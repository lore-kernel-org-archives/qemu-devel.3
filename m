Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90415E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvyb-0001kl-7P; Wed, 04 Dec 2024 15:28:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyR-0000uP-5v
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:27:51 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyO-0001TL-J7
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:27:50 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434a1639637so1987355e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344067; x=1733948867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfTBm75o97Cz8/aU/8hyy/8ZcyfCCBeJMjQXzg2r+cU=;
 b=SqzBevB8p6YpDZUC18/k4mfzMsQOFPVYfWXFynLdgOnQpPBRBO3Y+kKuNnf+SMjXqW
 2mklqPRFcdij8SWFl/3RyuY/IkYy6WGVd68mlNle7EBlomp6jZo+16tV09b4Dbe9euCL
 e0uIBwZe09PgyBsoa0Dq7kg1lTLi3SMdF1//kQXAkOAgNdgL6Kpo4i5hvr429g6FFKxP
 Bx+oSGgHvgNmuSO65lUbAYvGgkJf+HN+Kbov9wOqW3vitHHON4D+Hge0rZ2GSlBdI10p
 xsBiYFpvLQ2S5OYHofqonzDkZDgFN61IST4lsZ0qm6CM+QgU704VGLPuaA5XgO3Cqh/q
 6EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344067; x=1733948867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfTBm75o97Cz8/aU/8hyy/8ZcyfCCBeJMjQXzg2r+cU=;
 b=spyEbi7nY30Ixy0TZA9LN7GWvPIo6t52a+RQMVeFW93dpWKeeKz82Tz2MTX811VhyC
 SaIyRKxRrDNenS4Yj8pXw669/AXdOZs0gsewnzL3Q0QS5sUmvghSCLN/VwnV7BEjmhd8
 1/wvHdb59LbcQQa8zoKfkwfRK5aeMjXoCs/2Htr6CNOGkWZTdA0WdbonsEbj9sUiaAum
 vOZs6MqGUMospH2HilXVX0HWh1N7zLsLlxQBUAEaSvNNxNqnOBpZOy7FTUxgCHNI/xde
 IgCT5BX4tWK7MiVRVE0Ey7lPW/U3ebpfskNYTjpkxpOZ17vQwi0rfzP+/m8yaTt/HIeE
 /RGQ==
X-Gm-Message-State: AOJu0YxEzvIBLBxbw2UGVx4dr0db5tbU2wzWEbWJPD9NTXjMgKE3QGPs
 Yi+e6KY9JVtKPgewrqaiKHAn3OLm47Zafglukn72eDK/b0tchFcZizvfrBnER/byEk8nZlTOcOe
 n
X-Gm-Gg: ASbGncuV4O9Eg+ytLMgJq2jmwYcOyCNU1RJFi2YvlgefipZEuV8Fy9IDG7whtEyR4c4
 zd7KqT2NTv+rYGxaZhBIO0t7WahvDrhLd1QpjI0PPEimUg57zk+j5b5MAC/8zDm7xmSc1Vw1Okv
 oosYcilQva+InfLvKwzGqK3gfdFEfdnYUWV1fA971l/7rtFEEGd34xgFW8cpMqx6eS16e2UMGJU
 si3BwDAxjhdBemy5/U/ZlepMQay3zhzraOncnVh98G6OZ1KrQAFJu8hCd0+wKoNwi2mkbTGSQMG
 7a+Zg5SeIHmG8E2FtEG1nfua
X-Google-Smtp-Source: AGHT+IGpgeJ7vBsWVKm7NeyrMHf5JJDdtts2znjAq5L8tAOSmcAfKNrzgAbgdCPI0p5ekUE7haCsLg==
X-Received: by 2002:a05:600c:4f08:b0:434:a754:661c with SMTP id
 5b1f17b1804b1-434d09acef0mr65607085e9.7.1733344066970; 
 Wed, 04 Dec 2024 12:27:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52aa0b4sm34940765e9.35.2024.12.04.12.27.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:27:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/20] target/xtensa: Implement xtensa_isa_is_big_endian()
Date: Wed,  4 Dec 2024 21:25:54 +0100
Message-ID: <20241204202602.58083-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Xtensa internal fields are opaque, only accessible by
the Xtensa libisa. Implement xtensa_isa_is_big_endian()
to get vCPU endianness. This should be implemented in
libisa, not QEMU, but I couldn't figure out where to
contribute this.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xtensa/xtensa-isa.h | 1 +
 target/xtensa/xtensa-isa.c     | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/xtensa/xtensa-isa.h b/include/hw/xtensa/xtensa-isa.h
index a289531bdc8..1cb8e6ccb66 100644
--- a/include/hw/xtensa/xtensa-isa.h
+++ b/include/hw/xtensa/xtensa-isa.h
@@ -829,6 +829,7 @@ const char *xtensa_funcUnit_name(xtensa_isa isa, xtensa_funcUnit fun);
 
 int xtensa_funcUnit_num_copies(xtensa_isa isa, xtensa_funcUnit fun);
 
+bool xtensa_isa_is_big_endian(xtensa_isa isa);
 
 #ifdef __cplusplus
 }
diff --git a/target/xtensa/xtensa-isa.c b/target/xtensa/xtensa-isa.c
index 630b4f9da1b..36eb4bcf3d4 100644
--- a/target/xtensa/xtensa-isa.c
+++ b/target/xtensa/xtensa-isa.c
@@ -1741,3 +1741,10 @@ int xtensa_funcUnit_num_copies(xtensa_isa isa, xtensa_funcUnit fun)
     CHECK_FUNCUNIT(intisa, fun, XTENSA_UNDEFINED);
     return intisa->funcUnits[fun].num_copies;
 }
+
+bool xtensa_isa_is_big_endian(xtensa_isa isa)
+{
+    xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
+
+    return intisa->is_big_endian;
+}
-- 
2.45.2


