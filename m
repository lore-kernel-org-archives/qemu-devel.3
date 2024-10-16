Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42D7D2A536
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 17:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t17Wa-0005UV-7k; Wed, 16 Oct 2024 13:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t17WV-0005RC-EF
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 13:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t17WT-0003k3-Mk
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 13:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729098560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Un6q6R/I5PAlrllKOI5gcodxrLU1Fsx1Je/qZufgJvE=;
 b=IDGYZQwAVXcB1B3AoP81m9ae6ThCwxqxxEJhx8lOI+LoqvZBm8fff65eogQqwQfwXjfLlK
 oCMvMvIGriHqQ3+hTyhFgdXlB2mE+OKQDhAqdnD/VDAePZJirvjEKXRIVpIx/CvwfpANmv
 LEgNG0qzP71A6toErazbpUxxXqK5obc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-HITaFzMlPVSvu1hNOPBklQ-1; Wed, 16 Oct 2024 13:09:15 -0400
X-MC-Unique: HITaFzMlPVSvu1hNOPBklQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b144a054baso172280585a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 10:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729098555; x=1729703355;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Un6q6R/I5PAlrllKOI5gcodxrLU1Fsx1Je/qZufgJvE=;
 b=cW69WwKrgvkU54D7mFV85vmKRmo4gWc316PXu9xg/U2uLz+Lw1g6pOPmLf4n1d7ANg
 kREEug8gpd+A8tpWerWxSL4eCmktyO4uj29tJIfSr2pjvi8n3j3Ho1VpMXODsYrzf+EJ
 PkAl7BcbjSEtU+kJCJP2YbBjWd1CS4UPNMHxQ+HIy8e33btyp68YclLs06gC4FTE5G0B
 rp460iM6diPuju6HEOCeLj8F481bOBkCWIXra1+wZDFswQIcEoVyOlZjvkZVj4w1qVJV
 Dicj7Q6jb5J6ped8pyQ9deLb0KslYHMGhcQharqOYnmTOTI4BCNAPs7/cFOcDD0B5SHv
 Im3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpdAh40M0wRZ4NNcp4+dYRzDcA6sed05bpBhe6DyL8vmqyZ0ISSTVNaiaVxl2yi3t3q3tBrNSnn36Q@nongnu.org
X-Gm-Message-State: AOJu0YwY4urKddIkTBaQD8fBJ31B6leU13upgvm6MjPwP/NzqdXHzdSn
 7aRpO3L7/mcn4GfymQ1pZK/jdecD/Fo59bpHU1JVySWOLcu3avX6JYJK67EwP7CMqnqGNWbxRT5
 5n4DQaxvq2Z61A1sdK6TlnPIYVX22uanlt94SgB9ODBXSTddqLtaS
X-Received: by 2002:a05:620a:45a1:b0:7a9:b2f4:42e0 with SMTP id
 af79cd13be357-7b14d5095b2mr53321485a.15.1729098555139; 
 Wed, 16 Oct 2024 10:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyQpsYsibbjQ0YztwV5gDCg1ICt0pmcu0Z0+mBRl2pNGWRu2H4/aSiqn7u0Cz8Pu9xgINVdg==
X-Received: by 2002:a05:620a:45a1:b0:7a9:b2f4:42e0 with SMTP id
 af79cd13be357-7b14d5095b2mr53316385a.15.1729098554688; 
 Wed, 16 Oct 2024 10:09:14 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b141e52f25sm144166285a.35.2024.10.16.10.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 10:09:13 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:09:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration/dirtyrate: Silence warning about strcpy() on
 OpenBSD
Message-ID: <Zw_zNzJdRIS42L-3@x1n>
References: <20241016160712.962407-1-thuth@redhat.com>
 <Zw_oM-RStF4QhWik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw_oM-RStF4QhWik@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Oct 16, 2024 at 05:22:11PM +0100, Daniel P. Berrangé wrote:
> On Wed, Oct 16, 2024 at 06:07:12PM +0200, Thomas Huth wrote:
> > The linker on OpenBSD complains:
> > 
> >  ld: warning: dirtyrate.c:447 (../src/migration/dirtyrate.c:447)(...):
> >  warning: strcpy() is almost always misused, please use strlcpy()
> 
> Is that the only place it complains ?  We use 'strcpy' in almost
> 100 places across the codebase....

I remember we switched some places to pstrcpy(), which seems superior,
where I saw tha g_strlcpy() is mostly strlcpy() and the man page says:

      strlcpy(3bsd) and strlcat(3bsd) are similar, but have important
      performance problems; see BUGS.

      ...

      BUGS

      ...

      strlcpy(3) and strlcat(3) need to read the entire src string, even
      if the destination buffer is small.  This makes them vulnerable to
      Denial of Service (DoS) attacks if an attacker can control the
      length of the src string.  And if not, they're still unnecessarily
      slow.

> 
> > It's currently not a real problem in this case since both arrays
> > have the same size (256 bytes). But just in case somebody changes
> > the size of the source array in the future, let's better play safe
> > and use g_strlcpy() here instead.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  migration/dirtyrate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> > index 233acb0855..090c76e934 100644
> > --- a/migration/dirtyrate.c
> > +++ b/migration/dirtyrate.c
> > @@ -444,7 +444,7 @@ static void get_ramblock_dirty_info(RAMBlock *block,
> >      info->ramblock_pages = qemu_ram_get_used_length(block) >>
> >                             qemu_target_page_bits();
> >      info->ramblock_addr = qemu_ram_get_host_addr(block);
> > -    strcpy(info->idstr, qemu_ram_get_idstr(block));
> > +    g_strlcpy(info->idstr, qemu_ram_get_idstr(block), sizeof(info->idstr));
> >  }
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> Is it worth also adding
> 
>   G_STATIC_ASSERT(sizeof((struct RamblockDirtyInfo){}.idstr) ==
>                   sizeof((struct RAMBlock){}.idstr));
> 
> at the top of this file, since both of these fields are expected to
> be the same size by this code, to avoid truncation.

Or we could define a size macro for RAMBlock.idstr and use it everywhere
where it's fundamentally the same thing.

> 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

-- 
Peter Xu


