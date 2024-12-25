Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0250EE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 01:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQFks-0001Ze-5C; Tue, 24 Dec 2024 20:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkq-0001Xk-Hv
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 20:00:04 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFko-0000RC-0J
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 20:00:04 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d8f916b40bso76550156d6.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 17:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1735088401; x=1735693201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+SlF2FR3ZV2vuRhtIQV4BC/j1/AENizpBsFIvnrz4w=;
 b=YL8wbzasMcztk4Ok1v5DofQn9ZCawlFDl3eHxONGhmTYn0KPrBNZznY+3HBLNctfnR
 JiEEwCLO7YXvk6Dblgqf+hGsGkaG369HAbgJUs7vfyNeo4ruRByf30CMto90Tost99Oc
 pSPfyjDac3wrwycBN65KsCF4hExLbpIiH1Y/B+mEt9M/dcrArrACcUZ6KZO7pRNFEVO7
 XMLmtCs7MDNq40FMxdYTJrqEdYCwXaWoO8+OZ0s0njbDekX2Hr8IXAl0BzcXHtj8O+Qs
 +fHW81AJyZReCY0VWeesF44L21Eck9el4MldBchNLo0+PAUpCE11ifOWP7drzVZqPPsI
 G6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735088401; x=1735693201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+SlF2FR3ZV2vuRhtIQV4BC/j1/AENizpBsFIvnrz4w=;
 b=eLJpCFwqlIBAmYuv/Hvh34EcwwRsYezyC439WiFNyiVeB/FkuI1O21sMV9sWXk331j
 QJ8xdyGWbcxEBIqIeIzkDpKYLXFntkRPuU0JaDbCDtYBDB30FAJOptj9L4OtUz/2ebrF
 IoONCneTtuZXwaU9VDSLwWZWnoKo2PcMr69egEhW3kqOdSiiHAtIYVYX92inG+gqFWWD
 BSrFgZeQU3BVznqAnlQCoCHfmzhVN6jWEX60OgyjshaM17/n/RBkV/36UwVcFVUZdVZP
 JnL3Nm/GqkkkpYKIMYR7dc6EezkTR8tb4ugzRgF1Emuq1+O2dmjKlzpknt4KFfq+adp2
 ZToQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVV1aS+MBvtggxBtUD+kZMiT2w0K4XG3XqKfR4FrTMhVL67zt0eJhdJLYjeQ90fQSnsQiRCwRpd7T+@nongnu.org
X-Gm-Message-State: AOJu0YwWF232721pDtqS6mzGu1vhbYObth85xOSsgYQg+QY3TIpJBvdd
 o2e7piFIla/kG7WW95oVr4ndrRYcxbPLQxVCkiOpzRCYSoUwc6TfpTPyAqvlFWc=
X-Gm-Gg: ASbGncv6XlE/CuVK26F0TZt+mgZBmYJgnghCSrg6hFccvuQ5yrjIasTBRFm918CfDKu
 kdnlQ1NGjwqPOGUTnGR1Ifem7shbDIyBf0Ucuf470p+dXREexzMrO+GQ0DjOSj5Ttxf3KuPV4lp
 FRynii/QohQlFuzIPJ39fdi1IqKe+qg8XfLnf/in411mze+MoHvref8JSIJDFn2pIj2Ql+jRhhb
 vLC6Pt8cDuEPa6ChMxmhuC+QVv2rOV1LCD1kqTRajgD9P8Nr4q7t8QV0I1vDqOQRBUFnfhkcgyZ
 bW/nkoKRjRdL5YfEXWAPksPH1A==
X-Google-Smtp-Source: AGHT+IHXmKHTkm1CK8v0eniqh3zqyfFhqSni4zJfaN2Yc1TwYN4csdn1h8vmUCAh1SenG2G0NNzjdw==
X-Received: by 2002:a05:6214:d42:b0:6d4:139c:cef0 with SMTP id
 6a1803df08f44-6dd233545f9mr226205856d6.22.1735088400797; 
 Tue, 24 Dec 2024 17:00:00 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:1799:4ca4:2dd7:ba38:ecbd])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d244fsm57318206d6.98.2024.12.24.16.59.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Dec 2024 17:00:00 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v9 12/12] migration/doc: Add DSA zero page detection doc
