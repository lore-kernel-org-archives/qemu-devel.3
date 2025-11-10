Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D7ACCFA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU9e-0007eM-Nz; Mon, 10 Nov 2025 10:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9F-0006uy-Fr
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9E-00010o-2Q
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRB05p19+Vj4BSBV3UAT/udACtKojjPOv6AwE4PFCW4=;
 b=bsCLTLs9DGT7HNfGsXjPbtf027N6QKvVPED3SEfpmw4YzSWFzcelwWEh25pMgdgfubKPtw
 oG51rEGeCDWeMcGPsfDX4zXTWpRRNlSIbd3xPw4FTaQuYwWT9HG0/+Cuit7SSpAeRV2PPi
 lXJlCZcuFYRAAsGfCGy9vopdaFg3D0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-LhegiWUjOweeSQev0H0DfA-1; Mon, 10 Nov 2025 10:49:37 -0500
X-MC-Unique: LhegiWUjOweeSQev0H0DfA-1
X-Mimecast-MFC-AGG-ID: LhegiWUjOweeSQev0H0DfA_1762789777
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso24248765e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789776; x=1763394576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRB05p19+Vj4BSBV3UAT/udACtKojjPOv6AwE4PFCW4=;
 b=Ix7GPw57lOyh99W/6YTTWdrx8MpawfPSIRMF3Zbwfs40nuBxzfMVW9fMuVLbhKOaqc
 LVBxmkaZY44GWa6cdCMZvJwGBvsTPGVeZEOqW9+8wY4mHAYs1GocoOyt4Mi+R2Rq9A6q
 xjGB6LBwfstXmq3vBkIyFX7T0FARqFNww/cqlhxPu8a/iWrUwaHMjS4DEY2Ez1anRpwb
 gO3hHfDCbkzLWtc6xhZArWBnmLBxKBrOYDq3sywPLELyX/CGgYDgMw8r4H3X6g9ydWJR
 xzSw2IKr2g3bv1YR5F1LoVead9Gw24iYot3JDnQwQJ05KTmAfjIpIt7dbg7wQsed+6SP
 KYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789776; x=1763394576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tRB05p19+Vj4BSBV3UAT/udACtKojjPOv6AwE4PFCW4=;
 b=pQLri5IjYoX2YlNLxCennwevNlE8ssjp9eFgSgi4uOCGQp47RDTOZysC5hoCaMcAym
 YCgxf2d2O4h34diQXFMYIvbuBy6NMtYnypNUrkIs/JanBJqirYAmu/AJqz/QXJnkzwqd
 mYCSA8TVNHxuuaSiGzgHLshgM0kx/Nb2CoumR1vzm85CBsiU1M8x4pZL7pW0zCEOdKgN
 U+9ugfqX0kxKciR4h3xmgDTPuuSY0S0lCX8K6vGY9YntKTSkAle1J58Ah8SXTOw58to4
 0PfRPFBD2A7gI8HQhCF6zYIXS76gs+TlP+9U5BzxsWVN1AUdiWrAimwD4JEgrQ3XeX9v
 VyVA==
X-Gm-Message-State: AOJu0YzSBWGMe/fRfALukcXXeJXeQjiVdCxvJaTBw7Y5REmxELPo9wMP
 icaakyBEkY8JjHphMPqgx4nojO61qcx5Dolsxmgi5YzgUkNO+S3I0a5EFjGJoXMb267a5MeIIZw
 4ER4dH5UtLOqP2pkq8VaRd7esqPIqClrfvCq+afgdtnmKJetEBQYH30F6
X-Gm-Gg: ASbGnctmPYslaYdPWsfxevEuWusIcvsQI3lbLrKYwY6K54RyuTOZhGiN+ojNuLxwjog
 or5ww9kfX4qUS6smiGMm9DG8RmQYcQm5pHfQtUI1NJB19iIx78ABxVIk3HTDUBoCpLO9Wbe5VD+
 tCCZfKqdyZigz0VR9d1QI0KGCLg5wAgQCpuj0XVz5B584nkaftCBlucMXsn3NQ9/0+Xx8GH/Jh2
 LQRuEC/2vjV/ygWR4xjIxQrQSkye7p+ezP66YMBV2cGw5lwzJGB0SyxCIitaeL1eP1BCNeqSNaf
 CyDestQYoACm5KJMePgnQCdb0lURp1dpzhc2nSXZAnYFl3F0Qk90nKo38mANgRCx4IhOUhC2oCB
 sdKniCZaHwcmrURULS0Sf5wQgM2/Vt1cxs6ZbjMZ4UGp2MsFfOJ7m62q8QA==
X-Received: by 2002:a05:600c:470d:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-477732298edmr67659445e9.1.1762789776650; 
 Mon, 10 Nov 2025 07:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcm1cSjRaA6Kdh4svJRAYcVlQlEnq+Z2vmfpzW1lrhyKy/AVgJrr5nrUEyUET2ju06rKyJlQ==
X-Received: by 2002:a05:600c:470d:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-477732298edmr67659135e9.1.1762789776127; 
 Mon, 10 Nov 2025 07:49:36 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2dd927c9sm16143499f8f.27.2025.11.10.07.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:34 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH v2 11/19] qcow2: Re-initialize lock in invalidate_cache
Date: Mon, 10 Nov 2025 16:48:46 +0100
Message-ID: <20251110154854.151484-12-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

After clearing our state (memset()-ing it to 0), we should
re-initialize objects that need it.  Specifically, that applies to
s->lock, which is originally initialized in qcow2_open().

Given qemu_co_mutex_init() is just a memset() to 0, this is functionally
a no-op, but still seems like the right thing to do.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 4aa9f9e068..d6e38926c8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2873,6 +2873,8 @@ qcow2_co_invalidate_cache(BlockDriverState *bs, Error **errp)
     data_file = s->data_file;
     memset(s, 0, sizeof(BDRVQcow2State));
     s->data_file = data_file;
+    /* Re-initialize objects initialized in qcow2_open() */
+    qemu_co_mutex_init(&s->lock);
 
     options = qdict_clone_shallow(bs->options);
 
-- 
2.51.1


