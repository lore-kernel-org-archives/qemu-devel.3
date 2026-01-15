Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C31D4662F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 23:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgWvl-0004dx-FX; Thu, 15 Jan 2026 18:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgWvk-0004dT-3l
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 18:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgWvi-0006H2-52
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 18:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768520343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciUaUZYQ2Rj9RnjiiFPXMIfG3NfVmTkOT3wr4ABpzag=;
 b=Zz8ng+IFu6htePucBcqwr9bdZl4ihlZp0pBhJV6Funh/8qHtgjW3EKVgmKAfmmCjPjHutu
 hHD/dr05KsXdldLedkQgqXXzXrO0WKvcrkN8fQDd/RLH3L8KOqDgzgCYYUQHrMqiii60L3
 WTudbm0swRmtjvNw/ntl2OC1m7a8QEY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-3EMVQBtyOXKMWYYjSh2_Ng-1; Thu, 15 Jan 2026 18:39:02 -0500
X-MC-Unique: 3EMVQBtyOXKMWYYjSh2_Ng-1
X-Mimecast-MFC-AGG-ID: 3EMVQBtyOXKMWYYjSh2_Ng_1768520341
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5019f8a18cdso44048261cf.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768520341; x=1769125141; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ciUaUZYQ2Rj9RnjiiFPXMIfG3NfVmTkOT3wr4ABpzag=;
 b=MK3+/PAuMrW6siplMJYqdw87AZ8IN2MB1Ms5hleDjQZslu+GYCcNCdvWCeX+GDz4Cb
 /cQuieUR2GBXyCp/olUfarwZ/4wMhdRET3TS7ytBIhb81TKpF359KAI2mg+STW8l0JSO
 VecPMnwILevmlKiPd0/hLl7QNCsJlo006Izl4PYtPC8dYEBIOaP48SUSDHzyEUD4CwU2
 jekzrDaHAM6Sr3n56ipDeazh8I2rjlpHnZ34hAXH6JhiFMIO/hIEaF+UvEh1faVlAUJB
 D1jABtaTv2sfFLR40OQNZr0ZLoW96wnqDZll2M9mtsvnUyfKbxWhKpyaJquJF7d4M+1D
 V/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768520341; x=1769125141;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciUaUZYQ2Rj9RnjiiFPXMIfG3NfVmTkOT3wr4ABpzag=;
 b=r/9XO+06udTpO0Yi/JF4KdPdAl5xQUY2AhXQi722SMYtxFj7AiKpBbVlM1nIqLq+AO
 6ipvq4gQnF1V8lCPoB3PKZ+3GfDiaxdLwn7+ptbqnaNtlENa3HCEOuI6S+hGCPvttpEQ
 BDXAdIcBKbCPZnzTGq0FnZEg8m0H9207NtJqfbB89dXuh1aO9MmLWB6SmXmmpAmR9CbC
 9+9ggl2jzTqwB7wR/qYrUv3TpFYwKiJzqDEsJZ7ajTTMHtxDE02bZjOvQmsP+FsHmvYT
 fwT2DGoZHRzjLlAW54+Yn1A0FPi1CygG5y3pJo/b98l51P0shzA/UllRBiJ+/9mjIZln
 uDRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+Xow3HAo2lw1zqF9srC7KcAXCldQ4HEYuNkWWkum0rtgVCTvHgX0/hlpuu+1Ha0fiC52fdeJnvei9@nongnu.org
X-Gm-Message-State: AOJu0Yym6bjudV6XoR2BbORXPyUslbf6uKurzrokBFjPQwvz60WUJxYJ
 PTiRBT8Aqp5mxvVwgGvg2zDayL3S06TSH6kfOcwfKIttYjh1FsDog/tVPNqdtVt082FN2Gqd6vK
 GQtrF6zdBgB7mltCG/d4VvrxWivyPJX+rObzxVkmR68wa+/QMpkAxvLRI
X-Gm-Gg: AY/fxX4ELjcL2HkwSJPy8/6o0KRniNtNXWRN7C9K/Tr5O2ei8P/tkIA8B9TM3wSKG1K
 qNxWYNmw/JiCqvo1JD1xnXt3t5L+10AyUHtOmT9s1JIzb+XOIWkXRP5JmuoCT9CYCvOOsKxy7v/
 PBSIQtcHqSpXFnb2IsASSSOfjqoknpJUtEs8+3rtXhd/j+jRUzxg6tBXUMO224pX0ihBnFSPeUU
 PkbuFOlEGf9HnH3IbymTC+7oxrVQWjOq2j5EugaUCqu0qD3i8BK+ianYsjakp/TAb0FecAvYFXC
 ClrmgWSKOB32NZsPjwgt1ia4dvCWjr+j6Qak8o1bkSW8ofyrVMx/5Yo7a4FwJUJ86aAT07giqeO
 RHuM=
X-Received: by 2002:a05:622a:1794:b0:4ec:a568:7b1c with SMTP id
 d75a77b69052e-502a16229ecmr19722361cf.21.1768520341557; 
 Thu, 15 Jan 2026 15:39:01 -0800 (PST)
X-Received: by 2002:a05:622a:1794:b0:4ec:a568:7b1c with SMTP id
 d75a77b69052e-502a16229ecmr19722051cf.21.1768520341033; 
 Thu, 15 Jan 2026 15:39:01 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef8553sm8007621cf.24.2026.01.15.15.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 15:39:00 -0800 (PST)
Date: Thu, 15 Jan 2026 18:38:51 -0500
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aWl6ixQpHaMJhV_E@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWlxY9TWGT1aaMJz@gallifrey>
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

On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:
> > > Nack.
> > > 
> > > This code has users, as explained in my other email:
> > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464
> > 
> > Please then rework that series and consider include the following (I
> > believe I pointed out a long time ago somewhere..):
> > 
> 
> > - Some form of justification of why multifd needs to be enabled for COLO.
> >   For example, in your cluster deployment, using multifd can improve XXX
> >   by YYY.  Please describe the use case and improvements.
> 
> That one is pretty easy; since COLO is regularly taking snapshots, the faster
> the snapshoting the less overhead there is.

Thanks for chiming in, Dave.  I can explain why I want to request for some
numbers.

Firstly, numbers normally proves it's used in a real system.  It's at least
being used and seriously tested.

Secondly, per my very limited understanding to COLO... the two VMs in most
cases should be in-sync state already when both sides generate the same
network packets.

Another sync (where multifd can start to take effect) is only needed when
there're packets misalignments, but IIUC it should be rare.  I don't know
how rare it is, it would be good if Lukas could introduce some of those
numbers in his deployment to help us understand COLO better if we'll need
to keep it.

IIUC, the critical path of COLO shouldn't be migration on its own?  It
should be when heartbeat gets lost; that normally should happen when two
VMs are in sync.  In this path, I don't see how multifd helps..  because
there's no migration happening, only the src recording what has changed.
Hence I think some number with description of the measurements may help us
understand how important multifd is to COLO.

Supporting multifd will cause new COLO functions to inject into core
migration code paths (even if not much..). I want to make sure such (new)
complexity is justified. I also want to avoid introducing a feature only
because "we have XXX, then let's support XXX in COLO too, maybe some day
it'll be useful".

After these days, I found removing code is sometimes harder than writting
new..

Thanks,

> 
> Lukas: Given COLO has a bunch of different features (i.e. the block
> replication, the clever network comparison etc) do you know which ones
> are used in the setups you are aware of?
> 
> I'd guess the tricky part of a test would be the network side; I'm
> not too sure how you'd set that in a test.

-- 
Peter Xu


