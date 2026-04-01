Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DE7D3517F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82BM-0004Ij-SU; Wed, 01 Apr 2026 16:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BL-0004IF-8x
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w82BI-00037d-SX
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775075330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kb2EMKRNvdGGvafy+iD9MxCie+cNqjcod0U6cR8fsMU=;
 b=WAXYEqfxt+fXMFD5e7Qbuy2WTbBpawK9CFixg/NP2cwYiC50y9Hc/lh0zr86C8IaHT8mFm
 LFKtinuonJ9KKKojYnlij3W+JiormaUJmwTibzux5Tt8LMMN5xLJwWq0+nW/Pnlu0UEkT2
 mK/i+y3nQkO/9I5xpxgPPsT3Ml7OgN8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-r6_3a1X9MvCFWx1yetxmMQ-1; Wed, 01 Apr 2026 16:28:49 -0400
X-MC-Unique: r6_3a1X9MvCFWx1yetxmMQ-1
X-Mimecast-MFC-AGG-ID: r6_3a1X9MvCFWx1yetxmMQ_1775075329
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cfc575fa15so81095785a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775075328; x=1775680128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kb2EMKRNvdGGvafy+iD9MxCie+cNqjcod0U6cR8fsMU=;
 b=LzIQOCW0SuWXVoljHadEzaXPLnn4rYYvI2VeNK9mJiB/NJ1Uru3K6iNqQ1Inn54pW1
 /SBb6h+1ii/hgqTEdVSO1mJoRJGJgJEoCXsqlcAgL2YnEFuqAvnUch6oKlx0WYfOh+iE
 EZ3fi8pCoUDfb4+xsg2c0B5j7uE2liv2NgEYt9RQ1NVS1tVqVIPWB05536qlZAInyQ9v
 1tegFsC5Z/c5VD6qWksSl3Wd0Byb5OxwrRCYfqzCTWAcu+VYNUwV7lGbw1Facz0xGcZT
 28hwH3CBOZGPh8IMVCP09IZCBTcPbC9evzKIzIHUp1raBJJaaVRA44NB+HvBzskdrI9Y
 +l1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775075328; x=1775680128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kb2EMKRNvdGGvafy+iD9MxCie+cNqjcod0U6cR8fsMU=;
 b=igHT8pPcb+rg1KgQMCWD4CbfAMCBLFX7TJabMAO+oSFbdYNAQHrycAw9jwfBLfpie4
 HCmErjJU8xe0iPXJfnQufPWLOxuGGdgD76Rd79eCVcYTYaqQgbsddxYGfa0zfJzpW/Rx
 7gRN4Ks31+NWnKd2gsC8dM7f14Sx8hfrfygd49Sm5tBxYb9+8qi9bCixxHWadmaix5Xh
 kMYPgFWYe7uMsz6Ebtu8KCe0ifrhs8LzKqMVDHRWmURHyXfeKf6CqT2BlmfxHgYgVbvd
 7PCOaPw4RmGKCzrB1pBT3TeDFQqhhmo8p3Gzb4klNBSosmP7qMqu7dWza0LcEhO8JQM3
 ZvJw==
X-Gm-Message-State: AOJu0YxZCVrZ8Bwbw9Ziuac0NG2QUNFxcYFcqEmIc8KSO3HfiB3Vx7S1
 XXG4qq3MQ9VQivpb30crEGb3m18WbHbkcnVtZdu8po7KDvvGxpLDeZUUdlC+Lhs10ew+sPHOMi6
 4iUe+b90/55vud9oHxnTXkmTkC3LzZEgtVg+tNHyX/1Cb6dHRCmxgh7bruna5kluXNVtXg4fWqY
 zPAI5kGemcvEVy0A+gQhB5AHViLeVYnw/I1bViRw==
