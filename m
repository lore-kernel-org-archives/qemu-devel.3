Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1589CCD18D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 07:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v77Dw-0001dG-Kf; Fri, 10 Oct 2025 03:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Dt-0001ch-Hq
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v77Dm-0007xD-Fb
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 03:07:28 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso13419625e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760080039; x=1760684839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5ER2oUjcbGwVSVbKc1P6Ocf6G/t516J/ZS3yvUvHLk=;
 b=UVYFNkxueSfCTx8HtuJxwWYFQKHJbK9I1H5UwCfTkhO9U0fs7hFMWLlmziDk1xGwcw
 FgBFsm9UwjrPTHtCBjzZeFFdVdmKbmqEwwQH6mcLPQJDQMAsOLOJrXgYCvtFGn3l7RaE
 eCeBxJGkTQhho7SKOyS+TFdnk6LqFY5WEB3dbtybDnpl7uMaatPrtDYLUqZQN5govw/g
 O9Rp6oVbrCi4S49L26Ux0krlvigCy6g8CSo36yYdyTImwuIZ+gHQl4flPCJtSXpwwJeh
 L8D1Gikf1uPVDxpVbCO4sRcO9rwgmEu+g6SjYk8zCjzhPlgbUsnC9vfd3DDtqVykYiaM
 VBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760080039; x=1760684839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L5ER2oUjcbGwVSVbKc1P6Ocf6G/t516J/ZS3yvUvHLk=;
 b=aDgcDz/SLVPK3hroN4LBsqSlC0WiAhWaWZ1U+snWSdS2WX+F3SNTJKsKgat9I5N0Al
 74+91OHxCLDA+iv/KIHvhVKYWkeUsUL5njAgl3S1lp1HqDkBPi/ngubDal7Pi8PjVp+y
 bwLPB5MBCUQsZj15Y34NO8BHOVLkd8DAVsGAydJ9TPpZM3UeTAqth0LQnUIic4Zqzbxd
 Ttw20R8U0GkfenP2B3KOlCAlbTsAauVPwmulkldGveyiP1HXk1ooXI8Io89xjLngxviC
 K1srohGw5p2Vf02jjf2p5X8DGJ5r9aZl7HFcmmWISX8Ky+N+HubFmefk1iSkatUzWsUa
 1q0Q==
X-Gm-Message-State: AOJu0YzS5WDsnkUmsinsWAHZs3TzLdW5srGBpM0TAUruligpAK8YALj5
 BqeSmz+i1JTs92SAhCz8SXiL8dHJAfobjXu/thez4ektTY9VOxNCufBwx/KLv03r1UPke3Ma9YK
 vRtrKiaI0eA==
X-Gm-Gg: ASbGnctHwKppzedTXjj2xF1yHUY69T5TxnlO097BmRBJVV6L7mosxq+VQ5I+6vON9Os
 dK7eD7fG07FlHXQrYwgQIRzh8Drl/CeDBHJBMHbc9C4vMm53P/oVyL9rqBKPUgh4WcKsWuEzv4k
 LriG/VhDXD6g5TswSxIEH234MJYwqIZC8M2EZb4heFLjNaV5cv5lQtxBjdPYCIyk2Uq1YJdfjG0
 3tB1WbUPZIewr0AdmEZ2Ov4zK9tPDhWh8w/53eaATBcAufwZuxkzli7mAOmVDrwXMXdAFwZGPfp
 kjmPev+cteLheoILAECDWNuELoCJrEKI1XO0AUx+5iQ7zkLI3E1KNKgBYTrW36YqAnmQR+fhIAE
 lhRNq6UAzBaMg4a5IjGtMYDTaAmXu22rYn09fPzqCVxmjTr/8zvrWdI3m/pYxpZriVkQ6E3WOX1
 sLffrdjxqLAHCIuLZ2Zc+m8pHi
X-Google-Smtp-Source: AGHT+IGGhmqdVMb0fgZ1lI7PqOKmrxPqdAEMlY1tbvN3l99J/0wEey18Rj3GpLGnEz0SCRxYzQYjJw==
X-Received: by 2002:a05:600c:8b22:b0:46e:4882:94c7 with SMTP id
 5b1f17b1804b1-46fa9b02c6amr70757115e9.28.1760080038826; 
 Fri, 10 Oct 2025 00:07:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab5250ddsm52382815e9.6.2025.10.10.00.07.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 00:07:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/13] target/openrisc: Remove unused
 cpu_openrisc_map_address_*() handlers
Date: Fri, 10 Oct 2025 09:06:51 +0200
Message-ID: <20251010070702.51484-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010070702.51484-1-philmd@linaro.org>
References: <20251010070702.51484-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Commit 23d45ebdb19 ("target/openrisc: Remove indirect
function calls for mmu") removed the last uses of both
cpu_openrisc_map_address_code() and
cpu_openrisc_map_address_data() helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


