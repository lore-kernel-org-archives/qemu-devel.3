Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471FFCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hv9-0005WM-UO; Fri, 03 Oct 2025 11:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huv-0005Ro-Sw
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hu3-0007ll-Dt
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iGEtJMiuoEi1cxg4DAPq5OvbXxKkcrQDI9UI1HPhzm8=;
 b=W+aL6K7bwnbwAgXX08GEaOVPeIu/MuuIswhO3WcGtnrMuW2nnei4PfCGog3nCCp3RKZMnp
 y1oqiip/7lm6fgMsNBKga3m9Z/jTaavMzsXCrx2v0q1bsKymQCdTUO7d/Y1ajcO7ftnsT3
 o40WwNDhow060sXOXAvBa6nT16bwEs4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-eYWaebcmNlmARg7zUbDWTw-1; Fri, 03 Oct 2025 11:40:56 -0400
X-MC-Unique: eYWaebcmNlmARg7zUbDWTw-1
X-Mimecast-MFC-AGG-ID: eYWaebcmNlmARg7zUbDWTw_1759506055
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70d7c7e972eso46669116d6.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506055; x=1760110855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGEtJMiuoEi1cxg4DAPq5OvbXxKkcrQDI9UI1HPhzm8=;
 b=CCWhsdMnUIX4nje2NeJFQguSDa4RBW7ibmibKWGdKUCPOsJJlRtakS/twfPw+RZorL
 91S08Sb/XzYsmpwTk92SQnGBlWQHroc+aM7zY8GmDvwOPEq8Rdks52kw8p9FScIXWCao
 HnuBcI+VkzOcBd22hu9DYm8pIN6Rf7Q+IzTwgkbDotb5wvbe2O7tkNQl1LATuqqpxVVh
 wDDjx48V2zyX/SirnAoqBqTb6QLDni/1i3+Fnx5IwQco1v/eW5dbjOUutfrdgR51apj+
 J2d8wYHalhQJ5nopGPn2t0+2D29TzN4gDROhGf/4219Pfz6Qmppr9dQeOtHXpl0Y6rYa
 CCUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Gi9qbyLAsBb1lxG1Fet2SvPCkHpFq/zaW0tEX7YPcHInpE7Yqne8Og3925YsRHRBnkctN81rrINW@nongnu.org
X-Gm-Message-State: AOJu0YzBqXC1LNslYTa4eQZFGJ/6VFIqjdUv0uLduRBUmsRZObwf2uIP
 CPQZ0VZEnnjiaOQibCoj6qljK8HMN3o4r0Ia1FSQqVuxkMPVK0p7rORQN227og8pTsOVQB91jgM
 2RwIJsmtogOolSPGgZpOsBSybrHPp8qUsRcce+OzMEIXZXsMnOfOG4T8U
X-Gm-Gg: ASbGncspVwlSVQ/JRf7wQMwFb+FjAzDhYFzQbs1N5jrPrpRCsvfiIbAbMqRq+7uHryp
 4qL1dPIuVnFsnbGuQBqfi4js1Fo5B1j78f+YrswujYrSpEoNEwVhph/roQf5rcW/kvWbIkS1AmD
 h6PlpROBCPQQIqr+1bxL3EA2TwW9BGok0BpAwxL6FrMYfNiRcK2DUsQNwBoVuQlgZL64FwMm5cn
 rW5Jb/ABxt9DlJJBmyaXjPP8ftwUtl5MK9+LAel2thqnudvSZi9q8g2ZZBIsYKnNIMhSkxnsqZE
 RCNOi/Vpu+VWtwqfrbTY1Pkn1Hb6arlxshkpcg==
X-Received: by 2002:a05:6214:1245:b0:812:c072:db14 with SMTP id
 6a1803df08f44-879dc8824f3mr49992656d6.50.1759506055318; 
 Fri, 03 Oct 2025 08:40:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9WQJ5edj76YIQhurQzJWjWnrVI4yEgqP19M3z77aTpbNnoiiERE2r/eoskaQ4RriiiLO3gg==
X-Received: by 2002:a05:6214:1245:b0:812:c072:db14 with SMTP id
 6a1803df08f44-879dc8824f3mr49992086d6.50.1759506054666; 
 Fri, 03 Oct 2025 08:40:54 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 45/45] migration-test: test cpr-exec
Date: Fri,  3 Oct 2025 11:39:48 -0400
Message-ID: <20251003153948.1304776-46-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Add a test for the cpr-exec migration mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1759332851-370353-20-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/cpr-tests.c | 133 ++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index c4ce60ff66..9388ad64be 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -113,6 +113,138 @@ static void test_mode_transfer_defer(void)
     test_mode_transfer_common(true);
 }
 
