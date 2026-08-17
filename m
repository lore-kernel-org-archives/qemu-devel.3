Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650A8C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvvbK-0006il-8V; Mon, 17 Aug 2026 07:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wvvbH-0006eX-Fp
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 07:33:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wvvbF-00059v-5v
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 07:33:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f92e3c14bso75668f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1786966431; x=1787571231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+JRr5THd9V5FxcrPVZRC9o711BRF+tkcolc4gE+ntNk=;
 b=idYyp5a4aO1l9lUfirJQNezvj1/qC2AFWb4jNFHj0dsUmoB/OIzHrxa21R7JqdiIgQ
 coRBO91wHbkmPfsLWTpR5yDYom8hg+Yf6D9t1cX/PyhSVFKG77l6MANd8wvIItiEiR3c
 0BKV4mDR4jdzv/c5lCcC2D0480yoo0MOqBV0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786966431; x=1787571231;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+JRr5THd9V5FxcrPVZRC9o711BRF+tkcolc4gE+ntNk=;
 b=shgUfpvMsGDZoxLhJYEhBNvFIfLnDEKI3TW2UCc0IeiVQxFLarQpZbDGIr6XxePF9V
 VGtdgip7EJuEi8FR3hUkZ3yPRmQL/fW+wI2214o+KvzbgeGxtitZ8d/2+W3xYqfoWpAP
 HMgoTGfGPHWgbQn2Rnu6Z4mYSJ6hADK6PHweDwDYXVoqvCZACplsX5py/3tWwqs7Ao3Z
 tG2cfJKp7/gdOQaj/ZvmtKHq7sDfe9Ph61d1bN5M6uKcIpfg85HrhoOaTTf8/2vrZdD2
 ENz6ujtTY9p9F3MuS0oY1iWb9DoUymKPztcy37Axu/wGw6bALhaoo8bEJYA/0MIokeGD
 bLFg==
X-Gm-Message-State: AOJu0YxY/bqMNSuYnbZQ6pfLKHdwHfWplAZB3zb3z4vNtngjXD6bsfOg
 iCkIeU3C+P3TT4GH8VaPYkQt4q4Ubiz1GROu3b1pDJRYWOnGQ5ncLO+zUkwypSFhBHHCedftF/v
 xSNVJ
X-Gm-Gg: AR+sD13q78LRZRgkdAFhXK8SBUAewRNBcPEokTr6oee8DwH50XSlmwQTup15yaLF/QL
 jERplAwxIl2Em4m59cPukC2CDKPMWM6r4Wi2qsQAas9aVUAg167l7HRENyxrXuzC8XxJHVjPQt5
 ScijVWlzpCbn5Sju87xHZdO88I2EjCm+yGpi3rO69v255BNPUvOupMEfYX97honZTk9+WvNmoLl
 8V1ynzhVeLchXZJ0EXCtYQ3eMDjW9dE33hKX46XugRwY9JBXzWRj/eJH8mFQ+52MEN11jZPNI5A
 jqPYcBkgMFzWKhDWyRp9BBJhj9ByM6bSAq1yYXx57b9ily6JqFwheJaxahHzqWxg3i758rzD4Hp
 ku7/olFYxNi7QYHJxZoc7k2FlDqq/XB/4DsnQb3TJhVEsicuRmrXj+MLFpVXtr10+Bo0keXLXnT
 hOF67KqwhbI/CpVB2NJMVysMJPJ+1yuNhTPTo2WTIkejSnK6PPxRYI5mrhdpsrAeOJXNyHqn/jY
 /nNiD3dJSTefahe132zRw27SI5Bv5mag9vX7lI109g9gooec+qymYZuVwg=
X-Received: by 2002:a05:6000:46c8:b0:482:552f:ef68 with SMTP id
 ffacd0b85a97d-482552fef9bmr23788324f8f.19.1786966430915; 
 Mon, 17 Aug 2026 04:33:50 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf573be10032bbd7f65fb99e30.dip0.t-ipconnect.de.
 [2003:cf:573b:e100:32bb:d7f6:5fb9:9e30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b77f41sm3123140f8f.27.2026.08.17.04.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 04:33:50 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3] hw/char/pl011: support backend hotswap
Date: Mon, 17 Aug 2026 13:33:49 +0200
Message-ID: <20260817113349.103833-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x435.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Currently, when Incus issues "chardev-change" QMP command to change
chardev backend from ringbuf to socket it receives an error (with aarch64 VM):
"Chardev user does not support chardev hotswap" [1], [2]

Let's fix this by properly implementing BackendChangeHandler for pl011.

Please, note that we have to "replay" CHR_IOCTL_SERIAL_SET_BREAK, because
if BRK bit was set before backend change (i.e. (s->lcr & LCR_BRK) is true),
then after change we need to send break to a new backend too.

Link: https://discuss.linuxcontainers.org/t/unable-to-connect-to-vm-console-on-arm-architecture/23096/3 [1]
Link: https://github.com/lxc/distrobuilder/issues/892 [2]
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
v3:
	- introduced pl011_set_handlers()
	  [ as suggested by Alex Bennée ]
	- introduced pl011_set_break()
	  [ as suggested by Philippe Mathieu-Daudé ]
v2:
	- fixed a typo in commit author name
	  [ I did `git format-patch` and copied this patch from my Raspberry PI
	    dev/test machine and it turns out that I have a stupid typo in my
	    `git config get user.name` on that machine. ]
	- added RWB tag from Alex Bennée
	- adjusted a commit message
---
 hw/char/pl011.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index cb12c3e224f..031afa5b246 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -425,6 +425,15 @@ static void pl011_loopback_break(PL011State *s, int brk_enable)
     }
 }
 
+static inline int pl011_set_break(PL011State *s, uint64_t lcr)
+{
+    int break_enable = lcr & LCR_BRK;
+
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK, &break_enable);
+
+    return break_enable;
+}
+
 static void pl011_write(void *opaque, hwaddr offset,
                         uint64_t value, unsigned size)
 {
@@ -462,9 +471,7 @@ static void pl011_write(void *opaque, hwaddr offset,
             pl011_reset_tx_fifo(s);
         }
         if ((s->lcr ^ value) & LCR_BRK) {
-            int break_enable = value & LCR_BRK;
-            qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
-                              &break_enable);
+            int break_enable = pl011_set_break(s, value);
             pl011_loopback_break(s, break_enable);
         }
         s->lcr = value;
@@ -660,12 +667,29 @@ static void pl011_init(Object *obj)
     s->id = pl011_id_arm;
 }
 
+static int pl011_be_change(void *opaque);
+
+static inline void pl011_set_handlers(PL011State *s)
+{
+    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
+                             pl011_event, pl011_be_change, s, NULL, true);
+}
+
+static int pl011_be_change(void *opaque)
+{
+    PL011State *s = opaque;
+
+    pl011_set_handlers(s);
+    pl011_set_break(s, s->lcr);
+
+    return 0;
+}
+
 static void pl011_realize(DeviceState *dev, Error **errp)
 {
     PL011State *s = PL011(dev);
 
-    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
-                             pl011_event, NULL, s, NULL, true);
+    pl011_set_handlers(s);
 }
 
 static void pl011_reset(DeviceState *dev)
-- 
2.47.3


