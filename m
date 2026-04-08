Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F67F10F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYaw-0001CP-3j; Wed, 08 Apr 2026 15:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wAY8v-0000Am-72
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wALed-0000JU-Eb
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 01:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775626841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GaYXssJET9HUuN8qmmpMmIRItyV5vk+8O1bNepNsjg=;
 b=gglKICR1Gnp74dto23+6jCq3uFe/MPsqG7qyZnLF7mJSP1DXCn+AVXA2NUyrPFa6pDyd1o
 qqgIVOjYKkeJRBVWKysRQ08uwOBlU1b1wSXEDKV9lR3jAP9MsSWgcqZ/Qe2Hm/YDZqEdXX
 +D8tdioldd2zdhIg3AgkP3hxM2ellPc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-U26elcI3Ms20ABWY4Gjafg-1; Wed, 08 Apr 2026 01:40:39 -0400
X-MC-Unique: U26elcI3Ms20ABWY4Gjafg-1
X-Mimecast-MFC-AGG-ID: U26elcI3Ms20ABWY4Gjafg_1775626839
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso13334997a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 22:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775626838; cv=none;
 d=google.com; s=arc-20240605;
 b=fDOHyNTAOeghXFDGJxpWMmn6WeaNjb+A4k/tTTbz20XUU9ZhoT9RLxUtua3pa7qhAF
 NvXu7DQXdJvunRKJxWys3DPr9RBdJsmp5sPBjDLjAA6bFH7eoR7fN6I8YFQB6riQ5mFL
 qCAGiBNnUGJodtJWSANq17gO4CRz/tdEqsKQCQf8lx4taHaq/8FFclN2bs7eU/6USQJG
 VvGfR7e3SEvuCFN9GpiWAMqn89ctxkj48UyytpZv+HhWHSXggimu72VmFMP3Mm1oZL1v
 XowWSES3BE8ePJXZ8p3td76TMI8YGDB26m6rl2nEwJYNhlHrS760HeMYOn7KlUJCJ7vx
 GArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1GaYXssJET9HUuN8qmmpMmIRItyV5vk+8O1bNepNsjg=;
 fh=J0lI+6V1e8A1yyN2nd5Guz99SJqLbGXMn75K4Y7Xiz8=;
 b=jCzdS4sZ2pkyxan8O/LgbRAzjiEQYCNjiewQbWmnkPUUqubqnaWLDDHJ7OQeh0FG44
 M4x4ioHAJcm1SAEmM7qLUoixLOTVhKERNn14eMDcVqWQSXlluDttIqBrmjadXBMgveUz
 tg47nGsrCv8PK5WRbaUIpBAJRNtPN4BjeBfMIFw2JGH7EPuRbOnZMvYtYsNL2smDJxSB
 ap+COWitw360ofTl/ohojCCZWsHpR4z9cmGAMwGWxJfcD+x0xxUpvRW/XyXZetlK5FQo
 PT1l+hjFuYWspfdWVXSPQFUCwmO5DKffYO1BsANCZ2npSDW16Bw+AG+5Cbr/OaSuH6sK
 6lUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775626838; x=1776231638; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GaYXssJET9HUuN8qmmpMmIRItyV5vk+8O1bNepNsjg=;
 b=A7DQUD21dfY8xDWoZsPvxAHAICbnSUPoXgem+QOqqm9aqBJNm0gIgcFLaMzn4/HjOF
 O8/1RU+AQR7vJTL+FOxWTWbLDKMo7LiJaSdhHG2/dpfCUuWEX6UG/hxNrXn1ZiicKY4i
 g5ULZyUtJbsLgiPMEvm1CyzK1ojT2CA9Z3wUULViKeyYSedkXe/NBLhH/POZjp3va6m8
 aO05OBWtRQtNTL49ZAUr0D3EFvB3Ko6pgUYDViRXXchnsLqPZRDPE51HKNC3/PzFa1hb
 d9whp0gRvs0mta5Y+M6dtxLUY9pHGpxkjJB7fcly7swk7BNNx/kRMdJh9/UNgHBchkee
 5HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775626838; x=1776231638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1GaYXssJET9HUuN8qmmpMmIRItyV5vk+8O1bNepNsjg=;
 b=GJXbHbJ7jg6ArtHrlbuKHSvxZp8pFbZGV5nSSQ4+QrhxtcEHBTJnBuiHx39vgpchgc
 5OOI4wZ2pk4+bv4/xNovq9DoMaC7acYrxBzes2Ql7grdcfmmBR+IBIYDEgbR9QrH2HMA
 mdx8IJcg5Tn+uERPqoEi4tVvqb54TcOxnjWkN10s5pkCT3/36GY+IkDG9v4N6PKXLz/2
 XWODJemllUF0TTNlT9QRopBEIrctvmnqLCrl+3J4VBf4ZuqNjlK8URQKsUv9NzpE/H6X
 4TowHUbmlFXQ9SnAnJlKSRnvqvpGGDk464su0cDDw3ONKc07fOaYXHiBYuflUuxG+Btx
 C6gA==
