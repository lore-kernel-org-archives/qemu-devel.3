Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E10D6E2CD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDfX2-0007RU-Nq; Wed, 20 Nov 2024 02:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tDfX0-0007Q9-QD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:53:47 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tDfWz-00009Y-BU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:53:46 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso240179266b.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732089223; x=1732694023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ssPGh2Gcl3S8w4QvthlBvRR2oy4k+XVJ4QDrmqM9C5k=;
 b=RMqMGA0WzvJ3bqxLUdbWKtDuaunqEPn13Yp/jNCo3ZrMuDXBkyJtMkJBCnSpstI1Jj
 dt0SJN2gSwkfuz1G+RyMMZIqrdxvcmoXcNELM/0+rulAC3DsQmg2wbfPdAKABfPalAzd
 lrocxZOEGXzAir5Et5nV3pFeiAyCZnJaCUk8Upa1DTfbkqLW9+7ZVRK1As++xHZm3obX
 F3cjOfWpuLWvVc+aFtQCRc0Nw+mcg7li8LxxGQ34gCpNcxSov4+TBD5osKGo2dhpt9nj
 zFmyhSYKpbv0aP8BMimjlidTIYjidQ3Bh/AsgJRdfYSWzjb1FZwI2gtOlzFme5n8G4rW
 0kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732089223; x=1732694023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ssPGh2Gcl3S8w4QvthlBvRR2oy4k+XVJ4QDrmqM9C5k=;
 b=Kp7MWfzRmySf020O2MDdLmFTgWEBy644iDhbAI6x8+ikWKPFDdNg//YOkECIxClTBW
 0H56meJmyTb2sIyDFKu5bPeyx/idA/L9u5FJy2SXW6ylBr2BUbScdLD/StmKj2V1LlQk
 mcyPlKSac6ptCVMdDwuJ6q67Xm8tQc/hlIDu+Fy/m7MDHprjrsyzJsHqvrNf30UoQ//R
 0mj/TxahqS0uxomfZ+FigwjQLk67XFKuZmd+yCvtWPa0k4nT/ekPnjknbLGp/RTmOMWW
 48efllJBrV4XOOcmokuRSrRei/WLrh9kNcUK0nRfcomuspy1BSSGk280NwiCYK5bn38W
 Wzug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqjKvUeBvQLwOGha9s1diiehDyY4+G8RKrXn1pOOmvUV+fhbOS+4Itt+/vPjaJ9Rx+OQq6sePt20I4@nongnu.org
X-Gm-Message-State: AOJu0YxzIj2QLCTCF1Hgsy68RY25YdE+J0OY+TSNoOHYy/GsPAKRgWKZ
 l/7HEBdshv5gAT7y/t7Iu3TtPlR4PAGchl7rgbEVK0mI/9uzn3BG
X-Gm-Gg: ASbGncs11kROoIFFI9UeIF6A9O4VXri+vo0Pf2viDTt76Vkh9uvUviGM7vAwK3tRW8f
 QRFs29cRh9CcKJkV3nskhcrKoq7K7TunnrL+jLh2Lwv8jPmhaQ1angyqJ5Gyoew6BJI3N0WduU1
 otRhdc/vMtnI29h2Y0KoX4P1TAoGXIPP4BywI7y/1QTL38b2njEJr/glEJsOs13i5HN3cLzbnLu
 j+dcLHFNDAfi4uxJE2kwNj/IjtNlbT/pL6THR+stAsNHTeU0iXgLHdgwg==
X-Google-Smtp-Source: AGHT+IFseflXyPcOilZJ70kKgIb8JteeURnhaA47aafK1VOu29WgTSoQ+2+QCEvVsu9z9ZEYV2GP8Q==
X-Received: by 2002:a17:907:3d9e:b0:aa4:a814:3f75 with SMTP id
 a640c23a62f3a-aa4dd748c45mr157954366b.52.1732089223165; 
 Tue, 19 Nov 2024 23:53:43 -0800 (PST)
Received: from finn.fritz.box ([2a02:8109:8384:1400:37e7:543e:4254:db4f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df265bbsm738395666b.38.2024.11.19.23.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:53:42 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] chardev/char-mux: tweak mux bitset operations
Date: Wed, 20 Nov 2024 08:53:19 +0100
Message-Id: <20241120075321.27143-1-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62d.google.com
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

Patchset tweaks bitset operations by changing a constant to unsigned
long, introduces a static compile check and simplifies bitset operations.

v1..v2:

Rebase on latest master, incorporate review tags.

Roman Penyaev (2):
  chardev/char-mux: shift unsigned long to avoid 32-bit overflow
  chardev/char-mux: make boolean bit check instead of find_next_bit()

 chardev/char-mux.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)


Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org


-- 
2.34.1


