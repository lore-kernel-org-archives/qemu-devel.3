Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248A81090227
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3E1a-0003Zx-03; Thu, 19 Mar 2026 10:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3E1N-0003Z9-VF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3E1L-0003fb-BL
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773929202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QwqZIdQs7IP0BLl0cY9ooPt81zZxWlzH1SwJmVaLk1g=;
 b=G+34Gk9dR3Z3EtNldVSrdAWKBdRjC5xzxMvYqgGWE4AyBqEckaF9FznY+lxF2RkVmBLIlp
 UtxfJuwQ74Smn4oSDvYCvGvR6SrI/TNrrthUZ07YYEguhvl94fcle24IY+xpMpqkXKQRbh
 pVbWJtj4QgCPq7bD8QMLkAJOOPQyb3Y=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-KsqwEPaaNlCLrvrYRe7qzA-1; Thu, 19 Mar 2026 10:06:40 -0400
X-MC-Unique: KsqwEPaaNlCLrvrYRe7qzA-1
X-Mimecast-MFC-AGG-ID: KsqwEPaaNlCLrvrYRe7qzA_1773929200
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-95111ae8112so1326694241.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773929199; x=1774533999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QwqZIdQs7IP0BLl0cY9ooPt81zZxWlzH1SwJmVaLk1g=;
 b=R4nO7mIjjDIrlBVgbMRdJa3c7Rcqm9TbWbLhhFqc7aEjMjIcKXi7BsXz2g6r/Vzvxi
 oMz6mFQ7n/jGMdJWKFR9X693QDJ2zTAUpajJPQ76U1+c0Nyq5mNfH+JnPs9y0FyOEs3Z
 xahfBfYn2IJV/xmXOR/f7TrfZSbWuRmPddHjJc3NhW7gFZOVLpHaeCFW3OhOkWvB03ay
 BpPNwq+LwxORtcUAB9YhpX3Fhk3vigp0FBppVd3b89Eg8CcR1SwecvDEYntmaHTGAHR1
 NS3H4GAmv6aW9dFf38k5Csy2lzIKV28fjQQ60RWA8hAbMqtPZRZKBZbeGTNOA6rCSMEy
 ygmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773929199; x=1774533999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwqZIdQs7IP0BLl0cY9ooPt81zZxWlzH1SwJmVaLk1g=;
 b=JHaKWcQlO/MeC153QUeRGuWm86ZJEeEUcYnLG92FTxtICAQwWcdYr7Mm50hNImEpeL
 n1zLTsepmC/SrQ7uYtM/9Y1Bj5e3IKbmJPB6DCgeBPe0ylNE8VTWmoVcCenNbWU6FQUS
 pjX2GbhdnKmjgLorRJ5Tf1TkxEArZiVIXKbIfV4cTuwK0Wan+bV/kMpscG//WVHLqmNj
 WzpsbUiarOQzXn45PzlQh1LTDVunxTdxQ/bVNI0rz1M7JxW5ruees/iZlHv37pkAYsDa
 ZvGR+yqZfwGQ93xm60IaEMyfKsc+sdoRQtbnI68Xghmve5yOuXbHbjDiQ5p4Bu2QJRkT
 LWdQ==
X-Gm-Message-State: AOJu0YwcR9cZlsT5SA/ql0Sxgauab28Nvdbd3lK27JTbmFflXwohUvFI
 9iiyH4KTDDdyJwF+sU8FazVaVAwM9HDAtgo5HiB6Htkt7JCMLQ9X2OGDnSloMUf86/CkgPG1h2a
 oYVdTrLtrdOltXk/FdAvX/QEfCTSwr9ERy9VyUTeHgcouezLT7X+dQM0/3n5uzq4bnI4EZLO18T
 NVUhQBO5sdBPga+2fMXJK2CNuTz92hgczJIp/WEw==
X-Gm-Gg: ATEYQzwIi9bA23D1lS8zMTunUPipUxmnXQmbiPMrB2id7MbIOCuPnl+zTev6hmQBwR2
 xFooKwS8sRaC8vR/Ye4BDcDsoV+/gLVSY797RMdSYjxza3kZUhJ/WgUDW9JR1zej8xmDiMEbGet
 VjzPCeTHIWanU2ME+RKPXUl7TtkKwOCqiFFtRe91oou9ugATKUqdDi0+Ib8uuhwvAw8KhLyJzS8
 4obt9MGr+r5bM87dAxNbydZrnWFnjNLFNNbSJqzDFbI6kAxmEmmhcrbH1JfZtsNHU4ZQ1NEgztw
 ygUC2Q4iWF9BNpzuzJ/Uw/dLer9f+5IoWLwNR/TTmCEbQR776aVg9vPGOl9EV6yqEqhbgWHvCPY
 oXbNSf4K2HCw=
X-Received: by 2002:a05:6102:3ed3:b0:5f7:240f:bbee with SMTP id
 ada2fe7eead31-6027d084dd9mr2972432137.1.1773929199240; 
 Thu, 19 Mar 2026 07:06:39 -0700 (PDT)
X-Received: by 2002:a05:6102:3ed3:b0:5f7:240f:bbee with SMTP id
 ada2fe7eead31-6027d084dd9mr2972384137.1.1773929198609; 
 Thu, 19 Mar 2026 07:06:38 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b9ce294sm44932506d6.30.2026.03.19.07.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 07:06:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 0/2] Staging patches
Date: Thu, 19 Mar 2026 10:06:34 -0400
Message-ID: <20260319140636.74007-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 5a68a3add61208aad34d47134fdcfd3f407d2ce4:

  Update version for v11.0.0-rc0 release (2026-03-18 15:56:51 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/staging-pull-request

for you to fetch changes up to 2a13e310732154f75a02be54e2b32524cc869417:

  hw/display/tcx: Init memory regions in realize (2026-03-19 10:05:18 -0400)

----------------------------------------------------------------
mem pull for 11.0-rc1

Two fixes included:

- Xiaoyao's fix on recent coco guest boot failure
- BALATON's fix on recent sparce device-introspect-test failure

----------------------------------------------------------------

BALATON Zoltan (1):
  hw/display/tcx: Init memory regions in realize

Xiaoyao Li (1):
  memory: Set mr->ram before RAM Block allocation

 hw/display/tcx.c | 24 +++++++++---------------
 system/memory.c  |  8 ++++++--
 2 files changed, 15 insertions(+), 17 deletions(-)

-- 
2.50.1


