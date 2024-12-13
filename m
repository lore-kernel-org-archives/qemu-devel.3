Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD8DE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB2w-0003yX-Ng; Fri, 13 Dec 2024 14:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2J-0003Gj-Cc
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:15 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2C-0006cX-KP
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:14 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71e1158fe3eso974844a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116940; x=1734721740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBuAnCPgZLHdX0sVpQB+fbM15dWtrtdAGUwOdHBBqsc=;
 b=HoNt0DaUOEkOA17O5Jr0EGkPPm+xC567V8+SQmEjcc2lQPqAZzgE+wHHEnAH0xfblT
 2FYZbKjIQXFHDuPAImQcIu1kepnpq4JfX2CfDSqO26UI5wA8IW+G4z53VEZgV6Y1pMEp
 rDr0eSfvwGW4vyLtwK6A0AiMVKOv/2Ih3vDIbn1hhmD4EOz3MsJC42qJiuO5g3gESYjQ
 tGbegkHQaHFRmIOF4o3ysGQpxbY34a4fRDGEoazXmy5POoVPV63TVHfl99rkHqW+kmgR
 sjCCf8k1Dce9CoxJaK/CDhmAfJnftsoQp3/2kSEvD42Sz4krBktEPDvagOlqrwSKmX+h
 7iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116940; x=1734721740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBuAnCPgZLHdX0sVpQB+fbM15dWtrtdAGUwOdHBBqsc=;
 b=Zstm31FmSk0eeVzVbCMv3RRYYWBFGxwSTlScPh2lKJHZFpEw5/EVELSyWy8hPgB0/n
 8I0nK7ZfY2zsiifC2A5VE11Ii5nUhfa1utUY0pKoO05V4xGoLCxLs9A46tO1QOwyHQCP
 eSYfw1uj/Wk0NUWED9RoowQeZaLhnU/pKkCpyi4SdcUHjbbU4+ShFZ38i4BGCfB9K4f3
 CvtdRzt74mf0+ckeKXEGSfL87GYRyLss8EVKmI2owjLuzHPZ7WDsac/HgH9Ih5pDJ1M6
 kKaT+YD78w2NrSWn77uWLrNtDVXBXfbK4L4iV9eY+EeC45QHTc/5Px6OenDnudkjnPt6
 dv5Q==
X-Gm-Message-State: AOJu0YzqxuT3wtun9yB4fRutI2oo4FtSFIS6aP+w2gL18Ta5GakITVlZ
 79iLOm4vCWdqw29p0hONenOYHl9njocGAq71+W0jsddjxP81XD1FGGjONKd+Sqv/KzuWgCAG9Ru
 GeKjRek97
X-Gm-Gg: ASbGncu1CzvNAo3fDxP+rcUFTdBmMFP3FcgsIOC+C3RFCm0PnpSvxlVW/vsdqJfW75I
 /FYpfMcPWxV9G5W9pdJNCUCDc839agYG9vujbx1Vf4H+c/lobz7KJ+rxVGIB8wriL6kY5cOVDIB
 w/uKWFIVmkb8SUi/30Ynnt80RyAri9pyQZzt7VJxhO9C9LTU5OSyROOFeEC2D+lgKXuLOY2vZ3L
 Wa52NITk3c5H7R3wtSSl2wONKmu2Mfzce/Pv6ZVpms2Kj5Gd4UKzMiJW64Lv3qH
X-Google-Smtp-Source: AGHT+IG4Oaa1CFMaif+EnKB8kf2kg/gBi+Er63DHsr2guVeeoIb4v5eKEHl55hIr030QigRhTnJLHA==
X-Received: by 2002:a05:6830:2a92:b0:71d:f6d3:9fd2 with SMTP id
 46e09a7af769-71e3ba3f147mr1411664a34.24.1734116940056; 
 Fri, 13 Dec 2024 11:09:00 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs),
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 18/71] hw/block/xen-block: Unexport PropertyInfo
Date: Fri, 13 Dec 2024 13:06:52 -0600
Message-ID: <20241213190750.2513964-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

xen_block_prop_vdev is not used outside the file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/block/xen-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index aed1d5c330..72cfd6893a 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -659,7 +659,7 @@ invalid:
  *
  * https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html
  */
-const PropertyInfo xen_block_prop_vdev = {
+static const PropertyInfo xen_block_prop_vdev = {
     .name  = "str",
     .description = "Virtual Disk specifier: d*p*/xvd*/hd*/sd*",
     .get = xen_block_get_vdev,
-- 
2.43.0


