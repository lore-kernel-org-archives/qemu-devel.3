Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65940C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvIGF-0002ne-AQ; Thu, 20 Mar 2025 11:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tvIGD-0002nS-N2
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tvIGB-0002YZ-LY
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742486201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O+k8Re91HQ2Al4b3PIN/sdPU5zIUmTTgri+A4EGAxgY=;
 b=YiqAc+oVNbmB401qq6aYFT/9gEL1EEsM1jrFC2LnVdj/h70Ov5n56JUlE3z+9xVZ1809pQ
 I4VVFvaoWKJ1QSxcJhdli3Q3phCMhxJzqSzyHB610+Juwkgy7h5YTIM4ionOXNBy5rTVyC
 GnIHZMuZO64Zv/938FTSR5FL9oVMoy4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-6nJJN3PmMvuGtTyyAAwRyw-1; Thu, 20 Mar 2025 11:56:40 -0400
X-MC-Unique: 6nJJN3PmMvuGtTyyAAwRyw-1
X-Mimecast-MFC-AGG-ID: 6nJJN3PmMvuGtTyyAAwRyw_1742486199
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-476a44cec4cso16290831cf.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742486199; x=1743090999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+k8Re91HQ2Al4b3PIN/sdPU5zIUmTTgri+A4EGAxgY=;
 b=JXbrj4Pf/QDw1JFg/viql0iCAPAysAb2ukl2R7EsJbIwwGcRgpjjbSLD9IuO4k+EUd
 3iI9e0CFErPs2d9NOkDR7xWXCB1TkZ8PKa9RouX9RvN5blbsYSRm821jjhiUZQaZPbnR
 ugTpNbqz0UP2Aeh8mp3MqjpdncPU4nsRICBBZD9Lmn0KZfA0EDnBzoqNU8P64cVy0qY5
 6n0N+1uwFT+Cr0MPbd0tJ7ofRoUQ8bfi+MLxt/vqY3Ov1KOT2w8+17MOztiIYnhbrcl/
 Mqp0QxN4HT4Vne33YCgwyeeI6Q5X2ReMm5klSGl66t8LLB/syn3BkYVq62QfLA9l/gut
 ltkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN20J4E8DbicrFlHXw3eP5cej6Eg0PB3SVdj6CHwno7u9xV3aas7KTwBr5+CUeOrOoS5OlaGkoHNUT@nongnu.org
X-Gm-Message-State: AOJu0YzKEmu3TcwT29lWy1ayhG0kAP6fBze+1meR4ZX2bVseD7Eg3LxG
 A/XxvbTNB1Lx4BbZgcPfr2QHUxuXs2E3k5KXjMuzWacT4ieQACpUUYiNS9tKK0PbELKxM1ibeUN
 +mHcPwDGWwGcg0PbbgRTLwqkxMqOGHQzsI2HQyVKZ514QjlcsrdV7
X-Gm-Gg: ASbGncvEU4PGMemzuLAubaVTe1PCtTlwEs/HIAz6C2HjT0KaK6fV49LVHa5DGsaR05M
 uBr7WgqV6SBHDXD6B3QMYFyMt3ynSCZzy9LsgV7tL3UhpGWlVkN7SukBIunALZs2zGP5jgXg/Ab
 64BAuBiq1Ajwd1ownEt6u87lbqYadKUGQEiEUwlusodW+MMIq8YraXAa3nINOoW+Dtn0MGVKEBR
 FWPf+Ga/4mMLbwzFmsrsVFSKaefUN67hDacEqdIwtt+P5OxRxMDcTCfxIBrJpiwjPgpYNjj0GSo
 HLnNdGs=
X-Received: by 2002:a05:622a:1e8a:b0:476:afd2:5b60 with SMTP id
 d75a77b69052e-477082ded8bmr112555671cf.15.1742486199487; 
 Thu, 20 Mar 2025 08:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI0Fd31UOy7wVnBYL4X+Jfo0ja03G+qiT0yAVjXVhMF4LsYlzjleYZi4KzghIYsUWvIHn8Sw==
X-Received: by 2002:a05:622a:1e8a:b0:476:afd2:5b60 with SMTP id
 d75a77b69052e-477082ded8bmr112555351cf.15.1742486199054; 
 Thu, 20 Mar 2025 08:56:39 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d6359a4sm489401cf.77.2025.03.20.08.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 08:56:38 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:56:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
Message-ID: <Z9w6s1XkDw6Qpr2v@x1.local>
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de>
 <CAE8KmOx0KQ7OfbyivQ_256JVRugtJ8ekykxtQw-uz91Uiuv-tg@mail.gmail.com>
 <875xk3bw1i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xk3bw1i.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Mar 20, 2025 at 11:45:29AM -0300, Fabiano Rosas wrote:
> There's a bunch of other issues as well:
> 
> - no clear distinction between what should go in the header and what
>   should go in the packet.
> 
> - the header taking up one slot in the iov, which should in theory be
>   responsibility of the client
> 
> - the whole multifd_ops situation which doesn't allow a clear interface
>   between multifd and client
> 
> - the lack of uniformity between send/recv in regards to doing I/O from
>   multifd code or from client code
> 
> - the recv having two different modes of operation, socket and file

I can't say I know the answer of all of them, but to me the last one is
kind of by design - obviously the old multifd was designed to be more or
less event driven on dest side, but that doesn't play well on files.

To be fair, I didn't invent multifd, but IMHO Juan did a great job
designing it from scratch, at least it has a bunch of benefits comparing to
the old protocol especially on perf side (even though when initially
proposed I was not a fan of how the locking was designed.. but it should be
much easier to understand after previous refactors).

And just to say, we can change the code or protocol in whatever way we want
if that could make it better.  So instead of the rant (which is still
welcomed whenever you feel like :), we can go for whatever you see fit with
compat properties (and if with a handshake, that's even less of a concern).

-- 
Peter Xu


