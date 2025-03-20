Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC568C35FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvI7s-0003wN-Tq; Thu, 20 Mar 2025 11:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7c-0003ad-Dm
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:48:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7Z-0007qM-B5
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:47:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so6033655e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742485667; x=1743090467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQMafUmqG4jCB4tpUPdNT81l0E9rYtmlbZl+WPtco9M=;
 b=CyfBv4Q43ttytkp0Sf7OOkGge1f65BaOASrsihzsjB9dEQazIf7fSW38gDXksKcAXP
 06Kp8TMt26gVRiBujM4pm6iIXs/5DG1sZhl0XXc0RlBaC45Yl2lZivpoayroCDKHECHV
 IFo5u4vqkJ+VYps+W+gxdyPveRpS7iT/+GEIlhcsDHMvaAGQeTh/dNZNshxr2S+JlCR/
 X2xZdp2pX68FCBEpmKtN4NVynG/NvFY4aVOjm8d9QZR7FJ2htOyxZnoDRxqNJ7SRfnr8
 HwwLABLdjzz4Vn8qFA1fYZCAS3V442l+7joOq96RiY+U5gcxttJ1i6/TxKf+lBqIMT/e
 tDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742485667; x=1743090467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQMafUmqG4jCB4tpUPdNT81l0E9rYtmlbZl+WPtco9M=;
 b=PkMn6eV4DkwijWtp9NrMXf+c6fpY5hxXKg7VrsXr5B7wRFfBu4MK9psCtjYs+v/W0O
 vsCAcIFy4GMD9WN7ydDdWDbt2RwZnkX7VQIG6NlqyxVcCN+gCm2iToRFMbgvcsSprSr0
 b/TJUtI4qkwCqqYfgqe9A61r9oCa0aLjpseyNklE5AO8E09/uaN2JL4lQnfI/ZQFmBFL
 +x/KUK1E0VFkDoFRHf7bEU4p4XluZH6ssy65Ua+y8rRn4mh7EVU0atbXtbed1khP0tv0
 OpjCHTTA2MdvnOFyX1nuErJfkzbTkLNyIq1RRKrHQqoot6hG8NMhOt6AC1KuMoaKOtmA
 fFhg==
X-Gm-Message-State: AOJu0YyQdCAIOQQTnA/b3Zl6FCWXZzMs9WoJpai7x4bPDg4QmzxHllT9
 507cLUTpe27WOMtT9C8E2uwqEblgBBtibPMcqWSAny9WrNUYHjVrKxeoEWiq8Th+veJ8GBcIHZy
 j
X-Gm-Gg: ASbGncvudIYJRHI4YwGdySk2IPg7JMostmKETOt0LPaUcOgUWNCU/Puq6Ge8B1CMP22
 HohPeog4LDaadVPdTKH6GiRz5k+bqZDnTCUmE1C/cvzAWn8BpcHB+Sbk5WEnFxciqAxhLfjVv9K
 MeyKJuihP7oHBOP/rpHp5uF+F8WoLnQ7wjgKM3iipWb0BX3/T32oattlmyAlPj/cq+BzEleeaUS
 JYUOQ2S9qNLuMDcbZIFBRg+8FuopmzbxVhpO+C56jZsD/ubR2ecDBtVt2aBc+Z8aaWntbuEv2Hz
 unzQVsdpZvZVH4AFlt0PvX/VktROOd2vLJmUWxI8Em3gE7KEfZRtYgbCAH3g1gzle2+r5fk/aT0
 VXfrAAHiXTqX8bGadFKBs/gMy
X-Google-Smtp-Source: AGHT+IE0GHXcwL1EPJLeySkkI5jBc+dj/Z7qRdcjOeD3/cW/0uwTCweFRNPEdpm+UjWYVJZkDKknrw==
X-Received: by 2002:a05:600c:4503:b0:43c:fab3:4fad with SMTP id
 5b1f17b1804b1-43d437c3354mr79362395e9.16.1742485667346; 
 Thu, 20 Mar 2025 08:47:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43ecbsm52028545e9.10.2025.03.20.08.47.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Mar 2025 08:47:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 5/6] qom: Use object_class_implements_type() in
 object_class_foreach()
Date: Thu, 20 Mar 2025 16:47:21 +0100
Message-ID: <20250320154722.27349-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320154722.27349-1-philmd@linaro.org>
References: <20250320154722.27349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Previously classes indirectly implementing an interface more than
once were triggering the ambiguous cast assertion. Since we are not
interested in the returned class, but only whether it implements or
not, use object_class_implements_type().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 536308c0553..6733adcd6b2 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1136,7 +1136,7 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
     }
 
     if (data->implements_type && 
-        !object_class_dynamic_cast(k, data->implements_type)) {
+        !object_class_implements_type(k, data->implements_type)) {
         return;
     }
 
-- 
2.47.1


