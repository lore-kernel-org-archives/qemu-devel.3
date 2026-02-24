Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC283F3C9A1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuj5-0003iK-BX; Tue, 24 Feb 2026 10:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vuuj3-0003hX-Nj
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:53:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1vuuj1-00083y-0X
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:53:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483487335c2so51785835e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1771948405; x=1772553205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NX+INBnr6aHArn5DuxoUEzmoCChewtj1R+qgypjDrjU=;
 b=gnHgy750btH2ihyug5oczJYjG1m13kjF5fdyxIfdhd0+LeREbfe0C0/4Tmo+NFiIKs
 JI3otB923BLK91vPUisBuheU3G2vyK+ORVWP3A5STaRc9yhdN64oGECQ91Ii+r1rEFHR
 HXtG8+g3LbmjPEFchXA5+46IfVUa/zMenhY5fspihi9+8dDuJu7D2NEzqNZ31//i+CMh
 H2Z7v7vXT2OxZCzsoAikCax+jO4KVrEsatu6xwn1gB+mRSYxP0Vg/kNIPlIVvzl34oaF
 hPwT6j2TV7nPRxhiBZO0fRKLn6KperAN47IKrLrLVfquWzl6NBpQ3AL55TrIDc7OvpT7
 SIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948405; x=1772553205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NX+INBnr6aHArn5DuxoUEzmoCChewtj1R+qgypjDrjU=;
 b=EnQr+WH/tGLw2wKIj4daet0cKGLQTUuyXJWbUC0uZO8OQzgWP60c8Fw7Zpz/O0cZJW
 W4BNzaFA8B0SyGLH59nYj9WxXTbhZ7WhmL2OR8JlEMq7DD4XqymM1zfKvEHa6DXe6eV4
 +FezAnkX2YJJs/lyDuD6SQILYkKnuko3dhZCLbpuWqQpe98+sZwVTjTid3y/RlOdbRIH
 I+kvmelH26bmj84F9uVjke+psrYSz3q52ZkFwLAZNBIrJrcnRSr2/u725qMd1xIbRGUd
 RyU/qGrZ/IU4At/KOnOjxiglCeL4nB+Xq9RcO19wN8iMpvoznMbHN4drE+bRFWQwry7T
 vc/A==
X-Gm-Message-State: AOJu0YyX2RqD+Q4JIQq914lKDgrU70XkR6yA/UBXbs4eFx2zj6WWJ60A
 vNwH2KB2AAEwg7vaYkLkFd8rxE4G7o3b+0k6F7ZtN8BHj1E5+H7jOFIbvJcc1kR61+N8r+YTJuC
 ATyAE
X-Gm-Gg: AZuq6aJ3gprkVqZ/7s387vPtWMdU6h3NT4crE4mQNE1R7AF9+/I0mmSc1Zo/tiuo2Uq
 QRn0KgLv+LzBGSM89usrAwTk0BW2J438cU28wfhvz3EdYqWhvdDR0JmUDhGnWvt17ST8LCIq9tk
 4/4stSX+kcF1EAI1Y7GisZlVTrwVgNgYh35DEIazX4ntqjjFGiZ07l2XntY/XklSOg6N+9Q/Xvq
 +EgbSRs3ivVBvniW9o4CL44gQxFnMbJ0wvAnfCP5tSoyV0TAwSYQ77vpXJu6shvjztsgFQKmqMF
 WZeLHolv3A+CcLjeW8d3x8oQAZKcG2+IcwL6dXf0OxYv9ebrxSGPnpqAtqh26Vxyu51FMX+cWN/
 JaYox9VgDzb7H3buF5YDzcW32FsZDReQZ3yauRIV5Tf/fs+TaqTMzu7iGR7fb+AjUT/WWufcl1/
 C60k35dwz//lKtRKrcrY9Ir72N0b3uJj2UEQ==
X-Received: by 2002:a05:600c:46c9:b0:483:a21:774c with SMTP id
 5b1f17b1804b1-483a95eab7cmr219446915e9.25.1771948404978; 
 Tue, 24 Feb 2026 07:53:24 -0800 (PST)
Received: from localhost ([2a01:e0a:e9e:c3d0:7a5b:f76a:6cf6:aac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd75df9fsm7008955e9.13.2026.02.24.07.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:53:24 -0800 (PST)
From: Antoine Damhet <adamhet@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Antoine Damhet <adamhet@scaleway.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 0/3] block/curl: fix S3 presigned URL support
Date: Tue, 24 Feb 2026 16:51:28 +0100
Message-ID: <20260224155314.1658988-1-adamhet@scaleway.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=adamhet@scaleway.com; helo=mail-wm1-x331.google.com
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

Hi,

This series adds the support for S3 presigned URLs that only allow HTTP
GET requests. While working on this I also stumbled upon a deadlock with
concurrent I/O and slipped the fix here. Over the years there was
already an attempt to support these kinds of URLs[1] and at least one
report of a user in need of the feature[2].

Unfortunately S3 only allows a presigned URL to live up to 7 days so we
can't really put an example with a stable URL on the commit message but
here is a presigned URL for the archlinux cloud image[3] that will
expire in ~7 days.

Cheers,
Antoine

[1]: https://lore.kernel.org/qemu-devel/110120539.4133.de5ac8a5-69d1-4f59-9540-4a679771a547.open-xchange@ox.pcextreme.nl/
[2]: https://lore.kernel.org/qemu-devel/7b37cc65-1314-29f4-006f-70836bdfb4b4@linaro.org/
[3]: http://test-presigned.s3.fr-par.scw.cloud/Arch-Linux-x86_64-cloudimg.qcow2?AWSAccessKeyId=SCWDHE3XBQGZFV282QKG&Expires=1772551595&Signature=fqADX1DJvEKcC8iEeoZpssYSkTI%3D

---
Changes in v2:
- New patch (2) that refactors the http(s) QAPI types
- Specify and reword what happens when using 'force-range' with an HTTP
  server that doesn't support the feature
- Document that 'force-range' defaults to false in QAPI
- Fix a few typos
- Regen presigned URL[3]
- Link to v1: https://lore.kernel.org/qemu-devel/20260212162730.440855-1-adamhet@scaleway.com

---

Antoine Damhet (3):
  block/curl: fix concurrent completion handling
  qapi: block: Refactor HTTP(s) common arguments
  block/curl: add support for S3 presigned URLs

 block/curl.c                          | 115 ++++++++++++++++----------
 block/trace-events                    |   1 +
 docs/system/device-url-syntax.rst.inc |   6 ++
 qapi/block-core.json                  |  22 +++--
 4 files changed, 90 insertions(+), 54 deletions(-)

-- 
2.53.0


