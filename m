Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6975EC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lsJ-0006qp-3W; Mon, 21 Sep 2026 17:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lsA-0006hV-Uo
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:26 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8ls9-0000PZ-51
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:26 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso25999055e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027294; x=1790632094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zV++aD4uHP4QG4HyYObNt6nmUUhVFuY4aARPX6yJf7c=;
 b=ktuXPZqbxt9NjMfjypF9IAPDFm5c+jsaaYxeNdVMlb+Gy9dXGga76ATIwgiVevQiFW
 KroRSDR3YGbQyMIBYGRrau20PgzXBvLwukdS15PeeAvFO+MK71ELD7QUXm8buLw50xGK
 rDCyZRU/tVUWuQuIgrXwWo2K8a2EhUN8SsztTAqsWwDou6eOly+7MpHOy/w9PmxwJ2UL
 k6/JXsRf4nTpqI6jsdtccCypcjgJsquwwcK6nOVXWxKt903tPdZbzHIYftPx9+FTEe70
 n7V6JdP4yHzRkyG/9BuQHQu+vYhgSr3yNLDssJDeyGVoZIvarVccbkYRoiz61Ll8Wu1s
 N9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027294; x=1790632094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zV++aD4uHP4QG4HyYObNt6nmUUhVFuY4aARPX6yJf7c=;
 b=BdhHA+qb+ARjdB1ziJ1hMZlvDOhxChw7ZTiUtWFf3GqhH/LunZ2g7Qvt1pWdpaqzrY
 BEDyeDGM8M3CB3ATYe+BXE068jD/03QHswXwHiNk9Sc0+g3hkoje8QSdNnLOzXfBmysn
 yWgfZcn1EMUpCG9lueLsytkSZJEy/ZNomZyh6iY1P3IY8YHJleq1Gi4ZaauZ6cbr5Kwn
 mw8EvHrRYkotczUxd/DkN0Pny7M/iO/so3S9kYN9e8DrOfvFVRhrzrqXT1vzqYJHewNn
 2NYxQIke3I0ptHPkcbetkJlxOAoXf4IfRzs5wgeCwr/81mc//C3FhV3cj4JcGJL6n4VA
 nkiA==
X-Gm-Message-State: AFuF++l+ZDg/LD4qD6QbKY7b8iWVGj8rXE2Wm3tia5nzYpL4qod6LWwM
 H9H1R6V444lBi77zmicORd7stvHvihLKWgOqG6iQsONORhNOcdEL5LssglL1zA==
X-Gm-Gg: AYBFou1t5WsaU3Is9UgeDuLvMEeclBSYjI18r/3AoZDxvsLXuDh4MEsylTIasw5vB8x
 WBiAg+F5BKOgon5uSwHKwL32CeqkND66t3etN8FX41zdUsbIXpgY8/nhY7S+UyjbZRhA50EptJg
 8/+cDDTYo+4mP18GqyRRcqdXXJoiQTPy5ATkL+LWDG63qyPLxyE+76CKJcBeFI8AvsBy4QbZRYc
 GNKZGhAF2eQK8lApqDupWsGdmO9Lns5ZxnJjYX3jvCNBZLxuF/zmzSORiRY5iVMaf41okGkJhCf
 nqRftY/vtTbGKg9FJHtCM82lLTJK//stCb0hc/TNBqUatk47iIACKWGQrU7ieIdcprh4dVvnk8b
 YTjKQFSY9bC3qXKLIv3Wag+7GojFNsJgtGfWh4nBqZ9XzdQtRBMScLFvYe/GW0CCQxZgosytoZA
 c2BnAcYifpqhoMr2BRfG4vsS5PmKd3j5MO7UwQHFi2rd3nkqFuDe97gbtnPSW0pQylksKq3NOrJ
 AMGe1sTcWztInxLYq1qqUR82iC+kbMinXfA0SFJ2fmmMRhYh+9XA/Ervz66hvFaWSLVhk0YvH3A
 /iE=
X-Received: by 2002:a05:600c:468d:b0:49e:69f8:e846 with SMTP id
 5b1f17b1804b1-49fc56862b6mr179989325e9.9.1790027293712; 
 Mon, 21 Sep 2026 14:48:13 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:48:13 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 35/42] hw/misc/imx6_src: Avoid casting from void *
Date: Mon, 21 Sep 2026 23:47:03 +0200
Message-ID: <20260921214710.29422-36-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/misc/imx6_src.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index 8d2c4175e4..5bc1318f9d 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -89,7 +89,7 @@ static void imx6_src_reset(DeviceState *dev)
 static uint64_t imx6_src_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
-    IMX6SRCState *s = (IMX6SRCState *)opaque;
+    IMX6SRCState *s = opaque;
     uint32_t index = offset >> 2;
 
     if (index < SRC_MAX) {
@@ -150,7 +150,7 @@ static void imx6_defer_clear_reset_bit(int cpuid,
 static void imx6_src_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
 {
-    IMX6SRCState *s = (IMX6SRCState *)opaque;
+    IMX6SRCState *s = opaque;
     uint32_t index = offset >> 2;
     unsigned long change_mask;
     unsigned long current_value = value;
-- 
2.55.0


