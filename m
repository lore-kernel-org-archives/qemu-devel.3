Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A55C27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGyen-0006PU-CR; Tue, 11 Jun 2024 06:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyem-0006P1-2j
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:23:12 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyek-0000XL-6c
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:23:11 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-35f188e09a8so2271354f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718101388; x=1718706188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xpe02UaoiDO4a/WcwgPB6nbXqy4TUqut8B50lRTSb+o=;
 b=vuw4/2NIHWia3DF/C/YKOGfiFjb+J/IP9VGlxqQGaDlJn+khpz/nvJMPF35n9EpADF
 Fd9YpyFKA3nF0K6LdBlOta4MJx7z+h7uxQ1CJhBBNqaco/GS8RJixZh6j58A/XRMvLrP
 83QQ8Ubk6WdtTeTlrAN3FSZWo1AEJ4GUsiqsaavOp/3moyt7MEl12S5KyNjcpLbd0w62
 lSgC2a0Zzd5+7DPajIHzeV0Fz5OaxgdkY8sI3okzjO90IGyL9KrV7FF/cvxrKVqt0FIi
 DRdfYdETcEPsrERZPLfut0P//CdzKLZZMfsbcXmRQud0ntJUlRhg4Lr+CHqyPrXmp1pK
 nNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718101388; x=1718706188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xpe02UaoiDO4a/WcwgPB6nbXqy4TUqut8B50lRTSb+o=;
 b=XnxTwX+jVBEHeQ0LRiZYDbzKR1DDjNePuyKBGkVeGbMPGI5sKHz8CTm0BZM67kK3+k
 Nie2d9utKtruY2NxjwbVVBq2yeE6BvHQykzYtVEuL7vE8eWgZCaOPPxvz6gFdT2UTy++
 GtLLMRsGOKlydawcRZP/kmxIy+OQ38X+2VII8+qBeXR61oInmAzKeQDVi79y5rv5+Eho
 0zDilcZ5Mp5S9p3HAZ14CfdBm8pLcTBen+mmhztSwGO5oM6otz0v3VcWDA7wH3YHX4Sc
 cXdfNWOvu4WHb8vy2WOZe50OPWt6xaDQK+P8o4YuD9h29GDeAEVtcSR2YE/yPyE9P1uf
 P5AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsfUw8lLKqlCzqS43U3s/ILq0RBc9w53lEpiYQoh+fgiBuL7gNqlFE7Fo9dJAW7h70+JxqbfBHm/bs2ZhrlOQwhu7AURw=
X-Gm-Message-State: AOJu0YzZh6EoctqUa1hgI7YGH5trP22RNY8CXEMJlwXEjf73rx4Iu5j5
 J4qr1z9IXK0YDX2ekplaAzIgoiO/xPE2QKCVngSXqci4pXBWpUT4j4tWMrb3kSc=
X-Google-Smtp-Source: AGHT+IH/PEaRVR6Ps9EzO6gqKexgWcBhwhpahK2JXwBomwAPKu1mexEPvxG9KosIZqA5QycylvUfuQ==
X-Received: by 2002:a5d:6d01:0:b0:35f:18e6:845f with SMTP id
 ffacd0b85a97d-35f18e68979mr5687383f8f.40.1718101388519; 
 Tue, 11 Jun 2024 03:23:08 -0700 (PDT)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2598ac1esm4513148f8f.93.2024.06.11.03.23.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jun 2024 03:23:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] hw/usb: Introduce x-query-usbhost QMP command
Date: Tue, 11 Jun 2024 12:23:02 +0200
Message-ID: <20240611102305.60735-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Since v1:
- Consider modules (Daniel)
- Remove monitor_register_hmp

Philippe Mathieu-Daudé (3):
  hw/usb: Remove unused 'host.h' header
  hw/usb: Introduce x-query-usbhost QMP command
  monitor: Remove monitor_register_hmp()

 qapi/machine.json           | 18 +++++++++++++++
 hw/usb/host-libusb.h        | 16 ++++++++++++++
 hw/usb/host.h               | 44 -------------------------------------
 include/hw/usb.h            |  3 ---
 include/monitor/monitor.h   |  2 --
 hw/usb/bus-stub.c           |  7 +++++-
 hw/usb/host-libusb-common.c | 31 ++++++++++++++++++++++++++
 hw/usb/host-libusb.c        | 43 ++++++++++++++++++++++++------------
 monitor/hmp-target.c        | 16 --------------
 tests/qtest/qmp-cmd-test.c  |  3 +++
 hmp-commands-info.hx        |  2 ++
 hw/usb/meson.build          |  1 +
 12 files changed, 106 insertions(+), 80 deletions(-)
 create mode 100644 hw/usb/host-libusb.h
 delete mode 100644 hw/usb/host.h
 create mode 100644 hw/usb/host-libusb-common.c

-- 
2.41.0


