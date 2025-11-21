Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E94CCFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcxx-0002qq-0F; Fri, 21 Nov 2025 21:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vMc5R-0003tD-Ty
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vMc3P-000366-Nf
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763773467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=alLB5iRtMxU59kwYbO/hqVpYEcq7up5cqqrAWXwjS5M=;
 b=FT1j3ZD5VBbUlejFhlEBfAH8NinFAFt7FSiInDkXBP9g3WnVwr6ubdwIm0Cw495u1GnAfy
 Xn992SyDPvL8Q9MmDHzBW60+DIJk4grusPnqo3XCmS9MYrsSrLiJKLpVOy8npzEObHkQyK
 KzWim8DDsQSVed0mBYiOjulyG7bNclM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-PssE0mPIOxautILZhG_mPA-1; Fri, 21 Nov 2025 07:46:37 -0500
X-MC-Unique: PssE0mPIOxautILZhG_mPA-1
X-Mimecast-MFC-AGG-ID: PssE0mPIOxautILZhG_mPA_1763729196
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4776b0ada3dso22133255e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 04:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763729195; x=1764333995; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=alLB5iRtMxU59kwYbO/hqVpYEcq7up5cqqrAWXwjS5M=;
 b=UeNpBS4AAJnIj1Rx8hPlQhVdpJevyYxBA0N1WsnujFGcG24BxzABnpzbshPVb4z4tW
 OK7lPRX2dJb4DtMggH394+UxcM9megkOOirUt/WA13sknDh34LUHDgcfHIz49YyPXive
 RoR3UQUUfonLg09z8p8DSseu20x86LadTB+ZcGXAeY4mGm6VKzXy/3NGDOc99CVUpveY
 C6owXeMMim1Ky1IJDox5TxQuhGaaJxQjbprFMW5+gLY4qheHiGPuA4DqUXk5wJtBnLOG
 1BNJ4kYIcF+DDZAR9ro6laOWoQxXx6sBkwJEvPjuZVqVDYbL5EOroblYbkCdgBu4yBKS
 jI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763729195; x=1764333995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=alLB5iRtMxU59kwYbO/hqVpYEcq7up5cqqrAWXwjS5M=;
 b=w+bkS2BuXYcs4wo6Fa8OmpF2UWIPDCZh7pRSHqEDCXwyzoFLzbaPDR3RaXT6TuAjqK
 G95gzbGmsHkkPc6MT5vK3ZyoMU1wkC3ap0RzO+4CaoBa+zMoSRVzvUVhjMU9q1rlihfX
 9veoHwsFA67exC8OsZQ0wcenSbrGIfHHDcInALdZqon0BEVeI+dDDX1cxmV4YXB0CcJw
 4fAQ2CfwLPQBnX7xGIpSoNDI7CBhWRzWIfhifxrOSd3/INfE07sKH3bI+8LTpvK1f7d6
 p+qZRp8qXzg3/t9pMi39mXz8k+dUYUD0csX3qdG4+bf4QVD7dn5CI66nU6ERVfTvJ1Va
 4FNw==
X-Gm-Message-State: AOJu0Yzwphbl+b32eY9fSAEcdyJpIzkU0WPMLuFCSoJF2ZCBztFaFDbF
 hjyMvQgt95CT0o+j5KwId8FsjrTwoTo6sDtK/g7su1s1CO6gC9pM+HXP7kfOPkQWWWOWQixIa/t
 pVZmzWbjrqgThhOBIJVR8t0PATyP07JpYpxXL5O621ErG87X53WWSoi2hPxvDFGNGfz0=
X-Gm-Gg: ASbGncs3ViCOqkDBSxqPbWMemA6D6x8cMVAA3C2Anmd6ljMBhzmla3VYbMzXwEoVXoR
 Qqbz47aLOQ/XrCi/ebA8OKWbaeBiFQrA7DVD9mZ9y6oAuVF2cq0b9ZzrVEOqSc5O6KfGDjQ9G5T
 MoSj+ISBQ4hDZjFDNdCgeBJ/kFTaGzYbdLiTM1kzIEm7vHPuQRQDCwfz6abXpfNclgL9T7nK33h
 0EPn6Y2csOLL8pvxBlf/GFEDUl9NO++uFCEEuNeC9j63+Urq7v/4WQSt2X1LJsuuDMO+5s+20E7
 bw5ytHQIwVYGh1NGHOgl31sqgxvEiEMORnj6PvMY4Ye3aOETENg45foin9SDaOx7kGyDC3NhoSE
 =
X-Received: by 2002:a05:600c:4746:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-477c04cfa31mr23241125e9.5.1763729195507; 
 Fri, 21 Nov 2025 04:46:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHunRWJWkBMAc5joO3iiF9Tb3/dbNuJPxkGyHkni+j9F1nymyp/P1c+SI9jxfBdkshnhK/CYA==
X-Received: by 2002:a05:600c:4746:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-477c04cfa31mr23240905e9.5.1763729195084; 
 Fri, 21 Nov 2025 04:46:35 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477c0d85360sm32103495e9.15.2025.11.21.04.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 04:46:33 -0800 (PST)