X-Gm-Gg: ATEYQzyby4+cbEIS2gBZfGo1KN4ExBVaKmKElm+Zjdxzsm5Z7EhJgHKr+p1fysl85x2
 wMx7BKDWCqclYuBvEHeJz9hC4h9dB2TWu903729ncFuu6ckTBlodaZw2mtEPactLJHIMJSg7Nb1
 xFU9/2+L9KQkcEKOADFJyLliRMM60c1QAvwR3rH1+w5O9PWubjalPcsumhUSBhygzuVe7UGtoWU
 N/faJX3EJ2ahsSQEmJK63h9K4sIccr7VhstFzBVfdlC3v/pijqfln1+f3MtKcE+oigxnKeRO3tb
 3YoMVNyZ7MDOjcDAGy/wl9Px0izu/vhU1uibsHPDOHjNvMFE8S1v74Tw45JkfyfLfGE8v+jKW2Z
 m1VNtpAzCNvvPI1iVcGnZr3fYvUU2LsVcvYoiOBFRN+I=
X-Received: by 2002:a05:620a:2845:b0:8cf:b7c2:fd20 with SMTP id
 af79cd13be357-8d1b5aac057mr736321285a.11.1775075327841; 
 Wed, 01 Apr 2026 13:28:47 -0700 (PDT)
X-Received: by 2002:a05:620a:2845:b0:8cf:b7c2:fd20 with SMTP id
 af79cd13be357-8d1b5aac057mr736317485a.11.1775075327295; 
 Wed, 01 Apr 2026 13:28:47 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a548a4efsm68194085a.8.2026.04.01.13.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 13:28:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/11] vmstate: Pass in struct itself for
 VMSTATE_ARRAY_OF_POINTER
Date: Wed,  1 Apr 2026 16:28:34 -0400
Message-ID: <20260401202844.673494-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401202844.673494-1-peterx@redhat.com>
References: <20260401202844.673494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Passing in a pointer almost never helps.  Convert it to pass in struct for
further refactoring on VMS_ARRAY_OF_POINTER.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h | 6 +++---
 tests/unit/test-vmstate.c   | 2 +-
 roms/seabios-hppa           | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index d4a39aa794..d4880e75c2 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -547,9 +547,9 @@ extern const VMStateInfo vmstate_info_qlist;
     .version_id = (_version),                                        \
     .num        = (_num),                                            \
     .info       = &(_info),                                          \
-    .size       = sizeof(_type),                                     \
+    .size       = sizeof(_type *),                                   \
     .flags      = VMS_ARRAY|VMS_ARRAY_OF_POINTER,                    \
-    .offset     = vmstate_offset_array(_state, _field, _type, _num), \
+    .offset     = vmstate_offset_array(_state, _field, _type *, _num), \
 }
 
 #define VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n, _v, _vmsd, _type) { \
@@ -1093,7 +1093,7 @@ extern const VMStateInfo vmstate_info_qlist;
     VMSTATE_TIMER_PTR_V(_f, _s, 0)
 
 #define VMSTATE_TIMER_PTR_ARRAY(_f, _s, _n)                              \
-    VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTimer *)
+    VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTimer)
 
 #define VMSTATE_TIMER_TEST(_f, _s, _test)                             \
     VMSTATE_SINGLE_TEST(_f, _s, _test, 0, vmstate_info_timer, QEMUTimer)
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index cadbab3c5e..6a42cc1a4e 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -668,7 +668,7 @@ const VMStateDescription vmsd_arpp = {
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_ARRAY_OF_POINTER(ar, TestArrayOfPtrToInt,
-                AR_SIZE, 0, vmstate_info_int32, int32_t*),
+                AR_SIZE, 0, vmstate_info_int32, int32_t),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index cf3a472f4d..1a8ada1fb7 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit cf3a472f4ddea30d2d483a8ba4b005505f0dabb3
+Subproject commit 1a8ada1fb70643172e251aacbac673c9ecda99e9
-- 
2.50.1


