Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D31CC9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHtU-0002aA-MF; Mon, 12 Jan 2026 08:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtQ-0002UM-0u
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtN-0003go-UZ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fe/dGeMhV+z9VZQ3DIrLaWoG9yC5tlBJFvMhJmKEvDU=;
 b=SFeMNFyu9MbQDo6p8zdrn4BgyExQENlJInSu4Z22gHkEHJjYYjvBUfLKXVG2asq+eqEtdj
 ExpNF+aT25x2dRTryzTd7RHxrBWyAjazzEyx8lBx9/tinbhljb259BL1grd4iUvEMnE9+9
 yC7StETvTwJi+nJ9fvwLenFPcxBrpx8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-uy3sWtF1OAG4h8SgpkgqSQ-1; Mon, 12 Jan 2026 08:23:31 -0500
X-MC-Unique: uy3sWtF1OAG4h8SgpkgqSQ-1
X-Mimecast-MFC-AGG-ID: uy3sWtF1OAG4h8SgpkgqSQ_1768224211
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a089575ab3so69012475ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224210; x=1768829010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fe/dGeMhV+z9VZQ3DIrLaWoG9yC5tlBJFvMhJmKEvDU=;
 b=Mstf7sAmqTv6fR+F0gfc5wCOYfEwB0Ht357T90k84k5DkK7xDGxUV5AuTPA4a0SjU4
 6d2MtL4OPQXNGH8pQPzOjthPFaYVnOEbQtUlfhpRM6EByU4dYlnmaZhtvW2LtiV6mPis
 /jB7f4MGu0ezjsq2Nyy/0F1s0xRYM8OCxzHWgPwvAsTvNdd6oq2on7dMAh2ScAGMhe0+
 CrMfs3Y3q936/Pu6Z6fR2ZXFjhReJY2PnDvQ3/Xkg7gwOdE93z8+eNtEqlbw8aSv5Xes
 KD0sJvfErS0YLdw2Or2PBlChCb7nnH/Ldf6BMuCOdY/+fHqy8ndJFJlTABKrxUD6affR
 T1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224210; x=1768829010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fe/dGeMhV+z9VZQ3DIrLaWoG9yC5tlBJFvMhJmKEvDU=;
 b=rntSU/UHDFnem0WWGJA0thgxdPZIJWiY468PtOTkiX8tYUa9toy91RXcw9HRgIIupr
 bmjR7HXpl0/9KEycowvW/TADwrJV3qTdQc+gQMZNmJt9t2Aui0n7EYnPbYLVxGoeaAkC
 V8/1LQPgap+phuOHZpKeRyGIbk8G/A1PTGHkiNu/l1dyK3gAi/VrDgdGlai/5W9TFicg
 XVAb9WRpnhrMAQmDga+mRRnZeEEMd61+pnnhEkhKjVa9oGepk4cHK2Pn0/Phak1lyQgt
 VxqsElA3djvEFEXJhMdgUP+cD395/+93XjZuA+NjoFSbvagIs/CEViFJJU+yMH9fslxV
 2VHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbxFDmkLoNOHyP4BZyEoZbblRKpnwyDLBg+0Gb7CVZ5fLAhn/KhoQgv0FuK2eH4NTHfTWfL8KSKqi3@nongnu.org
X-Gm-Message-State: AOJu0Ywmp+akVyOxk2xKOp3TeC0CFtuGgvN7nOzmL+zfzswrShWsc81y
 HrROKn7HixGV3LeHjUBIY0GF5f03Q0nhkQmGpGKJ2EQ8kYqUoVwHaFQKcLiszTOVxMoNnq12mFf
 HeynXLYNW2MlhCZgSf03Xp1UP6vFhqc7BZzvKodsxeeDbatbbooDu61dd
X-Gm-Gg: AY/fxX67D8/vU3ED/M3BxZDae8CEg534ul8YmSEae1OtE9oMUruvoH9MU9/G/48gqgO
 yImi5p3IELN6j++36neDjKN8Zq+kuZGt06SUKGPhbWgGWQA2E4F8WnXV+svcyGBpN4TifKSvXhD
 fLlu6e+NUSwKbvht9tNh8ETE521+aLIqyNrFJirXV3SQxM+Wywn2SfRz4Pb5TjJNbv1YM25xXp1
 ZbaW4uS55Wmc70q5J/V9eir9IwoNUyZttkg8mmRClGuyYBj9gwNhB22YzAbRfMbJUcyaaa2Urdw
 4iacxuNa7MgwVWRzeo8U8QxXnKvbovkMYSpz7bVga0naa/lmZO1whnGU7jv5q2V5FYP1+O7TcEx
 xY9ezPdx9vwLZjPaP+JUNX/D7I1DlqTA01jsAlaYcaPg=
X-Received: by 2002:a17:902:c942:b0:2a0:9fc8:a98b with SMTP id
 d9443c01a7336-2a3ee4bfbcbmr174766185ad.40.1768224210550; 
 Mon, 12 Jan 2026 05:23:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPGYbyVi9tDvyyrOxBOltQV/g9GuHqjDTo1e0zBtMmMF7qITdYQbkP+X6Oj0bo7f9ddP1Pew==
X-Received: by 2002:a17:902:c942:b0:2a0:9fc8:a98b with SMTP id
 d9443c01a7336-2a3ee4bfbcbmr174765985ad.40.1768224210121; 
 Mon, 12 Jan 2026 05:23:30 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:29 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 03/32] system/physmem: add helper to reattach existing
 memory after KVM VM fd change
Date: Mon, 12 Jan 2026 18:52:16 +0530
Message-ID: <20260112132259.76855-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

After the guest KVM file descriptor has changed as a part of the process of
confidential guest reset mechanism, existing memory needs to be reattached to
the new file descriptor. This change adds a helper function ram_block_rebind()
for this purpose. The next patch will make use of this function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 include/system/physmem.h |  1 +
 system/physmem.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/system/physmem.h b/include/system/physmem.h
index 7bb7d3e154..da91b77bd9 100644
--- a/include/system/physmem.h
+++ b/include/system/physmem.h
@@ -51,5 +51,6 @@ physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
 bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                         ram_addr_t start,
                                         ram_addr_t length);
+int ram_block_rebind(Error **errp);
 
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index 0105e88058..58c89500e9 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2857,6 +2857,34 @@ found:
     return block;
 }
 
+/*
+ * Creates new guest memfd for the ramblocks and closes the
+ * existing memfd.
+ */
+int ram_block_rebind(Error **errp)
+{
+    RAMBlock *block;
+
+    qemu_mutex_lock_ramlist();
+
+    RAMBLOCK_FOREACH(block) {
+        if (block->flags & RAM_GUEST_MEMFD) {
+            if (block->guest_memfd >= 0) {
+                close(block->guest_memfd);
+            }
+            block->guest_memfd = kvm_create_guest_memfd(block->max_length,
+                                                        0, errp);
+            if (block->guest_memfd < 0) {
+                qemu_mutex_unlock_ramlist();
+                return -1;
+            }
+
+        }
+    }
+    qemu_mutex_unlock_ramlist();
+    return 0;
+}
+
 /*
  * Finds the named RAMBlock
  *
-- 
2.42.0


