Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246E2CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJ3-0003cA-Di; Tue, 21 Oct 2025 16:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBJIn-0002nq-JA
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:54 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBJIj-0001HM-Hi
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B4DF0211BA;
 Tue, 21 Oct 2025 20:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761079781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiIAhu4T2xHsX3SOlsikAJ2GYtgu64nvAbISQp1oSmQ=;
 b=WABtZxDvPxI7BUHOV4YcjcGS72TRHfwjvjJ0cweeOSWEwzEBH0pGvZ22ah6v4ZI4oADwrk
 Cr7fD0iXTBcSurJibA90x3g0/Wv0D7IhyGvZLzPppySew52I2eqcHUZy0jfwS5O6zrjoTU
 L23kLoKRMZaegOjGQ4Q963uD3YCM2Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761079781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiIAhu4T2xHsX3SOlsikAJ2GYtgu64nvAbISQp1oSmQ=;
 b=aiqgZY1h6jGI1oROHN4suVGohii3CDxS4Ao4sLaux3DOpGGWAdsfvhxrJT19rqowMpQ5Oq
 50DrS6C+lQo6qSDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NkFNdOH9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mZ6r3MJt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761079777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiIAhu4T2xHsX3SOlsikAJ2GYtgu64nvAbISQp1oSmQ=;
 b=NkFNdOH9yJ6YNb0d2I/YMSE8EF8HdFhMJ7WDb1Vp6TWPb5BmdyuYZPXdCmrwkUBqBIUOn/
 XP5htVxyU0bM9CB2IQOk0U8zLDnjsoo0Bunw/9BqBApdbmTBHniwsQxkLTGMxdkuhCudtf
 znwMAIUG7uwA9r5IM8L2su2MHNKM1qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761079777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiIAhu4T2xHsX3SOlsikAJ2GYtgu64nvAbISQp1oSmQ=;
 b=mZ6r3MJtP1vC23iUxEOPWVptP/F4LC4TKq9iffsaFQJnZbZ16Wm1myPq1/bVJI4AZNYPUs
 MqZ+dPuma8ZGXDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FD0C139D2;
 Tue, 21 Oct 2025 20:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id awtNOeDx92ioVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 21 Oct 2025 20:49:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Arun Menon <armenon@redhat.com>, peterx@redhat.com, Peter Maydell
 <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 3/3] migration/cpr: Fix UAF in cpr_exec_cb() when
 execvp() fails
In-Reply-To: <20251021184132.2635958-4-peterx@redhat.com>
References: <20251021184132.2635958-1-peterx@redhat.com>
 <20251021184132.2635958-4-peterx@redhat.com>
Date: Tue, 21 Oct 2025 17:49:34 -0300
Message-ID: <87ldl4t1y9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: B4DF0211BA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.39 / 50.00]; BAYES_HAM(-2.88)[99.47%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

Peter Xu <peterx@redhat.com> writes:

> Per reported and analyzed by Peter:
>
> https://lore.kernel.org/r/CAFEAcA82ih8RVCm-u1oxiS0V2K4rV4jMzNb13pAV=e2ivmiDRA@mail.gmail.com
>
> Fix the issue by moving the error_setg_errno() earlier.  When at it, clear
> argv variable after freed.
>
> Resolves: Coverity CID 1641397
> Fixes: a3eae205c6 ("migration: cpr-exec mode")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

