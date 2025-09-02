Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF82ECA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQo3-0003bo-Af; Tue, 02 Sep 2025 09:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQo0-0003M2-IF
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnt-0004by-NO
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b82a21e6bso25305005e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818720; x=1757423520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P7MMLvy2F0B/H0xVteB+a4geiLFU/+Hk/YVYg6d+sXw=;
 b=PRnz7njJUiWlLNx/wVp1VsYxr/GFCYKGubx6LGnxCV9E5f+iRkkqNypPb4e4nFaA/k
 GGSpVJTUjHqnBvBDfUTwTlk5WZ8PEkRJwELT0V0+CeVSl1/P+008pF4nOPjxQsNFya5+
 oQFsfJc4DLoFpWdxYjMUMYJ3x6shPJ5d9PR63Yu6twYuDavYJnu75FFto/7cVULNf9CA
 y4TU58HCbrZSbcwAotS3AjTt5RzC52iZCUcKPJCvKCAwjgVnoRiYKYICzsEyu6ECTvvq
 X8iHVhcYPvROTyslDjnnyl0yi5Zxj2cI1khkfUfSRyfo1vIgFybnGyCUFtUP+hplBSNx
 a89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818720; x=1757423520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7MMLvy2F0B/H0xVteB+a4geiLFU/+Hk/YVYg6d+sXw=;
 b=I4j36th+xdOpF2uOTE//LhBoLv/TjWYq4jo5jfGCAkJSOAORUJIXisJVP+8LGBRiKv
 4AjqeZkMO4bwRJQhHXeFLD+T5EIzJtD8Obd6tt8dBx+GVAevRcZQiIgzisLBooYd77eX
 8jeCfhoYovgNrQIGJRDE8iqW8k/kugucf4iufyk0+QOv6bRg1mqhnBwIgHxM5yxxB0eR
 KnjYYX0lQuKeISiu7HLeFBPBg5UzQrfgifXeAThmiOUd8quqmt8bxryKbKqXIhSSskWK
 QVTeBW8sQEIl4Pz222jLmvNTenDKgxbVWzWS75c6rhu6GBZGCQDTCO8LJCAE1kdMrIqb
 7lMA==
X-Gm-Message-State: AOJu0Ywqy59lJJk84FtfXXVlRzubrRy4Cd7HDi+puFIMa+aB6CrzKs/g
 spblO5llh8bYHQC2YaxDs8wEzUDjoVC9EneGMn8GxOeS04LRaSSNlLMrd0cBqFgXq4mZGJfhg3b
 FU+h9
X-Gm-Gg: ASbGnctgel380xLrpYjJaGNv5K1Eh81N2pB0vHVrjmFqBSwUyg6Vzw9wxZblS/lzuHT
 3KUGyAd8LnR9IwiamleoHnnqEruLFfLpw/HqWlNATw7eUd8XdaQY0v18ygYQfnYYlQ8Di0d2lgn
 1+telV5e04P5Np3WjAmcQXaJ+hQJQ7aCdUkhYSLU1BTthF74j0m2l/NjYFqBlkd/mvLAIuiGxNJ
 vdfD7WA13MgGrr7R1oe1ouYbF9grauLAGbWAIRzR+PTKY3fA1klIQp+bFHlNRqVue+qIF0cM+/A
 CIh/hJbzkRsadasQa/bcAVrargBUBVez/MIpArt4upZICwEWLpFxM2yO3jE2ACGgKxDNC8FZN8m
 T/M8xx4EVsxiQ+QCOjy9zgs8Cbz3k7UC9jtW2pr2bAcVYtPhnl3qddzG6KkyQ/815DJ1beJyaIH
 snRe3xAR4=
X-Google-Smtp-Source: AGHT+IEU/Q2GKKo8UlCz12NuLxKhNulzD5tAB8JJOYqN9sAGkVnc7J3BKY+Sr+hWTwxwk/4Iv5ba7g==
X-Received: by 2002:a05:600c:4705:b0:45b:74fc:d6ec with SMTP id
 5b1f17b1804b1-45b8553f1e8mr105150445e9.8.1756818719769; 
 Tue, 02 Sep 2025 06:11:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d64ba4ff83sm9214419f8f.4.2025.09.02.06.11.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/39] hw/ide/ich.c: Use qemu_init_irq_child() to avoid memory
 leak
Date: Tue,  2 Sep 2025 15:09:59 +0200
Message-ID: <20250902131016.84968-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The ICH9 PCI device uses qemu_init_irq() in its instance_init method,
but fails to clean it up in its uninit. This results in a leak,
detected by ASAN when running the device-introspect-test:

Direct leak of 96 byte(s) in 1 object(s) allocated from:
    #0 0x58f3b53ecde3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qem
u-system-arm+0x21f1de3) (BuildId: 8dcd38b1d76bd7bd44f905c38200f4cceafd7ca4)
    #1 0x72e446dd5b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1
eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x72e446db745a in g_hash_table_new_full (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4445a
) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #3 0x58f3b7c6fc67 in object_initialize_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qem
u/build/arm-asan/../../qom/object.c:568:23
    #4 0x58f3b7c6f670 in object_initialize /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/ar
m-asan/../../qom/object.c:578:5
    #5 0x58f3b7c6611b in qemu_init_irq /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/irq.c:48:5
    #6 0x58f3b5c6e931 in pci_ich9_ahci_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/ide/ich.c:117:5

We could call qemu_free_irq() in pci_ich9_uninit(), but
since we have a method of initializing the IRQ that doesn't
need manual freeing, use that instead: qemu_init_irq_child().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250821154053.2417090-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ich.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 4cade0d1219..b00987f08d4 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -114,7 +114,8 @@ static void pci_ich9_ahci_init(Object *obj)
 {
     AHCIPCIState *d = ICH9_AHCI(obj);
 
-    qemu_init_irq(&d->irq, pci_ich9_ahci_update_irq, d, 0);
+    qemu_init_irq_child(obj, "update-irq", &d->irq,
+                        pci_ich9_ahci_update_irq, d, 0);
     ahci_init(&d->ahci, DEVICE(obj));
     d->ahci.irq = &d->irq;
 }
-- 
2.51.0


