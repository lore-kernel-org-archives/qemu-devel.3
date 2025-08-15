Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E56CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 16:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umxJZ-0000bk-08; Fri, 15 Aug 2025 12:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1umxJX-0000av-7Z
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 12:29:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1umxJV-00082U-JO
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 12:29:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b9dc5cd4cbso1621629f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 09:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755275395; x=1755880195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUgZ+KVuNdEYqt+yAn3+wWUDhlf1k1kEZldqgXlJQhE=;
 b=xsrNxJXPWr8tBeJ0K/GyVNj3bpurfA1PKPkMsIJcEP5PHjEo4SGOeUeqd49ktntLIT
 FQimC4DtuQjg6EKoj/OkpZX+bRmwZC6dPsec3oY0M7WNaa/xlmAeZ2iQ6C5pw719h9zt
 F/DYYfh6xXOBg50LP2rOMuztjv7aI9MPJa2CJ5FnqsInzoYKQq0ioW8jjDUFH8XLtkDs
 drO0DkIKdmNiwVn+2fF6lM2QmZFKbwD7o4aGwmciLEbwkgOvy+2HEoCgfHgBcoqEVe64
 MVwhWUBzfj94KNz7Qz7jVBT3DbFC3vQtKhWmmCuXM05R5NGckKXbYzJVTTKoBlFdlIJI
 VJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755275395; x=1755880195;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aUgZ+KVuNdEYqt+yAn3+wWUDhlf1k1kEZldqgXlJQhE=;
 b=suuZdtww/TtdA7BLKFZfTdLfOgx4dhE1qpyrjhJmHtA6nEWFjl8XSyShjfZu3ZxbUM
 j+mDxHyn9WR3sLnDtgsaF3tO630g3kGBszN4dypYwqQ9seSRY2h/DvrJTrH3fRDopi3c
 ROQFRNj5bMhJKFJ5zhgPTjseWUkty8+iIs5L8k0WyOp1wRHPGMwLkJBE2Uno+cH++mSl
 J6EwfmsAOfoNlfl3Ii5ksTUEtIKt+jrKSiiTaV2ZZa8lnk72Yqpmq0CMFj7VIhzvLCIg
 uRqXPEiQY4xPycjNUku9AP2nU/QhmJ3Uqnhu6FuKBc5DMIF9FgcVcoxetpFNBpquypJx
 wD2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJMaCLGtK3ITPcJiAnGpr8nL5YzNQodSS9YKFvbQfsybnaO0vNps/MssLhmplplQ5xSSyYxZ+U7m/e@nongnu.org
X-Gm-Message-State: AOJu0YwaMZa4XIMkNhwiF0en1D3B8PPV+lVCfj5yyAWXDv2omSGXe9no
 KtgJiBUMJgExBLKj5HLRFtjZUEBjClMLlQYdvYruntCq8rEKKoROfAHlQWieSSElowQ=
X-Gm-Gg: ASbGncv8UuFvpTYRndNsMwMdBw7dPZxXgMtcCovpetjBKMxaaHdhmeiSs80lga7ja9c
 kRrlBZVVbvKL6xge7MI4muuCnGrEbl7p4V/jjca3a4NJrmXeTlaEhtp70LuIZMXaFEaWzQv5UQv
 Wj0edCqixRAhT9uLKLlDU3rqHTtUp7Xcw6WplLGq45U/6B93rjPos89QEExgKPnwOAJ5GxyDbU7
 +RBTv108QqBDg7Ki+bmcc+IKIHFhPk/lyqWmrAv/mmLcIQ1m1yV36bo+/RFM2Q5nA++K7g3RUz1
 qxeVgqX8OMTwcaRtxWgkujOCDZqz7+kb3gH4x7Hs7S6rdB252n25AlivAfpYLjRMJ3LKGgcnka2
 +aIyxe4LiQEcu8/FOAfuFqC4=
X-Google-Smtp-Source: AGHT+IFAPKe6AQobJBZXbYdwy17crM6EayxdzUF1PXqkuLLrb9Q5eqs2zR8Gx9g8juDGcuYfX1z6Xw==
X-Received: by 2002:a05:6000:24c4:b0:3b7:e3c3:fbb6 with SMTP id
 ffacd0b85a97d-3bb689218e2mr2404622f8f.31.1755275395233; 
 Fri, 15 Aug 2025 09:29:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb64d307cfsm2418326f8f.18.2025.08.15.09.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:29:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 012775F80F;
 Fri, 15 Aug 2025 17:29:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v9 2/6] tests/functional/test_aarch64_rme: update image
In-Reply-To: <CAFEAcA_ZQ13qMRUQsieJiEPV=ULrDbz8=EJaW4_kw=yEysob0w@mail.gmail.com>
 (Peter Maydell's message of "Fri, 15 Aug 2025 17:08:16 +0100")
References: <20250727074202.83141-1-richard.henderson@linaro.org>
 <20250727074202.83141-3-richard.henderson@linaro.org>
 <CAFEAcA_ZQ13qMRUQsieJiEPV=ULrDbz8=EJaW4_kw=yEysob0w@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 15 Aug 2025 17:29:52 +0100
Message-ID: <87349s4kfz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Sun, 27 Jul 2025 at 08:42, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> TF-A needs to be patched to enable support for FEAT_TCR2 and
>> FEAT_SCTLR2. This new image contains updated firmware.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-ID: <20250719035838.2284029-3-pierrick.bouvier@linaro.org>
>
> I see this test failing in local runs of 'make check-functional'
> sometimes, complaining that it can't create the scratch/out/EFI
> directory because it already exists:
>
> stderr:
> Traceback (most recent call last):
>   File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_=
aarch64_rme_sbsaref.py",
> line 49, in test_aarch64_rme_sbsaref
>     os.mkdir(efi)

  os.makedirs(efi, exist_ok=3DTrue)

would solve that.

> FileExistsError: [Errno 17] File exists:
> '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/functio=
nal/aarch64/test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_=
rme_sbsaref/scratch/out/EFI'
>
> More information on
> test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_rme_sbsaref
> could be found here:
>  /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/functio=
nal/aarch64/test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_=
rme_sbsaref/base.log
>  /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/functio=
nal/aarch64/test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_=
rme_sbsaref/console.log
>
> (test program exited with status code 1)
>
>
> Is this something where we need to blow away any old output
> directory for robustness ?

Generally scratch is cleaned out once a test finishes (unless you
preserve it via QEMU_TEST_KEEP_SCRATCH=3D1). But I guess there may be
cases when it isn't cleaned out properly - does Ctrl-c get caught?

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

