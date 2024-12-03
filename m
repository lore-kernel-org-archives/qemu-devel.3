Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B76D49797
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIP6d-0005XE-7k; Tue, 03 Dec 2024 04:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP6b-0005Wh-VL
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:05 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP6Z-0002eH-So
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:05 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53de579f775so7337200e87.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217721; x=1733822521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XItCJo5+ANEXJJ4rNbIonoA3BAW/mx+bgexv+wsAke8=;
 b=N2xN9whegwIDXlZKttTtXksIKYzczI+I0Jmbv7nVZBIyuGBVcN7Tmi2O6VJLLfQDPh
 zEwYO/9i7jtMznAmW945cLWGk/eYXQUool/0nd3Ym7fkNyUTcaDWU21ZAPitgPzbBhoU
 O5anoe34/euS1/kX6P3978Yzr5GSNSnwqzBYEgeUc1qhTg0+jDu3e2I5UmLY0lWORPb8
 tjSJvn6jThaGJrrGVmjleLfJfO3uzsHCmI6rIndJOTPbUA7NGq0xg5gZ91j/e084ntoF
 1LraiKSjsNzYfDh5EMwmrntHuYz8no3BRRBJ7b/juhHcUlEOWjK0/k3BXXg0Pgj3grHv
 sOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217722; x=1733822522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XItCJo5+ANEXJJ4rNbIonoA3BAW/mx+bgexv+wsAke8=;
 b=f6Sh2JkAk1VdnTVrnsqrNFHd4rYATa+/Khj5sQEjs0ZhgzP6L3k921dgjReWmgO90+
 97XS7/mCZ6i303Q25Ak0PSaf+Z5xftYYr4q6RQL7n5K33yTj0ZzzTlh1UiVdx95v6IlN
 47XsYg2Xu0Gt/8EvPW3AlsOE0QXhrx1jKmlIXnjBqWTJ/9vzEZsjsi4RMlfVOg+ERkQe
 ozyVuZXiRAXj2xWzvfH+lhiMOpdrEOC1YLRKFKF5JjDo9KoedncpL5D6ZEkAexNUWFuV
 wcTCdTV1tFXOwDQ1srE3agOT5/SY8dOD6ec3jrj/BJcUMqkz1+KmtPF45K+VK2MfWbxh
 NxfA==
X-Gm-Message-State: AOJu0YyJm4WOUiSRDlX0Pc8NnxC3sGRyx9RTtmIAH3qzGPqJ8hywJnZT
 QPoOVoN3XGnBPinpBPSyJbds27gJe/WQBW1wq2dYN+6rL5AtEGJ3F0Hubdac7xHz9xN0lm9uAmz
 l09s=
X-Gm-Gg: ASbGncvpI7IrfVtLW0SIgkp+iu1fsxKIGn0SPf0ZgUfYjR0csEok718SL8YQSyCdBsk
 tZlorppWawcuwgKZ3kIIelLKG7wAxACdzBr76+0wKtvXugURZovZooloS90Xv+s50S13IdeZziE
 uFONN6cuSL35OP2fK8tlWCTUlOiM7mNIPii6arJNQnhAQEDSJKAiE5A5Hdk31AYzvpIvnsjqvNU
 /jFTp4MOgNn5AzBEP1fZjxH7HD/VOkNsM0gxXP1tt9268+wAw/WrsIMWWj+UjnlI0lOxElI
X-Google-Smtp-Source: AGHT+IELVm7e97U6LHV1aSNR3lGVC9QDV3n0nCKk5HiuyFOrOWNT99UW+76qnuiTrgbzvwhK7O0Rcg==
X-Received: by 2002:ac2:5967:0:b0:53e:12f2:5e02 with SMTP id
 2adb3069b0e04-53e12f25e19mr1049931e87.42.1733217721439; 
 Tue, 03 Dec 2024 01:22:01 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa599908be5sm591969266b.140.2024.12.03.01.22.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 01:22:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] tests/functional/test_ppc64_hv: Remove legacy '-machine
 foo, accel=bar'
Date: Tue,  3 Dec 2024 10:21:47 +0100
Message-ID: <20241203092153.60590-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203092153.60590-1-philmd@linaro.org>
References: <20241203092153.60590-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since commit 6f6e1698a68 ("vl: configure accelerators from -accel
options") we prefer the '-accel bar' command line option.

Replace '-machine foo,accel=bar' -> '-machine foo -accel bar' in
functional tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_ppc64_hv.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 312248bbfe4..536a433b993 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -138,7 +138,8 @@ def do_test_kvm(self, hpt=False):
         else:
             append = ''
         exec_command(self, 'qemu-system-ppc64 -nographic -smp 2 -m 1g '
-                           '-machine pseries,x-vof=on,accel=kvm '
+                           '-accel kvm '
+                           '-machine pseries,x-vof=on '
                            '-machine cap-cfpc=broken,cap-sbbc=broken,'
                                     'cap-ibs=broken,cap-ccf-assist=off '
                            '-drive file=/dev/nvme0n1,format=raw,readonly=on '
-- 
2.45.2


