Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B741EC36005
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 03:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty0I9-00085K-LE; Thu, 27 Mar 2025 23:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1ty0I7-00084u-NW
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 23:21:55 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1ty0I5-0004HF-S8
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 23:21:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22622ddcc35so48410075ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 20:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743132112; x=1743736912; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OGk1quvDzx3nrT5033tZIZ5fhSbgio0BulPWNIPHYpI=;
 b=d+GP3vCf+l7WdZR/27S6LEuHCKA21V7RU/l5UM5uIXqkpC45oaywnEj3X+AjLQYCuw
 3XLNeehS3nTh1JOgU73KvFsp6bFflhr+wyuke0mZB9RTBoSrJ4CnbLD/566dQV8EuTwi
 u5Fz9DaSajVDHW781pq3n0q2ncPquZ2MYJ2iw+ZQSu9qMeaD//tnEvPBp3GKX2KY+4SO
 zldzqwRT4CnWuraALIXhGzkgLhhFNjRFBXSlzen3ufOiEo/MwuLiHtKxR8f73wubdsGA
 Ab7FSK8SWYJ5DX78xyTY9D+jn+zYjC+Q55IXn4a+P7tu4+pQmbimLwlHUD4LHGGNFR2o
 0lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743132112; x=1743736912;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGk1quvDzx3nrT5033tZIZ5fhSbgio0BulPWNIPHYpI=;
 b=DDmhwystArC/5ojjbXGN4yL64Rx95aXg7Gn/dQbf2en0fSY4SjPPERv0yUkdsdKMsn
 MdG8gqZ1ue25zVo9xydEkQVPcXReercp60nhvJ1GIt2IbjWoPrJNm6D7ABSa+Q3O4YUj
 JyvK9qWGOHbpjpiqXnpV75NJIIkdEkr0Q3lMhpAXb4C1DDF0mOp0siMlm1lOyM0kTYS2
 BScKab2A8imtv48MH3QjATIGKhX5+lfn6NZo8Zphz5qRwvpQh6ZQXp4yiSfnG5cizVzh
 JyTINDAoawwDx1kF86covMuce8lcxK14k+MNgWqSzhRejHfjUg+zWk1OvzuybmQsuU28
 +u5A==
X-Gm-Message-State: AOJu0YwbQv76pPocj1hSogfsfR960Sl2PzAzLpaFUBo+TlUPKurlmnST
 N9ITDC5BTiAB9NQ5QjE7e825Vyo15ADea1xc2ZlTNds5n4XVouFzt0tppA==
X-Gm-Gg: ASbGncty6iQcgtx2Oku8022kzpRVOLWAumqyc4ftRaETw6WCJEAc1cm9pkSDc3inCsV
 M73ZZe3tltPDaQY0gqtGLiFfiDZBI/ORHGz8aepc0liF7wTmB42Ouws14n1ckudIkP6hCQrNq9N
 j73hzWH9UAu0uGQzT39zrsYrRCj9yLaBqSdjZf9mrYkDalBfQquOIFV873o971Xcmve4blTZAVm
 9BAATKKT8TOl4kCSxPrPxB2WWQS/m54/E+AdVUfcgzBLmb2KSB5pgi9qtfYZXuVXqLBKW7lJDVi
 jGB6LEEYpIOO8ItcIGjk9zQ1b09eskA5qRzqu4iBCqYlw8aw9HwkOVA4Uns++d83Bs1uSxrD804
 =
X-Google-Smtp-Source: AGHT+IHqZ95w//EjI70SGk89lp8jJkpbJShJGmAoI4vLiXAPhjjNcyHkef6M/MMsNKrdl5r+bh3Afg==
X-Received: by 2002:a05:6a00:228a:b0:736:ab48:18f0 with SMTP id
 d2e1a72fcca58-73960e0c149mr7388292b3a.1.1743132111566; 
 Thu, 27 Mar 2025 20:21:51 -0700 (PDT)
Received: from [192.168.31.221] ([124.64.23.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739710b8001sm638733b3a.156.2025.03.27.20.21.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 20:21:51 -0700 (PDT)
Message-ID: <73cd69f9-ff9b-4cd4-b8aa-265f9d6067b9@gmail.com>
Date: Fri, 28 Mar 2025 11:21:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/scsi/lsi53c895a: fix memory leak in lsi_scsi_realize()
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=hz1624917200@gmail.com; helo=mail-pl1-x632.google.com
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

Hi,
This patch addresses a memory leak bug in the usages of `timer_del()`.
The issue arisesfrom the incorrect use of the ambiguous timer API 
`timer_del()`, which does not free the timer object. The LeakSanitizer
report this issue during fuzzing. The correct API `timer_free()` freed
the timer object instead.

=================================================================
==2586273==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x55f2afd89879 in calloc /home/runner/work/llvm-project/llvm-project/compiler-rt/lib/asan/asan_malloc_linux.cpp:75:3
    #1 0x7f443b93ac50 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5ec50) (BuildId: 224ac2a88b72bc8e2fe8566ee28fae789fc69241)
    #2 0x55f2b053962e in timer_new /root/qemu/include/qemu/timer.h:542:12
    #3 0x55f2b0514771 in timer_new_us /root/qemu/include/qemu/timer.h:582:12
    #4 0x55f2b0514288 in lsi_scsi_realize /root/qemu/build-fuzz/../hw/scsi/lsi53c895a.c:2350:24
    #5 0x55f2b0452d26 in pci_qdev_realize /root/qemu/build-fuzz/../hw/pci/pci.c:2174:9


Signed-off-by: Zheng Huang <hz1624917200@outlook.com>

---
 hw/scsi/lsi53c895a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index d85e384ad6..6689ebba25 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2372,7 +2372,7 @@ static void lsi_scsi_exit(PCIDevice *dev)
     LSIState *s = LSI53C895A(dev);
 
     address_space_destroy(&s->pci_io_as);
-    timer_del(s->scripts_timer);
+    timer_free(s->scripts_timer);
 }
 
 static void lsi_class_init(ObjectClass *klass, void *data)
-- 
2.34.1

