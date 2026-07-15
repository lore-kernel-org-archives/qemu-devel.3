Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F5FC44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk663-00060A-7N; Wed, 15 Jul 2026 16:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk661-000601-T4
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk65z-0002BS-H1
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784146841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4F1vsQcSa+TUS5VNkFwhZ38EJ+drGYLf14qmF3xMO5U=;
 b=YNAr5c589/TusxwLQ1UzekE+DC7KzyShM3xxW1Ql1FZHlHlcYRqDWgqc21Y8vUJ9q4x6+3
 SYdkOsuobiSVze3AW+blfpMtPcuckEEgvnq0/eIGlyS3vBKCAuH4KK9w8VnQxcoZvqKryD
 9tkP2SJcfdfI+qu3/K2S0CbAnV7+k+s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-qYAQcyFWO4iP_-Dkuk3Low-1; Wed, 15 Jul 2026 16:20:40 -0400
X-MC-Unique: qYAQcyFWO4iP_-Dkuk3Low-1
X-Mimecast-MFC-AGG-ID: qYAQcyFWO4iP_-Dkuk3Low_1784146839
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4926596eebcso17893385e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784146839; x=1784751639; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4F1vsQcSa+TUS5VNkFwhZ38EJ+drGYLf14qmF3xMO5U=;
 b=Q14i+4EhF8XgOkRuYGIgyTH7b+mQE7iC+kJS2ktQmvkIjsN70CrLoWbxHFXqFHgNCt
 vprw87Sjm5Ri8EQbR/U+JMNuyAj26HAHuagq3FAYzYVuKTz2N0qR211HFIKgEsU4V4x8
 XVzZHq6p4zfQav/atAumERsznTL6yxxAOf+FPW1Ntul0hf93s9Izgm/deZz1QvVEXH/Z
 Sfv2+NJepEDqR/snk5+s4aK1adN9BnCXNIxN553MzR1V4tHTSWaqDiw2EpEAi21BNczC
 dgmmnmoTEWivVuikjPgJ16yHxOXT0+6u8I+4rV0mP93Srz3htUihfOSKziSrYjZrbtf+
 RaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784146839; x=1784751639;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4F1vsQcSa+TUS5VNkFwhZ38EJ+drGYLf14qmF3xMO5U=;
 b=KvWFYG61cyewizRuKRkpABjwsfz813ASECjCH6tW6FtqmewLOPWXhxLg3Jus0LilhL
 QHBmuKgo5rqTh5DPS8ZZusAtdWMtwKmNV1MoPiwp3VCh9nkHwus+eiMDOz4sZPS14zdM
 Pel/rMqLcBiVATLCbJurl5UbDHvP/80urh7vQxp8j0eHx7UYwODzi09TW+RNXTrzW8GR
 pfjwUEVDnv8hxKjvMCfSX07IqvXxL2JlRns4zgeTRkXFCqowVzEUyxZTalb7MU1+5Mx1
 GscoIb9zUCwTy4I3PJzDdACle0041RghpAh38eS4P1Dg0arkd+kHH6fG7pgFAokOzMb5
 sy8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RorGbesDy7zOVt9FcbVAMUSLrlUZ/PK7s+flhfJ8TcZCqawY2QYf80yZIrxoATrz5rGacYelj/y7F1X@nongnu.org
X-Gm-Message-State: AOJu0Yzw353+C+y+vy8ZJPbYroSpZQUQ87upBWOjsQTEAQvXelA56xth
 Ktd0ubnyWM/0mmil9OMFxjQt5WwxDfyhzYaH645ZPiAhXBNQ+ZkjpqXZA/E1JxK6DQBZLoBuhzP
 helLwY085OlFfuP7HJPJB8lgscsnqTZOzVIHrA5ZVlMnSz6BWcgTb96qh
