Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983D3C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA7gI-0001wn-Kf; Fri, 25 Sep 2026 11:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA7g8-0001v2-Hh
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:17:38 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA7g6-0002S6-3u
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 11:17:35 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0d2d9088fso143638a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790349452; x=1790954252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=urXT4jPKU6tbVHhypN6hoqubodCMD/uvkI9RhN6LG/Q=;
 b=UlwCGDSXWa9HZKvp882V6BhdGFeJ3M0ZbJgWjQO7aAWnoZ+RkM77UeZiClnZwhjTAo
 iqCj7SonCwe7u+yLWOJICzn9budQVMURegoaTChnc57AqHUfiyQHOTLff/+YPRBE1i47
 NeuCOSgDIVZC1B1WPaVsz40k2ARVPTPz1h8q02lb5pu8l1XcxqjMd3QzV66iaS3KPT4q
 999wrtKf4j/i8RU4CXREQ4kjpkH3bNoaK/z+zVPcQU3gXcaDpHMoHGWzzUe2zDLWT60Z
 WS0Ho6o9XqjdWpLFH9f6C3xip0o4CkdRwiJeF4MGAboY3gnHPZbprcI5eKVBnrHQ+8Wz
 vtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790349452; x=1790954252;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=urXT4jPKU6tbVHhypN6hoqubodCMD/uvkI9RhN6LG/Q=;
 b=YFwHoCrMueNaeADNkH+PPZ4TZjMFL+HVK0zqEivHpEdvX7IOroRHEDH7YX31Su/tVU
 CoSA3267Lk+FvgZqQdC8dzuUhzwqkwTEu1xAgNJhKh3I9NZ+mHkk0bx8NQIzg0gw2XDz
 1R1SBN83/P3NnKWAf+JxUfgieA5FIpRxLQrvc7Yle2nmS5C1M2B6Qzstx7dKOLiokeb8
 V9YjGQuzTTO3nOAUF46q4F1LIXiK2JdwkCrX7IicCRMbvgFfgM8ATwHHdxxAfwkq/YHc
 FiIDh4IB3vntfHk+P8b77DyGv19lGc0P9LalcvmTY2AYoqPfFRdtpNeBX6lcrP2F0iLn
 G//A==
X-Forwarded-Encrypted: i=1;
 AKwUvByWUDFP/ESpIHVQakFcZLsvltv/fEF2UJMp3ghHhGDFnTDD1SNj2lizU4ft04I8G3/ykfgCm9sJ38va@nongnu.org
X-Gm-Message-State: AFuF++n3c+eKhr+biFIx/aL4Ryfzcbm9/f8GTMiPmX5bgS+96VOvpDXd
 wgxvLtjByLHfBIQ8yfGJxqy1wqy4sgB6F3Gp3H5PozwJSNTMPUE7erknKShrcz4pZ8J1wXkQHUh
 z3KAI
X-Gm-Gg: AYBFou0Z1CYrFO4XpQF+ngy6NoDUSOXRhdWnJGSBcGRZ8ln6hzk8lcIygFymSJiZpH6
 B7KAMOfaX5oeZfPzK+avexHxNQWuZMEf0sNpu931cXU2qitjE9f1rIuBQ39KDQ3+S5fL1qzMgi5
 pUhsCH+yTDaNo+77m9HsSyXugA4kGJLh63M/tA7PsUeHESvwNbH6GhHtZiF/B2pf7rBGnJ7RN6D
 dk5uUCQtsBTIG3HJF4GmHso7RSr2vF600w78Ds6mQLxyV3gOauSa8/zok949sN7ppAkxwDB+DI7
 1q2zbt9duj1RQmtTZBxnyWHq5XH9tflJD0j6EpQVi07jecIJ7v3xShpAPjWoSdR3HSax/+185sU
 ITvtidJbl0ZwcKlb93CGI1KnDl+fGsefq1G/INrKChjNWcJwa71Yp1sZ5EZxxtAT8j1IT3fE7TM
 W0+8ufLxBvaCmQ1K+4pB3nbjghJBj3o4wmeTdVtZfCLzcy9MrCQXCo4fHVcS5pLe07IoInkWSoz
 SYGUVMr9w2fBkiNqgZtDkDBorvQuleLGhu0Wsvj
X-Received: by 2002:a17:90b:448f:b0:3a0:bddd:5b0 with SMTP id
 98e67ed59e1d1-3a0bddd07a2mr1767171a91.38.1790349452197; 
 Fri, 25 Sep 2026 08:17:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df91423df7sm12673035ad.43.2026.09.25.08.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 08:17:31 -0700 (PDT)
Message-ID: <db122cdf-3dae-403e-81a0-7d7e8a5189d8@linaro.org>
Date: Fri, 25 Sep 2026 08:17:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/40] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/24/26 18:53, Brian Cain wrote:
> The following changes since commit a97f90fcf8029af253a2ba274b9bda9acabc5b23:
> 
>    Merge tag 'pull-tcg-20260924' ofhttps://gitlab.com/rth7680/qemu into staging (2026-09-24 08:24:59 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20260924
> 
> for you to fetch changes up to 443fe4436feb05b4b55ad0fa77d199da39b7f13c:
> 
>    target/hexagon: rename LEN to OFFS_REG_END in VTCM macros (2026-09-24 17:22:46 -0700)
> 
> ----------------------------------------------------------------
> Hexagon: HVX sysemu, tests, fixes
> 
> Added HVX support for system emulation: bind SSR.XA to the associated
> HVX context.
> 
> Endian bugfixes for HVX.
> 
> Add tests for improved coverage.
> 
> Improvements in the simple packet short-circuit logic - for handling
> multiple reg-writes to GPRs, System, Guest, Vector, Vec-Pred registers.

Applied, thanks.

r~

