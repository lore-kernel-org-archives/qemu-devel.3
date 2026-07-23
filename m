Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA4BC44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmmXu-0006Bn-GD; Thu, 23 Jul 2026 02:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wmmXs-0006B9-M5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wmmXq-0005gh-7T
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784786672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=niyOg9VzPAiSo40vNvHu9tZil6B9O1QeQyKulBHn0B8=;
 b=Q7wXgyAC54OVmaTftbd+JfHJ8pUwswU0M2XbDZMVpHncjQguCElWafsptMUSA+N8zK8qQW
 pVSqw2qHjQVTr38yLaP+zhY5rEyJ0vAM6xGUHGhYoKONjb9wxM40HfU1Xyg3ZTX58LJYqv
 Agf6/1gl9Q1+cdP8BGIRUcMmc76gfIQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-ZcE3hbugOaq_XI-EYZHuCA-1; Thu, 23 Jul 2026 02:04:30 -0400
X-MC-Unique: ZcE3hbugOaq_XI-EYZHuCA-1
X-Mimecast-MFC-AGG-ID: ZcE3hbugOaq_XI-EYZHuCA_1784786670
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f83450a8eso233778f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 23:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784786669; x=1785391469; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=niyOg9VzPAiSo40vNvHu9tZil6B9O1QeQyKulBHn0B8=;
 b=ro52uYQ2jq9XWmlccNian7o40wIqoc9aDKOPKUgko21tM4Fax6MoK7e3iYXOD9vrvg
 NbesNQ4XYdYLYbjo4v1GsYqdK/pu8E8cs2qUjN+uTSY68FTcG44fhcib1NmkvPZfAOpq
 1ClI/+rSA01fpfMOi6umyaYfZHDvA2+PgMnTTNOospCCG+SWM07QKba3b/qcx5H2Ttp3
 XQaIZw/BwTWnPViwgxZ1BbMRr2Vq3+tR4EaFzbEkfPLJhOfkUNQDmC8s8mFh81jSDc6x
 Qlyvx16KZfvddLuwGg6wvmRxN8ASzVBIYxLtQVqRD3h6rj/TgUWmbZHUsFYXoUEKUZTO
 pTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784786669; x=1785391469;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=niyOg9VzPAiSo40vNvHu9tZil6B9O1QeQyKulBHn0B8=;
 b=Hpc7CJsMnQDYDswSDfstP6GzRPpzgTRffYquH4fz/BPP/3zJkN17qDmGukzeHI/TaY
 8IcdJ5bZgHC8GTKU79JAI6rPyp3sVM4OEd1Ksdtw5xEv4f7yX2ynzNuIyIF1B1Mo2acn
 BzxLWD9VmURixIQYhy8o5Br15iuSrbct1O1EjymqI4pgDiMbrzjzaB/bPtIrdQnIRRZt
 Astj90+sQnPVHFsHXVYIYom98OpZRg8BHUWTY0jjoh9Bmms9fr32GQ8s/lP1KrA/K+Fr
 ViWaoUev17SAOPF1IR66Q95prQ7a6baAOEL7a7A7HpdMrIXMBd6G4Eccq85uDdTRrO/s
 c5hg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHBNvgDNuygTIgJAcnUureOn8EWxfObJBE6aeRZ6mqHX59TOA3VwF/svomx6hH8GwkRVDG5UeLQf+6@nongnu.org
X-Gm-Message-State: AOJu0YzQEER8Dlu2D9UsjIl6DjTZpeO8ZC15R0EbSuAruY+MvvahoaH9
 sA6qi6F0sG7oBGQtzZUIqUuUYiJUQ5c9vAWPa62TtvaCLEM3u5MhOWoGT8zm0JErj0HK+hfQkAn
 mfrX8bNCVeuslbLj/lpok+lekK9YIXBWNTRPhZReS2woxsL7bQnV2aveP
X-Gm-Gg: AR+sD13/toFmhEifH5iRVcaiHrvwMrzDkBTEyP/I3I7eopgSSHzQsRUMuqEYTuML/6h
 iRn9NH5stWqoXkkHQEffRlQ6J9vtnI1H0Vw8V2gWUcElnpo/ErSW51FAf6AHUqmccukij5JSRvM
 p3NfwU87IrLMptBqGU64GmNAOUhTbBg6jCm73W8wpxJVOdrR5IO5YtDuhbUl6ZMNBk6DQMhySP1
 zcxVq39IlKll1Z+d4YnABqKN3T0Aw7IwSx8Hg7nBoUDMpLnqhpHwaOIM4C/Kd/6D+uaNn/ARGwG
 +VlqEYZ55tPtz0bKNiWkJMjkmqeGDHls43o1NA6x/b4DrwaOYyXu3MxpWF3jQzvpx1LEN5+fz0K
 qRftg17ed2RH84mq6pXZbNQ==
X-Received: by 2002:a5d:5f07:0:b0:47f:6f9e:1e82 with SMTP id
 ffacd0b85a97d-47f8d710b11mr1792054f8f.9.1784786669514; 
 Wed, 22 Jul 2026 23:04:29 -0700 (PDT)
X-Received: by 2002:a5d:5f07:0:b0:47f:6f9e:1e82 with SMTP id
 ffacd0b85a97d-47f8d710b11mr1791974f8f.9.1784786668866; 
 Wed, 22 Jul 2026 23:04:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c52fa9sm13412227f8f.20.2026.07.22.23.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 23:04:28 -0700 (PDT)
