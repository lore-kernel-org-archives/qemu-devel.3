Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A168C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Li-00017Q-Lu; Sat, 09 Mar 2024 14:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2K9-0007H7-Nu
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:43 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2K7-0003Li-BZ
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:37 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56838e00367so1123581a12.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012333; x=1710617133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2x/6JhOMSh1e4AFrzigsCMOr4MSgOhrpELj7cZb/3o=;
 b=o71V9S/tFWCUUoD2gRbRDJumvGbsCbOE4vR3j3PnNWuG7uAa3wBxq5Iir8vUgJ+dRe
 8Oe6M9/K1sxIexy3Io77iYFRO+mX1MWcPCxReK3boy/3hdkCJEF+FNj7ve1AydeTsHyE
 sKGnBC/TdM7VgsG/Yg5O31Jd4SLvEpM9ZhTV017X1J2smOatt2Xws0GWPZ9AdbG0552b
 y6dIK5x3ut+shu+w/W3B7qIzH07Wca45bwkWMam0nTs9+r/3q6X6TxlGEQbOFAsW5Y+D
 NbhjvgjU9mguO/Q0MPe9daryfmemZDruILxgte0WyNzOAtqJZFpsVvAPNQjZsmAG8yAi
 Yg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012333; x=1710617133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i2x/6JhOMSh1e4AFrzigsCMOr4MSgOhrpELj7cZb/3o=;
 b=R4+CBLIgKN8LG7jhLMUKL0UgbjFo3V0aq/5DxHvqbT53XcOh7RfpO2QjZKkPbICGnR
 CLwIqmQ5GXdXlEU6Shi32RLFOmGycQjbDO1Cr5aUQgYEVrOHKN0l07JBjm4r6q6CoqnH
 kPyGgqIOA8erQhIX99BPdu4pdGd41Zn92BxdWYy0NeFD6uPfUB1iMeRcvosatFFOIzhg
 auCPDQXALE3+nHmRvtSpot5XX2ZEZthMnYvEeY9OMUvqQz+XgP4EGjgg2IX85nrfPhna
 fJyx8TGinQrvKpC5oAM/UY64OBD7IMsbhklMg83E1u56F08HI+NVLluJgymK1BOzDGHe
 7Wrw==
X-Gm-Message-State: AOJu0YxusqlcyKRCx36lU3NBHuvGu7AMhiHxWuxKLOOVqWxczbCCjlV7
 XizEBltJ46cFVUNvVytefWqBMIiA5DlPOPGyGV31hqe1F/yRLvTjzyhdgBHv0PxdnYp8CdZWX78
 o
X-Google-Smtp-Source: AGHT+IFEkQNqTbtU2RBTq9eGHLCDEa8wZZyowcE+aPAYBK+1dEOfyC7DrVa1WHIhLTcYNbSSUNw42A==
X-Received: by 2002:a17:907:a0cc:b0:a45:f6fa:8c20 with SMTP id
 hw12-20020a170907a0cc00b00a45f6fa8c20mr1533733ejc.14.1710012333792; 
 Sat, 09 Mar 2024 11:25:33 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a1709067cd000b00a45f63d2959sm1165361ejp.210.2024.03.09.11.25.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:25:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 33/43] tests/unit/test-smp-parse: Drop the unsupported "dies=1"
 case
Date: Sat,  9 Mar 2024 20:22:00 +0100
Message-ID: <20240309192213.23420-34-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Unsupported "parameter=1" SMP configurations is marked as deprecated,
so drop the related test case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240308160148.3130837-5-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-smp-parse.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 24972666a7..1874bea086 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -607,11 +607,6 @@ static void test_generic_valid(const void *opaque)
         unsupported_params_init(mc, &data);
 
         smp_parse_test(ms, &data, true);
-
-        /* Unsupported parameters can be provided with their values as 1 */
-        data.config.has_dies = true;
-        data.config.dies = 1;
-        smp_parse_test(ms, &data, true);
     }
 
     object_unref(obj);
-- 
2.41.0


