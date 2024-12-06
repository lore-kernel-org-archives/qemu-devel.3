Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC91E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJe0s-0002rE-HB; Fri, 06 Dec 2024 14:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJe0o-0002qC-Ga
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:29:15 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJe0l-0005Er-4C
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:29:14 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-215936688aeso23083905ad.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733513349; x=1734118149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FbPMtxcOc3D4j1V0HPSTBCu31VLQo3b2yamOLZCop3s=;
 b=kk9dqz92d10YhMsOAwNKxNBem65lLBXIqXL17qAZohuEOKzdU89MvCUaVsZd/1uvVG
 xRveCFpaurl99Q+rpTW6I1cI24xLGZ7tYcnl6NeAA5+fBQZkHhXpzTBZgnALshaCx1+C
 8qL7gJ0/6I7x5Lpvih592jqZiZFfw3+p7Ej0AZAS05f1q4wxTAvRRUdd6ck8KednccPT
 Sdfd3cBL5vEdqgwX2+U1v5Kq34kxSAbrb6kTgGp8T4TMObpGBUvCH/H2NmPq+TNIdye4
 llIDKNgAj+JhXT1h9+kgO1m10gI3iBl+Jbyl7DKmNIC1qb080d5m1eaxRlAlGasbmU52
 OAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733513349; x=1734118149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FbPMtxcOc3D4j1V0HPSTBCu31VLQo3b2yamOLZCop3s=;
 b=UUz7F++tJQEm8cWBTeWiAMO50Rfb4OaRHlPVVMRAl/mD7Fl9yL6jY8QMkXgOTwfG3+
 Zy10wVyaP3+KF0DMOLdtM12sNgTqyZr7ndjkrVWXpHMiI1qWmRlWV8V9khmYg9zIXxta
 HlbmWVRaKUUV15p560+LXMGuauYyVzXbotYoe6LUpDbAhi2zM1ctWgulSqK+/PshqLrP
 bA229Qa8OxsuJunhDePZLlh1t6OzwqdZ/UqXpF1OOICMLY1fEXXul07N6/FVMhKtI6aR
 TtaUPFYsO/s7DC9qW8jowa6GEuYkckfzlxNvSHqTLqpFyVC9ueda6oAowgsM+GLGdO72
 5WrA==
X-Gm-Message-State: AOJu0Yz4o+MODd8+ZX6ZpLHDZKXbYikANeJ4vBjsdx/lOyPiI3mDfKXP
 Fk8MbfziQezJerWozHsS6zqaid059iI1x/1NxmSpuL4alIXEuXizatEsL9cuSR7/NymikRzPGwc
 fLzE=
X-Gm-Gg: ASbGnctaJVJ48d8n4bjYFJsdDRbwB2c8QahAj0vUU686F0RNySpX7HIC9Q4WbFnJVHP
 ROKQgee9M73UuuvPwCB6iqr7hQhXexWKerYyot5Nm937OuWBpjZkTldlQgQym0Gw/Rn+mC3aHVq
 OYTt1Q5DUXqhMLVCBgHAvsstfpooIx+yKLaaJ5xJtLPUVciIK4OivHt4GasUu+/vK5Os7ei/UxX
 JGVNmPebt1GzzPAr++J5tcLLMH1eTXL8xwVSWaBfiS2Lk2WMi5ZYL9BlWuLSe/ilv8bftqbgLsc
 Id6WSpIh
X-Google-Smtp-Source: AGHT+IFMrlZJVSch9+XLcwCmnYK958N0MU6X3npy9db4D7XTYUqGyFCj6Ns4sOuLUYXsJ3CdST3c6g==
X-Received: by 2002:a17:903:2348:b0:212:996:3559 with SMTP id
 d9443c01a7336-21614d2e567mr62280495ad.5.1733513349592; 
 Fri, 06 Dec 2024 11:29:09 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8ef9fcdsm32110205ad.146.2024.12.06.11.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:29:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Blake <eblake@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 manos.pitsidianakis@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 1/6] docs/devel: remove dead video link for sourcehut
 submit process
Date: Fri,  6 Dec 2024 11:28:55 -0800
Message-Id: <20241206192900.3893118-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
References: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 10b062eec26..03b2ac298aa 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -252,10 +252,7 @@ patches to the QEMU mailing list by following these steps:
 #. Send your patches to the QEMU mailing list using the web-based
    ``git-send-email`` UI at https://git.sr.ht/~USERNAME/qemu/send-email
 
-`This video
-<https://spacepub.space/videos/watch/ad258d23-0ac6-488c-83fc-2bacf578de3a>`__
-shows the web-based ``git-send-email`` workflow. Documentation is
-available `here
+Documentation for sourcehut is available `here
 <https://man.sr.ht/git.sr.ht/#sending-patches-upstream>`__.
 
 .. _cc_the_relevant_maintainer:
-- 
2.39.5


