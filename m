Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAA5C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76Ee-0004pG-J1; Tue, 22 Apr 2025 01:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76CS-0002Hn-1M; Tue, 22 Apr 2025 01:29:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76CQ-0007un-FH; Tue, 22 Apr 2025 01:29:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22928d629faso45054575ad.3; 
 Mon, 21 Apr 2025 22:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299775; x=1745904575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gr7bhHNF0kj7hfwtuL868huK6XynZ7LXafxTGg/yBU=;
 b=eIDVKF6h6reUc7PzLrMDiXAoVDNFevpYYFPUa7Rtn79yjwpMaNRDNbpfwp3j7JOjml
 o/Bsh+MAAaBQ3lIwkEvCTDXlovkeMYc6VOESohobb5KtbZVsXn+CHH0xThGiRi+V+l3O
 +XNc9DV6j/YhhutKyNe247ny3txbxXPVUJacMY1+85D8zcLBcH88RZKJDOnKkRqOKpZ4
 7EQO5q9LLfdQPuW0P4AYpbgtKNujwpKJVhpmADdXLqF+RAfUsepUrdrug9pKt793smUc
 fL0xI1pYR5FgwrGIO7t3vExmfqrGwlatvJUWlofGJ+ctt5Nho72agQH9AclmJm/hd253
 BKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299775; x=1745904575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6gr7bhHNF0kj7hfwtuL868huK6XynZ7LXafxTGg/yBU=;
 b=l6INReqv0k/s3r9bgzNtNccy/Qqd0hSEl+WINCSQxvx23VWo2B5jbWEcB1XFOpqBZC
 NhN2HdYLhFndez7ey7z0GILwjsj5ARK1OnswRFFtZMtN9vUuj2m1YAE879J+SIRjeh4D
 iI99vLFkkJdiHXdLSupob5XcrMdwCD5BB8bdpaqsAHjsC0zJSjmmqKTro+5qoXhu3Pme
 ON1tXDpbrXiPKVU68yi90TrEf5rvqtxgCnjVne/uSz7hcO37Km0G5cJLr+bWeiVvvW8V
 KgDcQVCyecTnpYmIQKOadQBb+gy0FApCthvJoRQ7ivAgoeg/6LvuSGMj8vrQWM7MmPkx
 oCDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMSU8Z/b1WVdP5fx7+RjwwBJansPikN+3G5+LMNcXQC8OFxPuXriKyU5BDl9YoleeJebplqrZ5rVIePA==@nongnu.org,
 AJvYcCVT+hC5YbmY65Sreqfd5OauLOkiODmPYaUfR5fPoLtqKKchkMfv17N9E1fdeO3poDagBdW9PgNk/j4v5g==@nongnu.org,
 AJvYcCVxH0Qo4baomUVUJrih4QFgCgHdAkorVPJn9gdCVeX0n4s9wD5LVRdHJqTpXo2rd9FQvlNQRCEhNA==@nongnu.org,
 AJvYcCXI4vUiSKG27RjcEVRlmfOfz0BCK4ugMBbDzluOCpJFpM5XciRP3jCm7FnuV0fatPIAW8s1QB0ShQ0=@nongnu.org
X-Gm-Message-State: AOJu0Yw+0O3Vv8qo3KENrvR2QtvfIx1JU0RtBNzVE9Dh3gKt2kUNNP3B
 rrt5u5pJy+EUTeMYelQmSQVahG7oak2ejTtabKY3CDxTLCp2nmX8uZUV27IS
X-Gm-Gg: ASbGnculWhcvmiPmwUtUkMkXLqPQwopQINBGvLYlZ+kgp2o31L1Tg+AkwIbqCkkSwxu
 EDJyNZNpkA9kpLB22qrJUoiOTMw6rDGvK3iPs+bTlJKjfcS+OzUKtjU2Qdxkh4USH16wGhF0qWP
 eNkGNHk9KQboFngUHQbBQY2QUspnT9KjAa9Ge8tsb5VvgzzVy3LT81jGBEwvynmJhYYqsAeDMOZ
 up7ZTkbW3FIrAo7utAaStA5F+V/oNM0IlCTTXZ9JpMhbFIAV+gl+m17fsy8byqOisOYSO2fRz4M
 7aP9OQq0hEAB1HjB3+s46gAsfM6ZJQBk9n7XGoIIowvJzi4GILpR2JT0s+Q=
X-Google-Smtp-Source: AGHT+IEvwcDPz94D7S/A/DPpswvF0YESDUhtKqiVJ4FZXaM3bYPN5bTVckf7CP+ln3cnZtF4hLLr1Q==
X-Received: by 2002:a17:902:e808:b0:220:c34c:5760 with SMTP id
 d9443c01a7336-22c5361b398mr186304095ad.51.1745299775484; 
 Mon, 21 Apr 2025 22:29:35 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:29:35 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 12/20] block: Add including of ioctl header for Emscripten
 build
Date: Tue, 22 Apr 2025 14:27:16 +0900
Message-Id: <1821e79d3977c3645aa79128b823748aa9a63800.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Including <sys/ioctl.h> is still required on Emscripten, just like on other
platforms, to make the ioctl function available.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 block/file-posix.c | 4 ++++
 1 file changed, 4 insertions(+)

V2:
- Split this from the previous 12th patch into a separate commit and revised
  the commit message to clarify the purpose of the patch.

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d15..69257c0891 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -110,6 +110,10 @@
 #include <sys/diskslice.h>
 #endif
 
+#ifdef EMSCRIPTEN
+#include <sys/ioctl.h>
+#endif
+
 /* OS X does not have O_DSYNC */
 #ifndef O_DSYNC
 #ifdef O_SYNC
-- 
2.25.1


