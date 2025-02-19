Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA3EC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 13:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkjlt-0004tv-K3; Wed, 19 Feb 2025 08:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkjlr-0004tg-Hs
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:05:47 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkjlp-0006Il-OF
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:05:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3F2421896;
 Wed, 19 Feb 2025 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739970343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwVm262yQ8ApiG26X9T+AdfzIGSUsLepJCCt/Jpaf1E=;
 b=cqKSOyYAmAfR7aqAP/A79Pzgx7vMuLFcakq8pX8IjZOElxCsOCsp0c7Rv1gL4OIuT1Xy4i
 YzecR+Z/QSO5LExW0vE1tcI/KyXm36DEChkPUAe1+tGRSyB4Rjfr4OKeStXWvAOJ8wlUWE
 Tkg+WmiFXW52HwTs24hlac7lJTT4Og0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739970343;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwVm262yQ8ApiG26X9T+AdfzIGSUsLepJCCt/Jpaf1E=;
 b=Fk5i0rYggL2hKiJdeRtx6zpV0pUijhlmfZe9VcOKwZuxl2m9E/9W/Sm25GFSJBlggr/1Y/
 zcd9R1XLvhDYPHDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wQ+DLeab;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QDzfz3W8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739970342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwVm262yQ8ApiG26X9T+AdfzIGSUsLepJCCt/Jpaf1E=;
 b=wQ+DLeabwpneTVaEVqCWU979tL9HT6XTuo3T/u9MfVSM1TC29Yu5ZQzrNo/srxrQp4qe0A
 Y1g10VSfF8rISBpESGjAMd0iw1zcCzc79EM4N7TMcFjX3WXLDBJ8Au9CSZzH6F/7mDv68b
 BRLNh+gLb0+YUZzPAJ1ygn/6zs4hMqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739970342;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwVm262yQ8ApiG26X9T+AdfzIGSUsLepJCCt/Jpaf1E=;
 b=QDzfz3W8bPNWkzZjDwdr9qdJ3bW7vf0+cyFDbUF3YQM13lCnB91aMqupoDQr0+AZ6gJ2Wa
 ZRBIU8qqVJPDDlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D70C13715;
 Wed, 19 Feb 2025 13:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qg6KBybXtWcsfwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Feb 2025 13:05:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?=
 <alex.bennee@linaro.org>, Dario Faggioli <dfaggioli@suse.com>
Subject: Re: [RFC PATCH] elfload: Fix alignment when unmapping excess
 reservation
In-Reply-To: <1d9428e2-8e9d-40c4-a7fe-67e1a5965dc9@tls.msk.ru>
References: <20250213143558.10504-1-farosas@suse.de>
 <1d9428e2-8e9d-40c4-a7fe-67e1a5965dc9@tls.msk.ru>
Date: Wed, 19 Feb 2025 10:05:39 -0300
Message-ID: <87wmdm84po.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E3F2421896
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 13.02.2025 17:35, Fabiano Rosas wrote:
>> When complying with the alignment requested in the ELF and unmapping
>> the excess reservation, having align_end not aligned to the guest page
>> causes the unmap to be rejected by the alignment check at
>> target_munmap and later brk adjustments hit an EEXIST.
>> 
>> Fix by aligning the start of region to be unmapped.
>> 
>> Fixes: c81d1fafa6 ("linux-user: Honor elf alignment when placing images")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1913
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Is this a qemu-stable material?  That issue was quite hot..

Yes, I think it's good for stable.

>
> Thanks,
>
> /mjt

