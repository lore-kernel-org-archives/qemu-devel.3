Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8154C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yd-00046R-5l; Thu, 20 Aug 2026 12:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yb-00043O-9s
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yX-0005TR-St
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esr51iSHBjd/y3UjyJmq4pMVM2wH/MerbWeavAT2qh0=;
 b=AKja7Yqp3FyQLL0eyk982b8HmD9M9OCsFCsQEQcOrJW6Ik8Z+FBH4iHT5qS1k7byhve3Lk
 ooHxIFMxCFM67wkRnNdoNUFFvRgMUJIQqY6O8VoOKtcKXMbnMPqGUWhVojiGeuYMofbR+e
 YqosxHWPL+7U3vsaTViP2kfATHWiV4A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-LTQ7m2e6MBqPKdVXXJcRlg-1; Thu, 20 Aug 2026 12:50:42 -0400
X-MC-Unique: LTQ7m2e6MBqPKdVXXJcRlg-1
X-Mimecast-MFC-AGG-ID: LTQ7m2e6MBqPKdVXXJcRlg_1787244641
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47faa02f707so976826f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244641; x=1787849441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=esr51iSHBjd/y3UjyJmq4pMVM2wH/MerbWeavAT2qh0=;
 b=si2l1JP6bDTw/TvdnRECLOzrM3EsDBGudV7cNe1T/6ICXzLuBiMzXfdfSMFYo4yiq+
 FmVUp2ybnc5eckIrrE4JVy/eweyYBzNborTqbJrLcY6amn+X8hUA8hNN3HWIDXsKYVnx
 xjk58coUxv1cetDyOVtwovR9sCq9G5y4vOgwCqVMoJLES8ILGaL0hBnFfRzgmWi3jydk
 q4Z4k7W5Nf42PrKSxivjijLu/Z7c6sP4lc3nWrdL/kdn93UjjxgDE7ZVkttWrDx94EYJ
 IxDJ4PSt5PGPkQDb+bW57w0yeTUqlGyorxNmBt3BlW7Zql1gaP22ipzrcT1gtx3m+XE7
 xJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244641; x=1787849441;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=esr51iSHBjd/y3UjyJmq4pMVM2wH/MerbWeavAT2qh0=;
 b=sF2M+lt5rsM5UbC7+GC42Qa0XR+0WKZlBP16jupY62btCJyX7wPyKvt1IlE29if9+V
 O0mQNzujmaSI7X7UZMxzCxgbm88MTyDeVYLDEDnGEnqye9lmI/lXpTFBNLcqLpe6xbzX
 4uLWw7yZiNR/idZPkJYAR0ShTHL+ujfKTalQKYN7TeCks1yQ2s3WqzNBN4y59pmo6Acc
 cy4xHGwghV6E55xrzyZD45aS22LgTrskGN7i1gjYPei+KXOr9XvvLrTo1nI2f6L4UgVK
 Eyh6w5lMI+X55Xq0zvxaCp8PpqUSHyv9MlrzBMPq8NsqJuT2uvE4cMjYG1R0E/yyJr1R
 sqAw==
X-Gm-Message-State: AFuF++m5awaU2YKFYrVwGLEjKe98gnDqozMi6N6eUMxdO39ZlAPIUfmU
 PDk9q3WmwYMwtry8qjCdEVC5e3zwhWTb92xhbiImShft3zUaQfNDyFySR1lXXP9AmqwaoXtS31q
 CjHos+LBikPg56jkbl6NXlgMB/FY+2SgRwUtscMv+YQ3DybwN4lBTV8Ac7GkmMoEJpgsIm2NSGX
 DB9MGTV6UETuRNiUTAYXsqKR4kfC6UjabXq88CJ8Lq
