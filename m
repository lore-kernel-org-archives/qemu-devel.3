Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC38C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfICX-0000xy-R7; Wed, 28 Feb 2024 06:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICW-0000sY-GL
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:16 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICU-0007Es-Rz
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:16 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dca8b86ee7so27209125ad.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120052; x=1709724852;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vwQMc7eTDkdxhjLzMvuMnyMxWvXIcpUjn8IJsLlj/Nc=;
 b=o61frJ7dajGf6xP11TlaXAdNxT0YhKoYXCX5dNIOpzdLy7fj4rJWZGIoEi0cM/lWor
 d62unzaf/I5xepw9+GbbpJWtm6xEOvaJX0Ygm3oZ4FOLNDJuvekPEQD7uJgQvNf1M6jZ
 di6tjYPhtnDFJHvm8FV+kIA0H3PzriMRNuPosgD5h3+F+ft7Z9NbDPI3tJHl3lSjrI1M
 qzHco1MLV68maiXTSMVPjmwcEEUhq6zQJyXzq+owrzbZ/BexqSSuUS2C5c85BWD8ULpt
 ap7T6zk1MqBreSxaZXbQEFGrTHU3EAoe/fPe/yjSy69xYpAx9goZHsVGHhCJ/deJyRa6
 xwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120052; x=1709724852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwQMc7eTDkdxhjLzMvuMnyMxWvXIcpUjn8IJsLlj/Nc=;
 b=cz0LBvub7t9thoW57uNmvezxjxUgCA6OjEVZ0gEH/1SlhE8iaqJlOrv1K//uGt9sEG
 CK9WNiccD2HRsCogs7qBUY26SVv4hykaanY8anqTuLc15QDesvMhOyUKV93nBaQWlvVF
 cTYkJgWWh4Pm1PgFXrSjkHD8eeSpejoU6bNCsVDma+jn+vPCYQ9VSvfm6ESWG3ssSftu
 6fd+EvNOTOW0PV8dbvE/PTBpFEVlXliow8SCChxF94hdHclYBkv18Pi05pk4WM6HTWol
 sccZsZ/8q+7JcCH1i68XnahpColPs3fbWKu981/XHEBdTMcUzt+sYQXxYT+5+BNpszDb
 tXSA==
X-Gm-Message-State: AOJu0Yz1AG+TnqG84nhI3jXkOTpdkFE1OGJV81F11jPciItMY3jw3fcB
 UUD2IeICMTij+Wf+YfydwHFj0jQlKhH3JfdX1mEYKV89JPXG2vGByItxFeOqWPBRXiZNZNsoVFH
 n
X-Google-Smtp-Source: AGHT+IGq91bTptl/mv2TAlN4+n99Gh409tCWZaD6HuTTEiWFf/dQJ8x1aRqbo8yqgn6+hdkS8eTGNw==
X-Received: by 2002:a17:902:eccb:b0:1dc:a282:6606 with SMTP id
 a11-20020a170902eccb00b001dca2826606mr9641723plh.14.1709120052508; 
 Wed, 28 Feb 2024 03:34:12 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 bi2-20020a170902bf0200b001dcc18e1c10sm2153933plb.174.2024.02.28.03.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:34:12 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:20 +0900
Subject: [PATCH v8 09/15] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-reuse-v8-9-282660281e60@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

Release VFs failed to realize just as we do in unregister_vfs().

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index d934cd7d0e64..8710ee95b26d 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -86,6 +86,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.43.2


