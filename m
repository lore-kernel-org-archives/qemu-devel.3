Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5449AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb4CM-0001LU-D4; Mon, 05 Aug 2024 16:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sb4CJ-00010B-Mw
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:20:52 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sb4CH-00022H-MP
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:20:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E39F21C89;
 Mon,  5 Aug 2024 20:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722889246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ikF+DtANi/r1AIRSe1GmX1n1cKKTQvrQZuBTXHOwalI=;
 b=XqqfGX4GEvYN2vlqyVfv6G2S0Y9UbKzindYdOrvWManozI4LqWQ4BaYVc+seZZjG1KwPwQ
 2oJmFg6FjN59nstIN4HKq6kjK/6ZXZIayq31ePVeSHJmKueOadD9JEkxdUQQWhCvlkDFYU
 E2O8Yy9UM4UhcoLPspdtVl8BxRB80o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722889246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ikF+DtANi/r1AIRSe1GmX1n1cKKTQvrQZuBTXHOwalI=;
 b=VoakXUJf7UNGU/ZK9rrNZqSqDQ/w7mDwUvLKaySxuyE9FayNgeptz6FU6pbTfyPd2HnxXI
 tHZoEmTmFuLB2sBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XqqfGX4G;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VoakXUJf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722889246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ikF+DtANi/r1AIRSe1GmX1n1cKKTQvrQZuBTXHOwalI=;
 b=XqqfGX4GEvYN2vlqyVfv6G2S0Y9UbKzindYdOrvWManozI4LqWQ4BaYVc+seZZjG1KwPwQ
 2oJmFg6FjN59nstIN4HKq6kjK/6ZXZIayq31ePVeSHJmKueOadD9JEkxdUQQWhCvlkDFYU
 E2O8Yy9UM4UhcoLPspdtVl8BxRB80o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722889246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ikF+DtANi/r1AIRSe1GmX1n1cKKTQvrQZuBTXHOwalI=;
 b=VoakXUJf7UNGU/ZK9rrNZqSqDQ/w7mDwUvLKaySxuyE9FayNgeptz6FU6pbTfyPd2HnxXI
 tHZoEmTmFuLB2sBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07FF513254;
 Mon,  5 Aug 2024 20:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fYYNMBs0sWYcNAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Aug 2024 20:20:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jpoimboe@kernel.org,
 Babu Moger <babu.moger@amd.com>, Dario Faggioli <dfaggioli@suse.com>,
 Fabian Vogt <fvogt@suse.de>, Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] target/i386: Expose IBPB-BRTYPE and SBPB CPUID bits to the
 guest
Date: Mon,  5 Aug 2024 17:20:41 -0300
Message-Id: <20240805202041.5936-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1E39F21C89
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

According to AMD's Speculative Return Stack Overflow whitepaper (link
below), the hypervisor should synthesize the value of IBPB_BRTYPE and
SBPB CPUID bits to the guest.

Support for this is already present in the kernel with commit
e47d86083c66 ("KVM: x86: Add SBPB support") and commit 6f0f23ef76be
("KVM: x86: Add IBPB_BRTYPE support").

Add support in QEMU to expose the bits to the guest OS.

host:
  # cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
  Mitigation: Safe RET

before (guest):
  $ cpuid -l 0x80000021 -1 -r
  0x80000021 0x00: eax=0x00000045 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
                            ^
  $ cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
  Vulnerable: Safe RET, no microcode

after (guest):
  $ cpuid -l 0x80000021 -1 -r
  0x80000021 0x00: eax=0x18000045 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
                            ^
  $ cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
  Mitigation: Safe RET

Reported-by: Fabian Vogt <fvogt@suse.de>
Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
More info on this thread:
https://lore.kernel.org/r/68f8b8b1ca1bf58b059f52afbd1c9c51108a074a.camel@suse.com
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c0..d33401c922 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1221,8 +1221,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "sbpb",
+            "ibpb-brtype", NULL, NULL, NULL,
         },
         .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
         .tcg_features = 0,
-- 
2.35.3


