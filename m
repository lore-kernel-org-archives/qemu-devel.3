Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1C6CD11DB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 19:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnO5O-0005H5-PO; Thu, 21 Mar 2024 15:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnO5L-0005Gh-Fr
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 15:28:19 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnO5J-0006n5-Vi
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 15:28:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dddad37712so11768295ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 12:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711049296; x=1711654096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O0ekOmRrQ+fpx5FSwZGStmzTGu3jdCzlHx+IpElHWIM=;
 b=LzKHMl4XmevMkk1OCTgdFXWO1tkexY6OlppABqtxZ1WDElxS0SPjAxBD4Kw8o1SbrU
 h2yUgQGUoM6M5zSgmzdNCMkmOTTaX0Br0Lel+GJwTY+bGqJ5Qj9u+mkHMDnREv7oLkhg
 UxgqVmFKFX4YTrqPAqpqdGru/D8j5nxai3CltTMk+PM246MEmXTTR8Dn7QYtDEjENtqk
 eiqr8mOW5+gnhAzbNHIuI7J8hasjdhrHo+4uO/WSy6eemNsMVGN/D2fKiv3c27wl1HwO
 wdViuoLDdMY8en1eGZI/DpBzfYNl5PIHl2Ln8RzBhyzCUAp5WV7KEE8u0xB660pArpjs
 AxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711049296; x=1711654096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O0ekOmRrQ+fpx5FSwZGStmzTGu3jdCzlHx+IpElHWIM=;
 b=h+gMogBXyDCaCFZE+ENNmqcre1roSYMMR1HznOIgqDoppndBoTdPs9uxlw1B/tGmzz
 Po03zVb7WJRKOy18kTOcwzS6yiUiSuYwaiy6EZXA6oTh7qGv0EIXG7vQKiRcGsJQt3r4
 +KTz49XHMOKXRugX/8q3o60I+XeI8tze3GCRcevALxpIPKUuxSpYIUVYo4PZ6PVWKI4e
 Zv0MAlLmnaDqZ4ZaYRgThY0tBG1CpkvYwLuXqgE8qqw2yENycE4FxJpKavZzuxhH3M+O
 jws0gQSgFzdKk2WHhksI4bMd2zZX9ep1zvlpUEs8lsAQoIJ52cIQoMyf4hkcPlRj0LZl
 TJIw==
X-Gm-Message-State: AOJu0YxZqhY0gwubyW40q/P84hDP3C1I0paCT9w/P4178vvEEFQ08Z+w
 wxSyNxicsPBjOjcDOTJgGwcZgIeWjw/buPPL3iPIeRX8/50SXaAf1176TAG/re0soSIQ2K1UHvR
 2
X-Google-Smtp-Source: AGHT+IEVm7RUoT8p7G9M3SjwZzFfKGFjtkVY/5riP7WL/Pkf0H+77or8MqqBO6IuGzXzHaMseuNa0Q==
X-Received: by 2002:a17:902:e984:b0:1de:f59a:4e6 with SMTP id
 f4-20020a170902e98400b001def59a04e6mr372182plb.24.1711049296230; 
 Thu, 21 Mar 2024 12:28:16 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a1709027ec800b001e06c1eed85sm207303plb.141.2024.03.21.12.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 12:28:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	svens@stackframe.org
Subject: [PATCH for-9.0 0/2] target/hppa: two more simple fixes
Date: Thu, 21 Mar 2024 09:28:11 -1000
Message-Id: <20240321192813.371526-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Using the correct space for BE,L linkage might make the difference
for a cpu stress test.  I believe triggering this would require
something like

					f=(seg,ofs), b=(seg,ofs+4)
	be	0(sr1,r1)		f=(seg,ofs+4), b=(sr1,r1)
	be,l,n	0(sr2,r2),sr0,r31	f=(sr1,r1), b=(sr2,r2)

and then validating the contents of sr0 on return.

Linux only places B,GATE in the zero page, so amusingly there were
never any high bits to clobber.  But I can imagine HP-UX making
more use of gateway pages, and certainly a cpu stress test would.


r~


Richard Henderson (2):
  target/hppa: Fix BE,L set of sr0
  target/hppa: Fix B,GATE for wide mode

 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


