Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4E2C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RFQ-00040y-9I; Thu, 03 Apr 2025 16:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RFM-00040V-6U
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:33:09 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RFJ-00044K-3f
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:33:06 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso6984905e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712383; x=1744317183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lv7WRDAe+YGQs2mxscSeBnIuH1FPhg0M1NDpEDTQH9Q=;
 b=kG1+Z9thqJaXNdVDgkeNHywmAxsEN+Ssocu5xDV8l/V8ufcm3fsDPDpE2karm1hRsp
 cI2D0OO/g1QDnFsS/9habPvxRplPqxJgV77VK7Vb/NucSkjn+K3goLbG4sfYXkNG01SY
 18w8LVhBVI06W5OILZ6MaocaOsCy/C9V5rmaD6Zp0pcIWjEHHUayjIIwD/Nw26ZE8snY
 9WwOgBEDgUZa6Xyo4wnPGWtp4hxx9v1W/HvRacrfYjc8l0zdCmASkXwc48ZnoA6DA802
 z3q5cwz95qYa7+UU+DGbO4emPvOVaUHULeCboUzVZ12lNUXEKG6nenUoUZi31CpgKVyx
 PxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712383; x=1744317183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lv7WRDAe+YGQs2mxscSeBnIuH1FPhg0M1NDpEDTQH9Q=;
 b=SXfUJFF9cqRn2AK+eWVCrGmROXQEWEcDQXxEgusClfFnSfj8XeaXbxKpIdPT7yFbxP
 ooUCzejnsOGfJKeA9ctbBhwbo+FrSnFCgXj8OF/vuKFB8gKnw3EnZ2Xz2fnFfr/lTGk/
 8DoxOML2d4cPrC/Ds1WR39VMClIp/JwPD3412SnCQ28HkJHZKbdRECdLk1zOWaSOhZwe
 tsaH6T9DlCVMiFw67Mhgnxt/jXprJCRKqYneqZ9LQoopytrfovWxIHgeniNM8wTZl4SS
 hIa2CGKcAH0ExyHKp+NdYNnKGj5KFpDwEWefUNz/rz1nuJGKneu6/r1ITluMOaq4kvxK
 LYUg==
X-Gm-Message-State: AOJu0Yw9wXy3bTaJN1kRRfPZivPMdl+57PmNlG2Wp9IRW36cJZxYdBLe
 8dm7elBgb+zzgB/PfwvEuUfkEHz+R+02v2rzX6AnhWRjZOmc0xTPSs2F2qeV7GmopWUEMzrAsGZ
 Y
X-Gm-Gg: ASbGncubFWwuHf4Bc/dRrKGkPsfhOgedVRhUjgRctMtgCMZVcsbPmatqQRqO4/mXmBL
 rLAQwOqbVd/74LecJ5bU+0RwdoEdEd/cUz+CO4jkHoGEXVR990N60tAiYZRdQ9tUfuqqjphRJ6z
 6P7kOSpxVD957VGoi5HeVDxTSZByzZWnIQun+oXVrx15DpABhSFD1kJ7XohBbGX4KPGwu7yTLiT
 gsUwQtN8OPV+xbWCYV41NZ6ogkjdKbSrUbF5mXnyrJrKYkuG9NEKnM5y9X+4ZpnzMy1LMReJWC6
 e4SHhLZ1HwqGWJ2s0CQs1Mlc+Qj1j09wig2LH7xLdt6qeHn9mQwTIgOvR4sb4r3l0az/ixItkcR
 Y9ZjkY2ANfAZZ9Vg9fPWbh/Lw
X-Google-Smtp-Source: AGHT+IEpNujC6ObkbA2+VyHek7N5ZyJT2+swRY2rg4uTUw1d+UnZ23wJJtADL3/Lh6xoor4OKixmSg==
X-Received: by 2002:a05:600c:511f:b0:43c:e8ba:e166 with SMTP id
 5b1f17b1804b1-43ecf9c3d51mr2840225e9.22.1743712383043; 
 Thu, 03 Apr 2025 13:33:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1660bcesm30716045e9.10.2025.04.03.13.33.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:33:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.0 v3 4/5] tests/qtest: Skip Aarch64 VMapple machine
Date: Thu,  3 Apr 2025 22:32:40 +0200
Message-ID: <20250403203241.46692-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403203241.46692-1-philmd@linaro.org>
References: <20250403203241.46692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

First, the VMapple machine only works with the ARM 'host' CPU
type, which isn't accepted for QTest:

  $ qemu-system-aarch64 -M vmapple -accel qtest
  qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF

Second, the QTest framework expects machines to be createable
without specifying optional arguments, however the VMapple
machine requires few of them:

  $ qemu-system-aarch64 -M vmapple -accel qtest
  qemu-system-aarch64: No firmware specified

  $ qemu-system-aarch64 -M vmapple -accel qtest -bios /dev/null
  qemu-system-aarch64: No AUX device. Please specify one as pflash drive.

Restrict this machine with QTest so we can at least run check-qtest,
otherwise we get:

  $ make check-qtest-aarch64
  qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF
  Broken pipe
  ../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
  ...
   7/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp     ERROR      24.71s   killed by signal 6 SIGABRT
   2/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test     ERROR      71.23s   killed by signal 6 SIGABRT

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 2750067861e..fad307d125a 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1788,6 +1788,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
         if (!strncmp("xenfv", machines[i].name, 5) ||
             g_str_equal("xenpv", machines[i].name) ||
             g_str_equal("xenpvh", machines[i].name) ||
+            g_str_equal("vmapple", machines[i].name) ||
             g_str_equal("nitro-enclave", machines[i].name)) {
             continue;
         }
-- 
2.47.1


