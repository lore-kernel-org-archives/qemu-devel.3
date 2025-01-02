Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC186E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMt8-0007e3-4Q; Thu, 02 Jan 2025 10:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMt3-0007Zt-8h
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:26 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMt1-0006Ze-RJ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:25 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so114287145e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830802; x=1736435602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOzPkO5TmCycPZ/aaTUQEr16ldzePeyfEU/CMbdVIug=;
 b=SsK/aAoEEiUkSZB/b4u2s7wDXRx5D75mrVFZEaHTh2pE75Hq77DPt1nLSI40rxPmC8
 4pl+swDT5NDXpLuDEvQhY24po1TngoIhHPOz936E1p18dFJYXrRlGWyuBQl0fCa+BfoH
 Vbog02EU5Y9iwpdXgxOu2q0Rril4+5clIJ3B6x5YnAO1Gyqm1yeC3ZjKct7DR4MjgFiT
 yp+nEEl0wIvSiX7rI86/u1525YkmkUV6KZ9DoLUr113es4NyRP6T2GFJM7BuQcppg0tl
 /tnoxzh6jvrfboEBh7E5FaRHAJC79nNfRqAvH+UcAapHxZ5nvWxUR6D3BiN0NxCOtdZ8
 70Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830802; x=1736435602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOzPkO5TmCycPZ/aaTUQEr16ldzePeyfEU/CMbdVIug=;
 b=Usdo2+gYV+Tbhb4XFnNZ2w5XMTN0aGCB21xuq564ktZGvCvMmuCEEFTm9Cfk/IWk1t
 n1qe4FmB4r1278uKoR7S3tMmrqp/UuC7z6EH+BI8rytrBaS05urzcJCrZ7UwE8qjyi83
 Gamx+3+dKd4L0syDXb4EJJLMzXsPhryfk2HUNAedIPPDMDslhb8ut5YcsUpdlvGZvPQL
 xB3HXn+Uq8hLbJTthAKZQ4T7dHJDvXjeX0zZhi2jTF1mVDL0GpAwlXJJqk841RKObpxJ
 ntokpzqYt77w56bZ1kyvlwGVgQI/kz1t4+VNo/oH1mhFyoIp1ZpgDcvu53NrU0N/GBWk
 YDLg==
X-Gm-Message-State: AOJu0YwVvyGOIky1iYESK9n/ybvaddMZJkgk1jqGJ/UU9uJgTc9YwvgV
 2PnoRugs8HhPDAowtYH1GG84HBfXl5bJkz9gDQiEprB9gWzsR/qvxIaKcKNPGmtXmclc1nfKm6h
 cMBmqmQ==
X-Gm-Gg: ASbGncvoAN2BGDGe2wArvCB9JvIiSp3O/wZA36TtieP0FS3NZNH3+1415seqU5z8SPQ
 upbeC2uxVipTLeQSiH9Bs0BsjSgFQfmrECN6W68sUzvL/llJkli5qhUK4D048ODIM1xbIxK3VzE
 wUjb9AjwGQgQd/GhB0hWUXu24gfIV0ANe880dl8BI+/rj8rAJkDhX6qbmEm7kL9ohBzfBtxL08J
 o6+dMKWF4c/5jXZI1ezgjodGUqWTq6BjlC6YL87bzhDwEsO9DicjYXvz+EJPu+grfY6oQItDA9n
 fjAjDDbnIcx8OSGOuMKpkY5tpK+3+Q4=
X-Google-Smtp-Source: AGHT+IFrL5hXkCHLj+i3X6LEtqowF+hQOBI+5N4joqlV03TBnogyeaMQTJ+NmsC1RngDUIu53EXNWg==
X-Received: by 2002:a05:6000:4b0b:b0:386:37f5:99e7 with SMTP id
 ffacd0b85a97d-38a22201897mr41198827f8f.33.1735830802090; 
 Thu, 02 Jan 2025 07:13:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e357sm39397475f8f.72.2025.01.02.07.13.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:13:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/10] qom: Add object_get_container()
Date: Thu,  2 Jan 2025 16:12:41 +0100
Message-ID: <20250102151244.59357-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102151244.59357-1-philmd@linaro.org>
References: <20250102151244.59357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Peter Xu <peterx@redhat.com>

Add a helper to fetch a root container (under object_get_root()).  Sanity
check on the type of the object.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241121192202.4155849-12-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object.h | 10 ++++++++++
 qom/object.c         | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 95d6e064d9b..bcf9910b42c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1510,6 +1510,16 @@ const char *object_property_get_type(Object *obj, const char *name,
  */
 Object *object_get_root(void);
 
+/**
+ * object_get_container:
+ * @name: the name of container to lookup
+ *
+ * Lookup a root level container.
+ *
+ * Returns: the container with @name.
+ */
+Object *object_get_container(const char *name);
+
 
 /**
  * object_get_objects_root:
diff --git a/qom/object.c b/qom/object.c
index b4c52d055d9..81c06906d30 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1751,6 +1751,16 @@ static Object *object_root_initialize(void)
     return root;
 }
 
+Object *object_get_container(const char *name)
+{
+    Object *container;
+
+    container = object_resolve_path_component(object_get_root(), name);
+    assert(object_dynamic_cast(container, TYPE_CONTAINER));
+
+    return container;
+}
+
 Object *object_get_root(void)
 {
     static Object *root;
-- 
2.47.1


