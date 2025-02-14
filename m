Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15422C02198
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 01:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj74a-00042g-B0; Fri, 14 Feb 2025 20:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2NX-0007kk-0P
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:40 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2NS-0002Iv-Lj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:33:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41E9221186;
 Fri, 14 Feb 2025 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1N/+cx0LBjfz50VtZgJZ64SClXfdW5+6ckxPdIA8HdQ=;
 b=D/+cOCaJ5XdJHLVZGK/6sojPNS8jn3M+eRMjM9LL5Gyk4ONB0wby9qWxwNPQD39LEmWGFn
 +AfKoAlkFI6k7Mi3y5xvtZ3QmFZh9fYKnXc7oalUMZieCxVZFrJaw4o5+QmasJ9Kdd/Vmx
 l15osbnY4993EAeoOc/KVkS1lhwdUrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1N/+cx0LBjfz50VtZgJZ64SClXfdW5+6ckxPdIA8HdQ=;
 b=jP0ux9KM2vsRL7sydYfUqxr0KaqcGPQbWk6ShOmLokel06F664gB632kv5p2UI+K8Ts0/8
 Xu384j2xE60pdJCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ME5wx3qC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pHqTr8A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1N/+cx0LBjfz50VtZgJZ64SClXfdW5+6ckxPdIA8HdQ=;
 b=ME5wx3qCODYJK1JHNTynEQC0tWgflzi0SAneRD4tLWVlTsyfvYCX/McCYSDxkzFUm2+U1L
 Dqhax3TZ2pjdFGyG9+IeIkIZ+1C2s2NJdUSz4SF+wJTMSrs26Mnhr89MZpNkQvicxyZzXa
 jvOghcDXdVS5xMdH3MnkFAL0D1sQXhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1N/+cx0LBjfz50VtZgJZ64SClXfdW5+6ckxPdIA8HdQ=;
 b=pHqTr8A55WosmztRRIdlBucCKP2Lauf3FbLUoZHe4MD7+wjaUcCP64ay6GD7FfvCeOudH0
 9FGb/gwKTu5oLHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DA1613285;
 Fri, 14 Feb 2025 20:32:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eK6pFmOor2cgEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Feb 2025 20:32:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 19/22] guestperf: Support deferred migration for multifd
Date: Fri, 14 Feb 2025 17:31:56 -0300
Message-Id: <20250214203159.30168-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250214203159.30168-1-farosas@suse.de>
References: <20250214203159.30168-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 41E9221186
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_NIXSPAM_FAIL(0.00)[2a07:de40:b281:104:10:150:64:97:server fail];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

From: Hyman Huang <yong.huang@smartx.com>

The way to enable multifd migration has been changed by commit,
82137e6c8c (migration: enforce multifd and postcopy preempt to
be set before incoming), and guestperf has not made the
necessary changes. If multifd migration had been enabled in the
previous manner, the following error would have occurred:
Multifd must be set before incoming starts

Supporting deferred migration will fix it.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <8874e170f890ce0bc6f25cb0d9b9ae307ce2e070.1739530098.git.yong.huang@smartx.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/migration-stress/guestperf/engine.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/migration-stress/guestperf/engine.py b/tests/migration-stress/guestperf/engine.py
index 608d7270f6..4b15322e8d 100644
--- a/tests/migration-stress/guestperf/engine.py
+++ b/tests/migration-stress/guestperf/engine.py
@@ -106,7 +106,8 @@ def _migrate_progress(self, vm):
             info.get("dirty-limit-ring-full-time", 0),
         )
 
-    def _migrate(self, hardware, scenario, src, dst, connect_uri):
+    def _migrate(self, hardware, scenario, src,
+                 dst, connect_uri, defer_migrate):
         src_qemu_time = []
         src_vcpu_time = []
         src_pid = src.get_pid()
@@ -220,6 +221,8 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
             resp = src.cmd("migrate-set-parameters",
                            vcpu_dirty_limit=scenario._vcpu_dirty_limit)
 
+        if defer_migrate:
+            resp = dst.cmd("migrate-incoming", uri=connect_uri)
         resp = src.cmd("migrate", uri=connect_uri)
 
         post_copy = False
@@ -373,11 +376,14 @@ def _get_common_args(self, hardware, tunnelled=False):
     def _get_src_args(self, hardware):
         return self._get_common_args(hardware)
 
-    def _get_dst_args(self, hardware, uri):
+    def _get_dst_args(self, hardware, uri, defer_migrate):
         tunnelled = False
         if self._dst_host != "localhost":
             tunnelled = True
         argv = self._get_common_args(hardware, tunnelled)
+
+        if defer_migrate:
+            return argv + ["-incoming", "defer"]
         return argv + ["-incoming", uri]
 
     @staticmethod
@@ -424,6 +430,7 @@ def _get_timings(self, vm):
 
     def run(self, hardware, scenario, result_dir=os.getcwd()):
         abs_result_dir = os.path.join(result_dir, scenario._name)
+        defer_migrate = False
 
         if self._transport == "tcp":
             uri = "tcp:%s:9000" % self._dst_host
@@ -439,6 +446,9 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
             except:
                 pass
 
+        if scenario._multifd:
+            defer_migrate = True
+
         if self._dst_host != "localhost":
             dstmonaddr = ("localhost", 9001)
         else:
@@ -452,7 +462,7 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
                           monitor_address=srcmonaddr)
 
         dst = QEMUMachine(self._binary,
-                          args=self._get_dst_args(hardware, uri),
+                          args=self._get_dst_args(hardware, uri, defer_migrate),
                           wrapper=self._get_dst_wrapper(hardware),
                           name="qemu-dst-%d" % os.getpid(),
                           monitor_address=dstmonaddr)
@@ -461,7 +471,8 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
             src.launch()
             dst.launch()
 
-            ret = self._migrate(hardware, scenario, src, dst, uri)
+            ret = self._migrate(hardware, scenario, src,
+                                dst, uri, defer_migrate)
             progress_history = ret[0]
             qemu_timings = ret[1]
             vcpu_timings = ret[2]
-- 
2.35.3


