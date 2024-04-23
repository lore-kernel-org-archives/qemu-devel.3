Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AEBC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzI1Y-0001bL-Fm; Tue, 23 Apr 2024 11:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1rzI1V-0001Sy-Vw
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:25:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1rzI1U-0003hH-1h
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:25:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4155819f710so47941235e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713885930; x=1714490730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BA4MrQSg3NiqaMN2ilw9hK0bF2FljptiE1dimU9pg44=;
 b=cMnlV+XpbiI9kHG59mYTrrynFEaKKTH5879kERcZHjHzjAzkbP+1X0YvOD7DOixmny
 oJrebLwvgAG9gM+vJIAi2F6lmA3pYkQPcceImUuWoRq7rdC0jSikXD+NniaXjilCYCHI
 4r6FzGFAa073m2+19c+RfZB2ERPF7pl4ArR+k6r1B8OyvqyikIDRHKMwLC1qDTrgar9c
 7qOLjI2gRD/Mt5iE4YIiet5iyV7TgOm/r2N+KJ/0XiYa9AIGhmCs2hKCYTSkoJ3KgT+g
 n6Z0rAO0s7tPADkTzWFEZHn37XUIfeUJ16vheQbo1QPOAbGDFNTa4t7w1tFy7+IF1z9E
 /2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713885930; x=1714490730;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BA4MrQSg3NiqaMN2ilw9hK0bF2FljptiE1dimU9pg44=;
 b=WSIoyCpzTd5TBieCxpU9VFH9hBl45WgNydpCdMJ6A1SIHGIPsGOlIWFefG1q8N3KyM
 1pCcMBXzF43xU+uU+ImaEVzr2VxSXd31B23i5KgnWjpFJ71ouzmHTazbpCwVsGSEPbRL
 8EKuH1fddcjwqzEy1T8BJAB0lBPKjuH1SsTaTkzfuGgFgy5w/x+VtHw51xnbRKjmt+L6
 Nhl3+sFwgRjYtqvsxBoWRyO7cIkRXXHNpsuE4qCxZHxpoCUjjI3ceLQ+Mt1tjUAR3Lcx
 jMznO2F7Vd2sA5BfOQOiMzFBStY6fToVlbnlJHwiK6hLSk4kifOc7Je2dmUjbszZcV0Z
 ZfbA==
X-Gm-Message-State: AOJu0YxZf2U0fVibg2jaYNIErc1z9WN9a1e6EFnEPNPi/+Y1Dpj3eW54
 c2pkMQIIEar4RUcmItnj3Gm4kNZ464i3xnNcCjFweTa+y5akxbr5CLB41CM7
X-Google-Smtp-Source: AGHT+IGteirJYfdiqfbr/Xf63avlKN+cSLq7nJ1Twlu+VnEBRxFT67ArGWMXm70uY9xqCvklYv+5GQ==
X-Received: by 2002:a05:600c:4e8b:b0:418:e2e4:a84c with SMTP id
 f11-20020a05600c4e8b00b00418e2e4a84cmr11168208wmq.30.1713885929484; 
 Tue, 23 Apr 2024 08:25:29 -0700 (PDT)
Received: from top.fritz.box (p5dd9421d.dip0.t-ipconnect.de. [93.217.66.29])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a5d6207000000b00346f9071405sm14864844wru.21.2024.04.23.08.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 08:25:29 -0700 (PDT)
From: Michael Vogt <michael.vogt@gmail.com>
X-Google-Original-From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: Michael Vogt <mvogt@redhat.com>
Subject: [PATCH] linux-user: Add ioctl for BLKBSZSET
Date: Tue, 23 Apr 2024 17:24:39 +0200
Message-ID: <20240423152438.19841-2-mvogt@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=michael.vogt@gmail.com; helo=mail-wm1-x333.google.com
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

Tiny patch to add the ioctl wrapper definition for BLKBSZSET.

Signed-off-by: Michael Vogt <mvogt@redhat.com>
---
 linux-user/ioctls.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index d508d0c04a..3b41128fd7 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -102,6 +102,7 @@
      IOCTL(BLKRAGET, IOC_R, MK_PTR(TYPE_LONG))
      IOCTL(BLKSSZGET, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(BLKBSZGET, IOC_R, MK_PTR(TYPE_INT))
+     IOCTL(BLKBSZSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL_SPECIAL(BLKPG, IOC_W, do_ioctl_blkpg,
                    MK_PTR(MK_STRUCT(STRUCT_blkpg_ioctl_arg)))
 
-- 
2.43.0


