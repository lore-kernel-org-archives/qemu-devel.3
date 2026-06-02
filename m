Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB20CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 12:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUOJb-0002RN-BB; Tue, 02 Jun 2026 08:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@ziepe.ca>) id 1wUOJZ-0002RA-Sv
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 08:33:49 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jgg@ziepe.ca>) id 1wUOJY-00036S-1B
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 08:33:49 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-5174a34800fso26645831cf.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 05:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1780403626; x=1781008426; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
 b=duNeyrBF6PY9NXDfPsjOVI+MpxCyjzgrxZyHQ7dUh5p7tplADBG1RRszIyTr37QXNp
 5HjRa2uZxFWX++KJM4ZrJeofK1TOmxk9l0NB3iBatYbnD6G754Gk7rZOFcQuWnsVC8B/
 seacEiklp5hfsoiyNoUPRAf3lxZ95qbirVcPjL1zAFcxlA3xAX3UDCa7ToBRSUhWC+Oc
 bBPAznzjn/FI+Lr/OdjoNikBRm8Ok3TePxY7VWXr8h2J2sKOKowvnF82MhCcaKn92s9C
 3KMPkL+RpuJ8QYIoxA5jcH45fm9zNPAxboGYUlOjWIlai7v1F0nhnKDWPfS4dzqq5a7B
 bSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780403626; x=1781008426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
 b=MM3mUYK3mDIvjopTmxOmGrKZCO8ZrxF49ZoQkO90W+tAFMZuDvfKl7yUmMvgTJnyq9
 2Egiz0auWF1Pgv02vyoBD7eC6snvigCgVb3mG0d5mL1Kyo8RYqHPAnFUY+2bSEeN2ZBa
 NFYWP5W+Wh6aof97073/xFyaeDtYaVrwZEuFD00/NweNetDZmzFwnVvNhP0k6CxJxPuY
 zTveJt7HzHmNef1N/kBJ/FDc5qOmSodkf58xNcHKVyQACTSFK2U3IlFj7i9G/CaeAAxY
 3qQa4WEUDa+wmhlQ6kkkT4Gpy7yxXRReEQN+6ucaD4mWyS+ZyA7LVkMpVH5tLO3vheSy
 ZC3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tzIUKPj/feqRke38k88CqHiaB2kh4e4fSF7QoAviAhfZpHDK8xbCU8Xq3nCc3li+DRAqYlqlh0BQE@nongnu.org
X-Gm-Message-State: AOJu0YxUz1CRsIZYrbQIOw51FVadzFvCm8M/DW+cgfru1h2ohhE7bGL+
 PlMXWgzHWxAzDbZkQbD9UKYveBOpdRUK5WKlXUXC6B9waO/DluQs5PVzcyUaEcZPUbA=
X-Gm-Gg: Acq92OEulgo3hiNG6dOkfnv5oIEr4JY64FnCSSjOvJzGv8o27banuer2nWaWz9FoiqW
 EQayjE/Tmn6ObZwv+AIQupUOLH+Il3JnnunPHknB3PZF/s0sCX+MoX/zQJgS3FO4G2TCR05QSSv
 p3rWzznCZh2vBOgMPstW+vGH2WtJwceDZc60napxizKLbnpHEbmNDLx4O+9J1dm7cEGU2ubbO78
 E2J+qUoeX/fH2GbQA0S0nlIjjiwEfGF0rl/B6+e9PcwCgqEaA/wsmnR42cS8yon9dcfa/oeL+A5
 g5+31xSGFSHIqfm+9lPcAnsJUDFrIf4+pYIpThg6L9oKpNFj/IIIP1o1wMP/+Eiv9zSK7cuY8U0
 rlG8x1TSBiHDuAgi1uT058qbAS3g6g9P8HQEZpdOOlioMIaJHyi4xVBiinqSEh87i8be9WzN+fS
 J9ve29uhA7tn2xvwidbNv4vWMAQRg7AnwZAbP78YTy+Y8rbGfyZHEDBmeN/d1QUm9zwcPYfBqZE
 +YXIjwL29V84rh2
X-Received: by 2002:a05:622a:190a:b0:509:2527:d789 with SMTP id
 d75a77b69052e-5173a5c05ecmr228232631cf.6.1780403625864; 
 Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from ziepe.ca
 (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net.
 [47.54.130.67]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51741d6a240sm78686221cf.18.2026.06.02.05.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wUOJU-00000003m5x-3DKO;
 Tue, 02 Jun 2026 09:33:44 -0300
Date: Tue, 2 Jun 2026 09:33:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, stable@vger.kernel.org,
 Petr Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>,
 Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bart Van Assche <bvanassche@acm.org>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>,
 Benjamin Berg <benjamin.berg@intel.com>,
 Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, qemu-devel@nongnu.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/11] params: bound array element output to the caller's
 page buffer
Message-ID: <20260602123344.GG2487554@ziepe.ca>
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-1-kees@kernel.org>
 <ah699hwLxIIOZ0-7@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah699hwLxIIOZ0-7@ashevche-desk.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b; envelope-from=jgg@ziepe.ca;
 helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Jun 02, 2026 at 02:26:46PM +0300, Andy Shevchenko wrote:
> On Thu, May 21, 2026 at 06:33:14AM -0700, Kees Cook wrote:
> > 
> > param_array_get() appends each element's string representation into the
> > shared sysfs page buffer by passing buffer + off to the element getter.
> > 
> > That works for getters that only write a small bounded string, but
> > param_get_charp() and similar helpers format against PAGE_SIZE from the
> > pointer they receive. Once off is non-zero, an element getter can
> > therefore write past the end of the original sysfs page buffer.
> > 
> > Collect each element into a temporary PAGE_SIZE buffer first and then
> > copy only the remaining space into the caller's page buffer.
> 
> ...
> 
> > +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> 
> get_free_page() (or how it is called)?

I thought modern mm guidance was to use kmalloc whenever possible and
not use get_free_page() unless you intend to use the struct page bits?

Jason

