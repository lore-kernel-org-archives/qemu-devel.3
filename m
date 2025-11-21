Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B71FCF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcu7-0008DC-8y; Fri, 21 Nov 2025 20:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbt7-0005Ff-Cm
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:54:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbsv-000146-Sy
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763772816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OBgeAQUZvehA/BVpzsvoAFXFSA2fVvR6joWQg75j/bo=;
 b=UO/twTrOUnnHjo+8vXr1eWK8Y9W8M2Sq/IaFM/6N3izJsdma3lTCGNhYCgIdHidOVoLb7b
 WhnBX1S53dPlg/vIxoDjovmFwtAsdTL21K1jjQHnSgX156DHYwdwEwF5QayA8sNdrG+AFl
 XtOzeSDuvgigF3KHPg67k2HBh947Ao4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-U6DkqmI9Owm56pXXqyyNAg-1; Fri, 21 Nov 2025 10:32:48 -0500
X-MC-Unique: U6DkqmI9Owm56pXXqyyNAg-1
X-Mimecast-MFC-AGG-ID: U6DkqmI9Owm56pXXqyyNAg_1763739167
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8824b00ee8bso31957586d6.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 07:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763739167; x=1764343967; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OBgeAQUZvehA/BVpzsvoAFXFSA2fVvR6joWQg75j/bo=;
 b=Vr5PVERUAagcASqDxIWzvUJzFVlNrGvPoZUooZTJIkwBViX9kNIdFOKCpwu+ePNPxL
 dRtx0pKvgKjVSAWZJ+E3GgZTzZkZAPhvmon5UP0I7yJnESDl+XszALagKgt5jRi1zejT
 gtsQ4zUN9DKgzcoCaVMXrh0UUVMQX2E3K3Xi1yRuCgYkHUq5qsxtCIx9CcyoS0cqOY8N
 ct2HrTEpZxahpREEpNnqucmUsbzhqo7RKw0kSTnYMkLp759l5TzL+5r+t5LJEttSpQGz
 iL4iDcxWDyuzV5zP8NgoSVhtTOBWVdORM/kOsPWDLUqcERjSyXcxDzydosO33UVEIhl2
 fQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763739167; x=1764343967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBgeAQUZvehA/BVpzsvoAFXFSA2fVvR6joWQg75j/bo=;
 b=aJDd8mkvq5qLucLjTLz97j3ROWWLDXkYCk7GneV1SWGnExTNBTq79zEqOLU3MO/ozq
 B2VqHQVidNSXzlZSp8mkcAHQDXrh+nFGtshBEx0jcUVWVcfjBEqEfdy6VehPw111ZXAl
 dQDl4Dr94gTvFIVWHzqjOAW5nT8d0eJACyEESq6JkMtyW9ScwQPn0FtxfavR+VsOS+4J
 gK6CY9+DdiUM0FBRu6FKX3JOeJLi4Qk9o0pzwUjxcYFRXt9CRsBVSgoREJdEBek0LIkM
 2kjAMeXxwGVJvAalcqsiCROM9gUi6qiQf16uaeW859I4AttaJ1pJqEVefT1JwFzSLa3e
 lSTg==
X-Gm-Message-State: AOJu0YyUaBUNILDHsGtlZv2RqsbMZpWyE9XAvYOfYY7RhAr+5r27rUMJ
 8rRSgunIGDUXdZcibY3I2jroNdN4RHGu85lQwL7Q8/mwxdpJ6asGcbqMitGyBOhC5DV5I2QRC8B
 FtJDxCVjad0bSf5nAevnjo+gVro7Hanu4hDXQm75Y77w4fygsYFDSUhwq
