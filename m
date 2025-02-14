Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFE4C021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 18:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj0CK-0000Sy-0g; Fri, 14 Feb 2025 13:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj0CH-0000Sf-JX
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 13:13:53 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj0CF-0000zu-GA
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 13:13:53 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 722772117D;
 Fri, 14 Feb 2025 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739556828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRHfVXcXJyosCHXVmxJXjGwvRnGYmykGlXkOhodHe1A=;
 b=O7h0CslNoKspkl4WiMxb/+h01RlydLOs+E378ExYSTtBqDorc+Rk6VHGwqSoQeKguE7bgN
 9QbCTct3DB8taNVHLAJMnjj3yot857rINZpF8y/Z+SCze9khf2OZcjGBWSjRsC0+Hvv28R
 dx+SSJapoEbkeqhcSE71pNdfC6nwnBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739556828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRHfVXcXJyosCHXVmxJXjGwvRnGYmykGlXkOhodHe1A=;
 b=FJ2HVkvlkOBkpSS0spf9Cf4nIug/j/58Z9JM94ZHHTBSkd5atp6T1XNgIKSeQhd6A0b/rv
 SobJB54yKuRhfLBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739556827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRHfVXcXJyosCHXVmxJXjGwvRnGYmykGlXkOhodHe1A=;
 b=M9ss0aOOecYY5joObL1gewrr4m9gPzMnK2d3tZWUIAeBMRDq4NzK/AbXSv3DUIoZK/hKkB
 +KkQrBOUKTEdg7pFT7Qlr6khK6darjhP2QQc9X/ATiELJCyZdketTRlzO0bYk0D/XQfp+c
 AQxQP3MssKF5+eoXeYIIzzjk2tcAsGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739556827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kRHfVXcXJyosCHXVmxJXjGwvRnGYmykGlXkOhodHe1A=;
 b=eiHtLE9a9RBhG2DvxfV2VXdW+RHKnWYLCj6ZUR7YHJ6eiChzkcbvswrUWSpFkl8NRIwYLM
 PdYXWXYs3zikHzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC02813285;
 Fri, 14 Feb 2025 18:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zLQFJtqHr2cragAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Feb 2025 18:13:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: yong.huang@smartx.com, qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: Re: [PATCH v4 RESEND 0/4] Guestperf: miscellaneous refinement and
 enrichment
In-Reply-To: <cover.1739530098.git.yong.huang@smartx.com>
References: <cover.1739530098.git.yong.huang@smartx.com>
Date: Fri, 14 Feb 2025 15:13:44 -0300
Message-ID: <87a5aov1gn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[smartx.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

yong.huang@smartx.com writes:

> From: Hyman Huang <yong.huang@smartx.com>
>
> v4:
> 1. rebase v3 patchset on master
> 2. build initrd-stress.img manually like before as suggested by Peter and Fabiano
> 3. drop the [PATCH v3 1/5], [PATCH v3 2/5] patches
> 4. add an extra patch: [PATCH v4 4/4] guestperf: Add test result data into report
>
> Please review, thanks
> Yong
>
> v3:
> 1. Remove the two redundant assignments in [PATCH v2 2/5] suggested by Daniel
>
> v2:
> 1. Update the MAINTAINERS section suggested by Fabiano Rosas
> 2. Ensure the dependencies when build the initrd-stress.img suggested by Daniel
> 3. Fix some bugs
>
> v1:
> The previous patchset:
> https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smartx.com/
> does not made the necessary changes and tests for the upstream version.
>
> This patchset works for that:
> 1. Move the guestperf to scripts directory suggested by Fabiano Rosas
> 2. Make initrd-stress.img built by default suggested by Fabiano Rosas
> 3. Make the necessary changes to adapt the latest multifd behavior
> 4. A nitpick for multifd migration
> 5. Support multifd compression option
>
> Hyman Huang (4):
>   guestperf: Support deferred migration for multifd
>   guestperf: Nitpick the inconsistent parameters
>   guestperf: Introduce multifd compression option
>   guestperf: Add test result data into report
>
>  .../migration-stress/guestperf/comparison.py  | 15 ++++++-
>  tests/migration-stress/guestperf/engine.py    | 43 ++++++++++++++++---
>  tests/migration-stress/guestperf/report.py    | 20 +++++++++
>  tests/migration-stress/guestperf/scenario.py  |  7 ++-
>  tests/migration-stress/guestperf/shell.py     |  3 ++
>  5 files changed, 79 insertions(+), 9 deletions(-)

Queued, thanks!

