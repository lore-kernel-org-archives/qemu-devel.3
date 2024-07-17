Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEA6C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 14:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU5DB-0003up-5k; Wed, 17 Jul 2024 10:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU5Cw-0003r7-BY
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 10:00:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU5Cp-0008Ry-V2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 10:00:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42660b8dd27so47016115e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721224829; x=1721829629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FHIcAsY8i/uctUZuPeh8Vzd8dmu0Izzx+CInGK+n1jU=;
 b=N2HSN4YGVYYQLY9fwDMPiRIlVrEIkB0wBB8oX6NlML0nv6/pBRkM1Tz31G90THabAp
 sITAkn1l3QB4DWeIwwdb4JdbJfBKeZRO35bLpkeOE0cvewJ1CYGUh91bauUeIGXFoGFf
 QRMG+oqQhp/FNyKFTbmMWYPeOIjrQu/l+stwXLdzs7BtSlh2rUDG24mZ7kX0LsSHz1mR
 nbgUwzE3NBM0vpYax6mMHKxL6SGcfB9chgLUuo6nUxdt2Gzsuzdw/A4hsGr11TEI5ZFS
 mgTkd/Y0j5v7VT1qe+hf4adktuxylINyju1EKMIn2DcKwn0bL34Uzx9zPoF/VkCJvSJT
 JDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721224829; x=1721829629;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FHIcAsY8i/uctUZuPeh8Vzd8dmu0Izzx+CInGK+n1jU=;
 b=UfMon/iQey0a2vtMnA4FU+o2Ogi4KP6RoDx23J8JU7eK4nEW3ooDjSjndrwZm7p2X2
 1KWxQ3LG11wKgG/l+ilBeiYOBzvuj8TUGhsvIxm2YmnLwEuMjWFjQVdUJfN/AaNwHnFF
 I21PCJUlWZRHuVbrP09zEUN6WH71qNGdWOjPn9785//uPQ2vLKNteFSMsnJCXeyJfKsi
 AodatvtUvgMOHvHU67ycct9N5WIz84Qy198Yw+iMcU739Z6R6kjaOSB3iXpsthG5eRli
 gzREa5J847585fjCKD/zL1Z2l0GVjKg7a6mdMcK65ORxWh6kHmveDrVx7GBHku9GLu0h
 xdAA==
X-Gm-Message-State: AOJu0Yxur8lvG8C7zImPdZczGuL++E9qb8Vz8CREnJCU/YkdKrw5W0mI
 H18aicbwF6Su7A1QSeJ6AUMoglsuRpB+FSBigaeMXxIBj5+15x9qY3cnwkTSsGBmb9okSXtv2HX
 iquHKKA==
X-Google-Smtp-Source: AGHT+IHYjJJELgTXrMKTjxA122dyrxiF4b7r14wjlGidgbOSH95I18aBqD6AGJ1KRwmZKxDiMBxIHw==
X-Received: by 2002:a05:600c:4f56:b0:426:6f17:531 with SMTP id
 5b1f17b1804b1-427c2cb15cbmr16078185e9.13.1721224828687; 
 Wed, 17 Jul 2024 07:00:28 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27877dsm202323515e9.26.2024.07.17.07.00.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 07:00:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Dehan Meng <demeng@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] MAINTAINERS: Cover guest-agent in QAPI schema
Date: Wed, 17 Jul 2024 16:00:25 +0200
Message-ID: <20240717140025.66397-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d9811458c..af4db698de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3219,6 +3219,7 @@ M: Eric Blake <eblake@redhat.com>
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: qapi/*.json
+F: qga/qapi-schema.json
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 QObject
-- 
2.41.0


