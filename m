Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C76C54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoHm-0006nj-Py; Sat, 24 Feb 2024 04:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHZ-0006h5-Dx
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:25 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHX-0002ga-B8
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:20 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e08dd0fa0bso1386960b3a.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766718; x=1709371518;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hp/9hxQDBtPEY0OINim6FUiDAX4NmkB4mD/jfDe7uLw=;
 b=MxXWY0BpmXjH98bncxv9zjmr2XArF0N2TvpdpZYu4pPmq8NGWFopOONOt2EShOXk1+
 Pyx6xtvamssH0yNgJFHffWgMksG541Nd7WqtFL10L/Xz9hH5a69ei1jHoDXFg2wLplQM
 Bel7YJO4bU+ekkG8KVFIXGKW9UZ1P43IwX3DGaCRQFNO8BO/ta4WSQMlR05Airc2vYx9
 gOOLuV6v70dabn272RMe5i1vv5Dspxxk7DbowRlWaQdJJXiS3yhUUGnU/almv6voFua0
 z656uQDor0mFIeA7qUkxJpDhyiJng//TCTg3UEi5GZx10IpMoc8bpRmn/q6IXeftPP/x
 3aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766718; x=1709371518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hp/9hxQDBtPEY0OINim6FUiDAX4NmkB4mD/jfDe7uLw=;
 b=vPO8OZ/ZLuh/qfZKlZYAB68zyX7zqHaCtBNBh6dFYsaLmg0U9LwUx2Qbe4cElgi2WV
 9HMuWF9JRQS0wR9v2EyQ0S0qtmnI7rf45WmVmGPqkPREe+FcecVA4nIJQFFJmaRimdup
 YBoI0nsd0u2uQLQsMo0gBxsFtc1hLHKkYDZUfmWD3ECn7pZ3yOyBAmy+6zS7KvEmCzEE
 rSOCskFYpxz0hWlHUh3qyexPDuvlo3fdI1SCdL3JL6w8KruoupFk8kyESTRlTNiQRggW
 TmvGx2IEKJeRjbC1cTm7WGN1SdwJtPqiF3F6TiZGHz6hu2sTYGLS734GPKwP5hTwHvxy
 g1uA==
X-Gm-Message-State: AOJu0Yxc/MHQetD2Nr7K6NGrnJEWUZDIs4AU96/A5lHmbFKzoKqVQdBu
 jlHDdu2qw7T3EiZhOrmo5SKZ+npX32wI/KpVj7NK1miWbvAELcffIus3Xt5qvHo=
X-Google-Smtp-Source: AGHT+IEQLrDIGn1Em5s3sXsJbyZQpSVzNSwfVFjzO+05wpPpm5aK7A56L/jPuwvD/RtNMNxg53IJVQ==
X-Received: by 2002:a05:6a00:3c8e:b0:6e4:62f4:c58a with SMTP id
 lm14-20020a056a003c8e00b006e462f4c58amr2863476pfb.9.1708766717835; 
 Sat, 24 Feb 2024 01:25:17 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 x3-20020a62fb03000000b006e500abadf1sm435pfm.111.2024.02.24.01.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:25:17 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:39 +0900
Subject: [PATCH v7 07/16] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-7-29c14bcb952e@daynix.com>
References: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
In-Reply-To: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..8b1fd2a89ad7 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -17,7 +17,6 @@
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
-#include "qapi/error.h"
 #include "trace.h"
 
 static PCIDevice *register_vf(PCIDevice *pf, int devfn,
@@ -204,11 +203,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }

-- 
2.43.2


