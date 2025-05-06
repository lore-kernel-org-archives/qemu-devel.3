Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D134C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJOv-0007TG-Sw; Tue, 06 May 2025 10:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOo-0007Kg-QO
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOj-000151-Uj
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:35:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so4304289f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542152; x=1747146952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4nasfLqu0VVLMFCIOog2FEhLL4f1HNNL/mEDNMZUOE=;
 b=TNBmEY0ouMQqBq969Nn4AWkpLJb/FIjD1li4jwfOd7qe3IAZMrThVIeFiIalZP8Sy2
 61DpQcffkkS+EtQ2c9/Fv0OO+QmQBTLCNZuGSAvpUKs+8uJqggMnwOpHTFJohnYgtezB
 jRvMY7A65CO5PCxrnhQhUcEwSRsqIRHOhbpH/l/7X+kMR7EdW2Lm7ghg3XqNEcR/wEnn
 sOxg3ZIOR7gPqaXo4GKGf4BgzEDECw4tu0Awkb5xXhUGxiPBm5gvFRWeDg/rJuwyAyj+
 Bl9Xi49Gn8DHAbuJtUSiNOHQobjTcMyPjU/jA1srCXN5hD6Q5IRymYquZDDLiQfp6UP6
 KO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542152; x=1747146952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4nasfLqu0VVLMFCIOog2FEhLL4f1HNNL/mEDNMZUOE=;
 b=M9I8FavfmaJ9Ts4sYJ0rmaQfaEjeP+30rMcB+H8RcOdybO5ox0kcNvHt9SSVkQHWPr
 vLLjUAKHqraQjhVQep4+FRao86sok1FLyrS00fKNUi3osi+/13DwgzXvG62hA4SFBQxO
 nKGoa2tj8k4M6mPlPLG2loH+NApXRNB+jAcpFl5nymAr2I5D96iVeARC0bdpcdOLRnxu
 An6GHnUwGkYoFPHogQhaUVrF8m/vgNo9+0hWH88TGN9Em5LGPnBdo3xA7fG2CeP2Qmx2
 LKWANZDBUdETqzPdnVaY09lf41AkE2FsfzVIZ4YH8Kac37VLoSJAxuGxFuLcOws/tN3Q
 V+Vw==
X-Gm-Message-State: AOJu0YxUFFsvGO4u58gXstt2J24zlb6anYmnQromZOnQvkTc2e6gxbDZ
 oxomXkIuTIu20SvCBxex1AqIDs1QcglN4vxnYQy6geqAASJwf7vdoA0p+fE9sOESeycDf716sKx
 e
X-Gm-Gg: ASbGnctKMwX59/oBvGMzPhxXBXf8YbbhoUjkX5URIDh/7AiiD2l9RbnJ2N5ytxAJCdq
 PrxHqY5DcXah5jsHg00COollEsRShE+m6j5KdVzKGxsJb32uh7kIVonF/Pz6hp9T7SnxFrH1xik
 BX6Gb8l7YGgVgW0kg/v8Arrza5bd5QGxJNdmfs3VIXzksSytRmjnf4OpZGpW7i6w9RL+2+FCEhi
 XWpjOjlqwmPWE6FQRNwTua7zC7pVOnu6mIE+MThJ7xnLtc+sU0mVjxtrDVjqc+2vYlvDQbruZ8Q
 5tPS95pDVe5xFj/WbWKQGWfW8lilgkzrJvRjr06z1G0i+OR8E3lQs5FGjfmMM9LEMoQc9iCXqVH
 PWO2xLh4T2YTfUj/YoK+Q
X-Google-Smtp-Source: AGHT+IGtB3v6xYiXXsE4BUgKJzZcL9+D52jHr1iqxBLM+qfXC5ByYJZpApUhaZiZHhPp26FjcKrCZA==
X-Received: by 2002:a05:6000:290c:b0:3a0:8a42:e9dc with SMTP id
 ffacd0b85a97d-3a09fd7c681mr8820990f8f.26.1746542152108; 
 Tue, 06 May 2025 07:35:52 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7cbbsm14130113f8f.53.2025.05.06.07.35.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:35:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/22] hw/hyperv/hv-balloon-stub: common compilation unit
Date: Tue,  6 May 2025 16:34:57 +0200
Message-ID: <20250506143512.4315-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250424232829.141163-2-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.47.1


