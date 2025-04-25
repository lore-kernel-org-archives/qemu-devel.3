Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B74C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Kzr-0000Ma-LW; Fri, 25 Apr 2025 11:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kzl-0000Jt-SK
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kzk-0003Zk-6c
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so16848685e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594978; x=1746199778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YS0KKbVb3QlYsS+EDVG/sJJ1OU5Cca6YcSkQlykDIeM=;
 b=bW9O5mgNzVg5l4I5seWtmQGM3rQYY6eJJ+yxCHISU7UrKFH9HxgTd0ZYW9UcP9oQT/
 2q8ygk5LP4s+EThWHQprQbYulF6EewWp5YGNA3CuGEVOjOaIL4HybUoM4+ztkOhMm/dW
 8jD4mzW/kFHjmpR+rorviWhtwHkQjVx4toPf6Plg4QZRDdBEuDZAJX+3bWgYm16JnBsY
 Ty2OqFgGebBs3BCYLnEq7wQ+IfwE6aqWgnOGnXu9vnERtr3oV6UAiFeMka94crN7kyse
 4XxMphE5AXpoPgmIiy/rs58lxrs9v9w1zYqfv5JHaVjdFn/lUY1KqQeZIi87d2DSwX8a
 ytlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594978; x=1746199778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YS0KKbVb3QlYsS+EDVG/sJJ1OU5Cca6YcSkQlykDIeM=;
 b=MGFP/1efNG3siaoZg8BUkzTJ6fwUeom9ypv8WK7HX54gIOjp3qMdNCTOHkbIFCY16d
 tJHWZI7NiDjrriMvPtyddDtr3jJBzIvTemaV5jHwHM6aL3amXIk5dEzSUd8rBs+KoiOP
 ia7pmBxcYrDGmXK+feHMcbrEpgUp+oiVWp+ysoblJXpM9G6ydc5EH3bBacbobanTLXwS
 RNaYP+ny6owULK4sBRDNlcfYt53CGASWT3noYVRR/5j/pcp1R5Wncf5Sq1BuIFPkLfSD
 6/aMYIi5tkCVRLy78g+3dIMlHbuWT3u57me7Sq9BpDYR/o3/RfGt5FPYhRxJ8S05prI3
 p8gA==
X-Gm-Message-State: AOJu0YywU/VXVkg4FlUR4UL2nQsUuedvw9wDlL2lMZLCPG4GameeDQlw
 SydaD5rg2KcsRUcSTEOd4LpUct2oKLfzBr9uVAq1VnrcFaxx3dw6U/LpzUBR1CWfYxsE5cu5FQD
 F
X-Gm-Gg: ASbGnctkOcIuiH62C0aGVUWYMm5tIkO+y7WI40yGy38TjeHTA5eCGIb6oR6p35KASMo
 OJZsRuae49th95sxgQHf/Wu8rSOJJoJfr/QvMHbk0FbwYACP1teJo93z7a1RBruLIFi9GXzkpL4
 0UncUhsWwmbl9buRvVpWkFUEp8I5nRbQO1TI1b4PQt2vxotax+TQlSG1iC2XiSXhMbjTOT/vYUZ
 cPjkYOyzRm4jzzVrtvH8oQeanOWl3cJkmK1PXFD1BBszL87MwJTxOrr/knW+8QXVnByP2nZTTKd
 0GM6xCW2LuOseIA8QvKTrS54hPSawkptYl167SBsPyw6V6xvhPi1230FWXB0j7oKB+xvPOksZDr
 Npf6jjiehSGLJhbU=
X-Google-Smtp-Source: AGHT+IFInjTQAR1G200iUGYgOowwmDQfqVthj6CTIfwaQ54XRZhxQgpBt71wqtuBQPjqKHUeF3ZBWg==
X-Received: by 2002:a05:600c:4f12:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-440a661a17dmr21668015e9.19.1745594977953; 
 Fri, 25 Apr 2025 08:29:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29ba29sm62396805e9.7.2025.04.25.08.29.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:29:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/58] hw/misc/edu: Convert type_init() -> DEFINE_TYPES()
Date: Fri, 25 Apr 2025 17:27:55 +0200
Message-ID: <20250425152843.69638-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
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

Prefer DEFINE_TYPES() macro over type_init() to register
QOM types.

Initialize the .interfaces struct field as compound literal
casted to InterfaceInfo type like the rest of our code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250424194905.82506-2-philmd@linaro.org>
---
 hw/misc/edu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 504178b4a22..5723ef0ed13 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -429,21 +429,18 @@ static void edu_class_init(ObjectClass *class, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
-static void pci_edu_register_types(void)
-{
-    static InterfaceInfo interfaces[] = {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    };
-    static const TypeInfo edu_info = {
+static const TypeInfo edu_types[] = {
+    {
         .name          = TYPE_PCI_EDU_DEVICE,
         .parent        = TYPE_PCI_DEVICE,
         .instance_size = sizeof(EduState),
         .instance_init = edu_instance_init,
         .class_init    = edu_class_init,
-        .interfaces = interfaces,
-    };
+        .interfaces    = (InterfaceInfo[]) {
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { },
+        },
+    }
+};
 
-    type_register_static(&edu_info);
-}
-type_init(pci_edu_register_types)
+DEFINE_TYPES(edu_types)
-- 
2.47.1


