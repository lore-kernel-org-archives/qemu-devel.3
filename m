Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A99C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp5RI-0001PX-BI; Wed, 29 Jul 2026 10:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp5RD-0001PA-FD
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp5RA-0005um-TF
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785335951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOnTk6/yHiTcYITCKdeVC5C3GiW3dEC6Vexx6iygnPs=;
 b=RhikhoDbeQWhcg6TVjiNxIn8XOMEeG2v3oVOD8mRx5ynT+i6CTGLn6Vq8vB/yHXT9wY4kA
 mWD4D9difIwjG+98d2c5lugZk2TIuocXJbsY29igllo90N1n0U7zXaeaevgOrsTKenldgy
 qn4l/Nusu8bl0lO6D1Iws3d7EOnDJfA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-eXCI95daOiuqwqyq3XX6aQ-1; Wed, 29 Jul 2026 10:39:10 -0400
X-MC-Unique: eXCI95daOiuqwqyq3XX6aQ-1
X-Mimecast-MFC-AGG-ID: eXCI95daOiuqwqyq3XX6aQ_1785335949
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so12069326d6.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785335949; x=1785940749; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qOnTk6/yHiTcYITCKdeVC5C3GiW3dEC6Vexx6iygnPs=;
 b=Aslgrghs2HhhtRpZh0c9WrvvdDAGNe6AiEW4ARa7OGPM0VLqCGryOzFp56no5QrdsV
 clWKO3jHF4Z73fdVJsmYdefnYUW3YwubX6mwY5JEx/MMjakDN81OPHB0xB+c1MgFoD9h
 kZXKwBH0yOGUtDC4sJonxJLLkdb235OIweoehnqZHRJemk4B+UzlwwYvHamL/TTYECYF
 yA+E1CMZrtI26JS+JoAhbDDm5VFe83Y1GfE9WeQzvXbLuk4EylcQTQof3usKUnIxkvcf
 /qIRVCxLSuyHi5o1gzwVTvCxfXGa5gkvsCk98RHsAAinbv14Co5jnVW88CtxvNXdTxZJ
 xTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785335949; x=1785940749;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qOnTk6/yHiTcYITCKdeVC5C3GiW3dEC6Vexx6iygnPs=;
 b=AwajKyL0isbvkU/8KS9zgaIuhLD1S4MsNm0iBuj4wv1xF1gg0UGFjY3wHk/QMIfrva
 gBClQFgzxqe8niksdz1QUlHSc8/A74DzwuhU/0+NJL9SQn8FhEU+Z2CcUxDYKK81zGnI
 fLF2tR2vhM2I7SUNNIIBxkXl0r3QwgxEoxL280U2zuMB+IXSPJFZ5ORr3tWyJO+0ehyZ
 69YdfaRRty7yOZUn+icdOhmdTtBlDkMcegCnAmuwBzC1xaAO+4zdZf1WZ1kBkOn20JrF
 +eXkSDxInKNLDMZGBwe+rb26uOcssG9uDQ12eZs2kgYVKsYhxf11Q8gKeEmZ6hbLYn0P
 Q/Sg==
X-Gm-Message-State: AOJu0Yxl+eYXLmPx2wr8+elFeJ7OycX/GcvNdFRN+NqH+G8AuDhhAAR9
 PwS/cg+Gt6NVHvPX0iv0M6EJb6r2TsC+OhyH8Szb9WSDkzIfS4KXkfmenfUbLF+5ndpu5sd0oBy
 GsrzHohzkYm5x49uKzVXdh0UHMrxyrnmWm0e04vtZlrGmxEy8pu4TACx+AZ3NQfdnn99H7HQqQr
 WNJj8RTPAXIJ95elKCWeio/VcGjZUMFIPZiGWkFA==
