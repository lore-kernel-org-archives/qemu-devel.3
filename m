Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F74FCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mw3-0001Zl-9m; Thu, 16 Oct 2025 08:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mvi-0008J8-JH
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mvb-0008Nv-7s
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so620578f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617070; x=1761221870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V34vUqnuOAcXv8xBDqSxXxZXlKVZYEr3wYMejkasFuM=;
 b=blKdXGnEgArAXWU/e5MX+bAW+6QklKm7PJc11htySjD8OwjmCEmeHjql4avtwhXUp4
 1tG80twlb9gMj0viYJbQDecFUw3NFsQ7UPELdW1V2r2rqK6cAd6JmCqbRGJ4EEeNJCz4
 9PY8fpICgDRxlwHwlXzyZK5E4nHT7dKQTAd7MpJ31ZK3xEeTnD6AF2eICvp2jchtMYPg
 QcAemGOe7x+sY3Dc32h8oa6mM3N7JEbp/MQcOuMd77cZPT/c4asq2ftjiM54oupRa9Tf
 XcCje4xf86m/o2T3pLHQBYnD/hWDWhIShqjP07f6uADVksD4dBuokm9LNKwAdgQZ80q/
 3YOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617070; x=1761221870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V34vUqnuOAcXv8xBDqSxXxZXlKVZYEr3wYMejkasFuM=;
 b=d8/jMgtTbuzrOkO9emEtiIEhe7EOexZdbo+ynr8BW2iWGFVl4ExjktdjzVFyB5jM5R
 rHBQzB+UsZJoNcJ22xi+cJmVnwZ1YxLGtoGTU2NdvFnCJgv/yxhGqLxvRZSUmqYDuZ/g
 xYrzUdl4pciDQ34XcNIbKo8EPU/ZSqLihnuShG+Riyqz8fklpKjqfjBzSITvu1ORHrP2
 515ePW6CnQwDIiICaPABCIWp4dIOWYHnOSZwafYOAtt3NxCf2HGtYPBCxE/BJiWku7G9
 wQKAYcqmaXa+8Zpha64tkcCy3a93/dchNje0E4R3xClkiWiCp6yfWBqUwLyErgSXpD81
 CF0Q==
X-Gm-Message-State: AOJu0YwWk9qyH4cD6OkxK5sfweCGBLky5jVImk3fQ2nphw9ZnvDBBMNJ
 a2A9BTOu6HaPhgUfpiGtDpFoh3hq02Cyf30/WqkYqXgaquPykJRSK+94+K7BpppRSpikCRQ1Mpd
 i6pHwPzA=
X-Gm-Gg: ASbGncvZamnvDva+4j/5nCmH7okbXduEvKPQhnznmkhGbK+sy4/Q7Of25UDmu0KNfRA
 PQn8Mk6b1x6pp0G7RYLX12GI5Xu1lRB+wdK+joTZtQJtQ4NIl3sKJ0U1tff60/WYW5CG/ekuxh3
 DBFowK69QyIqpKYmdklcQI4nX+thkz+pWTnZ7KShLHj7xDZviZVR2rG/ps09kr3TVmXs8mRCtx4
 52DNER+97HYFkdYuQvBcJPRUN/ozJCqevgQ9ZF5K/3/Ou5IrpUpiQE5EkRBLqvTU1V9HV0oCosn
 e5yOEARVM7cVwRwHWSgkLGrb0YSQ+1HaOfDpCBgSktUnpRbzMC1p5SpAWYYO6v+SYAricU8sSne
 AORCzOKnH2QWDmv3D3yoRPCMXDVAdxKmfYmgez16BwTS4MqGET5SttujT5GmfVlzywcQnMINRDg
 F9hpWGu819Y5r8EJrr5bTwLqfUMiOh86TWENdPJB5VUWoz2YVXLRd+eZUe4JSoL5MB
X-Google-Smtp-Source: AGHT+IGqB8/fYLZkJ5GHloB9hNILraBgdhbyg9KE++Qq6C47b+930T3L2LnUWwWbQSfIYNbIlGn4ww==
X-Received: by 2002:a05:600c:64c4:b0:45d:d68c:2a36 with SMTP id
 5b1f17b1804b1-46fa9b079camr217243625e9.27.1760617069733; 
 Thu, 16 Oct 2025 05:17:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144c900asm23129205e9.16.2025.10.16.05.17.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/75] target/openrisc: Remove unused
 cpu_openrisc_map_address_*() handlers
Date: Thu, 16 Oct 2025 14:14:45 +0200
Message-ID: <20251016121532.14042-30-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Commit 23d45ebdb19 ("target/openrisc: Remove indirect
function calls for mmu") removed the last uses of both
cpu_openrisc_map_address_code() and
cpu_openrisc_map_address_data() helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010070702.51484-4-philmd@linaro.org>
---
 target/openrisc/cpu.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f4bcf00b073..87201365a91 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -220,15 +220,6 @@ typedef struct OpenRISCTLBEntry {
 typedef struct CPUOpenRISCTLBContext {
     OpenRISCTLBEntry itlb[TLB_SIZE];
     OpenRISCTLBEntry dtlb[TLB_SIZE];
-
-    int (*cpu_openrisc_map_address_code)(OpenRISCCPU *cpu,
-                                         hwaddr *physical,
-                                         int *prot,
-                                         target_ulong address, int rw);
-    int (*cpu_openrisc_map_address_data)(OpenRISCCPU *cpu,
-                                         hwaddr *physical,
-                                         int *prot,
-                                         target_ulong address, int rw);
 } CPUOpenRISCTLBContext;
 #endif
 
-- 
2.51.0