X-Gm-Gg: AfdE7clVmaf55L5LnS4sEVkVFyStfONV4VxETwHzn9wMXZUwA9Opa3jeyvrY/8+37hk
 0ckiDNta1wVljdq0EvSiLIk+RIdRJ7HTodLzYymMN9+aES1IMs21B2aTKMO+YxVdMlKHdXe3fyh
 aG9dAaI76jW46asl46bduncFCVZ1KSp22vGzNFUPWbvNNdcAFv9T12MgBVBRBPiHmjbiwCesrGP
 09j5aO98pHPGNPSwX+ZS+3sdWiabEfkEpFeEbvgFi9yQkX31aXNpGq1tuk0agzyKu18J8sLde2M
 7bmLKuDalVI9gekVRUxzeTq9z29+q1hlQzdBKjLePcgBOyQLGPsb/mPkIvPniGo5b/BXqNHUotG
 JcZcXsRR7eaKp92hwzsVYlgH3q3IJUcomDP0=
X-Received: by 2002:a05:600c:4e4a:b0:490:bbc4:76a6 with SMTP id
 5b1f17b1804b1-4951b64c7f2mr103343345e9.21.1784146838788; 
 Wed, 15 Jul 2026 13:20:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4a:b0:490:bbc4:76a6 with SMTP id
 5b1f17b1804b1-4951b64c7f2mr103343045e9.21.1784146838283; 
 Wed, 15 Jul 2026 13:20:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635082csm18919423f8f.7.2026.07.15.13.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 13:20:37 -0700 (PDT)
Date: Wed, 15 Jul 2026 16:20:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Michael Tokarev <mjt@tls.msk.ru>, jasowang@redhat.com,
 armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
Message-ID: <20260715161756-mutt-send-email-mst@kernel.org>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
 <7453c24d-7daf-4dfb-9e16-0d6f4e1f6d76@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7453c24d-7daf-4dfb-9e16-0d6f4e1f6d76@yandex-team.ru>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 15, 2026 at 11:10:28PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.07.26 18:01, Michael Tokarev wrote:
> > On 14.07.2026 18:42, Vladimir Sementsov-Ogievskiy wrote:
> > > Hi all!
> > > 
> > > Here is a migration for TAP net backend, including its properties and
> > > open fds.
> > > 
> > > With this new feature, management software doesn't need to initialize
> > > new TAP and do a switch to it. Nothing should be done around
> > > virtio-net in local migration: it just migrates and continues to use
> > > same TAP device. So we avoid extra logic in management software, extra
> > > allocations in kernel (for new TAP), and corresponding extra delay in
> > > migration downtime.
> > 
> > This is quite a big patch set,
> 
> You probably haven't been following Steve's work (about 5 years) on
> CPR Live Update :) My patch set is small.
> 
> > - is this really worth the effort to do
> > all this just for *local* migration?  What's the possible use case for
> > this in real, - am I right this is just about upgrading the host qemu?
> 
> Exactly. You say "just for", but actually local migration is a lot more
> "massive" operation for us. Remote migrations are done mostly to release the
> physical server for service/redeploy (you should first migrate all the
> vms to other servers).  That's a relatively seldom operation.
> 
> On the contrary, when updating to new QEMU version, you migrate _all_
> vms on _all_ servers.  These (minimal) downtimes affects all the
> customers, some are sensitive to freezes.
> 
> > And with that in mind, isn't it sufficient to use what we already have
> > (namely, create new tap, start new qemu instance, and migrate the usual
> > way), and tolerate some very minor downtime while the networking code
> > learns the new network topology (isn't it happening almost instantly
> > anyway, and if not, the management can help by sending gratitious ARP)?
> > 
> > I wonder what's the use for this at yandex?
> > 
> 
> This series together with similar about vhost-user-blk local migration
> gives several times win in freeze-time. It's significant for us.
> 
> -- 
> Best regards,
> Vladimir


I believe it is.
But let's focus on what exactly are we saving here.
It is not that clear.

Is it the overhead of tap losing state such as
bridge forgetting the tap mac. Or what?


-- 
MST