Date: Thu, 23 Jul 2026 02:04:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260723015708-mutt-send-email-mst@kernel.org>
References: <73f79841-8cc7-4ca6-8f6b-fb97b53a6fe8@redhat.com>
 <20260717091756-mutt-send-email-mst@kernel.org>
 <CAFEAcA-O6Z4JrVV0DL_tta6khRyUta_Zz5mJt6OszaW1mu0o6Q@mail.gmail.com>
 <20260717095407-mutt-send-email-mst@kernel.org>
 <9c2ad22a-e768-4a07-85a2-01ce1fc14368@oss.qualcomm.com>
 <59882c5b-545d-4768-8bf4-723fed97a801@redhat.com>
 <al-eCtxGjG4HHEbl@x1.local>
 <6210e178-a93f-4411-810a-41edb1fb656e@redhat.com>
 <20260722015422-mutt-send-email-mst@kernel.org>
 <amDyvgR09OJssENX@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDyvgR09OJssENX@x1.local>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 22, 2026 at 12:41:34PM -0400, Peter Xu wrote:
> On Wed, Jul 22, 2026 at 01:58:18AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 22, 2026 at 10:53:27AM +1000, Gavin Shan wrote:
> > > On 7/22/26 2:27 AM, Peter Xu wrote:
> > > > On Tue, Jul 21, 2026 at 03:37:53PM +1000, Gavin Shan wrote:
> > > > > If Peter is fine with two variants for x86 and non-x86 architectures.
> > > > > I can post (v4) for further review. That will be something like below
> > > > > and let me know if there are any other improvements are needed.
> > > > 
> > > > I have a generic question on the "unaligned access for x86": I think the
> > > > question is about the one Michael raised here on unaligned access may break
> > > > x86 here:
> > > > 
> > > >    https://lore.kernel.org/qemu-devel/20260617022330-mutt-send-email-mst@kernel.org/
> > > > 
> > > >    3. (theoretical concern) also on x86, unaligned accesses are
> > > >    possible on guest and host, so converting an unaligned access to a
> > > >    series of aligned ones can in theory break devices.
> > > > 
> > > > Is that a real problem we need to consider, or can we start with unified
> > > > approach and leave it for later?
> > > > 
> > > 
> > > I'm leaving this question to Michael.
> > 
> > Knowing what I know about hardware designers, it's something someone
> > somewhere does)
> > It can be made a separate patch, just to show - it should be all of
> > ~10LOC.
> 
> It's only about removal of anything that might be controversial for now,
> thanks.  I also wonder if anything would break, then it's more solid proof
> that per-arch change is required.

Repeating:
	I think there is exactly 1 kinda reasonable case. A 2 byte read/write at
	offset 0x1 within a dword. This maps nicely to even classical PCI byte
	enable mechanism and so yes it works if your CPU can initiate these
	things, and it's atomic.

It's easy to find more examples of such hardware if one looks. For example,
LEDCTL on e1000e:

20260625101817-mutt-send-email-mst@kernel.org


A claim that no software uses this hardware capability is the strong
claim that needs proof, not the other way around.


What to do on non-x86? reading a dword might work, or reading
byte by byte might work. Both can cause issues, just different ones,
but given we did byte by byte previously i guess let's keep
doing that.


> > 
> > > > PS: I apologize if I missed important piece of info along the way; I didn't
> > > > follow closely on the discussion on this topic in the past few weeks.
> > > > 
> > > > One thing to mention is, what we change should only need to affect
> > > > ram_device, AFAIU.. so most memcpy()/memmove() shouldn't be changed for any
> > > > arch when it's pure RAM.
> > > > 
> > > 
> > > It depends. This patch intends to fix issue [1] in the lower layer by using
> > > the newly added accessors (qemu_ram_{copy, move}) on all directly accessible
> > > regions including the regular (pure) RAM region. Otherwise, the newly added
> > > accessors should be limited to ram_device regions only as you said.
> > > 
> > > [1] https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn/
> > > 
> > > Thanks,
> > > Gavin
> > 
> > using memcpy()/memmove() to emulate guest's atomics is generally
> > kinda broken.
> > but yes there are architectures where doing it to device ram is
> > more broken than doing it to regular ram.
> 
> If we keep memcpy()/memmove() for len>8 (aligned or not), I am thinking no
> perf issue will happen, then looks like we can indeed change this even for
> pure RAM operations, which we can't identify in case of e1000e driver use
> case.
> 
> Then does it mean we should not use __builtin_memcpy()/memmove()?  Even if
> we know constants 1/2/4/8 would work there, why not we go ahead and use
> qatomics, which is even more future proof?  I also stumbled on top of
> commit 77b1757090 ("include/qemu/bswap.h: Use __builtin_memcpy() in
> accessor functions"), which seems to say the same thing "for the long
> term".
> 
> For "should we still do unaligned access if the guest did it, so as to keep
> the original behavior of a bare metal" question, are we on the same page
> that we should just break it into aligned accesses for all archs?  I think
> it means, we will not be able to emulate guest faults correctly as what
> will happen on bare metal, but we're missing the fault injection logics
> anyway, so whenever it's implemented we _could_ switch it back to unaligned
> accesses.  Before that, breaking unaligned seems like a better way to go to
> (1) satisfy all legit users, and (2) don't make QEMU crash by guest
> operations.
> 
> Last, one silly question: why do we need any helper named with *memcpy*, if
> memmove is always superior (to consider range overlap)?  Can we stick with
> memmove all over the places?
> 
> Thanks,
> 
> -- 
> Peter Xu


