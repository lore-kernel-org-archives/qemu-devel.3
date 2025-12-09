Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00984D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 00:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSlzu-0002ME-JS; Mon, 08 Dec 2025 19:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1vSlzs-0002LW-G5
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:54:32 -0500
Received: from out-186.mta0.migadu.com ([2001:41d0:1004:224b::ba])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1vSlzp-0001oh-J2
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 19:54:32 -0500
Message-ID: <0c2f64fa-a635-4593-8631-12a40af4a79b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1765241666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+X08zZVuu9xwIY2BZW1KSVandt935dGEKHaAn+7km4=;
 b=G937yI1S8co2hEc7VyQfgFDGo4cp5TX776y429+I4Wp178opFfFrjdkXW25QXhwetFFWoW
 gTQae+79rlfM7Dl1wOdQd6m98rIAovmKx4g+9wA4/Ht8c7DUhn1rO8MxhWUPOs8INOphSP
 TQ7at5BbdFnYVIJrHsX6TjakCnOa7RQ=
Date: Tue, 9 Dec 2025 08:54:19 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] target/arm: ensure PSCI register updates are flushed
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
References: <20251205151115.2035930-1-alex.bennee@linaro.org>
 <20251205151115.2035930-3-alex.bennee@linaro.org>
 <ff000682-b14d-4152-88b3-cb2761b60bc1@linux.dev>
 <87zf7shped.fsf@draig.linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <87zf7shped.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::ba;
 envelope-from=zenghui.yu@linux.dev; helo=out-186.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 2025/12/9 01:08, Alex Bennée wrote:
> Zenghui Yu <zenghui.yu@linux.dev> writes:
> 
> > Hi Alex,
> >
> > On 2025/12/5 23:11, Alex Bennée wrote:
> > > When we handle a host call we report state back to the caller via
> > > registers. Set vcpu_dirty to indicate QEMU is currently the reference
> > > and hoist the flush_cpu_state() and make the call unconditional.
> > >
> > > Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3228
> > > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >
> > This fixes the guest boot issue.
> >
> > However I notice that some (all?) HMP commands (e.g., "info registers")
> > don't return and result in guest hang. Haven't dig further though.
> 
> Does this fix it:
> 
> --8<---------------cut here---------------start------------->8---
> target/arm: make HV_EXIT_REASON_CANCELED leave main loop
> 
> Without this we can spin tightly in the main HVF dispatch loop and
> never release the lock long enough.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> 1 file changed, 1 insertion(+)
>  target/arm/hvf/hvf.c | 1 +
> 
> modified    target/arm/hvf/hvf.c
> @@ -2020,6 +2020,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
>          break;
>      case HV_EXIT_REASON_CANCELED:
>          /* we got kicked, no exit to process */
> +        ret = -1;
>          break;
>      default:
>          g_assert_not_reached();
> --8<---------------cut here---------------end--------------->8---

Yes it works. Please feel free to add

Tested-by: Zenghui Yu <zenghui.yu@linux.dev>

on it and patch #2. Thanks for the fixes!

Zenghui

