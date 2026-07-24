Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5996C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHgm-00018Z-KN; Fri, 24 Jul 2026 11:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wnHgl-00018I-Tu
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:19:51 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wnHgk-0007qG-GE
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:19:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A357F7B963;
 Fri, 24 Jul 2026 15:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784906381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3E4i5VkUNKi9DknUCgacJVt7r+iB4bswteC3aqWgk4=;
 b=d7M6GYaK6c41S3pGWUWPPRqKrLi5Aen54Pza9jlTuzQnSdCE0BAh5PD3NGzL1D86to8R+/
 FoDaCkya+2PK4CvQkuK5VErsligLwwVZQ5/wSLoFk3o3SbMxKHDp2aUvXvst5QI3zxgrK5
 7HwRRVV7FLwlA/PJn02j2xcz+lMP3so=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784906381;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3E4i5VkUNKi9DknUCgacJVt7r+iB4bswteC3aqWgk4=;
 b=jl9ENDOnsAOUXcwYNRV1yWG0arzLzvZaw5L5WB1516DNkii+z9fKkAi9Izsl7PxmalHnuo
 24M2r/CYsdOxJcAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784906381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3E4i5VkUNKi9DknUCgacJVt7r+iB4bswteC3aqWgk4=;
 b=d7M6GYaK6c41S3pGWUWPPRqKrLi5Aen54Pza9jlTuzQnSdCE0BAh5PD3NGzL1D86to8R+/
 FoDaCkya+2PK4CvQkuK5VErsligLwwVZQ5/wSLoFk3o3SbMxKHDp2aUvXvst5QI3zxgrK5
 7HwRRVV7FLwlA/PJn02j2xcz+lMP3so=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784906381;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3E4i5VkUNKi9DknUCgacJVt7r+iB4bswteC3aqWgk4=;
 b=jl9ENDOnsAOUXcwYNRV1yWG0arzLzvZaw5L5WB1516DNkii+z9fKkAi9Izsl7PxmalHnuo
 24M2r/CYsdOxJcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D141779C3;
 Fri, 24 Jul 2026 15:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aB95E4yCY2pDDQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 24 Jul 2026 15:19:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] contribute: Fix broken hyperlink to the report a bug
 section
Date: Fri, 24 Jul 2026 12:19:35 -0300
Message-ID: <20260724151936.3332290-2-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724151936.3332290-1-farosas@suse.de>
References: <20260724151936.3332290-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 contribute/security-process.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contribute/security-process.md b/contribute/security-process.md
index 0ec1952..b65e9ee 100644
--- a/contribute/security-process.md
+++ b/contribute/security-process.md
@@ -7,7 +7,7 @@ permalink: /contribute/security-process/
 
 **The QEMU project no longer accepts security issue disclosures via email.**
 
-New disclosures must follow the [report a bug](report-a-bug.html)
+New disclosures must follow the [report a bug](../report-a-bug)
 process to file a GitLab issue (work item) for each potential issue,
 ***marking it as "*confidential*" prior to submission.***
 
-- 
2.53.0


