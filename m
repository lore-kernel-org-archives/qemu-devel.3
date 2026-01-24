Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8F5D715EE
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiOF-0004Q9-Bu; Sat, 24 Jan 2026 13:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiOC-0004OU-Ih
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:40 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiOB-0003it-2H
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:40 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8230c2d3128so1252883b3a.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279378; x=1769884178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAwgkxcCnnqe9jCM08ttRZ7hAqumVGJ7T0ER05F6LwQ=;
 b=O956HxEZfSPx8GCvnPSsJwJxxHSVmLD/iYV6cRktl32P2eBBI44CVs89BAqeLF49tc
 sA7gaUCFXz4+/wwHZ711hJfnsFztrvh9A8PjhwtLLkx9a7fHmV5B8gBcHh8t51p+lTKu
 uODrRjGauh2T27X5Cn0V+qrNA3HBfXFUyi/Us2ymOPVNFYlT5s4S30qp+aCdMzC9D+Os
 SWBAI0d8xfXWORgQ4dSr8b4T3kf4tjtjCjptwY3oHR1bYYAObK6/lS6JgY19QSohyN88
 WJHPurmA9RcFIJwyazqDNH4iAmCn2eCQU1WpZ6Y/nYNJ+Db7sx2gvVdrLgfHey477aQ/
 +hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279378; x=1769884178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BAwgkxcCnnqe9jCM08ttRZ7hAqumVGJ7T0ER05F6LwQ=;
 b=imhLPWWodiXLW8VaWGhEQ9okPpER7OvRG2SeMbiTISuQvnXE8j4X4Fu+3FuuFwATiM
 C7Fcpum9eP5fJZo8XkgUn7YRUFd83+3HGg9KQVOsbWVwe1F07wRBPqTlOdUfruKmXshp
 IhWvrevmOIi/boCpTzRE5SJGKyJGQlGccVrJv1I/EiiAGX4MnrqkMc5V6R6XiW8Vsz5Q
 j24oTUmIh0N7vV9mApdT3YMNECGQxjZiwL/pubyWIrEFSmLkLuZMbM8D/ctRUFPSm9iF
 XGtaux9tsGnMEKuSI01nZEZb+tj545ZD+p4Ro+B9LPJ3DNg2AnuWJoedwyanmOE6BMGE
 pnrw==
X-Gm-Message-State: AOJu0Yyy5nnfMdEgLyDTTtl4EPChmDZAD/9ZStr813Xr3decBo4ObyEk
 LP73WZd9uHx6BAgexh5a2kKaedTmS1AjLQ6LB/R0VymUTlov/e02/H4xwYPwNiTa6w0mR+fmgbY
 isnpAygc=
X-Gm-Gg: AZuq6aLVzxM7eKCwYXd9OZtUG0NkNpzXIykwA8JYmAzuCywSZzRxqwhsNuj4AyCNazN
 uKQR7JeBc9xZP1SY+OMkZSC5Qoi7KMRpoMh/z/P5/tffHt7AvwwZmmjVh7oREWNYlDa99nf95T4
 KyD/kRQn4BneLAgdhfUTYWfc/IjEHaD4LD+/FzcHcGPwTa91UcdDJRi+8gesiOaWZq13cfhnL1F
 QXduy56Ev+WJ8CNVswgt/5QT5VgaegHZAJ+EvkSc6brXLdSmzN4wB3+uySEBeOeOR1JY4JMJEdA
 qWQ0fpY90guKnWy6rOEfZ9mEdcquUKIZ+QdcZ43znT5F8gyexLXNP80qG3AaTQMNePlVKLObtYb
 oBNAh5z57bbJjbqi01ZQsKqxKtOTJC37aRspb3oZ8EyGXY36tOqkIHfg/Zqr7/RwBkM2HyslWin
 +kjsK4TsGankiBVkRMBqgf6U20N2ctuiBh9wyq1bA8ZKrHJgS7fSH0ZyBEvawuXE7/
X-Received: by 2002:a05:6a00:800e:b0:81f:7db2:89cf with SMTP id
 d2e1a72fcca58-82317ea4fafmr5626890b3a.39.1769279377703; 
 Sat, 24 Jan 2026 10:29:37 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:37 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v4 09/11] qga/vss-win32: fix clang warning with C++20
Date: Sat, 24 Jan 2026 10:29:19 -0800
Message-ID: <20260124182921.531562-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

C++20 deprecated such constructs.

../qga/vss-win32/requester.cpp:380:32: error: bitwise operation between different enumeration types ('_VSS_SNAPSHOT_CONTEXT' and '_VSS_VOLUME_SNAPSHOT_ATTRIBUTES') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
  380 |     ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |

This is a false positive, since VSS_CTX_APP_ROLLBACK is not a value
defined in _VSS_VOLUME_SNAPSHOT_ATTRIBUTES enum.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qga/vss-win32/requester.cpp | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 5615955b6f3..74489fcd0ae 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -377,8 +377,10 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
      * To prevent the final commit (which requires to write to snapshots),
      * ATTR_NO_AUTORECOVERY and ATTR_TRANSPORTABLE are specified here.
      */
-    ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |
-        VSS_VOLSNAP_ATTR_NO_AUTORECOVERY | VSS_VOLSNAP_ATTR_TXF_RECOVERY;
+    ctx = VSS_CTX_APP_ROLLBACK;
+    ctx |= VSS_VOLSNAP_ATTR_TRANSPORTABLE |
+           VSS_VOLSNAP_ATTR_NO_AUTORECOVERY |
+           VSS_VOLSNAP_ATTR_TXF_RECOVERY;
     hr = vss_ctx.pVssbc->SetContext(ctx);
     if (hr == (HRESULT)VSS_E_UNSUPPORTED_CONTEXT) {
         /* Non-server version of Windows doesn't support ATTR_TRANSPORTABLE */
-- 
2.47.3


