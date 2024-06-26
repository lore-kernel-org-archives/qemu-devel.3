Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C385C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 04:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMKNf-0001j0-3O; Wed, 26 Jun 2024 00:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hyeongtak.ji@gmail.com>)
 id 1sMKNd-0001fs-BJ; Wed, 26 Jun 2024 00:35:37 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hyeongtak.ji@gmail.com>)
 id 1sMKNb-0004bz-EA; Wed, 26 Jun 2024 00:35:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7066463c841so2936673b3a.1; 
 Tue, 25 Jun 2024 21:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719376532; x=1719981332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I4S7uZEPhH9ntgTMnCv9u5wHaTvK/eGeWAK0YEt+zxc=;
 b=NKdscHll1JtLpBdXFaUq17R+nlMXjMqazTBfPZHQmovJf+Pk0cZ6mfsCbCcxovdNm/
 mqYnRSe0u3+8KlkcmdptEnx4c9J1kPYwJ3JYAljxomY6Zg7V3ylffkXMhagVFaMwmJ1D
 qUSar05xyFJXyBqXlxFkSa6NCeMNb+ZbQDOvncx0HPIiD/mvPJZCtPOVHuyOQLz1RGxS
 J1BdlJoaGYFuTaZ/kwJxI2mZ8MWoSNtUNX0QlizwaG9+9DXZaZhR7+k29W1WLCgKSuP4
 P+3/Jsv3PfMlFnkdaoXBosUWGeMKomg4aqXOsdAQP/MqE3eBhxK+JEU5HfiPoKtrFgnj
 0HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719376532; x=1719981332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I4S7uZEPhH9ntgTMnCv9u5wHaTvK/eGeWAK0YEt+zxc=;
 b=goVOH2UNOAuzqT8zJ8hqT5pGOQNMDcfQr/zJscmHQTGZuLlLBRVOC+mHedTwFgSC7V
 kk7Q/0qFwShSosdp/cevs83ppC2ykFzYEY6NIlYK6gg72vicIlsl5+hlOOFrCO1YjM4w
 FAah+TSQC9HZTlV0bSjy3fNB+AQ+NqrCon9O7VXzGUNdq04dlmSvLQOwR0FwPo1MidhB
 /uuVwhuMg6mJm279fCAm55MCOFb8lZmWd7Re7pmEgZTaS5k4s+H20/++oNvjJufJaXXW
 8hd9lw2m5J48HrhzWGG4Kb4T7pceky9pI8NFQEsp/xaVzS5h3GL/c8eGPALcYLKn5FIi
 m2AA==
X-Gm-Message-State: AOJu0Yz91UuFeICNPmkFPF0W00A0XrDQWlzy5hRfEeNfzIMs5UhEqonL
 4r626Jph3sDS6jaSnoeqeuWNp/gzv+34mNMl23zLsnTKt2Xd0oebphPsfA==
X-Google-Smtp-Source: AGHT+IHda2j7hNxwnp7jm8bw5Ejz0/WjOfp9qcT85suJEa7NVgRHdnniJgzWzi5hqGwyHMyYeLtnOA==
X-Received: by 2002:aa7:908f:0:b0:705:bc32:5357 with SMTP id
 d2e1a72fcca58-7067459c765mr9065851b3a.1.1719376531766; 
 Tue, 25 Jun 2024 21:35:31 -0700 (PDT)
Received: from hyeongtakPC.. ([147.46.174.104])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-70668dce186sm7331775b3a.176.2024.06.25.21.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 21:35:31 -0700 (PDT)
From: Hyeongtak Ji <hyeongtak.ji@gmail.com>
To: qemu-devel@nongnu.org,
	jonathan.cameron@huawei.com
Cc: qemu-trivial@nongnu.org,
	Hyeongtak Ji <hyeongtak.ji@gmail.com>
Subject: [PATCH v2] docs/cxl: fix some typos
Date: Wed, 26 Jun 2024 13:34:58 +0900
Message-Id: <20240626043458.1446926-1-hyeongtak.ji@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=hyeongtak.ji@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch corrects minor typographical errors to ensure the ASCII art
aligns with the explanations provided.  Specifically, it fixes an
incorrect root port reference and removes redundant words.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@gmail.com>
---
 docs/system/devices/cxl.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index cf0a5143cfe8..a551d95455bc 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -218,17 +218,17 @@ Notes:
     A complex configuration here, might be to use the following HDM
     decoders in HB0. HDM0 routes CFMW0 requests to RP0 and hence
     part of CXL Type3 0. HDM1 routes CFMW0 requests from a
-    different region of the CFMW0 PA range to RP2 and hence part
+    different region of the CFMW0 PA range to RP1 and hence part
     of CXL Type 3 1.  HDM2 routes yet another PA range from within
     CFMW0 to be interleaved across RP0 and RP1, providing 2 way
     interleave of part of the memory provided by CXL Type3 0 and
     CXL Type 3 1. HDM3 routes those interleaved accesses from
     CFMW1 that target HB0 to RP 0 and another part of the memory of
     CXL Type 3 0 (as part of a 2 way interleave at the system level
-    across for example CXL Type3 0 and CXL Type3 2.
+    across for example CXL Type3 0 and CXL Type3 2).
     HDM4 is used to enable system wide 4 way interleave across all
     the present CXL type3 devices, by interleaving those (interleaved)
-    requests that HB0 receives from from CFMW1 across RP 0 and
+    requests that HB0 receives from CFMW1 across RP 0 and
     RP 1 and hence to yet more regions of the memory of the
     attached Type3 devices.  Note this is a representative subset
     of the full range of possible HDM decoder configurations in this
-- 
2.34.1


