Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC045C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4vZ-00026F-3M; Thu, 06 Mar 2025 01:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vH-0001zO-M2
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:36 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vF-0006G3-Dp
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:34 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2239aa5da08so3616255ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741243291; x=1741848091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnhPiWQ46KHFDBAFB5FNYntK+UjbBUc/XRUUAjHcGsQ=;
 b=SF60Dl6ueLNkAkSKXCFm9f/szUvIVcBhKIxIkdN/pmO3FKEHUGAag7VynKlKOSSaTk
 Xy7bI5taunD1MNToSBWOb8HiJ2j0SDX5hY/lk7vqhGmyZTXhjPw9PCzkzThGM98yzmEd
 Hf3lQDoAP77gjn3/nEnQAfiqKaIry2FCSiO2jJ8yNs9P7ChBP/JsJptwnw/5b4gKBmdO
 5i0ZPd7Vn0SFpE6aQ2manyi0QVzd3h/BYh1toxK3grvVO7UnBRVA59Hedb6uH2J3C79t
 f8woBVfkkcpYBWjQaIvlFW4xgRYCLruadhqsTLsFeNd8TQ1N2P4AK6zXvtfEIbbor6cv
 PUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741243292; x=1741848092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnhPiWQ46KHFDBAFB5FNYntK+UjbBUc/XRUUAjHcGsQ=;
 b=jtJfd9OUrellBgwctHEwEic5KNmUSCMjYjJK0Z6kRxEm/BLHNQOSMTP/UIZlV5iTQx
 uuxtnsuOXLZqPPESIhvEa7IH64EZVyrjyVxiNs3ZzRX1QyYx+GcZiHvNuY7RPSm85T71
 IkZCdt+cZYh9erdJ59ReYaJtcivU5YzWo1GrmZ1Clx+OOj0J4tYt4YcUopy7Y8OM71eb
 ow/Pz3sigtvJZZd/2Ziu4ScSAmsJJmYzHvF53mnzBvXvdDc+fUtQYLFlBvgRWTxU1BOb
 w7Ar5J+1kjmi9ghtuQosviaQEmLnU/VQor+fDnyWotnHhzG9RTln8ynxO82QnDvQzNoZ
 C6Yg==
X-Gm-Message-State: AOJu0YwsNOj9+L7q8pEmR2CccKJo/zJUuLqFQO8VTji+BZEQonQTThFx
 TPkp7x4SaZEif+OjcLwD0fqicZZFI0e0ch4gv5wYW49m0igRpnVeOc9AtWxVe2sohjFbjO6zCyQ
 N
X-Gm-Gg: ASbGnctuwOyX2KRjIoW3C1vai4kbjcIj4vlKu1QAzp2EAVcJESPEd6dGKjA3umS7zt+
 QHcwPsN+AjL1gsWsWtib1stRRXYxg3Zfv63apgayQyHXhNpnH9GXqdqg+LsHQ9Wtrpo8IEpCmL3
 tzWsb25PcBhZYRqxgcgx4UE3br7Zs9UDMN56FjV5tBIUq6iQowBwy3bSTblc18aQkInEOsXM1mm
 BCPV1KSMUo5euApWhUTtWCox9V9C46nkrEzGBvLugOMuBf1tDcXAhwG8dUk7XezMGf7A4stvG/3
 rAnRzO3dq4d638HQbwBsLhb4u0CPjCSL65fx0joQYOIH
X-Google-Smtp-Source: AGHT+IEq64VAzi+4aQJPN7hRWSuCMxEBlLQ6WpVavzM/G3w68jHWfj5WK0DeS8abR956/Zd3+Yllmw==
X-Received: by 2002:a17:903:19eb:b0:215:b1a3:4701 with SMTP id
 d9443c01a7336-223f1cd9503mr98970205ad.13.1741243291712; 
 Wed, 05 Mar 2025 22:41:31 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cffsm4769355ad.174.2025.03.05.22.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:41:31 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, pierrick.bouvier@linaro.org,
 manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 alex.bennee@linaro.org
Subject: [PATCH 6/7] hw/hyperv/balloon: common balloon compilation units
Date: Wed,  5 Mar 2025 22:41:17 -0800
Message-Id: <20250306064118.3879213-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index a9f2045a9af..5acd709bdd5 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -2,5 +2,5 @@ specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
+system_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


