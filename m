Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB0FCA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 02:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoCW9-0002Kx-95; Mon, 18 Aug 2025 22:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoCW8-0002KT-1x
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 22:56:08 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uoCW1-0004aP-Jo
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 22:56:07 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8057B2126B;
 Tue, 19 Aug 2025 02:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755572158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LXnGRtwLJIDeCaqnhbqQv8+gi7GpC5ekmTCS2N9rWck=;
 b=zQ5gQXMU1HVUBd2Nv1oWsYGR/H/+/KeNgOTD4l8S5rHin3n24AAizNgDuOGujQbZdW6qDk
 0L2lh70vh9NVBlKlMdlBWoF4WcC0f0OQoMsmVXaRzFnXzv1BTPJzJNmN6dRcJBunC+AWgw
 /MexzhD69EYDrPEOE3d+vTTCUByWINQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755572158;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LXnGRtwLJIDeCaqnhbqQv8+gi7GpC5ekmTCS2N9rWck=;
 b=XBdbF0KZ7TuxfRw5Qc5QVKFJzpqpJNwdXk9l6lDZF7crkhCC7Qw6tJ/ji0Vtv4dE8lWC7z
 HKtd546IvC9wrzDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nECcT0fT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bKxqp0JN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755572157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LXnGRtwLJIDeCaqnhbqQv8+gi7GpC5ekmTCS2N9rWck=;
 b=nECcT0fTlmS30bl7ErVFZPfvi7y0y7ru5TvHEkjOvuvspeOHCuQrkWnfHC8NHc6+1hlLSw
 HJwbIZFew2zdP2l3+gIYo+b47Bo76deSarCM1Qi8umQF9ePpPgflkzUakMgfaGn+nnu1Hj
 dNAHpkST4qF5nSFaiIFB24RzIm+ZK2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755572157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LXnGRtwLJIDeCaqnhbqQv8+gi7GpC5ekmTCS2N9rWck=;
 b=bKxqp0JNI1wqMWj1LpqkwV3/g4tdyAToAEqzY7k1N+sVYfkcwcSpc785F//O5WpUqMk87h
 RMZ4KKNPXvJhdQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8B2A13686;
 Tue, 19 Aug 2025 02:55:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AuNMKbzno2jpXgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 Aug 2025 02:55:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Fabian Vogt <fvogt@suse.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, peterx@redhat.com
Subject: Re: [PATCH] hw/intc/xics: Add missing call to register
 vmstate_icp_server
In-Reply-To: <6187781.lOV4Wx5bFT@fvogt-thinkpad>
References: <6187781.lOV4Wx5bFT@fvogt-thinkpad>
Date: Mon, 18 Aug 2025 23:55:54 -0300
Message-ID: <87zfbwvx39.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 URIBL_BLOCKED(0.00)[nongnu.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,gmail.com,redhat.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 8057B2126B
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

Fabian Vogt <fvogt@suse.de> writes:

+CC Peter

> An obsolete wrapper function with a workaround was removed entirely,
> without restoring the call it wrapped.
>
> Without this, the guest is stuck after savevm/loadvm.
>

I'd note that this only affects guests that have actually negotiated
XICS, so guests using ic-mode=xive are safe.

With this patch, backward migration to QEMU versions >= 9.2 is
broken. Which I can only assume is ok, since the hard break (vmstate
gets rejected) is better than weird post-migration hangs.

If the PPC folks can spot a scenario where migration would provide
reasonable results even without the emulated interrupt controller state
being migrated, then we'll need a compat property for this.

Also, a 9.2 guest cannot move to a more recent QEMU version without a
reboot. If this is an important scenario, then the new QEMU needs to
provide some compatibility knob.

Otherwise:

Acked-by: Fabiano Rosas <farosas@suse.de>
Cc: qemu-stable@nongnu.org

