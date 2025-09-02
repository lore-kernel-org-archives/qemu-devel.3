Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C36CCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQnj-0001Kh-EB; Tue, 02 Sep 2025 09:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnL-0000s7-8m
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnC-0004Xc-KW
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3cf48bde952so3723553f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818678; x=1757423478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xLSY6a6sWL0T22LwducXeaaoZsK3dxB1C8UUGoL+RxI=;
 b=hDpQe2Mp6JvN1EUf9Qbo0bL/V2zhISbgxIbK2s0IHvcadoW89ssDpCEtFAettdSZIH
 K3L08JtZ0vNSvWm77899bWxyb5cLwgYr2ndOs5JIxm0747aRq7Yt1ljo0ieZ/r/lO7Pp
 33P0w6H7iEnpDQHj4hEyvY5ZXZryfKQoYrr2wQ3hq+XFa32uj3WMBLqX/dgqTJPeT5ow
 kPZozOFLu7aEt2CB6WW1L6iKYwpWdGDMAMCB4fZZ9wV6Al6YDMfk54tBIekFv0SBzpAl
 a1ZdDeZlV4dIsXzXVmrAbEiUxpvigjTQ5tgkDpBt4Pyppk5PXkb3xYz6hLOJ96HTYamI
 NF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818678; x=1757423478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLSY6a6sWL0T22LwducXeaaoZsK3dxB1C8UUGoL+RxI=;
 b=EUqwLvrlTjwg0CCQ1zEtaEZc4pL590WtWH0hZ/KNenYblyuLdGExtmwjsoys3WhRQ7
 i+MyIn/bBNfeXvcQyKsYXvqR3+5xrAeAAQKFruFhvU+/fvWfHCOpZap+tp7/nfaMM7b7
 tl9RwM5WIcVv4qzDOdCReuHsYYGE5vyWRnvwluxe1UO+0ZN6NOM+LDg1q9e5ssxQvcz3
 1RG4ihm37ukXntY9r1eSwecwzIzVBfii0e/OYS+CgM/CaDGcGdwjga55+uFJISPpaU0G
 Jn7UH1TGIAn5k6+wkKHFdD/JZ4/wOU1nXW+SSKAiLxiiwHDemkyub4cTsM8rz+j2jUE1
 3UKA==
X-Gm-Message-State: AOJu0YzylQkAdMCIcM8TtZY+F8PqKzdWdLKssc35rz2R815F7f6kBSgK
 A1gVQIFGlJPAqaVUroGr0xuh0izkRXqGtPdtCtPcmINrazil6/rSe2UKTtYjuIjsCVG6Q/WoheQ
 D2+cf
X-Gm-Gg: ASbGncvqKiJTLR7yeh5ewBaxIeSb9AGqt091OOru28SdaYjyA57SoSI2/vzD0uiaCry
 Aik0TbMMVMros5bnq9K9eX/51Js78JhJwLsHTvcCcHwq/zf9DluF1DC5MYlVmfKMhjszOVZp6ox
 iQuYiJPggEPx7CeJUV9RfyPIoUvAdOFZ0xBZckzYungS3ccRLtmQyDap2YQBTTeM7D0Jt+m1q9I
 /EClN8hHCt+mN/2C7FWxUFNBlxr10fkMReqWbNoZpHikkixgNbytzNDpAMhAwOCOnze5HF0IdHb
 vDTXdSVk2YGm6Uh6kP2eTuHQQSk4/++nRfUmQZ7dDkXyAe/MhXwPIN9HnDdvTxCSBr85ENCQLl2
 u74qncZMU7CWrlNis5tn3tL0RjVR0mp7hkuvey4qW90GSM0QufVnTGPCTSfgnq1xgOD6CwdM2eX
 VcUwKdXIE=
X-Google-Smtp-Source: AGHT+IF6m2HomZhoyW01LNdH7WwNgwHqiQcuHZtgARwPJQNnkuHVYg5IbLwDSRoiqXUMu4rdHP6e/A==
X-Received: by 2002:a05:6000:430c:b0:3d3:9b18:227e with SMTP id
 ffacd0b85a97d-3d39b1825a8mr9416998f8f.10.1756818678185; 
 Tue, 02 Sep 2025 06:11:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf275d2717sm19669772f8f.15.2025.09.02.06.11.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/39] hw/scsi/mptsas: Avoid silent integer truncation in
 MPI_FUNC_IOC_INIT
Date: Tue,  2 Sep 2025 15:09:50 +0200
Message-ID: <20250902131016.84968-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

For the MaxDevices 8-bit field of the request / response structures
of the MPI_FUNCTION_IOC_INIT command, the 0x00 value means "max 256
devices". This is not a problem because when max_devices=256, its
value (0x100), being casted to a uint8_t, is truncated to 0x00.
However Coverity complains for an "Overflowed constant". Fix by
re-using the request fields in the response, since they are not
modified and use the same types.

Fix: Coverity 1547736 (Overflowed constant)
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20250811095550.93655-1-philmd@linaro.org>
---
 hw/scsi/mptsas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 1ebe0b82a79..4ada35b7ec8 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -579,11 +579,11 @@ static void mptsas_process_ioc_init(MPTSASState *s, MPIMsgIOCInit *req)
     }
 
     memset(&reply, 0, sizeof(reply));
-    reply.WhoInit    = s->who_init;
+    reply.WhoInit    = req->WhoInit;
     reply.MsgLength  = sizeof(reply) / 4;
     reply.Function   = req->Function;
-    reply.MaxDevices = s->max_devices;
-    reply.MaxBuses   = s->max_buses;
+    reply.MaxDevices = req->MaxDevices;
+    reply.MaxBuses   = req->MaxBuses;
     reply.MsgContext = req->MsgContext;
 
     mptsas_fix_ioc_init_reply_endianness(&reply);
-- 
2.51.0


