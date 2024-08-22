Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07ECC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shAbV-0007r8-Cr; Thu, 22 Aug 2024 12:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shAb5-0006fj-Tt
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shAb2-0007W9-2B
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724343810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=En6cDJcQXq6a6TBoYjcaNO4etnd4XW7tDBZMwmzLBUI=;
 b=E/VJHzSNl2LKkNCx76iTNmGlCZKWVyrqfcdCHJU/rNmnT9qw/ng9B15BjdF0woLDoZX8yX
 rfkqbhV9o3H5abXAu/0utqygzU0O49eKdWuDoyDzWLrAmRSsGstV17S/Hw7BTf9yl7feFk
 Mm8JeuhPnipeVdFXD52CtsdXI2Expo0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-SptprSiIOxe8rrUV5s4PZA-1; Thu, 22 Aug 2024 12:23:28 -0400
X-MC-Unique: SptprSiIOxe8rrUV5s4PZA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a66b52c944so107430585a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724343807; x=1724948607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=En6cDJcQXq6a6TBoYjcaNO4etnd4XW7tDBZMwmzLBUI=;
 b=OkIHnT+B27mH/JQgm+3MyeqEZtLrYYCH+713EUoZ5s4cplrR0sJf6qfkcepmrJdpc6
 NSs3UmoctPzOYgaoFhg8YIal2hIddVNYZAcHRx9BSMglh8G7XuwD58x1e0Mm+UV44oAW
 9BlfNLJalcVQKCJkATw8WSJP0v5We5lx5IrKrHPoTVVq2w7sjzGXovIoHQhxkKp2AHAi
 72soyUMST0JeXVuiRpvBRp+JqMHShbYghi7rzZk2V1aW6ssExIZPLBQxtMIZQx14JUMn
 SxG+ufI8KLM3p4sXLM06SkJ2z14coehIRhzh/Jbe8SqJcsvggWq7EyPZ3zT5h0/CJZcl
 4VCw==
X-Gm-Message-State: AOJu0YzSMOvbzbT1mLO6aP8jOWGdWlDbHr/NzB4ISSPh+MuANFLaQE+J
 Iy28/otbQtv43UXfGMlwOGxzm9x3CDb3Z3dzM8W0DWmfsQ5XYkyWsFBru0Wtk43OHMCbv1LzZNm
 iOx74HeZbdE9bNcpOglIkrm8unBXhdsGilW/ujeqsA6wxcIWgT8vO
X-Received: by 2002:a05:620a:4507:b0:7a6:6b98:8e2d with SMTP id
 af79cd13be357-7a6740ebdbdmr734674085a.67.1724343807411; 
 Thu, 22 Aug 2024 09:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBtCBe1j1TvAj7jMuN3/0cFVPxzWqksJb/HKEIy1U2bklQG0ika2e6hm2s5xjpi+Ss6AsXBQ==
X-Received: by 2002:a05:620a:4507:b0:7a6:6b98:8e2d with SMTP id
 af79cd13be357-7a6740ebdbdmr734669985a.67.1724343806817; 
 Thu, 22 Aug 2024 09:23:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f35cda8sm84835385a.58.2024.08.22.09.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 09:23:26 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:23:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 13/14] migration/multifd: Register nocomp ops
 dynamically
Message-ID: <Zsdl_ADh-VTKV-wT@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801123516.4498-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 01, 2024 at 09:35:15AM -0300, Fabiano Rosas wrote:
> Prior to moving the ram code into multifd-ram.c, change the code to
> register the nocomp ops dynamically so we don't need to have the ops
> structure defined in multifd.c.
> 
> While here, rename s/nocomp/ram/ and remove the docstrings which are
> mostly useless (if anything, it's the function pointers in multifd.h
> that should be documented like that).
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 101 ++++++++++++--------------------------------
>  1 file changed, 28 insertions(+), 73 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index c25ab4924c..d5be784b6f 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -167,15 +167,7 @@ static void multifd_set_file_bitmap(MultiFDSendParams *p)
>      }
>  }
>  
> -/* Multifd without compression */
> -
> -/**
> - * nocomp_send_setup: setup send side
> - *
> - * @p: Params for the channel that we are using
> - * @errp: pointer to an error
> - */
> -static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
> +static int ram_send_setup(MultiFDSendParams *p, Error **errp)

"ram" as a prefix sounds inaccurate to me.  Personally I even preferred the
old name "nocomp" because it says there's no compression.

Here "ram_send_setup" is at the same level against e.g. "zlib_send_setup".
It sounds like zlib isn't for ram, but it is..

Do you perhaps dislike the "nocomp" term?  How about:

  multifd_plain_send_setup()

Just to do s/nocomp/plain/?  Or "raw"?

We do have two flavours here at least:

*** migration/multifd-qpl.c:
<global>[755]                  .send_setup = multifd_qpl_send_setup,

*** migration/multifd-ram.c:
<global>[387]                  .send_setup = ram_send_setup,

*** migration/multifd-uadk.c:
<global>[364]                  .send_setup = multifd_uadk_send_setup,

