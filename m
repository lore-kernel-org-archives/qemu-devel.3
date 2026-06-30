Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5996EC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weV0B-0007DB-1P; Tue, 30 Jun 2026 05:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weV05-0007Bf-RB
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 05:43:31 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weV04-0003iD-45
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 05:43:29 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-30b9e755555so145957eec.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 02:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782812606; cv=none;
 d=google.com; s=arc-20260327;
 b=oudrCTqTaL6TyMxBiJug1sBFiHVovPLWWjgbZoleOLnYfqqR90BD/lNG4kZyb+ZqLH
 DPaB56DA65CpezFGFSomHGFDQ4spZuFat0dQPz4M5nY5nTEVAPgYHync+3KfQDhNFOXE
 Z96uGJvMPquz2Ha30U3RUeSxnduu3uLVTfw/Q5bm8Bd+I2djewc9OscYvhxvvGnJLC5J
 QZNWk5ovNicOGhonDEVVDjwM2lasH6I2e2dq63njGivlnaEGfzQmBemce2vJnKxQClWf
 GQkTqYB7GwuuWEUOtE9j3EbZJKBcBZ/fqk1SxLDsOnKDyB1/hEss8EeUgnZ1XEn4e2Mr
 YuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FFDeTaWq9gb9YQZ3DE+5IyVJ3b1N4Ny9ykkllIKbndA=;
 fh=Rf+6LNIT7ae/oiXm7iYpRqM0ZV+oa7nPLPPWJ9l612k=;
 b=cVo4EW94EO7IKW1Eym2fP/Qdpl9sE4kCF1I4aRqIVp07a8XOr4twoOZ8UcITRjsrzu
 WvgFkhewyA9hJoCKpgPL7jGKZN/QhmrE7gwyYvOlPmXkicKK3MHLLDpVDAeiaUAfXex5
 mAfHlA6V4HbaaDs+r04Uv0UQd0HzkPhnxLpAewSrja3xQRTTRoRCV2azlVq8j+CYSfy3
 cDZle8OHGnW78YVXmAipeacKNjCPDmeM8iMe8Wtqz/8rZ1EaLO2xLeI5UCbnGT+ARP+N
 LUj7Ma6Czotjoz0R0+uKMbqLORcuMQj42Swm33fQpUVTO1lw4kzwizSE5VBrkU17we0H
 9ARQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782812606; x=1783417406; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFDeTaWq9gb9YQZ3DE+5IyVJ3b1N4Ny9ykkllIKbndA=;
 b=kolZwVgH8Vp33Hxqy35OCe0tnfrRIqgrqCtaFTzCzEr6HsrZENnonRDSSR6+ysG4pR
 wEdVZf2AzBvpP7Rkm1W4IErixefRFT3gfsVGg0JX2mYfMwPafRxUqmijoLOPdYDlHsh9
 Mzk4GTP3doL0Wtj2poQfpcExV997qQhlxBQgWMicWdFr0ZbEqTGQNKkqKsbNtSjE8Gt2
 uXMD9ATga0hVP8xHZpTZR1Ibq+75w1cm+8zy5GS7h1TtMdqLX1Z04TS4HvnKuBoRVQTd
 C7xiPM6aW3JXnTFC3KLeYYazn0/+cSRcBadHECXPmcZoEMS77I0xtePVSnV6UP+MTSon
 707A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782812606; x=1783417406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FFDeTaWq9gb9YQZ3DE+5IyVJ3b1N4Ny9ykkllIKbndA=;
 b=GhfMvIDDjyoJJ/f4yxbx0ZGrxKuDPOaW6X8cFKy5S/j5aHplaNnDgjqetX2LfQdlQe
 Lty4KekyfSwSRUlfznsvGMiDSPzdmJkBr0Ae5gqiNUTL6diRhd5phAKVWme5NkQC2lJM
 7dB+0N9XXZYN7lVFxLpxon9/ONappdl4z7IfD8DiE3he00Zf4rax3x0Omj4Y/T76r1Ay
 HPPTTgQrUdI3Th88ly0G3BUTCjaGNa5ODN11tR7Bt3k4ARfhrDOv1/v+gf5UvrLyfV6i
 CuS+VCt8qJwzgDq1DVqgLVPRHqLYtJ3eHFnHfTzaALl8RwYaaihrpIQm7q//PFW+1MPj
 ZYvg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpn7LiDHBNI+IXDoTyj+aWRgoLOl3afzyE8VhfFaQBuiPQfkqkk3uPLXgtXVDBAIv7IJKo/fnaNAZTB@nongnu.org
X-Gm-Message-State: AOJu0YzhEVXW0mGPMdkM2ypVbRBNteWZ2ztqsLL5RVH5okc17WvXlGrE
 OdErU5NKpCsoS5GIXw2nbbS04WTpa1zmmFmeo/lEyLhVAP9tw2uDhUSHkmoemuZU1q4OKHhqk4z
 2n7r9kG4QJrBbYa8DcxIeGzhW8u+eKz4=
X-Gm-Gg: AfdE7clGtpGXm+F8PUGSoq/GVswA0WWX1EXLcDkT9rhKTVQQeRuxlEPwS64GzGmZW4C
 PVL80EV1BQv8FTEgMBLojckohX+HoLKNKnCK2JWQhHDHTtpfC68sV9l0kkF7C05pk3hFU3lTfaj
 H3DcewA8K5hY0lS6XgUIafsg9hYYqHcuqu35hx1BFouO4/Qqd5qWGbPs9YsnBTlIvTK1Pw89W3r
 /ag8JJlOxZgRFLHmgT14CnpYC4iVfrOYctE3QP9zRm67lZ/17KZ3vztSEgzrNffUiirNt6A83CL
 phWfpBuumdUbWz0K3NaF5kQXFtwj
X-Received: by 2002:a05:7300:430f:b0:30c:9f31:b631 with SMTP id
 5a478bee46e88-30ee13a1086mr2309432eec.33.1782812606231; Tue, 30 Jun 2026
 02:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260630093302.688700-1-frolov@swemel.ru>
In-Reply-To: <20260630093302.688700-1-frolov@swemel.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 13:43:13 +0400
X-Gm-Features: AVVi8CclDxxyWWrgA6bDAIzL7TOpEnEIL2_KjB-Zl2MNH1KMEicOteusmWkiADg
Message-ID: <CAJ+F1C+cS7c=Mc2GAn-WQ-XmCPU-hQM4JuDFsEkS87q0yTdrNg@mail.gmail.com>
Subject: Re: [PATCH] utils/module: fix memleak in module_load()
To: Dmitry Frolov <frolov@swemel.ru>
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1334.google.com
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

Hi

On Tue, Jun 30, 2026 at 1:35=E2=80=AFPM Dmitry Frolov <frolov@swemel.ru> wr=
ote:
>
> Memmory for version_dir, allocated by g_strdup, is not freed
>

memory

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  util/module.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/module.c b/util/module.c
> index 09dc43f51e..dbca6bc8be 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -243,6 +243,7 @@ int module_load(const char *prefix, const char *name,=
 Error **errp)
>                               G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS "+-=
.~",
>                               '_');
>      dirs[n_dirs++] =3D g_strdup_printf("/var/run/qemu/%s", version_dir);
> +    g_free(version_dir);

Or declare the variable with g_autofree?

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>  #endif
>      assert(n_dirs <=3D ARRAY_SIZE(dirs));
>
> --
> 2.34.1
>
>

