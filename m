Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5620BF4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgPJ-0002jr-3f; Fri, 17 Apr 2026 06:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wDgPH-0002je-D1
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wDgPF-0003dc-9m
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776421595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NWPvD2YSdIKV0X6XHEiHW+bfj7Ed1q4U6gsijBt7fkg=;
 b=FJvZEMKj8heOq+/8pLdG3qffzS1nDpeByWxFFfZIZMyqVmE7tn7vo5ubdH+/isib6Pgkec
 FaTf9+2SB18sACgPFKqJ9ko0gwb1qkBlnjidKAfFZQxo6yUlGu+TQJ94yJryCjWjcp2GQm
 csL7uwM8kAPdd3u0suemOCQMNuCpIp8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-IO-_N9SxNDm394H3d_GP2Q-1; Fri, 17 Apr 2026 06:26:34 -0400
X-MC-Unique: IO-_N9SxNDm394H3d_GP2Q-1
X-Mimecast-MFC-AGG-ID: IO-_N9SxNDm394H3d_GP2Q_1776421593
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43d705eaa64so589944f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776421593; x=1777026393; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NWPvD2YSdIKV0X6XHEiHW+bfj7Ed1q4U6gsijBt7fkg=;
 b=SbT1Bz8UQ4JBq1u8IquotV2RNBDB0bnalKXU3Yin+SYQ5yGtvp6R9Mpgje8GyOHbMt
 k6kc/glCP11V9XGv/J14a19LMmRgAmtWWL/hJiyWQXuPAa9AllxWYWfqPn0/7VRzDRhI
 vHHmwLYMI0zvnO70zz5AWa9KYPPlx4f4VyRD5eTuO9PNyhZEVLWX1EgonC0xJR85e6pc
 LoVBwHZz9kYuJYeLS9OXypsyvYE0zCV/Q+KxaQV+Ro3a5iZ3+q+4yfpR1fGVlfXNyBII
 IsziPB7IV6dSS0tPvIa4PgnQd4Rd4odOX7SCooLhVI9Tn+igeTvnmnPjOzIm45CcQGIE
 x4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776421593; x=1777026393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWPvD2YSdIKV0X6XHEiHW+bfj7Ed1q4U6gsijBt7fkg=;
 b=ZW7AFfRPDKMyglUM5ZbNTy5UaHFnnMs4z/do/VFa2rQIoK5AIUvoPs72CnyvDv1d1H
 IdCld9G9r20EhkBZ1HhHSp8uSDSZlHnO1Ica8Rq61HH4PbBHrynQzS8tJuWpDDlI7opj
 COxUZjloi6szJt54852YV3TXyjNTp04ib86fPxukuOMVfwMWACA+gmSenqmf7DcpTdCz
 RmYX9PmU4yJPxfMAwsNLAD374IoydcZT8vgwozzIWMj6lQG2R7V6znilD/yxQKmB3lII
 HPGAVn7Ced7cwWbUNCdqcwJiROvBbE2FHuSsyOXLPAwP0RAiCDdQdJEiEK5pZIfp+pm3
 hFRQ==
X-Gm-Message-State: AOJu0YysUOlUJSxub4ekBzr9tAqXa5QdySgp2QEOC/Fe4xcA6u1L9VCz
 7wGA0aqc8Ye6ct1Ac+QyvAiY8k+TrLzGaOUr2fGL5UbhSA0yhjSbdmk/zG4Bn/ApKobOz4yyvVp
 AFRMsqQRBBq9pK5FcDUHDrPsI5W6GlbQpO7q8aQjER/dQumEFdaeFNS83
X-Gm-Gg: AeBDieubzDcRwrgVBTNXUzxVCrgeNZiwjYIdWokqpyouOUQkQBnNtvuDUYqw66TGni9
 LvVcyOM298uxFlkl0/gzuz1gBNZDrB2yfh6nluB1h/wpjh2Dku9pvwLRL06Vk287Kopua3n3Kb2
 neOx64k2x9t39e0nTC9bbqGmn5ldOoQ0mg0QrdbQSYUqpi3ZKyYAVlcsYCHGUnYebdegktAGgbH
 WL5iz9BV6pGJth9ikbtaCQ0hzD8caY0ufhIGV1UbyKgQxltiWgRxu5zO6nNER8cl4/87QTbZ90n
 o15SafU6HXFQ6ylorEqwonp76XlxnHrV6yMj9rsneIC3bjxjh8DP+G7sw3eA/NTz0oyQM/0zwAB
 2YnUloOfBBLIr
X-Received: by 2002:a5d:5849:0:b0:43e:a8ad:975e with SMTP id
 ffacd0b85a97d-43fe3dfbedbmr3363558f8f.27.1776421593248; 
 Fri, 17 Apr 2026 03:26:33 -0700 (PDT)
X-Received: by 2002:a5d:5849:0:b0:43e:a8ad:975e with SMTP id
 ffacd0b85a97d-43fe3dfbedbmr3363498f8f.27.1776421592737; 
 Fri, 17 Apr 2026 03:26:32 -0700 (PDT)
Received: from fedora ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4dc26a3sm3683084f8f.15.2026.04.17.03.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 03:26:32 -0700 (PDT)
Date: Fri, 17 Apr 2026 12:26:29 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Joao Martins <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 08/14] migration: Make qemu_savevm_query_pending()
 available anytime
Message-ID: <aeIJt7j7BiiwuITG@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-9-peterx@redhat.com>
 <adfegWEjLcGmDTPi@fedora> <aeElO8Wkkbqh439l@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeElO8Wkkbqh439l@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Hi Peter,

On 2026-04-16 14:06, Peter Xu wrote:
> On Thu, Apr 09, 2026 at 07:15:28PM +0200, Juraj Marcin wrote:
> > On 2026-04-08 12:55, Peter Xu wrote:

...

> > > -static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
> > > +static int qemu_savevm_state_setup(MigrationState *s, QEMUFile *f,
> > > +                                   Error **errp)
> > >  {
> > >      SaveStateEntry *se;
> > >      int ret;
> > > @@ -1409,6 +1410,13 @@ static int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
> > >          }
> > >      }
> > >  
> > > +    /*
> > > +     * Logically, it should be paired with any hook being used who needs to
> > > +     * load_acquire() the flag first.  So far, only save_query_pending()
> > > +     * uses it.
> > > +     */
> > > +    qatomic_store_release(&s->save_setup_ready, true);
> > 
> > What other savevm functions would benefit from this? Would it make sense
> > to include them in this patch/series?
> 
> I don't yet know any other hook would need this.
> 
> AFAIU, the rational is most of the hooks should only be invoked in
> migration_thread(), where it's always guaranteed that save_setup() is
> always done before hand.
> 
> Here, when we make save_query_pending() to be more flexible to be able to
> get invoked in QMP handlers, then it opens the races and only that hook is
> special.
> 
> We actually have another option, which is to keep another cached variable
> for global remaining data, then only update it in migration_thread().  Then
> it will keep the rational as before.
> 
> But then that var will only be used for this purpose, and I thought it
> might also be confusing: remember that we have per-module counter caches
> already for querying the remaining data fields, like what RAM and VFIO do.
> 
> So I chose the current approach.  Let me know what you think.

I agree with your approach, I was just wondering if there are other such
races that are not handled yet. I don't think anything needs to be
changed then, given that only save_query_pending() is susceptible to the
race.

Thanks!

> 
> Thanks,
> 
> -- 
> Peter Xu
> 


