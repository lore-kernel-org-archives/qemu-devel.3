Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C73AE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZrR-0001K8-1G; Fri, 06 Dec 2024 10:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJZrP-0001Jv-W3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:03:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJZrN-0001r4-I7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733497392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QAwHTN3P9CIzl7XAr4qtCVwciAPeZ7rNKGrw2wqk/8k=;
 b=bE7Q/zAVaVFYee2yA5HS+D4njP/qWWHbe+0J6C6HyO2xYKVZnZVkyBgqW9wvUBEn4On9cH
 24u+fndH8Xd/8IhHSYj2Erf/0UgMfPoiFiY+DwCNoBdLxa8gEsdwg4+t/bmPaUA5/snai0
 zW6Tvddbi7GR5pnwOn85YFMQkEPdwNk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-TEmWr_QDOKStQaU_suESvQ-1; Fri, 06 Dec 2024 10:03:10 -0500
X-MC-Unique: TEmWr_QDOKStQaU_suESvQ-1
X-Mimecast-MFC-AGG-ID: TEmWr_QDOKStQaU_suESvQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d889fd0fd6so41031226d6.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733497390; x=1734102190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAwHTN3P9CIzl7XAr4qtCVwciAPeZ7rNKGrw2wqk/8k=;
 b=dpIOda+yrFcCCdvOzBn0OPTrKLvf+VxBd4cZ5JeiidGZu4aGaH8YXGnre/gRA2FvqQ
 keF4YJB0UFfDM8njFMBz2JprXhVVkfdYi8ky43PjlREDCqTs/V9Ui10MUNh6CP7/XbQ2
 N1hWyfa7rNqtPBGsOLQR0KKhuECxqco8d4Tff97iINRIWWl9VIz+ckyUtx0tzXA7rkb9
 B594cJi8yLh735tURUkgXWVNLeUxl0PleW/wMS+swoQQKoheFXFR2h6TzSF2GL9LbMQo
 eDVzJg6EaOnN2ASuEMEIJi3pXz74DGEhKSls2sqHmX130MzFOMeCy+LMPvkyb/4C7hhk
 L6jA==
X-Gm-Message-State: AOJu0Yzd+ykFwi5c/ayTE9NZ31EqR1eLXez0IYa64y/xb48o+/Hd6ihe
 xVGKmStZxzMzchiNRy2wBVnJ4eZGbt/GsnOpJPNiPM6qvgxY0c2tQUyePHa9MbLH0MClC/d6ek3
 ScOTLPEPfAcRWLX7y6jo98tjpqR9xSIxxVEj1RlcCimbYIEkFwJqo
X-Gm-Gg: ASbGncvX6hb3vv5C8MQ9Lihf8WRfx//ooccW+ae9ielKbftR7OwQeua5LHa1fzDEgeY
 b/0G+tDsnisnoo7SjHPoTP9AU0OP8jW4hskSkX/Ayb7qnM4vT3KV6BHQPl+jAq4O8n6+KCJJHNi
 cHWvkKsRUfA0MpdctvYoSTjrXBL3VWZhS+BUsme1B5CCH/CLJrTiMfdhPPg0Mean7bCU9uQYui5
 MMli5O9S5wnAqSI9G0sLde7aSI/QGgExZOJ9p3CwIsreW0ZfcUcSRQDU+xtGU+Fqj0cULu+JFyQ
 SrJULzRe5v4=
X-Received: by 2002:a05:6214:55c4:b0:6d8:f50e:8036 with SMTP id
 6a1803df08f44-6d8f50e8397mr8038296d6.20.1733497388992; 
 Fri, 06 Dec 2024 07:03:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPz+IvPs4vVpdRkzj2UfY+/nCZbNOmymPvZpcMeay762gc2ne7TnidjirU1XSZTnUTpl+HYA==
X-Received: by 2002:a05:6214:55c4:b0:6d8:f50e:8036 with SMTP id
 6a1803df08f44-6d8f50e8397mr8037586d6.20.1733497388540; 
 Fri, 06 Dec 2024 07:03:08 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da6b651asm19738816d6.69.2024.12.06.07.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 07:03:08 -0800 (PST)
Date: Fri, 6 Dec 2024 10:03:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 3/7] migration/ram: Move RAM_SAVE_FLAG* into ram.h
Message-ID: <Z1MSKpiMiPsidzJO@x1n>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-4-peterx@redhat.com>
 <874j3hc4fw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874j3hc4fw.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Dec 06, 2024 at 10:43:31AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Firstly, we're going to use the multifd flag soon in multifd code, so ram.c
