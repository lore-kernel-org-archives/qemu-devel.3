Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77AFC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiOE-000510-Tq; Tue, 15 Jul 2025 12:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ubhmQ-0008OO-N8
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:41:30 -0400
Received: from out-182.mta0.migadu.com ([2001:41d0:1004:224b::b6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ubhmO-0004Ob-Ds
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:41:18 -0400
Message-ID: <ea30d545-d261-4cac-9f8f-c7397cd0560d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1752594062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7V8Cdvs4AuS6U7poaI/O6/VVvQZ9QMea5JWYQfk00y4=;
 b=HlzSM2ETa+bttnsKCFc7uH2GYRt6YHS2lM3lUGNr0iKY3hQzvc0hdmJLy7amdlxZ8b5BMI
 pmusNl7I8MzeXQShNLY/4Rl21VH2zaK3/vdR+7L5ya/q0aQ/+q1pW0T4iLFW4Zxyo7x6IU
 yMQIHsyWcqHYMqZhTZrgxIq0oGknrtk=
Date: Tue, 15 Jul 2025 23:40:49 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] hvf: arm: Add permission check in GIC sysreg
 handlers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, agraf@csgraf.de,
 mads@ynddal.dk, peter.maydell@linaro.org
References: <20250714160139.10404-1-zenghui.yu@linux.dev>
 <20250714160139.10404-2-zenghui.yu@linux.dev>
 <7a34c735-3306-4028-bec9-f34b4271a543@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <7a34c735-3306-4028-bec9-f34b4271a543@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b6;
 envelope-from=zenghui.yu@linux.dev; helo=out-182.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Philippe,

On 2025/7/15 04:04, Philippe Mathieu-Daudé wrote:
> On 14/7/25 18:01, Zenghui Yu wrote:
> > Quoting Peter Maydell:
> >
> > " hvf_sysreg_read_cp() and hvf_sysreg_write_cp() do not check the .access
> >   field of the ARMCPRegInfo to ensure that they forbid writes to registers
> >   that are marked with a .access field that says they're read-only (and
> >   ditto reads to write-only registers). "
> >
> > Before we add more registers in GIC sysreg handlers, let's get it correct
> > by adding the .access checks to hvf_sysreg_read_cp() and
> > hvf_sysreg_write_cp(). With that, a sysreg access with invalid permission
> > will result in an UNDEFINED exception.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> > ---
> >
> > I hard-code the @current_el parameter of cp_access_ok() to 1 because
> >
> > * we only support EL0 and EL1 in HVF, and
> 
> This might change with this work:
> https://lore.kernel.org/qemu-devel/20250620172751.94231-1-philmd@linaro.org/
> and plan to leverage M3/M4 for EL2 support:
> https://developer.apple.com/documentation/hypervisor/hv_vm_config_set_el2_enabled(_:_:)

Thanks for the heads-up! I hadn't noticed that and need to have a
further look at both.

An alternative would be using arm_current_el() as the @current_el [1],
plus a cpu_synchronize_state() before cp_access_ok() to synchronize
env->pstate from HVF. I'm not sure if it works for the new split-accel.

P.S., there is another arm_current_el() (in hvf.c, pmswinc_write()/
pmu_counter_enabled()) for which we haven't called
cpu_synchronize_state() to synchronize env->pstate. Is it wrong?

Probably we can do an overall cpu_synchronize_state() on every "handle
VMEXIT", to fix at least the above issue, which however definitely hurts
the performance.. What do you think?

[1] https://lore.kernel.org/r/d9c8d200-4453-48d7-b14a-8e15a7cf6602@linux.dev

Thanks,
Zenghui

