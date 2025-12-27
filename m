Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77A4E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQup-0002kf-L6; Sat, 27 Dec 2025 04:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQug-0002JT-Au
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuY-0006uH-PQ
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7kUTlFc/KJPLVMSA/F+IBTx3RR6lGmvUqShGXuIbKbE=;
 b=MJ29P42eqY6y6E94et2DoAtLhh5YamRYCIJmgJypeG1w9POhZZZYGwJeouVCorT+rS7Zwj
 LMdYtAFZS84oTE2omVVPPwtg5hQ7+YoZiJjiZHH3ov/nIeWEEZdzV0TxFt3HqDlHky1Vcf
 0V5XSMkfJLX5gXj5g4LCgnbE2H+RyRU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ItGvtA1iPr6XGiyd2aB90A-1; Sat, 27 Dec 2025 04:48:32 -0500
X-MC-Unique: ItGvtA1iPr6XGiyd2aB90A-1
X-Mimecast-MFC-AGG-ID: ItGvtA1iPr6XGiyd2aB90A_1766828911
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso39606675e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828910; x=1767433710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kUTlFc/KJPLVMSA/F+IBTx3RR6lGmvUqShGXuIbKbE=;
 b=rB+k8Y9gZ8ItI4qGHfSNFQhIwhulwhf6fCei/ULRqqC2v7t0LDlkiE+h9otILIczIS
 yQjFInlZwYIBlAbfwXzvHHmcx7ELxWzEN+StxYTFrBcsNjlK2yBlbc6974f0YEx7sR8W
 ugRgQVjfFwB4JR3LzfZvfD2k/f34vIC0ly0RomMj87++RlC/M4YemSzM35p6Z+oSHd8T
 sgiu9u+/AA14oBliHGc0UnCzJ4ON8G6rZss7Oi4CX0BI/NH16dP+C5SgCUTpRhwAhLLi
 T67hk8QZDVkw4BmSUeVpt5rBCqjHtGfvJ5sb9lMF0uUq+eW39HO86xZbschd1tTAPkBU
 sIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828910; x=1767433710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7kUTlFc/KJPLVMSA/F+IBTx3RR6lGmvUqShGXuIbKbE=;
 b=KE5ZJKYQvTZnLTTNIBt/Fy0upHBwJ8mfYHmjJ7IdSZ9P1Xg2KuBAVFos51SM7dPikG
 7b9gAb85uUQXpzaoeeuA3k66ekiwsE3jARSleWh4Ls5ob25L8AyC1Y1m35ljDUhcWFQh
 uMcmyt9EcIpP35UdeWPJjLAYkMBjpOZ8tu/i9P11Ej4GYhqw6uHDKlJ6yodGrcmJG4/P
 FAFWPRczIG74XC0WKm5Lg+eHbAW8tHQpg+RVYYBivXuI3q/CNdm5zNfGugkUr9HVrmYa
 LAH4gT8cUq1E/DDwBCvdjOrx56Cg1mzemQh1PLa/RLOJdxohrblXfwpifNeXnSxiLy3k
 Jyow==
X-Gm-Message-State: AOJu0Yxf+YMcWeWSvzbT+5W6Y5emF4rxSQy/xdal5XG9iJd5QwZ8Ioyk
 A5jDA3lIt7U7LdOEUwU8zGxaITbje18oF/oQIGcMqFqByyjacJiEYlJYyyBV4jVAg4DIX7346rl
 MYsXsKHUZSHKfXqVv+nlBZVZUhtVjnqbwgodzYYnvdo4b8+jAghs3H6nTWycq/I3hTbEqGHonpS
 bo5wpJ4dGZMzdA1z2UY8EWcm2nFmHQeRB12QKYybwk
X-Gm-Gg: AY/fxX449KFjc48ECj3HEpuNA8k/s2qgmD/UQGwj/CFNjHPLB59DqxmCDOwR18nZyZ8
 wq7HJ+rJ7Wmg3G0ZMY8Pp19b+dD483vjkRTFA9m/mx0e3NlcDQVTIFOHwCmvrMPm9Gg1/kxMvFS
 UwfoyO1P+jeXEMq5mZSIv19SrT9tcizAkjhtGEFBZcyavcINqr9pl4cvj2oUeSU1Wpwwk7DRnlV
 niNcALWbBPaxkG16UWvN6k9lwJJvTXO4zh/6IBfTWyDlm78nHi6TZ8ha1xzhfDHe0slLHOZaUPy
 QNbGIPhucF0yUxmNlV0TT4Cz0OZskzBIl0h050F/eBh5fUFsLHbVmky98v3JIz60M7A9J8dye6k
 TB2rckYOBAvQByg4sb0K8dj3taRccH61T3ljMMZdW4Iu0IT7NRQAFsvCDjHTlkXzyxLI4Ug29I1
 GYTKC851r6zueCArk=
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-47d18be89d5mr355281155e9.17.1766828910369; 
 Sat, 27 Dec 2025 01:48:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbP2AxT+3667TzgfRbqvGgsFSYVTqZOkF4PeOGmaf9Tht4pzv7keNxhKWdJCMQ0OHwpwivZg==
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-47d18be89d5mr355280895e9.17.1766828909941; 
 Sat, 27 Dec 2025 01:48:29 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aee5sm51008526f8f.4.2025.12.27.01.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 "Xin Li (Intel)" <xin@zytor.com>
Subject: [PULL 088/153] i386/cpu: Migrate MSR_IA32_PL0_SSP for FRED and
 CET-SHSTK
Date: Sat, 27 Dec 2025 10:46:53 +0100
Message-ID: <20251227094759.35658-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Xin Li (Intel)" <xin@zytor.com>

Both FRED and CET-SHSTK need MSR_IA32_PL0_SSP, so add the vmstate for
this MSR.

When CET-SHSTK is not supported, MSR_IA32_PL0_SSP keeps accessible, but
its value doesn't take effect. Therefore, treat this vmstate as a
subsection rather than a fix for the previous FRED vmstate.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-17-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/machine.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 45b7cea80aa..bf13f7f0f66 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1668,6 +1668,28 @@ static const VMStateDescription vmstate_triple_fault = {
     }
 };
 
+static bool pl0_ssp_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+
+    /*
+     * CPUID_7_1_EAX_FRED and CPUID_7_0_ECX_CET_SHSTK are checked because
+     * if all of these bits are zero and the MSR will not be settable.
+     */
+    return !!(cpu->env.pl0_ssp);
+}
+
+static const VMStateDescription vmstate_pl0_ssp = {
+    .name = "cpu/msr_pl0_ssp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pl0_ssp_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.pl0_ssp, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1817,6 +1839,7 @@ const VMStateDescription vmstate_x86_cpu = {
 #endif
         &vmstate_arch_lbr,
         &vmstate_triple_fault,
+        &vmstate_pl0_ssp,
         NULL
     }
 };
-- 
2.52.0


