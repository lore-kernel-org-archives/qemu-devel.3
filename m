Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ACCC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp616-0005D3-ES; Tue, 26 Mar 2024 08:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp613-0005BW-P1
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:34:57 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp611-0000eH-BX
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:34:57 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso2232216b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711456494; x=1712061294;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=epmBK7av2aa3lJZIHywP1gcTcoG4fm8mkn0XPkXFBz0=;
 b=PNbCTmBzBCAYuOaMEPtD6aacuPTb5dqAKQFtokh4PhdFNUIm7ZAq/0R5SkEKfIPnNl
 aH/r2S4udc5BIV/qvQt2UnN081E2vHIS7BO2nqm/8+A/Chs4mMj0ffZwg1s3noUSTbjd
 LrUmOvenXJFTIN6Oi/7kbY36exNZCuxz3ZkNOBowRsFIPrPdkol57SnSKwOED2fNTask
 q4K3rvy/hRUeMjwZ8wxIx/zO2iF0rzvDc38jv1cgRvvofgSca5XqLvf7fodV7WYDZkJv
 BHHqfiW832462/PF3n4+TGqE6Onj0SlWdPfzzTtNODjrjcgufbKrjO/yd8Qaeicr447s
 nQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456494; x=1712061294;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=epmBK7av2aa3lJZIHywP1gcTcoG4fm8mkn0XPkXFBz0=;
 b=vbWzdfqq64a5cwnXZHwhmKOIm6CynfDsjMTDScPIBFkeyF3g35fsMQjpSbejw//RZF
 8CwwYNtPy7v2MaW55AOSFFlO/r3/EWz8nQ2a680q016/64cs8KEtEqVxgX+092Nst+ng
 7WFoGZNmVHKUW32fXszxg5EHybhO61TfRb+Y9LDNz2koMYrsrNdxtwRKCv0Z1lT/PzGY
 PwsRQdVKV+hKCXuWIgc8m6wIL+ijYPU+rakHV4rWfr1yGzaRSInQudgZEEa4bFvK9urc
 fM5PApoJ9jzDqb4AercMiAkXGcsgBL90QHRlT7zpjLvbaALxvgw1OMjUGezCbADdJ+pm
 fviQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBv2gUS4BRuO5ykAbc6SLHHn0cpZbVmeKa2ia4/Gj8fSRCtYw37gpYvDuE+OpykBisx5NopLqgVvS4x5gqRJ3oyMYcgus=
X-Gm-Message-State: AOJu0YzTLpLZDrR3Bc3g9YXjdwQ4/Eunb7Ld9IabatEpJDPdOEnF4Lqr
 /c7k+8pWsCi6XiFpxJeqHSZ4MdfCkx2Y04YQ7Ckfoe+ec/F88DT4mVjAGJ7maC8=
X-Google-Smtp-Source: AGHT+IFQRWAqRgfjgcPRhgn6qwB4NCE6xKU6IAgh0rMuEwPLSwRz/SqDHsbaUSLwXBxNxtw1Wh5luQ==
X-Received: by 2002:a05:6a20:12d2:b0:1a3:6fef:3a80 with SMTP id
 v18-20020a056a2012d200b001a36fef3a80mr10196394pzg.40.1711456493735; 
 Tue, 26 Mar 2024 05:34:53 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 a19-20020aa78653000000b006e67edb113fsm5805935pfo.219.2024.03.26.05.34.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 05:34:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for 9.1 v2 0/2] meson: Fix MESONINTROSPECT parsing
Date: Tue, 26 Mar 2024 21:34:21 +0900
Message-Id: <20240326-meson-v2-0-d9f9003775e9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM3AAmYC/x2MywqDMBBFf0Vm3YRkfNR21f8oLqJO6iBmSlJEE
 f+9wd09nMs5IFFkSvAsDoi0cmIJGfBWwDC58CHFY2ZAg5UpsVELJQmqrwmHu0Pfo4f8/UbyvF2
 dN3iJxUNb6LKYOP0k7ld/tZfOqdK0Fk1j68rouny0yio388SzaBnzeo1uD7zpQRbozvP8AyaVS
 BanAAAA
To: Beraldo Leal <bleal@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: b4 0.13.0
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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

The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
must be parsed with shlex.split().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

To: Beraldo Leal <bleal@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>

Changes in v2:
- Added patch "buildsys: Bump known good meson version to v1.4.0".
- Link to v1: https://lore.kernel.org/r/20230812061540.5398-1-akihiko.odaki@daynix.com

---
Akihiko Odaki (2):
      buildsys: Bump known good meson version to v1.4.0
      meson: Fix MESONINTROSPECT parsing

 python/scripts/vendor.py                   |   4 ++--
 python/wheels/meson-1.2.3-py3-none-any.whl | Bin 964928 -> 0 bytes
 python/wheels/meson-1.4.0-py3-none-any.whl | Bin 0 -> 935471 bytes
 pythondeps.toml                            |   2 +-
 scripts/symlink-install-tree.py            |   3 ++-
 5 files changed, 5 insertions(+), 4 deletions(-)
---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240326-meson-b5e2c7a2fb2f

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


