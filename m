Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2E8EE57D5
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqit-0007eH-Ib; Wed, 31 Dec 2025 02:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqis-0007d0-5C
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:22 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqip-0001Bl-I3
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:21 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso12528001b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166458; x=1767771258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pu2TYG/+F91diJrA2qUvqaX2TgetOgZbJlelL7PNoU=;
 b=g6sTaYOeBZQxsRFtilZMkS24g6S8XFxu+4/Eq0Vv65QAK882ItxO6Gqz/M1oJhqpho
 LSHJTaIK65xOlXIjisz2zshJ1LvXeTK4Ia8nQgykrKO+MFUl7+lh4HFPzAznuHYUHDPe
 PUo8fgN1Km4Syz0V5KVm4DZ678Upj85Z1nonjjWbJIDI549IrPuIRFhT7xkRtkY5IGcZ
 DLLxP8gEoKVbpgj9skh6MGemGf8+Y6UmOL3iip9tIvkRj3JxcUPKdth8DeBUFNEn4Fs5
 x/DR9GxoNuKvab2+IQIEjMV1rpRJ1/PaNqdD3hQM/T1EdO0zuwxKUZhM7IrH29fGyhd5
 b8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166458; x=1767771258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4pu2TYG/+F91diJrA2qUvqaX2TgetOgZbJlelL7PNoU=;
 b=dPhjlwMjemgQWQbmqckeDzMs0J4x5ip2MSWDxV73seGDZhGX+osW9wD1tCt1CmD2/N
 YzhmWgDj8k+u5jjpmfPSIdEDRcY1sJ8VKjnrZcg8YCsnf0X3ktF4xCL4tZr0fbEYZxqi
 YHJKDqA42CVRY9Rcb9BqvBN1IFOkyRj/GYTVxqUzgUGOwNrbz4Crdiy6IqfaFS6XGBhV
 zw+VVnXmyAwWx8pnu1+Nonb8ebAY0y2cfZJOhYWZ4vSCZmK1kDxpItCl5QO9QJQolxTE
 i49LgvIp2pp33vfuEUiLDGOaVbNyqIz77CL34YfW2uqqutoTe1iW6yQ4J/0bxF2DVSyo
 Cevg==
X-Gm-Message-State: AOJu0Yypq8svIfv1pwujKFAWozmJsgzxetdOVdO1sMNbPIf0ZdoR3Ent
 bk9CzM6yEwKQ1mYuiTGpmhAgIOniPl6FxMIl/esnSuU9w072u0jJyglexeQSoAmA+K18BHG/pDH
 rR6zu
X-Gm-Gg: AY/fxX5teDZ4omYt7gSRZD2sq/2Ly5OcEG5C3BJ/iv6FQcNnnU/VxC34114vxHxrKiH
 hmuKzSB4lUUnteYNPssmfogh/OdDfDdHJpMiI77TC+WPbw0tCx2ufyJmaaQfiVm6bG6FdQo+NOC
 vzMtwaPcNg3WKaQUBkxUEBJmrTnQqvuSWoLFS3X2DHe7EQ538CW2mFUanLGTnQw/f6agHD0Zvu8
 bsJfJOEkWJhOaahK6/CvQHXUKQZNoltIUKcre5zLIv56PZHNSqkfu2MTr3gCHllMTYyFxnaWUJ9
 k5R8U+xa4QYPPHCMbUIcNtxOV5RDL1J9nylVbYzWQZV4YrGL59Z+TkDtTr2rkXr7ymq0sBZ0ZmU
 LM2cSFYsFWW8djNfQ4ZuFDykvYuX31jYR90a4E068re7siSGyvKThABjy+CeHv5rxSDgmAFcCEJ
 ygIMYvvsD0PmhJ9cR6oZZRtU4e3VR58FiBJ2Fdbjowt9Y6Zt+uuqc3Lll6u7/4MxaS
X-Google-Smtp-Source: AGHT+IE7PO8Dw38NSjBDK0GezpRbjNyt552i3Ha5VVy/uzXzBAr8IZZTHZhE435Ly19qsIlyhxA2gA==
X-Received: by 2002:a05:6a00:8017:b0:7e8:4471:ae68 with SMTP id
 d2e1a72fcca58-7ff67966c94mr28142616b3a.52.1767166457968; 
 Tue, 30 Dec 2025 23:34:17 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:17 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 09/11] qga/vss-win32: fix clang warning with C++20
Date: Tue, 30 Dec 2025 23:33:59 -0800
Message-ID: <20251231073401.2097765-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

C++20 deprecated such constructs.

../qga/vss-win32/requester.cpp:380:32: error: bitwise operation between different enumeration types ('_VSS_SNAPSHOT_CONTEXT' and '_VSS_VOLUME_SNAPSHOT_ATTRIBUTES') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
  380 |     ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |

This is a false positive, since VSS_CTX_APP_ROLLBACK is not a value
defined in _VSS_VOLUME_SNAPSHOT_ATTRIBUTES enum.

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


