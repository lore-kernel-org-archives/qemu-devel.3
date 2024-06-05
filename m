Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6BDC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEoX4-0000Qp-3l; Wed, 05 Jun 2024 07:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sEoX2-0000Po-9s
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:10:16 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sEoWy-0006lN-Ex
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:10:16 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:10:168:4:11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 734651F7F8;
 Wed,  5 Jun 2024 11:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717585807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Go75RBuzrkOiil+FwYZeL1Z2xR29uwaH0/vGqJoMCY0=;
 b=OxpY9B8kTd5SCt7gmuXmdYgZ6EnkFn6zk9GItenbImi64DtpHMRIiPMXBiqIprb50oxaGW
 TAZUIcXx+RhVfL6WZFpyYLdIaEKwXCJy4vDUzsmv4d3TmVF9QVXZqg6LxaLSD3AEqcUJOW
 bc5udjaSBGLEtPecteHtKLfI7T8cWa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717585807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Go75RBuzrkOiil+FwYZeL1Z2xR29uwaH0/vGqJoMCY0=;
 b=ihvZrvlHys6zr6KfuXOlrCOuwQelOQLMilqIgmk1TlNIJykP6j/KryAXlR8zGFWgVBL3Tu
 hVt3Uo2TGThq37AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OxpY9B8k;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ihvZrvlH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717585807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Go75RBuzrkOiil+FwYZeL1Z2xR29uwaH0/vGqJoMCY0=;
 b=OxpY9B8kTd5SCt7gmuXmdYgZ6EnkFn6zk9GItenbImi64DtpHMRIiPMXBiqIprb50oxaGW
 TAZUIcXx+RhVfL6WZFpyYLdIaEKwXCJy4vDUzsmv4d3TmVF9QVXZqg6LxaLSD3AEqcUJOW
 bc5udjaSBGLEtPecteHtKLfI7T8cWa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717585807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Go75RBuzrkOiil+FwYZeL1Z2xR29uwaH0/vGqJoMCY0=;
 b=ihvZrvlHys6zr6KfuXOlrCOuwQelOQLMilqIgmk1TlNIJykP6j/KryAXlR8zGFWgVBL3Tu
 hVt3Uo2TGThq37AQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 163264A0552; Wed,  5 Jun 2024 13:10:06 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: qemu-devel@nongnu.org
Subject: Re: linux-user emulation hangs during fork
In-Reply-To: <mvm5xunu4ye.fsf@suse.de> (Andreas Schwab's message of "Wed, 05
 Jun 2024 11:14:17 +0200")
References: <mvm5xunu4ye.fsf@suse.de>
CC: Richard Henderson <richard.henderson@linaro.org>
X-Yow: They don't hire PERSONAL PINHEADS, Mr. Toad!
Date: Wed, 05 Jun 2024 13:10:06 +0200
Message-ID: <mvmzfrzsl0x.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.59 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; ONCE_RECEIVED(1.20)[];
 RDNS_NONE(1.00)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_RHS_MATCH_FROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_ONE(0.00)[1]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:dkim,suse.de:email]
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 734651F7F8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=schwab@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

6490d9aa62ef3cbbac2bf584fb0f3e737ab05e44 is the first bad commit
commit 6490d9aa62ef3cbbac2bf584fb0f3e737ab05e44
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Tue Jan 24 10:10:19 2023 -1000

    linux-user: un-parent OBJECT(cpu) when closing thread
    
    This reinstates commit 52f0c1607671293afcdb2acc2f83e9bccbfa74bb:
    
    While forcing the CPU to unrealize by hand does trigger the clean-up
    code we never fully free resources because refcount never reaches
    zero. This is because QOM automatically added objects without an
    explicit parent to /unattached/, incrementing the refcount.
    
    Instead of manually triggering unrealization just unparent the object
    and let the device machinery deal with that for us.
    
    Resolves: https://gitlab.com/qemu-project/qemu/-/issues/866
    Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
    Reviewed-by: Laurent Vivier <laurent@vivier.eu>
    Message-Id: <20220811151413.3350684-2-alex.bennee@linaro.org>
    
    The original patch tickled a problem in target/arm, and was reverted.
    But that problem is fixed as of commit 3b07a936d3bf.
    
    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
    Message-Id: <20230124201019.3935934-1-richard.henderson@linaro.org>
    Signed-off-by: Laurent Vivier <laurent@vivier.eu>

 linux-user/syscall.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

