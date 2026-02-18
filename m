Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AF2E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfc-0004Ag-IJ; Wed, 18 Feb 2026 08:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfT-0003yp-Sv
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfA-000543-Mr
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVtrqVMsyosUaHcDZ5RGcCJIBeUjW9Ffsh9VA3rZWsw=;
 b=AeyrBG0I8Z/gy2CHBlrsKoNkpb1OUeSHLcd3P22Jhl4S3B3xQm3lYTx3nHOBDRIqzGlJBr
 mpr7kcOtGaJdgSCaGYqSXNOtKmgwazHy5VlxDKQyPE804wHvpiudUAcNCHNREdmVakFyEo
 EJyB4evfUqU//cQATwx/PkByAOsyDQI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-kk2Z5bLzN0SfwJNal-15ow-1; Wed, 18 Feb 2026 08:26:55 -0500
X-MC-Unique: kk2Z5bLzN0SfwJNal-15ow-1
X-Mimecast-MFC-AGG-ID: kk2Z5bLzN0SfwJNal-15ow_1771421211
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48071615686so47356145e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421211; x=1772026011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVtrqVMsyosUaHcDZ5RGcCJIBeUjW9Ffsh9VA3rZWsw=;
 b=NqHrJnuUikqcOd2cbqltc5QoZYnRlYSSPG2FWQJYjbtpdm9NH+FykPXOEuqkuat756
 coMiUcU/Wsmvu0ZRk57towBEO8U4bML7oIwcY/tfUveNlHxm2N5/3zx5sP0LDbd3Mfzx
 eqj/8NykUIId0i4ch7CocYPBQkQZWmxQvyGSpzi/0x80lKdm1EN2WWqPt8ivDe7euST1
 53R5tdAGeNPhX253abSlTr1H82DhZuijAztXWKkZJ9ax9NRqAng42OBKjBrNxh7nznv/
 ZTJdFg1Ha1jdr1TyPfLMHOB12druKtLF0OcJdIktC13+DweCQMEod/NsKCmJe/G1YQeE
 2/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421211; x=1772026011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uVtrqVMsyosUaHcDZ5RGcCJIBeUjW9Ffsh9VA3rZWsw=;
 b=qzORdUBf1B+5UW/2DSWI2FWYctf+33NWZ3EPaSyZDZeV4qBKL85yP915H/9NqsLgF9
 15O9C9wrJN4u3m25QhGppwiR/e2i/704XzhKd54bcYR7skkie3hT+N4JLnge2sqjbbVS
 1EW+WnErPuGMjQUN7vxtiPgz4YbaXi76W00K+TidwQKevSoa8QBmK5VHZu1hGj537UKN
 /JrkvtNwj4cu2CcVZPrp3OsZXvUKCCuMoOQzEccsGw7Urde1Bd/1qI7aN/oQzI3bX5AB
 JQgoV5d6LnVGV2AFNMr7zn7QS6+eFBFuP2Il2GackN9d4E+nqpzGY9S7hk+9+SWKLpo0
 7x3w==
X-Gm-Message-State: AOJu0Yx/+8FjndYWP6xQHLiONFW/JCWjwo6zI1SxFbEkjhm3RGICP8R0
 kGw7oeKgyRYmKo7DdpV6MQTzY7k2KeSf1v6BjTFu0TgHI948eogtUPxIfHIDDD+jT7igHckSEwB
 DJ7tsmRCrr4IAoIicVpEuCG2QzpVmcgxaPljiJZMqzMlixfHt9m8IVS+8
X-Gm-Gg: AZuq6aLUutCNCp5SWwVxk1AUQp54L+vnSS+ZRyIkGSOepyo+dVa0o/SuZtf0+mfGlSU
 dze6f8PLvfiFeg4TE7oVzWPAGqkU7oaS2yNHmheie6mEw+OtXjq03kSesdzItPuSiPDqbouYufL
 yA+mXHzYleKe5p//7nwZfIsMkkRXKGLNKIybrDuLfPYhs6MQUCNuaiW4Cj6LNkFzIpw8MSLPCly
 5Evr1JRkdE+583RXVkggq7JwzSDC1Bl123nqM9KumxXzpPaUVWlMzDIJnz8vOIG/UL5M/rfncBz
 aNsnTuB06b1f+z5fr4QxIX2VhpwP5mPLv3EoGp1CgmP0EMwLhtGjOEMSGd2w4wBGuGmp1PApuf+
 RbDQcrNnyNXraysXC5hM2qrkTXwywF34AHtoHKKBIMKNbeBzNMTfzDdjrYxqvldutguBwpm5z2n
 cG+vn0
X-Received: by 2002:a05:600c:4e42:b0:483:76b2:cacf with SMTP id
 5b1f17b1804b1-48398aee83amr33458715e9.32.1771421210866; 
 Wed, 18 Feb 2026 05:26:50 -0800 (PST)
X-Received: by 2002:a05:600c:4e42:b0:483:76b2:cacf with SMTP id
 5b1f17b1804b1-48398aee83amr33458325e9.32.1771421210386; 
 Wed, 18 Feb 2026 05:26:50 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483970d447fsm36188655e9.0.2026.02.18.05.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:26:48 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 03/24] fuse: Remove superfluous empty line
Date: Wed, 18 Feb 2026 14:26:12 +0100
Message-ID: <20260218132633.29748-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 2ed22c6b2f..4cdf527d69 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -464,7 +464,6 @@ static int fuse_do_truncate(const FuseExport *exp, int64_t size,
     }
 
     if (add_resize_perm) {
-
         if (!qemu_in_main_thread()) {
             /* Changing permissions like below only works in the main thread */
             return -EPERM;
-- 
2.53.0


