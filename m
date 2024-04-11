Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D07CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 11:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rusnU-0003tl-Nv; Thu, 11 Apr 2024 07:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rusnD-0003rw-0z
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:40:35 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rusnB-0007h1-3o
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:40:34 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e2b41187aso1307570a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712835631; x=1713440431; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHIF+i0Ss53JiQ/A2LOt4RnE65a5xhTGwSUyEeHDJVw=;
 b=LX4FUlvE4dnHpXvZETTPLoGACp0g3xv1FKrrjZpVSWUfOUkvXHbPz/TtGDIIgTs0RU
 dk1R+YusScXGeVJQfs3chhhOQN4F/Y2TjQFf8k/ikrdHPkhE8GxVToEA8UY6Pc1xSw8r
 lMBbLVTJNmALGnR/Lt9VP6Ff4yFeuhyN7nEh0HNI0CVkZPR9iI29Hv6AUq/Do+m2Kr9A
 ds9Ut+zLEjW/BUYFtbDnvUZW8wkb800XWoE/izBz9bN+IycL1PSuSuM++l3HS/Q/5GLu
 5DAUBc8eo3VQ/m0pTt0GHtVGH9tPmT98c6jDDHQqPRc6CyvYn+0D60B6mMX7FtXHopit
 hx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712835631; x=1713440431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHIF+i0Ss53JiQ/A2LOt4RnE65a5xhTGwSUyEeHDJVw=;
 b=vhq+F7II4DNEPsKvPN5XErUtDEPaS4cVQsfw6TTswcRpEUbxftDyx7BPFspO8pSvdu
 kIjV95mLQRRKhhta/7Wk30ccE7lx/Mf5aX9uBKbcs41NsrmCQ1w6QVes3p6dog2NQKXA
 58hd50ivRapDhpojqUDXqTuD1ozqUSt20SO/vwqfonE25kUz6fTC0j7K6A5lI6+XhCpz
 MiKrzVCCGS8yAoxQVfvqeBTOoMmpl+pVKO+TFCU6YmCWBg7TW4Mj52JHi+FiuYy200mx
 FM6L87dfb2PjlTXkIdSefWTjK/7COnkwnnIBDqi4UD9BoMqSM91uhGBnAgSddJjbB7GQ
 2tOw==
X-Gm-Message-State: AOJu0Yy85K/qIS0GDTWZofoY3tDMUvgo9sX9+R4DeD6kGMhnqfdZAQdf
 6G2VXu3+Vt6bremCe9i0y1GCtlJXZkG1RzEYdsjcWmyzZ3S3IYnmPoait6K2D0HfbTCN/zcf6NV
 VpR8bmEbQQB5wW+kwsvEbwwwDAaUY905mlZ13cQ==
X-Google-Smtp-Source: AGHT+IEfWyD8uMgsXWURZ+Ox3U60AF9v0S5kuitkDL0ZI3bcAnjhshs8QcyRUl/qjCYAA7/cNpeaaNi6MV81LaDSLPw=
X-Received: by 2002:a05:6402:f12:b0:56e:566e:730c with SMTP id
 i18-20020a0564020f1200b0056e566e730cmr2244064eda.12.1712835631180; Thu, 11
 Apr 2024 04:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-5-philmd@linaro.org>
In-Reply-To: <20240411104340.6617-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2024 12:40:20 +0100
Message-ID: <CAFEAcA-S-go8U0hJPNSRhXQ3hSQ0BN4WVcTBPie4MRnjzGh0VQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] linux-user/flatload: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 11 Apr 2024 at 11:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  linux-user/flatload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/flatload.c b/linux-user/flatload.c
> index 5b62aa0a2b..b0f04af4b6 100644
> --- a/linux-user/flatload.c
> +++ b/linux-user/flatload.c
> @@ -692,7 +692,7 @@ static int load_flat_shared_library(int id, struct li=
b_info *libs)
>         char buf[16];
>
>         /* Create the file name */
> -       sprintf(buf, "/lib/lib%d.so", id);
> +    snprintf(buf, sizeofbuf), "/lib/lib%d.so", id);

Indentation has gone wrong, and another missing '('.

Looking at that, I notice that this function is actually
dead code -- it's in code that is only compiled and called
if CONFIG_BINFMT_SHARED_FLAT is defined, and if you try to
define that you will hit the "#error needs checking" in the
calc_reloc() function. It seems to have been like this since
the flatload support was added in 2006.

So I think we should remove the dead code -- I'll send a patch.

thanks
-- PMM

