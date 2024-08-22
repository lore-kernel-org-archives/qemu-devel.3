Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59843C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shAZN-0005id-3M; Thu, 22 Aug 2024 12:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZD-000575-FW
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZ4-0007K9-5m
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:38 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso7484165e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724343690; x=1724948490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRIh29OU7dNzm5XtXlrEQk7GPVofTkxU59XhpGGv5/A=;
 b=Aqig05m1LszCefa1p+WpMvLPgGz1e5vPghRll6xMHoUz/EcDSOHpEkHL5YXl0DWz8J
 lAvmMzzQHJw1xwV+nNoLXBZfFPcgwo54r24WYpH8HDvqMvobF61/5k76TlqueBfGeQoe
 vJ70y2R6GY0vN1Vx20sKPMKbq2j83IpZUWTa6LrJl2YKEb4zB9pGb26JHprUu2gnpsEQ
 5PhTGKwFsn3Ltb4i/IZy5vzeRq94dMZ332SqXE6T6IuOdAVBT/VMriwg8qD/zxDdeSMA
 NDAmiZZXX/XEm4i/GYR13oPTN4FIB+ZiYhc4CEaGHuyIum4q6Y+sA6lz8PJ5tKNHDAMU
 KwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724343690; x=1724948490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRIh29OU7dNzm5XtXlrEQk7GPVofTkxU59XhpGGv5/A=;
 b=UCDWTRi6pH/1Dy62WSMN+xlX1lY1jXoZAfcK5/9ROtMTAlAcmYbrPaAUZqlJii22nQ
 uv8whvY/XBPdym+CON/65PQtQRnbc7KM76lS4AHCClAWcAUU4eUM1nVzU1qfwxUoUAgM
 EU3sX2dVwxy1JdkUOmcjCneiZOmhYmUHJOlsRYUHjdPc4F1BPPRp/cP1HGxyziVjFO+0
 pIDCuM/JU2YojnO+hEp54uyIYfQLweCbEfMv543UJmmxdy0z11EdqHLyyZVmfrG3ifc1
 894bzwpnBUvNvYET9UGiL/KkSGux1b6MqFGTi9cSlFqaswL1CgJgSMtSee4YQymkPFSi
 gXdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ol+XsMMDThZOzC2yxjQWfABilIVpaVZyRV7xrzHIE6DFCVS+Xvtijbq0DYpaVWCm0PArGeq4ixBS@nongnu.org
X-Gm-Message-State: AOJu0Yxjjw5ADQkCGqqiPPvzNayvsdEJTgUD0vgxYO2elZR0Xc6DpMSy
 LUYdsxTYzVhyeWxGeR9al6Rweh0/cC31tGpIZFacZku5pJG4qMDw7ehEjg2y0qk=
X-Google-Smtp-Source: AGHT+IHizkunBMg1SWdGeNjOsoDPjIlI/EYVZ6LjgYznxfMhe9u18Wiz4iMSr6MvSLw9lQ3bNrPs1A==
X-Received: by 2002:a05:600c:1992:b0:426:6ee7:c05a with SMTP id
 5b1f17b1804b1-42abd23061amr43199385e9.15.1724343690325; 
 Thu, 22 Aug 2024 09:21:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac5162347sm28928485e9.23.2024.08.22.09.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 09:21:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH for-9.2 2/6] hw/misc/xlnx-versal-trng: Free s->prng in
 finalize, not unrealize
Date: Thu, 22 Aug 2024 17:21:23 +0100
Message-Id: <20240822162127.705879-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822162127.705879-1-peter.maydell@linaro.org>
References: <20240822162127.705879-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The TYPE_XLNX_VERSAL_TRNG device creates s->prng with g_rand_new()
in its init method, but it frees it in its unrealize method. This
results in a leak in the QOM introspection "initialize-inspect-finalize"
lifecycle:

Direct leak of 2500 byte(s) in 1 object(s) allocated from:
    #0 0x55ec89eae9d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294d9d8) (BuildId: 6d5
08874816cc47d17c8dd775e8f809ae520e8cb)
    #1 0x7f697018fc50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x7f6970197738 in g_rand_new_with_seed_array debian/build/deb/../../../glib/grand.c:202:17
    #3 0x7f6970197816 in g_rand_new debian/build/deb/../../../glib/grand.c:286:10
    #4 0x55ec8aa3656a in trng_init hw/misc/xlnx-versal-trng.c:624:15
    #5 0x55ec8ce75da1 in object_init_with_type qom/object.c:420:9
    #6 0x55ec8ce5d07b in object_initialize_with_type qom/object.c:562:5
    #7 0x55ec8ce5e91d in object_new_with_type qom/object.c:782:5
    #8 0x55ec8ce5e9f1 in object_new qom/object.c:797:12
    #9 0x55ec8d65c81d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11

Move the free to finalize so it matches where we are initing
s->prng. Since that's the only thing our unrealize method was
doing, this essentially switches the whole function to be
a finalize implementation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/xlnx-versal-trng.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index 51eb7600414..c0d1dde8708 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -624,9 +624,9 @@ static void trng_init(Object *obj)
     s->prng = g_rand_new();
 }
 
-static void trng_unrealize(DeviceState *dev)
+static void trng_finalize(Object *obj)
 {
-    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(dev);
+    XlnxVersalTRng *s = XLNX_VERSAL_TRNG(obj);
 
     g_rand_free(s->prng);
     s->prng = NULL;
@@ -689,7 +689,6 @@ static void trng_class_init(ObjectClass *klass, void *data)
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_trng;
-    dc->unrealize = trng_unrealize;
     rc->phases.hold = trng_reset_hold;
 
     /* Clone uint64 property with set allowed after realized */
@@ -706,6 +705,7 @@ static const TypeInfo trng_info = {
     .instance_size = sizeof(XlnxVersalTRng),
     .class_init    = trng_class_init,
     .instance_init = trng_init,
+    .instance_finalize = trng_finalize,
 };
 
 static void trng_register_types(void)
-- 
2.34.1


