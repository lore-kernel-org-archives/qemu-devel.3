Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E3CC624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwysi-0001ST-Uk; Mon, 02 Mar 2026 03:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysY-0001Oz-PF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysV-0001Tq-I2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5qZgLNKA9poYeTAUmYdiWdVUJItW4x3tAQyKyP+eAk=;
 b=KwE50Ukw8Fslm4F/ag2wAPP2SAbBVbkBIZgUc0JKXNUD58v2QHoT0Tjywa8n/3OC7OvoWj
 u6lR9cMWU9id/kziedVJrEK4Lg1ywOx1Q2xLREjgcY9h/0JKWXT7+poBQsF5Z6GYB5T15/
 YZePI6IEVm/nqxRugkGny13TjS3pxiM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-esP3egdwOjaYCOObQTIlRQ-1; Mon, 02 Mar 2026 03:43:45 -0500
X-MC-Unique: esP3egdwOjaYCOObQTIlRQ-1
X-Mimecast-MFC-AGG-ID: esP3egdwOjaYCOObQTIlRQ_1772441024
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso46174165e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441023; x=1773045823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5qZgLNKA9poYeTAUmYdiWdVUJItW4x3tAQyKyP+eAk=;
 b=GPdKkRMyDJLSnR6Cp/wXb4/CExpSd9qdV6N6gmO62rlZQTuAkW8Jp8r59ycKBJ95VU
 6lcwVM9KL+m/EDYgiaJfFNwydxjQI+gvYsQ1A8zni2UubSC+ZIiqTCad4zBfSw1J4cxT
 AxKaZyhYoaiI/REGSNJi8fteCyrVtURYGsWqhFQtGAEI/mXE7MBprLSQxqZH3l/sCnLi
 sDY7iVw4SuESa5nD1UaoVdl/3M94AKpEvIY0/bykI4vmxvppbbGNIXXJsikahGxia3xj
 nhbT41KK7wL8+1L9GlnupxH3p5yhZbpAYlWVo/r25B0HkGG5Vln7UCMex72c2GWcPI/c
 gxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441023; x=1773045823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q5qZgLNKA9poYeTAUmYdiWdVUJItW4x3tAQyKyP+eAk=;
 b=Oyd4fUiwyMa63ZPbESIt2na2CFmY4tgvKPRvuPZSzjV3fOQr9xQkCBEuWKnvwHl5Yl
 nFm5V5W1LGwZeemFccfWU/BJ85XdrOHDCqndU9RZjaaeWVBpj1m4xTybpJg+6zBkKM6C
 zTn2tJzwr4gjkZZgHqnvVqaLyXJ7sbCaLcImJYpBaNaAB9d1bVr+jB89wEYxws35cjwX
 6HzzicWL7KviUu+np4P7tfdPlqTYmWCVDRn1Vwbgw+/wQtTpW7dHtnjsml63LdkKNQeE
 ORpFBmzqjQZu3JaXXhRvkyk3yEWDQISYsuZNMBwG4Grz2GaLqp2Nedl+X2kCUg+Wp8pC
 tOSA==
X-Gm-Message-State: AOJu0YxzxAI4Hc9Qm+FN6WQWunQ5BudRtR0a8e7AKvMiRcaowC+57Edr
 KR11ZhsTKAh+r9pRQKjIy1RO1w3Y2tX7HG/RFKQfTNwy9bkJFurvDtJVq3sqOylJUTza54A17fq
 hW0ZOAUpuI67xE8hTakdEFmoL/OE+GkVfMl7c3d6krJrjCR0AWBCKFx+N2FuWA4kUmarke32b0x
 UyA+PJ1wSaWroSmSnrAp4VEj/Jc3MMmEeGptF1v/Hp
X-Gm-Gg: ATEYQzw85Ahs9LPmrvkR0L2SdZG+PAI9+2IPEKnGToNAuISdArRz169bSfA4En49Pn/
 Nt8ReY02M2ucMnhDsKWp0c4Be+N6tbK5gu1Uum6y1H67miyuc/AVpOHzF6WdSmWnKzqE67z9uKJ
 jiXrObMNr6Q73dzpkyRJCPFf1Xmvgx0/E1s2Fnng35uOnQqOTRPuJ7bGklF1I5aWsLnh7mTgPJn
 XDKg+MRIsjJbkcVMdNjmMxxtuxB99hLEZyIGDwLK16GEGL4Fh6hJbN9tOt5bPnzYuLeQ6thW0F7
 a0hYJU45o1T5071AIFKoQ5j1nAxQF4sjxnRmJFrkRF61VKl9Fjo6t8VMLZ7Znhkpk3hSbxiPVCq
 be6C1Hjab83GTm2YgaSftd4kdo12aJB0rrZpUac3pp5GqSlnOcLI87sUMFAIXyGNXjtHDSm42+q
 4MSWdInquYD9/ueDwZGP0mVtp4f7o=
X-Received: by 2002:a05:600c:699a:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-483c9bf44e8mr182307385e9.25.1772441023233; 
 Mon, 02 Mar 2026 00:43:43 -0800 (PST)
