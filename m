Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBFED1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84K0-0008Sa-Ro; Mon, 04 Nov 2024 16:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Jx-0008In-9E
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Jv-0005WD-SH
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pofF4pvx4NNxLWVgauC0xOmCFfdwGb52obnY+44wiVY=;
 b=FO7xu22jclJrv2A7xhdtZ538094w0kmoxKOFngA8Et35oUYcXZFGgKl15utXabZ32peQQ1
 DS/da9BeMZZRTOA0RV3DHy5Nv+VsayQBEqZcwdEmsW4LSjqanFGnvWAmXa5OgK+k5BY0uW
 bipdUEFxNbTTCmRJCulZC+fTG3+cQDw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Dj7pYH-mNQ-RzJ21jjP0yg-1; Mon, 04 Nov 2024 16:09:06 -0500
X-MC-Unique: Dj7pYH-mNQ-RzJ21jjP0yg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d4af408dcso2149410f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754544; x=1731359344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pofF4pvx4NNxLWVgauC0xOmCFfdwGb52obnY+44wiVY=;
 b=fOCGavYHhnf0RVLLMtmNaJhukydF73eRI0itektxVAe3yrpoVRqwjGgAVq3nklJeQa
 c4BjNFLuPhSXjhXPdymRXCQGHoEwpkim1k/nM8KtUGEL2owQp8Lq7LTQ/JuPK4p9YXh9
 XF/Av4dC76n2C1P2A+QV3jgDsdEgdkGMvigpvdmgxI6v49QkQnnzZd/Q7mPZXymaFG/0
 8u75BbsOxtILRK0ag98jOtLlhpKl0E+ksNV9B4tdcWxz/PD14SwCwphoNPzXxNVu3NmH
 UOVdG5eMRCQmp+a983F2+Z+9iArgFVoaTwNL85VlhjxAuLRy/2826lZyX/rtwzUQMDeY
 JWCg==
X-Gm-Message-State: AOJu0YzxJ58vqOMiQf7bFojZe5Ar/wJZ6lpLA9US5zXUByRGzrsB8TrG
 OG/V0zrBGV04uPkH/xPixzjPQyp23uCozyWAWJQQseepbYaEV+z7WZz+bNiAbdjrO747F5ks5zM
 W63AGibMO/wrg88GtFHZ7px8KkRC5z6obJMZGSMeJ16DcQ2E/pm/mYciGuuJUTklQFmXQrMie37
 4FNi3o7dBteM3h9YuFtsZp0hDgmzENFQ==
X-Received: by 2002:a05:6000:104a:b0:37d:2de4:d64 with SMTP id
 ffacd0b85a97d-38061162c32mr22194019f8f.35.1730754544119; 
 Mon, 04 Nov 2024 13:09:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY8R5MnEzr3CIWhSoUwKBYsfvLUyOJJSlAUj4Jwu0r5UaN0b5reA1N+nWt+6e+WAJiNlcjOA==
X-Received: by 2002:a05:6000:104a:b0:37d:2de4:d64 with SMTP id
 ffacd0b85a97d-38061162c32mr22194005f8f.35.1730754543614; 
 Mon, 04 Nov 2024 13:09:03 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113dd8asm14222338f8f.73.2024.11.04.13.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:09:02 -0800 (PST)
Date: Mon, 4 Nov 2024 16:09:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 53/65] hw/cxl: Ensuring enough data to read parameters in
 cmd_tunnel_management_cmd()
Message-ID: <c0f122419fbcd1e0bf2bc2a0a3ae6410bb2cda22.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If len_in is less than the minimum spec allowed value, then return
CXL_MBOX_INVALID_PAYLOAD_LENGTH

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101133917.27634-8-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5e571955b6..a40d81219c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -151,6 +151,9 @@ static CXLRetCode cmd_tunnel_management_cmd(const struct cxl_cmd *cmd,
     in = (void *)payload_in;
     out = (void *)payload_out;
 
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
     /* Enough room for minimum sized message - no payload */
     if (in->size < sizeof(in->ccimessage)) {
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-- 
MST