X-Gm-Gg: AR+sD10aW/Xj6JhIHghSK7rIgDJrAoLpdDUhTJO8chd3yN8QOMTQUb9Ufx5k868Ew+n
 8NfKQYnGjbJ+vYfntW6FwmehC7lUiKFP30M8aNkwCz/CVgkJThuzXOWjDu0sHBjTYR1HYxK4oTJ
 /GZYLuO3eyuFxupQHRzOec/jFGcO8pA4Yui4r871t1f5XM780AzMBNBvy4QWjsYxgU9QcgXhwOu
 X4mkOSSLckiYv8SMpUrg4KTjzrlag0aH2PpJ6chdZP74urgehfQ0LW/LbPc65RirLZe33useeKc
 oalL3OZrSLyh6cfFXXjJNddEmfLO1hHHo5c6ozGHPCR2YZDi+Tac8+yMr4B1CXkZIaPcpYVE2XF
 o6hIekvOMrnb5/qvAzhnM7TZbj0Pdq1VfLpnBdB38IGBrKtty8NtUz4ELpUT00BUAqNrUWr3ED7
 nk4ik=
X-Received: by 2002:a05:6000:61e:b0:481:5a46:dbef with SMTP id
 ffacd0b85a97d-482b7811899mr13475347f8f.5.1787244641056; 
 Thu, 20 Aug 2026 09:50:41 -0700 (PDT)
X-Received: by 2002:a05:6000:61e:b0:481:5a46:dbef with SMTP id
 ffacd0b85a97d-482b7811899mr13475226f8f.5.1787244640514; 
 Thu, 20 Aug 2026 09:50:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b7d3asm13351802f8f.23.2026.08.20.09.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 14/53] target/i386/mshv: migrate Synic SINT MSRs
Date: Thu, 20 Aug 2026 18:49:17 +0200
Message-ID: <20260820164957.1895963-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Migrate HyperV SynIC SINT MSRs. We can only read/write those if SCONTROL
is enabled in the guest, hence we have to split the SINT MSR out and
make reading/writing them dependent on that MSR.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-7-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/msr.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index a5f639c3ca6..5288e32b6da 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -331,6 +331,8 @@ int mshv_get_msrs(CPUState *cpu)
     struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     size_t i, j;
     uint32_t name;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    bool synic_enabled;
 
     set_hv_name_in_assocs(assocs, n_assocs);
 
@@ -357,6 +359,27 @@ int mshv_get_msrs(CPUState *cpu)
 
     store_in_env(cpu, assocs, n_assocs);
 
+    /* Read SINT MSRs only if SynIC is enabled */
+    synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
+    if (synic_enabled) {
+        QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
+
+        for (i = 0; i < HV_SINT_COUNT; i++) {
+            assocs[i].name = HV_REGISTER_SINT0 + i;
+        }
+
+        ret = mshv_get_generic_regs(cpu, assocs, HV_SINT_COUNT);
+        if (ret < 0) {
+            error_report("Failed to get SynIC SINT MSRs");
+            return -errno;
+        }
+
+        for (i = 0; i < HV_SINT_COUNT; i++) {
+            uint64_t hv_sint_value = assocs[i].value.reg64;
+            x86cpu->env.msr_hv_synic_sint[i] = hv_sint_value;
+        }
+    }
+
     return 0;
 }
 
@@ -391,6 +414,8 @@ int mshv_set_msrs(const CPUState *cpu)
     struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     int ret;
     size_t i, j;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    bool synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
 
     load_from_env(cpu, assocs, n_assocs);
 
@@ -423,5 +448,21 @@ int mshv_set_msrs(const CPUState *cpu)
         return -errno;
     }
 
+    /* SINT MSRs can only be written if SCONTROL has been set, so we split */
+    if (synic_enabled) {
+        QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
+
+        for (i = 0; i < HV_SINT_COUNT; i++) {
+            assocs[i].name        = HV_REGISTER_SINT0 + i;
+            assocs[i].value.reg64 = x86cpu->env.msr_hv_synic_sint[i];
+        }
+
+        ret = mshv_set_generic_regs(cpu, assocs, HV_SINT_COUNT);
+        if (ret < 0) {
+            error_report("Failed to set SynIC SINT MSRs");
+            return -errno;
+        }
+    }
+
     return 0;
 }
-- 
2.55.0


