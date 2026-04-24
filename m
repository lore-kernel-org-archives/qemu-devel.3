Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C23AFDEE28
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG43Q-0006bM-90; Thu, 23 Apr 2026 20:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG43O-0006aU-6V
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 20:05:54 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG43M-0000xu-La
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 20:05:53 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2eadb000b8cso861809eec.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 17:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776989151; x=1777593951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oCzWXRgOCadYTORyOC3+pSx/THt4GuRTdvIpDdRgxN0=;
 b=dEnidserK1gQSFBAGWSQjWHnJH+KjSmKGd9PEIBTunudpiDOYhwPzbkfIdMCfFy5bf
 gEL1b7VSl5YkTyaETXBWqJz2lk4qgo3+F8ogUfawsRqTPxM/h3G8kRbUk0YjoOqqKdNl
 oMsysZDiH0dfpcNkOFZwIY4Podo/tJehhdXhH9a2soMHSoS1ixNCarOyrBOOpEJI83No
 KqTDRalHKvOozv4CclCgexSNvvLGS/qep9KnDjvHQTiztd4JMLiAquj5+qey/eiySi4Z
 ymWw7VGLIh551U0cUbJs3vWyyQEt1DIqUbh9At2BDxgc2Gg/GztK1HkTeAXqOIjZcvrR
 NOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776989151; x=1777593951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCzWXRgOCadYTORyOC3+pSx/THt4GuRTdvIpDdRgxN0=;
 b=fTDHW8eXNO9GFP+d55Z9CfCjVpzM8UBm+B3s+BM5ZAo002Ahid7D0XFxMxiy2MW9B9
 dSWWuH07Gbq0B+I7DEA9ip634Llldv++/LoYbTl8YVCFy+orbn6ekINxtrzyhZTlx1lJ
 vvIvVjUj3gNzvc2hSh6GjsEiqU0EY1B2q0INDagijwifCu1oI78MWF1H7u85gfuM3Ay6
 bZJ6nGjWwP9CHOnfgN9y5dHXTJZiWHWHQcQPA5TkgRiTw8MZnvVSYMJhWRzNQ9ek4QUR
 aDEabeGE7VDR5Z1rrKnrRrfbmtfzPScAp6YGPz0jUqHN+eaDNNhgg1netIXRvjrlRYyL
 hVaw==
X-Gm-Message-State: AOJu0YyVjseKI/m3kcQRZwqrBt9ibMNdKTBhTPC+q2Qcg0g+4g7BFu6I
 lZ4yjHCuGq8+LD+uA7+4fyzIrIfknuqrVq67gQuk97aehCgQ+Dd1oU5spSatW9jYXtQ=
X-Gm-Gg: AeBDieuTWFW+BNiG4Y1Z2oYsLlsUAYvsFyBHfYL2ter8K0dnURrGwDzeh3ZxdDBY8/e
 LRERgNp7MbskYzyitsFZ3sqf7Yisvbnr3sStMDMGmfHyPsQeKK8kOSkU/AE3mdl7DNklGJPgpYH
 Cf8ZZ5DXXrZvSRdD3UHVFqFS4odYEWG2xuklYsjRNL+k2b8MfAGmjjHu6FtWmf/xaUVa/DrfvT+
 NIaD9m8SJVZeTY23LI5vBSVFqI/0+p4btXgNCCwpuWQUBU/plo/h3cNyQIdl4Y7kzUN1+ETunHe
 rx1VZqmI7jrefrvB+JTCiP2gFn52j6xAeegLL5hy7a6LWqq+VWBFxLsqxyETvY0WM26qOV7fsLB
 gsASu8TMFfswMKpIYc6pOMl97dZHkLK3h9XNNEi1OJh7eN7ICTq8wE4sFYC9ND5vCepN/uaFIV6
 t6AVhiHUSUnCMXZ7y4paXdpvKy60VuVpwq5k17kKNVzmMKji7X1ErJJDFDD8411XEpK7d+8ASe
