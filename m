Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48524D78798
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAVh-0004g5-P0; Thu, 21 Nov 2024 11:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVY-0004Wk-S7
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:22 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVQ-0007zE-7s
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:20 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-431481433bdso9628835e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208290; x=1732813090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMCy7EhA7nNoXN4BB2O8qdNc46ZWyWADLDGmK+DUhKU=;
 b=mh/pMQscgda3GBpKKZrTP77SMcDtIQAa4M2gSFFXRGf3U6HW2sE9lhCkuT8Fh58kjx
 HOCUNd+xI3MPs6RWXgUkYFv+Fw5GUOivptbIndw8f2rbzt1s3H4WrwzYWYRXgqKIO0Ez
 nMQF2xAKTwyVLbqJMHCQH+YEwZTjOznHidTJt9JjVy4ykZjHi+gcr010Nj10/NtNDx57
 aSKVyrNK8vTYBFxz4Q74Ytf0ZDljDPKUIp1qBQ5DKUyodS7DtAuTvFjLgHR88GFoU06P
 Mv8NlCiLqOxq/epobvrRW3REUh2cG9JUp1hmN72Z22Dgznw29ggdiDilGmXj5j/xWcQU
 5bOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208290; x=1732813090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMCy7EhA7nNoXN4BB2O8qdNc46ZWyWADLDGmK+DUhKU=;
 b=kjm5vHLLY60B3rGzJnVbpSQzGa2nqNFGB3iKuZsSGu9ntBtvZS3Ih+458imCvOjnd4
 6QOaOlWCZYvsvtady0Q/6t2qcfsMjxut+2BlpGUZGtyhjsFh8O5aYujq3bWI7cxV0NUV
 lAITCKjBlRnzgHWyUCo3nWj4QKmbJfZiHYYoLAuCOhEBVcdYGrHCGjlP19/RjM/cAaWE
 0uxZ4oMdQbJqhk9s3SwqasKvBxNT0KrVs+5vBLJ/o2Pl+prasqqQgykqzroI4OOj2jW2
 c9mA4zS1TwOeFTTlaSoVjMtok/mYZsj+V5aXIrz3aJIzMUWQwg4QY50rjIfl9ZdYW4Wv
 CnKg==
X-Gm-Message-State: AOJu0YxVohZ8dk3N9WG6/xqtAqPWEtoRUcOcau5EcLN0kI1Czn6xx/+f
 5uLDD2WaZpcoODmIXNO747avaljHr97/4UHuxaCuiSlzwL/fY87DIERs9qXrBus=
X-Gm-Gg: ASbGnct8edKgpYkKUAXqKiP36in7Qk++Qp69mIM7V8kNaxumVzczYP6crAe4YeQa8uV
 Fh5C8pFoBylS2yuuGyKIL3XZSya4p/RF7+lIqvx/kmcDUZz5tdc/fsI+HVDu68fXcba/r/ulfXE
 MkVdtDPjyXM20jwSmhSOJlgXxxA/x6K+6P7adtjPpt8Loc8N1Kv61hwicl5AMUY/dbyM+EMvJEJ
 xS7MgMh9g0ylBYK79dKwkI+I2llIZVa3JpwNTAb0unti/R4
X-Google-Smtp-Source: AGHT+IH+MC7eCDHoQMDKArNYsaKTywvUGhZHwwjRj/MFMddUvEvD+S7p1jx61D8QzHK0h/caHtIs5w==
X-Received: by 2002:a5d:6da9:0:b0:382:30a5:c377 with SMTP id
 ffacd0b85a97d-38254b01509mr5296140f8f.32.1732208290382; 
 Thu, 21 Nov 2024 08:58:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43366cbcd17sm45828635e9.1.2024.11.21.08.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:58:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 863075F92B;
 Thu, 21 Nov 2024 16:58:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 01/39] tests/functional: fix mips64el test to honour workdir
Date: Thu, 21 Nov 2024 16:57:28 +0000
Message-Id: <20241121165806.476008-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The missing directory separator resulted in the kernel file being
created 1 level higher than expected.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-2-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_mips64el_malta.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/test_mips64el_malta.py
index 6c6355b131..24ebcdb9c1 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/test_mips64el_malta.py
@@ -129,7 +129,7 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         screendump_path = os.path.join(self.workdir, 'screendump.pbm')
 
         kernel_path_gz = self.ASSET_KERNEL_4_7_0.fetch()
-        kernel_path = self.workdir + "vmlinux"
+        kernel_path = self.workdir + "/vmlinux"
         gzip_uncompress(kernel_path_gz, kernel_path)
 
         tuxlogo_path = self.ASSET_TUXLOGO.fetch()
-- 
2.39.5


