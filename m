Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBA0D74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIbo-00045i-18; Fri, 23 Jan 2026 09:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbk-00043e-7r
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:57:56 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbh-0007jd-Pu
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:57:54 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1481132f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180272; x=1769785072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcUC6w9q42GWRSbYQZFcLBt0XhEmErhACAa+5VBMoN0=;
 b=Xo77A9e5P06wuxRXyj79Nume8REpNnXZXAQb7I0Z95qrZpmbkdaaDJ0wACv5mni3b4
 UuEZKsAp3S1na4wsa8kP6UQ5YcLVos0UP0EyObMuIazsdh59zBYiPJ4wkcvLfeVMKkS8
 6xW+bDLnmLhQ9mMBbWYn+dP/vZBI5VX4d2XjnDRKCjRDYKtCdiYOQB8LUEC/ti5AtQmn
 pfKbWV/4zzhZ8SbR7lQCLpcMdtVEEnmsN3GMgt2WNWuOp6zdaEVGBWAkY9J0otra6WvU
 F5+abK3aBCgb7Jwy7bfnL3Nv4RrdGIPZnlxlQZvv9ldm+m3JMuPGFdPccLiN12x7Ifdq
 Lf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180272; x=1769785072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jcUC6w9q42GWRSbYQZFcLBt0XhEmErhACAa+5VBMoN0=;
 b=fErVKlDW37bPlErLChFxgi1yHq8nrdb9+sLx7B2BNYdY3J4r9enLhDrCcEHgzUl8zd
 aCIdTPnSaI0XAKQE3Yw8QFd/rz7KwIo95by3F8sZgfyWtawXOX4BsLlf2t1IOKEdBFL9
 jj3u3ZB3Rqf0WrCGiRs5cytGCxsCeSrRablNcsHUD0Bc+leBdxg7m7PiaqxehXquiUFn
 Pn9z5EnFqKJN9BlZxUNxmfzp6UVhK2QNBy7FnNTXR/VvdRFTBjkAevIxVxbH53fRN8iy
 jFOVUXGvTT1lpzAELA1IKWRht5BH88nLJ3yt6AwYRaA7ebJQWEqu//73BNNHdw2qwrMp
 oCCQ==
X-Gm-Message-State: AOJu0YxOOGz3RbcIFDwMB2HhhULEQtdMf5Asd4qy2QJ/lanJpnLBrieZ
 A21XJa0RSGl5/MluNNFfjZTbiqlwfsSQAptMcGyOLcILWbAuDCqCxRlUWXLBfrE5maM=
X-Gm-Gg: AZuq6aITstN0B5NwbYizP/E+iB+tXUO+fgHqcOAx7AYFvE4bxQ30fPNPJxDR8/EbtFO
 heL1fTQ60X3wc77ViLe+agndxRaV2FDYXeUyQbgwKTSnz/aMSmWeJ8O41Zj0wL2XyBZEHA40NuP
 i+RgJkUNNSsKIr9K9N/9n7Eih7KtehMJtL7oLSdzP3s/jaZYtN9zi0T7/o0VxRwYRs+FLT4QG7y
 wrTK+T/OwNsZiYxjwihzRUfeGEnhULtuHaWLY8Z0BLglnKtYjferwjb992zvYvbu/rMMHTjWHJ9
 sjxayUOwRxhUnPI6gPydAe5awr/2Q45WFLbK+j3KRJtTSuxzueibLNLPHswWyCMBDbJ51MKfbbF
 7C3I07dS3ZE/7GD1aMsomZZZUAueyAsKuBQlm6lfOeKU8IvLSg1PITdKWxp83RB5gfFxN3l4He8
 zOoN43PVHzixtU
X-Received: by 2002:a05:6000:2382:b0:435:a782:8fd6 with SMTP id
 ffacd0b85a97d-435b15969a3mr5601989f8f.24.1769180271876; 
 Fri, 23 Jan 2026 06:57:51 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c01783sm7584838f8f.3.2026.01.23.06.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7DDA75F841;
 Fri, 23 Jan 2026 14:57:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 01/16] MAINTAINERS: fix missing names
Date: Fri, 23 Jan 2026 14:57:34 +0000
Message-ID: <20260123145750.1200879-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The form is Name <email> so lets fix that up before we enforce it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36a2be3ddba..392100b213b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2551,7 +2551,7 @@ F: hw/virtio/vhost-user-snd*
 F: include/hw/virtio/vhost-user-snd.h
 
 vhost-user-scmi
-R: mzamazal@redhat.com
+R: Milan Zamazal <mzamazal@redhat.com>
 S: Supported
 F: hw/virtio/vhost-user-scmi*
 F: include/hw/virtio/vhost-user-scmi.h
-- 
2.47.3


