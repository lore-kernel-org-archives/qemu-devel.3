Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F12103E198
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ssk-0002Vf-TG; Wed, 18 Mar 2026 11:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2ssi-0002VK-HD
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 11:32:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2ssg-0000Nx-34
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 11:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773847939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CRvjEwoYDkRt8yhl7mlhHXw/CubI4L/xoNdBYKsHpnE=;
 b=hUpb3QGGNTmzuFAUB+2Pm304gaHKDKvg0iku+KFX19su3li3l96KWauH+F+N+PxhGKjUcQ
 pGc020dhjQleWQXA22YZvnngA6/BCL8f63yrilephHh2YiJHsZSKg3nndHRoU0ofAJ5ZZ9
 H0AfoCk9J+TnbA3K6AGks0T03uNcWjs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-thwKr7c6NKW_R9ufkY2kGg-1; Wed, 18 Mar 2026 11:32:18 -0400
X-MC-Unique: thwKr7c6NKW_R9ufkY2kGg-1
X-Mimecast-MFC-AGG-ID: thwKr7c6NKW_R9ufkY2kGg_1773847937
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853ab1cae0so61966035e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773847937; x=1774452737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CRvjEwoYDkRt8yhl7mlhHXw/CubI4L/xoNdBYKsHpnE=;
 b=LTz9PnnCvv8gIHafHRsWXd3lXyShDfG9uUpLh+iqh37amdtN6JSYANi0P1xkgVE/FK
 fIfOZdyMp70l5FjtZmEJaF4SaKGWnFHfGcRXJl2rXxhhMFnWvNm0qwkGVmdrq4xA98SC
 NJ+ObV9zXrwSEMuuH6cK2lRNAoMkeMwn1hY+EnWV5rC85YepV9jgv+i2LRmU+sWSpHbM
 svxMM+16TFvLtY8SfrbX0QQ8kNFHcmyHB+iFzQqHklVDVrNuWqH1doNsZnjcAjX8EQWl
 SlvBIBQ+niJKBKXzPsx5+vy9cpNxel+MQQOc74nR6BRhGlBIekSMtF0iLHmsUmUJcskN
 gjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773847937; x=1774452737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRvjEwoYDkRt8yhl7mlhHXw/CubI4L/xoNdBYKsHpnE=;
 b=ppre1J69oZ6Ovy7Pd1mAoTqlnphdcerEXc7rVRv7kOQTHRB+Jua+hzkf4yQhL7DYDa
 7FOLb39WGiIYEnYdyFc5k1hnrPR6Mvly91Bg6H82PViwlkBw1rtGzWTmOhVJd8DM+9xc
 8A+5xa4rW0V2M04N5NkLzKEM06zPiHL8B9LL6OKXOe7qKidEMh70YP2S1II9zRJSB2yV
 4fZWfVDYBsKeEzSd1XpkLYJBLaatSpZSb1HIO8MKBbezP8dHPy3jxnl0Z55usmcAcHgw
 iOib0ow6OXGTwGaURRxSDj4YXLhbEtAzeQZcq3fgB1b58seK6vr4Fu8RYSpQhUyZ3VAr
 ep+A==
X-Gm-Message-State: AOJu0YxBwk83PntFf5bnakAa1maM6u47HugKZAFlKAfMzf5mLZTp4z1B
 Ozy7FEZ/ATh+4HxvsjTrxD2sdb/AZpZs6uxACV2gPxKuL+Rs04KP7aMySFjl+cvVEDYRVDfP/rg
 azYDLZCYMf9ukzC/k2+iJBpuAOQ8Bi+HbcERs7svHm70OpKIWwYzzvTfz
X-Gm-Gg: ATEYQzwZcj/zLq4XTa0RkwS7P6WpfLFHlBpVTeA1zGxKkTsKOcClEHrure+DCXFI6ta
 PSz2qUcFTSc+FONXyZSfPRx+eleEFky5m1bDCCqus3cnRz0jwb9SRImzUQW/REZfzzeqGXMTosx
 B2giZbSbuxgvI02+BR0nM9eus5uz1Uc5OIjzdB9WIXe8NLGzzHOsQ2bppVJPSETszhW/6jzVOYR
 Nb8mB3D/uQk21r5nlRGejyIycecSafXpsqJA3dlyA+8bxOS8hZr8WfBK2gEc76IHtd38haorB6t
 DLjSmL6o5G/+6E/faT7dwB4VRGu2ej/pXkx86t8meXpjTGAcT9VqLHvjtR2FmgImH4wfCfSarM9
 A1fueaglCuyEnL8lsH8pfrX8QWpgqmyYEv2hbVrvhB1FHjRQ+GPivzWDIV+TVW1k01Hs5AzBrv/
 Q4rTg=
X-Received: by 2002:a05:600c:8b0a:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-486f442207amr61380405e9.3.1773847936909; 
 Wed, 18 Mar 2026 08:32:16 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0a:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-486f442207amr61379765e9.3.1773847936429; 
 Wed, 18 Mar 2026 08:32:16 -0700 (PDT)
Received: from localhost
 (p200300cfd737d03304b9bf783d26f60b.dip0.t-ipconnect.de.
 [2003:cf:d737:d033:4b9:bf78:3d26:f60b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f460e990sm28533425e9.1.2026.03.18.08.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:32:15 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-11.0 0/3] linux-aio/io-uring: Resubmit tails of short
 requests
Date: Wed, 18 Mar 2026 16:32:02 +0100
Message-ID: <20260318153206.171494-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

Short reads and writes can happen.  One way to reproduce them is via
FUSE export, if you force it to limit the request length in the
read/write path (patch in the commit messages of patches 2 and 3), but
specifically short writes apparently can also happen with NFS.

For the file-posix block driver, aio=threads already takes care of them.
aio=native does not, at all, and aio=io_uring only handles short reads,
but not writes.  This series has both aio=native and aio=io_uring handle
both short reads and writes.  zone-append is not touched, as I don’t
believe resubmitting the tail (if a short append can even happen) is
safe.


Hanna Czenczek (3):
  linux-aio: Put all parameters into qemu_laiocb
  linux-aio: Resubmit tails of short reads/writes
  io-uring: Resubmit tails of short writes

 block/io_uring.c   | 83 ++++++++++++++++++++++-----------------
 block/linux-aio.c  | 96 ++++++++++++++++++++++++++++++++++++----------
 block/trace-events |  2 +-
 3 files changed, 123 insertions(+), 58 deletions(-)

-- 
2.53.0


