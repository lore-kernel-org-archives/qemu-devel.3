Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8495C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 19:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tif5U-0004K7-VM; Thu, 13 Feb 2025 14:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tif5T-0004Je-B0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 14:41:27 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tif5R-0000PL-GC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 14:41:27 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C538F1F845;
 Thu, 13 Feb 2025 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739475682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2OFjMu0UbGjZsMup6LKxlHLt/ln3koYNojGg85GCcM=;
 b=VIqShCHR9HVvK0tk0jRZaSmehkTrri9SNKrJnxYNX/ZTntsfrzrENOXjzNohp08LK0xZdR
 iC2FLMtfh5XxKbJfjBKUI/7hwLvzM02M4X4pWKFlXV6CQSAraTSmqOhDja51XItdF9VzO6
 AO44TJpB2/3hm+q6rlDOpCTCbJit05s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739475682;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2OFjMu0UbGjZsMup6LKxlHLt/ln3koYNojGg85GCcM=;
 b=2njIQZTvkOiOVhdUj/XPMFlefFM5IPHsw5cAkMu1cg8BlT4oNABEezrVvbZUG9YrtebyE5
 pz/OO38TWKjt1jDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gv6gBw19;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=l3I5+GNW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739475681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2OFjMu0UbGjZsMup6LKxlHLt/ln3koYNojGg85GCcM=;
 b=gv6gBw19ag6NNXcCTeahJfbEIwXkAbso/kAn0y1730ImfeWpn7288HJw1T2V5mEBCmS3XF
 q2B551Cf58zK7JORsQT367g1izAO6d9afml16tta/SHqxREVN8NEuicWFsAfGOD7Y+yLxj
 SnK8oi2xzj4y8zAnI+raRC/xmRCdFA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739475681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2OFjMu0UbGjZsMup6LKxlHLt/ln3koYNojGg85GCcM=;
 b=l3I5+GNWuOgGTnVLB0NKsDAvXSVKm+BlrkE+cL4AmwQyj+HWYVVXdK0RMJJ3J9pNrMWkE1
 d/1qaNlY/E/CpQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DCFB13874;
 Thu, 13 Feb 2025 19:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K3cIO+BKrmdUUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Feb 2025 19:41:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Jeuk Kim <jeuk20.kim@gmail.com>, jeuk20.kim@samsung.com,
 lvivier@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, j-young.choi@samsung.com, keosung.park@samsung.com
Subject: Re: [PATCH 0/3] tests/qtest/ufs-test: Add MCQ tests
In-Reply-To: <cover.1739336154.git.jeuk20.kim@samsung.com>
References: <cover.1739336154.git.jeuk20.kim@samsung.com>
Date: Thu, 13 Feb 2025 16:41:18 -0300
Message-ID: <87msepvdi9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C538F1F845
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.49 / 50.00]; BAYES_HAM(-2.98)[99.93%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,samsung.com,redhat.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Jeuk Kim <jeuk20.kim@gmail.com> writes:

> This series adds test support for UFS Multi-Circular Queue (MCQ) mode in QEMU.  
> It includes MCQ initialization tests, a bitmap-based slot allocation method,  
> and cleanup of unused code.
>
> Jeuk Kim (3):
>   tests/qtest/ufs-test: Cleanup unused code
>   tests/qtest/ufs-test: Prepare for MCQ test
>   tests/qtest/ufs-test: Add test code for MCQ functionality
>
>  tests/qtest/ufs-test.c | 724 ++++++++++++++++++++++++-----------------
>  1 file changed, 428 insertions(+), 296 deletions(-)

Acked-by: Fabiano Rosas <farosas@suse.de>

