Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A0BD29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 15:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhr8c-0001Sm-Su; Mon, 19 Jan 2026 10:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vhr8X-0001PH-3O
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:25:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vhr8V-0007Ij-BP
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:25:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so23991995e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768836344; x=1769441144; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rMGzXo7kijpc9pekkeTT4hBtuTYNDeWiB+UtqYt/1nw=;
 b=FELF5A0bK/G/pIL6aQ17T+qULaY03NoUX1cecX/Eda7tAsvGH45VyWo/9yRMvJmXwi
 O9kQv4Gi29ZAxrQJgnl7HwJBJ9mkvStHQF/wiM1ordhdPjHmpxYJF/hL8c9/bcW0GM5a
 eUyZ8EUdBESTBiThRoisYJIC8/avkclGKEoA71F3ojWArmYjHuzuQhkz3cjq1VUXAfnY
 q+4K1UNxfBVKJMPpusLwheUhvxg0oEpPBdT4oLsF84hwA8ZiT5ojeUHeqn8fxT9tRtk+
 PfLT2g9B36cUKZf+I88I89OE+Dh1+CpoTuN/FVEV76GOKQ5YVmFZgg6jU6b1rG2jcoAp
 KLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768836344; x=1769441144;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMGzXo7kijpc9pekkeTT4hBtuTYNDeWiB+UtqYt/1nw=;
 b=WniTMFMAvzM1ReH30sn5AebHOf1CUeLzXqT2J4TJPgI96PBI76hdOql7qDyFq2HE4D
 hAjgqmfcNfol501XXikACq3iT2+gvBBHDgoyjZE9XQI65WVZVh148NpQDGwTokAVYRos
 9lZZTpkSa1CAXSFDJaYAFNNOq437NLOL1Qh7AHo82ps3T+E+aTDgs0Ci7T8HG6MU0qih
 b6D5jvmNiY2/pE1BDDKlrF0zdwGPhBZO66Z0dNzrBjh09WThfLd/BZ6AkJssw7UpQDKU
 h/C7VOIAL66GuvBdr0HVdJs3Au3/LO3SaCLt7D66zoWNc6WNQT/MdCw1QYnc7xQqTDn8
 IyVw==
X-Gm-Message-State: AOJu0YyG+u/ceQCAvFVWnDsJrcUMJpkka6V+0A2Lf9XbjWvmbPLW1OvB
 IiWIGjPIVG8NyT+d37OM73u6hk5Oto1M7FJQT9ZJGFYgHm/UF37+cZ6fXdG9ed1Hmn4=
X-Gm-Gg: AY/fxX4lgjL++KxXQBdYLxVP4p1VSEc/h6QAHgZ1565VMP4snvP+LtI6NI6A8mmFipq
 8N/XhkpHJ7l7YP+exBFzxohLRIw+VbmCS2ttSYLod0ppQG9t41j11MQyJR+S6s/ypxxH8gI3av8
 zMF4SYNgh48F+qRMR6lWrcvqWrwyEt1+Byqh2hoM0Vnj7DJ9CWJAihzwDJl6oW/HX9TGo0xfJhk
 VPB2L6tdriLJCz5mDtSHNHe7eu23I2G8PQGMBt8jhYUajrsBE1/CinMVyk8zxGW3t1zKW8kWLiT
 fiHbPl4ximgThiZyRm1shpP0H3r4ZT5PBGJ8JztrRTcf0sk6OwkVeVzLpL+Q6Tl+piqWnYz9t9c
 hpx0CJjfFKD0y2pBH1Fx8ELjAmZYIFwSOQSCpPA/IlySlBHmzFePPnRZOy6l8TnbfmHpX2pXmgk
 W6wb/zuL5999bwzbg=
X-Received: by 2002:a05:600c:1f88:b0:480:3ad0:93c0 with SMTP id
 5b1f17b1804b1-4803b0e45e2mr15982835e9.23.1768836344464; 
 Mon, 19 Jan 2026 07:25:44 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:d8ca:2fec:bd3f:5062])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428acae8sm255355665e9.4.2026.01.19.07.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 07:25:44 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Mon, 19 Jan 2026 15:25:43 +0000
Subject: [PATCH v2] docs/system/igvm.rst: Update external links
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-igvm-documentation-fix-v2-1-b2f6174e3f4f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPZMbmkC/4WNTQ6CMBBGr0Jm7Rha0gKuvIdhUYdSJpHWtNhoC
 He3cgGX7+X72SDZyDbBpdog2syJgy8gTxXQbLyzyGNhkLVUQjY1sssLjoFei/WrWUscJ36jNn3
 TkqR7PxGU8jPaoo/h21B45rSG+Dl+svjZv5NZoMBOq1bVRmui7vpgb2I4h+hg2Pf9C61Pyl69A
 AAA
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32f.google.com
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

* Fixes link to AMD64 Architecture Programmer's
Manual and bumps version to 3.43.
* Updates link to buildigvm to new home on GitLab.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3247
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Fixes broken links for the AMD64 Architecture Programmer's Manual and
buildigvm.
---
Changes in v2:
- Changed link to buildigvm as supplied by Stefano Garzarella
  <sgarzare@redhat.com>
- Link to v1: https://lore.kernel.org/qemu-devel/20251230-igvm-documentation-fix-v1-1-865750a66cc8@linaro.org
---
 docs/system/igvm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
index 79508d9588..9db8ae43d2 100644
--- a/docs/system/igvm.rst
+++ b/docs/system/igvm.rst
@@ -166,8 +166,8 @@ References
 ----------
 
 [1] AMD64 Architecture Programmer's Manual, Volume 2: System Programming
-  Rev 3.41
-  https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
+  Rev 3.43
+  https://docs.amd.com/v/u/en-US/24593_3.43
 
 [2] ``buildigvm`` - A tool to build example IGVM files containing OVMF firmware
-  https://github.com/roy-hopkins/buildigvm
\ No newline at end of file
+  https://gitlab.com/qemu-project/buildigvm

---
base-commit: c1c58cee16380f81f88fbde6b12f247b376839e2
change-id: 20251230-igvm-documentation-fix-6a937c2cb9fc

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


