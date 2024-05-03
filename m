Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC354C10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uyO-0003rd-VP; Fri, 03 May 2024 11:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uyC-0003Ko-MN
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:12 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uyB-0002l2-40
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:08 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a5991a443b1so179616666b.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750625; x=1715355425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMmV30WDdZVboe02eVG5MkgpkSOVDl1PK3DuW0Q/4bA=;
 b=e3rZfAfNzfl3zDIxymETYVhB0sL5Cfy1Z1ArZCvmwUZu0HpDnxbKqHg1I75sGs74SY
 Lu4wfHx+n00T2tO28hNlzPmlElDLQBzCRMz4EMyCRgoNupdaf240oKUelupZExBdV6rJ
 xaK9KMYdWuMoKyDed7Btt3823Ys3kK74DYaNwlHLdw7+wWvPgbH+ft8bZAIsxaV0DNHB
 pM6qSy4zg6FwxROb1TNHumJskZCOZ/OsLmG5CaVu+U7X2AVpFypbBBgp3sLkVyW5xZaZ
 vbCmmYAeV5x+OHyHBLXn1j3DtlqQeetFUvlGXKHx7qqjbhrDTS/UcXPqqfCbSbWVRQTA
 31Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750625; x=1715355425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMmV30WDdZVboe02eVG5MkgpkSOVDl1PK3DuW0Q/4bA=;
 b=IFpT1kwgSibfsixmFPo8+P0idTnhzW0n5OSFt7h5qAP7IozPeLZYJCvmXSxw/fGawM
 fuB6Q90TkSKcRqK4s2UTsCfOO0YaTWXduO7G4GXZlzdkfSJSXcx3LxOKqdvD5viyPSsd
 EbN2B1LgRLhTJO5H1k0FuwP+fMT9Jf820cPM93affUnBtsHJjR1JpqLyMmpwBLqaKN6H
 fYthB/0ewN1YZ7fWT2367c2+zpM248DiJn/tmXSHaDCWiw9HDM+OEtlytHgWXrbxZRGa
 EuOuafu4Zd5f54p4LnvVbfFxLVPLwlxW2mHgzMo7Id8tWFyTBNH/AdvockKZ706CE3eN
 Yjww==
X-Gm-Message-State: AOJu0Yy9NHOgJqF/ZJA9vrU81iLB2GwGZP/1OZSeqxPxHP+iQeZjuQCQ
 w1yhSfN/vDIpbw/OHr2i6ynFjMrhFcAtkgwie+BeXrobInH2H05UEHGuXosJn3ApO+HLO3J2B32
 u
X-Google-Smtp-Source: AGHT+IE1VuW+VHFXGOYmb5PVVtYpDBMWfYmCeR0Nvbhrkczf9UsXRNsJSBByKL8JSIe018n68UzSOw==
X-Received: by 2002:a17:906:f2d4:b0:a57:e5fd:a77d with SMTP id
 gz20-20020a170906f2d400b00a57e5fda77dmr2055447ejb.5.1714750625471; 
 Fri, 03 May 2024 08:37:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a17090655c400b00a5931d77634sm1825010ejp.34.2024.05.03.08.37.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:37:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/14] MAINTAINERS: Update my email address
Date: Fri,  3 May 2024 17:36:08 +0200
Message-ID: <20240503153613.38709-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Anthony PERARD <anthony.perard@citrix.com>

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Acked-by: Paul Durrant <paul@xen.org>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <20240429154938.19340-1-anthony.perard@citrix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96411e6adf..2f08cc528e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -532,7 +532,7 @@ Guest CPU Cores (Xen)
 ---------------------
 X86 Xen CPUs
 M: Stefano Stabellini <sstabellini@kernel.org>
-M: Anthony Perard <anthony.perard@citrix.com>
+M: Anthony PERARD <anthony@xenproject.org>
 M: Paul Durrant <paul@xen.org>
 L: xen-devel@lists.xenproject.org
 S: Supported
-- 
2.41.0


