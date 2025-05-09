Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3497CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 21:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDV7G-0004ti-Lx; Fri, 09 May 2025 17:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDV7C-0004tP-Px
 for qemu-devel@nongnu.org; Fri, 09 May 2025 17:18:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uDV7B-0004Ki-3Y
 for qemu-devel@nongnu.org; Fri, 09 May 2025 17:18:42 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 94C8421172;
 Fri,  9 May 2025 21:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746825511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzR+LOf8Lq0PribY6vuOyjE5WquQhVAel4jTNq9tMRA=;
 b=MP955axpTYUJ8iNStPU8bBFzqGi/Kq2UDX5XDCazaUsRcgbRaAGp1ZBoVLy54UgtdeDP9J
 EopBQW+G6ZuLomsfcUMuSTavWV7qnOW3QA3BaNA2h0PsQKpDsnCxrxpGxE3c8ltsKfs3Ou
 ZVOO9QJs8lbJ1/faTFDawR5QAUK245k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746825511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzR+LOf8Lq0PribY6vuOyjE5WquQhVAel4jTNq9tMRA=;
 b=jZIBIweLy6SjAgjtjTavPUADHyLvG13WRSiD//64wbpgsEB2aAeWzhQdkX+qzcHMn3U+iz
 TLwF2Q9jo1846NAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MP955axp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jZIBIweL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746825511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzR+LOf8Lq0PribY6vuOyjE5WquQhVAel4jTNq9tMRA=;
 b=MP955axpTYUJ8iNStPU8bBFzqGi/Kq2UDX5XDCazaUsRcgbRaAGp1ZBoVLy54UgtdeDP9J
 EopBQW+G6ZuLomsfcUMuSTavWV7qnOW3QA3BaNA2h0PsQKpDsnCxrxpGxE3c8ltsKfs3Ou
 ZVOO9QJs8lbJ1/faTFDawR5QAUK245k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746825511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzR+LOf8Lq0PribY6vuOyjE5WquQhVAel4jTNq9tMRA=;
 b=jZIBIweLy6SjAgjtjTavPUADHyLvG13WRSiD//64wbpgsEB2aAeWzhQdkX+qzcHMn3U+iz
 TLwF2Q9jo1846NAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3783E13931;
 Fri,  9 May 2025 21:18:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QLUIOSVxHmjkNwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 May 2025 21:18:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/3] tests/qtest/cpu-plug-test: Add cpu hotplug support for
 LoongArch
Date: Fri,  9 May 2025 18:18:21 -0300
Message-Id: <20250509211821.23684-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250509211821.23684-1-farosas@suse.de>
References: <20250509211821.23684-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 94C8421172
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim]
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

From: Bibo Mao <maobibo@loongson.cn>

Add cpu hotplug testcase support for LoongArch system, it passes to
run with command "make check-qtest-loongarch64" as following:
  qemu:qtest+qtest-loongarch64 / qtest-loongarch64/cpu-plug-test OK 0.38s 1 subtests passed

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250314085130.4184272-1-maobibo@loongson.cn>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/cpu-plug-test.c | 24 ++++++++++++++++++++++++
 tests/qtest/meson.build     |  3 ++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
index 6633abfc10..44d704680b 100644
--- a/tests/qtest/cpu-plug-test.c
+++ b/tests/qtest/cpu-plug-test.c
@@ -156,6 +156,28 @@ static void add_s390x_test_case(const char *mname)
     g_free(path);
 }
 
+static void add_loongarch_test_case(const char *mname)
+{
+    char *path;
+    PlugTestData *data;
+
+    data = g_new(PlugTestData, 1);
+    data->machine = g_strdup(mname);
+    data->cpu_model = "la464";
+    data->device_model = g_strdup("la464-loongarch-cpu");
+    data->sockets = 1;
+    data->cores = 3;
+    data->threads = 1;
+    data->maxcpus = data->sockets * data->cores * data->threads;
+
+    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
+                           mname, data->sockets, data->cores,
+                           data->threads, data->maxcpus);
+    qtest_add_data_func_full(path, data, test_plug_with_device_add,
+                             test_data_free);
+    g_free(path);
+}
+
 int main(int argc, char **argv)
 {
     const char *arch = qtest_get_arch();
@@ -168,6 +190,8 @@ int main(int argc, char **argv)
         qtest_cb_for_every_machine(add_pseries_test_case, g_test_quick());
     } else if (g_str_equal(arch, "s390x")) {
         qtest_cb_for_every_machine(add_s390x_test_case, g_test_quick());
+    } else if (g_str_equal(arch, "loongarch64")) {
+        add_loongarch_test_case("virt");
     }
 
     return g_test_run();
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 3136d15e0f..7daf619845 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -148,7 +148,8 @@ qtests_hppa = \
 
 qtests_loongarch64 = qtests_filter + \
   (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? ['numa-test'] : []) + \
-  ['boot-serial-test']
+  ['boot-serial-test',
+   'cpu-plug-test']
 
 qtests_m68k = ['boot-serial-test'] + \
   qtests_filter
-- 
2.35.3


