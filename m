Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E5BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOffp-0005zy-Oc; Fri, 20 Dec 2024 11:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffo-0005x8-1v
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:20 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffl-0006ob-VY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:19 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436341f575fso22743785e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711376; x=1735316176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tj6AnlKg0EXBBgClIcVaCfEyCYSjd/a+74sK1iIjuEg=;
 b=u74+8ydGK3lrPnMc2RY/YBgOXu3TDZF/F+1Xb8lLVkFCjf8XOCTXkAyYQ90gDUikZl
 RL2kNnDh4DYUQKei0IT1xT4WS7rfmpG0D+e49ZAt2KKswGquLaTYKAv6jyrbzNe/k391
 q5vG8fnuxz40Yep4yeKgVt4yJDy3NQnXpK7P5sB66rK5p6HUayjW3dHJuqp53eEMPt4H
 hfapmymMm2tB4UZyVr43TQQDdp1v2Gq/0jK6y/ctIY2+s1AZu0KbgldwRW4JBQqxOdqq
 oIWf/2h5T9mK8YWDA34gw+rZMvykMoss3xP1m4NwGmz7uRrzpsN43FqUNLeCagv+1I1v
 qMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711376; x=1735316176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tj6AnlKg0EXBBgClIcVaCfEyCYSjd/a+74sK1iIjuEg=;
 b=eHOWVDSF7sL+3aKhBGWajQSlyfhqDCwovfkiLJpRVrEY+KsdhQJ4jFUZOtXF32nDBM
 Xc2X00dQD1URJezE8yhLXcJl8d7amV3RJnsBmpfWAaYl1IHcpgl4EKf09txMDpdv3JZH
 LNHDi2ncmsY3TItW9yPkSoYiDW8ekC5aQ64QL6N94nt77KtyUVpSdy7mGmftwBrgvu9l
 hhwXmZ5nWGIwJA8WipCGoNpIz0AAlwY2IckEwKq4FoRL7yFnjkJbxBjpAYTn+yuY58mT
 H59k34+6U4QNFQAPzXj+dqQxGTz0/dyiywOAtjJS17wn/HUB3QOYuzQ2TE9Dtn2d/TZ2
 jTnA==
X-Gm-Message-State: AOJu0YxFy54Nn4NzSGUOV3DZ8IF6bNUSkggiDCxNAYwE+7LYTpDAkDU1
 W73DYA+Rn81GFvhtkPIqe834F1rXHh/OqIPH9aCzjh2f83w3qBTrEpidbB+kqMIzbeAOCqXCO61
 O
X-Gm-Gg: ASbGncuxL4mmMou6hXzbXBnN9h3jlIq4ER2xtDofF2vNhVlMEkj5PWah2QD90BQjWg+
 uCBlw8NKYzk+wL6GNkKkh4Fkr0vUfZpLO+P8SwDFBHRDo99fPz9hXrF2mEBQczAZ6YY51qjlhIx
 iBMWKGOtt3YWrXRLVyrg92uUPLu1mDEF4ujIkEt2wWfFjd/MTL0zeDG4BW8Nj5lPV7oH39pYKy7
 BbPEabqQqPTFtqYbVBSG6zYiCmnghRan9WfmH0tg1u9MbkDuAT06bHxfMFL2UcD4hj3SqLHvw8=
X-Google-Smtp-Source: AGHT+IFRMgVEkUGJxR6+lbJPlxMZsomGzAj6g50ljjwB5jU8TCDF3Q5OuWi0Mf0pUiKFgh/naDcmVQ==
X-Received: by 2002:a05:6000:400b:b0:385:ee3f:5cbf with SMTP id
 ffacd0b85a97d-38a221eab74mr4150297f8f.20.1734711375772; 
 Fri, 20 Dec 2024 08:16:15 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8292adsm4376055f8f.19.2024.12.20.08.16.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/59] tests: Fix test-qdev-global-props on anonymous qdev
 realize()
Date: Fri, 20 Dec 2024 17:14:56 +0100
Message-ID: <20241220161551.89317-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
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

From: Peter Xu <peterx@redhat.com>

test-qdev-global-props creates a few subprocesses and test things based on
qdev realize().  One thing was overlooked since the start, that anonymous
creations of qdev (then realize() the device) requires the machine object's
presence, as all these devices need to be attached to QOM tree, by default
to path "/machine/unattached".

The test didn't crash simply because container_get() has an implicit
semantic to silently create any missing container, hence what happened here
is container_get() (when running these tests) will try to create containers
at QOM path "/machine" on the fly.  That's probably unexpected by the test,
but worked like charm before.

We're going to fix device_set_realized() soon, but before that make the
test case prepared, by creating the machine object on its own.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241121192202.4155849-4-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-qdev-global-props.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 1eb95d2429b..d2f9800148d 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -72,6 +72,26 @@ static const TypeInfo subclass_type = {
     .parent = TYPE_STATIC_PROPS,
 };
 
+/*
+ * Initialize a fake machine, being prepared for future tests.
+ *
+ * All the tests later (even if to be run in subprocesses.. which will
+ * inherit the global states of the parent process) will try to create qdev
+ * and realize the device.
+ *
+ * Realization of such anonymous qdev (with no parent object) requires both
+ * the machine object and its "unattached" container to be at least present.
+ */
+static void test_init_machine(void)
+{
+    /* This is a fake machine - it doesn't need to be a machine object */
+    Object *machine = object_property_add_new_container(
+        object_get_root(), "machine");
+
+    /* This container must exist for anonymous qdevs to realize() */
+    object_property_add_new_container(machine, "unattached");
+}
+
 /* Test simple static property setting to default value */
 static void test_static_prop_subprocess(void)
 {
@@ -295,6 +315,8 @@ int main(int argc, char **argv)
     type_register_static(&nohotplug_type);
     type_register_static(&nondevice_type);
 
+    test_init_machine();
+
     g_test_add_func("/qdev/properties/static/default/subprocess",
                     test_static_prop_subprocess);
     g_test_add_func("/qdev/properties/static/default",
-- 
2.47.1


