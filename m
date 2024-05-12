Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51479C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66nD-0003fs-Sk; Sun, 12 May 2024 06:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66n0-0003VW-EL
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66my-000698-UP
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXo9sva3/rn1vjZeUYeBkrkHGuS3CAewAGjT9QThyKs=;
 b=c8h0nDeNUex9xk+I4YuuoSt8TZ84OdDvjZDdE7YRXcDfrqUao+uyrJ58iXtNeN9H0kYcE5
 QNj+SIWT9BXpV7F3uL76ruPkpzN7r6vqpJF6gYtivP4McfwQXUpFFNTdOW8bcMC7r+CO7A
 e12DhARKvdgngfGeU1zOhjzCgrkBfic=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-Tv_2ziPFOtOujpsxYfqN0A-1; Sun, 12 May 2024 06:50:41 -0400
X-MC-Unique: Tv_2ziPFOtOujpsxYfqN0A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a5a5fdd6185so23518166b.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511040; x=1716115840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXo9sva3/rn1vjZeUYeBkrkHGuS3CAewAGjT9QThyKs=;
 b=q1TVrkK8gWOQ8HLNNMlULtFCHAIByUus6cFC8E06pQDLcJHgqro4PWe4FF117ZiL2t
 lWNMKXuPS5rcxqwLpcsi2gIVZi6EUL1+C8ezBGHgexU0TUN0s+jyZHhCk/Ikalt3wIR2
 GBH1KHI5SYeSSZtnR6fWJF2c1KwdROh8LxZK4MUlaut+Rw1Yua2b6TWMUDabo8iqcoeW
 Qx6iIcW1DiXCtoM4clHekP3IzvocooNF3SwwO/Yb9Z9mrzlTh4JThVqrf6efFo/bjQcL
 O/EJsleZVbsPdeQCpgU62afy1kmTH09PDDDyJGYENBWGujFKiRz4RpoI623V7/OjlcP1
 O/vg==
X-Gm-Message-State: AOJu0YzUhNoXQYSpIFCXuZXRnSGHQjKbYXn5KcVlydO2MBXSxFxCk6v3
 nsSbHrE3cd5AKcYBXyic1BiFIOY7E4owSc54MrbFoERLefJdOTS3HCLwi3BvCG4dfJVtJ6KHwzh
 8TxMFQuHV00q5H/sv0wuk+LjGEFklNOejj3zTul7MTNB9EhBWcG/0mMO/l0x1KJOEIIU0HEuWt2
 ik3FHcC4N8eqE0mpnT89VxI4TgzVnqcCA77zJ+
X-Received: by 2002:a17:906:f582:b0:a5a:66a7:47f3 with SMTP id
 a640c23a62f3a-a5a66a74d79mr8023666b.35.1715511040193; 
 Sun, 12 May 2024 03:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/k3G50ADBzwMCeQtcTA0uCRkG17Brpa8gGAmAAFyIkSLQFZf2FAoWhJeC/z7OPhvW/GVXTw==
X-Received: by 2002:a17:906:f582:b0:a5a:66a7:47f3 with SMTP id
 a640c23a62f3a-a5a66a74d79mr8022566b.35.1715511039928; 
 Sun, 12 May 2024 03:50:39 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17a06sm438997466b.219.2024.05.12.03.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 21/27] tests/qtest: arm: fix operation in a build without any
 boards or devices
Date: Sun, 12 May 2024 12:49:39 +0200
Message-ID: <20240512104945.130198-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ARM/aarch64 are easy to fix because they already have to pass a machine
type by hand.  Just guard the tests with a check that the machine actually
exists.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240509170044.190795-14-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/arm-cpu-features.c | 4 ++++
 tests/qtest/migration-test.c   | 6 ++++++
 tests/qtest/numa-test.c        | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 9d6e6190d55..966c65d5c3e 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -632,6 +632,10 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    if (!qtest_has_machine("virt")) {
+        goto out;
+    }
+
     if (qtest_has_accel("tcg")) {
         qtest_add_data_func("/arm/query-cpu-model-expansion",
                             NULL, test_query_cpu_model_expansion);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 7a1345f80f8..e8d3555f56b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -781,6 +781,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         kvm_opts = ",dirty-ring-size=4096";
     }
 
+    if (!qtest_has_machine(machine_alias)) {
+        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
+        g_test_skip(msg);
+        return -1;
+    }
+
     machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
                                       QEMU_ENV_DST);
 
diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 4f4404a4b14..7aa262dbb99 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -558,6 +558,9 @@ int main(int argc, char **argv)
     }
 
     if (g_str_equal(arch, "aarch64")) {
+        if (!qtest_has_machine("virt")) {
+            goto out;
+        }
         g_string_append(args, " -machine virt");
     }
 
@@ -590,5 +593,6 @@ int main(int argc, char **argv)
                             aarch64_numa_cpu);
     }
 
+out:
     return g_test_run();
 }
-- 
2.45.0


