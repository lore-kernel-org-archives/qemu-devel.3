Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EA8C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1MJH-00062S-Tl; Tue, 01 Sep 2026 07:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1MJG-00061q-I2
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1MJE-0002Sx-CE
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 07:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788260743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wET2hheVOXu2dloDjPLhB0/+IUvdyjY2j1T9fRYhgpI=;
 b=g7l0Wzu8cX62Yf+2WnpgcGBB7sxJSKKIdqB6fS8vIQO7almGn8CwvGEsPRlNb6oYnXnDaV
 9m6dR0A3c9aWl1PrUz3VfitjP+u3U8NHFC6YvSkA7KH5oNj/1L6bJt3XR8/lp2l+a2NE96
 CnlxJpnh7oO62G2VxGyFIcpZ1rzK3Rw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-xOWqWDWeMjqMYUd6-o2HBw-1; Tue,
 01 Sept 2026 07:05:39 -0400
X-MC-Unique: xOWqWDWeMjqMYUd6-o2HBw-1
X-Mimecast-MFC-AGG-ID: xOWqWDWeMjqMYUd6-o2HBw_1788260736
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D8C41845537; Tue,  1 Sep 2026 11:05:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE47A1800257; Tue,  1 Sep 2026 11:05:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A38021E682B; Tue, 01 Sep 2026 13:05:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  zhenwei pi <zhenwei.pi@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Jiri Pirko
 <jiri@resnulli.us>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 qemu-block@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>,  linux-cxl@vger.kernel.org,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Alex Williamson <alex@shazbot.org>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,  linux-edac@vger.kernel.org,  Michael
 Tokarev <mjt@tls.msk.ru>,  Fabiano Rosas <farosas@suse.de>,  Zhao Liu
 <zhao1.liu@intel.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Eric
 Blake <eblake@redhat.com>,  Peter Xu <peterx@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>,  qemu-trivial@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v4 00/43] qapi: convert (very) trivial intro sections
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com> (John Snow's message
 of "Mon, 31 Aug 2026 16:19:02 -0400")
References: <20260831201945.287730-1-jsnow@redhat.com>
Date: Tue, 01 Sep 2026 13:05:29 +0200
Message-ID: <871pbd9qpy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>


