Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3574FE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdjk-0005tV-TB; Fri, 06 Dec 2024 14:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJdji-0005tA-Hx
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:11:34 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJdjg-0001dL-KL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:11:34 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434e669342eso1124325e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733512289; x=1734117089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gf444pBF2yoxmHZ5HvWlXczwGthca5lWQ8M0vpy4MeM=;
 b=ONcgOFpP/e6r+S5dgjLA7ckaieFcT/kgB7LP03nShabWqQJqRiS/tHkBYnRZdzAYL5
 vvq8w3HbgcMORFkJ2Drds2SM3aAEu1UFfb98dg0D1SFvqP4jdFUKIhnSXMcBqwyehLdJ
 /wexcWVqhfrGG/bbYIhhhIQh//vjccfXmhmYeFw0MlDfp2AzX6hzJTO73p0p/B51XlT4
 PcvfY4oGpXNsx0fYvmfIIP9o3/tUSjK07CpKOattycR0v3Ru9Hx0DIp+2VBcNP0QXvVK
 CFoeHwUDB9oRRboS65VEfLYeNYQsOTAf8i9X1S2t5XO9ozKbI54e6EwjznoxIyodL7mB
 CBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512289; x=1734117089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gf444pBF2yoxmHZ5HvWlXczwGthca5lWQ8M0vpy4MeM=;
 b=n7FtP4LvmCZiZkU/uOORnTNoFepKBrE3JinNa7bwwBcfKBBi4wyBVB4Bk7jLSQImPj
 8lNbZlEV6bxBIrRu25aaQqiIK6/lTuY3EPYEnHOWpLTXV6/7IrVKAnPw5wl/XcIo9IVp
 X8Ppvb4si6dZYPAXxVTiGTeG6dakzbQShcijgF4NqzobHSyNsbpwvUIUyWKkN8UmYrm5
 j6ZW3ovczDPaY+xOP3syG9Pjt/uurevZBMdBDKCYnI0HrK3/wVX9mHJNxqcBZ+lQwAyo
 1JxDkUx77MNFAE/yst0GwtI6I5GL5PLlL2KFVIAt3WCzMQaGoeu8KaW6oOaxwcHe+gnp
 eNhQ==
X-Gm-Message-State: AOJu0Yz7aI6JPKWJmDENRXrjyDGB/so+DCAResazBDKy8L6YyxNONi6n
 uT3vz3f26rwAF9DO6ZzpHEPC8wX3NwPGDO9rQlUdKpaOEgAR31oB2K/injAFcjA4BO7NcIepy1Z
 Edjo=
X-Gm-Gg: ASbGnct5GMkRFdKbI0bNojmlR1gWZSTRg9oTP7JnFyhSIAnR4oQmCoXlg+8zLxnOtVh
 DGgAmRokyaOsm49Qzkpk80iABmjHCpRnoR4xw+AJk6zMhzXl+GAuyVGlsjuFS96W1owfSEffQRu
 gCgRJNY20vm7j4q+trcjItwtSDpJbzkRUQA2ZvER1ACNdbqybmSUfp2NAP0LhzszvyMZ3EpKbHv
 yf4ZdBqUe6MiwA2n7M/7LV8/6ldxn0TSVGGJplwJvEho7G49PtzreDue1vak5NSyp4=
X-Google-Smtp-Source: AGHT+IHLGmlLDwaZG+B3gIlmcvq2CYpNgDzE39RiukPQksk9CKRcTf/2kUD6TcIAzs9HT6fRTOTJvw==
X-Received: by 2002:a05:6000:1846:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-3862b39759fmr3211726f8f.35.1733512288807; 
 Fri, 06 Dec 2024 11:11:28 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf4395sm5171746f8f.10.2024.12.06.11.11.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 11:11:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] hw/timer/hpet: Make fw_cfg state private to HPET class
Date: Fri,  6 Dec 2024 20:11:20 +0100
Message-ID: <20241206191124.9195-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

No need to have an external hpet_cfg[] array accessed
outside of hpet.c. Move it in the class state.

Philippe Mathieu-Daudé (4):
  hw/timer/hpet: Introduce hpet_add_fw_cfg_bytes()
  hw/timer/hpet: Reduce hpet_cfg[] scope
  hw/timer/hpet: Have hpet_find() return an Object
  hw/timer/hpet: Hold fw_cfg state within HPET class

 include/hw/timer/hpet.h | 20 +++-------------
 hw/i386/fw_cfg.c        |  5 ++--
 hw/timer/hpet.c         | 52 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 49 insertions(+), 28 deletions(-)

-- 
2.45.2


