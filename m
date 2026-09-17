Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6100C982D6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Dfo-0001MB-PX; Thu, 17 Sep 2026 11:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifan@redhat.com>)
 id 1x7Dfm-0001Lo-S9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 11:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifan@redhat.com>)
 id 1x7Dfl-000824-59
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 11:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789657511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UNvUd00gEOjp48lklDvdI8g5aeJ4obcTvxfiIT+k1lY=;
 b=ReDzhWVsCSOKpYhV3vYyyzOYwDcWxdYD+aMu+FBIRpUDS9DZPW9wgVWt1uPL5KN+MkTJt+
 NpC2J+nVROkKabpJ00SjrhA1tu5nK22JnfCksfPY0qSEFi8OD/eaYQWGKDRu0sB3gHMTBn
 WYh56lFCYOvEIVSwFEZ8jFSmkZ39aJ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-44UC_bCOOGKpO3Z_gsmV_g-1; Thu, 17 Sep 2026 11:05:07 -0400
X-MC-Unique: 44UC_bCOOGKpO3Z_gsmV_g-1
X-Mimecast-MFC-AGG-ID: 44UC_bCOOGKpO3Z_gsmV_g_1789657506
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48706ee8fbaso615666f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789657506; x=1790262306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UNvUd00gEOjp48lklDvdI8g5aeJ4obcTvxfiIT+k1lY=;
 b=lY2yEhsuIY0nHMfGzrv39RSR30042/TehFMnLz9Nu1nlTCfYNcWyTYvHm2ax6xFxBU
 725Wt/MgJV/DAv7MDvuof3SAfILsiPhhzQ+Bjylk+lV9z6a7yEE8VuQb4beX/sVXJ0qa
 sB9N52HSaD76tpDj2bbiAhX5l15lYuvtlN5528ULjNlPZrVLkwqRifyUucFbh040QgXx
 HqB9tuaySTL4wMgnWEL10pgaDPsLPD7jnXEOGpDqIgYr6yWPvyQSz5Gd3mWD2QPC4FE1
 fiEdzYQ0dhzQnifqY8Yi5r5B2D+E11mtEQZckX/uygpYpFOycverl/wMUekz1Qctc56V
 NSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789657506; x=1790262306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UNvUd00gEOjp48lklDvdI8g5aeJ4obcTvxfiIT+k1lY=;
 b=G6Y1Ky6JaRt8WNB26W0jvHrb8umFFoRE59H/WqPTwvmJc2znN4zqOyYyLAzUS9ng27
 HDyNmZ4F6gasYYl7uhpmKzIc1BUWkMjBkXQfcJlxX/KctJli2sMP1A33io34iiyOrW5K
 Po0+ZLDGA89IuTXMXQmU+sNKEUrDk6jHuMctnMilveG4X7+DGNdL7jCwwC5dTexXfoSg
 K+VbeZOhF5gFM4hwzbD5roSYex6sD7rJP6Z2nR/2hR2VxqgLWobM/63Q3vT9clBbaeZH
 UAoiLsHUcP001UzhijhyEYRkwKGYO5yA7u8tBakOMSy6Pdg9WJPwnCmuKf1zYii5ALJ2
 LR/A==
X-Gm-Message-State: AFuF++le6yV62NkL2km3+i+T93A1OSO40oWrHIuWkOpZdpeCKo9Tkl1E
 +zBN6JrZmFjsGyPkhTsCzHjUjhyVAaNV55CntQrWQfktKXgKUVyYf/w9AVa4UhZ6ykZOKQaLH/w
 HKPpew+pEet3c/bCf+r6H/6qzjtixw33jkZyhfxD7dY4jwN1uw59ZxZbFpfIwAlGaakN8dJ/coe
 mtAVEyN8U7fJ3zayXenQryOPYn9+alrAokJJgIDXFF
X-Gm-Gg: AYBFou1acShEduvRtzzM9TK4AFqATi5e8X3mqsVmEHrCBGs4rK6UOK9d0z2vo+xxIgh
 4eIF3SRlx83o8ypvoqv0AOZ20TjC3SE1XCc6fO0xl3RZp8Fi7svYFLPzb4BgLCT3KpkLTAbyw5P
 c8rjdn7HrfUCYAo++A4ABWGjLe9FifTi0v16/6KczpTIofwPm+D+9YokewBivU16gJAgUmKjCl1
 UlyV/o1Lp81+Fnn2vpmSc0awyp5B/roxc9pAkO3kfTROeGIj9YSDCeLT93dmUZBJ5vgBiUravU3
 UmX2aA1msgwiiLcfa2z+KLNkHg/2mF6gmMrzLm5Ub2ejmajMybsUMd39Gc2jvO3ygf0fbks=
X-Received: by 2002:a05:6000:716:b0:487:aa8:cfda with SMTP id
 ffacd0b85a97d-4870cf26bcdmr8750904f8f.2.1789657505689; 
 Thu, 17 Sep 2026 08:05:05 -0700 (PDT)
X-Received: by 2002:a05:6000:716:b0:487:aa8:cfda with SMTP id
 ffacd0b85a97d-4870cf26bcdmr8750842f8f.2.1789657505267; 
 Thu, 17 Sep 2026 08:05:05 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm18168799f8f.23.2026.09.17.08.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 08:05:04 -0700 (PDT)
From: Tommaso Califano <tcalifan@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nguyen Dinh Phi <phind.uet@gmail.com>,
 Tommaso Califano <tcalifan@redhat.com>
Subject: [PATCH] hw/usb: Fix guest-triggerable assert crash via short
 CMD_SEND_OBJECT
Date: Thu, 17 Sep 2026 17:05:03 +0200
Message-ID: <20260917150503.143821-1-tcalifan@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

QEMU's USB MTP device has a guest-triggerable assertion in
usb_mtp_get_data() that fires when a guest declares a large object
size in CMD_SEND_OBJECT_INFO but sends fewer bytes in the
subsequent CMD_SEND_OBJECT. The assertion compares the declared
size against the actual bytes received.

If the guest sends CMD_SEND_OBJECT_INFO with size=1000 and then
CMD_SEND_OBJECT with only 50 bytes (short, non-64-byte-aligned
final USB packet) the assertion fire killing QEMU.

To prevent that is sufficient to remove the assertion, becouse the case
is handled by usb_mtp_write_data() which return RES_INCOMPLETE_TRANSFER.

Resolve: https://gitlab.com/qemu-project/qemu/-/work_items/3993
Signed-off-by: Tommaso Califano <tcalifan@redhat.com>
---
 hw/usb/dev-mtp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1d8cfd32dc..406793fc03 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1813,9 +1813,6 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         d->offset += dlen;
         d->data_offset += dlen;
         if ((p->iov.size % 64) || !p->iov.size) {
-            assert((s->dataset.size == 0xFFFFFFFF) ||
-                   (s->dataset.size == d->offset));
-
             if (d->length == MTP_WRITE_BUF_SZ) {
                 d->write_status = WRITE_END;
             } else {
-- 
2.55.0


