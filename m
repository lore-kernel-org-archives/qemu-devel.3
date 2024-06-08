Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48014C27C65
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYL-00033p-WE; Sat, 08 Jun 2024 04:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYH-0002zl-84
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYF-0000J1-R1
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q3cCgFbm3xHQMQ7si/zOG7zOC+yimRG7HkT0s17JMR8=;
 b=A5TfwIfGJxbPi5d/qkpFqlj2P9r7BUrG8CuqGogRUCHvb/RemZVRo9fmnaV1aENmWM4mQ3
 ZH1x/XvVvjFWThDzbNNrZ485PJ9m7A5vCSFfFpGk0sm9jN990YC36d7XMAq5FXErsryCo1
 dwjgKAL1+6sU2SiuWsourFw2ddIfsMY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-nR3Bz54hO4CFnxzS-XFPuw-1; Sat, 08 Jun 2024 04:35:49 -0400
X-MC-Unique: nR3Bz54hO4CFnxzS-XFPuw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6ef8d9d3efso16336066b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835747; x=1718440547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3cCgFbm3xHQMQ7si/zOG7zOC+yimRG7HkT0s17JMR8=;
 b=bCbpqATgp5WaqAL0jbLQHq7k4+D6IENzyafyCqejxECFif0RmcIniF08QK+Ie1rNRg
 MtlLaXHQi1e5xITviXBcDDstjtH+mngh5CjgL5lvjH1WfaBzvCRgd4qyjUbQWLtA2KkI
 Cpiy2NIRUImg4XIDcM00ajvwm6XfMuyebmjh0JgALQopB+SavE0WCrw9bSWkaDpeCs3M
 EiIlcTs/Nb+jq7WtxuurUgehlqORRTTXPgYL3DTZ2St4w0B+WUWYhAQnSht3utXGaLYQ
 7OsVF+dAdTsq5WJ5iR5dEdz7GV0JbIRsn8fCmzuFIAqezi8LeP2nNPOt4y/yTDuCaAFl
 KcCw==
X-Gm-Message-State: AOJu0YztmFrh8sA612/Ah3jZjjnaetIVHfb2y7p7/SaPeT6oLsHJOsu0
 e3n68WhXgVbrgCOQmfoR9SjVbfOJnnk2GFWJL60PaB8U/6sDXuTVnbtkQm0FgbOjg4Ky6N0cVV7
 0hiV43jXWB+7eMOdSFS88Qq5XlyCxOvOsGOk/PpEttQALF3ktRqPZeJbY54Plivhr6unNieuNbA
 r2E9uTMIuouH3l76a1VUjc2fGQMSy6kPExj/d/
X-Received: by 2002:a17:906:1759:b0:a68:875e:e36f with SMTP id
 a640c23a62f3a-a6cd5613731mr302743666b.16.1717835747727; 
 Sat, 08 Jun 2024 01:35:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi4HX9CW9lgEN3VRMNy5oAO+gayjXYVj+DkwLdswdxvVACxw5udN+eIj3SSWHD4u0E935aZQ==
X-Received: by 2002:a17:906:1759:b0:a68:875e:e36f with SMTP id
 a640c23a62f3a-a6cd5613731mr302742166b.16.1717835747314; 
 Sat, 08 Jun 2024 01:35:47 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0f71a312sm3455066b.8.2024.06.08.01.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xin Li <xin3.li@intel.com>,
	Shan Kang <shan.kang@intel.com>
Subject: [PULL 35/42] target/i386: enumerate VMX nested-exception support
Date: Sat,  8 Jun 2024 10:34:08 +0200
Message-ID: <20240608083415.2769160-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Xin Li <xin3.li@intel.com>

Allow VMX nested-exception support to be exposed in KVM guests, thus
nested KVM guests can enumerate it.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Message-ID: <20231109072012.8078-6-xin3.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h  | 1 +
 target/i386/cpu.c  | 1 +
 scripts/kvm/vmxcap | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9a582218f43..8ff27e933de 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1071,6 +1071,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define MSR_VMX_BASIC_INS_OUTS                       (1ULL << 54)
 #define MSR_VMX_BASIC_TRUE_CTLS                      (1ULL << 55)
 #define MSR_VMX_BASIC_ANY_ERRCODE                    (1ULL << 56)
+#define MSR_VMX_BASIC_NESTED_EXCEPTION               (1ULL << 58)
 
 #define MSR_VMX_MISC_PREEMPTION_TIMER_SHIFT_MASK     0x1Full
 #define MSR_VMX_MISC_STORE_LMA                       (1ULL << 5)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bfb5a25e596..383230fa479 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1492,6 +1492,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             [54] = "vmx-ins-outs",
             [55] = "vmx-true-ctls",
             [56] = "vmx-any-errcode",
+            [58] = "vmx-nested-exception",
         },
         .msr = {
             .index = MSR_IA32_VMX_BASIC,
diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 44898d73c2e..508be19c758 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -117,6 +117,7 @@ controls = [
             54: 'INS/OUTS instruction information',
             55: 'IA32_VMX_TRUE_*_CTLS support',
             56: 'Skip checks on event error code',
+            58: 'VMX nested exception support',
             },
         msr = MSR_IA32_VMX_BASIC,
         ),
-- 
2.45.1


