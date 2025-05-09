Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09993C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 11:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDLZw-00074i-2u; Fri, 09 May 2025 07:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uDLZl-0006tA-N5
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:07:35 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uDLZk-0000iS-2V
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:07:33 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-30a93d80a80so1697053a91.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746788849; x=1747393649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fsmfHrclO/ZhH0M2xU03zDzze+DzH7GdaKXlzB+FH8Q=;
 b=wn8/PRVCC4nMxQ8uVkVIrgSDYxXi7KQEXR6797swOKPZLlsSELlijequoZkvPLlwCV
 YPPEDlivs94zziiNxLukRMOb/FdizWil9Oeoad9DN56FnyO2nNSWZqA0MmvpxvbTe8wL
 zuLALxZGLaDxmaibqgt0AjNng6v/YOm7VN83LeBFRuu9n8MO0cmcrYSfYFffhIFs6Jsd
 c4PawXZd0cyN6Roi/YRUIY+uJvt6vojH4gkw8II+sl6KVXKq2Z1RiUNmomaLRbNlVtXE
 kDhCsc8GJOEiZs5qhwi+P4/u1EboqX4BmtDOQALnc7XuYwUkZqwN25lukLd+7D8vi5mb
 Y3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746788849; x=1747393649;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fsmfHrclO/ZhH0M2xU03zDzze+DzH7GdaKXlzB+FH8Q=;
 b=lldLAvnF2IVCXdJj2YRblIXpNas3dfdwm4uLo3wcUBFtZBZxw1b1BTyVzh8iHiDdk6
 VhqBi+ApizPncLfbHhe82yWaLZajXg2+PqkzAcLiYSv/89V4w4cnhmzYrFcXvpmrIEoc
 yTps0xY8TAi4Uuu1lr1tBi2XFAb79OflTkTn+3+gSsuocJI1GMiuWawFydxgZZf4Ezlp
 iRYi/aMBDJebxKm0+oXAGMpiV+iNb2oINQzd6GKukJuzBukBi25/891ceLspz3yPzxSz
 DrkY+Ny6R5q5zLY65ZMaGXDK9pAvdfabKd1lWzit+Kh9frxHVbJqMiSe4oW4vlOWqWj0
 +7og==
X-Gm-Message-State: AOJu0Yy1gHrOGEjI65Aax1gGMCEqrCaqDZHaapUJf+yaDmHhJUV1ISh6
 yTgmAxmoawm+s/PtWvuGV9i1xnLUXWDQR9eYO+Rm78SRqJ1d86+kV2kgaXPiyAZPVcqLumhE94c
 tBqg=
X-Gm-Gg: ASbGncsSYEUdspjPyuBUh9G7LnvYX0Vnoip+YF3f0AwckEiZU7y3eSFs2zh+KBM6VeM
 CvT1duLK7wM+YrPPa1WjWEdNDuADlEuOC1U1E5RfCBwE28xt9zIt3VU57GwNpiQLIweR/+WGNkf
 e8uDBdS0pZHNGCsdIKEWW0WGxF4nQDYQ0JdnXTwajhQV5uJsoE9/9NmPT84q3/Rtnavlp9bF4lE
 OojdRr3dxGOGOMHtEXE3JysnlRW9nWHzt+cv5AoQLuSmK5spG4fWv4mdXZY2VIkbFHPU79hjJWB
 Vg2MoYyT6K2uAW7eri6zuIisCAfPRh5E5xB/cOgKsWynprv8AZuiZPpRMrMnqjK9C1ADUgEJ7QA
 8JVlHsC0Q+G4cxsw=
X-Google-Smtp-Source: AGHT+IH9Z2Nz/1FFelkiHryyeVR0HhXb7Jt8oiVYWLguIvxRwHDNVV0pOsV5mXH7+YIrO3gmTLsshg==
X-Received: by 2002:a17:90b:35d2:b0:30a:214c:24c9 with SMTP id
 98e67ed59e1d1-30c3cafbd2cmr4598385a91.3.1746788849470; 
 Fri, 09 May 2025 04:07:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c4add0e6fsm737506a91.2.2025.05.09.04.07.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 May 2025 04:07:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] semihosting/uaccess: Compile once
Date: Fri,  9 May 2025 13:07:18 +0200
Message-ID: <20250509110721.90447-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1034.google.com
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

Replace target_ulong -> vaddr/size_t to compile once.

since v1:
- fixed build error when TCG disabled (Pierrick)

Philippe Mathieu-Daudé (2):
  semihosting/uaccess: Remove uses of target_ulong type
  semihosting/uaccess: Compile once

 include/semihosting/uaccess.h | 12 ++++++------
 semihosting/uaccess.c         | 10 +++++-----
 semihosting/meson.build       |  4 +---
 3 files changed, 12 insertions(+), 14 deletions(-)

-- 
2.47.1


