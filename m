Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6165C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 05:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzUY8-0003uF-4T; Tue, 01 Apr 2025 01:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tzUY1-0003ts-3z
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 01:52:30 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tzUXy-0006Gi-Aq
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 01:52:28 -0400
X-ASG-Debug-ID: 1743486736-1eb14e18d900240001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id gP0W5X89XsjhBRGA (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 01 Apr 2025 13:52:16 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 1 Apr
 2025 13:52:16 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Tue, 1 Apr 2025 13:52:16 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 11:35:50 +0800
Message-ID: <65a6e617-8dd8-46ee-b867-931148985e79@zhaoxin.com>
Date: Tue, 1 Apr 2025 11:35:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers during
 VM reset
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers
 during VM reset
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <sandipan.das@amd.com>,
 <babu.moger@amd.com>, <likexu@tencent.com>, <like.xu.linux@gmail.com>,
 <zhenyuw@linux.intel.com>, <groug@kaod.org>, <khorenko@virtuozzo.com>,
 <alexander.ivanov@virtuozzo.com>, <den@virtuozzo.com>,
 <davydov-max@yandex-team.ru>, <xiaoyao.li@intel.com>,
 <dapeng1.mi@linux.intel.com>, <joe.jin@oracle.com>, <ewanhai@zhaoxin.com>,
 <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>, <silviazhao@zhaoxin.com>, <zhao1.liu@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-9-dongli.zhang@oracle.com>
 <8a547bf5-bdd4-4a49-883a-02b4aa0cc92c@zhaoxin.com>
 <84653627-3a20-44fd-8955-a19264bd2348@oracle.com>
 <e3a64575-ab1f-4b6f-a91d-37a862715742@zhaoxin.com>
 <a94487ab-b06d-4df4-92d8-feceeeaf5ec3@oracle.com>
In-Reply-To: <a94487ab-b06d-4df4-92d8-feceeeaf5ec3@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 4/1/2025 1:52:15 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1743486736
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3842
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.01
X-Barracuda-Spam-Status: No,
 SCORE=-2.01 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=TRACK_DBX_001
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.139319
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.01 TRACK_DBX_001          Custom rule TRACK_DBX_001
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

>> [2] As mentioned in [1], QEMU always sets the vCPU's vendor to match the host's
>> vendor
>> when acceleration (KVM or HVF) is enabled. Therefore, if users want to emulate a
>> Zhaoxin CPU on an Intel host, the vendor must be set manually.Furthermore,
>> should we display a warning to users who enable both vPMU and KVM acceleration
>> but do not manually set the guest vendor when it differs from the host vendor?
> 
> Maybe not? Sometimes I emulate AMD on Intel host, while vendor is still the
> default :)

Okay, handling this situation can be rather complex, so let's keep it simple. I 
have added a dedicated function to capture the intended behavior for potential 
future reference.

Anyway, Thanks for taking Zhaoxin's situation into account, regardless.


+/*
+ * check_vendor_compatibility_and_warn() returns true if the host and
+ * guest vendors are compatible for vPMU virtualization. In addition, if
+ * the guest vendor is not explicitly set in a cross-vendor emulation
+ * scenario (e.g., a Zhaoxin host emulating an Intel guest or vice versa),
+ * it issues a warning.
+ */
+static bool check_vendor_compatibility_and_warn(CPUX86State *env)
+{
+    char host_vendor[CPUID_VENDOR_SZ + 1];
+    uint32_t host_cpuid_vendor1, host_cpuid_vendor2, host_cpuid_vendor3;
+
+    /* Retrieve host vendor info */
+    host_cpuid(0x0, 0, NULL, &host_cpuid_vendor1, &host_cpuid_vendor3,
+               &host_cpuid_vendor2);
+    x86_cpu_vendor_words2str(host_vendor, host_cpuid_vendor1,
+                             host_cpuid_vendor2, host_cpuid_vendor3);
+
+    /*
+     * Case A:
+     * If the host vendor is Intel or Zhaoxin and the guest CPU type is
+     * either Intel or Zhaoxin, consider them compatible. However, if a
+     * cross-vendor scenario is detected (e.g., host is Zhaoxin but guest is
+     * Intel, or vice versa) and the guest vendor fields have not been
+     * overridden (i.e., they still match the host), then warn the user.
+     */
+    if ((g_str_equal(host_vendor, CPUID_VENDOR_INTEL) ||
+         g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN1) ||
+         g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN2)) &&
+        (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)))
+    {
+        if ((g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN1) ||
+             g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN2)) &&
+            IS_INTEL_CPU(env) &&
+            (env->cpuid_vendor1 == host_cpuid_vendor1 &&
+             env->cpuid_vendor2 == host_cpuid_vendor2 &&
+             env->cpuid_vendor3 == host_cpuid_vendor3))
+        {
+            warning_report("vPMU emulation will fail because the guest vendor "
+                            "is not explicitly set. Use '-cpu,vendor=Intel' to "
+                            "emulate Intel vPMU on a Zhaoxin host.");
+        }
+        else if (g_str_equal(host_vendor, CPUID_VENDOR_INTEL) &&
+                 IS_ZHAOXIN_CPU(env) &&
+                 (env->cpuid_vendor1 == host_cpuid_vendor1 &&
+                  env->cpuid_vendor2 == host_cpuid_vendor2 &&
+                  env->cpuid_vendor3 == host_cpuid_vendor3))
+        {
+            warning_report("vPMU emulation will fail because the guest vendor"
+                            "is not explicitly set. Use '-cpu,vendor=Zhaoxin' "
+                            "to emulate Zhaoxin vPMU on an Intel host.");
+        }
+        return true;
+    }
+
+    /*
+     * Case B:
+     * For other CPU types, if the guest vendor fields exactly match the host,
+     * consider them compatible.
+     */
+    if (env->cpuid_vendor1 == host_cpuid_vendor1 &&
+        env->cpuid_vendor2 == host_cpuid_vendor2 &&
+        env->cpuid_vendor3 == host_cpuid_vendor3)
+    {
+        return true;
+    }
+
+    return false;
+}
+