X-Gm-Gg: ASbGncvOLOOvp/M+03m90yMlo4B4hBQ4hm90oTAUpOF3nnWyUkk7p7BwuZU6MeYthpw
 M84LBkXUj9tlk8hW+SbEKXrpl4wXxIQxPLfumFXTVkaAG8tugAohsLoedIEQkQtDIYqN2PRgaXe
 /W6wBiDVkJcgxFy3TQkkHWYFf9RrBwST+9fCIH6Cc3zDlVPeCdTwd+n4p4F0CiUDVNkMaduqcae
 9OlJqeBWQS7KA87tbo3PjfM8om2UaspZF0aSEItzd7FLyPi/TFyMZHJw4em1fcNQu20xc6kaB6F
 2fz1QaeBRLR8s1bkwRdViEnijs+JQGNXfZLmfghDyWQJdnHCYjdN1fgsiGSq0KEGUBb/9dVSVaX
 jeyU=
X-Received: by 2002:a05:622a:453:b0:4ec:f26f:5aea with SMTP id
 d75a77b69052e-4ee58935c5cmr38013621cf.68.1763739166825; 
 Fri, 21 Nov 2025 07:32:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBFab+9o/I+hssaJuzCxeDD2z6bawNzhm9+LPOWojJLvIZuuQboR1bS4+pJGCiCyl7ALoFlw==
X-Received: by 2002:a05:622a:453:b0:4ec:f26f:5aea with SMTP id
 d75a77b69052e-4ee58935c5cmr38012601cf.68.1763739166023; 
 Fri, 21 Nov 2025 07:32:46 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e909b6sm39322981cf.32.2025.11.21.07.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 07:32:45 -0800 (PST)
Date: Fri, 21 Nov 2025 10:32:44 -0500
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/4] tests/migration-test: Merge shmem_opts into
 memory_backend
Message-ID: <aSCGHJ8r8iSOSTZK@x1.local>
References: <20251117223908.415965-1-peterx@redhat.com>
 <20251117223908.415965-3-peterx@redhat.com>
 <bptgyz34rzqk5dkcd7kzp4aksdsqu4qm5vjlvvoacvypqqovqx@vzotefvcdkkq>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bptgyz34rzqk5dkcd7kzp4aksdsqu4qm5vjlvvoacvypqqovqx@vzotefvcdkkq>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Nov 21, 2025 at 01:46:31PM +0100, Juraj Marcin wrote:
> Hi Peter,
> 
> you can add my R-b to the whole series, I just have a small nitpick
> below, but feel free to ignore it.
> 
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>

Thanks a lot for the quick look. :)

