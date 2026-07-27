Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4649AC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGje-0000xh-4h; Mon, 27 Jul 2026 04:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woGjP-0000wP-Jh
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woGjJ-0004aY-LW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785141031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gEY32oBjPDEGLInOOJ3xLmZYuzAbeEx9u84r6JKPpA0=;
 b=EX4+hVuA11FUOzWrcwRnhs8L1EvrFg1Je1Kr6/j4oyxibtTh6f9mFj420+gCjVTWT/ew2Q
 DA7Tb+rqhW937dS5UVRv7ec9HduCeyZMU7YiWcZ6SBj+GniYXzwYJiIsz1ZZCkdix4BVdH
 5sXHkQ+vb0SfPPVNL+LB42c31xClwBA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-TWN8L7Q9OnS4ONgp9Osntg-1; Mon, 27 Jul 2026 04:30:29 -0400
X-MC-Unique: TWN8L7Q9OnS4ONgp9Osntg-1
X-Mimecast-MFC-AGG-ID: TWN8L7Q9OnS4ONgp9Osntg_1785141028
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so1826521f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 01:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785141028; x=1785745828; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gEY32oBjPDEGLInOOJ3xLmZYuzAbeEx9u84r6JKPpA0=;
 b=n73XM55kOsCa72cYbR81JvQkPVGdBBrhhB2eeyFv5M9DUlyG7kxr2tF8XWa4CAwQo+
 vHryRXQjmLtoeGEy1vtgZNVNO+O3Jsq1RwWRCFT2kD2U8X9kIj4G8iPEtRn/po40aX2N
 5rxHZGFy8zQZeBmMy1O3E6eL7OV6z7tTPIVfsnpJQzRl0lYjQMvNUhmNfPDXN3MmSDNb
 UTSeGYoSLd0/rqtyS72WtDgxA9xx0mDgkjA742Oh7aD6KJkh9kfOt65UNHbJ6SpCqKCE
 e0885NyjZ/lXLDafNXOxNbbjoQ4TakOzyC9AOv+2I8h45ByVDwSOMbA5a/PSRfEKkhzn
 1E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785141028; x=1785745828;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gEY32oBjPDEGLInOOJ3xLmZYuzAbeEx9u84r6JKPpA0=;
 b=RqmW0DDKPH+SBLWYF+Y4wviZw7FfO8ugNY7t0A7Mr9iyiqt49XD5bPfVmm290W0Gjg
 /a9klq28DDrdd03GRxidtHg8NBsbIezPlu3tkAP9WujUJdrzPn2EbgyrO57SFuCoJ3mE
 0XMOBkMxVx0LNp1ZliVsmXzU1i/MxV0UiZk1dUhhh5wvO1rb8jWT2IxmioQhYmtH2Rdy
 8qDYkixLtXp4sqJ8UN9NTFtEBg83TundEfndOqTwFnApg//3JePVNsAW36qN6FQ74nfq
 /8CTmqLKX1VDoLKAROo8wcxzk42/a0hBdxHYzDjmjUqf10MLFu+MEnbt+4ZqY+ATAhMo
 /boA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmZHaoqmpy05DmaN82eVu7biAsnwDrb+0BjtLYgQlbbysqM3BjvzdQkhCCADyIwnRmYP2gbKc0ss+r@nongnu.org
X-Gm-Message-State: AOJu0YwLs1vfvm+w54p3XqdSf/ilXzmiKa8nSZE+T5QIqb1Ma9xlyzjK
 atV5vzvBzviq0DzjLGo/6YFeJG3VcTvaBh2brsivCCbhUUn9qDLTiMRV3Rny0C7PI82lVDx6zAu
 LreHKLpwLY7iboIBc59a0wskgyYzfpLJjBv8qFlcNpeIia1o429DqIvRs
X-Gm-Gg: AR+sD10Jceq/KBFrWDXVnNU792Mbi2n4CXdCxG49Nnn7qFTKgUqH8ARJUeeZMhL3d7V
 Iw5AzFDQDyQflseOOoxD9v0PaoDTrZ7UNuceuZIFDZlPWMB3gOSwxF/r6V4HjgEv7eX9BW4FMV0
 RSjWOFP/1H42PQq3ZbY3RB33VgmuKN0GTv2UArjr3+J9lSWQTN4/ei5WyaUxEGYANZ7JC9kzs09
 j3mQNIlGWofBE/33ARpd3yI7uZMbc0irxFY3urp8bBjFxRE5ZkY8Xm+ruTdaqmCDbC4v70DVnNs
 HJWRbSkaHaZfuwtRGxCt3WSxZ9p9ypcfU4AyxrRBj5kjzMe9Mum4DFYxUylr9yxGsiyoaC+WFT+
 w9A00OkfDNj5DRbQK9KfO6w==
X-Received: by 2002:a05:6000:1867:b0:475:f100:3607 with SMTP id
 ffacd0b85a97d-47f9feb79fbmr9749579f8f.54.1785141027528; 
 Mon, 27 Jul 2026 01:30:27 -0700 (PDT)
X-Received: by 2002:a05:6000:1867:b0:475:f100:3607 with SMTP id
 ffacd0b85a97d-47f9feb79fbmr9749082f8f.54.1785141022877; 
 Mon, 27 Jul 2026 01:30:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb5127sm44005943f8f.10.2026.07.27.01.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 01:30:22 -0700 (PDT)
Date: Mon, 27 Jul 2026 04:30:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
Message-ID: <20260727042804-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
 <20260726164738-mutt-send-email-mst@kernel.org>
 <CAJ+F1C+fCyazpGfof9H0_n54FMy3LX6ujdmTcW=gAmhFz8Lk-w@mail.gmail.com>
 <70e1a2db-472d-46f4-ae27-ea8fb4af6cc0@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70e1a2db-472d-46f4-ae27-ea8fb4af6cc0@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 27, 2026 at 01:40:48PM +0900, Akihiko Odaki wrote:
> On 2026/07/27 6:09, Marc-André Lureau wrote:
> > On Mon, Jul 27, 2026 at 12:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > On Mon, Jul 27, 2026 at 12:44:04AM +0400, Marc-André Lureau wrote:
> > > > Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
> > > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > 
> > > Not commit log really?
> > 
> > SSIA, but I can make it longer if it helps.
> 
> I agree the subject is sufficient so:
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> That said, we can quote docs/devel/style.rst if desired:
> 
> > * Variables declared with g_auto* MUST always be initialized,
> >   otherwise the cleanup function will use uninitialized stack memory

I like that. But the question is not just whether it's required by
the coding style. The question is if there's a bug and how is it
reacheable, which can guide things like backporting decisions.
Thanks!

> Regards,
> Akihiko Odaki
> 
> > 
> > > 
> > > > ---
> > > >   hw/cxl/cxl-host.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > > > index 7e744312f1d8..eba13c9e7cba 100644
> > > > --- a/hw/cxl/cxl-host.c
> > > > +++ b/hw/cxl/cxl-host.c
> > > > @@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
> > > >       MemoryRegion *mr = NULL;
> > > >       uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
> > > >       MemoryRegion *direct_mr;
> > > > -    g_autofree char *direct_mr_name;
> > > > +    g_autofree char *direct_mr_name = NULL;
> > > >       unsigned int idx = state->hdm_decoder_idx;
> > > > 
> > > >       if (ct3d->hostvmem) {
> > > > 
> > > > --
> > > > 2.55.0
> > > 
> > > 


