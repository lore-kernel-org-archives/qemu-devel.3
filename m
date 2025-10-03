Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF03CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hu2-0004qX-P5; Fri, 03 Oct 2025 11:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htd-0004mZ-MD
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htG-0007bp-RP
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViHboUUz9dG/QneaDqOx0i4crqhJqvsBxAcJ800i+Ks=;
 b=PBnRuSqo4i1Tzvs5ZzZwvNE6v4ugO8/E2/6GGvIdfEhUwoRa6El5+ZQs60cYch2uPw6ORe
 SV4c6ggNFjjSESgb2Td6gnb8gxbUjHr4C0+u8vsQzUc402dwXJumfX2hb7amDmMlSU//GV
 cM2qA72xSjamd1tPoIRAHU4i/Ab1RM4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-U3RlcnJ5Nx-xPnZd7CPc2w-1; Fri, 03 Oct 2025 11:40:09 -0400
X-MC-Unique: U3RlcnJ5Nx-xPnZd7CPc2w-1
X-Mimecast-MFC-AGG-ID: U3RlcnJ5Nx-xPnZd7CPc2w_1759506009
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78e5b6f1296so48261526d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506009; x=1760110809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ViHboUUz9dG/QneaDqOx0i4crqhJqvsBxAcJ800i+Ks=;
 b=bv9cyPC2YLayE4cVAAWOn8RN0XLbGGVWjjCw0mEVhfWgrGy7Co/nrU65GeN2zKa0Qw
 0d7Tk0EV0ZpGeDcZ5eemxq2k+0Ss/TMDN4Xrvzk44ysRF82nRFTMSuXxWChSm6HqHCOd
 5W6K9T5llzm1hh0bv5xk+Cv5tEwHGIQxhZiHxrDp7V2m6vIpx7EbCN2NoLotQeHBZ7Jj
 H+1v7nj3D+hVXvknMR+VSkg+YNgZ+fWt9Flg8gyUaIbNGT9J0N77Uh9E/ixSX9EOCWBA
 sNnjBryjPK6qGlfxxymESUV6Wqg2edui+uLbjHoF1XpCqg/SLf9+WSR6aWSTn7AFEFLy
 5rYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwlGtq6EwRSPSiDWWAL+acy/lsDCwCI+xyHRbkc/Zi4yn1aRSzGoMxHR5r/Krf11R7cJCxDqfYTVL7@nongnu.org
X-Gm-Message-State: AOJu0YyfM8LJFDYLXbFGbo14INfZZ3Mu2WCQcQVfTuoXcBzm79QNMkp7
 qCT9RU7eOlfDdK8+XjdqlZLoUhvp5YSePXobILk93GQeE88RwVy8eNKV05ebiS6y3TZMMKnMByh
 X1RY+u+GNdTVVDE2OQemZeJA2bjtzseKDI8S7DNdd2L41ojnworMB0tYP
X-Gm-Gg: ASbGncv25g1GPQqdAN7YWv01pVRHE9EYBWKWbuNz1pQBGlmfgjAVT1s3CHwcyuAzN9y
 lBgj8Ngt31aDs13EPzTJFzs4ZikDL47QP6kibJ8/KHxhmdkPX1UfM14BJ2O02n+KgvGbB/Sdp1b
 r0IDBrawBAN6uoB86Leyqq46RmSs8DXIk5nghz33fdZQ2qT+2N38Iw1f010xCEAF6vABa569X58
 BIP/9vQ7R3nFZXz5BCnxpZQwykjdSoRyZ5wswMt/+OYEE16kZ3CjC5WmFABus1GJiE6HIAv3m8W
 HTSzGT4K9a4bBB+Yq3I0qCzBv28y3Vl4Nzl7tQ==
X-Received: by 2002:a05:6214:238a:b0:814:eb8b:8d06 with SMTP id
 6a1803df08f44-879dc841d38mr42503026d6.41.1759506009024; 
 Fri, 03 Oct 2025 08:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbC7aMxdt3sfiqat1u5B+lkQOLk0V6iF0MtZHucs7GWfkOPDHgSGhSFy/Lv51/sjrgoddxfA==
X-Received: by 2002:a05:6214:238a:b0:814:eb8b:8d06 with SMTP id
 6a1803df08f44-879dc841d38mr42502556d6.41.1759506008465; 
 Fri, 03 Oct 2025 08:40:08 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 11/45] migration: push Error **errp into
 qemu_loadvm_section_part_end()
Date: Fri,  3 Oct 2025 11:39:14 -0400
Message-ID: <20251003153948.1304776-12-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that qemu_loadvm_section_part_end() must report an error
in errp, in case of failure.
This patch also removes the setting of errp when errp is NULL in the
out section as it is no longer required in the series.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-11-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 83d8fb8f41..c1ae36b50a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2803,21 +2803,19 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 }
 
 static int
-qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 {
     bool trace_downtime = (type == QEMU_VM_SECTION_END);
     int64_t start_ts, end_ts;
     uint32_t section_id;
     SaveStateEntry *se;
     int ret;
-    Error *local_err = NULL;
 
     section_id = qemu_get_be32(f);
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read section ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read section ID: %d", ret);
         return ret;
     }
 
@@ -2828,7 +2826,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         }
     }
     if (se == NULL) {
-        error_report("Unknown savevm section %d", section_id);
+        error_setg(errp, "Unknown section %d", section_id);
         return -EINVAL;
     }
 
@@ -2836,9 +2834,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, &local_err);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
@@ -2849,6 +2846,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Section footer error, section_id: %d",
+                   section_id);
         return -EINVAL;
     }
 
@@ -3108,7 +3107,7 @@ retry:
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, section_type);
+            ret = qemu_loadvm_section_part_end(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
@@ -3132,9 +3131,6 @@ retry:
 
 out:
     if (ret < 0) {
-        if (*errp == NULL) {
-            error_setg(errp, "Loading VM state failed: %d", ret);
-        }
         qemu_file_set_error(f, ret);
 
         /* Cancel bitmaps incoming regardless of recovery */
-- 
2.50.1


