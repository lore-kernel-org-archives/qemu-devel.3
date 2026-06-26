Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1144CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eY-0000ks-TO; Fri, 26 Jun 2026 06:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eO-0008K8-KK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eM-0005MF-TJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMJTWCQgasnt3uwwNSi7XCS5So8lwAHMFw+1U5QkCu4=;
 b=Bv/cAxIb1JdrXJMY7+QTByoX1cYMZkBR1wa47U1Xj5+915Ce/owFUcDEF3ikOuwbDluAJH
 mOHFp4ua04yL3coY7SV0214CKwp8zbuXKTSDqC7GBRgkr6AyYmrYTMDxSSYSVBOW7Au5L8
 aMZv5LKXOm+mLtYpN3Bw2eLIXKMEtkg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-mlPgwHUbNq-qfyAxfRIo_Q-1; Fri, 26 Jun 2026 06:19:04 -0400
X-MC-Unique: mlPgwHUbNq-qfyAxfRIo_Q-1
X-Mimecast-MFC-AGG-ID: mlPgwHUbNq-qfyAxfRIo_Q_1782469144
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46010392f89so569324f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469143; x=1783073943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMJTWCQgasnt3uwwNSi7XCS5So8lwAHMFw+1U5QkCu4=;
 b=qa0V9aaOZapwqW494zhV2mo0+g97jRqy/AyJrsBSs1S6NYFvHYiMoTQVXpYdFPzGwU
 vdcuNYi3xuTMt7islQIguzwx2sKWcLltRCsb8GQPr9PqHcnktIjDorSQ09/dJrw0gu7T
 H+5YJWyPEwGu6H5b3h3dLFeJQSVv9PkIjWnH/m65N1CMRCguhtwAaczJ1fgpjYr52QAJ
 BAZ64gHuAiZONnWIgmLWA6W498dPkafNYsN/457wuKJlCRCfGAmCF7tMHHec6u9REZn1
 9NM+hoZSbOZQnO1OuQ0/jsZUBvtSpkfLbBs0eOxOjdNVTyrDiWK4A4rhJG4RvxE4Amho
 3jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469143; x=1783073943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XMJTWCQgasnt3uwwNSi7XCS5So8lwAHMFw+1U5QkCu4=;
 b=VqCSKO5PryIQpyF9TPTzBKi2jdMdI7jU11hXBzt8JF7Rjjrk0S3pawfIL4DfcTtJZT
 SqWl965sd/TVybQhZMt8DhfuRYv/B/Op1F8o1dAFP8zONJnUcxeh4m6yo/tvGR89jQA8
 QC+cKT9A7rCgKieWnPp/eCflisHx7iaKYNrvneBLI95xsxX6RB7+fbwNgo9gGU/8YmcI
 VAzNIRkE8VnDLXmFrbhpURM78ztGR07l29YfsKxWS4trvKrzwUp/zjr3sZ6ZPTloV0o5
 GP2q5BeUOAR6t7mo0lsGkk9nt8CqbQsngQ4xAnWK68STdwruQu9iPoOeqOY10ttzUziK
 GXng==
X-Gm-Message-State: AOJu0YxXoAFn451E8l8I2mbMbEvFE0c15O/ORxxecSDdrOt8ZPVI/fEw
 ftJT7q982QSscOFRe6YlT4huV1JQNsrKX9tKl0UPjamxp1mK777osQHTlDbez2yVhbEdka4tyWG
 HIPUcQRU0+9VKM8LEhadrhItHl+/o+6j2XnhrYofHQbf0trNuyyB7MLg5WJQg6AdZWfFg2Ob51d
 2QwBCApQD+35Rh7pSORuoRlldv4G9WQXA4LoudI06n
X-Gm-Gg: AfdE7ckzXSEUKLDxRRU309T2B2IeQWC4UHmXOPwFlcY5cb+WfJzlhLuYnDt9EVlGx3x
 vaeoDU3O6xQraW3RBFQiF+/K66wV7riWZ5wdwKiLQTh3Q6wwWGKH96vj+rdEzFAq29KJxlmk5xi
 PN/shytNL98X1onW6XysVn8r+dLF/5sCws1mywqKTBAnN8lQB2JmaoVfxzl2lT5oG2ZXbhOssL5
 dxwwfQb0QAUamFvRRGoihRflAjvrHmkjEiRj8VNXVDihzTm9Cj3ZGCOHKUwwv1aWUujh5k/rW3I
 PihWKNSIHTjL+SylqzYGcTy5M9FSJLBNtL5PDF2geybmo9g2CexIj3Gknca6Fhqfs1yTM/51ss3
 7OAXYQPP0IKz9qIp4Sjiq6xyjw0KrYIXwHBd0rmIyeN6y10wWc2c/X0/3TdW4E6O1oh6EVxOYL/
 JHApkdhxllSbiMmRUC
X-Received: by 2002:a05:600c:620d:b0:492:30f2:963a with SMTP id
 5b1f17b1804b1-492667e849fmr90059845e9.0.1782469143715; 
 Fri, 26 Jun 2026 03:19:03 -0700 (PDT)
X-Received: by 2002:a05:600c:620d:b0:492:30f2:963a with SMTP id
 5b1f17b1804b1-492667e849fmr90059305e9.0.1782469143249; 
 Fri, 26 Jun 2026 03:19:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fde98csm72616895e9.6.2026.06.26.03.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 26/45] target/i386/mshv: move msr code to arch
Date: Fri, 26 Jun 2026 12:17:29 +0200
Message-ID: <20260626101748.1728079-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

The MSR code is x86 specific, hence it's better suited in the arch
tree.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-18-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 {accel => target/i386}/mshv/msr.c | 0
 accel/mshv/meson.build            | 1 -
 target/i386/mshv/meson.build      | 1 +
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {accel => target/i386}/mshv/msr.c (100%)

diff --git a/accel/mshv/msr.c b/target/i386/mshv/msr.c
similarity index 100%
rename from accel/mshv/msr.c
rename to target/i386/mshv/msr.c
diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index c1b1787c5e6..e433187cde0 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -1,6 +1,5 @@
 system_ss.add(when: 'CONFIG_MSHV', if_true: files(
   'irq.c',
   'mem.c',
-  'msr.c',
   'mshv-all.c'
 ))
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 49f28d4a5b9..6091c218874 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -2,6 +2,7 @@ i386_mshv_ss = ss.source_set()
 
 i386_mshv_ss.add(files(
   'mshv-cpu.c',
+  'msr.c',
 ))
 
 i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
-- 
2.54.0


