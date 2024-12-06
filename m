Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7B8E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 10:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJVXL-0006Hz-Qz; Fri, 06 Dec 2024 05:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJVXH-0006Ax-9N
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:26:11 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJVXF-0004Re-PW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 05:26:11 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-215348d1977so15196585ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 02:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733480768; x=1734085568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbpnqNrG3cFwIZii6c5MquwA7F8Z7zU8w7rRlBPru8Q=;
 b=afoKekRJH6CkvBylIgDY/ubdr8ZLZ8q8If216Sqyed4iH1RaDQODO438NY3KqrO08i
 BleqbTFI6E3N1MpKAd51M/Vr/0hUbRVlkeWP54a3nXifQcQqV1J/NR/4QXJHxwcNUHEP
 P05yWnZSvnzi2WzYmpp6cilpjz91GWoEsnc4XEfPpoBqPuQ/1IVF/eTVj7EIsZp4nWPe
 IuZLwXLHK0yrtw808mpxwLL5LvdPihzEtWM42OVuQkpG9E/Ky0gqL6Hp7CV4q0cpwHZ+
 L2CxvRlmGyT2qS2ar+8IrPVO7jQcH0xTdNvZH7GgVKD7C3lF9J/Vb3EaS32qRUkQAHbR
 SKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733480768; x=1734085568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbpnqNrG3cFwIZii6c5MquwA7F8Z7zU8w7rRlBPru8Q=;
 b=nV44VwmRc+XLcJ8IrAEhHvkHHwGWfuKZxOCSjkolU382PEyI4SnEAx1YCkvg9RoOg+
 rsD+lqWsczxDrzisABjQ7x+g/59ZBTq4oxYgFNhw/2xV+c7pnrTMx2YG0+45M5ruEl51
 kbxn4f8kew1setTjJk0W0iiolmgXtVJ969Gt22Q6SFFtSRHuscxzq7WI7P6+cLplcjXF
 w1EdKcBm8V+bb9Hkvkt2BJPbgMJVau3WYZ7CajQnzO4sSIRIYOfo9v4Ii3cGy+DWmVU8
 H0tay1ZlKUlWCTKppq24Iml1uTWvf7Y6nVhztd0KAaqwXR6WbUFm+wdZ6yp9tVvSSHBy
 4tCw==
X-Gm-Message-State: AOJu0Yz2KouklL6dWy+QUyUqhYRsqKjPQafplLO6z5h2RzylCnh4DhF/
 I2/imt0qR5pFJ59nF1nuqhiw7kj6eCcsPJXHhg2MyiJzBRbux+rU4vn75zurCxY=
X-Gm-Gg: ASbGncuA4TxmE7dYgP2Zb/mq8763KfTjK7iP38BKtRZX6JVJJIhyx/4H75klJfG9f8g
 rNhcrILWeLhsmVBAQ05zUBNMEKnoyni343BMfSdQQigPqoRcozj9w/vCJrW0xpTc8TQ9trZqyWJ
 XqJkx7i0nRqwoLYsrzrY8qOsNHhkKH3YVoDyIGNTU6qmHLbahcaZVtt//Gqbjgo3v1maRno+fId
 DCi2yYpgpglqwoxp9XaNlB9XJwyz9uW1uX7a7K1ZMKotzc=
X-Google-Smtp-Source: AGHT+IEFzBPBAzQVhCv0JdKREivN8znDY8V/NN7F0SmTW+ZrXjCuFu5eUGoI6O3mucXA2ladKaCv+g==
X-Received: by 2002:a17:902:e841:b0:216:1eb9:4a48 with SMTP id
 d9443c01a7336-2161eb94e44mr10657245ad.56.1733480767960; 
 Fri, 06 Dec 2024 02:26:07 -0800 (PST)
Received: from chaos.lan ([50.39.253.148]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e3e452sm25934885ad.43.2024.12.06.02.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 02:26:07 -0800 (PST)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v2 1/3] Expose gdb_write_register function to consumers of
 gdbstub
Date: Fri,  6 Dec 2024 02:26:02 -0800
Message-ID: <20241206102605.961658-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241206102605.961658-1-rowanbhart@gmail.com>
References: <20241206102605.961658-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

---
 gdbstub/gdbstub.c      |  2 +-
 include/exec/gdbstub.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b1def7e71d..7d87a3324c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -536,7 +536,7 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     return 0;
 }
 
-static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index d73f424f56..584ed73fc9 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -118,6 +118,20 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname);
  */
 int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 
+/**
+ * gdb_write_register() - Write a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @buf: The buffer that the register contents will be set to.
+ * @reg: The register's number returned by gdb_find_feature_register().
+ *
+ * The size of @buf must be at least the size of the register being
+ * written.
+ *
+ * Return: The number of written bytes, or 0 if an error occurred (for
+ * example, an unknown register was provided).
+ */
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg);
+
 /**
  * typedef GDBRegDesc - a register description from gdbstub
  */
-- 
2.46.1


