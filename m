Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3B8CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQoA-0004Bm-1q; Tue, 02 Sep 2025 09:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQo7-000472-Rc
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQnz-0004cF-HB
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b86157e18so16793835e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818724; x=1757423524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BGV/b4AEUGgg2Lmee3eaJgstc5VLArS5HN+xqv3hQRw=;
 b=B523NLin8Lu61jTo8BBb3sUhpQD6VFYpujI/Yk7SGyukDkE7sc5tTKGtwvwXjJrIVL
 2gfE90QA9MUdONgyDJFdPvu7n4TfJ+jrVPCg7DzGigAJKUkkXp/emCaCkRd3gZU5IbsS
 P9qMOYG17okpVRAV4iyZZuVxRvI0rRih/CevOWyDLwOfUxUHMupwd4juTDCgeeb4NwLW
 +Ug9ckzTvVeAm8JwBQycEVTm23ifVCj3XtsSaaUx1QOahimoDV7PcwgmPGziAb7vtKBk
 33DbQfW6qZZlwDLvBHpL1e0jzkHGmPEVwBgOVpaqRjhebY4JFcq1gsSOJRcnlMDbVcHL
 hlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818724; x=1757423524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGV/b4AEUGgg2Lmee3eaJgstc5VLArS5HN+xqv3hQRw=;
 b=EFbYLCjpIt6sUdhJh+sf56samFvG3oZci7kTS3SSeDywo7uRCdyhOMa/ftKIgG62zy
 PFhowVEkYYU1bDiYQAR5tAAmWflWUg3u2DOjFYoJ+UaFY4veLkdoEmMwJ/ZY2DKEde/2
 Anz446xcBL3/5jkqQNE3qbVK9oUCdBrzCUlcIBP5d3HUwe3/cvjnpilT9Ev//MHYAVyD
 EWjzf7sXeg/HUVZPrnJkJNHH1Nied+anpHHfCjXJ173JUegTXlCHSxDSswhNgBbaldOc
 mFCsO4pN26kLpq96B2qfbNNOyiX/KMl8j89yRmuegBFZ1Y9nsGIciWLfwzfs/HJe4Aes
 n+OQ==
X-Gm-Message-State: AOJu0Yz2jQgWNqE3Glf5znFPAYfPCiAUmoQZ9lK+f0iwF6cG0CEJCR2F
 S0LqdUyhkNkf92jHUTBjEs8eDUvjfxt0xC6ZqAZ7un5VNWYG95dWUCmdk574cfVsHVFnOZuKX6Q
 ihRMc
X-Gm-Gg: ASbGncvjn3ppluip6Whl9ViAgd/8VtDhnMR5pyJh14KGMR3MB9VE2mMecgvY4NwZwcL
 HuHBZSsVD0ZSKiVGdaf5mywBh/fLjkzpXoPwVt00gs8CFGE9EaWgIFrSkYdC/mFbELzYwP4QLC5
 kSP5JpW8ZD9xHdJvH+mM6T8sL31E/bpBnOSo2LCfQcJMXAjtjPvN6XpmrdFQqG5B2HjV1CDKh+j
 hmwBMVOX9kgIr1i9CtBTWxZ4FYRUfik+iQBYY7tIWDJjYFfcCumxud0WGymKBOkCsKRQXtQvr49
 /5QdkfxAhABi+nahH2XHlYzbD//QEreaiEKuFKn2dymGXnhuRHDW517C42yyNXldxXJNRGewQK8
 vTLzihpx3nHB5xiE7eHsw2VI0kAWvILbUzvsdiV+238BMU9SACSMSBMgQM9r6FBnX4MJuVfaYO5
 RthLoPWYo=
X-Google-Smtp-Source: AGHT+IGgGMsB2zNrI6Qfc/XUXPNx5hudoOvsEWQmSzltg7fCg4ve8pBOYzezh5nKGaX+QZDXb6f+aQ==
X-Received: by 2002:a05:600c:5486:b0:45b:9c37:6c92 with SMTP id
 5b1f17b1804b1-45b9c376e30mr11451145e9.31.1756818724343; 
 Tue, 02 Sep 2025 06:12:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8ab832sm197197435e9.23.2025.09.02.06.12.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/39] hw/gpio/pca9554: Avoid leak in pca9554_set_pin()
Date: Tue,  2 Sep 2025 15:10:00 +0200
Message-ID: <20250902131016.84968-24-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

In pca9554_set_pin() we have a string property which we parse in
order to set some non-string fields in the device state.  So we call
visit_type_str(), passing it the address of the local variable
state_str.

visit_type_str() will allocate a new copy of the string; we
never free this string, so the result is a memory leak, detected
by ASAN during a "make check" run:

Direct leak of 5 byte(s) in 1 object(s) allocated from:
    #0 0x5d605212ede3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (
BuildId: 3d5373c89317f58bfcd191a33988c7347714be14)
    #1 0x7f7edea57b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b68282
9a6913cf682d75)
    #2 0x7f7edea6d4d8 in g_strdup (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x784d8) (BuildId: 1eb6131419edb83b2178b68282
9a6913cf682d75)
    #3 0x5d6055289a91 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
    #4 0x5d6055289a91 in qobject_input_type_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qapi/qo
bject-input-visitor.c:542:12
    #5 0x5d605528479c in visit_type_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qapi/qapi-visit
-core.c:349:10
    #6 0x5d60528bdd87 in pca9554_set_pin /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/gpio/pca9554.c:179:10
    #7 0x5d60549bcbbb in object_property_set /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1450:5
    #8 0x5d60549d2055 in object_property_set_qobject /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/qom-qobject.c:28:10
    #9 0x5d60549bcdf1 in object_property_set_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1458:15
    #10 0x5d605439d077 in gb200nvl_bmc_i2c_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/aspeed.c:1267:5
    #11 0x5d60543a3bbc in aspeed_machine_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/aspeed.c:493:9

Make the state_str g_autofree, so that we will always free
it, on both error-exit and success codepaths.

Cc: qemu-stable@nongnu.org
Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250821154459.2417976-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/gpio/pca9554.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index de3f883aee9..eac0d23be34 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -174,7 +174,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
     PCA9554State *s = PCA9554(obj);
     int pin, rc, val;
     uint8_t state, mask;
-    char *state_str;
+    g_autofree char *state_str = NULL;
 
     if (!visit_type_str(v, name, &state_str, errp)) {
         return;
-- 
2.51.0