X-Gm-Gg: AR+sD13MZ3688KHfv+VRy7xGmwGG9LRJuoPnwn5Lx72/3sFbwU8vguVvMwfVTk4+sw6
 fEVFpjmq4e/Ego3muR3GlghXcBRIu7rNxRDwkncPZrFLNOCfHaBm//g1bkpvo0hrdUaTnIJ1qMd
 ZC/ZeyY/21O3WGcN1nJAXm5//yzjQ6JgCx8C3oyKpDpcJVYDVJOHr81rdfcnL7Mca5CiH3tbwJi
 xRjrixzZKFfkpP9+zbPN0UmDjnR9kE/rxv99y+xyEtMNd7OZ6GzB1QN5bV/RXlmpVSUOOMfH4mi
 BB5LeSG0Ds0YxZS6menuR6bUuJs78CGzemf9gsTmgbBXLze7wbwlA1vuHyqXCy+Nt/f/DcNVR9U
 sgjnL9NafP78rRCVfdkyFVc2lzvo=
X-Received: by 2002:a05:6214:29c1:b0:8ef:ec2c:6b70 with SMTP id
 6a1803df08f44-90817379643mr79305296d6.53.1785335949303; 
 Wed, 29 Jul 2026 07:39:09 -0700 (PDT)
X-Received: by 2002:a05:6214:29c1:b0:8ef:ec2c:6b70 with SMTP id
 6a1803df08f44-90817379643mr79304276d6.53.1785335947843; 
 Wed, 29 Jul 2026 07:39:07 -0700 (PDT)
Received: from x1.local (67-208-31-164.ip.tor.radiant.net. [67.208.31.164])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9081dd6b55asm25599566d6.36.2026.07.29.07.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:39:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:38:59 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Feifan Qian <bea1e@proton.me>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v2 4/5] migration: Fix rare hang of
 migration_channel_read_peek()
Message-ID: <amoQgwYxfUTPHyHv@x1.local>
References: <20260728210417.1925078-1-peterx@redhat.com>
 <20260728210417.1925078-5-peterx@redhat.com>
 <amkfP-dtwmxzg_TC@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amkfP-dtwmxzg_TC@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 28, 2026 at 05:29:35PM -0400, Peter Xu wrote:
> On Tue, Jul 28, 2026 at 05:04:16PM -0400, Peter Xu wrote:
> > In an unlikely case, when a migration stream is attached to the destination
> > QEMU and only send <4 bytes to the channel as magic, it's possible that
> > migration_channel_read_peek() may spin forever.
> > 
> > Fix it by adding a manual sleep for partial read.
> > 
> > Since the path isn't attached to a coroutine, it means when partial read
> > happens, there's yet not much we can do but hang the main thread, it will
> > happen even for len==0 case.  It means monitors can hang due to this,
> > either partial read or no data arrived (but connection established).
> > 
> > Leave this for later, the hope is this is extremely rare in production.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
> > Reported-by: Feifan Qian <bea1e@proton.me>
> > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/channel.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/migration/channel.c b/migration/channel.c
> > index 1e2935f926..f446561b59 100644
> > --- a/migration/channel.c
> > +++ b/migration/channel.c
> > @@ -296,9 +296,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
> >  
> >          if (len == buflen) {
> >              break;
> > +        } else if (len == 0) {
> 
> I think this should be QIO_CHANNEL_ERR_BLOCK, not 0..  I'll fix it when I
> post v3, and I'll do some more tests.

I just found that I cannot really hit this path.. because essentially
migration_channel_read_peek() is too early, and we haven't set iochannel to
be in non-blocking (QEMU only does it for the main channel; for the rest
channels they're always in blocking mode).

But still, instead of asserting it, I plan to keep this line so this code
is generic to blocking mode too in the future.

> 
> > +            qio_channel_wait_cond(ioc, G_IO_IN);
> > +        } else {
> > +            /*
> > +             * When partially ready, we can't use qio_channel_wait_cond()
> > +             * because it will return immediately.  Apply a manual wait.
> > +             */
> > +            assert(!qemu_in_coroutine());
> > +            g_usleep(1000);
> >          }
> > -
> > -        qio_channel_wait_cond(ioc, G_IO_IN);
> >      }
> >  
> >      return 0;
> > -- 
> > 2.54.0
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu


