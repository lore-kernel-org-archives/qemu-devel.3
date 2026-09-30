Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB21CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 22:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC2Wq-0007wd-KU; Wed, 30 Sep 2026 18:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2Wa-0007v4-3k
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:41 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xC2WW-00051a-LW
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 18:11:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F7951FB95;
 Wed, 30 Sep 2026 22:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR0QL9shiCxvWQrrGSUIvcMDrpiDFHvfxGXPJwlQC4A=;
 b=uNOwlQQAxn9fcwbz7EM8JOi+ZES72VEN1Qr6/MX1/F9s55boO3IHA2HmpIUqI3vLyIVMYk
 jQees+qBzMf0MkQ1JOOj7ifFQrTBSGvcX8ZeBWgy7AWM25HaUydS6pMVL0dck9OPHGz3PC
 8GD51lnSqFDJqzFoTx+UsAItFbQG7bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR0QL9shiCxvWQrrGSUIvcMDrpiDFHvfxGXPJwlQC4A=;
 b=QeABxkTR3AcmunLmoQqfN2A8OUT5ejzlViQA5mTNgryR4fk1dtqAGQhNTVRRwUKLmrAYJk
 zsqeZK2ILMQQrICA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790806287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR0QL9shiCxvWQrrGSUIvcMDrpiDFHvfxGXPJwlQC4A=;
 b=P3lrX0y6jSVJQHoCF59haNEqxwZgRmtbAuLMSB+rWSAi+MUud09oqiAHIbh3Nl0gyB8UGg
 zNHUH6UThdPz4UJxja9WAsBOLGtFXG5bLaBfMmTYG/l+zXD0g70KYMH3/GaWUCboS3DDRu
 3/1HjQHI6kM8GklzgJJbNmEacaaSDHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790806287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XR0QL9shiCxvWQrrGSUIvcMDrpiDFHvfxGXPJwlQC4A=;
 b=nuagZieyxTSFiiqd/m9+6qjDmOJ6jzypZH+18RYSpX5IZLrzu0GTfHfDsiWYPEKwzg2WVV
 oYdoSnV0DNB38CAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F269313B22;
 Wed, 30 Sep 2026 22:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id befqOAqJvWpwXAAAD6G6ig:T3
 (envelope-from <farosas@suse.de>); Wed, 30 Sep 2026 22:11:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 02/11] tests/unit/test-qemu-opts: Validate help=foo options
Date: Wed, 30 Sep 2026 19:10:56 -0300
Message-ID: <20260930221105.2262063-3-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930221105.2262063-1-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

The test_has_help_option currently tests two functions:
has_help_option() and qemu_opt_has_help_opt(). The former is only used
by qemu-img and has a significant difference from the latter, which is
used by QOM and qdev:

- has_help_option() REJECTS help=on and all variants that provide a
value, including invalid ones such as help=foo.

- qemu_opt_has_help_opt() ACCEPTS help=on and all variants that
  provide a value, including invalid ones such as help=foo.

Add a new test that validates these cases separately.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/unit/test-qemu-opts.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/unit/test-qemu-opts.c b/tests/unit/test-qemu-opts.c
index 8d03a69f7c..4ccb79d406 100644
--- a/tests/unit/test-qemu-opts.c
+++ b/tests/unit/test-qemu-opts.c
@@ -750,6 +750,31 @@ static void test_has_help_option(void)
     }
 }
 
+static void test_has_help_option_with_value(void)
+{
+    static const struct {
+        const char *params;
+    } test[] = {
+        { "help=on" },
+        { "help=off" },
+        { "help=foo" },
+        { "help=" },
+    };
+    int i;
+    QemuOpts *opts;
+
+    for (i = 0; i < ARRAY_SIZE(test); i++) {
+        /* reject all */
+        g_assert_cmpint(has_help_option(test[i].params), ==, false);
+
+        /* accept all */
+        opts = qemu_opts_parse(&opts_list_03, test[i].params, false,
+                               &error_abort);
+        g_assert_cmpint(qemu_opt_has_help_opt(opts), ==, true);
+        qemu_opts_del(opts);
+    }
+}
+
 static void append_verify_list_01(QemuOptDesc *desc, bool with_overlapping)
 {
     int i = 0;
@@ -1012,6 +1037,8 @@ int main(int argc, char *argv[])
     g_test_add_func("/qemu-opts/opts_parse/number", test_opts_parse_number);
     g_test_add_func("/qemu-opts/opts_parse/size", test_opts_parse_size);
     g_test_add_func("/qemu-opts/has_help_option", test_has_help_option);
+    g_test_add_func("/qemu-opts/has_help_option_with_value",
+                    test_has_help_option_with_value);
     g_test_add_func("/qemu-opts/append_to_null", test_opts_append_to_null);
     g_test_add_func("/qemu-opts/append", test_opts_append);
     g_test_add_func("/qemu-opts/to_qdict/basic", test_opts_to_qdict_basic);
-- 
2.53.0


