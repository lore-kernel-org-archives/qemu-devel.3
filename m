Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD586F41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcwj-00087c-N1; Mon, 09 Mar 2026 11:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwF-0007lD-4N
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcwB-0000Nr-F2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:54:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852ff06541so21303825e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071669; x=1773676469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OOvqoe7ybjz/sXWQnNO0nCuNJc5Dn+3Dmj9lVQ+2j/0=;
 b=CZFAPIM1U7BRbKfLjxqyrd1NwTzPsDIT+9DqxMH8vuY78O2pT4Gkt1ieiNfJSfNude
 XrTUY/Fsu7PQpct7Ljj3xzXdfeJn5F+uRB64BAa2tzRUNdhwKMeIS3UgPCRYPJzW4hHC
 1WveRcKuw4QFBdLbwHdAxYRw8ceQXIXY13aJLwUfAeVFF7L97OyU1hwP5p6z7SID/l8n
 sqlJ82UGTDX91xnz4KQMKqr+FMN60z+pHQoldMmlCrBey6KpuepcmOfrpfTAVaxcAlLF
 yN/ubFzR6jQvLHI1z6l3VRvoDFM3xNTjEirgONDHDwcnNc1m7v7GvsAjI/R/GAkZvhei
 YKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071669; x=1773676469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OOvqoe7ybjz/sXWQnNO0nCuNJc5Dn+3Dmj9lVQ+2j/0=;
 b=QlN/P3bCnbbooT8tvjNqSwybA53MQfA8KBlYLw+afIDpvu74qlA/9Ok3QbMIhsRUuv
 liLDj3ebgSmzPlTBond0zHCJSvjk5o50jDOx9gaQmDAdeosCOwCS6Uj9ENltsG9t7463
 0I6Es2NR1+wT3S0wx9CyiqVpmmLpKixYt4C+69r+Yi0g2z25sMcdk72nvZoOG177GzRN
 VbWBUk129pDBPxSFOsS63h7mxFsjdtmxcVsD+RqcueFDakt634RqM9esxhNxHWZlO/r0
 +65RamJBxQYh3leVLqICUA6Uh10y9baV5ikzB+1uJ+fQsbz+P9M7pdQYBDJDnM6z/IxH
 WHQA==
X-Gm-Message-State: AOJu0YxYjEPGeXJDwMvcOysXrW7HoaPweBY/AHgiJAvVVkEvjgM1v6ks
 Hp5zGLmKAAKx1vFiwbYvsgifsg3881S7ZJgBF+pfPVIn9Cmj4xpaqv6xq0D/uAnMmolboZEen7Z
 gh9lSxqw=
X-Gm-Gg: ATEYQzxK/z/B0bcnDRuZFxCXo+WGwTvIXVZRxEUNBM8oIDZYHM0b9mSWUkaAkXuXidW
 ESVxSTOvrD+064VUVgBXIwnlQ355YNvbL4UWZiZBRNk1NFDFCKbdAI3Lsf9xBLGvRW4MIJZC9X/
 /YBpJy8//myd0FFvcKws939dazGTjbJxn8AxMjr4asH1SNvsgHcCcCuCiExn+Bgk2+zHb73ViHp
 /D6ZEX5vATbF1Fmp0Pc5IeZWxw4G1NTiW0k9jkrIxrsjqVAQv3qCyjp5RM2wge1XAmgdjeAmg6f
 9i/Sqrzdu8RQxuA9+8TJ3ne0J0RrnJ5IM6dgeAw1mQzcIU8x30LeKJoWMfapYVrBuboJTYmInQ+
 jZx151h+ykfbCFPUtf+JRhZ45F7RAmRCJK+eDNH4M1BjatT0sMsMAbWjBJ3+7bBkh59vYM1f/+V
 WifVfnhkhP3Qlrri3NVOttyjcn18NqutYixnIoiNz5PNWgIRkDKx4J2sVCgT4eV+C3MLo9OYmx
X-Received: by 2002:a05:600c:350e:b0:480:4a90:1afe with SMTP id
 5b1f17b1804b1-485269785afmr180347865e9.34.1773071668993; 
 Mon, 09 Mar 2026 08:54:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a7f20csm926495e9.6.2026.03.09.08.54.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:54:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/49] ui/dbus: fix pixman cleanup
Date: Mon,  9 Mar 2026 16:51:49 +0100
Message-ID: <20260309155219.62400-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Moved pixman_region32_fini() outside the WIN32 block so it's called on
all platforms.

Fixes: commit 7007e98c ("ui/dbus: implement damage regions for GL")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260122113144.2046899-5-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/dbus-listener.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 46264839d86..3e2b4adf41f 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -964,15 +964,15 @@ dbus_display_listener_dispose(GObject *object)
 #ifdef WIN32
     g_clear_object(&ddl->d3d11_proxy);
     g_clear_pointer(&ddl->peer_process, CloseHandle);
-#ifdef CONFIG_PIXMAN
-    pixman_region32_fini(&ddl->gl_damage);
-#endif
 #ifdef CONFIG_OPENGL
     egl_fb_destroy(&ddl->fb);
 #endif
 #else /* !WIN32 */
     g_clear_object(&ddl->scanout_dmabuf_v2_proxy);
 #endif
+#ifdef CONFIG_PIXMAN
+    pixman_region32_fini(&ddl->gl_damage);
+#endif
 
     G_OBJECT_CLASS(dbus_display_listener_parent_class)->dispose(object);
 }
-- 
2.53.0


