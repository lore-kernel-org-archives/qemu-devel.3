Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9512BC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSd-0005iP-4n; Tue, 01 Jul 2025 13:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSG-0005RL-IE
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSB-0003KU-0b
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:34 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so5017143f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389643; x=1751994443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bO/eRE0oLZeR5GcJzymVIXIdadc1wAcqQphyP71Niqg=;
 b=T3w7VavbYkhgsK00Yvi4EW08c2Lj0qJryjuhM16A5YFDWdZr3GPlFl0Sa+1O+0sxwW
 JEMZvsI23PiNmgwAmPkJ4jG+3FOgOu2xEPHZaz7q6ZOkfEriCc6ZHjpB0KUTJB3hif5U
 7S/mrOmvUbFyXa56YLeojiJ+SUrzKg7408ytfL/Y0DK5mlIV2wVa2niemGQrdr06adCq
 ApR6pfeEe8PU42EpZhP2hq7HlCUTgoMrayGkFJcJr1bP3c+VPL4wEJgrNkvdYZx4boYK
 3VW2WRJwrd+LiDx0hzzj+12UOQGJspbWWb8GRKcCXDhD6rtBgv2P9XgkBJ/BW/dG5z1A
 UujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389643; x=1751994443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bO/eRE0oLZeR5GcJzymVIXIdadc1wAcqQphyP71Niqg=;
 b=mv+Sg0/MJFzgZB2d8qK+fo90sW8GybDOsAQ4eQv2g0lIB7Wpa1UqdzLpH2XYtNEQ2D
 tqCI53Nrhq4mqm3M7wDUjI0Wgjp8e3r8Fx59GLQ7Tb+pK/QOhoeV8O6QmTStWIOkwVzj
 lTJtv4prZPZzrmbpx3x7YS5rp8ds46/GrrgkijsZLjYk8DRh3KrbHN8QS3lJOagfwxk0
 1Nwin2k+98pxi9n74ZDynniJR7DrqCdORSH/S+O/4m41W3XOGpcKy+0fma1SIjx5aXQg
 AsoYzMZiBRGjoMjE9FdUe2L/RjR5g/3x9CakglLGRC3Jg8qZbNilMjmkA4rvULIZa76i
 h9zA==
X-Gm-Message-State: AOJu0YyYd6DGZ+qfhKSnpr15ZY3IqNuW/EtBRQdJ+Yxz/WaclEtsGe44
 wjelhLxFSJDqlDaN0QXlGboOMsVvbGvIr3s2e9WFwhi361oqlqxR1Haovr6eJPzzINja19cNTpU
 Q8agf
X-Gm-Gg: ASbGncv17jePxWMRhq3oJem+yI9/P3sV1LyF97MeEwG4DpLLur/GrIXiZ0EBZkQiL7L
 mnIBhGieG+kYB1BVVKeEUW9wvIiJDOCUOwnz7oqVlIgsyVQTVzup7fMZuNCzkHAfUT0iC/SAWJk
 R0QJ57w+Ig5sp+BBbubQC/biY1JtpmyBt/HHO9fOxUvYwwSbR1DFDsQkYAAyKjAILSQLiJALKvb
 YmczQ6IA1CDe0zuDI+lH4WIL7lUx4pnYfmlfIsZgrPHQ9QOcUZCv0fJltdJmw7WjN/pUPDtLkFr
 ObrNCVL8zEzr4UApqzkp7ESrC3R7yCCZ3r0oytJgDGSCJo2iffa5RyzYj0YliW1d0oGO
X-Google-Smtp-Source: AGHT+IEYWLZxdobjA8crRmR+FwWhkomues9TZK+twHaLr9sCQp8g9mNHsqLY7Zr3JfWhZIWThh4CQA==
X-Received: by 2002:adf:ea50:0:b0:3a5:52b3:103b with SMTP id
 ffacd0b85a97d-3a90d0d6d11mr13527678f8f.4.1751389643455; 
 Tue, 01 Jul 2025 10:07:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/43] MAINTAINERS: add myself as reviewer for Apple Silicon HVF
Date: Tue,  1 Jul 2025 18:06:37 +0100
Message-ID: <20250701170720.4072660-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Mads Ynddal <mads@ynddal.dk>

I've both publicly and private been digging around the Apple Silicon HVF code,
and use it daily as part of my job. I feel I have a solid understanding of it,
so I thought I'd step up and assist.

I've added myself as reviewer to the common "HVF" as well, to be informed of
changes that might affect the Apple Silicon HVF code, which will be my primary
focus.

Signed-off-by: Mads Ynddal <mads@ynddal.dk>
Message-id: 20250617093001.70080-1-mads@ynddal.dk
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1672fda8dd..b3b2a112073 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -511,6 +511,7 @@ F: system/cpus.c
 
 Apple Silicon HVF CPUs
 M: Alexander Graf <agraf@csgraf.de>
+R: Mads Ynddal <mads@ynddal.dk>
 S: Maintained
 F: target/arm/hvf/
 F: target/arm/hvf-stub.c
@@ -527,6 +528,7 @@ HVF
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>
+R: Mads Ynddal <mads@ynddal.dk>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
-- 
2.43.0


