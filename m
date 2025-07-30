Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD557C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 15:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh8bM-0005JY-FG; Wed, 30 Jul 2025 11:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uh7Py-0002HD-Ui
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uh7Pv-0005aY-83
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753884264;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=du3b3qc19im+V79WB77um6jE7StkWVlBq6WQBDzVBJI=;
 b=XDWzGEIH5cvotzcR1Q2BdUA1jDE/UmovKaJ3wweaEsDac35k9/fhY+OGlHbfmsE76xFSMk
 YYRXu/ZdfCYKl7YDE60d8Dznq6ZV/ekMZFgAZNz2mo+zQMggPcyZJB936Plp+sMgVuJ55Z
 uqIjKElpBOizf5ycHh9ktFAl5MsReio=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-uxqey9HhPI-O_6ZbTpJjlQ-1; Wed,
 30 Jul 2025 10:04:21 -0400
X-MC-Unique: uxqey9HhPI-O_6ZbTpJjlQ-1
X-Mimecast-MFC-AGG-ID: uxqey9HhPI-O_6ZbTpJjlQ_1753884260
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F274C180045B; Wed, 30 Jul 2025 14:04:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8242E1955F21; Wed, 30 Jul 2025 14:04:18 +0000 (UTC)
Date: Wed, 30 Jul 2025 15:04:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: startergo <startergo@protonmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH RFC v1 1/1] ui/sdl2: clipboard sharing implementation for
 SDL
Message-ID: <aIomXtsLkLhvi-B1@redhat.com>
References: <2cKNS7U_kE-Y4pOsCItcM1RhyWnkbpj0zicXQjMfV2AvXvx-Q5hg9lhWL9kZl3hAPpdbbuOilUAG1ahp7_YL2Gscf4iacyenhegHAvYlO_M=@protonmail.com>
 <CAJ+F1CL29s4Czp-dv2cMt=aEqngCEDNKNyBVsRcFfqfnXxo57Q@mail.gmail.com>
 <7evd1nX-kHgOCNpPH3vAJnNYZmzXG1b7wzs_aBHDQBVl1KOBk4SGM055Rcq7XN8TAaqGauW5hv0EFQrwQTISgLLl8Q1U6sfccK_lS7f4ftk=@protonmail.com>
 <CAJ+F1CLA3A7=Xag6764+0XhLSmgz=c4rztSM=k1PryK=QGVcbw@mail.gmail.com>
 <xd4WipyMvVQZAziPe9l9-q6i-sF0qVfag4JY5LGlkHZVTq7jT5BCDLIyT02psvU8fgya1Mj72k1za_MiJFjBTS335JiVREvS9ysZllzbPu0=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xd4WipyMvVQZAziPe9l9-q6i-sF0qVfag4JY5LGlkHZVTq7jT5BCDLIyT02psvU8fgya1Mj72k1za_MiJFjBTS335JiVREvS9ysZllzbPu0=@protonmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 30, 2025 at 12:23:32PM +0000, startergo wrote:
> From: startergo <startergo@protonmail.com>
> Date: Wed, 30 Jul 2025 12:13:25 +0000
> Subject: [PATCH] ui/sdl2: Add clipboard support with async handling
> 
> This patch adds clipboard support to the SDL2 UI backend with proper
> asynchronous clipboard request handling and QEMU clipboard subsystem
> integration.
> 
> Key features:
> - Runtime stability: QEMU starts and runs without crashes
> - Async handling: Proper async clipboard request tracking
> - Error handling: Comprehensive SDL error reporting
> - Memory management: Correct use of g_autofree and proper cleanup
> - QEMU integration: Full integration with QEMU's clipboard subsystem
> 
> The implementation includes:
> - New meson build option 'sdl_clipboard' (enabled by default)
> - Proper clipboard peer registration and notification handling
> - Async request handling to prevent blocking operations
> - Memory-safe string handling with proper null termination
> 
> Signed-off-by: startergo <startergo@protonmail.com>
> Co-authored-by: Kamay Xutax <admin@xutaxkamay.com>
> ---
> include/ui/sdl2.h | 8 ++
> meson.build | 3 +
> meson_options.txt | 2 +
> ui/meson.build | 3 +
> ui/sdl2-clipboard.c | 154 ++++++++++++++++++++++++++++++++++++++++++
> ui/sdl2.c | 9 +++
> 6 files changed, 179 insertions(+)
> create mode 100644 ui/sdl2-clipboard.c

> +static void sdl2_clipboard_clear_pending(void)
> +{
> + if (pending_request) {
> + if (pending_request->info) {
> + qemu_clipboard_info_unref(pending_request->info);
> + }
> + g_free(pending_request);
> + pending_request = NULL;
> + }
> +}

This mail came through as mixed text + html, and the text part has
completely mangled indentation....

There is no way we can accept the patch in this form, and there
isn't much point in reviewing it either as is.

If you can't get your mail client to send plain text mails without
mangling the patches, then the other option is to use 'git-publish'
as described here:

  https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting-your-patches


Also, when posting new versions of a patch, please always send them
as a standalone new emails. Don't send them as a reply to old messages,
as that is liable to result in them going unseen by reviewers.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


