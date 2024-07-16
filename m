Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058DFC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 07:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTcbs-0005ld-Fx; Tue, 16 Jul 2024 03:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbp-0005W4-8b
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbn-0006Ux-Jv
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:25 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc2a194750so17460355ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 00:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721114902; x=1721719702;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nndFPbveVHvyo+1OtPZPhuGcG+moLsZf8i7KbP3IDpQ=;
 b=GMoFgHI5HIZzLQ8kNbg//5h4gEezZOaEFSEdKu/O+PQ2O6ZNvho1xCu1g36MBR5XP1
 X47RiZuYoSHLKQt4JTXFX94yHItJCnQs0sP8xnU1jDVSDza6/NOiYg1CLqI8qCBjMdp8
 /1+vo4QNh4/hOXOhuD+6FywXA5vyjAXUMED5lvfSb+hGoYqkeno0KEH5wysFgDWlnOCr
 f3EGdSiNaI1GLzm+4zK+huNhEnhaLeePIn0An5X8UIlDZLW8mfJf6NYX0B0RTt4c/dMO
 h5p2bJvBApeIN+knpV4n9jM/lkQEHvKz70wbsqHXrq/DSTklbYP1SFLiDengbgkt1awz
 W3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114902; x=1721719702;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nndFPbveVHvyo+1OtPZPhuGcG+moLsZf8i7KbP3IDpQ=;
 b=s3qfv6ZtHLN4ctoA94oaCar0eq0TYPrjao3icHyuij+GjHXe/AtLQEcxnTISZIOBtf
 SKrXSWB/mx9KirIy7XVehTwQouOHyaD+UPF/DS7QZ64uVf3XKAFeoe5o7/EdM/DBu61t
 XSieFYRko3FZDZsbfHGkb0wDuu9mPBKDhprm5f5maPgeAvtYXHLzZzxsQYA85/C5NRKo
 v8FTExglBe3i9qhqg6nQZ3iiBqaCdOb4w3S6nKFDIXJsXbuy0WoQ0Te4tV5ulgNFGzrT
 DjD1UxGBV2OUjqD09Hk0DoUsykQ4/dEEq5JG/mUG2DbqcjKclg268Bz3nX5iYe3wCz37
 f2iQ==
X-Gm-Message-State: AOJu0YwGkAdfJ9ct8KlCo+y+w5tv6Vpn6o9jfcRyvWfpwTh/t21U0syA
 KIEaLrzGtitt+rsogHzwHVboHSPTtMT9Dybw5veXD9KJqJ3+XQBBWUkSKq9v01A=
X-Google-Smtp-Source: AGHT+IEf2tPScxuna9eeRgCVz8lF9FQkuOGJaZHKNKsE6KIk6bW1YyYbxUrsKAwx2smxtMUX6fvvGA==
X-Received: by 2002:a17:903:41cd:b0:1fa:2e45:bcb8 with SMTP id
 d9443c01a7336-1fc3d921be3mr10484155ad.2.1721114902296; 
 Tue, 16 Jul 2024 00:28:22 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bc45017sm52075555ad.242.2024.07.16.00.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 00:28:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 16 Jul 2024 16:27:35 +0900
Subject: [PATCH v4 5/7] module: Use qemu_get_runtime_dir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-run-v4-5-5f7a29631168@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
In-Reply-To: <20240716-run-v4-0-5f7a29631168@daynix.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

qemu_get_runtime_dir() is used to construct the path to module upgrades.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230921075425.16738-7-akihiko.odaki@daynix.com>
---
 util/module.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index 32e263163c75..580658edf486 100644
--- a/util/module.c
+++ b/util/module.c
@@ -242,7 +242,8 @@ int module_load(const char *prefix, const char *name, Error **errp)
     version_dir = g_strcanon(g_strdup(QEMU_PKGVERSION),
                              G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS "+-.~",
                              '_');
-    dirs[n_dirs++] = g_strdup_printf("/var/run/qemu/%s", version_dir);
+    g_autofree char *run = qemu_get_runtime_dir();
+    dirs[n_dirs++] = g_build_filename(run, "qemu", version_dir, NULL);
 #endif
     assert(n_dirs <= ARRAY_SIZE(dirs));
 

-- 
2.45.2


