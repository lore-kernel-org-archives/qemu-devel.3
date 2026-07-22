Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B3FC44532
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wma1B-0000zp-8j; Wed, 22 Jul 2026 12:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wma15-0000zM-8q
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wma12-0006DQ-DM
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784738509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9SYF1DYLmogVx0/xZqaYFIXFrUmPqPQL+ZYYRwh1E5A=;
 b=T4G2cM2OJGB6UGh4q0WDDO6VhIe8KnTm94gz6yTy2syMPVnnF4Q5JK9K8cClxYVx32gFxu
 F1bvQlCLHFqbWjBwCvSaOqEV8y+GwBzr0jbEjkdxsz2Kxt+AF0R2QjEzcDA+05xhMZyU6o
 9MfPJPM6jgYbH21HCET/rUfLuZTch/0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98--Ac5eQv6PUOZpWD0_T4LGw-1; Wed, 22 Jul 2026 12:41:48 -0400
X-MC-Unique: -Ac5eQv6PUOZpWD0_T4LGw-1
X-Mimecast-MFC-AGG-ID: -Ac5eQv6PUOZpWD0_T4LGw_1784738508
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0408254aso137862101cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 09:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784738508; x=1785343308; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9SYF1DYLmogVx0/xZqaYFIXFrUmPqPQL+ZYYRwh1E5A=;
 b=LmqXrt6XxQIf8swqW576Jf05jA4c4Yb7VERvT5yKusd8il+cHGN7p1bqP+f7a2l4LC
 KL9QGeHxoDNmFOBRHlAsGc9Efas2QE92+BYkfg+N2pUK6Vj1CeQQcHupEIaCJBrT2WMj
 ppHSLKXQ7K9d3KcRqJXsZF4RVl8rAR/fuUVY2XL3aYEs+ibNWQSLIGkwH6wQekWAnOMG
 lIz9TX14Iavb/051T3vGFmwt8YUAXdnUeZihRbYXUpaCnKU7SfL7EaSp6I1DvJ3+5dpU
 u66TkHU2PglrlAMlP5Vc4NjV+M1zl3NzM1oi7JQjIMzQODVUU1K7pdclFyKE5TZcoqb5
 D0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784738508; x=1785343308;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9SYF1DYLmogVx0/xZqaYFIXFrUmPqPQL+ZYYRwh1E5A=;
 b=HnTpYpy/CRIyf8APj8E0cylwJUgRZsVjK+DKLkwlb/BIZGGwMZ5YJmLL0FA2cfTsdr
 X8CtuL2nN8ExPnZD2ywctm7zwo0aYIhG33Xrl2jC9/4lR+zDuASYHBPg54ZDcbeSW+qE
 WME6cd9LBcMrS+GE3rEhuiJxneUMt71GDzPavgKSl42NDR7iI2iTgN6lZXD07rWDuGeI
 Hpv8jWsDKZ3jx25huMFJ/p5mj6gwu6YsWhMmLjMtGc441B5hNOCFTHFFOI4vxycIS0ok
 /Rt9psNu/ss3llnMN7lKtVRpTWCqfggmBbr45I8cBXIf4Jpx57wnWdJZdnthp1UteQlu
 yX2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrURwNCGQCg++WGDWfGY7qBtUOb/hk/5cp6E+GHr0+JNYJZr5TvPM+CNljYSXa8bY609XLoq+ZCYIeb@nongnu.org
X-Gm-Message-State: AOJu0YycsK49iz6/Ig1RhtxL//g0wp8KH10DKYPEo9tdwcfKfHzmlOxa
 huE7i++KcZ+1Cg953/j4gNQKgygB9wfbSHtt3FK6PL8mSknmM6G6ER5b/T9LaMOt584B2L7pRHw
 ipVF6L1nSCN7qd7M+5wbFYPw50/nppb6JcfHlAe/gOsHvMYY8U9qViIZ0
X-Gm-Gg: AR+sD11K4GtF4USNGhlsDeh2il7Kjkqago1iwYiEBRIAKQPOpkMDYDx/fdDjBsK8DXL
 UUuhwf4KQwUzIvWYdzf416PR93cJHbntc+5w6yc/LRfrLq2uFQy44JR218xM+HpV9mMknyljMKr
 BClyn0Jr844DiMA1BCwyf4yNqVLqhdGINsWNMPYn/hLJ9G2JjpERqw+8r3AHePqE0OYH5jtarQP
 JwNI52KFHK1tNvZziz0h+UlI2ljcPQKY2q4mOqQZJLYszPq23b+E6Jm8QnebTkoamNgMvbSwbf2
 L1czjiNlULCswRxzYjsg5eP9jbo40WC+DNJqMBf7ynkRP1S1k37+oqXyIJwJH/VlHXy9
X-Received: by 2002:a05:622a:5814:b0:51c:7aa7:e0e9 with SMTP id
 d75a77b69052e-52838901dadmr14281151cf.38.1784738507695; 
 Wed, 22 Jul 2026 09:41:47 -0700 (PDT)
