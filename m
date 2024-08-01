Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E022CC52D54
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXEN-0004U8-Bi; Thu, 01 Aug 2024 10:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXEM-0004TN-66
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:56:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXEK-0004UF-LP
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:56:37 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso3566631f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722524194; x=1723128994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=matng5Fep0g8jPV7m04ym4tW6NsmJ6p6PTM6YUsuJ80=;
 b=zSzjjBjx4UtjH1SKcasqD1xEiBD0QASkZVKCK7ypqTryiGmrDTg3AoE/SFcKv7f6yP
 IkYxzzeGvSK+suInc+9cwMNj+f3LtsZs3apTrKJs6aOTu9vf4GIHevmPZBcWx5+7dOpf
 Hgz6xvhnIZoAXnv6yRzuIbAsT/tBWkw81UpPkpHIEzSOiKlGBi7QgAPjdK/tL81UXs+i
 sGg5N4Giz3WuZgOz9sPLYbi2ihJgEqKpbYGOsKlctx1RnsXtov/I9iC6KjD9XWRamyuB
 QNVJjF53KMEfDcH5HP+GWjvjpA1o+3C7c/4Na3iF5yiCS725J45i4f6jJ+Xq7zkXc2fb
 YrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722524194; x=1723128994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=matng5Fep0g8jPV7m04ym4tW6NsmJ6p6PTM6YUsuJ80=;
 b=UR6q+zHiVoNXm+t0nW0ewaPii40UGqvpCzCnSkKgDFrNnG9qEtqK2Gnx6lZvJ9DCL5
 0v9hlvJLZYnEvDTK4r9M73xCQRue7ngUoWGIJ6nM/pqKpYgeCzVLej5HsTPK/SLg4dWG
 CAUwIqRWF8+lB75cEau/+BQziPzCJn8Mn9C+hlANiOnTiPLe0BhxI+0c7JUMC81VMsDI
 +ZSxp2jEpx78lciW2itPezua17tljS3Obo5BVmsH1Rus5ZVFlO3KNKrPiC3ilYL3BDZ/
 65B6Xf0NPVvCjqB7h+033xMWhggRP8beICD0DlAIw9xXEaOFgcc3JiOaoDF6oKHwo4sT
 58Bg==
X-Gm-Message-State: AOJu0YysRbNzIMfJ8l1vdjj9+t8X1zTKAJ3q5IqQW7eacB6ptonAFS07
 z0ASSI6MTy3MGjc42A1FfPOS7h0QA8dzqU4YtEKeJh0wAblXfmNYE8suF9nU+IXFk3AkhY+0k5b
 EP88=
X-Google-Smtp-Source: AGHT+IEgIJF3Pcc7dTIPhNjb66N+8vbFystd155o1igCjfg2BckBasPnv31URriBRC/4+TukKzHhzA==
X-Received: by 2002:adf:e98a:0:b0:368:3751:de3 with SMTP id
 ffacd0b85a97d-36bbc10d051mr64926f8f.31.1722524194104; 
 Thu, 01 Aug 2024 07:56:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0889sm19685718f8f.22.2024.08.01.07.56.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Aug 2024 07:56:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH-for-9.1 v2 0/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
Date: Thu,  1 Aug 2024 16:56:28 +0200
Message-ID: <20240801145630.52680-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

v2: Move reset values from Realize to ResetHold (mst)

Philippe Mathieu-Daudé (2):
  hw/pci-host/gt64120: Reset config registers during RESET phase
  hw/pci-host/gt64120: Set PCI base address register write mask

 hw/pci-host/gt64120.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

-- 
2.45.2


