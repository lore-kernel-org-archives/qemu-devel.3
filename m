Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D621FF433CD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 22:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD8L9-0000I0-55; Wed, 15 Apr 2026 18:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8L6-0000Hf-0d
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 18:04:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8L4-0006YG-72
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 18:04:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso71823085e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776290640; x=1776895440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gLjCsJo9+pOroEIlYtanmlE+LE1B4Ag6f7dTvZPO3M0=;
 b=wRiV93BHqfOSegsHPBeFGIxJ+caGlO9XgJagv0D8UdcvPIBR1f691wpFbB97A1J4bB
 zQN09OZm85WSql5+IkGR5Lr1XeVXlOLEKvW/BkP8g4iew2vmyUuCvF59Ow93RKt1Zcbg
 R+xrRoo7kGDSJbgOiYxm7JmjLfXaHcY79lhrweWk8sa8x7C27Nrn71ieifzMlsDNbPcH
 07wY8UNhYTNSK7OjK7aP5zXD5Me/JkeL/T3Gja35jxeWGEac44JdwrHE2xnv2b5odUhB
 92WUP+XDDgmS+lhzNYuiLZ+FhE4vaZnp2Epvpuu3IKsqRA7/85g7Z9mPUbjd73dnGBCB
 OYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776290640; x=1776895440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLjCsJo9+pOroEIlYtanmlE+LE1B4Ag6f7dTvZPO3M0=;
 b=mWVO9McVw7OiTYVRsKs25D/T7EtWNO8T2vgNQELJwKwlmRgyNQ8QQHWkje6pnquw8A
 THhTjInnn+u1xly4e4f2Iav7PHp3lALl9aGRbcwy3ANUjrr0qs1n/W3FY8sHHX9BSfrw
 Esqv6fP+HnRbGPLEcH/EQdnSxEa+qabOsHTuBAIQctU4anpnSlRLPA1Qz3DZAN3ZsMxD
 2Sad/szPJG4xtKbX65qnXY3bCOlDE673p3i6lO8SFXwvg3st1snEl2zY33c0HATETGCZ
 nlxN9AzLUv/X8onHcd1/XOmIn8fAO+g3n/0f4pDTucIko2oTFAT57Fyaw0rOBjPiwMNw
 Fobw==
X-Gm-Message-State: AOJu0YyJ/V1HmAgooYSNqO2zZJ6xjqo3dKqAu5p8hcM5GJhIr5qj53c3
 WSGoswmDe6jEL06t+mpmUz7oqzrEmE4rcg2+Vma1A7TKjEKy8+tN3XezEHIN70BNi9oDWhxkWlO
 Q55En5Zk=
X-Gm-Gg: AeBDies5mAFjlY93wc7CO+PPLGWqE6WVQg2/joC/cZkegjF99nZAop7j7D30CG5dvzj
 8EHTPbUtMH6X/NdENYN5/9ZvDRxAkgPd5jgOuaEkfq/zU6onmXr5BEsxMiGItc2jd44bjW/RkxE
 uO5eOesT/sx5lF6W9RH+6E2Moxj4Dj0aAL77GJpZ9c6iB+tAu8O66HU1wSbzOURP+k31tH5n02O
 vkIJRuXjM2U2qlFbdLrRLDmOQoIreU3+VTk5DXEjHCpuqltNibB2wfH3uk7+AU5ZvflYAqeoza/
 w5eH4URDVVMSS9FhN/geMAL8c0tfax75lI0Opha/d+ud8z/x3QHTxNho3RjAeVTOE1BfxAl8QDd
 rHhSiyOjEP1QNvcGWGpHyaIrpYV39VlXY1TS++L/E/+/cUx4j96jAUEhPIeqanQ5LS/0H3fLN4m
 /q2XoTDgoyfhKA2xis4bLrsnynpe7IeVSSHnGh2w04BVCUo6lyzoy/fUMz9HG33gOU/yON5sil
X-Received: by 2002:a05:6000:2085:b0:43e:a70d:763c with SMTP id
 ffacd0b85a97d-43ea70d79b3mr13502286f8f.42.1776290640054; 
 Wed, 15 Apr 2026 15:04:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead2decafsm6999141f8f.0.2026.04.15.15.03.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 15:03:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/s390x: Prefer MO_128 definition over magic value
Date: Thu, 16 Apr 2026 00:03:57 +0200
Message-ID: <20260415220358.93063-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The MO_128 definition was not existing when commit 6d841663be8
("s390x/tcg: Implement VECTOR GATHER ELEMENT") introduced the
ES_128 definition. It was added 2 years later in commit 4b473e0c60d
("tcg: Expand MO_SIZE to 3 bits"). Since it is now available,
replace the magic '4' by the more explicit 'MO_128'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/translate_vx.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
index b53e9e52639..447641df25c 100644
--- a/target/s390x/tcg/translate_vx.c.inc
+++ b/target/s390x/tcg/translate_vx.c.inc
@@ -50,7 +50,7 @@
 #define ES_16   MO_16
 #define ES_32   MO_32
 #define ES_64   MO_64
-#define ES_128  4
+#define ES_128  MO_128
 
 /* Floating-Point Format */
 #define FPF_SHORT       2
-- 
2.53.0


