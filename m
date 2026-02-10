Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C866BEA8126
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vppLJ-0002mi-Bh; Tue, 10 Feb 2026 10:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vppLG-0002jK-6V
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:07:54 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vppLE-0006K7-6J
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:07:53 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d196a2334fso4879508a34.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770736069; x=1771340869;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MeZ+59gNiVqHrggwqoOBFggj7Wr+waTH+fQU0MV2pXc=;
 b=zkk1EtvqQ+So+tM4F7i5NOLq9N/DOnwkf1xbIsXPXy0LFOH1ztChNxK4jyx1QCevPf
 JYYFpZZeswBKWbJBeZjMUVIXiOpVWKk05u+T/zy4+qOnpXBOxVqOCD1gpIFWRFOxwwm+
 QuhQHb6srP0BklM0YKbnHzyafIJxSaOgeQdKhtCQ5irKsIY48GCCQdgqfXTs5d9TGphQ
 C8fhVnrz5E6G4xHH50C56KC8XvBCmpU66obgnJBxWf5blCOYu4AtnEJtRtp4jK7MpMDM
 h21StkY2EzNOJAZ5b+WRDbgRiWSm2fXljmRBgdfLVJ94hbbrtETFs1mY24/vrf+ppsRR
 2I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736069; x=1771340869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MeZ+59gNiVqHrggwqoOBFggj7Wr+waTH+fQU0MV2pXc=;
 b=g0bliOHG1o6d/PHUMoHjlaBM86qcql1VS7LxRq6T+HoJlZy/g6EAYPbqFq5Ifz3V90
 Fo5c0q+pXD/bb2V/4A8DK8EkebnHAAKiP0thvdn1KzTZfxS6CNvGPqMk3128U6wwUj10
 OIIvRMEdiitU3vMgJJqYo/7p1PBVaf8MHI/2vrWqNblbxmfjpJTmnHfhsBoqI5BUPMqZ
 GneX3FUVhUc9Gj9NfizDvPnx7A3FBz826ttzcv5q6W8ztcBvAyTIkoHAjshleUxvMid9
 47qzU7ALrgWprH/AQwkn28GNhRo3yzxHpjGx2ZDgvNRuNcR25tPP12wqbCPcd2klmYOi
 CfkA==
X-Gm-Message-State: AOJu0Yw0nvIwf88wb1Tq4/VkXNFEzgSB2SEXd9ZXkzEHanyryL9xhr9a
 8P1pD+LwyCRDycI+JKpxJV6rjQcNUmYRjdtKUdq2xBF1joCbwkOA5vXGzN1efxlXqOs=
X-Gm-Gg: AZuq6aKUF6MaANiRJhQ3ZISF+pOxODh1CUcx0OLmkSFvBYp3hao+SC3SjKe5KHXzrnF
 XpAyyd+UzUBb+zNVrm2AV1lHDzpec/l66Kq1oJMNSX5GtqKgV2RYW7C9d87wZQtY84nZWkRd3AQ
 KNqydej6Vo4df/+J2pNI9XhgUrNe3gn5QZZfifcX+wNLqJyfNVY8WNaEIE9WSIzxTYlv5Y1LorG
 yOpQVaqCbeF5E15bkG/beZtnoN4uq6BZYv2EHqLWSYMVsW8rgzEw++8ekFNJcpGl+tDlfVY230+
 gz1ZaE9uzyjeQLMHqh21lSK24FgbAKFkKbaHU+Rsa6b7W+y05kEQ/IyLDMN9c97RvRtFdXS+FBH
 QX1YgAOheuL5Qi9CB8gRd6jfJQ19JhDrTRdEW+dmblI7MGk9GUhVvakum6MUxw4Ds3At9P+juN3
 og6FWqPSzjeA==
X-Received: by 2002:a05:6830:3153:b0:7cf:d14c:ca0b with SMTP id
 46e09a7af769-7d49928c8b2mr1366485a34.4.1770736069697; 
 Tue, 10 Feb 2026 07:07:49 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4646fb56dsm9986510a34.3.2026.02.10.07.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:07:49 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 10 Feb 2026 08:06:49 -0700
Subject: [PATCH 1/3] freebsd: FreeBSD 15 has native inotify
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-bsd-user-rm-openbsd-netbsd-v1-1-8b8b0f50c29d@bsdimp.com>
References: <20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com>
In-Reply-To: <20260210-bsd-user-rm-openbsd-netbsd-v1-0-8b8b0f50c29d@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=68+yfbEHIriU0SPdvX5NtyboUt2TBRTmYMDYDdpKqn4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpi0nDljnNvvVgYeqGzRGfODQQDC91p9OOJGSJV
 dQZgnoWL6GJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYtJwwAKCRBsHNEofbAR
 AIZ/EAC2k7Fqp5BGPxAqtCi0kIKg4S3cxrt5JfcscKsGEGfJeRdvFSPCNxadDR2x1JYup7Voy5T
 0yQTtKWgjLiB28xKuzqlN0GC+E+UjNIiacKV2MopgCjRrHI25S7GJL6K/rTyF1vB7OPjE1FXMBC
 Ri55AELZJjmbzgpHixvPg+/xjqVzioYAOHH1G5l2MKmhct+ImsgjIfx39ReIDeJzrAWD5LNrYHR
 VYNqFqfMREjkLFWPN05F+l+bHdmkMFwtwQ+WBCuFt6kxlxQbwY+720fekF6B4auM/0Ins8ehWEP
 y0cf7tKhDt+mm85AhSNl7hKMGiy372poIQ7bHLYkTKQOqDv+WVUbwD6+KJSLTpYtOGtTDMgKtoO
 5tA7Ur/k7taxg7yDW0lzBQKPiU3rIpft8hk6yGEaUA3vtX3y19XqsbqEgnkVozRqV6X6YnHUCdG
 6ZcfxBEUFDppqG30GZQAsSEzBNVDjTQAoDvy3Z37fjUC2IjUL71UG+/SJSoYwC/pC0ZJ34ajmGo
 9x4VtBwY0Tx0Ln3UsUHiAU+qP5mb5cV5eNyvp0sTX1Pmi8TE+D3g4tMMj0kYbEzWB8ylPwRumtR
 SFOsodgVxAMdvFAqlkCKH73SiOIFVxpPQu1HFDqvrblLIApr7KE6Rw8/FF5hEvKiaTPBFf40DMO
 H6S06p03OIWtHPw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Check to make sure that we have inotify in libc, before looking for it
in libinotify.

Sponsored by:		Netflix
---
 meson.build | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/meson.build b/meson.build
index 2d114e9018..537f50283f 100644
--- a/meson.build
+++ b/meson.build
@@ -2662,13 +2662,15 @@ have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
 have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
 inotify = not_found
 if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
-  # libinotify-kqueue
-  inotify = cc.find_library('inotify')
-  if have_inotify_init
-    have_inotify_init = inotify.found()
-  endif
-  if have_inotify_init1
-    have_inotify_init1 = inotify.found()
+  if not cc.has_function('inotify_init') and not cc.has_function('inotify_init1')
+    inotify = cc.find_library('inotify')
+    # libinotify-kqueue
+    if have_inotify_init
+      have_inotify_init = inotify.found()
+    endif
+    if have_inotify_init1
+      have_inotify_init1 = inotify.found()
+    endif
   endif
 endif
 config_host_data.set('CONFIG_INOTIFY', have_inotify_init)

-- 
2.52.0


