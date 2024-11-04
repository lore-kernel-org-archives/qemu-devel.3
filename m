Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAEDD1BDC5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80Ky-00054j-Jd; Mon, 04 Nov 2024 11:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t80Kv-00052d-Pd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:53:53 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t80Ku-0004gf-Ev
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:53:53 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso394728166b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730739231; x=1731344031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h208FfcvMiJmm0tnJW7SVVNKFW7oPgnIHJ7sZhG3bV0=;
 b=z5XgqII76qwapFuUFZKeOC/o5p2Cz55HdScA6yvBWXIEfDSraCNv7jKQgeNRkVZkJP
 qBgPAiGhWVdAgdyu0GhWWN+p2+SxW/9YoHhAManrYUB9j02oo0tHZW0K4U37LKUKAYQm
 Ho06NRDVBXnJOqAog2DwgahYJ0pri97W3URmFR7uZzBN3qET5/AU+bNNZT4mDU98LzYH
 aaT8BSCA64Yze6omBUAWtBOdm0XGIu7aVn++S+slVBayRzt8ycOBRJUxTuQ1d+fpUJeH
 Sjhi6W+orsRet4lkxjm5+Gv8Q5ZPrDAXA7rdHnd9If+0gv39DYFbpJ1z+D2iYY971utN
 0USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730739231; x=1731344031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h208FfcvMiJmm0tnJW7SVVNKFW7oPgnIHJ7sZhG3bV0=;
 b=X53KpfL6heKmjEMWYIAI3+iazGAXULyLg3Gv8Z9eY23XuWh8fjE/Z9Jls1h503GhSm
 rA3kr1ONvrnnjpadFlBSFxU6R46Eg2cxGVXSwDq19H4RSJwFQAAuqALOwICe7wDr8jpT
 HmikRbKeyO2tZcTw7R4waJBkc+eCgaS99CJ4CKY3JYx79pTOFTuLzOdscA94I4RNPIGn
 IYGe+ExhuNEbIkA1lNOneDbpq8T646g0fLVAYPVjM34HRxsYl5FqYFQZTYsXwLwNmXDD
 8GrHhP6qUJdjOYQ8XKmTbDvTPy1y/ub+vFq6bUV/Vaz1TC301BKObTRPOlbTC6L68VqN
 xKDg==
X-Gm-Message-State: AOJu0Yz7FiurGoZc5VVzCiRI6gjvb5DPK2YK7IWPGRU3NZLdmTTYRkts
 l9qauJj/QDaNKx5cO9o2d04zI+bi1h9ZHUbbNidDtMGAPbK1lW9oDR8tDUoKsuM=
X-Google-Smtp-Source: AGHT+IH3ZEIcLGUd1wVWXZMoaW7KtSYQhEVEDabRv1QAnSiEO6UclTG2+QNfN8/j+ScWYl4AgaKUMw==
X-Received: by 2002:a17:906:6a1e:b0:a99:87ea:de57 with SMTP id
 a640c23a62f3a-a9e6553bc7amr1235008266b.2.1730739230667; 
 Mon, 04 Nov 2024 08:53:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16a30c7sm5090966b.41.2024.11.04.08.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 08:53:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 49D6E5F882;
 Mon,  4 Nov 2024 16:53:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/2] virtio-gpu: coverity fixes
Date: Mon,  4 Nov 2024 16:53:46 +0000
Message-Id: <20241104165348.2361299-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Hi Dimitry,

I'd already started this before I saw your email so I thought I might
as well push what I had. Feel free to review/use as a base/ignore as
you wish ;-)

Alex.

Alex Bennée (2):
  hw/display: factor out the scanout blob to fb conversion
  hw/display: check frame buffer can hold blob

 include/hw/virtio/virtio-gpu.h | 15 ++++++++
 hw/display/virtio-gpu-virgl.c  | 21 +----------
 hw/display/virtio-gpu.c        | 65 ++++++++++++++++++++++------------
 3 files changed, 58 insertions(+), 43 deletions(-)

-- 
2.39.5


