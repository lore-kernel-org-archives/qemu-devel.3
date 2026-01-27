Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313C0D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCg-0004Yg-Pp; Tue, 27 Jan 2026 13:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBk-0003Cp-JT
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBf-0000kV-UX
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MDMVKTHdAhPweTPnMeympx3V8z4uq5Hbee97R017RKk=;
 b=VIVbZxfT4CrYC0FgGCdiwLmAloLlXoo0CFnCWlGG+i/FKdKyTRcBOUHAzu7HiVhAkwzEvv
 XUShAeA/MY9l2muokt3Vnl5RhsVsAV2jejL5H8NItgmSQwzjiYq/VMtn7uIB9Ig2TPnHhM
 8Ud1gzB3jJ29QodRKioVsUmfI6TXeI0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-0cgqNM4-NpikANkKELo-uQ-1; Tue, 27 Jan 2026 13:53:13 -0500
X-MC-Unique: 0cgqNM4-NpikANkKELo-uQ-1
X-Mimecast-MFC-AGG-ID: 0cgqNM4-NpikANkKELo-uQ_1769539993
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c6a291e7faso738974685a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539993; x=1770144793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDMVKTHdAhPweTPnMeympx3V8z4uq5Hbee97R017RKk=;
 b=tuWfgt19ZCkR0REkzczcxYm/EdeJn5XCW0BfmabIwubEVu2rP7ZTPhEMM6QAANiRgU
 YSoJAT/ZdWuH9ToNFEh4UREBA0CzI/vlrincW+ydJeNNYDe+TPk8IbtwWsU+8yvAYiHS
 O4ErE+GPOtpFBo4FHc8y/bbW6uxf1ZpTU1RiVA8koU/JNxtzsfApL+/Za5q2vM6q2PVM
 n5hVehDhHWS6b1cShnOMG4c8nXBiwSapT0/nfBqJ7FQBbr6IlfEemmhgZyC0JazDL3/6
 2p+WwUeD0K7F79RSP1WmDXrfuApsFtmtoD70DdmeDqGZAq9YgYdjJ38ELH8KQSKQa11s
 3bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539993; x=1770144793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MDMVKTHdAhPweTPnMeympx3V8z4uq5Hbee97R017RKk=;
 b=A3tqzcIRCLtG7rbD1z33/d6UeRaDXtpE5WecpPj08+07jut77wvCc1pGsQhuo/80tC
 TeiNvO4KJFJqtBiAAth95Tp8DqNgzvHu89istV34Brubas9lf6c/1mJYRimaNYxphRfA
 ZWv6TBWekfjs5zLpdnRBAZzifL/ekE22z0bk/+CAgTYfRzPo46W5rxkOuwl5CUNg60sz
 OotRC+WVdhSww9s36/wLhnoTvYAVfKdyWbLA2Coz4cdmL572mJZUsmPFK+1PcbxRzh8j
 hlZed0ARjNzRw7yGMd4nDIduKCqcJhLo8St4nTY8LczMTYUdWAEHcxqTfBpzCqaH+z1L
 CD7A==
X-Gm-Message-State: AOJu0Yw8RTC5t/HGvZimiduI+kCLxBUv/EMOk8S1nuwvh3r/UX7l0HB0
 hW/X3jbAKhbkLwk2qZx5ejGwbsK0hZn2FNE+FGcQDkMHXD+gVhVOIxOjI5ARQp6M8GgNPWJsgic
 4yGkRB5eybhsWKxT5HhU2zTMxGFXXDo1JhGtoFzkwYabYr85K3BFs/HeQR+bVS69DjDi0ExUSIO
 YzaTMe3yCHn/uOpWfbbG+QT2vRLW5lp74O8CqouQ==
X-Gm-Gg: AZuq6aJUqFGyf31GLBIlYIJ/g1Jw8WVlk++DJmy17/iXwqCgjhpV+ZlcRp9sL1b3/01
 QLzJ1uQ7WuLgkwNQmGgQ8uDcen5o+Anq4Bw0eaHWimM4IC3iKfwz5hClOXckmf3wnHbW1VdLOeI
 DrmlwvNlCyF+y8TXts7w2xrSfOE6Omki1GQ1DpobgeI86xsx7+Idw31wnbPthjHHuZjdnGuRKZv
 gT7QCMS23RFno1Eck49CLasbNSOKdVRTnBXUwa+O7r/+spycxv4IuPWjpZy/WQK4SDncRXjV0ed
 agTSgEQ0yOjlQnujAB0Idrd/RhGPraJA1Yu8FNXaq9AUzD2QV/tqz45N+R4qHvPjFWfW8KsFWBQ
 i
X-Received: by 2002:a05:620a:4888:b0:8b2:6443:8401 with SMTP id
 af79cd13be357-8c70b9279f7mr329383785a.76.1769539992912; 
 Tue, 27 Jan 2026 10:53:12 -0800 (PST)
X-Received: by 2002:a05:620a:4888:b0:8b2:6443:8401 with SMTP id
 af79cd13be357-8c70b9279f7mr329379385a.76.1769539992382; 
 Tue, 27 Jan 2026 10:53:12 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 14/24] migration: Introduce qemu_savevm_state_end()
Date: Tue, 27 Jan 2026 13:52:44 -0500
Message-ID: <20260127185254.3954634-15-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Introduce a helper to end a migration stream.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h |  1 +
 migration/colo.c   |  2 +-
 migration/savevm.c | 12 +++++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index ea01ca63ec..d0596d1d62 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -49,6 +49,7 @@ void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
                                         uint64_t *can_postcopy);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
 bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
+void qemu_savevm_state_end(QEMUFile *f);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
diff --git a/migration/colo.c b/migration/colo.c
index 0b1a58cd8f..db804b25a9 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -470,7 +470,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      * to be blocked here.
      */
     qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
-    qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
+    qemu_savevm_state_end(s->to_dst_file);
 
     /*
      * We need the size of the VMstate data in Secondary side,
diff --git a/migration/savevm.c b/migration/savevm.c
index d41e89228d..a787691352 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1065,6 +1065,12 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
     }
     return 0;
 }
+
+void qemu_savevm_state_end(QEMUFile *f)
+{
+    qemu_put_byte(f, QEMU_VM_EOF);
+}
+
 /**
  * qemu_savevm_command_send: Send a 'QEMU_VM_COMMAND' type element with the
  *                           command and associated data.
@@ -1555,7 +1561,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
         }
     }
 
-    qemu_put_byte(f, QEMU_VM_EOF);
+    qemu_savevm_state_end(f);
     qemu_fflush(f);
 }
 
@@ -1699,7 +1705,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
-        qemu_put_byte(f, QEMU_VM_EOF);
+        qemu_savevm_state_end(f);
 
         if (vmdesc) {
             json_writer_end_array(vmdesc);
@@ -1879,7 +1885,7 @@ int qemu_save_device_state(QEMUFile *f)
         }
     }
 
-    qemu_put_byte(f, QEMU_VM_EOF);
+    qemu_savevm_state_end(f);
 
     return qemu_file_get_error(f);
 }
-- 
2.50.1


