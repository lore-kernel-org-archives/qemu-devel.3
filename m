Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D86AC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x04j4-00060U-Vw; Fri, 28 Aug 2026 18:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x04j3-000608-Uj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:07:06 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x04j2-0006qD-5B
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:07:05 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso2216385a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787954822; x=1788559622; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oJN2ebBCig1xXQWSndr6B369XBH8cGgXx4DUAYFq41U=;
 b=nAzwYXcJWQKMIRjsNIPmRTi0PdAzyfoOeJNai1NeMMEcKG5McSqha0JFCqIm0Z7GzD
 f9ReMDKtgOfu4QkX108Ob4PntmxlzaFo85N3WsDBRPDUIEUKc4HTmOYAFcdFD5pQqYft
 Vajobuf+ztTC3qNffvoks3Vv5RxjQP97QX1tdIrUD4mTRf4+mgWRHf0XNnU9eX3y/U70
 UGGpwAtPNdXf6Wm661wSdqS5qhOvl6MmHNzMkcS0qtD0K94zrIwyMWtsn/agQhuArpGx
 hIsbL1jkPPFMkjmAHV49XHWrv6YYrd/KsTUTkesW+CDyVlOq4qYR3AUPft+iXUN3WZdH
 HNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787954822; x=1788559622;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oJN2ebBCig1xXQWSndr6B369XBH8cGgXx4DUAYFq41U=;
 b=f8hv7FOJry5gWk1CEkmQbQFnGHkEUA1azcUdn2JtHQSVoNRG3GGtut5RRmcHPqHAyM
 ZN09fyYk3U7OTiNqhDMMF/nPG4Qa2aempxmyTICuguL7t4jfzFjCq9s20pTKjr4YOoQ3
 sHnxdwy54Z3bLVEZ5v3GoiA4Y3r/wYgM2CJOADqgem9GTGkbUxDw47Vz3sV2DU/M2GdN
 6NfDXA4iXrzpSv9uOO7Sn2BjfLRhvICHPw1wC6MxkMFgaLF3w4Yi8DVsi2lQRO/KoBLI
 aDgJck/DNhJcDNQsl0ugs6lGEH267pMH7t6urmx7UDBeoQnLGZEx/QMWHI8zcJW3MRt9
 nrHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxY+RwyPYSiMeNzqswXRjC00A+oepIhUsAYg79pIj9OrmyZXotI4RoARnVF0srBKiFEDOWDqrHI5/nN@nongnu.org
X-Gm-Message-State: AFuF++kxkg97Nrkj3K1I8OoPIThCDjM18u0UIfgxdrFulHdCZ3YOf6pT
 ntkx1cyTaXrJdgj5OlTkZH/iT+q3ysuNJM5Zxmt68uRUpd8YIusnz2UBarxIX3Utjt4=
X-Gm-Gg: AYBFou2f7e2xY8TJ3ws6YM1NXPQfFk3m3rVW1Y3PVwcBiQvcPblXe0YhZan7Jg6vpLz
 PxgYPKRMIhozffvnbz6G91Kko0wOOEGiPhI2ZK9pfO17Rt8+0T7KVOgBTheWmUlKAlvBK3X8Nfa
 kHuUmVvrZxt5GtR5w4N6TB2A7xTvPGu9Q1GSM1qm2H7pmYdhztOs2NDJJjOPZOp3En6B9zJWVeq
 TN+2aqB48pODEFmtzuOz3FziG0ZtuFjSbfBA9N2Mn+1Lwlt8ddqdQfsRrPjfrp1xl0nptBdxiRq
 3J3yGtFgv9MT7ZoeixXOGdyyoKbRLVreSiZaIiMLZZ16HlbDRBNroHJX8kcjfOZxqYy6Xa+cVh8
 ZZ6vSvkVv873bcp6hB1NDZ0nwjDDroSK9YutWhIjqYRsNoRiVb6ha3Xj+8xqPCggRR+7DL2I3HO
 iheDseIZKT+NjZsFRgfVcOZUQtf9laCPjR9Zkcjj/uIzIO+n4Mmua/yeFbcA0W8JitKUe6ArTwP
 rKq2nVtNnBcOZWxXjMeKAQ8I7v3GoE=
X-Received: by 2002:a17:90b:2b90:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-396d0fce294mr20114416a91.12.1787954821954; 
 Fri, 28 Aug 2026 15:07:01 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398aa331ad1sm217427a91.2.2026.08.28.15.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 15:07:01 -0700 (PDT)
Message-ID: <df7496bf-b6ce-4ae2-955f-1233f02988e0@linaro.org>
Date: Fri, 28 Aug 2026 15:06:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 044/105] tests/tcg/alpha: add float reference files
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bibo Mao <maobibo@loongson.cn>,
 Helge Deller <deller@gmx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Laurent Vivier
 <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <20260827221506.91574-45-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827221506.91574-45-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 8/27/26 15:14, Pierrick Bouvier wrote:
> Makefiles were skipping the output compare when such files
> were not available. This results in arch being very inconsistent with
> some providing all files, some providing no files, and some providing
> some files. There was even one case of a misnamed file that result in a
> skipped check.
> 
> For consistency, the current series adds all missing reference files for
> all arch, and make their presence mandatory
> 
> Tested-by: Alex Bennée<alex.bennee@linaro.org>
> Tested-by: Aniket Sahu<asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/alpha/float_convd.ref | 988 ++++++++++++++++++++++++++++++++
>   tests/tcg/alpha/float_convs.ref | 748 ++++++++++++++++++++++++
>   tests/tcg/alpha/float_madds.ref | 768 +++++++++++++++++++++++++
>   3 files changed, 2504 insertions(+)
>   create mode 100644 tests/tcg/alpha/float_convd.ref
>   create mode 100644 tests/tcg/alpha/float_convs.ref
>   create mode 100644 tests/tcg/alpha/float_madds.ref

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

