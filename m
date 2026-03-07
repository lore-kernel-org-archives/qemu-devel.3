Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F40FFC9EF5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 11:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vypqm-0004If-9L; Sat, 07 Mar 2026 06:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypqk-0004Hf-8F
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:29:38 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypqh-00069p-2z
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:29:37 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso83239115e9.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 03:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772882973; x=1773487773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wRFky/kgKlIM/6LOIrsby4j7UuvJHJzcaqZGDyYajsQ=;
 b=W2pNQf/Iponj38qVhpejHzPa6lud79QzDOyNYhq1B5YddQ+oaqrFDu28lnnHrViyYh
 5HJZfk+qyINpWFHxDfUnAA6CQ4VdiE5/rzeviMWy6hsSm15e1uoVzOOe7vE4UoM90yrC
 IRizT83cOWY07AndXB1jMKm9XRkDqWf4+SCjmIHXhNl1qJPR9raNDqxGGeyi1ZJ0jdaK
 VBkHP7m9klDspBWx5/xG8rDBOi7VU2o6ROQO9msrO2/y5Hh/3lifmam02FqLh3pbujH6
 b7IVpMZ5n0FGaBWzLgzcXYaCiicsOjUuv/3ie83eMjMtwaTnhsuO7affL9bLqK9z3NxP
 M2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772882973; x=1773487773;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRFky/kgKlIM/6LOIrsby4j7UuvJHJzcaqZGDyYajsQ=;
 b=YRMIolqWdMKfQwlsmYopQOENXF2q9m2CJtTFncmUmXLLKne6+8Btt5VMdH3J87pKnd
 5m+d6W/3HZv4RTkgRKa42hopUzEtlaLTwzvqUx6v8D4grgU4guqohFHlQMh6xyW4cJIF
 dS5WSG8Cfh4s2Y+XpvDk6AcXsBIT7m9zPROdGWb4x8cidA5ogKsz5EHOZsqm2lkaxY23
 v2iLWlJWU1kACIEaCFJX1UkrO0EKxzPuhImvpB1Yxwr9qyaOK4pNmTLLDKrASKlOTc1x
 UTaH/FNJT6mKbh7ynd8DHpHCu77L6aE0jcAIjlXQsTU9Ar7eJ4nKdnxVyWo4R5A3o5kq
 A4vA==
X-Gm-Message-State: AOJu0YyrhTeCLgaoebxlJFO2j7RtiJ4WWZM/Fbvxpr2J0iucskVmjx8g
 ug4+2B1w8g52PLkC3eGTjuTjBxXCH/ELyGMs3A+VWfqxB/3HM4jiukIYk78SNw36s3apwSD0bJ3
 j74FT
X-Gm-Gg: ATEYQzwBdgTUI2rX9R99D06ZwdeXLb+W95fbjE/RGYeHuOED21ViOw/yextL1lA3Mbg
 hOewlzQvxncEjZR0ftIBkeDeCy8tini5OwhngCLbJxe90UMUEVE8mFOeDDyRAvFFnbQ40wY3gkS
 hEVZthV8+ntY/vU8DlWr6MLKfk6rZFJtlVoCqgBSB04H3GYhH/a3axWZewGfHx4hzMAIPlAvXmy
 1NK0bktwrE20VNlcqa91kTcNYK8ELK6dC1g3Iup28jr/KJ813OjpM5d1hsv8Bv9ANp8m8zEdW7y
 dOF7ku8Ah6+3UWlqYu3y5ze+ir1A/fpNpD2zxrrc13w/A0ue3e7L8jICkLeNfXFzM5lnjLkTCHo
 N3SOWd0LyFTsNoYTtDFrKrenCCkjA5C3yikfgowIKFpgddjHjfpTWRKiSKjJCCl8bRGLFG/U/Ia
 Q7Q4a+t+AeoXEcFl2ltDtOOUKzvHxgNIUnaKE3jP+Jg9QOqcGrCZv2b+yKcRd2KI42DgtMETeqT
 txk1LfEXBb5M8B7WWm9Cu+FtVTYqB4=
X-Received: by 2002:a05:600c:64c7:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-4852691ec50mr81481035e9.12.1772882973291; 
 Sat, 07 Mar 2026 03:29:33 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853252cae1sm13462255e9.3.2026.03.07.03.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 03:29:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 0/3] sparc: fix minor memory leaks
Date: Sat,  7 Mar 2026 11:29:28 +0000
Message-ID: <20260307112931.3322532-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

This patchset fixes some minor memory leaks in sparc targets
that show up when running "make check" with the address sanitizer
enabled. None of the leaks are important in themselves, as they
are leaks that happen once at startup of memory that must in
any case stay around for the lifetime of the QEMU process. But
getting rid of them helps in moving toward the goal of a completely
error-free asan run, which would let us guard against more
interesting leaks being added in future. It also removes a couple
of uses of qemu_allocate_irqs(), which is an API I think ideally
we would get rid of altogether eventually.

These patches are enough for a clean pass of 'make check'
and 'make check-functional' and 'make check-tcg' for the sparc
targets with asan enabled.

thanks
-- PMM

Peter Maydell (3):
  hw/sparc/sun4m: Don't set up dummy cpu interrupts
  hw/sparc/sun4m: Use qdev GPIOs rather than qemu_allocate_irqs()
  hw/timer/slavio_timer: Free resources allocated in instance_init

 hw/sparc/sun4m.c        | 34 +++++++++++++++++-----------------
 hw/timer/slavio_timer.c | 25 ++++++++++++++++++-------
 2 files changed, 35 insertions(+), 24 deletions(-)

-- 
2.43.0


