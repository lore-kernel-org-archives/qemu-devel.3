Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E24C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2RQ-0006vw-NU; Tue, 11 Jun 2024 10:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RO-0006uU-3W
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RM-0005yQ-IX
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cM7wXV2F0pH6OJZLvvHOAgJSjTxfrcPSVlPgLYx7Pc=;
 b=G47aFxthQq82QGX7Q/QrpSeiK1qmNhUASkNomB04/LQGHzTvA/zT/rWuLL8gN1wqrFKNkb
 ZP5u8e3GyPlkil+9FFN6JF+axnSfRMVQC6dbyM5DtgG8kMf0WRrfDO6YeoFVV4dPdNdzuj
 1q85YVs0z+0mZLjjSyp7uDa9W5szUwE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-YPzCvkvjOF6GZwt-7QjeIg-1; Tue, 11 Jun 2024 10:25:29 -0400
X-MC-Unique: YPzCvkvjOF6GZwt-7QjeIg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6f2af30793so47500666b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115928; x=1718720728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cM7wXV2F0pH6OJZLvvHOAgJSjTxfrcPSVlPgLYx7Pc=;
 b=sdro15VJVAetaO4pQY/aaC8OUxJVJXn6fyAYFieWoaaXCyvYWOts0fKYn8jaSn0de1
 eUoa6ZwmnDD0pnqY5Yhi7kBpJdqx9a8uoCog6YXI1hAF7G9Q3ejri+ssj7b7KAX1zgS9
 LmwEhnzM8e4k0Co/9dE0h1iQmV9mP79h0sOXv5bVp8hJHafViPnz8QeyS+8Mo3hqItAi
 I0yx5Y9VglPBFyb2X9ICUDiMDU4Xd4+cGfm1RvvGfqVB4ifbuRHYcQ1hiPf9IzF4X0P3
 rDCNOXi4dE2vQLJNFfIyddUEMERTLFMPXObY+R0EqjHGu8M2bVohjsRWMAV16LiVzSv4
 dd7g==
X-Gm-Message-State: AOJu0Yy37JM2oCUAtjpM+m/ik5LYKpm886aTsLhgGG2EPlxulyeFUYRX
 xEEfBjjKJm0jfLMAfcFUA3ky96iAeo16WhxzWoSJkoAl0Pj+KWu0CwTaJDw5kImUCAE7Lbc1Gwy
 7LhwMjuyFMqLHyYUoHdBvJtMuEYFMs+rWQivBc2bHdabGANGgI8jy4ktagKj67L8D+vSt/8mUz0
 wYnQoLf/aIaTNxcJQY3mCTa3QzNOauNxbjJgsB
X-Received: by 2002:a17:906:2844:b0:a6f:1d3e:d1af with SMTP id
 a640c23a62f3a-a6f1d3ed202mr440176966b.5.1718115927811; 
 Tue, 11 Jun 2024 07:25:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+720WuYCmxgP7HJp9rCt/R4ioMgMDddeTijxEo80Vhf33ZpxBt0UimL2bwY8sRLGqaqgtXA==
X-Received: by 2002:a17:906:2844:b0:a6f:1d3e:d1af with SMTP id
 a640c23a62f3a-a6f1d3ed202mr440174966b.5.1718115927490; 
 Tue, 11 Jun 2024 07:25:27 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f3672d1efsm102920766b.224.2024.06.11.07.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 02/25] i386/cpu: fixup number of addressable IDs for processor
 cores in the physical package
Date: Tue, 11 Jun 2024 16:25:00 +0200
Message-ID: <20240611142524.83762-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Chuang Xu <xuchuangxclwt@bytedance.com>

When QEMU is started with:
-cpu host,host-cache-info=on,l3-cache=off \
-smp 2,sockets=1,dies=1,cores=1,threads=2
Guest can't acquire maximum number of addressable IDs for processor cores in
the physical package from CPUID[04H].

When creating a CPU topology of 1 core per package, host-cache-info only
uses the Host's addressable core IDs field (CPUID.04H.EAX[bits 31-26]),
resulting in a conflict (on the multicore Host) between the Guest core
topology information in this field and the Guest's actual cores number.

Fix it by removing the unnecessary condition to cover 1 core per package
case. This is safe because cores_per_pkg will not be 0 and will be at
least 1.

Fixes: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240611032314.64076-1-xuchuangxclwt@bytedance.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7466217d5ea..365852cb99e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6455,10 +6455,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             if (*eax & 31) {
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
-                if (cores_per_pkg > 1) {
-                    *eax &= ~0xFC000000;
-                    *eax |= max_core_ids_in_package(&topo_info) << 26;
-                }
+                *eax &= ~0xFC000000;
+                *eax |= max_core_ids_in_package(&topo_info) << 26;
                 if (host_vcpus_per_cache > threads_per_pkg) {
                     *eax &= ~0x3FFC000;
 
-- 
2.45.1