+static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
+{
+    g_autofree char *qtest_from_args = NULL;
+    g_autofree char *from_args = NULL;
+    g_autofree char *to_args = NULL;
+    g_autofree char *exec_args = NULL;
+    g_auto(GStrv) argv = NULL;
+    char *from_str, *src, *dst;
+    int ret;
+
+    /*
+     * hide_stderr appends "2>/dev/null" to the command line, but cpr-exec
+     * passes the command-line words to execv, not to the shell, so suppress it
+     * here.  fd 2 was already bound in the source VM, and execv preserves it.
+     */
+    g_assert(args->start.hide_stderr == false);
+
+    ret = migrate_args(&from_args, &to_args, args->listen_uri, &args->start);
+    g_assert(!ret);
+    qtest_from_args = qtest_qemu_args(from_args);
+
+    /*
+     * The generated args may have been formatted using "%s %s" with empty
+     * strings, which can produce consecutive spaces, which g_strsplit would
+     * convert into empty strings.  Ditto for leading and trailing space.
+     * De-dup spaces to avoid that.
+     */
+
+    from_str = src = dst = g_strstrip(qtest_from_args);
+    do {
+        if (*src != ' ' || src[-1] != ' ') {
+            *dst++ = *src;
+        }
+    } while (*src++);
+
+    exec_args = g_strconcat(qtest_qemu_binary(migration_get_env()->qemu_dst),
+                            " -incoming defer ", from_str, NULL);
+    argv = g_strsplit(exec_args, " ", -1);
+    migrate_set_parameter_strv(who, "cpr-exec-command", argv);
+}
+
+static void wait_for_migration_event(QTestState *who, const char *waitfor)
+{
+    QDict *rsp, *data;
+    char *status;
+    bool done = false;
+
+    while (!done) {
+        rsp = qtest_qmp_eventwait_ref(who, "MIGRATION");
+        g_assert(qdict_haskey(rsp, "data"));
+        data = qdict_get_qdict(rsp, "data");
+        g_assert(qdict_haskey(data, "status"));
+        status = g_strdup(qdict_get_str(data, "status"));
+        g_assert(strcmp(status, "failed"));
+        done = !strcmp(status, waitfor);
+        qobject_unref(rsp);
+    }
+}
+
+static void test_cpr_exec(MigrateCommon *args)
+{
+    QTestState *from, *to;
+    void *data_hook = NULL;
+    g_autofree char *connect_uri = g_strdup(args->connect_uri);
+    g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
+                                                FILE_TEST_FILENAME);
+
+    if (migrate_start(&from, NULL, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    /* Source and dest never run concurrently */
+    g_assert_false(args->live);
+
+    if (args->start_hook) {
+        data_hook = args->start_hook(from, NULL);
+    }
+
+    wait_for_serial("src_serial");
+    set_cpr_exec_args(from, args);
+    migrate_set_capability(from, "events", true);
+    migrate_qmp(from, NULL, connect_uri, NULL, "{}");
+    wait_for_migration_event(from, "completed");
+
+    to = qtest_init_after_exec(from);
+
+    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+                             "  'arguments': { "
+                             "      'channels': [ { 'channel-type': 'main',"
+                             "      'addr': { 'transport': 'file',"
+                             "                'filename': %s,"
+                             "                'offset': 0  } } ] } }",
+                             filename);
+    wait_for_migration_complete(to);
+
+    wait_for_resume(to, get_dst());
+    /* Device on target is still named src_serial because args do not change */
+    wait_for_serial("src_serial");
+
+    if (args->end_hook) {
+        args->end_hook(from, to, data_hook);
+    }
+
+    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+}
+
+static void *test_mode_exec_start(QTestState *from, QTestState *to)
+{
+    assert(!to);
+    migrate_set_parameter_str(from, "mode", "cpr-exec");
+    return NULL;
+}
+
+static void test_mode_exec(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    g_autofree char *listen_uri = g_strdup_printf("defer");
+
+    MigrateCommon args = {
+        .start.only_source = true,
+        .start.opts_source = "-machine aux-ram-share=on -nodefaults",
+        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
+                                " -machine memory-backend=pc.ram",
+        .connect_uri = uri,
+        .listen_uri = listen_uri,
+        .start_hook = test_mode_exec_start,
+    };
+
+    test_cpr_exec(&args);
+}
+
 void migration_test_add_cpr(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
@@ -135,5 +267,6 @@ void migration_test_add_cpr(MigrationTestEnv *env)
         migration_test_add("/migration/mode/transfer", test_mode_transfer);
         migration_test_add("/migration/mode/transfer/defer",
                            test_mode_transfer_defer);
+        migration_test_add("/migration/mode/exec", test_mode_exec);
     }
 }
-- 
2.50.1