Date: Fri, 21 Nov 2025 13:46:31 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/4] tests/migration-test: Merge shmem_opts into
 memory_backend
Message-ID: <bptgyz34rzqk5dkcd7kzp4aksdsqu4qm5vjlvvoacvypqqovqx@vzotefvcdkkq>
References: <20251117223908.415965-1-peterx@redhat.com>
 <20251117223908.415965-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117223908.415965-3-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

Hi Peter,

you can add my R-b to the whole series, I just have a small nitpick
below, but feel free to ignore it.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>

On 2025-11-17 17:39, Peter Xu wrote:
> The two parameters are more or less duplicated in migrate_args().  They all
> describe the memory type.  When one is used, the other is not.
> 
> mem_type currently uses numa parameter to specify the memory backend, while
> memory_backend (the two users of such uses "-machine memory-backend=ID").
> 
> This patch merges the use of the two variables so that we always generate a
> memory object string and put it into "memory_backend" variable.  Now we can
> drop shmem_opts parameter in the function.
> 
> Meanwhile we always use a memory-backend-* no matter which mem type is
> used.  This brings mem_type to be aligned with memory_backend usage, then
> we stick with this as this is flexible enough.
> 
> This paves way that we merge mem_type and memory_backend in MigrateStart.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/framework.c | 41 ++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 8fa39999a1..6df0e56c2a 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -260,23 +260,36 @@ static char *test_shmem_path(void)
>      return g_strdup_printf("/dev/shm/qemu-%d", getpid());
>  }
>  
> +#define  MIG_MEM_ID  "mig.mem"
> +
>  /* NOTE: caller is responsbile to free the string if returned */
>  static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
>  {
>      g_autofree char *shmem_path = NULL;
> -    char *backend = NULL;
> +    g_autofree char *backend = NULL;
> +    bool share = true;
> +    char *opts;
>  
>      switch (type) {
>      case MEM_TYPE_SHMEM:
>          shmem_path = test_shmem_path();
> -        backend = g_strdup_printf(
> -            "-object memory-backend-file,id=mem0,size=%s"
> -            ",mem-path=%s,share=on -numa node,memdev=mem0",
> -            memory_size, shmem_path);
> -        return backend;
> +        backend = g_strdup_printf("-object memory-backend-file,mem-path=%s",
> +                                  shmem_path);
> +        break;
> +    case MEM_TYPE_ANON:
> +        backend = g_strdup("-object memory-backend-ram");
> +        share = false;
> +        break;

Wouldn't it be a bit nicer to add this case before SHMEM, so the order
is the same as in the enum? The patch adding MEMFD follows is by adding
it right after SHMEM (and before ANON).

>      default:
> -        return NULL;
> +        g_assert_not_reached();
> +        break;
>      }
> +
> +    opts = g_strdup_printf("%s,id=%s,size=%s,share=%s",
> +                           backend, MIG_MEM_ID, memory_size,
> +                           share ? "on" : "off");
> +
> +    return opts;
>  }
>  
>  int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
> @@ -286,7 +299,7 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>      gchar *cmd_source = NULL;
>      gchar *cmd_target = NULL;
>      const gchar *ignore_stderr;
> -    g_autofree char *shmem_opts = NULL;
> +    g_autofree char *mem_object = NULL;
>      const char *kvm_opts = NULL;
>      const char *arch = qtest_get_arch();
>      const char *memory_size;
> @@ -350,12 +363,12 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>          ignore_stderr = "";
>      }
>  
> -    shmem_opts = migrate_mem_type_get_opts(args->mem_type, memory_size);
> -
>      if (args->memory_backend) {
>          memory_backend = g_strdup_printf(args->memory_backend, memory_size);
>      } else {
> -        memory_backend = g_strdup_printf("-m %s ", memory_size);
> +        mem_object = migrate_mem_type_get_opts(args->mem_type, memory_size);
> +        memory_backend = g_strdup_printf("-machine memory-backend=%s %s",
> +                                         MIG_MEM_ID, mem_object);
>      }
>  
>      if (args->use_dirty_ring) {
> @@ -378,12 +391,11 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>                                   "-name source,debug-threads=on "
>                                   "%s "
>                                   "-serial file:%s/src_serial "
> -                                 "%s %s %s %s",
> +                                 "%s %s %s",
>                                   kvm_opts ? kvm_opts : "",
>                                   machine, machine_opts,
>                                   memory_backend, tmpfs,
>                                   arch_opts ? arch_opts : "",
> -                                 shmem_opts ? shmem_opts : "",
>                                   args->opts_source ? args->opts_source : "",
>                                   ignore_stderr);
>  
> @@ -400,13 +412,12 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>                                   "%s "
>                                   "-serial file:%s/dest_serial "
>                                   "-incoming %s "
> -                                 "%s %s %s %s %s",
> +                                 "%s %s %s %s",
>                                   kvm_opts ? kvm_opts : "",
>                                   machine, machine_opts,
>                                   memory_backend, tmpfs, uri,
>                                   events,
>                                   arch_opts ? arch_opts : "",
> -                                 shmem_opts ? shmem_opts : "",
>                                   args->opts_target ? args->opts_target : "",
>                                   ignore_stderr);
>  
> -- 
> 2.50.1
> 


