Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990F5C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKlH-0003SD-Q2; Mon, 14 Jul 2025 11:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJQL-0005mA-2F
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJQI-00031K-IP
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vhvI6iEHiSuvP1SBzLnbUovE+ukDH+3w63y7QhiCTTY=;
 b=VsA2N8c4qRHB6ry65EyTf2JWoTOF0A4ZRhCAs2hEMkasJxwuJfgXfJcrO1Bz4Tf5UB20Js
 +FVp4HHmM5tNddwJe1qMBmmoIY+K7Is8PM/Fcw7ajN06/2o050j9jynHjeiEeid9Y54t6w
 Xdxz7UKz0HL7A0yPbLkpvZXmtnrY2Dg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-oNLZYJuMMCC9F_CvnGxung-1; Mon,
 14 Jul 2025 09:40:44 -0400
X-MC-Unique: oNLZYJuMMCC9F_CvnGxung-1
X-Mimecast-MFC-AGG-ID: oNLZYJuMMCC9F_CvnGxung_1752500441
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEFF319560B6; Mon, 14 Jul 2025 13:40:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF19B19560A3; Mon, 14 Jul 2025 13:40:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0F4B721E6A27; Mon, 14 Jul 2025 15:40:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Jiri Pirko <jiri@resnulli.us>,  Markus Armbruster
 <armbru@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Ani Sinha
 <anisinha@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Peter Xu
 <peterx@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  qemu-block@nongnu.org,  "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,  Laurent Vivier <laurent@vivier.eu>,  Jason
 Wang <jasowang@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 qemu-trivial@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Lukas Straub <lukasstraub2@web.de>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Michael
 Tokarev <mjt@tls.msk.ru>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Zhenwei Pi <pizhenwei@bytedance.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 0/4] qapi: add auto-generated return docs
In-Reply-To: <20250711051045.51110-1-jsnow@redhat.com> (John Snow's message of
 "Fri, 11 Jul 2025 01:10:41 -0400")
References: <20250711051045.51110-1-jsnow@redhat.com>
Date: Mon, 14 Jul 2025 15:40:33 +0200
Message-ID: <871pqirium.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Queued for 10.1.  Thanks!


