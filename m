Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D3DCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJGz-0005HA-Re; Tue, 21 Oct 2025 16:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGe-0004wE-AO
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGZ-00014v-TU
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso51270725e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079652; x=1761684452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bbj4DnU9UMuayjGZMJyam2c15BZ4ZqrND3uomWVqkE8=;
 b=Ply08PmbEkZYScdrfHz2Oon/EMjCnz0pMY4fPpdq1MGfTaIjhrLtKupT8EEaEAqsfo
 K9tf/EG8Svo5EI9Wp5ORv4gp6qFxjMqMJwDg9Es8ov4wQKbcN0sw0khuw7n2PeFwQSF3
 /2GL9pxibxSGMLg6d4ETrznWXwJPl6wu14SAvoq8C8/qFU2EyVk7UFbOEzGU1hUPV/Kk
 ZfLiYrZXzqWG5vX1dAqwLayei+G+ZwwYcPlbSTMyHezmX+wyWTJTstlogz+5CqmqvWmg
 POLeyEO+FEMmwF4eHdyUJj0Sx1rsrh3407IsLlGRxnQDLx3WsMY/QFl7d9ENd0jwFBYD
 lYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079652; x=1761684452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bbj4DnU9UMuayjGZMJyam2c15BZ4ZqrND3uomWVqkE8=;
 b=kJyId4/sum9FGRgwWBLx96nsfSAybq1OL6vZAxvVy8G1QKq3srW2kLac7pnXhdt5+M
 A5GqXQIa/dzHRPF8YlDA69fKiBR93tVvltnGiLDtNaAtH/YU1toripm7/Hc8KrXb1Ohv
 WpR4DUIZIemDzzV9IftNyZvRS+1fMOQwESS6loBOsCI7IqMGme76hZ5xgcu0JdoXxV2r
 B/2xObj24Og4gItrQk9tIAr218geRJie8YJh6XwwfXnOnqQ65aV2Wy5DwyQTPpNmKnxa
 4F16RCLHLNyYE28PGfGYO0N3cyp5CMCm3ayuOCm7us7eIlZ3M0JY1JGFoJLal1eCdzQG
 wGFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkvUA5wFvLtyq9oLinMswwa96HMhpYW4W9zeqyEMRDTY05j+EuI4efmwFKVl4vxI1HzDRm6gw480vN@nongnu.org
X-Gm-Message-State: AOJu0Yzb/oZHQN6543NMCygmXELYvRI6aHfkCqVYMj3JGZ0vT7KgbBf9
 ILFWbdgKMmm4gPq7VFB49b3ViarRn012f7FMGcPFB4YpKHe+jMr5QQyDY/KMJLPUZ4w7l7JBGL3
 ig2qvN+M=
X-Gm-Gg: ASbGncuTJX1V/ZcbbqkPAw9KEh28owAA16VJ+Vl+lYqZRXqFFA55rosMNoTYlFq/6ei
 S5KEZzhncHGJAdKSBtGb7WOX9rSwz5I3s9vtNHIXhs8HCNvgphLh5i4iQLmZHWhcJ+XNpwCr9/Q
 PhuX+7UAumtLd/X++TE+GrSv4ubYZyj2wAuFNWphKC34A/cBil0hlT6a3SMBXFPBvsDM9tamrTj
 tdAYxsWGYkB2cxK8HZEh6p0B5BHwUN4iP7sVhfsCLh3rNS0viUdyL1y1b7zaSx1GrC/1tFPvUo+
 z/lIZ7BJWKHV3Dioai5QjvNCOkq5ORvp9RzotJaf7291V+dfFU5YmdTSeVWrE53DWZiO96DGejZ
 hNelGWSkJaJmQNwBqcSR/YO4umptNGCSe3FE9+R3P08KWWMPbSpEwfsMuPb/ZEQ4G+hnQ1NjEkF
 UWIzmRP2edhUs5uZ58qujPw7oxTLjyZbwErYeZJtCvl5Ihtxo1OO64CQ==
X-Google-Smtp-Source: AGHT+IG+mCw6CFnC9+i5Zw9JMUhd4HTOjLTt1QfZ7Vbl7xNLvhfutdApr28Hi2ofRzqrxb+leeVItw==
X-Received: by 2002:a05:600c:5299:b0:470:ff87:6c2d with SMTP id
 5b1f17b1804b1-4711791781fmr146572925e9.29.1761079652358; 
 Tue, 21 Oct 2025 13:47:32 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496b09bc4sm24261565e9.2.2025.10.21.13.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 13:47:31 -0700 (PDT)
Message-ID: <8fdacbaf-f760-41b1-9313-fbe8d9c66a4a@linaro.org>
Date: Tue, 21 Oct 2025 22:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/25] target/alpha: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <cover.1760884672.git.neither@nut.email>
 <78ba254c812a91105bf52f6f0ce73774ee2be265.1760884672.git.neither@nut.email>
 <2a0a4cde-1427-4d87-a331-f4ed6fa64aa2@linaro.org>
 <20bf0927d2331f70d92048726362558d78caa4a8@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20bf0927d2331f70d92048726362558d78caa4a8@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 21/10/25 22:38, Julian Ganz wrote:
> Hi Philippe,
> 
> October 21, 2025 at 10:10 PM, "Philippe Mathieu-Daudé" wrote:
>> On 19/10/25 17:14, Julian Ganz wrote:
>>> We recently introduced API for registering callbacks for trap related
>>>   events as well as the corresponding hook functions. Due to differences
>>>   between architectures, the latter need to be called from target specific
>>>   code.
>>>   This change places hooks for Alpha targets.
>>>   Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>   Signed-off-by: Julian Ganz <neither@nut.email>
>>>   ---
>>>   target/alpha/helper.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>   diff --git a/target/alpha/helper.c b/target/alpha/helper.c
>>>   index 096eac3445..a9af52a928 100644
>>>   --- a/target/alpha/helper.c
>>>   +++ b/target/alpha/helper.c
>>>   @@ -27,6 +27,7 @@
>>>   #include "exec/helper-proto.h"
>>>   #include "qemu/qemu-print.h"
>>>   #include "system/memory.h"
>>>   +#include "qemu/plugin.h"
>>>   > > #define CONVERT_BIT(X, SRC, DST) \
>>>   @@ -328,6 +329,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>>>   {
>>>   CPUAlphaState *env = cpu_env(cs);
>>>   int i = cs->exception_index;
>>>   + uint64_t last_pc = env->pc;
>>>   > if (qemu_loglevel_mask(CPU_LOG_INT)) {
>>>   static int count;
>>>   @@ -431,6 +433,17 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>>>   > /* Switch to PALmode. */
>>>   env->flags |= ENV_FLAG_PAL_MODE;
>>>   +
>>>   + switch (i) {
>>>   + case EXCP_SMP_INTERRUPT:
>>>   + case EXCP_CLK_INTERRUPT:
>>>   + case EXCP_DEV_INTERRUPT:
>>>   + qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>>>   + break;
>>>   + default:
>>>   + qemu_plugin_vcpu_exception_cb(cs, last_pc);
>>>   + break;
>>>
>> Shouldn't we handle EXCP_CALL_PAL with qemu_plugin_vcpu_hostcall_cb()?
> 
> Host calls are exclusively calls that are handled outside the emulation,
> on the host, regardless of whether they are hypervisor calls or not. In
> that respect EXCP_CALL_PAL looks to me like a regular exception that is
> handled by translated code within the emulation.

OK, thanks.

