Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADF9CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PWi-0002En-HC; Thu, 16 Oct 2025 11:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWf-0002EF-EZ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:21 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWU-0001B0-OC
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-426ed6f4db5so1223023f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627047; x=1761231847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ft/uZKRt57FExqDKhDW7vwtqNjqhMjVJExGaxMf3Tw0=;
 b=nRmQwN1/WARNqQCaEhjebODDL52+pW1s94IRFgBiViEHb5vQuN/8/6aKE62cczbdyF
 0ja6vI1rnZaNaNo1Il9Ie/5MH4cGVBc8nP0tMO40DpmJO+uC37m9Jc3Bn7EkhO9Kr0m7
 fAeQYpvF8EsxFKsHkBF3u55fK52KFBvO7cElxUS3QsYm2KEuuDOb59/tADnTrNowd69V
 x8XxasD5t81Rqgy3nuD70AI6LVQ1fe5Uc5OZtASVY7/Lv953jJklBKyMiWagzRGiifPB
 O34KCnTBMKOmDSpUzwqFzAPWXLeB11XT6R427tIZ2KJpOXQZuIvt4uulipK6HkBnVisr
 MSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627047; x=1761231847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ft/uZKRt57FExqDKhDW7vwtqNjqhMjVJExGaxMf3Tw0=;
 b=fZoPYfFiF/wE4S9rJ25zOkncCr8J/bPO8qKZUg2cJKjNajhZb75TB72XNe8LDocKmc
 K7fh1tm2a1nHo/h1VI80+nELiBOCtpo9NIpNZHvMWvNgn1RytznKo41bYJZwrehp+1yQ
 khZXQO8UbyDVpQXotuYGOjkdUa/UQ+Bl36f/9MyPoaInapv3bbsdLhpWO9EF2KV/h/1S
 suAzZDaD2Y8HK2wrr5Wj97fj0ud2N0PNwXVLs2ZLr0uewQz9vSZcjFFrOqLTTFIaRHUk
 UwWnDtYZRL0qn+dogtkkInuZvvNnc9N9R+kl3vByfyxbhuLQRq4Js1XNI7LwqvXI4LVo
 CuBg==
X-Gm-Message-State: AOJu0Yxt0m3cjkIUfnUL6mAJdmxnKjGaXE4GRtH4rE5K9uO6hZ5ksRv7
 g7SkFWbfd80OFbYCYKyxsnPdjHnveHh7JX93/iRc5+wunbiv/9OEaPJf01OjLRApkCo=
X-Gm-Gg: ASbGnctAH7RASyu4g4e/rDkUfH5pO0lOMPAIN41fHgeYYvincLTs9dma4D5roUywBw5
 Lvp8QV46OVq3hWS99qIu87ciw6Av9SagubLU+MiGoLC+qmkA22rlpc6K83slWjDcVDFkEVKlTYo
 TEThIDDD1auPpN6m2DUOn5h7SI9N4dT/5tLVup6Jl+IWzM9eTB4F2kmCumyUo4g80TUYg1KMTs+
 dTZGRNSl8p+O7Olomn0uxPCLi+ZpAxDw4nNiLTi/BRjRF2Mj4kE1/l5BLYZafV55odbv2bC1Eks
 063CcQpPgsqMSJ191mbdW4pMLwgx0KGOI8jkQRKG5gW6XIFRfKTttlOcFtpZnPj2Ogr7RNLDeKZ
 aBid/LvqIIJZ2v1Pss8fz6ByWsYI2KNerjaUlzZpriCvUNkaJApGmSjwwEK2PDl3qQ1QBEMEQye
 qnWz95WMCB65g=
X-Google-Smtp-Source: AGHT+IEhGrVVisZ9mvuZ7HB+x3TwwgOtfFoKj1emarwEoQ+jEgFnV/guR98trF/hd1cU1ZGNXN7t4w==
X-Received: by 2002:a05:6000:26cb:b0:415:24ee:60ac with SMTP id
 ffacd0b85a97d-426fb6a19f9mr3180110f8f.5.1760627040634; 
 Thu, 16 Oct 2025 08:04:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5833dcsm34880030f8f.19.2025.10.16.08.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:03:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BDE085FA6F;
 Thu, 16 Oct 2025 16:03:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Subject: [PATCH 03/11] tests/tcg/multiarch/linux/linux-test: Don't try to test
 atime update
Date: Thu, 16 Oct 2025 16:03:48 +0100
Message-ID: <20251016150357.876415-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016150357.876415-1-alex.bennee@linaro.org>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The linux-test test includes an attempt to check the utime and stat
syscalls by setting the atime and mtime of a file to specific values,
and then calling stat() to check that the values read back correctly.

Unfortunately this is flaky, as it will fail if some other process
(for instance a virus scanner, backup program, etc) gets in and reads
the file between the utime() and stat() call, resulting in a host
syscall sequence like this:

utimensat(AT_FDCWD, "file2",
  [{tv_sec=1001, tv_nsec=0} /* 1970-01-01T01:16:41+0100 */,
   {tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */], 0) = 0
# successfully set atime to 1001 and mtime to 1000
statx(AT_FDCWD, "file2", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT,
  STATX_BASIC_STATS,
  {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID,
   stx_blksize=4096, stx_attributes=0, stx_nlink=1, stx_uid=32808,
   stx_gid=32808, stx_mode=S_IFREG|0600, stx_ino=21659016,
   stx_size=100, stx_blocks=8,
   stx_attributes_mask=STATX_ATTR_COMPRESSED|STATX_ATTR_IMMUTABLE|
         STATX_ATTR_APPEND|STATX_ATTR_NODUMP|STATX_ATTR_ENCRYPTED|
         STATX_ATTR_AUTOMOUNT|STATX_ATTR_MOUNT_ROOT|STATX_ATTR_VERITY|
         STATX_ATTR_DAX,
   stx_atime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
   stx_ctime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
   stx_mtime={tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */,
   stx_rdev_major=0, stx_rdev_minor=0, stx_dev_major=252,
   stx_dev_minor=0, stx_mnt_id=0x1f}) = 0
# but when we statx the file, we get back an mtime of 1000
# but an atime corresponding to when the other process read it

and which will cause the test program to fail with the error
message "stat time".

In theory we could defend against this by e.g.  operating on files in
a dummy loopback mount filesystem which we mounted as 'noatime', but
this isn't worth the hassle.  Just drop the check on atime.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/linux/linux-test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
index 64f57cb287e..bf6e0fda262 100644
--- a/tests/tcg/multiarch/linux/linux-test.c
+++ b/tests/tcg/multiarch/linux/linux-test.c
@@ -155,9 +155,14 @@ static void test_file(void)
         error("stat mode");
     if ((st.st_mode & 0777) != 0600)
         error("stat mode2");
-    if (st.st_atime != 1001 ||
-        st.st_mtime != 1000)
+    /*
+     * Only check mtime, not atime: other processes such as
+     * virus scanners might race with this test program and get
+     * in and update the atime, causing random failures.
+     */
+    if (st.st_mtime != 1000) {
         error("stat time");
+    }
 
     chk_error(stat(tmpdir, &st));
     if (!S_ISDIR(st.st_mode))
-- 
2.47.3


