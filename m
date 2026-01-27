Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA96D2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCt-0006Jf-1T; Tue, 27 Jan 2026 13:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBp-0003FU-W8
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBo-0000oN-9n
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769540003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvoXimTzM4tcN8+c8sY9pRd+AZdXMUmsetzDVAYThuY=;
 b=JHh3Y90fozuxaXfeU6012ZGI5t0wPl/H8aMCn378dzvge9QW7ZUhMHuy2CxOrD0HSscSmz
 BlwUHBZ+i5OUY6dm2jGSe6614RIqY2FZr9grmWqOZwAQ9m64VWQ7KD8XWBN5gv/3iHjRRJ
 +1wSnVWc7X2PXB5HYWWRC0JHx3y/ZCY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613--c_eT5TjMbay_vXuKv0XFg-1; Tue, 27 Jan 2026 13:53:16 -0500
X-MC-Unique: -c_eT5TjMbay_vXuKv0XFg-1
X-Mimecast-MFC-AGG-ID: -c_eT5TjMbay_vXuKv0XFg_1769539996
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89482366332so231962196d6.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539996; x=1770144796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvoXimTzM4tcN8+c8sY9pRd+AZdXMUmsetzDVAYThuY=;
 b=itZtSg+vMD2LPuxbPNLcDGn12TCxydyC4jB7f2WfFOR9LUm5qYYmF6jbcW2xDVtj2P
 Wr98q0SQ9M7dMTA0vmjeCP/V9rw5NknXgqjlfzQv+fT7FDhFsNqrIYxgieCdOT83DkDt
 Aq4bcuwZ2lNamaVFM95ndpi1DUGIvcfCEsxc2KzKJRS4wJ1Y7h3tl9VHXwtLtr31uxE0
 fpYmqh1IGpbSZsGRFiMrN9y/xoJYLQjf2W0wCJItAirKUrxRSorXSxB9DcNWk6VsKe/w
 aLG5xVSBEyBt+P7rMAqLQjJ67/em924OxtNIaZSGZa+3eCk5f77te3gTLuQE7SXeNlFo
 Iwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539996; x=1770144796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dvoXimTzM4tcN8+c8sY9pRd+AZdXMUmsetzDVAYThuY=;
 b=KdDVN14N9qp5MtVqIN1MDQB2ZUbpC/sZYv6DgWSpavUmX9BAhf3L2lpwj2DWh/gDQs
 IS7FFR+ysdsFp5YCqnbSbszQFml2xS3A6SMyBN1gEshub5BS//h6yI2+zrXMkmB8MW3L
 hmbmZbf7hCaXHiLEJ++YXBdjlmmOx2COkmOcuELvoE1hjxm+K19xmeVRVaCnAOVADyal
 zyuW36PlRmY0F1Msi+B6FFEHbHFwMhlWwczkO86rGQyL16rHgH2qKqRFyfb7MfmenG/n
 KvxdSwfkIoBNTJQhBipkHxn+Glf1yW+FUonJxvxb0Lhvy3eh8ZXiwPPFE61yGcNps1eB
 BNHg==
X-Gm-Message-State: AOJu0Yx5Ez/6wbraGfMuMjwuWT5qlO8ZYhLu3VVrAdUxhgn8QG6WqCkP
 NiMIe+JozuRyhYbvqqEsfxykTPuCcYDlPvcNKdNQOB1DmHSTZ04Dr5JEFzlcIcv4HGUdb6P/g3o
 gCYBJmB9cVl8eKDlc967Es1a447H2W4tD8Hl5ZjhwwqDCAtN86D1SySItK/WS6GIEPWx4k5CmvJ
 bNvPqjZdz6Lkj/0yc2YkcbI3N/AyCXzef8W/DzqQ==
X-Gm-Gg: AZuq6aLaXY1ni6q0OKYr91P0EBo+nUzoh7eFCgQpMhcQ0O9l2sNOzd0LdClCm/7BNDS
 JmpV+y0Rrpcx8FDmEUtH2RUE3lEZ1PT6jnfHYQtRriEEDxMgxG+UMhuLNPsePrQD4s6mI0Ruq5l
 qHv1Cinek8JnL1IeI2WDR1XPdetWFJprjzZ2q/hlyw/ifXj863whkcmEliaGceXLH8Vk3WOAaOR
 5OQ0/UDQteNRvIZfVkAZ0jhc1A9hgizC6x+cB6FmawZ3+o8OHGxbHUEIuuchJ+Vln7zdjOPL50c
 ZG8EjqujIPGq8RIRtUPTHZpyosNly75+tUCZmt5vTSlq9eQjAVm1bxm9TCt+B1wyGHPOIpNVhKS
 R
X-Received: by 2002:a05:6214:76a:b0:87f:fbe1:2c2a with SMTP id
 6a1803df08f44-894cc7ff3femr39621646d6.26.1769539996131; 
 Tue, 27 Jan 2026 10:53:16 -0800 (PST)
X-Received: by 2002:a05:6214:76a:b0:87f:fbe1:2c2a with SMTP id
 6a1803df08f44-894cc7ff3femr39621326d6.26.1769539995647; 
 Tue, 27 Jan 2026 10:53:15 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:15 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 17/24] migration: qemu_savevm_state_complete_precopy() take
 MigrationState*
Date: Tue, 27 Jan 2026 13:52:47 -0500
Message-ID: <20260127185254.3954634-18-peterx@redhat.com>
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

Make it pass in MigrationState* instead of s->to_dst_file, so as to drop
the internal migrate_get_current().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h    | 2 +-
 migration/migration.c | 2 +-
 migration/savevm.c    | 7 ++++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 57b96133d5..bded5e2a6c 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -42,7 +42,7 @@ void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-int qemu_savevm_state_complete_precopy(QEMUFile *f);
+int qemu_savevm_state_complete_precopy(MigrationState *s);
 void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
                                      uint64_t *can_postcopy);
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
diff --git a/migration/migration.c b/migration/migration.c
index c6e54d2a3f..b8c85496f8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2752,7 +2752,7 @@ static int migration_completion_precopy(MigrationState *s)
         goto out_unlock;
     }
 
-    ret = qemu_savevm_state_complete_precopy(s->to_dst_file);
+    ret = qemu_savevm_state_complete_precopy(s);
 out_unlock:
     bql_unlock();
     return ret;
diff --git a/migration/savevm.c b/migration/savevm.c
index e1918d4f38..830d8e5988 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1728,8 +1728,9 @@ int qemu_savevm_state_non_iterable(QEMUFile *f)
     return 0;
 }
 
-int qemu_savevm_state_complete_precopy(QEMUFile *f)
+int qemu_savevm_state_complete_precopy(MigrationState *s)
 {
+    QEMUFile *f = s->to_dst_file;
     int ret;
 
     ret = qemu_savevm_state_complete_precopy_iterable(f, false);
@@ -1742,7 +1743,7 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f)
         return ret;
     }
 
-    qemu_savevm_state_end_precopy(migrate_get_current(), f);
+    qemu_savevm_state_end_precopy(s, f);
 
     return qemu_fflush(f);
 }
@@ -1841,7 +1842,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret == 0) {
-        qemu_savevm_state_complete_precopy(f);
+        qemu_savevm_state_complete_precopy(ms);
         ret = qemu_file_get_error(f);
     }
     if (ret != 0) {
-- 
2.50.1


