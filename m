Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578CAC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 04:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7oXy-0005i6-N2; Thu, 24 Apr 2025 00:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7oXv-0005hO-LZ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:50:47 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7oXt-0003W0-Ld
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:50:47 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-afc857702d1so443196a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 21:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745470243; x=1746075043;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YpQVNvyURY83rQ+0SoqZteehI+zIQXlO14ywFIRoUsc=;
 b=vWUWgpDsgJFBbqWfcuDcG9VwT8QyZPlKmuqbtYScWZ5JNtcjejUwfIi0UJaH0sHsT7
 zTwVvHtvWLubeSoe13sYtd4XNEnPActsT+Bv6MOFLIzbqqPTSAQXPyXCYMgeYDVhIQYZ
 pzxfgCNua1jxqxn2QPLwJRVNIdODNasZ/RfpsKnSEDOOIVZYSqCKubPkLG2YiihPTi3h
 p5lQb0hQdmDq73wvj9TSfkK0HeyRRB9tg3n4BanzpLV5iNeFwGUw9mKFJbhXnyCN3JGZ
 TNWGULZaYf+VwO4mOv6BGl40KhCz4Ht3dgp3wG/+xrec0GFk5skAXqa9XLbBHShUov6l
 Upqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745470243; x=1746075043;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YpQVNvyURY83rQ+0SoqZteehI+zIQXlO14ywFIRoUsc=;
 b=R1xWL7HE1Xm2mobtyB0SlYlPsZSv2DHUgRRebcXILyEs44jFbmEWAwzNkUHCGSdFj4
 kdkgZRGQowCQhMNW2nV5a82xIdlGKU40gAeV3IfblrxXZ/rl6UYdrqnMQ5iK7ssnJLiH
 CZlxrK5hONeBaOvfhau0cghM6Dx7HjzqybBa24IN6/NHV/9TWAu/gCIxH2BR7FjPYMmX
 1RiA8nRJmvZEiwdVm4VXQ5VmvAkfILDNiOX6MiE+tBvWERb78pK7IvwKOw9qYd1AMxbh
 6C+It+bzcVbOIjZ46nfEW88dZmCU7XdPHFewCSJJjQ2oyjun43Bgzq19hcvlmQeYqoEM
 4tNg==
X-Gm-Message-State: AOJu0Yw/JHFLU9hzkduCo1N3/U4OJ+wlIMAVxZIdebMyzy9vQwJRuEKs
 lVMDMkkrXU0QtQmBN0K44s1mbiPJItJxQD8yKWQSNmf/al1Dgmlacvwx7Ks9MrE=
X-Gm-Gg: ASbGnctBzOQSLnhs05iqcHwo7Up5pKI2Oc5+eiqBHIKnLniP5qrldCJNeOdXc5nEDUM
 pAGNcHqvhXe+mZi3v9Sh7/xr37TZwqiRyKZlr3kpQu6R/0lZ0WYpnmbYBBHhNUdCFGLcpdF5ULc
 dVL1bvPYmS+vnte0CjI5L46Fe2T18KUibzO5+kkSqwRfYlrQPNltsuhwALe9jOCy+qoGHSfHyrc
 W/OfaZg34mUofic6i/zaTBLYMe9q6u1BL11RwHDP6w+bXWAbzwUhDCz7RFuKMPEWU6JOrxHkJca
 igFhHc1jNRlbT6OC8NJ2d/8IozofKKedQd9+j4I4prVfkxQnE57przo=
X-Google-Smtp-Source: AGHT+IHXoJ3/QXAc0kbduRpnbwtd51GOmBepvpAuCwQzO1wrhAA8CwGoMEYVDu7hds9AmfweVv1VGQ==
X-Received: by 2002:a17:902:cecd:b0:223:65a9:ab86 with SMTP id
 d9443c01a7336-22db3bdb024mr22000015ad.12.1745470243697; 
 Wed, 23 Apr 2025 21:50:43 -0700 (PDT)
Received: from localhost ([157.82.205.213])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db4d76e0bsm3638505ad.43.2025.04.23.21.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 21:50:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 24 Apr 2025 13:50:12 +0900
Subject: [PATCH 2/4] meson: Remove CONFIG_STATX and CONFIG_STATX_MNT_ID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-buildsys-v1-2-97655e3b25d7@daynix.com>
References: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
In-Reply-To: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CONFIG_STATX and CONFIG_STATX_MNT_ID are not used since commit
8ab5e8a503b5 ("virtiofsd: Remove build and docs glue").

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/meson.build b/meson.build
index c0ecb6feab77..1a02cd89903b 100644
--- a/meson.build
+++ b/meson.build
@@ -2191,14 +2191,6 @@ gnu_source_prefix = '''
   #endif
 '''
 
-# Check whether the glibc provides STATX_BASIC_STATS
-
-has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_source_prefix)
-
-# Check whether statx() provides mount ID information
-
-has_statx_mnt_id = cc.has_header_symbol('sys/stat.h', 'STATX_MNT_ID', prefix: gnu_source_prefix)
-
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
   .require(host_os == 'linux',
            error_message: 'vhost_user_blk_server requires linux') \
@@ -2560,8 +2552,6 @@ config_host_data.set('CONFIG_CRYPTO_SM3', crypto_sm3.found())
 config_host_data.set('CONFIG_HOGWEED', hogweed.found())
 config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts == 'private')
 config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
-config_host_data.set('CONFIG_STATX', has_statx)
-config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
 config_host_data.set('CONFIG_UADK', uadk.found())

-- 
2.49.0


