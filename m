Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F56CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 22:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5tEp-0003xg-H5; Mon, 06 Oct 2025 17:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5tEn-0003xK-If
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 17:59:21 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5tEl-0001HT-IQ
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 17:59:21 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b57d93ae3b0so3741728a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759787957; x=1760392757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AfBvKJJpJ6q4U5syqX/XccyPCaFSm8RTFze9cH68z4o=;
 b=Th5jA8VgFdXtCfHOwGGrGpVxdZ5W1ncpVUIb0e1ieQgm7gGMJ3J3+QtMEw/fxvNDZZ
 h8H55GNuuL6E77gnsO3odTt0OY2HVv2Djd36sTRtC+Yt3Iz9Q/ZyXHfvKdu3ZuYJCaKo
 e8NIK1TEQ8sVSpTEzxSA/C5Kv9RccdT3B+rrNE3rJeY7CqJ9uXk+i/WUJ88M9ADPq/zC
 8iHIM/MjoD05kPVdQ00eZ9Kechgs/rakI3VZnSGJ8/HYEGHL1u6Sq4Kd63/kOxgCPbRd
 s4ErYhNbdH5CGlsmbp5CGwcp9L2wdsbg++G3H15tyA/fPJUoZSzj2P0fpD3Z2+XGuoFW
 SAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759787957; x=1760392757;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AfBvKJJpJ6q4U5syqX/XccyPCaFSm8RTFze9cH68z4o=;
 b=G7WkiLn5oSunnAz3Zm9gf6m1TTzGkARBdcAWkzQxZKXyLZUfDr1qiVm8zyW6G1L/+5
 u8Q/yEDl9091dA+bvt9w8uFz37ECTloQh5kbiWZXNvFlQSMVs1/uJPg8h//eeapZ2bNj
 +B4M4GMFcU2T3DDviXyusU1njfjz83phGgr/ghrR5SB66WWPVgidcWorH4TUt16f86Dy
 g7zCrPyT2n/gaF4iyfxw3Z8jNLDvBk9KMdzhi9Smq5HjtOQGoPCvJMGls6AMb/NrKvPZ
 SiiwKrMoCHPnHR7as/+Rh0PIh66rOZvICNtFyUWvZoWxyPjxn9S/SuJWpdSzflB0TJjq
 BVcw==
X-Gm-Message-State: AOJu0Yx8Wuwg6gP42Q3hiWF+p4GTS9kbPpi7srUO9p3KPx5F7i4N40oB
 pEgL1tMBAiMned+hzfVwwa6sK9Tx2/hggJKxe2kD2RlwqjtfK2oQk5uj7wplfYfamY7EyLbo2xm
 R0zwSEgQ=
X-Gm-Gg: ASbGncsjB7mVE4911XsfDr8X3LzNPEROtW3SXXVuxs2c3OPjQXNDY5r5uDtG4aC7NqS
 CzpF9SDJkn4M9j2AwDgms/UE1fFqSyrAxf2HBXu+5S5Zj1fE4bMzWscPjt+TTjt1gAe4S1ENonJ
 H94m3kihwyMpbXE7yGWu3uQi1VgrQfJIptE14u8l7Yuc9XKsswFEE7UE1Cm0v4nDfMXpDsFyKNP
 ZCyYs5712p8n6sfxQa3PiKepOKkfZ3HiBqnWUpx/CZt/sTrwAZs6jFgXFieeuwNl2wbtKw8eQ27
 4r1gFO5vD6n25UWKUzDDFYcTH4gc2n97QC1zh49vgwyt2nL2SOLznmSOxyy0y6M7AyWUCW9shcB
 QIn+NZkNGoekdeUoCFANlSmXfUzKuOdUMWwyq5Anz3oTXaNenunBPJ0I/oPDEWwjQVRF1/0JGyo
 E=
X-Google-Smtp-Source: AGHT+IFAPBjPSecDPONJrlVgxJv6UHwbcMuq1JidE9ytaaxB0zCZS6PxwozklYv6dLnIRSPcS7cQCQ==
X-Received: by 2002:a17:903:f8c:b0:28e:873d:93 with SMTP id
 d9443c01a7336-28e9a5652b5mr169894085ad.17.1759787956748; 
 Mon, 06 Oct 2025 14:59:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1b878bsm143316415ad.81.2025.10.06.14.59.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 14:59:16 -0700 (PDT)
Message-ID: <8e1047d8-3ee1-4808-9c3e-710d293efeb0@linaro.org>
Date: Mon, 6 Oct 2025 14:59:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Trivial patches for 2025-10-05
To: qemu-devel@nongnu.org
References: <20251005065538.436862-1-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251005065538.436862-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 10/4/25 23:55, Michael Tokarev wrote:
> The following changes since commit bd6aa0d1e59d71218c3eee055bc8d222c6e1a628:
> 
>    Merge tag 'staging-pull-request' ofhttps://gitlab.com/peterx/qemu into staging (2025-10-04 09:10:58 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
> 
> for you to fetch changes up to 0af5926a0feb0b69a127f5c24eaa605408fed2ec:
> 
>    system/runstate: remove duplicate in runstate transitions (2025-10-05 09:46:06 +0300)
> 
> ----------------------------------------------------------------
> trivial patches for 2025-10-05
> 
> Just a bunch of tiny fixes everywhere.


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

