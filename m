Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14530CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8Rz-0003ze-En; Wed, 29 Oct 2025 11:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Ru-0003yj-6E
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:50:58 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rq-0002rh-Em
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:50:57 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6399328ff1fso12649795a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753047; x=1762357847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=csF8Zps1zGkSY9AlSeNCixo/R7NZrugkFKozd2LXLyQ=;
 b=ZfnH7BQZKGcXrRtczi1C4KZPbxGZMsSU4EoHq7FQuaUl7J9r05joTIxNBYzPlcN3D5
 CeGG9mA/FE0qi44IJKa4B6qptXwvBoxO26cQtPgeq6qow33cIYWoWQsVx4o/3E6c50MN
 r9+xS0wJwPf3brKAD9huPWqt6NQ5JStTGtIZX8r7IbGdHv1yiFctiFEAr6IemmzvWzHi
 D60ZEHCzcMkDP0Z4LEr/B+PzgFwTZHlswayPh6gxbTeo4W81NE1QykFKl5KnLbqgSme0
 nTDVfLpE1oQSdw7nEJgUzpaRmFDuhkJtd7uzA7svJ7SXo2DAFgWo5t0GWCcelpkQbKCi
 isYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753047; x=1762357847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=csF8Zps1zGkSY9AlSeNCixo/R7NZrugkFKozd2LXLyQ=;
 b=FLpVJ0BaDmOJmFw3ijJBIXYbO54J6BP68GkyE46MSjtfFVnTi0Vt27yWZrTKeENiat
 LoIGX1rNo7dSn3TLzpDOscqzsw8mbumi6zI0HZM/rkEDXNAaBds3qIubxA4xFkIWxrek
 PZ609LhF3uKcNPt/k4mo6q4XzfnM2f8XbFEnScTZkzQfioQr14TGl8APvb75ePMIEHPu
 xAhqTrn7ibmUyPEnbpcClQOy7hForQ+YwkU0H+ka07z8dV9ij1E3PLbwdFiRo/P/q/1o
 mo+idd8VdpCgNCUkWKWkvxzcRPT9f6pQyNyMIAP2MmwRspwjZdOOjqhjNSXyGRCYHPUD
 UzEA==
X-Gm-Message-State: AOJu0Yx74m2Jw8q6YhwDsu8DrBi7OgHmeHyWpQ1N5kqgAA/I+niMfSCE
 mZky8F63yoa8I4rJHks2izn4A73snOGo1TV//goBnbvvdqsXGpqdg+YwRxnBrEn3jM4=
X-Gm-Gg: ASbGnctfd4RnN/uQWPBvw82YJC2AqOrhWY3svK5t+OvXUH+VRtE/DVZV62YLSdSkkIF
 5hx0JRq5Bsc48tavll1gB1ic3yjMOb52RxtV72hd9xGawpUWFh5Q894xCs1TjNeEBm7WHt2Aln3
 8Eq8/CxupaRA+OM0YbdPoOkS3t91mBON3l9ZEEr8C1LMzEM4Frx+xNkfbm5JdIx0799zt/2Yg5X
 xe26iWRc31wQOo9a0+BbaIEWZEz8gYnl23xmMD4/beLYWB2PdrFK3zDmETNDUnX2mHV8RLMYWPW
 mtTOZydLw1MtoPmP0eL4U9VwwIv+i4NcEBRGFmUyE6tt54nikIdgomn1gMU/UpRzVX6nDUcINzN
 SemjcNSogszRLoC1gPMNZeh71dRC8+HTiUrYH6pjJNhaf/EnswpBJjV0wTE8Y6I6TEk2JhFWj7k
 zV
X-Google-Smtp-Source: AGHT+IG+KkX9ET7a6j+8q6rVA81D1eD8DmFC2ZsGDOJan6vuPoIPgM8zNyNO+79TaIPKTPZD+cTSzg==
X-Received: by 2002:a05:6402:50ca:b0:63e:600b:bc86 with SMTP id
 4fb4d7f45d1cf-640441a9b44mr2661907a12.14.1761753047423; 
 Wed, 29 Oct 2025 08:50:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef6be28sm12298752a12.2.2025.10.29.08.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 136115F929;
 Wed, 29 Oct 2025 15:50:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 02/35] scripts/ci/setup: regenerate yaml
Date: Wed, 29 Oct 2025 15:50:11 +0000
Message-ID: <20251029155045.257802-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

We inadvertently updated the base libvirt-ci project which has
resulted in changes. Make sure the output matches what we generate.

Fixes: 0d4fb8f746d (configure: set the bindgen cross target)
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251027110344.2289945-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index ce632d97108..70063db198e 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -26,7 +26,7 @@ packages:
   - git
   - hostname
   - libaio-dev
-  - libasan6
+  - libasan8
   - libasound2-dev
   - libattr1-dev
   - libbpf-dev
@@ -37,7 +37,7 @@ packages:
   - libcap-ng-dev
   - libcapstone-dev
   - libcbor-dev
-  - libclang-dev
+  - libclang-rt-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index f45f75c9602..4f1a49be34a 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -26,7 +26,7 @@ packages:
   - git
   - hostname
   - libaio-dev
-  - libasan6
+  - libasan8
   - libasound2-dev
   - libattr1-dev
   - libbpf-dev
@@ -37,7 +37,7 @@ packages:
   - libcap-ng-dev
   - libcapstone-dev
   - libcbor-dev
-  - libclang-dev
+  - libclang-rt-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
-- 
2.47.3


