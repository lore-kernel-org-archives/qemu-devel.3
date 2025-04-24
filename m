Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56515C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 19:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u82Zi-0003Il-9N; Thu, 24 Apr 2025 15:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82ZS-0003Fu-4j
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:49:19 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82ZP-0001Oy-JA
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:49:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39ee682e0ddso981290f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745524152; x=1746128952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUd7Mrc/+E/RovgnI7dK3dVHrdmGl00mXa1YhnjRtP0=;
 b=NcWyIHvyn0k1fNVghkECPweJkDyk9+vDxUUhRvleGJkgHDcFXf7HplGnynEWSh/1YM
 4DGRGfUSsVVO1EGWmSp0N5HRqgiRATnoiHFrv5p2HkUJElZXnByxa75df9w+XnTgOkFs
 HjKmA/6seaQ4ZicnfKVo9n2uvLyZxAtsbC6wfTJXtj4Q74gFSYAXtEXr7FOTRJnugP0y
 oN9m1lS6lH/CAiVLiGx+aq2zRzQFhCoqt34OBL1Mf0jXGsax/wIbfAzLgh4VgRIv//xm
 gm0hb3aBw1ZsCremt0Sac67Ztr72mHX2NKGRgtxucsGaCWTX2HToUvzzLhv59OxBZkPE
 AYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745524152; x=1746128952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUd7Mrc/+E/RovgnI7dK3dVHrdmGl00mXa1YhnjRtP0=;
 b=gzU1Dswb96xfBJMgK7H9UHJQCv3hrAbpg5mu5qDRWy0x2vw6X+UOw9aKYOvN+3Vz5/
 FrrgZNENvvJBmeERxlJHKSvEQpRhRZ35BY83LrOu6a92+kOVZmj4sob2sSg7McN3ZOSt
 BcLhIt6NFoN+WMLV6kydIpY81nVmS6JfaG3wLm83awUAPxjWLO004qqqFc5gTAm62hXG
 eOuSt0+3KbuKjKxzzhk80mQpoURgyN0TgpISdsrSBg0Ah1xsSB1DtAMU6JbujFPivEon
 /asjRSP4jO2Jfs4tZ1ESFhjSpfwbjx57TBTBQglKKSDVOblW6kMZoA/G9GcVmUhkwMDP
 hVjA==
X-Gm-Message-State: AOJu0YzfOOIfOyw3ntlY0ja5DIg5FN4GCsAoIBZAqaWL3lT03Gw5x918
 L5T1bw3wYKg/hpz7Ngqr2Fql2OhAY9VMjFUDnLfmnhOC9rB7JksFVZK1sIgBPXa1zzFyA8jvSlA
 g
X-Gm-Gg: ASbGncuQr1CQTswlGv+DxyjbzgMooKEKwnhey/yBFTKxSQNQJDOHhGQb7GoYvI/ezNt
 6HXvJYcfKgN1puaUt+ktaTW35TXoLvleEYp1upCIkocgPmTeAtk25WnuvW9lRRplKFzY5mzFZ4z
 G3/MIMcaYj2MdlSvQ33F0xXiaKqifk3oUR9DFixyqjUUOzHoTci/dnsEkEBqJMneOow5vn0fLaS
 PgHqtSWZRxqrV/7Fa3gisT70kD/xV/0VHlFzYSRQrhnqUR1CMHRyTpvPLC8gqucrtY0kDjel6Yv
 6r6tvbW+PG91/j2+9x1zpPyw16dfG8SQhik6B2cwRnqh00sG1dH/FP6qLPlqJ48o0/CiO1oriiM
 cyivdzZdcOcFwk0U=
X-Google-Smtp-Source: AGHT+IHOoE4sLSqdhiVZjogxJV9oQfLbLPK6smUy//53WGnXLckJQVes4qHnCDKtTdmfkxkj6tK5yw==
X-Received: by 2002:a5d:64e3:0:b0:39a:c9d9:877b with SMTP id
 ffacd0b85a97d-3a072aa6a1dmr554002f8f.27.1745524152381; 
 Thu, 24 Apr 2025 12:49:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca52e5sm227174f8f.36.2025.04.24.12.49.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 12:49:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 1/6] hw/misc/edu: Convert type_init() -> DEFINE_TYPES()
Date: Thu, 24 Apr 2025 21:49:00 +0200
Message-ID: <20250424194905.82506-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424194905.82506-1-philmd@linaro.org>
References: <20250424194905.82506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Prefer DEFINE_TYPES() macro over type_init() to register
QOM types.

Initialize the .interfaces struct field as compound literal
casted to InterfaceInfo type like the rest of our code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/edu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 504178b4a22..5723ef0ed13 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -429,21 +429,18 @@ static void edu_class_init(ObjectClass *class, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
-static void pci_edu_register_types(void)
-{
-    static InterfaceInfo interfaces[] = {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    };
-    static const TypeInfo edu_info = {
+static const TypeInfo edu_types[] = {
+    {
         .name          = TYPE_PCI_EDU_DEVICE,
         .parent        = TYPE_PCI_DEVICE,
         .instance_size = sizeof(EduState),
         .instance_init = edu_instance_init,
         .class_init    = edu_class_init,
-        .interfaces = interfaces,
-    };
+        .interfaces    = (InterfaceInfo[]) {
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { },
+        },
+    }
+};
 
-    type_register_static(&edu_info);
-}
-type_init(pci_edu_register_types)
+DEFINE_TYPES(edu_types)
-- 
2.47.1


