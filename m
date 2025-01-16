Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A04C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSvi-0008Tx-NA; Thu, 16 Jan 2025 11:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tYSve-0008SQ-8N
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:41:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tYSvb-0003J3-9y
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737045665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5XajcaPx0fbToYw4Hp0QIg5MZLlqYmtQgmgzJkDpG1s=;
 b=QNnaxEr6wrozTYchwAQhv4pJTvn1wrRNjZZGrYESjCjrbK+xlOd1xCakJvmLrM5pDSAQeM
 op4pWTcuvZXUUcQmWXsNydqVbkvOU+G+K77hd0CkJvHNB52M/B63+IX29/8O42rkS864et
 ywExHX/NXgwJmSE75jv7RFjCfuVj5oY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-2LUBQ6ptN0mcUo569aR5rQ-1; Thu, 16 Jan 2025 11:41:01 -0500
X-MC-Unique: 2LUBQ6ptN0mcUo569aR5rQ-1
X-Mimecast-MFC-AGG-ID: 2LUBQ6ptN0mcUo569aR5rQ
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2163dc0f689so29898725ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737045660; x=1737650460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XajcaPx0fbToYw4Hp0QIg5MZLlqYmtQgmgzJkDpG1s=;
 b=rNsNTqPQVD+EhN9uSJ4FTFSUR3ocpXpL9OtnhehZm9HhS9PvRioiucr3QO3ZCAxpl/
 AT9wMrKpnoALfpS1tXBf3EgWBwHLoMqVDG+H2NH8VkZY5wMtkQJJOpngqTbdWyVohXXS
 rlEL3TYGINZDPepPgK1H4KBMYP8ki9ralFcQXC+1iYNmCAwBjFIrwhJ4RGXfUeYHjaQP
 +cv4NHJpaf4sod+X8oiNNEqeNk8Yk15afPhH8v/M3eQnp9ofulojMJW+ATSOiGxXNKRw
 QBJUIUtkF1JNiQqa0FURY77DuzTis/XC2oUGJMcuACc2wWvAMTEs9CghaFaXhj0o+kdi
 pEjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB5oePLwqQs9CsrBDLje35AsPwfTIgBmeK6x9nJLvDgElqmNX4b4kP6cHRb5LtM/QCEF3vjQe+/7E5@nongnu.org
X-Gm-Message-State: AOJu0YxQ4oqqGfjwKg7Xwr+GV50fHXBmn+1J2d+sHGf7W0bI93TLyktl
 QE3LuIfeEA6nzg7T/pYDeorUYWTO/HaZdcBZ64DkNqAp1OpRPHHp6f+VWXWnPlXzO2SKuPGjr6+
 0fMoS3qhsGoWZjkuVgB9bj9UuS1FTyVSde+Ti2KbqPlMihaStnxLP
X-Gm-Gg: ASbGncuOOgopbAe7MMAhwh5FeixuYw3M9kYxNC3Hu+9Ki+CtGowWFgktT4iCtXzlI0X
 pe/NsRLML/FcuXeJ0rGxaDWhTkXpoXQc/rVTwbSnJHbELNVA0uHGcdjcUHRAymQi8rEaKpQW5zJ
 Pxcqp+eNufdL7k3XrK5W66ygpL7e14wttDOwjJDVZ99ydpZcd0n/QBN8gtVEkSAtl/Z+ybXryi/
 p+iq/HXrPBDC9Yi4U4vahLkthdS9AwO0TBBLxz47kWgdybSknAs2O1XZPNiGbu9IsofYzD1nfkH
 disySX2HVCDxtq8SMw==
X-Received: by 2002:a17:902:f54e:b0:215:50fb:ae4a with SMTP id
 d9443c01a7336-21a83dafe90mr553993415ad.0.1737045660150; 
 Thu, 16 Jan 2025 08:41:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUEyeBJUitEOJg+weGFlBRABqw+TZnfXsa1shosVWV3v1BNDjbhrbvSdt/pPXFPJLrtDVzUQ==
