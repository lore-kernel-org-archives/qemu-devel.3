Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B52C44532
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmaOS-0005Iq-P0; Wed, 22 Jul 2026 13:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO8-0005De-ST
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO7-0001bW-8h
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so37170115e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784739942; x=1785344742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uhfeGe/4CB094Qsb3YMVun3IRBzdJrjy7hL+hy4mT8o=;
 b=obpby+CLkN/xw8MotLp2Tsz1rqx1ESd4U64wqCyGD0Ik0YYFcMSC6He9tsX/8pRp19
 wb/jhu2aQYknvWAuqjTghgvNqH5WWJ9yZS8reHqvju0ENffS3ojiThzDbxliISmw7/Cz
 FHAww/BvLbUOLqs3eJ9XGzj1dX9jVZCRLC89fhi2O02VS/6KZfqV+09WcyzZyUN3Jhbi
 V1EQSDUBl1rMq/gzJ1bkXTJKA2h9DG/RVvpaJsD2q3730tuzsx57TGZM45D+ehUke7au
 d/dh79FIg0GCghryJBfHwKaBLrCGMvBtQk1VOokF1fLsjYYY1OuNe5zvAzWCDtaavSGh
 /sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739942; x=1785344742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uhfeGe/4CB094Qsb3YMVun3IRBzdJrjy7hL+hy4mT8o=;
 b=mr9bOrVgf4iLr2ofdi5iOrFh7A3DqBl1p0/xE3fZ9zVVujj8EGZBGxNucAWfBN4/Li
 a0EImLO3i+1bNhY5wB0PeAtBBb8yPvLc8iHNGzIBoV1C6Mq2u9+U3S5eBYsHTZkcaf4+
 T2BSOIWD/O+zmVFasDHS6UvlIJ9Wzyx7rBIPDfL1S0CM3Lm90xDnpbX8QfeRygu3risZ
 sT0dMfhDiSKyFyvLC++n+Dhz7i/8gGOS2P4ZLs3ttKM6VWJEtwwQPJcbMwrGN1DnWue4
 gxP1cnazIm09FrN/B4E7tSZ8VxRngM2Xfd5aQH1V7c8HonoN5frGwpBICDhyy6j9lZ/B
 ksug==
X-Gm-Message-State: AOJu0YyL5GD8Q9b4v6l7NXHCFF85lP4n4aVZIEiZhTZGTJ8K0Arx+lva
 2bc1XRu26/oRhJCapzK/Vmj4tnAKlq9IbDq0HoJh1Er+vrolP/SRuUDiytx439Mis3vsFRON/Cn
 +CmPu
X-Gm-Gg: AR+sD13S/HTP2usOd7Bgq9k2f+WV1KWNwV29WPkLwI0QJ5Yed62eFooq2wHYCbYOXQl
 uj0SjKDAAiTYJ+PK29/a1GF11HLnPgaW7nXC76O5iNHvHS5EdU/NwFzD+Qw3LU7bGXO7U9TP2L/
 YF9btfsmH4m+8WLwiyMII8YwJCtsV4cSocT/vs9+IVYluU5mVbyD8ySAg6YHDGxd8AL1giyuj22
 Zk+ftLakJ4CmWOYNlNBf2PK1P44ZNPv5qEL3jlIq8e/yuU/Szxae06mExBCCXyvHbxzfhaIi2aR
 ONtIKM6dZg7BpZ/hIOrnieg5bkDira6ks0CyJ32qqvHkrt37K39Pi5eJ427SAfa5kdybLkDPwoR
 7Utn4Ei9EesOAHQSGzCEM9rmYJSqRFJLN3eszBfUYBmEANQYYi99wvbh6aqotf8k7FuNDLUPJGI
 k=
X-Received: by 2002:a05:600c:3b28:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-4954a3f36b6mr272514675e9.10.1784739941881; 
 Wed, 22 Jul 2026 10:05:41 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9c54:c407:8170:580d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b7483f0sm63993215e9.3.2026.07.22.10.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:05:41 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 9/9] MAINTAINERS: update parallels tree location
Date: Wed, 22 Jul 2026 19:05:27 +0200
Message-ID: <20260722170527.2593225-10-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722170527.2593225-1-den@openvz.org>
References: <20260722170527.2593225-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
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

src.openvz.org is become unmaintained, point to the GitLab tree
instead.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a28935c898..902db77218 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4393,7 +4393,7 @@ F: block/parallels.c
 F: block/parallels-ext.c
 F: docs/interop/parallels.rst
 F: docs/interop/prl-xml.rst
-T: git https://src.openvz.org/scm/~den/qemu.git parallels
+T: git https://gitlab.com/dlunev/qemu.git parallels
 
 qed
 M: Stefan Hajnoczi <stefanha@redhat.com>
-- 
2.53.0


