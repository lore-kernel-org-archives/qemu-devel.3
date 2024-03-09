Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91254C54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lk-0001HA-Hq; Sat, 09 Mar 2024 14:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2KL-0007NQ-T5
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:54 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2KJ-0003NW-BF
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:49 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso112896a12.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012345; x=1710617145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8wT84tp5Ct3Koz7/1+DQ3KNhe44GTMwlt4WEbo2CyY=;
 b=wTAGvnU7iv8knhIc9QM/CApgXDYdur06A/RIpA3EnwHXT30pnBduKbE8jxFdDLpkm8
 lKPVdEEVsYEY5Ffp4AlujOMQq4YC4QQVT/iuaCOPX0n8s2Ti8SjVReIMFqqifIiYakXn
 LxLwPTh9Rn6zVNmvt/pPFx4LX+iSOnj6XTHgkt60EiI6Jr5g7/4DB4ozzN3m3FWi0eNY
 5lkT1xHtK6mNb3K/1ZOdONNWx0ZKZj2VFrNjISN+UAmNAkMczQ5sIBou6XRYZT/BQFhU
 0PeDplfTF1n2shOSLdJkXfGgPI/MVDEjRkDCvUSB73NyfGw6ERPFJa0De+o32dxfJAM2
 rZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012345; x=1710617145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8wT84tp5Ct3Koz7/1+DQ3KNhe44GTMwlt4WEbo2CyY=;
 b=T9sqak3maeybx/l8eGdgvHUfpD/fOwH7jSNriT7gtd5LCGMShp//ZJiMu+z+F0vBfw
 GoojSQkpvZWtcUeHVpdZVQcsOdu9pQmmpbXFKSrklcMdC1kzhMHAKhf+AsiLZ3YduhNC
 dpcx/zs5Zd4baCjXtHHktPKfHWpvs0LP92wvm4gQh1v6m4/D28h0tKcVHWYzYry2r7rt
 2o5nChgAdk83k3tfW9H5Q+mNGWC0/1Se6WBJLfInKe3Xosmx/AstrHbmTcJ5TOu8v7ar
 b8+VTVCcFcRs2JHPpxZPyORj755VzhMEm1z9j+b5NVA8xj+9H0sUkKZoi++S7U2KPAsQ
 h9Ow==
X-Gm-Message-State: AOJu0YyC6inb2g9IMx8z8I5shx05j7ZId2AeKZ+/d2D92Onf3q1Qkcc8
 KaxMiXYypolXTnzEv8BnWj1CTWfhEOo/suzUJWOvFQ7DEjlrvLmPHEDvXAgACI9t5KGqquN50zd
 o
X-Google-Smtp-Source: AGHT+IHL2283zRWdp80KRzzkeAAhztph/YcLfqqeU3h8wTABynkHPOJPy2Af/Ap9CSy2HfDDt/3JMg==
X-Received: by 2002:a50:ccd6:0:b0:566:d274:a41d with SMTP id
 b22-20020a50ccd6000000b00566d274a41dmr1546436edj.42.1710012345670; 
 Sat, 09 Mar 2024 11:25:45 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a056402359200b005648d0eebdbsm1143695edc.96.2024.03.09.11.25.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:25:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoling Song <xiaoling.song@intel.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 35/43] tests/unit/test-smp-parse: Bump max_cpus to 4096
Date: Sat,  9 Mar 2024 20:22:02 +0100
Message-ID: <20240309192213.23420-36-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

The q35 machine is trying to support up to 4096 vCPUs [1], so it's
necessary to bump max_cpus in test-smp-parse to 4096 to cover the
topological needs of future machines.

[1]: https://lore.kernel.org/qemu-devel/20240228143351.3967-1-anisinha@redhat.com/

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240308160148.3130837-7-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-smp-parse.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 84e3422774..2eb9533bc5 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -20,8 +20,8 @@
 #define T true
 #define F false
 
-#define MIN_CPUS 1   /* set the min CPUs supported by the machine as 1 */
-#define MAX_CPUS 512 /* set the max CPUs supported by the machine as 512 */
+#define MIN_CPUS 1    /* set the min CPUs supported by the machine as 1 */
+#define MAX_CPUS 4096 /* set the max CPUs supported by the machine as 4096 */
 
 #define SMP_MACHINE_NAME "TEST-SMP"
 
@@ -333,13 +333,13 @@ static const struct SMPTestData data_generic_invalid[] = {
                         "by machine '" SMP_MACHINE_NAME "' is 2",
     }, {
         /*
-         * config: -smp 512
+         * config: -smp 4096
          * The test machine should tweak the supported max CPUs to
-         * 511 (MAX_CPUS - 1) for testing.
+         * 4095 (MAX_CPUS - 1) for testing.
          */
-        .config = SMP_CONFIG_GENERIC(T, MAX_CPUS, F, 0, F, 0, F, 0, F, 0),
-        .expect_error = "Invalid SMP CPUs 512. The max CPUs supported "
-                        "by machine '" SMP_MACHINE_NAME "' is 511",
+        .config = SMP_CONFIG_GENERIC(T, 4096, F, 0, F, 0, F, 0, F, 0),
+        .expect_error = "Invalid SMP CPUs 4096. The max CPUs supported "
+                        "by machine '" SMP_MACHINE_NAME "' is 4095",
     },
 };
 
-- 
2.41.0


