Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63561CCA472
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Iu-0002oW-SF; Tue, 07 Oct 2025 07:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IX-0002Yy-4O
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:56:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IE-0001Ju-Jj
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:56:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so66574875e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838139; x=1760442939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjKs3jTlQtEveYE7uYq60wvWxiynzDFcFsVQGbRYhNc=;
 b=etKt8jGEqvy1JM0Qcu8KItWPIApPZs/lSRyLGr/zagH5ZR8jHRvlmodB3i1MlGdUwv
 Az1maFRJXCWqKB2VR2ccLJLkwF2lfE+ezpsfz5QWKYXu3+vwgoLoYNQF2HlkcRdGJeir
 /oagKnOGqpxTtBlOrIuVHUOpG9ybm6RjTVT/OGHhGwdhNhwBV6viUNU0djD0MgdCASRB
 GLx3Ep2FqiuCtRbtW7TiRmPKGmO3jGhgjqfm4OUbBeCwFA00q9t9BNi2N0Y3DvP5JhFS
 rSaamIhNrQ32I/fkdSerbxlroLRTTC1Zn+WY2M4bJDg6fOOawT4yqCb2MJ7uWkExRTNb
 rtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838139; x=1760442939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjKs3jTlQtEveYE7uYq60wvWxiynzDFcFsVQGbRYhNc=;
 b=FhmKKWYIIitYJQNZjmE3bxO1ju+T6hvMjUWOa6LluN9NCS2lRYqArKIH3PRHTyzSmF
 +83oAU2WFi5gGCwNZxA+9rePVGgLELCLMOYDAal4UJDbIlTJE3NsrVaQKTUZ+vJk0Zup
 454mqTGsTT/3LB2Jr3eh/sCexqQYIhhjAXWkYjSbC8bCm/QrnKK5yrSB3WEJOpoXi0Jh
 UXT5hdpSWiHMemYkVHZMWTRUv+iTwxmhlkT3D43Q9l8VQu7pF3Tg5l7EetkePo19KXnd
 lUwUJh/Evpemzio2sysJAJ4DAvu6BalRNYTzU9htUaThBx8wmsSLq17N84QN5+Ykyl4+
 j2TA==
X-Gm-Message-State: AOJu0YyhCSShze+wstu27IRJ5+x8eGMAdEtZeCi8y5zBhlaRkQO1XEor
 3bOiG7Ddpi5rzeE4ZJSxXaIoFXVpr0JJ+7CkvqJuMmLQFq+C+aS7JG0oJ92T7e7haDnYFs05133
 qyqSC
X-Gm-Gg: ASbGncuqySXIpbbFMg2vkuC5JCbwM2fEa4Z8taAIfZEPRWzlHIdIairzwYzFFyFmu4d
 eGnZ56zLkUynnfQ/R+XBGMu2VtlBIY8T4wWRS5FPB4ju0w/BXxi+XfZfD7djOdQ0xC46s2/cpX8
 6YyLySuVRE4sXl4hrxq31fC01ToMNuXG415KML491BPOqCaJmwfrB7NhGdIbQDJal7kpLZHWXBh
 YS9+BHofaCgkzly8tC5BMWVHhFTq6OYe2YYYQQic4izJJ1polA3E84MxfiItBHEFxvTIj+5jOza
 kK991r9aT4383JgiGQCJ8lR7HT+czN1l7elXrcLXFBjmAjUhF0ibbfeSBh/S+lac9v9F39KDvKK
 ioy0gqKzf7KKTpZbSpcMb+xastH9gt/4tXy5GRY+3q1cMkyperkM=
X-Google-Smtp-Source: AGHT+IHpE/V0ZjKKmJ+B6VpYK0c7yiKtrZL2X4HqBTLhnY+3PP5vUXoLLfXSZJcdAHfcBCxmI/dVOw==
X-Received: by 2002:a05:600c:1986:b0:46e:3cd9:e56f with SMTP id
 5b1f17b1804b1-46e711043cemr122446345e9.6.1759838139125; 
 Tue, 07 Oct 2025 04:55:39 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa57320easm11268755e9.0.2025.10.07.04.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C82C604EC;
 Tue, 07 Oct 2025 12:55:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 13/17] tests/functional: drop datadrainer class in reverse
 debugging
Date: Tue,  7 Oct 2025 12:55:21 +0100
Message-ID: <20251007115525.1998643-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The reverse debugging test uses the avocado datadrainer class to
create a background thread that reads from the console socket and
dumps it via python logger.

Most tests log console output as a side effect of doing calls
to match strings, but this test never tries to match anything.

This isn't critical, so just drop the functionality.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251003141820.85278-7-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index a7ff47cb90c..7fd8c7607f5 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -34,8 +34,6 @@ class ReverseDebugging(LinuxKernelTest):
     endian_is_le = True
 
     def run_vm(self, record, shift, args, replay_path, image_path, port):
-        from avocado.utils import datadrainer
-
         logger = logging.getLogger('replay')
         vm = self.get_vm(name='record' if record else 'replay')
         vm.set_console()
@@ -53,10 +51,6 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         if args:
             vm.add_args(*args)
         vm.launch()
-        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
-                                    logger=self.log.getChild('console'),
-                                    stop_check=(lambda : not vm.is_running()))
-        console_drainer.start()
         return vm
 
     @staticmethod
-- 
2.47.3


