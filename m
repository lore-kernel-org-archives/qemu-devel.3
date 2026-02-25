Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1901FD3747
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDll-0006yR-5t; Wed, 25 Feb 2026 07:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvDlj-0006xz-95
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:13:31 -0500
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvDlh-0005V3-Lz
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:13:31 -0500
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-896ff127650so110331026d6.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 04:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772021608; x=1772626408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FcUv0YHkFe7fQDS/6iOuRrmizx0VWDUj7Vt67MUCvjY=;
 b=OEtM7KlBcZ3SWh9Ayu4E+Ehp/1Hn+w3XWhuaJEt5hJlUekxGmmTa4MhOHDxVss2dGo
 TXkvAi6WfG7t5KOYCRtIVw84QPSA6x8j4eNW6+CCgIbHZXsyOonxopnBl8orC4cEjUvL
 9ai3bT7toEoEQ34uMln+W8ggldHeFqHQIajqVadOBXMpPd7C5W7U4Rse0XPYjpFUNLtu
 rIai4EcSAmSRTEvMoKM9/l0HXG438jr0AriIdrAKUzBGyl6OoihDEmZxDAtwvQ6Q9V5A
 o5cDoDiOQY+/2WeUTDwYYaTlbWHaq2w5XdO3+xVG/LKFmz3bvvGMzUxiWZozasweuxSf
 TIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772021608; x=1772626408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcUv0YHkFe7fQDS/6iOuRrmizx0VWDUj7Vt67MUCvjY=;
 b=R2UHAWz0Xx+aJy9yqZcffexddhJckMliOSEFywQ3mIaoPdwgjVlddEarrRTIjvGd5o
 /b5j+EZM3L3r0aVSalrpeGQkpMBLkQ4a6LC1yNU/3Yj4mxhBjATwLRmZ5JQxJw9uZgAv
 3dcl1rxOCbHnTPXRaVmOnkn6ewM/YSg1ZO3CTXwBhjlfOReLdBQtukbt3/TNfXv2+IXd
 NJFirRvfjq/l7WWp2cj2boak/MdOesjo794XtYGlruN19g0L/7QZK4/73OdCLDgXXUE6
 5kABzo8WNanrylHkA9a2O60P08xetAaRML622wcvSAbaDLnUOAP2sO6IjeqS8RPHQc29
 DlhQ==
X-Gm-Message-State: AOJu0YzaNESWoB/Z59hX//iZq8tCIOhlFRsOiHvEN0ZAzEzn0SNRlJtd
 Ang792npa8bERQYo7AkjrVdZMPQiKJDY13yxz+LtI5wRbjyE+yZTPSkdEK9+bg==
X-Gm-Gg: ATEYQzyLrQdhTxshdim3fBrv+tl2hK5KfSeBVhmCPIxkt/A5qC5tB7lX5GJvDlXjT4R
 IJIyHtb405a9aCB1Ixfn9mDR5AoiGgD7xZUo4GVn0L98O8oWyvWYVRZzrVbZ+8qWf67jr7Ent1R
 Nf1zSCllb28EiguL9PjO5rNTYChkEmHtVZT5y95JPSeC0wd5BD5G/6HtdnRo3RtTRG0RLGvgJEM
 ET/FUeHQHQrjwNMswRzBVfKoV9oGbI4nN+aRwpwZKvZ0o6tw5kdIdYrhrhc8yQoBurmMtaTA2wN
 sidWkq8WX2TKSxgPLGnmyBRUWw76uB4mUVkpyFxHMRzbJxR/2vNV4JUFHpVMPALIRjGBot9wqTM
 M4Vt/n/X73EJIf5U7mFt2yj4tz17wo/rVPD6rwC5gbSOM7fwSzq0f4xvnASoQrmGCsIep4G1GKl
 mji9u9FdDQVOg9UEsB6blU99Z1DtQqkZBWDmWC3EPhzFACDDNOzMppbMeMMNIdEg==
X-Received: by 2002:a05:6214:20e5:b0:899:ad2b:4c56 with SMTP id
 6a1803df08f44-899c13fcdfbmr1613136d6.20.1772021607860; 
 Wed, 25 Feb 2026 04:13:27 -0800 (PST)
Received: from localhost.localdomain ([207.98.184.46])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997e77aedasm115830606d6.53.2026.02.25.04.13.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 04:13:27 -0800 (PST)
From: David Hamilton <dahamilt0@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hamilton <dahamilt0@gmail.com>
Subject: [PATCH v2 0/2] hw/misc/ivshmem-pci: Improve error handling
Date: Wed, 25 Feb 2026 07:13:21 -0500
Message-ID: <20260225121323.5395-1-dahamilt0@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=dahamilt0@gmail.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series addresses two error handling issues in the ivshmem
PCI device:

1. Handle the return value of kvm_irqchip_add_irqfd_notifier_gsi()
   which was being silently ignored.

2. Check for errors from setup_interrupt() in process_msg_connect()
   before continuing to ioeventfd setup.

Changes from v1:
- Made setup_interrupt() return bool per QEMU conventions (Markus)
- Simplified errp check using bool return, dropped ERRP_GUARD()
- Dropped vector number from error message

David Hamilton (2):
  hw/misc/ivshmem-pci: Handle error from
    kvm_irqchip_add_irqfd_notifier_gsi()
  hw/misc/ivshmem-pci: Check error after setup_interrupt() in
    process_msg_connect()

 hw/misc/ivshmem-pci.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.50.1 (Apple Git-155)


