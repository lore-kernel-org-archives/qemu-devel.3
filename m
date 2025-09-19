Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D41CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 17:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzelg-0006hM-Sx; Fri, 19 Sep 2025 13:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzele-0006hB-CY
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:19:30 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzelW-0002RX-Pu
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:19:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BEF66228A1;
 Fri, 19 Sep 2025 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758302359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBrqOEpR2bsXFnmMuCZgZGgA7t1Vaapw7MdbyCbFAcQ=;
 b=yHcUsn0OFWJ3k+SH/znWDb1IEaqYRe+AcsNvTFJ75KFKs5ml/nsK4rtTF2lMSXSpcK1IU+
 /KU0mnrFEbP39BX30VqLcwskGXf73GSKEHwsm4h89tFKop96eSLMxznFVGlXN2GI6KwSdL
 qgIMhgJhjhz5AdrDhOjhEnNcO5Fie68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758302359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBrqOEpR2bsXFnmMuCZgZGgA7t1Vaapw7MdbyCbFAcQ=;
 b=QVsxhQzn6KkM8gvEluLedP98vDbnke0NQhMLErF3lQOz609nbEdYs2c36O+zmAnwd051gy
 7pSPnht/5rD+PNAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758302359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBrqOEpR2bsXFnmMuCZgZGgA7t1Vaapw7MdbyCbFAcQ=;
 b=yHcUsn0OFWJ3k+SH/znWDb1IEaqYRe+AcsNvTFJ75KFKs5ml/nsK4rtTF2lMSXSpcK1IU+
 /KU0mnrFEbP39BX30VqLcwskGXf73GSKEHwsm4h89tFKop96eSLMxznFVGlXN2GI6KwSdL
 qgIMhgJhjhz5AdrDhOjhEnNcO5Fie68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758302359;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBrqOEpR2bsXFnmMuCZgZGgA7t1Vaapw7MdbyCbFAcQ=;
 b=QVsxhQzn6KkM8gvEluLedP98vDbnke0NQhMLErF3lQOz609nbEdYs2c36O+zmAnwd051gy
 7pSPnht/5rD+PNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3ADAE13A78;
 Fri, 19 Sep 2025 17:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M0clO5aQzWjWYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Sep 2025 17:19:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Auger
 <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>
Subject: Re: [PATCH v3] arm/kvm: report registers we failed to set
In-Reply-To: <20250911154159.158046-1-cohuck@redhat.com>
References: <20250911154159.158046-1-cohuck@redhat.com>
Date: Fri, 19 Sep 2025 14:19:16 -0300
Message-ID: <87jz1utl63.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Cornelia Huck <cohuck@redhat.com> writes:

> If we fail migration because of a mismatch of some registers between
> source and destination, the error message is not very informative:
>
> qemu-system-aarch64: error while loading state for instance 0x0 ofdevice 'cpu'
> qemu-system-aarch64: Failed to put registers after init: Invalid argument

Beats "load of migration failed: -5"

Thank you for this, it's always good to improve these error messages.

>
> At least try to give the user a hint which registers had a problem,
> even if they cannot really do anything about it right now.
>
> Sample output:
>
> Could not set register op0:3 op1:0 crn:0 crm:0 op2:0 to c00fac31 (is 413fd0c1)
>
> We could be even more helpful once we support writable ID registers,
> at which point the user might actually be able to configure something
> that is migratable.
>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