Date: Tue, 24 Dec 2024 16:59:19 -0800
Message-Id: <20241225005919.26853-13-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241225005919.26853-1-yichen.wang@bytedance.com>
References: <20241225005919.26853-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf30.google.com
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

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 .../migration/dsa-zero-page-detection.rst     | 290 ++++++++++++++++++
 docs/devel/migration/features.rst             |   1 +
 2 files changed, 291 insertions(+)
 create mode 100644 docs/devel/migration/dsa-zero-page-detection.rst

diff --git a/docs/devel/migration/dsa-zero-page-detection.rst b/docs/devel/migration/dsa-zero-page-detection.rst
new file mode 100644
index 0000000000..1279fcdd99
--- /dev/null
+++ b/docs/devel/migration/dsa-zero-page-detection.rst
@@ -0,0 +1,290 @@
+=============================
+DSA-Based Zero Page Detection
+=============================
+Intel Data Streaming Accelerator(``DSA``) is introduced in Intel's 4th
+generation Xeon server, aka Sapphire Rapids(``SPR``). One of the things
+DSA can do is to offload memory comparison workload from CPU to DSA accelerator
+hardware.
+
+The main advantages of using DSA to accelerate zero pages detection include
+
+1. Reduces CPU usage in multifd live migration workflow across all use cases.
+
+2. Reduces migration total time in some use cases.
+
+
+DSA-Based Zero Page Detection Introduction
+==========================================
+
+::
+
+
+  +----------------+       +------------------+
+  | MultiFD Thread |       |accel-config tool |
+  +-+--------+-----+       +--------+---------+
+    |        |                      |
+    |        |  Open DSA            | Setup DSA
+    |        |  Work Queues         | Resources
+    |        |       +-----+-----+  |
+    |        +------>|idxd driver|<-+
+    |                +-----+-----+
+    |                      |
+    |                      |
+    |                +-----+-----+
+    +----------------+DSA Devices|
+      Submit jobs    +-----------+
+      via enqcmd
+
+
+DSA Introduction
+----------------
+Intel Data Streaming Accelerator (DSA) is a high-performance data copy and
+transformation accelerator that is integrated in Intel Xeon processors,
+targeted for optimizing streaming data movement and transformation operations
+common with applications for high-performance storage, networking, persistent
+memory, and various data processing applications.
+
+For more ``DSA`` introduction, please refer to `DSA Introduction
+<https://www.intel.com/content/www/us/en/products/docs/accelerator-engines/data-streaming-accelerator.html>`_
+
+For ``DSA`` specification, please refer to `DSA Specification
+<https://cdrdv2-public.intel.com/671116/341204-intel-data-streaming-accelerator-spec.pdf>`_
+
+For ``DSA`` user guide, please refer to `DSA User Guide
+<https://www.intel.com/content/www/us/en/content-details/759709/intel-data-streaming-accelerator-user-guide.html>`_
+
+DSA Device Management
+---------------------
+
+The number of ``DSA`` devices will vary depending on the Xeon product model.
+On a ``SPR`` server, there can be a maximum of 8 ``DSA`` devices, with up to
+4 devices per socket.
+
+By default, all ``DSA`` devices are disabled and need to be configured and
+enabled by users manually.
+
+Check the number of devices through the following command
+
+.. code-block:: shell
+
+  #lspci -d 8086:0b25
+  6a:01.0 System peripheral: Intel Corporation Device 0b25
+  6f:01.0 System peripheral: Intel Corporation Device 0b25
+  74:01.0 System peripheral: Intel Corporation Device 0b25
+  79:01.0 System peripheral: Intel Corporation Device 0b25
+  e7:01.0 System peripheral: Intel Corporation Device 0b25
+  ec:01.0 System peripheral: Intel Corporation Device 0b25
+  f1:01.0 System peripheral: Intel Corporation Device 0b25
+  f6:01.0 System peripheral: Intel Corporation Device 0b25
+
+
+DSA Device Configuration And Enabling
+-------------------------------------
+
+The ``accel-config`` tool is used to enable ``DSA`` devices and configure
+``DSA`` hardware resources(work queues and engines). One ``DSA`` device
+has 8 work queues and 4 processing engines, multiple engines can be assigned
+to a work queue via ``group`` attribute.
+
+For ``accel-config`` installation, please refer to `accel-config installation
+<https://github.com/intel/idxd-config>`_
+
+One example of configuring and enabling an ``DSA`` device.
+
+.. code-block:: shell
+
+  #accel-config config-engine dsa0/engine0.0 -g 0
+  #accel-config config-engine dsa0/engine0.1 -g 0
+  #accel-config config-engine dsa0/engine0.2 -g 0
+  #accel-config config-engine dsa0/engine0.3 -g 0
+  #accel-config config-wq dsa0/wq0.0 -g 0 -s 128 -p 10 -b 1 -t 128 -m shared -y user -n app1 -d user
+  #accel-config enable-device dsa0
+  #accel-config enable-wq dsa0/wq0.0
+
+- The ``DSA`` device index is 0, use ``ls -lh /sys/bus/dsa/devices/dsa*``
+  command to query the ``DSA`` device index.
+
+- 4 engines and 1 work queue are configured in group 0, so that all zero-page
+  detection jobs submitted to this work queue can be processed by all engines
+  simultaneously.
+
+- Set work queue attributes including the work mode, work queue size and so on.
+
+- Enable the ``dsa0`` device and work queue ``dsa0/wq0.0``
+
+.. note::
+
+   1. ``DSA`` device driver is Intel Data Accelerator Driver (idxd), it is
+      recommended that the minimum version of Linux kernel is 5.18.
+
+   2. Only ``DSA`` shared work queue mode is supported, it needs to add
+      ``"intel_iommu=on,sm_on"`` parameter to kernel command line.
+
+For more detailed configuration, please refer to `DSA Configuration Samples
+<https://github.com/intel/idxd-config/tree/stable/Documentation/accfg>`_
+
+
+Performances
+============
+We use two Intel 4th generation Xeon servers for testing.
+
+::
+
+    Architecture:        x86_64
+    CPU(s):              192
+    Thread(s) per core:  2
+    Core(s) per socket:  48
+    Socket(s):           2
+    NUMA node(s):        2
+    Vendor ID:           GenuineIntel
+    CPU family:          6
+    Model:               143
+    Model name:          Intel(R) Xeon(R) Platinum 8457C
+    Stepping:            8
+    CPU MHz:             2538.624
+    CPU max MHz:         3800.0000
+    CPU min MHz:         800.0000
+
+We perform multifd live migration with below setup:
+
+1. VM has 100GB memory.
+
+2. Use the new migration option multifd-set-normal-page-ratio to control the
+   total size of the payload sent over the network.
+
+3. Use 8 multifd channels.
+
+4. Use tcp for live migration.
+
+5. Use CPU to perform zero page checking as the baseline.
+
+6. Use one DSA device to offload zero page checking to compare with the baseline.
+
+7. Use "perf sched record" and "perf sched timehist" to analyze CPU usage.
+
+
+A) Scenario 1: 50% (50GB) normal pages on an 100GB vm
+-----------------------------------------------------
+
+::
+
+	CPU usage
+
+	|---------------|---------------|---------------|---------------|
+	|		|comm		|runtime(msec)	|totaltime(msec)|
+	|---------------|---------------|---------------|---------------|
+	|Baseline	|live_migration	|5657.58	|		|
+	|		|multifdsend_0	|3931.563	|		|
+	|		|multifdsend_1	|4405.273	|		|
+	|		|multifdsend_2	|3941.968	|		|
+	|		|multifdsend_3	|5032.975	|		|
+	|		|multifdsend_4	|4533.865	|		|
+	|		|multifdsend_5	|4530.461	|		|
+	|		|multifdsend_6	|5171.916	|		|
+	|		|multifdsend_7	|4722.769	|41922		|
+	|---------------|---------------|---------------|---------------|
+	|DSA		|live_migration	|6129.168	|		|
+	|		|multifdsend_0	|2954.717	|		|
+	|		|multifdsend_1	|2766.359	|		|
+	|		|multifdsend_2	|2853.519	|		|
+	|		|multifdsend_3	|2740.717	|		|
+	|		|multifdsend_4	|2824.169	|		|
+	|		|multifdsend_5	|2966.908	|		|
+	|		|multifdsend_6	|2611.137	|		|
+	|		|multifdsend_7	|3114.732	|		|
+	|		|dsa_completion	|3612.564	|32568		|
+	|---------------|---------------|---------------|---------------|
+
+Baseline total runtime is calculated by adding up all multifdsend_X
+and live_migration threads runtime. DSA offloading total runtime is
+calculated by adding up all multifdsend_X, live_migration and
+dsa_completion threads runtime. 41922 msec VS 32568 msec runtime and
+that is 23% total CPU usage savings.
+
+::
+
+	Latency
+	|---------------|---------------|---------------|---------------|---------------|---------------|
+	|		|total time	|down time	|throughput	|transferred-ram|total-ram	|
+	|---------------|---------------|---------------|---------------|---------------|---------------|
+	|Baseline	|10343 ms	|161 ms		|41007.00 mbps	|51583797 kb	|102400520 kb	|
+	|---------------|---------------|---------------|---------------|-------------------------------|
+	|DSA offload	|9535 ms	|135 ms		|46554.40 mbps	|53947545 kb	|102400520 kb	|
+	|---------------|---------------|---------------|---------------|---------------|---------------|
+
+Total time is 8% faster and down time is 16% faster.
+
+
+B) Scenario 2: 100% (100GB) zero pages on an 100GB vm
+-----------------------------------------------------
+
+::
+
+	CPU usage
+	|---------------|---------------|---------------|---------------|
+	|		|comm		|runtime(msec)	|totaltime(msec)|
+	|---------------|---------------|---------------|---------------|
+	|Baseline	|live_migration	|4860.718	|		|
+	|	 	|multifdsend_0	|748.875	|		|
+	|		|multifdsend_1	|898.498	|		|
+	|		|multifdsend_2	|787.456	|		|
+	|		|multifdsend_3	|764.537	|		|
+	|		|multifdsend_4	|785.687	|		|
+	|		|multifdsend_5	|756.941	|		|
+	|		|multifdsend_6	|774.084	|		|
+	|		|multifdsend_7	|782.900	|11154		|
+	|---------------|---------------|-------------------------------|
+	|DSA offloading	|live_migration	|3846.976	|		|
+	|		|multifdsend_0	|191.880	|		|
+	|		|multifdsend_1	|166.331	|		|
+	|		|multifdsend_2	|168.528	|		|
+	|		|multifdsend_3	|197.831	|		|
+	|		|multifdsend_4	|169.580	|		|
+	|		|multifdsend_5	|167.984	|		|
+	|		|multifdsend_6	|198.042	|		|
+	|		|multifdsend_7	|170.624	|		|
+	|		|dsa_completion	|3428.669	|8700		|
+	|---------------|---------------|---------------|---------------|
+
+Baseline total runtime is 11154 msec and DSA offloading total runtime is
+8700 msec. That is 22% CPU savings.
+
+::
+
+	Latency
+	|--------------------------------------------------------------------------------------------|
+	|		|total time	|down time	|throughput	|transferred-ram|total-ram   |
+	|---------------|---------------|---------------|---------------|---------------|------------|
+	|Baseline	|4867 ms	|20 ms		|1.51 mbps	|565 kb		|102400520 kb|
+	|---------------|---------------|---------------|---------------|----------------------------|
+	|DSA offload	|3888 ms	|18 ms		|1.89 mbps	|565 kb		|102400520 kb|
+	|---------------|---------------|---------------|---------------|---------------|------------|
+
+Total time 20% faster and down time 10% faster.
+
+
+How To Use DSA In Migration
+===========================
+
+The migration parameter ``accel-path`` is used to specify the resource
+allocation for DSA. After the user configures
+``zero-page-detection=dsa-accel``, one or more DSA work queues need to be
+specified for migration.
+
+The following example shows two DSA work queues for zero page detection
+
+.. code-block:: shell
+
+   migrate_set_parameter zero-page-detection=dsa-accel
+   migrate_set_parameter accel-path=dsa:/dev/dsa/wq0.0 dsa:/dev/dsa/wq1.0
+
+.. note::
+
+  Accessing DSA resources requires ``sudo`` command or ``root`` privileges
+  by default. Administrators can modify the DSA device node ownership
+  so that QEMU can use DSA with specified user permissions.
+
+  For example:
+
+  #chown -R qemu /dev/dsa
+
diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 8f431d52f9..ea2893d80f 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -15,3 +15,4 @@ Migration has plenty of features to support different use cases.
    qpl-compression
    uadk-compression
    qatzip-compression
+   dsa-zero-page-detection
-- 
Yichen Wang


