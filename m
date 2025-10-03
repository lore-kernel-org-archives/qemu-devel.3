Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB3FCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4gcu-0004NO-Sv; Fri, 03 Oct 2025 10:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gco-0004Kt-GV
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:10 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcT-0000NW-Mo
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:10 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b58445361e8so3007711a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759501124; x=1760105924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mtpvyaz05WnNRIvwV0z7Z6oqmwF0DfDKz/U2RLEI+Wk=;
 b=qowHoSlhUD7zR0clBYSTWli8UYESYqRkzhD1aFYN7AFKcYk+xbQ/QCdc1OMsfqH1nw
 22r3pGDFqZiX0upLB14G8UWJFEEuLZI3oZBG++l0C76T+DUwFXrfJxzgMIgEy5k+rcf2
 OIf86vmIgwa6T06ZvIOfcLCZoxhwb+0jeDgSV/YFnjteX4twJgzAS89HnpdPkX3HXbV6
 xFwblLmLerlocuih2g7F8xCp526KHy4Iv3L0Dm11G/YiL2kKNJjjsaRgR9SrcqSPno22
 Ij4Z5NkvQp2OaA8qjoEdXYFaXg+xGpVxThl/bf0lNTjGqNiJzOpPoLia4KGNTDoeP7+P
 dh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759501124; x=1760105924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mtpvyaz05WnNRIvwV0z7Z6oqmwF0DfDKz/U2RLEI+Wk=;
 b=hdjwvCgkClXQNtD6ZZBndg4rzVyFNiQIaIYWRpj1zF3qWzF5eCUh9qfuP4Z1GnHZdT
 nm/HKSpaAP8dXxOTRCFwG6JVa/bi52cuS+oqa6hnaMVmiCVf0IvJCEHS73p7h0Yvr0V3
 PgtpwwxgdzLj1+2vF6MnicvHdLuYNkeKmpgrt6oTVGHC8EL7Wk9od90csI9q11YZ9kWB
 ou3XLVAyZBRar1jV/3l29BraJv5ZF56neFy9hMSSaVJS2NhsulQgrnfEGc5v4/nD64tY
 qUezl2zCGjJhPzf77UbDdszI0R/orLPwqgTSavb8J0uWyjAZjlWtbWEB0YvEdVZSTejO
 m+7w==
X-Gm-Message-State: AOJu0YxWnT2YZ7yQaLLNlq5NB5Cv8HLFRlkXNEZbNoffVYCTs5Q3dv2d
 Y7wtR8T+Cz+BggmnX6EipY88h15Ki/uwj99/Opnq/6FbPbj3dB3U2mLtCE8oNKSrQD5RCEXsM3V
 UO3ic
X-Gm-Gg: ASbGncurVNIgrVYB4D82wLwKNjtPjis4zQNVhd3BhPhqX3FScc7by1KtpbrNnBlKxhV
 WFkKbkN1D6RS/JCzCp4X0M2qy5quu/lYGAWlEsE+WGJjVfNYLmvGXBMolkKe6I1orKYiuJxIC5A
 KCkth1tHOaabdEjJNcP0ViB30h7yWkhaqW2ia5IkZ7gVleQezgVVIH7NfaUgxsK75bp1Sgw/7Gl
 Fe6npWtJswkxM0BswDN96MARaoJ4fVj/XWgz6CQjq3980cqlI4R2CKpioPLdEil4F7s6VJjpuFO
 ZZNcRqh1dePQPs5K+1/p/6eaD3AeMCU6xRW9q5jww3DvhiHi7U2p/hJmyGzxpRPkLWPSOERjISS
 0pqZlsw9WNDaxSne6f/4UAtW99zQXQxwIctiH6QnAfdfjZo8fUD/kf0ZC+P+/vv++OKQ=
X-Google-Smtp-Source: AGHT+IFxb5Z1ueKe0S6WrcLScL/Nnmc4VK5AfIFlx2OugTXXpHfyeeHpAqYhciFOaMK5iJGtmNzKwA==
X-Received: by 2002:a17:903:3806:b0:26c:4280:4860 with SMTP id
 d9443c01a7336-28e8d038cf6mr102763055ad.8.1759501123898; 
 Fri, 03 Oct 2025 07:18:43 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5635sm51759645ad.102.2025.10.03.07.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 07:18:43 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 6/9] tests/functional: drop datadrainer class in reverse
 debugging
Date: Fri,  3 Oct 2025 14:18:17 +0000
Message-Id: <20251003141820.85278-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003141820.85278-1-gustavo.romero@linaro.org>
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 tests/functional/reverse_debugging.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index a7ff47cb90..7fd8c7607f 100644
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
2.34.1


