Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF59D1951B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 21:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkTne-0002zc-L0; Mon, 26 Jan 2026 16:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkTnc-0002yO-3Z
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:07:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkTnZ-0005My-2U
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 16:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769461618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JyfUCMmjTrUwSJSasAEHFFmAZsNaeBTAIAqIrIVrCog=;
 b=XwgqQgaE5+uGiz3iQb8ZNtRVOny7Wnux8wPrTlV1JVe0VglNoMoCKOEqbHjZ4xSB8IGFRC
 NjDPgW3VjfXgdrUzI3UC9+McF3ByWnMJtwufyr8EjMqeui/UpytX9cBY9r4fps5jp3kvYm
 lSvq2ZXCOZfbIqiIxZHhVTMrIK41w4A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-MjE0IqCuN0S1bhSzzZzr8g-1; Mon, 26 Jan 2026 16:06:56 -0500
X-MC-Unique: MjE0IqCuN0S1bhSzzZzr8g-1
X-Mimecast-MFC-AGG-ID: MjE0IqCuN0S1bhSzzZzr8g_1769461616
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-502a341e108so156179591cf.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 13:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769461616; x=1770066416; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JyfUCMmjTrUwSJSasAEHFFmAZsNaeBTAIAqIrIVrCog=;
 b=o5JgKukp32nC+Itu03oTGq0otaBfEPVFE1OOnioskTxe1RxQsolydil+sj2AJ5zbRB
 OKsAV3HVbUrNEpxjyl5cPJRZbZrb/5GKbXCBmGbtNbiKtH0klHTyw4Jq3BMPRC9FCE9s
 rTDmwRYL+Cw62Djos4sLxsnfZ+6/Cego0X0YBq1ex9IFZDWyGUub818Vlmt5obhSetaO
 es1YvmDh4YPv+6X5QQIdnoVBuTrBpi2WCM9VA9adksCfOsBCOglY63xVcXQ3tvkjBifg
 w0IPrGhWLYgU7nT6F2ESxAmm3x6eEGbcMtAuilx5JenQdw5m0kdv+qzTspDkDRkOz9QV
 3cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461616; x=1770066416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JyfUCMmjTrUwSJSasAEHFFmAZsNaeBTAIAqIrIVrCog=;
 b=PJ/6ghQXKayWGB4/XdhllVxfkWRwXD2r48iosw6T7l69fXlLkUXw7ArMeY9XlrBCC/
 ppEWuDpZ5h1oC167pGDu4VXEqqqp7RbSW11xnfDQCM5f3sRRhsjbn2KFrLR9itYYJXOV
 JWQasTrhXsNEhONWw3c/Yv4WqPSEp99h1oMrvYERaDRRhmogy/Un2d5+NK1h8ASPVUkd
 MSNFTGrIik790FbHueKI4qQ8Wrr74vxbKZOvDRxMma8TQlg4xEXnpQcxj36Oq2UeYUFr
 y/oWailEVlLbo5lf/cOYakXyORvJcEnGEEMA9dhefZJXEWVUzE8jF1Qj2PUOyKhIjCRT
 96MQ==
X-Gm-Message-State: AOJu0YylQvSo+nGXzQ6FhkUVnmIgQ4Y1zSZeGxikrK7RugaZiF3Prkpl
 Bh7RPP9polVwzjuNFZcmDUfuzzxmis5tdIj7QC9lyRTcRDErvqoCZWGizzlfKJbL8Z/buu7u2o6
 E3Kx4bmPJiTzBFflGHmcEJBaX3Sky05e2blKJBaZmIy9b+miRRNHYfs+C
X-Gm-Gg: AZuq6aKHKAO+G3rOKwSufYx7TwnE0wWt4vmmSH3qfoWdwlsKyVLpDnyJcm4LkStxOE/
 XcTKboPAK4c4ecAX2pE7kWdS7RVwIwSitc4GN114oQnhOGKK9bF7nm5bdJUIoZpJaR/X/XSzUuQ
 i6ZGCJFo1gbRufw8GSFMK7wpMvOhWFW2aGvJINCihIr4mvNh+wHARXYx1O8kv+yc+3yRhPmkY6X
 CFe9IFQ5Drmx3Ymia1Om46UipEylRnQaA7joElnC4x2/9AgpldM9IDcepyLvLb9lT4D1Fp6qUO0
 PA8Ycm8CMMQS2x6iCQIWakKWeCRdYstadvM5oiSEZABUFWjKA8iuIqtqeJKijNnsSdmYbT81mTV
 BCWo=
X-Received: by 2002:a05:622a:8e1c:b0:501:51e4:1ec3 with SMTP id
 d75a77b69052e-5031b25f946mr43798721cf.78.1769461616263; 
 Mon, 26 Jan 2026 13:06:56 -0800 (PST)
X-Received: by 2002:a05:622a:8e1c:b0:501:51e4:1ec3 with SMTP id
 d75a77b69052e-5031b25f946mr43798451cf.78.1769461615822; 
 Mon, 26 Jan 2026 13:06:55 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e38700d6sm1014634385a.50.2026.01.26.13.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:06:55 -0800 (PST)
Date: Mon, 26 Jan 2026 16:06:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 09/10] migration/colo: Move qemu_fflush() closer to its
 user for fb
Message-ID: <aXfXbR2voiOjM4Pf@x1.local>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260121223336.3381912-10-peterx@redhat.com>
 <871pjgifm9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871pjgifm9.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 23, 2026 at 11:10:54AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > COLO caches all device states in a buffer channel `fb'.  Flush it right
> > before pushing the buffer to make sure everything needed will be flushed,
> > add a comment explaning it.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/colo.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/migration/colo.c b/migration/colo.c
> > index f92803dd29..e2307f1907 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -472,8 +472,6 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
> >      qemu_savevm_state_complete_precopy_iterable(s->to_dst_file, false);
> >      qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
> >  
> > -    qemu_fflush(fb);
> > -
> >      /*
> >       * We need the size of the VMstate data in Secondary side,
> >       * With which we can decide how much data should be read.
> > @@ -484,6 +482,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
> >          goto out;
> >      }
> >  
> > +    /* Flush to make sure everything lands bioc->data */
> > +    qemu_fflush(fb);
> >      qemu_put_buffer(s->to_dst_file, bioc->data, bioc->usage);
> >      ret = qemu_fflush(s->to_dst_file);
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> Wait, aren't we wasting a memcpy here? Isn't this the same, but without
> the copy of bioc->data to s->to_dst_file->buf:
> 
> qemu_fflush(fb);                                        // ensure bioc->data is populated
> qemu_fflush(s->to_dst_file);                            // send buffered data from migration stream
> qemu_put_buffer_async(s->to_dst_file, bioc->data, ...); // point s->to_dst_file->iov to bioc->data
> qemu_fflush(s->to_dst_file);                            // send s->to_dst_file->iov contents

Good point!  Same to postcopy..

I quickly measured a small VM in postcopy path, async put can shrink the
time needed (plus the flush) from 91us to 38us.  Not a huge difference, but
I don't see why we don't do it either.  I'll test more and add those when I
repost.

-- 
Peter Xu


