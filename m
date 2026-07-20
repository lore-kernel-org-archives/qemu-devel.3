Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1624BC4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlogS-0002lE-Ty; Mon, 20 Jul 2026 10:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlogQ-0002kb-0A
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlogO-0008Ia-21
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784556561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u3IRo2FfwSRH3SmDYXoFL3FfZdxPQ3jnnPGCl1NtgQQ=;
 b=HSQHkgkvH/Dm7oxbcFancDFXeCAr+JfKYkbH3qCXdCVz6TKuIuYy8j0qUOJKiovIBy6qJb
 PmAF33GxTTu3BKJ3I6CFXMmfO1JQB21gNW/YQq3E0A2qhqGkck2vKE3Q7ZLqoyamMEXAJC
 ltD8AcAqxiJqqb7zMxcKP0hd8iF28ck=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-wNAHI_tIPBepgbRIdViYnw-1; Mon, 20 Jul 2026 10:09:20 -0400
X-MC-Unique: wNAHI_tIPBepgbRIdViYnw-1
X-Mimecast-MFC-AGG-ID: wNAHI_tIPBepgbRIdViYnw_1784556559
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92ec91dc265so656609685a.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784556559; x=1785161359; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u3IRo2FfwSRH3SmDYXoFL3FfZdxPQ3jnnPGCl1NtgQQ=;
 b=EvFRE56hWHwj00qIKGy92pfzGcnKcB3zfWx93GHC7K7c1YsYCXtgTysu53zPNbkAXR
 Mg7S4xfB4Zqc5/I0I9aSSFaQPCGdmPx7Y++76PmQER5IqItG+uf1mTG96mhXSrSkqcg1
 0+6hBb+zz2nDYI9Znu6qWSbvnUh0sFfc4VNrN0JVGsL3KwiFpkE721+HD2yTf4QsOJV9
 PEJG9LiTflZsxtr4ernyFr8D496EzOYFPKh+j/7QJGr5pMjplQYBxmAZkfU0uhbDg65B
 aq9MuL4uJNVIJjc5015qpiNcHOxNdH5j8ZlzcisWtQjxws/I/y76C/Y8obF+PSlCsuR8
 nEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784556559; x=1785161359;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u3IRo2FfwSRH3SmDYXoFL3FfZdxPQ3jnnPGCl1NtgQQ=;
 b=TGG+Qi8PYisPz/MSHngmSxBiZ+Ig2gN5OgErf1A3rT2ucpxY9Jrbmt0Qkn97geAvNB
 8/Emc91fD2dGCGIrbAAf6hKnBdTtYLXhta6GzSJJ5hzACjv/IXx9CZi/RqkYCgof5BCV
 E6taHxpifJlb5Mks2rEV9E4Q69ync0orpuCpYVzYUqi0piypjBt5zl0e98SZdeHblUtE
 rGlGacQi/01PZxqiCzsIMWN6cwcc4czaIPj78CZNgq5D90aSo+c5/mCTxDt/R3E9hTEZ
 MGarFIJTscxwn4dBUunV/I/xS1eb5MbJ8ubADGPBRB6Q6LYslKRiYZaU6ObYc+jz1Kkt
 P5Ow==
X-Gm-Message-State: AOJu0YzbnNaXoVCO15ehPfKa9FG1ggVJ/mTIwjNZeY1YDLnBQkHZi7Wx
 8+fuHaahKLfdFxgTtykcVLi2igK0toWBkeI/4bccjDGM1jMbtMBEs7B5DgShlidp9o1h+8qWoVA
 0r9PPD/T/N2jsP8JcrmDpff0QGaqedSAr9wjCUskNN300uuXjIcAW3+sw
X-Gm-Gg: AfdE7ckhlLM8oOdFcaEgPT4t62hMl6gp+7za8Y0G1xrzgLpansZ0BBPHy+c2sqz0EWr
 W0ID5n56YFN/SkjhvQah3P66QZxz14iw5Xz1PVTaARSw9ga+WcCvKFUJ4NVbll9vc+K+hMsvyGH
 Q5jZlaZ2KCI2Z3yXg17YZnpUyCalsJOccyzd739miT7p7cnhQhZU45Fo/OUNHP9F03cUsvggmsz
 kO85WYqFlrjsMAVzGRc53gE/v+ykNwxHDePQ8RTbn8KU644VOIz1PYqOt305jTiBlFytcxtMGwg
 Deq4LuCxBlQuhuGNQt3yhts103xzp98SJKN0ecwXTZbh5e1kRrNPoy4I/PiBUNsE+dYe
X-Received: by 2002:a05:620a:6cc2:b0:915:83fa:b3e0 with SMTP id
 af79cd13be357-930b3e4919fmr1369859485a.5.1784556559091; 
 Mon, 20 Jul 2026 07:09:19 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc2:b0:915:83fa:b3e0 with SMTP id
 af79cd13be357-930b3e4919fmr1369851885a.5.1784556558528; 
 Mon, 20 Jul 2026 07:09:18 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b52dd4fasm875197485a.4.2026.07.20.07.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:09:17 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:09:13 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 2/8] migration: fix qemu_get_counted_string annotation
Message-ID: <al4sCVxUxqrtmLjd@x1.local>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-2-fabb4db3c204@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720-co-v1-2-fabb4db3c204@redhat.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 20, 2026 at 11:55:31AM +0400, Marc-André Lureau wrote:
> Fixes: 394b9407e4c ("migration: mark mixed functions that can suspend")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


