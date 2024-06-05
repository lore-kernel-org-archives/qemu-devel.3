Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250D7C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLl-0005ny-Bf; Wed, 05 Jun 2024 13:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLj-0005nE-IZ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:22:59 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLh-0003n9-Qh
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:22:59 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-681ad081695so20343a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608176; x=1718212976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pN+qsqPGpYhww4jH+ML1rz71xdlmduezi6vORxR7A4w=;
 b=g0Q5v77k3NFcbar4tVnX9Q/mBy2lRdQPsmi4UFCZc/dS3+y3PR+YwXupuZIbjSAUOB
 /Z57BF+LAgUNwYFCDwel+WzpVkmloRrNGtIwHYQ8RGDeZqz7M0sL3gZDII+alrhJXkpb
 loqRrihYD2iXaWz8wH2KKlPGZjHP20HseBEBAzwUtDPqDlJWYuSOB8JBScIZMcfNDxEF
 rynRk+iZcR9XFDWBu8xUeZ4PWDcBf72WCWZ4Xor97Z3WKVn72SmUm5Dg5sKz6bZm2KjU
 ZaHZyyc6v3EvHyLhqtbaxGnfU8os1qotrT8eArmNy1tLyVIZGGSpkyeJKTOycb0QFcSj
 OOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608176; x=1718212976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pN+qsqPGpYhww4jH+ML1rz71xdlmduezi6vORxR7A4w=;
 b=OTiINbCYgRfRMOcWpxzdSJcMrvBzgicOzzPmPz9dg0+d1YsGytNxTEE70e7oVBdxby
 Y4q7Ffuy0RZYPiOETOslAcU/EtTHvpG6gi6ws5oN6kyZ+QwT0H7XNQVg5dXNnMjsk7ON
 UQ5ZLnGFnCIao2VfQeDwHyLFSfsm4I3YvRuTueUZhRfuzh6NRpEKwEVITUX9Qr+GiDi7
 XmqYRcbKIwLy8YyJd6/Ea7TdYzKXrA4VIcq9vKq6FBYPRpzL7Nz9WxPkzFZRntCxu9Rf
 TgAj3BjK11irbD/oXzm087RqICcITi/ZhB6/fTX4xXZ941yONLl9D8AmTZHb625wadvv
 D1Dw==
X-Gm-Message-State: AOJu0YwgiK8om/dF2T4gRKsVY3PQSO7BLj1jL2iMw9ND2ht/UZdSrdKT
 2uAxCSFSLSAUbU1AaUEYxNZ9lZwU2KZJkxBk3lQGDNoSihLyIAPb+6jjKarHGFVxUJDD2Sx4g8B
 s
X-Google-Smtp-Source: AGHT+IHiR+K1+3vN80BB0OiMPveeBcNE7TyNlJWXR1DxexBZ51TZ9YIb91H3+RtCVBFlTQtqbzuURQ==
X-Received: by 2002:a17:90b:1110:b0:2c2:1372:6c81 with SMTP id
 98e67ed59e1d1-2c27db0fdeamr3395335a91.15.1717608176081; 
 Wed, 05 Jun 2024 10:22:56 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:22:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
	Michael Vogt <mvogt@redhat.com>
Subject: [PULL 01/38] linux-user: Add ioctl for BLKBSZSET
Date: Wed,  5 Jun 2024 10:22:16 -0700
Message-Id: <20240605172253.356302-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

From: Michael Vogt <michael.vogt@gmail.com>

Tiny patch to add the ioctl wrapper definition for BLKBSZSET.

Signed-off-by: Michael Vogt <mvogt@redhat.com>
Message-Id: <20240423152438.19841-2-mvogt@redhat.com>
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
2.34.1


