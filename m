Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9754010706D6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nrw-0005Qn-Tn; Wed, 18 Mar 2026 06:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2nrv-0005QY-IP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:11:15 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2nrs-0006gv-1A
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:11:14 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-798374d0f44so11616327b3.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773828670; cv=none;
 d=google.com; s=arc-20240605;
 b=Bbo59VokuBFqQ03zispRBP6E180rcihZcc6fEOvdSeidS9sXdPkY+oYDa4KMK6EQz7
 34CzUJL9VP7fKMh/cvUZa8x4sHgjupwy5ESZdIXOD+DiIoZQ6YpMBxdCwIwnyZe8+VkG
 O73viXH5QrO4Ubh+VAPNNO9FoF1pft+wCm3BSfROBHB5ihsuPC1qnE4RitSEo1J913SL
 5hTNB6rOCROtKqfZhFpgOn98h/lYV8FPYBu5EVC3WUb0Y8eW+lx/BSLwJtoMRtidF5fk
 Kum70aS4rmlU4t41O+oiMBb7Sarg0vzEogGCwwUfSuy8jU7jsmYbzipAZKj22d2c4oCJ
 WOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7fRBsfiEyGPQyFguCO7JUqSPE9oZnDWBZHhDWDo7AlQ=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=RT3WnoGKFs8YhNZ0amc2qeosPXoLAukfh8FQUQCbZEpVXL4ZHe19DpL0CDgNv/ZLvQ
 eRNFJ42OOa5q7XuOyDQG7IHC8hYH4OC0iJs7LDuZhfbGaiAlEZe1YDrdwlZ9L7+XbzP9
 Q/VM/qht3alggpHcVZe7jp0TS6BpYGok/j4u+RNvhVmDWW5kLy0oTosloLbY1NygbAu6
 1Yv46b5P9GZxxFiXiQpWuMspGWHh8HQ8ki97EVMsCMnfMAFiTPAf8+/39/NBHwj9LJzj
 kqdAiCAgsqDEHK4Vm7VO8alP0HL0RIZJrs8RDJty9CXtBIE5wo/WJnbIXGmFn+HaDzx9
 Hx8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773828670; x=1774433470; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7fRBsfiEyGPQyFguCO7JUqSPE9oZnDWBZHhDWDo7AlQ=;
 b=dBjDg49ooPGv/WaZWvTXtHrZIutmWqYacVy6G9iEBHBU2U9S1fFKsSNrF9oh9fFBkX
 2QMzSZoPjW4Uo4lFHRhF7t2j/LeEUbvnkDCgjrOxfpHnJpvUtC2gfTT9f97AiBdxj546
 lBtiRok3mzirQg+NMN1qoD5z8Bl0REnFO0pZMNXYHQ8kl1WhxnXCjIKm66ZmBtmzKDGM
 gKvxW3zA/OAkqhEbIhKSbc/rBXjfj5zlLLTkvnYKcZND74wy7E1mvgLbqeonTlRgTQjF
 t5f6InWlBy+1vvfM8iY+5ly42Ejzf7Vg0nOft7RdKYpXuLTHQ5XDNlyMB+pNZ+Kxj6k8
 UwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773828670; x=1774433470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fRBsfiEyGPQyFguCO7JUqSPE9oZnDWBZHhDWDo7AlQ=;
 b=rZu1FYj0hryAydIH3gE4tCFZYW3rg+b12HGyCppLLfvmAhzopbYtijHeZgv6NFwfQN
 m9wuZrG3bbE56v2yMPOgYGyOjkCeOH/Ee0uZnqW+eNcYu4Gm9Jp9rrrBGkEK/iplT00Y
 0MzqGyLjZoVrMHJfNBHIZJKmnT+4b8z0xwS81a1uwuyQ33JE3yANfpfRdITjQ3Ua8OXB
 VcS+dpas1Vr/6hhuhDwaWd+SFfSWcsqr09rLC66YPi59+n5qEna8Pux3fGXNzaPrtWyz
 G5TdX1+fQrOnWfMKw8CTspz33FeMNxaAhISKQxQKBxCiGbORSFUE9pzyCzTfEX4MwNGg
 wbZA==
X-Gm-Message-State: AOJu0Yw4IZMosEcoZikCOWllaMyNXcwYJq3kcP6IZRjzOC9AcqbGZjoi
 yIymtiJdwUA+2NAlVkuZMVN9oEfAw7hIpApKm/8ZoD6vPtK7HvL+SCwPM2RMv1jDqDpwJDGor4e
 f6wtB3TGSuDqc/8MIfA5Juyppnp4BZgPDEJNMFjbEmQ==
X-Gm-Gg: ATEYQzzk/1LDHbHS0eTyeB2pNKSSW4u8TeWCKhO7Ay9gffHLRgcx1DCQ3LLCilSu1Ww
 DKqS3tO1vMCnmskuLyKDMwvpZACRp21UR4IiBt+tDwGgbFeps19LSD956V37YBeA6MzSu7EZnlE
 1N6CgTiX8VTb84cYXs3hX//mn3r5wq2GipaAcQp2Zs08appJ91+0J38BN6ivf9HRFl+4iCn2k2f
 9/8QU8MxcMvaFgSNs5QsOGv9RqAZunYLUZd6Cu9F49dAbKZpTQp6rrkwLkHwRpk5QL6gVjuROGr
 DmiU14Ttczz9G5VBuFo6WIlNFbSUfErAnG21QB0Sico65YOtp7IOf3wFsUcjZkB6cJc=
X-Received: by 2002:a05:690c:630a:b0:79a:4b22:5e4d with SMTP id
 00721157ae682-79a617c99e9mr58295337b3.10.1773828670409; Wed, 18 Mar 2026
 03:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260318083238.1132609-1-pbonzini@redhat.com>
In-Reply-To: <20260318083238.1132609-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2026 10:10:59 +0000
X-Gm-Features: AaiRm51uGqiMCC0PXs7Ff9oN-UPPy6YDh63U386E1m_sjCQ025XcTJKpQhLoQsE
Message-ID: <CAFEAcA-Zb9zJhbpwyGs92oSL3OMsDyshNdKatQfebzq71y0LYA@mail.gmail.com>
Subject: Re: [PULL 0/4] Last minute changes for QEMU 11.0 hard freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 18 Mar 2026 at 08:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit fff352b9b6080e580aa1fadd29b4eccf4cb2922a:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-12 15:21:06 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6257754bb9b00b52018951096a9fba28b98a5b0d:
>
>   rust: suggest passing --locked to "cargo install" (2026-03-18 09:20:57 +0100)
>
> ----------------------------------------------------------------
> * runstate: handle return code of EOPNOTSUPP properly from rebuild_guest()
> * meson: do not hardcode paths to generated files
> * rust: fix build when --disable-rust and meson < 1.9
> * rust: suggest passing --locked to "cargo install"
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

