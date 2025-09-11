Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF345CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 09:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwe2x-0001e4-Ot; Thu, 11 Sep 2025 05:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uwe2r-0001cf-L3; Thu, 11 Sep 2025 05:56:49 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uwe2l-0005P0-41; Thu, 11 Sep 2025 05:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1757584579; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=v+vs4CjpsTjK/bQhd1tu9FkaHGP8LV/h4beB5NsLGsY=;
 b=uOgeGZtzDWc1+VkF1Y17lvydmQ5tchcLtOjN25Kb+nPJpWFY7JcKivjIM0WJU6UUFgJcoRCfDPFbyo8mmzoheBgKepNVQq0sCTaTcjtaw2JuYNJxazrW32ixCbhNAfne6m9v23cY65n9IXqQmFGOrGMDfGHV+V+l8J+WCYsz1Ls=
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0Wnlj.Ka_1757584578 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 11 Sep 2025 17:56:18 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 11 Sep 2025 17:56:14 +0800
Subject: [PATCH v3 2/4] migration: Add support for a variable-length array
 of UINT32 pointers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-timers-v3-2-60508f640050@linux.alibaba.com>
References: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
In-Reply-To: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757584576; l=1832;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=cayQUbiz/WECLi6cpVZlwvmhlxaq9Pjmx69PYLrf5gU=;
 b=GRQ0OjVb3FeXn2XgxLUf+jJ6HaL2ch4vCSW1NekWU3meTPsR2yHjqas2TTK1FD7niN2IrBa8/
 mWbAj8tCAVqBwjw0bRvYLgU4tkZFmv9tqqBTjwGwsaGOm8H74I5cQ5v
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Add support for defining a vmstate field which is a variable-length array
of pointers, and use this to define a VMSTATE_TIMER_PTR_VARRAY() which allows
a variable-length array of QEMUTimer* to be used by devices.

Message-id: 20250909-timers-v1-0-7ee18a9d8f4b@linux.alibaba.com
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 include/migration/vmstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..1cfddf31b54090f0f63380794092858b4bed8bcf 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -522,6 +522,16 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
 }
 
+#define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
+    .name       = (stringify(_field)),                                    \
+    .version_id = (_version),                                             \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
+    .info       = &(_info),                                               \
+    .size       = sizeof(_type),                                          \
+    .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
+    .offset     = vmstate_offset_pointer(_state, _field, _type),          \
+}
+
 #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                                     \
     .version_id = (_version),                                              \

-- 
2.43.0


