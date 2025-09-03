Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4E5CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnF8-0005E6-7p; Wed, 03 Sep 2025 09:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1utnF5-0005D3-C5
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1utnF3-0001jL-7j
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756904973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4ntV/1v1cCZG3ep5pRqcro4tfXVrHunRE5Y0Nj0Rzw=;
 b=eZNEudcO6zKfVboE32dsPVktr2kivzb5ar8bkHaWQjZhLX+2fkXbhd4xKa5k7KLVLtIbTC
 0bOO3oFfcKUsctuZJq9YOL5xTJLzLgsCZDu4U7eMFdc0IDrot43knTKVyKL0KgQ+ciDLxI
 QRsR/k5lCnUYkZ5NNgxXliCEBIQj5X0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Grq8xUCWOMu9CFjq-dz2Vg-1; Wed, 03 Sep 2025 09:09:32 -0400
X-MC-Unique: Grq8xUCWOMu9CFjq-dz2Vg-1
X-Mimecast-MFC-AGG-ID: Grq8xUCWOMu9CFjq-dz2Vg_1756904972
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b49715fdfbso11243031cf.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904972; x=1757509772;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l4ntV/1v1cCZG3ep5pRqcro4tfXVrHunRE5Y0Nj0Rzw=;
 b=qunTi4QHqpOfbb9x6giIQ0nh9aMTtyKro70jZl8z8S4pDck2bH/SS90+2LAGyFdhWt
 FzzckQOPuuV99JyF8ZlQPNnHVRTA9qL8VAa6/OS6rMdzJKoyrP8/Rq9yXmI91JVPsBEh
 qatGcCyfFVrQnL08LoGqyDKzdMXdW3AYnAK6WgCB+TO1af+Qpwv5P7K/eTW7BAKUm+91
 XB1R7PMWkQuIIVnWK3Ai1jycBZtpYhq1lcBydUQgOYMfkZu/9QQSI3IzwGK3Q74P9svT
 DZpLwvF6Hg0o4aOWtiic/8NJx4TQkc1XFuaSLocOAHyzCPQPL/bl8rGml0tNcz0oaK1A
 y/MA==
X-Gm-Message-State: AOJu0YwbKnUkTmASGYRxfdWXuszCLYdRPRa7QpqfCjjLDPBhYtDImegW
 SlXe8L4QFHVVSB05xcsZmOnWxOuSk49ncYaqXoNmeTyZQ4FY2uJGVhQwLqlXnzpt6tvkUkfwKW+
 OHLEzcc5noH+JyGrlgaMtwdq/Nc233wCjag/je9we4fMDzNPqwTAgy4qJ
X-Gm-Gg: ASbGncsRo1ou56NejR1DBiNNNMYx7F0HhIIUjoupM7WKnfozfK8bLtuZHURArvfuJXw
 cyld3GZzCYlFg0CbRe1t1MxhhBfc8x0WJwaulpCzMfFaQwkqG5l+mFIwLEs2cuiPOU62G32qfI+
 X3Sl5sWQv6+YoB4hNpUZoXS25z+ULYoxZ4PXyrkJ8LKacAPyOCBwIEt3HI80R4CU33dWX2a9fPr
 vg1D2MNiEvXY3QbzOgXg46WUOuBNHmuh4IGKGu2s8LTC3ohJXiaaW7KUty6C3xMVuDoX378vbUV
 Gd6VYFASwPlGmP0Dw9smEWE+ApibIoOS8jB7MQvvihremRsuFd36PGwWXoOkc9dM/AKReZP3hhK
 +cJrIV8AYu2uIbPEWkeyxUg==
X-Received: by 2002:ac8:5805:0:b0:4ab:6bd2:e25 with SMTP id
 d75a77b69052e-4b31d842179mr177692371cf.25.1756904971465; 
 Wed, 03 Sep 2025 06:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK2WcYMso5E4yNwocoZuXFBewtA6nL8ctkwhVjObGLuM0kxuL3p4Se8qzGfDyamtio/XgK8g==
X-Received: by 2002:ac8:5805:0:b0:4ab:6bd2:e25 with SMTP id
 d75a77b69052e-4b31d842179mr177691661cf.25.1756904970688; 
 Wed, 03 Sep 2025 06:09:30 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f78757fsm10935471cf.43.2025.09.03.06.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 06:09:29 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:09:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] memory: Fix addr for flatview_access_allowed()
Message-ID: <aLg-B020VAPtAE-1@x1.local>
References: <20250902214005.730358-1-peterx@redhat.com>
 <2f195d44-21e6-4829-9e5b-03177452b889@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f195d44-21e6-4829-9e5b-03177452b889@linaro.org>
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

On Wed, Sep 03, 2025 at 12:38:19PM +0200, Philippe Mathieu-Daudé wrote:
> On 2/9/25 23:40, Peter Xu wrote:
> > flatview_access_allowed() should pass in the address offset of the memory
> > region, rather than the global address space.
> > 
> > Shouldn't be a major issue yet, since the addr is only used in an error
> > log.
> > 
> > Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Fixes: 3ab6fdc91b ("softmmu/physmem: Introduce MemTxAttrs::memory field and MEMTX_ACCESS_ERROR")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   system/physmem.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/system/physmem.c b/system/physmem.c
> > index f498572fc8..019118cf75 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -3027,7 +3027,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
> >       l = len;
> >       mr = flatview_translate(fv, addr, &mr_addr, &l, true, attrs);
> > -    if (!flatview_access_allowed(mr, attrs, addr, len)) {
> > +    if (!flatview_access_allowed(mr, attrs, mr_addr, len)) {
> 
> Right, but shouldn't we also use the translated length?
> 
>        if (!flatview_access_allowed(mr, attrs, mr_addr, l)) {

Yes.. I'll repost, thanks. :)

> 
> >           return MEMTX_ACCESS_ERROR;
> >       }
> >       return flatview_write_continue(fv, addr, attrs, buf, len,
> > @@ -3118,7 +3118,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
> >       l = len;
> >       mr = flatview_translate(fv, addr, &mr_addr, &l, false, attrs);
> > -    if (!flatview_access_allowed(mr, attrs, addr, len)) {
> > +    if (!flatview_access_allowed(mr, attrs, mr_addr, len)) {
> 
> Ditto.
> 
> >           return MEMTX_ACCESS_ERROR;
> >       }
> >       return flatview_read_continue(fv, addr, attrs, buf, len,
> 

-- 
Peter Xu


