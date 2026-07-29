Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D29EC54FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 22:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpCSB-00089m-CB; Wed, 29 Jul 2026 18:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpCS8-00089U-LZ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpCS6-0004zP-O8
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 18:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785362917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lK+/jF54pCNYivFqRHvaGkLZjZo51InvpvYpWbPOvec=;
 b=VBNKwbStKsNSvTYwzHpvqOtwbuW4QT91A0RB9s4113vZ7AaKsX0sdIebo6DJi6cptPqioP
 wdq/yBcnftnKkFf1dfY+ywxQgxvzB7dv95aTe9E4iX5xa0BcMWjIFbUUSICorTFgZG0hBG
 UuWSgh1uvF9GBpOzQuSwcjUYyZgWTLc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-dd7jWMLVPHqBxyGoCp3qCg-1; Wed, 29 Jul 2026 18:08:33 -0400
X-MC-Unique: dd7jWMLVPHqBxyGoCp3qCg-1
X-Mimecast-MFC-AGG-ID: dd7jWMLVPHqBxyGoCp3qCg_1785362912
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c1f548718d0so193205566b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 15:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785362912; x=1785967712; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lK+/jF54pCNYivFqRHvaGkLZjZo51InvpvYpWbPOvec=;
 b=aoYhUzIaV0EI9j3llARdKTs2CU3i1wdJETzfS9LKQ8hveFHnYYRKAnuDvYAe8yI0+Q
 UjcY3dFWzxzlGUD7odjI+ThbmpolZ/d9AiT9YcVWl1eVd6VhxhUq7KRcd9gB73K47Hdj
 zKpG+L/oO+umt1zXw10E4gSFFOZAsvYF9SQNUZsQL1JE0300ECiikH8ARkbgZ7xQL4jw
 mwSCz1lEaMLHJPqmx0oS/QBwdjI9byz+SCAj43CNHYAYLDgipnrjExgDK73cdlAq+CMa
 GOA1JDRr/1p29YwsCjmtfDSha2KaNKo8GlUYMKaxDmsGXVD63OWKBbDDMVIPl7Q3zsF2
 1mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785362912; x=1785967712;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lK+/jF54pCNYivFqRHvaGkLZjZo51InvpvYpWbPOvec=;
 b=PdSF6l+glXWAhsfYJF/sYs8rajaYJOZJKy6o0Qb5vcwvK7p7IkQNr2a9WfYOZM00rc
 FB2hGahBbg4eZ7W/V376R5MIltrKl6Jmn3PRdvfVU/q6r7MijqAfTr2YHm6MggXXRbIp
 O1s1O42I7y6Ms6loqkWgItKB45g0wfEtWDmPQ6kivAPc0CMX3ujR4ZetPz1dogSfZ/ut
 Ihe3h8cciSQpW8VdoSam4Hs974okD3eP6hznsEwGsZ9vH2ll7wsg/WBNOmol7RRNpRYs
 ysmr6BgLq7gh5XXoI5WrkoNNxrDUcJv0Zd4Kyov1fIYm3Hv8Y7UePvXoXkjWebof65wx
 kprw==
X-Forwarded-Encrypted: i=1;
 AHgh+RohMKMxv7zY/ioYeGkZ6svjO16VDDCFRLUjhtx6HqLa4dFs8LBBRn/n90uqpDbDNwOetK5k+fgVOMc4@nongnu.org
X-Gm-Message-State: AOJu0YwOsiSx/DOEtBcwj57caGtunm1F6BJJRkeeDmPcF4iPezKuKdHK
 6c+LQ6Brvi/0d1ZDGoisC03iEn8PNM4u82Wx79lLmHTdOVNjd3KzQupZIHTs053+XLhEqU/WOmO
 8Q+ogDaBNbwHSw51f3Eno6RhXIlNxLBGhur2Ay+Q7Oi0izWv1lLL/vKgw
X-Gm-Gg: AR+sD10sR2xJ5mMvUiITX4S+DNiGiqOYV8M2hhqlpcU10/reZU70uCS2IwGGIUXO/nG
 +nUyCFBb8LIeSvNRlqKHTH3XQnF5Bytlt9VFDQkoN5bN7ZaX1xJVfA/MjSKdjs3EDGierH7UYfa
 ww5/mB4CBgIOXY1wJqsZzR73wscBDi27ZiyoFFjiEB6+tilzFvTO2ZYEhm9ORVqVL6TY8KqSb/u
 ifi4fuoR8v5Em+mOIfGQnf5LUn6sSFvES9joYIbZdpsCdtl9OWqJ9yjlFDU6QSxuu9dZDU+v/45
 qA17TkWYHfX/cwrxWJq7Nvkc5F06naYPuCVjkmqlKB7/+QYkPOI3i6ayKnODpJiWStQ2QQ==
X-Received: by 2002:a17:907:961b:b0:c1c:3b06:ed24 with SMTP id
 a640c23a62f3a-c1fa5671767mr11114466b.28.1785362912230; 
 Wed, 29 Jul 2026 15:08:32 -0700 (PDT)
X-Received: by 2002:a17:907:961b:b0:c1c:3b06:ed24 with SMTP id
 a640c23a62f3a-c1fa5671767mr11112766b.28.1785362911656; 
 Wed, 29 Jul 2026 15:08:31 -0700 (PDT)
Received: from redhat.com ([186.247.166.223]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f83cde9cbsm165650266b.16.2026.07.29.15.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 15:08:30 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:08:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <20260729180727-mutt-send-email-mst@kernel.org>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <87jyqeomqz.fsf@suse.de> <amoHbVsgzkYclCt2@x1.local>
 <878q6toopr.fsf@suse.de> <amof2Vbn_nTHR5H9@x1.local>
 <875x1xojtk.fsf@suse.de> <amo86cXLNE2uV6Ge@x1.local>
 <20260729145247-mutt-send-email-mst@kernel.org>
 <ampUBV4wAluFGW93@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ampUBV4wAluFGW93@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Jul 29, 2026 at 03:27:01PM -0400, Peter Xu wrote:
> On Wed, Jul 29, 2026 at 02:57:57PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 29, 2026 at 01:48:25PM -0400, Peter Xu wrote:
> > > So to me, it's much simpler we say migration stream must be
> > > trusted, and I expect dest QEMU can allocate any buffer it needs, until it
> > > eats the whole system memory.  I really don't see much real risk..
> > 
> > It's not risk due to migration, specifically. But making qemu
> > drink up terabytes from the guest would be problematic, right?
> > 
> > Putting qemu in a cgroup with restricted total memory
> > would be one way to prevent this class of security issue,
> > and a robust one.
> > 
> > But that, in turn, is impossible if qemu insists on allocating
> > unlimited memory at the drop of a hat.
> 
> Just to clarify at least one thing.. we have two attack surfaces here and
> they're very different IMHO:
> 
> (1) guest behavior caused memory allocation, or,
> 
> (2) migration stream caused memory allocation.
> 
> AFAIU, (1) is more severe. All my points only apply to (2).


Absolutely. Yet without fixing 2 we can't mitigate 1 with OS level
protections.

> 
> > 
> > However, migration is hardly the worst offender here, and I am
> > not at all sure we need to start with it if we even want
> > to address this limitation.
> 
> Agree.
> 
> Thanks,
> 
> -- 
> Peter Xu


