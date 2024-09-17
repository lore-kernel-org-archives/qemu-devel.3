Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD59DCAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 21:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqgAj-0007DC-I9; Tue, 17 Sep 2024 17:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAM-0006at-ED
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqgAK-0004tC-Cy
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 17:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726610119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEH7XELrrgRUk7dJEbjSFoDATfJsQ4JEpBQhyHZoeiU=;
 b=FafSL/+ibCRgWqJ+zV1rgjBpli9+JiJpx6x9BuJdAvt+u6yKku/moohUAtNIPVNO0q7jOO
 UYryzCDWC96xgK0BxbpkrTfiBGogVHwugWw/jZOtCdN9ruBMXkGzXFqmTE2Ey08h6UTe/m
 VeSQBoZKF2xSDhVBREqNT/xwpj7mNPg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-tWoJL2xQNAyiFutzB4K7PQ-1; Tue, 17 Sep 2024 17:55:16 -0400
X-MC-Unique: tWoJL2xQNAyiFutzB4K7PQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a9cfe4442cso987160085a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 14:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726610116; x=1727214916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEH7XELrrgRUk7dJEbjSFoDATfJsQ4JEpBQhyHZoeiU=;
 b=hiYH3kpRI0dwXIbrudDjkwyPEQxW+P7IsrCQCYkoZXaW1SBMViSGsp1H9TMcEQsfeh
 q8nNdLCyMpgLAqGJXW7I01yp0Gy58NrqbN8pnMR6ZsT8+Kvkeet5N+GcA5RFysODRFwo
 2OGQ0aIojBiI3VdgyUnSiD/PC343N1BoISTjDLckXF23YKtyX8ZexlwQKC6QGWotlZZa
 x8rtXzEUx1OobDj/a+qxJ3WHyP8Bhm9OiM/J92GrEyZGWU0qsTtDRkZNvJfoQR5MAkkd
 176FTIrudVvE2IGIPTheWXUR78h26qugcI5wExFjKFYbyG6PS0PlKd5oD48wkgveYeFF
 EFHQ==
X-Gm-Message-State: AOJu0YxyVQ1DUJ4N//hAkorPO8Sfg8zcOJlJtG/IwKuGIZltGYATWa4q
 ixCynApz/Da61CK/9B8BLpXY2nptBCB5H99OqfZWJQRC8rPun0oXvpZBDpmJiv275s5pWWAmwVh
 u9rBDQefS4lbucXxNCdccmtjXQFtB13OdaXdfWDp1GI8GwZRWZLcVFu18xfDJKxMfNNlVJzavnb
 SyMkC3rG5Z0BQ3Mr8X7htt0D4V7Sa7NwRzMw==
X-Received: by 2002:a05:620a:3954:b0:79f:197d:fe92 with SMTP id
 af79cd13be357-7a9e5ee7bc3mr3393235185a.2.1726610115819; 
 Tue, 17 Sep 2024 14:55:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAxOc+2TLVFD4V5QSj73rFIH/CJ80tUcVmOunent265Iq4wxz+IWfQhp9ClAUSp/Z+CADqdw==
X-Received: by 2002:a05:620a:3954:b0:79f:197d:fe92 with SMTP id
 af79cd13be357-7a9e5ee7bc3mr3393230985a.2.1726610115305; 
 Tue, 17 Sep 2024 14:55:15 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e97c9fasm402869685a.28.2024.09.17.14.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 14:55:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Fea.Wang" <fea.wang@sifive.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/6] softmmu/physmem.c: Keep transaction attribute in
 address_space_map()
Date: Tue, 17 Sep 2024 17:55:04 -0400
Message-ID: <20240917215506.472181-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240917215506.472181-1-peterx@redhat.com>
References: <20240917215506.472181-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: "Fea.Wang" <fea.wang@sifive.com>

The follow-up transactions may use the data in the attribution, so keep
the value of attribution from the function parameter just as
flatview_translate() above.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Cc: qemu-stable@nongnu.org
Fixes: f26404fbee ("Make address_space_map() take a MemTxAttrs argument")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20240912070404.2993976-2-fea.wang@sifive.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index d71a2b1bbd..dc1db3a384 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3274,7 +3274,7 @@ void *address_space_map(AddressSpace *as,
         bounce->len = l;
 
         if (!is_write) {
-            flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
+            flatview_read(fv, addr, attrs,
                           bounce->buffer, l);
         }
 
-- 
2.45.0


