Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A9DC2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcY1t-0005FI-RU; Sun, 04 Jan 2026 19:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY1k-0005Ec-B2
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:00:57 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcY1i-0005qQ-LE
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:00:51 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a110548cdeso181585745ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767571249; x=1768176049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DsQF0cRXv3d7BSGA/ghAlxSb/S8HYBmdwaqoNGzeu8Q=;
 b=EN1sPWIh4MCqpaZuyuIvnHIbMY9KSsFzALg+V7F8sdM76wAZWSVp4qILAblEmbT/VQ
 tlMHRwauc/b1bOL8hgucnIJgfJIid0c9R0bO1KIDq32eFpmOxJYLROYDOE0j5RkuDPNL
 pl5eZZ0AXwBv6JjTVrLCmh1+VQPyWFrGeVv1pP3Udl0r0PWc9PFhWq1QVRaB8DIFCxnj
 pgxJQBlwwUV4l+PelnsMYrKUSTQ5TpBKUqcgttuaYpH3Fg6ACM4Ty3LCwDv3a1f/+bLL
 941yAGs739mfo4jw1OmzAnDEyD6J9VDjd84Dky/M27Jf+aLHr5eV0vFwWay6EoEzNk35
 +12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767571249; x=1768176049;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DsQF0cRXv3d7BSGA/ghAlxSb/S8HYBmdwaqoNGzeu8Q=;
 b=K4Xy8wCHaOxE3ykUs1RlWSxtZwX3ClPpcZvEtDFUUxiq52Y6msFb6WXSQpK/BbqvQs
 teQGMu7heAYlYPyfqbeHJBktu1KsidtFUEvMynaRZyPOfliyqgbOLm/pZ9jr2qo+/9cJ
 UMCXBCWoSXzIW6i6O8lJjuMH9QDhzGQwqex3DftAOEUFCIQGhl8vxjWya6jeEr0uRsOe
 8j7kGGQ+CUkhKyfsrlxSzfJw9F2jlgfpMfDSBdcCz/BTSGmz9LT6R51G/y3jWiGJUPSS
 7Fu2+Fs+uN0yPwpWYB28BrOMGtb3T8ooGQPRvhJk8YbxzxO2stVzIXW7ecRx/h9JMTJ6
 9F/A==
X-Gm-Message-State: AOJu0Yxqpg/8QZzkLvfukVc0bP6NZ2xD8ylQBXUR1U/ytJa0CCm1bGpO
 87PrLkhMGRkJsk+zu1HjbApF9NCrHKczgfPZBGm9bgPC3KxYWvLjKdZizuBkM8wQg0pQ9mVVwXx
 i1Nd64/E=
X-Gm-Gg: AY/fxX6gFcodu1TeIUWVXmY6quIUOIoHIYw3BGO74I56p+JmEHphADHznoMKSp6Pimk
 n+4J+i5Q+ra32Ni25S/lUomY2QnYN7lq5gltxNlAYhFwmDwIU6frHg45RTMioRF0GrVSRS+sGaO
 E+cDSaHO1bqIH+0TCVcgs/5Oc7ycj3qHdQq9JyiOTRR7K+N2++ZhKeSO5zXSHx0yx25TLonEhTl
 vdKIr6rnu2ZbTSqfhouxLaYVQjFDLcD9YKlcFnKOqyrNmr4o//5vZTf3+NL8R5cgTJRMEe5FzVF
 x+nmkGpfME4mLCgfHkB546CLNUeSsBRoniBvI7ArLu0PqATJkc4oe253wScc/b3WMbvkE2OUOBO
 xClXi2af/S56fkyuhGyfT5bkvqFoXdGpTCPQvtENPGs3fYbRGYbNQv6GGV3a3BEmBU1rwFx8O1X
 fzw4ws6oFpwm6JcMX276wSZuP0I2bq+A==
X-Google-Smtp-Source: AGHT+IFPPjadwu0R1VH9leUzQXygDshUlVIx8IabRAIIXiWezDNtREPgNMtpco3kKDqNGX3U0UeDmw==
X-Received: by 2002:a17:902:ec8b:b0:2a2:c1a3:63df with SMTP id
 d9443c01a7336-2a2f2830da5mr487703165ad.31.1767571248798; 
 Sun, 04 Jan 2026 16:00:48 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c83961sm435086985ad.38.2026.01.04.16.00.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:00:48 -0800 (PST)
Message-ID: <c69a083e-0705-4a7b-9588-bf5e26544d1d@linaro.org>
Date: Mon, 5 Jan 2026 11:00:44 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcg/risc-v: Fix clobbering of TCG_REG_TMP0 (t6) in
 vector code generation
To: qemu-devel@nongnu.org
References: <5D809A625CAA1DCC+20251229084747.1428-1-zengzhijin@linux.spacemit.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <5D809A625CAA1DCC+20251229084747.1428-1-zengzhijin@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/29/25 19:47, zengzhijin@linux.spacemit.com wrote:
> From: Zhijin Zeng <zengzhijin@linux.spacemit.com>
> 
> The RISC-V target currently uses register t6 as the destination for vsetvli and
> vsetvl instructions to capture the resulting vector length (vl).
> 
> However, in the tcg_out_dupm_vec function, t6 is also used as a temporary
> register. Since tcg_out_dup_vec may emit a vsetvli or vsetvl instruction
> internally, the value previously written to t6 (e.g., by an earlier ld in
> the same translation block) can be unintentionally overwritten.
> 
> This patch reserves the t3 register to be used as the destination for vsetvli
> and vsetvl instructions.
> 
> Signed-off-by: Zhijin Zeng <zengzhijin@linux.spacemit.com>

You don't need to reserve a new register.

There are only two places where a tmp register is live across set_vtype: dupm and dupi. 
Both of those places can be changed to use TCG_REG_TMP1 instead, with a comment.


r~

