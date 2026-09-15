Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EBAC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WNU-000801-R2; Tue, 15 Sep 2026 12:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WNQ-0007zP-1n
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x6WNI-00086C-6w
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789491074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVwkm2GOKcXaWGzJGET17BZVUmRG25MvVyuBFZPf+PE=;
 b=RtHvj5w59ehhelV6PL1gHIoR/W78BOyOXvFuwwbqKCJcQC7+2ycJLnnoqhepXVL5DlFTqw
 CnR7wYznXqUvYNXuyS3nRhklhlKEtR0LPmKgWHBWsxcUPYEhFxwVz9V6nheN84a/s2jHQa
 fXFCD8NB6JZyyolLUpv4uyTWvMDCaCY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-_nU4gSqGMNenkYkVQMSYvw-1; Tue, 15 Sep 2026 12:51:03 -0400
X-MC-Unique: _nU4gSqGMNenkYkVQMSYvw-1
X-Mimecast-MFC-AGG-ID: _nU4gSqGMNenkYkVQMSYvw_1789491062
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e7631c43aso27260745e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789491062; x=1790095862; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pVwkm2GOKcXaWGzJGET17BZVUmRG25MvVyuBFZPf+PE=;
 b=sMJGRwhFYVDwdNDUEniZPO9N3YJ+0epsO+J6wGQj/lby07XFF7fQ02Zqaf61HVelry
 Tvxyg6jub87MZWkEwYbDUCtYIiTstvPl/LA6FLDVwT8ZkE7sV0+W4tBXsGJvDm/WU1kt
 0rUonYnU7iruiAYHpxhjUz0SY0b5LkTzssREICVUSrjtP5zVP37kexM4jwLtkaQt9glW
 qxkUtA8QhBb24qyEdu8rMT7sndcSoaNRPkFmBdvWhQk9wt5S7W1XBEkzfCdHlesJI5ga
 qG1TC1MfXchZ0KY8OdY2PdT2WFl4CO4yFw1gyd4SAhfObi7Ai3XuG7A/4vBlhJdw+s4R
 T6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789491062; x=1790095862;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pVwkm2GOKcXaWGzJGET17BZVUmRG25MvVyuBFZPf+PE=;
 b=F7tOaP47ct1IkfCx9XhxjjwmywDTLcMkkYtF1IXNN9pdmGmQC9CxKg0DD+LURsUm6R
 IcAwsltYWtCh3GpYM2XGQMuqtZ14k4QV4wwvPxi13uAsPtbk7XhmHcvJeIMDNAWNS/KL
 7NaWzJYUnZj6Y6HqAQGzyn5B0GWDzCdZ7SSttPwjbVgMaz2/RIPZKiFKczSTfSyyby4J
 lnB5sS4qE4wFd/YqJ5+OtRpsoXspT2xfCvKXPb3d5ZcS5GRqsXc55hUseGMD/P6s0tfP
 4Z9akMbmjWYNHjKmuNk3jRb4z9nA2VQuyNB/6lbaz993desJM4UTxb022T6YsFfQDcwe
 jKXw==
X-Gm-Message-State: AFuF++laom1ywGFRf5htb4vvDphdyJnl4kiRaLJ4tlc0Jh92c4pHRXCi
 cFvAUxfOsF3QClu6NeXC4x2c4biqhQGouWrxK01lKYxQowifEDftqETERBCzmz/Xazxc1gyspj0
 pNTg5y8BBMawQHKNx7HMsGNosqnpwG9fuFRkFKPPxqTmWbEgwBfTK7CGf
X-Gm-Gg: AYBFou3FsWGLRLSBz20Ln7Ikeyz6Q6O/GbAHi8PJd+bj0Z8y3ZwUF1WgMiSja44NtCX
 XP4i5Vebg9cSf2SJrjZsz53r/AFGuGoMPzO+QVeO33gV4x7vJjZyTC1f/Uw7n/bzSQAq2F5mRxw
 dKfKkAayV9XunBVYLDq+T32vnLdHyCBjBIkRWO+DAGxyWOyktdMz7GWcitXJybu/XC650N4HN4k
 bE7Lq9XtUm9mEmkdIdxRdS7vPeKxcokgt6W/L0wQ1qFbMNQoMcmTQsfVlzbA3NsRDq87nssq7CS
 LScRyY92bIeeQNyhMgRarBO3dGeWOH0ObMNU1nvDOeCEOd5Y9x6tLow616mmiFQIepOy2nFsq8E
 UUoQ1M5TuGjftbCPiVG3UP8M=
X-Received: by 2002:a05:600c:698e:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49e7a638778mr189541325e9.3.1789491062064; 
 Tue, 15 Sep 2026 09:51:02 -0700 (PDT)
X-Received: by 2002:a05:600c:698e:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49e7a638778mr189540615e9.3.1789491061557; 
 Tue, 15 Sep 2026 09:51:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83aeae01sm8940165e9.6.2026.09.15.09.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:51:01 -0700 (PDT)
Date: Tue, 15 Sep 2026 12:50:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, marcandre.lureau@redhat.com,
 mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/display/tcx: use memmove instead of memcpy for
 overlapping blit memory regions
Message-ID: <20260915124754-mutt-send-email-mst@kernel.org>
References: <da75d0f0-d98e-4e27-ac6c-c575a2d382ff@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da75d0f0-d98e-4e27-ac6c-c575a2d382ff@swemel.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

thanks for the patch! some questions:

On Tue, Sep 15, 2026 at 07:20:46PM +0300, Николай Зорин wrote:
> SWSA#34e3af79-c6c2-4ad2-986f-313c1ce28e5a

what is this?

> In `tcx_blit_writel()`, memory copying occurs within the same video RAM
> buffers (`vram` and `vram24`) using source and destination offsets that
> can potentially overlap during blit operations.
> 
> Using `memcpy()` on overlapping memory regions triggers undefined behavior
> according to the C standard. Depending on compiler optimizations, this
> can lead to graphical artifacts, memory corruption, or unexpected
> behavior in the guest system.

was this actually observed? in which configuration? which guest?
why does the guest do such overlapping blit write?

it also seems unlikely to depend on optimizations - more likely
on libc.

> Fix this by replacing `memcpy()` with `memmove()`, which explicitly
> guarantees safe and correct behavior when memory regions overlap.
> 
> Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>
> ---
>  hw/display/tcx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 2cfc1e8f..fb48a199 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -587,9 +587,9 @@ static void tcx_blit_writel(void *opaque, hwaddr addr,
>                  }
>              }
>          } else {
> -            memcpy(&s->vram[addr], &s->vram[adsr], len);
> +            memmove(&s->vram[addr], &s->vram[adsr], len);
>              if (s->depth == 24) {
> -                memcpy(&s->vram24[addr], &s->vram24[adsr], len * 4);
> +                memmove(&s->vram24[addr], &s->vram24[adsr], len * 4);
>              }
>          }
>          tcx_set_dirty(s, addr, len);
> -- 
> 2.43.0


