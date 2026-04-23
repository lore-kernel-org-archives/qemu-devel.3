Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECA0F99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFque-0007ra-E7; Thu, 23 Apr 2026 06:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquH-0006eH-KK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquF-0002TK-EJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:36 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so5144103f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938614; x=1777543414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L+c0h+CLPgBfTzUuGx7+tZ9wXi9zIucBCy1ZZEJuP5o=;
 b=rSS+eIxC7cteMJ4jA91L4onu+mfXOJZi7ZLAXSHOAZDeK68M7Pe+TxhYfZEWyrLsUj
 EfnTl9U9/dUVr2LrJoXQy+7vWqgb88nEZ+s/xrCdPpe+ruNyq1nDcoY2nJDk0bDoquvi
 zYYijT3JnSxC3LtBvzWimpaJnd/AfaihX3AHigqZ5SCjHsr+7T0u/qxsNROfh6aqy3h3
 8Rl6LLu5OEgUAk98chrGN2QQv2Qu1WtvL/8BVBQfbqxkoNHX/eyhZtcX5b/Hy6bjSC2W
 h0XJAnasJNo2hjMQezNMJu1VFY5Y+xGD5bT5Bih9nF8cKN608JwGdjaotlzqtZMny3Cm
 w7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938614; x=1777543414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L+c0h+CLPgBfTzUuGx7+tZ9wXi9zIucBCy1ZZEJuP5o=;
 b=o5iq3pkYHDhY4eDsIKrCJ7ToVUBgfcvekctrn4gEkJdKXkk1vUuFwE5nlR85DWz0oL
 QIJC+LHg+E97UUDsR+o8B5FQhGfsX1aQM5L6wDZfKByrZD5ifKmrbuhapNjBkukx9n3p
 hxadABzQO2FvYG8dtRg8lUV7AJRAlKWCgG35NWUVMXR7mq8NPx4t4FWkazlvMuVd6pLI
 MBNWXR+RX8e4efReqoQujVtwNQEsBhZ3BPU36088TPbHIwJ8Ne2i/EQk2nTEyFU1e6qN
 sFmu+echy//Hg/ttgZZsIrGo48fPHsIgz8hamyDLf5lBuYCsU34f/iFFNa7K73TzMD3h
 gOtQ==
X-Gm-Message-State: AOJu0YxJZN+ez6Rr+dbtahu9bSgGs1EKCZraN07a2nmazODu/RMuT5SD
 qsc3eTlKDTt0URwJ64uz0l53aJ6WB2H35R5DS8zSPQboZdpXEZFYsvainWDNSJK/1f9hk7koNhW
 wScQ3
X-Gm-Gg: AeBDiettTyM76nCgM+mHIHJZA7/bt9O5gfZkHsTkhRDmQvCEDNmhHnAPL7EHx/QLE2g
 Mz7jYc8kt/S2VbtCYDDvkUzEYxlYk7j7h1cUKEKsLMxeQmMCKJmeqOdWajJsSOSlorUmEXOXqLr
 TbEdPQ/clZNFVZ5jvwByDpT9SHkOcrFA84WC7v4uM/cQpaFsyyXFX1PQRWgjoARqv2YO2FBGLyb
 ymc0QLme40DPyBv8wySxrrpBsFwiAbnO1KH75pXULbRgpdoWa7X8hMDc9aEfcFjUvi6jl1giHZX
 eYL3xzK8cvQCDqD0AL1640JXRNtcIYtoQJ1WmsaMu9xSApxXsm5qcgt3nfPTq5jQ+xhD8CbxXNv
 BRa5WB93uhXTjAGu9eSwezTRGHga/sf3BdW2Op810yPZ75JkrDTzMtOLGKnEY12fwwSsO7YQW0W
 nCriIvHp4W3noK0va23EZIOrRXZ5YmEaRsgPlxNn5Hzj6+f3jALcjR1YwbnjaW9gOPhZDRJZu5y
 yE7SWqs2Mfar6JTF+irbwi1HhAT7IiPzh4sElV2J6+cW9cPB+yZ
X-Received: by 2002:a5d:5cc4:0:b0:43f:e430:e6df with SMTP id
 ffacd0b85a97d-43fe430fc09mr28864983f8f.1.1776938613579; 
 Thu, 23 Apr 2026 03:03:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/59] MAINTAINERS: Remove Yanan Wang
Date: Thu, 23 Apr 2026 11:02:26 +0100
Message-ID: <20260423100229.2941820-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Yanan Wang has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20260416091654.316158-26-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1577e6c5c..9b3da13653 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2007,7 +2007,6 @@ F: docs/system/i386/nitro-enclave.rst
 
 Machine core
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
-R: Yanan Wang <wangyanan55@huawei.com>
 R: Zhao Liu <zhao1.liu@intel.com>
 S: Supported
 F: hw/core/cpu-common.c
-- 
2.43.0


