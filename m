Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1994CC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjm68-00071u-Ql; Mon, 11 Mar 2024 16:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjm66-00071H-H9
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:18:10 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjm64-0003bx-SH
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:18:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 427175CB31;
 Mon, 11 Mar 2024 20:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710188285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73udz6fq9DOi9KH2Z+SLEvZ4z4rRSC2Bn8g494J1Pdc=;
 b=wD8dSqYWKl+zdcmF37ntbJqqenxIQqLbVX625XKGBfhl+aHZvTbSv8ssDQDxncEueRK/De
 F+nADq92Nbnr7kIbOoGOqgLzp0fx00YA4psvw+Oh3tJowOExIrjt2aGWhoPNeTNY/t1fDi
 xEMiSeticjE3jZ0HLei8uiewfDzrq/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710188285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73udz6fq9DOi9KH2Z+SLEvZ4z4rRSC2Bn8g494J1Pdc=;
 b=c8dqpnuq87fdRPZj2hTy2TnkIpeylKmmvyI9mNcS+amoNWIDQBPP4q5Toq2u5rKRgiBfKq
 vdRTWUG1seJZs/CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710188285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73udz6fq9DOi9KH2Z+SLEvZ4z4rRSC2Bn8g494J1Pdc=;
 b=wD8dSqYWKl+zdcmF37ntbJqqenxIQqLbVX625XKGBfhl+aHZvTbSv8ssDQDxncEueRK/De
 F+nADq92Nbnr7kIbOoGOqgLzp0fx00YA4psvw+Oh3tJowOExIrjt2aGWhoPNeTNY/t1fDi
 xEMiSeticjE3jZ0HLei8uiewfDzrq/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710188285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73udz6fq9DOi9KH2Z+SLEvZ4z4rRSC2Bn8g494J1Pdc=;
 b=c8dqpnuq87fdRPZj2hTy2TnkIpeylKmmvyI9mNcS+amoNWIDQBPP4q5Toq2u5rKRgiBfKq
 vdRTWUG1seJZs/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9FA5136BA;
 Mon, 11 Mar 2024 20:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FEDgH/xm72XbWwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Mar 2024 20:18:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@linux.dev>, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v6 4/7] migration/multifd: Implement zero page
 transmission on the multifd thread.
In-Reply-To: <20240311180015.3359271-5-hao.xiang@linux.dev>
References: <20240311180015.3359271-1-hao.xiang@linux.dev>
 <20240311180015.3359271-5-hao.xiang@linux.dev>
Date: Mon, 11 Mar 2024 17:18:02 -0300
Message-ID: <87frwwmsjp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.44 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-0.96)[86.75%];
 URIBL_BLOCKED(0.00)[linux.dev:email,suse.de:email,bytedance.com:email];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[15];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FREEMAIL_TO(0.00)[linux.dev,redhat.com,habkost.net,gmail.com,linaro.org,huawei.com,nongnu.org];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 SUSPICIOUS_RECIPS(1.50)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Hao Xiang <hao.xiang@linux.dev> writes:

> From: Hao Xiang <hao.xiang@bytedance.com>
>
> 1. Add zero_pages field in MultiFDPacket_t.
> 2. Implements the zero page detection and handling on the multifd
> threads for non-compression, zlib and zstd compression backends.
> 3. Added a new value 'multifd' in ZeroPageDetection enumeration.
> 4. Adds zero page counters and updates multifd send/receive tracing
> format to track the newly added counters.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