X-Received: by 2002:a05:7300:8622:b0:2c9:1943:e7ff with SMTP id
 5a478bee46e88-2e465773791mr16890359eec.10.1776989150657; 
 Thu, 23 Apr 2026 17:05:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:44a8:c4b9:45be:963d:f3a])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ea8e4b373dsm12958055eec.6.2026.04.23.17.05.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 17:05:50 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 0/3] hvf: map granule abstraction, configurable IPA,
 and MAP_FIXED alignment fix
Date: Thu, 23 Apr 2026 21:05:41 -0300
Message-ID: <20260424000544.9617-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fix a bug in the MAP_FIXED blob mapping path (introduced by 4eb0aace)
where non-host-page-aligned offsets cause mmap(MAP_FIXED) to fail with
EINVAL.  This affects any host where the page size exceeds the guest's
(ARM64 with 16KB/64KB pages, macOS ARM64).

This series introduces:

1. MAP_FIXED alignment validation in virtio-gpu: check that both
   offset and blob size are aligned to the host page size before
   calling virgl_renderer_resource_map_fixed().  When not aligned,
   fall through to the subregion method (which works at any
   alignment).

2. A map granule abstraction (hvf_set/get_map_granule) replacing
   hardcoded qemu_real_host_page_size() calls in HVF memory mapping.
   Non-aligned regions return early instead of proceeding with
   add=false (which attempted an unnecessary unmap).
   An 'ipa-granule' property (auto, 4k, 16k) on the HVF accelerator
   object allows opt-in configuration:

     -accel hvf,ipa-granule=4k

   The property follows the kvm_arch_accel_class_init() pattern:
   ARM registers the property in hvf_arch_accel_class_init(), x86
   provides an empty stub.

3. macOS 26 IPA granule support via hv_vm_config_set_ipa_granule(),
   reading the ipa-granule property to select HV_IPA_GRANULE_4KB or
   HV_IPA_GRANULE_16KB.  Falls back with a warning on macOS < 26.

Dependencies: none.

Changes v4 -> v5:
  - Use g_strcmp0() instead of strcmp() (Alex Bennée)

Changes v3 -> v4:
  - Rebased onto current master (no code changes)
  - Fix Signed-off-by email in patches 2/3 and 3/3
  - Resent as new top-level thread per Alex Bennée's feedback

Changes v2 -> v3:
  - Rebased on current master
  - Add MAP_FIXED alignment validation (new patch 1)
  - Move #ifdef __aarch64__ property code into hvf_arch_accel_class_init
    following kvm_arch_accel_class_init() pattern (x86 empty stub)
  - Use MAC_OS_VERSION_26_0 named constant
  - Remove Venus blob mapping warning

Changes v1 -> v2 (Mohamed Mosaad review):
  - Replace hardcoded 4KB with configurable ipa-granule property
    (auto, 4k, 16k) on the HVF accelerator object.
  - 'auto' defaults to host page size; explicit values opt in.
  - Add fallback warning when macOS < 26 can't honor the request.
  - Add Venus blob mapping safety warning.
  - Use KiB constants instead of magic numbers.

Lucas Amaral (3):
  virtio-gpu: validate host page alignment for MAP_FIXED blobs
  accel/hvf: introduce map granule abstraction and IPA property
  target/arm/hvf: configure IPA granule on macOS 26

 accel/hvf/hvf-all.c           | 30 +++++++++++++--
 hw/display/virtio-gpu-virgl.c | 45 +++++++++++++---------
 include/system/hvf.h          | 15 ++++++++
 include/system/hvf_int.h      |  2 +
 target/arm/hvf/hvf.c          | 72 +++++++++++++++++++++++++++++++++++
 target/i386/hvf/hvf.c         |  4 ++
 6 files changed, 147 insertions(+), 21 deletions(-)

-- 
2.52.0


