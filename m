Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F47CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvXe-0006Ia-77; Wed, 14 Oct 2026 05:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvXU-0005aM-RH
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:44:48 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvXS-0002Ac-7g
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:44:48 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-33c2520ad38so9002144eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791971085; x=1792575885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sWqnMtVBapcAMkNSzz9Oucq2kSJcuJ58bnoxZuu8/QU=;
 b=h28cYMYx83AH/25b/yFQ9Y0kuo0M18OtVgEOL3QjFDsJxoYvInqVvMsHjoB/9vquzx
 +AEiYBpOwSb+p63YpzxMNPR96Qsd9D0yzDgNCRuq5hEq8PiUTedPmjzZ0UhJc+onuV54
 7sPkbL24mSTF017grmOaP5BL1xWvClzRTo7dIR9bKyg24o1d9N4W+IDMQQpu8rl0lIux
 vtn8KsN/aUh7Jq73pc2BSSLwOTD6Bi28iSHa0PcJMNtkap6+IHf42eQ1Cuuuiy+eD9Vo
 CCIICYRWlx+uzwjVmM+SBbsCD+KxpXy3+gWLcUgEdaj9jlABpPMZIRGhRRvvi+SFMeZj
 0eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791971085; x=1792575885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sWqnMtVBapcAMkNSzz9Oucq2kSJcuJ58bnoxZuu8/QU=;
 b=Y7E8nykH79XoKcdRNbkphlVm11domUSmTI/Pwk6WkKOSNzP2Qj0/V380oooPC0nM8W
 RWOL1uYebPkD7qyJWOfWHtsn/6hn6/R8tr7M2osuqWsju+MsMbyJ2t+i2Mejy+pLgu7U
 Fhu2oZXmz9f/P5ROf2xbuQ9hpZ/Yp+jrDThB3WWXDgVdavyq1LCJNdDZTCcDBvK7rpsU
 G5qwOY2xIoxn924zgmGzp3EtPPabZ5AA9RfMVuLj3XyTHpNdHNeQbYfzN5UYl1XL5wQN
 j7L36CYR3/cbuD9lUgcJLVq4Ujh4VNK5rnoORU/LzRuNBPNB02/kR99nylbXDEUkay3T
 w1hQ==
X-Gm-Message-State: AFq9FYLdsVy3yhLDRuTOlyWM3vNnW9ohvtwACxqfeBS80udKz40ATaq/
 RZOXC/fKkjRTJv8GiGvbmGGsAsjCEcsT1VVP+U6Vfgy80Zsk/kJoIbUrl1TuNYsvl8g=
X-Gm-Gg: AYBFou30oDvoO5zSEpIt2uceyfEO+uXO+SmNnVOFjV0Zw6mBCVXvY7N06RIozA7fIy3
 dDt3XIu+STS5KIbcN0vg7jlV4uN0u7ptHv8NZN2jHYhflsbawjPJXAgowszbpFN41Xqyz9mjOD+
 k6ZRyNabvQODL7UV7B9c3/M3rjD3CRSKTqzOJjg6kKKMLg72jO0+/+H4RmBRDDc92n8mMBHBxGN
 +yxhlBJk3uMBMMe1KJAMgY3bDrzF10lULDBi3t/SZZ5hY1XPHY4LMuIC+Mz8qdBojsoJQw5vtTP
 sy6YlJ/IOfc40w2q6+45fDHXWGR4/hHx+rnq921yU8wH3zVcMW+nLzuqrbd2HKCjbDksfcCCqe8
 626Gg25IkotyDQ24jHwKDBbGJ6EcLLPcFvirzivyD/ZygD8to9znt/RXwecrco8OB2aOhB9WtY+
 zpfY8BlaccoZ1QbXGxjXetnEGuVTvVAKrjdYc0Ag2rB8vth9H53Lpdhrwt2wv6m5+d07jqaobFY
 6CqBGM0nj6IZKpgSw==
X-Received: by 2002:a05:7022:7f14:b0:14d:c53a:f6a0 with SMTP id
 a92af1059eb24-16a5dcf6278mr21934044c88.13.1791971084559; 
 Wed, 14 Oct 2026 02:44:44 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:44:43 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Song Gao <17746591750@163.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 29/34] system/arch_init: update qemu_arch_available to handle
 non-target select condition
Date: Wed, 14 Oct 2026 17:41:44 +0800
Message-ID: <20261014094224.1976-14-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1336.google.com
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

Under multi-target qemu, target may not selected when call to qemu_arch_available,
return true for that.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 system/arch_init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/arch_init.c b/system/arch_init.c
index b8362b12a6d..5424ef8cf24 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -24,9 +24,17 @@
 #include "qemu/osdep.h"
 #include "qemu/base-arch-defs.h"
 #include "qemu/bitops.h"
+#include "qemu/target-info.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info-qapi.h"
 
 bool qemu_arch_available(uint64_t arch_bitmask)
 {
+    if (target_combined_binary()) {
+        /* Allow all architectures until machine selection sets TargetInfo. */
+        if (!target_info()) {
+            return true;
+        }
+    }
     return extract64(arch_bitmask, target_arch(), 1);
 }
-- 
2.55.0.windows.3


