Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E34E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9Wl-0005n0-Fd; Thu, 05 Dec 2024 05:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Wi-0005gl-4j
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:08 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJ9Wg-0003dK-IV
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:56:07 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7258bce5289so591971b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733396164; x=1734000964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6IjMTOhbbtnbKyiu9odYQrXzvjL175+vD8tdZJb7kU=;
 b=T1xquenMk0ZKS0Upc2mBNxF2qG0CemI5770FCwVx3lxCDVTE6GjAiv2iUtVwkxQ+6n
 yN+iqqI09f55mo7NNuyakq0s+mOX5kiVIJZdVSf3RpNuMq/1sxDUL7HNjPAi77aQFaSl
 uLwY9rc7YaoSwqUjWMzeeQVuLEZQBr7HH5rrhMjY9tK0GqIS8B09iF0ttqJExLHQptP+
 dIjFSrPa1BI0mT6EePOp/6OcgihBapRoaFwvGIoHhWHXai79J4jcLWwTSeh0pb8cE5H1
 Zj6ctg5sI6cTg1Euu4qWsEkRcoXeGumsN8lU8PS0DAng5TbXcHaoOI9xOdDY26ZL2qbW
 pKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396164; x=1734000964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6IjMTOhbbtnbKyiu9odYQrXzvjL175+vD8tdZJb7kU=;
 b=HfjQAoihUIMWM/cuqhwk3EAwOt97p5w0HjRWxLBZJfnCEPVzQJqQVjW6xOQVsBLYlY
 cZk2JP3J3eXayPZp3VE7dnUvZrzqKNOoQmFA1yeJOn2zcs0IwHUnnPioF1v9XWM89gZL
 /jFHYhZg2OC2xRru4qhkNjUKtUZDp/xx5DWGTzicAJiOcRApKGlS9ifXazy58Rj9iABu
 pptNeKPHSpsoYAUpzoHSvimdTVcNe5A57GkLNYLPd5iRd/5Txt5KhQAbNhN6lNYwnFXN
 X4oQA5Z5R64bQkGGTEJClwd4t0FIw5HT15TdKEQ93oWVuLnSbj2O9/i1xVwc1AhOiov4
 s+8w==
X-Gm-Message-State: AOJu0YydXJzj5v9N/Ig9KuSm8YCXzJuiPh0jcxEqX4SiQcyZfVpZn188
 UUOEDCXQuKgPCcHAdmkBzP+xNHU0MmG1BwDmRGqxtZ697HGc+W4WPhCcPii6vA==
X-Gm-Gg: ASbGncsyBRBjeuFqGWcEy3ZBIC4WLtY9tT+5jywdK97k6fpXKKQNMWWugETGSAxEDsA
 l/WSNCHVgaph0qz6QeMgKjE+nG/dH/X2SLGCCuXIPft7yLjsH0q9Z0/kSdC1lme3rdmMSfy4U1J
 JJmnFGiq46X0xQKSG6kJDDAr2j2I3yf0jPXovd4pyJkspy6EJGK19Vjf6Nm7xNsVl7wfHzPgpne
 jUami/JMzFB7K6MRL9T+R99K29w3ov9rCIZaNOGAW9knKoev+3uqCHG3A==
X-Google-Smtp-Source: AGHT+IEcXfPZNQpfUQWRyo13uSou100geH0MS+nU6Dr2t3NxXBPLbmhsbKoWJ5BEx4RpDEjSVrtrhg==
X-Received: by 2002:a05:6a00:2d29:b0:71e:755c:6dad with SMTP id
 d2e1a72fcca58-72587ee6365mr13408932b3a.5.1733396164621; 
 Thu, 05 Dec 2024 02:56:04 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2ca6747sm1010905b3a.149.2024.12.05.02.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 02:56:04 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 06/10] vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake
 device ids
Date: Thu,  5 Dec 2024 18:55:31 +0800
Message-ID: <20241205105535.30498-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205105535.30498-1-tomitamoeko@gmail.com>
References: <20241205105535.30498-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

All gen 11 and 12 igd devices have 64 bit BDSM register at 0xC0 in its
config space, add them to the list to support igd passthrough on Alder/
Raptor/Rocket/Ice/Jasper Lake platforms.

Tested legacy mode of igd passthrough works properly on both linux and
windows guests with AlderLake-S GT1 (8086:4680).

Reviewed-by: Corvin Köhne <c.koehne@beckhoff.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ed236f443a..49b6547776 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -86,9 +86,14 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x3e00:    /* Coffee Lake */
     case 0x9B00:    /* Comet Lake */
         return 9;
+    case 0x8A00:    /* Ice Lake */
     case 0x4500:    /* Elkhart Lake */
+    case 0x4E00:    /* Jasper Lake */
         return 11;
     case 0x9A00:    /* Tiger Lake */
+    case 0x4C00:    /* Rocket Lake */
+    case 0x4600:    /* Alder Lake */
+    case 0xA700:    /* Raptor Lake */
         return 12;
     }
 
-- 
2.45.2


