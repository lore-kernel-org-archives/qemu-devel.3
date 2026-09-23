Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7F9C982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 06:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Gno-0006IB-4j; Wed, 23 Sep 2026 02:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x9Gnk-0006H4-05
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 02:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x9Gnh-0003sC-4G
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 02:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790146192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RukGA7/eptk4hlE3nq6/h6PGdx/f4D5FvVzgE4r979o=;
 b=GXNdeB075AHVHeuO5VKeVtc2WTjltJ6xvUHDMysBBcOpdV4qLd0bUe0CjzpUMzC+i7gU9l
 cvmvtEupeljtdGu88AY0QDMydKooFnL+LIHnX/onI3IIp4aklrFPYBcwEP+egAPwD3eJRQ
 IzYGpq90LwD5lxrGcmWDGvOQlEC6qYE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-tio-qnPVP5-mZzEniYw2OQ-1; Wed,
 23 Sep 2026 02:49:47 -0400
X-MC-Unique: tio-qnPVP5-mZzEniYw2OQ-1
X-Mimecast-MFC-AGG-ID: tio-qnPVP5-mZzEniYw2OQ_1790146186
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E196F1979203; Wed, 23 Sep 2026 06:49:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 857881800370; Wed, 23 Sep 2026 06:49:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C99221E6A04; Wed, 23 Sep 2026 08:49:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <laurent@vivier.eu>,  Kostiantyn
 Kostiuk <kkostiuk@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,  Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
 qemu-trivial@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2 0/8] qapi: convert intros for qga, firmware, etc
In-Reply-To: <8733v0zcsm.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 23 Sep 2026 08:45:13 +0200")
References: <20260922205605.501602-1-jsnow@redhat.com>
 <8733v0zcsm.fsf@pond.sub.org>
Date: Wed, 23 Sep 2026 08:49:42 +0200
Message-ID: <87jyocxy0p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

With the update to tests/qapi-schema/doc-good.txt squashed into PATCH 2,
of course.  I'll also make the commit message tweak for PATCH 5 if you
like it.


