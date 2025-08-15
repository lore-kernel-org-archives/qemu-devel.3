Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFADCA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 16:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umwyo-0005G5-9C; Fri, 15 Aug 2025 12:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umwym-0005FO-8G
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 12:08:32 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umwyk-0002Ti-50
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 12:08:32 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e931c84f0c1so2320244276.0
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755274108; x=1755878908; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eY/Xd9SoGmOBtP6Y4PhgcXLlQ3bEJqzFHMhcJISIziA=;
 b=zAwbZWtu80s/46I8qUXqTl6OQkjLa+kcThVo3wilwhuCMGlNDt7owHaOuUOYffmqmv
 iU5KZclbXLhYF0aNQCMhSjJxWAG/eKsZ8k2KP/CLOLr6Io9Zk5TpJFiHq4uLucjYjc+N
 H3v2NVn+OiiVL6ZjZ7pRaR1ufQJ3OiDxqCTKFxA6OOruZuZaoGi6lz9vrjFZ74+ehBqj
 ZsYtB3V5QAfaYKCoek3ovoLUtPgTx9GTKNSj54Q4eojIzc22Xv+2tQYuDkXhcgXsvU5p
 LRnN7O4I6RXeyrPXpO6uwUiy1qin8DzfzK6yB42E4q7++FLTawAhLpEX0sms8g42mpDk
 zJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755274108; x=1755878908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eY/Xd9SoGmOBtP6Y4PhgcXLlQ3bEJqzFHMhcJISIziA=;
 b=mephlru4rqDQ4/MklIyxt6dts7JCcKwplUPNfOtZfsWCISO4uE+S0kTl7pd6YBx9C4
 v7ylyhn7KyousyP+Km+k+c0U122s2RGnddRXVDlT+wdxTL+7sVdP1a1Dz4giaaYkDcS6
 cgIB13//ldt+8+Ws6vag3XQuOmjjQ6BRc+zAHtpgFPd4SUfbdJfhcW/3MxKdtlnfxr39
 ehoXd9LsHgb2me4kHo6ZD8SmWtM0vKwo6LhgLHtpWdHruYYk60DHJ3ZpoWX/EBrOwvvA
 aDdXIznrn68aM/yoAozyqPEY8i2mf1uXNCOzZWUpvTYBEkzubmJw1gsDMO/jzx31jHdS
 mSMg==
X-Gm-Message-State: AOJu0YyTpgC1wRIC0Uxt23ELRrkcrbFc9I7kacGdjh4rjMldfuTEH4GI
 pKRz2HEhCghirW+jOVKhVHO0jyifjxFCfgZ4If/Py0AP0ldNjS6cxoaudDTBc9eWCZRHuuovNgc
 EcDyA6Uo1gJkARVr2l6Uu2MbpNtyTgvSF86a4NU6h3Q==
X-Gm-Gg: ASbGncuPaawJYSb9kf33HQXp1zJdRpJIlEYF5e4I0NEmANgUzocq0U9Q9dPXGCE+nOW
 55XAdLS9Tl5O54/bjKFcsKvyn4ILFcGexJfuua6qCJsBeFfbhpYOfwRXiVV1NE+3t0ZIVXmjGwT
 +1QgRjaQyv6HI3gtmnHqleTVPCtNoJCwlecBNyfoG2CH25NMi37YNPaMsqzCbWwIyisrmyL1yYG
 Ov3IuxO
X-Google-Smtp-Source: AGHT+IHfWpKPqRSRXqpJGPyX+nNHM0+P8djUk1isJBydpoiMLJjjiuwVc0DkjZMo08V6MOMxY50XWvlOw2sn7DV5mK0=
X-Received: by 2002:a05:6902:f86:b0:e8f:d7fc:dc with SMTP id
 3f1490d57ef6-e933237378emr3507765276.6.1755274108495; Fri, 15 Aug 2025
 09:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250727074202.83141-1-richard.henderson@linaro.org>
 <20250727074202.83141-3-richard.henderson@linaro.org>
In-Reply-To: <20250727074202.83141-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 17:08:16 +0100
X-Gm-Features: Ac12FXxz3d56QEg4n0O5yvltQsoDgMvagSO7AHlsiDYGBd_6oGsShLmgMcLx5DE
Message-ID: <CAFEAcA_ZQ13qMRUQsieJiEPV=ULrDbz8=EJaW4_kw=yEysob0w@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] tests/functional/test_aarch64_rme: update image
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 27 Jul 2025 at 08:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>
> TF-A needs to be patched to enable support for FEAT_TCR2 and
> FEAT_SCTLR2. This new image contains updated firmware.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250719035838.2284029-3-pierrick.bouvier@linaro.org>

I see this test failing in local runs of 'make check-functional'
sometimes, complaining that it can't create the scratch/out/EFI
directory because it already exists:

stderr:
Traceback (most recent call last):
  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_aarch64_rme_sbsaref.py",
line 49, in test_aarch64_rme_sbsaref
    os.mkdir(efi)
FileExistsError: [Errno 17] File exists:
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/functional/aarch64/test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_rme_sbsaref/scratch/out/EFI'

More information on
test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_rme_sbsaref
could be found here:
 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/functional/aarch64/test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_rme_sbsaref/base.log
 /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/functional/aarch64/test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_rme_sbsaref/console.log

(test program exited with status code 1)


Is this something where we need to blow away any old output
directory for robustness ?

thanks
-- PMM

