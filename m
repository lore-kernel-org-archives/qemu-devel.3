Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF12E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwDD-0004Ml-FW; Thu, 09 Jan 2025 12:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwDB-0004CU-L1
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwD9-0000vY-PP
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:49 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso9434545e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443244; x=1737048044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEpqXVU8Ur/P9HPMuqzJk8wNNbtEkgm3VtINnkR/R0k=;
 b=SGgYfRvcDJz5NA85QIeegH2NGC9g0gQCpWSHQIOOc9HxyH+lLAB5QUtt6+NlvY0N41
 NSn2hvB8mHUcguDoOTBv1KJE09C5s6YM9xIOQZLYH51brxcheWf1HBsKUUisZnbkQP8q
 7p2LWn5PNaI1ORzeZkDyXSbOOFAiyDK5Pmzo0+Nk6esaP0vc5FX4JPT0EGosLkxnOMQa
 TjghTekRYGr8paMLMC10yao6rND12vzdvmacexHNeO26OIDBF6twapZFyv7VZXA3s7MH
 cr1ERlW4WZzX1aCpxhtOB8AD/lMtmaWVWFMKTgcLe1hf7xRT2p/OXwX1OHTabw+LybNJ
 QaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443244; x=1737048044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEpqXVU8Ur/P9HPMuqzJk8wNNbtEkgm3VtINnkR/R0k=;
 b=a0/qfn+jOW4lakdpEqJw2YAhhCFmQvSL8XWW2iARbjzq2cTgcAS1tYtDf2bVyMZmsP
 hDfyYTs/1bTeF7h9FdmLXczLTpR7x3+FFrpiSVuYz/hBdaHypq8M2V4WUho7azio7jmK
 iU8YWEMJZUchBYvcCtw85FYv1mGF4BQQynjJnCFpRfo7fDgRudUGZncIRc2OD+a9tgnp
 9bos3vjybMdPQwst6oLBTvquCzz3QlD39DvVD2zUiCs68tPZ3YOjugPzcpp+Moz+owS2
 ZGLC3TkKswprYqvLoBBg0JPtL63LKzkiD9vKw3rrbO+2kfP1qmZGQcUINRCr7IKD/U6x
 3m9Q==
X-Gm-Message-State: AOJu0Yyv9Xq7Y4Me2Km/1c94mugL+VHQ2ZwPhkZk+TCbVYLNqnlMJBDc
 iH6fxsYk9r9t95imQw1u+333w7XEU+z2MH73mRqK0t2tdoFAG81PVJi/TWOv/BHworL9PxYKLoq
 XOpI=
X-Gm-Gg: ASbGncuBXP5DOHUihpsSac6Nq9Ih/2GxPqpv/Oi/M1NIXFftw7XJrpkhgxGvaJUJ64w
 OL7jGgcbIz7OaPe+TvjXFp/d87NJQxVgUb4A3R0hlnd7HC/p80fbSIjRUcVf2qxlaqkEcOIRiNo
 bLyvcjZrdJXIvbrgU8nSQ0Gs/ANzvXxmLzn0aP93xh4dUqG35LPlj4ngSAu4Qcqki5Qu+5Chd7s
 j7qFedp1HCyFS6Eyyj63fcZbwprKO1EfzwHspuO1W/ADPSnmjmDVZq7P8vfxxmzUgrCpp0ExHqh
 aHsMCBTsyxGSYgwGkgvtZliVticzb97d/C7D
X-Google-Smtp-Source: AGHT+IHmmF2A+MA1ZCXsxdRGrsjDmUIhOzjDNv1N4dKcFmAOW946Kdq0v7C/tRY3Q6IHyRgJ95tm3g==
X-Received: by 2002:a05:600c:310c:b0:434:f8a0:9dc5 with SMTP id
 5b1f17b1804b1-436e26a8c21mr73170825e9.13.1736443244508; 
 Thu, 09 Jan 2025 09:20:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fb99sm27331315e9.3.2025.01.09.09.20.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:20:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/11] qom: remove unused InterfaceInfo::concrete_class field
Date: Thu,  9 Jan 2025 18:19:47 +0100
Message-ID: <20250109171948.31092-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
References: <20250109171948.31092-1-philmd@linaro.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>

The "concrete_class" field of InterfaceClass is only ever written, and as far
as I can tell is not particularly useful when debugging either; remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20250107111308.21886-1-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object.h | 5 ++++-
 qom/object.c         | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 77935572894..9192265db76 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -573,12 +573,15 @@ struct InterfaceInfo {
  *
  * The class for all interfaces.  Subclasses of this class should only add
  * virtual methods.
+ *
+ * Note that most of the fields of ObjectClass are unused (all except
+ * "type", in fact).  They are only present in InterfaceClass to allow
+ * @object_class_dynamic_cast to work with both regular classes and interfaces.
  */
 struct InterfaceClass
 {
     ObjectClass parent_class;
     /* private: */
-    ObjectClass *concrete_class;
     Type interface_type;
 };
 
diff --git a/qom/object.c b/qom/object.c
index 58897a79a76..ec447f14a78 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -314,7 +314,6 @@ static void type_initialize_interface(TypeImpl *ti, TypeImpl *interface_type,
     g_free((char *)info.name);
 
     new_iface = (InterfaceClass *)iface_impl->class;
-    new_iface->concrete_class = ti->class;
     new_iface->interface_type = interface_type;
 
     ti->class->interfaces = g_slist_append(ti->class->interfaces, new_iface);
-- 
2.47.1


