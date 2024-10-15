Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED958D1F9C2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 19:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0n8R-0005qY-St; Tue, 15 Oct 2024 15:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t0n8K-0005ol-9d
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:23:06 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t0n8I-0001xG-Mo
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:23:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 28DF91FBA0;
 Tue, 15 Oct 2024 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729020178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gnTC2kt+1cMbD+JSZLKT5yxnm17ge96UFnNlyj4I2rU=;
 b=HlJkkrgKF8CO6ybuVufF/C/29EMV5jE84T5WKcHMP02Na4Vy7+r4d2JfF2MYvCtnK2y8I5
 NY+VwcV90jDnTyxwhxCWWAnJoQ+cwzh8ljumDuiLZD/B0avKnG8a8YtCJtxmqN+sm3oTkX
 LROu4Hmh+ooX8KWHtRNDLHYbFKq+u3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729020178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gnTC2kt+1cMbD+JSZLKT5yxnm17ge96UFnNlyj4I2rU=;
 b=T8R3vCCET9wDLSF746r6vtzqn2jUNLz0j1jyY++eW1JalqSuvmV+Jg+YeszUE5467F2X4S
 JnNZvYmrGyW4J0Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729020178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gnTC2kt+1cMbD+JSZLKT5yxnm17ge96UFnNlyj4I2rU=;
 b=HlJkkrgKF8CO6ybuVufF/C/29EMV5jE84T5WKcHMP02Na4Vy7+r4d2JfF2MYvCtnK2y8I5
 NY+VwcV90jDnTyxwhxCWWAnJoQ+cwzh8ljumDuiLZD/B0avKnG8a8YtCJtxmqN+sm3oTkX
 LROu4Hmh+ooX8KWHtRNDLHYbFKq+u3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729020178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gnTC2kt+1cMbD+JSZLKT5yxnm17ge96UFnNlyj4I2rU=;
 b=T8R3vCCET9wDLSF746r6vtzqn2jUNLz0j1jyY++eW1JalqSuvmV+Jg+YeszUE5467F2X4S
 JnNZvYmrGyW4J0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A784A13A42;
 Tue, 15 Oct 2024 19:22:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3XqAGxHBDmcoWgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 15 Oct 2024 19:22:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: tpm-tis-device-swtpm-test timeout
In-Reply-To: <077cee03-efd0-4716-865a-b9990afb91a3@linux.ibm.com>
References: <87jze9qlrp.fsf@suse.de>
 <077cee03-efd0-4716-865a-b9990afb91a3@linux.ibm.com>
Date: Tue, 15 Oct 2024 16:22:55 -0300
Message-ID: <87h69dqigg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.11 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_SHORT(-0.01)[-0.049]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Stefan Berger <stefanb@linux.ibm.com> writes:

> On 10/15/24 2:11 PM, Fabiano Rosas wrote:
>> Hi Stefan,
>> 
>> I see the tpm-tis-device-swtpm test timing out, could you take a look?
>> 
>> qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-device-swtpm-test time out (After 60.0 seconds)
>> 135/138 qemu:qtest+qtest-aarch64 /
>> qtest-aarch64/tpm-tis-device-swtpm-test TIMEOUT 60.01s killed by signal 11 SIGSEGV
>
> Is this something new or been happening for a while? Does it happen 
> consistently? I just build the master branch and ran the tests on a very 
> old machine, I mean 13 years old. The host runs Fedora 40 with 
> libtpms-0.96-6 + swtpm-0.9.0 from the distro:

It's the first time I see it. I can reproduce consistently by running
that test in a loop while make -j16 check is running in another window.

I'm on openSUSE Leap 15.5:

$ rpm -qa | grep libtpms
libtpms0-0.8.2-150300.3.9.1.x86_64

$ rpm -qa | grep swtpm
swtpm-0.7.3-150500.2.1.x86_64

