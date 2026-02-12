Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BD2EE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvF-0005iy-RD; Thu, 12 Feb 2026 09:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuz-0005O3-Ep
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXul-00064d-6Q
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoD0TtgLmIrq8/npxlFppEMCqVLj+d/XD3HyCB+m280=;
 b=KDwtApLaz3fAliKMrP67OJ02y+NqLuXrjzctT/jlVAuK1Q6JCI8MWPL/+6lOfN+GItboiq
 OqTS7jrX/l1BQJEmlt5DaTerjIFsZgKPZ8lPjFWFJf5sVmNPTRT7NNIVPabwHEmMGIvFFW
 u2g7RgJWt4Vb8lnrn0zdAu8PAt0kLUw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-vSBQQ3B1MLuncL64pNXWrQ-1; Thu, 12 Feb 2026 09:43:27 -0500
X-MC-Unique: vSBQQ3B1MLuncL64pNXWrQ-1
X-Mimecast-MFC-AGG-ID: vSBQQ3B1MLuncL64pNXWrQ_1770907405
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48069a43217so76251555e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907405; x=1771512205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoD0TtgLmIrq8/npxlFppEMCqVLj+d/XD3HyCB+m280=;
 b=F3j45ZpX6Peb4YIA6SPhkjPKKE581bn+994qnbOMiiPKFU3aat0kCjnM0dke1jzaU5
 xpns/GfW1KN1DciyWJpOWv/+5XIDI4xuKjjsI8DUHa+35Niq436BGFRUf2N5ok8I+pVK
 +WVBDbZs5O9cd8p7D3mHR+lwczCFckwOwq/4ovgh0gXYpFSJznwrnd3ok87dazUA8mg9
 okRAb8F5VFjeqm5OvLXaBku4o3Ut2CPmpUY+lok+UuYeJ/JTRpy/i95wG8ceYrJ8bBGA
 C6Tv6G7ZkbJvJcOGf0djRLHr2BMG0mrcx32gDpJPEPSLMAjvMqvv0cTSTpp57YM0h4sR
 Z+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907405; x=1771512205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yoD0TtgLmIrq8/npxlFppEMCqVLj+d/XD3HyCB+m280=;
 b=FVIkpT6huN3IA/+Xgachjh+5nG3Zq7nod9lVF313a+VhyiKvCuK3LFOHspteyafrpH
 ZqGUhj/XIiCyvsME2tCLsmdE+lQ1OrCa1fo5Ytj+OfaTD+YviLaJBUuwqV/af1t8dmRv
 HcdDJbrfoG/vsJySSGMp5pKjQeHKW0xhi/0+hYkKHtBAnklDfP+WlHIZx0aP3uGkP79N
 7jwWJ/6SiGWbIoZIqrj8IEqxorpx25PJgd6zQzVS/scUNeYBh1c3O4RbUsdwayqAJ360
 ZXvvuFxoteZ/qzlklxOhsIoyiGcJuInLvaoq7ZMwwoApBr8n7ZJhAlKtEnO9dEtP4z7P
 BZPQ==
X-Gm-Message-State: AOJu0YylvgRbVp2GIOawu490nRzTAr0fDcgzIXWkfKT1n5qzm6Yc93sY
 O4n3rn/GGIfxazIe0k/hw6kk4nN+8zrVFIOxIKxCLXvW7ohG3trcrvoLDcR3iJi/2N7nKJsQbJ2
 YvtDszUEWGyNfeNA/4UicTEsd89cGbTC5szEJ49U1TcSroZAS9H2t5nBat/UlyhN6L3D0VdUuxU
 a7affXj61pkMqbmVfwG9PlYbjCI0cRMNNZYn3T/gUx
X-Gm-Gg: AZuq6aLi/hUm0qF35V87s4yFAtzgJivALF00W780OIvCBImGIMxRAtqE8CNUzYskbgv
 TBSGkGLND5a11fLd18rHhC23xO+jbqW4SYnHQkVU08qtRWPPY5DsXsOTE+qbmuUJFoR28Zwv0Ah
 mc8uTu37RbpqYyKh9snkVtqirT/rMDcoU6avE/+Pton+u8yjKwlUhZbYh9nCnxN+0+BRXlO1MNW
 QtLPaAeBDp2Gs/apogxT3dt3JvMJY571d5B6Hjttd3RCIm87QALJXbKsc01aoJVezQNjnKvlZJj
 B1QouEGfIUIB0cIKkgx6GJhtE/BwS9SUacte2zV5ZulYf2//FHdWlfjscSjJUbOMjCwJSDwe6MD
 Xsng0UEddlZiDIG9t5OBoYaVRpzmS7DQPn1hSXlwtncIQkC12BkBHth1YSntW2XkSG1s324az/6
 8bojBFjhoFOPDUZpKG50PBe+omg5fP5bEEE0A8kIwb7V0KWg3iKg0=
X-Received: by 2002:a05:600c:524e:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-483656abab4mr44171965e9.3.1770907404629; 
 Thu, 12 Feb 2026 06:43:24 -0800 (PST)
X-Received: by 2002:a05:600c:524e:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-483656abab4mr44171305e9.3.1770907404139; 
 Thu, 12 Feb 2026 06:43:24 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a5c7c4csm158957785e9.0.2026.02.12.06.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 17/41] hw/i386/pc: Remove pc_compat_2_6[] array
Date: Thu, 12 Feb 2026 15:42:19 +0100
Message-ID: <20260212144244.22579-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The pc_compat_2_6[] array was only used by the pc-q35-2.6
and pc-i440fx-2.6 machines, which got removed. Remove it.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-17-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 7f8cf94138a..d6d54852375 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -298,9 +298,6 @@ extern const size_t pc_compat_2_8_len;
 extern GlobalProperty pc_compat_2_7[];
 extern const size_t pc_compat_2_7_len;
 
-extern GlobalProperty pc_compat_2_6[];
-extern const size_t pc_compat_2_6_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c0e6a23bec1..12f139c6798 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -266,14 +266,6 @@ GlobalProperty pc_compat_2_7[] = {
 };
 const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
 
-GlobalProperty pc_compat_2_6[] = {
-    { TYPE_X86_CPU, "cpuid-0xb", "off" },
-    { "vmxnet3", "romfile", "" },
-    { TYPE_X86_CPU, "fill-mtrr-mask", "off" },
-    { "apic-common", "legacy-instance-id", "on", }
-};
-const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.52.0


