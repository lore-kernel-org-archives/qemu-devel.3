Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B05CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwmA-0005Br-E1; Mon, 03 Nov 2025 10:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFwm8-0005B5-Ak
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:47:20 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFwlx-0002ip-46
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:47:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-421851bca51so3984562f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 07:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762184825; x=1762789625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hAwSv5m0SCHS7ZUiqLQkSHrP57WMiWiuegLNWilDi8Y=;
 b=E4PDAE0endaWC2bqSoySSklGcgCZnBB71abcFqBwCUCETOBdhsxZ8GohwMqXjk5Qy4
 ZXkBU8uHcsE/tH+IRsNADoY6Z7z18xiymnddWUG8bMmTtGlBNDXac74EEohmjlwxfMgt
 /aJ6cy/pWAQtPkRKTjQ0mvQYBAe34NY3bjb13sT4xAeedeObSoF5d7+UtxvMiilGRlcQ
 DinAyNf2I3sM5KJwRRHwOeGGxMSN8VCzRBgBhKxrQyCZMe1m/RiJJKKQOlE4x0qD12Ex
 /HcRFoiBwwNhZa8hqeXtXE54pQPnDv8sl4jFxsjz2MtILjpAEgnXL1PM8j+K2NRpx018
 Gu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762184825; x=1762789625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hAwSv5m0SCHS7ZUiqLQkSHrP57WMiWiuegLNWilDi8Y=;
 b=kXGieXlCoSTVjaev3YT4ACLzkM1xw7p8cjsDirN0M+vPUKfZMtG5RmuLlIkONDyV4s
 IKNWboX0ytMY1U/CFBdBa8PLIfWAx6iXjaXgk1Dwq5XRYsDlhFYA6TXNmz4d130xUb9H
 jDBJ98xYbe+FazNBhdzSfVANUvtxEZ2B1Sb4WNdUYm1NOmuIJh+u/ONW7sHCYLbz2tfv
 jx3Ofd5/p94WhFIqTHl8PvGyHwWTusK9dK0Xg11QjBEivuhakh0WdeufT3k4IK60pV1V
 Fs8bZUARIG2An4joS4qsVZh2PY3WmghgpZxbUhc856Ahsmsxoj+w9+PWcSghcqsT7PE/
 2RvQ==
X-Gm-Message-State: AOJu0Yxev6T4ACUghPyfYODBYxSWQUaBAJwYQCM4zrwXG9bMq2CAXmtq
 8UuXQpnRK6fxHCljP0lCbHRc9FPIlxCQHvZq2HzBfKxJNkRzTot9Wf3fgM0acsOZfA1oj9oDCkG
 NtSC/
X-Gm-Gg: ASbGncuHISyWxOZlF9SAsBjYkmRWQQ29178fR/9ZoxjccoE8qh/AKog3HcVqcVePC5B
 wLxS8ILpd5C+kxhm8w+FhzSpWYoD46WvExb81K+IkHjzZGSMcsI16FR9ig86Owlc+sl6RMMqmO5
 T6ss/z1Ll8en1L2ao1gWO6RO7RNuQzs+IIFzLPmJ1PGf7YcgyKlaZIhxXRANUmYlznTUiTXq78r
 PhdK5B8HGZ7AFXKi6r1wP0lqM/bPR/XMaCSvtPDVxEeZufIlmvGcWpxSvVPQWNYmEy0ZLxxGrGs
 DA4d9yWe41PIhBQSnM8oIYj4NViHMLwK8UUSSS+YkpsILt7NvT20dFucJQllw9rPRJUT13HxOYS
 hEfyrwyvghxBtqWrnCbi5/KT9AHTEj0FE75yzpvkjxUWXMa1GBY8kIJSLxT/4b9ZyfgAsf/zkFU
 jwKySc02wBwmeGW+rm
X-Google-Smtp-Source: AGHT+IEuJAQhMZuavzQE31Va/eF6pd1l+rlSPxtlK0wBMqMqyRxzIcdjUvF/10N5Sh8N1OuWbbWCDQ==
X-Received: by 2002:a05:6000:4312:b0:429:ce81:fe0d with SMTP id
 ffacd0b85a97d-429ce82001emr4650123f8f.60.1762184825220; 
 Mon, 03 Nov 2025 07:47:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429ce6b0c16sm10504156f8f.38.2025.11.03.07.47.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 07:47:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] docs/devel/testing/fuzzing: Note that you can get qtest to
 read from a file
Date: Mon,  3 Nov 2025 15:47:00 +0000
Message-ID: <20251103154700.4126379-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103154700.4126379-1-peter.maydell@linaro.org>
References: <20251103154700.4126379-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20251028165236.3327658-1-peter.maydell@linaro.org
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


