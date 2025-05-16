Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5219CC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwXk-0007Ou-5v; Fri, 16 May 2025 11:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFwXd-0007Mf-Lg
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:00:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFwXb-0003hS-Rb
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:00:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so22036345e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747407601; x=1748012401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D0ReuWMRTooe/KylawT5wRMRAb6jXVbm6SfmBZkC4tM=;
 b=iMAmlKEbPFUtW7M0xKlwKcYIE3Q8aH6gZaEVjwS8xXICGPZYQeh3u0B1vin7lQyYiL
 cRiftdgrdK60wn56OWLe7dTnBPzLadOPPELcLVE5kYt8PaBtgX8TYhOFNCDK1joKkyJQ
 r1FQfrU8VzrECVVRkC02evZD3NZTahlktxpE/dQYOd/Gm/BAm0529zhuv6d3nRnRL50E
 AabRlmGxA82BeDrFdpk/9cyyCLnGWx7AoVthR5jOdQZ0skQrqWg8YhV5P2FLU3MbWzP/
 MiuGSka900lP7nYSiqqrR2w4vMRinvTW+LOh+kJWURMfoc0efQojYAJDL+ypNVAbj1o4
 IR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747407601; x=1748012401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D0ReuWMRTooe/KylawT5wRMRAb6jXVbm6SfmBZkC4tM=;
 b=xUxVn2zg/bKB+T459OzCzYdPkAATjkQzkktS27lPWteGP0HeFRF8Ob1j7iC4agWsuI
 vB2nbXJxx/P0x4bqOhLnIDBrpSN82hEXWT6vyNEeHWs6vudzL8iV7ZP6aIvbOw7xsEiM
 q0OeqvjU2XhZI+zZH3uhs41Nxn9IWWb8npI8Gwbaw0rKE+aWLqeU+5vbC/RSEHj9Ujse
 CHjh3fNTb9lcIy/DLtSL6oTsFIADNd63/I+6YWDPt2Fqq3Yiu08SByYOM7c98epMMW6O
 QVvmNgoE5+88XsaM5wYO/KLIqzcCi6fabPRGlqG4A0uuV/XXP7Hhb5jjqfbTyS0j6HKf
 pfQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBob/9dsCDzFZ6HNmlxrJ9rgm3SLGF7gc/qyoRPvOdNp3WvUBzvntirPFjRh0D6vDViaaGUMPrYlvT@nongnu.org
X-Gm-Message-State: AOJu0YzolguCKEcMFoiQOfHlKBrK/AB6jYEGlFlu6UW2HDIXuGsEIgFc
 vUnaYB1LOkVipU6/HKtxGo8wdb26z52ScVclZLC8gIfCu82CpDdXC0Fv0itKjAgEmZI=
X-Gm-Gg: ASbGnct9uZOczpLHLyJgNQXjuzUrgc1LJSilVAOtCis3e30MncnYCXe2vCmjSZZ5U9e
 ZlxrNAGD3FwjeEAHntod/COoVstkCiis6TCf5OxqTX5iC6eVospl10Y/AYU6n5WdHsGytBYOMCv
 mVCebUFXpDKksyl10RaXUZMccTG3abzix9eapZyObeaxErs7mYEntvQSPnSNlTJwHnGLnJ0bB5M
 0kqPl0wp8g4TlpNidJOMPj3LthTPiO/ISHpdZnaHKSWsV6ImPBmNIb84sRqAUI+owc0KR/sOhfX
 MXVf/Wp64+VxmxdQLNuVT/OzsQpl1ufAJjaWcIG4x1H9iuZlkVI8DM7uui5BGlY1aplKfiamE2C
 7PjvC49H0qIGtG/Zk01y8vKmIbyjj
X-Google-Smtp-Source: AGHT+IGw6p11153tnDLuGERn2nTAmlDbO9rlSwGmt5UqE7ZeoeFHoXPbCHjexU3BtIB0HgBE46aMBQ==
X-Received: by 2002:a05:600c:34d4:b0:43d:412e:8a81 with SMTP id
 5b1f17b1804b1-442fd67180bmr33321985e9.28.1747407601364; 
 Fri, 16 May 2025 08:00:01 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca88899sm3042526f8f.80.2025.05.16.08.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 08:00:00 -0700 (PDT)
Message-ID: <d5dbb421-83bc-4ac9-9a88-953ec0f97735@linaro.org>
Date: Fri, 16 May 2025 16:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/microblaze: Remove the big-endian variants of
 ml605 and xlnx-zynqmp-pmu
To: Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-4-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250515132019.569365-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 15/5/25 15:20, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Both machines were added with little-endian in mind only (the
> "endianness" CPU property was hard-wired to "true", see commits
> 133d23b3ad1 and a88bbb006a52), so the variants that showed up
> on the big endian target likely never worked. We deprecated these
> non-working machine variants two releases ago, and so far nobody
> complained, so it should be fine now to disable them. Hard-wire
> the machines to little endian now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst           |  6 ------
>   docs/about/removed-features.rst     |  9 +++++++++
>   hw/microblaze/petalogix_ml605_mmu.c | 15 ++++-----------
>   hw/microblaze/xlnx-zynqmp-pmu.c     |  7 +------
>   4 files changed, 14 insertions(+), 23 deletions(-)

\o/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I won't be able to look at the rest of this series until in 10 days,
feel free to merge if necessary.

Thanks!

Phil.

