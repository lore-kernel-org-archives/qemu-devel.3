Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512ADC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQAm-0005AD-AN; Tue, 20 Aug 2024 10:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAi-0004wU-QS
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAf-0006L4-LT
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42808071810so45306025e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165355; x=1724770155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i63bqDS44eEn4ijbQfvAhZ8JfystuRSkXcF0FbTNIZI=;
 b=XTY3PdeZq0fx1dR8IZwhhebK6GxrBiFeCzucKmt/6a6nedm3lAnnwTjUWOY8Ev1WQM
 tk4mY0oW6m+xQAeD8KU0ohDX0S/T13DtT0H3S7cQYqTNO7jQnYSBgB/ag0V6KVS+5Gql
 3hJtH9T0K3SAhXwizfLElPKp72pSxwCdBA8sjB+h9Kj0Q9+LE+psoBWCrKkfQIR7+G++
 HruDiyAR2s/1bHISfRgqZRlCldnUoqH4b6SaFy4QtnyW+S/hSbYg2buO77r3L0sq97kf
 JvqQfmi4s/zVVDR0Z0JOrN3fkGzayU2T5mZL/QUSlWLuHLmg7Ui+RZrPWyXiPNHoSYaY
 am2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165355; x=1724770155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i63bqDS44eEn4ijbQfvAhZ8JfystuRSkXcF0FbTNIZI=;
 b=mFkejoehsEGDzGdcmJrfZhNID0DtYywCCMmofUmORaCLWFh9Qv6/vZMZrZ5wASIE9/
 tk+wUHdSycORHsD0txSHPZJfnyrVYZ7DbPlOcfuekv9TZTHyHWiayKB1XO3weK4E7xMJ
 h826kYrZIdKAd93eOVE7UjcTHV6C8A7UCDEDIMQqhHzsOyvKZfnYOqwHjnrgHdpjUHUG
 N4CpsWySTDyIdkwnve2hms2TwRgD0sHwe5biK2qdePowDuHrbPO1UHw5Eh5PyN3tWyLB
 x7xPIOMlzReDFCnGh5QZQiiUxjlv405ciUErrqP3tg/cyy0XqaKBAAEZURl5uey0r8tJ
 fw0Q==
X-Gm-Message-State: AOJu0YxTIVjKf+t981Z2AkEmz3VfTUqQLr9624tcZrgNyuTVdMBKAWD/
 SD1XaFUOp7ybdLv7FRZEcFlylbknBm9jAfa1gvx37YIJBZfsQX7PpwK0fk7q+zncCmg8018BGxe
 /
X-Google-Smtp-Source: AGHT+IFJ+ckHQ3+S9h9nSmLwb0iAz36+alydO17x4JsUJkFcGASkYrvrmp9827tz4G3cvAZ0dIgtjA==
X-Received: by 2002:adf:fe0f:0:b0:371:6fb9:95a with SMTP id
 ffacd0b85a97d-371944534c0mr11032323f8f.34.1724165355021; 
 Tue, 20 Aug 2024 07:49:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a306sm13334672f8f.15.2024.08.20.07.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:49:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-9.2 2/9] tests/qtest/migration-test: Don't leak resp in
 multifd_mapped_ram_fdset_end()
Date: Tue, 20 Aug 2024 15:49:05 +0100
Message-Id: <20240820144912.320744-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820144912.320744-1-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In multifd_mapped_ram_fdset_end() we call qtest_qmp() but forgot
to unref the response QDict we get back, which means it is leaked:

Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
    #0 0x55c0c095d318 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f318) (BuildI
d: 07f667506452d6c467dbc06fd95191966d3e91b4)
    #1 0x7f186f939c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x55c0c0ae9b01 in qdict_new qobject/qdict.c:30:13
    #3 0x55c0c0afc16c in parse_object qobject/json-parser.c:317:12
    #4 0x55c0c0afb90f in parse_value qobject/json-parser.c:545:16
    #5 0x55c0c0afb579 in json_parser_parse qobject/json-parser.c:579:14
    #6 0x55c0c0afa21d in json_message_process_token qobject/json-streamer.c:92:12
    #7 0x55c0c0bca2e5 in json_lexer_feed_char qobject/json-lexer.c:313:13
    #8 0x55c0c0bc97ce in json_lexer_feed qobject/json-lexer.c:350:9
    #9 0x55c0c0afabbc in json_message_parser_feed qobject/json-streamer.c:121:5
    #10 0x55c0c09cbd52 in qmp_fd_receive tests/qtest/libqmp.c:86:9
    #11 0x55c0c09be69b in qtest_qmp_receive_dict tests/qtest/libqtest.c:760:12
    #12 0x55c0c09bca77 in qtest_qmp_receive tests/qtest/libqtest.c:741:27
    #13 0x55c0c09bee9d in qtest_vqmp tests/qtest/libqtest.c:812:12
    #14 0x55c0c09bd257 in qtest_qmp tests/qtest/libqtest.c:835:16
    #15 0x55c0c0a87747 in multifd_mapped_ram_fdset_end tests/qtest/migration-test.c:2393:12
    #16 0x55c0c0a85eb3 in test_file_common tests/qtest/migration-test.c:1978:9
    #17 0x55c0c0a746a3 in test_multifd_file_mapped_ram_fdset tests/qtest/migration-test.c:2437:5
    #18 0x55c0c0a93237 in migration_test_wrapper tests/qtest/migration-helpers.c:458:5
    #19 0x7f186f958aed in test_case_run debian/build/deb/../../../glib/gtestutils.c:2930:15
    #20 0x7f186f958aed in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3018:16
    #21 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #22 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #23 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #24 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #25 0x7f186f95880a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #26 0x7f186f958faa in g_test_run_suite debian/build/deb/../../../glib/gtestutils.c:3109:18
    #27 0x7f186f959055 in g_test_run debian/build/deb/../../../glib/gtestutils.c:2231:7
    #28 0x7f186f959055 in g_test_run debian/build/deb/../../../glib/gtestutils.c:2218:1
    #29 0x55c0c0a6e427 in main tests/qtest/migration-test.c:4033:11

Unref the object after we've confirmed that it is what we expect.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/migration-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5cf238a4f05..6aba527340b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2395,6 +2395,7 @@ static void multifd_mapped_ram_fdset_end(QTestState *from, QTestState *to,
     g_assert(qdict_haskey(resp, "return"));
     fdsets = qdict_get_qlist(resp, "return");
     g_assert(fdsets && qlist_empty(fdsets));
+    qobject_unref(resp);
 }
 
 static void *multifd_mapped_ram_fdset_dio(QTestState *from, QTestState *to)
-- 
2.34.1


