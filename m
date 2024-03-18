Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AB8C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 13:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmDTG-0004so-8S; Mon, 18 Mar 2024 09:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rmDTA-0004r9-G9; Mon, 18 Mar 2024 09:56:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1rmDSt-0003dm-3Z; Mon, 18 Mar 2024 09:56:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A2CE34AC5;
 Mon, 18 Mar 2024 13:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710770142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TiBGKTg/un8GUlyX+t2Z1wteiuQqe1aidWMoXtDtmHo=;
 b=gDMmMvs6O+cdnMV7UcC5tS9aMoR0C82t75cZvYGH+IYyrl947UyQbIGWI3sv//mCRB80NS
 La9irtLYVoRC3c2g400zNf/9cpaQ3H+6fEiprUwv2gwlvHNkq9hhZq3IJxs0U/p2j1xApn
 DWwhksK8GyyhxqbxyUUJfwU5pJLzoQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710770142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TiBGKTg/un8GUlyX+t2Z1wteiuQqe1aidWMoXtDtmHo=;
 b=+10c6i8YX793jDr95rHpROfkpFYWS5JsMw+BJjaM2BC7LshyXsYJH6c9EGeRdeqDAEBE/A
 2CT0RzB+4q8Py6Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710770142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TiBGKTg/un8GUlyX+t2Z1wteiuQqe1aidWMoXtDtmHo=;
 b=gDMmMvs6O+cdnMV7UcC5tS9aMoR0C82t75cZvYGH+IYyrl947UyQbIGWI3sv//mCRB80NS
 La9irtLYVoRC3c2g400zNf/9cpaQ3H+6fEiprUwv2gwlvHNkq9hhZq3IJxs0U/p2j1xApn
 DWwhksK8GyyhxqbxyUUJfwU5pJLzoQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710770142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TiBGKTg/un8GUlyX+t2Z1wteiuQqe1aidWMoXtDtmHo=;
 b=+10c6i8YX793jDr95rHpROfkpFYWS5JsMw+BJjaM2BC7LshyXsYJH6c9EGeRdeqDAEBE/A
 2CT0RzB+4q8Py6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EB5C1349D;
 Mon, 18 Mar 2024 13:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L/jXDN5H+GXmLQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Mon, 18 Mar 2024 13:55:42 +0000
Message-ID: <6d416a97-eaa2-87d2-d2ed-cfb5a42d83f4@suse.de>
Date: Mon, 18 Mar 2024 14:55:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>
From: Claudio Fontana <cfontana@suse.de>
Subject: qemu-img: very bad performance with the default number of coroutines
 (8) in presence of compression. Fixed adding "-m 1" to the cmdline.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.58 / 50.00]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; BAYES_HAM(-0.07)[62.03%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gDMmMvs6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+10c6i8Y
X-Rspamd-Queue-Id: 7A2CE34AC5
Received-SPF: pass client-ip=195.135.223.130; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hello,

pretty much the $Subject.

We had reports of very bad performance with the default options when running:

$ time qemu-img convert -c -p -O qcow2 file.qcow2 file.disk
real	7m13.220s
user	6m56.682s
sys	0m13.038s

I studied this and noticed that for every coroutine a thread was created. But at no point ever were two coroutines making progress at the same time.
On the countrary, they constantly competed to run, leading to very slow task progress.

The workaround we found here was to just add "-m 1" to the command line, leading to a halving of the time taken for running the command:

$ time qemu-img convert -c --m 1 p -O qcow2 file.qcow2 file.disk
real	3m22.212s
user	3m13.744s
sys	0m7.881s

We repeated this test on a variety of hardware configurations, and the relative results are always the same.

Have you witnessed the same situation?

Should we change the default in qemu-img from 8 coroutines to 1, at least for the "-c" case?

In case I can submit a simple patch that does that, but looking forward for your thoughts.
It is possible that coroutines were added in an attempt to improve performance,
so maybe there is more here to fix, although in my view already fixing the existing bad default would already be a big improvement in the meantime.

Thoughts?

Thanks,

Claudio


