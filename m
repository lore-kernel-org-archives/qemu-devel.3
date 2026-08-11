Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7312C5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthcg-0007Ov-3v; Tue, 11 Aug 2026 04:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wthce-0007Oe-5r
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:14:08 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wthcc-0005Zf-FB
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:14:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so1770103f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1786436044; x=1787040844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R7S39uQxz8DgeQ+qlTnBuuwhWWQyog1pObMiQJSp9Io=;
 b=aVeaUiw4sweSHE9NX0EsZEsk0gu2/jC2TazKmWhmasFTUTpt5AdXDlAER63qtWwF84
 2IwfgUuX30umzPJX6x3b6A4GBlwAuqgJeUnGB+IBFHL6QYIy7pGUw5uJn3lVgzVPyRJs
 QzAcF7pvgtGB5TQUgeB15QYOzDLFzjpg1xf44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786436044; x=1787040844;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R7S39uQxz8DgeQ+qlTnBuuwhWWQyog1pObMiQJSp9Io=;
 b=X91dZNr21xjYIbxjUq9oJoRuP7FoeCDbIXfQt1+gRPa/HJnxcKx3ru5L6mU7Du1Ch3
 RWjVZtHz+RQ1ZCYpcKLCFY+nZT/epd7jyJjsDfsAu8LsubOrJBereEepONUT76vNHxck
 zq+YJlwfkQ4a4QMyAlhwdaU4KBqc0iycTrMfGDuvIaTUkT93B9vxlcSla0/yjtCYD7LQ
 jkOrHMAqDLQx7bkTC4RuEqFi2SBQtNRx/50iLTYM/Qc60TRy8Zblo/Df9bee3gm5yunq
 k/+1DGpaa4bQtaJdEriOlRKh1wkdyACoV+tMChU1qGgd18hdWEX9hvcFhVSSENgbzj+j
 tCwg==
X-Gm-Message-State: AOJu0YyN4g83BaF6Mi/7ZZ6I9EyZJ16+NDLVCg8tY7Io018wZTdHvckr
 r3S1i1aubwVT08s43zpjZadxO6gx04Z4cVjyb2yfDrnZUWMdpEYe3jmJ0YYWPjvNPG+sTnZzwd3
 lGYbi
X-Gm-Gg: AR+sD11Itx4ZTQNrngXUfAIeik1Hj0aVF3eDdsR6WKBAU936pU/vNl2uSro06sWpT17
 za5nplws1YLnIUkLnX3QO2Y2l8ywkDL/Ct7NwA+7XRjd9p3pY/e8NIu84Kcv1G/VSAZU7hhQMDf
 E/0zEURtzmvR2+i0Za3UiBHSIV4OjBM0CKjZgqzkmxdN10R5q/jOX8Ade2xEX3xYfugFt/hLOEb
 arDuCs4rLIVUmkNIadnOz8adRqyaE/ckpd8bsPvwe0UoVwj8mHuUmesl5yLJV191LdOViWhx742
 tHmFvkw491Jj2eXsGsUaoZHuJdGBc2wfgIwEno+mZQHB3HPI18k1Dj11Ke0yim+aqfF3yDRf1cI
 4ufdAsT6QPYvgEQZZAynkl9g+jt12FWEOu0vycfDY4SPVxacO4gBAH9cS5by7gavsluvS0HGOw7
 ORoPheiMpqQN2toXUFiFwGPMD74yBGA0yaj5vhspjBq3LK6759Bg5iUhOv9QdO5sC8oQO19/oQV
 PQfz3XnxqN0kbdX52s8SgrHcZyFfc3QEB1QyhE6EUzvohAWfp88uMS+KGoBSK5pkGqLaw==
X-Received: by 2002:a05:6000:1449:b0:47f:fd05:25a2 with SMTP id
 ffacd0b85a97d-4814ad852b5mr2490539f8f.8.1786436043345; 
 Tue, 11 Aug 2026 01:14:03 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a72003269960306a2193b.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:3269:9603:6a2:193b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a5ac75dsm2164925f8f.7.2026.08.11.01.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 01:14:02 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2] hw/char/pl011: support backend hotswap
Date: Tue, 11 Aug 2026 10:14:01 +0200
Message-ID: <20260811081401.51771-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42d.google.com
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
v2:
	- fixed a typo in commit author name
	  [ I did `git format-patch` and copied this patch from my Raspberry PI
	    dev/test machine and it turns out that I have a stupid typo in my
	    `git config get user.name` on that machine. ]
	- added RWB tag from Alex Bennée
	- adjusted a commit message
---
 hw/char/pl011.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index cb12c3e224f..3622248ec0c 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -660,12 +660,26 @@ static void pl011_init(Object *obj)
     s->id = pl011_id_arm;
 }
 
+static int pl011_be_change(void *opaque)
+{
+    PL011State *s = opaque;
+    int break_enable = s->lcr & LCR_BRK;
+
+    qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
+                             pl011_event, pl011_be_change, s, NULL, true);
+
+    qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
+                      &break_enable);
+
+    return 0;
+}
+
 static void pl011_realize(DeviceState *dev, Error **errp)
 {
     PL011State *s = PL011(dev);
 
     qemu_chr_fe_set_handlers(&s->chr, pl011_can_receive, pl011_receive,
-                             pl011_event, NULL, s, NULL, true);
+                             pl011_event, pl011_be_change, s, NULL, true);
 }
 
 static void pl011_reset(DeviceState *dev)
-- 
2.47.3


