Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B82C49EA1
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 13:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ9dk-0000YC-02; Wed, 31 Jul 2024 09:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.reisner@linbit.com>)
 id 1sZ9Ks-0002m5-7n
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 09:25:46 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philipp.reisner@linbit.com>)
 id 1sZ9Kp-00057w-HZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 09:25:45 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7a9a7af0d0so750202466b.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1722432341; x=1723037141;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dxALnPUmyRoYA7morwgIVajtl32kZIWfqqOlhO4AnjU=;
 b=wZ9Xe6eYmS+ygi4B1BPD/lGJoSri2rgONANkNFy0hExzjtWngVXAY57XAheYcwHD9v
 BAelyCjfmqP91klwy6lsA40SeAcPC4F32bUozJJJ8o/ZHyn8+McNgZo7fcedoJRwLNM/
 PASi+OM+OY7s/RWfNpT1wL17+b5c3AshufIKQNnhrTQHb4bcsLGoU8Sm1wYBUkx9cdPl
 W0fB6iRwJc2E/JWp31MAtN52yhkn3WUPuzN73Jp5Ivrfcc8oTkWvcOPux+vJZYMhr+Q3
 nWoejpl5jpNjqyyQ+k6seldxKzpRpcOfZ3KHEIwrDvBO2SRVT/VD51NmDcncb9PPEOaz
 oskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722432341; x=1723037141;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dxALnPUmyRoYA7morwgIVajtl32kZIWfqqOlhO4AnjU=;
 b=YAdVlU5MkeL/c8Up83WT/e6I64D1ltW8Z+/4kkueoapyJXRperX4Rrx57zCBpYccJ9
 7HeRD4w5zJJyCTWyc6i48Sul9Bcno+qurOpGLD5rC7TJ18kka2VmDCnVra+Z4RKl+ySE
 d0NWJzUzUDxNaKEOPQeRX+lJqw2wpMLHlcldxxjCQyTT+acrJkjwOFfruLuForDgQFGo
 GXyVjy8Hr/FUfZi4vyoswsgsf8g8Vtw7waGhy6yIRXSTvO5bD+7XI+2czi1zNv9+xmH8
 p5j4dH0idihvTMqeYe+LBlltYks/sHExH0enrtwqvUpEL9p562/CuEstv7emduWNhhxZ
 PWrw==
X-Gm-Message-State: AOJu0YzYnTdmWZC/uj2iH5EU130EVG+UoA2GXer5czz8KsvCAI3qo91F
 IXNDrWushvLyh6FxfrzkthHsNmlZUPl1zCm/5qN+G7KJRdYs1iV3eqni9pKDvt4TWUPBn8T0TsO
 X
X-Google-Smtp-Source: AGHT+IF9wofbJ3/NgqqRuSMYl/jlVE/7xRp+MUHKtRVKoBPdC39XL3cBiO/2e9Rhc2q3iMJtuMsW1g==
X-Received: by 2002:a17:907:86a2:b0:a7a:d093:f843 with SMTP id
 a640c23a62f3a-a7d401605afmr953963566b.63.1722432340910; 
 Wed, 31 Jul 2024 06:25:40 -0700 (PDT)
Received: from ryzen9.home (193-80-247-151.adsl.highway.telekom.at.
 [193.80.247.151]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad4aaa3sm772603866b.138.2024.07.31.06.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 06:25:40 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH] util: retry open() when it gets interrupted by a signal
Date: Wed, 31 Jul 2024 15:25:24 +0200
Message-ID: <20240731132524.308273-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philipp.reisner@linbit.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 31 Jul 2024 09:45:07 -0400
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

As with many syscalls, open() might be interrupted by a signal.

The experienced logfile entry is:

qemu-system-x86_64: -device virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-format,id=virtio-disk0,bootindex=2,write-cache=on,serial=1b990c4d13b74a4e90ea: Could not open '/dev/drbd1003': Interrupted system call

Retry it until it is not interrupted by a signal.
FYI, dd has the same kind of loop aroud open().
https://github.com/coreutils/coreutils/blob/1ae98dbda7322427e8226356fd110d2553f5fac9/src/dd.c#L1294-L1299

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 util/osdep.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index 770369831b..a1269d9345 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -294,14 +294,17 @@ bool qemu_has_direct_io(void)
 static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
 {
     int ret;
+    do  {
 #ifdef O_CLOEXEC
-    ret = open(name, flags | O_CLOEXEC, mode);
+        ret = open(name, flags | O_CLOEXEC, mode);
 #else
-    ret = open(name, flags, mode);
-    if (ret >= 0) {
-        qemu_set_cloexec(ret);
-    }
+        ret = open(name, flags, mode);
+        if (ret >= 0) {
+            qemu_set_cloexec(ret);
+        }
 #endif
+    } while (ret == -1 && errno == EINTR);
+
     return ret;
 }
 
-- 
2.45.2


