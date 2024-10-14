Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8F4D1624A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JUa-0006du-Rt; Mon, 14 Oct 2024 07:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUU-0006cQ-V4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:43:59 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUJ-00056W-D6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:43:49 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so323808166b.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728906225; x=1729511025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qO/4HKWHrVuc6GQ36ulz/Nn1mmzauBCzpX9YAoGCMM=;
 b=CNcCF0wuKZT6U2pq+SqtODHZYRZRDDfz05cG2H8pd5vn/deshGxjsXYV+JqLHDuzpF
 +tw0Hbd8AcwaWSgDK7dN4Jie8TkpXHkrk86Mb5kaYKkU7KAmcwj8CAUbIBBkh6rvUm/V
 TJKPPOP8l/0x7W0919l/0vkdO2wXEz2/8/tkfuGOiVqMTpjpxZBluS/FQcBmWHLOp6JZ
 YINofNaGkAvecHgcbYWu/vkfFYGn8LsH6z5jCRiT0M7PdZM4fqmHg5V6PRyDidpNeh51
 dlAblyr/CKOhp71sqa5UeA3jTT7IJFj5QbgU9DB/wthzqbcVOm4pYsOoM/RuaUASeof+
 1t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728906225; x=1729511025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qO/4HKWHrVuc6GQ36ulz/Nn1mmzauBCzpX9YAoGCMM=;
 b=JqZhWJDZkA06788j5blfteraUoRCp2Ul1gurlsbdPMWnJxZ6K1mQzU+uCcdrRSUeot
 LIfcyYUXH2r4xqnhiIPVdjThokyKMxzNurMrS3Oh8M8Cf2vuaK9uZ+0zrWkWJf3O1Ypl
 lEZt0XFzg+hsU63JndoJO+nR2PEpMEtmq/s6VkZs7A0V3zEipIGGfEZ7mJ2d5qY2LQix
 IYY8U7q5Qk1+dgjXsYKCDObgjQk1BNDtDiWOntq2dsIu9g3ajTIVHtJLjsgrnyvS8xFo
 DwhySyOGbwZbzG/8b09Gz6Tmi7AKqie15AQccVWwMu3TEwmXesaLK/mpyPWN/XIDe34U
 xYlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4aKKcTLFs4ApYWMmnC+xu5u7PmM13G7MSiOjr+77C7WoWPeaR2faD1tF1BUxzi66thcDsPgjS+3aW@nongnu.org
X-Gm-Message-State: AOJu0YyeePS9auYv5PyOgX8u4S7bFZQPf1bYRtM5FaY8mWH6Txj18/g0
 gMh3dMhB54MTGB85FQ3k/bA2Sj1Vaeb02zazs3gy2/EaMC3HxH0hSfaQcg==
X-Google-Smtp-Source: AGHT+IGB+9MUTxbiaPxJAsuIqO34C+VnrlUDm3BdJyxrV/If0tvsfYdH8W8LLj4VfCmk0P9dkqJs7Q==
X-Received: by 2002:a17:906:794b:b0:a90:9fb5:2c43 with SMTP id
 a640c23a62f3a-a99b8a67042mr1106077566b.34.1728906225362; 
 Mon, 14 Oct 2024 04:43:45 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99fcb2765asm247764666b.64.2024.10.14.04.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:43:44 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/8] chardev/chardev-internal: remove unused `max_size` struct
 member
Date: Mon, 14 Oct 2024 13:41:29 +0200
Message-Id: <20241014114135.389766-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014114135.389766-1-r.peniaev@gmail.com>
References: <20241014114135.389766-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x630.google.com
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

Clean up forgotten leftovers.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/chardev-internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 4e03af31476c..c3024b51fdda 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -40,7 +40,6 @@ struct MuxChardev {
     int focus;
     int mux_cnt;
     int term_got_escape;
-    int max_size;
     /* Intermediate input buffer catches escape sequences even if the
        currently active device is not accepting any input - but only until it
        is full as well. */
-- 
2.34.1


