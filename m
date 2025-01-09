Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD01EE7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm4o-0001jY-5y; Thu, 09 Jan 2025 01:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm4l-0001Ye-Aj
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:27 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm4j-0003oJ-QS
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:27 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f13acbe29bso2552445a91.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404284; x=1737009084;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vnOMtN50C8qTZil8w9g4J3opxb/Gn/jEvUw3KiKXfx0=;
 b=LELfAX7SQSXUmIRYPXeJPjRuxFDRJ7qRr8BYmNHVMUPKISMG736T2nItORV55ixjKq
 JpRHF9aU3tWMvJbMDjiVAbQOOjM26xHSwfm/MeYQADzkXWdAmc77IhmdLb3W7+eNkDFT
 6kzu5CfDE30i7HdmfyjDp5SuGV3/mRBMA5Ubg0ib2jkfQvRBF5Qf1gdSpioo94mbWWJP
 TRU3doVhSPSeg7H5uXUb5VagbOkIpreVJ9OVGLB0ArLZ5MW1NTMWxlxsLde8z7oUHHkd
 F1QdRmvPWlIdkYteeKBR99/Bx/f6FwBl0c10ALiO7J+e4LsWu4rIe7A6vxRKIVe3fLVv
 YrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404284; x=1737009084;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnOMtN50C8qTZil8w9g4J3opxb/Gn/jEvUw3KiKXfx0=;
 b=qhwofS68cxylCJHDuO3biJApKcpCVJMkpt24bY16da211t3yAIiTmv9ZXHAZ8U0KCo
 /SuczXjubYGU8FTEw54KDfhueO/7542byaNkkKA3wJethYCOAygpoTOCGPs+aqw2CTb0
 IkrBDn+SMUpNt4UjpGsKSlYL3IE5YWBhwWs8We/JkKODz0svHAQBPh+O0AW5noA0uG/4
 sJFdFbvHlptRtuM+M5iLEs2Z0CnFBx6VCPvedTpnowTp7xxMS3CQrNo7tbFE2EmjsyqY
 nb4GD371rXWgPHnqCPz2KpSceW3MR0FQpCvcvLFOY68OoCrSVc481EfHPlzJlfXGObN9
 Bw1A==
X-Gm-Message-State: AOJu0YyH+x0oPUfCoG1htuywWJCag52ibL/6pcakoI2/dhooooXGqOE5
 6iIB4CFv8P9JB0nYkJIrbWZ2Yb5emvnrlcRJ1TdlleBgoeEmDv2s4/qc44MUx0F2o9xI6bR6A80
 Y0oI=
X-Gm-Gg: ASbGncu6FZKkfJdbUBCazsW1BW9/zy2YXJzDQzl3iyvXdDOiTciag0Vbrd42sCBcNYR
 G5MOdpyUouHoCYwBIaR3+NEvskCQ+DFH8WJGbimHlx5iXoVO1BOFbLzvscASZXhC30lk43myxtk
 6tciMubzZLWP0dDU4+Myfel/QkGewYvSqy2cUzOpDi5wrHSRRlAGdQtPkxUSJiALm3rFAOPHswv
 wfYZh0NrdKa2SiuvJYWaWijH0LkvoWGi/HjHRCUFXAnkO5CEtXj0tTNMns=
X-Google-Smtp-Source: AGHT+IFnil+IO1wxeRdskWvdXeL7IWAObV4bUpF6lYtxdNSnkEXs5oPE6eHuq9B5G437xnTLNm56OQ==
X-Received: by 2002:a05:6a00:3910:b0:725:41c4:dbc7 with SMTP id
 d2e1a72fcca58-72d324bedf7mr1983431b3a.4.1736404284357; 
 Wed, 08 Jan 2025 22:31:24 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72afb89fedesm26967955b3a.84.2025.01.08.22.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:31:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:55 +0900
Subject: [PATCH v19 10/14] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-reuse-v19-10-f541e82ca5f7@daynix.com>
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
In-Reply-To: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index f1993bc553c0..db087bb9330c 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -93,6 +93,8 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
         vf->exp.sriov_vf.vf_number = i;
 
         if (!qdev_realize(&vf->qdev, bus, errp)) {
+            object_unparent(OBJECT(vf));
+            object_unref(vf);
             unparent_vfs(dev, i);
             return false;
         }

-- 
2.47.1


