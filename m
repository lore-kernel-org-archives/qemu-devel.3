Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BD3C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 06:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukcwm-0003RY-Ke; Sat, 09 Aug 2025 02:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukcwg-0003K6-7A
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 02:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukcwe-0005Ou-Kf
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 02:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754720443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S+wqlEX+dbhZlu+2Q2U1ufU4MoJGnbtQuMwJYP7rN6I=;
 b=M9Vs1HaaAWLG8bBoIaKrnIyO/+OnXjnVkp5wSmUcz+Ylqs03S8umQ0/rbVvYUXwn7vh0Ta
 pjGmNSCs6M2F5T89Nf5+HwqhiscvsteBB9/af/fe9MoLoKQlVhl4Fi/qVgPm+oGKaGPW+b
 cLzXgJFvlbOAGPfuHfrcX1HC/JooxXI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-FAWXzMsyPayYDPRAyPb26w-1; Sat,
 09 Aug 2025 02:20:40 -0400
X-MC-Unique: FAWXzMsyPayYDPRAyPb26w-1
X-Mimecast-MFC-AGG-ID: FAWXzMsyPayYDPRAyPb26w_1754720438
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F20E19560AF; Sat,  9 Aug 2025 06:20:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47441195419C; Sat,  9 Aug 2025 06:20:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A1F2D21E6A27; Sat, 09 Aug 2025 08:20:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Weil via <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Samuel Thibault
 <samuel.thibault@ens-lyon.org>,  Michael Tokarev <mjt@tls.msk.ru>,  rent
 Vivier <laurent@vivier.eu>,  Stefan Weil <sw@weilnetz.de>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH trivial] chardev/baum: Fix compiler warning for Windows
 builds
In-Reply-To: <20250809061302.596931-1-sw@weilnetz.de> (Stefan Weil via's
 message of "Sat, 9 Aug 2025 08:13:02 +0200")
References: <20250809061302.596931-1-sw@weilnetz.de>
Date: Sat, 09 Aug 2025 08:20:32 +0200
Message-ID: <87y0rtnhhr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Stefan Weil via <qemu-devel@nongnu.org> writes:

> Compiler warning:
>
> ../chardev/baum.c:657:25: warning: comparison between pointer and integer
>
> Use brlapi_fileDescriptor instead of int for brlapi_fd and
> BRLAPI_INVALID_FILE_DESCRIPTOR instead of -1.
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>
> This is a rather old patch which I now use since more than two years
> to support Braille with QEMU on Windows.
>
> It's a hack (because Windows uses a pointer (64 bit) which is
> assigned to an int (32 bit), but it seems to work.

Would a code comment pointing out the hack be useful?

> Regards,
> Stefan
>
>
>  chardev/baum.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/baum.c b/chardev/baum.c
> index f3e8cd27f0..5c3587dda5 100644
> --- a/chardev/baum.c
> +++ b/chardev/baum.c
> @@ -94,7 +94,7 @@ struct BaumChardev {
>      Chardev parent;
>  
>      brlapi_handle_t *brlapi;
> -    int brlapi_fd;
> +    brlapi_fileDescriptor brlapi_fd;
>      unsigned int x, y;
>      bool deferred_init;
>  
> @@ -654,7 +654,7 @@ static void baum_chr_open(Chardev *chr,
>      baum->brlapi = handle;
>  
>      baum->brlapi_fd = brlapi__openConnection(handle, NULL, NULL);
> -    if (baum->brlapi_fd == -1) {
> +    if (baum->brlapi_fd == BRLAPI_INVALID_FILE_DESCRIPTOR) {
>          error_setg(errp, "brlapi__openConnection: %s",
>                     brlapi_strerror(brlapi_error_location()));
>          g_free(handle);


