Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBD3C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94Ir-00058s-Ks; Tue, 22 Sep 2026 13:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x94Ip-000567-Ex
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x94Im-0006KP-VQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790098147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=up4a4u/vUQmBPGpEuPzmniDhqAY/8+jta5iAB4aNAzA=;
 b=d7vO+tzqRa+H+Gr8qPZkDrdaTspxJ5qHdlVPwRVPe14lFTycmXpTa84dxWmvCKtT0abExU
 mf0hUoD/50NS+Ef/h4yrn1rzGGxBdbax4sh9jODqbWP5hL4q/RRzNEgwU73//65viBn7QB
 aUDmaKwpz6ylwUpIgSzHPcZVpSw8JHU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-4JW7MiCIMxCioS2UIUn2cQ-1; Tue, 22 Sep 2026 13:29:05 -0400
X-MC-Unique: 4JW7MiCIMxCioS2UIUn2cQ-1
X-Mimecast-MFC-AGG-ID: 4JW7MiCIMxCioS2UIUn2cQ_1790098145
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9104215fbdbso2137056d6.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790098145; x=1790702945; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=up4a4u/vUQmBPGpEuPzmniDhqAY/8+jta5iAB4aNAzA=;
 b=m+B/nXKg9J2/TyhjGJbMfyDkmi079eeKqAPVJZjg6Tx4wzpsyV0OPjUOXiFV8vs3ic
 w3xYZGX5AzwyKHT5i5tujjVUTt5xRXIQ1qnZAcskYF/e7Er+jW1/V9LRcygDtjZQc6aW
 w7neKCL9fEeIcACdWF2D1nd3mi9+yXJz8vjtj58BYDO39ctaDbUgkZXJ3nKDjxJSLIkl
 9CWEvSar5WaKdQ80SGJtY5JjTKtjMF0k9FY78+M/5NKGAkzL/Qzi6k6WL0sutlpbYqYc
 kHpSNogaVC76HeJ21wWf9FqUba8xGQJsZ2ryjWUrK6dcNUYTQv2OmcvSYltG4GQlv7Y5
 S1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790098145; x=1790702945;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=up4a4u/vUQmBPGpEuPzmniDhqAY/8+jta5iAB4aNAzA=;
 b=Kjn5eUs4NAhEExO94b3SEzpkBQoRl8ylu2xSZOlqEoQll9bfSe2LNqDzZ8emNwqmaA
 zaDsfvkrnYXOkML7WV23n8FLHity4l2h4tOE0xEedg7Ha+E/OS0eoxfvuwdLFM2T//3B
 FY3p6e1vDE0G6kIdss20JTVo0O2f1mVbfR3FAtPEJ99cAZguzQuV+HDKuVaAkCibj7lp
 FSwLFUBz0xbhR/gEOCWBWdS6iqM7HxXxvpuaze7Iva9umaYuiM9z3oS7fFHim16q2jPa
 40OJ6u7/wcbHofUjw0UUFD7XoDXy6k7Cs0cxoSkI9JKc2b8WYnkXmELtH5J8EzGg0Fid
 QXWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpAqL37LSMV26PMwEJ3Xv+D/yuswglm7WM6aEV3jnTkk8ymMyprZ3MUs9wRtO8fJWKoaBukl7pdkea@nongnu.org
X-Gm-Message-State: AFuF++m4C85bCUlZb4L/jQ5knA278MkwDcZcLydu4chtlJcwaiYIBZQS
 O8PE6wsT8tQ8TXLWN4gL2o3RVS66y9p8qPKK3B4U7XzAhwYiHMrDSZesFznBDYbNHLf1/oE0c5n
 B35kjucgDq22xnTu8AFBe87rM3wmL+Sr0I9Yg4vstjKRC4Efs50M+rBF+
X-Gm-Gg: AYBFou3WIGpj7z96OqLSUBWNhfKTmrpTtKmg4j5PUTkdn0CuqOo+7OT1H0X8/yzfD5x
 9yfHo3yXWl4HSYtRxrvFt3/gCFHhryRXueTll3CzTjaUL08trYiL/1xq9RLkaYVUiuDY/JjkV3K
 4yJSOhiOex154joN2SULL9BDXnpX0GDL83QEc7vMGGCU6Nx45h8Jg+zU0a4A6B8srpThR2lx4uZ
 yGBe2OrwzjDEKnd7/Hsw7hP6Ml53V7qp90aP0ycpEkI1eSUkaA6oOULLKZl3I9RQKX2fPGqaoGa
 kXz4sqRisnBDbAYEraN8QXMT9JF/sUUlDq4pnW/r6nx9KE/lobV8hB8a6G4qyX1fFWzQNYk=
