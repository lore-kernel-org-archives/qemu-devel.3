Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D93C5B552
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQm-000721-81; Thu, 05 Jun 2025 12:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQj-0006zf-EW
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:01 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQh-0007wU-Lt
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:01 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6020ff8d51dso2171180a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140817; x=1749745617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2bAjqn2l1sYmqIqqjIVtgsfD4EifRV4UThIaUxbMJI=;
 b=k/GozYxcofK0NPUAlYIXSpSB8ArTQhrKoOAiXbZydDrInyk0xJ08VVU+y23Pv5uvmc
 D/XQJJ4ig4+5XWBRceXiNmniIMXV4tXRA38bdstN/Qz6yeI+fXzKQ19QvE2c87sL6grD
 5za7e6tPnlqS3MpBB3IJvdav4Pj/xUQaNo2TNMJEA/rPKbqK+0fyymT1IxQRju39SSUj
 Cs/RUh4U/9jntxWEjD9c7Av675fo9glh8bnW4PAQ8fvwuig6f1uscK3jqywQ9EcJBdiL
 y38sVj1L4+fWgQbCVaQHb5RH29Ujuzgj7BLcXXmS7U1qDtQsSezibQAD30vsDNrlvK7p
 rhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140817; x=1749745617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2bAjqn2l1sYmqIqqjIVtgsfD4EifRV4UThIaUxbMJI=;
 b=v9djL2OATmqnsaDXXgZXrjuu++bY4fehFOtRkURlSoYvo9ijppgb3TqQjhAYOcvL9G
 sM8frEe+ogWfgI2v+Y8cMRep9bawWymZ9VMCRtFNlq6xqccE+cHgoAizHCVPj2Nq5iS3
 A+0yv5dq/U/I+qPdTL1c+c7R6qFGW4hHH67QDvvV6wb6RWkRQ3sAm3CXN/+Nhh2Ix9M/
 kQf4dJ+80pRNCHB0y2OJWM768+eSJNtc75yrjzX3gxpHHH6WlggrO9s6n669190whbml
 B6XXRliRCIwJjU1LsquVTiRUKnajauTuXb2Q6NpWloJgNcrwGbNwvvJHlfD/D8zjvUvv
 P1OQ==
X-Gm-Message-State: AOJu0YzK+1QJuO9a8m5ywmJLcZ1JKhlF+Ay3/zagw8Keq8jWHAsYf8fh
 1qvGUQzJ+sl52ZAHi5Np8P/wc7SiWPYLPoFIk9kf3+Nu/NE63y3BvtLxOadw7QvE9iM=
X-Gm-Gg: ASbGncspzk+jVeGQ487DW9tuyFjKho1vrdph1fnNAr6ZvqfRKrPX8SrrDo2oG3DeA4m
 Ur4Ka7Ys2XWEsXN9kcCy1JSqB3X68CUS0ZYC0GLuYs/j+WNhdJq6HeGB4JzNxi2fvj/W6na7wkH
 CLC5v5XoQvHV+lnQcD32MDl2GZuFIWAVH1ZwvS+VmU1Wyen1avqVc3/8RTJXsl9ZYFstQ3NRP5D
 tb0GDnw9rlqOl8631OYzUjBYb4Rk8SEVtMf86mR+nWLpPm2ZxYUrf7JhjaoRRPYfBbQXZ9bGH1c
 x59olmHxMmqyJmZuDqKanXKInJNLK728vOw99fA/e1dyrTO1muI/OtgzRrDtKn0=
X-Google-Smtp-Source: AGHT+IFfAR18DOBFmZKJ3lz7feNTaQ+ql32aTl9zKKusJnaYcjUvLb5qf/yECxlQ+COMFaPMmhsuLA==
X-Received: by 2002:a17:907:7fa2:b0:ad8:a50c:f6cb with SMTP id
 a640c23a62f3a-addf8d5ec0amr666246966b.26.1749140817129; 
 Thu, 05 Jun 2025 09:26:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-607341e69fbsm619848a12.47.2025.06.05.09.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 092625F828;
 Thu, 05 Jun 2025 17:26:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 07/17] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
Date: Thu,  5 Jun 2025 17:26:40 +0100
Message-ID: <20250605162651.2614401-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Seeing as I've taken a few patches to here now I might as well put
myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
it is not my core focus. If someone with more GPU experience comes
forward we can always update again.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-8-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 16af37986a..7718199979 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2668,7 +2668,8 @@ F: hw/display/ramfb*.c
 F: include/hw/display/ramfb.h
 
 virtio-gpu
-S: Orphan
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
-- 
2.47.2


