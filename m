Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C024DC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 21:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOkgJ-0000q3-G6; Tue, 02 Jul 2024 17:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOkgH-0000pu-ET
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:04:53 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOkgF-0007SD-5l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 17:04:52 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52e743307a2so5298432e87.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719954289; x=1720559089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eT3tfvANiBCnVaEI91vYtDYUp3ZwZaFuJlrs2Y7RAys=;
 b=EWV5pc+Y+f6nTS3WhoL3J40cJYRudx9V8Yx6ffMwVjDV20/6jMfi8tt/qxDlCmVdIr
 97i6OPQa2kdBJ4ahj1Ub+gYdIhZ9sqpnk0oXw6quhjFl77j+8pbV3yccwOqwuIFXdZue
 1YIUkVUGk3aen0xMgC7L0m6AEqyzlL9uJO2znOE5mnf9XwN1CGfO+K8Ma6r9qkQfC9LW
 Epsh61deBxViY8a88k816WH5A3HxvH6mUQIGXYHoY2so/bopa0arHpvEMko685wPid/4
 JmtG5NsH3EAO4SlqUQbYVvUcnVmoKABUtbHKIn6KRkq+WMsjruVAVw706Dq56Huo4zN9
 etPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719954289; x=1720559089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eT3tfvANiBCnVaEI91vYtDYUp3ZwZaFuJlrs2Y7RAys=;
 b=vCUB3AZGZjSnmmByxbDOrE3hpEKqOzbVxigrvRYpU4o760BtHEV28UXNfkqPNEyPEE
 UTYWWQ1ZASFoWS8CwxIF0g9VVgXzsNp/qABqaIuHOH2Xisc8BKemC+dq5P9ui0EbJXn2
 P5V4Q4bmtPPtRG+dIwVLCbJC1YjrHH1KPY4uHOEx41EAuoh57Gtjxw2ExRk5KnFPyGsl
 wofiTdoCM+iA+hpgQfMdKKY8LJroBUAAC5Qg4X+qVzf7aA7MFyU8L03Pdwn5XaaFwe33
 3LzoRjF7Z6TL3VpPkx2GVoUyQuOctdp6cVwSTsRzBEFTqUYASR7FTZsgmb4ulYprG/G1
 EntQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkVe2IV8uy+v4Ee/ZDHQJWCrD3ezhX/ftynfsv2o+bR05rL8D20aY4UX7YWQOYc2pMu0jWk0CMaJoQx33gZEfxizR4jjo=
X-Gm-Message-State: AOJu0YyV2I07z0ZgXrMV8tDehwDFnAwdOf688T+F4blnkLBH3vcRt8y2
 q3JW1ZWgU6+rgYSWNN+iRdVm+vNKzRtTt1vX5LNlp2J8bWxlrrQ=
X-Google-Smtp-Source: AGHT+IFfubuMZGwIKsoDg218iF3VUMOYt0Dre1P5hI2sMHkYELwIz/OvOj/c4Tg72HCJR/tmytgGQA==
X-Received: by 2002:ac2:4e05:0:b0:52c:d20b:22c8 with SMTP id
 2adb3069b0e04-52e8274a865mr7689154e87.64.1719954288425; 
 Tue, 02 Jul 2024 14:04:48 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fc58esm14337739f8f.72.2024.07.02.14.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 14:04:48 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/virtio/virtio-crypto: Fix op_code assignment in
 virtio_crypto_create_asym_session
Date: Tue,  2 Jul 2024 23:04:43 +0200
Message-Id: <20240702210443.3060881-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=zheyuma97@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The assignment of the op_code in the virtio_crypto_create_asym_session
function was moved before its usage to ensure it is correctly set.
Previously, if the function failed during the key_len check, the op_code
did not have a proper value, causing virtio_crypto_free_create_session_req
to not free the memory correctly, leading to a memory leak.

By setting the op_code before performing any checks, we ensure that
virtio_crypto_free_create_session_req has the correct context to
perform cleanup operations properly, thus preventing memory leaks.

ASAN log:
==3055068==ERROR: LeakSanitizer: detected memory leaks
Direct leak of 512 byte(s) in 1 object(s) allocated from:
    #0 0x5586a75e6ddd in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
    #1 0x7fb6b63b6738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
    #2 0x5586a864bbde in virtio_crypto_handle_ctrl hw/virtio/virtio-crypto.c:407:19
    #3 0x5586a94fc84c in virtio_queue_notify_vq hw/virtio/virtio.c:2277:9
    #4 0x5586a94fc0a2 in virtio_queue_host_notifier_read hw/virtio/virtio.c:3641:9

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/virtio/virtio-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index bbe8aa4b99..5034768bff 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -205,6 +205,7 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
     int queue_index;
     uint32_t algo, keytype, keylen;
 
+    sreq->info.op_code = opcode;
     algo = ldl_le_p(&sess_req->para.algo);
     keytype = ldl_le_p(&sess_req->para.keytype);
     keylen = ldl_le_p(&sess_req->para.keylen);
@@ -224,7 +225,6 @@ virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
         iov_discard_front(&iov, &out_num, keylen);
     }
 
-    sreq->info.op_code = opcode;
     asym_info = &sreq->info.u.asym_sess_info;
     asym_info->algo = algo;
     asym_info->keytype = keytype;
-- 
2.34.1


