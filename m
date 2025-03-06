Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC618C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqJP4-0000g0-4H; Thu, 06 Mar 2025 17:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJP1-0000fR-ME
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:09:15 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJP0-0005Ny-4c
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:09:15 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so2323439a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741298952; x=1741903752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xhPcJdLRZuWcTHNn5ILX4oDORKbEgr3FbJWLYVLBsLs=;
 b=s2FpI5337TDuu3qiGpEIcZ5O+SlBs+GZxozshzUX7JNtsNX4twDeIMFIudkUbx830a
 WS29rGyUxWkqgA2ypwlV/gedw5V/p2K2E5PGaJZmcJKpEWgVW135Xdn9tbM491DEJNTe
 ExTan1Egh3qV0COW5vTSjQAPMtaekZQ630vnfeMZb6Z50yn+nsGgmp5gR6BDBd0mhO6L
 GN83/XjUcdaGIFFUHqTliWb7I0+erq0kSAJwhMLhqwyus2nbn+I6Ug6EVpesYwYFe/am
 obD8pnPrQAaNip/JrD98B40q/z806oQKb4tMjOE727kTetXYNM6+EcEAFFh6T3XLrsw0
 GKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741298952; x=1741903752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xhPcJdLRZuWcTHNn5ILX4oDORKbEgr3FbJWLYVLBsLs=;
 b=khydAkylBWLCqiCc6vD6EGpqeXW9YuW9othQ0e/EPSfvKZgVD44jOy9PtpAwZE238d
 hpBQs7ax2ScA5C0tlZER9P13Vlce1NrEkjSlH7u7jdFryU3yNDZhgsA0AufMnisHcQDW
 /eB3w/ew+SrwMSVtKyP/7gt7iEURsd7MiCApVTaoUFWm9xBvJZdMgNIxp2dUYUHjHOxC
 SLZySvNjWuVb6RaG2LrG58ww72WGg/K38hnjjwhvz6oSMsyZcesYzHw/2Ui8YHlFfRoD
 FhJQTQLn0OXS0ukJo3YlVcsiUaFnTB+YPffSHSVo+iRs4kZh0JOIZ7kAKLu/2fTlISeQ
 GMJA==
X-Gm-Message-State: AOJu0YxPm34fhPElNaDiy0g4jMZEte4pSzi3BzZLhGz47J3us7lLutmh
 5DBM/LW5RmhCF/zrCl1zDNdySOfD+dvZKosyU8DKnXtTwzs9JcrOWkurtFEdlUf6DDPvpIL2/ZJ
 7
X-Gm-Gg: ASbGnctRMUyMceIcwCYStEpN6rsPKNVtX59lE7tg4CNqephWeT2MeVPwIFdMIsHUKCE
 pYdOuv3e9sJpRzqU+LJtYOfeLIsOlQv3HK59gc6AlfV6pzM3eMw9qbvRD5VzBxQvWhEQuG0x1XR
 DYAt9OrYQXD4L53s4doV0CWfnff04GDz9xmHFiZ1zdlljvxQd96J7nspfwJvtNReQLFX4bqTfK2
 MmQx9ttPGSMp/s6sHZl/rvDGUa296w5NmV4Q3nUjm19oCLzTxoIB/k9/mxwYC0lIj5qj8sDmEap
 zmuUk7JqwWOCU0RTIUQf4w/f8nYAs0Xl2cTpiQA5n/K4FslgEzhWK9fYbeNTOdGNt6Gtdrys6yP
 7CLeFzv4t
X-Google-Smtp-Source: AGHT+IFC5e5w+U70CvSS9ALilhsH7rZnn8T60OgnK4EWkTbhv49DvtiEiCFaLkUy3cEGkPUxbd9rhg==
X-Received: by 2002:a17:90b:52:b0:2ee:f687:6acb with SMTP id
 98e67ed59e1d1-2ff7ce63692mr1459542a91.13.1741298952289; 
 Thu, 06 Mar 2025 14:09:12 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa4cc5sm17489305ad.220.2025.03.06.14.09.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 14:09:11 -0800 (PST)
Message-ID: <12f724e2-678d-4009-85f0-719574dfc529@linaro.org>
Date: Thu, 6 Mar 2025 14:09:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] target/arm: Move A32_BANKED_REG_{GET, SET} macros
 to cpregs.h
To: qemu-devel@nongnu.org
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306163925.2940297-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 3/6/25 08:39, Peter Maydell wrote:
> The A32_BANKED_REG_{GET,SET} macros are only used inside target/arm;
> move their definitions to cpregs.h. There's no need to have them
> defined in all the code that includes cpu.h.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h | 28 ++++++++++++++++++++++++++++
>   target/arm/cpu.h    | 27 ---------------------------
>   2 files changed, 28 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

