Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8126C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 17:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgSMJ-0006Hc-BN; Tue, 20 Aug 2024 13:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgSMF-000602-Ez
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:09:23 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgSMA-0007gk-I7
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:09:23 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-44ff7bdb5a6so33967771cf.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724173755; x=1724778555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neQQWEIsPFABUcyeRkFJVB5t97KxMXB5egl1r8Ec8hk=;
 b=RUGA0laOaiWXIKA1cv/i1OhYhr9Vpo4V/n0PidHuDxqL5Tg9mKlrC0U9lLn5hsiFja
 TF2acq9rYMQnchi/+AlAL/S2NMUSwdZbJVWf4w22v9/4PME+Emdp3feUOZXiSbMqBMId
 M1v43UcDOFIuasGUbVJWEJP1/KD45XvPmHKhGK9ofA4ub3f2l73zu7qb6u21pxJI2PMC
 n36zunu6tdM0vVR/wwB17Xdar06FeJGu37acHhnCfHleFMbUcBKsFrYHmoFR+ca6o/+L
 m15oKQZlSOpbceKZ77zEq1XLs1SZ+R2du8FTGutP15PigjTKIQpO0IXz9p+9dDGJcQ+d
 nVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724173755; x=1724778555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=neQQWEIsPFABUcyeRkFJVB5t97KxMXB5egl1r8Ec8hk=;
 b=QrKlqJndDkdmuDs0k68jEDveT3XlSSsm2UHN+viXokE/r13bydnbaA3Fk+X6hIctsN
 paT189vtpiGZuOztvmQsgSrXhHBYhQjmGPR77I/mmt9NHqmdpq+kLoILx1FuAa1lUHa1
 Q5bLQigtBbpkn2jVdZDqCh0yLFRUg2YPWnC8WpPuyK4inevcfH/AVXbzqGtQ9YoXGYr6
 EJ50bnM8hMjI/v48appCk7DZCOr+OK9vXxbjad3y19W7mtLE7WoLQhz6RU/AMMyFl5YE
 +kAn9Lc7ZkBNhpEcDCBkhQ4Yhza9KOoyvEYD8qpma7S9eSQwUh4TcrLzmzAvfWd84C1J
 Sb1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq/Hnmf4W5cw1scvqdyDpMC8Gqpv16zHmNJOsXn4PZ1iJ3sYVQG+S0/wMxAkQTy7httVNvfC8SBaWq@nongnu.org
X-Gm-Message-State: AOJu0YwT0qanj51s7FE2BY7eOyEikaS+ldqJ89CLJMNAD+jiI2hDAxxM
 oOevKaeVAvzLkwpX5865CXmjb34m4+iKO9HIRnxN4dUqM8k3o31r162N1vS01vQ=
