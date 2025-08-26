Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1A4CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 05:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqmWo-0000fx-13; Tue, 26 Aug 2025 01:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uqmWa-0000ZY-52; Tue, 26 Aug 2025 01:47:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uqmWU-0007Fv-70; Tue, 26 Aug 2025 01:47:13 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7704f3c46ceso1882920b3a.2; 
 Mon, 25 Aug 2025 22:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756187224; x=1756792024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jC5ltyVIy9yJ20gk6j9B/6jrs48ECuEt3pZwln7qQJg=;
 b=QQVYcc3nnN4ihzWZ1YgMZ9zfttDjU2GcM0RmmTiSvnvJPBgi9aQRW1IaBuebpZY9ND
 i3Z6L3dAIwFzJiTCn3Qm4RRtkDf6Uu6BCMyQRksqEvbnUuiIwFwxgUKwDyjfCiASJedc
 2T0bik2h7+/YP+E1ZyW1XXWxAKvLVSDfmWgdFw60iMj4YOvzUMWevE2jukVItrySD9CU
 QVYWLsiBo4WiKSYPSPyfsUbRI0alm6WBh3LhR+isqrXUsHrbDZDr+mZ73AiQ9YoGCkih
 n/dYRWlgBHXgwN7Dk1zDeIk14GhHua90pmR9AGSvqWCPt38eniyhcG6Y5oIirX3uBh4/
 +I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756187224; x=1756792024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jC5ltyVIy9yJ20gk6j9B/6jrs48ECuEt3pZwln7qQJg=;
 b=Tqid3s4Z0oXvqMW+bvW8OMeL6HddkAu3uREHkxoQhDYGUUpdbTjMju47o/TCXOnAq3
 p/Y7l+bFgoEvoMHjP9u0cmmTU5iUx3HbPJ+0WK1jfM21DJZqv40wpdpBnV3is6fl1eGC
 4fh5v9hfKIXx3IKEYWamkxAVATIzi0fPRC6JQ6c0qohjMJL3aUjue0iy3F3LIX0EUwxN
 qJTQxO5X0Sfvsx77ndVEzjbi+pgbYFsADc8Ovht0KhXR1fJOBfojEPQQMh3St2sop0ls
 5jRKvbf0cIfaKhjsBcz9EhD8vyNHU5Ijgj2x+sKRyXw5W02wtxIdiYIEJ5WtSH5ddEy+
 IQSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdWq3MWoIts2sOoFiltIHZfB5ZdhtnM1C+unODu5LMF1E8tL43+kZ8/GyrFzF0RKptTqed+NIeeXIZ@nongnu.org,
 AJvYcCXvABk+9Tn1yJ2RSzXUExJyw9Z5LXXxDhI3AjqNeno7X9hAkSv/PqAXINuvba+0/FT3bH1/we6GSzL1uQ==@nongnu.org
X-Gm-Message-State: AOJu0Yw2086H+gJDriyGEPgmn8WSFZ4d0XlXmpu5Pc50TVAJHlpOW+Ii
 gynWtENDznIpkvsfjOj/rHwlZQWU24ULwO4ho/7MYYrhAMB09/rwZL3W
X-Gm-Gg: ASbGnctSNnnQUU4RlXa8XrTHjrRBKXEMI2D1220iHpQa/hGBFuHHIflH191QAxPEoud
 vshtSQ54wSYpS3wr6h9m/bfJsvri+8rdzH+SvXoCF9PhEbMAzVY0AJDjgDHO2rG4MSGFG0odOZq
 4XoFDQy0ft3WjRJbZKj+Kf43KkH8/TifcEEHl7WoFMIV6yh6Xi7qDAubtozWAzrIeKbyUopJCBy
 zToW0J4HTRc00tsTf6mKOr4KP1YnHeX7La7RE3NiiweCAo0fqswDpVSG4/gutp2FdS5OhuOXhbu
 uBF/xLhom4X32Yhmkf4cJpNfgObHz4eNpJvmaRyKW81kQkXQRICtzMQ2gk4JXqcC0898VHusjDl
 czx+s+m11XR18iij5jy0zuCgbzQ==
X-Google-Smtp-Source: AGHT+IEBhaHreBhD+w0v8PyJrJLq2knv7d9i4viw06enYmEUgd39gF68jPw6PZsfpEV0w5bMlBWK2Q==
X-Received: by 2002:a05:6a00:bd92:b0:76e:7aee:35f1 with SMTP id
 d2e1a72fcca58-7702fc09f00mr17043840b3a.29.1756187224004; 
 Mon, 25 Aug 2025 22:47:04 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-770401afdaesm9032365b3a.53.2025.08.25.22.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 22:47:03 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 2/4] spdm: add spdm storage transport virtual header
Date: Tue, 26 Aug 2025 15:46:28 +1000
Message-ID: <20250826054630.222052-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826054630.222052-1-wilfred.opensource@gmail.com>
References: <20250826054630.222052-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x435.google.com
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This header contains the transport encoding for an SPDM message that
uses the SPDM over Storage transport as defined by the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 include/system/spdm-socket.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 2b7d03f82d..2469424cce 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -88,6 +88,17 @@ bool spdm_socket_send(const int socket, uint32_t socket_cmd,
  */
 void spdm_socket_close(const int socket, uint32_t transport_type);
 
+/*
+ * Defines the transport encoding for SPDM, this information shall be passed
+ * down to the SPDM server, when conforming to the SPDM over Storage standard
+ * as defined by DSP0286.
+ */
+typedef struct QEMU_PACKED {
+    uint8_t security_protocol;
+    uint16_t security_protocol_specific;
+    uint32_t length;
+} StorageSpdmTransportHeader;
+
 #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
 #define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
 #define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
-- 
2.51.0


