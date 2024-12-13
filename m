Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C01E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 20:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBuW-00065g-FN; Fri, 13 Dec 2024 15:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBuU-00064k-Sd
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:05:14 -0500
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBuS-0003YZ-Gj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 15:05:13 -0500
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844d67eb693so145423439f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 12:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734120311; x=1734725111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBYc4aQlrS1igcjODeijBs12yeJjZWYu4l53GmXO3AU=;
 b=nF9UpnHGQRIYzvkTfQvGI4ubej2z6CQfLwGd6Rud1jKdE3moGdgE4/9iYa58vhLAsa
 qOa2ywQtBNrIWe11KkQia4bk4UAmGzZ8JvjTgTXkGNgR8dChx+45kjj5awvRTbFCyuiY
 HyiX4HmhjY9nfAeqRuW+cur9H4O8yB4n1sywOdJWnTFVWsvT8FWX7GlTwV7TK332k9g6
 JzSxWm5T7vZhk9MOzUnKOJOOmxqBtayWj0gk+z2gtQOMn/V541Hjtwe21+HZvS3ex2M8
 41L3K7Xw5IPswJW2rlEpCnC/Wxw1eKsXuTE7xREMX6axGzIJsmfS9vtLTFqp9t62NU2t
 fRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734120311; x=1734725111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBYc4aQlrS1igcjODeijBs12yeJjZWYu4l53GmXO3AU=;
 b=O1/dk76Nf13OjNVmy7DvYU/ndntM0eylsmPnpP/KZ0XH8GA9fAdBHTOlD8IHMJOET/
 d2jaqgfPDHdFKsIs56DeDynto/y/ys073g+XrULQdX2Qj+bN0OjYEg19/JCQDET5W1fF
 1QuR0OMhUf/Nkl2M3uCOs2Tm+k3ePZdaslNOw3dgKxKSvxgRNVERg1s4ds+KcbP46BC3
 ofzDP7I0vFmFUL68D91GbCL/0sOJcS3D2BaDM+RuCZCa88ANb0l3giKSPPis07g6Frm2
 tjOY0xQ2xmtjzju4V3wcvMj0feCmtqISrB0o4RCMNUk3Cv8zWiVoiC7vS7Vg2+ktKgj8
 u55Q==
X-Gm-Message-State: AOJu0YwWPTO62mY6Yh1UllTMQJa16tILHEBsczKhMsRt0fEDqYyoQZCB
 ebcKgbi4sjrXxJqu4e3hwEY17Phj4ZpoGjos62WtJqu90ig3k47i85WzpIr0UgxWPKsC9qGoJeq
 j+iM61hue
X-Gm-Gg: ASbGnctNkWxye9mXyQb53vObaXmYDTaMQ2kpH2xU+Gk4Gn568JAdtUg4wVj+JlYTw5Y
 6zcYh3xBXSl3EC/GO3fhfC66IeK3xOpPjbzlpb+qGQxZ2ywfpXGCeUyMvVclLunFxKIAc1y1sda
 B+JMd8HgznOjdCD1Ryn3MgOquqU/Vy9McHiUxXVJwYu0IFHClbBQBMxa3i32HLdqDfNX2+6FzHE
 CyTN49Tcq32golGQ0/Rpc9D24TEi6a6E6BrzCu5ZTxtyQJg1ZqqqyZCourK7AJ1
X-Google-Smtp-Source: AGHT+IHzbFC26rD43dDUHbcP/ZqPJGU/b0iz9DtdzCOPQvM/wfXDFyqlMAAvMM4rdtH6/Vgioaxefg==
X-Received: by 2002:a05:6871:582b:b0:29e:4346:7fb9 with SMTP id
 586e51a60fabf-2a3ac7c1efbmr2259520fac.22.1734116956378; 
 Fri, 13 Dec 2024 11:09:16 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:09:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 23/71] hw/cxl: Constify all Property
Date: Fri, 13 Dec 2024 13:06:57 -0600
Message-ID: <20241213190750.2513964-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd35.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/cxl/switch-mailbox-cci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index 4f419443ab..3fde0f8aae 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -65,7 +65,7 @@ static void cswmbcci_exit(PCIDevice *pci_dev)
     /* Nothing to do here yet */
 }
 
-static Property cxl_switch_cci_props[] = {
+static const Property cxl_switch_cci_props[] = {
     DEFINE_PROP_LINK("target", CSWMBCCIDev,
                      target, TYPE_CXL_USP, PCIDevice *),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.43.0