X-Received: by 2002:a17:902:f54e:b0:215:50fb:ae4a with SMTP id
 d9443c01a7336-21a83dafe90mr553992955ad.0.1737045659758; 
 Thu, 16 Jan 2025 08:40:59 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3ac93bsm2316345ad.157.2025.01.16.08.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:40:59 -0800 (PST)
Date: Thu, 16 Jan 2025 11:40:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
Message-ID: <Z4k2lQeeYzarxIlL@x1n>
References: <Z4AldAcucTyqZ0HJ@x1n>
 <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
 <Z4E6TnKaUt8FMWIv@x1n>
 <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
 <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
 <Z4aYpo0VEgaQedKp@x1n>
 <CAFEAcA_mpWZO8V9cE74bKzveEEZDXkqE+XbOFFdhmKUKO3dmSw@mail.gmail.com>
 <Z4a3GxEbz1jjCDc5@x1n>
 <CAFEAcA87oYqMj1t+yriXHLuTg3G-=eRwOvt4-n4uJmeNujTBxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA87oYqMj1t+yriXHLuTg3G-=eRwOvt4-n4uJmeNujTBxQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 16, 2025 at 02:50:26PM +0000, Peter Maydell wrote:
> On Tue, 14 Jan 2025 at 19:12, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Jan 14, 2025 at 05:42:57PM +0000, Peter Maydell wrote:
> > > There's at least one test in the arm qtests that will hit this.
> > > I suspect that you'll find that most architectures except x86
> > > (where we don't have models of complex SoCs and the few
> > > machines we do have tend to be old code that is less QOMified)
> > > will hit similar issues. I think there's a general issue here,
> > > this isn't just "some particular ppc device is wrongly coded".
> >
> > I see.  Do you know how many of them would be important memory leaks that
> > we should fix immediately?
> 
> None of these are important memory leaks, because the device is
> almost always present for the lifetime of the simulation. The
> only case you'd actually get a visible leak would be if you
> could hot-unplug the device, and even then you'd have to
> deliberately sit there doing hot-plug-then-unplug cycles to
> leak an interesting amount of memory.
> 
> The main reason to want to fix them is that it lets us run
> "make check" under the sanitizer and catch other, more
> interesting leaks.

Right.

> 
> > I mean, we have known memory leaks in QEMU in many places I assume.  I am
> > curious how important this problem is, and whether such would justify a
> > memory API change that is not reaching a quorum state (and, imho, add
> > complexity to memory core and of course that spreads to x86 too even if it
> > was not affected) to be merged.  Or perhaps we can fix the important ones
> > first from the device model directly instead.
> 
> The problem is generic, and the problem is that we have not actually
> nailed down how this is supposed to work, i.e:
>  * what are the reference counts counting?

I think we know how it works before this patch.  And with that, I suppose
Akihiko managed to figure out how it was not freed properly now for those
due to the circular reference issue that this series is tracking.  That's
definitely one step forward to me.

Said that, this is also the major controversial point so far on this patch
on how we should implement such object-internal auto-detach mechanism for
MRs even within the same object.

My suggestion is sticking with the current simple model as much as possible
on always using owner refcounts for MRs, while resolving the issue we're
facing with that.  I have a complete patch (which, I would say, should
still be under authorship of Akihiko; what I provided is a fixup on top of
his, and I slightly touched up some comments to provide the best
readability):

https://lore.kernel.org/qemu-devel/Z4e7gFSqdhcmJPYb@x1n

So it's more of a preference that I prefer his older patch with the fixup,
rather than this patch.

Akihiko would prefer start using two refcounts, one almost dedicated for
object internal MR refcounts so that we'll finalize internal MRs in order
(which I questioned on the necessary), but not completely.

>  * if a device has this kind of memory region inside another,
>    how is it supposed to be coded so as to not leak memory?

Is this question about one MR being struct field of one object, or
specific to something else?

> 
> If we can figure out how the lifecycle and memory management
> is supposed to work, then yes, we can fix the relevant device
> models so that they follow whatever the rules are. But it seems
> to me that at the moment we have not got a consensus on how
> this is supposed to work. Until we have that, there's no way to
> fix this at the device model level, because we don't know what
> changes we need to make.

Yes, I think I understand slightly better on the issue we're facing now,
thanks.

-- 
Peter Xu


