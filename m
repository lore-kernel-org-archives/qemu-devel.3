Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3B1C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHPv-0005eW-60; Fri, 25 Jul 2025 08:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHPl-0004uQ-Hg
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHPd-0000LJ-LG
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6y91SjWTLJ1eBloC1C/ESEGfP7aG6XyfswjvdDTmYeQ=;
 b=b4Z7R0uViF27EfylwGmLjgxXPSSGX1IngfZhxbZZtjGHn9L2ZP0950317fiZaWw/vzifw/
 b9CQdKqmUw/E51dIs+yx2VxG2CGIKlrJFHDs1QG8ktOEguXf8YNxz5OKFNqP9VC/GXDnoW
 nNnzZN8Jx36iciLeobXwEEDfCacJPEc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-IVcM4DpFMfaNfQIO_23PgA-1; Fri, 25 Jul 2025 08:20:31 -0400
X-MC-Unique: IVcM4DpFMfaNfQIO_23PgA-1
X-Mimecast-MFC-AGG-ID: IVcM4DpFMfaNfQIO_23PgA_1753446030
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31202bbaafaso2148305a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446030; x=1754050830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6y91SjWTLJ1eBloC1C/ESEGfP7aG6XyfswjvdDTmYeQ=;
 b=WKw9kJewxC6ql36FRJm1VZIECG5EgQCmRBS5ldHnzZ9y8Y9HExlsNk8KV1rkl0E9Oz
 9SC/K4UxPBjEKT3OKT3pdvBFD65EzqvIndLNXd3wZzeiSv96SoFSfJgrwcWmJJbaIuya
 M9I++OpWa4rI539/6QfbIjhfBdQqh8wtvaUmyWd8hcaRiMS9DRGMhEj+YWULeanHyTAB
 Gw2ahQ0WlCH/9s6/5T1lTVVqXSimNTUDwv7w9uIzJ4KkkIDSoZurMS9o+4mWzW7yf3Zn
 XSr7uYrBLXxomJfO8nJCRxcqnNqbJLQLZWYa8yHlGRj42rii+Zo7VliXky7oE7g0rohu
 yC2Q==
X-Gm-Message-State: AOJu0Yw5+TVXZIGfMgTnO6uaCsI6nylr5MyitiK2ZrPEHAqPspMuGCq5
 A1Vlx4gnBukG+ghV/+1BetUpL43l7GwonE89AoA30SMMM7foA3mIRRQHpQ1roTE52CPhRZC61kD
 f2s10WLPCQNquODXsyKxP04+EuKL1UG7kx5a1HZ6uNGgrYDglkMSUzq/Q
X-Gm-Gg: ASbGncvc35PYPbk9+OA0EcARpfKLH0VicDnSVHhB+w5NWnSB5aTGcb1dS34Dif00UkS
 wvp1Nm2+lQdGIX9Ne/3EyGbbPcmioeP5WkRsW8QaGsp+ASN3bA+pRf+8iUM8mWVBTcmiSBCbjTF
 CyZzWphG5nrj2pBc5NzZs16dagbPij67ks0WgUsYWeCgEHHyT+OK+aQfjOlt3wXosjSoDQWi8Bq
 HxqJsCfxjR4a/KLLLP0rgoAlCOoM8unzXCEjBLADJK7T0QFzkrc81n2KlyIxuASRt8a631O6Nvy
 Wdd2rqcDNoUKoy27SfIp6hFWfzPuRhc/Q2rhhV22NLR5OGJtgFGZmA==
X-Received: by 2002:a17:90b:3807:b0:312:1c83:58e7 with SMTP id
 98e67ed59e1d1-31e77868e3dmr2122021a91.1.1753446030232; 
 Fri, 25 Jul 2025 05:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6M+udlIFc9cOCAoM/t8VSkuebkcj8sjXxszcbxZOo+uSgQ6bcdAqloJPU/JTkJS/TQx3urw==
X-Received: by 2002:a17:90b:3807:b0:312:1c83:58e7 with SMTP id
 98e67ed59e1d1-31e77868e3dmr2121969a91.1.1753446029810; 
 Fri, 25 Jul 2025 05:20:29 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:20:29 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:49 +0530
Subject: [PATCH v7 10/24] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-propagate_tpm_error-v7-10-d52704443975@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=armenon@redhat.com;
 h=from:subject:message-id; bh=QIX+/c0txxgJSFReUXiAq0+vlqbsKiNx85778EjiCCw=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0ZzmU7YdAeWU4KPN23ea2Cxsa3wcq1ht/eUjUHHrNU8/
 jo9ir7WUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCI26Qz/DBibojf0733u6LX2
 SUjOZJb9ni7RlcEX7x5dHvf38QJFJ0aGveubXt9r6Jmy1PCcwN7G5o9vpaL4JPYoLM0RsdwX/OQ
 8AwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
It is ensured that loadvm_handle_cmd_packaged() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index d40b25d74be46b209be8f28d10b7538a5ff2e3dd..63cf488d9f411c0fb8d5f1bc8a719aa575bbabdc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2403,7 +2403,7 @@ static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
  * Returns: Negative values on error
  *
  */
-static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
+static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
 {
     int ret;
     size_t length;
@@ -2413,7 +2413,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     trace_loadvm_handle_cmd_packaged(length);
 
     if (length > MAX_VM_CMD_PACKAGED_SIZE) {
-        error_report("Unreasonably large packaged state: %zu", length);
+        error_setg(errp, "Unreasonably large packaged state: %zu", length);
         return -1;
     }
 
@@ -2424,8 +2424,8 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
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
@@ -2455,6 +2455,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     } while (1);
 
     ret = qemu_loadvm_state_main(packf, mis);
+    if (ret < 0) {
+        error_setg(errp, "VM state load failed: %d", ret);
+    }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -2611,11 +2614,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         break;
 
     case MIG_CMD_PACKAGED:
-        ret = loadvm_handle_cmd_packaged(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
         ret = loadvm_postcopy_handle_advise(mis, len);

-- 
2.50.0


