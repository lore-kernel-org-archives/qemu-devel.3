Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015B9CCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 23:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHr3b-0000pp-JK; Fri, 16 Oct 2026 19:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHr3Q-0000pC-C1
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:09:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHr3O-0008Ji-HS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 19:09:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so3274625e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792192172; x=1792796972; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=np56ev6ZrXUUDJyT55I+NxWEm0VSZfVRUYQG3R+fPFw=;
 b=KXkkXBla9nNOj1mB6xufWb9p7oqRS3dCeKbFMKbBF364vkQ74/dYdcK1/DwcbjLJfi
 bjy7/bv9OjZu6TfftXXoa4waeTkZu+BV6rmgjj+PlCrjAkHCFShFtnJByxoOfCm0qa/G
 d0iwmZilE/fxYzZOiv8/lj0pQG7u/AxuhvG2slDTFCVgmQYR0F4jmVTKrqfCY8oHe9gm
 NoQhoZGOXsWVqU6yBsXBvszRwMrx5CUmGcZ0TjqiMbCyQI2E5Zu11x0Lt6nnsOGEl74q
 hW0Egm+R2Bm6OPC1UyxO6dyCXjbjZXULNsYVGIB5jOpNlv0KmSUn8WreIvOUp04g+lFh
 UC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792192172; x=1792796972;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=np56ev6ZrXUUDJyT55I+NxWEm0VSZfVRUYQG3R+fPFw=;
 b=brsYq5IN2zJzeT7ylsieHY7rM+4gEVUz3UMlQ3x+iMSyd8I1RbYzR4eiamS6lI35ge
 gv3HRV6RXZM64u2nE7RwmMvIL6uVvCPu0W2t/BG2QTUWQK7kZBNcbOlmvr8NlOeCI5vE
 FrcPg41EWGdwNLXkda8GOdM3gnBM7kM0TCxvRCd7GyCc/9d1Qs5atrvQ1Rf1EodCh+g3
 PYlutevnBGRFtVUarcZC+T361AMcDOCC8lo80tu/CwKRANztv3HqUdUt+dmeQdZfRyjS
 n67V355aG4ulO1mrnyVOWKdgKMaf/paqiS1anMMRfbahqjGU+jIBzvSeC2Er+1HIZrL+
 YF7w==
X-Gm-Message-State: AFq9FYJHSfWUWrlB6aBiYYqOTZJ3OpOeqLJrzY2Xy+SpyCPVka8JtWOP
 x+Gc0N1q6/udsHVmj8V8gko0/NXzeeqDxD9CkhzJw0PKVTTpn3+P41yF
X-Gm-Gg: AYBFou2bQmCuHubL/5hDGbALIaOfc/bmL4gjIYJJix4a5VuwoIhU/6mbphdI0+nCJ9x
 KgDcZfZCGR6AOl2xKulGyIhf4c8b6Vzu1mQfMEq4jWGOI5PIPyChQsghiwgGSXrEzAzu2xjnk06
 fQoOkKOEUQf6cIIP7DK5z/qFTHSiAr3hQ7zRVbnfTsCtXT7hJ9GeH6zuKDy5ZkSr2eZTtYgMifw
 X9OJYxo8ztA5fTHA1WHIctcSdwIxC2HFZlZV5LzSp3BV7zW7wYycjAEBU3tUbWJ9fxnprZWntFj
 zBNKu13CSiebNYXeRSyUeh5X6uqvsFBZ79EPsTGzaJKjLle0Gq6MgEFl7Ws1HoxkHNwZiLp6ZU4
 ZiLNsJijyhbKdFRP80l/eDNPT7OoavgjLpp3xaEv0w1WRtgmHzP/9CW7a8625NDkZlPMwhGSoZO
 XY7dSq1gF4MMLYN04B3FTua58f6tW5lIMcPdHxZrrpxhibpVzoj2l2WS356w/MUJMb0caJyEX45
 Qm8JdedMuTJnoizivDV41TLXRCdWAmfSBhagA==
X-Received: by 2002:a05:600c:34d2:b0:4a0:1c10:1372 with SMTP id
 5b1f17b1804b1-4a1d7614d3amr26885595e9.27.1792192171920; 
 Fri, 16 Oct 2026 16:09:31 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd96f9a0sm179876155e9.1.2026.10.16.16.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 16:09:31 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PATCH v3 0/2] io: make sure we don't close stdio fds
Date: Sat, 17 Oct 2026 01:09:07 +0200
Message-Id: <20261017-fix-stdio-close-v3-0-cfff0122a2a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WN0Q6CIBhGX8VxHQ0Q0LrqPVoXir/6N5MGxmrOd
 w9sbW5enu0755uJB4fgyTmbiYOAHu0YIT9kxPTV2AHFJjIRTGjOuKAtvqmfGrTUDNYDPZWllky
 pRhY5idbTQZysxevtx/5V38FMKZMWPfrJus96GXja/ev5rh44ZVSCaSvJtSlqc+keFQ5HYx8k1
 YPY+mrvi+izlnHQqmQg5NZfluUL7sejIwABAAA=
X-Change-ID: 20261012-fix-stdio-close-98864055d473
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792192170; l=1715;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=IxoUqjGMEYnmTUe3ybtkcVdXuy1ipY+LkiX7fgZ/l98=;
 b=GAOQ7/aymYDAorYH22Z/hP8BfX37PNn8judntLLGXbucwPFz9eysnOrM6P/RTsE7i2u9k90Sg
 isQPkws3uPGCOl6n71I0BMvRZ5IcKZpB6voj/+IirBo8RgSgtOsalrZ
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The stdio chardev currently closes the stdin and stdout fds when it is
destroyed. This means that, assuming char0 is a stdio chardev, invoking
the HMP command

    chardev-change char0 null

will cause QEMU to run with descriptors 0 and 1 closed. That's not a
great situation, as:
  - the stdio chardev cannot be recreated
  - code assuming fds 0 and 1 are open will misbehave
  - the fds 0 and 1 will get assigned to newly opened files, possibly
    causing them to be confused for actual stdin/stdout

The fist patch fixes the problem by duplicating the fds before they get
passed to qio_channel_file_new_fd(), the second patch adds a warning
that is printed when qio_channel_file_new_fd() is called with a stdio
fd and modifies the documentation of that function to say that passing
stdio descriptors is incorrect.

Changes in v3:
- Add documentation changes
- Link to v2: https://lore.kernel.org/qemu-devel/20261015-fix-stdio-close-v2-0-0f01e6580e24@gmail.com

Changes in v2:
- Code style fixes
- Set *errp when dup fails
- Link to v1: https://lore.kernel.org/qemu-devel/20261013-fix-stdio-close-v1-0-4ecfa416c7bc@gmail.com

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
Filip Hejsek (2):
      char-stdio: avoid closing stdio fds
      io: report a warning when a file channel is created from a stdio fd

 chardev/char-stdio.c      | 16 +++++++++++++++-
 include/io/channel-file.h | 12 ++++++++----
 io/channel-file.c         |  6 ++++++
 3 files changed, 29 insertions(+), 5 deletions(-)
---
base-commit: 7e8d3c7fc460fe7cd28a3e423d7466fa292bc269
change-id: 20261012-fix-stdio-close-98864055d473

Best regards,
--  
Filip Hejsek <filip.hejsek@gmail.com>


