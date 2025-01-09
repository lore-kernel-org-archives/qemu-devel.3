Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76FFE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwCj-0002Qa-Lt; Thu, 09 Jan 2025 12:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCi-0002QB-0Z
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:20 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCg-0000f9-BI
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:19 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43635796b48so8101515e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443216; x=1737048016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYVoLWc90TjSnXBWQnMWyZY22lK6Lc4zmHvaduQQgBs=;
 b=mWME27ASY++JmgXplutd9EMHhCPY/i/hwiqP6shlsbl8LbMCS1QrkBn4m7cHbXNszn
 s5x0rTv/ucoHlZqFEcO0bhPdToPcAm2YgcqzhbiFPRIbg3UHqxr+WGmgB1raAQcO9j83
 QNP7zNa2O6ozVtSLpRlUMg2/GaKW6mkaJEnuMzAGP15qaRrq76qYh3tdGPf3MYqhV0HO
 SDH1senFfCPRzL1kZ3SS+J3QLEEv7FihTO58S54/l97R/AQDLzRInaY+1DGhKmV0rVyA
 n09QPe44nu6MM9xzII++DwujwNqZ6SH/AhdDp6IxlgrIbf59I++bJa7+kP5x8jnTs/bT
 P2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443216; x=1737048016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UYVoLWc90TjSnXBWQnMWyZY22lK6Lc4zmHvaduQQgBs=;
 b=TqMWwrNA+tgmEX9VBVWho6ljZUu78zdlXGchU4T0EEad3VyTc2h9bwdJ9ZJ+fjm5Sd
 lj1hSh5FLvznJ4cyjbVwxP3vBsfhyDYsnC736jIVEQqsVI9GW8iuE3pSrwuYUgoGEn3s
 x/fGXAp8qCQ8mjSsy8NtW/PU6SGMfcr+WYqZKgPoFMZRFnwT+W4VKW+6TnMcaqh8lTKR
 mWcmFbhTfLE0lrq7RZLtXfIQ9avpYy4aBGdssZo/jwflKpbfby9xOJm3RWpSDS+BGNlL
 8hb+dQhUacSZp+W+RUrnO79z6fIizhw11qEPNLtM90LcCmf4ulNL2la+ZpSqxjvpxbx7
 ZtqQ==
X-Gm-Message-State: AOJu0YzQe2Q3mTiwem5jVpgPZ+8RxKgdjp4R7HPuIYdxGal+HYwOJ4zm
 AVTll7B5kPmZQa1OuA1yeNG1uveUTYmaW/AkJPzIxm8E4VQRB5QDvzuv8Fj7NQnhU50AZ1LJBSl
 4ueI=
X-Gm-Gg: ASbGncseAMh4Kps/IIZYScI5da5krQC4SGf7byxRjCKu0fMVFacfoSoKhgxUDzgSkni
 MVAlkLjT1badd4NGCGJSkbNk82rAwaXI4yfFvueXVAtDCEt70SeW5QUvrAIHx557/8AGY2kT7jp
 p+JEVgLr4iicbPZcHThNKTaV0qd/OamwTP8Vkrru9NZxL70Cxo/ij0h4yJ715Aa3iOtpkvUdSC4
 g1bALC/Uy95OTCRtTlb+e/S3fT832V7z7CMER04S/W3ZBew8rnF+eTUwPmCLTLFerfPt3cEiHwK
 m7pDL00Cx1OmrkrBE/BQmQWvir5kDFQh1bnr
X-Google-Smtp-Source: AGHT+IGdgqoXPnGF2lcK+LAQfU3ZdfrA1Ka0Kkrj/L+eQjTDCQPl9L/bg5MPbz0F0/mQyfX9hEaJxA==
X-Received: by 2002:a05:600c:1c9b:b0:434:ffb2:f9cf with SMTP id
 5b1f17b1804b1-436e9d80fc4mr29197855e9.14.1736443215826; 
 Thu, 09 Jan 2025 09:20:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89fc3sm62157365e9.30.2025.01.09.09.20.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:20:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/11] qdev: Add machine_get_container()
Date: Thu,  9 Jan 2025 18:19:42 +0100
Message-ID: <20250109171948.31092-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
References: <20250109171948.31092-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Peter Xu <peterx@redhat.com>

Add a helper to fetch machine containers.  Add some sanity check around.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241121192202.4155849-10-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-core.h | 10 ++++++++++
 hw/core/qdev.c         | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 50cbbf81211..89575e74e27 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1033,6 +1033,16 @@ Object *qdev_get_machine(void);
  */
 void qdev_create_fake_machine(void);
 
+/**
+ * machine_get_container:
+ * @name: The name of container to lookup
+ *
+ * Get a container of the machine (QOM path "/machine/NAME").
+ *
+ * Returns: the machine container object.
+ */
+Object *machine_get_container(const char *name);
+
 /**
  * qdev_get_human_name() - Return a human-readable name for a device
  * @dev: The device. Must be a valid and non-NULL pointer.
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 48bc9a7b9c7..9abc4e8322f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -828,6 +828,17 @@ Object *qdev_get_machine(void)
     return dev;
 }
 
+Object *machine_get_container(const char *name)
+{
+    Object *container, *machine;
+
+    machine = qdev_get_machine();
+    container = object_resolve_path_component(machine, name);
+    assert(object_dynamic_cast(container, TYPE_CONTAINER));
+
+    return container;
+}
+
 char *qdev_get_human_name(DeviceState *dev)
 {
     g_assert(dev != NULL);
-- 
2.47.1


