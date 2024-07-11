Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25947C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1io-00040f-OH; Thu, 11 Jul 2024 17:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1im-0003w6-HE
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:00 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1ig-0005YU-7v
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:53:00 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-703775e4d5dso678051a34.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720734773; x=1721339573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOMeFKnXZZxuQzQ4Ug4ts6vhOgDMsElUKC3GROOqZJI=;
 b=FTLt1zdLF5Tg11PWxTq+7mQ2KaRGtDh6MjPwsC8S9t5rScb+rbX18ccykE6+x9XVFI
 QfXR9fGCE7gXzjdhp7/nS9xft+zAUB9G6zTYLJY8SNojW+zY0h+NIm0d8qRhoYqQp06P
 O4QcMz6FuKt1un3bkg9OyBE6sBbzevjgoZOdv8WBE/TgI1S5tXn3FCh0OH9AuPXiuWmS
 hbKiI3iNFKnXQi7FuyN3WbgCIAVZ+px8rpRSiZ32CifllVoGZQ4wlImauUj38zBA72Mf
 CmDPWpllqwQ70fWPVjlnVM+LPfCOEAuzqCFm6nMjhNwWGGcNcHT33PhS9YAPODdL/lWK
 T5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720734773; x=1721339573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FOMeFKnXZZxuQzQ4Ug4ts6vhOgDMsElUKC3GROOqZJI=;
 b=AzZ2jFwLRtuCEIMb9kapMw6MNqUKQuMfqTav5vdCvZr6sXERbNr9px2ibzatdj95kV
 oqZVXvaAiaMf17YhdUDxFBazY9iKLDQ8nYmpxyOj8La0pAkVauPG1pl2FUbIjXCBIvym
 fQik7K8C4A8iYXzRYO4mqSuY0RpuEDfcsMeKIiRxFpk7IvCI0+pPyN3ooRGiUqux5zE5
 dcomqqsrL/I9ay7bCOijW6yL+7yLQv7aswVMKgws4OBpvspBw9tujD3adKMb1cs3Xh8O
 PrpFm98UpKvbAv93S9dK0Eg/mbCEztUleiDWDlDf+WBjYeS8U2L204bHXxrsZf3PqfgZ
 Wv6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH9AURWZtJE1vlE28r+e5ii1A85C/w6zIdt9sGfgt41ndHmYS7gPHBSndgB9pAnJhHy4dJaEzGsuqGckXyaG68FUrtj84=
X-Gm-Message-State: AOJu0YyGs2EWajVdhhgCktuuRZThe34uFghTsLHB0fHx2J5TIzHZc9Ow
 wZGOkfKjcM54mAkUxoJP3W+f4Q355RO8akqJ0GPc5T9n4BMff8nXQ3dhQ0HyiBA=
X-Google-Smtp-Source: AGHT+IHzFlqKU2qpZF18tXY6Jqt2whh20atIX/FwpcZMEpSuSAolTOEUtWHlyfT6Omp8BCtePHdHsw==
X-Received: by 2002:a9d:4819:0:b0:708:b286:f6f1 with SMTP id
 46e09a7af769-708b286fcefmr2768816a34.13.1720734773065; 
 Thu, 11 Jul 2024 14:52:53 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7044ac2876dsm713125a34.2.2024.07.11.14.52.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 14:52:52 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v5 02/13] util/dsa: Add idxd into linux header copy list.
Date: Thu, 11 Jul 2024 14:52:37 -0700
Message-Id: <20240711215244.19237-3-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711215244.19237-1-yichen.wang@bytedance.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=yichen.wang@bytedance.com; helo=mail-ot1-x32f.google.com
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
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index c34ac6454e..5aba95d9cb 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -193,7 +193,7 @@ rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
 for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
               psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
-              vduse.h iommufd.h bits.h; do
+              vduse.h iommufd.h bits.h idxd.h; do
     cp "$hdrdir/include/linux/$header" "$output/linux-headers/linux"
 done
 
-- 
Yichen Wang


