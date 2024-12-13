Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F1AE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF9a-0005D5-FU; Fri, 13 Dec 2024 18:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8t-0003kI-FF
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:23 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8m-00035a-JI
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:17 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso1229390f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132729; x=1734737529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bS7kAbsoNxuKHf2e31cMpukZsD99I4oPiyFLxXmY0js=;
 b=x2Lly9fkMM7yi/WGVNsebQRTtnJombW8F8FulBmisQE9NbQ6Z4+XFX3Zx448FxgeCD
 qw2E0cOV+YocAEYKNK6rlCERHa5O03q0aHX7ndhGIxfRxrC3MkpDMWkqon5KWuTZO23k
 qMuQNMgLLbUN1gm3tcvrzVt28FYmjdIJQhaXFnXlPutO60ueNmBun1q4B61zRy8s2PFt
 T5jKr3fNgrn4qKF4KwljD/LuJLRjX4mMo0H4fOhz5pRSDBTXMLcUxUyapZ/WSO+kgOeF
 6q5z6DraECKwZ52LLpx6YaeO7JjauR12z+G6nUNExfvHBufsJsiJZk1FKJQRMwdrTiaL
 89CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132729; x=1734737529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bS7kAbsoNxuKHf2e31cMpukZsD99I4oPiyFLxXmY0js=;
 b=QIAQ6iCwjZ/XtoYa6yOVfisIcv6kjwWuaTrZxG1c4o3KeEKg4+LvTGKJstpMyx7Y9v
 p7XBLkm+IpdR5W+HRUj5CBJqffax4OFaIRludC3Seu+dHaxKmGUI+54vLnPot9569lYV
 lOSD6D3BNOY10XvJtc2wTlisJyJ3aq/XZUR/ocDpZGG5auDvnfrumqajrbebtmIlaGqJ
 rY2MdqzOkPPA7+Eye6ucb8ycvqIAPF2OMTfsMSPXod5eC28PuOcJ5DTIYvIZ7YsnPGkw
 MPOpCexVA53yICLwv9p5RCPCTXHO7p7buW3LxLfKDBX6xyGRO52YdLYzGvLEYN+33Vzq
 Ue4g==
X-Gm-Message-State: AOJu0YwVPOcZ2j6EBRXzCQXZiGcv9sc/4tMJyM7fStUwVGeHPeRyHlae
 r9cB7o7rVegVpNU6q86Asp0OzWooskwVOt07u39GgwGmPKTny4jFRFgAlIdgAaNQg40KyOCcDxe
 LPkc=
X-Gm-Gg: ASbGncsStHXiUOm94SaTeEYMt9qxOnF9ATTch/UTdnkRew29wmM0woSmNdk92bpJhaU
 pANUP21hsdql+RMNElJXa3FWw74rAG2sShr2MB5ezbPPLkQZx/5bSmJqBQvIltUoSp6OsDviS68
 8mRpLeBJB4YatxrazgW+u/WvYrvTHRnsZ1T1R05IF17tmO5qjMJeZK0ISNWe9R48ETYLWilr5EB
 1uxkE340O1RM8moE3+s1Shddb049btC6BMUyXnHr2MEOjykHE9GdWxiPkrcPDSTMcB7R/W85q/M
 1Yn/Qw==
X-Google-Smtp-Source: AGHT+IGETfqe3F0bRqdclqecJBEKH8BSYGdlMj63wkeuGekamnOv4Ez1x2OaSpJY0C3ELH9bIQq7Rw==
X-Received: by 2002:a05:6000:4715:b0:382:49f9:74bb with SMTP id
 ffacd0b85a97d-38880ae2565mr3311619f8f.35.1734132729489; 
 Fri, 13 Dec 2024 15:32:09 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436362c7e02sm7129865e9.40.2024.12.13.15.32.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:32:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 14/20] hw/usb/hcd-xhci-nec: Remove unused XHCINecState::flags
 field
Date: Sat, 14 Dec 2024 00:30:49 +0100
Message-ID: <20241213233055.39574-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
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

Commit b9599519a01 ("hw/usb/hcd-xhci: Remove XHCI_FLAG_SS_FIRST
flag") remove the last use of XHCINecState::flags but neglected
to remove it; do that now.

Reported-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241127122812.89487-1-philmd@linaro.org>
---
 hw/usb/hcd-xhci-nec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 0c063b3697d..1a191fc7372 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -30,10 +30,8 @@
 OBJECT_DECLARE_SIMPLE_TYPE(XHCINecState, NEC_XHCI)
 
 struct XHCINecState {
-    /*< private >*/
     XHCIPciState parent_obj;
-    /*< public >*/
-    uint32_t flags;
+
     uint32_t intrs;
     uint32_t slots;
 };
@@ -51,7 +49,6 @@ static void nec_xhci_instance_init(Object *obj)
     XHCIPciState *pci = XHCI_PCI(obj);
     XHCINecState *nec = NEC_XHCI(obj);
 
-    pci->xhci.flags    = nec->flags;
     pci->xhci.numintrs = nec->intrs;
     pci->xhci.numslots = nec->slots;
 }
-- 
2.45.2


