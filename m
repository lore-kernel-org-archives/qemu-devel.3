Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C3AD3ABD0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 17:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAXpW-0005vu-8e; Mon, 11 Nov 2024 12:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAXpP-0005ut-Pv
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:03:51 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAXpO-0007hy-8P
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:03:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso59938345e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 09:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731344629; x=1731949429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aswoOKXvIzBRThw5Im2BrT+a+DMSnACXRZbpsdUuO5Y=;
 b=Cg4eMBivePnketDBT9lL/asao4W7n6JHmVun+i26PH/N85TD4ac7EsVRfQSTHpyNNV
 y/BWlQM1gjzrHJKeko6sjlcfibJxotZ9aMbAIW2thnjV3yhHu+zTifYQkCU7o591cGOT
 RZ+WG1cBoA19Y/dq+dFTPrXBInpUBQJi9OUrvPfjxOsaSYO5XLJEEsxLVabpCM9uE9+N
 Gzif1bclBsBWvAZZLZxFOn+tN0TKfwrTyG9DUdRwre1SI30ttGuucqUX3ZdcAVAXClvL
 6QM4OEoH1nV5tyhJlDqGiRgKtEeAH94zb7tr+JSNnxh0agL8K8UAGkD26SY7Hh4xismx
 eoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731344629; x=1731949429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aswoOKXvIzBRThw5Im2BrT+a+DMSnACXRZbpsdUuO5Y=;
 b=JMYU83cNW3ukD+rmAgSnYWmLEBTO0C9gNkek8leQiZWau8PGdQ3ASb4Mll+XIeEPyI
 xgPltT9RNATjP05mAVmZY2+X5urhSrTwi6mx+U8r7NIUdC3FUfNv5KN2DcnIGkElLKoO
 1K3GdgHFY9aJnRIKkBgGrxmA9OWH7sS+hmC/TljWXMmHoVSn/oCE0jauTF0fsverUsvc
 Gr7KosAJ/9oZFlC/yUeqy5frMWYghvI+kchSHa82RY1sLFyDutfnVvNsTnGWfyvehAAc
 dyW5ZCOMvQbCe28deXarl7boMWsn0ebrWM93SOuz+oIArk8WI2CPIBvNREv+wuBolzDU
 q5VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCD0b7wrnUEv3QMGLd6/w5OABwGtkDnIxp5orv3e3dMrhTKPobLBk9CtrwRNbwlj39Hch1HqUBGab4@nongnu.org
X-Gm-Message-State: AOJu0YziVGma0YHv+Wjo3WZIQEyeGvoEYPPsmhlXghhnPA8tE+IYsBqG
 2mqDZr95ms3wzzwwIFSDn+WaalzFBgbFCvXsAt6rvkQm0Gu14149Adi5nfyYMvE=
X-Google-Smtp-Source: AGHT+IFyB1rBJo9m1u2KgkUHXHd8dtIfcGq35meJPcGKk1gaswaJ/5OlR7o4b8T8XeMOdCICssJ5Vw==
X-Received: by 2002:a05:600c:524b:b0:42b:ac3d:3abc with SMTP id
 5b1f17b1804b1-432b7518c59mr141503645e9.24.1731344628453; 
 Mon, 11 Nov 2024 09:03:48 -0800 (PST)
Received: from localhost.localdomain
 (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr. [176.184.43.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda04049sm13204861f8f.93.2024.11.11.09.03.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Nov 2024 09:03:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Fabiano Rosas <farosas@suse.de>,
	qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] block: Fix leak in send_qmp_error_event
Date: Mon, 11 Nov 2024 18:03:33 +0100
Message-ID: <20241111170333.43833-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111170333.43833-1-philmd@linaro.org>
References: <20241111170333.43833-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Fabiano Rosas <farosas@suse.de>

ASAN detected a leak when running the ahci-test
/ahci/io/dma/lba28/retry:

Direct leak of 35 byte(s) in 1 object(s) allocated from:
    #0 in malloc
    #1 in __vasprintf_internal
    #2 in vasprintf
    #3 in g_vasprintf
    #4 in g_strdup_vprintf
    #5 in g_strdup_printf
    #6 in object_get_canonical_path ../qom/object.c:2096:19
    #7 in blk_get_attached_dev_id_or_path ../block/block-backend.c:1033:12
    #8 in blk_get_attached_dev_path ../block/block-backend.c:1047:12
    #9 in send_qmp_error_event ../block/block-backend.c:2140:36
    #10 in blk_error_action ../block/block-backend.c:2172:9
    #11 in ide_handle_rw_error ../hw/ide/core.c:875:5
    #12 in ide_dma_cb ../hw/ide/core.c:894:13
    #13 in dma_complete ../system/dma-helpers.c:107:9
    #14 in dma_blk_cb ../system/dma-helpers.c:129:9
    #15 in blk_aio_complete ../block/block-backend.c:1552:9
    #16 in blk_aio_write_entry ../block/block-backend.c:1619:5
    #17 in coroutine_trampoline ../util/coroutine-ucontext.c:175:9

Plug the leak by freeing the device path string.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241111145214.8261-1-farosas@suse.de>
[PMD: Use g_autofree]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 block/block-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 7b329ff194..6128012953 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2138,10 +2138,10 @@ static void send_qmp_error_event(BlockBackend *blk,
 {
     IoOperationType optype;
     BlockDriverState *bs = blk_bs(blk);
+    g_autofree char *path = blk_get_attached_dev_path(blk);
 
     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
-    qapi_event_send_block_io_error(blk_name(blk),
-                                   blk_get_attached_dev_path(blk),
+    qapi_event_send_block_io_error(blk_name(blk), path,
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error));
-- 
2.45.2


