Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D03C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucChS-0005lC-8k; Wed, 16 Jul 2025 20:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCff-0003f0-Ju
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCfa-0004zX-Kv
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZ0YZUXDiWb+ftqHaZ7WVZRt6gYFvJwP+252zqkyPx8=;
 b=drJeL5hK7izS/2HCqbfC1C5DooucnTYsLbOlk/etK5pcukFJaOTBpD7Tukz+Nk4nTi0kks
 iTnoyIoZrTgmm4ljVhcBHWcWudJqOf59W7mtqV4eBreBxPLLd65ie/EakrNjKdBIqsYL1L
 o6DaOa7n6P+vB3qYAsSlU/aY1HwLGOM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-5VRvWgosNaqdQwhygLlm4Q-1; Wed, 16 Jul 2025 20:40:15 -0400
X-MC-Unique: 5VRvWgosNaqdQwhygLlm4Q-1
X-Mimecast-MFC-AGG-ID: 5VRvWgosNaqdQwhygLlm4Q_1752712815
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23827190886so3356515ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712814; x=1753317614;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZ0YZUXDiWb+ftqHaZ7WVZRt6gYFvJwP+252zqkyPx8=;
 b=V3aZUog5Jh5wGHftylT1NKeyFHwpUjqyp/wdQPAVkV5fRRL8mdhXd2JUStvP3Vn4iT
 eKBlmRe8/4SW9yzu9FkD77GrNBD4BQA8XWfHFRQXQMJsCIc9lPToYISfqTHB+aKCmlmt
 PI8HbdhBuG2rFAVakx4Emf9xcU/kde2dc+mOKXAuqfQv4wdWmO14nFzccjRchmKEo7xR
 KBwdmUv1gY3IhhMKmurmGeT6tLqihEh3P7TSD43r/mgruOwewb5uJ+/EChyjq/VXVKIG
 i1poEkZ7dtnnjk0kdOCY1kQGTcKlGlCDB9eK8EgPs54CjdTtXecxvtHxZVCXBTEzKyeL
 XKiA==
X-Gm-Message-State: AOJu0Yw5bfJJR1C3jGF1MUP2+OG5v9yKgKzLxWnXp/yL3I8awidGBURP
 ogckTURqlpGvMcjhxlC9QtYJEHMX0MrVk0xQVaESI7X95krQS5IKHvFq3QQNJBxXH8N8ryD69DE
 LZv84BnnpimZ9yLE1YFlsVs7FXxHHDgGyoEJuUO7AAEHkMbNQT54LqQDk
X-Gm-Gg: ASbGnct74pGibY7k78rKmD0RTzaHLpvYRLJteVuWp/8VCpaVlP+Tma2oM176NrqeXhM
 0im3NSFXHgf6uesU+9kz4ujhu7X07162FypBFn3z8Mrl3K+L1sOcHBZam41MbZQru94D7cy1JI9
 ZHN0mezLnZdg2bDfV54cTMVrVcNb3o29XfLDd+E1K9Cz3HpDmQyDRLAOJGK5vXDSaeOiF0Kzn4r
 qjtzOXay/KAvqqWluICJLyaOldl+iQAJKxdLkvi5fZRuoSl3vXCrYBcnEZzGoIi3x/dCpf6guIa
 AscJ/nZnL4AcH6rV7rxjpY+95NoiJroR+261t7Xa/AwYDV0SL9au
X-Received: by 2002:a17:902:d2c8:b0:23d:fa75:eaee with SMTP id
 d9443c01a7336-23e2572a013mr68449945ad.32.1752712814595; 
 Wed, 16 Jul 2025 17:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHylzS3NeT330/Yb5NqSyNrAkE53UG+yUhfnUgAFG8x5s/1xTPGbKoB/2tuhFMYZ26BkIG70g==
X-Received: by 2002:a17:902:d2c8:b0:23d:fa75:eaee with SMTP id
 d9443c01a7336-23e2572a013mr68449565ad.32.1752712814193; 
 Wed, 16 Jul 2025 17:40:14 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:40:13 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:31 +0530
Subject: [PATCH v5 08/23] migration: push Error **errp into
 loadvm_handle_cmd_packaged()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-8-1f406f88ee65@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
In-Reply-To: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
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
 h=from:subject:message-id; bh=5drxytJC6sRDNwDxqC8A6N42M/U5XAm4KwfI3qYVSfs=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm7zTa78NoYGK9y6tKXz1O2xeYKHc55u5ZxgCJpzLj
 fHXTljfUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCLCAowMs87ImZyYsECNbYvL
 xVfvghnv7VNZ7DT/+Mk1Pp9lPza1n2RkeK7AIMgtNidCY+fvJb4cU9ref7ifUeqau3KxoP2EY3I
 BDAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 98711bb38a4548d4f168459f729f604a78716c25..d1edeaac5f2a5df2f6d94357388be807a938b2ef 100644
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
@@ -2610,12 +2613,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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


