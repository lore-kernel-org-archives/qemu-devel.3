Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB04D18129
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Mxl-0006G5-46; Mon, 14 Oct 2024 11:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Mxb-0006EV-VY
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:17 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0MxZ-0000vB-2E
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:14 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a1b71d7ffso85833366b.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728919571; x=1729524371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaYY9X9pUCStJ66Iupj9x96nWBsnt7lR9iGUBryB4Dk=;
 b=FbX3/CUWJXb07XxPUSz0qAYWJ4C/mAjdr3fE8509XcYtqv1tXU2kJvEZA/5gfIBo6Y
 +QTZVc/Kmlyn9nMgoLudRWeTh3x8eqP+drjKggpIjtPzyd0R7fsz0hM05O1iuUQjdMe4
 Ga7Ky5e6088uGUtie6YXE1ppJk2dUVSfvXWiSFMV/AfvJSFqTq6H/ErMxP7yMYw7CsM8
 Ayel2IKcTmmF7iZ+X0fiaQECH/ICChWgjgyrCblvMlOVxGTj7HkGkmh2H3dcTU1Jk1/A
 lOisBVTBA/tDuGZweBNbui9NwG6UQTl3rM4uDD30jOUFzKouJ9bUJmEci6Gip3JXM3rw
 MyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728919571; x=1729524371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QaYY9X9pUCStJ66Iupj9x96nWBsnt7lR9iGUBryB4Dk=;
 b=KW1Vedcsq50Hl+1xhl9cGHi3gp4DU3OUoLUxIGS/3jNV4WlgS7FAPLPsJNaQXfsBJk
 Izwuk7/fyfBtHMyvv2iS9M+gz4kBqv63tWggnocSzaPWQfk36qUuMPB+tx1CQCRzQkCt
 MsZq70PFeLiB7o3NT0OWYWdEP7aTgJ9ior6U5bhUfzqOYQGaYOsvw3dU0eGiEg/uG8L5
 v3n/nZPbaGhcl6weyHjeBklSfPZo23ao6XXWd4UalCQ0DFJq0qEt77gZgb1bKUdxJL+e
 fRHFyZrTYgkD8sN3V350BtGklmVJU28/myZnaLkEpt8g6X33QgIyqIZr/cdSSfNOJFix
 kJmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpiGzhYorlXMsEqhPovHpuJDWHy/ket/njGdUt9hrYUmyfpePw6mGp2+3Ev0GHmmO4uVYu2i7p+5IE@nongnu.org
X-Gm-Message-State: AOJu0YxrJ4k3NPzp7RxD+eA6/AGS6mdzVCs+15AZv/B43JcaAX5wKOdP
 0bzum/V9Tmwu2BSj4gALDsAm4BkCH3o0LyZLnFcLZX/cC0urVO1DWakP6g==
X-Google-Smtp-Source: AGHT+IHhinpAKBW8vGpg7qbPB9tX9QFXI2Kt7wpctCW6olsndY28fNtMmaG3cAD0OYHvuVjlUtrSqw==
X-Received: by 2002:a17:907:9806:b0:a99:497f:317 with SMTP id
 a640c23a62f3a-a99b95fb02bmr976014266b.62.1728919571168; 
 Mon, 14 Oct 2024 08:26:11 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a13396603sm133689966b.169.2024.10.14.08.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 08:26:10 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/8] chardev/char: fix qemu_chr_is_busy() check
Date: Mon, 14 Oct 2024 17:24:01 +0200
Message-Id: <20241014152408.427700-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014152408.427700-1-r.peniaev@gmail.com>
References: <20241014152408.427700-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62f.google.com
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

`mux_cnt` struct member never goes negative or decrements,
so mux chardev can be !busy only when there are no
frontends attached. This patch fixes the always-true
check.

Fixes: a4afa548fc6d ("char: move front end handlers in CharBackend")
Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index c0cc52824b48..f54dc3a86286 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)
 {
     if (CHARDEV_IS_MUX(s)) {
         MuxChardev *d = MUX_CHARDEV(s);
-        return d->mux_cnt >= 0;
+        return d->mux_cnt > 0;
     } else {
         return s->be != NULL;
     }
-- 
2.34.1


