Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDB9C28B27
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdVy-0000xQ-0R; Fri, 07 Mar 2025 14:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVf-0000ua-CH
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:38 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVd-0007WG-0O
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:26 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2235908a30aso16134395ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376243; x=1741981043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rr2e69lL8FG0Id6CFQe12hDqKFL6G/BQmRPiJllL+3c=;
 b=y5yBLS4jpWE/YDxCB9jL+O1kq8nasucWnF1f2wB81TPlMXqPdCsZifXrH+9QSB4WR0
 ZqdWxYe8r/Wj1QWrMULSwHVe2z6ptsmKnz9Kpb//TfuGVpeOT03uOZqGHeJWweOtUU4V
 w6DsBILQgx3YHN2L5nGlZ/JXlDa1Js2wIS/Fx7O0u9HoqSmdqVx/ephSqEIYGOZhxwUL
 mAGezTRJsx8ASZUz3i2el2gisIX79oQKoMk3xhHm2gHYk46Fw9oFF1Lu/gYGYbxDLxDZ
 xOfsaiALHZi4zOpjyUEdxVNia84YvEFRBULCBRBQ0wp9k6a+/0UQvTqBMQ5kszzNS1pK
 h1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376243; x=1741981043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rr2e69lL8FG0Id6CFQe12hDqKFL6G/BQmRPiJllL+3c=;
 b=DWpCZTMUPY/Ccthhm9ZnBj4U21AShRGPvd8CLCotHDF351AQCkHU1z9EIyS8BlDn5G
 Y9qmsAiQm2+qlf+VlLWO9a+hkJ3EjDpKN7KJoGs2x2Kwqw0krc/bmKUXZy7i3Cx3/q/z
 qcho55F13RYrzesjDrY10b2Jigq3HhvP1ooAwC6lj02I+2jHh9fWIbFJnKkSc5yQXJ2Q
 BX1MQatCcARunuqsGcQaJwkLOUXDSEummMyA3mCH8tfsEbNSiYOfDbS0IYzIOT5QKgc7
 vW4zlxhkPYd/ToHkvYNHXl9b3/z7fUOpT7BRseWv5IiqXZDahLA6ZrcJ235ZLiawPIzz
 Zo6w==
X-Gm-Message-State: AOJu0YwHFDXb5sFguU6Jkg2wkNPEQjZdAN9JU8TuMRPdBXKWrY4fSIDJ
 lvO/e57lpWLgnPmDQl3pHyq2Cpq6vfSy0sSG/nLO8HsBeonQbO3bicNqDZ/c4DnKXVQWLZE0Ykl
 l
X-Gm-Gg: ASbGnctKlZA6vG6KlAs/vfW0aAygNv0M5nepGEwmnml53HK9A7PX4bNP2PF+tEVOTDY
 wqLh4k5MaNVS9Zg7Nr/1tirZ6tTa8u8f6ZoRhPtYXH/1VUdBH6LP+7t9fJg7YLWoYCuxMREuXxx
 +L3SRldNd+i2oFTO7MbVkfK+v3aSNAVAigsS/mzsypsk7tqGkQ19y68+ft71ENakljPGIDrM0hN
 jRFt2VcyEpQwhygXT94Ov6MImOc7PTpFk6l7nNpOj0ZAU7TdeQ+8ATKM4vk33u272DKPFPic87i
 VfD/TqP0Ch4xoPoiuGfvnkzxpHfSYQImPo8Pss7L6PnJ
X-Google-Smtp-Source: AGHT+IF+B4FmJwW4AAH0ztyyNrVMPlGFTFmizaeHxb8u74ANm2FF7U52/1RJ8EMRstrrGA/FGRW6YA==
X-Received: by 2002:a17:90b:1c0c:b0:2fe:a545:4c85 with SMTP id
 98e67ed59e1d1-2ff7cefccd3mr7096469a91.27.1741376243525; 
 Fri, 07 Mar 2025 11:37:23 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693739ecsm3821757a91.26.2025.03.07.11.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:37:23 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, kvm@vger.kernel.org,
 richard.henderson@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 1/7] hw/hyperv/hv-balloon-stub: common compilation unit
Date: Fri,  7 Mar 2025 11:37:06 -0800
Message-Id: <20250307193712.261415-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
References: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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
 hw/hyperv/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index d3d2668c71a..f4aa0a5ada9 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -2,4 +2,5 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'), if_false: files('hv-balloon-stub.c'))
+specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
+system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


