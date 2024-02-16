Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343ADC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw2E-0002Oy-MB; Fri, 16 Feb 2024 06:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw25-0001fp-8B
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:29 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw1z-0001Hl-Ng
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:05:28 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3394bec856fso1782605f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081522; x=1708686322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EY92sY1OM6q6PT81SQkKCMEQr7lGvoIEo8ukB7aXD50=;
 b=Y/ZcLL72CDJKL+5r2dO8P+wIpI7/77R3I3pQmRUqOH21HAHQjN59/1XuC0YIykgVv3
 GZ8nNUws9Sqe5zvOMTgdzr9YcCXxHLHdk4CQhx1guMtQ0SPnUHHJ7mgKPRT8Kbz0av99
 E6jGgkK2IW1uxLkQgGbyHB8C7KbTFQ0GZWtYHdGf7v2IPcX/mvWQR+ffdGteo2kk9RUz
 frb/Up2+gAy+Xf6vRXBTnr4BN6cO30tCboc4r/n4uPDSBp/7ydUDiGA7EKI2fDpQXFDE
 6CDlpj3c+B679wRIOLafXInl+Q4EgGxcpdgCq7fe/n2z7mb6Hc+OuVFk8cXLMREWRNFM
 NdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081522; x=1708686322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EY92sY1OM6q6PT81SQkKCMEQr7lGvoIEo8ukB7aXD50=;
 b=Rm0ix+0ZR2cjxdCXe85v0ForcIn/nTAHZwzJR41mzpes3Qs24nHwkYCpofXPQOUUu3
 YIF5LDdqzDB/OMkXH2O8qQyjKes4I+yAFV6F5p21kpDqY33EyeQ3o4jDgVHud8CHPQuq
 oj+DIgy8agRU0isFDOOEQc4vPKAg4dgd/WB+xjRaBZ2GOt6r/JyFg6ys914KCcgXeQeq
 djoIFfjeGANgxi16qBqqmNCW5ZLf6FlAYtI7h/Qrr7ltAtfGmyd4DzewpAou5f6QKzJR
 FqrY2sMeQPYqaD88jbDuGQN9y1xXQR1493Gu+LGR5BSGkgmBbo8U9WQfUsX1uPYW8yhQ
 p3fQ==
X-Gm-Message-State: AOJu0YyUTV7pIuqMLNWTygWR5V4UKG499dB429zX4Rgvy6cORdJT8aWr
 InBD0hk4DJ8D4svyxm4gGx259ciRaDeNoujeKXGnzVUzaK9OIPGwU1zPj7uIikVHIvUzH7H+Bq+
 c
X-Google-Smtp-Source: AGHT+IFX3LRB9nE1Kt3bjiVuGKSJ0Ca66wmm/33ndnTNcwVDid+HlwyJnTfGDpIjNrYio+Brf+PD9g==
X-Received: by 2002:adf:efd2:0:b0:33d:201f:ea9d with SMTP id
 i18-20020adfefd2000000b0033d201fea9dmr875165wrp.2.1708081521846; 
 Fri, 16 Feb 2024 03:05:21 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05600011c500b0033cf095b9a2sm1873207wrx.78.2024.02.16.03.05.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:05:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 19/21] hw/s390x/zpci-bus: Add QOM parentship relation with
 zPCI devices
Date: Fri, 16 Feb 2024 12:03:10 +0100
Message-ID: <20240216110313.17039-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QDev objects created with qdev_*new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-pci-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3e57d5faca..6d07a7b530 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -934,6 +934,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
                                 "zPCI device could not be created: ");
         return NULL;
     }
+    object_property_add_child(OBJECT(s), "zpci[*]", OBJECT(dev));
     if (!qdev_realize_and_unref(dev, BUS(s->bus), &local_err)) {
         object_unparent(OBJECT(dev));
         error_propagate_prepend(errp, local_err,
-- 
2.41.0