X-Received: by 2002:a05:622a:1f11:b0:532:ca19:afc1 with SMTP id
 d75a77b69052e-532eac94933mr4108041cf.29.1790098145014; 
 Tue, 22 Sep 2026 10:29:05 -0700 (PDT)
X-Received: by 2002:a05:622a:1f11:b0:532:ca19:afc1 with SMTP id
 d75a77b69052e-532eac94933mr4107691cf.29.1790098144420; 
 Tue, 22 Sep 2026 10:29:04 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532eb32f6aasm1536191cf.16.2026.09.22.10.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 10:29:03 -0700 (PDT)
Date: Tue, 22 Sep 2026 13:29:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH 1/2] docs/migration: document that postcopy can be used
 with multifd
Message-ID: <arK63C0Yw5fkDpwc@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260915063719.89031-1-guobin@linux.alibaba.com>
 <20260915063719.89031-2-guobin@linux.alibaba.com>
 <87se319wi4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87se319wi4.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 22, 2026 at 11:44:03AM -0300, Fabiano Rosas wrote:
> Bin Guo <guobin@linux.alibaba.com> writes:
> 
> > Since commit e27418861288 ("migration: enable multifd and postcopy
> > together") in the 10.1 release, the multifd and postcopy-ram capabilities
> > are no longer mutually exclusive, but the postcopy documentation does not
> > mention multifd at all, leaving users unaware that the two features can be
> > combined.
> >
> > Add a short section describing how they interact: multifd carries the
> > pages of the precopy phase, the channels are flushed and synced before the
> > switchover (because loading a page in a multifd receive thread is not
> > atomic with regard to a running vCPU), and the postcopy phase itself does
> > not use the multifd channels.
> >
> > Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> > ---
> >  docs/devel/migration/postcopy.rst | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
> > index e319388d8f..570a3a1ce6 100644
> > --- a/docs/devel/migration/postcopy.rst
> > +++ b/docs/devel/migration/postcopy.rst
> > @@ -294,6 +294,32 @@ the background migration channel.  Anyone who cares about latencies of page
> >  faults during a postcopy migration should enable this feature.  By default,
> >  it's not enabled.
> >  
> > +Postcopy with multifd
> > +---------------------
> > +
> > +The ``multifd`` capability can be enabled together with ``postcopy-ram``
> > +since the 10.1 QEMU release.  The two features apply to different phases of
> > +the migration:
> > +
> > +  - During the precopy phase, guest pages are sent over the multifd channels
> > +    as usual, so the initial RAM transfer can use all of them.
> > +
> > +  - Just before switching to postcopy, the source flushes and syncs the
> > +    multifd channels.  This guarantees that all the pages already queued on
> > +    those channels are loaded on the destination *before* the destination
> > +    CPUs are started, which is required because loading a page in a multifd
> > +    receive thread is not atomic with regard to a running vCPU.
> > +
> > +  - During the postcopy phase the multifd channels are no longer used for
> > +    guest pages.  Both the background stream and the pages requested by the
> > +    destination go through the background migration channel instead, or
> > +    through the preempt channel for the requested pages when postcopy
> > +    preemption is enabled.
> > +
> > +Consequently, multifd only speeds up the precopy phase of a postcopy
> > +migration.  The bandwidth available once postcopy has started is the same as
> > +without multifd.
> > +
> >  Postcopy blocktime statistics
> >  -----------------------------
> 
> Looks good to me, I'll wait a bit to allow Peter to comment.
> 
> Acked-by: Fabiano Rosas <farosas@suse.de>

The updates look all reasonable,

Reviewed-by: Peter Xu <peterx@redhat.com>

For Bin, just FYI in case it matters: there's a known bug for old machine
types when both features enabled (with preempt, which libvirt enables by
default), it's still during review upstream:

https://lore.kernel.org/all/20260916213558.587304-1-peterx@redhat.com/#t

Thanks,

-- 
Peter Xu


