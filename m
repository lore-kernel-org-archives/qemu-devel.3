Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951C6C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrz4-0004cU-HX; Tue, 28 Jan 2025 15:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcryD-0002S2-Ll
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:14:02 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry8-0001ga-Pq
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:58 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so68177995e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095235; x=1738700035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D4r0o4ouDgyMwto03p97/ZTNbKwsZTo7cBCLFrtLIeI=;
 b=z8TqQtIF7xIqYyxu4SkEksCVYXflEAg2QhMzux5bMiCNG92UeaefXTvx+BmIOpye4D
 kHgeMOWvARi6o9aUSYnopoDUY/bMxCoMrgNGrT81LWNee4bJcG1q/DcFrdrxXpoKg+dS
 zdD7JfdIoDDkwCScqxenUImJGrNhojboeAs45ZxIhjVVh6cJNUmPGTaLOjEL6SvgoyEf
 xJQhcjla+NntTtc4QMIOu/BmWSblp+NxxlulsN07eolOFgLQ3Gxazp3dJ333S0tdbsf1
 Y1rZvhd01q7jGSfkNjx1m6gk6oTRwSx58qwv4d0507r/zftltio7P/t0HN+37HLXGk1G
 0GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095235; x=1738700035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4r0o4ouDgyMwto03p97/ZTNbKwsZTo7cBCLFrtLIeI=;
 b=ZCeoAKZRg/voR8qvgpHjQHUT+TiEQfr7H0Zupq0ikHUDbMwvhO2Dgr1p3rDqL/JMl2
 Qaj1SZM8FKbzfJum5EgJyox0zgx9Ee1oHkAfYAigXcsFCqqxIO3Hu4J0HVTdDoofeb4I
 Kr2qnhpcUnULlJv7ZA8Qp8eGlsMLZc+cuaSsSlt7HZYDwWLhJakFj93WuD+Tps7sbwNZ
 C6YFlISVleS+Enanbtr5V/QlNYycmolwqOIIm5FS/XBQcJpiZWo8HMzCTuAncsfw0vaI
 ZaC5SzOFf1MIipjNAkVoa9kue5xNng+r+/mstw4VBRLfUBfFVOdDTcSq9LCubL79ASP3
 XgbA==
X-Gm-Message-State: AOJu0YyXupYtiJYqWCV9OMmXIGYz7fS0eZ5KiSxVygRCRSjKe4uJ3K8+
 SQ6szyj+aB0o33IhwdZCHJUOogqQq4ltbLMVkHyLzZvcK6jta7MCu8dHuQmSJdghSUfaTY9W8p7
 0
X-Gm-Gg: ASbGncsJrUlI2JOX71g2ok6kDT/uG0CxVy/9HO5oJJ6hoGG0/3PwQX//yFaRX27e4vG
 a0TeNemNhKizmEKRUjk6FBEhJYNOgwP6w6l+43fHQbqbRpXqpWcnXtXeC3BN6/j2RN9CwdGB7KS
 gfk29dX8Y8TYS6FB/ZMx5bS5fmqlHcEfOWPkr/F64C+gJPNxR3JXOVdMnYB0wrnSPZahOZ1w2P6
 GMd1ILjPH7KOB7hPL484+p6ARboZR8xHM8kzradlxkPVH1IvNOIvLuoYk3z8B6goh9sJ4PmdCOo
 8ArQEUr/VWcIdH9eChZMkw==
X-Google-Smtp-Source: AGHT+IFLadsEv3bLbWDJkntoAW9qXMCkG1KxbFK1EVtTpVFqfshqhxPgtkwA1JyqoOzS+o1Hi+8A4g==
X-Received: by 2002:a05:600c:1e02:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-438dc3c22acmr3126435e9.7.1738095235227; 
 Tue, 28 Jan 2025 12:13:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/36] hw/usb/canokey: Fix buffer overflow for OUT packet
Date: Tue, 28 Jan 2025 20:13:14 +0000
Message-Id: <20250128201314.44038-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hongren Zheng <i@zenithal.me>

When USBPacket in OUT direction has larger payload
than the ep_out_buffer (of size 512), a buffer overflow
would occur.

It could be fixed by limiting the size of usb_packet_copy
to be at most buffer size. Further optimization gets rid
of the ep_out_buffer and directly uses ep_out as the target
buffer.

This is reported by a security researcher who artificially
constructed an OUT packet of size 2047. The report has gone
through the QEMU security process, and as this device is for
testing purpose and no deployment of it in virtualization
environment is observed, it is triaged not to be a security bug.

Cc: qemu-stable@nongnu.org
Fixes: d7d34918551dc48 ("hw/usb: Add CanoKey Implementation")
Reported-by: Juan Jose Lopez Jaimez <thatjiaozi@gmail.com>
Signed-off-by: Hongren Zheng <i@zenithal.me>
Message-id: Z4TfMOrZz6IQYl_h@Sun
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/canokey.h | 4 ----
 hw/usb/canokey.c | 6 +++---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/usb/canokey.h b/hw/usb/canokey.h
index e528889d332..1b60d734850 100644
--- a/hw/usb/canokey.h
+++ b/hw/usb/canokey.h
@@ -24,8 +24,6 @@
 #define CANOKEY_EP_NUM 3
 /* BULK/INTR IN can be up to 1352 bytes, e.g. get key info */
 #define CANOKEY_EP_IN_BUFFER_SIZE 2048
-/* BULK OUT can be up to 270 bytes, e.g. PIV import cert */
-#define CANOKEY_EP_OUT_BUFFER_SIZE 512
 
 typedef enum {
     CANOKEY_EP_IN_WAIT,
@@ -59,8 +57,6 @@ typedef struct CanoKeyState {
     /* OUT pointer to canokey recv buffer */
     uint8_t *ep_out[CANOKEY_EP_NUM];
     uint32_t ep_out_size[CANOKEY_EP_NUM];
-    /* For large BULK OUT, multiple write to ep_out is needed */
-    uint8_t ep_out_buffer[CANOKEY_EP_NUM][CANOKEY_EP_OUT_BUFFER_SIZE];
 
     /* Properties */
     char *file; /* canokey-file */
diff --git a/hw/usb/canokey.c b/hw/usb/canokey.c
index fae212f0530..e2d66179e0b 100644
--- a/hw/usb/canokey.c
+++ b/hw/usb/canokey.c
@@ -197,8 +197,8 @@ static void canokey_handle_data(USBDevice *dev, USBPacket *p)
     switch (p->pid) {
     case USB_TOKEN_OUT:
         trace_canokey_handle_data_out(ep_out, p->iov.size);
-        usb_packet_copy(p, key->ep_out_buffer[ep_out], p->iov.size);
         out_pos = 0;
+        /* segment packet into (possibly multiple) ep_out */
         while (out_pos != p->iov.size) {
             /*
              * key->ep_out[ep_out] set by prepare_receive
@@ -207,8 +207,8 @@ static void canokey_handle_data(USBDevice *dev, USBPacket *p)
              * to be the buffer length
              */
             out_len = MIN(p->iov.size - out_pos, key->ep_out_size[ep_out]);
-            memcpy(key->ep_out[ep_out],
-                    key->ep_out_buffer[ep_out] + out_pos, out_len);
+            /* usb_packet_copy would update the pos offset internally */
+            usb_packet_copy(p, key->ep_out[ep_out], out_len);
             out_pos += out_len;
             /* update ep_out_size to actual len */
             key->ep_out_size[ep_out] = out_len;
-- 
2.34.1