X-Received: by 2002:a05:600c:699a:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-483c9bf44e8mr182307005e9.25.1772441022669; 
 Mon, 02 Mar 2026 00:43:42 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b4175fd2sm9780766f8f.14.2026.03.02.00.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:43:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Justin Forbes <jforbes@fedoraproject.org>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL 001/102] hw/i386/vmmouse: Fix hypercall clobbers
Date: Mon,  2 Mar 2026 09:41:56 +0100
Message-ID: <20260302084338.473368-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Josh Poimboeuf <jpoimboe@kernel.org>

Fedora QA reported the following kernel panic:

  BUG: unable to handle page fault for address: 0000000040003e54
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 1082ec067 P4D 0
  Oops: Oops: 0002 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-0.rc4.260108gf0b9d8eb98df.34.fc43.x86_64 #1 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20251119-3.fc43 11/19/2025
  RIP: 0010:vmware_hypercall4.constprop.0+0x52/0x90
  Code: 48 83 c4 20 5b e9 69 f0 fc fe 8b 05 a0 c1 b2 01 85 c0 74 23 b8 68 58 4d 56 b9 27 00 00 00 31 d2 bb 04 00 00 00 66 ba 58 56 ed <89> 1f 89 0e 41 89 10 5b e9 3c f0 fc fe 6a 00 49 89 f9 45 31 c0 31
  RSP: 0018:ff5eeb3240003e40 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: 000000000000ffca RCX: 000000000000ffac
  RDX: 0000000000000000 RSI: 0000000040003e58 RDI: 0000000040003e54
  RBP: ff1e05f3c1204800 R08: ff5eeb3240003e5c R09: 000000009d899c41
  R10: 000000000000003d R11: ff5eeb3240003ff8 R12: 0000000000000000
  R13: 00000000000000ff R14: ff1e05f3c02f9e00 R15: 000000000000000c
  FS:  0000000000000000(0000) GS:ff1e05f489e40000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000040003e54 CR3: 000000010841d002 CR4: 0000000000771ef0
  PKRU: 55555554
  Call Trace:
   <IRQ>
   vmmouse_report_events+0x13e/0x1b0
   psmouse_handle_byte+0x15/0x60
   ps2_interrupt+0x8a/0xd0
   ...

It was triggered by dereferencing a bad pointer (RDI) immediately after
a VMware hypercall for VMWARE_CMD_ABSPOINTER_DATA in the vmmouse driver:

  ffffffff82135070 <vmware_hypercall4.constprop.0>:
  ...
  ffffffff821350ac:       b8 68 58 4d 56          mov    $0x564d5868,%eax
  ffffffff821350b1:       b9 27 00 00 00          mov    $0x27,%ecx
  ffffffff821350b6:       31 d2                   xor    %edx,%edx
  ffffffff821350b8:       bb 04 00 00 00          mov    $0x4,%ebx
  ffffffff821350bd:       66 ba 58 56             mov    $0x5658,%dx
  ffffffff821350c1:       ed                      in     (%dx),%eax	<-- hypercall
  ffffffff821350c2:       89 1f                   mov    %ebx,(%rdi)	<-- crash

Reading the kernel disassembly shows that RDI should contain the value
of a valid kernel stack address here (0xff5eeb3240003e54).  Instead it
contains 0x40003e54, suggesting the hypervisor cleared the upper 32
bits.

And indeed, Alexey discovered that QEMU's vmmouse_get_data() and
vmmouse_set_data() are only saving/restoring the lower 32 bits, while
clearing the upper 32.  Fix that by changing the type of the saved data
array from uint32_t to uint64_t.

Fixes: 548df2acc6fc ("VMMouse Emulation, by Anthony Liguori.")
Reported-by: Justin Forbes <jforbes@fedoraproject.org>
Debugged-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/c508fc1d4a4ccd8c9fb1e51b71df089e31115a53.1770309998.git.jpoimboe@kernel.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3293
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/vmmouse.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 2ae7f3a242e..c1aeeca0c9a 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -72,7 +72,7 @@ struct VMMouseState {
     ISAKBDState *i8042;
 };
 
-static void vmmouse_get_data(uint32_t *data)
+static void vmmouse_get_data(uint64_t *data)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
     CPUX86State *env = &cpu->env;
@@ -82,7 +82,7 @@ static void vmmouse_get_data(uint32_t *data)
     data[4] = env->regs[R_ESI]; data[5] = env->regs[R_EDI];
 }
 
-static void vmmouse_set_data(const uint32_t *data)
+static void vmmouse_set_data(const uint64_t *data)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
     CPUX86State *env = &cpu->env;
@@ -197,7 +197,7 @@ static void vmmouse_disable(VMMouseState *s)
     vmmouse_remove_handler(s);
 }
 
-static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
+static void vmmouse_data(VMMouseState *s, uint64_t *data, uint32_t size)
 {
     int i;
 
@@ -221,7 +221,7 @@ static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
 static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
 {
     VMMouseState *s = opaque;
-    uint32_t data[6];
+    uint64_t data[6];
     uint16_t command;
 
     vmmouse_get_data(data);
@@ -247,7 +247,7 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
             vmmouse_request_absolute(s);
             break;
         default:
-            printf("vmmouse: unknown command %x\n", data[1]);
+            printf("vmmouse: unknown command %" PRIx64 "\n", data[1]);
             break;
         }
         break;
-- 
2.53.0


