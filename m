Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF1FE64A80
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR8f-0000VY-PM; Tue, 03 Dec 2024 06:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8b-0000LI-SH
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:18 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8a-0000aP-7W
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:17 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53de880c77eso6361633e87.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225534; x=1733830334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oJ3H34REbMvqjovorF+2XA/kIyPhomBUF8Hcx8gznY=;
 b=f90BlEz+XsVQMef1E/SGHvUiiG3QK/7TPbfJ3QMuzcptygXsUEuCUWqtb8jNTdnzhL
 QurNL+xNRH0NJj3jJxnAYu3mUiTdXzqtogZnAG+h1+iWL7dwNWXW9hW0lst/0Y2hUwSC
 Gze8x7jikSBtZaSQiNfhhFC0sQS+cqxTSjA9nA0b68zawWWj6z9vz7MdrlGWbTbZqPk6
 fFBrUD35lkRHa1L9EIX5ca/nFogvJqEy3zPE4mtOzUafP9FEuo6uw4bZ4qlp02wqsOhr
 ouNEZQ7fkztnEATFxRGJf/eF6tNKe4f5UBfODfZb/Yg8DzF5ZKVwRcB+iFKXSkndj0/V
 p/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225534; x=1733830334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oJ3H34REbMvqjovorF+2XA/kIyPhomBUF8Hcx8gznY=;
 b=tyAIClt1o3AApg4G92azLQtYKjaECSKo+8kBi31889befJDtkckcTYQzzYrGDFUGox
 BfByVQQEJaRHZwSUJRdsRamM3HhOifQFZNEdWMEwrYkNAdKP+InGroogARdElACGGRFS
 M1GRwk8xRaSgl8fvpn1ub0AC1rteqqUfq41CYAdeR8vv8klDFRTxOENcS5WXU5cN3/qp
 9yxnuRuUbuDlgLQSAxHqV2aQggYV5TFBXtZMxf4kZeRopwr9iT1CXd1A+dvWfEwOQCkN
 9msXEM++genLW5lazNtZqnusUaxg4i/guYMy/x7A1oPT89odjICndUVDYAvitEjmdsUw
 G3Dw==
X-Gm-Message-State: AOJu0Yzl+SFuMZrXk4jRBKmj8c1z73iIRN63S9Tfk0p7v+yY/bP/eRX3
 qxLcXfRa1+uaadJSb2y8V0TJm5FM5qGH+f+HJLGIDQqqjILsQSLjTfk4xdPjYAwBiGQyimPjavz
 J9JU=
X-Gm-Gg: ASbGncvqa4eWsOQ0J4v7fOHAgrTeRuzZvxv7ISx3CjJAgvEbBe85fmmarIQaUeLbKXK
 x8MgE2Yi/qXptH10Bs7fr7sPKhJK1pQh+QAVowQhfxnXlk4E2TeEKxWFGI9sNaBjWrgeLXPwUa2
 9v2gG7ytX7Hn5w58wnfdE7MzFO5h938JCVGLZgBSLWUdvOt/11Wn+bq8joKGgs9BJO66AJsoKKB
 Wk/+jPsQpHBj4K9hXHfVFDyF10VSV54xA9rtZ/e6O3SnzXET9tA6DCqJ9B0ZKOnKekarkd0
X-Google-Smtp-Source: AGHT+IFNdN3s03OSyilShrap3bJHPlqpUz+VxnyixofSr5MSlcZTPJGvR/kmxUNN72deveUA7VjUvQ==
X-Received: by 2002:a05:6512:224e:b0:533:43e2:6ac4 with SMTP id
 2adb3069b0e04-53e12a28294mr1264949e87.49.1733225533807; 
 Tue, 03 Dec 2024 03:32:13 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74efbesm217218755e9.7.2024.12.03.03.32.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:32:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/13] MAINTAINERS: update email addr for Brian Cain
Date: Tue,  3 Dec 2024 12:31:33 +0100
Message-ID: <20241203113140.63513-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Also: add mapping for "quic_bcain@quicinc.com" which was ~briefly
used for some replies to mailing list traffic.

Signed-off-by: Brian Cain <bcain@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241123164641.364748-2-bcain@quicinc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 .mailmap    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d6194684f1..f92be047756 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -226,7 +226,7 @@ F: target/avr/
 F: tests/functional/test_avr_mega2560.py
 
 Hexagon TCG CPUs
-M: Brian Cain <bcain@quicinc.com>
+M: Brian Cain <bcain@oss.qualcomm.com>
 S: Supported
 F: target/hexagon/
 X: target/hexagon/idef-parser/
diff --git a/.mailmap b/.mailmap
index ef1b8a53f44..727ce204b2d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -75,6 +75,8 @@ Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
 Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
 Ani Sinha <anisinha@redhat.com> <ani@anisinha.ca>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
+Brian Cain <brian.cain@oss.qualcomm.com> <bcain@quicinc.com>
+Brian Cain <brian.cain@oss.qualcomm.com> <quic_bcain@quicinc.com>
 Christian Borntraeger <borntraeger@linux.ibm.com> <borntraeger@de.ibm.com>
 Damien Hedde <damien.hedde@dahe.fr> <damien.hedde@greensocs.com>
 Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
-- 
2.45.2


