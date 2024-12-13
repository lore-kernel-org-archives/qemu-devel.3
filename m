Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43659E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF7m-0002C3-9i; Fri, 13 Dec 2024 18:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF7j-00028G-TG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:08 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF7i-0002y0-3U
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:07 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385e06af753so1233385f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132664; x=1734737464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+pQd2baBlmY/N24Ub4eY1nVz17amZBdVdb84Jx0GrY=;
 b=xfLTB+D8NTb8rId3vns/m1d1yjpal733qY4JlFGTGLXvxldgs3oHfP/WrS09yJQzJg
 s3iGcLFwtOA7djXoZWKnMNhkT2M3tTFE/hcebiuSan/bZ5aXvlkunwOHIFxdczkWaEBd
 9Lz5jr2kpP9UyixOzofJePu5ukIm0cW3jS7/N1m8vs3wrEqGsz8YJLxyr4pSCAxoLtSe
 C+4wLZSWXb7dCaKQj/umiz7KNPZ02bfoOfjBpcZzYA1EuUU6A2FU2TQW+AnzIYGe/usU
 b6oBA4OQLzGiHTizR5HJ+IckaOEcR4yGJdYudFwdFOexnePnqUNuaDWTx5iBxhiprE7G
 P3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132664; x=1734737464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+pQd2baBlmY/N24Ub4eY1nVz17amZBdVdb84Jx0GrY=;
 b=mlVJ03i+rJxwdRrws+AJRDLdiCDCovSJZBwEsRrvH75eOXA3U2Za9/lu50bXTxtTD7
 QahqcL6mPexCxEZKtQXjMrrLYUmrbvSHqScbSSIhL0RQMQVGHG7iGYI0k4H7UUtczPMR
 DXLihR9hJUiWXeyUxgJomh6Y9SY4KkfjMHdq4WNYOsUiMcL2ok9xC7bw45NEeTJ982yB
 snpaP9NTVXlLejEDX3/jAHh2XoWnH8evYFGPrs3CWYbZHRg0+jFkggPbpnaGktPJo8B5
 BlfceUpCNG7RGMzCveBTqgn9dAJuBQv7pQiOj0wDeuyS/W8QjJ4AIPJTDFhz+zeP3xRy
 q1Kg==
X-Gm-Message-State: AOJu0Yzy0e8YzclrWjotsanfn1MDb6vYzrRmuEd1QgUU3hO/uqWNo/sE
 ULPnF1z163Mi3p3SzRV8GbqoDnZ9oTITButKVwsIgLgV2vPZR0/TLCYRpUi75V+fHi3zh4lM2Qq
 1AXs=
X-Gm-Gg: ASbGncsq7aKP7vNrx2EElTWmI5d93vs9EXXCGGNRNSfKzk0SROTb2O/NZgV/Ieu9oz3
 /GgZrKu2/OeSmjVNhf5t9UohOTaixzadq7U68mZNtKiMVfq3J2mIDxEEL7IOyhnQr9QDnVDvXlC
 rt1yZG7IagvHDQt5WK040RKFweYWpdJe8uE0NPqb55LDnEB+oy02z4voOi9/qfxl77z7kwAuw8r
 YQ1uHHC//ukivTVk6nOZ+q/0dom4FK/8lXQ254ZOpjKKaxmu4Mdhu178affldYnzRZ1xUlhVMyN
 duiizw==
X-Google-Smtp-Source: AGHT+IFgwEUAeUvtio+G1STrD/sSIgV+JoHjDmfPQ9W7JDVusM99HHk3BAWEhI9iLu+LDHOiGyjMvA==
X-Received: by 2002:a5d:588c:0:b0:385:e2c4:1f8d with SMTP id
 ffacd0b85a97d-3888dcd4760mr3194762f8f.19.1734132664122; 
 Fri, 13 Dec 2024 15:31:04 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801a8b0sm821799f8f.53.2024.12.13.15.31.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/20] docs/nitro-enclave: Fix terminal commands formatting
Date: Sat, 14 Dec 2024 00:30:36 +0100
Message-ID: <20241213233055.39574-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
Message-ID: <20241109122844.24057-1-dorjoychy111@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/i386/nitro-enclave.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/i386/nitro-enclave.rst b/docs/system/i386/nitro-enclave.rst
index 73e3edefe5b..48eda5bd9ec 100644
--- a/docs/system/i386/nitro-enclave.rst
+++ b/docs/system/i386/nitro-enclave.rst
@@ -48,13 +48,13 @@ Running a nitro-enclave VM
 First, run `vhost-device-vsock`__ (or a similar tool that supports vhost-user-vsock).
 The forward-cid option below with value 1 forwards all connections from the enclave
 VM to the host machine and the forward-listen (port numbers separated by '+') is used
-for forwarding connections from the host machine to the enclave VM.
-
-__ https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#using-the-vsock-backend
+for forwarding connections from the host machine to the enclave VM::
 
   $ vhost-device-vsock \
      --vm guest-cid=4,forward-cid=1,forward-listen=9001+9002,socket=/tmp/vhost4.socket
 
+__ https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#using-the-vsock-backend
+
 Now run the necessary applications on the host machine so that the nitro-enclave VM
 applications' vsock communication works. For example, the nitro-enclave VM's init
 process connects to CID 3 and sends a single byte hello heartbeat (0xB7) to let the
@@ -65,7 +65,7 @@ the applications on the host machine that would typically be running in the pare
 VM for successful communication with the enclave VM.
 
 Then run the nitro-enclave VM using the following command where ``hello.eif`` is
-an EIF file you would use to spawn a real AWS nitro enclave virtual machine:
+an EIF file you would use to spawn a real AWS nitro enclave virtual machine::
 
   $ qemu-system-x86_64 -M nitro-enclave,vsock=c,id=hello-world \
      -kernel hello-world.eif -nographic -m 4G --enable-kvm -cpu host \
-- 
2.45.2


