Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A376C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 13:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU48B-0007Xl-OL; Tue, 24 Jun 2025 09:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU489-0007XU-Vt
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 09:56:10 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU486-0007Vf-TA
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 09:56:08 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b34a6d0c9a3so642105a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750773364; x=1751378164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9+nWBo7i7WCZ2UG5L7PNPjkabWITXE1kl5bG3bC2nx4=;
 b=apF/5K2+nO7U0ZAVpBb4iC+lv5Y+QsZZZDZ9ECiZFqCy2WgzErrKymQUqi5fqwzgHB
 FfEJf9nYSR11Hbq4qm7bwT/7vdE8iUbPyduyTo5DTeZmVfYRBZcnZPC26fQsx0E5nuuR
 6wiHtoLL1TYD2bAOKLAW+yQGkWvwHBufnQN51FLu0NHBQ+YiomwsvPT90imQMlsvnPQ/
 /gGVr9qhJZ2m0ZLTvSHWlAjllMZWGXOb4EtDQvBXp7qA3Mcj/YQRb/yDxmVwcbJL1lyQ
 iD+jai/ZMMMqfTGcPK+34hoHlXAIxJtnV9L5gpaT6jqejuufBunEIGEmIVXtFZ5aAp38
 KJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750773364; x=1751378164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9+nWBo7i7WCZ2UG5L7PNPjkabWITXE1kl5bG3bC2nx4=;
 b=oVHHBEn6bMG7GLFqZq0d4LZeOObnRU/HiuioPj7ymr8C98wFUsYOe3pDjN/Q3Onzry
 swF9aZNNSoKuX/C9/47ReHsIfuTeycW6p77R5pn5gCYFOBVNlDprQXLqF9a5+qaHZYCQ
 vQxntuOR1VU8EyshOqhkKSwnZE1ZIE/tnD856ZsCQ100hssQk4m0bf06jMki+aIs7sxS
 1WUut1/xZY8eokFK2wRLSOTxl97hIFYf1p07O4EA/9vkm1PG+ZKzjp3WHGyvLgKR5Cnf
 g0mg887iXY3r7M4IpWPEF7YmT4swue3aLMJEvrI3XTHZUyC6LmLIS4yZh0v2X28u5zQM
 /OkA==
X-Gm-Message-State: AOJu0YzyQdo95lTxTeoj7SW07j907hU5hzSyFyRH3YBrD/ANnhU2o5D0
 FCArrldzexwl6KBVL8sDKr0HWMZrQjhHdsCSe8X1rvprIi4woDHRJtefk28EqI4eaE6VPzxDN0C
 uW/xG14w=
X-Gm-Gg: ASbGncs+BRAyFzVIhe+iIYb3RTjAWFhwH751Dm+SSa4JX0xGhN03U+CRbNNPQQyxvL1
 oJZVq6i5XfAIEu6oFKDRPp77iNbh7G2+NPdmXkjp+KbrIJqfstDeuSLe6ZWqXoSdoNsOjsRhioo
 KsDVkl/2U6yLdmpozFffefITFMTZxW3tCcBD/qtLM0823fEWN3Cri1RI3XEpqUqhwmytIoFrL/E
 BZnLFhFwzQKPDqquwaKVEtinEOvtpoJwCd8wt4xgTC5gfMsyrwPw8mTuLrOQwRMLIRUtG1dShbA
 /WwFPjg8bmWVlBAfabOgLNKfk+Co0v0SB4Wba1j4QD8QslDWacgrH03upgXEjbdGCm43iewTR7V
 oM95yKh9h+mQoQH4LVEvyaPI7Fo4X
X-Google-Smtp-Source: AGHT+IEQVvXPBWlOzrkSyRrrRDZWCecQL0hLQ6/qcPHzb7F7oTsyWy3fqfC+8br+MEOjEHQBPYq1hA==
X-Received: by 2002:a05:6a21:68b:b0:220:670:879e with SMTP id
 adf61e73a8af0-22026f87dabmr23521822637.37.1750773364433; 
 Tue, 24 Jun 2025 06:56:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3218c00286sm4721443a12.73.2025.06.24.06.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 06:56:03 -0700 (PDT)
Message-ID: <ed27cef5-b936-43ba-950f-b6470aaeaa45@linaro.org>
Date: Tue, 24 Jun 2025 06:56:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 042/101] target/arm: Tighten USDOT (vectors) decode
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-43-richard.henderson@linaro.org>
 <CAFEAcA-VvH13D8ViMu8kv85sERNNA1JP+JLX0p26zKu_nasBcQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-VvH13D8ViMu8kv85sERNNA1JP+JLX0p26zKu_nasBcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 6/24/25 03:13, Peter Maydell wrote:
>> -USDOT_zzzz      01000100 .. 0 ..... 011 110 ..... .....  @rda_rn_rm
>> +USDOT_zzzz_4s   01000100 10 0 ..... 011 110 ..... .....  @rda_rn_rm_e0
> 
> This sets esz to 0, when it used to be 2. The helper function
> looks like it looks at the simd_oprsz() so I think this is
> wrong as well as inconsistent with the esz we use for _4s
> insns in the previous patch.

oprsz == vl.

esz is unused by the trans_* function after the change.
But I agree it's confusing to set esz=0.


r~

