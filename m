Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ACBFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLB-0007vO-6L; Thu, 30 Apr 2026 05:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINL8-0007rX-Gy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINL5-00032p-Al
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0L6UPQqIBvtEwpkdo/ifxNJlu1wz3w2ZGV+lBliBaK0=;
 b=Os0pnFKsmnUZzjlltZ4Q5wIONfzevtd1CH39N5yjbYFqgDzuVN0Y9/CY6qgHGiOOlA6s3V
 4OZ3FIxJogmn2a+oJqU2YycQNlJrF6YbawvIc8r9kcX/FpeneiVRqyE/9Acp0g15fCvwWL
 8P+S8ESdljT+CVFRSSzoHaEYBAgdbvI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-FosuL2jlNBeOtYMqFN4SdQ-1; Thu, 30 Apr 2026 05:05:39 -0400
X-MC-Unique: FosuL2jlNBeOtYMqFN4SdQ-1
X-Mimecast-MFC-AGG-ID: FosuL2jlNBeOtYMqFN4SdQ_1777539938
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488d9e1e61aso6861265e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539937; x=1778144737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0L6UPQqIBvtEwpkdo/ifxNJlu1wz3w2ZGV+lBliBaK0=;
 b=edloc8NA8R7Fy+Sp2TL0qSWHmberdHbceDwuVxlV27WBFr+8uYX+gN9zAPIrm8dGUR
 XyFaXVHmxhzByrUA3U0KMfYytkZyZT4r8rnk9G58OCuHzXD5c0b8lcrtTJ3b443AY1jT
 gDU/PZvzTtWljqYYauJSxlLVaMxBcER0ER00UNp/w0zijlMrLBO211ctZZgMze5KZkjQ
 x/UomUEuHNnWDhEy3hfQCMG/oUrM443puX732oRwanjeuQ6hu34/3izaYHauunrkMf3R
 RMkezgpr+eq4nzF4I49hF9oa6Z5IZT6nKga3o+B+iQ7otOnwUWPdfw2uH0CIWOenFeGY
 js1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539937; x=1778144737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0L6UPQqIBvtEwpkdo/ifxNJlu1wz3w2ZGV+lBliBaK0=;
 b=NbIu9D8mlEt8jOWI2CmhaH+KWjs8dPTHft3FN7UoHDuRa38t47TaBDAdf4Sojh61lA
 BkrfMtnXLajQ1Uq3Sk/c0ZPKbPy3Y7W6id6tad9BitZDwmtrAw2XH3fvR3VaLbsegwRj
 kKso/jlloe61oIoblZr+6mR2HWuKf/1jB+/q93TCHJOpYVliz+uGIsVybekC+TpqDwVy
 rnLPJYLyL5RH9OsDxdLQ/cDd6lm10bNeZi/F1gCVRE5DtkUIcjWSUqfXhr/0DLJTQQQ3
 aYKzvF+s0xq3S2oW4YZgxuk8ylZpBzXeaWM1H5BYG6YKFMP8fMgyzG3MAheZYhChMGF9
 2nuA==
X-Gm-Message-State: AOJu0YwP2VI/n2gY1zrWta7DgDki60d3H54FhmRu6/COJBhQrY6L1tU9
 RuX44fSdX5Y8+LDBOcpDnVvg3IJEFej640cde7o0IQQfFxISquBhRD2h68x3WTiXJjFtQ4ylvZy
 gZafz958LIPnnXmvuNc8iUPsowcJZ4o01leZwgeQpd0HURP61d7SHEc2tkMKanUJ98CC9fGCFsy
 DKq/0lm2D7cqcgzHO6BgaN8wG1HV5q138ZLOvauxMa
X-Gm-Gg: AeBDievvylnQ6M0AkqIvJPDz+xdGvHjDAFXvbZDorqF5YM66hi5e3xHtqL3hwbwFg5V
 9aEMloUGedvAeR39RdrqpkZgEEcMvOqQ++yZe6+RUr2Df2qJV72XlXYYFLdc8Rez71wxuMNCp0R
 7ROLfWHSO8N3b/XVJUsGIoBV2zW7NmOIwUxwkkB4mK/Jk9aIUI9tpZ8ETt9OTOUm9hNOGtD04c6
 bYSbTdK5baArC0T3osli+m4j66un4ujyJEw4Rm0TDD3RSFzHiKmmZbnuxy5tk3ONMyzC2M5NZJh
 +V0xMFlzAUzkzg2S8K0+2JhUjgjDjPHKq/oHcwrd6t19lxgL+GlEvayr2xVDzSdlOZo09bSTd3V
 CAemaodohukWwVDI0CqhUmEtyUVKfyIxy8pkubGvivHgLASIZfW/YcLU++swL4Mh2pKXGS/hTYW
 WLnj8UOa1tL7V2mnp+aL5urC5F/j3qeHx7Wdc=
X-Received: by 2002:a05:600c:198b:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-48a83d66cb9mr34798825e9.3.1777539937024; 
 Thu, 30 Apr 2026 02:05:37 -0700 (PDT)
X-Received: by 2002:a05:600c:198b:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-48a83d66cb9mr34798165e9.3.1777539936338; 
 Thu, 30 Apr 2026 02:05:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed6b65sm84075865e9.3.2026.04.30.02.05.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] kconfig cleanups and mypy annotations
Date: Thu, 30 Apr 2026 11:05:21 +0200
Message-ID: <20260430090534.841894-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Modernize the code a bit and fix some issues that were found while
adding mypy annotations to minikconf.

While this stops short of adding flake8 and pylint, it already
improves the style and fixes a bug (see patches 1-2).

Paolo Bonzini (13):
  kconfig: remove duplicate declaration of CONFIG_CXL
  kconfig: remove duplicate declaration of CONFIG_MIPS_BOSTON_AIA
  minikconf: run through isort
  minikconf: small cleanups and dead code removal
  minikconf: move command-line assignment out of the parser
  minikconf: fix type mismatch in do_declaration
  minikconf: simplify self.tok
  minikconf: modernize handling of include chain
  minikconf: use .items()
  minikconf: pull main program into a function
  minikconf: remove unnecessary semicolons
  minikconf: replace else with early return and avoid unnecessary else
  minikconf: add mypy annotations

 hw/Kconfig              |   1 -
 hw/cxl/Kconfig          |   3 -
 hw/misc/Kconfig         |   8 -
 hw/riscv/Kconfig        |   4 +
 python/tests/linters.py |   6 +
 scripts/minikconf.py    | 465 +++++++++++++++++++++-------------------
 6 files changed, 254 insertions(+), 233 deletions(-)
 delete mode 100644 hw/cxl/Kconfig

-- 
2.54.0


