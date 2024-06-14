Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B407C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZS-000190-Oa; Fri, 14 Jun 2024 13:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZO-00017j-PL
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:34 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZM-00045V-Mk
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:34 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A675B20727;
 Fri, 14 Jun 2024 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLzeyc/X1R/2F7Z/mZ8QhCI6C6667LCgP8daYEWJFF0=;
 b=g3swic/cAHL5NjpEOnM43jmiTQ7Xuw8TLbLC6kSFnpO3xjYWj8f9EOBP8MOfVd4xLbKufD
 4JdYvLimCa9IgtWda5kSZaoF7KKGNO6iDRX6n1jPsLkyFI160zL4VKosefESMFY0IhsvNV
 c6LEh4VqdCDJpEQz3ZUjcbIZlsMsjQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLzeyc/X1R/2F7Z/mZ8QhCI6C6667LCgP8daYEWJFF0=;
 b=OefEhbZLftHbtwZXl5HkGGsZYbwmjtudbTHkXOJvt8XYdyeNHmdhdMK92hd9ks3EF4oArc
 S865mYmIbYmvvZAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLzeyc/X1R/2F7Z/mZ8QhCI6C6667LCgP8daYEWJFF0=;
 b=g3swic/cAHL5NjpEOnM43jmiTQ7Xuw8TLbLC6kSFnpO3xjYWj8f9EOBP8MOfVd4xLbKufD
 4JdYvLimCa9IgtWda5kSZaoF7KKGNO6iDRX6n1jPsLkyFI160zL4VKosefESMFY0IhsvNV
 c6LEh4VqdCDJpEQz3ZUjcbIZlsMsjQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLzeyc/X1R/2F7Z/mZ8QhCI6C6667LCgP8daYEWJFF0=;
 b=OefEhbZLftHbtwZXl5HkGGsZYbwmjtudbTHkXOJvt8XYdyeNHmdhdMK92hd9ks3EF4oArc
 S865mYmIbYmvvZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0515713AB1;
 Fri, 14 Jun 2024 17:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gGdrL2R7bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PULL 12/18] docs/migration: add uadk compression feature
Date: Fri, 14 Jun 2024 14:17:56 -0300
Message-Id: <20240614171802.28451-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linaro.org:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Document UADK(User Space Accelerator Development Kit) library details
and how to use that for migration.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
[s/Qemu/QEMU in docs]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/features.rst         |   1 +
 docs/devel/migration/uadk-compression.rst | 144 ++++++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 docs/devel/migration/uadk-compression.rst

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index bc98b65075..58f8fd9e16 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -13,3 +13,4 @@ Migration has plenty of features to support different use cases.
    mapped-ram
    CPR
    qpl-compression
