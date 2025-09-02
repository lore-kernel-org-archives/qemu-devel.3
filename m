Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB52CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQoN-0004Qy-98; Tue, 02 Sep 2025 09:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoB-0004G6-OM
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQo7-0004ck-PR
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso4608993f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818734; x=1757423534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vdp9ZUtiSvenNdC+VKbqDN2o6JPuLdKq8aqZrWQK9yo=;
 b=mdpq95TwI/Yd9ohQiBN2vi9RzhPBWyJh5999BOUjIj4K8qp9K8H92miFDnhT734e+I
 HanBal9FMW9RR9l80o9APLHxk+VZO6ffa/SOh7cLigZO3oAwYJ17PXoMqR+vsqlJwZQ+
 za+OiI4Czhv0TINUg/j/hiK84RveNamliRPTCl6fMlofGHBQCGFfxALfv3xcuv1luzlZ
 Itt1pQ0sRxR4Y2wtXffu2gXg1BFN4E/9Tm6OozQDzgKZzDDgvTk7m534Jelw3t45JHyO
 y2QLdU1UjC8vqDEaGgncRmukZrq4cckI2YKKJT34aKksUomumDeQm2MAK+8KnmIegxDk
 CT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818734; x=1757423534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vdp9ZUtiSvenNdC+VKbqDN2o6JPuLdKq8aqZrWQK9yo=;
 b=SUi7cvIQCQvArSZxPmbgpB1D3NERyaWzUr8sr1YEVU90S6P/Lymr59uvBJFxsid+9+
 ecDTIWDmfvNvVh5DahJJAefGgKPjYxS7l8QD+EQ8hTCMRGtlIMz98niHDzQ6blcXzhNA
 urSnsJCQvXG4JpterxYqcMzdWd56qbFet4guZnWHfPSkoghdxtVwQUeezKbokzj9++fS
 gIA2GD1O82CBAzONGt8zK/foEYSaUYWb2mnGuLpGIr5xIlSHhYO2Z27m53bWJj5GTy3e
 ZB7EQ4tw5Ccnbj+8FwGfZTAiKwoKpugX7oU7HuZsbGPrto5X6j37k/NqAbwIOSC3Z/RT
 Zdzg==
X-Gm-Message-State: AOJu0Yyo4C3HNHI74PscdTRseEy3AetUE06cRx4RtIDGcJqiVRmeZ/jS
 h1MPsGBNw5XpD/VwJ8rGD7S/eO+AZg9oT9yX7RqfJAD8evAv2GqzBAEFfYVhzdapdehBxho9Q6Z
 BGpps
X-Gm-Gg: ASbGncvV0DegsOyRO504k4L8V/x23ygHYU0p1nlEQVWBMdjJ4zx93B0oH/lW1xjx7+Y
 XQ8suWR/3RmZyfCRVdKVJoht0jlzvNaeaWDq7VQngAmLiIyGLD6Uy5ecXT3b69uioMR2YecxjbT
 4oQQ30SKSpNq12Xyx+LnSNsOtloP89ZMArYQeKNUxFqYYoqCfjymR9gX2AQr4r6e4sXN/HTB5/9
 yIzzltxutBb4OLdwJPqtaUZ05VUHmSng2dFBAsURsB6XD6ayScXSiq2WLqemot+d80WyIPUFiMw
 XFGpTQ0SfR/LyzPi5qtyCotNsdxuYIZ/Fge2USGWLJgfC3Hh+hFA2aOyDi+5K2XmLNdxmTru7/g
 /dGzu6c4ct1r/RXXszoy/jDEBOTebUtD3f30QYuLtrMM5O//nGczusUfygi+EB/SZPVk8fdlb
X-Google-Smtp-Source: AGHT+IFs/zZaYW+fGiRdmyDj8DgBgIKeczkDW5jzEfgjbwNqCb1i3OJ7lr7UmuyitmrSIKud6PGzcw==
X-Received: by 2002:a05:6000:400d:b0:3d7:94bb:cb9d with SMTP id
 ffacd0b85a97d-3d794bbceb5mr3411133f8f.3.1756818733579; 
 Tue, 02 Sep 2025 06:12:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b945332adsm44075905e9.4.2025.09.02.06.12.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/39] hw/misc/xlnx-versal-cframe-reg: Free FIFO,
 g_tree on deinit
Date: Tue,  2 Sep 2025 15:10:02 +0200
Message-ID: <20250902131016.84968-26-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In the xlnx-versal-cframe-reg device we create a FIFO in
instance_init but don't destroy it on deinit, causing ASAN
to report a leak in the device-introspect-test:

Direct leak of 400 byte(s) in 1 object(s) allocated from:
    #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c53fecd904ba5fc1f521d7da080a0e4103b)
    #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5aded850059d in fifo8_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../util/fifo8.c:27:18
    #3 0x5aded582b9e4 in fifo32_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/fifo32.h:35:5
    #4 0x5aded582b326 in cframe_reg_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/misc/xlnx-versal-cframe-reg.c:693:5

Similarly, we don't clean up the g_tree we create:
Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c5
3fecd904ba5fc1f521d7da080a0e4103b)
    #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x71fbfaccc799 in g_tree_new_full (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x93799) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d7
5)
    #3 0x5aded582b21a in cframe_reg_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/misc/xlnx-versal-cframe-reg.c:691:18

Add an instance_finalize method to clean up what we
allocated in instance_init.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-ID: <20250826174956.3010274-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/xlnx-versal-cframe-reg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index 1ce083e2409..95e167b9213 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -693,6 +693,14 @@ static void cframe_reg_init(Object *obj)
     fifo32_create(&s->new_f_data, FRAME_NUM_WORDS);
 }
 
+static void cframe_reg_finalize(Object *obj)
+{
+    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
+
+    fifo32_destroy(&s->new_f_data);
+    g_tree_destroy(s->cframes);
+}
+
 static const VMStateDescription vmstate_cframe = {
     .name = "cframe",
     .version_id = 1,
@@ -833,6 +841,7 @@ static const TypeInfo cframe_reg_info = {
     .instance_size = sizeof(XlnxVersalCFrameReg),
     .class_init    = cframe_reg_class_init,
     .instance_init = cframe_reg_init,
+    .instance_finalize = cframe_reg_finalize,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_XLNX_CFI_IF },
         { }
-- 
2.51.0


