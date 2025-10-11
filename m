Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD55CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 08:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Um4-0000t5-Gq; Sat, 11 Oct 2025 04:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1v7Um0-0000gI-O0
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 04:16:18 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daan.j.demeyer@gmail.com>)
 id 1v7Ulw-00073z-G9
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 04:16:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f42b54d1b9so2374154f8f.0
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760170567; x=1760775367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OxOXkUWjbNfdgOyfCO31w4sh83bWsOK8NhWXhJg34z8=;
 b=kdK6OKYf8AAtftMsy7H/7IPNXNPtrYuj5l3KtKZz3GTXIA70jeQYMKLjdVuqnu9Dws
 kgGTDcFBeyUsVEffzT09o07lkuLUELgZ7OadgJ+PDORZRd25nWlYGmBLeY7xL9wF7QdR
 kK7rSKxnMih/k9OCnd5ngkag6OGXohT9faY+0mpKUuQ3/aBT8tfpLRD/Ipsby2RxXpFU
 Le29GxgHhAdy/6RGLQRd8NUJNJGUvAxtcaT49d3SrM/EGsy4UZIqKZeAu+OX+c5B7V2U
 4rBDQtaYpqQ80IfJjD5SXtfWlWgDTcSjyBieCGjY9n86W9f6w8uiYLCXaoOTZ9CRMs7/
 QUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760170567; x=1760775367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OxOXkUWjbNfdgOyfCO31w4sh83bWsOK8NhWXhJg34z8=;
 b=p/xcaPdpo6LflTvshm7yIqjGISGXy3j9qSaUyNZtAJIdzf+7Rl4OFuDX6iBvJ3IYQP
 akcaURwEBeN3jQdFjyg2vw/awwdIBfckBjFhgG0ia8I9FAGzL4Z9X5KA8XHHietFI14v
 Z8ummu8M5dWC1Cn48/Q109ipmSngl8hHV4hGSF35MR+muJjxWKGVWZ6UBF0+pq85pTkd
 S0Hk8mERLARjXKtvfQeKemAIUHe3jXR39uOtp472tPQKHbgeLf70eIgMPR9TOkiAiTiN
 FrB2GbFFOWAbm7oMhhTm2zVWiDBS5B3OnUE2DagVFLbssBEFm5LnrD+JedUngT3/KjRu
 ZmbQ==
X-Gm-Message-State: AOJu0YyYK2sKpBwJNrD8V78yHI3aslc3nRKoQgAe9JoOvZ9mV5px90Ri
 A6iySXqvlr6YKXanZQQG4CFTfUMhibzJKANksKu9JtdRf2Gnl6D1Uf1PQPgElLXc
X-Gm-Gg: ASbGncu3A9h8XeWkkMTcgY08ZwlYYPugG75eX/4bdJqw8mBcYNtXxIBHJEQHrU2C7hS
 xzo+wcoks7OEWnOPkMtcueZy0K8FjH0TXib6865dkBtGri+vDjZtMJcGE14iBBa44sQ4Bdnal6C
 i7a4y571T2KPHuw9+5UIMYH3si6yAF9iJXGQMDp3H6TO5ikeePWG+EMFN86MkBDvY5oMHoyCmrj
 /BGJQUyeje9Wa4OEyAU+zIZO6+MXPXoWDYihUpjN6APv3hUA5XFP48bGjs0z5PgCRo1AJ/wusg+
 I3nxmEZS5p2r/bndTILSKm13SLKBEb8t0M1KfnLs1aHIRszvqGX6NY8p8MoVq9MW1cp/1lA+U+3
 OoGde+tWRBFbWvcAUv5IwIxsZczK6FVhFvf/D4FRj0zFVS+r6fbTykxEjeiEQJukYvuZ7508UWs
 l3NuoFQvkhUpwPX8c3VWDEuXuRhMAZHEc+9/PCc+J6XQ==
X-Google-Smtp-Source: AGHT+IHTcpxK5cFzuKPOX4FeMpZjndK3JzxDXfildK7XdebrPdpLZjQm8nFu5O1ULX1kwsrpeagp0g==
X-Received: by 2002:a05:6000:18a9:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-4266726dceemr9814866f8f.14.1760170567411; 
 Sat, 11 Oct 2025 01:16:07 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T (d54C349CA.access.telenet.be.
 [84.195.73.202]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe69sm8045969f8f.32.2025.10.11.01.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 01:16:07 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH v3 0/3] Add support for zboot images compressed with zstd
Date: Sat, 11 Oct 2025 10:15:50 +0200
Message-ID: <20251011081553.4065883-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=daan.j.demeyer@gmail.com; helo=mail-wr1-x434.google.com
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

Fedora arm64 has an EFI_ZBOOT kernel image compressed
with zstd. Let's make sure we can use it for direct kernel
boot with qemu.

Daan De Meyer (3):
  Rename LOAD_IMAGE_MAX_GUNZIP_BYTES to
    LOAD_IMAGE_MAX_DECOMPRESSED_BYTES
  Use g_autofree in unpack_efi_zboot_image()
  Add support for zboot images compressed with zstd

 hw/arm/boot.c       |  2 +-
 hw/core/loader.c    | 41 ++++++++++++++++++++++++++---------------
 hw/nvram/fw_cfg.c   |  2 +-
 include/hw/loader.h |  2 +-
 4 files changed, 29 insertions(+), 18 deletions(-)

-- 
2.51.0


