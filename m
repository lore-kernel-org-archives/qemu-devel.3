Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F144EC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Oza-00032g-Jm; Tue, 21 May 2024 08:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9OzX-0002yV-Ka
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:53:19 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9OzV-0005g5-JI
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:53:19 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso9774766a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716295996; x=1716900796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KJSPsg/3w1SFfOVwaOmt9sT3HJOmlmBmCmncyWEza4=;
 b=T5b/1X+4lat4zwgYphnvEg3Ke7grWp0oniZe4uU+aBP5qNdofJww/G9Ne0nJAaYrkq
 osIg2ZXGDl/E/7R67N1hngCreXlkPpky9MIXyvvs1THfTr+GRSCTpOBQALb9cxy0vtVo
 5jFWb38xAoH3m7rfp+9AoLveQDMav820rc2hb6ElPMmdrvK0+M5dZ9sgkyy6U1MQ65UH
 HLlv2Asl603ifxVJLhwR/4H+nCROLVrwqWOQCq8otJl93NpxPPYo2PE8cJdrkSAHRu/y
 GQkiFVi3y2Av+bScaMn55wjKfmpHtmqRxlxh0RQuU4trqWTZ3R2kMioQhzDyp16j08T5
 jrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295996; x=1716900796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KJSPsg/3w1SFfOVwaOmt9sT3HJOmlmBmCmncyWEza4=;
 b=Vm/er6ThH+boiDbAhhRFMUVQDY0TEiZxelqwscGWgx5mvDWp4DxpJjufk1NjhWT/Ws
 oDXgn25Aid1choIGbNcMUzgMD6HWAI1o5zqoGydvzq4i/MLX9KVgLfCdOnA8kjsAan4l
 S/OmJzW8XmQtq81+Vnj+FYgZIIoohA9Oxeu9WZUoG4RzDhRR8eP7DRe4ptIbHT4IGQ9Q
 mMMXRfEH4FV9gTF72xp47dJ1rp9xUx1eKyGH016S125EG0EGGn8pub8KxidLRtY4Q+FH
 3w5R5facx1MWxJ6xNwS3yuOGoOxm/HdSnQTI+P8sfXLGsrT8ixKQgUkh99oDCSGX+aFr
 n8SQ==
X-Gm-Message-State: AOJu0Yxci2o0rHQmJyDridrS1Ut0I9lCraSSV408RJbRmSQxNn7nN6pM
 9EF15lDemxN3RtcQ39V85uJSk+GR+cEAGKN81ldWq5xACnvZZcJdm+Bxdz43/YM=
X-Google-Smtp-Source: AGHT+IG/iCpBNlImeMZT44iU8t2TDR8Y2NtHuGoWpRgjPluULKwqXqK/U0jD2gHrxboYP4dHqoxMPQ==
X-Received: by 2002:a50:ab55:0:b0:572:7b95:7d14 with SMTP id
 4fb4d7f45d1cf-576f5c09715mr4900634a12.27.1716295995759; 
 Tue, 21 May 2024 05:53:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c2c7d3esm16607686a12.73.2024.05.21.05.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 05:53:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0ED4A5FA1B;
 Tue, 21 May 2024 13:53:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Beraldo Leal <bleal@redhat.com>, qemu-s390x@nongnu.org,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/4] tests/vm: update centos.aarch64 image to 9
Date: Tue, 21 May 2024 13:53:13 +0100
Message-Id: <20240521125314.1255403-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240521125314.1255403-1-alex.bennee@linaro.org>
References: <20240521125314.1255403-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

As Centos Stream 8 goes out of support we need to update. To do this
powertools is replaced by crb and we don't over specify the python3 we
want.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/centos.aarch64 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/vm/centos.aarch64 b/tests/vm/centos.aarch64
index 3f58de1e64..fcf9e08c87 100755
--- a/tests/vm/centos.aarch64
+++ b/tests/vm/centos.aarch64
@@ -25,9 +25,9 @@ DEFAULT_CONFIG = {
     'cpu'          : "max",
     'machine'      : "virt,gic-version=max",
     'install_cmds' : (
-        "dnf config-manager --set-enabled powertools, "
+        "dnf config-manager --enable crb, "
         "dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo, "
-        "dnf install -y make ninja-build git python38 gcc gcc-c++ flex bison "\
+        "dnf install -y make ninja-build git python3 gcc gcc-c++ flex bison "\
             "glib2-devel pixman-devel zlib-devel docker-ce.aarch64, "
         "systemctl enable docker, "
     ),
@@ -38,10 +38,10 @@ DEFAULT_CONFIG = {
 
 
 class CentosAarch64VM(basevm.BaseVM):
-    name = "centos8.aarch64"
+    name = "centos9.aarch64"
     arch = "aarch64"
-    image_name = "CentOS-Stream-GenericCloud-8-20220125.1.aarch64.qcow2"
-    image_link = "https://cloud.centos.org/centos/8-stream/aarch64/images/"
+    image_name = "CentOS-Stream-GenericCloud-9-20230501.0.aarch64.qcow2"
+    image_link = "https://cloud.centos.org/centos/9-stream/aarch64/images/"
     image_link += image_name
     BUILD_SCRIPT = """
         set -e;
-- 
2.39.2