> 
> On 2025-11-17 17:39, Peter Xu wrote:
> > The two parameters are more or less duplicated in migrate_args().  They all
> > describe the memory type.  When one is used, the other is not.
> > 
> > mem_type currently uses numa parameter to specify the memory backend, while
> > memory_backend (the two users of such uses "-machine memory-backend=ID").
> > 
> > This patch merges the use of the two variables so that we always generate a
> > memory object string and put it into "memory_backend" variable.  Now we can
> > drop shmem_opts parameter in the function.
> > 
> > Meanwhile we always use a memory-backend-* no matter which mem type is
> > used.  This brings mem_type to be aligned with memory_backend usage, then
> > we stick with this as this is flexible enough.
> > 
> > This paves way that we merge mem_type and memory_backend in MigrateStart.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qtest/migration/framework.c | 41 ++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> > index 8fa39999a1..6df0e56c2a 100644
> > --- a/tests/qtest/migration/framework.c
> > +++ b/tests/qtest/migration/framework.c
> > @@ -260,23 +260,36 @@ static char *test_shmem_path(void)
> >      return g_strdup_printf("/dev/shm/qemu-%d", getpid());
> >  }
> >  
> > +#define  MIG_MEM_ID  "mig.mem"
> > +
> >  /* NOTE: caller is responsbile to free the string if returned */
> >  static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
> >  {
> >      g_autofree char *shmem_path = NULL;
> > -    char *backend = NULL;
> > +    g_autofree char *backend = NULL;
> > +    bool share = true;
> > +    char *opts;
> >  
> >      switch (type) {
> >      case MEM_TYPE_SHMEM:
> >          shmem_path = test_shmem_path();
> > -        backend = g_strdup_printf(
> > -            "-object memory-backend-file,id=mem0,size=%s"
> > -            ",mem-path=%s,share=on -numa node,memdev=mem0",
> > -            memory_size, shmem_path);
> > -        return backend;
> > +        backend = g_strdup_printf("-object memory-backend-file,mem-path=%s",
> > +                                  shmem_path);
> > +        break;
> > +    case MEM_TYPE_ANON:
> > +        backend = g_strdup("-object memory-backend-ram");
> > +        share = false;
> > +        break;
> 
> Wouldn't it be a bit nicer to add this case before SHMEM, so the order
> is the same as in the enum? The patch adding MEMFD follows is by adding
> it right after SHMEM (and before ANON).

Normally we don't need to order cases in a switch() (especially think about
when fallthrough cases could happen..), but sure I am happy to move it if
that at least makes it easier to read for you.

I'll wait for other comments to see if I'll just move it when merge or
repost.

Thanks,

> 
> >      default:
> > -        return NULL;
> > +        g_assert_not_reached();
> > +        break;
> >      }
> > +
> > +    opts = g_strdup_printf("%s,id=%s,size=%s,share=%s",
> > +                           backend, MIG_MEM_ID, memory_size,
> > +                           share ? "on" : "off");
> > +
> > +    return opts;
> >  }
> >  
> >  int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
> > @@ -286,7 +299,7 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
> >      gchar *cmd_source = NULL;
> >      gchar *cmd_target = NULL;
> >      const gchar *ignore_stderr;
> > -    g_autofree char *shmem_opts = NULL;
> > +    g_autofree char *mem_object = NULL;
> >      const char *kvm_opts = NULL;
> >      const char *arch = qtest_get_arch();
> >      const char *memory_size;
> > @@ -350,12 +363,12 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
> >          ignore_stderr = "";
> >      }
> >  
> > -    shmem_opts = migrate_mem_type_get_opts(args->mem_type, memory_size);
> > -
> >      if (args->memory_backend) {
> >          memory_backend = g_strdup_printf(args->memory_backend, memory_size);
> >      } else {
> > -        memory_backend = g_strdup_printf("-m %s ", memory_size);
> > +        mem_object = migrate_mem_type_get_opts(args->mem_type, memory_size);
> > +        memory_backend = g_strdup_printf("-machine memory-backend=%s %s",
> > +                                         MIG_MEM_ID, mem_object);
> >      }
> >  
> >      if (args->use_dirty_ring) {
> > @@ -378,12 +391,11 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
> >                                   "-name source,debug-threads=on "
> >                                   "%s "
> >                                   "-serial file:%s/src_serial "
> > -                                 "%s %s %s %s",
> > +                                 "%s %s %s",
> >                                   kvm_opts ? kvm_opts : "",
> >                                   machine, machine_opts,
> >                                   memory_backend, tmpfs,
> >                                   arch_opts ? arch_opts : "",
> > -                                 shmem_opts ? shmem_opts : "",
> >                                   args->opts_source ? args->opts_source : "",
> >                                   ignore_stderr);
> >  
> > @@ -400,13 +412,12 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
> >                                   "%s "
> >                                   "-serial file:%s/dest_serial "
> >                                   "-incoming %s "
> > -                                 "%s %s %s %s %s",
> > +                                 "%s %s %s %s",
> >                                   kvm_opts ? kvm_opts : "",
> >                                   machine, machine_opts,
> >                                   memory_backend, tmpfs, uri,
> >                                   events,
> >                                   arch_opts ? arch_opts : "",
> > -                                 shmem_opts ? shmem_opts : "",
> >                                   args->opts_target ? args->opts_target : "",
> >                                   ignore_stderr);
> >  
> > -- 
> > 2.50.1
> > 
> 

-- 
Peter Xu


