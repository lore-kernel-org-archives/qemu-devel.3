Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1138EE4999
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 19:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vafJt-0000QM-UG; Tue, 30 Dec 2025 14:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vafJs-0000Pv-Bh
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 14:23:48 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vafJp-0002Jb-PF
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 14:23:47 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so8122906f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 11:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767122622; x=1767727422; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o6eKXCg+fwK62FH9L6V3v88MN7/RXYoc42hjUN6L09Q=;
 b=qVJCkAvFe58BAJu4d0vXtEnHfe6BpZkKlN6s4i/ehT7FZN5VyUQm5/CgxfItB0vhIR
 ZUbVVZoDhJ298G0SzFpUcZYxEqqeJ71/4WeZ/diWi9ykB5FAr6huwzSAnd39BaZhIW5J
 1Bsyhb5BplJdLKOTizXhvsQUP+s3a+FrEmWc+UkMKBzjymJk5YVIZTK/BBq5wx6N8Azu
 mXNfRvtkLviJphRcVtDk5dcsGifieaKmjDjrkKRKD+PKq9i5l55KacHrBLXTsZNdAgDm
 eMnpn+ObTf61F2uDa3zUQgFV5vQz0Tljmm4wer9W5rmHT1PjqzPsJLeATkxcAEEvOyvo
 HbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767122622; x=1767727422;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6eKXCg+fwK62FH9L6V3v88MN7/RXYoc42hjUN6L09Q=;
 b=Gck7Ju1l4F/0bhvIon4naoirzlO8ZEVHKXoWEQ8oAiK1LmkjogZ/L79mvPvpxrjZwr
 TAJbCHBV3dOUQ/7l8M7NUwIWDE0AlKKMt6GCrWgb/imcIUlWP5WJUQt3X5em5NZFL/j0
 /B2pROod+7fqObgDU8RFrh6X+YWHGS2mt4ZXnkHt6qYyUhkizDBfTpNMoe2U3SUCYrlf
 S/SPKrptGbVcOAvZYxN8JBlWX8QfvYJ5SP418cEdBoqz6gBGftczliY0/GKqmO6l1+0l
 12XV1b1ecQniBJSLjfwqPfXsvb8DDmFUnX9RNWl2UBq1DrMOMyiEJbXonaqIQYCvQMDI
 7o/Q==
X-Gm-Message-State: AOJu0YxtBc6J3+Wg6m+3DbVJdSIVaqP0WUEakMS0RywxEDDwJDMDO9g1
 3nJiHsOoSWXoUSQW1TjlA3ROtK2R8Vb7c2WmIAD+IWjNy8fciAT1Puc9EbqYBEDl2EU=
X-Gm-Gg: AY/fxX48PGOXARpNfUyyb/psD9Io+qy9TDTX4FmK3hQENv0pCZyjNWUX8FTukOY0m/v
 QWDbmpO7H2yZ5O5imW9ATTnXff0fUf5mLpIGCnWWK/5ikhielXFUWcItsKsbRMTfHaXQfb+xNjr
 vDDyCPapu3n2OTm8Uye07WzefDWGTjzuDqqjlPyglYoND7XusjKukpr0YUzqmnwoFWQg20UuUUN
 RaYblUqa4vGBNONBzB7nYdm4L4uxjYs9BwsdrJPjhXBElVTXfr9uyynIOAr/soq6QRNkLtNuCUA
 5IKGLnwWvPQOV4BF6/ymKu8XJJdbrXdEx3qtwbvvHpkwCWfzDv5+BvlwKoF4tvGeZfpPVMdbByT
 1G9ZLklWTKJwaovd98k2PDXw0Ceq5Keg+jKEqn2BhTm7sbf5F9/B+pMWfflTXm2HGQcrz0cOIHC
 ZY8MsUQ9nVc3ZwHDE=
X-Google-Smtp-Source: AGHT+IFZ4dH8lPy5DrHHXtTwhTP6EKdVN1TQZ6QO8O35aUKmNKDKiXqw21uDa8D4uPmzFXjYYGJGhw==
X-Received: by 2002:adf:e74d:0:b0:432:84ef:715b with SMTP id
 ffacd0b85a97d-43284ef74a2mr12732704f8f.0.1767122621811; 
 Tue, 30 Dec 2025 11:23:41 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:b400:eb32:60bd:1d89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1bdsm69363805f8f.8.2025.12.30.11.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 11:23:41 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 30 Dec 2025 19:23:33 +0000
Subject: [PATCH] docs/system/igvm.rst: Update external link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-igvm-documentation-fix-v1-1-865750a66cc8@linaro.org>
X-B4-Tracking: v=1; b=H4sIALQmVGkC/x2MQQ5AMBBFryKzNgkVhKuIRU2nzEJJi0jE3U0s3
 8/774HEUThBnz0Q+ZIkW1Ao8wxosWFmFKcMpjB1aaoCZb5WdBudK4fDHqqjlxsb21UtGZo6T6D
 nPbLOf3gY3/cDhMIuLWgAAAA=
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x433.google.com
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

Also updated revision to 3.43.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3247
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Just fixes a broken link for the AMD64 Architecture Programmer's
Manual.
---
 docs/system/igvm.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
index 79508d9588..f45eb1707e 100644
--- a/docs/system/igvm.rst
+++ b/docs/system/igvm.rst
@@ -166,8 +166,8 @@ References
 ----------
 
 [1] AMD64 Architecture Programmer's Manual, Volume 2: System Programming
-  Rev 3.41
-  https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
+  Rev 3.43
+  https://docs.amd.com/v/u/en-US/24593_3.43
 
 [2] ``buildigvm`` - A tool to build example IGVM files containing OVMF firmware
   https://github.com/roy-hopkins/buildigvm
\ No newline at end of file

---
base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
change-id: 20251230-igvm-documentation-fix-6a937c2cb9fc

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


