Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80768CA0EC1
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 21:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukqqK-0002g4-En; Sat, 09 Aug 2025 17:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ukqqG-0002Xb-K1; Sat, 09 Aug 2025 17:11:04 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ukqqF-0000RH-3n; Sat, 09 Aug 2025 17:11:04 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-af95ecfbd5bso550395266b.1; 
 Sat, 09 Aug 2025 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754773860; x=1755378660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yuhrFQ4YMQGngl1ljCiD9nY1lduhD/ZObTT4cnNlv/U=;
 b=jRldKPZvCYS9IH+ql0hX47Xx6RQ05PHZl7b33LckD7Dz8dL/+YAoFpbBdRkklIvJhK
 gf2IONmVOZSKZ1rdtRL1tVcmWh/DX4ou0TY8cNmjv+DsdST2o4zQ0YtqcxO/H1gSDLdC
 +vdxHWXGbyZKQHrhcROcvENfulB5j4i3rEOFSUuRLAIRI1Jrzufeq2HoNsIsYv8vjU/I
 ysU55tM768lLRmLzmLqUVbxhguNX8T3KWoxA/Cu3f6M404cdAKwPuMnvLSG1iUHapQow
 YM6tq9W/awQE+GMOqDtRYZDtFUocxHNkXhcWXvfHk/91tUmVQInSPzjDV6WK9+JiNigR
 Q2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754773860; x=1755378660;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yuhrFQ4YMQGngl1ljCiD9nY1lduhD/ZObTT4cnNlv/U=;
 b=NNOpZ4ufy4mvnq8GOf+9s3/r/c/ZQJpSWcd7vj1EH/14Sbx4Iy2P1iUeIBkoR+m3Is
 BlGrJUg3BE3uW6VbDCuh/Ew/lAbSgtxeisaHVeOSJmaeGbdIuj8EmsChssKeXIYwENOm
 nsUPifjK/t1sXyYuhr3a9p4xaqGaSk1sJFv9Cz9MIrj+1iujeL5J6FytFVHeW6OgcWd+
 vxGiCyoN9SLO3nNSc/8Xuvoprv9D8UP/3L+44Yr/aP5wQvhztrTW2W007FLwg6HmIuZ8
 rt7Hc8axk9kH3CIcIelb7e/FQ+tvL7WBNYwbrX2A9VdJxFSN8F38OEa4KNv6B2y3rPdL
 k3sw==
X-Gm-Message-State: AOJu0Yyc46dYwaMUUWk6AET6sMD/GuuBUHH+5xqyA3+RYK4nTjYS5MyL
 SWkkor8WZ0AVn0kCXOEhkjsxOrAu+j++8yh8EN/ZEQvcU2Kxx2U1PqdEXoPAfgDDrrg=
X-Gm-Gg: ASbGncttOeDeF7n3VjryS7itTKY+606/bNXDnMrCdRb0pVEpz/Baq88/c9KEPaC5FUA
 3iU4lieWZxKKnAQPhvMgLFpNfw8ExHivLF3gE13e5pmr/dTcJnn/CUYO4J6YEESTpqAWsswqDcZ
 4kdEWQ/agtIDZzOiPCptM+FHKf+UvPIgQyE5E7zI5cAvcDh5kw/dWKkphChgO043bKBG9totpvJ
 1s1p2omH6B9royt8xvf17b/SgkBXrIV7XbfbBchuuMzPK2RtKniz1zsbgujDa9AFOwN0l3luzOC
 5x7drt3SB3W1RauSA+EvROdhPjqSKJOpJ08KN8EHcSHJgNergad4bS1kcAYrnCSAsW9pdrn75TS
 jmEJWyXOS5JFxDTR0iU6MzCT3IdUCxzNBCBJN6ushvXz1GZ61
X-Google-Smtp-Source: AGHT+IHcgdbWpeXHRWitx3TVSK0i4Wf3yWNwmJZMOKPggfvY3PfiVAsDwmcCB6sZlhcQUSB9UEpVVQ==
X-Received: by 2002:a17:906:f5aa:b0:af9:5a60:3319 with SMTP id
 a640c23a62f3a-af9c64674fdmr728772766b.19.1754773860448; 
 Sat, 09 Aug 2025 14:11:00 -0700 (PDT)
Received: from localhost.localdomain ([87.251.30.120])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-af91a078a11sm1759490766b.7.2025.08.09.14.10.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Aug 2025 14:11:00 -0700 (PDT)
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Vadim Chichikalyuk <chichikalyuk@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/3] hw: acpi: add UART clock freq to AArch64 SPCR
Date: Sun, 10 Aug 2025 00:10:48 +0300
Message-Id: <20250809211051.68824-1-chichikalyuk@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=chichikalyuk@gmail.com; helo=mail-ej1-x635.google.com
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

This series upgrades the ACPI SPCR table for AArch64 virt to revision 4,
adding the UART clock frequency, which was not previously available via ACPI.

Regarding the NamespaceString: following the example of the SPCR table
for RISC-V, I've set it to "." (indicating that there is no device
corresponding to the UART in the ACPI namespace). However, looking
at build_dsdt(), the UART is actually added to the DSDT, as
"\_SB.COM0" (same as RISC-V). Should the NamespaceString be that instead?

Thanks,
Vadim

Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>

Vadim Chichikalyuk (3):
  tests: acpi: whitelist expected blobs
  hw: arm: acpi: upgrade SPCR table to revision 4
  tests: acpi: update expected blobs

 hw/arm/virt-acpi-build.c          |  14 ++++++++------
 tests/data/acpi/aarch64/virt/SPCR | Bin 80 -> 90 bytes
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.39.5 (Apple Git-154)


