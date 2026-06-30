Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A367CC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWPA-0000ED-EQ; Tue, 30 Jun 2026 07:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weWP8-0000Cg-EC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:13:26 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weWP6-0001ts-Sn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:13:26 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-30edbb0dc5fso2425036eec.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 04:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782818003; cv=none;
 d=google.com; s=arc-20260327;
 b=r1M9lp+3seu/K74mah/HQvMixRkmx+YwdOhIX9ZFSGtpAP4jXzQleDG9/xK6kPL1Mm
 CIjlK2vmHtvKXLZNe3CS9EDAUw5pi++HyQ2qzR25voNru7ykOVT500V0xpczzMPeC9MY
 ho5WqGpgdCo92nnXK65gl+lPSdsbR83jBdKsO1rtgUI9iyU33Z1eQMBfSECr+ul2UWZx
 vSNiOZ4IffXA71Flaqz+4s8BtT0yqH7+fa4F8qWOfW0Y3qwaUNthyae1pftIIzBhwwb5
 TugHSIANa34U9GdrsRKv7tqnRV0aArhX2j8q0FpXOoH/arBhj6y7bfwzObH4O1i1lL9R
 NwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WRI3qR7U8QFgsfiRa3Q0fJwXioyWf8zhdfv59Awc77Y=;
 fh=ImuS54uIFw4m2bdJc93F/N3uPOr4vAyXV8spnViD7yQ=;
 b=YYku6OkODClffn48C/9XWCkjizRcQwK3lH+uyTgHd51ZJj/ctVcFW4Vw3HPIt5OkUO
 KvuxsDk4epXiu2KU/d/PjiQAJruQ8EWayARfkGbxm74cj2VHRgWhBWJDMypy5Own5haI
 mbjyXCq2tyqJ9DkF5zLdkexytgIRopSpLbOeLHlQi8WOk7rXbNX3SpoNR1CDOdZdc5GG
 /k3hoGbDgyJ6S1qR81JIQIUMnSsAw9tL7Yz/BEelAgjSTDxVgDbQM743FpkTCQic6/+q
 Pb0GvKfWI8OPllLSekfA+y9MIp79FQ35x6/AMTdvjwiSPvy5bEkDt78gYqxLyM5ogVmr
 DEzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782818003; x=1783422803; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRI3qR7U8QFgsfiRa3Q0fJwXioyWf8zhdfv59Awc77Y=;
 b=G0lu9/+jUdpgsiQi/ItqEGxkgP8+4gcTOc/d52Uqq+o9QpCes6mQCQhMdiCsBZF3lT
 Ahu8L/IvSuTEWzoIsEV5byU18NH7JTluPeOoD2U4PPHFJNR9dVxsLBbEU/aJHDoc288S
 4Ed63keluz/jegpvy6+o8jjgMh6xfu+t/9T5Q7nqacbdyIxnxKcem+qaur8HZ5iqHVum
 KDtARZTMxKqVJSHWjK8Y9t7z55iat2uo0ZNAjJdn0o7R2ls29HceVpoKFFECMeFVIAnC
 h+Xtg/nHZOPZrRqDCVhHd88SPkpRqaAtZmzzBy0e64T7ayCPVTTTaG88Ayw0NS5EAc11
 AQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782818003; x=1783422803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WRI3qR7U8QFgsfiRa3Q0fJwXioyWf8zhdfv59Awc77Y=;
 b=FmxdCkC9ZFpDfzwpfZhYAscahyETco5oc05xp0n7U2bX+T7QNGChv4tPdJc3jBAlTB
 xv74nhD9ResvVQPJHRjLg30nirM09NYavd+g2GgHkyhPEW3zKbU4pXJgTCmRPUpk0tcx
 ZTbHw380AXpFxcZls3CyBJjsbXPdNs0DL4TPNe5asBpLGobEtiLVvMrI+TeslY3Eeplc
 Rng7kn32UK0mA2BQM4R80z85SIYYdvWzQ959CUZ4UAXLsiz5AIR6aswapm1Gv3DQcYl/
 aPUKxyyyydIWxCIaCJMA9EidE77f/xZEtfHEj6c+InCkMcu+Fpiz9suCLYE80/GaYVkO
 VybQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RppWkl5R0fgL1XiCPrPiXTw/NrIrB7QyoMG3//SoHEaXJ+yjjFuwL8H+Liig7F9E4grpEz8pjDt9NVt@nongnu.org
X-Gm-Message-State: AOJu0YxvnHWVOEo+oea1VbKygg7VfMw20lGavV38ynSBc0BmrCy4jLH5
 EkitTZA0EVoeEPZzivmpn73cG/xIqaV4JGRNNKz0+Op7mhATMWPbLWYjc+UxCwcZtmsst4ybRAb
 IoaCRMGePvw1GDQwSj79peyO9vItih3k=
X-Gm-Gg: AfdE7cmufA1ODd9WjIn0SqXRCgmyQp223kgHV0PK+86ZOgg3/mW1cegICZGKC9WN0t2
 GOaWreLMb9ypJIWNtLB6LGcJ7MnKqA+faUa6I53vJ7XIGpJN07VpC33Y8zTeUVnR6pAdUrIA5b4
 gdXEk3xx5t6qPszgvgpxhFqyxgjIvXjAlG3XUTb7P0NW8JsO74eC0O4LYZsnbXdexX3nLVyXUL6
 HlswcpIQtLv6zIfIlGJa6UFzPYKq277oVdGdKvi0WZ0G1yEApNY3wZ0HZ+JdV7Jwe5vRZ071dFS
 +yVtvOCqBhFSDo+4E1p8Y5FyP78sKFOB8h7I1Fw=
X-Received: by 2002:a05:7301:578a:b0:30b:ed93:5cda with SMTP id
 5a478bee46e88-30ee12c5ccbmr2115638eec.9.1782818003094; Tue, 30 Jun 2026
 04:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1C+cS7c=Mc2GAn-WQ-XmCPU-hQM4JuDFsEkS87q0yTdrNg@mail.gmail.com>
 <20260630110601.736019-1-frolov@swemel.ru>
In-Reply-To: <20260630110601.736019-1-frolov@swemel.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 15:13:10 +0400
X-Gm-Features: AVVi8CdDtcNkwBKejsRP95wBxMg4i2FjBvbCRbZhgJayD4rOPhX58lnBBXOu9VI
Message-ID: <CAJ+F1CKNMjregp+gS1+whvj6tt2-HY7UkN1UoRvsk+CRV670fw@mail.gmail.com>
Subject: Re: [PATCH v2] utils/module: fix memleak in module_load()
To: Dmitry Frolov <frolov@swemel.ru>
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Jun 30, 2026 at 3:07=E2=80=AFPM Dmitry Frolov <frolov@swemel.ru> wr=
ote:
>
> Memory for version_dir, allocated by g_strdup, is not freed
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> v1: fix with g_free()
> v2: fix with g_autofree
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>

either way
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  util/module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/module.c b/util/module.c
> index 09dc43f51e..8f8e6994f1 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -203,7 +203,7 @@ int module_load(const char *prefix, const char *name,=
 Error **errp)
>  {
>      int rv =3D -1;
>  #ifdef CONFIG_MODULE_UPGRADES
> -    char *version_dir;
> +    g_autofree char *version_dir =3D NULL;
>  #endif
>      const char *search_dir;
>      char *dirs[5];
> --
> 2.34.1
>
>

