Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2B4C3DA42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 02:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRjvM-0003oN-K8; Wed, 10 Jul 2024 22:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sRjvK-0003nG-M9
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 22:52:46 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sRjvG-0007rb-1t
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 22:52:46 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3d92df7e83cso654396b6e.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 19:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720666357; x=1721271157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MGC2Kn8K5/OSwfmUdmDEoAYSPqg+YzbcoDs108eAWs=;
 b=ExNa3LvoXrRwkFf1i9ZhIjwqfJVAwuewo7Cxh5lExirmog5OrJZYDOaOyyZBJjrySN
 NavgsLyZaj9v22ldIPd+mwgJ7zkzf//fsTiRj5PNXyFS44hxIihPPoQkmf14TG47hoj1
 NQGY0FGlP5591Ye99r2A9p/C4H1mhUjOefBHeByttVf5ZfQ6wdGCNxcqajK6L2HkXCxS
 GuATY/FWOWOO5DbwPesYCl4qYg7MJoHR68pwBGM26omsVMx6TbKLLbRAOpEsiSHO9JjW
 MiZuBDihkALYGF6sCjvz2J37DkD9a35dsPdzC/uLa0O+fE+24Bjj4F11kn5xPFNmX/4F
 Nlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720666357; x=1721271157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MGC2Kn8K5/OSwfmUdmDEoAYSPqg+YzbcoDs108eAWs=;
 b=MG73gam18hmEAmi3yFv8UlkOMh6gqAeooaHiAm2QiogRooAwA4EkfjGa+hI5I2MUpY
 26rUxl3z3Opr303bYvl+KX0mba+2J4rUUTE7pPh9c7N6Ac2Qoal5lE2AMuyeCZ2POz+4
 M//ewoQ35LfKua5qdCjKkRnMHGNm/GptZOzfs9s2Q5+I3lhjK49BxObpyp3DDIciXFLS
 np3ZFsXJJM44PoI3UyREGJMQzapzoj7I+3vfkaO7iyOdnrOFmFSbcNHc6NK5uVL0o7Q3
 R0j3eUAfCaZGqL3mU3Yt6P90kY0aUQr5FCTG0B/fC7NITCUIhnDFHHEB48oI2qwmlT7y
 De6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgHwFTCInOvSomfLF0657TJR1+eEXNFhrzNECN3CUj/LswbaO25SrgFnbjuR6I0UzDo0Gy95Y0b2lTMnKuh9qJlmoJAfM=
X-Gm-Message-State: AOJu0Yy6Z2QsMGlvHXQvTsTm4m9d9+3bvyRmnhDGKri5cRetFr0IHFxl
 0+MqoPz2yxQ3T+qbGiE5ZlJ2esLo0MPGGEhp58Ng5DefGFy2+FwrQ55jFRpysyU=
X-Google-Smtp-Source: AGHT+IF9q22DwXwIFfWUbgTPTCF6f2lNNsdBLCMDlh1lySiidxT1nNHUoL+C70/oStzmTmnnl9azRw==
X-Received: by 2002:a05:6808:180c:b0:3d9:25ec:d9ff with SMTP id
 5614622812f47-3da9feef910mr544537b6e.20.1720666357231; 
 Wed, 10 Jul 2024 19:52:37 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3daa12f4f7csm117827b6e.41.2024.07.10.19.52.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jul 2024 19:52:36 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v5 1/5] docs/migration: add qatzip compression feature
Date: Wed, 10 Jul 2024 19:52:25 -0700
Message-Id: <20240711025229.66260-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711025229.66260-1-yichen.wang@bytedance.com>
References: <20240711025229.66260-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oi1-x22f.google.com
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

From: Yuan Liu <yuan1.liu@intel.com>

