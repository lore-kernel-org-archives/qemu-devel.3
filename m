Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71685C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 07:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMjxh-0002AP-Gp; Thu, 27 Jun 2024 03:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sMjxf-0002A9-Ay
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:54:31 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sMjxb-0005zM-Ck
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:54:30 -0400
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out2.suse.de (Postfix) with ESMTP id 04AB81FBAB;
 Thu, 27 Jun 2024 07:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719474863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWOhstAmNkS2JPmTmH2ksRJAV2+dUojT8OW3aOKZbNA=;
 b=fsfQOWSIEmfdn4NMPAm9J0cEjv+FSxhW1ZiziVKrxCfTiI96Z/dV7BxjDE1/3UY4DT47Ne
 LlGD3mzgU9esRnuuNmifG97O7q89T0ckpi1sYqhy30d0ILtyn0vcwSSWSX64FlweL9JHeV
 66+eItZnBKP0iC/Tp5RfyrWyGLjzbBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719474863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWOhstAmNkS2JPmTmH2ksRJAV2+dUojT8OW3aOKZbNA=;
 b=qdUHET1OiR5idhr3XPpbsd7iFqygzcQxJOqa9hKWGL8eJuUqdA53es4QNQXdfzZU/yWhcM
 qk/tPLkFks4tAwBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719474863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWOhstAmNkS2JPmTmH2ksRJAV2+dUojT8OW3aOKZbNA=;
 b=fsfQOWSIEmfdn4NMPAm9J0cEjv+FSxhW1ZiziVKrxCfTiI96Z/dV7BxjDE1/3UY4DT47Ne
 LlGD3mzgU9esRnuuNmifG97O7q89T0ckpi1sYqhy30d0ILtyn0vcwSSWSX64FlweL9JHeV
 66+eItZnBKP0iC/Tp5RfyrWyGLjzbBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719474863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWOhstAmNkS2JPmTmH2ksRJAV2+dUojT8OW3aOKZbNA=;
 b=qdUHET1OiR5idhr3XPpbsd7iFqygzcQxJOqa9hKWGL8eJuUqdA53es4QNQXdfzZU/yWhcM
 qk/tPLkFks4tAwBw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id E53A14A050D; Thu, 27 Jun 2024 09:54:22 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Warner Losh <imp@bsdimp.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
In-Reply-To: <CANCZdfq4=s=g8GoeCKY4576xgJs4-X+fXh7m5ZOJ1UeBXwWdCQ@mail.gmail.com>
 (Warner Losh's message of "Wed, 26 Jun 2024 09:54:06 -0600")
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org>
 <mvm4j9gp0xd.fsf@suse.de>
 <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
 <CANCZdfq4=s=g8GoeCKY4576xgJs4-X+fXh7m5ZOJ1UeBXwWdCQ@mail.gmail.com>
X-Yow: I'm dressing up in an ill-fitting IVY-LEAGUE SUIT!!  Too late...
Date: Thu, 27 Jun 2024 09:54:22 +0200
Message-ID: <mvmv81un7m9.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.12 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.12)[-0.584]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linaro.org:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=schwab@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Jun 26 2024, Warner Losh wrote:

> On Wed, Jun 26, 2024 at 9:48 AM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> On 6/26/24 01:23, Andreas Schwab wrote:
>> > On Jun 25 2024, Richard Henderson wrote:
>> >
>> >> can always force the use of a non-zero base with -B or -R.
>> >
>> > $ qemu-riscv64 -d page -B 0x3ee000 hello.riscv64
>> > host mmap_min_addr=0x1000 (fallback)
>> > qemu-riscv64: /daten/src/test/hello.riscv64: requires virtual address
>> space that is in use (omit the -B option or choose a different value)
>> >
>>
>> Well, sure, but that obviously is where qemu-riscv64 itself is located.
>> Still not a valid test case.
>>
>
> Yea, what happens if you say -B 0x3ee000000 or something else that won't
> conflict?

I didn't chose that number, qemu did.  If it doesn't work then qemu must
be fixed.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

