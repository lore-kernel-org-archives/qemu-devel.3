Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B78CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeTg-0000te-NO; Tue, 28 Oct 2025 03:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeTZ-0000r8-RX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:50:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeTW-0007Qm-AO
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:50:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4710a1f9e4cso45933025e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637832; x=1762242632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IGrLf5bVKU6CARCMqqRyAEgTxbtQQxxofvYEiMrdKA=;
 b=XPKO/3p2NJk6FcCLN7R6GvSUoRkZwAnOdISpxcatC3TYGSmvtolnPlz325pgzza++f
 UypVmLtvlyvX3KUsbGocMrC7wljhRst2sSxCSxW0S3Ey3h5E0+qhNAiMYyV9oBpCTXWZ
 8tLluOp+q0RHZaJWjZlmDR5ufjZSe8mNa68053d/9L5WDYx0tVUEnA9EMX0X59ceQ+c8
 gKyVYjXQ82DMDBvvaYSFYPyIFccT5JR7TDSuiaKu6v7ADJ0xyNix8rvSVYNVX7iBNCtX
 ORmnoimz1S5gQa+8wPkEIq5olh+HIE7ZgQYpe326cSRzqLgcGSrwH9TRXRPl4wVp3cbg
 p7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637832; x=1762242632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2IGrLf5bVKU6CARCMqqRyAEgTxbtQQxxofvYEiMrdKA=;
 b=uK6vi8kdVkruFzPE4a0zArmfj3iiLEJMu+LdInBYEiKrM6xUTYLzn5vUmKoXSe1Y1m
 rgIqROflrrqPIKacqGDLmqAa3OWjuNCdGE1eNXhBJ5l06xIwfbZYFhbccBUxPY+tLm/0
 998atR+p/V2ZZmU5fCMjl4717kfTE3ypHfGMLLc73vxjjOGPtZLh60dzk0/2OvwkPkxv
 2TgHOmE+F3yNKngIKw+VR3wgQk6VJbGOg3GnyeuuaruvvZ2vfRmASLz9YV5cufaolA9d
 j0PcDZz6VidRb55IDhatzSXoGDbodK9P0Fe4bKMC5yISjMaBglaKsHwsdLhWl4jI8jbn
 E7Mg==
X-Gm-Message-State: AOJu0YwpXPyERXZapwgNqaqPL/1P9JYAodNVgnX5ZfLb20rrBHmDbc5j
 KEZz/sk0A+Nm9mFDcTH/mHKgTiyaNPPjEBJfpHryCJhEXlol9DAWo68j/y1dzAqqySf/gB5iOzP
 W5qUn3PA=
X-Gm-Gg: ASbGncuCB8Scd4cPA05c9NclVVh7VXzTHrIxVqedV6cfSzPDpDj68VTe9TIDas8LBK5
 7TwRXgB8yPAs1dKg06nROH4YYqOAOTNQRfYmJsxoErAHT8HmnWXT36uthRXu99pDd2mDj9OfZbK
 B17Uojms4aHBMlPsFFXRqKbsB4zLXgy3ZywAUd+b4HP8dRRvS6/7gDPlo3ftpAmle8AOS/GxVUc
 2Arv7JeY96UOgZVd/msNgPR06i+YVHGDBEQ3zuSmJho3tNfzple3bj5ndY62DZldT9ZRzyb9gXx
 CAcTu+35PBhZfWfQaLEcqwiCvlDvhuMio8B4bdan6cZo184K7hkh2LcXrxvjNdNLeg5i7wtwwCb
 8kHIjoedx0npXQ8Em1tZmOkYqOv9a9MWcUIGt1ELslblpObpo95RFf6fJRgoEEAV0fSUFo5Kaqp
 jCMl9//+dlkLf328zepO4iBPx9X1cdiXPDhYjcANS7JMBtftfn3DJi0kM=
X-Google-Smtp-Source: AGHT+IExz3L/LvK9Wz7HXSNvuLZztaFgYtya0Ma5Ny3KTlFw50GuuF/kptSXn5uMJBBk4D6WE3FJ5g==
X-Received: by 2002:a05:600c:45d5:b0:45b:80ff:58f7 with SMTP id
 5b1f17b1804b1-47717e7d10amr21335975e9.36.1761637832517; 
 Tue, 28 Oct 2025 00:50:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd48a07dsm180117025e9.17.2025.10.28.00.50.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:50:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 04/23] migration/vmstate: remove VMSTATE_BUFFER_POINTER_UNSAFE
 macro
Date: Tue, 28 Oct 2025 08:48:40 +0100
Message-ID: <20251028074901.22062-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Michael Tokarev <mjt@tls.msk.ru>

The only user of this macro was VirtIONet.vlans, which has been
converted to regular VMSTATE_BUFFER.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Message-ID: <20251023135316.31128-3-mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/migration/vmstate.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 63ccaee07ad..09f1eefcfb6 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -727,15 +727,6 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = offsetof(_state, _field),                          \
 }
 
-#define VMSTATE_BUFFER_POINTER_UNSAFE(_field, _state, _version, _size) { \
-    .name       = (stringify(_field)),                               \
-    .version_id = (_version),                                        \
-    .size       = (_size),                                           \
-    .info       = &vmstate_info_buffer,                              \
-    .flags      = VMS_BUFFER|VMS_POINTER,                            \
-    .offset     = offsetof(_state, _field),                          \
-}
-
 /* Allocate a temporary of type 'tmp_type', set tmp->parent to _state
  * and execute the vmsd on the temporary.  Note that we're working with
  * the whole of _state here, not a field within it.
-- 
2.51.0


