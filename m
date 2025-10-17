Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDDBCCD1A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kXq-00004x-C5; Fri, 17 Oct 2025 09:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXe-0008Sn-0b
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXS-0007xX-Fi
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47117e75258so7543085e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707831; x=1761312631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZrcPjLfHxaL48ZnDYfElgAgAzur4umLN5QD93IZQyk=;
 b=WHRJ4qKCAca8m+qOstPXsGJyic8uy4eF1csVH2rv+vHzDlUcKm5dQQ7kjsoqDXsx6f
 tt9DclR79Q40qignxPebkou3pxEw2vHy7+RIIL0RoQm3l07HjjVJxBXRQRyywsoT7I1T
 H2WBny5obgGA7dFsvnvVp7exzppSf6YD9vYEGCudX71DbSA3afwTf9EUyj/zSPh2rSJC
 t8GVj0XOCFdxoMjMa4+JINDsMQIB1+JIXLSLfAXHH8Lq2Kh4PZnoiP80YDCD0gJ/Wndc
 yaLXfmocHSpfxR/bcjQEoan2Ww9Yw/2dXfQBUhoRY8nwqjNnr4utbwIP1iS2dNJmSWf4
 B17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707831; x=1761312631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZrcPjLfHxaL48ZnDYfElgAgAzur4umLN5QD93IZQyk=;
 b=QGR6RZKrNpfIQ8b6LSmH0uDO5JY+ilNWF5GFADEaf1bWEd09Az/Ixs2/Ry+7Lq9DmK
 oIoBevlCCMNMZqsfM9nBJy7ovhLXzrPzE/GAJpy8WyX8rgxFWZz/qxSUE9WcZVoV+Fi+
 /Us3V9mVvtidnyJNb0tjV+Ip3jSo4Ncc2h8LA1+6bsXVOmPifbIJGlgI3vPzx0Qye1jZ
 bAXI0pUH9Pkf/sYOVRLU49W2xjICZn7IsXnmWQS8O7BQZBnwSy1k4wh9pF+G2azan8wI
 0tIodqcKJ5TgCkQRbendnPQmmnppNJBOJYXXdTw20Vlf45/l/BprCycHlMIYI0QmFVfM
 anmQ==
X-Gm-Message-State: AOJu0YyUhSwk98EZZ3XxHIQVEU55z6dziOgJIMCJSI/PaLMXswECZGdZ
 q1FCunZqfhE0eypyuys/ryK9+9VWukeTybPNZwQIbISin5wRywe28uCxtQNfkwUPJYWZx/I34w2
 hkXdaWTk=
X-Gm-Gg: ASbGncvGxYbAh4j63lGoXchfTX3Lz4NJlh+CyrpFF/ncg4Myb5hKYnfTISPGh7M4hxn
 KhWzYzicPTrUifZLz66cOv2T7MaiCO7z1EgAwTa9DzI3cJFO0Ksjltxew9CPj3TwkD8G6DgWtHW
 WTtHB9hUOFNzIL7FdmfcprmQyujtKYLHSUi9/dS+FPy2dL8aWgYfN7OHNBvmnr6nyYV/RHqt1PK
 UxZIbtPFNXqVcdNp/CtLee5N7ElwzmEQwI8QAbo+rzgOi/V7DaFTJbEI+uPqo/uqS+FxO0vKD6r
 wPrlN1+R3hE9KPkxPi3kQfSiQbtX1WNzSaZ9xemjcY++kBOvSVXNZAvlsXHGoXYVOTx75Og0Ixk
 5Dmtwn2SB7ScjVoZQSs8CyQYs7DRFV/vGKaQQlwmCjFbzaHue6vy1gRzzMZyXH3BBayMSblAGqt
 MYAL1HAMnCFL5Uab+4xy5nW/UJLmB135yLySTMZKeovcSLiLzVi4iVNhxGtj7N
X-Google-Smtp-Source: AGHT+IEHXKCqSHJkQqTrkGXNC6LA92jnIENYehUqITe/TG9b65FUa3BgDb2ost7w/wUxRpjpLfCJYQ==
X-Received: by 2002:a05:600c:8b0d:b0:46e:39e1:fc27 with SMTP id
 5b1f17b1804b1-4711787442amr29143035e9.5.1760707830687; 
 Fri, 17 Oct 2025 06:30:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711442dbaesm84947425e9.8.2025.10.17.06.30.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:30:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/12] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-5.2
 machine
Date: Fri, 17 Oct 2025 15:29:54 +0200
Message-ID: <20251017133002.61410-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7be998168e8..103b0c4d73f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1109,18 +1109,6 @@ static void ccw_machine_6_0_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(6, 0);
 
-static void ccw_machine_5_2_instance_options(MachineState *machine)
-{
-    ccw_machine_6_0_instance_options(machine);
-}
-
-static void ccw_machine_5_2_class_options(MachineClass *mc)
-{
-    ccw_machine_6_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
-}
-DEFINE_CCW_MACHINE(5, 2);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.51.0


