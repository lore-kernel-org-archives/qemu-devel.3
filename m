Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864D1D358E5
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 09:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlNxS-00036h-5U; Thu, 29 Jan 2026 04:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vlNxO-00034K-1F
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 04:04:54 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1vlNxK-0006gV-Hv
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 04:04:52 -0500
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id E7BC25BCE6;
 Thu, 29 Jan 2026 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769677486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7Z6a5azrdJIt9pnVn9XS9/W6lGM9miKyPhAOkCSsV8=;
 b=uhZNVk+mFHfwM1pb7QrfaZlSQCrkZjKOV+OJUFbO/7x2pv7HlWUGR1OV0HyuqCaqUNE6WF
 4FxksriPq4MN0NyFC3h2VPEqBxubsiC+KQNe3osH6/AHX2UxuyaC1tXcpG03KE9kNQih2E
 SnWXzdL9QxDKY4G7ehLXb/Q3PP9HWBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769677486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7Z6a5azrdJIt9pnVn9XS9/W6lGM9miKyPhAOkCSsV8=;
 b=nE2Y2wnH4nuR1iUztqI0mt0Zk8bP2LGbq6poG8fFBw4PqPFIJSGPiqlHtqrgcW6jVbBbKZ
 jDErvwf8ELDh7PCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769677482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7Z6a5azrdJIt9pnVn9XS9/W6lGM9miKyPhAOkCSsV8=;
 b=tqMEYIssIIlSiLZw5tZNkSMvta3E8MGBuAUCaRqLOjf6gBLFmOjRhI35qrPX7YlLr16IuC
 20A5EWrUUiU+qx1Zwwrw6/p30vvaoXIQ3LC+/DcLCZ75blyn0VbZZ9d6sqFLxLvV+OlOwn
 hEDWDg3yNzkDwDvD4o2Io7JJQPobtQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769677482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G7Z6a5azrdJIt9pnVn9XS9/W6lGM9miKyPhAOkCSsV8=;
 b=MeylBtIeT2sj5vms2E+DerK6uRSGGzSVo/nmllcW3Ttb8pOu3SV/Tz9eImUC8SRj/C9XHC
 Xrkym9yUfMLHV3DA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id B83A04A056A; Thu, 29 Jan 2026 10:04:42 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 19/19] tcg/user: do not set exit_request gratuitously
In-Reply-To: <20250908101241.2110068-20-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 8 Sep 2025 12:12:41 +0200")
References: <20250908101241.2110068-1-pbonzini@redhat.com>
 <20250908101241.2110068-20-pbonzini@redhat.com>
Date: Thu, 29 Jan 2026 10:04:42 +0100
Message-ID: <mvmqzr8hjrp.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.16 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.16)[-0.811]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 SEM_URIBL_UNKNOWN_FAIL(0.00)[suse.de:server fail];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=schwab@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sep 08 2025, Paolo Bonzini wrote:

> Whenever user-mode emulation needs to go all the way out of the cpu
> exec loop, it uses cpu_exit(), which already sets cpu->exit_request.
>
> Therefore, there is no need for tcg_kick_vcpu_thread() to set
> cpu->exit_request again outside system emulation.

This breaks go.  If you run go build in a loop, it eventually hangs
uninterruptible (except -9) with a couple of zombie children left over.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

