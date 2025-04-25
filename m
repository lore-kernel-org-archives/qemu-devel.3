Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D3EC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KzN-000084-UT; Fri, 25 Apr 2025 11:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KzE-00005V-E1
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KzC-0003WS-N8
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so15055115e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594945; x=1746199745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6uHbC7gkNaBaOGHOhDOw2ZtpkNYSZdzsksMim+79v8=;
 b=XGjwg7pbF7cTq/1H5nqC6rwUXMKWFKxI/emJ/elb2kOeixivOrmEt5zGmRttr1r2Wu
 Td+qBtONRJaCo6zy53y8oJ5wPijFak1A2WLkR479hw47YvnhSxOxBRSTMlCUtcxpMRGs
 fJXsGNlCzjjqkzMtuuYhohIWKPVA/z5oAipb2rI0VZ7jseW3LjnQtRsy5YUZrF+ghvEH
 ESL4V+uA8GYK6Faw35bbTa1pCcBYy4jCdqPHlzdUGNhuoYTjvYr4YUdyRoKInCifi/xJ
 xK55BnufiqQo+UyLiEZKJZnhe88ixr3xqU7OMZ0h9xSbdJPY6oggKA0GnTZnldMZxjt1
 Gxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594945; x=1746199745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6uHbC7gkNaBaOGHOhDOw2ZtpkNYSZdzsksMim+79v8=;
 b=YplrDhv8asKoic8tEFCerfOjhLplpJ9gqkmO9lQWXuSrcI+6L2dHh5P77L6Vfk/GHv
 E0sMtYsjh7OaMgXDHy1acj0Wk53fZlQvgdjC8nEykc3l3pofBDEs1d47QQ08wkJSQkVe
 /mRTmFMkW5Kyw+w/3M3quSJP+79j6O6vs/l7EVUxsqaHLAGc0lqZiBfePZjbOC6QrjT9
 /TK9gxsJL+YwI+hAhQOg6ZjiHBsn+XHhsCpVBi+pwB7iCm2+QvlurpIb7RFSAMNdaSc5
 Co89XK6K7CLGUzZqU4ahbcpUQt85xSfdQo8I7Cz5HAvQHp++bTZjM03xQYpDumcKZSpJ
 hXlw==
X-Gm-Message-State: AOJu0YySIJBSi4cDiXIQuxcINN6yej6jh2tFRpYSGdefLDJC8oGcVyLr
 75Nf6xXMp0sIIPKMDa/nagTAb1V0YfwlZcd/8ZpUCf/vLXifOLbgopb4ql11RtCExWSA9wuYcTD
 f
X-Gm-Gg: ASbGncsJQvt7CLnNu7TSb/10k07hSYBZijyzIryMeKs/JUYEMBUo6Cq+PCcNuiL7C3Y
 +2x6SYN/5LjLu/WN4IHZ+xjtGE2j+bcXBl5iXSJkL4fLCALbmZu9GfbtrI9f27dWBQRvai80TqI
 wEu82DWN/YHWMbzszhnnNTVROEVir0w7zlfP0tjZWixdxpOQPBRb+TdDH6DnCqyvnNpjzj4Ca66
 1XEPgrnur4oncl4RCdwZeTgIuFe6Dm6N1L41/7PK8Ip5fqsuJ09zbBJJPZtM/IqTWdryLPV8XHf
 0MBLZ16t/3MnkLfjCRp3KZ1xDkrTrKsnDN9shsgvudRh1mkwR7/AtO/VphtfuFZNmInANlTH7j/
 dTObVpdiX+U4LNxU=
X-Google-Smtp-Source: AGHT+IHXVHgfivUPJdlyiYbRw7cyA/7AbPiaEaxnBqJcP5gvej4meMNzlV9WG2Sdy4HhA5ZkxSKyag==
X-Received: by 2002:a05:600c:4ec8:b0:43d:2313:7b54 with SMTP id
 5b1f17b1804b1-440a65ba1f2mr28179845e9.3.1745594944723; 
 Fri, 25 Apr 2025 08:29:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a1544sm61619915e9.11.2025.04.25.08.29.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:29:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/58] cpus: Introduce CPUClass::list_cpus() callback
Date: Fri, 25 Apr 2025 17:27:48 +0200
Message-ID: <20250425152843.69638-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Some targets define cpu_list to a method listing their
CPUs on stdout. In order to make list_cpus() generic,
introduce the CPUClass::list_cpus() callback.
When no callback is registered, list_cpus() defaults
to the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250324185837.46506-2-philmd@linaro.org>
---
 include/hw/core/cpu.h | 2 ++
 cpu-target.c          | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c8d6abff19a..5b645df59f5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -102,6 +102,7 @@ struct SysemuCPUOps;
  * CPUClass:
  * @class_by_name: Callback to map -cpu command line model name to an
  *                 instantiatable CPU type.
+ * @list_cpus: list available CPU models and flags.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @memory_rw_debug: Callback for GDB memory access.
@@ -148,6 +149,7 @@ struct CPUClass {
     /*< public >*/
 
     ObjectClass *(*class_by_name)(const char *cpu_model);
+    void (*list_cpus)(void);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
diff --git a/cpu-target.c b/cpu-target.c
index 14cd623bffe..d139a18f5b1 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -104,7 +104,13 @@ static void cpu_list(void)
 
 void list_cpus(void)
 {
-    cpu_list();
+    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
+
+    if (cc->list_cpus) {
+        cc->list_cpus();
+    } else {
+        cpu_list();
+    }
 }
 
 /* enable or disable single step mode. EXCP_DEBUG is returned by the
-- 
2.47.1


