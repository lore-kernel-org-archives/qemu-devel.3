Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F60C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONB-00012J-Tc; Tue, 01 Sep 2026 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON8-00010v-PX
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:54 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON7-0007BH-8f
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:54 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c25344a8c6cso640520066b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268672; x=1788873472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XR5LpIFh5hEx0c+Fcku7eIeS/4QG0ngt9VN8SHvA1ms=;
 b=DX3QXncjb7ACXb9gp84DJEbha/MPAu6S8/f4sKq4ynfExMzEAm/17AoeS/NU/CIVAN
 tGtlX0mBSsbFJvs3Aa+TWjQ5vZo3z3OcaMJco04A3CMHjZlHmKwvSeVfA0aGhXiSJmGJ
 0p6Btmi6k4Otv5XSxa7grLP9uwTvNIqdaLIiHo1kOZ8NSC4aOB0DwoC3olmNM95mxgyN
 ZD+8j53hWyCXVk0nzX2s1ZB1x+5rsTm8oHp366N47eIjo0WKYdO9G2xrGeRDhYlCAMKm
 ayKulaaZjXTSFGRphVOP+38l2Zc7JOkXHVGr/lvT5k9TeZGFV/cPkpZtkHkZeRaV1Vth
 Te4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268672; x=1788873472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XR5LpIFh5hEx0c+Fcku7eIeS/4QG0ngt9VN8SHvA1ms=;
 b=Tdkgj2SeJT5uK6OZKrVweh4eSzW6bS6l0+74rhbJR4mrecGujmfL+2lD3hQcxyBVEN
 AbplOMiuPm7+4mSyPdfuXP/B89ExtgLtzSeqwy5V7AsOn2Bm77scbCIyLDVbKBN7Aj2h
 fCet3siXGfh0Ot4613Ceo8eKmPKPEWXSq55o1M1lfb9/HuzKwwMgaR/1nDqDiAlET6Bt
 gqpzKT/4tZVzCAP7fOba063fO9D2Us7Rk4gSUTZMMQqQ2cC3g/SsvGd0NpxSbq+fvEH6
 41jSwmMdhwyKPXm6t+t8iR4oahwl16L4Rh1EUkq0YHxgYZ8VYtAuu0OFY62SnhwcM3by
 Aywg==
X-Gm-Message-State: AFuF++no+++EXqsiQTJOnnf4kn8C6L3Y39pZ+QZBkDQlVlPFGakKfb+E
 i2KuqKDCeMFM+NNYYcnTwFJO3/bSYI/m04+n9UcD/7g4SYh00f27gYdWVsqP6G5zc4u+oHg4x4a
 q9fQrpM4=
X-Gm-Gg: AR+sD13g5Hfv4742cJSL44/4ggVuMPNaJIN4hLLZwe/d5ZkP0MjjgoOU1JM/L3GtbJA
 OsfWj/8mnfFo3ep5DUK6hVz1RU6b8YZoVNS2JUBvH8hbCr8taWjADZwQMXO2TM6HIIFIzza03+8
 59lwHmuNeAoo145NTFeB+y48zXpLdOFthJPsQLjaFwTLUGLQdEJ3exGATpkAmWv8iNt4NdB5WAo
 e0YQQXAXqt2seZFyxueRcWnmuNtmdAkA/c5Y9JIMFyhRendwlzbNlCw92Q+LloU4TmDrGl/0ivY
 It22GfwhoJYWu/DgmToVDWAfuM3+cSU7iO4mGn0yw4RLYy6JVPV6z5pLexhp6O6pTUbEC14Nn0+
 G04Bm4Gg+Ke+R/dAO3w0QkjNn4/A75WaFR2+jy6OjCYZOD59Qoe4Rr6dgLyS0ywccwQDNtktuL7
 5dNh4Nmh7Ox5gzdFBJG4ZlYK/jpsNphPdYPjzA7ctHf7t99yEX4mgo0IkC/NfRqvn7oHSqOo90g
 uiAxqTiWt5BOj5rfAAOyNbnvJE9lIGgO4fY4da8/O5089JFtObl77DCkWvOuPiA3uz1MhSsu/hd
 brcI
X-Received: by 2002:a17:907:3cc2:b0:c1c:5aa1:de57 with SMTP id
 a640c23a62f3a-c2557030696mr2098786666b.13.1788268671589; 
 Tue, 01 Sep 2026 06:17:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/58] hw/misc/iotkit-secctl.c: add SSE-310 support
Date: Tue,  1 Sep 2026 14:16:51 +0100
Message-ID: <20260901131732.2263947-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

From: Simon Xu <simonxhy0404@gmail.com>

Add SSE-310 secure and non-secure ID registers.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260805153005.9989-6-simonxhy0404@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/iotkit-secctl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 93753c2ced2..9f6fb81088d 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -109,6 +109,18 @@ static const uint8_t iotkit_secctl_ns_sse300_idregs[] = {
     0x0d, 0xf0, 0x05, 0xb1,
 };
 
+static const uint8_t iotkit_secctl_s_sse310_idregs[] = {
+    0x04, 0x00, 0x00, 0x00,
+    0x52, 0xb8, 0x3b, 0x00,
+    0x0d, 0xf0, 0x05, 0xb1,
+};
+
+static const uint8_t iotkit_secctl_ns_sse310_idregs[] = {
+    0x04, 0x00, 0x00, 0x00,
+    0x53, 0xb8, 0x3b, 0x00,
+    0x0d, 0xf0, 0x05, 0xb1,
+};
+
 
 /* The register sets for the various PPCs (AHB internal, APB internal,
  * AHB expansion, APB expansion) are all set up so that they are
@@ -232,6 +244,9 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
         case ARMSSE_SSE300:
             r = iotkit_secctl_s_sse300_idregs[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = iotkit_secctl_s_sse310_idregs[(offset - A_PID4) / 4];
+            break;
         default:
             r = iotkit_secctl_s_idregs[(offset - A_PID4) / 4];
             break;
@@ -499,6 +514,9 @@ static MemTxResult iotkit_secctl_ns_read(void *opaque, hwaddr addr,
         case ARMSSE_SSE300:
             r = iotkit_secctl_ns_sse300_idregs[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = iotkit_secctl_ns_sse310_idregs[(offset - A_PID4) / 4];
+            break;
         default:
             r = iotkit_secctl_ns_idregs[(offset - A_PID4) / 4];
             break;
-- 
2.43.0


