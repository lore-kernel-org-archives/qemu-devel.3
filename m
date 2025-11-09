Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E318DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 08:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI1DT-00018U-Dq; Sun, 09 Nov 2025 03:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI1DR-00014h-Hv
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 03:56:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI1DN-0002ij-0K
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 03:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762678558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+Q9bEYYBTNHIl+DYCmoTR6Paxg5AZSMxtkEDPwN054=;
 b=WAMiZ3OOiXtLKbqnWN07ylhIt8maDGZnX/gX2DanPpEaqP/9gBDM875aPN8eKMFLWFOnIc
 ipc9ZTN2hv7kM/79AKL/WuWVzNntUHqozQX2DM+dzzm/wpogZYrQ9+0j9/K9Nz9gb9UTUU
 +omHhO+kixzQiRvi4xqkAuwMaphIBtQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-ECB3cwTQNpm0D_OJ-McX0w-1; Sun, 09 Nov 2025 03:55:55 -0500
X-MC-Unique: ECB3cwTQNpm0D_OJ-McX0w-1
X-Mimecast-MFC-AGG-ID: ECB3cwTQNpm0D_OJ-McX0w_1762678554
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c19b5e61so1270069f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 00:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762678554; x=1763283354; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+Q9bEYYBTNHIl+DYCmoTR6Paxg5AZSMxtkEDPwN054=;
 b=sNFZzvkhNvaOMQoNYjp6IamG+jt/Fr9OC6OAt9826yjo+IbV/M84YgLBqQq8MW58Ky
 GZ0aXvhjMGru94pYVsp4+C42yoL689pxGFLPErIJW3M2Bk9wT5Z0FBEe4cjaWEyiK20G
 IBmx55ATlXyG8jZ8FMI64lc+irpsEkjABtBPuX7PjCeVp3S1FPnwtdZMDgB/MmOyMxeh
 ug2mpv1iHjjBT/GIDx4NxLH7UC3nQltd04f3HODVBp0HXDYBzDHlbJO9xpBhMv0+Jouk
 0XrvfYQwRV0BAihaiA//RU7/1pef855/vh9AjUkRq0U510yfVEQlAxUQ4/6JihHnQMVu
 BHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762678554; x=1763283354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+Q9bEYYBTNHIl+DYCmoTR6Paxg5AZSMxtkEDPwN054=;
 b=oO1GrWS5mdAsfj8lSTot4akJGbI4Im0Or5GOALmMRIeKi+oAgAGkwVVD6CxAU5hwEt
 05zl9DRZkJxoSb0OkdTWhwmDLdalqeScOLsQdYV4ZtfI30rtSSF+vq+sfEjr4gPnFrEX
 GrIasza1WQwu8RwYYR3Zq3YLMO0z20FtW0TAFx/4sAtVEOiJ+zepFdBnZ9mEVLa82nD6
 c4SGE47qaAGJxLChIiK6xAOESoxfm7GHs74MHxdF8bbLOQGVGW6FNEBxISBhnzm3BOvT
 g8tV0T8iE5WvOXwYblfm1m0Z84heaZ/DDevtBeLwMFS9nLJCfA1q4G4XtO10/o+3RVDW
 PJoQ==
X-Gm-Message-State: AOJu0YyvK+sFNZDA8rB+WCF+Z7dbrOvPyP3EwfqS/TxwwHgxanwfDRv5
 VuNhUejnkqBuoZY/PJiDo+8X8wKGpzWKBTmdzfBBAKFxyfUOcZO/AihcAxU6SlBPNZKUg7X6uIX
 gROMZIaIg6+Vj0Jf6y2lZGKZr7JbJNv5PZ3VGGsd0E/kv+iQT3XC2oYtc
X-Gm-Gg: ASbGnctVuQNNUstClV3U/OA8dVqSBX4o6fPS+c9xScnD72GRa3l3gCL2PmCNXnswn30
 xVQkHok3B7DjlKkfpPF7Of/pbVKqg+EGPp6FYJFdAQHs75dlpU23vkiXDfVl1kUIfy1/Jt+PLZ0
 YbHFavDfeDC7g4ZpDuAo2iQOiehpP9tAtBz8alOnujDl4oNKoHLB20cyGcmHqTCmM3vRda8TVdj
 bqrti1fuTUjIUbLsm/edlHePGgnOs2lwgQR/XB14AgpmayTZLzfTJf7u+CsikjvDs9zIvTLeHVf
 nq5ft6L8ra1Ap8IPBoFfpJg+Blc5paRSjAXklPUSLzHPCYeh9mhQArAmphIfT9Bmp9w=
X-Received: by 2002:a05:6000:40cd:b0:426:ee08:8ea9 with SMTP id
 ffacd0b85a97d-42b2dcbd88fmr3471624f8f.44.1762678553878; 
 Sun, 09 Nov 2025 00:55:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGo38vIQ3H5blzaHbEFX8Lp2ZptkQ9TiuCWmO9i2RJZLRWnxh6SnwOm23mgPxFauipdOjxAYw==
X-Received: by 2002:a05:6000:40cd:b0:426:ee08:8ea9 with SMTP id
 ffacd0b85a97d-42b2dcbd88fmr3471610f8f.44.1762678553289; 
 Sun, 09 Nov 2025 00:55:53 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe62bf35sm15637730f8f.7.2025.11.09.00.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 00:55:52 -0800 (PST)
Date: Sun, 9 Nov 2025 03:55:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, Yureka Lilian <yureka@cyberchaos.dev>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-user.rst: clarify when FDs can be sent
Message-ID: <20251109035512-mutt-send-email-mst@kernel.org>
References: <20251106192105.3456755-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106192105.3456755-1-hi@alyssa.is>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 06, 2025 at 08:21:05PM +0100, Alyssa Ross wrote:
> Previously the spec did not say where in a message the FDs should be
> sent.  As I understand it, FDs transferred in ancilliary data will

ancillary, actually

> always be received along with the first byte of the data they were
> sent with, so we should define which byte that is.  Going by both
> libvhost-user in QEMU and the rust-vmm crate, that byte is the first
> byte of the message header.  This is important to specify because it
> would make back-end implementation significantly more complicated if
> receiving file descriptors in the middle of a message had to be
> handled.
> 
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  docs/interop/vhost-user.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 2e50f2ddfa..93a9c8df2b 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -411,6 +411,13 @@ in the ancillary data:
>  * ``VHOST_USER_SET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
>  * ``VHOST_USER_SET_DEVICE_STATE_FD``
>  
> +When sending file descriptors in ancilliary data, *front-end* should

ancillary, here too

> +associate the ancilliary data with a ``sendmsg`` operation (or
> +equivalent) that sends bytes starting with the first byte of the
> +message header.  *back-end* can therefore expect that file descriptors
> +will only be received in the first ``recvmsg`` operation for a message
> +header.
> +
>  If *front-end* is unable to send the full message or receives a wrong
>  reply it will close the connection. An optional reconnection mechanism
>  can be implemented.
> 
> base-commit: 917ac07f9aef579b9538a81d45f45850aba42906
> -- 
> 2.51.0


