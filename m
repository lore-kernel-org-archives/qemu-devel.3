Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0095F46C45
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kmq-0003zx-AL; Mon, 06 Apr 2026 10:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kmk-0003yc-AC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kmi-00054S-Pf
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775485116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBU+397EypgY+h5PHONu2tHrEibGvEnQLvVz+RQFsbU=;
 b=hzUIvVjwAX5UZEWS30WIt7m9OpOSIjMAQ4JwPp9Dne1Hy63hvkElLt3JjRLf01VakWYGvB
 godjcUOi3e4ZBeqiXQG7BGlS8Mu8sTX8X0ncKooVpYG55Mqc1Z3dc2kKenpB+Vou/9c29w
 ay5fENbLjY3PPz6Lo1iuOEWI7rYu+dc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-WCBSQPzCMUW-6NYjdpZEMw-1; Mon, 06 Apr 2026 10:18:34 -0400
X-MC-Unique: WCBSQPzCMUW-6NYjdpZEMw-1
X-Mimecast-MFC-AGG-ID: WCBSQPzCMUW-6NYjdpZEMw_1775485113
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b0b57e192bso31466095ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775485113; x=1776089913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBU+397EypgY+h5PHONu2tHrEibGvEnQLvVz+RQFsbU=;
 b=gqTwhPRKEEtVEeMBzF2/uyPmPDa2DMYJrg9HsKM6DE5HtTJX4kr54pjJLy7mQCJyzq
 mE8aKnYs+mcjfqZ06ae2YJKQGg/IeJsM9Sc/QjewUMrBcXuI68blj3mDBnk/Y3ab9hL4
 Bs/Jp+rygJkHv2J7uPW23ovndjD10IujqMKGHdlnSHydN4zyWYcZx+/Zwe1nqEtk+nYP
 0ZYEK4K/NZ1BOWOh2iDFA+aY4G9RNB5mLZns79KNar5uGD2wIR/Nx7v9JYKrYQqBMs4A
 0vctltP+qPjFJI5GT3IIhZU08jsySSavdUHDNj1q4V/pRwPRd1OSAeRTEu2EkzrK2IW3
 pHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485113; x=1776089913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wBU+397EypgY+h5PHONu2tHrEibGvEnQLvVz+RQFsbU=;
 b=cqqMZrwA58TjpJDBSlwx7RmsIVnEc3XnneeponHJCKT51LnVhyc5XGygu15EeuYssI
 HVZWt4lx127KInh1QEHQW9PfH6+bY77QTXMRrEKHAiGEM1/oZ0wXsz749KH2fVMMBetB
 vGS4GU/HSa7Trj1z7ZcnI0lNrP7X0+lexdOJgn4lgVyjgkGggJSwkzRoa/i+zflbhft4
 ryxj4nWgHe6YadJx96Inl1EFhqgUZxyomsJ6WD+CgUqq2//fuc704XFTqgTPmyGtiPAU
 BpKBxiaPPuyDt0QmcXXx83lmsVPfF0i/zUyvwxxVI4iG00sD20DFZkRtLfRGINgSp7mN
 gzvA==
X-Gm-Message-State: AOJu0YzDUfv6pHIrec/dhgKww26gjZwW+TPVA59//qxcVbq3LmrlJUQf
 kxLNER8f8CibjyJRSDY3/suigUPqnJ2ySGZlDUhQnDwOyqgrUrRHo0V25wH2ahQxx8R833Ttmdx
 DnXNf/IA2/Gb5PjlcqmLM2eRD9O55teJVJl12a8F0PBqMSPQj2ZO5ePdjlT7eQfpM9mk2IBaqMg
 agN8LK7Kb6818+ugoDy4NKDGTIZXjy8sy0r82mvjs=
