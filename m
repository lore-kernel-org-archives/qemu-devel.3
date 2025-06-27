Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CC6C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DN-0005OH-NJ; Fri, 27 Jun 2025 07:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7DC-0005Et-UZ
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D6-0007EG-3A
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-453749aef9eso7555445e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023534; x=1751628334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QF6hdZWmESZx/oo7D4Z38KZfMJLBNKw+PdVmoS4LcNc=;
 b=IVS7drpofj61UQqc08ybulXbLTQtOap4QPQCDY6L73gPaPUOKRvgjBBNztVXFRHFdj
 7jrHYN2egHiMAVVZ4GoL4SCQBMNaDdKH5TghXf+wEoEI2dqizwnXu0WkGC7tuQL6ZMic
 um/Draoow4jUmU9LywO30RAzwMPm5WskM3oE6sfd5pC9S4m/BFPje0Ss7RUDAAD0lZBz
 TsSyxGgBDOpoNI2w6fjBOiyRNgigPv9LtBGw9qYQeQEbCei51ZryUTLxb4u46RNTAM92
 WI2SVqL24pCw4M3E0PMvcwucl+q8GNcC4nKQaY3d71uHxho3iDxJeFqQYc60FU1oZ7n2
 Krcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023534; x=1751628334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QF6hdZWmESZx/oo7D4Z38KZfMJLBNKw+PdVmoS4LcNc=;
 b=Oq4cf9k56YwNOEq6GAtvVVeZKDurgYiskFH8rUw723QGBANPkCEj0kWgn4c0VOvcO8
 7b6Y9uWf6cfyRW4MYhxQkZITsipvc1g/EDLM0hvn42p3yO9bvKFR55PFj3MBEm9BUvIC
 oPpm+JctpImgFXTpMyW8nKJAQIlizBiAgbck+KcLQUELUms7SCWxXjiLr/JpPvWG/I3s
 p2/Jm4tJeNUEz8hbAjXI4UR79BGi2olvJ83M8OiF1SIX8LOl9SW1yBa9Kk5tcML5cY9X
 UQm2kJv3F4a4V5WfsZWhoH4At8FBUMNJYf62psg5bJtcy6yZZRlrn84R3Bs1gJ75HzCg
 UtPg==
X-Gm-Message-State: AOJu0YxXWhDmovmy/v7Yk+G6TZWpQaNlBU/qCpd1EHkQfjKgyZv70Dg9
 aXlbOc+levcU5b3DE/z1T9fTTzodLu6ipCTy7d2oxLNYgqFsmsnc8QseoUIBurmrwCA=
X-Gm-Gg: ASbGncs+/89prJ8CI8A86TLjwlo53npaj5FSwho298p4Ia9orCAwsiY3IDjD/pyvyIy
 fwGJ4d9Z1ZFy3KOjTFtRu0+yoiAKdzvgck0TWB58k+fOkU583x5IZH2nX9o1TgIbIsv5IYUa7mv
 zGLJQ/DrpV994EeYi3X+YzMzZIwMJc+JywMvoXYFxnjNVMX/FLcGuBxLYOKdcY66FJ/1qVBYOiK
 IKfAulLxqrK9fE8NkL3N8euLRhDxCxBdRRPZKLUX7i/Mo2er1z1ea9AafqdxEE75ucmszLqcay/
 +qV85LVovEy8JatkL5QQY6ByJQayVecl92eji+km7r6+ZG83APkeoxJcbHDxgiQ=
X-Google-Smtp-Source: AGHT+IGJf2WH30sWNSgwa0EBA8wpipWnFhJvCXFNSdBgRZn5W0Cs2ytvG1IbuXnhLzLQpznMYh1maA==
X-Received: by 2002:a05:600c:4e11:b0:453:7713:546a with SMTP id
 5b1f17b1804b1-4538f758197mr24870115e9.14.1751023534254; 
 Fri, 27 Jun 2025 04:25:34 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45380705351sm70294515e9.0.2025.06.27.04.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9447B5F91D;
 Fri, 27 Jun 2025 12:25:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 14/15] MAINTAINERS: add Akihiko and Dmitry as reviewers
Date: Fri, 27 Jun 2025 12:25:10 +0100
Message-ID: <20250627112512.1880708-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Thanks for volunteering to help.

Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-9-alex.bennee@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f96a8d956..83719f1309 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2678,6 +2678,8 @@ F: include/hw/display/ramfb.h
 
 virtio-gpu
 M: Alex Bennée <alex.bennee@linaro.org>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
+R: Dmitry Osipenko <dmitry.osipenko@collabora.com>
 S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
-- 
2.47.2


