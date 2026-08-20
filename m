Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73CEC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zG-0006Dj-Pb; Thu, 20 Aug 2026 12:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zA-0005kU-ME
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5z8-0005fZ-Ka
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHMjxFzNA661zOFOpV7Ud+oCkAP1toVbytmTYNQiqSY=;
 b=B4ZCGFPwThZb1QihjakoMfnbVlhyqdBefuwZGlLQWbpRIw8L/j9DgnIRUPonXfUZXmbbCf
 gBDtvIzK90EfTa7SaypyquplM8bFm16RNTBt3u/pjEu+VqKDC8eEVvq1WT7y9U+YvASBWE
 gLZKkrJegIJ2xWEWbrD70VuCTQ0eeMs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-bh_sAZZtNEWy9FdJWRUDfA-1; Thu, 20 Aug 2026 12:51:20 -0400
X-MC-Unique: bh_sAZZtNEWy9FdJWRUDfA-1
X-Mimecast-MFC-AGG-ID: bh_sAZZtNEWy9FdJWRUDfA_1787244679
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f8398ed9fso103723f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244679; x=1787849479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GHMjxFzNA661zOFOpV7Ud+oCkAP1toVbytmTYNQiqSY=;
 b=QIHbmJLEvuXaELf/Rq5YA2+v/+rEBJXMbIbivVYPhJtfsi7TgE/v4DCfbr4IUgruNL
 OicHZ5Bk1nBY6dYoWcO6g7Ayk4UO9XF7mD5AOXzyvKq5phIL5A8ok/GtZMrID7xJM0pw
 3mTsoZnm9UttHBkblXf+yz+CEIIPMLQ1brMUAtW3P0v8/iAL+fUF84varyvQUq+1a0Qb
 uxeRClN9SXyMTTNdZkC6vaxfos0vu21iWnKcsLCjdFWi+p8VKx9PfmNkLTBrlRG/Snjh
 iGe7DNwpeynI85lRVsL/xDqvtSOtn4N/azDq7cj/nLbsyhfaRW/ADDd2p7Byp+97ODxb
 PnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244679; x=1787849479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GHMjxFzNA661zOFOpV7Ud+oCkAP1toVbytmTYNQiqSY=;
 b=pdLFJ+OnxvyRoSotPMoWHn6PcZJs7O3xo1DhuR83p2NN+bCwkv6rNNKDB1R5Yl0aZ1
 c46N8izN5C81zPdClcfIRy/XEVjQ6OVKJzuy1Hp3FDP2+KmgUZ33+o9hj37EeSG9lU+j
 uuPt/emQoNMh2INzgjY7cgFqm/5DMm9Rr0Svl+THEEegJ1NHkE7q+MydjlnXHygT6aku
 xr/meRMd7Od51Mm0cRfmLq+atE27r4iYsjlQymPneC8ZUDLy1st40PJ4FY3BoWaAy2p6
 plcTYuLo4Vj9Dk8wvqpY8emEUJ+ETbdfbaZTo1BRq85dieOi8J78n/F2Q3z+LSsjqdlK
 XXpw==
X-Gm-Message-State: AFuF++nSwlnC/bQpID3pFdaub9uGlvAR7fHme0OcOV4kLOSjBTg+U3um
 YKlJ3zxPcx00qU/hvM5kfOsCVI2NYY3nutWbsV6yvaywIKFEH6W5+T8ljJuNeE1kshCNh/YyyFB
 7OXl/HLUcZqp8tVRuftkTdl/mXlxA5xNZCiF0SxcfyNcGCFnHJzy0VKMZOcfxivZUz6HBfmjfvG
 6qcGJRVbIXAJuqikXue8X9pncy3grGi7agGI04bDFC
X-Gm-Gg: AR+sD10VC6AAlTDcxjb/9R58vJYpEK4PWv6MnwUhtCS5Z4c3EbrjXnEDkQrgFzaJ1ZL
 utrJvju/dxb2bi93LaJCEC13LYoyKUGUsIKupYlE/c5wbAtU+S5FVysCzNxtLbuukNNc/Iw11w9
 n58O70tIHrhHLJT2YTXfSVbLegmTR0Lna5kUa/FWl/xxUfdEhBpTlfVWXSVkKLau8NmCbpibdiC
 EOVDRFAmFbE5/Zf2PKWxy9OTjyeV8YXoQy0yBStio0IMfGtnOIccHPk8KTqvaX94n9YgvFxRQw/
 enOfwm0QADFKBWzz9pprlSi1Ef57Eyo9kgL/bJ/zRH6nLCOgZh3cuNtMzWIocoeh7tQfjY1LQ+y
 F1jik/nmjwcclbjx2nQHjj3Ga/kmr/G/p8ojMRkw6vxGtFNZ51VaP0nY6UrlG4WQw//4YgGgcjz
 st7/U=
X-Received: by 2002:a05:6000:41f6:b0:47d:eedb:ee62 with SMTP id
 ffacd0b85a97d-482b1fd3b69mr28864596f8f.14.1787244678947; 
 Thu, 20 Aug 2026 09:51:18 -0700 (PDT)
