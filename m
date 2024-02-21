Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBECC5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcovv-0001UL-KB; Wed, 21 Feb 2024 10:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcovf-0001IO-Ru
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:54:42 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcovb-0004G1-SH
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:54:39 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9513721F92;
 Wed, 21 Feb 2024 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708530871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIx96oIz4O6iSjptgRUvurFujPK8ytNpkKVWuHmoBqw=;
 b=Rfmx2Sah7/OkheMA6a+NDiqzwKYWexJ6n5q0ISjC04IHnQx/iIhAIEryNLLr/ePVRjc3yw
 sTsgKlTsSzhKYsk5woCYFYSp43iaAKOOyMf7aGdX+Wf7p5hvWakrySgje3sAsJy+gW/u+I
 EpjFmW5eGN75SNUXN8wl/QxfKRVQa0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708530871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIx96oIz4O6iSjptgRUvurFujPK8ytNpkKVWuHmoBqw=;
 b=SElCyVZeYo81UQOorLS3EPcu202YWfVQnXSJQMc7Iku+XKS9sd4bSAjanXrbkgG+Xe9HL8
 eooMDqO3sENoocCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708530871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIx96oIz4O6iSjptgRUvurFujPK8ytNpkKVWuHmoBqw=;
 b=Rfmx2Sah7/OkheMA6a+NDiqzwKYWexJ6n5q0ISjC04IHnQx/iIhAIEryNLLr/ePVRjc3yw
 sTsgKlTsSzhKYsk5woCYFYSp43iaAKOOyMf7aGdX+Wf7p5hvWakrySgje3sAsJy+gW/u+I
 EpjFmW5eGN75SNUXN8wl/QxfKRVQa0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708530871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIx96oIz4O6iSjptgRUvurFujPK8ytNpkKVWuHmoBqw=;
 b=SElCyVZeYo81UQOorLS3EPcu202YWfVQnXSJQMc7Iku+XKS9sd4bSAjanXrbkgG+Xe9HL8
 eooMDqO3sENoocCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FF6C13A69;
 Wed, 21 Feb 2024 15:54:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wAsBNrYc1mX+FgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Feb 2024 15:54:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V4 5/5] migration: simplify exec migration functions
In-Reply-To: <87msrtc479.fsf@suse.de>
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-6-git-send-email-steven.sistare@oracle.com>
 <87msrtc479.fsf@suse.de>
Date: Wed, 21 Feb 2024 12:54:28 -0300
Message-ID: <87edd5byob.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Rfmx2Sah;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SElCyVZe
X-Spamd-Result: default: False [-2.36 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-2.05)[95.33%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9513721F92
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> Steve Sistare <steven.sistare@oracle.com> writes:
>
>> Simplify the exec migration code by using list utility functions.
>>
>> As a side effect, this also fixes a minor memory leak.  On function return,
>> "g_auto(GStrv) argv" frees argv and each element, which is wrong, because
>> the function does not own the individual elements.  To compensate, the code
>> uses g_steal_pointer which NULLs argv and prevents the destructor from
>> running, but argv is leaked.
>>
>> Fixes: cbab4face57b ("migration: convert exec backend ...")
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

You'll have to reintroduce the qemu/cutils.h include:

../migration/exec.c: In function 'exec_get_cmd_path':
../migration/exec.c:37:5: error: implicit declaration of function 'pstrcat'; did you mean 'strcat'? [-Werror=implicit-function-declaration]
   37 |     pstrcat(detected_path, MAX_PATH, "\\cmd.exe");
      |     ^~~~~~~
      |     strcat
../migration/exec.c:37:5: error: nested extern declaration of 'pstrcat' [-Werror=nested-externs]

