Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279B2EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniCI-0004Os-12; Wed, 04 Feb 2026 14:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniBV-0003D8-MD
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:05:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniBN-0008G7-K0
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sdPq6lHZS69iXcK74zZ9QXneSB3GbIyJznf4tebCiz8=;
 b=bx48m9O5iwWImbQSXw3LaoDbuMk9rJE85x7ioE0Ti603AiAx5bX6uoVr75pdd9PJoVOJek
 6dG4PddOJ7oyrc5Pi09oun3h/SEkTN3C99fyMvA+gxoQ5ylcudVXUL3knF0y3syB+pFidQ
 HMDyavgG43BQ3xVQ+XV7wj54l0Z7pB8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-efoD3sJhNl-CUEO7xZdJMw-1; Wed, 04 Feb 2026 14:04:49 -0500
X-MC-Unique: efoD3sJhNl-CUEO7xZdJMw-1
X-Mimecast-MFC-AGG-ID: efoD3sJhNl-CUEO7xZdJMw_1770231888
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so1965485e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231887; x=1770836687; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sdPq6lHZS69iXcK74zZ9QXneSB3GbIyJznf4tebCiz8=;
 b=MeqEMqJEbsg6aEpUj05wHAKmaIzoDoCed3PTGq0J+Jm2iIETcEuOQYa3hqlQTmBbxi
 ePtHs8Eoa5xU/Fe649rgc9mfQCWmAG8BnGXba9yfoyD+hy71gthwV8egObJ9lFk0Zd30
 AZ3QqFf+pcaYYzW6l0QxwSpIQlH/8+LISUtjincQo7gJKOwj0+0xgGQzIDOUn9AuPWqB
 /FVaisZRYIhwaQUZ2lbPriPOedi+H4cNPeefPQknwGKrrr8HzmK3MwhIf7i0NbZB5tTp
 K3CXptpY9oaNizmMm4gH3qF32uJCVUpsRp5HuIKHOYI6YeZwVAgfGwD5SMFJTeA51WUO
 DUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231887; x=1770836687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdPq6lHZS69iXcK74zZ9QXneSB3GbIyJznf4tebCiz8=;
 b=lwtQ9OJT4LvvGEYJKmsp9qrKDWZhx6P/FGWSi4H5zmSJ+luf4ldvKJ1ara5/W6JIrn
 i52TfxlNIMq4NinqTyyLg2wqsW77jlVedI94I6ehuGX3B2gviNzG5OXkJpLBVUYhMmdP
 wZX/aW/8pPXZ5d91rh4Y1F/Tm/7zsQ757QMIt/yt3G/+mpciPoFBhCwBn28f+2+i+qs8
 Or1zFEjs/vMymO/z3tDfBQdVV/oB1nAyj994iGKDLcB54EZu0uNOYJuvC2qoWMlzIeW7
 ujs2xRTRhUQqDjEl+6dNbOv+3gBqiKUd3dkYRr2p8y4iXHa2hn7awMXjapVnChWYZKLr
 zNsA==
X-Gm-Message-State: AOJu0YxRhotWcxR9A1j8J5M2YC65+NhmFThA4U0lQk5XSarbqebLW177
 D2W95TOXfGfhQLnNGHqZ/Cm71pYgLv7Ns3JCpVBAFoqUSqWMvf/qrHBgTMIfiFfUySCvB54RbM9
 IMUvByigtyMTBQz59M6ryoGo0hWQQg0s06s/yXlpbQ63LR4uRqHIldRDyQNg0RhFRIwWnaBfoAQ
 194NyXnS69pQBDEGa3WxsQWmehCdy3qJ/lYA==
X-Gm-Gg: AZuq6aL3MbgjNOaPFq0mRXODxjICp67CGp7fYtX3DzMV33wzRlYXpPYgrwRuFsh9oeb
 dBuATtl0LchrC0TMHcBYA0UH+iPTV3i9haxadX4lH2ZMCWjWNgLZUU5gjB2tlR6wjIYtLzxBhHi
 9JZLb2wJP20w3y+zglrQA1ynfLGuRxcr4KnakvsGZIOPNZxyl+ayfb4GPq3R/DXrt9HHzbmuc9E
 4Skg790Te6FOJBVLAuzIQ/Zm17cAEYsVCqCqXQQFHWTuzIiPC+0J8YwVyNR+kIYQ+Xi4v4Z8HK7
 shKdDUCE9qX531giXxOovD29gKnotMz36ejfP36XoK2fLd/BLXMWO1qc/ZmpiiHOuPebBnOhVlX
 bZErcBBDcXIlMqPY1IaUtqH8TCgOGeNGHlA==
X-Received: by 2002:a05:600c:154c:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-4830e921d0amr46104735e9.5.1770231887496; 
 Wed, 04 Feb 2026 11:04:47 -0800 (PST)
X-Received: by 2002:a05:600c:154c:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-4830e921d0amr46104365e9.5.1770231887040; 
 Wed, 04 Feb 2026 11:04:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618058473sm8616782f8f.22.2026.02.04.11.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:46 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 51/51] hw/cxl: Take into account how many media operations are
 requested for param check
Message-ID: <1ef708ee4b765b9eac097192d54b69a603589f9b.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst the spec doesn't speak to it directly my assumption is that
a request for more operations than exist should result in an invalid
input error return.

Fixes: 77a8e9fe0ecb ("hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery commands cxl r3.2 (8.2.10.9.5.3)")
Closes: https://lore.kernel.org/qemu-devel/CAFEAcA-p5wZkNxK7wNVq_3PAzEE-muOd1Def-0O-FSpck4DrBQ@mail.gmail.com/
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260102154731.474859-3-Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8f62a13a8..2f449980cd 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2547,7 +2547,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
      * sub class command.
      */
     if (media_op_in_disc_pl->dpa_range_count ||
-        start_index > ARRAY_SIZE(media_op_matrix)) {
+        start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
-- 
MST


