Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B90C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSRC-0002Z3-7M; Tue, 29 Sep 2026 03:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xBSRA-0002Yv-0N
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:39:40 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xBSR7-0005Pi-3a
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:39:38 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c293c683202so556404166b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790667575; x=1791272375; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3WZ18XJ6XgCGDzy9TgcyGC1cokB2nelddPH4ZGMBB7o=;
 b=jnVlAJPC03uq2umU9PHT7QR1HK2/KtUl+1z8w5TpqYjeGoNWN9ULwfiTBr8VAqzzSg
 vh6BeLeYUeFzt8hUdR0dlVwj2XTIacW2CVTwYbABZY3IL1IVxnX9xTIKDTBh9Xq4THVk
 kvgZlM+2x8jgeZByPYkBbuU2QOjy2Zq5tXXLZe4kshALivHTsVQObiu447ChkICPNtuE
 5JeA3ovga4OfaMklHCdUo/vuUzYVBuRBYKgJWariOWKRfEuxHnYveH+5HMOhcBmLVy+9
 Np+Fd42v0FNGc1StAh3khM2XNkmMZquG09JAIx1lLhRQVGmk3awByaPjBZWyrxaRyA01
 DPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667575; x=1791272375;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3WZ18XJ6XgCGDzy9TgcyGC1cokB2nelddPH4ZGMBB7o=;
 b=J5SvoijHFVVFepeuK0DqdvXCedkIXnnhTUtuBg/PYS37bi6TAKMnzhdfFN5VbwoAQT
 ETffoXCOybX3/tn5J3uTldPW0qrO+bYhswknShsiN/kialsR/Z2BUCUA9dgSQqdV76IS
 kdhTFC2hHDeSVIajz0/cn76ktMcm1xQ4Ihd333NZzTVOQM1MFKTb5Vi/k7qRhDRpYqBm
 u1donRR/hStBBsJ1EkBXBeOY2FLown0LI6/SzyC05cEkvM2Cfaf7/VOFUCMvUKZSk4FU
 D1cK5CiWnmoPBISoPn7NZA+BwnXoQw20prqiV+95pOt0QiouPcI3rTGnhMETTgLv42KX
 DFFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2koZOb9643+Hg5uWc+tixQ5BS9NCKTpP8pPwFvU0b7pgq4Sy4goHJ09ds8FINdwX/y4hLbvPWAHOP@nongnu.org
X-Gm-Message-State: AFuF++nShZp38enXCW/ij9r1G6wvwACcvjHb+KDdALfK4dXuEHN+Ob9H
 dQG0OZTCl4qmLinZnQodTHtSqB8yigzBVs3Z95pbMXHxLRaYQRSyPu5zZ7pp4h2aajk=
X-Gm-Gg: AYBFou1CtiQ4/D8bVUEqQ8FxsEwnmbqbGpKw6vrA3uppzzLopEGD/IGrNWnMCns5Ax7
 umAtcOqtiNsk3duuPFC2MSdhlfoXYCPuYBvo77ktQIwVXrWpDzhhXmdRzrb0tsk1ceG+cALNgJp
 BpOH42r7psVz4DzTIKMtOkBqsqML3/C06MT9mpGR4VnZYsVFQZu2uiaRFcd53E7ssykJbAtH4e8
 s9sMpprD2pKpKms3vaQrvJ6rGwy1tgyLGmFKq/c2POKS5ILJBeOic90q7bktNd3y3en/fwun3nZ
 /Ldg039CvkTGHrpSr6kTWviqr1U5iGx3lXcL62kn4Sgvu8x9lLguNPRDaOKQpaKef3g2Uf8oJzO
 9AgDbqw+06Rgw2O98H/cG3p4dGzyM5CgT3ApklkjENP1WR2HYj3qMP8CXegTHH4B2Wli6Ai0b4k
 9S/x3w1cvJVuYAsBtoLpxKu12vLFdGppAvRwPAIlC5g1vrTj/aL82TE2E4ssOc7SOFjLBDv7vUL
 lNTFvky4+WKsxWWeD0IvoFLf0SXasKvjB9TScPRKsZMixROVHrzFd2am4vTeVnM8OIhCQ==
X-Received: by 2002:a17:907:7283:b0:c29:22cf:b0f5 with SMTP id
 a640c23a62f3a-c2aea05f3dcmr936690566b.33.1790667575340; 
 Tue, 29 Sep 2026 00:39:35 -0700 (PDT)
Received: from [192.168.1.39]
 (cpc91486-slou5-2-0-cust898.17-4.cable.virginm.net. [82.13.155.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2de21a6349sm220626466b.21.2026.09.29.00.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 00:39:34 -0700 (PDT)
Message-ID: <3cca72d4-ebb9-4086-acf2-57ee0177b3af@linaro.org>
Date: Tue, 29 Sep 2026 08:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] accel/tcg: fold the dynamic cflags into
 CPUState::tcg_cflags
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260917082618.1076988-1-richard.henderson@linaro.org>
 <20260917082618.1076988-3-richard.henderson@linaro.org>
 <8ed6ee25-57b4-4068-b526-c9370934bd84@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <8ed6ee25-57b4-4068-b526-c9370934bd84@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej2-x10.google.com
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

On 9/29/26 08:16, Philippe Mathieu-Daudé wrote:
>>
> 
> Noticed this commit while rebasing hybrid-accel work. Could this new
> helper be useful for this previous discussion (patches 38-40)?
> https://lore.kernel.org/qemu-devel/730b4fca-e0fa-4e99-a092- 
> f63aadfa57d9@linaro.org/

No.  tb->cflags and tb->flags have different purposes.

That hook is avoid synchronizing cached state internal to the target.


r~

