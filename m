Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACDBC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx37l-0001Bw-Fx; Thu, 20 Aug 2026 09:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx37j-00019R-33
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx37h-0001Ep-Br
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787233679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZnIdUZ58dNT8SG5pxMHfzRVuOZvuP8wyDJYgoasZoN0=;
 b=AZmWdBEft6s/P5kAhMZteYuFx2a+R+tlFK2iFfIVc/lup6YsepcdupGVHHTzexe9PI2Cl5
 SjIMMOSdJ+iwWlXGo1eOoJE1i0bIH2UUQai+Mtj2vEBlMqYyfFUNmnGhAh/s1ONRJFHNfD
 fKb7aemqPYe2tXB0F8QCmlESCrp4ET8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-_fIgc6xpNXChu3ch8U4XHA-1; Thu, 20 Aug 2026 09:47:58 -0400
X-MC-Unique: _fIgc6xpNXChu3ch8U4XHA-1
X-Mimecast-MFC-AGG-ID: _fIgc6xpNXChu3ch8U4XHA_1787233678
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9368f2b7b2bso240050085a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787233678; x=1787838478; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZnIdUZ58dNT8SG5pxMHfzRVuOZvuP8wyDJYgoasZoN0=;
 b=qKK61bTF3Der8bpoE8nlZZyFNyLdEPieQOJaeujq77zVweBWz+SJMy9+XppLO1zfI7
 RdUac+e9csT9hmPn8VTk7CzAnAZrps8p7suNd7lKW0C6zju1pnC2k1uZR6b9B1E9Zrhv
 6eW+dTlH940xwNFYfzhLNg1XCpPqJcARYv2JqSCfvCZy8N0ypGhyejoYtG7aU2BA5NP/
 3fuxJqrinoJB0fqatwEk4BxVRPqgwvvccK/jOdX7n3rZ5zReY6etFaJzLvXC0AotCLsj
 BNLY1XttW8ihc6EEaf+wOMZ8z0ldxyeEJK3SvXDZ7s08hHEI74NtiAmZLzKOrUkXGCs5
 M2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787233678; x=1787838478;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZnIdUZ58dNT8SG5pxMHfzRVuOZvuP8wyDJYgoasZoN0=;
 b=cWgD1m4phZy+m2VEnKUwkHMuiu4WoVdasoOcRzHdnMDWMf4byJ1jtRkV7TdxarDsmE
 SU9gyOs0gEH9OghS4dRbM43Skd6h5EbNRxo+g9W9iFeVdu/Qa4OjOLRb6YSALdBvcw5x
 1NCiqS76tpSCIofTQO1utfv3vz7/6LgJXQGiN01XU9s446DwwhCi/dpxsaAX9xjMqoF8
 MvPL352+Dt8IMoktMAm1rdnfo0Um1R10Ds2CFEobPZGougfNQC/OZlArJC8HFdYS4Mm0
 d3rWHuwviIC5wrotTtcABFLC1quC2KzX3q3RDTKGTlS+4tS6dqJvzX9DqrQv2CrJofBD
 k1aQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6ce6jpXGwEPg7W0m1MZoiZa6DFLXrrsV9LkQR/9FMt1c5MSl+1wdKXTPaNOdQOUa+kSP/Y8wd3I+F@nongnu.org
X-Gm-Message-State: AOJu0YyWltwtlGiF3EA78Nav/LIXyhs089ODNLUIlf+orV69b+RBt+mT
 C2xL6teAZMDqdauwZQB6BkfabUJ9x7cGcU/nsEN+pDCYPZ+SGhwbM/j6G44yL+Pe2tg6TMudZL3
 D9JOcztVkhs9NhCbuvjaEtH2yWVV35XQ7Njz+Zy1Ja1UdQDFv5nkrpVUk
X-Gm-Gg: AR+sD13QlfP2uFoADjzHjGd6VDN+l5OpqH66i91QaXmZCFUg8sUAGmxZch7DAaA0NdJ
 mdUb5QMyuks+N5YziY0jJy/Rg4VTXVODPaYCAsqUC/d5DeH9cQxWogj+f6gYaDzM2A6/F489vuU
 wovVF+qPDKPp5h02bp5SGAXPYz0XkLRLi+CLas769IgzwOWO+elkweX7BQCv8oztxc8RxLwe3J0
 bCIASu6pOb1FKoCE7RtxMcauj3JLP/h5JhzqkBA+onnZwdkRVOIKfgfWSgMb+iB3WwMUoiBiKX6
 6aOWtMP+he7BWoV/BVmpBFBpvsVTLrtytTXNYE/AzhhIalLYl4pI+YQ1sF5fnaoqrjJtXQ==
