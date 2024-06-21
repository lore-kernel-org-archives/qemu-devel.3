Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C49C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiDU-0002FW-Rn; Fri, 21 Jun 2024 13:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiDS-0002Ez-Oi
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:38:26 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiDR-0000QZ-7x
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:38:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F37441F7F2;
 Fri, 21 Jun 2024 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718991504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEOhp0X74wpZ5cb7A3Gg0tumP3iDpl/x67A2N7B3tG8=;
 b=fL6LfIKq/UB0Iey/YKQVVuwixGmnAIRXpA85XmjCVgZZ++2HFmHP8o50e576KHPvorEapq
 ee5MMNY5gw/QBo9XpMMrWvyK/r6CEW+8LFVzgeInK1xoxctKR9LShkhNf0Vcj91iD1q4tT
 OmW0bTDI/Z7la4ps2h9EYo1SJufHZmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718991504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEOhp0X74wpZ5cb7A3Gg0tumP3iDpl/x67A2N7B3tG8=;
 b=xUTp0bUi7I/IEb4cbCdHd3cHqGHVODwo40gs/BwYQBZimxvpMGm31Wh1MYtpjJgoK3v6/Z
 fHgCYk0qsOALzxBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718991503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEOhp0X74wpZ5cb7A3Gg0tumP3iDpl/x67A2N7B3tG8=;
 b=snqgYOEDJQ1OksZ5yLQU6REG6TKXRgNbBEgpemF+AvhGMLmIlxflgnFEmNVI4sqc+kedX5
 kyxltJ/FrV6Z0H43tgPcDX0l1VyeNZ4TmedMDNCuclWWzz9tD6GRUOhndcH1haE0f7tGhh
 0GyYx0t9pxj1+T0hPt4z6VseFN8TG24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718991504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEOhp0X74wpZ5cb7A3Gg0tumP3iDpl/x67A2N7B3tG8=;
 b=xUTp0bUi7I/IEb4cbCdHd3cHqGHVODwo40gs/BwYQBZimxvpMGm31Wh1MYtpjJgoK3v6/Z
 fHgCYk0qsOALzxBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84C3B13AAA;
 Fri, 21 Jun 2024 17:38:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WBLOEo66dWbtZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:38:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] migration: Remove unused VMSTATE_ARRAY_TEST() macro
Date: Fri, 21 Jun 2024 14:38:17 -0300
Message-Id: <171899123149.29250.1103255118297359659.b4-ty@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621070317.9670-1-philmd@linaro.org>
References: <20240621070317.9670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-2.90)[99.56%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

On Fri, 21 Jun 2024 09:03:17 +0200, Philippe Mathieu-Daudé wrote:
> Last use of VMSTATE_ARRAY_TEST() was removed in commit 46baa9007f
> ("migration/i386: Remove old non-softfloat 64bit FP support"), we
> can safely get rid of it.
> 
> 

Queued, thanks!

