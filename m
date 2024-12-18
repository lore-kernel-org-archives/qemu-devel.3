Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF223E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwoZ-0000KB-Ud; Wed, 18 Dec 2024 11:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnq-0007il-Su
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:39 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnV-0006qc-DS
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:38 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso13462513a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538876; x=1735143676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WD+OCh9xieXyi8aUL7na7hMYPj/U0GHInutd7eRNwQ=;
 b=Y2nME5dZeYtcJBmjx6ax9RpoZoFFa72POHjewp36RFIlS5MmrCKrGQMuVyoYcHe2lr
 q6qV9C5YfpUgwo4+eER9Ur6cQxIgZm+mJ8kR74d4tJ8HAohpCVBDLMA2CIrtiLDigeo6
 qBjkK8CIc7WyMwex9tkGTtIFjxRnQiL7XpIF6GptgLcgOptFGa51oOuO5/RyJ+UijoAz
 Zgov+Aoq9drseCfj7GLyxS3mvn4Tj4yc1W3fVZ1nsSGvd+NR5rnqDokD1OsVghRtrg/z
 37kjHZcAgdIL8wWpRKhgY++1+tG82DRojT5QziYl4frk/DCGYvv674rZtjobtxGi7SYX
 QEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538876; x=1735143676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WD+OCh9xieXyi8aUL7na7hMYPj/U0GHInutd7eRNwQ=;
 b=wTUYcPOGadvfoAB6RDD/xJUKFlKKd880PXYvuuTes3zRD3kLxI1qS0HbJ8RPUlO1GY
 KHtx8tPES6mNpSmV/oHkBHOTz7mMAQnhjuNFZ02ynmw69UzwhPQOyUVroGVurbTqJndl
 rY9vGfm34OXAFAxRn5jJqx+oOxwtwOgeixZpnes1VvoaFwNR519qLZWrp9HzTeOx5OCY
 RmqapxAqmmnFcvdABELWbhiRUEctKPew+2Db4eXcmU9g5F1wSxsPmjj1BwL/1KwQR9dg
 MrLZ1HE4J+Se5QROy6r9urbDUKUBlBvKSHbJpMGS3MNOPC2wuax7jEXzbMMl43+CeN7r
 YYsQ==
X-Gm-Message-State: AOJu0YxcsE3JB1DzxmaAI+63gupUVKCNKQcTU0HtiDOivZ5wFh1vwUY0
 Zdf+cfBhchdlws76lchaASNFtQp2P2EV/9McZu8p5D3VlZF0CKRsSFdMz7437gI=
X-Gm-Gg: ASbGncu9qUNiQvpRnmikadS1wlJWq/pAfaUJ9T+mMKvFBmcIi0YPU5+pS2Wm0/vkYnl
 ifvDen2//hTtgctHBROYutgcxeoXghXrOY9cw0/AodBIf4e2AaGGlJNH4WHS54nWRNF8iXxQGoX
 1HooZDUdg602lxE3Xosc9kVDOl9Hvk1qMzGTpR5OxHK1nWrgIq0sJMOsyW7ZgLPrj0W788tOiOq
 99ZsrdQFCsitgAg0WMIkPCCoNkiX9w7yn3Dg5j5fazOnbDkQDLMgKo=
X-Google-Smtp-Source: AGHT+IHiSqi+g0EE7Vs4MtUIdiCQOpAOtRZSSznSgSCmX7FN6dTmpkBuWIofdpLJUgqx25DZfIteqg==
X-Received: by 2002:a05:6402:3589:b0:5d2:723c:a568 with SMTP id
 4fb4d7f45d1cf-5d7ee3ba959mr3583489a12.10.1734538875792; 
 Wed, 18 Dec 2024 08:21:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ab604fsm5553991a12.2.2024.12.18.08.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 449C55FDA3;
 Wed, 18 Dec 2024 16:21:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Beraldo Leal <bleal@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 12/27] tests/functional: update the s390x tuxrun tests
Date: Wed, 18 Dec 2024 16:20:48 +0000
Message-Id: <20241218162104.3493551-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-33-alex.bennee@linaro.org>
---
 tests/functional/test_s390x_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_s390x_tuxrun.py b/tests/functional/test_s390x_tuxrun.py
index dcab17c68b..a7db4bfd84 100755
--- a/tests/functional/test_s390x_tuxrun.py
+++ b/tests/functional/test_s390x_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunS390xTest(TuxRunBaselineTest):
 
     ASSET_S390X_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/s390/bzImage',
-        '0414e98dd1c3dafff8496c9cd9c28a5f8d04553bb5ba37e906a812b48d442ef0')
+        'https://storage.tuxboot.com/buildroot/20241119/s390/bzImage',
+        'ee67e91db52a2aed104a7c72b2a08987c678f8179c029626789c35d6dd0fedf1')
     ASSET_S390X_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/s390/rootfs.ext4.zst',
-        '88c37c32276677f873a25ab9ec6247895b8e3e6f8259134de2a616080b8ab3fc')
+        'https://storage.tuxboot.com/buildroot/20241119/s390/rootfs.ext4.zst',
+        'bff7971fc2fef56372d98afe4557b82fd0a785a241e44c29b058e577ad1bbb44')
 
     def test_s390(self):
         self.wait_for_shutdown=False
-- 
2.39.5


