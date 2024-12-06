Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B13E77171
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 00:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJLtG-00055T-SL; Thu, 05 Dec 2024 19:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tJLtF-00055D-Gl; Thu, 05 Dec 2024 19:08:13 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tJLtD-0000en-TT; Thu, 05 Dec 2024 19:08:13 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71d4994dfbaso1322173a34.0; 
 Thu, 05 Dec 2024 16:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733443690; x=1734048490; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4V1OKmeKb8Gi4Mrt+S0Udru7bQJn66xk28W83/WdKk=;
 b=kfXkAuawzSqCihEjmYkbN7PtVcEMCdflg+Jo1ZGIL5SbggdBdkzdk3Lr1l2lx622Fl
 vM83PAYVrmJ664DcAaajUBPYcAwb9IVBAnkx8M0uYVIsy8WT1n9VLWc8NLfz0CjsLOel
 ohTG5AaJVb1csEYcoxhz/PPnCREhVgbwZadXQAYFoC4GGwU99bs8J6OHbsGX0VSFVtX5
 +jIctuhP4D+1gZEtWqLjiF4bLbnSM5Zex3gExPKW036bhCCT+JoxG3thc+AQKMTg/WwG
 U0mEZ5qI8IHGmuA1svxZMU2LjxS85kIdHRY0qECE8zk5IAD91qeEFsRQkEG2On7RrANj
 HRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733443690; x=1734048490;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4V1OKmeKb8Gi4Mrt+S0Udru7bQJn66xk28W83/WdKk=;
 b=bExZuow/aN5bdHQNGf07oS2z6tjc1QDwR6ZddZbUYtu9XqJk6NpbJV2Fg2p7iBpGMN
 njsAszI1Up67M22Q+mEXA80ydX1yrOxolMny2wgGak+ljvmGN87+qIdWfp4BoVhJRFnx
 5URxKF/44LaIx2Crq3aVV8Qko1XA1RM/nTRrtRJViXjylpMIikE5hG3sWGG3WcRztabt
 RgknCnmhI6tCP9P23dUqluj2K+E0WB4F+JI65q0I9CmhB9/+eX1Xi81OWypN/c1EEY2u
 ql9PtFBLs2S34g2Hddr/1jyME71ZxDybW1+JDVeslZlU5Fcvkw2i1ScUxLBwcZ9zGxrj
 Y06A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9Km2gPbBuY8fqsfTixef1Pa3zeXHMMhFLdaeA/QUveHCJ3NzssKz2shJIAvOlfH7RyignhL2niqGj@nongnu.org
X-Gm-Message-State: AOJu0YxkkjOfHAHTYfMmL0HA6bSz/GLrhD+ipSs0kBzlC8DmAliH3aV1
 cLUBNVbHsPoqxHPsYxgs7mxfIGeTOWMPq4x+AWNUm3bQiKt8J0aQaXPMvIhC
X-Gm-Gg: ASbGncs+2QAonOmyCV0b4jivwvwZ7fOMyAgkEiwleGXJf5C5TXkNrgw1JeJIPVnE+eA
 jxljNKcah9uXHgxVVe6v4bDPjN76ksTjqVakWNshiltrpSzJurah7ZARaVmn4M2n1v9vSTjaJET
 gKN8UgjsJHYFaxPyn4bwqjv3z1Mrt9uaM0cNfXZpvm/9nhZP0Eg7Jo2PdcqNoU0z5TwrFZYqKSA
 PM3q6FEFjgQc7Dkm1CnWwkJxSbFWWpK33Cdiy4R9QB0+hBzusxKqs4yqVwkliQotE9gXI7VBmO+
 N5P/60ngOdeJ68JZ3S8=
X-Google-Smtp-Source: AGHT+IGShAj3uqXd20/wHGAEAEEDsukFGVmdrmf2BOrhDIZN+bGkssJ91gQCTddYU9hYTsK4FE4BYw==
X-Received: by 2002:a05:6830:350a:b0:71d:5a36:d9ce with SMTP id
 46e09a7af769-71dc2c5a1dfmr3183923a34.5.1733443688329; 
 Thu, 05 Dec 2024 16:08:08 -0800 (PST)
Received: from takeshi-suzuki-dev01.colo.rubrik.com ([104.171.196.13])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2793046d9sm486212eaf.30.2024.12.05.16.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 16:08:08 -0800 (PST)
From: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
To: qemu-devel@nongnu.org
Cc: codyprime@gmail.com, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
Subject: [PATCH v2 0/3] Add RW support for 4k sector size vhdx
Date: Thu,  5 Dec 2024 16:07:48 -0800
Message-Id: <20241206000751.34694-1-takeshibaconsuzuki@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=takeshibaconsuzuki@gmail.com; helo=mail-ot1-x32a.google.com
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

The first patch adds support to read and write VHDX images with 4k logical
sector sizes. This is done by internally converting bdrv sectors of size 512 to
logical sectors. VHDX image creation with 4k logical sector size is NOT
implemented.

The second patch adds an iotest which reads and writes to a VHDX image with 4k
logical sector size.

The third patch adds logical sector size to VHDX specific image info.
    
```
Format specific information:
    logical sector size: 4096
```

Takeshi Suzuki (3):
  Add RW support for 4k sector size vhdx
  Add iotest for 4k sector size vhdx
  Add VHDX specific image info

 block/vhdx.c                                 |  97 +++++++++++++++++--
 qapi/block-core.json                         |  27 +++++-
 tests/qemu-iotests/315                       |  65 +++++++++++++
 tests/qemu-iotests/315.out                   |  20 ++++
 tests/qemu-iotests/sample_images/4k.vhdx.bz2 | Bin 0 -> 37834 bytes
 5 files changed, 201 insertions(+), 8 deletions(-)
 create mode 100644 tests/qemu-iotests/315
 create mode 100644 tests/qemu-iotests/315.out
 create mode 100644 tests/qemu-iotests/sample_images/4k.vhdx.bz2

-- 
2.17.1


