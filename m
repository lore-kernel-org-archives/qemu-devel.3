Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0509C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdWT-0001PT-1e; Fri, 07 Mar 2025 14:38:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVl-0000uz-AG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:38 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVj-0007X4-HD
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:33 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2239f8646f6so43850585ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376249; x=1741981049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9F27FfUGwswIcGWG8chjG9ToIwjCIEVz8dw0HLVPgHE=;
 b=izUibNIB4U/vp2Dvjzv+V4CrQX8AZ4jEzBpDhdzwYXKSLUlxdZJHNDRj/QrKXa3xO7
 RBtplQLACuc9sJ55pl+1+V17mJ7VAkLkkr9RtDrdkZJL+E/QmTY1yEycGVJ1I45cVPt3
 r0QBvrPYlzeEL9t5nuKczEC2PccQf+BafJWCtNthSWlm78zSiFY9M0dfwACkYEZbENoX
 PEMOqWYzoEnvckRvVQjt3hnB43oNLxFIMcFE4VPW26uPjwSsHf0jXUk+n9RqBH4L/wKm
 IPcvDZx9lY4L0D3HqJ98EEx9L2R9Lkyss0gmJnEIoKEsiGm+LUoHClI/alCMC0OKnaMG
 wnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376249; x=1741981049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9F27FfUGwswIcGWG8chjG9ToIwjCIEVz8dw0HLVPgHE=;
 b=pTYqpbn8oh+7empC276T2I+LdYuXTOQ69EytIkql5DiLKK+BKXRXVcL9fNyUO7Nj+3
 sqOhJDY3YgZX1NmggBk9IeD1hLfn+WULBXot+opHmYYzAhMu2o8lLQNi6q+I87linOo1
 BFNRjW56CVwYnaVNv2vhpMhATq2/Gib28lPbjfEM0y53/Z6Y8/6MYihiyDdf0HHAApVf
 6qu8DBPx+DDAcrsFODhFP8U8lP0e3usw4I9z5qHenjm5mvmVsinz5N3yr4YElg+zIx+B
 yYx3jFbEzFMqD5xAXbGIALma7pvJziwCFEHzC2YUWD3I36Zsgb3nQUFJHEQ5mTdmLYwQ
 fWqQ==
X-Gm-Message-State: AOJu0Yz3S2t75Bh+oLFs5gbax5xtCJDR/GMHC7aAx041QEJjdtIuoKzb
 GtpMDSITF+/hFzSJUo92B07bjZtDHxg867+Z15kameBHfI6Sde5H1GPmcKz8uQkvxDK7eI0ekGu
 j
X-Gm-Gg: ASbGncuMJs4Kege2JdIio+6dhopvjCKrMx2t3qxJgxck+EfxEGSE88MsKmOYzRH8xfP
 klKxOV4JubwUGw2pErSQ2o6YfYos58Hi6fUeosLvryV+rv2OMXhLhrlw1E+G/R1VJVM3vwQwQaI
 B6rtX4HpXyWZ5CWUuRv+/lwtC7SKMQTXxjeSl2AxLARj116+ebHjQ4WKxH4hq7djqQThNDQx8ls
 8TxH7nMDF172FCz2Fjr0t5GJn4JpKrXhweeQu7sBTZu6/yJ81aXfze9JVHxKasg/w8/a9VA5RTu
 CnNfhWBoUI2rGReoNPx/AYPgyyhp4/Mg7DyMpPz6awFY
X-Google-Smtp-Source: AGHT+IHWCKlEFd/V+IXVDyRg9UgdcAnAKe1xUxYmKmGOcFCl5FIjv1cYNHI8vIQzpKEocH729xzagg==
X-Received: by 2002:a17:902:f786:b0:224:c47:b6c3 with SMTP id
 d9443c01a7336-2242887ecefmr70236325ad.6.1741376248782; 
 Fri, 07 Mar 2025 11:37:28 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693739ecsm3821757a91.26.2025.03.07.11.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:37:28 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, kvm@vger.kernel.org,
 richard.henderson@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 7/7] hw/hyperv/hyperv_testdev: common compilation unit
Date: Fri,  7 Mar 2025 11:37:12 -0800
Message-Id: <20250307193712.261415-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
References: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index 5acd709bdd5..ef5a596c8ab 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,5 +1,5 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
-specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
+system_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
-- 
2.39.5


