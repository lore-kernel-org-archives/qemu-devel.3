Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6F1C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzh7-0006jg-9H; Wed, 16 Jul 2025 06:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzcn-0006r6-4p
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzcl-0000LR-5E
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=px3R0RISbWrQLQtgKLUctsBD5ZgKayzzpEum6sB//t4=;
 b=IRcRxDf8iMWtaZfdp1XXRdz1Uz0T+WJRKPm4mWy/NuaemtS6HnZb/LNqsYzD8FnClXi5/t
 vcjg0HgvucHxOtN4r3Zq5oisqi1HArqj2l/CSUQ0fX8kcWqwI8kYOHYn0uXu3PpmIOTARf
 /r8ivL1ez+QUYS/9lKtq8JpWRVHJoDY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-uQwskiaZP1ar54odcFC8vw-1; Wed, 16 Jul 2025 06:44:28 -0400
X-MC-Unique: uQwskiaZP1ar54odcFC8vw-1
X-Mimecast-MFC-AGG-ID: uQwskiaZP1ar54odcFC8vw_1752662668
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23824a9bc29so85687955ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662668; x=1753267468;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=px3R0RISbWrQLQtgKLUctsBD5ZgKayzzpEum6sB//t4=;
 b=YINbhjS3z/qyvAzhveZhKLMv42k7vfQCwBWUeBnLPXiRz2oNDb1WR8gaAKFgNR5dSr
 Gpp6Ytx36dtin9Us3ejAu2vg7lMFrr52qxqIotN8QseYSj2jYk0LeffnC85z/9WZV7KQ
 Roy3Quf12pa3oIXjxodcIMRp4LjsOPNnJJhQRmL7g5/tWrfM+N5RqngER5xGVTM3vo5O
 Q8hkZlBgiQZ5ipH/vgaFVSC/aS0EceiWpg0AWt3NgIzhlyT8G2Mgv/QUgoK3aJzfuKlY
 X5Of1bFvIfJpL4xTO1TI/wgETyQ5GCMmo4IJ5bnYnA7DXBRgh56qGq0eZBmr9IU9r3gC
 nrCQ==
X-Gm-Message-State: AOJu0YytsLSDrk4P7aRKLiBEcvPVWpgLtxVh7zwHxpCCRio0kewBLtZT
 ef+DsDHSZFNP/t3Xak/aNsCEF0f33wDStgr32dz20Lbl6RWW6Fc7JLbtQLMNAulB+ownu9dZT/y
 WJyxeo4n3S0YxTWlwgxzi5yfeMGfLOD5G0AYIzUZ107Kmvk0qLaW7nkA0
X-Gm-Gg: ASbGncu0ME5R5+TYlQ8N64EMEUAW+REtGkfBD9ATM2AYGwaR+HvLyRIsNJuXULl84ie
 tTdOIkvT+dog+q5Ux3/VtdCoNm/ATDa2yaB+GjLwsl3jCOKUchMJXNLj4V8744aS/sHrAdshhGM
 rH1qiAhgSr7+Xz7xvebaDLg5Aad64CawU7/9jW8pRmqhgjd8JTsJW5gqdpHiMQvQtkw5W4i0j6/
 BgNRfsO824SEjj03V7hN064YWUhk9AqpLMhU+6FOUWPMBd+ZFA0zU4e3Pgze/P9shKKPyrlaloi
 oVbQaPFkQSQbncAfo7bN05rhXrk+vG74jqoaGkp6ASjFeUQelw==
X-Received: by 2002:a17:903:8cc:b0:235:eb71:a398 with SMTP id
 d9443c01a7336-23e257a280fmr37599145ad.53.1752662667821; 
 Wed, 16 Jul 2025 03:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ4No5ef+C/nXQVdFBvXGpeb7dCgpN1mwBQydV9qj2g0hnI3jtYQW85INopfmcZr0RbLgptw==
X-Received: by 2002:a17:903:8cc:b0:235:eb71:a398 with SMTP id
 d9443c01a7336-23e257a280fmr37598835ad.53.1752662667375; 
 Wed, 16 Jul 2025 03:44:27 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:44:27 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:12:58 +0530
Subject: [PATCH v4 08/23] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-8-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694; i=armenon@redhat.com;
 h=from:subject:message-id; bh=devVsePfbg8OfEG7eObrBgRq/peOTZJY071zwuhog14=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k72n5udl7gtehH1PibzHLCbl/zR595knq6oyP3s3c
 Ap/PpLbUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCI8Dxj+aUwz9FRw5ry4JmZ9
 5tPwSTdW9CirzfCxun1U7u4FG4uSjQx/Jfc9LylXUXrBN3Husu9rrE3+7y+y2T6x8sxUU/vl/Ql
 ajAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
It is ensured that loadvm_handle_cmd_packaged() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e40e67b43166d11cd417c17d1c387a1effad41b7..1953842177f03691b3f401a4ea8b1425ef90ac9e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2399,7 +2399,7 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  * Returns: Negative values on error
  *
  */
-static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
+static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
 {
     int ret;
     size_t length;
@@ -2409,7 +2409,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     trace_loadvm_handle_cmd_packaged(length);
 
     if (length > MAX_VM_CMD_PACKAGED_SIZE) {
-        error_report("Unreasonably large packaged state: %zu", length);
+        error_setg(errp, "Unreasonably large packaged state: %zu", length);
         return -1;
     }
 
@@ -2420,8 +2420,8 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
                           length);
     if (ret != length) {
         object_unref(OBJECT(bioc));
-        error_report("CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
-                     ret, length);
+        error_setg(errp, "CMD_PACKAGED: Buffer receive fail ret=%d length=%zu",
+                   ret, length);
         return (ret < 0) ? ret : -EAGAIN;
     }
     bioc->usage += length;
@@ -2451,6 +2451,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     } while (1);
 
     ret = qemu_loadvm_state_main(packf, mis);
+    if (ret < 0) {
+        error_setg(errp, "VM state load failed: %d", ret);
+    }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -2612,12 +2615,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         break;
 
     case MIG_CMD_PACKAGED:
-        ret = loadvm_handle_cmd_packaged(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
         ret = loadvm_postcopy_handle_advise(mis, len);

-- 
2.50.0