X-Google-Smtp-Source: AGHT+IHuLLwZlh5nYuCf6hK1kuG6uVxTnkexmI2Q6gksCyVYidgZcP89wbGkCq/lbXP0xTECQ7n6MA==
X-Received: by 2002:a05:6214:419d:b0:6b7:8be3:3da0 with SMTP id
 6a1803df08f44-6bf7cda7f30mr158376866d6.19.1724173755269; 
 Tue, 20 Aug 2024 10:09:15 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-52-8-182-0.us-west-1.compute.amazonaws.com. [52.8.182.0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fef2372sm53599576d6.114.2024.08.20.10.09.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Aug 2024 10:09:14 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 "Xiaoning Ding" <xiaoning.ding@bytedance.com>
Subject: [PATCH v8 1/5] docs/migration: add qatzip compression feature
Date: Tue, 20 Aug 2024 10:09:03 -0700
Message-Id: <20240820170907.6788-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240820170907.6788-1-yichen.wang@bytedance.com>
References: <20240820170907.6788-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qt1-x82e.google.com
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

From: Yuan Liu <yuan1.liu@intel.com>

add Intel QATzip compression method introduction

Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 docs/devel/migration/features.rst           |   1 +
 docs/devel/migration/qatzip-compression.rst | 165 ++++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 docs/devel/migration/qatzip-compression.rst

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 58f8fd9e16..8f431d52f9 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -14,3 +14,4 @@ Migration has plenty of features to support different use cases.
    CPR
    qpl-compression
    uadk-compression
+   qatzip-compression
diff --git a/docs/devel/migration/qatzip-compression.rst b/docs/devel/migration/qatzip-compression.rst
new file mode 100644
index 0000000000..862b383164
--- /dev/null
+++ b/docs/devel/migration/qatzip-compression.rst
@@ -0,0 +1,165 @@
+==================
+QATzip Compression
+==================
+In scenarios with limited network bandwidth, the ``QATzip`` solution can help
+users save a lot of host CPU resources by accelerating compression and
+decompression through the Intel QuickAssist Technology(``QAT``) hardware.
+
+
+The following test was conducted using 8 multifd channels and 10Gbps network
+bandwidth. The results show that, compared to zstd, ``QATzip`` significantly
+saves CPU resources on the sender and reduces migration time. Compared to the
+uncompressed solution, ``QATzip`` greatly improves the dirty page processing
+capability, indicated by the Pages per Second metric, and also reduces the
+total migration time.
+
+::
+
+   VM Configuration: 16 vCPU and 64G memory
+   VM Workload: all vCPUs are idle and 54G memory is filled with Silesia data.
+   QAT Devices: 4
+   |-----------|--------|---------|----------|----------|------|------|
+   |8 Channels |Total   |down     |throughput|pages per | send | recv |
+   |           |time(ms)|time(ms) |(mbps)    |second    | cpu %| cpu% |
+   |-----------|--------|---------|----------|----------|------|------|
+   |qatzip     |   16630|       28|     10467|   2940235|   160|   360|
+   |-----------|--------|---------|----------|----------|------|------|
+   |zstd       |   20165|       24|      8579|   2391465|   810|   340|
+   |-----------|--------|---------|----------|----------|------|------|
+   |none       |   46063|       40|     10848|    330240|    45|    85|
+   |-----------|--------|---------|----------|----------|------|------|
+
+
+QATzip Compression Framework
+============================
+
+``QATzip`` is a user space library which builds on top of the Intel QuickAssist
+Technology to provide extended accelerated compression and decompression
+services.
+
+For more ``QATzip`` introduction, please refer to `QATzip Introduction
+<https://github.com/intel/QATzip?tab=readme-ov-file#introductionl>`_
+
+::
+
+  +----------------+
+  | MultiFd Thread |
+  +-------+--------+
+          |
+          | compress/decompress
+  +-------+--------+
+  | QATzip library |
+  +-------+--------+
+          |
+  +-------+--------+
+  |  QAT library   |
+  +-------+--------+
+          |         user space
+  --------+---------------------
+          |         kernel space
+   +------+-------+
+   |  QAT  Driver |
+   +------+-------+
+          |
+   +------+-------+
+   | QAT Devices  |
+   +--------------+
+
+
+QATzip Installation
+-------------------
+
+The ``QATzip`` installation package has been integrated into some Linux
+distributions and can be installed directly. For example, the Ubuntu Server
+24.04 LTS system can be installed using below command
+
+.. code-block:: shell
+
+   #apt search qatzip
+   libqatzip-dev/noble 1.2.0-0ubuntu3 amd64
+     Intel QuickAssist user space library development files
+
+   libqatzip3/noble 1.2.0-0ubuntu3 amd64
+     Intel QuickAssist user space library
+
+   qatzip/noble,now 1.2.0-0ubuntu3 amd64 [installed]
+     Compression user-space tool for Intel QuickAssist Technology
+
+   #sudo apt install libqatzip-dev libqatzip3 qatzip
+
+If your system does not support the ``QATzip`` installation package, you can
+use the source code to build and install, please refer to `QATzip source code installation
+<https://github.com/intel/QATzip?tab=readme-ov-file#build-intel-quickassist-technology-driver>`_
+
+QAT Hardware Deployment
+-----------------------
+
+``QAT`` supports physical functions(PFs) and virtual functions(VFs) for
+deployment, and users can configure ``QAT`` resources for migration according
+to actual needs. For more details about ``QAT`` deployment, please refer to
+`Intel QuickAssist Technology Documentation
+<https://intel.github.io/quickassist/index.html>`_
+
+For more ``QAT`` hardware introduction, please refer to `intel-quick-assist-technology-overview
+<https://www.intel.com/content/www/us/en/architecture-and-technology/intel-quick-assist-technology-overview.html>`_
+
+How To Use QATzip Compression
+=============================
+
+1 - Install ``QATzip`` library
+
+2 - Build ``QEMU`` with ``--enable-qatzip`` parameter
+
+  E.g. configure --target-list=x86_64-softmmu --enable-kvm ``--enable-qatzip``
+
+3 - Set ``migrate_set_parameter multifd-compression qatzip``
+
+4 - Set ``migrate_set_parameter multifd-qatzip-level comp_level``, the default
+comp_level value is 1, and it supports levels from 1 to 9
+
+QAT Memory Requirements
+=======================
+
+The user needs to reserve system memory for the QAT memory management to
+allocate DMA memory. The size of the reserved system memory depends on the
+number of devices used for migration and the number of multifd channels.
+
+Because memory usage depends on QAT configuration, please refer to `QAT Memory
+Driver Queries
+<https://intel.github.io/quickassist/PG/infrastructure_debugability.html?highlight=memory>`_
+for memory usage calculation.
+
+.. list-table:: An example of a PF used for migration
+  :header-rows: 1
+
+  * - Number of channels
+    - Sender memory usage
+    - Receiver memory usage
+  * - 2
+    - 10M
+    - 10M
+  * - 4
+    - 12M
+    - 14M
+  * - 8
+    - 16M
+    - 20M
+
+How To Choose Between QATzip and QPL
+====================================
+Starting from 4th Gen Intel Xeon Scalable processors, codenamed Sapphire Rapids
+processor(``SPR``), multiple built-in accelerators are supported including
+``QAT`` and ``IAA``.  The former can accelerate ``QATzip`` and the latter is
+used to accelerate ``QPL``.
+
+Here are some suggestions:
+
+1 - If the live migration scenario is limited by network bandwidth and ``QAT``
+hardware resources exceed ``IAA``, use the ``QATzip`` method, which can save a
+lot of host CPU resources for compression.
+
+2 - If the system cannot support shared virtual memory (SVM) technology, use
+the ``QATzip`` method because ``QPL`` performance is not good without SVM
+support.
+
+3 - For other scenarios, use the ``QPL`` method first.
-- 
Yichen Wang


