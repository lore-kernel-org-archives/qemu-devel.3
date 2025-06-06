Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA92FC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIy-00038t-1j; Fri, 06 Jun 2025 08:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIu-00033n-QY
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIq-0005yj-J7
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5uzjuLSgEF/FIRBnn8m7SuPE8mBgQcI4+vg0czbC7uA=;
 b=CiBJQfs0oG3vma6In/BkGrD+uXSJ+Yxr6FFhVyuHojdMkUKEMxeSqfJusZSD956jv0AtLF
 UyZCx1I0ZLwFzakUA4zJC1DOs9FxHS8DY59tUEVDO9dvK+/WHPuwxcKS+ljwIiOb3lCRah
 9f7ONKdtAGqgXZ9rTGN/NTDv6S1CmM8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-Ex3xEc1UOviw9uFNYgh6fw-1; Fri, 06 Jun 2025 08:36:06 -0400
X-MC-Unique: Ex3xEc1UOviw9uFNYgh6fw-1
X-Mimecast-MFC-AGG-ID: Ex3xEc1UOviw9uFNYgh6fw_1749213365
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f8192e2cso1130535f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213364; x=1749818164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5uzjuLSgEF/FIRBnn8m7SuPE8mBgQcI4+vg0czbC7uA=;
 b=NgeqQDwXg/7AP4jFu6kbiMP5Xjv59t9zttz/69TBxcDRzL6ulKfQytzij57CWtTnLY
 2NlzfTFNFGZ8OPE3ppcycPQTc5S+L9aTy3EMNps+FDoIfx226F7lEg3U+NtT64tfnkNt
 bizoXjlU/5ekRFUDog6eoqgdJQ9afzQ5z4mnFQ5DhVHdEjiVY/04yad74fL4a1Ctal/F
 0oUXhCm1BmRliwzGCYVerEtrg+X0GBDg18r74SXlFqiBxb9LgVbBWkojPsVB9dYjqMH2
 DSkEy3JehuuwxnzUI1Aww0Easue8+LAd6lsftNEUpQMV5881mjvegH1difvgDYfCzl8c
 iM1w==
X-Gm-Message-State: AOJu0YzmZIT3ReF7Dhi7cEBWG1t+mdVmQ3GY7zgG+ztPBFvsl/i6GkKe
 FYquSguyLa666BdaAFNuVIFf9nKaQUix7HLO0/f29b3wD0VxFtOAs589hIVyHHLLqBVyw3UDBwh
 HpyuySSr6jN81fu3On7G/Kq87rM6aZ7OpzfnHQvUF+SZdWCt3uoAVKIfd9FW/hfeisHTtIgYdvW
 4U0rfO6OXD0YEsdVrjpf7prs15aZ3TvLZvEYCvhR2E
X-Gm-Gg: ASbGncthTRDcl2YsRvjTdBlteH0+9zVyn19UMW2RxJeI8bMTSqKunl30RjW+1YZT2vt
 ht4DjL0CLKAwrQ6+2sgTFhS9yisd+H052adidmHzT7c9VycCz/ybF6tYJD449UGpmafKVM22iea
 swZN1MVAD9gL/JsLlGw+T9m9TySVofsN9ARQP7ys6GoTt4DZ1YzH74Tu0K/deFzDnSDitN2wL3P
 EsnfN5bGspFZQkLL/sYzwzO+zn1N/7+gEV4MbxdQgvsDQ/6f3+96GTvwUsTPukVX4w5hjRixx1U
 riZSFqqDXyatcpxWYJZUMnv7
X-Received: by 2002:a05:6000:144d:b0:3a4:ef2c:f41c with SMTP id
 ffacd0b85a97d-3a531cb398dmr2539855f8f.26.1749213363865; 
 Fri, 06 Jun 2025 05:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF/M1v76688IS5doGwdqn7njxie6kVO3PSvh0fiBZLDxXG4Q5Iz4OrOXe8IvEq/koXjPJtjQ==
X-Received: by 2002:a05:6000:144d:b0:3a4:ef2c:f41c with SMTP id
 ffacd0b85a97d-3a531cb398dmr2539840f8f.26.1749213363406; 
 Fri, 06 Jun 2025 05:36:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323b5147sm1818585f8f.37.2025.06.06.05.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:36:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 22/31] qemu-thread: Use futex if available for QemuLockCnt
Date: Fri,  6 Jun 2025 14:34:36 +0200
Message-ID: <20250606123447.538131-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This unlocks the futex-based implementation of QemuLockCnt to Windows.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/r/20250529-event-v5-6-53b285203794@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/lockcnt.h | 2 +-
 util/lockcnt.c         | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/qemu/lockcnt.h b/include/qemu/lockcnt.h
index f4b62a3f701..5a2800e3f18 100644
--- a/include/qemu/lockcnt.h
+++ b/include/qemu/lockcnt.h
@@ -17,7 +17,7 @@
 typedef struct QemuLockCnt QemuLockCnt;
 
 struct QemuLockCnt {
-#ifndef CONFIG_LINUX
+#ifndef HAVE_FUTEX
     QemuMutex mutex;
 #endif
     unsigned count;
diff --git a/util/lockcnt.c b/util/lockcnt.c
index ca27d8e61a5..92c9f8ceca8 100644
--- a/util/lockcnt.c
+++ b/util/lockcnt.c
@@ -12,10 +12,11 @@
 #include "qemu/atomic.h"
 #include "trace.h"
 
-#ifdef CONFIG_LINUX
-#include "qemu/futex.h"
+#ifdef HAVE_FUTEX
 
-/* On Linux, bits 0-1 are a futex-based lock, bits 2-31 are the counter.
+/*
+ * When futex is available, bits 0-1 are a futex-based lock, bits 2-31 are the
+ * counter.
  * For the mutex algorithm see Ulrich Drepper's "Futexes Are Tricky" (ok,
  * this is not the most relaxing citation I could make...).  It is similar
  * to mutex2 in the paper.
-- 
2.49.0


