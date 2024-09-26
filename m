Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E101CDE032
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 19:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stuaW-0000ca-Gy; Thu, 26 Sep 2024 15:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stuaS-0000c0-C7
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 15:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stuaP-0008W4-Ir
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 15:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727380535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsmYR2qxCm7GhRF2pkTcLkDmIDL3JMjXPVWcUAXdIHU=;
 b=ZtEIRdtDfCjd/zcCkt6DNyEL755OGtTYlVNryyU10WN/hm3os/844iwpW9BaNXHBw6Sc8o
 AfULsBfTvN5nQb1eKSgW/xS3r68BKIFetmwjmEcuj6kNlDXzqs0NpgezYktbGOtBUfZ0s2
 mNAH/3yZHS5Q+Nv+zD8qz+mjZRrgPO0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-ZYmH-woEOhijDnguFTGDAQ-1; Thu, 26 Sep 2024 15:55:33 -0400
X-MC-Unique: ZYmH-woEOhijDnguFTGDAQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-20b30341cceso4830335ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 12:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727380532; x=1727985332;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tsmYR2qxCm7GhRF2pkTcLkDmIDL3JMjXPVWcUAXdIHU=;
 b=KhihzsrUmPifc4u9EzopCaaF3fTCGlm72q8dwmjkzfwI/MUfnvol8WA6w3QwC2fbp4
 e3CDGEs7M3O6FCcbolUF30FM1tnPdetidOpIOGv1bM37nBIYUb6hJGHurMPJ7rRrkv3R
 KHr4UNwRCUA6+fFIIFNydHZ1v1UE6PUKB3Uwo8Ip56NDyq6VuG09vIVlYDYSJYSqbkZi
 JbJz8TTxuXsbYXB3R38b4FWX02MDouN6leKxwEo9A6zbgVMD/oPaVXkMMeWG5Zdz6kxB
 IgX4yYKzOWrCIWUsJctmMnuuJfAlrnFjhN4gd6JOm6ABqozY9fHUiCBz/ja8mbW1DeWz
 Lc8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ448oMiOCy+KB3ywgIWocf7PXVyyWCs7EyEZ0g/JuYJNuTqIyPqNh8PsmtdzQ3wHMMAzxJ2iLYGD0@nongnu.org
X-Gm-Message-State: AOJu0YwH/RK19/DMw0JJYfMnhPjBClqn4pTrtEYytmZb7B0jiKZMOZTl
 5H15H8QKHqeo6YALmeCQwE05yKwQXwhEgybySQWxurx+HZChiJCVchitW7siBoiO9IIspFMVG2Q
 aVxIOZ2qYCrlP6Jw2tCtOrhfclMGJBAUW5x0lkp7jVnYiWkpNKC7g
X-Received: by 2002:a17:902:dac5:b0:206:aa2e:6d1f with SMTP id
 d9443c01a7336-20b37b6cdb8mr10909275ad.46.1727380531871; 
 Thu, 26 Sep 2024 12:55:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtrJti12mCEqEpWdz62H3PIqr7ETbWxfmlvreGQ829CkHbx0i6QT5P/nUz5eN/E74o3Ba+iA==
X-Received: by 2002:a17:902:dac5:b0:206:aa2e:6d1f with SMTP id
 d9443c01a7336-20b37b6cdb8mr10909015ad.46.1727380531424; 
 Thu, 26 Sep 2024 12:55:31 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e321c4sm2058505ad.188.2024.09.26.12.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 12:55:30 -0700 (PDT)
Date: Thu, 26 Sep 2024 15:55:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
Message-ID: <ZvW8LxJsv3pRWom_@x1n>
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
 <87msk7z4l3.fsf@suse.de>
 <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
 <ZuxxOObKqS_G0Ela@x1n>
 <CAK9dgmYaE=poiwLQqD6qbjJQdgPLMn8cW8VO47xYFTBkNiUVLA@mail.gmail.com>
 <ZvRh0RhkUC-eLbjo@x1n>
 <CAK9dgmbi1VSXvxFjziH5PjaoiaQwBJ3z4ff1BAojtm26VTThUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgmbi1VSXvxFjziH5PjaoiaQwBJ3z4ff1BAojtm26VTThUQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 27, 2024 at 02:13:47AM +0800, Yong Huang wrote:
> On Thu, Sep 26, 2024 at 3:17 AM Peter Xu <peterx@redhat.com> wrote:
> 
> > On Fri, Sep 20, 2024 at 10:43:31AM +0800, Yong Huang wrote:
> > > Yes, invoke migration_bitmap_sync_precopy more frequently is also my
> > > first idea but it involves bitmap updating and interfere with the
> > behavior
> > > of page sending, it also affects the migration information stats and
> > > interfere other migration logic such as migration_update_rates().
> >
> > Could you elaborate?
> >
> > For example, what happens if we start to sync in ram_save_iterate() for
> > some time intervals (e.g. 5 seconds)?
> >
> 
> I didn't try to sync in ram_save_iterate but in the
> migration_bitmap_sync_precopy.
> 
> If we use the migration_bitmap_sync_precopy in the ram_save_iterate
> function,
> This approach seems to be correct. However, the bitmap will be updated as
> the
> migration thread iterates through each dirty page in the RAMBlock list.
> Compared
> to the existing implementation, this is different but still straightforward;
> I'll give it a shot soon to see if it works.

It's still serialized in the migration thread, so I'd expect it is similar
to e.g. ->state_pending_exact() calls when QEMU flushed most dirty pages in
the current bitmap.

> 
> 
> > Btw, we shouldn't have this extra sync exist if auto converge is disabled
> > no matter which way we use, because it's pure overhead when auto converge
> > is not in use.
> >
> 
> Ok, I'll add the check in the next versioni.

Let's start with simple, and if there's anything unsure we can discuss
upfront, just to avoid coding something and change direction later.  Again,
personally I think we shouldn't add too much new code to auto converge
(unless very well justfied, but I think it's just hard.. fundamentally with
any pure throttling solutions), hopefully something small can make it start
to work for huge VMs.

Thanks,

-- 
Peter Xu


