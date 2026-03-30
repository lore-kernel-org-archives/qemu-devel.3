Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577BF10D14A2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7BBI-00064e-Kb; Mon, 30 Mar 2026 07:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8z-0003h8-9Y
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8v-0005yu-IO
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfpuJ19t/UpPzsDmyGWAHDp6zIk3S1l1GzeSUE0fPeA=;
 b=hnjfwfS3jMbRjzZmOKiMjsd/pV9M0seYE2vTYBgowczH4JQtlCdH6FrrC34vvxurEL40Bg
 nnhf5fS2PQhynr4mLIGypRyAGSknBLm+D9An9sJ98+zDG77+X6pOjR0LkpscbVq212B+WZ
 tErt4Yi8yNIJ9PKpuRZuQ9agS9Xk9Qg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-S4hE5z2sNOmfK0UxEN2ekA-1; Mon, 30 Mar 2026 07:50:51 -0400
X-MC-Unique: S4hE5z2sNOmfK0UxEN2ekA-1
X-Mimecast-MFC-AGG-ID: S4hE5z2sNOmfK0UxEN2ekA_1774871450
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43ba02dc34bso2467114f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871450; x=1775476250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfpuJ19t/UpPzsDmyGWAHDp6zIk3S1l1GzeSUE0fPeA=;
 b=d3wFWdvaw8hxpIJEj8daUd8KTRkLCXBS9xwRmbdyMBy1XLPCfsp4XM98hy/znMhYk8
 514FY+IVeEdIukOa0+gO2uV6swnatqfMRsd7FFD34N6mSFBScLf4SszTFYi1vflnE99f
 jAoA3pB4w6WruOJmAVF3icbR58mihhPbggX5mf4gnvI479zRZnkEB43VNVQMRcr0RQhx
 MJiOhWROekjXBpS7qge25U/lE0y9FSkbp+E00dSj7a8mRFilYMJTSzDnnlsSyRWyUIN8
 d9eNKCu724tomBUGmxAzCneCrCkYHuX2eaOpxml9Z6dHQ1p337B7pTMtb0nzwsJ/1t9g
 wSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871450; x=1775476250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GfpuJ19t/UpPzsDmyGWAHDp6zIk3S1l1GzeSUE0fPeA=;
 b=Ruj1B7l3zQWZ5e0Sx3xWXl4/mzgTvsYHF2xaRe1cEvfkqH8D2eYi/Mil9TMA5jXJX2
 wtAKMLA+0yBtzTclZMoab22+CzQTMGwpsvngGeLWI+fWk8m22/07+m6hdJKLSIDAWNUt
 KM6u83+F2OcceHGRDqnjgVFWTZfgKXANQmgFA7BAmTOOt8S7LupwCm+4Bf9i2EjC5asj
 Ums3DH1ktP8vRULxtAF3Jbz3mZ0I0bUDnviN/UZqF6uLTTqvwvNjIDecRU4wqKA+MtpD
 1rPKasW7oGm3ZaohYcnuzFawHxXa3pnklJYbVlsPsK2KBnlyt575EGIRaIEr2KJgfpir
 HztA==
X-Gm-Message-State: AOJu0YxpWsmK8Sp9yfkPvdNem1PYRkj+0wDs7qyRuX+TOYlGo3HOA7+3
 1nEwevYGp5HMkoVeT31wga7JENbBQG/ivKnKUNbZjHrIp9rMF3XJ7sCbyZ2RKF4gsTB+HxcFVtc
 S0BOmyDlkmzUuxNa6dFD/pWmXBB0CyeSbBwkeVTtII5okpuqx7rraBl9dLRuLFxpWVyNwkV0gWE
 WF9fM/sV6lTf5pCJmpqCx1pPWGij3NUpV7trW1oJml
X-Gm-Gg: ATEYQzwmfl47uqF50XsQH8/uVttdWva2HOiCM3a81xj+gqAJWmMeN4/EzmrtbzRTENp
 eLHgjaKWMkNwwNY7EtgSGeugRoLNQIeW1Wvp2kOK6PIvZHohusDYsknMsKPbrEwo4Kglo28Yx1q
 b3e0cXygsG9HWVurstVUSFekRCOOHgd2QDFInLnzTXeutKLm8H7QNxRBw5MUSdFY4l0oNaSwQnF
 qq8XL+s+DORY9CVY9eSgazbPsRLRYlMBBT0sRYooGCQt1bLLdYUrgTOyYwNoFXOpFPaKLczKp/i
 eFBN9hnV1V3r3aeH/8dbM4CowkssrCaPSTwp72MHqn9yWU2bxL0YAKuTkTJIuwjeoFTGINsq5Io
 6PZMVXfQN9aQxdl/XeUeGAnAlAyQBKR488likPiDXd0actn1b1dBIv+Sqw7kLLwk7cYwseuXdz+
 2MuEPRMCRuxZhDFsyEYTyMvcPC
