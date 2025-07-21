Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A238C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udonP-0001RP-W8; Mon, 21 Jul 2025 07:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoka-0002Hq-Jl
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udojv-00013G-9S
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zyYz1xtCwZyxn4IXaGpYg4fJLMvtmlv/XpixD4zN4xI=;
 b=f0yGvSVLjmDv/0YR0sYmqI+2zZaqyZRIs37Q82mDXVBLV5fdUCY30eZYmAvQE44aFEFvUM
 15dDhVo0T33rHTAC/O/hgOX7YDKgePVCG9p2yGdx1BFoVkzaV8/ZiQq1RNkwJdxIgu+Id6
 ItVZmNmLhkGCZt1NJNhPJ/z6+fYByJ4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-yvgbCSNEMSmSVzcEJ1mAmQ-1; Mon, 21 Jul 2025 07:31:25 -0400
X-MC-Unique: yvgbCSNEMSmSVzcEJ1mAmQ-1
X-Mimecast-MFC-AGG-ID: yvgbCSNEMSmSVzcEJ1mAmQ_1753097483
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b3f321dc6abso1933449a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097483; x=1753702283;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zyYz1xtCwZyxn4IXaGpYg4fJLMvtmlv/XpixD4zN4xI=;
 b=YqpHwVEc2BwSZfFZkeOHNdEQtmQ8yDK3J9jYQuK9hyQ2jiizD5QzZldh7oSXC3BSJR
 2Vo5a2hHKBYw9gXy2Ua77b7zW1NtfHFKuSuCAV1xNfOJ75L2V6ULayEEEsgsQzwhHN4+
 MAD1me7G53o+7PBAEDuwaySoVKcVnp5pZWgTlX41KtF3AZt8QazMLE+UWQdvnXLuIqfX
 /PfKwJIOupzuzkFrnk0/2djqnII1//puzB5vYLhlYixLzp/EBOec8zwNssjmfrAwPjT8
 nlgj90L2cpw4q7/oHlHXL7oCY+GS6s81I0cmFydXJtC6MNvETXIPP5ZPq1DBXN0GNwLH
 XPtA==
X-Gm-Message-State: AOJu0YwumZCTA2shUfgLN9DgMj+sbm2trGBXKyZX4sG//3QtSNKfjIyv
 j/vaYR8zEwySKUt0wvv8+jIOxU65otZKXPkLVBDKGIJCW57ryxLuR0hQomLk18XsSbDHk7FZioD
 atxofXP3x8dfwRz7IXidQ0K+EtR8QATfK7xPpYuVO4TzNaYVGpRk8BOkQ
X-Gm-Gg: ASbGncs32ZDoyhJPDTnoUeYTi/PMJq0lU0V54Io0Rf9no9STL+DBpOej2lbGX8Uv/Mf
 /bR+rwheCDmGPRsy7NFoXDHYk6VCT5IV8KqSefNSBI/dYqHGQgOcbaUS80pRDuhtuM/AVIF/J4g
 0oNuh0zAmp7gFIZBdiwC01A4ikPzBhMFM0cp0dgI0LtaMdJQDAFuCQ2GqbT7sI3lyGzTR83zr/p
 Sd2KXA7G+dUoE7KnchXS1dZBsV5XFOopScyGSCYb7eJjAwWrVlamU3N2hWvSpNBhKESMp2QUx+n
 0stmaTE+IUXUQ+NR5zATiCS5FZdlsQzkVGGSWA2k9gTfnA4dDbNc
X-Received: by 2002:a17:903:32cc:b0:234:c5c1:9b5f with SMTP id
 d9443c01a7336-23e256b6e89mr244456555ad.16.1753097482819; 
 Mon, 21 Jul 2025 04:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHntwN9CY/ddE+iepBKZfRP4Tl+nIoG+xMRc7ujVb1U4aH+MeR/PyqquRbvhnoPtFl2LqkpSA==
X-Received: by 2002:a17:903:32cc:b0:234:c5c1:9b5f with SMTP id
 d9443c01a7336-23e256b6e89mr244456055ad.16.1753097482402; 
 Mon, 21 Jul 2025 04:31:22 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:31:22 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:18 +0530
Subject: [PATCH v6 13/24] migration: push Error **errp into
 loadvm_postcopy_handle_run()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-propagate_tpm_error-v6-13-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=armenon@redhat.com;
 h=from:subject:message-id; bh=TONLV2CnLzLVhvR62svdv6KnanpfdwsJshUlVQ9ywUM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyqRfemtS04U9z3L+S3nIcHOdj2hNrFSZdRAvO6v8a
 mnhM94dpSwMYlwMsmKKLA1fA2SbAgojIm1fXoeZw8oEMoSBi1MAJtK1npHh4IkZb7sd3basiav5
 vULs7mPjBq/l0X1V2ZNiKhX6Xk+2YPjDNa1028m2zsQHZmp3Z2w79c4x4/W0K+aa4Ru2uMnZ3dn
 HDgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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
It is ensured that loadvm_postcopy_handle_run() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 09d12dbcf59e2dedd529224f70003e6e673442ff..856ec984e1ab09f5fddfd30eeb59e73a4c981697 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2271,13 +2271,14 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 }
 
 /* After all discards we can start running and asking for pages */
-static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
 {
     PostcopyState ps = postcopy_state_get();
 
     trace_loadvm_postcopy_handle_run();
     if (ps != POSTCOPY_INCOMING_LISTENING) {
-        error_report("CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_RUN in wrong postcopy "
+                   "state (%d)", ps);
         return -1;
     }
 
@@ -2625,12 +2626,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
-        ret = loadvm_postcopy_handle_run(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         ret = loadvm_postcopy_ram_handle_discard(mis, len);

-- 
2.50.0


