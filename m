Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C808F8A14C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrp-0006R5-Ux; Thu, 16 Apr 2026 05:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqk-0005JZ-Uf
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqh-0007qs-7E
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4888375f735so76911235e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331042; x=1776935842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=omt9TBIi8KQdmmfSubrv2/3PXB2C5P8lliGKMs/DCOM=;
 b=uM714uapNm0hJwrp7VmZGDJENOR14THNbJqkpCFXqTbX5crHNNFiIa3Trq297+FdTx
 Xy34a5mNEDysdPZDPYav1ET+pMY8pXoCF6eXtA2DWo9YJDMwEODHISnpObz0ny7VJK+i
 y2kqBp7aX0qE/mdy6L081Xf56fqwi/1l+DqrSeFXzPI7sN9ZJB8U30MQ1zcdlWi3zl1K
 R35yoVlL/IgCpLpDXT9V/lzwNYgg3kjXA3IBT8BUAOUYoybjGPby2/OTwrzS7slUl7qV
 3BkgslJSo0C7PXARqqn2Yxh5hqS66Re8PNJ0Pzzab4fP86Umfy0KJkoXJMkU8DKg2xRU
 63PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331042; x=1776935842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=omt9TBIi8KQdmmfSubrv2/3PXB2C5P8lliGKMs/DCOM=;
 b=cxoqnR2R4eLYyq8xsdosikXAv2xhyrS5BLjjjBLrLbZi0Oi/OdlXAMfMGjCp3vIbuz
 HLWbd4w8JQo1iGjsuV7U6KM36TCCzlDAggMwXtWbjuLj5MiZnUn1JcsTMn6FLja4dniN
 iQSH6PHkr8vOG45EDoeG6TFTJl+h49bzRU4TurlWmblywee145QiFwr4y9muV9oiIyE/
 0J7NX3VCYcBiOJ41TdemoONDw/g0Klelnvl8r8Dxix9ftx6golB3nFE8u2BZvIVaKYsj
 vG2ewy9iz8wQKhsVbxDs35CcU1n5+1Hf10b2NKE4EG/kpk/99gBUpZv+kduZkfalaSM0
 9Zkg==
X-Gm-Message-State: AOJu0YzZXmpTRINCBKRZte5oYwDERck6/WmM0hjKcBK4YuzUmonj15TR
 OGiNaCN8SwgBjdAzQzf66c0Q3sljvnxNKMm13U2GmCgbXqCpPL5xQPMyyHbdQy2nOjupHh09Ew4
 QfUpDWJU=
X-Gm-Gg: AeBDiestqPyKgioVfxfO70JvULjvAr4kIk8Z0R21dfkreHxIyiEJnvlNvpMApvlA3+6
 6Dh37dup/pzuPVZDOsAsew4F82HiKNIwXNKM8HSPg2zdOHQQ8ZsPkZRaki2tpm0JrbBIg/bXu21
 DqJqLQQwcSlX7NbdhNVBC7z4wNZTgGBUxEvTj7zRQcNXMl3djEMwijvMqSAHbqAkGugFtV+Bk0w
 kDsPsNI9gFYbrSpyLnKeoFklXfX+zt6UTWHZidLb66O+UhuCwckpi8N7ofT94KZZKsBqWtRsS8x
 5dxIaCP0gfyFYKrwZT8K8BC0OnEFl9eNP5MIaLmETw+xon4KQgNONzBnbqvJSd+FrRmgC9V/Qtp
 bf78+6D4uvYYMTH20L7FW4CCa82Aj4cgE0mSIH8s/tscTNF0yeJCu1ZAAgcFLuNZGICdOLSY91N
 IbGP4Q9HmGtCBgE3GbGzzh4sMipdzrMamIFBxs3ajD9AeXTY5B+uO0vNp3Aa8mdrpJYq9xZX04O
 DLemM2wbamCddKmBHiITjbd/l3472CI/q6H7kApEg==
X-Received: by 2002:a05:600c:a109:b0:488:b239:77ec with SMTP id
 5b1f17b1804b1-488d683d510mr247467985e9.17.1776331041745; 
 Thu, 16 Apr 2026 02:17:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/28] MAINTAINERS: Remove Yanan Wang
Date: Thu, 16 Apr 2026 10:16:51 +0100
Message-ID: <20260416091654.316158-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 043d26b0c4..ca64361b24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2006,7 +2006,6 @@ F: docs/system/i386/nitro-enclave.rst
 
 Machine core
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
-R: Yanan Wang <wangyanan55@huawei.com>
 R: Zhao Liu <zhao1.liu@intel.com>
 S: Supported
 F: hw/core/cpu-common.c
-- 
2.43.0


