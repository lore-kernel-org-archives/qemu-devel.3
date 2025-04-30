Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ECBC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAB67-0002Jq-Ij; Wed, 30 Apr 2025 13:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB66-0002Jf-P9
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:19:50 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB65-0005Na-28
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:19:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22401f4d35aso796555ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746033587; x=1746638387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jCb/vbCI9zcbwHG1Z90zVN69PE5OMV4CHJVzN8WJG9s=;
 b=WViZyP6x/NF1HMsE4E7MWHpkOM6SgcG3hswCBiiNNwka0B0qlJZosW/N3s233D6hDj
 Wh8CESnPvBZHD8WobatScG03iZO2s9NHFpjA9b6S/g9+lLLPYkCIKPP6+s4CnMaDT5sn
 SCrQ+r+HtWZCDeyqvndyVE5Si3qUqDC9gAAdjZhdRlkT7wQaaJY3K6MpOqR+PVzqEmym
 j3rZuocs4sMYyai8EMXMP3aCMKjzkHUKPCjS5FAEKhtILPkeO3pvxO8dVEkOvgOMoyA2
 BKkd8hl+ybFPrpH0q35aZJOkfWddw+baq011BPVCs4kups3xfoPPFeI4OreI8i8LAya+
 Ao1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746033587; x=1746638387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jCb/vbCI9zcbwHG1Z90zVN69PE5OMV4CHJVzN8WJG9s=;
 b=HD341GvyGKjpxi0cbgbh4rO5tvWKzXKGKGgB2Ss8/vhBwaO5q2Fm7F4rUzPvyLBUeS
 RiKcyu/7PxIy3h8Ic+vJQ3rWKHwsaQv9TN4nAu4OKCJ/+CyksuSZTfgU+AfruWWX4TT4
 wD3MgxHG/35mLOT1D5/Wy9r9aOvklP0UmqbljjvmKHn09oRm1EWISddNo5muUqF6lfLC
 npgtzSSoYAAE51wv3OyPSjVZt+255MLJMI61Y9ESjnWybCF06H0kksEdc2Su0apMByXd
 Gl96Jd3ZrpDAgsuOhRP9ygi0cR2wamWjJPVEg3VRFHqtOQXUZh0ziExHyK4Jrc1lQiwf
 vZqg==
X-Gm-Message-State: AOJu0Yx4qbOlhmlXkNmQK/++VNzgUkyXkVCw/Z+FsVk1jy2x2yXfjOIQ
 EzGyKZZgZknbYT6NIwPCQcKkPqnErITSOmgK7vkf3Ti0J90JQVk5UwSj8FK/wkfmkXo7sCWU/eO
 N
X-Gm-Gg: ASbGncvpMM3fgTG7unf50r+P5h5azGbIHtJzCEKrik2xkXIbCj3anM7TLAHdQkzy6QO
 WJ+nrMrnnKpgr6cDzK1z9eU0q93qdgwWx17mPNganwGfJ+V0QhxOz9CPzxXESxKYgZl83NdF1ql
 FkELiA5LICz9CKMpUG1pnjKGNHHvyiJm/3jo6qc+UN7dilTW4gAml1j4o9jzbrPKf3IgZsowVWN
 BF44+FTbbaQ+CaMgp1JXeujNjS9jWVzSfDtfwpAHTxEIN+r0Vgl3muIrF6HThfPhftnaeZ5HUd1
 FQwKInt5ELm/+P109+K1ugrBNIRX2veeM3sOhyl0GILvWKKiiNsnHZBnHs0jQv3ELgRQBPVfJ5+
 wOfJTRM8=
X-Google-Smtp-Source: AGHT+IH4eGa/J7nyNlSn5MfeZeHhzzAJB4abOW8Jrf5gCIex8qDid1sA6LjhIWL/SE7AjU+YTVe/cQ==
X-Received: by 2002:a17:902:d486:b0:220:ce37:e31f with SMTP id
 d9443c01a7336-22df34d5f5fmr65081075ad.17.1746033587250; 
 Wed, 30 Apr 2025 10:19:47 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76ce1sm125280455ad.40.2025.04.30.10.19.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 10:19:46 -0700 (PDT)
Message-ID: <dbc5dd8b-0bd9-48d6-8b0e-d9b3b6892a1e@linaro.org>
Date: Wed, 30 Apr 2025 10:19:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] hw/core/cpu-common: Don't init gdbstub until
 cpu_exec_realizefn()
To: qemu-devel@nongnu.org
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250429132200.605611-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/29/25 06:21, Peter Maydell wrote:
> Currently we call gdb_init_cpu() in cpu_common_initfn(), which is
> very early in the CPU object's init->realize creation sequence.  In
> particular this happens before the architecture-specific subclass's
> init fn has even run.  This means that gdb_init_cpu() can only do
> things that depend strictly on the class, not on the object, because
> the CPUState* that it is passed is currently half-initialized.
> 
> In commit a1f728ecc90cf6c6 we accidentally broke this rule, by adding
> a call to the gdb_get_core_xml_file method which takes the CPUState.
> At the moment we get away with this because the only implementation
> doesn't actually look at the pointer it is passed.  However the whole
> reason we created that method was so that we could make the "which
> XML file?" decision based on a property of the CPU object, and we
> currently can't change the Arm implementation of the method to do
> what we want without causing wrong behaviour or a crash.
> 
> The ordering restrictions here are:
>   * we must call gdb_init_cpu before:
>     - any call to gdb_register_coprocessor()
>     - any use of the gdb_num_regs field (this is only used
>       in code that's about to call gdb_register_coprocessor()
>       and wants to know the first register number of the
>       set of registers it's about to add)
>   * we must call gdb_init_cpu after CPU properties have been
>     set, which is to say somewhere in realize
> 
> The function cpu_exec_realizefn() meets both of these requirements,
> as it is called by the architecture-specific CPU realize function
> early in realize, before any calls ot gdb_register_coprocessor().
> Move the gdb_init_cpu() call to there.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/core/cpu-common.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

