Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E96C44503
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjgj-0007jj-T6; Thu, 09 Jul 2026 04:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjge-0007hr-My
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgc-000891-UD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso5228285e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783584045; x=1784188845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C70+uWMIPFlVAoXFJOb24D4T9JBIOgkKt64Wojdhw3s=;
 b=SC49cBmDLFUCK0nYppYWUmeE6itn+Rjasrc1nkQc4I2MQmetZGKmduhPTv0YusxOOi
 8Do8ruXMotkTrj7VMuFUZ5piFMBOgltOCHbZG+OnDHHkU3/z0iThUGW9aTtZOOSyQu8p
 CASHaqDy1ibRklS0OqYkzspWR7XwJR7Nw3jFu7hpl/diQxUcplRGKdU7g6yshYL7EcWM
 l9iZALpE5PhkUc/0sRdRthG5bZ+YmayQeTjdMepQCPbquGWHqZ3f1a7z/PN9/SV0gT2k
 gRRN3MW/bs+Ks0BiHR+6i6HJwDFifM8pZXVZYwf9LsBWkxG9NMvn+o2b83NFzFK2KgBv
 Z7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783584045; x=1784188845;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C70+uWMIPFlVAoXFJOb24D4T9JBIOgkKt64Wojdhw3s=;
 b=ne+cWVoridnNqGQtPSm9eyUM2W+5zGTQ3Khj4WIR6100RkajM1q6btgQ9O7CYgiivN
 twmzRWVZzDGV5Jk8/+9SA0gMd6R1cvDtWwfbrz4Q9ikwZe3Gn3/A4LM0KZ7zVG2oUMfY
 0ObHhHyx4TygPh8OQoSez8/kur6A8zvaCSRMREStqzW7cRb3BLgVJv2ZlW95Pb5/Sjao
 OEe/JiPp7AV7/LBWJhOzArbxPe7cR2Url4MX0jHOeaH5LriAvhdPsjwvQx+nNrXui8rk
 LUfQrR70/qnqb93NhCl5ujTkWUOMc2HmBQoMdqcKwO4cvZyBCa7PJepLRKITdfET9oSK
 z3Vg==
X-Gm-Message-State: AOJu0Yzo3Wtv9K69uP5t6YNuplZEqj+0Z/TXq37YStGTuAnyMum4zntb
 actF/POoxi1/CxIPXU1Onvhl//O98H9c0qwltbaf5tOZcAQsXlmdZoKQFU1uCVVUYMG5bGVFHCa
 p+Yyv3JI=
X-Gm-Gg: AfdE7cluL543v6/THzFPhItStVsohuDjRgQsv9ToCm+Wkk7vKA16CHkHx0jmU0SFKi2
 VSX98xNt22Ae1HB+O1FUDcG8t03qsalc+w5ID77Os7RfsPiehcFOp+GSIVRtcjm/C1kJHWOGxHj
 xIL3adBzev4IL1uN3SFODjRZoCNmTnwxlypEwF7qeISJvGBKuJagH6XtD1GXNp+MNSaQOqCYiVp
 q6a+cCXh0Ys2kWPov1JTcUK408J7Z1qTR0o90ypWYRVb1tZn631A0Xdq4+sv+QpNYR+eF1C/4De
 mVZEiB3o0lhIiuznTr22r3lWeShZbby2TWdmcLDfIYCPAX9pZ6Q4qd93huIqBqY/H26D1gqfe6b
 nBbs/YeZjKLl8wWCMTfuMfODiMYXleQeRT3Th5Ih5471QWhgzkA4imOhgp5ZP18fqyJEglm3pz6
 P5tGvLBhCzvFqm
X-Received: by 2002:a05:600d:84ca:20b0:493:c984:db9c with SMTP id
 5b1f17b1804b1-493e6898b54mr41240505e9.2.1783584044657; 
 Thu, 09 Jul 2026 01:00:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8f1sm50017820f8f.3.2026.07.09.01.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:00:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 43B555FBD4;
 Thu, 09 Jul 2026 09:00:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 1/9] mailmap: Fix Ryan Zhang email address
Date: Thu,  9 Jul 2026 09:00:31 +0100
Message-ID: <20260709080040.4157324-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709080040.4157324-1-alex.bennee@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Add a .mailmap entry to fix the invalid email introduced
in commit 490a3e1867f ("ui/sdl2: Set GL ES profile before
creating initial GL context").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20260619071422.99061-1-philmd@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 593b6c2c534..7665ea87562 100644
--- a/.mailmap
+++ b/.mailmap
@@ -36,6 +36,7 @@ Jason Wang <jasowangio@gmail.com> Jason Wang <jasowang@redhat.com>
 Marek Dolata <mkdolata@us.ibm.com> mkdolata@us.ibm.com <mkdolata@us.ibm.com>
 Michael Ellerman <mpe@ellerman.id.au> michael@ozlabs.org <michael@ozlabs.org>
 Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
+Ryan Zhang <ryan.zhang@nxp.com> Ryan Zhang <mailto>
 Timothée Cocault <timothee.cocault@gmail.com> timothee.cocault@gmail.com <timothee.cocault@gmail.com>
 Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
 Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@kiwi.(none)>
-- 
2.47.3


