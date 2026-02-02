Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F689E7314C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 09:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmpsr-0005z8-CM; Mon, 02 Feb 2026 04:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vmpso-0005yu-88
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 04:06:10 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vmpsm-0000WD-3q
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 04:06:09 -0500
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3E8D65BD5B;
 Mon,  2 Feb 2026 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770023165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qguQkZJAREBWmSVYC+qKE7Fm7ih71weB0HwaOTk2VbU=;
 b=TDRWQTWrOVD4iw01TroTgF09iRPGY35Zd2ZQ8zVWYw7k1UGu7/oCAjAFl2C/TwfvrmbEAY
 TZMcGnYzSE+IVZDC5sge8yqczI1qeiLj85zjIo6gjINv7F6ccV+SNWSXxYl0pJypQznyQ8
 pxROia9swt8dwrYuqxKWVltSBREhTVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770023165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qguQkZJAREBWmSVYC+qKE7Fm7ih71weB0HwaOTk2VbU=;
 b=HzDIqa7P3KbDijo8MAoQRJb7/ZJba7PEu0o1je+xTCvH0X9npB8gjg3JYDl6ywz+9n8nZU
 iyNL4N+RE8H3sfDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770023165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qguQkZJAREBWmSVYC+qKE7Fm7ih71weB0HwaOTk2VbU=;
 b=TDRWQTWrOVD4iw01TroTgF09iRPGY35Zd2ZQ8zVWYw7k1UGu7/oCAjAFl2C/TwfvrmbEAY
 TZMcGnYzSE+IVZDC5sge8yqczI1qeiLj85zjIo6gjINv7F6ccV+SNWSXxYl0pJypQznyQ8
 pxROia9swt8dwrYuqxKWVltSBREhTVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770023165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qguQkZJAREBWmSVYC+qKE7Fm7ih71weB0HwaOTk2VbU=;
 b=HzDIqa7P3KbDijo8MAoQRJb7/ZJba7PEu0o1je+xTCvH0X9npB8gjg3JYDl6ywz+9n8nZU
 iyNL4N+RE8H3sfDQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 303324A05D9; Mon,  2 Feb 2026 10:06:05 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 19/19] tcg/user: do not set exit_request gratuitously
In-Reply-To: <CABgObfYWC1OHHyfWCxzV92K9jAfpOGnpNLNoA-FC0-_yKNRAFA@mail.gmail.com>
 (Paolo Bonzini's message of "Thu, 29 Jan 2026 21:22:06 +0100")
References: <20250908101241.2110068-1-pbonzini@redhat.com>
 <20250908101241.2110068-20-pbonzini@redhat.com>
 <mvmqzr8hjrp.fsf@suse.de>
 <CABgObfYWC1OHHyfWCxzV92K9jAfpOGnpNLNoA-FC0-_yKNRAFA@mail.gmail.com>
Date: Mon, 02 Feb 2026 10:06:05 +0100
Message-ID: <mvm1pj3h5vm.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_ONE(0.00)[1];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=schwab@suse.de;
 helo=smtp-out2.suse.de
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

On Jan 29 2026, Paolo Bonzini wrote:

> I assume you have already tried to revert it?

Sure, that's how I verified it.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

