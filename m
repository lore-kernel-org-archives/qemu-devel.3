Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E96C35FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvI7w-00041z-7p; Thu, 20 Mar 2025 11:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7P-0003Tn-8W
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:47:49 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7N-0007oG-J3
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:47:38 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so643143f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742485653; x=1743090453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GC9BJXwZMB68nDcfXgqs95N9vIk0tB0Sm7nNBQ7VN3g=;
 b=yKpkJ1Eo8LuQmzL6FJedANYlBo6nHsu8C7Hfubf1qpFm7vdYiLKIdCBj+yiev2bmzK
 xkWo9cWBpjcQ8YS8PAFJ9ducxqOCZPo+OO+m7nRHyYVLp3QlapiGRokTSm/7KHbgJnEs
 7Jph4ioiv8xIz/2VfalEWDkORymU/GV0rf3qPNlJlt83EJaOiNd7R7Jgc05NdZkkslXE
 VGTBEMjNst64mGN71ffGBxjJ11o0ztYRlX756IX/abHQ48rBd0OIE1F0I4xSgDn4KzEm
 3naY98FmGlipSrO1woSpIdKUsaPUCePhmRYYbKmscnWW2twNPwVma8P+spsd8T/U4FsA
 tcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742485653; x=1743090453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GC9BJXwZMB68nDcfXgqs95N9vIk0tB0Sm7nNBQ7VN3g=;
 b=KzRK2amgE2KvPCS8NRgzrzZbuJxZ1cNWtAXmgHJUvOPA/JMV49xeeZFUSMrK20s4mQ
 iDtjcyZatNYZYgO0HE84cP06olRAros3dHDcfk+e89jFw4zz+j1gchwS4hhya6wx/xhv
 Qd9OFxMJQ7twwxs6fJpdJ1LaIm5oIjQclPjeEKyDOTDh6CiKg1uyH9d7PE2PLHmaaOim
 UKQRE/ZZYqDUHOUYRy3h4nWBJzxj8JRCtdr5KtlMwGwtoJ+QYBLRO86WQDELo+pict0S
 HXIuWOYIg+3g/ipoeAE8CcC/sgdRRrxk8GoKT1sNebgBfxNXPOHztZ6qouHW/0MQvZ+s
 g0mw==
X-Gm-Message-State: AOJu0YxK5WvJLEB6yTekLlu1s0ZAqnabBXGkhaZapywFgikIp4KU9BuA
 j0E6bm0StxCnEFfdveKCqtJyIxaQbTwzf/6BuPvDa434lZkV6Hvt+cQ2z/gMDLKD1SITM7cj7yH
 N
X-Gm-Gg: ASbGnctnh5WB2UbFysvx8R6swGJYPi7APTBDJImeVisCpdu76oWPVo+XklA+gZas8O4
 KRROStJ9zVGP1Xs54ZqXjRPwO7bNfLfjC55TRg/7xN/VdYfSSAoAKRJfYrPoRVvgipLGfem++ZY
 H4L72q1W2HKDdvhWF9vADNoP6S9g1dm9HcV3L0nUjMuNfNxVEWgos+JmAuOWESB6rwQgYsbFeWY
 w11Q/dG6tpN2cXXbztqryOTQwJ/jUCx7jIWYKyqFeC8we8eoXv1Hb/dq9UcVy7ICHHnYduzoavk
 uxZbx34L295knzUctP4GnTCbIFA+C4ANyiqVfTvHNpQ4Wl7S62D7aVGt7KZFEaLtqI6bmYGPzZk
 BvTwg+IXhpqMPV1OXV86r+nhj
X-Google-Smtp-Source: AGHT+IF6djAcd1lLvRp2p/RhIZ/hWfF6UWx0s42BFk2yoq7T2E2/r3C+EtXWa3aVpAGdaiV46louwQ==
X-Received: by 2002:a5d:598f:0:b0:390:fb37:1ca with SMTP id
 ffacd0b85a97d-39973b04a9amr8653898f8f.53.1742485653445; 
 Thu, 20 Mar 2025 08:47:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb40fa30sm24349899f8f.68.2025.03.20.08.47.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Mar 2025 08:47:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 2/6] qom: Add object_class_implements_type()
Date: Thu, 20 Mar 2025 16:47:18 +0100
Message-ID: <20250320154722.27349-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320154722.27349-1-philmd@linaro.org>
References: <20250320154722.27349-1-philmd@linaro.org>
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

Add the object_class_implements_type() method to check whether
a class implement a type, which can be ambiguous for interfaces.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object.h | 10 ++++++++++
 qom/object.c         | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 9192265db76..fd74d4be89f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -995,6 +995,16 @@ const char *object_class_get_name(ObjectClass *klass);
  */
 bool object_class_is_abstract(ObjectClass *klass);
 
+/**
+ * object_class_implements_type:
+ * @klass: The class to check the implementation for.
+ * @typename: The QOM typename of the implementation to check to.
+ *
+ * Returns: %true if @klass implements %typename, %false otherwise.
+ */
+bool object_class_implements_type(ObjectClass *class,
+                                  const char *typename);
+
 /**
  * object_class_by_name:
  * @typename: The QOM typename to obtain the class for.
diff --git a/qom/object.c b/qom/object.c
index 1620a87ef44..b9948937935 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -992,6 +992,17 @@ static ObjectClass *object_class_dynamic_cast_ambiguous(ObjectClass *class,
     return ret;
 }
 
+bool object_class_implements_type(ObjectClass *class,
+                                  const char *typename)
+{
+    ObjectClass *k;
+    bool ambiguous = false;
+
+    k = object_class_dynamic_cast_ambiguous(class, typename, &ambiguous);
+
+    return k || ambiguous;
+}
+
 ObjectClass *object_class_dynamic_cast(ObjectClass *class,
                                        const char *typename)
 {
-- 
2.47.1


