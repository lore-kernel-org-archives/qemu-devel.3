Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FE1F4644A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PS-0001ts-4O; Mon, 16 Mar 2026 06:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PQ-0001mo-Ht
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PO-0003gq-OL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48532925a4bso22532225e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657769; x=1774262569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6aV4AyLVehW0PthetTdb9Q6TzUbWpqWLCzbdXYshMzc=;
 b=IQ0BJ/ua+y7qIWkk27GT/qZY0Q9lgJbxTaKHwK0ABAM1uMjdZ17pnI4+Ulkp4No9ey
 Qml0GQ91QSneJQ/HfGhKUbYQB6953MpGlLrDeokJ05OUnxEgknyrOsqGxh6kxd94xhqy
 eAkV2VE6BHVRKuT08ae1qWJdplByBC+uW7P821nJJAeRp3npw0N2r3e1lqE2DIHugfhA
 JuaOZvMpJdnzKgM6xmmIIDXMlkpoaHW+O+UIy+WDIs0IeVp08eKkdA69owLcEH9a+CkN
 HvfrnosHZSY3EuIH4oeAjZ75DnX4KSUhHpsuF8Gy0RyH2D2ijfwdnx2y77EEEg7OqXxp
 4aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657769; x=1774262569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6aV4AyLVehW0PthetTdb9Q6TzUbWpqWLCzbdXYshMzc=;
 b=cboqdckvcbFzvjMaJp0RuV1YF7ZIDxVAxpGNI+bRI7R6HkX0eNjCYF2bSkw0Lw8ssu
 1mOvXJGzyCbAMcN3mNGRfJFYaszXQ/bW2WRxaCX37AAAlofoTjaZ62J6bdOFM6+sSrN+
 9p9uGO194FUF07DvddbQjRb7Z0a6cJLx3ZJr/VV3PpK6Ck851uHWanrp5T5nKE7IN6+T
 2H7MBoq4f0SLpvvzi7/+FY3y5zWTrDufG/gGIa0D8qmHIlS4RL1BtJngojXAvER9b/3C
 P97ZpRuek0JuOeVePWtUjVPPrv2e2OuUV7lvkCPRA3WqYFtAGo9N18SKPxzQka9paRvY
 NQfg==
X-Gm-Message-State: AOJu0Yy287lAgZTe6n2f7bQ8MRS3/1S/EyipJS5dHdibOI00eYcELo6J
 rhehVmFLjscz4QwnbCsS+tMUWPH4YQgtIkORvZsR64cnMvAgFqjXF3nm4NmArCbfZf7M9UTlcCu
 B6iY9
X-Gm-Gg: ATEYQzxyLDcyKne5CHfOE9OmYAie7pzoSaDhFzM9hY78ylhNIvlvFDTT78movI3DPa1
 eUT9mvUhjvWURJIytWyD0ny35OEMplLggEFPS2QxVXbvERJ1D1DloU5sKc/WPXJnSFOhkBqe8A4
 FPOxcMyog9syMtgToi219cmXKckGttudkywTIUMxcyDD81bNPvkt0StWaHTWIwYgR5eQyaOUbXE
 a+agD2fo7OY9A4FWurzlvhO/VBISnasFNYO8KdCyrpM0tS0eWXrp5N/C3Bft6hp/Grj/MIAyh8+
 SSbWCr+E2Iuv3s/+UbXtkoP3gf0+FqZO49zEa5ssPXD8ob9x4JlM0shRMsSInunURlNESxb4Gwc
 BDioQH204ZeP3V6vajfEosh3eXGEWU2LzViFGlzSr+OAJNuuju0+PKj1kwh5/X2WuFL7IGjjX8u
 k/NyfyRbZhby4et8zaYBxSDjXSmdfuLWPWNmpLikqSnnS6IqwXFEYwxbOtyxh38CpAabzotFYyn
 cae+sb4e1g=
