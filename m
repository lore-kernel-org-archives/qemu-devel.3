Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985B0C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvjR-0008JD-Jx; Tue, 25 Feb 2025 09:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuqin12@gmail.com>)
 id 1tmpZZ-0007Cs-Vd; Tue, 25 Feb 2025 02:41:46 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kuqin12@gmail.com>)
 id 1tmpZY-0000Lu-Bm; Tue, 25 Feb 2025 02:41:45 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2211cd4463cso105729825ad.2; 
 Mon, 24 Feb 2025 23:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740469302; x=1741074102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KlWnMO6yHwjc+8paMlKW/7KmgYckeGtxB7oTCr77THU=;
 b=c72kS330tfSffpJWFiRET/MKGtkzdMIn2eurLBgnq24iM30/hf56htyWGGqmeVORA4
 DptnYguOHMl+dF7OHxbGHs0qLrwcjZ478l/PJHg67D55Y56lkNBuupQLVEE3C+u18ISU
 HuTM0sNP77Zml1ZHVB1v+2Az9p7GUGQCKrbXW73Hi0kXJbnl7U1LwaAgxMgikORzObUN
 YfqW77/O6bSiLE3Da9pq87BiuViJYVMBnEpxGgjvXX0thv2bJ8pAJRmsSM8B0Nh8GdXe
 Vh9E2y2bY47wATmOYiF0pxzPjYV3KEThkxMYxtvXJRx5iQba5PoCoGoNW77/4KJNYdZO
 sZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740469302; x=1741074102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KlWnMO6yHwjc+8paMlKW/7KmgYckeGtxB7oTCr77THU=;
 b=L39wJLSBwIJFrmHRpzp0DKzjCEAFoPoZixbG2ub7JPYFQyVozZHPbpZj6SWlz2EOOx
 O7I5FYHABT3e0gZnVupcBMMwqUMJ21xdpnPTLTBmggLpSfmoHOJQdUPwih/iRxHnRUlw
 ikIvCyfBoY/+q27uoeYynDQ3lO9cbLUorxmx6gWmCIkRxr6eJa8H4tMJD2Gc+bVXRoho
 z3EUMc7i5muP66t6yngIaL6KvCsZ0LROiFt3lyk232yFxxBBbHvDVA5113poG0PWnIBu
 DmgJwTQ5rsWIhVdM47fHqTG0JaMa3084d7MllIW3pUxt1ut55yE+XIesQj63wAT8GFxK
 p/6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtwK6Fm8lDBpJ6ZuGz5fSr0Z18gNYHTI6NoFrlMzg0jkUJF1S87SQ0aRxSe0puf0BX4EBqiO/+aQ==@nongnu.org
X-Gm-Message-State: AOJu0YyfCKcW26OWRaA6RhhjwsnnLhA+vXsqZDKRZnz/ZU1hjC3t4NYj
 QI/IcZu9jUt4olJHAmZ+KzN8kp5NwBs2UvkSgC0FinJDEBYn3NBAbdo1XQ==
X-Gm-Gg: ASbGncuhoj3OVbyrbAyWER1jhlBYAxJfKyJWAK5P8MfhAvTYe6bUKSnlMNDr4S+2IgF
 AXbpj7aI4pWi4mOukYhfA8NYP+RgD1yh89pb4dwMBBsySZZygn10dFd3CgoDm34ERLxtZ+qm/I2
 bOxI+l8G2UA91iTJ0Ucti/fgPePfiVi9SomcQT6HbsW450idjAJx4KKOduQd418xjjDE+OgdfZt
 pwJrUhPZBZpIVSTXP+sZmNS+59JB49gW+OvJjYzP17b9B9HTnQ6ZAiho66yZTrswys4Zy1HaOXh
 IusIGkkU5poIOh3heqKir8FhjwC/2j8AZybp8g1rE63d6Bn+qM0Z3K3g83HGf6jI
X-Google-Smtp-Source: AGHT+IGne/AdlSM2nyRCjocdnXsXV3vZSADzs59G3wfLi4qAIM8qiHubGMgmh4s3cPIz3EwDJsm1jw==
X-Received: by 2002:a17:902:ea0b:b0:215:b473:1dc9 with SMTP id
 d9443c01a7336-22307e7250emr35850735ad.46.1740469301632; 
 Mon, 24 Feb 2025 23:41:41 -0800 (PST)
Received: from MININT-QD064TT.redmond.corp.microsoft.com ([131.107.160.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a0a6041sm7856265ad.175.2025.02.24.23.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 23:41:41 -0800 (PST)
From: Kun Qin <kuqin12@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Kun Qin <kuqin12@gmail.com>
Subject: [PATCH 0/1] Adding TPM support for ARM SBSA-Ref machine
Date: Mon, 24 Feb 2025 23:41:32 -0800
Message-ID: <20250225074133.6827-1-kuqin12@gmail.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=kuqin12@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Feb 2025 09:15:51 -0500
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2625

This change intends to support an ARM64 server like platform that has TPM
support to unlock more power for sbsa_ref.

The idea is to add a TPM create routine during sbsa machine initialization.
The backend can be the same as the rest of TPM support, by using swtpm.

Sign-off-by: Kun Qin <kuqin12@gmail.com>

Kun Qin (1):
  hw/arm/sbsa-ref: Adding TPM support for ARM SBSA-Ref machine

 hw/arm/sbsa-ref.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.43.0


