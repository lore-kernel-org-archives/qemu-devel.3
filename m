Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A905FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 06:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVQPm-0007N7-1t; Sun, 21 Jul 2024 02:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1sVQPj-0007Ma-VL
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 02:51:23 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1sVQPi-0004JT-3P
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 02:51:23 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3dab349467dso1875613b6e.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 23:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721544679; x=1722149479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uaJ0ZXBpAW7c9VwzGUSIzgXoswI7weizqaUmvBFIDnI=;
 b=D/RYthsumigSGAemn5y1ZhYCj2EVZG0LjoXGPIG9YMxpEjyVz9msbd92uvUNGtrtFN
 fT8BM26B+wOiuwGf7eYw4b5v3cCelTFWhNPIAC81ygvRh46ZmvvaXALCtG9MpFGAIbSw
 CXRQE7h7r04IcwWfRHMBDHXTdwGP4KFe0BgoAChS7zxNrdMIKAxeZTGrM6LHFksoQgDu
 /15m+PF98zIYsGcA3ZnpNSnCXEJQGFFO48AN4C/3tGYiFKoWktqBeIyav4uBDe1F2SAc
 mitEn1eoyfg2G4XzJKxl0hflauyl18WE8Gq/78BcIle+IgqyAC+8+0vv+AWf3xLqq6t5
 mTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721544679; x=1722149479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uaJ0ZXBpAW7c9VwzGUSIzgXoswI7weizqaUmvBFIDnI=;
 b=LMFI4zgJAzdnCwuTgO3MmUzdDkpbHBMQFdveVUftrWSb7m9SZSSWMFhHLBfMX/LNuk
 grtyHh/26F4a1rImxtSSP6Q0n6ceVQsny2tM3sSnN+E80zEhweGxl5kAAsdCOYJAidTb
 GsCMGVQpjP8dDGNzjfRjQZEtmq/e+255HkmWvQW3n3SPyrhybNZZGJGcxyeeb359BYY9
 Vz2uJ0P/sXfvo/nrq9qwbbe7hy5TKWRIO0l/fU7fYhZpY2R9XICwziyfcIv9lkgYNyHV
 AUrKlQQXH9TTxChYa+Ckpso5B86qBOTncL8ALsn0R4QTzUMSN7CWh8NphlSQObt6XokJ
 B2Vw==
X-Gm-Message-State: AOJu0Yy/DfghgkR0TlcSvklbX5HdbkUvWmyozo8I0i9DaxLqSQhNdghc
 zsbRb/7M1ZRtEevmD+6aXQ38nh/oIw7Mxo81Pak3Ic5xuK4mUTwHYorQifhkrCY=
X-Google-Smtp-Source: AGHT+IG6FJVrOAIOTWZCKr4w/s/YrOHKSQjdWLFlwCPSZSXFbH1xKlmW52XL8Tppo6o7TE/TXZc1FA==
X-Received: by 2002:a05:6808:1595:b0:3d6:4eb3:3c54 with SMTP id
 5614622812f47-3dae629b9a3mr6810394b6e.11.1721544679215; 
 Sat, 20 Jul 2024 23:51:19 -0700 (PDT)
Received: from vm2204.localdomain (n218103206065.netvigator.com.
 [218.103.206.65]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd96e6578esm1112515ad.247.2024.07.20.23.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 23:51:18 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: qemu-devel@nongnu.org (open list:All patches CC here)
Cc: alex.bennee@linaro.org, Hawkins Jiawei <yin31149@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] scripts/qemugdb/mtree.py: fix error of treating decimal as
 hexadecimal
Date: Sun, 21 Jul 2024 14:50:47 +0800
Message-Id: <20240721065047.192558-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=yin31149@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The mtree command throws the following exception:
Python Exception <class 'OverflowError'>: int too big to convert
Error occurred in Python: int too big to convert

The mtree command first converts `ptr['size']` to a python integer
using int128(), then calculates the memory end address by
`int(addr + (size - 1))`. Considering that `addr` is of type
gdb.TYPE_CODE_INT and `size` is a python integer, python tries to
convert `size` from a python integer to gdb.TYPE_CODE_INT
in order to calculate the address.

Yet the problem is that int128() incorrectly treating the deciaml
as hexadecimal, resulting in `ptr['size']` with
18446744073709551616 vlaue being treated as 0x18446744073709551616,
which is too big to convert.

This patch solves the problem by fixing the incorrect treatment
in int128(). As a result, gdb can display the output correctly
as follows:
0000000000000000-ffffffffffffffff system (I/O) (@ 0x555557273400)
  00000000fee00000-00000000feefffff kvm-apic-msi (I/O) (@ 0x555557354ca0)
  ...

Fixes: 8037fa55ac ("scripts/qemugdb/mtree.py: fix up mtree dump")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 scripts/qemugdb/mtree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemugdb/mtree.py b/scripts/qemugdb/mtree.py
index 8fe42c3c12..c1557d44fa 100644
--- a/scripts/qemugdb/mtree.py
+++ b/scripts/qemugdb/mtree.py
@@ -25,7 +25,7 @@ def int128(p):
     if p.type.code == gdb.TYPE_CODE_STRUCT:
         return int(p['lo']) + (int(p['hi']) << 64)
     else:
-        return int(("%s" % p), 16)
+        return int("%s" % p)
 
 class MtreeCommand(gdb.Command):
     '''Display the memory tree hierarchy'''
-- 
2.34.1


