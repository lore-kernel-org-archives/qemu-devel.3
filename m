Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC99BCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298O-0007AM-Bh; Fri, 26 Sep 2025 10:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298G-00079I-SJ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:09 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2984-0005cz-5O
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:08 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so1433830f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895729; x=1759500529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LteooIRckejsKoiNLalnbU5BZGqP5YHRgNXf4dsk110=;
 b=mtLJGN1K5YZ80zbZ+WUW8oVTo+blpH+o2180/LUFq/1oPL23tm2sMWgtOSnTP3Ey3n
 qrF4mzZnOpXeyPFTDLzKbkbVoKu5oP5i/HH/2djf2ImNtuNskbQnLAGaIynopoewjbmS
 ejTAERHU2RlgGlUtz/Sk9KCySbkHcJ7Sx9RzOATrtyAgTWMZYlr25u8RI+2fBvTS/cVx
 d9bIXd8ycHZ104DiB046cRLvnP7BB0EiZfJ7InSD6/WDs99Jze6t9qKlrWVm4DatOwW3
 zQxtI7AYLvxz0TAa3j/wP9FCRkyW8Cd7jfC1Pdh3mKJBCTgcBW0sizT05/oJPSS5wjDR
 ICBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895729; x=1759500529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LteooIRckejsKoiNLalnbU5BZGqP5YHRgNXf4dsk110=;
 b=ZN7l5Gb8qGjX601ygOAMABiNUUsa1Q7D/uAlp+JleTp5fcZqOhifsjcg+FUxmkyHmH
 9sAsROl1lpXXkDyOrVVomBPMTBW2OPyz2NP1tYpFRkLDuqG5hFQms0vwU+3C8Ujl3ls/
 I3TasDhUCWIy19xxsQl/xVuNUn/82HtPvr1V3P3s/u1YgygpZxFTJ5t8OAt/rarBjI+w
 t0kvBsCdc3StZy3cYOVOaQJHPaxCI+mGDg1coDcjsNh6CChMPKwLkAtOY/ITOv6ZYr6X
 YsD1atldwjsQXW3yONS4M+o+Y4lQQMC8J/gSFMEOAxgKNlfIVkHsD+MCmSDULYSdMuZd
 qV7Q==
X-Gm-Message-State: AOJu0Yzn3QoXl74AT1xNrco1ppRgKSxfUEnuvgullxGVuBuJqRJ3VYhA
 i1HFg2lUt6vq4nsJkoLJoqIC9KHspwqhTjem61mbcJY4abE8juZ3GjtQtaPhTnjbSbsxCUGjpcu
 6IESK
X-Gm-Gg: ASbGnctXhIe8tWnmBA4sxV81evgrEEuDqMkqHlBN/eooJyRSlcMZnmDiU6HshWT3h4U
 AH6t9rBIW9KqSh1RRUn2uH0SiY0rDqs8iMn4AQGBqfokkxSNclAt9eSBDPXAwilkPnmNoXBkYwV
 mewWbcn17tfTAwiqM94RBDRRv7r5jG2c+YnGVEa08hDoossSe92HtvBHJQda8+U9OMBhnyNnt5Q
 BJCcUqAMvSsmKwYseMtfJP8OfD/nd8xRIAVYVaDdTF3sMpGR4jYbB3dNeJ0wEgsuhvD2wy6Qxv9
 uyXdkOCVqpSvn8+OOhqMd96Sg+MYGohAJv8sVlPvvA250s4zPxp9XqCZntSS3kdvisso8Nl90WN
 olY98mS1toYRSoznJ+e5mcqsAu3vxXtHXAeorfRw=
X-Google-Smtp-Source: AGHT+IFiRiSDZ2YRmxIIxIX0jH+HDHQBa2F+T+f0CmG9OBsv7KjshEUKJKlWdRCH82hkfwIWbtfz7Q==
X-Received: by 2002:a05:6000:4282:b0:3dd:981d:43a5 with SMTP id
 ffacd0b85a97d-40e4b294eacmr6139675f8f.47.1758895728770; 
 Fri, 26 Sep 2025 07:08:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/44] net/passt: Fix build failure due to missing GIO
 dependency
Date: Fri, 26 Sep 2025 15:08:02 +0100
Message-ID: <20250926140844.1493020-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

The passt networking backend uses functions from the GIO library,
such as g_subprocess_launcher_new(), to manage its daemon process.
So, building with passt enabled requires GIO to be available.

If we enable passt and disable gio the build fails during linkage with
undefined reference errors:

  /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
  net/passt.c:250: undefined reference to `g_subprocess_launcher_new'
  /usr/bin/ld: net/passt.c:251: undefined reference to `g_subprocess_launcher_take_fd'
  /usr/bin/ld: net/passt.c:253: undefined reference to `g_subprocess_launcher_spawnv'
  /usr/bin/ld: net/passt.c:256: undefined reference to `g_object_unref'
  /usr/bin/ld: net/passt.c:263: undefined reference to `g_subprocess_wait'
  /usr/bin/ld: net/passt.c:268: undefined reference to `g_subprocess_get_if_exited'
  /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `glib_autoptr_clear_GSubprocess':
  /usr/include/glib-2.0/gio/gio-autocleanups.h:132: undefined reference to `g_object_unref'
  /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
  net/passt.c:269: undefined reference to `g_subprocess_get_exit_status'

Fix this by adding an explicit weson dependency on GIO for the passt
option.
The existing dependency on linux is kept because passt is only available
on this OS.

Cc: qemu-stable@nongnu.org
Fixes: 854ee02b222 ("net: Add passt network backend")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3121
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 72da97829ab..bdfb6214e6f 100644
--- a/meson.build
+++ b/meson.build
@@ -1280,6 +1280,7 @@ endif
 
 enable_passt = get_option('passt') \
   .require(host_os == 'linux', error_message: 'passt is supported only on Linux') \
+  .require(gio.found(), error_message: 'passt requires gio') \
   .allowed()
 
 vde = not_found
-- 
2.43.0


