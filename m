Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54393CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNOz-0004IS-NS; Fri, 24 Oct 2025 15:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNOq-0004HI-Pv
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:24:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNOn-0000PN-Np
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:24:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so1509619f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761333868; x=1761938668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBOD7zGmQL29Jy5BKEW2FN23f31HLnybiZZBlEWgQZg=;
 b=EH2uyZOtmt7YgXLFdQo8cLTw0uLQnhobHBCpz9r1+syW/aMOJ+nAW+mLMf/EXR/Bfw
 3IofXU7b58P/a9wX1r4/H005Lcvl1cOChs6hnFZbbglmTHOoy711kjkqzJR1D47D5xHd
 7224CNMqUZE28hJBo0hykI5Q+GAx4Pcp/cBBUyu54gRY/4bJ5N/8WLBy70VzyJIEBgDQ
 zA2CrVSuC4IdhbO0BalvrVTWsp4iYlevz+KYYxOKCcOJyMn80kkup5PDA+gyB8jRmC1w
 Y5SpdilaSvQaKb5TMVcOiQWBrzZXR4KzlBenlDMEpFr9l7cXwC5j/elIez79kIeThjSg
 CBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761333868; x=1761938668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XBOD7zGmQL29Jy5BKEW2FN23f31HLnybiZZBlEWgQZg=;
 b=sSwp9wGDiktZggUD1VJPdOOCUyBbHH8VQ9zjRUL3u/Xiz/wkNaG28C5yLPeROreOzL
 k4HYqH6G1S/bZNySGwU88op6sXxdeMblP16PCBiO8DmE5nciG7Q8BVeXgjJhLBeTxKn7
 32IZ5rwvg6eu+i3BJrPzesA9eAfFgxM+vqGEkOscqKIMzoEKPlZDLqqbOV+QagM6N2nF
 70P5pMwiv78HMpOrer8Zczj7PWHuYvMgm8c9SgKOf6Zsu7fTKXr9Fq164v1RenesHVjg
 IN72N3nyT0uQ9vLp/CSYbYp0UDdmGV6v+HWdXhYv53lNRIOmmKeZUiDRV4GCfg4F7OYZ
 Q7Ww==
X-Gm-Message-State: AOJu0YzKIIG3f0tGaD2DwkTra+IRQIpLdtzNET4TGqz6UsXJym03NSK6
 dFeLrb5RYlYbNOeXZo0HIowBeGX+473nSDcz8g0yn8OxtBTFtW/jUysRxOEr7t4l7x8BfBeredD
 ch/fWD48=
X-Gm-Gg: ASbGncvYk4xNHSKIWYnwQeC/sBAHiNCYWjay2CulYaubkkw5ZnuW8JgOPJDbF/9KTD2
 oBJhwa2VcR02GJsW4yTWEEfpAGBHeVtX9upPXvCdWctIpcyLuO+yDAA8RhZVxKSY9OA9YcLaF3a
 w9sArjgbNN7Yq+FqUWcMgftsP3ocXyzca8dFhFV86vnwH8oHSgNFNb0LOa+L/mAR0xQjsqK0Z0Q
 JrFMgDxJ6D+qDkpa01IGL/q9dQ/9kL2vcstbHrRJUX2HDqPpWz+7LFemOI3LCOatr/Ade5hkRks
 BucPGfThr3NlMJPUK/AfH3WAZuYQKwK4oXayT5ohTH02l1a1dYcuJ/pNiwL2Ph8uVowdao/x4yX
 lEmtkKYtwQMGpkqgfJKEmnFJQ8kgfQ/3OQ+CYBebFJXbLAo1CPVUfNDbRjBEx1oQq8SETIbeoqs
 WY30mEMTNX7ALDgMZsjqQ+54WhMqUxTt9ybTG/WT2MJQyAIUYHSPCOCuTkSBbU
X-Google-Smtp-Source: AGHT+IFmUFD3XEAIRtQ58ZOAzfKO3Ya/wsE5mgEQg5gxBdVm52AB3hHpG0XlML3dRK7B4iX1QQVuYA==
X-Received: by 2002:a05:6000:1789:b0:426:d54a:67e with SMTP id
 ffacd0b85a97d-4298a0bd14amr5540308f8f.44.1761333867766; 
 Fri, 24 Oct 2025 12:24:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897e76b8sm11104208f8f.1.2025.10.24.12.24.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:24:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 13/27] hw/uefi: Include missing 'system/memory.h' header
Date: Fri, 24 Oct 2025 21:04:00 +0200
Message-ID: <20251024190416.8803-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  include/hw/uefi/var-service.h:50:39: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     50 |     MemoryRegion                      mr;
        |                                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/uefi/var-service.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/uefi/var-service.h b/include/hw/uefi/var-service.h
index f7ceac4ce24..91fb4a20918 100644
--- a/include/hw/uefi/var-service.h
+++ b/include/hw/uefi/var-service.h
@@ -9,6 +9,7 @@
 #include "qemu/uuid.h"
 #include "qemu/queue.h"
 
+#include "system/memory.h"
 #include "hw/uefi/var-service-edk2.h"
 
 #define MAX_BUFFER_SIZE (64 * 1024)
-- 
2.51.0


