Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDE5CCD188
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6kic-0001Vb-LV; Thu, 09 Oct 2025 03:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6kia-0001TN-Ic
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:05:40 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6kiQ-00079d-Ok
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:05:40 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso402404f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759993524; x=1760598324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VDG448XtrKQ3EDXh9pnS/qdRH2s0i6parwObYHkKug=;
 b=dAMHPgiyZWNiwj1l35G2xOFieg7GLPkQmip0daBxGgW9o0g938puyntAsAJULlXosl
 unjQLr3vCgWI2CoMI3tHctyPYyjJtQnDFo32L4QBdtZkc7FIZJ12ANUO33DCda2LcXjK
 7NcROHymda6RhIG1MPsIXwj+HMnFzdR1Fbe1CJD/iO8bT83z1ciqXEQXmEVv2PlWM+BV
 o8yCPUsT+nFxqH711j3gdGB3DlybjQ1f8xxWgvek3F+jyUABsCK5AU7KPay5TfvQNjZZ
 cCs3/ilDdoFUEC6Sz1tKVB2vatMgMdM5CuaYhHZM8e6put/NDkhHPHNdddp7691IG8zz
 b6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759993524; x=1760598324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VDG448XtrKQ3EDXh9pnS/qdRH2s0i6parwObYHkKug=;
 b=Es+hYKgiEB5pkty1u7jBZ4iEs5rMq6s6ajKdpNfsF9g1+IleUXkOLJEkRMehi3jPqZ
 nISsn21AbMR1VNffhkZznF7IZr51Bht06F0ptZjy2WB6FpYsn8VHynS4zniRzlqdUaws
 JI/BNDKw4SaQMwPXLkWVCYmQ6C7cDA+NjfBfK/eNpXZG1QdnbbXa6a2oCCL3+EnDEUZ3
 NIi9PXCO9cJUx9K+BxyBgYGO7NtRgBaJELAQjrElH1HcZ0Wtc5KaP8d2QwPFsqA0bE0R
 NOjW8biQ6dFsksjBdqMwzQKsOQFek62okKAQUlv8U5vil054CvbudEqNGM/gx7x7E7Kd
 64qg==
X-Gm-Message-State: AOJu0Yx1LcAqupdVATjyTuaBlndWNbRbp5o5MPQCAaABZ/faeX1JVcMf
 Q0vyDIOhlERAOAPqIK7D/Yhjfv2dWocQ2sXK1kT4BO7d5XTE8ycAUv/drNZedsZ2DG2IpikOmL9
 wr62pZeh+OA==
X-Gm-Gg: ASbGncuUmVeaa4y6Cc9AlypMUnC4xagAVlpKRTCdkPye2E2rcUCkQRHIfNH4Zr6yfAJ
 B5EHTDcTmW1ww8QNSB27HrFKzaQTlHWlPV+54fY5GnQ4PVFwlbbH84njjKFOZlXRE7HHtx9hOyc
 IicXIx/tBBC0rhbZmbxXAixNSC/x7eKSIj2NwJ0x8f4h/9PrJFzVMmbM0UUch8gUZpSisWLm+tp
 C/oC/qh8piTnuAgQKr2B7uIMmRtv4uTxWnqL16VwSV1cDshoTyuCOcFxWecdDIt/17iCpKeYL4W
 cio5exLCKLTAOBmVvyTLROIhsof6K2HN4qaywJ8MGOHva22oWfVLAPDTXeKJNWBE0YY3r43voU0
 +arhb/x5WInWBDXnUVxM5Vbf7ArWtxNviRXpmP2zSeiQdg8ir/sDKQgdwr/Sv4i9TFG7BpOrztm
 UQzFA1dFq3bjb4b63QWJEGQsIF
X-Google-Smtp-Source: AGHT+IHA6ytH702lke0JDe9/LYtxY2xb0OohsJdCMcwUquegBA2S2wUWRxxmDHRLEyzIZkfcMNV6dQ==
X-Received: by 2002:a05:6000:1845:b0:3e7:6104:35a8 with SMTP id
 ffacd0b85a97d-4266e7dffccmr3883327f8f.35.1759993523711; 
 Thu, 09 Oct 2025 00:05:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8b0068sm33308819f8f.26.2025.10.09.00.05.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 00:05:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>
Subject: [PATCH 2/3] =?UTF-8?q?mailmap:=20Unify=20Cl=C3=A9ment=20Mathieu--?=
 =?UTF-8?q?Drif=20emails?=
Date: Thu,  9 Oct 2025 09:05:11 +0200
Message-ID: <20251009070512.8736-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009070512.8736-1-philmd@linaro.org>
References: <20251009070512.8736-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Do not let git-shortlog make distinction between:

 . Clément Mathieu--Drif
 . Clement Mathieu--Drif
 . CLEMENT MATHIEU--DRIF

as this is the same person.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index f2f83e8061f..a510b5d681f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -137,6 +137,7 @@ Chen Gang <gang.chen.5i5j@gmail.com>
 Chen Gang <gang.chen@sunrus.com.cn>
 Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
 Christophe Lyon <christophe.lyon@st.com>
+Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
 Collin L. Walling <walling@linux.ibm.com>
 Daniel P. Berrangé <berrange@redhat.com>
 Eduardo Otubo <otubo@redhat.com>
-- 
2.51.0


