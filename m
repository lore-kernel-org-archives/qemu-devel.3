Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F86D3B996
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3yA-0000r0-It; Tue, 09 Dec 2025 15:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3y7-0000qi-GC
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:05:55 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3y6-0001Hk-1n
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:05:55 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso80284935e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310752; x=1765915552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2HB3vg2EkQ9yT72tK5H3rWvhcfCnwT+b44I6/a1Vbyo=;
 b=fg6yAhiTBqJ8y75iiMJex2HCXBasvqNQRWWmqk5+JIvYzyRPjsDxuXCBV/tDyXkbrV
 n7/uCb6Cf1p3AKM1UaPsXNt4EzcCLTkS/lAXimi6EgzA2WCZxOkLYbTCnp795bEmit7O
 aPkkqXb+GmNdZGofvaAVuo8QBSnyDvnnm2Z8N+EJ3GHr4phnconNfl7NrOjq7h+U04ls
 ehjc2g5GDkmtKvdFMV0bX89zupiR7dQ3oDDsHqpzopMFmvrv6Am8sdls107Gtz9cxaMN
 whAL05FIZKuT+eQ3xOAGCpHU4sOenhPryh6WSvgPZXZbxZI8F+cudD8mci3pC7tI/Ibt
 5MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310752; x=1765915552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2HB3vg2EkQ9yT72tK5H3rWvhcfCnwT+b44I6/a1Vbyo=;
 b=QEjwD6HD5hstdrxy1LmnndXzDUj0FRdMt2LWN8f17uGJeHv0AHcbniu3ekf/8GvZGP
 3xHNO32lKoRHeTF17zUWHJYjooWSnkKBm+Izq5ubihdxS1bSEnX7g/fCmv9NsDC5+9eX
 dL39lTe4ERW1QEganSOswxlJDZIKgKtVWFJkNBzUWPA4/iM8ENeIHy2E+RKq1fkbTeJK
 JlkrxG4LHYlFyrAZozeQSUw8bZ+sLzreAB1RfXIJ2zv5o9OXMIXJIml33WAHt16wyTq9
 86ZRurcvw14lR5JnHapHnogQGb5BO/818nz6tKJfm8jKsI2jpXGgA1PZDbdsCOZDXVxS
 4Ssg==
X-Gm-Message-State: AOJu0YwkcUS8hfO3PyzLBh9FWgnuEKfP0S3BqZNTOi8JsGL1Bd+t1ztz
 /U6PIL0vylT/KU7tRRJBC/6O0/WW4W6amYYl5aKNlKtocjFsfZfPCEjpi0w5XMUbB0/KdbHOpe4
 mvmnqKk4=
X-Gm-Gg: ASbGncufS/a5E4RZgGp2EA8nvEj2M+76hOk03SQE2SvfD3zwH6YQqnE8yAzB2pA6MBB
 Q41jXVLCWtsUwN9tkE8r6mulGptl1aHq0HLriZ+if7/UUc5OWo2Vd56HzbwkSgahplXdiyTQi92
 Nca7/ytZ69n9npsnoMrkvwdV8XZG6GMWXQG9qTiXADPQOkgDRjJo1nXGqb+nFfgI+N4aMzTYwx7
 uLi5CCGYoCzZHx61JERcAN97kR4LkVFtLCxFtlh/X853tfx9eqACzpSuyAozovSpEHzSm734Pgg
 YCmDL582jTkGK51R3+DmA/W1Z4a1sdSw5It5+ed3HlXxUYV5a7fNj3gzXW+exivrmRSQLTPBvAL
 Y2B1xerbvLSswNm0oz2VeWZ+LMRQH0723zgan4nGqngT6SGqPxBSxoBUAFRZp2UnvocpoN/gKJI
 wGgmT2CW15fBxNxdfJ5X43V56YDt4KBlq7Q4rqTwY6k4nktvJsyULGsXrnVpOA
X-Google-Smtp-Source: AGHT+IEa6Iw5zchbaYwHB3IBTlt38CXAVaJIpbUXld5Wl842kKXvQK8l2M9aASaA5vL2wfAMLZXBOg==
X-Received: by 2002:a05:600c:a48:b0:477:7cac:508d with SMTP id
 5b1f17b1804b1-47a83814829mr697825e9.16.1765310752026; 
 Tue, 09 Dec 2025 12:05:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe9032sm31371921f8f.1.2025.12.09.12.05.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 12:05:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] hw/9pfs: Correct typo
Date: Tue,  9 Dec 2025 21:05:29 +0100
Message-ID: <20251209200537.84097-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209200537.84097-1-philmd@linaro.org>
References: <20251209200537.84097-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Alano Song <AlanoSong@163.com>

Correct comment typo in xen_9pfs_bh()

Signed-off-by: Alano Song <AlanoSong@163.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251202132132.17636-1-AlanoSong@163.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/9pfs/xen-9p-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 79359d911a7..ca0fff5fa9b 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -310,7 +310,7 @@ static void xen_9pfs_bh(void *opaque)
 
 again:
     wait = ring->co != NULL && qemu_coroutine_entered(ring->co);
-    /* paired with the smb_wmb barriers in xen_9pfs_init_in_iov_from_pdu */
+    /* paired with the smp_wmb barriers in xen_9pfs_init_in_iov_from_pdu */
     smp_rmb();
     if (wait) {
         cpu_relax();
-- 
2.51.0