X-Gm-Message-State: AOJu0YzyvdtA6VvzkCWQxJvpr57YUYSlEZSG+B5W9237Us1+NEQ2LXg+
 oW5fqcwKvhQPHve0Y+Tq/F62bIi2ze1S8murqEGbDWWd/7ZNc2uIiLniIubuvEDJe3g1DphsR9a
 F+jSQsRUswIzCKm1yxhJXct/rxNtbZCz6Dah55G58Y0LnVzrn7Sfo7lSIRf8DBc9soR/xyNg0z0
 2o6UN2+vjz3qRzAxNR48SrHXGrYUiiFzxuTLjn+r5ruA==
X-Gm-Gg: AeBDieuQpzhwtBJLB8+rfhFefkTTW/W9eN1F+lAOReguziQQFAIoqJO4fs9YKbkF5Ct
 pErx9M6M0psw9+B0oLla7ltJ24Lo4ZUMMjIC3jK81e3JSZT3MU3JzC1fGTnYF+s12fb/E6T3Y29
 JA6sdUdS4IauSNtHpKPC6AUgVIjHx1+Jn+XjWM4XUySUOapgPTGPDGGtdcGNMJVyTdu3MjHxtB7
 0OdKbHJlpSoI+WfBEKkZFWq2sZ8Slrn4jL0Y+G1/hSl6m9EAbww5A33bLAE5AEsBbLbfua3UHIQ
 GFht7tZnbgW4E5bhgpIWWEM=
X-Received: by 2002:a17:90b:3d8a:b0:35b:e4f8:7b2b with SMTP id
 98e67ed59e1d1-35de68ebaf3mr21279419a91.18.1775626838275; 
 Tue, 07 Apr 2026 22:40:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3d8a:b0:35b:e4f8:7b2b with SMTP id
 98e67ed59e1d1-35de68ebaf3mr21279385a91.18.1775626837732; Tue, 07 Apr 2026
 22:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260408031725.641417-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20260408031725.641417-1-zhaoguohan@kylinos.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 8 Apr 2026 09:40:26 +0400
X-Gm-Features: AQROBzAFhhUboDZvXi8EzRHILwcHfSFw81EIKZwbwelGIdWr7xB8iEikNgPdoSk
Message-ID: <CAMxuvazU-_Uh2YSs7=7nBsLaRXq8ApuJ7rgBUyvmkRaGoAtX_Q@mail.gmail.com>
Subject: Re: [PATCH] ui/spice-app: detect runtime directory creation failures
To: zhaoguohan@kylinos.cn
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Apr 8, 2026 at 7:18=E2=80=AFAM <zhaoguohan@kylinos.cn> wrote:
>
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>
> spice_app_display_early_init() creates the per-VM runtime directory
> with g_mkdir_with_parents() before setting up the Spice socket. The
> code checks for "< -1", but g_mkdir_with_parents() returns -1 on
> failure, so the error path is never taken.
>
> This lets spice-app continue after a directory creation failure and
> defers the problem to later setup steps.
>
> Check for "< 0" instead so the failure is reported immediately and
> spice-app exits before using an invalid runtime directory.
>
> Fixes: d8aec9d9f129 ("display: add -display spice-app launching a Spice c=
lient")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/spice-app.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/spice-app.c b/ui/spice-app.c
> index 9e55f2737159..0df7325e6792 100644
> --- a/ui/spice-app.c
> +++ b/ui/spice-app.c
> @@ -151,7 +151,7 @@ static void spice_app_display_early_init(DisplayOptio=
ns *opts)
>      if (qemu_name) {
>          app_dir =3D g_build_filename(g_get_user_runtime_dir(),
>                                     "qemu", qemu_name, NULL);
> -        if (g_mkdir_with_parents(app_dir, S_IRWXU) < -1) {
> +        if (g_mkdir_with_parents(app_dir, S_IRWXU) < 0) {
>              error_report("Failed to create directory %s: %s",
>                           app_dir, strerror(errno));
>              exit(1);
> --
> 2.43.0
>


