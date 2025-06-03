Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE4DC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPPv-0008LV-G6; Tue, 03 Jun 2025 07:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPM-0007yK-1f
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:16 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPI-0002BO-J0
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:15 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad89d8a270fso1353020566b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948531; x=1749553331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLHAXd5IM7E3LOJv3AyI9ar9t7CdHBCtSRFXruIFS18=;
 b=LWtxeGy8qX1CFGgu9eipxKYVn4919sLdlolUJmAsmi5iMp7qwslJA9JpGwyLYg7qow
 IQN6QtYm4RjKs/8JltY5hqu1pdvJrPR6HrEmZCGk+weaw4QITV9+Es66frYAHJ37BFS+
 6V2j8ZEw8dJ7wX2IEFCamWFdhV63utK+J+U58+ag4+3t06ZJDam1tmmJ4qoCwndDIyIs
 NdaI4Ib+VvIpLucm4af25cT2BNts1VRf+4Qq8BnpUJua0vUdNDWhPKkcL68cDnaip+Rk
 UBVlDNdPJFWAnMhoRFa+a1YspT5uhc0i294EDxcxEOuOJSEdglvR4vIJEL6O5ecnNXmP
 6GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948531; x=1749553331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLHAXd5IM7E3LOJv3AyI9ar9t7CdHBCtSRFXruIFS18=;
 b=BjgKIOsUy5vWh5LzEpnFg5VHALgpBI1ZTX8SKS7Vlp4Zj8+q9RJdWZYSjHbbjixqNh
 i8epuU1gXoNYiHkgm2yMb4fm5H6dLiAQ8UFd08A0bpPTeS+pQgX+lRyG0/HusqvW10t0
 C8oWP5s3NYdkrVHpaJjktDlANmCoA341IZ8JVpd6T/SmdhU2HMK6LOMJm1305DgzEw+q
 uI+ndTpJC/hRuiqP/Cm4zeu1KlWt/CslnQvDU5mHcRnqTqBAReg9KiKNMgzys0s6ivIN
 Hlwkdz22RxE1QcS1ByM+H0Xqd+C2YaNaoGjenlUtuHyWd4ZHVg4WLXcR5k6TeqbJWmpi
 GtYQ==
X-Gm-Message-State: AOJu0Yw5ZwGFtq5loT2LRJxb0kG/1gPbABXTg2j1FJuHHT6yNZnlxFJS
 iPN+2P43AOWMUjYM+zC2o35ysGQ4aEZnC+treUD0pVzXNYRrfYMgUv9FuIYwPX3f2E8=
X-Gm-Gg: ASbGncv0N9DkjRHwvkKYb2uurxfFZmhkm0rR3HDhC5obN5KsPgC29sV+uGfHOaZ9sAI
 6xZx35FeBePmSA5ppBUBeMh/umMFi/Q419mhyoZIc+RLMCGJSuNIBjGKg7d2wvoniWhjTYGwTOh
 rSPfUVGm/2aCbppcnfWKZTfqihh2Fjhcd4Fz5Effji4P+dKrkBurJzB3lXGlXWPjSabAwRNRE0c
 u3gUs68r4qBGIqv+jsafVo+admA3IICrTaJiQVGSL+zqHdk+mTd144ITucn04Lv/V514pILn2pD
 RybzkWSkvzDicmQlwD2lPVrG40/L6HgeDEHNNCzXd2JBiCGWKTjI
X-Google-Smtp-Source: AGHT+IF/B2Yh7uAUxPJeeiVy7QhnVYMFAwL3ZHOfD5LthsL6b89cY3KgJORF8qB7DViR0EH5HevY5g==
X-Received: by 2002:a17:907:72c7:b0:ad8:91e4:a931 with SMTP id
 a640c23a62f3a-adde66fadf7mr201145966b.26.1748948530924; 
 Tue, 03 Jun 2025 04:02:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adde6f4b548sm81837766b.67.2025.06.03.04.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB69C5F9EA;
 Tue, 03 Jun 2025 12:02:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH v4 11/17] ui/gtk-gl-area: Remove extra draw call in refresh
Date: Tue,  3 Jun 2025 12:01:58 +0100
Message-ID: <20250603110204.838117-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

From: Dongwon Kim <dongwon.kim@intel.com>

This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
which causes some guest display corruption when gtk-gl-area
is used for GTK rendering (e.g. Wayland Compositor) possibly due to
simulataneous accesses on the guest frame buffer by host compositor
and the guest.

Fixes: 77bf310084 ("ui/gtk: Draw guest frame at refresh cycle")
Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-Id: <20250214170813.2234754-1-dongwon.kim@intel.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 ui/gtk-gl-area.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 8151cc413c..429ba914e0 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -168,7 +168,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.guest_fb.dmabuf &&
         qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        gd_gl_area_draw(vc);
         return;
     }
 
-- 
2.47.2


