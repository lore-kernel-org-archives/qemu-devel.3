Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E102EC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucoRt-0008Qw-Mb; Fri, 18 Jul 2025 13:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ucnsx-0007W4-Iv; Fri, 18 Jul 2025 12:24:35 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1ucnsw-000702-0A; Fri, 18 Jul 2025 12:24:35 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-553be4d2fbfso2369854e87.0; 
 Fri, 18 Jul 2025 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752855871; x=1753460671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0tSNdwHvz7/qWn2NTQ1xPS7vHeWeR1Yks6l86cO/Dqw=;
 b=fzlWV3hXWR6XIqOdPiGfpxVZTUBjcCmBby554ie01n2PSuhEI+H6xM0vH4uh10WA3c
 1itJkTSTE1+Qrh1WRoxGphV5YlvwoKpVPXR5+sCZAOEYh1yWNzDU0LyMXiHPknCkiehl
 bEI3neyZ8KaDv7mfKzO8vP4IdytlJaZp2LsEiZJjtWP9VpCsEO7SwOPTu79dUNTXnmoR
 tBz7zIHwobSz3R7P1BzieuMIma7vFRhLBPd4Mesr+L07QvXtx3jCYpKedIoqXxH4HdaD
 naeKKzNJ/FHC/5L4Sx5XctGdpT0sCgufwUrLwfvJy/9vqCvngKHeypN5VdjeC/asinLh
 ZUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752855871; x=1753460671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0tSNdwHvz7/qWn2NTQ1xPS7vHeWeR1Yks6l86cO/Dqw=;
 b=NK2LzxO1V4UDD/GlwABBUfbz8M37OQ/u/DJJ2WlbrAo1izlJwa5buVt0mdk3bL07yY
 0+825MTW8Lp4+hLnURrd2/Nl16mTti/R49MRPF5HR714RBwMmnUFirz16kl1G+AeP+En
 YoZePO0mOJXcqHvGRqfNvnip26I1qOTSQGKNlyPeaprw2EVIEDaQvIABqDFUebqvwW/A
 Sj4kPpmqAZWfrhCpsYEewKwpTyAoVTufRaAaNTlEF11YolbA9OyWZ77QBethZYmIUTa2
 unHdLjkaR9PaDswBDOcY1B1rIK7XqunUDYwjdgW0Vh8PgjILLw1HR7kBpFF/o44GO1kV
 rdlQ==
X-Gm-Message-State: AOJu0YxkOia+W57VKV0Jr2mJcm4n8NRdLi0QU/o+vV7Mx56m8s3I3pK6
 pVsy8JK6LMZRveGKgbTJs96AbXcmMY/Q65f6sqi6amUgYwMiFoHGymkVDlHFWCY4oZBWUQ==
X-Gm-Gg: ASbGncvj/X/BF7m9NDeogUh3PYytWMcXUKOgkLuG5UUavJQuP0faN05HZIb2LpSzfmp
 maOauz5wrof5nFZ2MrKnqRn02JCDeHs6c16XXbPbtZs5pVRY2N7vRqj8KdlumqknsjmaKFyj6rJ
 0lT5M4PKSg8q2gFcZdO/DVhNu2ioLBpoJgvOwePxz4+nTvXJIus7rTsFZdXqiXhvi3XF8W001R2
 4MAla1DNikHvR1G11iElzhOM+avaNYuJX5FwtQGDeQED3DlYE/R+WCC2t/ktY3XWUx3Ms2aeuvb
 lzyIbePOV3hILV2Fte5Wq4Ek27oHHtFz0maX83iJGbskjrwRS7Mkn44UrP/gWwLeubVEJXhkyGQ
 dMgfzl2+XkqjwsM+rVggKcb3C6lrTTdFGjLTDou4UWTo2SvGLl7uEar+CKsFy73A5r6RWZdor8O
 9k8cg=
X-Google-Smtp-Source: AGHT+IE5ccMkBF49Qwr3sjez00wAXnqMzLqXkW4m4VtK/6AYMLWVQF4ez2Nk3OmgRdsavEYiPOVQvw==
X-Received: by 2002:a05:6512:4058:10b0:553:adda:db40 with SMTP id
 2adb3069b0e04-55a23f7f73emr2723212e87.44.1752855870623; 
 Fri, 18 Jul 2025 09:24:30 -0700 (PDT)
Received: from localhost.localdomain (m91-129-102-83.cust.tele2.ee.
 [91.129.102.83]) by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-55a31dacd84sm310615e87.206.2025.07.18.09.24.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Jul 2025 09:24:30 -0700 (PDT)
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Vadim Chichikalyuk <chichikalyuk@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/4] hw: acpi: support SPCR rev. 3 & UART clock freq in ARM
 SPCR
Date: Fri, 18 Jul 2025 19:20:41 +0300
Message-Id: <20250718162045.49012-1-chichikalyuk@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=chichikalyuk@gmail.com; helo=mail-lf1-x12a.google.com
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

This series fixes erroneous building of ACPI SPCR tables in hw/acpi/aml-build.c, 
where the UART clock frequency field is omitted in revision 3 tables despite
being present since revision 3 of the specification.

The last three patches update the SPCR table for the AArch64 virt machine to
revision 3, exposing the UART clock frequency, which was not previously available
via ACPI, to the guest.

Thanks,
Vadim

Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>

Vadim Chichikalyuk (4):
  hw: acpi: add support for SPCR revision 3
  tests: acpi: whitelist expected blobs
  hw: arm: acpi: add UART clock frequency to SPCR table
  tests: acpi: update expected blobs

 hw/acpi/aml-build.c               |  20 +++++++++++---------
 hw/arm/virt-acpi-build.c          |   5 +++--
 tests/data/acpi/aarch64/virt/SPCR | Bin 80 -> 80 bytes
 3 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.39.5 (Apple Git-154)