X-Received: by 2002:a05:6000:41f6:b0:47d:eedb:ee62 with SMTP id
 ffacd0b85a97d-482b1fd3b69mr28864484f8f.14.1787244678468; 
 Thu, 20 Aug 2026 09:51:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b145153fsm14254951f8f.12.2026.08.20.09.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>
Subject: [PULL 27/53] target/i386: SEV: Add support for setting TSC frequency
 for Secure TSC
Date: Thu, 20 Aug 2026 18:49:30 +0200
Message-ID: <20260820164957.1895963-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

From: "Naveen N Rao (AMD)" <naveen@kernel.org>

Add support for configuring the TSC frequency when Secure TSC is enabled
in SEV-SNP guests through a new "tsc-frequency" property on SEV-SNP
guest objects, similar to the vCPU-specific property used by regular
guests and TDX. A new property is needed since SEV-SNP guests require
the TSC frequency to be specified during early SNP_LAUNCH_START command
before any vCPUs are created.

The user-provided TSC frequency is set through KVM_SET_TSC_KHZ before
issuing KVM_SEV_SNP_LAUNCH_START.

Attempts to set TSC frequency on both the SEV_SNP object and the cpu
object result in an error from KVM (on the vCPU ioctl), so do not add
separate checks for the same.

Sample command-line:
  -machine q35,confidential-guest-support=sev0 \
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,secure-tsc=on,tsc-frequency=2500000000

Co-developed-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
Signed-off-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
Co-developed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/af688610978f213a456a7753e1d9fe7d3a51e80a.1779281646.git.naveen@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json     |  6 +++++-
 target/i386/sev.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 4732fa89751..4a9b7f90884 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1116,6 +1116,9 @@
 # @secure-tsc: enable Secure TSC
 #     (default: false) (since 11.1)
 #
+# @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
+#     is enabled (default: zero) (since 11.1)
+#
 # Since: 9.1
 ##
 { 'struct': 'SevSnpGuestProperties',
@@ -1128,7 +1131,8 @@
             '*author-key-enabled': 'bool',
             '*host-data': 'str',
             '*vcek-disabled': 'bool',
-            '*secure-tsc': 'bool' } }
+            '*secure-tsc': 'bool',
+            '*tsc-frequency': 'uint32' } }
 
 ##
 # @TdxGuestProperties:
diff --git a/target/i386/sev.c b/target/i386/sev.c
index fdfeb604f6c..ae9c85af131 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -183,6 +183,7 @@ struct SevSnpGuestState {
     char *id_auth_base64;
     uint8_t *id_auth;
     char *host_data;
+    uint32_t tsc_khz;
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
     struct kvm_sev_snp_launch_finish kvm_finish_conf;
@@ -547,6 +548,13 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
                    __func__, sev_features, sev_common->supported_sev_features);
         return -1;
     }
+    if (sev_snp_enabled() && SEV_SNP_GUEST(sev_common)->tsc_khz &&
+        !(sev_features & SVM_SEV_FEAT_SECURE_TSC)) {
+        error_setg(errp,
+                   "%s: TSC frequency can only be set if Secure TSC is enabled",
+                   __func__);
+        return -1;
+    }
     return 0;
 }
 
@@ -1095,6 +1103,19 @@ sev_snp_launch_start(SevCommonState *sev_common)
             return 1;
     }
 
+    if (is_sev_feature_set(sev_common, SVM_SEV_FEAT_SECURE_TSC) &&
+        sev_snp_guest->tsc_khz) {
+        rc = -EINVAL;
+        if (kvm_check_extension(kvm_state, KVM_CAP_VM_TSC_CONTROL)) {
+            rc = kvm_vm_ioctl(kvm_state, KVM_SET_TSC_KHZ, sev_snp_guest->tsc_khz);
+        }
+        if (rc < 0) {
+            error_report("%s: Unable to set Secure TSC frequency to %u kHz ret=%d",
+                         __func__, sev_snp_guest->tsc_khz, rc);
+            return 1;
+        }
+    }
+
     rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_START,
                    start, &fw_error);
     if (rc < 0) {
@@ -3222,6 +3243,28 @@ static void sev_snp_guest_set_secure_tsc(Object *obj, bool value, Error **errp)
     sev_set_feature(SEV_COMMON(obj), SVM_SEV_FEAT_SECURE_TSC, value);
 }
 
+static void
+sev_snp_guest_get_tsc_frequency(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint32_t value = SEV_SNP_GUEST(obj)->tsc_khz * 1000;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void
+sev_snp_guest_set_tsc_frequency(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    SEV_SNP_GUEST(obj)->tsc_khz = value / 1000;
+}
+
 static void
 sev_snp_guest_class_init(ObjectClass *oc, const void *data)
 {
@@ -3260,6 +3303,9 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "secure-tsc",
                                   sev_snp_guest_get_secure_tsc,
                                   sev_snp_guest_set_secure_tsc);
+    object_class_property_add(oc, "tsc-frequency", "uint32",
+                              sev_snp_guest_get_tsc_frequency,
+                              sev_snp_guest_set_tsc_frequency, NULL, NULL);
 }
 
 static void
-- 
2.55.0