> > isn't gonna work.
> >
> > Secondly, we have a separate RDMA flag dangling around, which is definitely
> > not obvious.  There's one comment that helps, but not too much.
> >
> > We should just put it altogether, so nothing will get overlooked.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> just some comments about preexisting stuff:
> 
> > ---
> >  migration/ram.h  | 25 +++++++++++++++++++++++++
> >  migration/rdma.h |  7 -------
> >  migration/ram.c  | 21 ---------------------
> >  3 files changed, 25 insertions(+), 28 deletions(-)
> >
> > diff --git a/migration/ram.h b/migration/ram.h
> > index 0d1981f888..cfdcccd266 100644
> > --- a/migration/ram.h
> > +++ b/migration/ram.h
> > @@ -33,6 +33,31 @@
> >  #include "exec/cpu-common.h"
> >  #include "io/channel.h"
> >  
> > +/*
> > + * RAM_SAVE_FLAG_ZERO used to be named RAM_SAVE_FLAG_COMPRESS, it
> > + * worked for pages that were filled with the same char.  We switched
> > + * it to only search for the zero value.  And to avoid confusion with
> > + * RAM_SAVE_FLAG_COMPRESS_PAGE just rename it.
> > + *
> > + * RAM_SAVE_FLAG_FULL was obsoleted in 2009.
> > + *
> > + * RAM_SAVE_FLAG_COMPRESS_PAGE (0x100) was removed in QEMU 9.1.
> 
> Aren't these already covered by git log? The comment makes it seem like
> some special situation, but I think we're just documenting history here,
> no?

I guess so.

Maybe still useful when we hit a bug that some ancient QEMU manually
migrates to a new one and hit a weird 0x100 message.

> 
> > + */
> > +#define RAM_SAVE_FLAG_FULL     0x01
> > +#define RAM_SAVE_FLAG_ZERO     0x02
> > +#define RAM_SAVE_FLAG_MEM_SIZE 0x04
> > +#define RAM_SAVE_FLAG_PAGE     0x08
> > +#define RAM_SAVE_FLAG_EOS      0x10
> > +#define RAM_SAVE_FLAG_CONTINUE 0x20
> > +#define RAM_SAVE_FLAG_XBZRLE   0x40
> > +/*
> > + * ONLY USED IN RDMA: Whenever this is found in the data stream, the flags
> > + * will be passed to rdma functions in the incoming-migration side.
> > + */
> > +#define RAM_SAVE_FLAG_HOOK     0x80
> 
> No 0x100?

You just asked about it one min ago! ^^^^

> 
> > +#define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
> > +/* We can't use any flag that is bigger than 0x200 */
> 
> Where does that limitation come from again? I know that
> RAM_SAVE_FLAG_MEM_SIZE shares a u64 with something else:
> 
>   qemu_put_be64(f, ram_bytes_total_with_ignored() |
>   RAM_SAVE_FLAG_MEM_SIZE);
> 
> For RAM_SAVE_FLAG_ZERO and RAM_SAVE_FLAG_PAGE, it might be a u32 (offset
> is ram_addr_t):
> 
>   save_page_header(pss, file, pss->block, offset | RAM_SAVE_FLAG_ZERO);
> 
> But others just go by themselves:
> 
> qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);

No matter if it goes by itself, I am guessing migration was initially
developed by assuming each initial 8 bytes is an address, see:

ram_load_precopy():
        addr = qemu_get_be64(f);
        ...
        flags = addr & ~TARGET_PAGE_MASK;
        addr &= TARGET_PAGE_MASK;

So it must be no more than 0x200, probably because it wants to work with
whatever architectures that have PAGE_SIZE>=1K (which is 0x400).  Then the
offset will never use the last 10 bits.

Wanna me to add a comment for that in this patch?

> 
> 
> > +
> >  extern XBZRLECacheStats xbzrle_counters;
> >  
> >  /* Should be holding either ram_list.mutex, or the RCU lock. */
> > diff --git a/migration/rdma.h b/migration/rdma.h
> > index a8d27f33b8..f55f28bbed 100644
> > --- a/migration/rdma.h
> > +++ b/migration/rdma.h
> > @@ -33,13 +33,6 @@ void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
> >  #define RAM_CONTROL_ROUND     1
> >  #define RAM_CONTROL_FINISH    3
> >  
> > -/*
> > - * Whenever this is found in the data stream, the flags
> > - * will be passed to rdma functions in the incoming-migration
> > - * side.
> > - */
> > -#define RAM_SAVE_FLAG_HOOK     0x80
> > -
> >  #define RAM_SAVE_CONTROL_NOT_SUPP -1000
> >  #define RAM_SAVE_CONTROL_DELAYED  -2000
> >  
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 7284c34bd8..44010ff325 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -71,27 +71,6 @@
> >  /***********************************************************/
> >  /* ram save/restore */
> >  
> > -/*
> > - * RAM_SAVE_FLAG_ZERO used to be named RAM_SAVE_FLAG_COMPRESS, it
> > - * worked for pages that were filled with the same char.  We switched
> > - * it to only search for the zero value.  And to avoid confusion with
> > - * RAM_SAVE_FLAG_COMPRESS_PAGE just rename it.
> > - *
> > - * RAM_SAVE_FLAG_FULL was obsoleted in 2009.
> > - *
> > - * RAM_SAVE_FLAG_COMPRESS_PAGE (0x100) was removed in QEMU 9.1.
> > - */
> > -#define RAM_SAVE_FLAG_FULL     0x01
> > -#define RAM_SAVE_FLAG_ZERO     0x02
> > -#define RAM_SAVE_FLAG_MEM_SIZE 0x04
> > -#define RAM_SAVE_FLAG_PAGE     0x08
> > -#define RAM_SAVE_FLAG_EOS      0x10
> > -#define RAM_SAVE_FLAG_CONTINUE 0x20
> > -#define RAM_SAVE_FLAG_XBZRLE   0x40
> > -/* 0x80 is reserved in rdma.h for RAM_SAVE_FLAG_HOOK */
> > -#define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
> > -/* We can't use any flag that is bigger than 0x200 */
> > -
> >  /*
> >   * mapped-ram migration supports O_DIRECT, so we need to make sure the
> >   * userspace buffer, the IO operation size and the file offset are
> 

-- 
Peter Xu


