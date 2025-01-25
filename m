Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C3FC0218E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjUu-0003wn-16; Sat, 25 Jan 2025 11:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjUr-0003wC-LD
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:59:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjUq-0008No-74
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:59:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43626213fffso26480605e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824337; x=1738429137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vl8eHc07qy9w4iSjn1hsKOzQrxEbvrS/cmwezgpPirA=;
 b=HENe/ZT4HhAQ2JqJnAxYKmTyzHItT2iBPjsuTdPzp6OYGyBueJGISM/RBSZcEDNioP
 /pGanoVQrdvqJ8DW3cAEOfjfqSXnWc1bCSEAX5iPWd/bQdOB1dirB7ppSc+HUtjUGOJ7
 SR3AMg6V90z9QpKUrLCgYy1wD132hURh3QxpkE8JtnS11aOi/vGpJlxIadYgvB2w+L0P
 bkoiRadog4rT14ScyrD+83pOzGbHPOeIZs1dLwcFJZwge8wRkiKpACyMQpUpbiUn7lQ5
 uL31B8f5htXuvxJuuSDLcfNEquduh4xt3zq2yjW71cBKc3qIfiX3GWCul789u4wDHSdo
 XNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824337; x=1738429137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vl8eHc07qy9w4iSjn1hsKOzQrxEbvrS/cmwezgpPirA=;
 b=KnKbCa4fZprLYWLDWdinspLgFZXlVyh3fTGhd6ZYNc6YRmW9CoUswwJcyIKgg3UWdb
 /6roVusPzRVlGp029xN3jT7V0MEwXkgbx6IHcE7Gr/16UQ2MuVnkmaCaXaexhirJmW2M
 XWgko05KKmq6pjmmtycA82I+MjO9fd+bYlzzFH0IexTXWt4HhOhl9W3+wF40OZGeINGx
 TcxSRebSypFhKkJI7T1GEPz36g5tnYr5vJKooOvOtYlZTFfELtq1GewFAggrLSZV1QPB
 bPF2RQ+75mNgfaHMrMxUkqFnK/Xft9a1WaqyGb3DVf5dfuzrwevWTNkjYEh036THsO9I
 FLjw==
X-Gm-Message-State: AOJu0YxmzYC8/KxP82+HXud9WFRpKdR2vWyrkqli59ibHDkdkcSQ5g+8
 CYES80/K+XKazbuOXUOBFo3WFAfLpmkz2uR3wIpSMlZIb9YryPPnLgpFgBAPxUc3hN1be6jT6UC
 B01s=
X-Gm-Gg: ASbGncuPlbIZAWYl0TMevMNcX1N7Nv7Ime+Kmb5CM1lCwQSX7DzaPVgIC2f7M/9kuSA
 1pzIGSGdSIX7reKjCCAD0ij0ZlslA45fW7fqdmuCzAp1ZautduNnCHgajwnPyOghfD5731l43K2
 GV1HyYDyQ2GDx/Rm27CwW+SIIAj8O+ik/vY9e9IiN8ixya8aLqu+OF8Li/DOfJYUrf3rzaNE3UL
 iHOV/dtIavH+PE+K3qdTIUZwBwZyj3jc0BASpE/eSnfF+KFpOUhztR9EVNwG7k9evbs+uB9kSM6
 PKbxM5QgEaIXk9Zyw6RgV7f37+T385F9vscdxDdALrl93b+cqL3/ciA=
X-Google-Smtp-Source: AGHT+IEBRaAZ7+mLdhJjgm9AhOLIgHolcvpDeFIuooGkwxYtBzTJdzM0JjjqkiDmmbyjryWkAxysVg==
X-Received: by 2002:a05:600c:21d8:b0:434:ea1a:e30c with SMTP id
 5b1f17b1804b1-438bd0bca9amr74777855e9.13.1737824337360; 
 Sat, 25 Jan 2025 08:58:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188a77sm6148916f8f.51.2025.01.25.08.58.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:58:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-rust@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] qom: Introduce class_post_init() handler
Date: Sat, 25 Jan 2025 17:58:53 +0100
Message-ID: <20250125165855.32168-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add a class_post_init() handler to be called by parents
*after* child class_init() handler is called. This is
necessary to have parent class check children properly
set some values or mandatory handlers.

Philippe Mathieu-Daudé (2):
  qom: Declare class_base_init() before class_init()
  qom: Introduce class_post_init() handler

 include/qom/object.h     | 17 ++++++++++-------
 qom/object.c             | 14 ++++++++++++--
 rust/qemu-api/src/qom.rs |  8 +++++++-
 3 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.47.1


