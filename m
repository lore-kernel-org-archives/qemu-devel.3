Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BAAC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyzb-000365-Im; Tue, 25 Aug 2026 17:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyyzZ-00035x-Rj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:47:37 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyyzY-0006Yw-BT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:47:37 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38e7109321dso274245a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787694455; x=1788299255; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sxtVCHWFpHnseObQwOJhKDNK6mUOFq/n3jc5JdIVc3U=;
 b=M06pfLZD7ktbx+LJc7Yebd6gVUYy0ELoIIIZM5fHOdxkDLNURigsFc7uLeMyM0ck0k
 xVhghESsdWr4NEEv0lLDZSu7V5DOmWsL1rltk+zIUgXBlYkFDSOz9F6x/X7n6mUcpTJc
 dqrtu5cH3YdB3/sl6qKJz2BWu/ZIloVCXL4rVrusB0XeQVKMwCXTH24fjfCV5w/i20QX
 pesWEAZ8BODZTPe1gPJCh2NU5gKgWzHK9v1TAiYpaIduomOgkNIt7PnaxKMocC6/OC5A
 3XPUeRXYzDfb8JCiYKrvYjQQQ2F9OdHSn5f4CxEMKPr32r4h+17wN23QJ/3hPSv5LktX
 s4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787694455; x=1788299255;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sxtVCHWFpHnseObQwOJhKDNK6mUOFq/n3jc5JdIVc3U=;
 b=dBQFxDDmBloZNWRKR0ZiF05tGBVUubmfuLr+uHMraiXWHRx3hAO/A4/PZzKwbe5/OD
 pXfmLF3ont3fgzigVaKqU2DzgesJLEadvEFfBl81Y/DYqXSXVfzpVTNLEzIQ368pZARW
 k9hV7Y1B56op43pLLwC3nbX3PkhXnrxnLgwVsjWgp/Qxxt/OM/WONAxe/SQWmMwGAaLw
 KkbnHA1uuMREiAvmcaiDF5mPjG5zWgsrwjXdMW0hEQhdDzNoGhfA4wr3mcnND3xpGIC8
 z7x6I3Pimwe9yb9TV/NV2/RgEQYITlnb/8Tq3dsMjmxo1/nVSEqQdNSfqtb4vQ7pqiUv
 SHtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2YVJuzclFwCqzaCq3LNk658TIoEd978xoLhbwHlbEIVPTLTrz2Sv0hOVPj2ahSNHMVqN6Rlyw+Dl0@nongnu.org
X-Gm-Message-State: AFuF++msCcV6C/g10yLQ2y/9MXgCTuXBbtQ5v88Rn9AEGLKFP2wlXi+L
 k8v6N4ryLFW0V7GtIycVzNxOFTU7Hu2pNDP6zBIuy9q/WQvpCGs7JnKKNzic++EGlYA=
X-Gm-Gg: AR+sD13643wPKOoBneAkrNVliLb5trJdAtgUsuleO86MEu85dPteQLcbUFeROEuyf3n
 /Onjk384GOY62rwxKRKo4XZ0nezJ1M26+nfBCHETpBpntZsm5vmhwjOkHo34pZGdv6yXGe94jYd
 Hutif1FT02F60tCmWlxgZRBXSokGrg7TEZfpAyotEeWyXf/yOO547l0bBOi7FaO1IMgt4krasgy
 2ZLVAD/hwnsok1tEMLvLhxFbszRpqWXtqmWw9dpyBMip359Xoe+RmsRA3yQ79JyPNenMHPrYj8B
 w+1ZMw1s4fX+2K+8p+bI72dsPVI3KZ0MN7AU1bJzbT3iQLkfU0/ywi42hpohQXEySqT+yMN/mHq
 9JT+QBvVd3N/11CN65b/QDWg0HyaRLyJCUa3ptuSCWgCI2ausy4s+VoyIZG/4ihfkvICF5+iIMS
 zflYyUuoDfJt38FKHhBSMbLpjXOaM0V6nEGnBPu8CWGJDtflCcWweJyMmFSsHHr0zQmyyiDGdY+
 oaIxrkdsulOlGUdD3i7cJZbFFzj9sI/mIIShIs=
X-Received: by 2002:a17:90b:3f88:b0:395:f0e8:9e13 with SMTP id
 98e67ed59e1d1-3966d207838mr4456810a91.7.1787694454614; 
 Tue, 25 Aug 2026 14:47:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a5832bsm1252226a91.15.2026.08.25.14.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:47:34 -0700 (PDT)
Message-ID: <b847a616-5d7b-484c-8065-655d33c63c13@linaro.org>
Date: Tue, 25 Aug 2026 14:47:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] accel/tcg: fold the dynamic cflags into
 CPUState::tcg_cflags
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@oss.qualcomm.com, alex.bennee@linaro.org,
 zhao1.liu@intel.com
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260822190818.1829249-2-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260822190818.1829249-2-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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


On 8/22/26 12:08, Matt Turner wrote:
> diff --git ./accel/tcg/tcg-all.c ./accel/tcg/tcg-all.c
> index 7186c10cf0..c9874a286a 100644
> --- ./accel/tcg/tcg-all.c
> +++ ./accel/tcg/tcg-all.c
> @@ -254,6 +254,7 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool value, Error **errp)
>       s->one_insn_per_tb = value;
>       /* Set the global also: this changes the behaviour */
>       qatomic_set(&one_insn_per_tb, value);
> +    tcg_update_all_cflags();
>   }
...
> diff --git ./util/log.c ./util/log.c
> index 7cffbc1bf8..3fa46a67fa 100644
> --- ./util/log.c
> +++ ./util/log.c
> @@ -27,6 +27,7 @@
>   #include "qemu/thread.h"
>   #include "qemu/lockable.h"
>   #include "qemu/rcu.h"
> +#include "system/tcg.h"
>   #ifdef CONFIG_LINUX
>   #include <sys/syscall.h>
>   #endif
> @@ -301,6 +302,9 @@ static bool qemu_set_log_internal(const char *filename, bool changed_name,
>   #endif
>       qemu_loglevel = log_flags;
>   
> +    /* CPU_LOG_TB_NOCHAIN feeds into the per-CPU cflags. */
> +    tcg_update_all_cflags();

I'm not keen on these placements.  I know they're needed for HMP, but 
I'd rather have these calls in HMP, after updating state.

> +void tcg_update_cflags(CPUState *cpu)
> +{
> +}
> +
Where does this get used outside of tcg itself?  I think only 
tcg_update_all_cflags() should be stubbed, and indeed the only one 
visible outside of accel/tcg/.

Phil, is the stub itself better placed in accel/stubs/ or accel/tcg/?  
I'm unsure what organization you're working toward.


r~


