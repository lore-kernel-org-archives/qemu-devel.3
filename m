Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012E8C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmXD-0000Z2-VN; Wed, 21 May 2025 12:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmXA-0000Wb-8r
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:12 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWz-0006AA-PJ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:11 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6015f8d4b7dso3388144a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845779; x=1748450579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eBksJDjYxbj/jrleCQdl2ev5L2gMtbczqXLkNWvLosk=;
 b=AKNuvGKWCAH32dDrdVldQoZZw8l2dC6OtoPWvv6mfFrRk0EZo3VnQaEQS1d8nEWF8g
 TPOz750rb1tOXiL5HuZA91rvXjjk+1W17aSglLgvxKDHero+V/aKBRUmOJKCh4f0kweg
 6leZ++AS78Q4fj0heW5jmPb4G84mt9uPZNt6Eyoq+8g4ILJg26XOj6MW3Dv+N/b7GmIk
 ayUjcQVZdK2bdy/ImykWoOoYIUoXeBQrrCKZPTor2mGUnFNgMaMYW3OklNZeR+0wunFH
 zThC+hFebJo+zaUA2cDJiL0H8iEtCbFDAN958NMhV9ulT7x9iM0XZ92uQAJeNNxyW5AO
 Jodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845779; x=1748450579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eBksJDjYxbj/jrleCQdl2ev5L2gMtbczqXLkNWvLosk=;
 b=HVIY57SdAGOpC1Tc2XzBuAlLphROAXAZwn0JW0yYKqhwHHLkh04L6+eoEPmUCq2hTI
 KVgwOUh/ZIQ2MrIhfy3vdYJAfIanWQwHcdjwxfFlmnN9E0WdD1o0rbzRYdrY/uFvYJ6l
 6gCJAQE0XWf8VSh17qo057mBa6rCGPPr7xXExCesuqafXZ/pfrnb6i/hlvKOhojoJegP
 e8Y7TETY8btbSPebU0EoUUxUv1Choc2clWs46nk9meiznm0hquiq1eWX479qq/NXb3HH
 E76OpC+uV0F5NhcgruPreQEiZ5C2CroA47RAnwOkQeh+UqlB59AvO+fzIv6gpaOoe0Pu
 zZpw==
X-Gm-Message-State: AOJu0YzoCMe1qWPiODt6saGw8vsKy6pfxmGqZib7KxY7kY5d92R9+AEO
 e0+1GCoSkLk6Z2g36nw1p9tRMC5/ydolgeSqVUKp/lYX2uCC1oVKcGS1lVuM4UWFr9c=
X-Gm-Gg: ASbGnct1vWTBvbipVbj4FeI8AqSah7ILosBFrtJb5x74vISAZnEyHCfoomOOQFfhYyH
 NWHiq0eC5kZOk1Y4w7V9ujpMpWz6TPMptbFwhMKnITnjRWsrUbimTzV/o3BdT6FQXf9S2/+3NWT
 Sb5BbfVPl0tqFWYN096cmT38SYDaG+lLWuRWbyYFAVo4ia2EibEV1idx69pxOmxJzKhOCQ6/ejA
 /1uXezinvF6hNbKkAlnp/LReXl63us9FKozUN+45YusFL7+HBJGIxxYPLb46Masuyuan9/cd2dD
 MHKpvboSWUMhF4Wr3OJUG+suUgas44FEvM1P8TfE8dYHtJ/vCHF9
X-Google-Smtp-Source: AGHT+IEZQNK8srkgDbHlNOS49lrrDmrEqDNvwRubACyrTe6x8QHVG9ZX/ThXUILc9WHHGWNSpeDI1A==
X-Received: by 2002:a17:906:6a14:b0:ad2:2e5c:89c5 with SMTP id
 a640c23a62f3a-ad52d4c511cmr1980220966b.20.1747845778636; 
 Wed, 21 May 2025 09:42:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d271916sm934897566b.69.2025.05.21.09.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:42:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F34C15FA14;
 Wed, 21 May 2025 17:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 10/20] MAINTAINERS: add Akihiko and Dmitry as reviewers
Date: Wed, 21 May 2025 17:42:40 +0100
Message-Id: <20250521164250.135776-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thanks for volunteering to help.

Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8dfb393c06..a14e2796e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2674,6 +2674,8 @@ F: include/hw/display/ramfb.h
 
 virtio-gpu
 M: Alex Bennée <alex.bennee@linaro.org>
+R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Dmitry Osipenko <dmitry.osipenko@collabora.com>
 S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
-- 
2.39.5


