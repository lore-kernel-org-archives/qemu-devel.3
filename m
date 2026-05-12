Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDF0CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgZp-00013s-1I; Tue, 12 May 2026 02:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZI-0007my-7e
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZG-0007Yr-O8
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso46688275e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567169; x=1779171969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GBwY68KBHjdUL+kWpOv25D8sxw9nSd20K5nVKVPHL7Q=;
 b=mK/W2JlRNPblFkQYd1AUUvRbm8swokFCs/1wgUHIPxRiRa8WJGVUd/9E6JIE/vrqoM
 0jnriUI09X8WqFUXGyFZaBMaT0ZSop6EzTw0WXcmmULaPPSTxuVPcw9oAdv20u97mDrN
 e7xb216w7BkUp6ZQoGZNCjs3U4e6JT3jpw7AJeeITJefsbESJNMDy6Bsy/a3TUVUJDTV
 9MiZAvpjIyTHbtXJe/rIhqQg0eFHEJiPhOfyocf/ELn97H0LdjI+MgOoq1t6NTyGNKjD
 FoGl0dRtRzV909vvdRVwa9MKepV/VMre0C0N1DGynT8sLV9Lp37sAJDlG0xP3lmaOPJF
 kltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567169; x=1779171969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GBwY68KBHjdUL+kWpOv25D8sxw9nSd20K5nVKVPHL7Q=;
 b=dD0mDIE13YcC49qLUavkbNFimRUWvZMqiiBauhOELjZqZ0PIzL4UDQIG5a3JSp3iTH
 TfA6015eTQK5U83dMN0D/VrwJFl1g3ztbMgByGgBajSo2ouiDyjjRqVRHO0hODaV3aE0
 cdUMXdo0miE/H22yHvO6pmtiyQdsDvVCTmkI4Xcgu8mMi7tOBmKHR5V5rv/vPUZZePMu
 hbbUsW+uquO6WxmokOQ49X2t+kyIfWeg33fYPQwb8acE14Qst+PhZOCmUYrKVFuatiUk
 4h1QR7aK8Z8uvOwygEbWZ4qdvOOOWjpX6azCVdYBS9fjB4nP0B+8zELDyyF86cpjXJ1r
 5lgA==
X-Gm-Message-State: AOJu0YxUf8N0VzYEAy2W2f1noJXHzrVy/z/FQ0eL8hd9CrnOWyKYisDd
 UVPYKrbp55iwtUQaom7nii0BmOPsbkb2fTUH+FCGZg/dGSfCT4tVs3fr8Pnkt3hFiv/Z/tmIeeE
 t4WeR8ew=
X-Gm-Gg: Acq92OHXHn3tKZFyZmjeKngOWe6gAUbF7OY3BCtvNl9wkjkkqnUKokRKTyyTKk01pmg
 ytoRRKDVOtTDpGO051NmNZ29aEp7u1A9tynW+ZcdGln7i8JgUDy1xBRO3+pQe9GxvL2VeNm+eMb
 yipnBXoAo5LrtnK8esZrbUa9Nbj2EjFAXOmhFnr2qwMOAW/TD7Bp6ayAdmlKOzwbJ60kSUxzjZi
 8NrnRC2kLtSex9jt/W543XlWCUsRkGbOpBpmlyKj88BEezJegZ2Yn5NUlvOg+wjkWcs3vL163od
 KhXgj4sjQqRCPlHkUBZlSwI7oNr1BtR1WqGCpad0UK8t6C0WZe4BiRt5NFUxkVmUmXHBIHj3KSv
 ZY0Qx3ghuRbPAdjB2ApmnLTtVV6N3nRDV7fqI/mlT4IY5DuCNgn4EOUk1Ets/0hDaiiWAphfW0k
 3a3DH9qtO7eDvbZgnH5Q216hFue7FGeZ9PonCR3k929APD+Gx5vDlwtbX49uRz0yJ5S5FiibXf
X-Received: by 2002:a05:600c:3b0f:b0:48a:7965:b943 with SMTP id
 5b1f17b1804b1-48e51f4e9admr437975765e9.29.1778567168760; 
 Mon, 11 May 2026 23:26:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f447166sm10221975e9.30.2026.05.11.23.26.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:26:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/41] net: mark struct ip6_header as QEMU_PACKED
Date: Tue, 12 May 2026 08:21:38 +0200
Message-ID: <20260512062142.67998-38-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The ip6_header is often used by network devices to examine structures in
packet data, and it's not guaranteed to be aligned. This manifests as
errors from the clang sanitizer like this one:

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/net/rocker/rocker_of_dpa.c:321:37
../../hw/net/rocker/rocker_of_dpa.c:730:33: runtime error: member access within misaligned address 0x742970fe7ecd for type 'struct ip6_header', which requires 4 byte alignment
0x742970fe7ecd: note: pointer points here
 00 00 02 81 00 60 00  00 00 00 38 3a ff fe 80  00 00 00 00 00 00 00 00  00 00 00 00 00 02 ff 02  00
             ^

Fix this by marking the ip6_header struct as QEMU_PACKED, the way we
have done to handle similar problems involving tcp_header, ip_header,
etc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260505201324.932323-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index efe270dbfe7..46dc9ed5acd 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -119,7 +119,7 @@ struct ip6_header {
     } ip6_ctlun;
     struct in6_address ip6_src;    /* source address */
     struct in6_address ip6_dst;    /* destination address */
-};
+} QEMU_PACKED;
 
 typedef struct ip6_pseudo_header {
     struct in6_address ip6_src;
-- 
2.53.0


