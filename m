Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B02BCDDE6A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uZx-0001BI-M2; Thu, 24 Oct 2024 05:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZn-00019f-0r
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:19 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZk-0003oo-60
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:18 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a6b4ca29bso73774666b.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763775; x=1730368575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhQHhqHevFKxT3wc53Jhmtmk1x6HH6VYaEHocgPtTIY=;
 b=oIQ5/t3lKl2bjVlc03tsKAuFZq/vICRqO6/Ccy8ScjVVcDXsUglROmk3t42u++5uCW
 LHblbJ1UrvcKmyUJwY9AlIbFD/eyL2OHXx5FCmgSvL3HXvuW/tTKiho1gdzDQJKEd8f0
 +rw1OuAVllVKWIaHgmavOfmB8sRofqgttmqMBU0+RzaksQ34iKF4Ujq0VPptq+0dKEJq
 S5PU7dYV4Jzl+fnFGuahlYRT1KWMu+DY2s1yEXePSe1kHGFcmFoT6GXss2oNC6bnLRM/
 vSnRKR5qnThJCwnS2ORNxkrvDCCrj7InbVoT2Usw6Og8opL/0REEWY+MPcyEEz8qLZhu
 xt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763775; x=1730368575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhQHhqHevFKxT3wc53Jhmtmk1x6HH6VYaEHocgPtTIY=;
 b=avphdvWLp2B61p/kwkODuCQ/FYkTJ/TpyPMtVOCHT7/+EssFmMy7TE7bRPjHygnOjM
 SFCBk0ahG/2FHlukV3/dhOlSOk/lgt49z3m2qP6rtb6I3lgy2lTxxo5TWtgbIm6Z0jHw
 qHs7zw2p2zUHTowYVFhTmj8414nBo4kSD2ORrrL/xbEdsKPhdo2wMQGV/OBb6iSC58Pk
 pEK7izQpOF6ucsWG7Pg1K7XcRmgWuTJmy4WYYjlbXySYdqzFQuRl/lC35DGDbzkxJn6C
 Cx1ZYJjBfEBPW4nUE/tSTTKvXf+q6RlJrTPVy+DuqYBGkkwlhPnZlpvkA8haSDnxaPfK
 Tz0Q==
X-Gm-Message-State: AOJu0YyY3Ln1g1hJbrq1t00SkHPPr8piBTtuc6V/aFD2Sf4MutQjlVZS
 QF9TzBCevVVy5pib891vmmxWzKkW4uILIXQwFRBkJH65K1bjeJym/sqYTgDImdk=
X-Google-Smtp-Source: AGHT+IGp9X2kKIjWNxGXRtVWNZ/XN4045hxggZ7+x5tHr0FmH9J7a+QEALpb0GCGMsktJR465maIEQ==
X-Received: by 2002:a17:907:7290:b0:a9a:478:2ee3 with SMTP id
 a640c23a62f3a-a9abf92f3b4mr516951566b.40.1729763774607; 
 Thu, 24 Oct 2024 02:56:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91599362sm594433766b.197.2024.10.24.02.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F381D5F9EC;
 Thu, 24 Oct 2024 10:56:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/17] MAINTAINERS: mention my gdbstub/next tree
Date: Thu, 24 Oct 2024 10:55:57 +0100
Message-Id: <20241024095603.1813285-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Make it easy for people to see what is already queued.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-12-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index ef1678a1a8..7eea7b7954 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2984,6 +2984,7 @@ F: gdb-xml/
 F: tests/tcg/multiarch/gdbstub/*
 F: scripts/feature_to_c.py
 F: scripts/probe-gdb-support.py
+T: git https://gitlab.com/stsquad/qemu gdbstub/next
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
-- 
2.39.5


