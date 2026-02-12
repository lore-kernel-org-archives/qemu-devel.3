Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C958AEE3698
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvI-0005ms-4H; Thu, 12 Feb 2026 09:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXv0-0005OI-K0
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuv-000672-3c
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGOT1h5ESN0Qld+a/yHoOKPmD7wsqNv5O1QINCuR2Ao=;
 b=AEycS5IC0jhGM4enDd7z26IW78K7ew+UiDiujWtvlLxV61xNBlznjv9YYY6Ro/bTWIwOSJ
 ZsAVt0qw5wy/ZnCM4GhO4yVo2wux1gj3mjpHk/H4Ah80LzofwezjfgW+PbS0lpIFMz+751
 VpKFx0u37ABT3Jbbq+o3xMlG52m+Ly4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-_6xVKlXaN8GRzVcnZdoZ5Q-1; Thu, 12 Feb 2026 09:43:36 -0500
X-MC-Unique: _6xVKlXaN8GRzVcnZdoZ5Q-1
X-Mimecast-MFC-AGG-ID: _6xVKlXaN8GRzVcnZdoZ5Q_1770907415
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4831192e66aso70114355e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907414; x=1771512214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGOT1h5ESN0Qld+a/yHoOKPmD7wsqNv5O1QINCuR2Ao=;
 b=O7FZGCv3h3932NIxmf1WDcAUkz8xVHQIBvuz/5htS77Og9750OJDevJwcI6rBhfp1D
 4rMT1y4IkXyfkdTQiDLtAVB1fkMuu81oEyxvJbMrlFOnNOnzMFqv1I2WHHPq/TCE/Qi3
 rBvA99Opqdox8V4WZRhmlEEtHFAbUPBKZm+J5ctdGN+weJpi2i9E/dzoV3PhL1IZdwAf
 61hJ/yCd9q62FmI2VwG1JWpcfmPcZ8KuLpmGRHR3KiCuJKGecJnVWKqEZxPmZGuYNAD5
 ZYQ8SszQP2YB5ftx4P0hAFnVrgCUMO7sj/ydF9Wz9JaruDG/aFJKNxz6nYTCafiHVt0U
 //Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907414; x=1771512214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JGOT1h5ESN0Qld+a/yHoOKPmD7wsqNv5O1QINCuR2Ao=;
 b=pzKr8pPW58XNUP5nwcjemvCTXlRVzN2GH+TKNluRSLq2Xp9W0P2xEz/sybS6yk5gCW
 e1xIGItPH26Y+fbNU0SgepSr4ug9WXtGNgjIvo2ScBc9f7Ksdcn1fXiQnxbrOyBviBMz
 5paPLild4gzv5QFcbAKVIzTJW7rRHtfXDXNNUdqom28ubR1Be+69W1dOtNLUHWvUSsH/
 Zs1GPRwJsRqGavEdMehacmf6lSp+YYJieswsA9AYW45lPM5CsawJnNT88ec/GfH8OD00
 NpmNtFTBBOeIgfLsXI0sKbFpEU/GNwU8S7qXI7QSHLv06/PFOPmaGAeeck0+PR35vicZ
 sUyw==
X-Gm-Message-State: AOJu0YwNPJ2OsDZgscYIS/QTVsOA+gEBrVDRRTev4r/cvy/Tl3RyAhR3
 tOzzUFXho7mAcp1I0CamZQ79j5Gfzf01pKr51FBEhGRMUJ3a+ycLeNXugIxRAG64dyikzmfc9IN
 nBBmFwbUMkeStwcXwUEN1JfiOefb2WvZzZiRFZRL8B/kidTi7t61O628DpClpJpr4sCBC5XT8kn
 FWVPBV4sFeYjpy4gvdepDhFTfffXzVoW/zcc0h5hHB
