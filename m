Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFCED6A248
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 22:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBhuZ-0003OM-SS; Thu, 14 Nov 2024 17:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhuP-0003Ma-Cn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:01:49 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tBhuN-0007do-NZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 17:01:48 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b35b1ca0c2so130907785a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 14:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1731621705; x=1732226505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xY5QAGLhchl42gNHNAI66DnGmTQK1VTLeOyVk0oAer8=;
 b=DBcJh8pNZYpyFWJTsq0mv1bVwhtPot0Q9O3Fz6rao6TaoPWosk17uzDpnWMFydL7mX
 hDflK6NnLtGc13FVXZcUrr2XLy7fxypudX53/pGDpQsfcJ+MdaKCXf2yE48XzOwCzDza
 yjIuOHsQYamrkuuPt+trQ3noMvvepRVSAu91uzgod5XAsniTFzH9kJVb2CYrYXcdhMOp
 7l2ezcNHFxrQ0f8anhIYeblLRmDX7bQqvOQJ4vTJhqkI9DYRAliSlcYiqAw58PVUfJAf
 2kgo83hxjJXt2JZIOuTQjcGc+oQpOuRPktFLT1KuUrThfVVl7ekPsy3DeG0KNZacRJZw
 aSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731621705; x=1732226505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xY5QAGLhchl42gNHNAI66DnGmTQK1VTLeOyVk0oAer8=;
 b=ASLS5/Ta6sOlw1eLy45GZos3kEUQnttnsp0XZPVHwPHv+xw8KOC5c2LPg1oUVJwtFi
 mIBuX8cvUxikz/TIes0+dMU3Fq9bfPOo24EyGXNgRcyA4xZlJwsETL0nSQ3XbsCGr1Sg
 174+FQzgyw/HU/URoqrLWaoqRLvW4gARoKbsm3XdPlBMb1rGuKagEG9pKbPQLK0BxXE6
 pBl+cj0DroINfsk5JUd+ox/u2VWPlQZ81hid4jnhLmnfTrwMJYmEv6d/dUjBppSMRar+
 H7FDqyGfB2hOgf6U+2HAl+KR+zDCbPP5+eMMoqtwBj+69EBaygq4RQ9TY9TGQKeHgB1t
 UTLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn8DxQI2Z4/RBRoQKUjARISQgbGyqMkwmawRd7MOlmSdxyAAN4vJWWOGPODrDK/fjeeXrHnUJrAD79@nongnu.org
X-Gm-Message-State: AOJu0YxaDjB7ERZecWDlbbiOFmTrSd/2OSH9DDn6Pe6S15wmGv6RKCyF
 th3Oz10V/bxx8Ahm5y3jM6SkNpHB1tIStAWOvI5ekLPZX4SX4rmfuJc2h1BB0as=
X-Google-Smtp-Source: AGHT+IGUtxuqNM7Zulv0qK6XluzsFRH6oycNUZNFecDCEYBhfV3CXTXz1EGoPpFFKtoboMDboXVlWQ==
X-Received: by 2002:a05:620a:3f97:b0:7b1:4778:1564 with SMTP id
 af79cd13be357-7b361fa8ed5mr123817985a.3.1731621704758; 
 Thu, 14 Nov 2024 14:01:44 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net ([130.44.212.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca308bdsm93742485a.83.2024.11.14.14.01.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 14:01:44 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v7 02/12] util/dsa: Add idxd into linux header copy list.
Date: Thu, 14 Nov 2024 14:01:22 -0800
Message-Id: <20241114220132.27399-3-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241114220132.27399-1-yichen.wang@bytedance.com>
References: <20241114220132.27399-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qk1-x733.google.com
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


