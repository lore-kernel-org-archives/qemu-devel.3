Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830D0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 12:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZrgp-0006zE-Qp; Fri, 02 Aug 2024 08:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZrgn-0006x2-KF
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:47:21 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZrgl-0000Mo-Mc
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:47:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C28D219B0;
 Fri,  2 Aug 2024 12:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722602836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjPopi+AogEtRtml3lqI9NoiDIlORcbuZuE2YKjo2aI=;
 b=SP9eN5yPvWihRbihYBYYSRzLMF0VvQPp4/wLQDwWRT5pI+oLX++vHk+ymKl6HdJArUc9a7
 BiFiauiVEBd+HamDN94E1qsuYFJLp/P0vkSt71mlC4Yp4u963zfXF3wrLP3QWUnHnILcgp
 VcnU05j5KaTUDw++w4hy3u26YDOm+Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722602836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjPopi+AogEtRtml3lqI9NoiDIlORcbuZuE2YKjo2aI=;
 b=CEafSk7koPwuGfhc5Lz/NgVeIsarsuDo3Iq7Xvjf+qmvRct/UPWZ8wA7iF6tvMSn9+L32W
 TVvD0MzBW0vmstDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RVQuCREa;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="UFG4HdB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722602835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjPopi+AogEtRtml3lqI9NoiDIlORcbuZuE2YKjo2aI=;
 b=RVQuCREa9syoSG8OtqXDANmute9nS3tbV2wNVdF1OF6oxdps1Rb78rbENYS73xIIl3WN3M
 a5pEFTsyXwo6itrI6XLl+fPorz0wDFkBcpORLZ2birvRPTSkJGXeOwBaz22mzOl7NE9HB7
 y7wumjJAPv+bb9E6/NJet58gj352Bt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722602835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjPopi+AogEtRtml3lqI9NoiDIlORcbuZuE2YKjo2aI=;
 b=UFG4HdB/HNvCygt0ooNsm7ZLx4WzDFPvo/GIw0P0ocHk9ZxXpQ3YJsI5xaG2WrFPzeSuGo
 8gR504E3pc9HQjCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5990813999;
 Fri,  2 Aug 2024 12:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SDprCFLVrGaPYgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Aug 2024 12:47:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org,
	Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 0/2] Multifd fixes
Date: Fri,  2 Aug 2024 09:47:05 -0300
Message-Id: <172260260949.8916.4118167202139653374.b4-ty@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240801174101.31806-1-farosas@suse.de>
References: <20240801174101.31806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8C28D219B0
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

On Thu, 01 Aug 2024 14:40:59 -0300, Fabiano Rosas wrote:
> on mapped-ram for libvirt.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1397467740
> 
> Fabiano Rosas (2):
>   migration: Fix cleanup of iochannel in file migration
>   migration/multifd: Fix multifd_send_setup cleanup when channel
>     creation fails
> 
> [...]

Queued, thanks!

