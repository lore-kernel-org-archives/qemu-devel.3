Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BAFC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwM-0005QU-0b; Sun, 05 Jul 2026 10:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwK-0005Nq-SK
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwJ-0001P5-Co
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Balp7D8MFSKnXNPxZzDjhjGfDYz0bsOOyDe5UyFYcAo=;
 b=QXuGOwEX1F+0hMWZKbeNs5uG+MLcJAzlyv5Z88gSxlWirFt7oCVQMpV6Z+/Ytm6pXGAq0W
 c2/MFqpailb69qzv/Uix8hAWSEzzKZFe8VS5P9LUW2ts4e7h1HN2w1K3idGU1h/87LiAeF
 oS4Rqaew++8tk0VFCPQ8D+lKWZ9Zo6I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-pBpH1-O9M_aL5cru0-RIJA-1; Sun, 05 Jul 2026 10:35:21 -0400
X-MC-Unique: pBpH1-O9M_aL5cru0-RIJA-1
X-Mimecast-MFC-AGG-ID: pBpH1-O9M_aL5cru0-RIJA_1783262120
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4926fa2cb17so20277185e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262120; x=1783866920; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Balp7D8MFSKnXNPxZzDjhjGfDYz0bsOOyDe5UyFYcAo=;
 b=TinnaqIw74mW/8Hx0MJlzCkflrAyS9PFW9mj8Qbcgkri042I+8McuUaFlaOP3pSUv9
 XhFNLU92EqZNliliGDeVjbEAUZYD8lo7U5rkcoO0f9ll6z1E5IUjbJEm/oBgN+vTchLM
 fdUj+6XP5xwzh3unlLeypM//vS+Zensk99z4jhkJG51fKIfS88SUCtsXcQZuJISiSKm3
 rRib+a+4ZY2bs0E6jhhceIpMiQgKyFTjijjGXT6L5PjUlHBe4xU3ZYZFB6oGJuR3dL5f
 m3+JUud3LUmbX48Blq7nUXEh9RYhaV6WAo6eMw/OhXfLI1/fCa525BaqYj7QlasiCf+4
 eL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262120; x=1783866920;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Balp7D8MFSKnXNPxZzDjhjGfDYz0bsOOyDe5UyFYcAo=;
 b=AavlcU9xFizMc7fpqGNwM0+gQW8afHeozBoObyRJZSAP0eFzZzm8c86/pMFmL0X/6r
 hcxXWi3ZwUMz8Awjho8ujAdANngR2n/zBNod2a9tlcgighNiPumfgQ/mEdrpao2JlYRI
 tDsfiw0hI/k20tBV39wFJI867GgKTEDL2anP2YQSi0XBYWP44mMktc7yMVAEIWP2cIkK
 VyCp1hV7sCCSbcKaEH0CfGsCmIO8nqxN04bKhIxcmF/VzbrYbmyn8qtUTqgH00wTJIeJ
 xToXeOQu/y6c74uV0G2CxVNt9qU62mNE7SDC4PPUnNs6QLkdyIAuHn2AGeCFR79nuQVO
 7Hog==
X-Gm-Message-State: AOJu0YxLI4BhEehQrOt40Ni9jewjVxvNqAO0aKxgJKpt8n2UeZ4+ixCb
 h4BVdR/D6OKyNs3Ra1fDwOn8NB2kFV/FWLvQJ7v0C9aIMnARz5dCU4MP75QgsXtiEaFWdQl4JOq
 +RW+wb7XrNJihDvUAWQ/NFlbi/PsOjZBA+MNzMBUWKuWfAHK51sQoAp8GVWqENyeq16MrfEXKyv
 +aNnQYWYY5Sp8kjmwDYr+ymA/mg3c74L7gvg==
