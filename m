Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8DAFF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHm7o-00040m-8g; Tue, 28 Apr 2026 13:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wHm7n-00040e-2v
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:21:31 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1wHm7l-0002nz-NY
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:21:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d7650202fso8752153f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777396884; x=1778001684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kNowD0TcLYhrB4CuZH19TpRiJOZYqasUwam8Xxvtx38=;
 b=exPAF5yZrAT/IRxcnC99Gj5REn25JqbrhJrFRZJe4L0Pt44NyGGRtu8vRpccWWj7gQ
 fBThluETh48mk21+pnK0nzr5281NSpUZiIggat9E6hR9RPgMadnzkFmw2+g383DGy+wu
 sF5S0t4+D+rJ3AhKZBpO4mOVUsE/Y2S9TxnntBciXazxpOHmky3dAPe/+9rDlDF1b2m/
 xbRblEz2GXgMQfOM6cvMBSjKqBNeukjiJjTbWPq4qUKKYemUsLXqjAwam7euwtwws83i
 82/a6ggtfaIwSQDfW7nXfU6XsFL0ZjPATaSa94PCnm7oO1v48/WuP+7RPLmJd9IQpz/1
 o4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777396884; x=1778001684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNowD0TcLYhrB4CuZH19TpRiJOZYqasUwam8Xxvtx38=;
 b=aALjhv5xhSDIRCghzcHvmqJ6Y/dJRfNpUYwd364JZBzjhREdGvkmaJfJcRPcIbN+IM
 U4lMb6NO6IRQBnRIzv8dNiLS28AS8/GU7zbWdTMb7M8j/w+c/QdelxbYTc8DQqeBAPsw
 jg4AAxa4yMOcfmu/6ueaJAHnRYvsbD8VokoWResFEYmM/iCU6hWD8bSzexACKm/7/0lG
 eZPnakhoxHhKDuY+QDlz03vyr1dyyXDSZu9ZOa0K0b4rcXIcv8L/jO+cndROd4hIZ2M/
 RFQG9RPNBWR1DIVKS5eU+CI5BIH4LOhLu0Wa9eTAmGADOJkJ5bGg6imH1elcNrM1T9zz
 P8Pw==
X-Gm-Message-State: AOJu0Ywo0DUr0OZbiUBfPuU//z6OHtzx48g+APeOHMdzcBZraaDB3jmI
 d72X/uDBLnGhq+FWZetFaGhHMB0iUBUS/epJirnANBHqBInWsgkDg/G7pYJoqMDX
X-Gm-Gg: AeBDievs6Gx2akO/6ZB5sUSXDpTDgRzE2XH+YR2Fo0GYFGSj1n916501W71JEGOj+4S
 YA/lODRLw5thgmKb+6gD2HAisaQ6SihtJjOUNcnYo3k1pUHbO75+rGPGPghNxQMdT8brSxsW7z/
 cqDcdJblugOTdMdJEu6Dk+paEyh/OyZK3YKP5Ce3X1V4PgDkMlCabiR6svLTnsSupNqVIm6OSyt
 mWekgT775+zYut+GJrCqeGknGUhkpojCsu4Wvx/+KpwEzZdjTYP3x+phv+54acpjCdybCYSf/6W
 Rbp8AImEmIUguHfeAqed/hnRscudNgvFGKbq8kxHsVnyLU/ESwDKRNiT0eb11E6S5Kwfafz26PJ
 v3PYzXb/9oeu+9rTC9DaGqKrxH2sR4tJbxG0RyLN9QCGuegpvVhZYsBRnUwp3WJqyI1jNIuHYwt
 7N+bnioN8CS+kNahxXy4C5cVgkpCLxgnttD5JaZd5/9gpq/9ELhBOHUwUIO5xlC1EeYX8fSNKRg
 Jjb0L5gCH4RSWL/
X-Received: by 2002:a05:6000:2007:b0:43d:50c:6f33 with SMTP id
 ffacd0b85a97d-446494ea060mr7114729f8f.26.1777396883748; 
 Tue, 28 Apr 2026 10:21:23 -0700 (PDT)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f35csm9197860f8f.11.2026.04.28.10.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 10:21:22 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/2] MAINTAINERS: Add myself as OpenRISC board maintainer
Date: Tue, 28 Apr 2026 18:20:53 +0100
Message-ID: <20260428172055.1525176-1-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x430.google.com
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

In the recent changes from Peter I realized the OpenRISC board maintainers were
not properly documented.  Add myself and ensure virt is properly listed.

Stafford Horne (2):
  MAINTAINERS: Add myself as maintainer for or1k-sim
  MAINTAINERS: Add myself as the OpenRISC virt maintainer

 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.53.0


