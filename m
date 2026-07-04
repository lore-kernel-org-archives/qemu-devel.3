Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A038C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfx8H-0003IB-4g; Sat, 04 Jul 2026 05:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wfx8F-0003Hc-B0
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 05:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wfx8D-0003Qc-JE
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 05:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783159072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWIcsBFhb9WaV3xqHV2W8M8keb2oFHZF3x9btElgviA=;
 b=BMmIBdul8MKvg+uXSDHtnYWelAyhU/iAzdrm7wv5UWow8ZxEKvK2V8hKbJnZi5T7vnI3Ti
 CkS+3E4fLR2lm9o13MHsVApGMwgILn8Kltf2NM95H9IsNp4rngSyLIu11tMcTVLFIZSdVP
 pfQhMq7sCgkii1JtidbF2UGqHe2Aq8o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-iOYGwXswNiiY0PljSaO58Q-1; Sat, 04 Jul 2026 05:57:50 -0400
X-MC-Unique: iOYGwXswNiiY0PljSaO58Q-1
X-Mimecast-MFC-AGG-ID: iOYGwXswNiiY0PljSaO58Q_1783159069
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4784d0fb9cfso757870f8f.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 02:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783159069; x=1783763869; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dWIcsBFhb9WaV3xqHV2W8M8keb2oFHZF3x9btElgviA=;
 b=mraC3FghjJIiXMeofzm45CDovKYHkOh+svbGLMxL/0330b3hSWs42yCU7LdrJEDCK6
 Pv4ydIJfC8fJKP0HU53lmPZANBGXammgqMyTdYfxS0XwXcsFOTyHUxqzeDUkY5meVbgQ
 Wnbq8C55PBrFGabz4nRE2S3G+Nbsfv46IhY1iRhJLfCenwYsVAqSIfLeo/tJvd2/IorZ
 FP0GpY5GGR/q6nraxPETTXKwWIki/Er1swLqoheH56OuFxJ6le0yLnGAwE7+8ixnAte8
 W9To79UCZR9hs2ZSUA/5yuex202t8QfVALR9nQhlHqCeYs5lfZ5HjeDbtQoyHqn9CTf5
 iR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783159069; x=1783763869;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dWIcsBFhb9WaV3xqHV2W8M8keb2oFHZF3x9btElgviA=;
 b=BlCB8rly7nUD07snq1d/j6/4D+9r67vVeQ0p7Faln4FPKlme2nFV2bqzNip+xXJGWO
 bZGE3obZjc7GsF5d+8ldW6sryIUJQzpyBOLVY+iLhaujgByLMsQBIUv7tI5kTjOdisiO
 n0ccsMCIhBgaawT8udweimuT2bqfgxv3q2n6ZKIGUw8V+avUgHXzvBz/fCKQeNhZGwH9
 L0G3RKsNzC0W5uuPfPe/DyIjrUatrShB9pr9SDc1JOibeWvk4N5b4JzLV+RycninvuDa
 x1CvJl6jE02Kc97urDpYyvuzm/7UxAjyUMyC5DtUwK1fcnOdGi84q26U2zWyoQJcg7lQ
 nd/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqajusxlLk6S/7GFJKQwBvz97krOusF/B4+vLjAcpkJw9q6xevMGSxCD5v4JlMN9dPeHRY3uIg4ONKC@nongnu.org
X-Gm-Message-State: AOJu0YxYEkQsnsJe29TtlLyGxs6GAyC9Yeps6otsORXKCbgl3CQ0d6QC
 +qVPujJHVgEw9P0IeqKzeIbe0Na86jhMX/yXeUyv5MP/uCNCeyM0Lg2+st9Jy2UG0oPVCjWH67I
 TRBVhzQPzzVoGKOGLUWOKz+YSJLeqfUJfaBGPeWuvuX04C/VItwf2/V4g
X-Gm-Gg: AfdE7clwEKvfkxLqCmvd+72K9ta0szEmnKYF8oYh7mdE/XDIoSjIyPNzVNhF7v1Lw+s
 9xyM0fH8YcOzt+iOtN4R8Upykiuxo2CNoRdzyjeWNAMcL9jwPuqt7AzvKkNqsi8tq613Na+n452
 kjE//iY/XxsMlS3cG7CNzRycQPweXk7QKX/hZKCPcy4Dog8sU0mhSwe/A26+z1K/HrdKVB3gRrd
 cVAEUg/HV6eUp6TbqRRDtZ/xDA35PwMOvyFeNGJzoo4HzsiKV39PJECS/RShAA9O/Nki81FoL27
 bQGSaUYM5HeegY4ulOwGTo+Ua5oa2DKwKSjyd0N0SxXfv6a0/mGRRpalEx1SxseA0TNroUWWOXM
 Vdlx7dJ3SQoIhBsb+wNUDOelGXsIpFi3gy7q7OhtwlA==
X-Received: by 2002:a05:6000:230b:b0:476:6bd4:82b8 with SMTP id
 ffacd0b85a97d-47aaabdda82mr3347495f8f.14.1783159069265; 
 Sat, 04 Jul 2026 02:57:49 -0700 (PDT)
X-Received: by 2002:a05:6000:230b:b0:476:6bd4:82b8 with SMTP id
 ffacd0b85a97d-47aaabdda82mr3347466f8f.14.1783159068793; 
 Sat, 04 Jul 2026 02:57:48 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm6314494f8f.37.2026.07.04.02.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 02:57:48 -0700 (PDT)
Date: Sat, 4 Jul 2026 05:57:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Raphael Norwitz <rnorwitz@nvidia.com>,
 Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-user-blk: add seg-max-adjust flag
Message-ID: <20260704055717-mutt-send-email-mst@kernel.org>
References: <20260401230548.136541-1-heifetz@yandex-team.com>
 <82d9d2d5-7102-4b34-ad7d-df0e8f77b509@nvidia.com>
 <573d11f7-71e1-4f31-bbfb-884778961e14@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <573d11f7-71e1-4f31-bbfb-884778961e14@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Jul 04, 2026 at 12:17:40PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.04.26 18:24, Raphael Norwitz wrote:
> > > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > > index c151e836770..23f910d9fe3 100644
> > > --- a/hw/block/vhost-user-blk.c
> > > +++ b/hw/block/vhost-user-blk.c
> > > @@ -65,6 +65,11 @@ static void vhost_user_blk_update_config(VirtIODevice *vdev, uint8_t *config)
> > >       /* Our num_queues overrides the device backend */
> > >       virtio_stw_p(vdev, &s->blkcfg.num_queues, s->num_queues);
> > > 
> > > +    if (s->seg_max_adjust) {
> > 
> > NIT: declaration at the top of the function
> 
> Hmm, no, accordingly to docs/dev/style.rst, "at the beginning of blocks",
> so, it's OK to declare it at top of if-block, it's often used in the code,
> look at output of `git grep -B 3 '^        int '` for example.

indeed.

> > 
> > > +        uint32_t seg_max = MIN(s->blkcfg.seg_max, s->queue_size - 2);

if you respon pls add an empty line here.

> > > +        virtio_stl_p(vdev, &s->blkcfg.seg_max, seg_max);
> > > +    }
> 
> 
> -- 
> Best regards,
> Vladimir