X-Gm-Gg: AfdE7cmICR9rS8B1BhLtV8zIip/IqGkkyNyg3lN/RsuRG+bIFkMDmEo8hI5rSxV9w5D
 xYfGzMMMZ5cAiEykjIzDtGCzEs9wVdK2KEskmx7ttvioE/Rx8P4iaoP7DjL513OXMpEk1cXM7ui
 CawM87uB4D2jLitUrqV9ZH3b2BWjmRIbpqnk77gEZ+yWDtFqABkhGRSeJN71Idqc04ON6f+PkEf
 vo0MkpBQv2cFTDJBGViRiejdqYP3tbr36SoR0CF4okn8zuHnrn5Th+94qxp2fxcAqT58c6z/o+u
 Ibs81Qr8qgfwy2KzN03cY+fd8HSXWprWnrYUrnytU1iuAExDhFh7suLvUvfHLmTTuAUWPJl3/tz
 EXrUDUyI08M1gGai8U5kdk9UaN/Yc+BiC
X-Received: by 2002:a05:600c:37c3:b0:493:d3c5:6c32 with SMTP id
 5b1f17b1804b1-493d4b50573mr46822295e9.6.1783262119945; 
 Sun, 05 Jul 2026 07:35:19 -0700 (PDT)
X-Received: by 2002:a05:600c:37c3:b0:493:d3c5:6c32 with SMTP id
 5b1f17b1804b1-493d4b50573mr46821845e9.6.1783262119383; 
 Sun, 05 Jul 2026 07:35:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6381e4fsm347059965e9.8.2026.07.05.07.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:18 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 fanhuang <FangSheng.Huang@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 15/44] tests/qtest: cover sp-mem SOFT_RESERVED e820 entry
Message-ID: <c31b39063fe9af23ba78dd15155f73ef8f51e8ac.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: fanhuang <FangSheng.Huang@amd.com>

Boot one sp-mem device and assert the guest's e820 table gains exactly
one E820_SOFT_RESERVED range whose length matches the device's backend
size.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260623075051.3797975-11-FangSheng.Huang@amd.com>
---
 tests/qtest/e820-test.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tests/qtest/e820-test.c b/tests/qtest/e820-test.c
index 1db0744c08..aafa3c1aa2 100644
--- a/tests/qtest/e820-test.c
+++ b/tests/qtest/e820-test.c
@@ -16,6 +16,7 @@
 #include "libqtest.h"
 #include "libqos/fw_cfg.h"
 #include "qemu/bswap.h"
+#include "qemu/units.h"
 
 /* e820 entry layout and types (cf. hw/i386/e820_memory_layout.h) */
 #define E820_RAM            1
@@ -85,11 +86,44 @@ static void test_e820_basic(void)
     qtest_quit(s);
 }
 
+static void test_e820_sp_mem(void)
+{
+    struct e820_entry table[E820_MAX_ENTRIES];
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    size_t n, i;
+    int soft_reserved = 0;
+    uint64_t soft_reserved_len = 0;
+
+    s = qtest_init("-machine q35 -m 256M,slots=2,maxmem=2G "
+                   "-object memory-backend-ram,id=ram0,size=256M "
+                   "-numa node,nodeid=0,memdev=ram0 "
+                   "-object memory-backend-ram,id=spm0,size=128M "
+                   "-device sp-mem,id=sp0,memdev=spm0,node=0");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    n = get_e820_table(fw_cfg, table);
+    for (i = 0; i < n; i++) {
+        if (le32_to_cpu(table[i].type) == E820_SOFT_RESERVED) {
+            soft_reserved++;
+            soft_reserved_len = le64_to_cpu(table[i].length);
+        }
+    }
+
+    /* exactly one SOFT_RESERVED range, sized to the backend */
+    g_assert_cmpint(soft_reserved, ==, 1);
+    g_assert_cmpint(soft_reserved_len, ==, 128 * MiB);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("e820/basic", test_e820_basic);
+    qtest_add_func("e820/sp-mem", test_e820_sp_mem);
 
     return g_test_run();
 }
-- 
MST


