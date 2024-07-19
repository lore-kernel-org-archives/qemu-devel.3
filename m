Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606ABC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUiBM-0000D4-Hb; Fri, 19 Jul 2024 03:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUiBJ-0008Tf-Nq
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:37:33 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUiBG-0002kH-E9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:37:33 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721374649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DbCemAqk1RMGAJkOqK+qGm8GLRl52T9lDX8cpSvFDc=;
 b=zJRqaDB9k7q+RSr0SiF63mE7EA6nYpuR35znli9o+7PXR4B/oNVj9nwfO4xJHpFJ4oYbfv
 ChcRJtB10OUOrq6VjC/jRHfzTVoqzXciwAY1ipwa9NyPMDHC5Vlb0w1g1VeyVUjjZzNwYe
 vtXKOVUrtovm8CaJKgpxCWVqpBhx23LJ7yMeJ2y8ZhWM443GSfZcEz/Nkb48RaKU2Qdaej
 FvN3hQzttfS/Cp8R+y77YRr3ozzLHOtwDMNVx09l58Ukm6EGKHOU/HpD338h+q9+CLRc0A
 Ka7t1akPNreVYqnILtYKZIGG25Ll8+7cwocMjss2JKJkVmxrt2qMI6FKEKtlWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721374649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DbCemAqk1RMGAJkOqK+qGm8GLRl52T9lDX8cpSvFDc=;
 b=TUYOH1sfvSiFKfn0dx82QwCxszJvtCK6ESJP9fTR1Ys3N4BkTDf7RjxC3Bcs4y4U5w0WqJ
 ImliblOlNlvycXDg==
Date: Fri, 19 Jul 2024 09:37:25 +0200
Subject: [PATCH v6 4/4] docs: add test for firmware.json QAPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240719-qapi-firmware-json-v6-4-c2e3de390b58@linutronix.de>
References: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
In-Reply-To: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721374646; l=949;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=QbbzNg7hTap981Md99+ozCHjVgv8YoDN7wXDqCGCTng=;
 b=QAV1kAvM6lfFrq5Vix3yDMT6tca4hpJVle+gDpg9v+Kf+tFLZriG5LpVWM8bYj8gFyGVKKOAD
 T+/wPr35LtrAQStAYH7Er0sEMN+jsrlsPGHgNykvwbh199omeF0llGE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

To make sure that the QAPI description stays valid, add a testcase.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org/
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/meson.build b/docs/meson.build
index 9040f860ae1a..bcca45a342a3 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -99,3 +99,8 @@ if build_docs
   alias_target('html', sphinxdocs)
   alias_target('man', sphinxmans)
 endif
+
+test('QAPI firmware.json regression tests', python,
+     args: [qapi_gen.full_path(), '-o', meson.current_build_dir() / 'qapi',
+            meson.current_source_dir() / 'interop/firmware.json'],
+     env: test_env, suite: ['qapi-schema', 'qapi-interop'])

-- 
2.45.2