+   uadk-compression
diff --git a/docs/devel/migration/uadk-compression.rst b/docs/devel/migration/uadk-compression.rst
new file mode 100644
index 0000000000..3f73345dd5
--- /dev/null
+++ b/docs/devel/migration/uadk-compression.rst
@@ -0,0 +1,144 @@
+=========================================================
+User Space Accelerator Development Kit (UADK) Compression
+=========================================================
+UADK is a general-purpose user space accelerator framework that uses shared
+virtual addressing (SVA) to provide a unified programming interface for
+hardware acceleration of cryptographic and compression algorithms.
+
+UADK includes Unified/User-space-access-intended Accelerator Framework (UACCE),
+which enables hardware accelerators from different vendors that support SVA to
+adapt to UADK.
+
+Currently, HiSilicon Kunpeng hardware accelerators have been registered with
+UACCE. Through the UADK framework, users can run cryptographic and compression
+algorithms using hardware accelerators instead of CPUs, freeing up CPU
+computing power and improving computing performance.
+
+https://github.com/Linaro/uadk/tree/master/docs
+
+UADK Framework
+==============
+UADK consists of UACCE, vendors' drivers, and an algorithm layer. UADK requires
+the hardware accelerator to support SVA, and the operating system to support
+IOMMU and SVA. Hardware accelerators from different vendors are registered as
+different character devices with UACCE by using kernel-mode drivers of the
+vendors. A user can access the hardware accelerators by performing user-mode
+operations on the character devices.
+
+::
+
+          +----------------------------------+
+          |                apps              |
+          +----+------------------------+----+
+               |                        |
+               |                        |
+       +-------+--------+       +-------+-------+
+       |   scheduler    |       | alg libraries |
+       +-------+--------+       +-------+-------+
+               |                         |
+               |                         |
+               |                         |
+               |                +--------+------+
+               |                | vendor drivers|
+               |                +-+-------------+
+               |                  |
+               |                  |
+            +--+------------------+--+
+            |         libwd          |
+    User    +----+-------------+-----+
+    --------------------------------------------------
+    Kernel    +--+-----+   +------+
+              | uacce  |   | smmu |
+              +---+----+   +------+
+                  |
+              +---+------------------+
+              | vendor kernel driver |
+              +----------------------+
+    --------------------------------------------------
+             +----------------------+
+             |   HW Accelerators    |
+             +----------------------+
+
+UADK Installation
+-----------------
+Build UADK
+^^^^^^^^^^
+
+.. code-block:: shell
+
+    git clone https://github.com/Linaro/uadk.git
+    cd uadk
+    mkdir build
+    ./autogen.sh
+    ./configure --prefix=$PWD/build
+    make
+    make install
+
+Without --prefix, UADK will be installed to /usr/local/lib by default.
+If get error:"cannot find -lnuma", please install the libnuma-dev
+
+Run pkg-config libwd to ensure env is setup correctly
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+* export PKG_CONFIG_PATH=$PWD/build/lib/pkgconfig
+* pkg-config libwd --cflags --libs
+  -I/usr/local/include -L/usr/local/lib -lwd
+
+* export PKG_CONFIG_PATH is required on demand.
+  Not required if UADK is installed to /usr/local/lib
+
+UADK Host Kernel Requirements
+-----------------------------
+User needs to make sure that ``UACCE`` is already supported in Linux kernel.
+The kernel version should be at least v5.9 with SVA (Shared Virtual
+Addressing) enabled.
+
+Kernel Configuration
+^^^^^^^^^^^^^^^^^^^^
+
+``UACCE`` could be built as module or built-in.
+
+Here's an example to enable UACCE with hardware accelerator in HiSilicon
+Kunpeng platform.
+
+*    CONFIG_IOMMU_SVA_LIB=y
+*    CONFIG_ARM_SMMU=y
+*    CONFIG_ARM_SMMU_V3=y
+*    CONFIG_ARM_SMMU_V3_SVA=y
+*    CONFIG_PCI_PASID=y
+*    CONFIG_UACCE=y
+*    CONFIG_CRYPTO_DEV_HISI_QM=y
+*    CONFIG_CRYPTO_DEV_HISI_ZIP=y
+
+Make sure all these above kernel configurations are selected.
+
+Accelerator dev node permissions
+--------------------------------
+Harware accelerators(eg: HiSilicon Kunpeng Zip accelerator) gets registered to
+UADK and char devices are created in dev directory. In order to access resources
+on hardware accelerator devices, write permission should be provided to user.
+
+.. code-block:: shell
+
+    $ sudo chmod 777 /dev/hisi_zip-*
+
+How To Use UADK Compression In QEMU Migration
+---------------------------------------------
+* Make sure UADK is installed as above
+* Build ``QEMU`` with ``--enable-uadk`` parameter
+
+  E.g. configure --target-list=aarch64-softmmu --enable-kvm ``--enable-uadk``
+
+* Enable ``UADK`` compression during migration
+
+  Set ``migrate_set_parameter multifd-compression uadk``
+
+Since UADK uses Shared Virtual Addressing(SVA) and device access virtual memory
+directly it is possible that SMMUv3 may enounter page faults while walking the
+IO page tables. This may impact the performance. In order to mitigate this,
+please make sure to specify ``-mem-prealloc`` parameter to the destination VM
+boot parameters.
+
+Though both UADK and ZLIB are based on the deflate compression algorithm, UADK
+is not fully compatible with ZLIB. Hence, please make sure to use ``uadk`` on
+both source and destination during migration.
-- 
2.35.3


