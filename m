Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89932CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 15:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up7PV-0006nD-BK; Thu, 21 Aug 2025 11:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7PT-0006mR-OZ
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:41:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7PR-0006yJ-Pf
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:41:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b0c52f3so7116425e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755790860; x=1756395660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8msdbE8OOCV9QlavIWWqJy0H/EUNByvwJV0NVT0I2c=;
 b=AcKKCUoGT5TLpRMg173zpx2pCqqfuWWUtObzjrfudyD/Gkd3Vf3VcmqvHxHgpIS2bG
 6JNKUIxB09NaCZEdy6cby2AFkGmu6MIVfJ4DfV0IDJDRy5zRIp0F02rLzg+3xuDzNUAQ
 5Yb1GfkLZsMu+6sk1y5Gr4GVYZEAxnE1nGuPg69E9r21R6/kO9o0Vk8XPxyK7JUAQkFf
 tcAnYyGxj/1YD5JVV53IofLdfNSk2Gf6MPSMyqrL1L3M5pzPe4Q4Z5DVQNu2ZDvrCFi9
 P2VJdJH7vtvFTcbwyVITlRR61rmjO8L4mN3YiVqMeRfM0Ua51bvFCZHBQjT5B/Xu9wez
 4Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755790860; x=1756395660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8msdbE8OOCV9QlavIWWqJy0H/EUNByvwJV0NVT0I2c=;
 b=qpQXBnBUREPrAquOSPZnO41rNDym7+0YHbDhUgHIPw7JnVZX2yDqn5w7RkCs9OEUHn
 w9hphYU3E1RWg8HEbjjX36OMk8v6TGgk8qR45k/hhMRKT3csCXCjHPDvLr7pZ933ukUD
 DqQ2mt5tRq8k2GUpI1ZAoA5MtIWIJ+zheAxQFogD5bChEzLS9cODdnd/6NcLCVGTQISk
 PesC4nDD5oXGrqpjQe9woeVBg8t/4AL8RfTzg2TvLtn/OggiZqLWEz2lJrFQzbGEpkoP
 qmkCTtRWxXUCeFit/jy1EcKI4F1BXjW5OZzEJnbRtlQWXYNeE/5TA1WPMGZY2dHZxTaO
 hzww==
X-Gm-Message-State: AOJu0YzSQJ9JlhHUYg2nMe2euPIx9oi6CwwrSpPwsE8IQ6bxemekcNjb
 FFEjIGNF3Ao6VEgIaDvr3pb25sN1OM+kMgqOc5R3xoh+M0/UHP1+m9K0qLy6KIOQ47rbBmSTGHW
 JoUcK
X-Gm-Gg: ASbGncv5BygmX3jRiZzqPsxo8LgQUG8Yv4uCrahY21QI6HdsukGiVHoHMFLi4fH+LIX
 063zuUQ18lk5M4AwQhFmzxvCrolbgSkxX3GbmLhXOrqKReMH3TdLz1OYimMKKwV5i3Hwlk9+zKG
 EYyk9tdrj3TBUmJS7keF6tK58ZX/9r4rx1deq28v8DlOTo87kmUoEiNjp+k2aJTf/P1FGq3Q4zq
 aQ5ubYV+ANFHsmscGkGiVrE9j+uXaSDBI0VmkEXfWMz9YLYHQDna/Wqxkuo7qNr9j2Fd0MhAg9T
 jZ1NmvCA65x+QdxR2tQK9HnehXyPQ+JfWtRnUVBQQRJRZXfVFJaBv1MRtDkvEMvbzrMI67Sn9xr
 NwH+wenQVju2OTzy4MDb+/HPMBUFU
X-Google-Smtp-Source: AGHT+IGDClXur+75vbOkVyf+XDzkUWiNa40JGDxMzW1NKW5vW6ksdMxoRKHsNhTuRD/3v7AHQgkv7w==
X-Received: by 2002:a05:600c:4f87:b0:459:ea5d:418b with SMTP id
 5b1f17b1804b1-45b4d7dc6f7mr27644315e9.9.1755790859706; 
 Thu, 21 Aug 2025 08:40:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b50e0a479sm1443285e9.21.2025.08.21.08.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:40:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] hw/ide/ich.c: Use qemu_init_irq_child() to avoid memory
 leak
Date: Thu, 21 Aug 2025 16:40:53 +0100
Message-ID: <20250821154053.2417090-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821154053.2417090-1-peter.maydell@linaro.org>
References: <20250821154053.2417090-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
2.43.0


