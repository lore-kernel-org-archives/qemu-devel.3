Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D991E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwes-0005Mj-Ir; Wed, 04 Dec 2024 16:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@bytedance.com>)
 id 1tIuKH-0004df-4P
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 13:42:19 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@bytedance.com>)
 id 1tIuKE-0007wP-Rt
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 13:42:16 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b65f2daae6so6230085a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1733337730; x=1733942530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HJurhTOArQPGWijqY4ldIX3NomalTmxXbM6VQAo+d5o=;
 b=JxvwWsfwLmb+nS35R9McdCvbi9RKmAVLT+NWmyHi/iKks04y0nCSw9i3xRDt716d6w
 DWlFLAJCwI4pIEyqBOsFAYxEHN6xRV6OCRcAVbo60lOm6BAHXaxt2RdWnZi6fiudynBL
 tdXwa5ZYbA9kYi/Xa//nbwi4ky17dcaHPubTZcnkrAv5NUOOSWSN6u8v1+y5LszJvjOQ
 1w5uyQQB7gs5+V8vDo3FZraVMOhESENQrEocCePOvC8UH7wEaKrYDZ36JrQC8UenLXW5
 njY54OyQ/R0swVyzAZ2s0v879eWQSyae9O2juR25FkhNQsjXhRp9XRDW0cpEt5W1JacA
 q9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733337730; x=1733942530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HJurhTOArQPGWijqY4ldIX3NomalTmxXbM6VQAo+d5o=;
 b=b+R8u6ircL04g4TfAn7Llojd8EpT15+AZ3QyNYNpRtxluhSm1U5OpZzjqXPF31K24W
 gJj32fPznaX7dPCjosDSuhQ4Gnj1ZrMi3AKjtFT1YDYd53s92OKJFKobatiDWXP6Kted
 GaxUvvQ4VZwKrjdrn9h+REa2DZNzigsacF5YVmkXONAqvcF1YtxyJXK6IQ+497efJ4hU
 w99vJDgsaLoDjrpeqUM3lvnL6Vx/2Q5lXvsU5KdLn3JlHST8bMgrRe6piWtbdpdrgJ45
 nTVeiY5kspXApWzn3OCaBbtw6bWnUEpi93eI3mYUhGZ766Lx6B0wlyxtj5Uxy+VZDyMS
 WjRg==
X-Gm-Message-State: AOJu0YzI8mivYXnfOaxoLexDZSSbpW9vXMjrPKQ9PuHXpFRPj1NbFPIC
 VomERL+Wsv69mCwtdh/36ACMYTdSqP9t1lLCmhgAmTvx8p3xIUW4ngem/2RdG2YKjhO4zorYujp
 t
X-Gm-Gg: ASbGncvyMGtCPtaIvoiKwiPDEqn01hSB2+S3lzG8uY4BK9zVlrm/v8z7IdJxqM+bcNE
 DQlZCOeaIfNx8ApLQMORhYeDdA73sJtHrzDZpwXkW00JtdsTfommZXCmtzXqE1esi/GVt2PpUhV
 oBvxsW0/WfaKDWp05VevyW1H98Elg/0LoIFtATaYDWh7zTVC+bQ7QQEfwaYt5vs5Vz6idJlE+Yi
 AFy4KqZnCfzM9I1QETlEdfDXPGkqUZJoMW9f7yr4BkCM5WHzKaDtz4GqU3b7CcAZxrw8P91mOzs
 iezLlL5FNw3I4ng=
X-Google-Smtp-Source: AGHT+IHv0gG3XwOfc+oOjPo7zPgngwE+DDjdSvJHzvESr/qXCxrJ+fENDA2ByJWlFy4po3cQ4N3AHg==
X-Received: by 2002:a05:620a:40d5:b0:7b6:6e7c:8efd with SMTP id
 af79cd13be357-7b6a6200dbdmr817316085a.58.1733337730566; 
 Wed, 04 Dec 2024 10:42:10 -0800 (PST)
Received: from MXYWK0WKF9.bytedance.net ([71.18.96.10])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492121esm638278685a.3.2024.12.04.10.42.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 10:42:10 -0800 (PST)
From: Vikram Garhwal <vikram.garhwal@bytedance.com>
To: qemu-devel@nongnu.org
Cc: vikram.garhwal@bytedance.com, peter.maydell@linaro.org,
 francisco.iglesias@amd.com
Subject: [PATCH] MAINTAINERS: Add correct email address for Vikram Garhwal
Date: Wed,  4 Dec 2024 10:42:05 -0800
Message-Id: <20241204184205.12952-1-vikram.garhwal@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=vikram.garhwal@bytedance.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Dec 2024 16:11:39 -0500
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

Previously, maintainer role was paused due to inactive email id. Commit id:
c009d715721861984c4987bcc78b7ee183e86d75.

Signed-off-by: Vikram Garhwal <vikram.garhwal@bytedance.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aaf0505a21..b4723eecde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1914,6 +1914,7 @@ F: tests/qtest/fuzz-sb16-test.c
 
 Xilinx CAN
 M: Francisco Iglesias <francisco.iglesias@amd.com>
+M: Vikram Garhwal <vikram.garhwal@bytedance.com>
 S: Maintained
 F: hw/net/can/xlnx-*
 F: include/hw/net/xlnx-*
@@ -2673,6 +2674,7 @@ F: include/hw/rx/
 CAN bus subsystem and hardware
 M: Pavel Pisa <pisa@cmp.felk.cvut.cz>
 M: Francisco Iglesias <francisco.iglesias@amd.com>
+M: Vikram Garhwal <vikram.garhwal@bytedance.com>
 S: Maintained
 W: https://canbus.pages.fel.cvut.cz/
 F: net/can/*
-- 
2.39.3 (Apple Git-145)


