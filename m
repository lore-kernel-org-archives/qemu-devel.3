Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66009C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rje7l-0002fJ-7d; Mon, 11 Mar 2024 07:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rje7j-0002bo-Bl
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:47:19 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rje7h-00020R-JO
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:47:19 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1710157621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh8LY9SFh1cJe50bavbUhMkEhXra+MC2tsZynx59ktA=;
 b=s8XRrXs2WGt9JfKa6XmN2aZEyKDbQvCrYSgIxDgY5qzCUgzXuMAxE5JrLGQo9vGtKDvyo0
 wIdpX/uP3VfeYedQZNqh78Ybd7PHT7H9xJ5ppIwx+8DB62sdG835I9JmUji+s2l/eIIlAL
 cFzkazKAgrnR6oLuBSiKdnCPMqIGPPOXjVBCcwA0v7cnjZ/vN1vRbpXJ9jzneMuCukjab4
 pCIEWOliK70nbPE3MzdTJ0SzfQnJUA4di/YYmFpb3SrSkYAgUJlt4G7WKtOdH4M1sro/TZ
 Ho+nRLyYysGcTxAf5Z8i24BMDOcIRqrirX6exWY4CccpQYQMGtczEYtuVrad0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1710157621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hh8LY9SFh1cJe50bavbUhMkEhXra+MC2tsZynx59ktA=;
 b=f/xFY5IJWWi+IZLPqQQU2nDvFMC+nC8KmOhzHIT67lIz5nDz4N3MNn4R1IdnHJPlCYexSl
 vWwIcwJ+L9irkJBg==
Date: Mon, 11 Mar 2024 12:47:00 +0100
Subject: [PATCH v3 3/3] docs: add test for firmware.json QAPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240311-qapi-firmware-json-v3-3-ceea6e35eb4a@linutronix.de>
References: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
In-Reply-To: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710157619; l=892;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZTPnmxO3GaQAbwRnHrwYEOYFCggyLqxrMW5WVuKlvxY=;
 b=k9ddL7p/xeTXn+KMCe4E3KSByLVc3b/hKSMaRM7vfxSx+mM6O6fIT/Je0t3StXkoa1RHBi2ak
 Rfsp7CJGyGmAXROtgMQjIcSmzbEFzbBBfPysvJYkqOllKS9fcNG3K8r
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

To make sure that the QAPI description stays valid add a testcase.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org/
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
2.44.0


