Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D6EC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77kL-0005eS-1Z; Thu, 17 Sep 2026 04:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x77kI-0005e5-Mw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x77kG-0004iY-8m
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789634726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AtpW7GdIs+UQRnCNDfvnVDjRygyi1/x+G6MxuvGbuUc=;
 b=CVuqSbGGe3Lio2LP1LwdjV+du5kxtdIQePcnFsDStjuYD+J2+g7qFcTbwmBiVN4zJHr/Ma
 lDEGw6/WJt9UvsI/SGl6TNBSGTXt5UvOxECx0CQwQkJRunguecn5CyX+i939d0h10ixJ2l
 AgM8dtAloHJqhZH/tcFLQgOEoHFFNO8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-PcE8QrFlPa6Tag_RxncvEA-1; Thu, 17 Sep 2026 04:45:25 -0400
X-MC-Unique: PcE8QrFlPa6Tag_RxncvEA-1
X-Mimecast-MFC-AGG-ID: PcE8QrFlPa6Tag_RxncvEA_1789634724
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f4bff865cso309935f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789634724; x=1790239524; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AtpW7GdIs+UQRnCNDfvnVDjRygyi1/x+G6MxuvGbuUc=;
 b=Sj3xVtJFTd97Q/LFICmTzH51zogw6LrbVv1EholLY4KPWQVrKErTXR86cWQUXSlulX
 DQi76gDKGkgUPvK6DLx8sLU0Oa/yYsmRRuD1aXLCAVStaby5HOD7k0LkNXuS3kwJ1c4c
 S/A0yOzKu2yxW82gh2jGNOI5szJ3DePGYmsL6I2nIGOYmIGBtxyAJgr+xrJPDdw9MTzQ
 LtpDdVJ1w4Xjtb6vwZ1d/b2jWhnVBYPJIYgWD7Zo2HTPygFK72bCJo1NizvcVlCuPtQ/
 89pnU2rNtn2oWvFtwd7qFSTvEz0OfTVaMjpE2L7id2kWidvBovFiemuRTwZDDa8PZq5B
 H3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789634724; x=1790239524;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AtpW7GdIs+UQRnCNDfvnVDjRygyi1/x+G6MxuvGbuUc=;
 b=Xlcd5yXC+Uhug9vEYIAHliEl7wz7UnhoBCvitmYuJ9eDENrctIXpWPgIB6ZVa9rAZJ
 3gg4NbYVSfTtVOjpqdb8LTLivcrmLHzVrwSfYJtKmEnVy2aV6Oh/ha3dpeZi1gvmBHXo
 n6/08xZhPGVpPo8GsFsAIP2T2BTAR1oZhd08i748wkiYgVsP2ImHd+F/d7/HtCoELGBw
 eTnLQpa6IfQ+DGgHb0X+USYZVgVTcuC65AjIaKNGELXTwO6c6gN9uLX+HgyW3VpNvbjt
 xKQ8viMz9aYdFlaynYjiydV/sfJ40snvQgbQ9qhlU0sQX9kSzTtgYY+w3EGJYqmB9aVB
 gniA==
X-Gm-Message-State: AFuF++lthXM9yiAEqaVFItDVUH7Y4NYEQ5sPzd0An4/wVA5t7ETV5cgV
 KTYmXWxqu4pk16OUaA26hD5BkBpebgz7gKOsQGORptGAAAtNdHq2ezGc7GWL6ivkswGGxhF8tX8
 TW8aU45guGPtT1a7LLNmDBfd+GJGtwONJOjRKHWOcPusutpAmzRDvj2bk
X-Gm-Gg: AYBFou290QTr2cenNotcJausK2CehjQnis2dsUrhR+OQKSV3mdhg7Jhlfw1z3bpTfl8
 S/rkqNXZjefM31bmvN6LsvQlMffHJ5I+fClrHal10TyDhDObsWarDVQzMH1CODKWsPa2XHwTMVd
 yKI+xKjSGmewZP8FW+5grpPcZ5mO2D7MQsc1Z1fX4B6IICxpCnrnnIXCcoL5yyQBhUJK//S9q/s
 QChKR9VfIb3752zpseBdyI6WpENIYoCa7EKW1haVOO0d3Rk0X7h6xy/J0x0Gm8uQd9JjqXVvHTz
 zygpGJdTJa2Za0POlCa+TYNuvojv3DQ1y0/H76PUVcR38TtZEgk+6LzTYuzDNAhhrrWtgaLMNoB
 d7TTKfFhtWKSrf746keu24BOrLY1Eu3/NKw6yk0KUKMSfEA==
X-Received: by 2002:a05:6000:46d7:b0:487:c45:3957 with SMTP id
 ffacd0b85a97d-4870d05d37fmr11444150f8f.25.1789634724173; 
 Thu, 17 Sep 2026 01:45:24 -0700 (PDT)
X-Received: by 2002:a05:6000:46d7:b0:487:c45:3957 with SMTP id
 ffacd0b85a97d-4870d05d37fmr11444108f8f.25.1789634723694; 
 Thu, 17 Sep 2026 01:45:23 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1f80bsm12880320f8f.7.2026.09.17.01.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:45:23 -0700 (PDT)
Date: Thu, 17 Sep 2026 10:45:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, luzhixing12345 <luzhixing12345@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] vhost-user: fix SET_MEM_TABLE number of regions
Message-ID: <aqucfWDDNKWlGOdC@sgarzare-redhat>
References: <712e301bf7f815412fb264de8159cb3475bd237a.1789469028.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <712e301bf7f815412fb264de8159cb3475bd237a.1789469028.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Sep 15, 2026 at 06:44:01AM -0400, Michael S. Tsirkin wrote:
>vhost-user.rst says the legacy SET_MEM_TABLE contains 8 regions, but
>this does not make sense - we have a num_regions field for this.
>And it is not true in practice: if QEMU has less, it sends less.
>
>The incorrect wording was introduced, without explanation, as
>part of an editorial cleanup. Probably an oversight.
>
>It's really "up to 8".
>
>Fixes: 1958bb23b9 ("docs: fix vhost-user protocol doc")

I can't find this SHA, I guess the right one is b87ea798eb

The change LGTM, so with that fixed:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>Cc: luzhixing12345 <luzhixing12345@gmail.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> docs/interop/vhost-user.rst | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>index c1e02ff7e9..488214a306 100644
>--- a/docs/interop/vhost-user.rst
>+++ b/docs/interop/vhost-user.rst
>@@ -248,7 +248,7 @@ Multiple Memory regions description
>
> :padding: 32-bit
>
>-:regions: regions field contains 8 regions of type :ref:`Memory region description <memory_region_description>`.
>+:regions: regions field contains up to 8 regions of type :ref:`Memory region description <memory_region_description>`.
>
> Log description
> ^^^^^^^^^^^^^^^
>-- 
>MST
>


