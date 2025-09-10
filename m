Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2960ECA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 19:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwQwL-0007VM-51; Wed, 10 Sep 2025 15:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwQwI-0007Tp-G3
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 15:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwQwG-0006nM-KZ
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 15:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757534226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJfvX9CUxyXyMBgYTXCZWxleiRPqIAo4Pgyhuf2inlU=;
 b=hPHMtFjPGZN31vYhJlLhZSL73mjE6bbvuL60bkdGN5tiY1fHQhUaUBbwKBtDjwPjBndIEW
 i4+Ff0pYVdCeX8jVxnMWvzD23dRbfH7SK3/zb0hyP/kUjGLB9uOWKYMiyeNLVuFefYiE4M
 aTkFpUSLvOOcWAUKpR4M9YuyDAermnE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-VWCOnSfTNpGA2GvRK_IPBg-1; Wed, 10 Sep 2025 15:57:05 -0400
X-MC-Unique: VWCOnSfTNpGA2GvRK_IPBg-1
X-Mimecast-MFC-AGG-ID: VWCOnSfTNpGA2GvRK_IPBg_1757534225
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8080713fa17so1515810485a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 12:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757534224; x=1758139024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJfvX9CUxyXyMBgYTXCZWxleiRPqIAo4Pgyhuf2inlU=;
 b=G3lhteih6BNrxxQ//CsAqEiOW+crxuwT3I/E+bF0Hdpkzawi8DzCxBgxk8VLHXI/ap
 rkz0Ppu4VKZDinAsCMlQPB15qazkOqa0p+vGqSg2ThSwFQUcClHHkysCSIAms3AkQDvb
 yA87pOtBDHrcHr7l73cn0/Pk1sSV0/b9AfMheFJVk6vjLNUrS8jrWraLv2me14j337qT
 uwXUeB3ZPda5g+eBVtvnazRY0ISIgwobkdfFMZyQmFDXyZlQRXCXx1ybjWIcrcZcYon1
 RhsHzzoSQp4F6RzOB9MmcgiiAVbQEwUQZpqsS85AgzKZYfW+axXvMeoqbdt1LNSFPa93
 tQvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDyCriIQhK4qt4poVL2Wz4QU1scEvuEYJsZzP+N2dxb6xZKyBQNxWBRgYU01TsHro1QoNDWTMVLIPH@nongnu.org
X-Gm-Message-State: AOJu0YxdQSvDoYng4nbnAaDS8GdBDW376DxoHeWXFjht52DspY4EqsSm
 a7m/Mjf4On7RQWD/yJjv5By5LJ5dn0w7NJTo/HMRcgHYyLCrSX1Aa5he/UBALkOy5kjuxLporHq
 RwS6kfkZTXpOXwmEs4agBXbaCG6USUki1PnMfqRYDIwAmDP5Cu+99YoYX
X-Gm-Gg: ASbGncujnDtOoj7+edKDqNakBQTVqtHUvyWXY6pN2q1ef+4A5H+CW95/r4e9q4VXd2g
 k8rP6ctfD0SAqJR/ltaxGj8g8HF+og5N2Jwax84aIg571VyKGpO79bcbsFKE9mPg3rW6IVvdhNh
 2Jd/oAHkENX7n77jKl1U7kGsQLoUa0ifSb1FLxCr49WKJGAQYsskcNSNSCWKBsS2ar4qavivxOk
 nfhr2T0I/SW63IMxD0MBip0F7ezpBNcxWJxLKJ5fUJvu9bagm2K5JW084mdxV80pJnrRVYPaqW3
 t7ke4G9dXI6EH2XNVLDaOFx6EuYeuOAJt7Gg3nGukOvYfcKMfFNN9ps/nL+OdZnjXBTa5z3vFPM
 JFCd6bSiraFrcDabRz1v1TA==
X-Received: by 2002:a05:620a:28c4:b0:7e6:50f2:d62d with SMTP id
 af79cd13be357-813be24ae6bmr1695040085a.5.1757534224534; 
 Wed, 10 Sep 2025 12:57:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQLHmCuStN5W2OvF2WwVNes8tZlysXbljuPvsxEw5hrvOGcgIbfojbz+ekjfKAuWooxVUeJg==
X-Received: by 2002:a05:620a:28c4:b0:7e6:50f2:d62d with SMTP id
 af79cd13be357-813be24ae6bmr1695037185a.5.1757534223961; 
 Wed, 10 Sep 2025 12:57:03 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b61baaebd7sm29118851cf.22.2025.09.10.12.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 12:57:03 -0700 (PDT)
Date: Wed, 10 Sep 2025 15:56:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, farosas@suse.de, steven.sistare@oracle.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/2] io/channel: document how qio_channel_readv_full()
 handles fds
Message-ID: <aMHYCBFjrAaVXlG-@x1.local>
References: <20250910193112.1220763-1-vsementsov@yandex-team.ru>
 <20250910193112.1220763-3-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250910193112.1220763-3-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 10, 2025 at 10:31:12PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> The only realization, which may have incoming fds is
> qio_channel_socket_readv() (in io/channel-socket.c).
> qio_channel_socket_readv() do call (through
> qio_channel_socket_copy_fds()) qemu_socket_set_block() and
> qemu_set_cloexec() for each fd.
> 
> Also, qio_channel_socket_copy_fds() is called at the end of
> qio_channel_socket_readv(), on success path.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Maybe I'd just keep the io_readv() one, but drop the extra documents in
qio_channel_readv_full(), because that is almost a duplicate.

Meanwhile, we also have other higher level API that has the @fds
(qio_channel_readv_full_all_eof(), for example) that are not documented,
OTOH..

Totally no strong feelings.

Acked-by: Peter Xu <peterx@redhat.com>

> ---
>  include/io/channel.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 12266256a8..c7f64506f7 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -118,6 +118,15 @@ struct QIOChannelClass {
>                           size_t nfds,
>                           int flags,
>                           Error **errp);
> +
> +    /*
> +     * The io_readv handler must guarantee that all
> +     * incoming fds are set BLOCKING (unless
> +     * QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag is set) and
> +     * CLOEXEC (if available).
> +     * @fds and @nfds are set only on success path, and untouched
> +     * in case of errors.
> +     */
>      ssize_t (*io_readv)(QIOChannel *ioc,
>                          const struct iovec *iov,
>                          size_t niov,
> @@ -125,6 +134,7 @@ struct QIOChannelClass {
>                          size_t *nfds,
>                          int flags,
>                          Error **errp);
> +
>      int (*io_close)(QIOChannel *ioc,
>                      Error **errp);
>      GSource * (*io_create_watch)(QIOChannel *ioc,
> @@ -235,6 +245,13 @@ void qio_channel_set_name(QIOChannel *ioc,
>   * was allocated. It is the callers responsibility
>   * to call close() on each file descriptor and to
>   * call g_free() on the array pointer in @fds.
> + * @fds allocated and set (and @nfds is set too)
> + * _only_ on success path. These parameters are
> + * untouched in case of errors.
> + * qio_channel_readv_full() guarantees that all
> + * incoming fds are set BLOCKING (unless
> + * QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag
> + * is set) and CLOEXEC (if available).
>   *
>   * It is an error to pass a non-NULL @fds parameter
>   * unless qio_channel_has_feature() returns a true
> -- 
> 2.48.1
> 

-- 
Peter Xu