add Intel QATzip compression method introduction

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Yichen Wang <yichen.wang@bytedance.com>
---
 docs/devel/migration/features.rst           |   1 +
 docs/devel/migration/qatzip-compression.rst | 251 ++++++++++++++++++++
 2 files changed, 252 insertions(+)
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
index 0000000000..72fa3e2826
--- /dev/null
+++ b/docs/devel/migration/qatzip-compression.rst
@@ -0,0 +1,251 @@
+==================
+QATzip Compression
+==================
+In scenarios with limited network bandwidth, the ``QATzip`` solution can help
+users save a lot of host CPU resources by accelerating compression and
+decompression through the Intel QuickAssist Technology(``QAT``) hardware.
+
+``QATzip`` is a user space library which builds on top of the Intel QuickAssist
+Technology user space library, to provide extended accelerated compression and
+decompression services.
+
+For more ``QATzip`` introduction, please refer to `QATzip Introduction
+<https://github.com/intel/QATzip?tab=readme-ov-file#introductionl>`_
+
+QATzip Compression Framework
+============================
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
+
+Performance Testing with QATzip
+===============================
+
+Testing environment is being set as below:
+
+VM configuration:16 vCPU, 64G memory;
+
+VM Workload: all vCPUs are idle and 54G memory is filled with Silesia data;
+
+QAT Devices: 4;
+
+Sender migration parameters:
+
+.. code-block:: shell
+
+    migrate_set_capability multifd on
+    migrate_set_parameter multifd-channels 2/4/8
+    migrate_set_parameter max-bandwidth 1G/10G
+    migrate_set_parameter multifd-compression qatzip/zstd
+
+Receiver migration parameters:
+
+.. code-block:: shell
+
+    migrate_set_capability multifd on
+    migrate_set_parameter multifd-channels 2
+    migrate_set_parameter multifd-compression qatzip/zstd
+
+max-bandwidth: 1 GBps (Gbytes/sec)
+
+.. code-block:: text
+
+    |-----------|--------|---------|----------|------|------|
+    |2 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   21607|       77|      8051|    88|   125|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   78351|       96|      2199|   204|    80|
+    |-----------|--------|---------|----------|------|------|
+
+    |-----------|--------|---------|----------|------|------|
+    |4 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   20336|       25|      8557|   110|   190|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   39324|       31|      4389|   406|   160|
+    |-----------|--------|---------|----------|------|------|
+
+    |-----------|--------|---------|----------|------|------|
+    |8 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   20208|       22|      8613|   125|   300|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   20515|       22|      8438|   800|   340|
+    |-----------|--------|---------|----------|------|------|
+
+max-bandwidth: 10 GBps (Gbytes/sec)
+
+.. code-block:: text
+
+    |-----------|--------|---------|----------|------|------|
+    |2 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   22450|       77|      7748|    80|   125|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   78339|       76|      2199|   204|    80|
+    |-----------|--------|---------|----------|------|------|
+
+    |-----------|--------|---------|----------|------|------|
+    |4 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   13017|       24|     13401|   180|   285|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   39466|       21|      4373|   406|   160|
+    |-----------|--------|---------|----------|------|------|
+
+    |-----------|--------|---------|----------|------|------|
+    |8 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   10255|       22|     17037|   280|   590|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   20126|       77|      8595|   810|   340|
+    |-----------|--------|---------|----------|------|------|
+
+max-bandwidth: 1.25 GBps (Gbytes/sec)
+
+.. code-block:: text
+
+    |-----------|--------|---------|----------|----------|------|------|
+    |8 Channels |Total   |down     |throughput|pages per | send | recv |
+    |           |time(ms)|time(ms) |(mbps)    |second    | cpu %| cpu% |
+    |-----------|--------|---------|----------|----------|------|------|
+    |qatzip     |   16630|       28|     10467|   2940235|   160|   360|
+    |-----------|--------|---------|----------|----------|------|------|
+    |zstd       |   20165|       24|      8579|   2391465|   810|   340|
+    |-----------|--------|---------|----------|----------|------|------|
+    |none       |   46063|       40|     10848|    330240|    45|    85|
+    |-----------|--------|---------|----------|----------|------|------|
+
+If the user has enabled compression in live migration, using QAT can save the
+host CPU resources.
+
+When compression is enabled, the bottleneck of migration is usually the
+compression throughput on the sender side, since CPU decompression throughput
+is higher than compression, some reference data
+https://github.com/inikep/lzbench, so more CPU resources need to be allocated
+to the sender side.
+
+Summary:
+
+1. In the 1GBps case, QAT only uses 88% CPU utilization to reach 1GBps, but
+   ZSTD needs 800%.
+
+2. In the 10Gbps case, QAT uses 180% CPU utilization to reach 10GBps. but ZSTD
+   still cannot reach 10Gbps even if it uses 810%.
+
+3. The QAT decompression CPU utilization is higher than compression and ZSTD,
+   because:
+
+   a. When using QAT compression, the data needs to be copied to the QAT memory
+   (for DMA operations), and the same for decompression. However,
+   do_user_addr_fault will be triggered during decompression because the QAT
+   decompressed data is copied to the VM address space for the first time, in
+   addition, both compression and decompression are processed by QAT and do not
+   consume CPU resources, so the CPU utilization of the receiver is slightly
+   higher than the sender.
+
+   b. Since zstd decompression decompresses data directly into the VM address
+   space, there is one less memory copy than QAT, so the CPU utilization on the
+   receiver is better than QAT. For the 1GBps case, the receiver CPU
+   utilization is 125%, and the memory copy occupies ~80% of CPU utilization.
+
+How To Choose Between QATzip and QPL
+====================================
+Starting from Intel 4th Gen Intel Xeon Scalable processors, codenamed Sapphire
+Rapids processor(``SPR``), it supports multiple build-in accelerators including
+``QAT`` and ``IAA``, the former can accelerate ``QATzip``, and the latter is
+used to accelerate ``QPL``.
+
+Here are some suggestions:
+
+1 - If your live migration scenario is limited network bandwidth and ``QAT``
+hardware resources exceed ``IAA``, then use the ``QATzip`` method, which
+can save a lot of host CPU resources for compression.
+
+2 - If your system cannot support shared virtual memory(SVM) technology, please
+use ``QATzip`` method because ``QPL`` performance is not good without SVM
+support.
+
+3 - For other scenarios, please use the ``QPL`` method first.
-- 
Yichen Wang


