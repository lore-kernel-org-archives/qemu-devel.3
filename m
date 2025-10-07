Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362D4CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68R5-00069d-Su; Tue, 07 Oct 2025 10:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qh-0005rs-Qk
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QL-0002Kj-KW
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so41124115e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846335; x=1760451135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PlsAz1YE54uBsJN/iqS/yfydW1uYs/0hWnLbeRXDss0=;
 b=QYEipsZnua0t9/z6VPZQVjf1TWFvyt5RjILb8CE2jbMEXWxY8gwMn24FsW/JYgzKzk
 fWiq9+SciEkmas5IZKwMcMKG1UGRLtYPCtCHKwh3CvJNeqMx+/NXR6/7vXasYTLkJAXJ
 LNJLdjFO4nbD8/nmb41XLH/URs7dj+DlqHyn0LOaRVuDNrbn2/EciWVEvkyBqn4p+j5q
 YmfeQoHnfsESvl+wbN18HZELqAqRbtYhRHTb1ME2UjpPdYYs8RfJos+jwjRpoSt2xn2D
 pcfcQFvSPzym0EQtYr1M9Bqovy8lcBBJe4tqopyKVYxf8Ha4NZzUNwH5pbMz5g2Mik3c
 VvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846335; x=1760451135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PlsAz1YE54uBsJN/iqS/yfydW1uYs/0hWnLbeRXDss0=;
 b=ZHeuzq6+tggMsEP+KEUXLVZM4iE58iNYksOmA5vTgxbt7i7n3DfSLwn+ApfK7Xs4BR
 M+1JMdbhP5RX458KGo4uqrCD0AYtjCBrgtQZ50C1Lb3uuctNlWP2wZSIJ781vUH+FT8p
 O6oDOZ+1SAnAG3znzNdEK9V3wr8NQ6GYoagvawLeZnywKuadNeHDiG99I2B+7NxFpUXU
 LehvKhTaDKmdct8tZz6AZSU57YJfpBL9vq/+yk4V9Zik1g237IkcFSL9xaMW3ARnwEih
 QPtrtvpArFKUTBn15gJDWlZmWsJ2ly1KMezR5mVC8Sf76MfjfrNUjbhZcJovBzKApJgn
 bBQw==
X-Gm-Message-State: AOJu0Yxns0jcbjVJS3n+MOUy1CqlJd+XJQQPYwKdES4onmjV6N/wLKH7
 e2omcXMyqN07JgT8iE1S64f5zerACpxDM8vcl/WIfiE4/2OL2n/Ba4eGKLrXJRZEEtlJ9EYizpH
 Jwxer
X-Gm-Gg: ASbGncupu8GI79tQOJI/3wjwEDsiIZLhW7+MSuV9h7ECY8II+keHhuJA7iRYNT1v0T3
 gelpWpSnOvPmW0tV5ae1kEcK62+WnANFIwSz/j469Si2LTbRPtaNNalS8Z23on3Bmuq5POqhrv1
 R+5viHCWNPW95xDJLQ/5zG5xFNX6e+U/DaNQDR4Q5G5/nx0Zc/Rqvuu0xxiEP50T0svxfSzAkur
 hgjtcgv44OqM/CzNM8AADYCvYRRkSL6JXmr8EnDEs8GE/Iw+8iKakDr61aT/iDTdcjhiox66dFW
 hkAfc5GW11Kx2x+G/hyeSatMOXvhWnw32DlBPnodPGzl7JTX8pMv3mTQ/eLp14C3z0OhUWfcsks
 A3lbYgTGXlT9eaXc3r2bneruSBAnZlrYVIU7O36wllBkNp5MU7pduS2f/
X-Google-Smtp-Source: AGHT+IGZ+j3AKsFpD0qdpsBXugJtbhdg9fBuW1ymcx+oyKIGyos5WojTTMbjMNhiUfCqItvQn56JfQ==
X-Received: by 2002:a05:600c:c16e:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-46fa298e604mr24797115e9.7.1759846335136; 
 Tue, 07 Oct 2025 07:12:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/62] docs/system/arm/xlnx-versal-virt: add a note about
 dumpdtb
Date: Tue,  7 Oct 2025 15:11:06 +0100
Message-ID: <20251007141123.3239867-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Luc Michel <luc.michel@amd.com>

Add a note in the DTB section explaining how to dump the generated DTB
using the dumpdtb machine option.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-46-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/xlnx-versal-virt.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 94c8bacf61a..5d7fa18592b 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -65,7 +65,13 @@ When loading an OS, QEMU generates a DTB and selects an appropriate address
 where it gets loaded. This DTB will be passed to the kernel in register x0.
 
 If there's no ``-kernel`` option, we generate a DTB and place it at 0x1000
-for boot-loaders or firmware to pick it up.
+for boot-loaders or firmware to pick it up. To dump and observe the generated
+DTB, one can use the ``dumpdtb`` machine option:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M amd-versal-virt,dumpdtb=example.dtb -m 2G
+
 
 If users want to provide their own DTB, they can use the ``-dtb`` option.
 These DTBs will have their memory nodes modified to match QEMU's
-- 
2.43.0


