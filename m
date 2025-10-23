Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B739CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuAu-0001vc-0A; Thu, 23 Oct 2025 08:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8t-0008Oy-QK
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:12 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8n-0005Fj-5P
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:04 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-62fc0b7bf62so1095628a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761221399; x=1761826199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j70gJxXdGck8MJa36gCkeQcF/t7I7PGzdE6PkZ71zsE=;
 b=hlmDOOEBl7Vm6lDih1lqlgvhYK/8YPVoyr+KzMfCYWdSYIQWrBCerfvzpdjriXZS+Q
 xK8W68YuhUsbJtMj2HNBHomx4IT2LKD0k/ON/sHp3nJh9+lDNbO+mecqUaVdd6sTcri+
 McJ3fpRzxLQZ+c8r3Lj6f7mWC5JUmLOwi1ZE/gDy/XywMbJZ9KRJk2cymaAlteOsVhAe
 lv9+VQ75IRg0uL9mZXu2BEM2fKU5C3HhRl9q5Nr44/0uC8xl2ZC9UZFqd5+VZfBxgjVZ
 V6Kl+BaE6FHy12ugJgDM/55Rdxf6DbPqh1YPUj2OO/ISsdHoP4QVd4hZak1beABPd+s2
 vuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761221399; x=1761826199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j70gJxXdGck8MJa36gCkeQcF/t7I7PGzdE6PkZ71zsE=;
 b=ANv34a4s6OElIJ+TuJiXWD0zwuZQG774JmEz34/LWoDgRd2IDhHCtd2cwyTmO2keB/
 jS0cfrb0cqWsM3S2a/OhGsaZGnnAKasGqJRRDaqUCBIDPxVJOFE8bkGzvqFmp/E8RsmT
 iSl6MQjJLoaP4S3GJBW8YLP07RaFpNWWmJ6/V6A+FzbKyEM299XifJdw10qpDrlMTvi1
 /DORQFoQtmlxfYSSvTa0eWFK4PCbojc9Tt5PXnRf4yTt5IFfA/OjUSArcQHssAo4KtCx
 p165pzh9+2Dn8Vi0wfSYPwMWedUvmBZC7ED/tup3fgA9RFVcMz7QmzTE4vc1hRIlKrSK
 byDw==
X-Gm-Message-State: AOJu0YwSfzx0psDg4LRLRzrKxZeMsE7l1pelXXGXt/wHcY3wfTD+9RR3
 v9WUkZH9QVrP4nsWL0zANBNZ2APQSkshU1y55y0prrXJlNRrYnHpU3bDSUW7SXqJwlU=
X-Gm-Gg: ASbGncsselzl8ikkCDq1T4Et/aQEHQDX67MJhPI+YISG/MTQyPlzujvbIWO8AeLZeCM
 tOnArnub7ix+qFU1gAYC4XICaV4ZekvkyLkHUAamZaRMj8dg3jjFmH/WXIQ1BbgiAmzf0zez2tn
 isOU7E6k5s1/8wnnWjZqvdxLxKK1VcKz8Qf8FfZSXLJMxX0NARADCdGqots/nOAJVO2PMscwtaq
 cZoRBTjkF39aaDla8n/7YnAD24PVKuGTzEb5eAB9MYK6rsLuLz+Ovs0uWzs9ZW9oo7nFTpdrz+7
 OLWgpHuGfwQVEg5w4lBVsk7XIUZBSMC+VAgIAZ/gVQCW2Y9IFojQdnK4thgwZO/u24QReXvudJ8
 JKsZFBTDS7U6eG2lsabPcPKKDEk/3cgWGr593qHv3VAgKLS2jugXFzapOPrB47PNcvxl72Vv1Hc
 PdMPkQ7ByFrik=
X-Google-Smtp-Source: AGHT+IFFjnuOcTf27DnV0a4x8OdW+/JbIXGJRoBpX8yG7o/KUuxnNXaFEejHqB0LEAH/nxYsLSDtbA==
X-Received: by 2002:aa7:c74d:0:b0:62f:6759:3b09 with SMTP id
 4fb4d7f45d1cf-63c1f6d1223mr17452665a12.30.1761221399309; 
 Thu, 23 Oct 2025 05:09:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3f324275sm1490448a12.33.2025.10.23.05.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 05:09:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2C3A960F3D;
 Thu, 23 Oct 2025 13:09:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/7] scripts/ci: allow both Ubuntu or Debian to run upgrade
Date: Thu, 23 Oct 2025 13:09:50 +0100
Message-ID: <20251023120953.2905297-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023120953.2905297-1-alex.bennee@linaro.org>
References: <20251023120953.2905297-1-alex.bennee@linaro.org>
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

There is no practical difference between the systems when it comes to
updating the installed system.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/ci/setup/build-environment.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index 66bde188755..253d0b759bc 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -24,7 +24,7 @@
         update_cache: yes
         upgrade: yes
       when:
-        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
 
     # the package lists are updated by "make lcitool-refresh"
     - name: Define package list file path
-- 
2.47.3