X-Received: by 2002:a5d:5f86:0:b0:43d:533:9559 with SMTP id
 ffacd0b85a97d-43d05339842mr1762381f8f.19.1774871449650; 
 Mon, 30 Mar 2026 04:50:49 -0700 (PDT)
X-Received: by 2002:a5d:5f86:0:b0:43d:533:9559 with SMTP id
 ffacd0b85a97d-43d05339842mr1762300f8f.19.1774871448976; 
 Mon, 30 Mar 2026 04:50:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e265fsm19207747f8f.1.2026.03.30.04.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/12] hw/acpi: Do not save/load cpuhp state unconditionally
Date: Mon, 30 Mar 2026 13:50:16 +0200
Message-ID: <20260330115017.256211-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
References: <20260330115017.256211-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

From: Zhao Liu <zhao1.liu@intel.com>

Commit 7aa563630b6b ("pc: Start with modern CPU hotplug interface
by default") removed the .needed callback (vmstate_test_use_cpuhp)
from vmstate_cpuhp_state in both piix4.c and ich9.c.

However, PIIX4 is also used by non-PC boards - MIPS Malta, which does
not select CONFIG_ACPI_CPU_HOTPLUG. For MIPS Malta, the linker resolves
vmstate_cpu_hotplug to the stub one in acpi-cpu-hotplug-stub.c, which is
a zero-initialized VMStateDescription with .fields == NULL.

Before commit 7aa563630b6b, .needed() of PIIX4's vmstate_cpuhp_state
returned false for MIPS Malta since PIIX4PMState always initialized the
field cpu_hotplug_legacy as true. Malta implicitly relies on this
initial value to bypass vmstate_cpuhp_state. However, this is unstable
because Malta itself does not support CPU hotplugging, whether via the
legacy way or the modern way.

Commit 7aa563630b6b removed .needed() check for vmstate_cpuhp_state,
this broke the existing dependency that Malta had relied on, forcing
Malta to save and load vmstate_cpuhp_state during the save/load process,
which in turn caused a segmentation fault due to NULL fields in the
stub-compiled code.

Fix this by bringing back the .needed = cpuhp_needed callback for
vmstate_cpuhp_state of PIIX4, that checks
MachineClass::has_hotpluggable_cpus. Boards that do not support CPU
hotplug (only MIPS Malta) will skip this subsection entirely, which
is both correct and consistent with the previous behavior.

At the same time, add a similar .needed() check to ICH9. Although no
boards with ICH9 are affected by this issue, this helps avoid potential
issues in the future.

Reproducer (MIPS Malta):
  $ qemu-img create -f qcow2 dummy.qcow2 32M
  $ qemu-system-mipsel -nographic \
      -drive if=none,format=qcow2,file=dummy.qcow2
  [Type "C-a c" to get the "(qemu)" monitor prompt)]
  (qemu) savevm foo    # segfault

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 7aa563630b6b ("pc: Start with modern CPU hotplug interface by default")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3360
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260330053008.2721532-1-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/acpi/ich9.c  | 8 ++++++++
 hw/acpi/piix4.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index bbb1bd60a20..5c7dfb2c69d 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -184,10 +184,18 @@ static const VMStateDescription vmstate_tco_io_state = {
     }
 };
 
+static bool cpuhp_needed(void *opaque)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+
+    return mc->has_hotpluggable_cpus;
+}
+
 static const VMStateDescription vmstate_cpuhp_state = {
     .name = "ich9_pm/cpuhp",
     .version_id = 1,
     .minimum_version_id = 1,
+    .needed = cpuhp_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, ICH9LPCPMRegs),
         VMSTATE_END_OF_LIST()
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 43860d12278..9b7f50c7afa 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -195,10 +195,18 @@ static const VMStateDescription vmstate_memhp_state = {
     }
 };
 
+static bool cpuhp_needed(void *opaque)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+
+    return mc->has_hotpluggable_cpus;
+}
+
 static const VMStateDescription vmstate_cpuhp_state = {
     .name = "piix4_pm/cpuhp",
     .version_id = 1,
     .minimum_version_id = 1,
+    .needed = cpuhp_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, PIIX4PMState),
         VMSTATE_END_OF_LIST()
-- 
2.53.0