X-Received: by 2002:a05:622a:5814:b0:51c:7aa7:e0e9 with SMTP id
 d75a77b69052e-52838901dadmr14280721cf.38.1784738507144; 
 Wed, 22 Jul 2026 09:41:47 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-527d1224695sm18839241cf.13.2026.07.22.09.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:41:46 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:41:34 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <amDyvgR09OJssENX@x1.local>
References: <5faf04b9-d596-4a1d-9fe3-5e9ad5f0a99a@redhat.com>
 <73f79841-8cc7-4ca6-8f6b-fb97b53a6fe8@redhat.com>
 <20260717091756-mutt-send-email-mst@kernel.org>
 <CAFEAcA-O6Z4JrVV0DL_tta6khRyUta_Zz5mJt6OszaW1mu0o6Q@mail.gmail.com>
 <20260717095407-mutt-send-email-mst@kernel.org>
 <9c2ad22a-e768-4a07-85a2-01ce1fc14368@oss.qualcomm.com>
 <59882c5b-545d-4768-8bf4-723fed97a801@redhat.com>
 <al-eCtxGjG4HHEbl@x1.local>
 <6210e178-a93f-4411-810a-41edb1fb656e@redhat.com>
 <20260722015422-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722015422-mutt-send-email-mst@kernel.org>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

On Wed, Jul 22, 2026 at 01:58:18AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 22, 2026 at 10:53:27AM +1000, Gavin Shan wrote:
> > On 7/22/26 2:27 AM, Peter Xu wrote:
> > > On Tue, Jul 21, 2026 at 03:37:53PM +1000, Gavin Shan wrote:
> > > > If Peter is fine with two variants for x86 and non-x86 architectures.
> > > > I can post (v4) for further review. That will be something like below
> > > > and let me know if there are any other improvements are needed.
> > > 
> > > I have a generic question on the "unaligned access for x86": I think the
> > > question is about the one Michael raised here on unaligned access may break
> > > x86 here:
> > > 
> > >    https://lore.kernel.org/qemu-devel/20260617022330-mutt-send-email-mst@kernel.org/
> > > 
> > >    3. (theoretical concern) also on x86, unaligned accesses are
> > >    possible on guest and host, so converting an unaligned access to a
> > >    series of aligned ones can in theory break devices.
> > > 
> > > Is that a real problem we need to consider, or can we start with unified
> > > approach and leave it for later?
> > > 
> > 
> > I'm leaving this question to Michael.
> 
> Knowing what I know about hardware designers, it's something someone
> somewhere does)
> It can be made a separate patch, just to show - it should be all of
> ~10LOC.

It's only about removal of anything that might be controversial for now,
thanks.  I also wonder if anything would break, then it's more solid proof
that per-arch change is required.

> 
> > > PS: I apologize if I missed important piece of info along the way; I didn't
> > > follow closely on the discussion on this topic in the past few weeks.
> > > 
> > > One thing to mention is, what we change should only need to affect
> > > ram_device, AFAIU.. so most memcpy()/memmove() shouldn't be changed for any
> > > arch when it's pure RAM.
> > > 
> > 
> > It depends. This patch intends to fix issue [1] in the lower layer by using
> > the newly added accessors (qemu_ram_{copy, move}) on all directly accessible
> > regions including the regular (pure) RAM region. Otherwise, the newly added
> > accessors should be limited to ram_device regions only as you said.
> > 
> > [1] https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn/
> > 
> > Thanks,
> > Gavin
> 
> using memcpy()/memmove() to emulate guest's atomics is generally
> kinda broken.
> but yes there are architectures where doing it to device ram is
> more broken than doing it to regular ram.

If we keep memcpy()/memmove() for len>8 (aligned or not), I am thinking no
perf issue will happen, then looks like we can indeed change this even for
pure RAM operations, which we can't identify in case of e1000e driver use
case.

Then does it mean we should not use __builtin_memcpy()/memmove()?  Even if
we know constants 1/2/4/8 would work there, why not we go ahead and use
qatomics, which is even more future proof?  I also stumbled on top of
commit 77b1757090 ("include/qemu/bswap.h: Use __builtin_memcpy() in
accessor functions"), which seems to say the same thing "for the long
term".

For "should we still do unaligned access if the guest did it, so as to keep
the original behavior of a bare metal" question, are we on the same page
that we should just break it into aligned accesses for all archs?  I think
it means, we will not be able to emulate guest faults correctly as what
will happen on bare metal, but we're missing the fault injection logics
anyway, so whenever it's implemented we _could_ switch it back to unaligned
accesses.  Before that, breaking unaligned seems like a better way to go to
(1) satisfy all legit users, and (2) don't make QEMU crash by guest
operations.

Last, one silly question: why do we need any helper named with *memcpy*, if
memmove is always superior (to consider range overlap)?  Can we stick with
memmove all over the places?

Thanks,

-- 
Peter Xu


