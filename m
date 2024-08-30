Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54101CA100B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4WT-0005jz-W5; Fri, 30 Aug 2024 12:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4WQ-0005dD-3e
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:30:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4WN-0005UM-Qh
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:30:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-715cdc7a153so1579069b3a.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725035446; x=1725640246;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=irIRIMibZFJgz5jFRj1jah4+4BIJ9nqhnIXQObmlA2o=;
 b=heONaPFk1+4L0SBgPU0BYCjbiW1xp8FstX97eHvWEvgLOyvdlhWJSk+k/dKpmdnpQF
 IcUW80SDdLkZTVKwUaPuLeKgNU97/QQRvoLc/VP2ab+YBivFEA/DGHBSuUSVNmgPYeqH
 hLmQxg+6M6BUHpSBLayo/IRr3YVWpHgAEsrT0lccbrMwsx3h1KOhm4ah3+4ZD0pwUkrC
 N4In+X+DMIre0ym2cZBJBxoIRMrPFTGlLvcj+8KCsoGzZbYShXbDIgAtqbFDIXe/2uJf
 6q9wEkV+WwuJZDsRJEW0Q7yTfbOxKyQ22nC+WpSiNykZfoI3DgsJa100PFYENJAdEfB+
 DFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725035446; x=1725640246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irIRIMibZFJgz5jFRj1jah4+4BIJ9nqhnIXQObmlA2o=;
 b=gAIeVrDWaI/CDR4WBQtlF/FV+x30/zdq3WLxI4k7S2V3tLjvX87a+cS7H/nCdlUHzt
 Ow0Y3knPds40mpUkDYs+DpJmuATA+ibzTZ+Bdt0BCtFC4yi4eo6Ld7TCh/Ue5EzX1D1S
 ZqKU8w7fkpCf4VBAV75ZDKrFyM8S9UpkXYtz61xJbyb3lTaVa3QRBs6wyQ15zmPqtx1j
 0inZLI9FggMsMxg2WTkWzJaTOEUpgqFczopJ/uvImXgnRg2iehe34KGO20KwJUI6Lodj
 9gD9IG+SxlqbOuJOpfL9gtXgd4v0AqISmElMWNWQG/mH6cM3Q/pwQhcl/t1Xff229zTv
 wjHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtS6syMaNotnABDANSDy14hrIiCEFMGW69MXabaS9kZf92fwpFKwmsdHJ//mhGuQNzFGr4Nivs6MfH@nongnu.org
X-Gm-Message-State: AOJu0YxYkJBa4OtioqVOO6bCqYX0dy1yqQ9xOoNCi4cmDUrb5W7TB63q
 n+qJhZVLfOoGFFImvg3IwV4omdOfxfA1iQXVfsp0FCL5OEQFCGqCxaCRAOmv7ec=
X-Google-Smtp-Source: AGHT+IEfqnvnRURV+722FqXtpQe7pinhg+iyvTuKcHzTIqWV9jKyQK/inBGNtOGD0OepRvxRt00hgw==
X-Received: by 2002:a05:6a00:1798:b0:70d:32bf:aa45 with SMTP id
 d2e1a72fcca58-7170a85b988mr4058144b3a.14.1725035445549; 
 Fri, 30 Aug 2024 09:30:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e56d72d1sm3054975b3a.170.2024.08.30.09.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:30:45 -0700 (PDT)
Date: Fri, 30 Aug 2024 09:30:43 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v12 11/20] target/riscv: introduce ssp and enabling
 controls for zicfiss
Message-ID: <ZtHzs6HbcKTC9z/9@debug.ba.rivosinc.com>
References: <20240829233425.1005029-1-debug@rivosinc.com>
 <20240829233425.1005029-12-debug@rivosinc.com>
 <abc033ff-7638-4d2d-b2d7-65b3c88311e8@linaro.org>
 <ZtFfGR94f5EwIl90@debug.ba.rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZtFfGR94f5EwIl90@debug.ba.rivosinc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 29, 2024 at 10:56:41PM -0700, Deepak Gupta wrote:
>On Fri, Aug 30, 2024 at 03:20:04PM +1000, Richard Henderson wrote:
>>On 8/30/24 09:34, Deepak Gupta wrote:
>>>+bool cpu_get_bcfien(CPURISCVState *env)
>>
>>It occurs to me that a better name would be "cpu_get_sspen".
>>The backward cfi is merely a consequence of the shadow stack.

On a second thought, I would like to keep to keep `cpu_get_bcfien`
We use this helper in `cpu_get_tb_cpu_state`, `get_physical_address`
and `cfi_ss`. In 2 out of 3 functions, intent is to check whether backcfi
is enabled or not and based on set TB state or perform appropriate page
table walk. Only in case of whether access to ssp is allowed or not
(i.e. `cfi_ss`), intent is sspen or not.

Let me know if you feel strongly against it.

>
>Want me to change cpu_get_fcfien as well to cpu_get_lpen ?
>
>>
>>>+{
>>>+    /* no cfi extension, return false */
>>>+    if (!env_archcpu(env)->cfg.ext_zicfiss) {
>>>+        return false;
>>>+    }
>>>+
>>>+    switch (env->priv) {
>>>+    case PRV_U:
>>>+        if (riscv_has_ext(env, RVS)) {
>>>+            return env->senvcfg & SENVCFG_SSE;
>>>+        }
>>>+        return env->menvcfg & MENVCFG_SSE;
>>>+#ifndef CONFIG_USER_ONLY
>>>+    case PRV_S:
>>>+        if (env->virt_enabled) {
>>>+            return env->henvcfg & HENVCFG_SSE;
>>>+        }
>>>+        return env->menvcfg & MENVCFG_SSE;
>>>+    case PRV_M: /* M-mode shadow stack is always on if hart implements */
>>>+        return true;

