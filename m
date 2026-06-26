Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E9DCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3dQ-0006fO-8u; Fri, 26 Jun 2026 06:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dK-0006bb-3E
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dG-00056T-Jy
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ThgqOymbZD2sNEeS7GzI8rxbBAg23a2WJXA/vUiJ6AU=;
 b=DqoVzMvEoSouSnR+kfkPKSiaw46fEJnCO5FdYMSnTx6MmdHyQ3DTwg6RHAleCzNRk9/qvu
 CvNVgDIMompFtc9ruE41A95kCywrNoS8zV68QDxeCyWakMkg2uIh65vAl1F2/V7YQXUaAO
 k+qQbeL1m7UYAymLs+jJbQhjMpMWWBc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-5LeMvdqpORepGqppNAA5sQ-1; Fri, 26 Jun 2026 06:17:56 -0400
X-MC-Unique: 5LeMvdqpORepGqppNAA5sQ-1
X-Mimecast-MFC-AGG-ID: 5LeMvdqpORepGqppNAA5sQ_1782469075
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a767b782so6137375e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469075; x=1783073875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThgqOymbZD2sNEeS7GzI8rxbBAg23a2WJXA/vUiJ6AU=;
 b=dLajj9ZPiLF7yf9iZ2WIWuAOHtyqStiqCcYyzPLLCZ31LoKVV9WD5imiKazMGzXPfy
 i5ugHvR3HW6Tnpjos5wLo/ZJsvF/x+6hqqc2GZxb2kz07aDJwMqYyXTeYRK5C1Sg0QSm
 XaQ9tQmzCUivxbLOfUDNtFuDs38MepuToRTY6KIuS0KxEXzw/RflMARt3aFyO3dgbcFz
 5gD1xq3uxqeSETVMgOXf5w6zLLQyKANH1+L+D6e1+PFeQzyUdL1H4o+YZv+hhmNBLapW
 DJhLx4kSGLakr7rNGqe0VHeI8m0nJ6/V8tBwgRylmOpkVkx3H1HKkdu/pEzHsOlBBF1R
 eJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469075; x=1783073875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ThgqOymbZD2sNEeS7GzI8rxbBAg23a2WJXA/vUiJ6AU=;
 b=kdPiseEjiReyWRdSKvfKxyFJeRpuwxrOt+W1znF4irPBGZjqhlaA80vF798ZRqGjh/
 mYuggSuNtuX4hTq7/t3uIp9JPCEiLjbtCKlV+navxcD5U3BmxjPrxtjzBVoZ1/HKa3Ev
 m/zagrvv8H2Zd6kBzOCiGzSmTThC96SowsW0OhnoTLvVE6gNKFy9X1vPCEfIe2m0lvSM
 PaoAec/YClJIiGsos49a9WDLBlZwKXcVmZKTr6sIM+PPFVizZvct1lpDkh59TXXAqBdt
 QfKMAg43DLiwKuSD8rfScmNj2W/4d9yYx1KMHoP/BiDQ4XXArHkj6d5/Wn19yhUKsUhO
 2/ZA==
X-Gm-Message-State: AOJu0YxLw6garzn907kmsu/u/cs340niQGFZweaYIoueDexM1Nrpq5h0
 +Tl0EA6Zvu+5WAs8xDYbIgH/OINJTxgJevufpDFCskekTAsQ3hpqwM3Jp83NmsGM2I0UpHxd9Yd
 Ai80BPbt4I4BYa5I7biIpDU4zFSOd8uV+jdCfDzNH9h/31jbn2YWU/RWoYaqnWwj132I1JwPwkq
 Gw6BSFJWusSNSedXFspgUxYm1c884jyRQ21jnMYXFr
X-Gm-Gg: AfdE7cnbqWaXxiYwP9Dlgf1ygk0qGcb0K2Tr17pfcGgxCVEb1wG9YWFUliQLHIfMpVV
 EsOEXmEOVnFAMqhmo9UPH2vdWQIdBilFFv118Ti3l1w8o0OEWoOS0CH2s+FSuOQ/YDBfYaXEgoM
 8mrcgpWqiyVLB7R4eBu8lkH0FdI/kVLZQBfUQFBLRTjLs12fWDJfOR9gam3lBvwWnGgYrhTFCQe
 9lsk6rytBIqzz6dq0mQ9aMj9Ge9suLrz7VWF2n1lr6r2kmwG29BKiSiqCUVE2eRyPHgPo5fvN7e
 3BLMfq46q1bwZIt8gekghLrEItKjbitv67EuWatwXBXp3bte6Pus3U8Izg8OYqigX4vEcycGrqE
 PF9u3p9fJQh8jYTC1L5qPBLeU//MuhF3uIJLcdX5blrnZ9Bk0ZtjTc8IHLD0dVVhkf8RWkk7C8I
 XGF2dWcoRVHs7HRUDQ
X-Received: by 2002:a05:600c:a013:b0:490:c032:ae92 with SMTP id
 5b1f17b1804b1-49266892207mr92940175e9.33.1782469075465; 
 Fri, 26 Jun 2026 03:17:55 -0700 (PDT)
X-Received: by 2002:a05:600c:a013:b0:490:c032:ae92 with SMTP id
 5b1f17b1804b1-49266892207mr92939755e9.33.1782469075047; 
 Fri, 26 Jun 2026 03:17:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee018e8sm26100926f8f.11.2026.06.26.03.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:17:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 02/45] target/i386/mshv: fix cpuid propagation bug
Date: Fri, 26 Jun 2026 12:17:05 +0200
Message-ID: <20260626101748.1728079-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

The list argument was missing a pointer and hence e.g. -cpu qemu64 and
-cpu EPYC would produce the same of cpuid leaves.

Fixes: 4fa04dd1621 ("target/i386: Register CPUID entries with MSHV")

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260416121116.527927-3-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 4ed6e7548f6..38994ed6cfd 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -441,7 +441,7 @@ int mshv_load_regs(CPUState *cpu)
     return 0;
 }
 
-static void add_cpuid_entry(GList *cpuid_entries,
+static void add_cpuid_entry(GList **cpuid_entries,
                             uint32_t function, uint32_t index,
                             uint32_t eax, uint32_t ebx,
                             uint32_t ecx, uint32_t edx)
@@ -456,10 +456,10 @@ static void add_cpuid_entry(GList *cpuid_entries,
     entry->ecx = ecx;
     entry->edx = edx;
 
-    cpuid_entries = g_list_append(cpuid_entries, entry);
+    *cpuid_entries = g_list_append(*cpuid_entries, entry);
 }
 
-static void collect_cpuid_entries(const CPUState *cpu, GList *cpuid_entries)
+static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
@@ -615,7 +615,7 @@ static int set_cpuid2(const CPUState *cpu)
     struct hv_cpuid_entry *entry;
     GList *entries = NULL;
 
-    collect_cpuid_entries(cpu, entries);
+    collect_cpuid_entries(cpu, &entries);
     n_entries = g_list_length(entries);
 
     cpuid_size = sizeof(struct hv_cpuid)
-- 
2.54.0


