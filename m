Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9702BF8A149
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIr3-0005Jh-F2; Thu, 16 Apr 2026 05:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqY-0005Eo-Mf
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqW-0007lt-Fx
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a041eae5so57672565e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331031; x=1776935831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wbE/w4CELuOdDRf7rOVjXpo22K0a1w1B/qZrRC87LaM=;
 b=DXjEXITlpr2hrT5va7FGhgh0feH5CQvp30iVfg7lCfk5t+gSxqBE8Gg747XJrwVXXX
 mQaOsxp6ctHeQjbFk1T57B+syA3G+/CWX9omsGMUK4VR/AFlwss4wcPCvJ62gCW63cOr
 iGS9w/F1/HUJ8CnTbLNTAjErgJdveJGgxDU7fq1N9+hbflQlBJkS1rsB/fuyx/o9Fk4q
 X3y6nh6nQwN5DdH8SaFoODoNq0k0Ov5cfrdrx2f7lUCmW901aEkYSVohKE7rAYPoPyTk
 HvxOm9I3Hf7lk8Bzq4KrcmaL8i2a2PlQZ4JClmgTz+kIWZNjPQJcI3Awh23xlUXGQ8nU
 wZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331031; x=1776935831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wbE/w4CELuOdDRf7rOVjXpo22K0a1w1B/qZrRC87LaM=;
 b=lQghQOxSIUIwM5XVWzvnqOPSeEHnakfSJAcaw6QJ/eZni2zSKBT2YZzb3uY41j6+lP
 bz0/puvQ0oHZINlOEj0Y9iBcxtCqcZynnJ5qHxFiN7fgBBAESyPZZ9va4fdrwGzJiLBI
 gVjFlFMkP75lPk4vNJ0MHUTGc40UzdAlcqdIqdLOwDCZxJ967zh2Pulgro7nLyPluV3f
 mElRcRitLck5b3acrm/Zkh11aCOK9V/SxY03dRLsnb02iW1dZd9zKt/KrMWmZZ5Djne7
 +DareoyKBZu1Uv1ff8lxR/OdCXn3CPBmf6BkWiM5Eo8E0rg683SzxfrY8+jMOOJRoEcp
 v/Nw==
X-Gm-Message-State: AOJu0YzuWf6JNj3F8hw8plA+0BIi9wsQIs/TPIB+ndeUf8rhRCSaMioM
 xEefAt4eCeZk5zPfwNw2HhqZBc74Fs/avjmVfk4nujiIueS+puzXwLHHSCfgh1zf1mQ9xrKXO8C
 bGZjvvWQ=
X-Gm-Gg: AeBDieu+4kgxHHEDROBL6feI2u66TtVUQTi6ykdhCcYNbMF3i6HEmi02HEkhiHxBxpo
 TxMFbfQesGSt9RbuYnFwqtJkaWjrcWYNz4dW5Q6h9y3qKFB5g5//Qbx/IAH5Hanz55WK0+nZILv
 NKgEmM5Re/WpIFJ1ky5iMo3+yzDeslOcm8HrrFUonkUNkIALyL4qXHu50TxVDKehcBRtsdNnFo2
 IbX25yd/BM5044syfe3auR/rcgFbvqvUvj4LD31ACjAUeZwj9dd0vN+KV/opiRGNGI6cpwynvbG
 8vYRkZUUu57mHQFuZvzZxd9KFdK7a2GMKFcy+JMr0sB/b6WukPFbwq+TqCFUEp5H1jSZuoLCimQ
 SyxTNm8EUI9dpJj6svLDDa4OrH2xJQP9fMJeVq62z9HZpvUGNv6GjD5SF5mK/+JcPDswS5RMGjO
 ZLjxt09t9M7IG7a89VtV7+T5JFhD70Gn4miuN2DSFQ5iE9DeW26+uKQp4ciY7HtyJohTMsK/5Fo
 M3unBFECM+2spwpju7L/EDK2og+bL9xkN0sD9mNqQ==
X-Received: by 2002:a05:600c:3f0e:b0:485:3f72:323f with SMTP id
 5b1f17b1804b1-488d67e6973mr345882415e9.11.1776331030817; 
 Thu, 16 Apr 2026 02:17:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/28] MAINTAINERS: Remove Marcel Apfelbaum
Date: Thu, 16 Apr 2026 10:16:40 +0100
Message-ID: <20260416091654.316158-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Marcel Apfelbaum has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86e07415d0..64c97043db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1927,7 +1927,6 @@ X86 Machines
 ------------
 PC
 M: Michael S. Tsirkin <mst@redhat.com>
-M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: include/hw/i386/
 F: hw/i386/
@@ -2010,7 +2009,6 @@ F: include/hw/i386/nitro_enclave.h
 F: docs/system/i386/nitro-enclave.rst
 
 Machine core
-M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Yanan Wang <wangyanan55@huawei.com>
 R: Zhao Liu <zhao1.liu@intel.com>
@@ -2146,7 +2144,6 @@ F: hw/ipack/
 
 PCI
 M: Michael S. Tsirkin <mst@redhat.com>
-M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: include/hw/pci/*
 F: hw/misc/pci-testdev.c
-- 
2.43.0


