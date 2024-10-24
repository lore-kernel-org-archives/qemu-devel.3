Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBFACFA451
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uZv-0001BC-R9; Thu, 24 Oct 2024 05:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZh-00017k-8s
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:15 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZd-0003lx-NG
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:12 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso886204a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763766; x=1730368566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSs6E5PwhxtwynJ2m8FxX2eodRnAG1Hfy7dip8EgKxg=;
 b=yeZpcmdOhwj17W53h6axwsMgW8F+fDR2c8XzDAcofUJ86uZ0KfaPNWUqQsgXyC1p53
 6fK+2MI6GgO6u+RaA6g8xC4PBXE3rlsebV4loByRQUbhdKNc99HFrlo4PKLrWrOB83tA
 6n1vqf+ahXWoOU0um8PqGqeak4Kq8bxeiaatHE5g4Gx5GQL7ALcf/v0NKUzHO4kMEzxy
 8scxNpzsmdHRAPZrW+fGVytoJ8EkMlN7ZgemLGGnw8qu2GHBJXWDJ9yYjNGSYiYSYfV1
 Oh6le+9ElrXiqD9+vgWQCbkFiSj4WU9A2QTriZ7yyeaKGy4SCaHjUGFy9jTbSV/snRmD
 +AJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763766; x=1730368566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSs6E5PwhxtwynJ2m8FxX2eodRnAG1Hfy7dip8EgKxg=;
 b=M1iDF2sY0ms6ada9TEeZd64umyWbyCL7YwroXZ+onY5FJI317+dxMdQ6J73sPEQHSj
 EKBU2UK7TLx3MmH9TKi8hmTAPYPSl5qbkC+fbrt2b7GJwZ/6hzWWKlwqx1bJ8ceCMvCL
 nT8UmeL7CPpbUgdmWVx8aup6QW1VEgQA53g6gwyjXk7Tnk/+j+RfFiBxO8ORfEbTbGup
 18sMf4hXy2lcZo84Jp3x6A/rMkYGXLxWvAVjVPc/NyCgjucnemY91xMu8yCynCt4Ohti
 oFgG0bLjXUG7NMy3fLO8SNxSqDyCe4lfeZyDyu+0a+ryM+J6sNcOxuO32HEHjND/6ILK
 baRQ==
X-Gm-Message-State: AOJu0Yw9Mo4MXAmt7wvYTbYzt+w8X+dPz3TEHOw53Ix33sc+XHz3v7I+
 HffgHG03TOTCXJdYueZg2d6FWklrcnlOYG8AMEeHAcuidOvbeXw57Uh0EUCVjpLTezRNkWeutc8
 Z
X-Google-Smtp-Source: AGHT+IG9uBtFWMTKPiz8U/WNl6JMpMr7oepz9omcXdtox0xpidrEs2xG87CI3NaVscY8VAcCijaLFQ==
X-Received: by 2002:a17:907:3dac:b0:a99:ce2f:b0ff with SMTP id
 a640c23a62f3a-a9abf8a4f1dmr554338466b.33.1729763766132; 
 Thu, 24 Oct 2024 02:56:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91597c10sm586570666b.200.2024.10.24.02.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 492FE5F8CC;
 Thu, 24 Oct 2024 10:56:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 03/17] MAINTAINERS: mention my testing/next tree
Date: Thu, 24 Oct 2024 10:55:49 +0100
Message-Id: <20241024095603.1813285-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

I put it under my name as there may be other maintainer testing trees
as well.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-4-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index c3bfa132fd..ef1678a1a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4080,6 +4080,7 @@ Build and test automation
 -------------------------
 Build and test automation, general continuous integration
 M: Alex Bennée <alex.bennee@linaro.org>
+T: git https://gitlab.com/stsquad/qemu testing/next
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Thomas Huth <thuth@redhat.com>
 R: Wainer dos Santos Moschetta <wainersm@redhat.com>
-- 
2.39.5


