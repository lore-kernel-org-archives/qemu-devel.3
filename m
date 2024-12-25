Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253FFE7718D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 01:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQFkO-0001Qd-B4; Tue, 24 Dec 2024 19:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkM-0001QC-6l
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 19:59:34 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tQFkK-0000NO-Of
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 19:59:33 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dd0d09215aso45904676d6.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 16:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1735088370; x=1735693170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mmBF5CVSuEv5Hs4OjTWSCjE9+8hQXVfJDcSidunhtM=;
 b=WOO3xvxCWM+27ikugG1EWKIDifmVqYoxb3lJ9RfZd2xDeRlWxCnMrGParS6OxmGM67
 2Emx2oj1pVuHjqA+oq+dIpLDfK8JfGUFRUl0FJcz0eU1BB51KP2FshZ6CnJSSO7EnNiN
 zTE66xNvUMjlCGa33jHFdDuHs46+bc84nxnpmvrna5ZGiZFCQ/iT7Ic2XybC+RqItwCc
 TkpK3PDq7Tav4NcDK/1OXqrKVL5ox8/Bi6TH0q7Z6ZAy4r7jjbFTaPpy8Z4x4RAfYVOs
 DBa7cWnk8dqbRY5QfxUIkTdnjhpgWTNGEQtQr6Pbq6EtOYH0gV9BKwOUchAayMA+XaH2
 oKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735088370; x=1735693170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mmBF5CVSuEv5Hs4OjTWSCjE9+8hQXVfJDcSidunhtM=;
 b=BVjRE+BAsDICYtg9xXSdgrm93tEwwQd2gP5e6yX0AsqDBlJJPV8Mn8wPCaBI88Oqfi
 VzHQUbwObFiTYC0ib7BqVHHUrFOXY45CwzXAyPq4iypqVb/K74kWYEAd31xXM9lAD/0Z
 wn69CQeTTZwlYdIacuF9JANZXkLHysY+vVFgSGxqhLu9mlFXtxH4p/oeVoADjmOqWeNt
 7XK/xUF6yaR20AS3+CGWF4pZyY5mtQIXu3BDEM0G+gnLLh0M76COiGorSadNu32/rOsc
 7hKltKYinFMiV9rAy8EhgbWstsSwZ9xDUA3aaVSsXIdRFrQXqMpvV8gT7rdneUAKM1bd
 bpKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTqInJzU6WbM9ahwmWIsilqTNnecUeECulbXMOnrw/uNWD7OybYR66OP4EMPHX+c8rtnqfu6tWIGrc@nongnu.org
X-Gm-Message-State: AOJu0Yzlqzrtd6YoXbzdFcN3TbWBdEx72sy8BpyMCgY6f1l8ytBkzOLv
 PycIFMGkdBHYtEszvJwqwAe7XAc32V8bVMRX/F/UOWvArlhoINxY2EGGczb0nPg=
X-Gm-Gg: ASbGncshmGLHPC4hGY/3o7PBlAcY7yq1eHX1rVbfAtyZ1FNV2zGvhwdNrJdLHduLeAs
 4OSS6VG5gLDB1vPvB54pCYgTi7LGNxW3wGF55U2h3TsKqCsox54qmxSI/CUOnpwLl1wFQxtTRw4
 r4fkwawyq+Fc/gWQCOEjYSQAtnF78reUoVYNwf/Bo8djHbVcMVBCinLm1Va0YrUlTSE3UE6doRT
 jOCngoNUJ/KxKPG+Eu28AvtvaUMARg/N98l44WdqeUZNRzbxjyX17712hr3t0VLNssH2yFoIVN+
 nBYg5aC3ITp58fW/oY0um4b75w==
X-Google-Smtp-Source: AGHT+IFuddFNQhTL9yYzHQ+Z6+t61LdjxQEt3LFift2xuwErAI+yR0ug0Q1dueyfeIMCEocPNhBf5Q==
X-Received: by 2002:a05:6214:21e9:b0:6d3:f1ff:f8d6 with SMTP id
 6a1803df08f44-6dd233acd14mr210807806d6.40.1735088370557; 
 Tue, 24 Dec 2024 16:59:30 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:1799:4ca4:2dd7:ba38:ecbd])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d244fsm57318206d6.98.2024.12.24.16.59.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Dec 2024 16:59:30 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v9 02/12] util/dsa: Add idxd into linux header copy list.
Date: Tue, 24 Dec 2024 16:59:09 -0800
Message-Id: <20241225005919.26853-3-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241225005919.26853-1-yichen.wang@bytedance.com>
References: <20241225005919.26853-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2a.google.com
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

Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 99a8d9fa4c..9128c7499b 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -200,7 +200,7 @@ rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
 for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
               psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
-              vduse.h iommufd.h bits.h; do
+              vduse.h iommufd.h bits.h idxd.h; do
     cp "$hdrdir/include/linux/$header" "$output/linux-headers/linux"
 done
 
-- 
Yichen Wang


