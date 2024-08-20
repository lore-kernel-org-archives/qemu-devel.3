Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A61C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQB9-0006KZ-I8; Tue, 20 Aug 2024 10:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAv-0005je-1e
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:39 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAh-0006LW-IQ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so3494883f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165358; x=1724770158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAsHK7noev/bPNR4RNcwASEP9niT1BKYeUYjWLvcQsM=;
 b=XErvckPsnWK0oGlnAykzftnBZMoMKb53qyA35fcdKdWo/kKonbG+urq9dBYVn+UA9j
 XLSXND/6OnNcVLm6L3XrHE8bZPhopuZGlfKh8SwgnvNDc//AUTc5OMQqumypnJ1qEi5X
 A+G+Lvb6phRDsGPzJaqNxTghGsnsnaIERlIRedUub5q9z/njaupw64VO2x9bQimI66XF
 vh3v1xNey8WhLwvLpyO7CTSINI93LZ/02M/voZ9RFYv5qlbxbQxngfaIDxOIkmXlpVe3
 uS6GeZTlH5Z3uSI+jtXh9ZK+2ZvmhSkB5jaWQiF16Z6uFKsSWNYCaOq2SCWN5Ebk3ltj
 qD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165358; x=1724770158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAsHK7noev/bPNR4RNcwASEP9niT1BKYeUYjWLvcQsM=;
 b=GFFd4rXmJRknBfJsIvgl0iehD28WuKpMSKsEFGcLNwWF/pFwJgkYf5t1DZRywdUTls
 TNKF2BQepvdCvSC1KvmD55FdK/HKqPVozRPb4Yyn/YSGZ6OPkdWZ4yvRALSXHDy010lY
 vjAN8RYphZjJ8Q21oRXHa7+81YlEkL1KVIVoeB4gRNzaWW52uiqQWqX+rt6VI1G7duZb
 9kToi3d4IWeivAseMn6YSwpwkCe1Z5FN6nh2psJpFZPN9EH8YqCE57aYbOevwRyeSSHo
 icxmNFnLyXK5f/qJhYsE/8u7zXqaKoWxBCbGyW/OCjWWdnQ0X1SYuUSUS31PgKtE9Lxz
 4JAA==
X-Gm-Message-State: AOJu0YwibiiLZ+dYnkMR3YxpO5cjS33CwLZj8vRxjq47qpyxey1Mcudv
 FDrZ5f97wxpxeP95NA8aZmJu0ZGX0inq/gmR1OklBi+DR7mtEtMFiL7HGh4BDKUEgzdZxYn2nIL
 M
X-Google-Smtp-Source: AGHT+IE/5KkZylplrHDrwD7Qjrx9dt8R5kjq7PFwLQIF2+zzDrxVHH5xe4qAgRxWFps99fcnExhAiw==
X-Received: by 2002:a05:6000:e4d:b0:371:93d2:ce49 with SMTP id
 ffacd0b85a97d-3719468e998mr9256549f8f.44.1724165357684; 
 Tue, 20 Aug 2024 07:49:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a306sm13334672f8f.15.2024.08.20.07.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:49:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-9.2 7/9] tests/qtest/migration-helpers: Don't dup argument
 to qdict_put_str()
Date: Tue, 20 Aug 2024 15:49:10 +0100
Message-Id: <20240820144912.320744-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820144912.320744-1-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

In migrate_set_ports() we call qdict_put_str() with a value string
which we g_strdup(). However qdict_put_str() takes a copy of the
value string, it doesn't take ownership of it, so the g_strdup()
only results in a leak:

Direct leak of 6 byte(s) in 1 object(s) allocated from:
    #0 0x56298023713e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f13e) (BuildId: b2b9174a5a54707a7f76bca51cdc95d2aa08bac1)
    #1 0x7fba0ad39738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
    #2 0x7fba0ad4e583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
    #3 0x56298036b16e in migrate_set_ports tests/qtest/migration-helpers.c:145:49
    #4 0x56298036ad1c in migrate_qmp tests/qtest/migration-helpers.c:228:9
    #5 0x56298035b3dd in test_precopy_common tests/qtest/migration-test.c:1820:5
    #6 0x5629803549dc in test_multifd_tcp_channels_none tests/qtest/migration-test.c:3077:5
    #7 0x56298036d427 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5

Drop the unnecessary g_strdup() call.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/migration-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 7cbb9831e76..a43d180c807 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -142,7 +142,7 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
             qdict_haskey(addr, "port") &&
             (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
                 addr_port = qdict_get_str(addr, "port");
-                qdict_put_str(addrdict, "port", g_strdup(addr_port));
+                qdict_put_str(addrdict, "port", addr_port);
         }
     }
 
-- 
2.34.1


