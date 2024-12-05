Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D48E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJKFL-0004WR-Ux; Thu, 05 Dec 2024 17:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKFK-0004Vk-Nl
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:22:54 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJKFH-000805-TQ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:22:54 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21572ca3cccso11947495ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733437370; x=1734042170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FbPMtxcOc3D4j1V0HPSTBCu31VLQo3b2yamOLZCop3s=;
 b=fL+/Jt8xS5xDCd9Bgd2DL1X9WxDz8IRs4K+KCPAz6Vu0nCU/VwlgeGsxIB8nopkjce
 gz8Q2VqRAW71mpjsY/fR7Sl64byRoof8H7Zju1YIf3iQ8cIvJQpKvoQoZtX+t8HWGsKT
 YHS43KOJqEJ39ism0MFh+Y3/XRxIbG0CMB913rVJnXFCwfVY3LHdGkPehFoBrqwDxNW9
 NP9Fs3GIJGKD4wqtys+bkjbagqUVvwQTPsLOMK8HXHTi2lHEVfIc7AUYubr6ccxTHF3N
 8zM67fW33xEjF5jDdV8gQtfZ7UDVgD/R4b23+rclaQzwdbliW8J4htCs2+zar+nGEmKO
 yDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733437370; x=1734042170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FbPMtxcOc3D4j1V0HPSTBCu31VLQo3b2yamOLZCop3s=;
 b=nYxqJCSnmJGTy+PfZ8uhjk0qgh72qWrBZ6XzLgnTfn9PKdHVg4NBMldo8WBjHA/Xcv
 cwdmveQ6+IZso8AFd7STmjk6slo8PagaVqG0ik/HxZPPK3tPaVERhutAuPrbemBqdp16
 tH2/JK49JoE3qBLNNmHmIWanvBfJEo+0JIt5vx0UrCw+gt3odsRcwLbkA8iczc4OJ5e9
 dsL8b5lqqJ5hA1+sueQZoNYrX94pGHmKaJXV3IHApd2H8UisJ5fmqRU9BSnvkz8kkHlx
 h7RE9ETVvb7kojnsUZtm0iNtMNfjeChHW2ThhkI8Lz7ccGneLGTez1qpzlhadbeK4MV8
 SVtw==
X-Gm-Message-State: AOJu0Yy0sq0k+fAfIpf0QayWAi4OczrSPkFLPzLPXf8inMcuAQyAVOAS
 +64cSFiADf8hV2d13xfzCe3UnpRCX95CzZ7LiF2JzR8hO/YG9u7kw+A473QefoKzt7u5at1L9JK
 eLTA=
X-Gm-Gg: ASbGncuHFWQmPxSlDIElagtsUeYe8H0Cw+jgbv2VX6YEuEROV54gN4J0AnANN1AxWez
 OlriEU5D8BlcWgth18tYaE7dG48OvAroB3LDVAoYn0cvfN/fsLxKEl61SdS5T8cMIIDy8foB8lM
 oH+Jlpu6nh6cG4BQxHGT410YHbOL+EH0QlHxQMUqmJLsdUOPs4R8MYcCYvjKba/ZvLndmPi2HlF
 FjPZih9rDUt2y6H5uOPFnABkPtZoSBtf7o5cVo5ug4W1AZWdmob2SLl7xK7Y6GLljC7mlAHCUEq
 KLtGGvPH
X-Google-Smtp-Source: AGHT+IGGpMrgNZ1O4bZqOEYDSDjgfdADe/h62ubd0eMgisrR560w3IkgYU6NwrzANqjBgeoLeUxSbg==
X-Received: by 2002:a17:902:c405:b0:215:a3fb:b4d6 with SMTP id
 d9443c01a7336-21614d54353mr8243025ad.8.1733437369826; 
 Thu, 05 Dec 2024 14:22:49 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f0b571sm17310435ad.183.2024.12.05.14.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 14:22:49 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 gustavo.romero@linaro.org, Andrew Melnychenko <andrew@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/6] docs/devel: remove dead video link for sourcehut
 submit process
Date: Thu,  5 Dec 2024 14:22:36 -0800
Message-Id: <20241205222241.3789437-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205222241.3789437-1-pierrick.bouvier@linaro.org>
References: <20241205222241.3789437-1-pierrick.bouvier@linaro.org>
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


