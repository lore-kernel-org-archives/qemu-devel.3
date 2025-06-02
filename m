Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0D4C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 16:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM7wm-0005DN-AG; Mon, 02 Jun 2025 12:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uM7wh-0005D7-7S
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:23:31 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uM7we-0008Ho-ES
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 12:23:30 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E7E51F799;
 Mon,  2 Jun 2025 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748881403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HBFdGBmI4ZMHsKsvKSl+t2u3Cvzc3A5i8cRjLzadzyk=;
 b=Ssh0RYdxR/JjLQAVcc/cQiMksl43D1u+Hi9h2OiV6menTm67x6h6Df3yp99uM6R4lZOWR+
 KyKG4c8jhUDoIj2cWZW0pgb5Dt3cLp4gQ6MuP4Dcq9RP5DhNpN/AEhNP6Mhd7ZtFN2C3Qx
 gaQ5VNFQLjDR+uYV2Z3WPyZ629saYSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748881403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HBFdGBmI4ZMHsKsvKSl+t2u3Cvzc3A5i8cRjLzadzyk=;
 b=47BIsxK3G5NKBni8edT9qqUMw13DX5INkd1tBX2OykCTxQqltpH3RW8ceo3RdJ68Qxp/39
 YMnGpjVJ3R8eEHCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748881402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HBFdGBmI4ZMHsKsvKSl+t2u3Cvzc3A5i8cRjLzadzyk=;
 b=r2XQbjFH+5mJh8P7tw9SJcQy/612Fhbhl0psoBqkzl3Jxb0TYjx+GZdpE+DsLv/DiA7WrO
 oPRMyJYlRyJNTTheTb4xiXB3Oi2TwRWOyeu1rVprEtBoZxTw87Zd3aT0e+Mb0tWdvWW5b0
 GmMcXVwFqoqQ/i4Bw1V3zI2uRkSChH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748881402;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HBFdGBmI4ZMHsKsvKSl+t2u3Cvzc3A5i8cRjLzadzyk=;
 b=gbjQpKVuWabI6wHpaiOM2l714ykpqKSQRibkqywrw0EI0xW6NwKY1BAi9tnXble0DUdEGe
 UB5NxO4WOTOuZuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2D3A136C7;
 Mon,  2 Jun 2025 16:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IkPwIPnPPWgFEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Jun 2025 16:23:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com, "Dr . David Alan
 Gilbert" <dave@treblig.org>, Yanfei Xu <yanfei.xu@bytedance.com>
Subject: Re: [PATCH 11/11] migration/postcopy: Avoid clearing dirty bitmap
 for postcopy too
In-Reply-To: <20250527215850.1271072-12-peterx@redhat.com>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-12-peterx@redhat.com>
Date: Mon, 02 Jun 2025 13:23:19 -0300
Message-ID: <87y0ua3yfc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> This is a follow up on the other commit "migration/ram: avoid to do log
> clear in the last round" but for postcopy.
>
> https://lore.kernel.org/r/20250514115827.3216082-1-yanfei.xu@bytedance.com
>
> I can observe more than 10% reduction of average page fault latency during
> postcopy phase with this optimization:
>
>   Before: 268.00us (+-1.87%)
>   After:  232.67us (+-2.01%)
>
> The test was done with a 16GB VM with 80 vCPUs, running a workload that
> busy random writes to 13GB memory.
>
> Cc: Yanfei Xu <yanfei.xu@bytedance.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

