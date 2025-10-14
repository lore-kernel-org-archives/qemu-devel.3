Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91F8CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cxR-0007vD-5T; Tue, 14 Oct 2025 07:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxO-0007uh-AX
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:42 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxL-00081n-Ur
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:42 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b4aed12cea3so823833566b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760440357; x=1761045157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Svb2oNT9or1vltT0+6b3m5vDocAyrYfL4zg65Nw042I=;
 b=zg7sh0SnRhd/mEq5igfGudbRcPI0lxRd1DnP2KoMK0qIxqDSHbVp/Wfb4ORDajoDja
 cO9Lw1EQQ161JYiQroCfODwABmW40wIvmsJwpfNqctcyAkkgcmXjEjEd15+Xmi9jMUDs
 H17AzawfPqkqLIDsl1qah1/HHRT1PYiUTPS4zY7lo5OmNM+mW4V8qcO2Zske83kKkLt/
 KPLfB0A736/cbp0MqoFPN8+qg4zEh+LqTOlqTf7UrGbH4YQcepMKgCCTBeIHT1f/meXV
 RQCwDkmy0b81MnDXkfS87MFcZ52Xozm23dJ97DbTPpyrnX/MUyA6bzMfgzL2R5LE+Uc5
 vPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760440357; x=1761045157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Svb2oNT9or1vltT0+6b3m5vDocAyrYfL4zg65Nw042I=;
 b=UzwNarpLsPFEP0HwIsMLNLnXF355xLKDhx3vPWNjxWmHrT2i0Su1qwoBXTJTj1LzhS
 Anx5uWSZNTNU+JtpolkCQrBItXj4f/dfZpkYwhzG6S3tNR+qgUMoRGPZaFjeFJSUf/wk
 0MabqrWPxbxORJokcHkp/lPd3n7y/bznWyZLVegppbqkhdSp8C+nCKOVt1mLsnIVLuND
 Ts3YMob1jUN1QFQCxNWPH/Qj9XuMD+mEjDOBIQK947InkATFuHHipYAnzuYyC8hMLg7b
 gDnmx5RdQ4aBgAD00gHGP3jnRJAi7BUMcrWKnovvPFWIaby9gSvL6RTioSlWRlx3vHKE
 GRIw==
X-Gm-Message-State: AOJu0YyMMp88u04tIO11gWTphYxELenyZ7JPm1qYet612sTHLFi1fO03
 SdmuMMVW8LpoLGIdEuIHub5Ibbcs4t2DkHBKgtTEZLnCOOcIEu53VNWoY57hybca2EY=
X-Gm-Gg: ASbGncu5E1d+gyFixKEV7et5SKEZCm6Ubf3XilDsDsLN8NSLF5JyHzPKIWHQjtwvegw
 ycXa6t26P5CzN+H4fD+w0ZIB4rJB+fUAdZDw7mqgbB38jt6EaNG5P7lSNuaAlRDjrdGB/2CPNdt
 nEWS1ASQDFInSoDtZK6tM88R/MvScNUHYSRuqtSb+Hxk0IjinAreDSoyRshFjNCzoHhwwJl7h8H
 KC8rvWAQWjiAEKE+jr/j3e+O1TXcjtDIDqXgotJzAgQQEDeGJ3jZJ4CB2hCpWi06DCX3Wvnf+ug
 VKOJOBBLHq4LiENM71iSpo1WooJzZIjakq/c1KK/OggHJgylbbc8kD9DX5dU3koG4VdsZBZWe91
 sgC6zFNMt37Zv0tUX/UegSHsZEsShY5bHJ7+2nBDhddB4RBpCfONmV5Hn
X-Google-Smtp-Source: AGHT+IFIevHdJvXtsgzxk+sUWSZJ7n2+73TStVTDhq6g3DU//dlX//gLihQUjUehoLHlCNUEadABzA==
X-Received: by 2002:a17:907:d86:b0:b3e:f987:d6a8 with SMTP id
 a640c23a62f3a-b50ac4da0bdmr2559194566b.44.1760440356631; 
 Tue, 14 Oct 2025 04:12:36 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d9920ec0sm1149295466b.86.2025.10.14.04.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:12:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 112895F812;
 Tue, 14 Oct 2025 12:12:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/8] virtio-gpu/next - misc fixes and MR handling
Date: Tue, 14 Oct 2025 12:12:26 +0100
Message-ID: <20251014111234.3190346-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

I still have a number of patches that addressed a lock-up but were
never merged due to objections. However there is a bunch of discussion
around re-factoring the MemoryRegion code so I'm re-posting with an
additional functional test which demonstrates the lock-up is fixed.
Whatever the final solution for more cleanly handling the binding
between MemoryRegions and blobs it will at least need to pass the
test.

Blob memory issues aside I'll send a PR next week to merge the
per-head and ui/gtk-gl-area changes.

Discuss,

Alex.

Alex Bennée (4):
  system/memory: add memory_region_finalize tracepoint
  hw/display: add blob map/unmap trace events
  hw/display: re-arrange memory region tracking
  tests/functional: add GPU blob allocation test

Andrew Keesler (1):
  Support per-head resolutions with virtio-gpu

Dongwon Kim (1):
  ui/gtk-gl-area: Remove extra draw call in refresh

Manos Pitsidianakis (2):
  virtio-gpu: refactor async blob unmapping
  virtio-gpu: fix hang under TCG when unmapping blob

 qapi/virtio.json                          | 10 +++-
 include/system/memory.h                   |  1 +
 hw/display/virtio-gpu-base.c              | 10 ++++
 hw/display/virtio-gpu-virgl.c             | 62 +++++++++++--------
 system/memory.c                           |  5 ++
 ui/gtk-gl-area.c                          |  1 -
 hw/display/trace-events                   |  2 +
 system/trace-events                       |  1 +
 tests/functional/aarch64/meson.build      |  1 +
 tests/functional/aarch64/test_gpu_blob.py | 73 +++++++++++++++++++++++
 10 files changed, 138 insertions(+), 28 deletions(-)
 create mode 100755 tests/functional/aarch64/test_gpu_blob.py

-- 
2.47.3


