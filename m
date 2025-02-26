Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED1EC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDTq-0003da-45; Wed, 26 Feb 2025 04:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tnDTn-0003dJ-PP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:13:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tnDTk-0001nF-RZ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740561198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4MkbkipicWd+mhUgPmkvxULCVWBGcvK1zbqjmohoEUw=;
 b=YLwjH0lmXeQqD6P8RkY+6uctmxboYGM4AS2tE2XOP6ibvP/xsu9IdD8mPW9PxGD8gGgGfo
 eCkpuMdCMrgHu66lbz2VazRzgasfYSggxY/Til+dwk2Q0GZiI/lCu8sdj/tZPV51PAXJci
 aIHa+BwVm4RMxR6grQXeTcEtUQ4hw5o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-bIKVG3jhOAWwrtvDH63kaw-1; Wed,
 26 Feb 2025 04:12:07 -0500
X-MC-Unique: bIKVG3jhOAWwrtvDH63kaw-1
X-Mimecast-MFC-AGG-ID: bIKVG3jhOAWwrtvDH63kaw_1740561125
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D009180087A; Wed, 26 Feb 2025 09:12:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.219])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C1F91800359; Wed, 26 Feb 2025 09:12:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1CD551800091; Wed, 26 Feb 2025 10:12:02 +0100 (CET)
Date: Wed, 26 Feb 2025 10:12:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org, 
 Ard Biesheuvel <ardb@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, graf@amazon.com, 
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 14/24] hw/uefi: add var-service-json.c + qapi for NV
 vars.
Message-ID: <pji24p6oag7cn2rovus7rquo7q2c6tokuquobfro2sqorky7vu@tk7cxud6jw7f>
References: <20250225163031.1409078-1-kraxel@redhat.com>
 <20250225163031.1409078-15-kraxel@redhat.com>
 <87zfi95khl.fsf@pond.sub.org>
 <wyrnw2ur2xp7e6yr7f7hdbn3zbvolnvjojjrlaoax7hb2psxzo@xw7arzdtroer>
 <87bjup3y76.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjup3y76.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> >> > +# @digest: variable certificate digest.  Used to verify the signature
> >> > +#     of updates for authenticated variables.
> >> 
> >> How to create and verify these digests will be obvious enough to users
> >> of this interface?
> >
> > Well, no.  It's a somewhat complicated story ...

> I wonder how much of this, if anything, should be worked into the doc
> comment.  You decide :)

A bit verbose for something rarely used.  Tried to summarize it,
incremental update below:

take care,
  Gerd

------------------------- cut here -----------------------
commit 3d2ef31cbd70f4637330fe8d8418befd907899c4
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Wed Feb 26 09:07:10 2025 +0100

    [fixup] qapi docs

diff --git a/qapi/uefi.json b/qapi/uefi.json
index c1dfa76b6eb2..bdfcabe1df4d 100644
--- a/qapi/uefi.json
+++ b/qapi/uefi.json
@@ -6,7 +6,11 @@
 # = UEFI Variable Store
 #
 # The qemu efi variable store implementation (hw/uefi/) uses this to
-# store non-volatile variables on disk.
+# store non-volatile variables in json format on disk.
+#
+# This is an existing format already supported by (at least) two other
+# projects, specifically https://gitlab.com/kraxel/virt-firmware and
+# https://github.com/awslabs/python-uefivars.
 ##
 
 ##
@@ -29,7 +33,12 @@
 #     is set.
 #
 # @digest: variable certificate digest.  Used to verify the signature
-#     of updates for authenticated variables.
+#     of updates for authenticated variables.  UEFI has two kinds of
+#     authenticated variables.  The secure boot variables ('PK',
+#     'KEK', 'db' and 'dbx') have hard coded signature checking rules.
+#     For other authenticated variables the firmware stores a digest
+#     of the signing certificate at variable creation time, and any
+#     updates must be signed with the same certificate.
 #
 # Since: 10.0
 ##
@@ -44,7 +53,7 @@
 ##
 # @UefiVarStore:
 #
-# @version: currently allways 2
+# @version: currently always 2
 #
 # @variables: list of UEFI variables
 #


