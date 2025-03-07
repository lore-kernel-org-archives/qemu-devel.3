Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930E3C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfgN-0004yX-5i; Fri, 07 Mar 2025 16:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgL-0004xr-DN
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:37 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgJ-0001jR-UE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:37 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224171d6826so19558735ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384594; x=1741989394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rr2e69lL8FG0Id6CFQe12hDqKFL6G/BQmRPiJllL+3c=;
 b=ue9yWhH8mYGej/lLcpTBhr3q1RduNzMbNeP/5Ea1O0wKBXUQ35Q4p9JP7zPh8gIf1y
 yrtMyu04Dmcx2GyiZlIzHMFCy1k/NHtpe4elJNSr8K0eMLXTLlHE0FUnWu2cYp2XWmG/
 fWRAykqRvLRgRkcTVY/B3ot72cSiO6h9antfhJR3Gc567S7B65ui50HngbFWfqDQra65
 kVB74ejGWUp3jdZHzB6xd4qeJaL2PRJ0YEloFEWXR7rMxaADXURFlAMxp/lKehGnb3fE
 lrv7BJhxat+viI+G/bGwaQnIYNJ9V5F8b7KzL4DqFLHt0YxJhEZjC57Ngv+GH0ZMTqbH
 fIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384594; x=1741989394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rr2e69lL8FG0Id6CFQe12hDqKFL6G/BQmRPiJllL+3c=;
 b=PeyqlV5tYENGGssN5rZDY9EA8IveooIkn2GKT38KiRnTqsmG2g56mr9Qrm/N5XbhWi
 u/2FHWb9udW9NRGJfpHxDD0e90SCxInWoDZJuXJLObn4xJPeRfwU6R3pBKp34H3ELSBI
 gLerfhfWZaIKvVRUzfjTgkk1Rp3Rfvm0UXnNHjWLpkpSCpESsJDIfQPe82uJbRsHhc1q
 HeL34LGY3clceBEmMIDY5QeHNmiRhxnewh0pw/PtDYThCBmrCTg+6GDcPy8g314zAx2X
 +FuSfmYbSFK26yjEy7pDBiAHQP+V/JEpLP+yis7bpPhZg8/TCc9lQB2gtpU2bmj6lKHx
 VCxQ==
X-Gm-Message-State: AOJu0YylP+ps9uQkMRl2xKXHLGUR50foHeFcxI3KwaCdSY9ZICvFAwY+
 7D/mBUEkKptso1fG5heGS5M2kKQfa5+rftNKUvtuqCzjsC4o9PqaJO3CR7seR2UghvePqVF+KOC
 5
X-Gm-Gg: ASbGncvGsPwB+YvF1jnHuEDoR0ihMnGiaWd9iowpq1PfmEXwgZ1P2b2zdr0ZnchESFR
 PMZgSM56oHwA8dL8GtAdv9hvUUGnzTYjrsKiBvO623nJ7h2oP3c8+fsWMStiMXZshyhSOSMLbUh
 /fmMnrscDKGH+Lhq7gTIsncHpcgPY43jLO5LntPImc+JZFlt8zD/0gv0AOEFiSCHMrvBA4VDUe/
 r6DMmf9gnuk9P5EBeGWf+YD+1Z+QsUWZrtK3fINlN91R5+d7Kctga/SdV3mJ96thTs+kLD/d5do
 Vq4UNLov/G1+GUWuZDhzg276ZpvltJcCBCDnjKv27hS3
X-Google-Smtp-Source: AGHT+IGQFEGM3zWoP1MGBVKNnQI/YWUNXjOKA9W7V+6fnwmx4R0V57091J+aPoAmgwXrY1gc8ntrpg==
X-Received: by 2002:a05:6a20:7fa7:b0:1f3:4761:2173 with SMTP id
 adf61e73a8af0-1f544b1859fmr9592188637.24.1741384594725; 
 Fri, 07 Mar 2025 13:56:34 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ac9247dcsm2000927b3a.125.2025.03.07.13.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 13:56:34 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 pierrick.bouvier@linaro.org, kvm@vger.kernel.org, alex.bennee@linaro.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v4 1/7] hw/hyperv/hv-balloon-stub: common compilation unit
Date: Fri,  7 Mar 2025 13:56:17 -0800
Message-Id: <20250307215623.524987-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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