X-Gm-Gg: AZuq6aKcimJyOlGwgx5MmvX9CThN6IdTObwv2DNYL43bebnesCpZ6TDOmYeE89W7vhL
 Nt5LrION2SGiSPV7Xsfcjkl4uUPv+YmuruCfZ/LxDLNofY+rBgIcYOw8BKjkbHOn8kVgbDQpHNd
 RaRj9tlnTJGOS/FDhH6Ofc+8hatA+RW9ZjKGIK+kG0eEYsiFWzFZLDNpiVl/ZERzfbhI3X67KyO
 2UiwBXtUJlmDl7u4XKfMr9aSyqQHGINn6NVr/2Kgjh5aCYQ4u4SbI7JneaCwaHdbKc3U/wyqSQS
 A7MA6dD+PKlA7FoN1QPQQia6jBHaTDGCR+CkC5ot5uNt5i5ayVx46Ilmp4iuJeXcSA1ln+XnDSk
 noOfeFIgSJ6AvQ1fkFFzl9e9KmqHu53B2s8mZSHpxCn1+J/zcq4j+vIFldRVCzxWiQduOFYPgfL
 7AQqO6z3/GbLSfpGBuPwOXzI9oXJ8zgSf1F3z2pRmHlrwrUas+quE=
X-Received: by 2002:a05:600c:8411:b0:477:9dc1:b706 with SMTP id
 5b1f17b1804b1-4836570df2fmr36711235e9.19.1770907414414; 
 Thu, 12 Feb 2026 06:43:34 -0800 (PST)
X-Received: by 2002:a05:600c:8411:b0:477:9dc1:b706 with SMTP id
 5b1f17b1804b1-4836570df2fmr36710765e9.19.1770907413870; 
 Thu, 12 Feb 2026 06:43:33 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d9946dcsm106794215e9.5.2026.02.12.06.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 21/41] hw/i386/pc: Remove deprecated pc-q35-2.7 and
 pc-i440fx-2.7 machines
Date: Thu, 12 Feb 2026 15:42:23 +0100
Message-ID: <20260212144244.22579-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.  Remove the qtest
in test-x86-cpuid-compat.c file.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-21-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c                   |  9 ---------
 hw/i386/pc_q35.c                    | 10 ----------
 tests/qtest/test-x86-cpuid-compat.c | 11 -----------
 3 files changed, 30 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9efb42ad055..f9e0bca9743 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -723,15 +723,6 @@ static void pc_i440fx_machine_2_8_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 8);
 
-static void pc_i440fx_machine_2_7_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_8_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 7);
-
 #ifdef CONFIG_XEN
 static void xenfv_machine_4_2_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6dd1120c004..9158631f761 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -670,13 +670,3 @@ static void pc_q35_machine_2_8_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 8);
-
-static void pc_q35_machine_2_7_options(MachineClass *m)
-{
-    pc_q35_machine_2_8_options(m);
-    m->max_cpus = 255;
-    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
-}
-
-DEFINE_Q35_MACHINE(2, 7);
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 456e2af6657..5e0547e81b7 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -345,17 +345,6 @@ int main(int argc, char **argv)
 
     /* Check compatibility of old machine-types that didn't
      * auto-increase level/xlevel/xlevel2: */
-    if (qtest_has_machine("pc-i440fx-2.7")) {
-        add_cpuid_test("x86/cpuid/auto-level/pc-2.7",
-                       "486", "arat=on,avx512vbmi=on,xsaveopt=on",
-                       "pc-i440fx-2.7", "level", 1);
-        add_cpuid_test("x86/cpuid/auto-xlevel/pc-2.7",
-                       "486", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                       "pc-i440fx-2.7", "xlevel", 0);
-        add_cpuid_test("x86/cpuid/auto-xlevel2/pc-2.7",
-                       "486", "xstore=on", "pc-i440fx-2.7",
-                       "xlevel2", 0);
-    }
     if (qtest_has_machine("pc-i440fx-2.9")) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
                        "Conroe", NULL, "pc-i440fx-2.9",
-- 
2.52.0


