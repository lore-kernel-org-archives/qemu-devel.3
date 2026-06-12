Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D209ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY2sA-0002j3-Pu; Fri, 12 Jun 2026 10:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wY2s9-0002in-Eg
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:28:37 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wY2s8-0002TM-1V
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 10:28:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D585B6B657;
 Fri, 12 Jun 2026 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781269208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glvfeorQ3Abybe0H++pmDJNjCHvjK4jLZUDMSL1jdoQ=;
 b=vZ41ilY+ufEAjLq0HxafVkwey6tVqCcR6yrI0ySqD4Cl/RPSFi2HBs/KkYXYfiTJLiGGf+
 iMu/V0Gyx8HRvhf2t04CaZzYe6S8N5eLyU9CTobq0MYtGDaW2aSwhJsG7jGqccgoRunbkH
 M71zbaiwuBYTZXYlQSMA0e1HoEpxy5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781269208;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glvfeorQ3Abybe0H++pmDJNjCHvjK4jLZUDMSL1jdoQ=;
 b=7avGLW8f7ajSW/Uyq/4uSDWs88JNHGNU+JyGG9Pr5O+cMPYU0FGq0KwBb+30aUURxjHCr0
 CBpsImRndyowz6DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y67B44w+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U2D8jnyu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781269206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glvfeorQ3Abybe0H++pmDJNjCHvjK4jLZUDMSL1jdoQ=;
 b=y67B44w+0H80FWacKpvepuhIYWyceMD32WIVjseSSf4g96ByXxDAw/rHXw0k4MZV93QowS
 +9zb1uWcZqpuRF+38Ts2ls7DkyW5DTIm8kNHz0irJSpKp910SfSiRB8UGzlObUcp8F5FGu
 0+rOoQ0qwI2YOMKog9MQlEPyACgtRNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781269206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glvfeorQ3Abybe0H++pmDJNjCHvjK4jLZUDMSL1jdoQ=;
 b=U2D8jnyuB6VgUqrWNt8BiHKs5QIoOs2Sc0pZr6X61DYSj6HCdSxz5+U3umRLY/6g1Hsv7I
 gMgZwfWt3ik85+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B39E779A9;
 Fri, 12 Jun 2026 13:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qFOTDtUCLGq8TAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 12 Jun 2026 13:00:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, Laurent
 Vivier <lvivier@redhat.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Vaibhav Jain
 <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Shivaprasad G Bhat
 <sbhat@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Matthew Penney <matt@matthewpenney.net>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>, Aditya Gupta
 <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] tests/qtest/libqtest: Use GLib functions for proper
 const correctness
In-Reply-To: <20260612122835.ede570b2-b5-amachhiw@linux.ibm.com>
References: <20260522082555.54918-1-amachhiw@linux.ibm.com>
 <20260612122835.ede570b2-b5-amachhiw@linux.ibm.com>
Date: Fri, 12 Jun 2026 10:00:02 -0300
Message-ID: <874ij7kj71.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-2.69)[98.64%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D585B6B657
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Hi Fabiano, Laurent,
>
> Did you have any review comments on this patch?
>
> Shall this be picked via your tree?
>

I'll take it, thanks.

