Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBDDD5C0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 12:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9OQE-00032U-Hy; Fri, 08 Nov 2024 07:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1t9OQB-000325-Nb
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 07:49:03 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1t9OPy-0005c8-GQ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 07:49:01 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9ed7d8c86cso369683466b.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 04:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731070126; x=1731674926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6iO1dqaywxT8CPAhDVXsK0nrcQnuw8CHBfX/z92jgc0=;
 b=XTsg4NazhKwdeXF966l0F79j10acjyn+ipTa63kY5gxWwEz7BYe84TsSm9TWF6v+N2
 O8m4cFmCaOJbrCZsZlMgIa9GPVdCYp3b1f66aaUOF4OqXxKBoVnNmIqdoruceNTbMlpt
 gp6byOeI/T/RWyCIEMt1gcR+FpgYhZ8XtKAOtWxEZVZlqc46yBCx4tWP9xs8HzOap8wa
 pgLwaLj6cb/UJkPBOKuPjqYsq4L9TPDz8ojI0jRbT57qYnpiH5rOtzg4mOLYAo0R1eC8
 LmAHZLyG9/iZ4O1v7NgkRwBYVXzy3/d2LyvlhoQVEFzvO8enJbLYkcGX/TLCN3eJd6SF
 Do6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731070126; x=1731674926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6iO1dqaywxT8CPAhDVXsK0nrcQnuw8CHBfX/z92jgc0=;
 b=kmEd6gb02Vvqxjj07dogQd+ejQ8czN5Ifyjs0vK5jyeEOIXHmToZUPkUUUmzzhTxvZ
 ToIJuwopNJ3Bt5h/dGc1QtrvqXqWbZe9IgfTkPNxUkq7i/dX1aBoT9Cchg8IsbFk1sgs
 k6upT03yCkophYOCd3sFA6gAW3P4Fh2YwSgoLt/g7SZRrcUXVoqK/YMYweV3D8p3uWaY
 yCuiAYtT43nFaTvBnGyQddHLtHKwRrZ9ZB5Z06lv5PrWgSw1CrMcAc+CRGDQtU6l+d0C
 GfL2E0xFlNGgPPh9h84z/JsqJ99gQaaUVJ72cTIgOqgV6jzitMP//DJPsuJYLVrT2Ha3
 AhhQ==
X-Gm-Message-State: AOJu0Ywbx+q0ekPaZcZImbcDu3BDfeGuy0Gl7wQ6svAPKWdUuq8K1Onu
 /3vm84YyyAvhIUTeGEyyZADSDjWHC+RoLS/UzcgbjbEy6JEc7TZvbXqCaw==
X-Google-Smtp-Source: AGHT+IExsOtLppirx43XIfOgfAE76t0mUbdL1IjNwj4XqFzSb6/kvMzjyI21hJoKp/ToJ+x7cWk/aQ==
X-Received: by 2002:a17:907:7243:b0:a9a:49a8:f1fa with SMTP id
 a640c23a62f3a-a9eefeed031mr248051466b.23.1731070125559; 
 Fri, 08 Nov 2024 04:48:45 -0800 (PST)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0df39e2sm226170266b.168.2024.11.08.04.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 04:48:45 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/igd: add pci id for Coffee Lake
Date: Fri,  8 Nov 2024 13:48:30 +0100
Message-ID: <20241108124829.92893-2-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Corvin Köhne <c.koehne@beckhoff.com>

I've tested and verified that Coffee Lake devices are working properly.

Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
---
 hw/vfio/igd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index a95d441f68..c5282827ec 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -88,6 +88,9 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x2200:
     case 0x5900:
         return 8;
+    /* CoffeeLake */
+    case 0x3e00:
+        return 9;
     /* ElkhartLake */
     case 0x4500:
         return 11;
-- 
2.47.0


