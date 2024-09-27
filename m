Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5319CF6483
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suIms-0004pA-2N; Fri, 27 Sep 2024 17:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suImq-0004n7-Fb
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:46:04 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suImo-0003ws-Uo
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:46:04 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37a413085cbso2572286f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727473561; x=1728078361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1vHxexCTLbdRB8r0KvJgoIHaBve1hvZ62MNg9aoNm0=;
 b=NiCuqekYQvacC/zN+941Yi6PEy/hLXyBY7AG4dS3FtRi8PXf2cI+Zx2j6l3PDD5YQv
 kq+UgfRubfUT2i2mRi1hmcnIKb0wKcRKrjUJPbRgwdf/+1JmBoHs7k898U/KTOKoH4Io
 fjzS75vVlUMd7Aa8vkmD4vEc0qMzv8AcKoXX91L73Bsr7aoNPGOhbsBwOM4M/+9u5G+N
 gs9RoMiRTAZnv8mbdsIoH+MnU8CWU5WIQdtYVBui47x0XTi/Z93v7Rp7QGC35VQfPkRL
 10BZ/aqLqaKjSIWZcMz3UHy/+7fyaFZQHWmUoQo+G5O+jzOBK3rWMGMOIccts1jcm5LU
 FKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727473561; x=1728078361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1vHxexCTLbdRB8r0KvJgoIHaBve1hvZ62MNg9aoNm0=;
 b=UyEiW1Uc6wsjHEKbguLTDz06I1XAe94yvLpxeAywg9ZTuHgpe/A8+AeGXxEz8lvGqQ
 W1/U7SkdmvEleF6gdyY5sRLMfdcjMSHHrD0z6QLpVDiqW8BrGJRDP+An06ybloDSJc2L
 ldHNncqmrxwA1I+Om1XGGUXTOj0y62/jGViIPhCRM0hS6O4Kt4dzXeCGGf7Mr+Ny+stQ
 OUpDhRGKKHz9GWOr2W8XMrQT8oF06CsJOFxvUsq2DlGAg+KGbGyTy7DQ+1FV0G/dyh3y
 Pb0u/7xb4S764zC8v2CUDOiGOWH/PcP4w686zGaFKdx4FSyrQ2Cwwvcft8/odYF8yOVB
 Xq5A==
X-Gm-Message-State: AOJu0YyeOe4KzXBFml+5nc4vlB3YNcoGlwacVPo32dmacXMx25d63v8s
 /REI6tY6gk0+0EUUAT9BzBxR/7XC/6t96wB9xqzfRMjLI/CN3lsR6+M0+c21GanGk5WRfu4a9Q+
 P
X-Google-Smtp-Source: AGHT+IFE1tGVpbwj+SZ3EdB+7yU6IoGhvZLxv1moKmf/C9kyFjiXutvmrPG4Fe3YjdY6hgN1+W9tow==
X-Received: by 2002:a5d:500f:0:b0:374:ba78:9013 with SMTP id
 ffacd0b85a97d-37cd568e21cmr2908343f8f.9.1727473561121; 
 Fri, 27 Sep 2024 14:46:01 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd574282esm3373982f8f.104.2024.09.27.14.45.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:46:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] net/l2tpv3: Simplify LD/ST API uses
Date: Fri, 27 Sep 2024 23:45:31 +0200
Message-ID: <20240927214531.20242-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927214531.20242-1-philmd@linaro.org>
References: <20240927214531.20242-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Directly call ldn_be_p once instead of ldl_be_p / ldq_be_p.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 net/l2tpv3.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index b5547cb917..7a0d5dcfe9 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -318,11 +318,7 @@ static int l2tpv3_verify_header(NetL2TPV3State *s, uint8_t *buf)
     */
 
     if (s->cookie) {
-        if (s->cookie_is_64) {
-            cookie = ldq_be_p(buf + s->cookie_offset);
-        } else {
-            cookie = ldl_be_p(buf + s->cookie_offset) & 0xffffffffULL;
-        }
+        cookie = ldn_be_p(buf + s->cookie_offset, s->cookie_is_64 ? 8 : 4);
         if (cookie != s->rx_cookie) {
             if (!s->header_mismatch) {
                 error_report("unknown cookie id");
-- 
2.45.2


