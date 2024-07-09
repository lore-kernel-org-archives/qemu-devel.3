Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EE3C3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 00:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQyhc-0002p0-OX; Mon, 08 Jul 2024 20:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sQyha-0002o0-Aw
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:27:26 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sQyhX-000567-5S
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:27:26 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5c229aa4d35so2211840eaf.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 17:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720484841; x=1721089641;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iO1MV6ArlEqU8XDtVojJVdL6jozyd8gKimBqKkweKAE=;
 b=HasBjpPM8cUI0yHWPrLS8+7GmibnLuo/gHrn8wahVN4JWSHTEkBN+lcDZNc8AO8Wcy
 c4jYiBi/WYlbEeigCJJgWjrFo/sNuJ7fBSIwekelutJ/o+kQkFWpw0fyIvqZq7Fs76af
 TdakWFqmzGXAExt9LwEMEwtPENQVRiwDyI9PORWR0oyvlQGWSZ1xzj4Yes2W6NqVhEfU
 WN039AbdQm1Fy4Pr2ps+GrO4HelgabJO1S0yY3Myx87KP68WGHf7PhpdXGi1Fr14c1O2
 ZFLMqiiagD/cqB4sT6iFfTcHv/MD0qgRYak7oXiJjt5IpZufFRER6VjE4rP7aJQ7Go8z
 TvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720484841; x=1721089641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iO1MV6ArlEqU8XDtVojJVdL6jozyd8gKimBqKkweKAE=;
 b=mNInczRDf7QWb1cYfMtOxw5MVFxhyM1b9U6yXwfcDXkg22KeaicYheHTB5ONabF1r5
 64wrC7HO03ajj/oac0Zcpz50G+dL3jCGOtCuweI8ub4A0+5NQdHlek1dPN7pwV2Za1Xe
 LMl7yQQG+DZwspxAN67QkPwvGu4sHbuq4cwEpgIWm+puzVoH+DnGxY0lm2uOEjDsdSQn
 YYaw6Cf094e/UDYI3v8bevomi2C3KdKdyOkxg5FmtJYrtxB1t0Y3WxdqbllIlQHPZXye
 bQe35Oj53+db2qsBOWnlVfsX1R5EJbobtvRBWQQuC8kSpd131Sgp3i9avb7rMoRMVcKG
 RngA==
X-Gm-Message-State: AOJu0YyK9Xqaoxn//rIna7QACmxEbDJTGoHFoB/LTNzA8ds79FggKAdy
 25Ckr0B/h085fVrmRCLAe20uXKY65W+wxT16UQXVFaBHV/Yd+MQ1Tv0aqdx+PSqplBoJ/JyRx2/
 FX4BmVw==
X-Google-Smtp-Source: AGHT+IE11cIGLAsvOKiTbPikAs5wTbhe69EkiefltyT4HcKOBwvRRqmznLyiAWLHkenp6s3f58J4mA==
X-Received: by 2002:a05:6359:6f8b:b0:1a6:7a35:7a1d with SMTP id
 e5c5f4694b2df-1aade12c44cmr96221755d.29.1720484840495; 
 Mon, 08 Jul 2024 17:27:20 -0700 (PDT)
Received: from localhost.localdomain ([118.114.60.207])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d5edcdeb6sm421447a12.17.2024.07.08.17.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 17:27:20 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
	yong.huang@smartx.com
Subject: [PATCH v1 0/1] Fix the overrun check of the receive ring buffer
Date: Tue,  9 Jul 2024 08:27:13 +0800
Message-Id: <cover.1720458470.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2e.google.com
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

This patch is based on the previouse version:
https://patchew.org/QEMU/c7338afab65df208772f215567f323ae9b3c5910.1720210988.git.yong.huang@smartx.com/

Some code clean was made in this patch.

Please review.

Thanks

Hyman Huang (1):
  e1000: Fix the overrun check of the receive ring buffer

 hw/net/e1000.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.39.1