*** migration/multifd-zlib.c:
<global>[338]                  .send_setup = zlib_send_setup,

*** migration/multifd-zstd.c:
<global>[326]                  .send_setup = zstd_send_setup,

It might makes sense to all prefix them with "multifd_", just to follow
gpl/uadk?

>  {
>      uint32_t page_count = multifd_ram_page_count();
>  
> @@ -193,15 +185,7 @@ static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
>      return 0;
>  }
>  
> -/**
> - * nocomp_send_cleanup: cleanup send side
> - *
> - * For no compression this function does nothing.
> - *
> - * @p: Params for the channel that we are using
> - * @errp: pointer to an error
> - */
> -static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
> +static void ram_send_cleanup(MultiFDSendParams *p, Error **errp)
>  {
>      g_free(p->iov);
>      p->iov = NULL;
> @@ -222,18 +206,7 @@ static void multifd_send_prepare_iovs(MultiFDSendParams *p)
>      p->next_packet_size = pages->normal_num * page_size;
>  }
>  
> -/**
> - * nocomp_send_prepare: prepare date to be able to send
> - *
> - * For no compression we just have to calculate the size of the
> - * packet.
> - *
> - * Returns 0 for success or -1 for error
> - *
> - * @p: Params for the channel that we are using
> - * @errp: pointer to an error
> - */
> -static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
> +static int ram_send_prepare(MultiFDSendParams *p, Error **errp)
>  {
>      bool use_zero_copy_send = migrate_zero_copy_send();
>      int ret;
> @@ -272,46 +245,19 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
>      return 0;
>  }
>  
> -/**
> - * nocomp_recv_setup: setup receive side
> - *
> - * For no compression this function does nothing.
> - *
> - * Returns 0 for success or -1 for error
> - *
> - * @p: Params for the channel that we are using
> - * @errp: pointer to an error
> - */
> -static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
> +static int ram_recv_setup(MultiFDRecvParams *p, Error **errp)
>  {
>      p->iov = g_new0(struct iovec, multifd_ram_page_count());
>      return 0;
>  }
>  
> -/**
> - * nocomp_recv_cleanup: setup receive side
> - *
> - * For no compression this function does nothing.
> - *
> - * @p: Params for the channel that we are using
> - */
> -static void nocomp_recv_cleanup(MultiFDRecvParams *p)
> +static void ram_recv_cleanup(MultiFDRecvParams *p)
>  {
>      g_free(p->iov);
>      p->iov = NULL;
>  }
>  
> -/**
> - * nocomp_recv: read the data from the channel
> - *
> - * For no compression we just need to read things into the correct place.
> - *
> - * Returns 0 for success or -1 for error
> - *
> - * @p: Params for the channel that we are using
> - * @errp: pointer to an error
> - */
> -static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
> +static int ram_recv(MultiFDRecvParams *p, Error **errp)
>  {
>      uint32_t flags;
>  
> @@ -341,22 +287,15 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
>      return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
>  }
>  
> -static MultiFDMethods multifd_nocomp_ops = {
> -    .send_setup = nocomp_send_setup,
> -    .send_cleanup = nocomp_send_cleanup,
> -    .send_prepare = nocomp_send_prepare,
> -    .recv_setup = nocomp_recv_setup,
> -    .recv_cleanup = nocomp_recv_cleanup,
> -    .recv = nocomp_recv
> -};
> -
> -static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
> -    [MULTIFD_COMPRESSION_NONE] = &multifd_nocomp_ops,
> -};
> +static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {};
>  
>  void multifd_register_ops(int method, MultiFDMethods *ops)
>  {
> -    assert(0 < method && method < MULTIFD_COMPRESSION__MAX);
> +    if (method == MULTIFD_COMPRESSION_NONE) {
> +        assert(!multifd_ops[method]);
> +    } else {
> +        assert(0 < method && method < MULTIFD_COMPRESSION__MAX);
> +    }
>      multifd_ops[method] = ops;
>  }

The new assertion is a bit paranoid to me.. while checking duplicated
assignment should at least apply to all if to add.  So.. how about:

  assert(method < MULTIFD_COMPRESSION__MAX);
  assert(!multifd_ops[method]);
  multifd_ops[method] = ops;

?

>  
> @@ -1755,3 +1694,19 @@ bool multifd_send_prepare_common(MultiFDSendParams *p)
>  
>      return true;
>  }
> +
> +static MultiFDMethods multifd_ram_ops = {
> +    .send_setup = ram_send_setup,
> +    .send_cleanup = ram_send_cleanup,
> +    .send_prepare = ram_send_prepare,
> +    .recv_setup = ram_recv_setup,
> +    .recv_cleanup = ram_recv_cleanup,
> +    .recv = ram_recv
> +};
> +
> +static void multifd_ram_register(void)
> +{
> +    multifd_register_ops(MULTIFD_COMPRESSION_NONE, &multifd_ram_ops);
> +}
> +
> +migration_init(multifd_ram_register);
> -- 
> 2.35.3
> 

-- 
Peter Xu


