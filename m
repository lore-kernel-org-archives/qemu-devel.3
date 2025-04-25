Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B6AC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1z-00065g-SJ; Fri, 25 Apr 2025 11:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1Y-0004aO-Aq
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:32 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1W-00043j-CX
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso1345499f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595088; x=1746199888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiBpwyewNsWHNCmNEbMKXMBr6iNUyIIVRgYWIEt5InM=;
 b=ZGH7DSvcFNIGejkujG7vV7L4q0s4PDnUtJxRXY3GF3HzLiD/A8nLJhKO5PSQKHT4NT
 wVtjmC4inaQTqYvIVrAjN9MyyvIX+HWMlqsnIstG7t35C3Q7mX1wv56RJxaqPYRH+YR0
 yGkymrv6PRWTfx88cRvLDjskujAJWqWk2l0qAGchdRgZzeRmhca05KG7jxd9Wme4xNyT
 PAePWkdKfLccjVAlBwGc27X6M+PSHVqapZfJkwm4Q2HMurDzzm8J5joicdEBdAdjphWt
 FZWWJsoeuDEXmtx2l/VY8G/BsjO/rFdYJ2IXutfxe8ICuRjSD0haMzRNLz7wFrP8btP3
 ETsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595088; x=1746199888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiBpwyewNsWHNCmNEbMKXMBr6iNUyIIVRgYWIEt5InM=;
 b=tiUlooUubO0c7X8hdrjWuefRk5ulnrQdSxXDzJIlCfRMjWL7gYNqIdmbbjnwjpgqg7
 6NOeHl+++6UFeKbj1wqYhhWQpxNGGOTuH/ebWaCHBrrAA+MLaxYxvh72NGQXuJmd8nae
 ogP+wtWuBFQviBntBcCg3aS1GEYwOvRB6hPQFe9FwgepfdeeEPTBJ6UG2jn+clJ07qrd
 x8n5RDpaWq0e5yyTsD734+5VSi4yHPgQ36AAk8xmy/ZREMbbqPflqEx/7NC+Uc65V4Iz
 63EdZclt+56o7A3+YCttBArI7f8c6XDk30gYij26DkOhiJm6kj/ybcE6aCWY1SQz9/CR
 wbAQ==
X-Gm-Message-State: AOJu0Yzn+Fr8qjni2b/TQadx4MOzvXE7KL7f1kvLP664ax243dX9ugcO
 4q230h2bcV4dxOrkucGgYulTcu5LHBU+YoSk9PBxp02ZfD4c0hVUYrB3uowtsqoRczMuynLznMK
 I
X-Gm-Gg: ASbGnctHWEJls6Gyyeafx9uNQjshRfWRjN575H0k4pDcgJoonWGreWT1+I0aLNwvUKQ
 Cxhzr7VowqEeANf52ImaxlTeSc8o2esTP1TJmFxwaVMzwEDggRB7JH2+mzDomNRzTE2kFrRmLaP
 e7rUB7r9e/52HxlVFdmDBuI7LzPHTCjZOQ6TBXdbxk32r3FBdfFZ2CW4eZYLOf1QfPh0A8BF0DJ
 VjdKluqVGtYZ9dJb2BxzWxkoSkAIPJ1GIxYy48YWw/4zanOMlOCZ95guKOgLY8vFFr66CQNLPo/
 JpXpWw0qixM7xK+pERnBZuiUqTfcxQdsaqD9KfxDhkHfy0N+t1Liz1HNIHONg4978ssog3wE5N/
 NLPDwzRteV6JSBwU=
X-Google-Smtp-Source: AGHT+IHqVqye5O5d1Et5LvyMSdWsU+Mg5+k727CftuHgsLo+DR+EECnLym6PIWk7dSJ/2iSaCOvcPw==
X-Received: by 2002:a5d:59ae:0:b0:39a:ca05:5232 with SMTP id
 ffacd0b85a97d-3a074e0ef10mr2309522f8f.5.1745595088378; 
 Fri, 25 Apr 2025 08:31:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e4684csm2624707f8f.76.2025.04.25.08.31.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/58] system/vl: Fix type conflict of GLib function pointers
Date: Fri, 25 Apr 2025 17:28:17 +0200
Message-ID: <20250425152843.69638-34-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <e9a50b76c54cc64fc9985186f0aef3fcc2024da6.1745295397.git.ktokunaga.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index c17945c4939..4ab2001df75 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1524,7 +1524,7 @@ static bool debugcon_parse(const char *devname, Error **errp)
     return true;
 }
 
-static gint machine_class_cmp(gconstpointer a, gconstpointer b)
+static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     const MachineClass *mc1 = a, *mc2 = b;
     int res;
@@ -1574,7 +1574,7 @@ static void machine_help_func(const QDict *qdict)
     }
 
     printf("Supported machines are:\n");
-    machines = g_slist_sort(machines, machine_class_cmp);
+    machines = g_slist_sort_with_data(machines, machine_class_cmp, NULL);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
         if (mc->alias) {
-- 
2.47.1


