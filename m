Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7ACC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLlA-0008Jt-Gl; Thu, 16 Jan 2025 04:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLl1-0008Ha-Vj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:44 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLl0-0000zJ-Ey
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:01:43 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2165448243fso14341685ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737018100; x=1737622900;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rZyt3Sr/avzGsaWt9TByxGl0TLamcvGp/VBc11cYqaw=;
 b=MAWxrRiD2+hvo6PGrEJRwfKXMnNQ5kH6VtxTdS1B/kKLnRvq0Y1i+lwES6hVypb2Ww
 CSUZLIG2Pd1iagyNyLLwf3kfcQISoeTNKMsYx9wNTSBiuPyn8+RSamu7fGNDqV5SvlRC
 ZKVDOwFJBhIurD9SYezGmYMHq0/qbJzIxuXG9I8QSW9ULQmObv063DEooAsGiACiwW/7
 cbz7iySGP4RkexEonbdRFVNq7qKhfgEVFQmudv81Z5hE+DRYgvUDP17miOU6tYCk2LXf
 TRQlPpn9nl378mkLdLcOaudXB3JvrOy/9RsBYDtzky0OL3Ecv1EycIAazbc0YVWzMEum
 JrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018100; x=1737622900;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZyt3Sr/avzGsaWt9TByxGl0TLamcvGp/VBc11cYqaw=;
 b=v+6+hLDcmUPyCzIrc1s8B2X9NaW+LvmjoPI1N2EMOIOG5jmtQPrqxI0YvrbrGayMJ2
 9wPjYYLwMBmv7eU4+Lduap/uILEg37hbb3V2rhjMVdAL0a2ubP4J1ojmLlCdZemsmWkf
 QM6O3RljTALH/OOvrIEF6ZlLd30a5OfxMENCaDT5QZAMuLbltaFQxjXfeEmLN8qm13zz
 yFfJmyw1MOYyVU4kp86sNLyXQReO1s82WRSwHTZ7CPeEoxEQNcLAcbfikCNQWOZOsr1G
 lVXikMzx3J4A52xo0WameslXCffyevLSQa60EEqeN8Wv4jzq4uh+CL91jHSvx/HYIuQf
 A/zg==
X-Gm-Message-State: AOJu0YyHFrCsPpmdsNL66OWcaCGL2w1hVWE/wYL1v9iqbHAI61Oi9o99
 /qsuU8YkCjJdzW/DQVPvikxY8XmVACNKgKuinfltt6DCTEK5j1Xr15jLzlInENc=
X-Gm-Gg: ASbGncvD3ei4LcNy+ZMSVBIR510W89YcRkkDz4E5B0Wpn1HDkv5THaBdN7lwrg+gThx
 THArc69GeTs6zf/Xa+if1zTyjCsflxs8rQQAk2sjQ+NuKP7AvYGwMRMI7fAFN2YY6OmX2GhNFpY
 95whPLxGfjLcsMtbV51QqDBJHsNc3WOEDdZiXWoWtA3KkWA16TwOKxucsc596FEegwcn+KaKYMQ
 KRVUS/8WmQOUulEJUost5cEBa5LVgzs8q27gaRG/+2mn9pPWvdkoSqlmjg=
X-Google-Smtp-Source: AGHT+IHOrYN1LbK70s50nen6RrZgOHGsWwLHNPw/EZUQf2JGTLhYN2cYy341Tkuf0NFGhZYPPE98PA==
X-Received: by 2002:a05:6a21:3286:b0:1e1:ce7d:c0cc with SMTP id
 adf61e73a8af0-1e88d39caaamr54798123637.38.1737018100192; 
 Thu, 16 Jan 2025 01:01:40 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-a3199c61346sm10814518a12.47.2025.01.16.01.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 01:01:39 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 18:00:55 +0900
Subject: [PATCH v20 04/11] s390x/pci: Allow plugging SR-IOV devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-reuse-v20-4-7cb370606368@daynix.com>
References: <20250116-reuse-v20-0-7cb370606368@daynix.com>
In-Reply-To: <20250116-reuse-v20-0-7cb370606368@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The guest cannot use VFs due to the lack of multifunction support but
can use PFs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/s390x/s390-pci-bus.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 8c5eb69f7d76..c396d55c7240 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -974,7 +974,14 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         PCIDevice *pdev = PCI_DEVICE(dev);
 
-        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        /*
+         * Multifunction is not supported due to the lack of CLP. However,
+         * do not check for multifunction capability for SR-IOV devices because
+         * SR-IOV devices automatically add the multifunction capability whether
+         * the user intends to use the functions other than the PF.
+         */
+        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION &&
+            !pdev->exp.sriov_cap) {
             error_setg(errp, "multifunction not supported in s390");
             return;
         }

-- 
2.47.1


