Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C49E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5p8-0005lk-1e; Fri, 13 Dec 2024 08:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5o9-0005BW-6K
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:19 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5o4-00016J-PE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:15 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-435004228c0so21167475e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 05:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734096849; x=1734701649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33yHg4YQB7rIHCnPM4ck8re7RPKyKODYcLX3k+hKjac=;
 b=X6rEjXTS+l+IiT9IAS809useh+8FFac9ocG4tUomt/x1FRL2KceBlw4lzShL/kBWJk
 xLea8Rw8U/FmzBHoJTmvymptCBJImXnEYHy1mticnoC9u4ASbl789FpyMg+VkHbpQAbS
 i+KCnY9pohqEGA5aGEmN3Ij3JSbERYNNDmaVfh7hZjdEAcqNbGVeu9a+8Jiuq9ToGkhw
 5kyHl9U2iuUT4Kw6ShvtiKDD5G98GZi3SypkBQHwG6P5wTHCd8chRELL/0IfK3xU8Joq
 wxCLIrbsg//85qrqO0kqLpR60GT4GYeNDh1XaALF9AaoF5E3nuJdHJyQFsWmWDSzcyyi
 L+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734096849; x=1734701649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33yHg4YQB7rIHCnPM4ck8re7RPKyKODYcLX3k+hKjac=;
 b=WFk18gYCcdWVBugCDmYCvM0MzAfUVEjHU/A+DLm699D/dptOjrcPW3Rg54hhh97Fyx
 B/UtZOofcQrQdLnI6SXbWmVrTE/MeF+4oz0ORqZ6a6gwuzbaRKGF0n0JzK3TRq49saqK
 udxqBa6snVy7gRh1VCiZJsLuRxnbjQxQ5dNUw+8EZrAlv62pxE13p3jB7T03slDNrYqR
 yf3vUbTDNzA9V7TcwHoZyog4NCTK8Jp+0CxpTBVw9xJDDnaOzQuSI9CNd2c840U0NwNw
 vqM8Aj0lM7XL64VbolMAg4Ui+sk9OJ/Fd+LQn1WRR3AKvzabmB7kA0EFfK4Dg/Hx6No0
 UFwA==
X-Gm-Message-State: AOJu0Yx9QLTby+c5w4Twj9JfvBBGbS/d3/LwT6nFDwzaEdwZGIpqd+Sq
 be4MGsp/p5VT3XHx+iHuVG3cVhXJEvWI/5ecvbdaQZi/5uMz6j3SXyZ009e5DYIy5rjfIMVqpGy
 f
X-Gm-Gg: ASbGncuJ4OX7FPCt7gat99iULD0nIpB/asM4BUpMlAtwRgGN/61kMLQa5is1w56Tt8+
 +CEH19zAN8tufJOufRvGp1Nck/NOPHmcRic2tY0k+p/hBWxhiLSOS+9JtVENqHwVJKTtLBe9/dG
 gohK6BNhsbWtHOJgX07ARQ4GP4+UiRi8SqJVPunFaEtGlkeuE1n2QbphFbxUasxF89Jcp36Vql5
 ylzZvzsWzDvUC9tWFQxTVwytVJWkdt3PZcLAxxR5tL8pUgo6RW/W7zKyui/L0UI8NuJUNV0t48V
 B/00KC4ocjwNkoGx9hGsCWUrOZJbfAcGQp9r
X-Google-Smtp-Source: AGHT+IHJCQkWjdUS9JM+Or0PrYfr25uOj/EPsYAQ18w+d1tMFeDwJSAwNGr9B9vhcQB4Lk7iOvOf1w==
X-Received: by 2002:a05:600c:450e:b0:434:a852:ba77 with SMTP id
 5b1f17b1804b1-4362aa4ffe0mr24695125e9.15.1734096848901; 
 Fri, 13 Dec 2024 05:34:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436257178e3sm50186895e9.41.2024.12.13.05.34.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 05:34:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/7] hw/nvram/fw_cfg: Skip FW_CFG_DATA_GENERATOR when no
 data to generate
Date: Fri, 13 Dec 2024 14:33:48 +0100
Message-ID: <20241213133352.10915-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213133352.10915-1-philmd@linaro.org>
References: <20241213133352.10915-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Allow the FW_CFG_DATA_GENERATOR interface get_data() handler to
return NULL when there is nothing to generate. In that case
fw_cfg_add_file_from_generator() will not add any item and
return %true.

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/nvram/fw_cfg.h | 13 ++++++++-----
 hw/nvram/fw_cfg.c         | 10 ++++++----
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index fcb06f18cc3..5211018fd8f 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -30,8 +30,9 @@ struct FWCfgDataGeneratorClass {
      * @obj: the object implementing this interface
      * @errp: pointer to a NULL-initialized error object
      *
-     * Returns: reference to a byte array containing the data on success,
-     *          or NULL on error.
+     * Returns: NULL on failure (errp set if not NULL).
+     *          A byte array containing the data (if any,
+     *          otherwise NULL) on success.
      *
      * The caller should release the reference when no longer
      * required.
@@ -298,14 +299,16 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
  * @parent: the object in which to resolve the @part
  * @errp: pointer to a NULL initialized error object
  *
- * Add a new NAMED fw_cfg item with the content generated from the
- * @part object. The data generated by the @part object is copied
- * into the data structure of the fw_cfg device.
+ * If the @part object generates content, add a new NAMED fw_cfg item with it.
+ * The data generated by the @part object is copied into the data structure of
+ * the fw_cfg device.
  * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
  * will be used; also, a new entry will be added to the file directory
  * structure residing at key value FW_CFG_FILE_DIR, containing the item name,
  * data size, and assigned selector key value.
  *
+ * If the @part object does not generate content, no fw_cfg item is added.
+ *
  * Returns: %true on success, %false on error.
  */
 bool fw_cfg_add_file_from_generator(FWCfgState *s,
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b94cd27bd85..7e1065e5f50 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1031,10 +1031,10 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
                                     Object *parent, const char *part,
                                     const char *filename, Error **errp)
 {
+    ERRP_GUARD();
     FWCfgDataGeneratorClass *klass;
     GByteArray *array;
     Object *obj;
-    gsize size;
 
     obj = object_resolve_path_component(parent, part);
     if (!obj) {
@@ -1048,11 +1048,13 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
     }
     klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
     array = klass->get_data(obj, errp);
-    if (!array) {
+    if (*errp) {
         return false;
     }
-    size = array->len;
-    fw_cfg_add_file(s, filename, g_byte_array_free(array, FALSE), size);
+    if (array) {
+        fw_cfg_add_file(s, filename, g_byte_array_free(array, FALSE),
+                        array->len);
+    }
 
     return true;
 }
-- 
2.45.2


