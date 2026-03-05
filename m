Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B110BF3D33D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCHM-0007qO-VF; Thu, 05 Mar 2026 12:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyCHL-0007pP-2j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyCHI-0005Lf-Uq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772730864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=su9alf3DsTTLWrWiGYUOM5ix7KwPbc/XlrZe9ZtRvjM=;
 b=fabi8BzrEadSDUNsMQkwDu+qukzMa6kuAKDWH3+O+BSxb/JZLKfhNk77+elb0BZB3q7U9I
 /bvY2NUM9E3iBCt7+I8/hOq3HWC+dxlGeIrXdeK8Z8eChV+H1U8YodzZA0UleBoj0Qrh1o
 omSKOg5qI/ehmgZKAD/BOirZmDoE3ys=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-JTGPsp8YNhSyl6eyrOmulg-1; Thu, 05 Mar 2026 12:14:20 -0500
X-MC-Unique: JTGPsp8YNhSyl6eyrOmulg-1
X-Mimecast-MFC-AGG-ID: JTGPsp8YNhSyl6eyrOmulg_1772730860
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-899f92be718so153651766d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772730860; x=1773335660; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=su9alf3DsTTLWrWiGYUOM5ix7KwPbc/XlrZe9ZtRvjM=;
 b=p0SF4y51qCgML3p0n/K5QyJruSVZSYecVLZjvHPeKJkCfeMOjoRV9UubPkrH8DL7fK
 BGVXlKGhymKC2XBGw8ZO9FEymedZMYEEomfq8Qdg7I2pf5rTDp8AUcCHz2Yp4WvOOHIj
 x/Zaaea4FsDqBHc3R+QNU7ZbDUnrPPL2Rgi8oJeHoJZ2opzZxW+oRlBichr36xkh3ISp
 kLr+LwRv2uE9QlR069ZX74GPMRLqSW//JVeIZsr7EAj5LPh72y7Ve6ZVr+5fuG8suH5u
 y3YgbBv1m/CCiwqr3TH7QfyKZKaJ4+yLRT/L20kyAywUIyzKLdRSctklKNnJo211hTZ3
 3rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730860; x=1773335660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=su9alf3DsTTLWrWiGYUOM5ix7KwPbc/XlrZe9ZtRvjM=;
 b=Avo0Gf+ooGJfPBa/TkfoL1G/RPpzoVf+hPk53oumxcCE1GWKr3b8nSQ98ejaKdmf+q
 aarnlDdQt0WC/mgs65lvZreo+q36vNL+e00YxwI6cbVEjv0t51fo2621lJxPNjKuCv6D
 H6Ud603mxOymjB9VYFYAua7cSYa7/xSfObjtw1LjyzjUPKSx17ZQmTaI6HEyfhx3T2h/
 Z8yLtCnO7gLPP5Jw6qcHGinF4DKxdPJP5nc+LteOA24ND0YpuCsUPUvHReT5mVyfJkJq
 j1Tjj29ojYQVJybBSLEmajmCCVjIeibyO6De4qrjgotWFVuAIPjjlvtA+m9K0WXjSzCz
 kuIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1aA9fxRk1yPFjPbKiTvEyUnpN2vanUnhNwC9q5AItyKD4j9EfxTtYODmnGytjiEJBzVclLG/9v1jK@nongnu.org
X-Gm-Message-State: AOJu0YyzTCGIBJ1NIzNuDZ4AOMz2lcMDRukRc5nGpvM3uZ7Vq9CZj+Xm
 uoi9Jxb1hLYmbp2318Sw1KdNW8RxlTaLX9KiNofuEoOGG6gd6VeR+izaLD+0O3CKY79AyUgw/2H
 XHJQ7s8PV8P0RyYELq2Qak6LuRmMLang3o9qSsbJfOsVfP853JQ+TxseV
X-Gm-Gg: ATEYQzyJJHzB+lisYzXmD14MUAr4+pjsd9a3pLOhr8Pmt7Q7U38rYzMFDjtXZcDeAZB
 kpFbPLt2fplkTZgUh6vR36VMb686KLaxgBpZl7K8cukL41av7aY8uDc5jrUCaKD34crtE7JljVe
 WrmSt1am6h3hKUpJgbQJ9wJG6BDHqCx76AoVFa4pXzTNcBCeS3UPeuUN9HG4KUEanVua9qHlFEj
 6qojDtvL5l/phPSkL6l5wkrmIHBnaFIiiK4xwwqu1MoDJDExRScTxcHUbMW2acHe+ZjxztEf4ih
 BM97Ug8JJlmk9yyxe6FUlAEVovqAi6B21FyhlpoSrhBamuIlbqKqO9yRjMwu622wVytcpFp3Bkx
 tFKbqsIoTa/bhfg==
X-Received: by 2002:a05:6214:1d06:b0:89a:110f:8946 with SMTP id
 6a1803df08f44-89a1997a12bmr95585766d6.13.1772730859977; 
 Thu, 05 Mar 2026 09:14:19 -0800 (PST)
X-Received: by 2002:a05:6214:1d06:b0:89a:110f:8946 with SMTP id
 6a1803df08f44-89a1997a12bmr95584826d6.13.1772730859036; 
 Thu, 05 Mar 2026 09:14:19 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0485ca0asm87966486d6.11.2026.03.05.09.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:14:18 -0800 (PST)
Date: Thu, 5 Mar 2026 12:14:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 channel subs..." <qemu-s390x@nongnu.org>
Subject: Re: [PATCH v3 16/18] hw/s390x/css: drop use of .err_hint for vmstate
Message-ID: <aam537fYnkAsskav@x1.local>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-17-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304212303.667141-17-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

On Thu, Mar 05, 2026 at 12:23:00AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> That's the only usage through the whole base. Doesn't
> worth keeping the whole complexity. And 2.7 machines were
> long ago.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


