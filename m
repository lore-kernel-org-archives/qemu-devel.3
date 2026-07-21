Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCBBC44515
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 01:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlytU-0006JV-GH; Mon, 20 Jul 2026 21:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wlytL-0006G7-WF; Mon, 20 Jul 2026 21:03:28 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wlytK-00030V-EP; Mon, 20 Jul 2026 21:03:27 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C750D60A7A;
 Tue, 21 Jul 2026 01:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A361F000E9;
 Tue, 21 Jul 2026 01:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784595804;
 bh=/FnRMWymWQwCjna3n73N0UF7ENHmWL4PVz9Vqok9cHw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cF8+kISXOpw3Ni3rT/FJ0A3X2lJbG34catzjacQ9bOcImELNZNs8ULOWzYFxiCHN2
 k7mtp1rw6x7vzQVkPhzCU8pdH2Pbo8I31f+fA3TZ5DQNXdddVczRD/NfuO+w6u8HWN
 YLYE6bheZIyM8etBlJGCXaIlQuT6wzWFOeOGsnT5ZAfmEnYYUeK2nLLtM6/O6cUaxd
 O8yWJWOUTckbELbCpc3jLi30KnFJYih4aYi+OOkuGA3ZUrJx999v9BILiY8Kmi0YsN
 6y/V8HGUUrjuL1Ogj6OJGMzFFt/3TIpMz/ZfNyrqdZBn2vUnV2lVK4wzKo8OiH7Q93
 JaSIRLuCAN+mg==
Date: Tue, 21 Jul 2026 02:03:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 1/6] hw/cxl: fix timer leak in cxl_destroy_cci()
Message-ID: <20260721020320.4545bd3a@jic23-huawei>
In-Reply-To: <20260626062149.1844334-2-junjie.cao@intel.com>
References: <20260626062149.1844334-1-junjie.cao@intel.com>
 <20260626062149.1844334-2-junjie.cao@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 26 Jun 2026 14:21:44 +0800
Junjie Cao <junjie.cao@intel.com> wrote:

> cxl_init_cci() allocates a QEMUTimer via timer_new_ms() but
> cxl_destroy_cci() never frees it.  This leaks a timer object on every
> device exit path and, more critically, on every device reset cycle since
> the secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) are destroyed
> and re-initialized each time ct3d_reset() runs.
> 
> Free the timer with timer_free(), which cancels any pending expiry via
> timer_del() internally and tolerates a NULL pointer, then clear the
> field so that a repeated timer_free() on the same CCI is a safe no-op.
> (The function as a whole is not idempotent: it also calls
> qemu_mutex_destroy(), which asserts on an already-destroyed mutex.
> Callers must not invoke cxl_destroy_cci() twice; the .initialized guard
> added in the next patch enforces that.)
> 
> Fixes: 98cbac128f1c ("hw/cxl: Support aborting background commands")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Hi. Sorry for delay on catching up with these.

One minor thing inline - otherwise looks good to me.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 20e0b7e476..18a455e89c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -4770,6 +4770,8 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>  
>  void cxl_destroy_cci(CXLCCI *cci)
>  {
> +    timer_free(cci->bg.timer);
> +    cci->bg.timer = NULL;
Can we do this in reverse of the cxl_init_cci() ordering?   That would
put these after the qemu_mutex_destroy()

>      qemu_mutex_destroy(&cci->bg.lock);
>      cci->initialized = false;
>  }