X-Gm-Gg: AeBDievgQJVG0n7657SfnvjN/TEXX7rTOew4mXNwb8CUXk/eI1NayG//SJUhcSGWD/s
 5aJJKwvct/E4+SERpBkQqmXEP8Rd4C6tKPft/hJ16VA8f+1bRsq1l+StmDj+xh2/qjBN615CzWv
 RRd9WxTdiayG2oa9mAe5FBY79uqMoSzFaljVDCcne7957feWFUwrhURL4mz/q2a7YHRFLqnR2cw
 z2UvBydtO6r5SFkIiipvYnFdWvr1d5ShKUsJvphXFlkcias2WQKjFpToHs0O5Qx2KjQEJhzRMLt
 pzhSi8y+cex0ZroJNZM/zz4DHzWCIpVh0fkPD2H+dRagZnUeiCDuPdNhC51pgyACwAPRA68lfMK
 1jHMXyP/leCaEW9tOa8K539haZHWKMRm7IsI1e3KQearsuL4aChjcssZQxpc77570SEM=
X-Received: by 2002:a17:903:1ae3:b0:2b0:afad:7aad with SMTP id
 d9443c01a7336-2b2818016c3mr133742145ad.45.1775485112933; 
 Mon, 06 Apr 2026 07:18:32 -0700 (PDT)
X-Received: by 2002:a17:903:1ae3:b0:2b0:afad:7aad with SMTP id
 d9443c01a7336-2b2818016c3mr133741645ad.45.1775485112390; 
 Mon, 06 Apr 2026 07:18:32 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156732905ad.29.2026.04.06.07.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:18:31 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 06/10] hw/tpm: Add support for VM migration with TPM CRB
 chunking
Date: Mon,  6 Apr 2026 19:47:31 +0530
Message-ID: <20260406141735.25844-7-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406141735.25844-1-armenon@redhat.com>
References: <20260406141735.25844-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Arun Menon <armenon@redhat.com>

- Add subsection in VMState for TPM CRB with the newly introduced
  command and response buffers, along with a needed callback, so that
  newer QEMU only sends the buffers if it is necessary.
- Add hw_compat blocker because the feature is only supported for
  machine type 11.1 and higher.
- If the VM has no pending chunked TPM commands in the internal buffers
  during a VM migration, or if the machine type does not support newly
  introduced buffers, then the needed callback will return false, as it
  checks the hw_compat blocker and thus the subsection will not be sent
  to the destination host.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/core/machine.c |  4 +++-
 hw/tpm/tpm_crb.c  | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1abc8ae737..fb290c6c53 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,7 +38,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
-GlobalProperty hw_compat_11_0[] = {};
+GlobalProperty hw_compat_11_0[] = {
+    { "tpm-crb", "migrate-buffers", "off"},
+};
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
 GlobalProperty hw_compat_10_2[] = {
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index b9f295db7a..81471dd9f8 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -49,6 +49,8 @@ struct CRBState {
 
     bool ppi_enabled;
     TPMPPI ppi;
+
+    bool migrate_buffers;
 };
 typedef struct CRBState CRBState;
 
@@ -345,18 +347,47 @@ static int tpm_crb_pre_save(void *opaque)
     return 0;
 }
 
+static bool tpm_crb_chunk_needed(void *opaque)
+{
+    CRBState *s = opaque;
+
+    if (!s->migrate_buffers) {
+        return false;
+    }
+
+    return ((s->command_buffer && s->command_buffer->len > 0) ||
+            (s->response_buffer && s->response_buffer->len > 0));
+}
+
+static const VMStateDescription vmstate_tpm_crb_chunk = {
+    .name = "tpm-crb/chunk",
+    .version_id = 0,
+    .needed = tpm_crb_chunk_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_GBYTEARRAY(command_buffer, CRBState, 0),
+        VMSTATE_GBYTEARRAY(response_buffer, CRBState, 0),
+        VMSTATE_UINT32(response_offset, CRBState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tpm_crb = {
     .name = "tpm-crb",
     .pre_save = tpm_crb_pre_save,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
         VMSTATE_END_OF_LIST(),
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_tpm_crb_chunk,
+        NULL,
     }
 };
 
 static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
     DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
+    DEFINE_PROP_BOOL("migrate-buffers", CRBState, migrate_buffers, true),
 };
 
 static void tpm_crb_reset(void *dev)
-- 
2.53.0


