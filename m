Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9DCC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfICB-0000ip-V8; Wed, 28 Feb 2024 06:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfIC3-0000c6-O3
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:33:48 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfIBw-0006mm-Qa
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:33:46 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so4279427a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120019; x=1709724819;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XAlWXKGj/Qs8kksBVXE9dWWgaRg5MiFxbRpTNiPgudE=;
 b=KQUEQMshagDzEoYZ9GG73q2nHRIlEIbIa6QJfJbbEcEobgGrt4h8YU5fqBO9xeRNTI
 gfWsyoGqg8OsOCfOKw6v/HUkEfV+9uGAQWg/Qgo9Xtm4ih5PKG0H71UPcvTdit0O+MR/
 KFkcmD108S1U6TNly1sEed8p9oNOf9g3z4DkEctII+Wq6jIyjQejsyt3iL/7dTlkSHmq
 p/i21C3toAVuhlb+IFdQW0HdAkbqNPkZzSS4zxRp6XvYWGLe8Rm9gQbWsHBlSscuBKhq
 WBEEian009EJjklzB9YinUBuyqO8avHY4vKYN2O3s/ewQ4D2Kjr8VJ4mYF7PtceD/8sQ
 yw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120019; x=1709724819;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAlWXKGj/Qs8kksBVXE9dWWgaRg5MiFxbRpTNiPgudE=;
 b=d7hLM5kO2XvEr7n61UyeRk2N/6j3L7sG9BSdXknrm7s2bzRqthGuJl0S1mioG2ixJ0
 tcUetrJIdbzfPC3LLsVs4uUy6/lGB519g1TypZ2HZJJ4idbg19p4uigxKwxn5U4UYotH
 jYwGUtnWE6qXTNJJWefflBO08WDE1S73f6xKS8nkrhW/h70Mz8etPE4icBTyOAgq+a85
 Ta/rKEuxs1usE5EITpR9Qg7AO/LWQqBYi5FQe/UuTTmhdmrrcdWkhWdICR5WTDsUQOYM
 /xqRvKzMaiMDjPaaCGTDbrhAcQuRgIy6efSgz+2lOJZiWmE255alDYf5ykp7CzU5i5CL
 uvDA==
X-Gm-Message-State: AOJu0YyzfKfZzgsrQsINTt6kLbwUoxQEjdgoAt6kEJX69X3xEq9e++bI
 H3RTVY6WI0eJZN7wqHputpNF4kWbTlU02ZgkHqFro3NlTQDc82o2cbbb8pecF0o=
X-Google-Smtp-Source: AGHT+IHUCKL+RRgnVKgUePt5+zVino+WeuA+cSJ01uo48yXZN4JQzMAr3YWGiQHX4aOj+vAGNGp9cQ==
X-Received: by 2002:a05:6a21:6315:b0:1a1:139d:bdf1 with SMTP id
 wu21-20020a056a21631500b001a1139dbdf1mr3414867pzb.56.1709120018857; 
 Wed, 28 Feb 2024 03:33:38 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 sy12-20020a17090b2d0c00b00296f4fc7e60sm1371368pjb.12.2024.02.28.03.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:33:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:13 +0900
Subject: [PATCH v8 02/15] pcie_sriov: Validate NumVFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-reuse-v8-2-282660281e60@daynix.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The guest may write NumVFs greater than TotalVFs and that can lead
to buffer overflow in VF implementations.

Cc: qemu-stable@nongnu.org
Fixes: CVE-2024-26327
Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index a1fe65f5d801..da209b7f47fd 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
+        return;
+    }
 
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
 

-- 
2.43.2


