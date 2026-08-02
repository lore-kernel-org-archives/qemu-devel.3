Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9E3C55177
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 17:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqZbc-0006TC-4L; Sun, 02 Aug 2026 13:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1wqZba-0006SR-K9
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 13:04:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1wqZbZ-0003Q8-Bv
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 13:04:06 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2caf228a910so18719365ad.2
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785690243; x=1786295043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fKCb8NWcys/ZommzNZRAuYmhYCGnhBIR6CxzCeKWRKE=;
 b=Ikwk/bTO9prv1xOQggGr+SJn4NB5+7UlR0vfAYv9JuI6PQIvbNVt4ELCyIyTRxciLk
 kkyxI/OkhgZ5aTbb+RT0VzfpeJvFg/URRmeesDCuAFZqHRnW7RG3zmnp+cLID1XL1ryQ
 Lf36oV41S/B99wr/ILlk2ZNNFJ4lwvnluFYNI5ycKicB7jPiQaGizgXJ1c/T5JU/AXz4
 jds/c72gtzO0BDwSE84NC56oyybo41LqWI+gPraQcV0iBLBtxZQ1CjteSmFQgHhBPrOb
 WY5/ig3dbP1cVW7jV0NYRH2arO5eIvGCYWQtHRevh6DRJkkYrXf+d+Hnxg5itpWmEH/0
 gkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785690243; x=1786295043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fKCb8NWcys/ZommzNZRAuYmhYCGnhBIR6CxzCeKWRKE=;
 b=BteBbQGoVifbhCTr04VHtJfqXGil0kb5d78VS/Huuh+JkLKJ4p4ys2LbzALyDLrmNj
 E2I7RnjRdgV/PEyuWe4rYmHrTH1xB2RFmafMyFuzfOmPeW3ehmDvg6OLBQTrz9izqBwO
 D6IoITjXkfQdFS9rpUWxdYtDax3tRR1CwmqmRhzqMVwqFR1sKk8MggcRf95ur+2kQOV0
 u2UoABp4DvS3FdVDUf7PPmO1HkNz+k0L4REQupBIO1/nITQGUb87B2kCeRA2Ip6YcMP7
 Usy9tS8iUwm51P5aAUf8QtHsiuGQqwsXgJF6nmmdjbfR19wl0DjAws1arLmSO+zHmyFn
 8bGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RowpFEu2MphpuMv637GFT2YOwv+1HVr3x7LCXzfi1i5AF0Q44ls0EpTYHyiEEIjznHbbVEVMQiQjXqy@nongnu.org
X-Gm-Message-State: AOJu0YyVhsgbNsKsF/G/+r6dzApd41aPvEp4PjbcAmooZeDDnOPSUrQ2
 RMOv8SQA8VPEQFNtTeqh8ystJ8U0SYY0/nyWUkSQXwxPMj2FmgYmRcWq
X-Gm-Gg: AR+sD13XBYVh2R898gQpOdQWgMY1Ec49ZQGPh6uwDnDfb+ZlZhmVpwkhrwN4EquBpJS
 gDmyPdVnfmyuIQ+tbdEg37lipiVieco35IvPawAgmRczKvQtrZUYj3b3fbXSmMaJmgLitNlkajJ
 QbagbZfZPo9ltCRJOatSHBcowE7f5Y9VtnxmeNo4ozPnvj5ABk6RGQ2nx36sg8tne+I9Yb23a50
 Rz0X2KXXpRQWGOYCuqk2I6U9qrttYxG6juYjUdp8c2mrCHEFvm6PPzgnHpHszd2FtmoDrif37iR
 ibx1xiiKTrfFSkKTnE9j+ODCuWWZ98dmCB3ZUQJ0AQv2tYhftdpNuBK7Hq+WCt6cibs+DQxRGa/
 geFlZeOaqVpIkctFfBa3Yo0qUEKB16ypPul2x8D06hllcpxET8JDbjLjR7Hm6iY6/V8aqlVGn2H
 kica+gL+DoyNJz2r9XK8qpraX0GveVZXgDdGkMymmjzxVaJDKrMGJ6YJao1ZFbQw==
X-Received: by 2002:a17:90b:1d04:b0:38d:e5d0:9bd with SMTP id
 98e67ed59e1d1-38fbc50f6ccmr7593854a91.26.1785690243503; 
 Sun, 02 Aug 2026 10:04:03 -0700 (PDT)
Received: from phi.nguyendp ([116.86.160.247])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm22982126c88.2.2026.08.02.10.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 10:04:03 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: pbonzini@redhat.com,
	qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Nguyen Dinh Phi <phind.uet@gmail.com>
Subject: [PATCH 0/2] rust/bits: Fix minor bugs in bits crate
Date: Mon,  3 Aug 2026 01:03:43 +0800
Message-ID: <20260802170346.3493821-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=phind.uet@gmail.com; helo=mail-pl1-x631.google.com
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

These patches fix two minor bugs in bits crate

Nguyen Dinh Phi (2):
  rust/bits: Align SubAssign behavior with Sub
  rust/bits: Use checked_ilog2() in Binary::format to avoid panic

 rust/bits/src/lib.rs | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.53.0


