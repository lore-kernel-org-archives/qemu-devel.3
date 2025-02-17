Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59E3C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjw9k-0005SJ-N0; Mon, 17 Feb 2025 03:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw9O-0005Aq-AE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:06:47 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw9M-0008Pt-Au
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:06:45 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220e989edb6so75213035ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739779603; x=1740384403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gJN7KZHmHjZ3XjExWV5uhjIpIHKKlXPnV97jqXewGlc=;
 b=JGyFU70RLt741j8m3ZijRSjDL1HPTYrz9KXl47da3kHndlFHNps8yVU72S1IDFH+HQ
 LK5j2xpL3K2jYgeHlLy8DBZd3CxWJbZy1wAmQ4HFTvkL5yqxcTYIfMYxFSEXv4ioPO4R
 drXU+qUiqwcVcdBw0khUKXlSuNlfTA4q5s+pQUTp0I6usz9YJov+1sx/iL+fKFXm5JoY
 eO7H45/A0v5ljDDGUjwjep58rt9y27xoNJppKyVmKdS3ih6QMbbzi9+Wzf+PMU62xi96
 NjsTEU/2tksg46W8Pbf6BQQshkp9Xx4J2WIsCjOVo12Sz58GZqUDq2SCPGwzelUL2DtP
 eGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779603; x=1740384403;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gJN7KZHmHjZ3XjExWV5uhjIpIHKKlXPnV97jqXewGlc=;
 b=WvDziDonIIv7hyKu/lkhmzu4o5dhZVTD860G7r/UcjBgSV+e4AsKZWSdhc9bwCvC9K
 DEOXp42xUCC7m5NoMdxwTNsX9fLKOuJ/aKABrCSUH2IDKqPvPAmXk4Usp2MV9pujcUfN
 Lt5ofL0tTS2zRP1MyCDK5RAJuHNm/ym246Qp3IHv6VwnRvh6wIa58VHDr94RdEgc+b43
 En1P7daCUNX2WsCIv2yKAnK+BoKJ5zi1UDLRr4TI7egqQQjHI3xmKsW7/F+GypWEb4Fc
 4IsxkgBpSHZ0iFDCmiOX7RqAx8XX1asApXrCNfHoJat2LPUL/3aN9IWd0HV6LlkTE3br
 XcRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+WMijL8Smzz2FlPxI4eTcC8mjUUdWPaq7gT9ubeWKRB48mEoRcV5fje5T+p9L52H6NViSB3qUo4M4@nongnu.org
X-Gm-Message-State: AOJu0YzSRz9O79LYNyE7WEqAx5iRMnwPin+iq+3V9XqQ3GS6ALv0G5zo
 90WxmcS11VcYjXALPAQXR71R6/oo68SgB8g8FkiKSPXyrWfcA5qmAJRv2lwCfcM=
X-Gm-Gg: ASbGncvXfzHGQLAad94aEkzs9D77Bm1nRutFwZlXD2eaKgBpF9/+8sytGvESndaSn2c
 hSvX/Glpy75BQEKaYPFUSX15KTwcipNyS4aWVQCi3+vIAP02t5wyLD3exHXXDr90Gr1E8RLyC+3
 TqDlJB3ytWIKZV1jHMLhtEcYVwcw2totSbkFWVlyXbFTJquz5QwDE7CCZCTjnPeZDS4hoFyBe1B
 ZpvPifYX4SSxS/4kkW50j9QLi/GsQZEdA6FS6RWgGwtYQHrbZ7gjLMRruPnG5fSadgoeBMKuuqw
 inpgCi/P9m8BAcbDz+f8pv6kF9D3og==
X-Google-Smtp-Source: AGHT+IGF2TucfkwKT6rNPKTy89kobGK39s/8uZ2Xtz8h17wPzujzKogIDb8JxDSUYpMrfPOWe46lyw==
X-Received: by 2002:a05:6a21:4014:b0:1e1:bee3:50ea with SMTP id
 adf61e73a8af0-1ee8cb5d0ccmr14334780637.11.1739779602919; 
 Mon, 17 Feb 2025 00:06:42 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73242568a0dsm7419247b3a.43.2025.02.17.00.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:06:42 -0800 (PST)
Message-ID: <96bbc5e2-ef44-452d-af1c-ebb4a048f42b@linaro.org>
Date: Mon, 17 Feb 2025 09:06:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 080/162] tcg: Merge INDEX_op_movcond_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-81-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-81-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x630.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           |  2 +-
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                | 15 +++++----------
>   tcg/tci.c                |  4 ++--
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 13 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


