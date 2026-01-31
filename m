Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC80D46C1D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0IZ-0007OX-9f; Fri, 30 Jan 2026 21:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IV-0007GO-Ej
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:15 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IO-0000Tt-QY
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:11 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a8a7269547so25942025ad.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 18:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769824866; x=1770429666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2+1Hel5DeAkfEBIM4DKwx39tS6qqWr3LjIF89BUjXYI=;
 b=ivo/HP+cvaEF6O31PvnCNaVcWZ5cQtZFonT/2tVWf0ZZC9jksrThHy4H25St42uXz3
 svPFk+mWrAWvKeCuuShY3DUYQkHR0zNoJIj7zvO/mgFJUJGKJM+0GZiePSm2/2e9KcXA
 xD37Jn9B7BobH3zUleYaZLOvtKPxEvO3fdqqFKbTZ05Gl9HZb4VwkqW3qqQLqplC7jr2
 lGNW/Ng7JbqdoBrmlqtqt741XGeDFTGw4M5FG3Jj+Y7c/kVSEBICE0+jbIuIhtaNmjIJ
 TXeqk7fnPO9FBNsyCJ5B1yO+LrgDd70NDE9x/Mw7Vi/tTMeVHjE9DZSrRAkDRpo/Eedd
 v6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769824866; x=1770429666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+1Hel5DeAkfEBIM4DKwx39tS6qqWr3LjIF89BUjXYI=;
 b=caixjp9rzZUCffcW0Cb3d5M9cZUapz/4bGrX4XDC0WUf7LND2sUl6pY62v+WE/gWy0
 X6WMff/WlN7VVOsMzDYBfkOJYDf6PIprBmDX96sVkWiiqJNJtavAUiMKHwplVbE5V5l9
 eBBcFTo+qRa0P58JrEppqpUFrzhZ6A9eASN+Us10aGj4DacMQv0d0AaH7+ot4v5myVI0
 FXm6VIIK8nkqXSbX0ks60xv55wCkH0zRAQ1U1idSk/WvtJpkEZWS+DLsMzk7Go6DQEIA
 hhlPUtmDvV4UmJwaSKUMtmx+lvKkzq3eYiajSDhOm3SrLhQCL9ufidJ2DGJATmENhxyz
 EEpQ==
X-Gm-Message-State: AOJu0YxdhmhuJsYhAH48edKsJrX+bbhZUEkYhb6B09846o45Uo5auSBO
 663zPg21Q9DxU6fqc2XfxVVDrhQzvu7uV0x7lmhmEfq2Ten8a23nEgsxfGWVyH/c7M8/Th+6Qo9
 c0hYt
X-Gm-Gg: AZuq6aKeP4IVoL4+qv7jj0Ci4NJOKadQEhIMugtYSHHFLXvSDhZfUfXIRSAqHBStqU/
 LcxuqIUKxHI73I6fIIghSRFCLYp27nI9ocnXNg269wmBspdbl83HJ4eHxX1gChtpKQyh8n9Rqc5
 hf6J9gM8i5ufgzYw86XKYHhUNGjkgPZKVaG05HilQJOEn2fIQtdAWZw+nQqxqCkQr7b4RUG5BFw
 DkS8OyhyapDayJhG+UYz+f4CcjH5hEXiG39gkDGvb0Gri+17rxSOcf6AAiZQTQ6y0ub7cgIvslY
 UgwsmH7d9jTjeyYybYKuqn9Eelz1CByD9WAtrAcq+FGNdwn3DZiEd2zw6uvSHTUj6gkvNFUwp3s
 wT/P7J8UBSwvCG/0WmSnfZwTZWZbqX3hvt/P7hsiOwH37uvcX+An3hi/2HsE3HhH9wn7TuPLy0p
 9C+MM7z2rBFtUYmPkX44sVsDvj0QtvoY7ao2GDsfEvrW/V0giDasJFLRX8QH+ZaDQq
X-Received: by 2002:a17:902:e810:b0:2a0:cccf:9d24 with SMTP id
 d9443c01a7336-2a8d96a2943mr49809745ad.16.1769824866413; 
 Fri, 30 Jan 2026 18:01:06 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b41390bsm84697975ad.23.2026.01.30.18.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 18:01:05 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/6] single-binary: hw/virtio
Date: Fri, 30 Jan 2026 18:00:54 -0800
Message-ID: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

This series eliminates target specifics in hw/virtio and replace them with
runtime functions where needed.

Pierrick Bouvier (6):
  target-info: add target_base_ppc, target_ppc and target_ppc64
  include/hw/virtio/virtio-access.h: remove target specifics define
  include/hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header
  hw/virtio/vhost-user: make compilation unit common
  hw/virtio/virtio-qmp: make compilation unit common
  hw/virtio/: make all compilation units common

 include/hw/ppc/spapr.h            |  8 +---
 include/hw/ppc/spapr_common.h     | 16 +++++++
 include/hw/virtio/virtio-access.h | 26 ++++++------
 include/qemu/target-info.h        | 21 ++++++++++
 hw/virtio/vhost-user.c            | 11 ++---
 hw/virtio/virtio-qmp.c            | 70 -------------------------------
 target-info.c                     | 21 ++++++++++
 hw/virtio/meson.build             | 17 ++++----
 8 files changed, 83 insertions(+), 107 deletions(-)
 create mode 100644 include/hw/ppc/spapr_common.h

-- 
2.47.3


