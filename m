Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D578CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 07:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTcbp-0005Zl-Qq; Tue, 16 Jul 2024 03:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbo-0005RS-43
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:24 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbm-0006U5-Hp
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:23 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-25d6dd59170so2313453fac.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 00:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721114898; x=1721719698;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w42/OqwS4II2qccuVnDqy8/Gc/+eGYKSCH7VXQRvu8k=;
 b=RZjd9wzOCaYgAUqCDPHgD9wPnvCLel0ipzvtBndFLlrL6bLKVuex9DyfiOI1nHWeW/
 ZCjnu8nSi2ZwmKEl3o3Z2lrAxHkURCCrb8dwSBv6qRETMYoVeOGlm/Fm9T8Jnt1bVKet
 B2fdKVq1GNEaAMN5va4mUd/YMF5UXtfXEVSl98NSUouMW7fttKwb08JPv60RBiRlLX9c
 uKTfPj+4q+wNxoBlgpFPjuA5+oT86XDiGE10EvFeNvgWGjr3uKeGR7W/JQyjMAkN41+j
 9B0WX3tfAJ3Ur6Fih5cFZQnK2HdTi6iVATvLjFmBtaUAIAO80GIm22tSm7ZOkhJZzT5R
 apIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114898; x=1721719698;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w42/OqwS4II2qccuVnDqy8/Gc/+eGYKSCH7VXQRvu8k=;
 b=NATYTMx9W9qSCbKHsxIZfojZWjMwHUNfpQnVBmBAe+73OOljsQ/tNNEfHjTfs4nSwA
 udO6wpwN/of5sqG8NSkKdAf6BObLXA9neDM3cSTU5YM9ROUeUvx5agT6Jmr+YOWcdwF/
 DqK9OBo/5suYH2trp6zJzJP063x1KTupJjcYB595ZCddQ0cREYhcJBlsWjVXtMK2hzPn
 Et/OHlvQ107xSzafli509ZqXqiyDmiUA9ZIs5/2xMEwDz+bbjcv9tQOBEIdZzXaR+Pv9
 3GX5pd0j3T5IwRw8EHHi1bE8PPZFMVA/70rRED57yevBhtnXtdBYwKypbKiC/e3pDRPG
 c+mA==
X-Gm-Message-State: AOJu0YzhljmdMiJNmSmGfNVoixJPICAsuCAc6QA4LdHorw+oszO4YRKb
 oBN4zjlY6LA9Ki6BlSFG+RFFZDWn0IgmmBG0iXxg3Vh6i2mJMw0ze/nNI8Yl97c=
X-Google-Smtp-Source: AGHT+IFhfAECFQdPaCsZAOGXvHTpLNQ5Pol3qhCLg+VHy1L4OL/vgcxjMptxzv8PM87gQ1j4x//6aA==
X-Received: by 2002:a05:6870:d184:b0:24c:b654:c17a with SMTP id
 586e51a60fabf-260bdf97ce1mr909542fac.45.1721114897545; 
 Tue, 16 Jul 2024 00:28:17 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7ec7da24sm5586892b3a.113.2024.07.16.00.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 00:28:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 16:27:34 +0900
Subject: [PATCH v4 4/7] scsi: Use qemu_get_runtime_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-run-v4-4-5f7a29631168@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
In-Reply-To: <20240716-run-v4-0-5f7a29631168@daynix.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2001:4860:4864:20::29;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

qemu_get_runtime_dir() is used to construct the default paths.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230921075425.16738-6-akihiko.odaki@daynix.com>
---
 scsi/qemu-pr-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index c6c6347e9b6a..507f23357f6b 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -77,10 +77,10 @@ static int gid = -1;
 
 static void compute_default_paths(void)
 {
-    g_autofree char *state = qemu_get_local_state_dir();
+    g_autofree char *run = qemu_get_runtime_dir();
 
-    socket_path = g_build_filename(state, "run", "qemu-pr-helper.sock", NULL);
-    pidfile = g_build_filename(state, "run", "qemu-pr-helper.pid", NULL);
+    socket_path = g_build_filename(run, "qemu-pr-helper.sock", NULL);
+    pidfile = g_build_filename(run, "qemu-pr-helper.pid", NULL);
 }
 
 static void usage(const char *name)

-- 
2.45.2


