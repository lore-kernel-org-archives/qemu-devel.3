Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98F5E7FDE4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1Mu-000564-PE; Mon, 02 Feb 2026 16:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Mf-00052z-3i
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:46 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1MK-0007Oq-JO
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:26 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so54689125e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067282; x=1770672082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YOB4ISzqeTBlKe8AE9lG6xw3Tze1OPlSd3dhm8vtXvo=;
 b=JVS10ID+WI+mh8QssrnDGqeJE4tWoQzvm9QaYeps21UMVuk509k3oSbKVsQeXA2XHE
 o04NGFeqWTxOAuf+01mp4QktPiO5lSnHB4vPLGYcpMxIN/fSiDvtMMtxua1sQe14Ye9L
 vrN+zzrMxL37w6ItbIHyVDQPNFhsWq/+pYSYNpGc+Wrcs/61BfqoeM0CBAHQp/AhU1+D
 m/C7R9+lwAcpNcAuiDUDpNu1qNaRsCAIn5Us+iDXfJ/dx3euIk+JJTqK3c7i/KtNL5Dg
 3Teg8aHHrUa3o3TZsWfSisDBkee8gonctnJ673zYBv23iyCjJSZWVEeHbVoysp1bd0LA
 ZzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067282; x=1770672082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YOB4ISzqeTBlKe8AE9lG6xw3Tze1OPlSd3dhm8vtXvo=;
 b=WkHHp9310ANjgoRMhAGWlCGLvAW82kwjHjwkfsjZ6KVEbZo0zOCTw3FpjZ8i5aR0y7
 3ffPW65nKHMwMn8dFXe03IFXmBI7Ev+RA25TDOSF3vE31exZ2TvexMMaXIxdB0yAwM/n
 nB4P5S/kUUvVjmg8L+o10w1kgIooIh2CWc5q3tpWMGTkkhVzfduBzwPm+WDuzKaPTZfs
 /kRWT+BO9GS8atMujl15RnBdSSuZODG969Oaio9OaMAUrq269te23OrZ8/57daAvZz9z
 +LsYO9hi2wDacFhA92hwhi8ohwVbIeGE0Kc/6ofk7SZx5ZkvCmXcuBFkXgVp10A6IRtJ
 2yAw==
X-Gm-Message-State: AOJu0YyCBuqgRbKHf0ZZLH/rpTZlO6bkgWUczjhWSq5Sao4wlRNHmfCT
 2wQAIKnRcZzvHqglTj8VnIOeXomEHHMwJldJRMqJxsJ43kpZW2jzOucHYuX71wDzdH+eYlXOoHK
 hCNJxPQItKQ==
X-Gm-Gg: AZuq6aKKxGoiq9RCHpcA02Tb28A1oqNo7C9mXzRW6S7etyaN03GtnkNinDv8C5k+a26
 D9pAl2hPHwimOIvN2Kb+zDinjg4HVyTP6/WRUqJlGvXYFMDgkIefdyL+XgKGVD1D11hx71gvpKL
 GZv3F+QCIuqNl0EcNyBBAvL2pM8QGCYjLZDOtQNVu21GeGehAcR04eQJ4Z8bTvuc8eKeZPovJyd
 ybwuM0OIAvF6hIzKbCFlXxdrzM5cFNVFtXHb00x9pbcrAM9wDgouxFHo5AcYKgSCLk6OjvNrdqa
 DMZxVkwsjIBXap/Cpz9b52km8hyD8SteI2pcCOngZSKy1odM0l7oeJcfV2LalStbJmCE8POynaZ
 syXYRc53dkqZLbc3LKalYatmdKlycIf10DjzoTR5CvUNSOTCr2lavwzaxyJzgF7bk5CnjuJCEyp
 TvvknKkfMKNB0/T2pDRk8GQnec80gBa//hJCFlRu5HXabr2j6uT4+pTSHbMk99
X-Received: by 2002:a05:600c:4443:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-482db4a0fb8mr194153355e9.30.1770067282471; 
 Mon, 02 Feb 2026 13:21:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e476dsm45771548f8f.4.2026.02.02.13.21.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:21:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] hw/ide,
 scsi-disk: Fix typo on the rotation_rate documentation
Date: Mon,  2 Feb 2026 22:20:12 +0100
Message-ID: <20260202212019.94205-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alberto Garcia <berto@igalia.com>

Correct values according to the Medium Rotation Rate field from the
Block Device Characteristics VPD page (B1h) of the SCSI specification.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260128102548.224237-1-berto@igalia.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/ide-dev.h | 2 +-
 hw/scsi/scsi-disk.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
index 617e8159c77..f5eaaf68e65 100644
--- a/include/hw/ide/ide-dev.h
+++ b/include/hw/ide/ide-dev.h
@@ -160,7 +160,7 @@ struct IDEDevice {
      * 0x0000        - rotation rate not reported
      * 0x0001        - non-rotating medium (SSD)
      * 0x0002-0x0400 - reserved
-     * 0x0401-0xffe  - rotations per minute
+     * 0x0401-0xfffe - rotations per minute
      * 0xffff        - reserved
      */
     uint16_t rotation_rate;
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0f896c27f47..db7d04119e1 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -117,7 +117,7 @@ struct SCSIDiskState {
      * 0x0000        - rotation rate not reported
      * 0x0001        - non-rotating medium (SSD)
      * 0x0002-0x0400 - reserved
-     * 0x0401-0xffe  - rotations per minute
+     * 0x0401-0xfffe - rotations per minute
      * 0xffff        - reserved
      */
     uint16_t rotation_rate;
-- 
2.52.0


