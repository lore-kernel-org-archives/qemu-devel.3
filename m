Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092BEC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQXG-0005k0-SO; Wed, 26 Jun 2024 07:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQXA-0005WJ-Da
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:09:52 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQX7-0005IB-VJ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:09:51 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f6da06ba24so48171825ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400188; x=1720004988;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=imzyvSBElsn5CvDFjciPKcWXkdE1van1cg6iWIofoSY=;
 b=chhqXDHXyP2pPn0/POUtfPEzgQ5gTyH/tzMXAr7E1x1lhA0pgP9R2Uy1ENnQb6HMJ7
 VulGjhHvixvnJhJepD+VrmwET6A/WgwhpNIp7mUtyvc9hgwZPr3mwVnxG3tZnoVxSPii
 eVXna3voxfGXfS9SKsG8hJ9Ufiw8ixgIzedx9pZkFWp9/a67wTFPT3f6jxKlW5+icj5g
 eCOU1JA8jFXFt6G+uOD+JxPVdC58L9/IzCeNBbFEHduJ0UgZphbWIABJQPN9RnzuUqhD
 bi56xrXbbD7Ocvq9uV4D2DL54ji84aBl0MhmoysPyJhhN/NhPhw2Q0m45eRNffoLsmhF
 JOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400188; x=1720004988;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=imzyvSBElsn5CvDFjciPKcWXkdE1van1cg6iWIofoSY=;
 b=uUljoMaEpi5RaJoMCreJD3sO9mRsZRhurakGA7rBB8ooJhIWEDM7y+m1zTk2E+cUge
 /2wdLq5I8tIB9OE9FsVrw/0yjVy0lszrYaznoO0GWPrPvoYY3gkyQqvlDG1RNsjAOZRo
 8DJu2ORsfEIcCsoH4Au88IE2IVaWUEjXJNjgnFcC2p+r2yxqOTZ1p+qlhUgGRqMWrizw
 2zwZKg8AATijK0iKAg+lYwxFVt+eNYvPEg7B0eD2KZSzL0Da24Cp8r4MYvmf9OXBBGiU
 vWdykH6ERPURZrZIZ+sqVqiGfjPohgJ3Q2m70Y2LNM0J+g8jzST87uIYbDiRSEzuPQrp
 xvFQ==
X-Gm-Message-State: AOJu0YyMDIkBT9KU3qiCAO3cmGWDOurfcMoB1mihop0mD3Q57/exw8io
 2pp0edxturZQURAj64bYo+RTVuMFu4pi0Dsud+qbZFKNOq+e7S6J25XAYe3Kmzw=
X-Google-Smtp-Source: AGHT+IEzOjaTkLaT2BqKu5ac11FPDXhoZ8h59+mSvzVI0ejWggv54XHCljgeWJnS79TqD9o9pDrCNg==
X-Received: by 2002:a17:902:d4d2:b0:1f6:ef4f:19c3 with SMTP id
 d9443c01a7336-1fa23f0716cmr120609735ad.1.1719400187870; 
 Wed, 26 Jun 2024 04:09:47 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f9eb2f0318sm97495165ad.2.2024.06.26.04.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:09:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:09:37 +0900
Subject: [PATCH] tests/docker: Specify --userns keep-id for Podman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-podman-v1-1-f8c8daf2bb0a@daynix.com>
X-B4-Tracking: v=1; b=H4sIAPD2e2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyMD3YL8lNzEPF1LyxRT0xTjRDNDgyQloOKCotS0zAqwQdGxtbUAQbx
 hTVgAAAA=
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

Previously we are always specifying -u $(UID) to match the UID in the
container with one outside. This causes a problem with rootless Podman.

Rootless Podman remaps user IDs in the container to ones controllable
for the current user outside. The -u option instructs Podman to use
a specified UID in the container but does not affect the UID remapping.
Therefore, the UID in the container can be remapped to some other UID
outside the container. This can make the access to bind-mounted volumes
fail because the remapped UID mismatches with the owner of the
directories.

Replace -u $(UID) with --userns keep-id, which fixes the UID remapping.
This change is limited to Podman because Docker does not support
--userns keep-id.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/docker/Makefile.include | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 8df50a0ca06f..708e3a72fb8a 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -207,7 +207,12 @@ docker-run: docker-qemu-src
 	$(call quiet-command,						\
 		$(RUNC) run 						\
 			--rm						\
-			$(if $(NOUSER),,-u $(UID)) 			\
+			$(if $(NOUSER),,				\
+				$(if $(filter docker,$(RUNC)),		\
+					-u $(UID),			\
+					--userns keep-id		\
+				)					\
+			) 						\
 			--security-opt seccomp=unconfined		\
 			$(if $(DEBUG),-ti,)				\
 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \

---
base-commit: 74abb45dac6979e7ff76172b7f0a24e869405184
change-id: 20240620-podman-99d55d3a610b

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


