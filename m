Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D34CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpO0-0006s8-QT; Wed, 04 Sep 2024 08:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNr-00068M-BC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:45:16 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNm-0005sl-Fq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:45:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40E8D1F7C5;
 Wed,  4 Sep 2024 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fVnmqMUCoeEJ0o7aTnw/7to6eULdZeK0MhAeGNEGjY=;
 b=kSSWvKkQmubgT96I5fYS/c0d73GGuchBSdpRQ83iHlj8gwNehJBii7mAfSlYSK8V+3vRXF
 QRCqwHz++7RjMlp9D2l3tpUCEUadOMvV2EVh9xwXb4we00BaqihtZn4y8lzl6a4a11gT3z
 BwxD/6Hn6yUUGKF9e4JGwk1eOIo8EX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fVnmqMUCoeEJ0o7aTnw/7to6eULdZeK0MhAeGNEGjY=;
 b=2h0xyeOgzo7XikCgvQ4yjo5hatoya1pNKQ0fXl0Ehso7XY2Sr/sv6+xBSht/2fD6qfcicU
 wMGAwGGCrD4LRODw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fVnmqMUCoeEJ0o7aTnw/7to6eULdZeK0MhAeGNEGjY=;
 b=kSSWvKkQmubgT96I5fYS/c0d73GGuchBSdpRQ83iHlj8gwNehJBii7mAfSlYSK8V+3vRXF
 QRCqwHz++7RjMlp9D2l3tpUCEUadOMvV2EVh9xwXb4we00BaqihtZn4y8lzl6a4a11gT3z
 BwxD/6Hn6yUUGKF9e4JGwk1eOIo8EX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fVnmqMUCoeEJ0o7aTnw/7to6eULdZeK0MhAeGNEGjY=;
 b=2h0xyeOgzo7XikCgvQ4yjo5hatoya1pNKQ0fXl0Ehso7XY2Sr/sv6+xBSht/2fD6qfcicU
 wMGAwGGCrD4LRODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB761139D2;
 Wed,  4 Sep 2024 12:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4Ko3JFNW2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:45:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/34] migration/multifd: Make MultiFDMethods const
Date: Wed,  4 Sep 2024 09:44:11 -0300
Message-Id: <20240904124417.14565-29-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.988]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The methods are defined at module_init time and don't ever
change. Make them const.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-nocomp.c | 2 +-
 migration/multifd-qpl.c    | 2 +-
 migration/multifd-uadk.c   | 2 +-
 migration/multifd-zlib.c   | 2 +-
 migration/multifd-zstd.c   | 2 +-
 migration/multifd.c        | 8 ++++----
 migration/multifd.h        | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 53ea9f9c83..f294d1b0b2 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -377,7 +377,7 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
     return true;
 }
 
-static MultiFDMethods multifd_nocomp_ops = {
+static const MultiFDMethods multifd_nocomp_ops = {
     .send_setup = multifd_nocomp_send_setup,
     .send_cleanup = multifd_nocomp_send_cleanup,
     .send_prepare = multifd_nocomp_send_prepare,
diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 75041a4c4d..b0f1e2ba46 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -694,7 +694,7 @@ static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
     return multifd_qpl_decompress_pages_slow_path(p, errp);
 }
 
-static MultiFDMethods multifd_qpl_ops = {
+static const MultiFDMethods multifd_qpl_ops = {
     .send_setup = multifd_qpl_send_setup,
     .send_cleanup = multifd_qpl_send_cleanup,
     .send_prepare = multifd_qpl_send_prepare,
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index db2549f59b..89f6a72f0e 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -305,7 +305,7 @@ static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
-static MultiFDMethods multifd_uadk_ops = {
+static const MultiFDMethods multifd_uadk_ops = {
     .send_setup = multifd_uadk_send_setup,
     .send_cleanup = multifd_uadk_send_cleanup,
     .send_prepare = multifd_uadk_send_prepare,
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 6787538762..8cf8a26bb4 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -277,7 +277,7 @@ static int multifd_zlib_recv(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
-static MultiFDMethods multifd_zlib_ops = {
+static const MultiFDMethods multifd_zlib_ops = {
     .send_setup = multifd_zlib_send_setup,
     .send_cleanup = multifd_zlib_send_cleanup,
     .send_prepare = multifd_zlib_send_prepare,
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 1576b1e2ad..53da33e048 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -265,7 +265,7 @@ static int multifd_zstd_recv(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
-static MultiFDMethods multifd_zstd_ops = {
+static const MultiFDMethods multifd_zstd_ops = {
     .send_setup = multifd_zstd_send_setup,
     .send_cleanup = multifd_zstd_send_cleanup,
     .send_prepare = multifd_zstd_send_prepare,
diff --git a/migration/multifd.c b/migration/multifd.c
index 0c07a2040b..b89715fdc2 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -76,7 +76,7 @@ struct {
      */
     int exiting;
     /* multifd ops */
-    MultiFDMethods *ops;
+    const MultiFDMethods *ops;
 } *multifd_send_state;
 
 struct {
@@ -93,7 +93,7 @@ struct {
     uint64_t packet_num;
     int exiting;
     /* multifd ops */
-    MultiFDMethods *ops;
+    const MultiFDMethods *ops;
 } *multifd_recv_state;
 
 MultiFDSendData *multifd_send_data_alloc(void)
@@ -128,9 +128,9 @@ void multifd_send_channel_created(void)
     qemu_sem_post(&multifd_send_state->channels_created);
 }
 
-static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {};
+static const MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {};
 
-void multifd_register_ops(int method, MultiFDMethods *ops)
+void multifd_register_ops(int method, const MultiFDMethods *ops)
 {
     assert(0 <= method && method < MULTIFD_COMPRESSION__MAX);
     assert(!multifd_ops[method]);
diff --git a/migration/multifd.h b/migration/multifd.h
index a3e35196d1..13e7a88c01 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -243,7 +243,7 @@ typedef struct {
     int (*recv)(MultiFDRecvParams *p, Error **errp);
 } MultiFDMethods;
 
-void multifd_register_ops(int method, MultiFDMethods *ops);
+void multifd_register_ops(int method, const MultiFDMethods *ops);
 void multifd_send_fill_packet(MultiFDSendParams *p);
 bool multifd_send_prepare_common(MultiFDSendParams *p);
 void multifd_send_zero_page_detect(MultiFDSendParams *p);
-- 
2.35.3


