Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1727C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcRje-0004Hq-0a; Tue, 20 Feb 2024 10:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcRjc-0004HG-E9
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:08:40 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcRja-0003le-Qs
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:08:40 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33d01faf711so3354164f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708441716; x=1709046516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v8206/ozsFyG9qNvJzTDFGK4jzPQfnBC7XG0nswkrMc=;
 b=fPbIWhBy9Fc9ElsYmNut/BkMxFvI6yhGL++2Y/jk1VGBBcWSOTWFZk5YwFUVhj3uw5
 K718kYliqS3GexNoIKWnH9ARArXbQVQr0nL2G80VvOySDAgUH17Lwb5o0jy0iKCSJvuN
 HLvEo38zXlG49jx6LPN839vqYYgF7JGHyB4yZArw8hH8v2u/0CT9QI05A41DHl+PzM+U
 Pzl71QLdOODJlrWEu6KZBiRSEL/NTljVsl22Tp5WZSm6acQ5CMP4ha1DCWwGs0MOuCv/
 1lxc32YV4izXbGLXwo6m1REaCQKbUAjGq8ZTihPjRe/CTIdyijnyw4u3fn04PKMUY++N
 VrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708441716; x=1709046516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v8206/ozsFyG9qNvJzTDFGK4jzPQfnBC7XG0nswkrMc=;
 b=czsZJxCX+FSQx8iQCCvlDnFPrT2izVSLUV5e4q9JFbk2dLLjr/3wf6rVckdqa3Fgul
 Mcu/QUoTGC8auy9O/BZUrTezbrbwJEYScI5NHuDLhnD2/AIJ7Ur+Xkzemt5wULSelZcw
 gfPC+m3JphuG7mzErXbcYFZImzi/JdwRP7RzQgIivDq4ZRdq4IdYlOtBGOiF80t4kaZ4
 bISZUOXrvpLw2Z1vkN87qp4iDlNcFWqCp5mVTPj9na6Qw+yw8BX+66iNO3hCxPDY6TdI
 FGreaWXsDUorLPdS2aOBTmqrahFHpJZfAEA2Kcq9mZA/VwOXNf9OOk725FeZtgbCffTM
 dBTQ==
X-Gm-Message-State: AOJu0YxP4YGtLRrs1SOgGyh6MBBgIA4Ji1Phz3ZCNJ+r+8PFGBlbp/uG
 r/1miauFSrt7psQcjCDIK14dLvL4OkGRejM/XTWjysysOfXte7UXVnOhoawu0am1H17onnza0U7
 G
X-Google-Smtp-Source: AGHT+IEaODo2P3ht6IKHfOVC86erR2JVp7PnIEBIFlgShMPbnk+vhDLUz6DN0fy8RooU3vhB2I4ycw==
X-Received: by 2002:adf:e10f:0:b0:33d:509c:5692 with SMTP id
 t15-20020adfe10f000000b0033d509c5692mr4461999wrz.31.1708441716626; 
 Tue, 20 Feb 2024 07:08:36 -0800 (PST)
Received: from m1x-phil.lan (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 ay5-20020a5d6f05000000b0033d1ef15821sm13635071wrb.25.2024.02.20.07.08.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Feb 2024 07:08:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
Date: Tue, 20 Feb 2024 16:08:29 +0100
Message-ID: <20240220150833.13674-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Have s390x always deliver NMI to the first CPU,
remove the @cpu_index argument from handler,
rename API as nmi_trigger() (not monitor specific).

Philippe Mathieu-Daudé (4):
  hw/nmi: Use object_child_foreach_recursive() in nmi_children()
  hw/s390x/virtio-ccw: Always deliver NMI to first CPU
  hw/nmi: Remove @cpu_index argument from NMIClass::nmi_handler()
  hw/nmi: Remove @cpu_index argument from nmi_trigger()

 qapi/run-state.json        |  5 +++--
 include/hw/nmi.h           | 24 ++++++++++++++++++++++--
 hw/core/nmi.c              | 24 +++++++++---------------
 hw/hppa/machine.c          |  8 +++++---
 hw/i386/x86.c              |  7 ++++---
 hw/intc/m68k_irqc.c        |  6 ++++--
 hw/ipmi/ipmi.c             |  3 +--
 hw/m68k/q800-glue.c        |  6 ++++--
 hw/misc/macio/gpio.c       |  6 ++++--
 hw/ppc/pnv.c               |  6 ++++--
 hw/ppc/spapr.c             |  6 ++++--
 hw/s390x/s390-virtio-ccw.c |  8 ++++----
 hw/watchdog/watchdog.c     |  2 +-
 system/cpus.c              |  2 +-
 hmp-commands.hx            |  2 +-
 15 files changed, 71 insertions(+), 44 deletions(-)

-- 
2.41.0


