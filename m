Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4C6C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvFF0-0002ER-4T; Thu, 20 Mar 2025 08:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvFEx-0002Dy-Uv
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:43:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvFEu-0005QP-19
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742474588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fei6ufdl0yHPvlmUWNSN3z3HQrZPbFrTff3hXL/eayA=;
 b=PCo7tfTBhM9xDZMdJ8ycM59e/vqANjGmBd4T+c4WsQA7l2He3htucdBTeig/tl5d/zaiDG
 KgajkPQekdXwtD9j1exNTPKawp8d69tGuuuZyG/DX3inyKro7qfEGfusccVCDaGXIaXdZ8
 AEAzSw7bQ36RWJAkb6udoA3Ly8HAyBo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-AwPRlQfZNcWhSNJMDqEMxw-1; Thu, 20 Mar 2025 08:43:07 -0400
X-MC-Unique: AwPRlQfZNcWhSNJMDqEMxw-1
X-Mimecast-MFC-AGG-ID: AwPRlQfZNcWhSNJMDqEMxw_1742474586
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso306993f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 05:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742474586; x=1743079386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fei6ufdl0yHPvlmUWNSN3z3HQrZPbFrTff3hXL/eayA=;
 b=V4shMs39wGuEhKxre+B4ANDVdIs4MBh5bKSEWSXdqyjqbY16xbbXM63YS7QdBIwmYl
 eJp6Jx/t97qZy+djRnh6hD++gagNjKGyTWr374Zr7FcZjqnPtgiqdGg6dR5lPYeapoy2
 SpXiR/k5INVRzRQM+o3PFyK4ceofcPwtCuAfzurOiMU6Jel3XF+6lU/ukdyxeutTi5Nq
 Gm+L+cQL/mnA3a461xCmFIV6sC+jitQr+IK74pof9fawgC45QiUdjjl7WKlsO/OJTeiq
 XpjG/Ippty5WEvVYZHsdc3518NG6JUxhrnZvGlkM5nPaIDzk8GRa+h0wOIBjN1mAI7ua
 XFFA==
X-Gm-Message-State: AOJu0Yz/D5d/1QrNCzdZlOto66cjg5yP8pMcuYmveem4PC2eKrzTqCNb
 E1d+oiDzU/aHWxVrJAmSF0si4L+VOpMq3u3pVxlrJarANIneT155Cf7+ywxus9aJpFMw08NATU4
 XZJGboJcP1GtJHn2ye/qeLrtMfBj9cuiZaUlo9nqZMSC1XGxYgBMu1bLlv0d0o3kf/ZGoaIspTi
 YF4e++rm7cbvi069bv15lg7EeYB/3hFsZHIVIM
X-Gm-Gg: ASbGncsfXUfUqHAFmGUjdLOvAQOJgYN59wtPmhb91corE8BdSUHbloAjkSr/Cmvq6PC
 /JPuwFjIXy2G3FQ86BTh9gQVWmGRESkob2NBT2Y9j0lUem8TLhPTj24/NIzQNfRrzjDcxU16TtT
 yNKIECmqUuCbspzsxzTHfr0R3GX+TuuWmzSpYGU9TaG0VWdJOXmKgyeO8R4MpJJF+o9qok9VInB
 Ch7zco7asE18EX4KBIA9GMyNY+29CCx79Ah8sTTu2Uvhc1gM3nRJCFa/x54t76Fd503FV/AX8im
 ajNYzkGd1AuskKgYkitM
X-Received: by 2002:a5d:5987:0:b0:399:71d4:a9 with SMTP id
 ffacd0b85a97d-39973b326e2mr6299630f8f.52.1742474585723; 
 Thu, 20 Mar 2025 05:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+/G1OvIiZb3ZAzbD+vUIJoB3kIOx+VFUFjU7z31GZkIVsj/J4HpEVHs9w03a9/RBjnd8IYQ==
X-Received: by 2002:a5d:5987:0:b0:399:71d4:a9 with SMTP id
 ffacd0b85a97d-39973b326e2mr6299600f8f.52.1742474585191; 
 Thu, 20 Mar 2025 05:43:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8881187sm23334470f8f.41.2025.03.20.05.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 05:43:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	Wei Liu <liuwe@linux.microsoft.com>
Subject: [PATCH] MAINTAINERS: add an entry for the x86 instruction emulator
Date: Thu, 20 Mar 2025 13:43:03 +0100
Message-ID: <20250320124303.819196-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Wei Liu <liuwe@linux.microsoft.com>

Add myself as a reviewer.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-15-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f470a1c9b7..6bab3c642a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -533,6 +533,14 @@ S: Supported
 F: target/i386/whpx/
 F: include/system/whpx.h
 
+X86 Instruction Emulator
+M: Cameron Esfahani <dirty@apple.com>
+M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
+R: Wei Liu <wei.liu@kernel.org>
+S: Maintained
+F: target/i386/emulate/
+
 Guest CPU Cores (Xen)
 ---------------------
 X86 Xen CPUs
-- 
2.48.1


