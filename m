Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DA8CD5BC6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC7E-00026l-ED; Thu, 05 Sep 2024 09:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6y-00018H-KS
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0001ka-Mh
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42c828c8863so6188735e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541273; x=1726146073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y0cwAM8oBFk44DfdOjrDHqS5VWYwMHEPi8SwQKNFB24=;
 b=AjkOTaSUEoN3q6OuNZBwUgTJFt1ID9NLssdKIKbqgxiLKRX98G/fYUJ1AaQ0U4A9dK
 oXNQTsryhpx8gUbrNInjBkVcewR7RXJ/17PNbQBvMEeE3o5O2LsOpZmPVIhwekzad9Q8
 /5WLogQk13vPowejvp3P0wKdI5hiG3z8L7Y3buJqjxMtgOUbnaUw70nHCz73ELkK2xuX
 5CSPp+oVXYRnVj4Hh23HKbe4M2xpgzxb2sCACm0sVPKrL7JjXgse9x8GjEWHJIE/xhYb
 MJeK9n9Faae1rVFgU6jTZwF6eXNbSPIKtxt/jwdRJRqo8vTlLkWrdlO+C6OvWTypysWj
 hf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541273; x=1726146073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0cwAM8oBFk44DfdOjrDHqS5VWYwMHEPi8SwQKNFB24=;
 b=mtW3P1DcBG1e3XPkJBu6M26v6sNrc/dk78CIs3h6rPwVlfTDn++3OuKkoJOzKAyIbc
 UVk4pp3Lpl3zDuzdtFzv4nAPZoq0SunFecNs/Q4ndH72NWnA5KeAEZ5726N6vHx1tQsq
 R9CXavPAfvMHVrIpFdoYzTqseoR8ImlEOKxrPtziEHKY/MKC3O724tg7ypwilULLOGtB
 fFDNHwSo/ErdP3AQUIybnBzvfijeBrl4L90yFHZ/n4FAGzb4IcN98Hpn+SXE/qipk9PG
 fOXMCS6oQqEbt7d+rdQqh3HS+7ImdMfv6GPi3dwrb3F3b5OzSILF390wjCYdo1Y4vWGn
 huDA==
X-Gm-Message-State: AOJu0YxqS+rrGJyJznm7A3Wt6xGQsTUawtC43f8Py7PoupR64jjN817v
 KxbttYWYl386B9HDBL9bVoh+o++VzNY1u5flodoUOrYwLeZXLOJ1tlEMjRl1LqQxT743yZ+oRey
 p
X-Google-Smtp-Source: AGHT+IGJ3W7t99Cqfi386UGov/THIIfOWqHa8vWwvc6Gn1igvYzLVbuTjrzBBCjvH9QzxWR24qeVzQ==
X-Received: by 2002:a05:600c:3d92:b0:42b:afbb:171b with SMTP id
 5b1f17b1804b1-42be48fa9e7mr113449065e9.35.1725541272976; 
 Thu, 05 Sep 2024 06:01:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/25] hw/misc/xlnx-versal-trng: Free s->prng in finalize,
 not unrealize
Date: Thu,  5 Sep 2024 14:00:50 +0100
Message-Id: <20240905130100.298768-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20240822162127.705879-3-peter.maydell@linaro.org
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


