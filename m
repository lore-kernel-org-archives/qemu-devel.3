Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F61CC4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkhaZ-0005K3-E7; Fri, 17 Jul 2026 08:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkhaW-0005Jd-G3
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:22:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkhaR-0007N1-Ra
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:22:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49544a80b9dso9875255e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784290958; x=1784895758; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=elaMbURgQuHfjGQaT8RvfXt4Fn1NOwovA7rMEp26zck=;
 b=qPvS1fz00DDrdRlQ1lYHtaFKzAHRd3X0NOjltrRGRbRYrsXMXUWxWhChz7AoH8wldL
 tGMpTt3ajNBnKIOTsREhagEC0zK1RuyojvCzaUYfDqP2cQyxN8qlCmIkYvV6f7h929ob
 nTO8uW6pmchgigu13L62i8QHVNlXBeCGBtCyRuwA/fzJrTBNwOzqrIboub9gStL52aRg
 d/jTtN9VGIVvij/tw6QwYJRLcaS0W5IC0Jjkrc/QsLpPBrKvgOeEaYJY1k9PZU3wYcHb
 J1jbVU5CCVVmKMCcmDBCnWrX5fPeCaflFmd2gvwLb67LKPoJ3uPkoNCgxk9AggswAzAi
 KJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784290958; x=1784895758;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=elaMbURgQuHfjGQaT8RvfXt4Fn1NOwovA7rMEp26zck=;
 b=hFcWyYsABMf/oR0xZBi0EXxerAuHaJ+dam+IBPTVWdhvnUNNrMLSONGQnAZwMCrTZo
 VqzwFJyOxT8J6mntcL8kJfiAEmX+7t14yEyjaJIkmXJR2eOUkeonlXV0vsYOy6MDZFEz
 fGYtmt3hdX5RoMWSzVmAQ6cDo0GNpTvewtgSqOyLSmcCpgDNQ4ryroNax+pKK6kRKdK3
 2rnk2uYSvNtqs5VVF6yOHuhAlumx9JaY5RYfmycD37h0nugDRMOXjAMbW2PzdRyvDjGL
 0PszdBXAGm/wPkq2jtqY0k8ugMagpM5sERssABEo8xCgF6zNCuUDl3f//TzShCMGWBYM
 zJkA==
X-Gm-Message-State: AOJu0Yz2r+VtbLw5FFbAxulkwfyhPScnlLOrmoewwBaFH+kLk+WmI4+P
 jk6a4+8a7O5by/QYdAMxdX79e0YoHf0gkkzqobMhM7l1xTgrD8fMmPIyn6NlT7nOL1L4gaEIl32
 +YZtLfJo=
X-Gm-Gg: AfdE7clSI3chZDQqIlQbFEll1+qyzNL26jJP93zKHaxIFcq0ExLDjQ8S9UpoMPpVoQG
 Btf9ZPJCQem9j9KJOKw48TIcq6zWxvXqijGKt7cxukE7oNUawoa8TSUs6ckQZhsMiRIzdlmYeD0
 AhkEEw7YbsZVFGBFNQsTJO7Og5H6NXuy6qFPG+z3y7REyKN6NHMXQF2zvAjzg4eZyDBASfKs0W5
 RnznHrGM0Gc+BhkW+rQfOHp2APXKgONz5d4YI77b0uPUDBQjQerHW7NClcau0FOYU3aVdTsDMay
 Wv2dhNISsgQGqxx17aWpYE5ItRI/eHbh6fh9zSm4F9MAOYuRZaf5t5xOILbMkJqiHcF1LCW8fye
 BFCicH+pUETJ0M9OiGXhkdblrbtWaHSK3n+1kxPWvcxOROQ2XJ+tZZ9yNvKFyZs8tiyc=
X-Received: by 2002:a05:600c:5253:b0:493:be08:c372 with SMTP id
 5b1f17b1804b1-4954a3ed39fmr27509195e9.17.1784290958283; 
 Fri, 17 Jul 2026 05:22:38 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:819a:eb1f:262d:7641])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2f210csm48055935e9.15.2026.07.17.05.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:22:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 2/2] vfio/pci: reject invalid PCI_INTERRUPT_PIN values
Date: Fri, 17 Jul 2026 14:22:30 +0200
Message-ID: <20260717122232.468955-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715191735.2454719-1-den@openvz.org>
References: <20260715191735.2454719-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
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

qemu-kvm aborts a few seconds after starting a VM with a
passed-through GPU whose PCI_INTERRUPT_PIN comes back as an
out-of-range value: vfio_intx_enable() only guards against pin == 0
and stores vdev->intx.pin = pin - 1 with no upper-bound check. That
value later reaches pci_irq_handler()'s
assert(0 <= irq_num && irq_num < PCI_NUM_PINS) via
pci_irq_deassert() -> pci_set_irq(), aborting the process.

Legal PCI_INTERRUPT_PIN values are 0 (no legacy interrupt) or
1-PCI_NUM_PINS (INTA-INTD); reject anything else before it reaches
vdev->intx.pin, whether the out-of-range value came from a read
failure (now caught by the previous commit) or was handed back as
data by the device itself.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Alex Williamson <alex@shazbot.org>
CC: "Cédric Le Goater" <clg@redhat.com>
---

 hw/vfio/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8b8e8b6379..f14cc8e99a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -338,6 +338,11 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
+    if (pin > PCI_NUM_PINS) {
+        error_setg(errp, "invalid PCI interrupt pin %d", pin);
+        return false;
+    }
+
     /*
      * Do not alter interrupt state during vfio_realize and cpr load.
      * The incoming state is cleared thereafter.
-- 
2.53.0


