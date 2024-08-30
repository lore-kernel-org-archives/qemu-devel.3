Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3082CA101E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 23:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skB26-00024f-NG; Fri, 30 Aug 2024 19:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1skB22-00022z-Ao
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 19:27:54 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1skB1z-0001qM-0O
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 19:27:54 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e1a819488e3so1089563276.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725060467; x=1725665267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FEle3sKvjI2K6llgvcpOtRll+LlmisuDzD9jveYiTU=;
 b=ho0t6agC6wpLGMjGlQ1WGVVeLn3ndp+fBuypXGqGlbl/DNUdeej7JSxulIbtjzbDqT
 IRXa9wkFXqIK353JCuMJEfO428COjF9AEWE7hBqBStY52ymsc3NmOzPJwpC34Gz1BU/7
 EO7O5oIvKehh/9OxNFKdOb1TlBhEEjIH5TVv0KjIpcRAafBToNWMW3IfbVP92igxnJIZ
 l+2ki5B1aBvzeoiNUrN7DTcxesH/f37EOG869pCoV6JvG/u2EIgwU/tuOriqyI+pTaOA
 BS95IDT+7IgCCZCS6Y1M3ZuNatstqsFlAsn3YBoVrFx50D43jSlamAhHfnZXA9EsUch4
 WNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725060467; x=1725665267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FEle3sKvjI2K6llgvcpOtRll+LlmisuDzD9jveYiTU=;
 b=Ij0ogbNWCdlqY3WFRq2XTs2KS7JtEXXQ4mAJaWTF3BV3Xsf1Jztm1ju2Lx+dKfAM7F
 /QEGAf44lEFs44Blh/WFoLjpu8moUfCxtQBOKemJdYEmirSg8ThaWXjE72Zx0CYlPZaC
 k6XHgej1TE7bFWw4Mjm7731/A8ujXWmIu6EAnhgi5AOFijHkyOxHEqJEHjHiOL7h1iAF
 6R8ehjuPoO0z3FvnqSxGPDgXMNs6eUxSU6QKhyDZgpjPO1vTrn9w8EZ5YjJuM1wp0THt
 jW/h0P7NEFagTCwqM1M87QqezYuUdT1YQ5RmPidGjsvDBL8hJmliySKsy5sr+1c9v7KJ
 1LLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpNpMe5o+KEqH67VY6o7A0uukteeCpMUX8zqLOimJg/w9JA44XWndJECqW+xzg3tIfydFUzXoCfG5R@nongnu.org
X-Gm-Message-State: AOJu0Yz1C7jrxXO3klNmzJjwlxIWhr8+12z9Z+2Sm0kU5eT8QuOA67eU
 G05pxZDKT1rB1V9eeFyYIfv4ocLipzAj6dpgjrU07P8Wvksf71jmxhHHuLl7lcI=
X-Google-Smtp-Source: AGHT+IHuYyOVJ0Q4/JuBHZIGmoNjvWesI0uAcrpl2CQkvz4f/rTXl9YR5w4y2moK8Az2utWBs7tZGQ==
X-Received: by 2002:a05:6902:1886:b0:e16:561f:8b08 with SMTP id
 3f1490d57ef6-e1a79fdffe9mr5253196276.1.1725060466472; 
 Fri, 30 Aug 2024 16:27:46 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340ca689asm19129176d6.109.2024.08.30.16.27.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Aug 2024 16:27:46 -0700 (PDT)
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
Subject: [PATCH v9 1/5] docs/migration: add qatzip compression feature
Date: Fri, 30 Aug 2024 16:27:18 -0700
Message-Id: <20240830232722.58272-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240830232722.58272-1-yichen.wang@bytedance.com>
References: <20240830232722.58272-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yb1-xb32.google.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


