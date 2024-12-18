Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00A2E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyfc-00005y-J0; Wed, 18 Dec 2024 13:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfZ-0008QR-28
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:13 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNyfX-0001kE-D8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:21:12 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso47922655e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734546069; x=1735150869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rjw+OVRcrKaViPr2n2sn4Q8Gz6HM/7SEwuqxJQ/MKXY=;
 b=OfEOAr1NzJNWRI+SXEHSKfrSouxg7gtnMIwCTWNLQPW4WwRSLK4dyfF04Ikm5thXke
 3uwNNSttbqyC78Z7KL0JlsErr1RfUGKI6LIpVQErgywWIFVwUT+VubAfO4gLP4L5ZbIj
 YyYo487g3atiLbE8Oni+/664c9zSAdGLXVqWPDhld7CHSc4ZyEXAPXNk56+QS52A9KIJ
 J+GS+E0oedGwOfY6xJMuAHrdEHTg7RkB2PR+kSwD0J3Ft+wApfK1exxs6+N2Aws4s+J/
 SOq0RGB48V4Epp8Se3Q7stghao9WV9ir5wLveWk4JQmZ9gOAJurI+h8zXsIIK//+GSAZ
 lUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734546069; x=1735150869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rjw+OVRcrKaViPr2n2sn4Q8Gz6HM/7SEwuqxJQ/MKXY=;
 b=sNQKTm527KlZzJVHJ+vWgHyQ//uKMSbAboi1joh0npKKpb2xcuUkSS6Bxst30N+V/y
 DEcw2gYhdpIMjnX6MsMLvSVW/+I5bJuTaz9+USpVcDMoNKgCCwWpeReWqJJ7ODxIF4LS
 G4pYu+SD7nO06NJvYJDg+CiCr1vpYNE4ye4VW9N1n+A/qPkeIzUhqmLE3M1zsjPGLbe6
 Myu7qzAU3w0Ra16AwfHxPbC3SwSJw/E35+F+UpfDF7yYyEdqodE+vaTNe7rNmBiRP9pY
 PQZyc9WPHmaZ0h8S0rnjEqhDPSRqL8vm2g6C/ll7bxaQFGVb/KctzMrXsHfKWeUsO4ao
 75+g==
X-Gm-Message-State: AOJu0YxtPuOOuASWNIlNYS5bf5+U6184n8U62w/nF/Ld2NzuKN9XxCMS
 6ZvTWd1GuKi2uIkrzDAPrqH78YpQINZRue8u/iRoirBuEJbrhSKMBiXW7ED4GPdclzZxK90p6y6
 8
X-Gm-Gg: ASbGncuqnewK1G/BWBYOp6SgAhz4L/O3Wfrl8LfU49BDrrwNY9pXmGaEuggWbYKyBFJ
 C/WT75UvyXRuahtiut5jV16FJOKDVhp+o/2rLqkf/kmEPVjSKb5TKDOXqcrYdT0B4zanLFdhrJl
 rn2SUmld/GyNJ/hYwTBZq+lHVUK7K6cODXKxIQ2D49gAvvLFPGhGzNmv3dLapLEp0aUnWMzkZvI
 YEs/uWgobxF3u/bKhZjP4AKEz4BQzduEWSHBtXuOi+uHl6RVLffk767s3aHYXMt56atGEHjjNwW
 D1/4
X-Google-Smtp-Source: AGHT+IHxjnmyDbYVAgDXPpHu25OKjfiutLfU/WTGxBEswmrpAPypthNe6/aSQMrriAkQo2mBEAO6pQ==
X-Received: by 2002:a05:600c:35cb:b0:434:a386:6ae with SMTP id
 5b1f17b1804b1-43655347ed6mr31691665e9.7.1734546068966; 
 Wed, 18 Dec 2024 10:21:08 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b2038asm27331455e9.44.2024.12.18.10.21.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Dec 2024 10:21:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 0/7] hw/ppc: Remove tswap() calls
Date: Wed, 18 Dec 2024 19:20:59 +0100
Message-ID: <20241218182106.78800-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Remove the tswap() calls on ePAPR, and convert
them to big-endian LD/ST API on sPAPR.

Build-tested only.

Philippe Mathieu-Daudé (7):
  meson: Run some compiler checks using -Wno-unused-value
  hw/ppc/spapr: Convert HPTE() macro as hpte_get() method
  hw/ppc/spapr: Convert HPTE_VALID() macro as hpte_is_valid() method
  hw/ppc/spapr: Convert HPTE_DIRTY() macro as hpte_is_dirty() method
  hw/ppc/spapr: Convert CLEAN_HPTE() macro as hpte_set_clean() method
  hw/ppc/spapr: Convert DIRTY_HPTE() macro as hpte_set_dirty() method
  hw/ppc/epapr: Do not swap ePAPR magic value

 meson.build           | 11 +++++---
 hw/ppc/sam460ex.c     |  2 +-
 hw/ppc/spapr.c        | 63 +++++++++++++++++++++++++++++--------------
 hw/ppc/virtex_ml507.c |  2 +-
 4 files changed, 52 insertions(+), 26 deletions(-)

-- 
2.45.2


