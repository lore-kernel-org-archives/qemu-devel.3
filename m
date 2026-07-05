Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E7EC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNx0-0007J3-OD; Sun, 05 Jul 2026 10:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwz-00079P-7x
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNww-0001TV-Q9
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8AY5qydpCSDNc84ZBXBXAVjwTf6BeQKuqySCp6fMp00=;
 b=PyBrBUzw7Tifmy2lsIYxg3/n/VCod/ytAlRRsZUtWyxM98TGIGNywJxiK3ElJonMP8Z3+S
 s5X3HJdzhhki5KX/bpy091poyDXzdgyHvDeYDY9prQoC2ahJrGBTMP8KBPboiOuxBtzowj
 jHWkCwepLL09ot1YguxVbvZR/d9yGXU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-i7ZHdpTGOkSEzm8TXHKm5A-1; Sun, 05 Jul 2026 10:36:00 -0400
X-MC-Unique: i7ZHdpTGOkSEzm8TXHKm5A-1
X-Mimecast-MFC-AGG-ID: i7ZHdpTGOkSEzm8TXHKm5A_1783262159
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47499916233so252404f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262159; x=1783866959; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8AY5qydpCSDNc84ZBXBXAVjwTf6BeQKuqySCp6fMp00=;
 b=HWwpzNhCbBxN8EnjXaJOOBStpINAhRlizdRVekVP3gOVUzcW+BjfE3mVKFkpE/IV11
 U6GMyj/UQ7RNOFGAJjLyP2nTWeJp2OuUtP/FLAFXPdS1wivfLKFKfyfTxqLQLijrnATY
 /YRyoPOu58S5SnuMNsRU8futLojFzdXuJkGkedc804wlk7Ghg3CZaOpuKWrRj2wu9hy6
 3+u8foX7aU6d70NGQH+qHseDAy/mopDjpYprx+muqgq277ZRIf7ZoBDAwNgGPtg72yFy
 7132+JgVfFQ1MiFlhuzCxifgT1VNG3rvys9W3Q/+wDp+85Y2a5oY5aAKMu5O/aAi74gd
 RRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262159; x=1783866959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8AY5qydpCSDNc84ZBXBXAVjwTf6BeQKuqySCp6fMp00=;
 b=gdVnz9954vTrIiM/i9LJlaSHnO4rcTUYu/kH0tAOtoB1bvbmfSE79LDbUfI8rbnZk1
 xYA5TBJlGZNiIJYdLwQJ6NAZJYLUJ3KZSTpJbOK5jP/H7WtEom7H43+VH/A05aWa6rsp
 Gb3yu0lN9V/rdTsM/xOtFqpHLAMIfu9ykbOQPkMxQc9yCZRId30GPFs/ZHsQkSSFDaF8
 QKED9gAw2H/UUEh/TNAT5VJuN7Kg+400nWeuw6dbcScwlAe8vp4H+mZVQsKnEXho7jei
 dYErhBd1kKZRbNjR4qupyXJI5fO/xXdPP1dI1RQBWKw7w1/bjdJmAtp+H8sjSrGus2cF
 aHsA==
X-Gm-Message-State: AOJu0YxzOcyAI/W6M9qwtWswP0oDdUeS85RN3Llgy9ZsEVRyNzOOBmQh
 GAeSQxyYkblI6CncuKTNmfQC3x1n4Tfm1QXBN1j1UjlkXR/NGLP1fXbJkQ5obWkSd1XHCp2IAaM
 WAGVUyb2wYHtC+xftIIPcnhmyPyhpPWUYRuSviW7Rp6ApGGca6WCKlytRbZi/h5STXhdZw0B0u8
 xHk2j3/ro21umHc+PSwOjvCJaKVkBFC4vpNg==
X-Gm-Gg: AfdE7cmLSRUBF8KZcZ27nla19vvBcW9T08KDLyLpRAMr/oMoicMax1sLgtgRdCQGaBO
 GutZPA4iC102qAgy4KHCst6AdOST1D3CHa4UOyqQepO6bF045Vd+t2fxquaP7+wCVoiSkNR/ZUI
 vztNIOIuHIOHbzLszTpx7mNejF29pCR8tNLWb3419ZrZYN1fwTNHgkYZbQSqhmieUDlrgqeVOjM
 OanTjCPhWgW8v3znDyEU0USLs8aQE1chQnKfswTMqJWJ8t3Zx8e8YxoAWvlJ4AJFByJ5GFHwut4
 zRgXaNSa4ffk1gX3lwdYVPBUi3vj9cSwn01i51+U9ZjyYgfc6/FcNdYdeanaGPuTeqpJqYFEEf4
 g3rUf6PFKVgamUNzhBKij0MV3VHNQvJgr
X-Received: by 2002:a5d:6e64:0:b0:476:681c:4642 with SMTP id
 ffacd0b85a97d-47aae0da59fmr4707038f8f.44.1783262159224; 
 Sun, 05 Jul 2026 07:35:59 -0700 (PDT)
X-Received: by 2002:a5d:6e64:0:b0:476:681c:4642 with SMTP id
 ffacd0b85a97d-47aae0da59fmr4707006f8f.44.1783262158569; 
 Sun, 05 Jul 2026 07:35:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21328sm16706668f8f.32.2026.07.05.07.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:58 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org
Subject: [PULL 31/44] arm: sbsa-gwdt: add 'wdat' option
Message-ID: <51011f7f36b4406718d9698530c4e9d920184755.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

it will be used by arm/virt board, to pick WDAT compatible watchdog impl.
and act as switch over to WDAT ACPI table vesus default GTDT ACPI table.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-6-imammedo@redhat.com>
---
 include/hw/watchdog/sbsa_gwdt.h | 1 +
 hw/watchdog/sbsa_gwdt.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
index 8941dcff9e..5ad7c7a798 100644
--- a/include/hw/watchdog/sbsa_gwdt.h
+++ b/include/hw/watchdog/sbsa_gwdt.h
@@ -73,6 +73,7 @@ typedef struct SBSA_GWDTState {
     uint32_t woru;
     uint32_t wcvl;
     uint32_t wcvu;
+    bool wdat;
 } SBSA_GWDTState;
 
 #endif /* WDT_SBSA_GWDT_H */
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 49fdd723c2..330a74798a 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -265,6 +265,14 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_irq(sbd, &s->irq);
 
+    /*
+     * WDAT spec: "The clock interval that the WDT uses must be
+     * greater than or equal to 1 millisecond."
+     */
+    if (s->wdat) {
+        s->freq = 1000;
+    }
+
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysinterrupt,
                 dev);
 }
@@ -276,6 +284,7 @@ static const Property wdt_sbsa_gwdt_props[] = {
      */
     DEFINE_PROP_UINT64("clock-frequency", struct SBSA_GWDTState, freq,
                        1000000000),
+    DEFINE_PROP_BOOL("wdat", struct SBSA_GWDTState, wdat, false),
 };
 
 static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
-- 
MST


