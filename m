Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5466CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 16:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzHNk-0006PD-15; Thu, 18 Sep 2025 12:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzHNh-0006DE-Gl
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 12:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzHNe-0002gd-L6
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 12:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758212468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pPot1YgRDZE6hCh7mQ2pocPU2SLwI5BRF837EyaCck=;
 b=ERsDXc+qh4uLQ5tLZzl1D2ZEIYX6w/zv2ZmWleD5eqx6AjE3kQLF6fIY9/GTl++Pljif0+
 lsNolM4iPC2mneLedyre9jjIivrF5SThRAfsOjvzsgtytfNS9rQF6tuYoCvUxTLdTLyMKf
 nmaFzIx9veQCqADD+L7BNSjsUFNFi0E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-Nae_xjwSPnqL7YLXbOyTMA-1; Thu, 18 Sep 2025 12:21:07 -0400
X-MC-Unique: Nae_xjwSPnqL7YLXbOyTMA-1
X-Mimecast-MFC-AGG-ID: Nae_xjwSPnqL7YLXbOyTMA_1758212467
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70d7c7e972eso19035456d6.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 09:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758212467; x=1758817267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pPot1YgRDZE6hCh7mQ2pocPU2SLwI5BRF837EyaCck=;
 b=ZT7VCBgorxCGJPchvGrRB/SBWnu82nUGbRnWYHxoY15FItSY4wEpZAh49qMGyBjkq8
 NERH0NOKFGIl8GZp08h1OgJiw9w5LYWrIxaH+nnqSaQrOgMO5YjONJ2gVLLxlcP5sVps
 PnQDB+FxwCRiie8khX0pXm1FRvy++V1UIhlq7RTT8MyfM1C62KItUYDhGuuahvyjuAcB
 1r1oevBrsExgMNndXm2phEofGwKr285TuEOQ3s33TL9eGbu73J/8T5kjt9Qus1rSd/35
 ISb7K/F87A7O12tFcvZe5/Qn64nm9FHqU0SoMxs/dP0H60jq+rWvTlVUqLuL6J2uwJ4T
 HH1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5csQ18Eo6J9f/NjpbBhGX312Rv5omCZ4KDO+LCoAT9qBJi2mF0nZrQNueJMXXy7lJupqDr1UTEUd5@nongnu.org
X-Gm-Message-State: AOJu0Ywh+bvE7gCQm3XOuNmbNX8yfB18SEfWDNUZQx22y1xF1rPRJjMs
 UhhChRUbu5Yt+3iNatvA8Hju9y94+KQjjWTZFaNYnZNHAXSQlQZnumhqz1u4x8ZTx51TQ2Z+xqI
 b+BHfYMv+TIBYNpwxX6fmrGTEH/ac2MxYledgKIqh8Qhx+TK43ov7bi6E
X-Gm-Gg: ASbGncuaG32LF2BIw8sTAAgeVF4YHnZar8eR4tOphdzh+CCmANPzIhogvMZ/QF0RzBu
 iEXFAiY1c9Pf+cayyuVdJoW//2DRRC7ceYOwDm0wMCqT/NSILiwepgMlLkxVD0XCXdVARZFw+4l
 it2KQVugetcN3RTWpIOfAVyl3J4H/BwvTfMMCT0GMWm/RbuEOaZ3ELiB5Suqq9gHxzjNA/r84em
 5zVsJpSulg0O0enqPWTmg1Vf3pTrxoYskNLtycIExH2yhxHSLfNLVG/ibwHbIspO8H0/Ny965L1
 F/LLa6WK42tTCGTj5FE+a5CiQw9odfA8
X-Received: by 2002:a05:6214:5010:b0:722:970:3af1 with SMTP id
 6a1803df08f44-79912981a94mr326436d6.22.1758212466497; 
 Thu, 18 Sep 2025 09:21:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5SggIi+tiry2DFo3y6iLI5iQBDlENMAhmnoVxB3dUWtLTqu/Fo+l7vs/qxtYyCGU32KLXQg==
X-Received: by 2002:a05:6214:5010:b0:722:970:3af1 with SMTP id
 6a1803df08f44-79912981a94mr325736d6.22.1758212465766; 
 Thu, 18 Sep 2025 09:21:05 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-793472c35c4sm15248966d6.24.2025.09.18.09.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 09:21:05 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:20:49 -0400
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Bin Meng <bmeng.cn@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 0/7] Do not unparent in instance_finalize()
Message-ID: <aMwxYY9E3QghD10K@x1.local>
References: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
 <aMwRSpezxmIwIHrU@x1.local>
 <f536fc18-73ab-676c-bdec-59e94a3e5408@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f536fc18-73ab-676c-bdec-59e94a3e5408@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 18, 2025 at 05:29:34PM +0200, BALATON Zoltan wrote:
> On Thu, 18 Sep 2025, Peter Xu wrote:
> > On Wed, Sep 17, 2025 at 07:13:25PM +0900, Akihiko Odaki wrote:
> > > Based-on: <cover.1751493467.git.balaton@eik.bme.hu>
> > > ("[PATCH v2 00/14] hw/pci-host/raven clean ups")
> > 
> > Could I ask why this is a dependency?
> 
> It removes an address_space usage from raven so this series does not have to
> change that and I don't have to rebase that series. Otherwise these are not
> related. I'll check the problem reported about my series and send an updated
> one.

This series should be a split of a previous mixed up series that may
contain address space changes while this one doesn't.  It also doesn't
touch raven.c and ppc/.

Can I then understand it as the dependency is simply not needed?

Thanks,

-- 
Peter Xu


