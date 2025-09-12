Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9064ACAC587
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 02:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwtGy-0002Ke-8K; Thu, 11 Sep 2025 22:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwtGx-0002K9-Ca
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:12:23 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwtGv-00056y-IT
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:12:22 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-25caef29325so9005965ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 19:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757643140; x=1758247940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oRpME3fEReq6A+HV+JEVsuZoSxZ+EergPyPzTNo/lsw=;
 b=jrlzMsr1c2t8wXB++/C7fROIkOFlWkIAyk5CQKD0ZYOuJrvEla48DnJV67ffOvn5vL
 eXIhnTm2N4xrW+sLDscFDCevD9r5niiiDitBM3w1aglvhaoH8j3y24Tz6C3Y+i1pV9TK
 TxUj/cYWwCEux1yb5v2abBnpdoZiAfupVfW45KLMiM0DNYpdrivoZRwcAMFF2+kHd1Gi
 jn24sm/CcdpmG/EA6QIgNkZSqHHdJej53Zi8/1cwxkAfxPTDL9TtTXA3yPFIjnoo0OZR
 tGXjdRLCYCywcCP0PX4lkaHYl1nRvu0voMTmrjuZCKzzKhIeL6w8ygHjogcwXTIHn31T
 Mhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757643140; x=1758247940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oRpME3fEReq6A+HV+JEVsuZoSxZ+EergPyPzTNo/lsw=;
 b=JOly28XzF9LCVDnAyr+QaMmNhCGjwsoxzvOAkvuKqfxplj07tyQ5KG62f6Wjc2OPxo
 jm9cPS0qLYkVsIrY7ZToNPEO/xbyO4TiiUL8ZzaMKy7pF9xs1JbC4SvEXkXb/BCQ9hUv
 6BiuOlDGtcTtO1tuAJ8+QJyYBZMRZdIpQtGA/5P0cK5uSyywPWUbadhJx9Miq6FW/lHD
 qlE5gjjpU6b4AB9m0wddPjBWFjy2QAcXXS065ks9/alq8+3eltMR6BpSfKW08FOyo0UC
 E7xNEliQSk5OBh068TKVXPsnsJ0e0ykSCC/y61hgrbaoBizABMjRCwpfJ6+kE0DBkpF2
 OVEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8gi7vDXum8Yu/4Ngt5bKE4BzrJfOmcIlOEq8SZfUJz+fRUVl+T5JTjoUn04VbU8O6i4OnEkFSZ2hl@nongnu.org
X-Gm-Message-State: AOJu0YzEbyhBbXJC6z6UQ47nYS0sq/cZ6lKlRS1dFGDJQN5QiPFbNrEY
 jmAW5mXCsUogSLF+krH78wHRD5Lyh3B31O8Fsex6pQAvEnIgV7h0a5NI
X-Gm-Gg: ASbGncvyww5jEK6OkzlImNbStHJEWGF7JmybJV8eoN7epZlqw+IW7KTp8me1jIKtCUK
 ccH9NeDkd8C4hxd4OGu6xSAGl5DXl2i4NsxX/DQzI3VgEpncSBv0f5J5RlQ+0dsHlEBm1AjTl34
 utQX1uVjHUpv+1kBo17SPJRGBwSYwMJ2yWaGjavKXZJopPCIrXdX3RuzZmBRVF7WfOHusRjYl9L
 Iviu5atMnmBtZ1RdetU69bx4i7ZLCsX1rs2iZE5m+pjjaw1QDLOlkRNKPrpqyqzWTHN3JVoJWoi
 6tvGoV3PiY37peMNr6q7PmcI7HedIX/VY0BcDi8V3NSs62Qikjxc1NXym/ovv4VzT29eUoznY1o
 ceT6FzTaG9p5FUW6p5xvFB7V9sNGA4SM=
X-Google-Smtp-Source: AGHT+IEtbX15YzOAhFsDWtnsNyu2OMiWBMCeOT883cZ2c6sNpNoGtEGHYlol2NbETWTzUqKuoHG4fQ==
X-Received: by 2002:a17:902:ce07:b0:24a:af68:72f0 with SMTP id
 d9443c01a7336-25d2647047cmr12913165ad.34.1757643139579; 
 Thu, 11 Sep 2025 19:12:19 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-25c3ad3349fsm32853205ad.104.2025.09.11.19.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 19:12:19 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v7 2/5] spdm: add spdm storage transport virtual header
Date: Fri, 12 Sep 2025 12:11:49 +1000
Message-ID: <20250912021152.46556-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912021152.46556-1-wilfred.opensource@gmail.com>
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This header contains the transport encoding for an SPDM message that
uses the SPDM over Storage transport as defined by the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 include/system/spdm-socket.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 29aa04fd52..80cd7021c1 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -88,6 +88,18 @@ bool spdm_socket_send(const int socket, uint32_t socket_cmd,
  */
 void spdm_socket_close(const int socket, uint32_t transport_type);
 
+/*
+ * Defines the transport encoding for SPDM, this information shall be passed
+ * down to the SPDM server, when conforming to the SPDM over Storage standard
+ * as defined by DSP0286.
+ */
+typedef struct {
+    uint8_t security_protocol;              /* Must be 0xE8 for SPDM Commands */
+    uint16_t security_protocol_specific;    /* Bit[7:2] SPDM Operation
+                                               Bit[0:1] Connection ID */
+    uint32_t length;                        /* Length of the SPDM Message*/
+} QEMU_PACKED StorageSpdmTransportHeader;
+
 #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
 #define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
 #define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
-- 
2.51.0


