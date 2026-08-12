Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44851C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 11:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu755-0006rw-D6; Wed, 12 Aug 2026 07:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu74z-0006rC-3v
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 07:25:06 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu74w-0005fK-49
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 07:25:04 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso391309f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 04:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786533900; x=1787138700; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DQSkUcg1XDS9Ba2uGaX42dvSCDf/Me0rEMoUd/1hjq4=;
 b=LzbwvCnzU8vWqAUGWd2YKj01sH3GepPnrxtSbRNFccAJhV37m26aLhOcl84XBUH9Gu
 6nEYTogBteG8vCZ5uBqHKYwAV4eTm9eShYBhnWXiPFT20xEryxzGiUKAve76dueSy9/Y
 tpaM4I6GMcJKKmhr3KVJVyfiTpVrjUAhDiNHNx3XKFMdYux6UUFCTsepAzpAV7e8daBA
 NS1hyj80DE65uDOM0229Ymgvgi5tPjI0UYBmLQU3hu+jJeTYJqd9I/JJFVk8T85ROGV2
 N5t8xU3/w1cqb11F9hQrGuFVkSVnZPASkgjliOklapgngtuEOdMLYeeOVonQsGUGI031
 HNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786533900; x=1787138700;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DQSkUcg1XDS9Ba2uGaX42dvSCDf/Me0rEMoUd/1hjq4=;
 b=K9h8afthTYHKJPKz2YrULBMUVwCUnvMCpF7g5pu1tmYwZyUI2kBz/o/Qrvx9DNtf9e
 eAQR1n1Gjn4y4et40/lbYWfmV7EmVGsKas+Q2PS/4wuY5QVZaQTQv1auKukNCle9kZWa
 6ZrnTDRODe8vtFhvwonJHzoF2CasAplzpE/c6fku06MpShLqSEXodIhNUVaqrt8X/JrB
 zCNItuiO0D922uKgZc401lmVgc3/+MlL0JbIAN/dN+eMQqG3UWLXsUeK+QU7CddNMZFc
 dMEIqxlV7zAfPWcr2StF6KkZb5FWSlxuYv3gnD8w8xHozkozbBgtsjRq1fd8z+rhYwh+
 2C1g==
X-Gm-Message-State: AOJu0YyrW4wVPbG1PJLy+1jjrU5QoLdemC2Y0eT+rp5+4z4K//lwC+p2
 NbpeJ+WN/j4yRUqby5t/WEMVYuIvEyPa+bdyhBz3caSZtksJpIpMTQjGMOr2bC1F/MqQBszVwfM
 xeV97
X-Gm-Gg: AR+sD10pxbnv6FNeXY8QQO/+bb3Fu1tkFO2XL1gjyxYVKlAa9g6bUrM9mK6TYKIikt2
 2YUVQHJ0yrHW5ROHM0RrmtUyA5PQE96oui/g7L2kNDOyEuNM54diQ9/gN3rCYJbTqlSAVCrIWEw
 gLJgFf1O9kP0z8d5rdHSzy+fPT/Bar/M+FBbJ8/IKLxFSWoP2a+IK84CLWXOaaQFX/sGgytCtgk
 3P2i0VeJOjZG1JxHSNeBB5C1vRwfh3fA8/ln2eATEay7L9NDRt94P0lfrIxkPOb+4DPhp20zyma
 t+bHfoXmF1NhA6rLEAs1Di/gH9CwJeLDUpCBo8RuHU0/Tst65lR/2ZQUo7XomvXNAh68I5OwVRN
 sl/BJOouRmp5vsyXd/blSreMzmSQhd9lAvkRCAeO2eOCEQUXCsg8t5WO76QJiE+gocbiHyDawBr
 EZSsjYOh3FDZhUBfzEon0rky191cCo99g2Ux1BwMs3cOPJCGEWvUBkq9/6jQ==
X-Received: by 2002:a05:6000:2890:b0:477:47c6:36e5 with SMTP id
 ffacd0b85a97d-48152c784eamr5157265f8f.25.1786533899567; 
 Wed, 12 Aug 2026 04:24:59 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:89f2:ad10:d9bb:681e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d4e400sm7041627f8f.21.2026.08.12.04.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 04:24:59 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Denis V . Lunev" <den@openvz.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] mailmap: map the last From-munged author back to a real
 identity
Date: Wed, 12 Aug 2026 13:24:56 +0200
Message-ID: <20260812112456.970371-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=den@openvz.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qemu-block@nongnu.org rewrote the From: header of commit b67e353863
("block: drop force_dup parameter of raw_reconfigure_getfd()") for
DMARC reasons, so it landed in git attributed to the list instead of
to its author, whose real address is in the Signed-off-by trailer.
Map it like the other munged identities collected in that section.
This was the last one left unmapped, so 'git log --format="%aN"' no
longer reports any author 'via' a list.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
CC: Alex Bennée <alex.bennee@linaro.org>
CC: Eric Blake <eblake@redhat.com>
CC: Michael Tokarev <mjt@tls.msk.ru>
CC: Laurent Vivier <laurent@vivier.eu>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e5dc644623..08f0fa9e11 100644
--- a/.mailmap
+++ b/.mailmap
@@ -68,6 +68,7 @@ Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-devel@nongnu.org>
 Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-trivial@nongnu.org>
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> Andrey Drobyshev via <qemu-block@nongnu.org>
 BALATON Zoltan <balaton@eik.bme.hu> BALATON Zoltan via <qemu-ppc@nongnu.org>
+Denis V. Lunev <den@openvz.org> Denis V. Lunev via <qemu-block@nongnu.org>
 
 # Next, replace old addresses by a more recent one.
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> <akihiko.odaki@daynix.com>
-- 
2.53.0


