Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15554C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 09:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCcUQ-00071P-8l; Thu, 30 May 2024 05:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCcUP-00071H-8C
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:54:29 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCcUN-00026k-Nl
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:54:28 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6c104f64ff6so218198a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717062865; x=1717667665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pFJzHDtmft5g8RBuvLaR9yxIK0lDH4VCI5JZiV1edk=;
 b=SpFDr0Fdtnl932T7FjegWXs+Pql8yGD3rpZ+yJaBODTF530NdlHuk5z7gMJM7A+3m3
 k9fF7+aCsVyZVdHNKrnuY56tShLpa7h3ZDxNYpkJd7X3LaxVMaR2oDLWn+vAgpRR3qsi
 mGiQ3+EtuFdVD83U6gWqaCxR5hIuwGN0sDXel1O2ZxJtDUx2oVBpIaXhguyD+34Ayy0M
 6mcxPKLOplTwd1onaYmjK4zC/ZL3zMKq3RyFUhWnO2PhOo9ZoboqlGn0fEYxe3V/kJjc
 siJ4fY3eJpYqYNYow1uec3jlzP880+4hgk7KUSWamsTS53fE4eL84oOLolyKVTY4dyGO
 SmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717062865; x=1717667665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4pFJzHDtmft5g8RBuvLaR9yxIK0lDH4VCI5JZiV1edk=;
 b=gzzL1jCrIcdHFVBQzicA+zJG9YjCYkdrzPzmAz9gQ6tv4lCwqJRYi9iY+hwt1d4WN9
 C/EgVeKmHsEe+oeDRGWoua++S7WZe2EsyWCWYZlDI+wHAFvGhY+eG5kbDF+LI5aVovh6
 kSPcQyaty+XTyndXYWLB/vTDlYDJLBg85wJYin/6MY6v8/NH8Bc51K4XoOp1hRa7nVC0
 JPLgFEcrB6ZnOBVFDpBfPFWS4F8I4U6eZSu//RYpYqrFg5WCJLXNeYhPHTNNd8fWCkyu
 GfLZ4WBAQqyux/bop9+mvjqYDmVh7QC2MVq1vIsqlsuaQAKvjo1P9BrpX7o0zK2AqIZ0
 Koow==
X-Gm-Message-State: AOJu0YwLyZOik04czI1IVA8tlE0KfC0k0jpxqNNHzAtE+5b9rgKdvPIF
 7OG0nASihlJQ/tfGuH5+eJWcGiTp6DsAK21aPKJr4HKNZHL3UfZaTVojOQfE
X-Google-Smtp-Source: AGHT+IHkxr9RTTmBrPUBp1kRKkAPwkMA2RDNlgQ8Hl5lYwZkSHRcylHxqCfxeg+tx4sGMziZEYO7tA==
X-Received: by 2002:a17:90a:f195:b0:2bd:d42a:f84e with SMTP id
 98e67ed59e1d1-2c1abc06547mr1573898a91.7.1717062865492; 
 Thu, 30 May 2024 02:54:25 -0700 (PDT)
Received: from wheely.local0.net ([1.146.0.82])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775d28asm1183626a91.8.2024.05.30.02.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 02:54:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/4] tests/qtest/migration-test: Enable test_mode_reboot
Date: Thu, 30 May 2024 19:54:05 +1000
Message-ID: <20240530095408.31608-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530095408.31608-1-npiggin@gmail.com>
References: <20240530095408.31608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fabiano pointed out this test probably is not flaky, just that it could
not run under Gitlab CI due to very small shm filesystem size in that
environment.

Now that it has moved to use /tmp instead of /dev/shm files, enable it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8bbf45313d..de380757be 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3469,15 +3469,7 @@ int main(int argc, char **argv)
                        test_precopy_file_offset);
     migration_test_add("/migration/precopy/file/offset/bad",
                        test_precopy_file_offset_bad);
-
-    /*
-     * Our CI system has problems with shared memory.
-     * Don't run this test until we find a workaround.
-     */
-    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        migration_test_add("/migration/mode/reboot", test_mode_reboot);
-    }
-
+    migration_test_add("/migration/mode/reboot", test_mode_reboot);
     migration_test_add("/migration/precopy/file/mapped-ram",
                        test_precopy_file_mapped_ram);
     migration_test_add("/migration/precopy/file/mapped-ram/live",
-- 
2.43.0


