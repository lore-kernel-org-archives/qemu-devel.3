Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4BCCD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUhfd-0003Uw-Ax; Wed, 03 Jun 2026 05:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wUhfZ-0003UM-4k
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wUhfX-0001R4-NO
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780478026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n/NJPOPb3Oxf4n/3fP7l0ZxBRWPofSYLWXdyN4NZErI=;
 b=D+C31zKkTyG546700KFVOd4JVcFEhTYWRw6v2jIfn5RJloOOM5RzrLigHgboHrVy7nVdco
 0E0Djmc4eESPZbAjXizu3T/dN4Ii2nYCl9iBs40ntZlsDd6EPS3PM5e5kVW573JVoA2jxI
 Pk1uBAu9oTtSaI5R87qLQ+tr43WKLac=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-QdNcL45mN6eLW1vtiBFeTA-1; Wed, 03 Jun 2026 05:13:43 -0400
X-MC-Unique: QdNcL45mN6eLW1vtiBFeTA-1
X-Mimecast-MFC-AGG-ID: QdNcL45mN6eLW1vtiBFeTA_1780478022
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef93c359fso3383256f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780478022; x=1781082822; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n/NJPOPb3Oxf4n/3fP7l0ZxBRWPofSYLWXdyN4NZErI=;
 b=FcW4GCdXtgfhieECztkaLnpay/vD5RXIUra4JAuVI7YCB2sjHjyOOXuuwytx9wlxV6
 faa/sorczsTR1DvUtnItg3aWH7CMYGZnumSkByPGLMvkgclSjBWV2g9246rgzbu689Hm
 v+6zt4hCAzP/FY04LLrlkErG6IEUWCi8RIAbP0SdxvELiFjS6PsgbKgx5ISwieQheyyI
 bWNx3cgp/QZ0pkYGpH7ND/FqP9tsrYwpoo22Jo9eFhkLFM4WaoAnH4cP8qevag0v2wl9
 Z+4LjaK9c//NRu3TscEn2v8ke9zXQQ54kLgM6LMag88jyOr/zdYltilLlepa6J2gL0no
 CXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780478022; x=1781082822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/NJPOPb3Oxf4n/3fP7l0ZxBRWPofSYLWXdyN4NZErI=;
 b=NscLr9rKvexZqcTQit4VZ+bT++anqsUjybvGtIhk5nYZ/tUwNMnSdX3y/kowDQguKz
 5t2P6Cdp36L31+VRZu26qvP1Rf7lNkHtWVIbxHVPp8qxUuwiwD6M/qHHO+GJ1EeNaU9s
 fdU1Uf6weezkQPWBYF29fXkr/3xGBQqnyj519HGsWDN9DMzWAeNjK5M7K/3VwX7vlY7O
 o9pRE42crq8ZxSSvULVH1aR5RSK06egF1BHfm4SiG6+4AZQ6h8wv0n/2/Ig555OMQcCV
 4q5W27i13BQ3C032W/U+ij1vDNur6ZKTeFtwwl1iMhJPkLdKavpVUECR7wJhEaMJ5hf0
 Kn+w==
X-Gm-Message-State: AOJu0YxqFQ1PVwPnZJPwN78gf1Z//L6QplCiZg7grXuoty3nHeQqQKD2
 3iYpJcd3Jg2oZXTzLTjnHrz3nV9XU+KGtuVPK2nXQuhjvMrrD+Fq0PLJVwixmbzJS/trjnyRtCg
 d9eVTCv4mb/zhVQA+iC6G2oXMzAMyufjqfrIo3iO0SWGqTCTkfRGHo/8t
X-Gm-Gg: Acq92OFvpKPdhVP5H8V6QWo/SI28m/zf5QuxsTr4u5MyB4sLJdkJR57DqpPCI2j8TUA
 fOjNQXpqGl7frbLcKQHQ0AfkZWI8q3OTDpRuoIiVeajKyy1T/R5TkQ10ee/NN7HkpdYQ+tu6MDG
 rll1ZGB67jCld5SVFJN88hLZs7z8J99iaksMkYEvB3CaYDFCMMDzwUhlo2qFUwfIIn5//0caBU8
 mqpzoSyUTtQvGboCOQhap5sOnJZTGxSzeqWiFkLjbgYY8qq5DTbvdLo87dBET99lWXUsVmXfsHB
 Q0kidOohy4IhrHNDm5IYtT05zzC0LPdSZ9mdFaysRoj6Z9ItrAArDV50PwBGIyglc9s90MiAm4Y
 6WQ8k7x4lv6kNrF/IxYgUy1PZ0RN2YWIab6gvSg==
X-Received: by 2002:a05:600c:a307:b0:490:b7e6:bd1d with SMTP id
 5b1f17b1804b1-490b7e6bfa0mr21935145e9.16.1780478022268; 
 Wed, 03 Jun 2026 02:13:42 -0700 (PDT)
X-Received: by 2002:a05:600c:a307:b0:490:b7e6:bd1d with SMTP id
 5b1f17b1804b1-490b7e6bfa0mr21934785e9.16.1780478021739; 
 Wed, 03 Jun 2026 02:13:41 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.118.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b6d16f0csm43144955e9.15.2026.06.03.02.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 02:13:41 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:13:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 hreitz@redhat.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 gmaglione@redhat.com
Subject: Re: [PATCH v2 3/3] vhost-user: inject kick after SET_VRING_KICK
Message-ID: <ah_wMkIxfzNorE-X@sgarzare-redhat>
References: <20260519191548.335082-1-stefanha@redhat.com>
 <20260519191548.335082-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519191548.335082-4-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 19, 2026 at 03:15:48PM -0400, Stefan Hajnoczi wrote:
>The vhost-user specification was updated to say that front-ends should
>inject a kick after SET_VRING_KICK in case the back-end implements the
>old spec wording which said vrings start when a kick is received. Do
>this in QEMU's front-end.
>
>An example scenario where this behavior helps: the back-end fails to
>check if the vring has available buffers when SET_VRING_KICK is received
>and the front-end stopped and then restarted the vring. In the case the
>back-end may not notice the available buffers unless the front-end
>injects a kick.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> hw/virtio/vhost-user.c | 24 +++++++++++++++++++++++-
> 1 file changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


