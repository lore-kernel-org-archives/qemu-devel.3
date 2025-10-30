Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E3FCCF9F7
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 01:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEHrS-0000tG-MA; Wed, 29 Oct 2025 21:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEHrJ-0000qx-0w
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 21:53:49 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEHr5-0003zF-Cf
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 21:53:48 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-340564186e0so140651a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 18:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761789210; x=1762394010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMBp5mx5hVRrEJ3mweez2X+rN4LXdCNUoPyr+hQYFtc=;
 b=hFWF224N6aO6mmfF45uMACIFLxTZN4YAdWQS1XTg+sPBVUS1GX8nRaBzCfFUAxsWtF
 tmUTEbemh5lNjsaUSZHxd+Dk0g9yhQJFWkdfBFZjV/tvCLCNBETQXEjx3SBj0FVAZ4Yp
 ImD41fxPGdXkQI72RcGpO1sBmSsewmpaBirC3kI9gJBO9ZaPFOyxTC+1CCue6beoMZUu
 YrIeMrTzYs37hnRmtfQsg7niHG4kP/faS3tk6KIfLoMdqmtth7j/hD7R/zfCIN/2S736
 yTX+KQfKv9A+7P6ESH2NuCh1x9ipkoOZqxOl6e/vhpMh3aLRBbORvJZO/oe2eeJwIQyB
 mnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761789210; x=1762394010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jMBp5mx5hVRrEJ3mweez2X+rN4LXdCNUoPyr+hQYFtc=;
 b=trbUmMA2aIpVIdRohOiZ3676Oxgq3jby59De44F9ql5lRmuB1m+r2/50vIyUDGViTB
 +ntIZeYx/+xgXeED+/imOu45rOPdqE9NInGtSqBzRaaKsk0QS3bzaYP2bw1K18HGJBqV
 mtBFdpgjZX8jQwEv54XaTH4Bnv7zMo/CNxmwLUuEuJGsuadzRQzRTgr/H1y1WIUROVvL
 n9mJDLar52iXx2GX1DRScwA2FgFm4RDGJh5ZvFb8eSAEJvZHQ7YaszdgasTrRxhVHfmF
 MSLJaDI4adUCgORi5ZTmRrG7rcYoKnJCOuoaz/WdCldhOtgxmcEezyDAyimp90H0/0lt
 uM9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe6sY4lNPCl4sV1sTx9/V18Il2lXo6E0gK/a6dIF30aUC63QBNjfR9tjpWTvTj/1h9KGNq227SE3UQ@nongnu.org
X-Gm-Message-State: AOJu0YxBGAuCaJl1bKAlO+tLOjbgBllzEfIMbxyA1oEefkrdO5acuogg
 IyHZK9FPAP+yBasXWgEB7gWjMhm/2HtnH6OypLmRb9vUyKkTRcYVXYqo
X-Gm-Gg: ASbGncumFZQ/OOxoOKXKQpVAGYJQ5Xn2qeTi2bNRcJCWFI2Ajb5iOib8iyfct3j0nG9
 EEthcwRSxUygtsqk40JTaxkLW4QCf+d2iUrnu4/IbnmrxWv0C0w0x1257doavPAC/UdfDf4PO4/
 vk4Bfvx9ZavQuK+XjuB1OBmQjwx+5GrStiUHcMfI7EJrj+u0a5YqA8WZTuhxF1iX+3srtM2X5gC
 cv+HZSLrdUgWmv/XmHgKu4hIAMbZRChEic9NkXSqctuJTPcEpbVktvJ4nc0TAlm3O90FbfaQTsq
 oV04e2CxOlUX7BeAaKVfAxiTvkqPpUXn/ZDQ27XuvK3YbBAXAHQONFzEef66PlYJ4F4rBhmrBfu
 ccrzaeNi9XsrvI2Ae1oGM3vrK/GuQ5nfnnJ8Fc0QXp74olUdw9CzEXLfJvejFEzi220v8aYILPY
 3xwvBa59cVs9VMxDsYRDXnbwGN2rmD49YTzYDjdFAgoPpPUwTXLcBWQ7hnzBvX3nqoOqvA7dgEA
 D011QjIoEsV5M/DdSk=
X-Google-Smtp-Source: AGHT+IHFDOyXv9Qj/8f3y0+aOpnd4DXd07EjgRAhJeNNlipjWFCoOQ/7nHhUmJeGkOBIH6cwFZh2+g==
X-Received: by 2002:a17:90b:3a81:b0:33d:ad49:16da with SMTP id
 98e67ed59e1d1-3403a2f2005mr4951182a91.31.1761789209702; 
 Wed, 29 Oct 2025 18:53:29 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3405089b069sm586981a91.0.2025.10.29.18.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 18:53:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: philmd@linaro.org, alistair.francis@wdc.com, vishalc@linux.ibm.com,
 qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 3/3] hw/core/loader: Free the allocated string from
 size_to_str()
Date: Thu, 30 Oct 2025 11:53:06 +1000
Message-ID: <20251030015306.2279148-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030015306.2279148-1-alistair.francis@wdc.com>
References: <20251030015306.2279148-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

The string needs be be freed with g_free() according to the functions
documentation.

Coverity: CID 1642762
Fixes: f62226f7dc44 ("hw/core/loader: improve error handling in image loading functions")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/core/loader.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 1598dca03c..e83d245202 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -153,8 +153,12 @@ ssize_t load_image_targphys_as(const char *filename,
     }
 
     if (size > max_sz) {
+        char *size_str = size_to_str(max_sz);
+
         error_setg(errp, "%s exceeds maximum image size (%s)",
-                   filename, size_to_str(max_sz));
+                   filename, size_str);
+
+        g_free(size_str);
         return -1;
     }
 
-- 
2.51.0


