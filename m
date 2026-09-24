Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264A5C98317
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9i3p-00028L-GO; Thu, 24 Sep 2026 07:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9i3n-00026O-RP
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 07:56:19 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9i3l-0003NA-0K
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 07:56:19 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so1301451f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790250975; x=1790855775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ewZB0A+0FkfTeWavSCcxgb0CTdPDsDCGV16o07Ck9c=;
 b=gcjyoIzOUk+zQIgFq9Oswmd92e1awCGM+Yzd04uUk8PjlEX+gAW1qrk6THtAtxbcXu
 zYuAl0OdV1/fuP9u3CmK44lo/iUmqUtuiAA4tn8Lsq++rneHBAvLl18z5qtZSsbZ+Dhc
 4l0JyZIvBT8oq2CBbM+bv/9zep8lzPHZ9CzVHy7CflmTUDyY1U07odEUU219L34tK5Jo
 vEWefqv8wLe3KnXuoIue2xqhM4/iyWq2eseGLuCyU1BEybAxLpMRAg8Ks8BG7Qd1v8ql
 PYRKHQwcGnLCqM0GzAE+MW2tmniMxZo9HoIezxf+BWjN+wX+3mjpOQEDVAC9akiMoCjn
 jV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790250975; x=1790855775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ewZB0A+0FkfTeWavSCcxgb0CTdPDsDCGV16o07Ck9c=;
 b=Mgt9Yz1fD8+x8ADJdQgB1SviiB06/KNCPbkoq/vCfXlfdFLBCz8mVMshlpfpE5pjhZ
 O2A0viEhCLhRTF/C5pTM69InASK4Y/gofKDhrTkWJ7mOXeIFDib8PHub2uyxX3yY/fSy
 EO76uAjifVQfXccAWhnKl+dTU/kWexEQZzukvsdiZGcDkslZk0iEMT36IfOZagFe5vlr
 myJ4xDZoUxYNCBE/8MJXavYFI9DrCiDwVP4O3Nq+FiLRGvAoTJnatnPKNSxjN/OEYok9
 qpCd8/5PRhHwVpUje15Uer4whPbs55vzApK7EOiy2MyoQ9pgxFE2fGJHzCZxjo9LEBIY
 TXrw==
X-Gm-Message-State: AFuF++mM1e4wDlAz/wozrPftMVEnlY8VhA6FmMISjRMkHL8P/OzBCmNn
 CUPkHIZfyzq7/esZ/Lzb1pOSpBk0GNk4EjVEUUmLhTG++j5dGolZ4FW6Plf9g62DhE0+jbkZpvg
 mD+J5
X-Gm-Gg: AYBFou2OH3+seHRgZIkkyZDXzqrb7LU7pB6VmL8rdYOcphFLhTPpelPuEZETm/cgxdR
 9NMrFIffvgtrv0bHCENoqo7NjGZUgI2dybAtcvqtnNMJu9EsB6LrsnLZoiRVZC+EMT8l8+tv+XI
 dh6jwZ/bS3aT/3dY0cG+QfX6PA1Wh1vNYRFlRgUKAAPmHCpayJsp84mr/YBnH2jNOOBXXyAvsQI
 IXye+ZRY+nLKltsc4RckWiy7+zvnF03JtcpH8Nxs2wKjLexIXc2+EMoW8eCw96EXfMZxUQa0WuP
 qxWadQSCbl6LHUTrXxx0YKeQnYRplMwGEtSQGguB8dgKtpE0kob+FT/xKe0yLFuAdUZ+Vz6HZLd
 XRqWIWoor7Wu559q1n7jsiq46S8Djzz6OZC4qfegJ/RV2qQnkaZlCtsUTWOOF0xFvwtfyQZmSWq
 uESKPJ2oXOdsEp/QzFsw1lQLOPQBvQDo6nDzWfDjMQEetMdMWhsueXTAuYG375kMCK+qpB
X-Received: by 2002:a05:600c:8719:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-49fe66c6373mr40126925e9.10.1790250975061; 
 Thu, 24 Sep 2026 04:56:15 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f9ec:9c2f:7d67:4ad8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cca160sm58870135e9.12.2026.09.24.04.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 04:56:14 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 0/2] migration/block-dirty-bitmap: fix postcopy abort with
 bitmaps on several nodes
Date: Thu, 24 Sep 2026 13:56:09 +0200
Message-ID: <20260924115611.4098417-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
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

Postcopy migration of dirty bitmaps kills the destination as soon as
bitmaps live on more than one node:

  qemu-system-x86_64: ../block.c:6400: bdrv_lookup_bs: Assertion
  `qemu_in_main_thread()' failed.

The postcopy listen thread resolves node names with bdrv_lookup_bs()
without the BQL. With a single node the name is sent only during setup,
which runs in the main thread, so the existing test never gets there.

We hit it in production with libvirt: a CBT backup leaves a persistent
bitmap on every disk, libvirt enables the dirty-bitmaps capability, and
the next live migration of any VM with more than one disk aborts the
destination after the guest has already been switched over to it.

Patch 1 resolves every chunk but START from the bitmaps that START set
up, instead of from the block graph. Patch 2 extends
migrate-bitmaps-postcopy-test with a bitmap on a second node, and it
fails without patch 1.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Denis V. Lunev (2):
  migration/block-dirty-bitmap: fix postcopy abort with bitmaps on
    several nodes
  iotests/migrate-bitmaps-postcopy-test: add a bitmap on a second node

 migration/block-dirty-bitmap.c                | 59 +++++++++++++++++--
 .../tests/migrate-bitmaps-postcopy-test       | 19 ++++++
 2 files changed, 74 insertions(+), 4 deletions(-)


base-commit: 942229961efea74b153c44c59188eb08375f10f1
-- 
2.53.0


