Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF208D3B7F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 15:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSdCU-0004CZ-A8; Mon, 08 Dec 2025 10:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1vSdCS-0004CK-0B
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:30:56 -0500
Received: from out-188.mta0.migadu.com ([91.218.175.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1vSdCQ-0005YE-5v
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:30:55 -0500
Message-ID: <ff000682-b14d-4152-88b3-cb2761b60bc1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1765207842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJ72RjORRrCJlWt/m7tQsTM9PEMVFTd3MOD3mDJlL8Y=;
 b=aqeqjVUFjXN/Iv5bdc6UxGzGIdRc9V3Qh2UUL8pfs4zWnHTCbGzSmlUqm2y2JE4ZYZy5Fj
 FVaf61rALhhcFmev4+gLI7zUh0Mu7+U7ivtpnfGpWnKIoNXxq1zyySauGiwbt1koeyDpZb
 Howl+HEri2PtIuMgKXZiFGnyAP974pE=
Date: Mon, 8 Dec 2025 23:30:30 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] target/arm: ensure PSCI register updates are flushed
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>
References: <20251205151115.2035930-1-alex.bennee@linaro.org>
 <20251205151115.2035930-3-alex.bennee@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20251205151115.2035930-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.188; envelope-from=zenghui.yu@linux.dev;
 helo=out-188.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi Alex,

On 2025/12/5 23:11, Alex Bennée wrote:
> When we handle a host call we report state back to the caller via
> registers. Set vcpu_dirty to indicate QEMU is currently the reference
> and hoist the flush_cpu_state() and make the call unconditional.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3228
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

This fixes the guest boot issue.

However I notice that some (all?) HMP commands (e.g., "info registers")
don't return and result in guest hang. Haven't dig further though.

Thanks,
Zenghui

