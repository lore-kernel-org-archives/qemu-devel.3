Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EA2E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF85-0002g7-2A; Fri, 13 Dec 2024 18:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF7w-0002NZ-8U
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:23 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF7t-0002zG-9u
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:19 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso15177315e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132675; x=1734737475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXfVV08MxsawwgxsL3+POkWX1t2O2SuGby8ORoVPva0=;
 b=T/qZlnkE5CG9rk/oJsUX8UpcrkfMcdytcKmoty8voHcr/DQAC+Loi72Y/bdvBdlK8X
 762B4UNL5CX0UB3aeYtDf33jPYZ8d/ykLBR2DpwtJC0ubbDoOHMeiUyFkUU05Aqxym0q
 IPURpETfGVdw1Og0M47TiPlvD2lp0WIYWTlztTIeZarvgvVgoVK9oZKVxHKob9de7zy9
 pb2G9+UkfGhNcJG0Jwq/AkI4DMexX8oDCTeFesCXx+fsN5Xibc4ZDF6fA9yfnyhqHY6F
 u/8jtX+e75g9qeXHCKzmeKmZ5dZh5O48Y9IpPR/MWQUR6PxLB2PH8MtWBhoYucBELK8B
 f7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132675; x=1734737475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BXfVV08MxsawwgxsL3+POkWX1t2O2SuGby8ORoVPva0=;
 b=dUlZgPMrNfMeXRqIalAl7b5V8sTN7zPxH0/AUzijyNkNMqN1qKgmj6TCjdjyJWr26n
 jWzhU2dRPjBqw7Ocnngf6TRKAedXvA3t9Bo3L2xNN3TdzuJhFtPt0y2ojhG4lCqTlJV1
 mqlOdIs2GDB5n6Xnv9qd58kgD4keb8ofLD4UVfzy7lsIjjGJdbzxa+aPfQU/6FKCv2Og
 8PKgv3isMZE+C5/1aKpAVjjS7GL/boYgapm7kcu4EYfYMdoZZ82UCkF12cJU1Go11DCk
 BvrcsPgSwmUT0PJQ+STtnblsSQ2MEvMLuR3hawnTK/DO8RdNdNtYQ53qOoOGk5lFEbHy
 BhiQ==
X-Gm-Message-State: AOJu0Yyi9Yxx12cu2tugwIBPc0crehSzQ/vRG+jchJAZDB0JitaZ+b0Q
 Onvx+8UNsWN5MtgY8wuurqU1EoLtfpcTfrh3cLmh3xL7QWWiQ+3Yh8szq5gvdELf29RPoPS1G7F
 EyMs=
X-Gm-Gg: ASbGnctNx27Dv749VuZ1ZAD2oUc2P6oPoKKWteQE7sMNfAk29ZE+hDAyrr5zgtJvrMi
 Vo2rbkpyK+rfvuM4Ex5yC+slKWsOWVVO/eo+Viqn5aYtJf4AvbT5pnXaeOqWnmQwFlJYX7410ja
 lVy+ymL2GGXmxnu5l5/+6pEg4k7c4i9vJ1WDaZW11nG4vZjkLWPj6DvZ979lKVW6jlkPuFljKiG
 GTh6gR+jPBuSnAZKaQzpJhWmc0Fgc0HIQwO7rUBJd8XwYkLLkplem8MU1oUFNwbIHv8MushNmfN
 j2ovnQ==
X-Google-Smtp-Source: AGHT+IF9c3MW+kfYpcA2OgL107wV52dOQA4ooFlbhWX9A6IfKXP7tvOidUE8sI94pvAczO52MJaEzw==
X-Received: by 2002:a05:600c:4e4e:b0:436:1be4:c9b4 with SMTP id
 5b1f17b1804b1-4362aaa83c6mr37739125e9.27.1734132675274; 
 Fri, 13 Dec 2024 15:31:15 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436360154absm7313825e9.2.2024.12.13.15.31.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/20] hw/virtio/virtio-nsm: Support string data for extendPCR
Date: Sat, 14 Dec 2024 00:30:38 +0100
Message-ID: <20241213233055.39574-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Dorjoy Chowdhury <dorjoychy111@gmail.com>

NSM device in AWS Nitro Enclaves supports extending with both
bytestring and string data.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
Message-ID: <20241109123208.24281-1-dorjoychy111@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-nsm.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
index a3db8eef3e4..6830fcfe17b 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -444,7 +444,7 @@ static bool handle_describe_pcr(VirtIONSM *vnsm, struct iovec *request,
  *       key = String("index"),
  *       value = Uint8(pcr),
  *       key = String("data"),
- *       value = Byte_String(data),
+ *       value = Byte_String(data) || String(data),
  *     }
  *   }
  * }
@@ -504,14 +504,21 @@ static enum NSMResponseTypes get_nsm_extend_pcr_req(uint8_t *req, size_t len,
 
         if (cbor_string_length(pair[i].key) == 4 &&
             memcmp(str, "data", 4) == 0) {
-            if (!cbor_isa_bytestring(pair[i].value)) {
+            if (cbor_isa_bytestring(pair[i].value)) {
+                str = cbor_bytestring_handle(pair[i].value);
+                if (!str) {
+                    goto cleanup;
+                }
+                nsm_req->data_len = cbor_bytestring_length(pair[i].value);
+            } else if (cbor_isa_string(pair[i].value)) {
+                str = cbor_string_handle(pair[i].value);
+                if (!str) {
+                    goto cleanup;
+                }
+                nsm_req->data_len = cbor_string_length(pair[i].value);
+            } else {
                 goto cleanup;
             }
-            str = cbor_bytestring_handle(pair[i].value);
-            if (!str) {
-                goto cleanup;
-            }
-            nsm_req->data_len = cbor_bytestring_length(pair[i].value);
             /*
              * nsm_req->data_len will be smaller than NSM_REQUEST_MAX_SIZE as
              * we already check for the max request size before processing
-- 
2.45.2


