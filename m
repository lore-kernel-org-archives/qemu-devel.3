Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FC1CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmwG-0005kU-Jr; Tue, 28 Oct 2025 12:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDmwB-0005k6-Mc
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:52:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDmw8-0006aL-RC
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:52:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-429a0d1c31aso60713f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761670358; x=1762275158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=duXUtx8IpByXEhpH/TMjxuTeIVkxc2UAHVlNdpXFF+8=;
 b=NKbapBLTMuuEVJdJJzacI7Tx9BiNbNkqXi3Q8BrumQyOtoEQ2/TS64+PF3LjriQozQ
 abqeUTa7YVYqt0WML37JAD0YncnoAK/YERZ06jhm6WuvlO0puMJefjRseCSLomSa3Nv+
 jT38PZ5KjhS8W9IEG9mtTgIa1irT9zaQ2kjBPaXWbPNCTXySijbUozCbli3/mz2FlIfB
 0Qc6K+Vl8jt2Hi0EpRTcynmetqBwNrTFwzvEoGnBzh6yVOLx0fxWOxRydvR9E3pMQHMu
 C/g0yvdswItRbyP9zVM46Crdz2waP44qogdONaR8pmveqoUyCblU7lZqTegbougKHafl
 4ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761670358; x=1762275158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=duXUtx8IpByXEhpH/TMjxuTeIVkxc2UAHVlNdpXFF+8=;
 b=D+F8UbS7eCyqGCf5993thiXn9PRrgt7ZD5HZAb0UVltGxkWMYDhsqmKwPxG4/2KBiV
 XWckyqwFmOSPA0GsI+MRnqXMNlhceSh6cNljBQTs85Nd68R72MRi7r+Nv3mQ5fCijLiH
 4/NOyqraf+Nr2ojB5DikwfS6tq9MhUvvqc9dpJke2bk8xJh6evMBASWTZPpXOmimK8Y2
 MKDrOfJa/b1xN2lYYIYOVEHRVOR2LDEhmBy6TIKm0ZTAqacGtbn3ZdUWTM4kKHSLmsmp
 jC+L3c6LPSS8T6DiSW9dht3GhKksm601MakBwSaDuAxRnd9DLEj/TGvodUN0m6RrYv2b
 UFmw==
X-Gm-Message-State: AOJu0YwdCOvQUB00oKbmgBp7lM0T9RTgbl2+J432PtwQad8brb1kxw2w
 Nu/d/gdVmND0SyrU69u+p/zD9fFAObi2axdZEOBMZSaNUolR6BHZRsXI720gbqQnI7UfIJVuk70
 Edxb9
X-Gm-Gg: ASbGncuQDJ51VwrrOr7vxPcSwG05zbW/62ROKM4d70cX/7/kDAT5KaeW4pyhHuGZToE
 uktx3ylksbfzdPqbKA31CCztCGAoS3Ljsrv3nQJ7tBaHBFM7ARAz/k/6q8j41rh8W0bLDWicIdh
 /oMDs/t6LYEq5EiafqAUPloDE3qduwc5AyBxGxYoXNCfb8EYAIk8QOZiePJw0vlUARw1cTectrL
 PTALe2anmGRsyeZIOtupFSWKXh9F8myPvBE6AOtJxRqjpgIHSxT4aiIc8YYqQDY9lQVsK8eZbUb
 apYbvtmGmuH7rBtLA9R17ALJAYb/0eSZ2o2RjHxPhEcPcRkP2gH4I5nPHGhv2AjBgm1xG2pJSEA
 G6+2r1QlyaUAar/H1LBDXRwttMXJoSjUQEU7uP78Rs3EemZ6nRKN0YebtaS4eL31Bx4X5RXBVNP
 U4FkpzpA==
X-Google-Smtp-Source: AGHT+IFleQPq9YzE/C+DENiGSpAwOXKcjuN+nus4dBFOkFMIW77zkci8w0ZiX0IABInAbcnxPmnO5g==
X-Received: by 2002:a05:6000:2001:b0:429:8912:e28b with SMTP id
 ffacd0b85a97d-429a81a8340mr3563588f8f.4.1761670357877; 
 Tue, 28 Oct 2025 09:52:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df3c7sm20909318f8f.40.2025.10.28.09.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:52:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>
Subject: [PATCH] docs/devel/testing/fuzzing: Note that you can get qtest to
 read from a file
Date: Tue, 28 Oct 2025 16:52:35 +0000
Message-ID: <20251028165236.3327658-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

It is possible to get qtest to read fuzzer reproducers from a file
rather than directly from stdio; this is useful when you want to run
QEMU under gdb to debug the failure.  Document how to do this, which
was previously only written down in the commit message for
5b18a6bf44b9 ("chardev: Allow setting file chardev input file on the
command line").

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I got bored of looking up the commit message in the git log
every time :-)
---
 docs/devel/testing/fuzzing.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/devel/testing/fuzzing.rst b/docs/devel/testing/fuzzing.rst
index c3ac084311b..c43f815f320 100644
--- a/docs/devel/testing/fuzzing.rst
+++ b/docs/devel/testing/fuzzing.rst
@@ -263,6 +263,15 @@ generic-fuzz target.
 
 - Report the bug and send a patch with the C reproducer upstream
 
+QEMU can also read the reproducer directly from a file rather than
+from standard input::
+
+    $QEMU_PATH $QEMU_ARGS -qtest chardev:repro \
+      -chardev file,id=repro,path=/dev/null,input-path=/tmp/reproducer
+
+This is useful if you want to run QEMU under a debugger to investigate
+the failure.
+
 Implementation Details / Fuzzer Lifecycle
 -----------------------------------------
 
-- 
2.43.0