X-Received: by 2002:a05:600c:1388:b0:483:badb:618f with SMTP id
 5b1f17b1804b1-485567050dcmr204222605e9.25.1773657769143; 
 Mon, 16 Mar 2026 03:42:49 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/17] tests/qtest/arm-cpu-features: Use g_strdup_printf()
 instead of char arrays
Date: Mon, 16 Mar 2026 10:42:28 +0000
Message-ID: <20260316104230.836962-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Older versions of gcc with -Wformat-overflow=2 don't like the usage of
fixed size char arrays in this test; gcc 7.5.0 (SUSE Linux) says:

../tests/qtest/arm-cpu-features.c: In function ‘test_query_cpu_model_expansion_kvm’:
../tests/qtest/arm-cpu-features.c:578:35: error: ‘%u’ directive writing
between 1 and 10 bytes into a region of size 5
[-Werror=format-overflow=]

These can't actually happen because of the limited size of the values
being substituted in.  However rather than require readers to check
whether the arrays really have been declared large enough, we prefer
to use g_strdup_printf() for this kind of string work.

Reported-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260310151507.2973843-3-peter.maydell@linaro.org
---
 tests/qtest/arm-cpu-features.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index eb8ddebffb..5444e4d40b 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -519,7 +519,6 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         bool kvm_supports_pmu;
         bool kvm_supports_steal_time;
         bool kvm_supports_sve;
-        char max_name[8], name[8];
         uint32_t max_vq, vq;
         uint64_t vls;
         QDict *resp;
@@ -573,9 +572,12 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         }
 
         if (kvm_supports_sve) {
+            g_autofree const char *max_name = NULL;
+            g_autofree const char *name = NULL;
+
             g_assert(vls != 0);
             max_vq = 64 - __builtin_clzll(vls);
-            sprintf(max_name, "sve%u", max_vq * 128);
+            max_name = g_strdup_printf("sve%u", max_vq * 128);
 
             /* Enabling a supported length is of course fine. */
             assert_sve_vls(qts, "host", vls, "{ %s: true }", max_name);
@@ -583,6 +585,9 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
             /* Get the next supported length smaller than max-vq. */
             vq = 64 - __builtin_clzll(vls & ~BIT_ULL(max_vq - 1));
             if (vq) {
+                g_autofree const char *name2 =
+                    g_strdup_printf("sve%u", vq * 128);
+
                 /*
                  * We have at least one length smaller than max-vq,
                  * so we can disable max-vq.
@@ -595,11 +600,10 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
                  * unless all larger, supported vector lengths are also
                  * disabled.
                  */
-                sprintf(name, "sve%u", vq * 128);
-                error = g_strdup_printf("cannot disable %s", name);
+                error = g_strdup_printf("cannot disable %s", name2);
                 assert_error(qts, "host", error,
                              "{ %s: true, %s: false }",
-                             max_name, name);
+                             max_name, name2);
                 g_free(error);
             }
 
@@ -608,7 +612,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
              * we need at least one vector length enabled.
              */
             vq = __builtin_ffsll(vls);
-            sprintf(name, "sve%u", vq * 128);
+            name = g_strdup_printf(name, "sve%u", vq * 128);
             error = g_strdup_printf("cannot disable %s", name);
             assert_error(qts, "host", error, "{ %s: false }", name);
             g_free(error);
@@ -620,9 +624,11 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
                 }
             }
             if (vq <= SVE_MAX_VQ) {
-                sprintf(name, "sve%u", vq * 128);
-                error = g_strdup_printf("cannot enable %s", name);
-                assert_error(qts, "host", error, "{ %s: true }", name);
+                g_autofree const char *name2 =
+                    g_strdup_printf("sve%u", vq * 128);
+
+                error = g_strdup_printf("cannot enable %s", name2);
+                assert_error(qts, "host", error, "{ %s: true }", name2);
                 g_free(error);
             }
         } else {
-- 
2.43.0


