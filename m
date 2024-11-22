Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146C6D75E3C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 13:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tETPS-0002UF-K2; Fri, 22 Nov 2024 08:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tETPN-0002Px-Gh
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:09:13 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tETPM-0005WY-5E
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:09:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B72BB2115B;
 Fri, 22 Nov 2024 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732280946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcWfgLRj/+rJ52po7YzJAFA4+0Iqgy/ytXrPyeyaDMg=;
 b=up4iM1ZEr+Q8dXg5iaXMrl0esTH0E0fB4C2T0RYxHfFgGxag01DBk8ll8iElrLBuIknYKH
 I9y8qZshPpVzQ+FzCFhoz/fOnM83uSRG/SUdvj7czvY46AJS8MwiA4eBusTJpKRcpDIv8P
 1WY9u5AGARhhibRI/vl2siJ+wxSFCqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732280946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcWfgLRj/+rJ52po7YzJAFA4+0Iqgy/ytXrPyeyaDMg=;
 b=qHYHfg5qNtcZCI+qR7LlCRLryhLz4PWtSwEQ+nYVwuLR2OuryufGdGb+CIXQo4t1+hEUUU
 tnhhxldy/3cDeCAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=up4iM1ZE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qHYHfg5q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732280946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcWfgLRj/+rJ52po7YzJAFA4+0Iqgy/ytXrPyeyaDMg=;
 b=up4iM1ZEr+Q8dXg5iaXMrl0esTH0E0fB4C2T0RYxHfFgGxag01DBk8ll8iElrLBuIknYKH
 I9y8qZshPpVzQ+FzCFhoz/fOnM83uSRG/SUdvj7czvY46AJS8MwiA4eBusTJpKRcpDIv8P
 1WY9u5AGARhhibRI/vl2siJ+wxSFCqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732280946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcWfgLRj/+rJ52po7YzJAFA4+0Iqgy/ytXrPyeyaDMg=;
 b=qHYHfg5qNtcZCI+qR7LlCRLryhLz4PWtSwEQ+nYVwuLR2OuryufGdGb+CIXQo4t1+hEUUU
 tnhhxldy/3cDeCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1479813998;
 Fri, 22 Nov 2024 13:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d0cAM3CCQGdbUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 22 Nov 2024 13:09:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roque Arcudia Hernandez <roqueh@google.com>
Subject: Re: [PATCH 0/3] qtest: Provide and use function for doing system reset
Date: Fri, 22 Nov 2024 10:07:01 -0300
Message-Id: <173228070905.21431.9439732271678199860.b4-ty@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241115165041.1148095-1-peter.maydell@linaro.org>
References: <20241115165041.1148095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B72BB2115B
X-Spamd-Result: default: False [-4.49 / 50.00]; BAYES_HAM(-2.98)[99.90%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 MID_RHS_MATCH_FROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Fri, 15 Nov 2024 16:50:38 +0000, Peter Maydell wrote:
> I noticed while reviewing Roque's patchset that adds tests
> for the CMSDK watchdog device that we are gradually accumulating
> tests in tests/qtest which open-code "now reset the QEMU system".
> Moreover, several of those tests get it wrong, by failing to
> wait for the QMP RESET event that signals that the reset has
> completed.
> 
> [...]

Queued, thanks!

