Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3C8E9129A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0eM-0007ko-Ap; Thu, 05 Feb 2026 09:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0eI-0007jb-62
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:48:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0eG-0004Bv-Q4
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770302879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEIrvKrLd0swLY9/WjimKLsX0Z/fiphyqnNgm5gCblc=;
 b=Vy1LUkP1X6ZEcrzoQklCOqYfzHCmZEBUvXyfXHDDGD8VNElQ1BIpsPLorecIwiiq776omH
 Xv8VQx/XTElmQrhsJmW+MrfNTcyDgY1SJV+CC876Ns869e4K2M0DNRg0ZkhD3DcYI15kMX
 O4qz8/88aLhBKRg/gFqvkGhmsUcQCg8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-31h1vaoFN_ullotA8CN4Jg-1; Thu, 05 Feb 2026 09:47:57 -0500
X-MC-Unique: 31h1vaoFN_ullotA8CN4Jg-1
X-Mimecast-MFC-AGG-ID: 31h1vaoFN_ullotA8CN4Jg_1770302876
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-480686b3b4cso15419705e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 06:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770302876; x=1770907676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fEIrvKrLd0swLY9/WjimKLsX0Z/fiphyqnNgm5gCblc=;
 b=etZ50a1YP8tO2hZmbrvS6vnVVPbHWkIosIFcJcW0BUoVI3ZqNskSNDYq2/b31rgAkx
 p+WSN5UmJTjGMFuA1zT50PvolSLmOx3Nkwezcky4TE2QCBMfvyStUEma9lL9VAqL+V+P
 6j8jdkIsllNJh2IJv1z5uFEwPeY3drcZ2k0Pt5uXfJAI8cJ3/U82Dq4RHIX8BfnCVvSe
 r8uq1FdzGwuyF9zl7QlA23iC6CIboKMW1bx68JIzijonTLoYAROrjGnDnYRMkSioLzZ+
 6JfyS9r7mS2uK2Z/AomgcTzuoZuL7U14rqkz2b0K3z1QGhHSZ7tcKEXsOFHxCGKyjQ7I
 apsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770302876; x=1770907676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fEIrvKrLd0swLY9/WjimKLsX0Z/fiphyqnNgm5gCblc=;
 b=IAWFGqYKkO7ipDrpbA00vlR/3QE/T3LgkigGDUJiuU3B7WsjBAwHeY7R22Lmam5dT7
 vUXHmT9QJPXcaHj7XYGgIrSnK47FmBthQZTvLPVGap1rijCI4zSMiUxTUH0JbWDe3SZx
 F7GntTBZQqGcAdPKyefpUhDCY53eqi39zXLPeFm/0ZYeUo9ZFWavxOQ7QH+kdp8euXFV
 HAqfdI8MCiN0IaTwCdzRXQN4X1zkJzFxOebKEycaaFriWGuij1RXqrI1L8Sg0xk9satx
 vwBt0D+ttghKZ9UZRo9nwYAsQhINyPr74A148ZaAp8ru8svf8F39gywxtK6wWvGZ1bWe
 hTZw==
X-Gm-Message-State: AOJu0YxityxkdKqF+kPp2C4p6o94YV9ESMaLJ1Z1C9M02Lfbhr3GBt1W
 ThPZtIcIsw/U6xXVCAWyPB3BL9Q3q6E/4CmlmyRYTna7Q3GLaColF9pYRMoDS1MLH3h1bjPoGZp
 vKcNCl80y4qE11e4uC0L96KO5LNF7N/IpgeaXFe9qtWIEsV8FEa8hxO/h
X-Gm-Gg: AZuq6aJ8hhjoHWWk0oIz3HPkJMyZDacORXvqiTMjW+sU7XrnNnhpNwgsYr+rb1NODzb
 zVPY5dgakxOY/D29yPLXQz9PGRQJVeCQwHXieL6axNQJU3i8+W/L0a2uIdjxgPvpgwqokDPJhMt
 8S+RUZgzUhWpd7U7BWBE5xiQXLgkxvE5gR8igsznP0FFtceLf294wgPHrYp5rr7Y4hWNzYVcw06
 cLX2yCAqzzYj/i33IwGKZcydE23uxr/0Xoyhn4EhE5uDpHMySF76WCBLzhQJxmb6Ev9RzYBIgXi
 WkENHEbDDKLQswtGoW3O+jt3yVXo3A+3cM4O13V8TTBlso3NMyTK2EvK6/6PrpXYVJeLf95yRmo
 RQn1JZMAsp85JUGNNeJeOBEIm0o02zpka++OId2s0r/vFXLBYhy0OrvKQ5aTZJts1IgqB
X-Received: by 2002:a05:600c:848a:b0:47d:403e:9cd5 with SMTP id
 5b1f17b1804b1-4830e9303a6mr98427225e9.11.1770302876183; 
 Thu, 05 Feb 2026 06:47:56 -0800 (PST)
X-Received: by 2002:a05:600c:848a:b0:47d:403e:9cd5 with SMTP id
 5b1f17b1804b1-4830e9303a6mr98426815e9.11.1770302875705; 
 Thu, 05 Feb 2026 06:47:55 -0800 (PST)
Received: from localhost
 (p200300cfd737d06375fda007e5d3c5c8.dip0.t-ipconnect.de.
 [2003:cf:d737:d063:75fd:a007:e5d3:c5c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617cc9515sm13083854f8f.0.2026.02.05.06.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 06:47:52 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 1/5] qcow2: Skip data-file resize if possible
Date: Thu,  5 Feb 2026 15:47:31 +0100
Message-ID: <20260205144737.31131-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205144737.31131-1-hreitz@redhat.com>
References: <20260205144737.31131-1-hreitz@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With PREALLOC_MODE_OFF, we currently always resize the data file to the
right length.  This is definitely not necessary if it already has the
correct length, and if @exact is false, we also don't need to shrink it.

This is what other preallocation modes already do: preallocate_co() only
increases the data file size if it is too small, but never shrinks it.
(And note that for raw data files, PREALLOC_MODE_OFF is silently turned
into PREALLOC_MODE_METADATA, so this commit only changes behavior for
non-raw external data files.)

For the next commits, having all preallocation modes behave the same
will make it easier to decide when we can skip taking the RESIZE
permission on the data-file child.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index e29810d86a..69d621e9bf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4515,15 +4515,22 @@ qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
     switch (prealloc) {
     case PREALLOC_MODE_OFF:
         if (has_data_file(bs)) {
+            int64_t data_file_length = bdrv_co_getlength(s->data_file->bs);
+
             /*
              * If the caller wants an exact resize, the external data
              * file should be resized to the exact target size, too,
              * so we pass @exact here.
+             * Without @exact, we leave it as-is if it is already big enough.
+             * Implicitly handle bdrv_co_getlength() errors by resizing.
              */
-            ret = bdrv_co_truncate(s->data_file, offset, exact, prealloc, 0,
-                                   errp);
-            if (ret < 0) {
-                goto fail;
+            if (data_file_length < offset ||
+                (exact && data_file_length != offset)) {
+                ret = bdrv_co_truncate(s->data_file, offset, exact, prealloc, 0,
+                                       errp);
+                if (ret < 0) {
+                    goto fail;
+                }
             }
         }
         break;
-- 
2.52.0


