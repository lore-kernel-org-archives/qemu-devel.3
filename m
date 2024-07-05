Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FBEC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 12:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPiJw-0001lP-5k; Fri, 05 Jul 2024 08:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPiJj-0001go-8C
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:45:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPiJh-0006MQ-Qe
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:45:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso1163095e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 05:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720183531; x=1720788331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pfMDrGQNjJl/SzSSLkHWGPthpMt8sX9VrBjXHa0Dvf4=;
 b=K5lFwzvbcs/D7lDhWT856BRz8bp/yjnu7lXd0hL7xNEbYDx5hsKl1PRMg2hZq67aSk
 OPhOWHbgjkaqQRPJfTK58+U6VkGd3JgwrdCVnXn89du1CRKG0wkhdHdh1Oods0uuMGms
 3hQ1t/keY6R5J/CC4300c9pJ+9bf422AEir4Od/c1cxq8N2QFrtncsZmGY6BftphYNJR
 OMsDu84nrd/LKj7+4fQ76a8r1UZLslIxzrZAqKdxQysq6SkHOB/Tz67guTui8fjIx64N
 KW2Q4+nXmL+J1fFS2OGrjquzegnfntTOIUjUUAnuatWI3I3o+2BTKgHcDBFdI42tmTNf
 zWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720183531; x=1720788331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pfMDrGQNjJl/SzSSLkHWGPthpMt8sX9VrBjXHa0Dvf4=;
 b=Lguoi281dt5ppEFu1KifUBvysYq34B9knD/5/N4Sa12FzUeFxph/wWINSnzqmcdngK
 YPpCuY1qwvea7Q800cgNeIJTS84ICaP5ap0ukdq16h/5lujlY4Jqf9KJZpEjWuyZKv+r
 MDfta2FdKlpXT1nSus0QRn6/4tpEa7wIewPbCbMPVbz5OE3YEZ53PLha9bBylkobg0Mn
 oQe/rbv0TNhZPTkbxtHg/Z6shsAoLuTw11oV7dKJ4oRLKyJzRFYopCF+4DNPqdbyotPK
 mu/x6d7l7O4PqrrzfYYaWBEsOhP0X3ONzMSsf9Hd9MK0zJezwLkhbZ05RLeMaowWpVgT
 ymjQ==
X-Gm-Message-State: AOJu0YzUg7ubDGlLvYlDwzL8c3y4V9xeJtR47pMxfQNTb4S52i2/9A7m
 uGG63is5YYOruWn7ctnc8PuZzW0ArlVk9uPImhpVbFZo8+eiOZrE/5KOdmpyQst05A9VCQgZE7E
 0
X-Google-Smtp-Source: AGHT+IEOuubZ6kbgxbedpry34lfS2r3CTlpBOVMIGvE4+Z4MO9OW+WisrbMSY1d184rFUCFH8SYKdg==
X-Received: by 2002:a5d:6e5e:0:b0:363:337a:3e0 with SMTP id
 ffacd0b85a97d-3679f6c48ecmr3737172f8f.1.1720183531240; 
 Fri, 05 Jul 2024 05:45:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2fc9besm61047315e9.43.2024.07.05.05.45.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 05:45:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] system: Enable the device aliases for or1k, too
Date: Fri,  5 Jul 2024 14:45:26 +0200
Message-ID: <20240705124528.97471-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Respin of Thomas' v1 sorting the definition first.

Philippe Mathieu-Daudé (1):
  system: Sort QEMU_ARCH_VIRTIO_PCI definition

Thomas Huth (1):
  system: Enable the device aliases for or1k, too

 system/qdev-monitor.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.41.0


