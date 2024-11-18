Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1506D591A8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5Ug-00009Y-F4; Mon, 18 Nov 2024 12:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD5U4-0008N2-JN
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:24:23 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD5U0-0002oD-Ar
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:24:18 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c70abba48so18138895ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 09:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731950655; x=1732555455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4RsMVroYRLEeyBEwglGNgeTU+l2C3LQibeRDMRaXh0=;
 b=IoOIdnw/6HtZoeZ7VbU0QQX+zDBUq+/LVMkaMgYGd9d3qg6i+eSji1097ASow5K8or
 MwUxvlUeyw+ESPpjsSozibDv0IdMNvBar0TBdJ95oOvn6frzX73FD7TrlcnYkAkWHVP1
 WvexakIBb9f+NWu7tF5EBsSijAt0hauqNI9WLNPgr55hfCVIlO1SHsXj7cPwa14PtSi4
 izJShZDrPxDXoJe1e5GAV071noyQclNAvc+tazeVxJpL3p/hRhvc2MX2DwVOoSmm9eEU
 GG/x0hCQVa+uDF8jpmFR9xgxf1CZPlijZgoKZtAuYXBbEtYtbIphz1opywGSEptOfMth
 Eq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731950655; x=1732555455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4RsMVroYRLEeyBEwglGNgeTU+l2C3LQibeRDMRaXh0=;
 b=a0KDhOJvoso1Lh9t/a2qDXmeoRPlE1+AXtUWADeYAZiIR9llr+g/ZikxI5w9BDjmFL
 OCcyxD1cSOH3MX/uaPgqKimzahylQ8CMbeuVGF2GhcLUS8Jv+s/O3XWRsO3Vv/bOV8TJ
 /44W4APeRAUT+VLhG/YvNV3CAAS6jYQA0iwGKZ9MWUIhi26rJEi4lJnOSjX2L47lsypD
 DwBMmz7KqefN2vzt5OYufCWcpsJosaVBaSkVdDybPnF1WOS4LdMqn+NwMt1rAFwh2Yu3
 A0zWybC7HAbMPOxbn2lsA8lpYeo02wHVVKMinZC91LS1CibQZO0KUNy3uFyMfmcEdOCd
 vnvg==
X-Gm-Message-State: AOJu0YyZqVutFYGxiki6Q2o7832LdBYAFMeXcn7/Eej2Ge0Ze41qcOuA
 2OnZsNFmkH9heskthV/vWqFG2QvNbf5nXlebjCvCnK/sF922kbAO0pQEvNZ3mMHbxoO0hVm8yYk
 vmlXt7w==
X-Google-Smtp-Source: AGHT+IFBygmmPIfGUz8O9UWqNtcVccOTwB5Fr5+w+tOYYwbTSp47Wyg/hcvxZd8kCJUQ/HvoeEuAJw==
X-Received: by 2002:a17:902:e74e:b0:211:f52d:4dfb with SMTP id
 d9443c01a7336-211f52d50e8mr141024505ad.34.1731950654881; 
 Mon, 18 Nov 2024 09:24:14 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f55d04sm59469765ad.264.2024.11.18.09.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 09:24:14 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/7] docs/devel: remove dead video link for sourcehut submit
 process
Date: Mon, 18 Nov 2024 09:23:51 -0800
Message-Id: <20241118172357.475281-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 83e9092b8c0..349c32ee3a9 100644
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


