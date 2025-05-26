Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33ACC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTi5-0000Vs-4B; Mon, 26 May 2025 05:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJTi2-0000Vf-PA
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:01:27 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJTi0-0000DU-Rw
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:01:26 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4c4e6a0ccso1362175f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748250081; x=1748854881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j0nvD2KKz30tpEQ2zu1JMsv6t/6YW7YdzjE02XOtVvU=;
 b=vZUruYvFVD62nR6h2tU2OqzXdSshKOmnPvyiek/U/Ov5sK5ckda0kNQItA3dXiL3JP
 oxTff8rZEjU+CS9CfZKxVsi1AHS3coSI+WR1TsjAOSPDn2QXziMIsWAaiYLjWC4S+Fgf
 +j/Cr9v32d7NfvzZzyxfMbj7RskzL03u5AMwIzEx5NjEYBXBq5S1QGxsMLx+E6K4+TqA
 gF6Pn85fprChyyOIC9qwKJuQVpqa6d5XxRYmpaI/NUc6oGmkkc5VK99vOHKImF7d4cei
 SavSDcT+UsSbUqkqaOaKj96+fLgvjrGc6x7i54niq9pbjoVWM+dNj5vjy02rRgfIABWY
 6AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748250081; x=1748854881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j0nvD2KKz30tpEQ2zu1JMsv6t/6YW7YdzjE02XOtVvU=;
 b=igafMvphFk+/BO/khwGOSXXP3LteBj8EJ7sM6l7Re0AdbnBWMYkpSGLjBGc8wPCshd
 qwdlvW5csou/xzhoZjynbOOyyXP06DGkMK6PDgj7/E2LzK9ABWVEOKE0Zgnw3KiTx9xp
 92hHuCkPcZHZbrV84bSTde+M9scBPlBQvlRjjjvJpfNIUyk9CLoAEs0a7MWaG63VUQ4V
 dPThSSqyyQoCKoXrQUotwGm+n+L8ZYvkXJVZZPABdQGhG0C/Hbw9bAcHVSYnZIKkFZvt
 MrOxVvyRWCLZrxVmA3ePz5TfYhwISxgLq8dts9CCX8vVuPgB9STuPceicQcH2fNwHviV
 FXKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhiESkTEVdJVHfOpbJTB2afk6Fihmc3nsNLQFWP71zP5zZCWE9ey8fFAnFnwYRm3qJ3F2xmjmroHlL@nongnu.org
X-Gm-Message-State: AOJu0YxBLNynSHDNTpLjLWqLylyY66hrx/BEXYZgZZxzhY2sOeTKx2Mg
 3BO2MKRTCDBW1XplhF/LKze+BWlUwmrnfAB/J5SZqLYTHrVRWjos86RwnJQ3sC2oVNNPvHCKbGr
 kCbVgAjw=
X-Gm-Gg: ASbGncu8dsT3VZ9uvo8bjbLS2zYqLgh5hRps61OK6hJa2LwITqBJoJiQDH36xUxJQS+
 Q+dNx/S0/ZntKGSS5hCDnCXRoH5b4m2BA8ZJ6VYLBHMLNn54BWVqnypLECkusIAbUeGc+90aF7F
 FNIsKe2ZC6gU3aRtCDsdwZ6bEx9M/nP2jxOamgxHHSjTUjL4tnZBJTdnV/VPyExxos+Ri7sV0LJ
 i2sDrqQ/mBwY2eW43r4cIaVlO4TJAQuwISmFELLqbJbH7+bqpytNziEIc/r4WwJP9BG4UEd1R/W
 VMKxG4YidoEL1ggLy3B2B2RNwM7rmf/fqc+RScCC7LHxTLYbdc/LCeCGmTYzRgSXhA==
X-Google-Smtp-Source: AGHT+IEMSVu0DsjlYtFSl0L+i8uUevXiYttPTOz3pknqg1iD2OBV3kV7H54Wq9AMAezsjc8cV8iqVg==
X-Received: by 2002:a05:6000:2401:b0:3a4:dd63:4ad2 with SMTP id
 ffacd0b85a97d-3a4dd634c14mr894756f8f.37.1748250081505; 
 Mon, 26 May 2025 02:01:21 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4dc7e69c8sm1157748f8f.95.2025.05.26.02.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:01:20 -0700 (PDT)
Message-ID: <d90dd6ad-71c7-4720-a07f-8504f7fdfece@linaro.org>
Date: Mon, 26 May 2025 10:01:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/25] target/alpha: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
References: <cover.1747666625.git.neither@nut.email>
 <a5ec8863418a946530d167677184d40319470af2.1747666625.git.neither@nut.email>
 <f140b06d-53c7-4d32-ab95-1327d2659a37@linaro.org>
 <3626834acffdaf2f6f2504c1dbb2c457601964f2@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3626834acffdaf2f6f2504c1dbb2c457601964f2@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

On 5/25/25 21:16, Julian Ganz wrote:
> Hi Richard,
> 
> May 25, 2025 at 2:14 PM, Richard Henderson wrote:
>> Having read the whole series now, I think it would be better to change the TCGCPUOps.do_interrupt interface.
>>
>> Instead of having each target call qemu_plugin_*, instead have each do_interrupt return the discontinuity type, or 0 if the interrupt is blocked so no state change.
>>
>> Change to cpu_handle_exception would be of the form:
>>
>>   if (qemu_plugin_discon_enabled(cpu)) {
>>   vaddr from = tcg_ops->get_pc(cpu);
>>   unsigned ev = tcg_ops->do_interrupt(cpu);
>>   if (ev) {
>>   qemu_plugin_vcpu_discon_cb(cpu, ev, from);
>>   }
>>   } else {
>>   tcg_ops->do_interrupt(cpu);
>>   }
> 
> Personally, I'd be in favour of that. However, I do see some obstacles
> to that.
> 
> Quite a few targets to call their do_interrupt function internally,
> usually from their exec_interrupt. We would then handle that function's
> return value at the call site?

Yes, I think we'd alter the return value of exec_interrupt to match do_interrupt.
There's a comment about exec_interrupt may longjmp away, but that *appears* to be 
historical.  I couldn't identify an existing target that does that.

> Also, some targets such as tricore only have a dummy/stub do_interrupt
> and handle exceptions differently inside non-returning functions. For
> those, we would call the hooks directly from there as we do now?

It may be only tricore.  And you're right, it would be a non-trivial reorg to make tricore 
fall in line with other implementations.  So retaining the separate 
qemu_plugin_vcpu_exception_cb will be required in the short term.


> And then we have some targets that deviate in some other way. For
> example, s390x_cpu_do_interrupt effectively contains a loop, and we
> potentially need to call one of the hooks for each iteration.

That is distinctly odd.  I don't understand what's going on there.

David, can you elucidate re ce204cba74b?  Is this intending to stack all outstanding 
interrupts all at once, leaving the highest priority, then return-from-interrupt processes 
the lower priorities?  It's definitely unusual, but most things about s390x are...  :-)


r~

