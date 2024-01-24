Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748A5C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 07:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSXtm-00034v-6G; Wed, 24 Jan 2024 02:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXtj-00034k-44
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:11 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSXtf-00033t-TG
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 02:42:09 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3392d417a9fso2204457f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 23:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706082125; x=1706686925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cf7qB2BMl9WBhIDGMxLzOoiU+ORQO1oIrTiLobNFJVA=;
 b=lm9X33tPKkb5EtuLERlMkDWxNidzhFSfhKfwQw9DH8vXmTfQ33oQtqvjL+ipX/uNA+
 E3f3pEbynIOKgFpp/x/OEXL+OTXdOEMU8JgpnMtG0mgNXt7t0f/apoFDEhoJzp3+8qhm
 544CnDwV2MDersNXeAzyTUZzdVO/RT795fkl6qQZRWQJ8dBIKs8457e4RHNrreqF+nf+
 iNia2ohUkDKng/xkp5gbP3ZSwQd8m6tRe/tkj2hmFAtMjifz5Vn2yVxGqOggMFToZYKY
 m8GyvPOW3Jm/BkXCvJAnupxIhQVtgDIHJuhLh2Og/uFROfdeiN1NDh4kFE3fBvnVHKG6
 DN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706082125; x=1706686925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cf7qB2BMl9WBhIDGMxLzOoiU+ORQO1oIrTiLobNFJVA=;
 b=sW5zMuR7LDCN/9STIAYM5d2jmEMGS6Q+VcUi3QOVIvEgxViSDMWlOy3Cqos9P5yqnK
 ffW/56r8Yxd+iOD7OJWZviu6wDrX3N1/EBEE1kUiIf+44kOydh0A5kFvMrLKevFJpoN/
 0/vYk8iZSQdgy4utigvvSB3LaZjq/0JBn4ySA0wnbyVMTN6l1WyEaqtH63TdHdV4EcJa
 eHbAUSkhuI7fa2JWgarSkOc40c0UKS+/R7nutPsfeMDOHCEZVODbjwm5saKGrh6f3n01
 Rf8rKltadDl7nVMYU9X4jBieqX86TpgFABTl1TTfkKQQGF73Qp52kl3VGLDa5TGxY6Wi
 EZ3w==
X-Gm-Message-State: AOJu0Yx8gX6HTDj817Ku/c0NlPOakuM+gMG4WboGAppt13gcKco91WHc
 9ydz1yk2JUuIRJmUiCaeOQnLrgNM6c9yi05TbQyUawHX9dt+ZNpBACk2FA/jz9JIVpmNczUfk17
 K
X-Google-Smtp-Source: AGHT+IHy1iSPich9I/us8UAOfoBIQg7binsg2YL//o5jb1J6NjsC2eFZkXFly7SLwNZNLFDReoHxsA==
X-Received: by 2002:adf:e787:0:b0:337:c54a:199f with SMTP id
 n7-20020adfe787000000b00337c54a199fmr232653wrm.86.1706082125347; 
 Tue, 23 Jan 2024 23:42:05 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 w15-20020adfec4f000000b00338a3325331sm13143027wrn.69.2024.01.23.23.42.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 23:42:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] hw/accel: Use RCU_READ macros
Date: Wed, 24 Jan 2024 08:41:55 +0100
Message-ID: <20240124074201.8239-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use RCU_READ_LOCK_GUARD and WITH_RCU_READ_LOCK_GUARD
to replace the manual rcu_read_(un)lock calls.

Philippe Mathieu-Daudé (6):
  accel/tcg/cpu-exec: Use RCU_READ macro
  hw/9pfs/9p-synth: Use RCU_READ macro
  hw/display/virtio-gpu-udmabuf: Use RCU_READ macro
  hw/scsi/virtio-scsi: Use RCU_READ macro
  hw/vfio/common: Use RCU_READ macros
  hw/virtio/vhost: Use RCU_READ macro

 accel/tcg/cpu-exec.c            | 24 +++++++++++------------
 hw/9pfs/9p-synth.c              | 24 +++++++++++------------
 hw/display/virtio-gpu-udmabuf.c |  6 +++---
 hw/scsi/virtio-scsi.c           | 12 ++++++------
 hw/vfio/common.c                | 34 ++++++++++++++++-----------------
 hw/virtio/vhost.c               |  6 +++---
 6 files changed, 52 insertions(+), 54 deletions(-)

-- 
2.41.0