X-Received: by 2002:a05:620a:839a:b0:92e:7ba3:73e5 with SMTP id
 af79cd13be357-9371e670fdfmr1258132285a.42.1787233677741; 
 Thu, 20 Aug 2026 06:47:57 -0700 (PDT)
X-Received: by 2002:a05:620a:839a:b0:92e:7ba3:73e5 with SMTP id
 af79cd13be357-9371e670fdfmr1258125885a.42.1787233677213; 
 Thu, 20 Aug 2026 06:47:57 -0700 (PDT)
Received: from x1.local ([2605:8d80:6d69:ab3b:879:1f7:4951:97d9])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2a35basm38335776d6.35.2026.08.20.06.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 06:47:55 -0700 (PDT)
Date: Thu, 20 Aug 2026 09:47:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <isyanfei.xu@gmail.com>
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, qemu-devel@nongnu.org,
 farosas@suse.de, lizhijian@fujitsu.com,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 3/3] migration/rdma: Retry control sends on full queue
Message-ID: <aocFifqrtiv900Yr@x1.local>
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
 <20260817105117.3072040-4-yanfei.xu@bytedance.com>
 <aoYBhxpSL5w5gQcX@x1.local>
 <80b1c870-308f-4de4-ad53-c9ecfc91da24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80b1c870-308f-4de4-ad53-c9ecfc91da24@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

On Thu, Aug 20, 2026 at 06:27:12PM +0800, Yanfei Xu wrote:
> Hi peter,
> 
> On 2026/8/20 03:18, Peter Xu wrote:
> > On Mon, Aug 17, 2026 at 06:51:17PM +0800, Yanfei Xu wrote:
> > > RAM writes and control messages share the send queue.  If
> > > outstanding writes fill it, RDMA writes drain a completion and retry,
> > > but control sends fail the migration.
> > > 
> > > Drain one outstanding write and retry the control send on ENOMEM.
> > > 
> > > Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> > > ---
> > >   migration/rdma.c | 12 +++++++++++-
> > >   1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/migration/rdma.c b/migration/rdma.c
> > > index 6e8436ccc1..d1f44a5f55 100644
> > > --- a/migration/rdma.c
> > > +++ b/migration/rdma.c
> > > @@ -1572,9 +1572,19 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
> > >           memcpy(wr->control + sizeof(RDMAControlHeader), buf, head->len);
> > >       }
> > > -
> > > +retry:
> > >       ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
> > > +    if (ret == ENOMEM && rdma->nb_sent) {
> > > +        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
> > > +        if (ret < 0) {
> > > +            error_setg(errp, "rdma migration: failed to make room for "
> > > +                       "control send");
> > > +            return -1;
> > > +        }
> > > +        goto retry;
> > > +    }
> > Looks also correct, but two questions:
> > 
> > - Should we provide a helper instead of duplicating the WRITE op handling?
> >    I believe only WRITE wrids can be on the fly.
> 
> Yes, control message is syncronized, only WRITE can be on the fly. A helper
> is a good suggestion. Will do.
> 
> > 
> > - Could ENOMEM be returned when nb_sent==0?  If that check applies to WRITE
> >    path too?
> 
> ENOMEM can be regarded as SQ is full to RDMA usage in qemu. Actually ENOMEM
> is determined by provider and could have other meaning like
> inline_data > qp->max_inline_data in mlx5. Based on qemu codes, I think it's
> fine without nb_sent==0

I'm not familiar with mlx5 impl that you're discussing here, but IIUC the
point is we should be able to capture all recoverable faults and retry,
meanwhile we should fail immediately on non-recoverable faults.

From the name of the errno (ENOMEM), I expect non-recoverable faults can
happen with it.. unless this is something special to libibverbs to
explicitly imply "queue full"..

I wonder if it means this nb_sent!=0 check should indeed make sense, but I
also wonder if we should add a number of retry so as to capture real ENOMEM
errors otherwise that is not recoverable?  As long as it won't keep
spinning with the same error then we should be good.

> 
> In addition, I encountered this bug when I attempt to send dirty pages
> belongs
> to same chunk in parallel. That could more efficiently utilizes throughput
> when
> many scattered page in one chunk, and quickly exhausts SQ's WRs. Will post a
> RFC with more data.

Sure, I hope that still makes sure different versions of a same page will
be still ordered.

Thanks,

-- 
Peter Xu


