Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CCACAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYs7-0001cX-AX; Mon, 08 Sep 2025 06:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYs5-0001as-LN
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYru-0000v7-Rq
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWm914yPu/Z+1a+QMagwFJTO39uJw4aRXD1IlivLAnM=;
 b=D9PeABZlp5gYsyLgx85CsgwfzIbcgZ5qtnUWldyNcJ1wisrhfwh1taCyKsyYNXsxhXtQpv
 wCWosS+E76W3XYPBYKxiX1r1LM01j9vBRxN69e21DJA9m/NflqN2+GSNsClftp4IApvMNh
 4QntVa9o/Sbxl1oDwOl2MfeEoUbWss8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-oyWDSrbtPo2p0HpX4Lup7w-1; Mon, 08 Sep 2025 06:12:57 -0400
X-MC-Unique: oyWDSrbtPo2p0HpX4Lup7w-1
X-Mimecast-MFC-AGG-ID: oyWDSrbtPo2p0HpX4Lup7w_1757326376
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3df9f185b82so1902115f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326375; x=1757931175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWm914yPu/Z+1a+QMagwFJTO39uJw4aRXD1IlivLAnM=;
 b=gmJsSBHKHuWkYhNQmlqPuKouCINgRf93YZKug52I8jrYmgYo9xI5+XwehmyQjELHfv
 dDMIAAT9KkatOiS0BCHOgjcBTO+BKK0BQoO0Jy/w/a9PA7Bmx2rUELVPzML3nVR3MdRt
 8OZYR5UTbl3cDNs5yIu98C0Prlzxi4upffY9lJXVV/ukrgDdJLyYX9T2T6IVIFcgoT6z
 LbT787AMijGzT3BucGmY0ud8gdgFQW5ELenc18eL3gR2gFvLYjdZ79SR6lPAUv3+SpVu
 f8bzic1qbPiCb7zY+I4NMjrkCk475/gRXQ4yL+gH8876AyxabQNhIRkPXmSc0tQesbor
 LdXA==
X-Gm-Message-State: AOJu0Yxup00KDDjt0X/x4IbYEifdAOpdUoT+P0SvmKti/NWMwRICZCGw
 ys+uGlsWw/UXzppS5O8jmkbJpylR5mAXjR0bx6rWwGvloiaPx1gGsZfJ6m578/WYCjALoapbhzT
 Xf6moqbZFRLN8JKOVpa4AiLNom6dwFtiTIiZg2HkQdRH9NDRK3iYNIxiopuZFeZ41N30zgXK23A
 Cw9yi/skg/g1cRU0KGryBVLOSIqSAF/xQ0dGNxtFld
X-Gm-Gg: ASbGncvM3Mngp9kdYGaqla4mLt+9DybPwSP0vo21LSvbu61BpM0YDj4MuUNQ3gqVpst
 xdtSKjn9GWvXVClvYbTNFX+Aep/JBEYnNGw/dlIYF726iqy8Xx2KNBD/DsShlDTWqLHmykWKeg/
 hcx5k4WJ2GELeSg3U3ft6rcK+YQblTzE9tnzAoz05h6P+apz9C5qpV+FNPor9I6bPiRRcsMSCUt
 lDtsT8wZkuhZHf2TJri2dMiIWTwNZF2TawKiZ7rhwOrEN4Zbr0xPJHsJffHL1gFeKCHPl06dmo4
 rdscQ9Cp1cHE1R4Jli5nj/OR7oRZ97ERWkzS91YBTf5SQXPku6ShV0/rPljMyLZlvLTZRYvqzct
 rHSLlsfNxMDKK6h3Tbe+IaGJLyf/tFtzS3nBWXGzBLi4=
X-Received: by 2002:a05:6000:2f87:b0:3df:d8ea:1f87 with SMTP id
 ffacd0b85a97d-3e643c1d91fmr4919196f8f.58.1757326375317; 
 Mon, 08 Sep 2025 03:12:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN0cRRn44+j1+Hz1FyCYHnnw4S7R91ciITF4bibT4/CtfgWY7qkqPTtEg+jQK7pHrVpH1n+A==
X-Received: by 2002:a05:6000:2f87:b0:3df:d8ea:1f87 with SMTP id
 ffacd0b85a97d-3e643c1d91fmr4919166f8f.58.1757326374837; 
 Mon, 08 Sep 2025 03:12:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d1007c0dc8sm39510181f8f.53.2025.09.08.03.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:12:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 05/19] user-exec: remove cpu_interrupt() stub
Date: Mon,  8 Sep 2025 12:12:27 +0200
Message-ID: <20250908101241.2110068-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/user-exec.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 748bfab04a7..66c25fba7dd 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -46,11 +46,6 @@ __thread uintptr_t helper_retaddr;
 
 //#define DEBUG_SIGNAL
 
-void cpu_interrupt(CPUState *cpu, int mask)
-{
-    g_assert_not_reached();
-}
-
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
-- 
2.51.0


