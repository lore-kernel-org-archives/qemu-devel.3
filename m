Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F17D35E3D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 20:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8QPi-0001d1-Da; Tue, 05 Nov 2024 15:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1t8QPX-0001YG-LX; Tue, 05 Nov 2024 15:44:26 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1t8QPV-0003dx-32; Tue, 05 Nov 2024 15:44:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 432FB1F88A;
 Tue,  5 Nov 2024 20:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730839456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gk+jBPxRV9t5UADI/J/aQdtFRbrUz9WrIdYSlw9FntA=;
 b=u2iC3yJsoam0/IL7jZCgHF8TFIizKkZgyJXOEol5wrLvDe6tw39sCZWd/wL8De+qEFvP1e
 Yg8SqGY4nDAPk7alqecyeg2Ec70ybrgVKO46zgzY3Nckje658Pzzi17HBlLdcSBD7I7f2C
 QEyw2y0uDG85jukwW3bko/c59FE//s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730839456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gk+jBPxRV9t5UADI/J/aQdtFRbrUz9WrIdYSlw9FntA=;
 b=UvuYCM2ZKFh1Hs73+QyTy64KztxSor9YBWLMhlzyOdgSEedZt49x7l7p9nyTi6QGt1siFc
 FEPLl6usDzHqO9Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u2iC3yJs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UvuYCM2Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730839456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gk+jBPxRV9t5UADI/J/aQdtFRbrUz9WrIdYSlw9FntA=;
 b=u2iC3yJsoam0/IL7jZCgHF8TFIizKkZgyJXOEol5wrLvDe6tw39sCZWd/wL8De+qEFvP1e
 Yg8SqGY4nDAPk7alqecyeg2Ec70ybrgVKO46zgzY3Nckje658Pzzi17HBlLdcSBD7I7f2C
 QEyw2y0uDG85jukwW3bko/c59FE//s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730839456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gk+jBPxRV9t5UADI/J/aQdtFRbrUz9WrIdYSlw9FntA=;
 b=UvuYCM2ZKFh1Hs73+QyTy64KztxSor9YBWLMhlzyOdgSEedZt49x7l7p9nyTi6QGt1siFc
 FEPLl6usDzHqO9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0CD81394A;
 Tue,  5 Nov 2024 20:44:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qmqoIZ+DKmdHEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 20:44:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, farosas@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: Re: [RFC PATCH v5 2/2] tests/qtest: QTest example for RISC-V CSR
 register
In-Reply-To: <20241105142840.59617-3-ivan.klokov@syntacore.com>
References: <20241105142840.59617-1-ivan.klokov@syntacore.com>
 <20241105142840.59617-3-ivan.klokov@syntacore.com>
Date: Tue, 05 Nov 2024 17:44:13 -0300
Message-ID: <87wmhhwgv6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 432FB1F88A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.98 / 50.00]; BAYES_HAM(-2.97)[99.87%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[nongnu.org,dabbelt.com,wdc.com,gmail.com,ventanamicro.com,linux.alibaba.com,redhat.com,syntacore.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[syntacore.com:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, suse.de:dkim,
 suse.de:mid, suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Ivan Klokov <ivan.klokov@syntacore.com> writes:

> Added demo for reading CSR register from qtest environment.
>
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

