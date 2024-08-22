Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E62EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 12:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh6qV-0007wT-CR; Thu, 22 Aug 2024 08:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sh6qT-0007qM-Rs
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:23:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sh6qQ-0004cn-RJ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:23:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428e3129851so5436865e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 05:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724329392; x=1724934192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fuk1+Jjiy0dwyOWZxHuc1mCwVnRsvW+sH5qBxImq/Bk=;
 b=cBEndfJ0bifdcYbK1LlNLyt5LmLcx3DKPmReAe8kmaWSdZjBvpyWhuZLbcGjVgZlun
 qY5jRsSCk9cd/vInABAhLUVyj7M8N5Qmh93b5eBJpapvCRDT3EB32jbhwrIAtP2zss9v
 e0NHELBfkaF5hpcKaa7cDcuLf25nnQhNwoGB/b5wPh1fhnC+TvkHwaf9g6bP+pxvSG+y
 SNzXi8r7loHyYEyEa6dchnnlkh3HNsEF6KV5JYkpNDxtyO7h8cWrC6nDedftjyshJPio
 OAEGMYrAb7vXwNkWcSShWdp1nk4N5nQYkNPK/BDgRYWzQxEzSQI3szF2NeKpjnRk9stR
 t7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724329392; x=1724934192;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fuk1+Jjiy0dwyOWZxHuc1mCwVnRsvW+sH5qBxImq/Bk=;
 b=aHASQPdAi/pywbJOmWsAbvpT22XZDQWHyeRngq31MsnHc+0EJy+0ZYcbHblLvQwtU3
 IT4iaxQFDVgANoh31dXBWUUkSpWdkegKezA6YeyK4ZXlY11i2ZMowVj960muD3rA6Q+e
 sJJXAYwFCm+qZI1ueHJfRZbqUVCL4ag/pqQmgBBqc/qH0vWONcuwAO2Fosnh1SJyH5rM
 tPfjZW1oHQfE6sENZzmi5F92ind4QNwApQrEeV/F3cF6H3jM29uQG+8/8enlgmURYwFG
 MKYzJ36PRL6PVtnBW9mdiVIL4GZJpj3GtZqvX5uM4nKiXCo62d+vMLPJMI2OLB++Mq52
 Z9yQ==
X-Gm-Message-State: AOJu0Ywy4QIV4uu+yfRENk3PgIewtftt1Jxq+b1KY+h1zngQdYrpC5Gr
 mTx0JXNMEFHlK7qUSF0yCmaa9koAp4VP7scjVMJylgzagnDy3rEx5YFlk0PO+Pxq8gcItVhFXsa
 E
X-Google-Smtp-Source: AGHT+IF6YS2mGnPXckMTmnpj4hu8n5cKjYW9vki6Bj5woscz29+mODcOuEvbvubjOv8XGqytI1Fc1g==
X-Received: by 2002:a05:600c:4584:b0:426:6551:3174 with SMTP id
 5b1f17b1804b1-42abd2458fcmr45245605e9.29.1724329391592; 
 Thu, 22 Aug 2024 05:23:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac517a65dsm22757685e9.34.2024.08.22.05.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 05:23:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
Subject: [PATCH for-9.1?] system/vl.c: Print machine name, not "(null)",
 for unknown machine types
Date: Thu, 22 Aug 2024 13:23:10 +0100
Message-Id: <20240822122310.561885-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In commit 412d294ffdc we tried to improve the error message printed when
the machine type is unknown, but we used the wrong variable, resulting in:

$ ./build/x86/qemu-system-aarch64 -M bang
qemu-system-aarch64: unsupported machine type: "(null)"
Use -machine help to list supported machines

Use the right variable, so we produce more helpful output:

$ ./build/x86/qemu-system-aarch64 -M bang
qemu-system-aarch64: unsupported machine type: "bang"
Use -machine help to list supported machines

Note that we must move the qdict_del() to below the error_setg(),
because machine_type points into the value of that qdict entry,
and deleting it will make the pointer invalid.

Cc: qemu-stable@nongnu.org
Fixes: 412d294ffdc ("vl.c: select_machine(): add selected machine type to error message")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Tagged as for-9.1 because this is a sort-of regression since 9.0
(in 9.0 we didn't try to print the machine type name at all in
this error). But it's also very close to release and this is only
cosmetics in an error message. The cc-stable is for the case where
we don't put it into 9.1 and then backport it to the 9.1 stable
branch after release.

 system/vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 41d53d2456a..01b8b8e77ad 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1679,10 +1679,10 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
 
     if (machine_type) {
         machine_class = find_machine(machine_type, machines);
-        qdict_del(qdict, "type");
         if (!machine_class) {
-            error_setg(errp, "unsupported machine type: \"%s\"", optarg);
+            error_setg(errp, "unsupported machine type: \"%s\"", machine_type);
         }
+        qdict_del(qdict, "type");
     } else {
         machine_class = find_default_machine(machines);
         if (!machine_class) {
-- 
2.34.1


