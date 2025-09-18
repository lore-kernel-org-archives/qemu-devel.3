Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB1CCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGW8-0005WB-6k; Thu, 18 Sep 2025 11:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGW0-0005I4-NX
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGVy-00031Z-7e
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E61UbPQ98vkxoeM+8ySKgPLne5BO/4Y70dZrTRJJ2TY=;
 b=KRseeLISIyw1cDwcbm9NVs68LBfWCmqc3d5iv8pmjw6i3aHXemhxHLK8uuaHApk42Lk5S4
 4QEo64Uhz9v9zgTjaZVBHzEeOowzMexsO2hKsJd6O8z12f3PDi2+oh1uwmlEsLHGxwBp7g
 DQX3pusmO5raFntaGZEHQMFxG4prNtc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-O-c9RFJ_P_6CnC9sOPzR8Q-1; Thu, 18 Sep 2025 11:25:39 -0400
X-MC-Unique: O-c9RFJ_P_6CnC9sOPzR8Q-1
X-Mimecast-MFC-AGG-ID: O-c9RFJ_P_6CnC9sOPzR8Q_1758209139
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-77615793f06so1170603b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209139; x=1758813939;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E61UbPQ98vkxoeM+8ySKgPLne5BO/4Y70dZrTRJJ2TY=;
 b=oyT7Et8N1UGK/RzlGmii97D7e4v05DWbgYL0XqB1oznosvxYq/PmZFjmXl9clfyDtX
 kvBZ+Yor5WAyKV3NYKSPSyKHw35D0URZmNqHeXW5Wwa3UG+EuF+TT5z2WfKGV19xWO18
 uXllPyXlJ3k++aK9854wc3itqm3mFlNc8E4CzGeHUOTE10iQxotgP7Ia/cHI33NT3xd8
 Dn5cRNeyCSYKGj2X+XA1TBFe+75DHOACs7fnKi6lYxX21mOkaobubJzK8Zu5zwp4LXNq
 uwl7utiOZITfOVA8XOKRxhnlc+fmgOi8/m7AVQBWef9TP7EUqBgMSchZiLZd8Sr3YI1V
 35gw==
X-Gm-Message-State: AOJu0YznF4xzCF3kbGb03UROFEFj+fFkEplWooRd4FL+vW91+0KH0OTX
 yMcmUcI/YNtBTRNLkHx4sKSfgZjveLrtcN0Pt4HsjVAd8lOes0g0K6s7quzro+rwEmobCDXDPdx
 RK83DMI62McK+ZVw4gsfLf7AdULlSQ8pkNE8Ob5gocXxZG+s/+3xWX7Yp
X-Gm-Gg: ASbGncuxq3V1LK270v7RxB3OiuMYUoEWqE4/WWz36brZTYwR6yRdA8mMbnAwMvo6/Rr
 wD8YyDgqA4HVHvKmJHR3OfWtp+JKICfJZFQ7AKlCQGncYh0rCW2qVPkKrcadid0x0uucdjYHPRH
 lVyzWrEKf5URv/nBxaSgynFcxDOi/Qi3xbCazEgnjUb4+Gccvf+s8DIhS9HYYOhHrDifsoLjN7j
 mBbABE04HbklEZmonWlRVz2F9sT1BzGdRoTiF/3OXNwBa+x04h6Nx7amUWciBFlyav/MxomWiOX
 z6dRWItD3mLvonsijAQfXTJ5ZYn2+1C1ubQ4h4rb51rFVXCm96JYNw==
X-Received: by 2002:a05:6a00:8d1:b0:771:e2f7:5a12 with SMTP id
 d2e1a72fcca58-77bf6dce4eamr9126446b3a.6.1758209138747; 
 Thu, 18 Sep 2025 08:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEqxvr+s7Cnj59Yo4v8MSL5aVfPGr/qqLYwstSZpAITU5ySBcpQECIplhglRdTgj2Kb3g8gw==
X-Received: by 2002:a05:6a00:8d1:b0:771:e2f7:5a12 with SMTP id
 d2e1a72fcca58-77bf6dce4eamr9126358b3a.6.1758209138184; 
 Thu, 18 Sep 2025 08:25:38 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:25:37 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:30 +0530
Subject: [PATCH v14 13/27] migration: make loadvm_postcopy_handle_resume() void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-13-36f11a6fb9d3@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=armenon@redhat.com;
 h=from:subject:message-id; bh=J3tCTCrF6nSfsNZa6QUxbIzpTTI6Us9gYinavq3Uol8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5R8r5HU3undL7di+r4/FOHc/T8lPBd+tIk4Wh5e/N
 dnfcyK/o5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwE3OZGT4brhjl+qzU7UrFfsT
 D0benpXkVKWy6OFkvrQGRdENd1IYGBm2mj2pY04W3PBNfvmeVQ9XPHNj1l5u73ZPzPABf1S/lxs
 TAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.

Use warn_report() instead of error_report(); it ensures that
a resume command received while the migration is not
in postcopy recover state is not fatal. It only informs that
the command received is unusual, and therefore we should not set
errp with the error string.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d54028b1be4d7a1e4615c2b05611535bd7478e2b..c079942b7ecb959b3b668b977174d906f73c2777 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2334,12 +2334,12 @@ static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
     }
 }
 
-static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
+static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 {
     if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        error_report("%s: illegal resume received", __func__);
+        warn_report("%s: illegal resume received", __func__);
         /* Don't fail the load, only for this. */
-        return 0;
+        return;
     }
 
     /*
@@ -2391,8 +2391,6 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
         /* Kick the fast ram load thread too */
         qemu_sem_post(&mis->postcopy_pause_sem_fast_load);
     }
-
-    return 0;
 }
 
 /**
@@ -2647,7 +2645,8 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return ret;
 
     case MIG_CMD_POSTCOPY_RESUME:
-        return loadvm_postcopy_handle_resume(mis);
+        loadvm_postcopy_handle_resume(mis);
+        return 0;
 
     case MIG_CMD_RECV_BITMAP:
         ret = loadvm_handle_recv_bitmap(mis, len);

-- 
2.51.0


