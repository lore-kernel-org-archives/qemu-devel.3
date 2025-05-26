Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC81C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 10:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUhR-0003K5-Fi; Mon, 26 May 2025 06:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJUhL-0003Je-4d
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:04:49 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uJUhJ-0008V9-7C
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:04:46 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 50AC9180240
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 12:04:42 +0200 (CEST)
Received: (qmail 6370 invoked by uid 990); 26 May 2025 10:04:42 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 26 May 2025 12:04:42 +0200
From: Julian Ganz <neither@nut.email>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Julian Ganz <neither@nut.email>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5 15/25] target/ppc: call plugin trap callbacks
Date: Mon, 26 May 2025 12:04:32 +0200
Message-ID: <20250526100434.140715-1-neither@nut.email>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8879f07b-7d4b-4013-b798-a59d6a69bb48@linaro.org>
References: <cover.1747666625.git.neither@nut.email>
 <bc32d3f37c3e8d33e7f1c4f0d08b858d934f1ecf.1747666625.git.neither@nut.email>
 <8879f07b-7d4b-4013-b798-a59d6a69bb48@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-0.250626) MIME_GOOD(-0.1)
X-Rspamd-Score: 0.649373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=L9cYxMQEcBKvIk7TTralNnFUYqOHlx13RG1PHZiLQRQ=;
 b=m0autTUuqFQZBWxA4gaTFp2aZxS0PWm44ozuiU+Ws6vbIGUMKM2KnoxaOpFm0PpWjo9GNHqsan
 rBj5hgMUMPyATOAsUZsThoqGYdqfD1Uy7zmGJtF+ypqwzh9cowZMxzz/GSOFdujyzHm9jGPM4W0R
 ulHo3yxPcZUe5v1gcrcmeS7+4+Ts7chIOLbnzToesriX2d/KJnMwK7qIFDX16Vc21PqCHAUHzabv
 OXQcFuNGbTx3kwHQBMHiuPll5vU9yqjORaxlksWWaULaEJyrBwTQKH6aJsEQ3tFqAuaXs2wdyj8l
 1yDdf61zAvpgSAl13SsJYAC18ZwryW+yA6dmM0Ft0yQp/e7VXcaurqumMoKMPbF+jcZKu36OBUIt
 7Y5TyC3v+8Wve0FUU/r/c3W0ZiKQdPpPixrHMEhCfqGAng6oANBTz8HI28zJWN/aabqmvHbG9fT8
 8jzo2cmxFjbq6jhvPQL+Ul8soEpXIM+37F/7o5usdqT5JiTIt/gHARnh/v1WTFjX1Z7L1QByDP/S
 k+apmkXK42zNWKY+BPQH6gt2f55RcJx/tQAp69EpC3rrbMWJV8Y8zGC1Zw2p48D7t5ujl/L8kemt
 cXevZs3glZD6lHyPAgM3EAtjzGacLU7JOvrGoX6losTH8wqQ5GjbBga/6byaON0a8UEGJlQE61Ze
 8=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Richard,

sorry for the late reply to this mail in particular. I needed my memory to be
refreshed.

On 5/19/25 16:19, Julian Ganz wrote:
> > @@ -758,6 +787,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
> >           if (lev == 1 && cpu->vhyp) {
> >               cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
> >               powerpc_reset_excp_state(cpu);
> > +            qemu_plugin_vcpu_hostcall_cb(env_cpu(env), last_pc);
> 
> Err... I think you need to be more specific about what you mean by "hostcall".  Certainly 
> this isn't the same thing as semihosting.

We count as a hostcall anything that is handled by code which execution is not
visible to plugins through the exec_insn callbacks. I believe that this is the
case hee, but I might be wrong.

Regards,
Julian

