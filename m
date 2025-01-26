Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F92C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2aI-0000QJ-UX; Sun, 26 Jan 2025 08:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2aE-0000MJ-BL
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:21:50 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2aC-00038n-UC
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:21:50 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216426b0865so57878285ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897707; x=1738502507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bDx7CtznCHfIR/7DqkP+MkSw/oICEetZ9lKY58gq0Ig=;
 b=P1PrPUT28J+I7+FXtqfLnzwRCPYzb/A0MdOOxh+Zhxii2ocgM05K7x7/adquSC8Nup
 Soo0+zRCmD+SPkhtbjyH6OChPvE4kZdjd16/y152Ji/+sSNhkUIg6EmdtoY3LX/oW/Lh
 5so4kNbrKsyDeEqWw14G3boFgdiHEkM0b/RZCoZFbbORwuNcjvAwNVLeMdgzkqF0ANLM
 zyG01i71PHhDCFHoAwOibUNbsBIAUIfqaRoXtN9e8VovPeT+X8RfDVQrseVmkZ5uokud
 x7z9s0RvXrfmbl3bYxbXXaN2SZUUJ9yOKWMs1XekGP1Y2uHZ69POB+nsw180umcHWG+Y
 iWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897707; x=1738502507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bDx7CtznCHfIR/7DqkP+MkSw/oICEetZ9lKY58gq0Ig=;
 b=gE3jjW+kGJzcFUoC1suPK61hlCl1fxT4sa7gjhnOIUOno0p3/1XJn2KXIfwO3m43eF
 soeCf+bDNHDSNjyVap6VzakB+szV0FHSdOVZ/INJZZe/nrHGv2TMynac7NFXfhobqdAE
 9lq7nIkiC7tJfl0my6G0BT0/JCY1Kptmweeh195EW5WzEiBySppScCqRirsD8fyFLFa1
 qvlWikHsq16NUw4gGlDwQ6EB3I1qAQIlP27fT/sdNmQ9XIubPGOvQHKqx1HDL4W5yznm
 RcMw6epZMHv8LRX0yN11EyG/msAj81sXXMAfBtmzQLD9SGb2oylRwVpDvffSZYEI4pJb
 qOxA==
X-Gm-Message-State: AOJu0Yx0lsOtLyYHlCeByIQvuQ6Xljx+GvmJ0b7rOJ0qJDog+omNSZt3
 s433+Sm34oLpL2LZjNKa/BSBpjDEfDTqGznbgHUjNbcaWNl5FWPvcdHnV8mU7it9kUE8lNN7kmo
 7
X-Gm-Gg: ASbGncvF2PuKlZ8XyQucgl9He/x2SEVa5w18Evxhdr0XXaNfV0GXBINF9HfxKi5KDCp
 JZBWz4RGUjOnNH8rO2nUy4Z6XMDjwDkZKCpj6F81Fnd4WOAc0qquZiBlslmYqGLFj6+BxSuagON
 w9cTgOcT++2Q7+Xvlt1gmDF4ygkk6mxqf1XcGnERfZc1aziesC8aqR/a8eY3QQ1l3cWjw5hg8Cm
 uvB4lWRRyck/f5BpoW6Dyk7wXZ2qrxwhc62cM2Ek2YZrAz54WDRX3i1KJHNousVWot3eL4Sh5OT
 +bRlNwjv9V/zroKI8DjtZEY=
X-Google-Smtp-Source: AGHT+IHf2TkQXK5AG2Aa7kX0Ti2tyFVtfm1HTSoR+9pvgotDcgPJlaLFmR5dE0Jod6kE7YATvbcTSA==
X-Received: by 2002:a17:902:ec81:b0:216:5448:22a4 with SMTP id
 d9443c01a7336-21c351bcc64mr603925205ad.10.1737897707429; 
 Sun, 26 Jan 2025 05:21:47 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424aee6sm45476725ad.215.2025.01.26.05.21.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:21:47 -0800 (PST)
Message-ID: <ce068dc3-502e-48a7-980f-27cedf730848@linaro.org>
Date: Sun, 26 Jan 2025 05:21:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 68/76] target/arm: Enable FEAT_AFP for '-cpu max'
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-69-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-69-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> Now that we have completed the handling for FPCR.{AH,FIZ,NEP}, we
> can enable FEAT_AFP for '-cpu max', and document that we support it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/tcg/cpu64.c        | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

