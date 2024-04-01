Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E90CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 16:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrK6F-0001Ha-Fi; Mon, 01 Apr 2024 12:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrK5y-0001Bx-31
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 12:01:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrK5v-0000zG-6O
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 12:01:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V7bLN0Vxmz67DYv;
 Mon,  1 Apr 2024 23:59:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 172551400D1;
 Tue,  2 Apr 2024 00:00:54 +0800 (CST)
Received: from localhost (10.48.156.172) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 17:00:53 +0100
Date: Mon, 1 Apr 2024 17:00:50 +0100
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
CC: "fan.ni@samsung.com" <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Quanquan Cao (Fujitsu)" <caoqq@fujitsu.com>
Subject: Re: [PATCH] mem/cxl_type3: fix hpa to dpa logic
Message-ID: <20240401170050.00004867@Huawei.com>
In-Reply-To: <OSZPR01MB64531A2AA07AF4C7C8C800F68D3B2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240327014653.26623-1-yaoxt.fnst@fujitsu.com>
 <20240327132814.000057c7@Huawei.com>
 <OSZPR01MB64531A2AA07AF4C7C8C800F68D3B2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.156.172]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 28 Mar 2024 06:24:24 +0000
"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com> wrote:

> Jonathan
> 
> thanks for your reply!
> 
> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Wednesday, March 27, 2024 9:28 PM
> > To: Yao, Xingtao/姚 幸涛 <yaoxt.fnst@fujitsu.com>
> > Cc: fan.ni@samsung.com; qemu-devel@nongnu.org; Cao, Quanquan/曹 全全
> > <caoqq@fujitsu.com>
> > Subject: Re: [PATCH] mem/cxl_type3: fix hpa to dpa logic
> > 
> > On Tue, 26 Mar 2024 21:46:53 -0400
> > Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:
> >   
> > > In 3, 6, 12 interleave ways, we could not access cxl memory properly,
> > > and when the process is running on it, a 'segmentation fault' error will
> > > occur.
> > >
> > > According to the CXL specification '8.2.4.20.13 Decoder Protection',
> > > there are two branches to convert HPA to DPA:
> > > b1: Decoder[m].IW < 8 (for 1, 2, 4, 8, 16 interleave ways)
> > > b2: Decoder[m].IW >= 8 (for 3, 6, 12 interleave ways)
> > >
> > > but only b1 has been implemented.
> > >
> > > To solve this issue, we should implement b2:
> > >   DPAOffset[51:IG+8]=HPAOffset[51:IG+IW] / 3
> > >   DPAOffset[IG+7:0]=HPAOffset[IG+7:0]
> > >   DPA=DPAOffset + Decoder[n].DPABase
> > >
> > > Links:  
> > https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fujits
> > u.com/  
> > > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>  
> > 
> > Not implementing this was intentional (shouldn't seg fault obviously) but
> > I thought we were not advertising EP support for 3, 6, 12?  The HDM Decoder
> > configuration checking is currently terrible so we don't prevent
> > the bits being set (adding device side sanity checks for those decoders
> > has been on the todo list for a long time).  There are a lot of ways of
> > programming those that will blow up.
> > 
> > Can you confirm that the emulation reports they are supported.
> > https://elixir.bootlin.com/qemu/v9.0.0-rc1/source/hw/cxl/cxl-component-utils.c
> > #L246
> > implies it shouldn't and so any software using them is broken.  
> yes, the feature is not supported by QEMU, but I can still create a 6-interleave-ways region on kernel layer.
> 
> I checked the source code of kernel, and found that the kernel did not check this bit when committing decoder.
> we may add some check on kernel side.

ouch.  We definitely want that check!  The decoder commit will fail
anyway (which QEMU doesn't yet because we don't do all the sanity checks
we should). However failing on commit is nasty as the reason should have
been detected earlier.

> 
> > 
> > The non power of 2 decodes always made me nervous as the maths is more
> > complex and any changes to that decode will need careful checking.
> > For the power of 2 cases it was a bunch of writes to edge conditions etc
> > and checking the right data landed in the backing stores.  
> after applying this modification, I tested some command by using these memory, like 'ls', 'top'..
> and they can be executed normally, maybe there are some other problems I haven't met yet.

I usually run a bunch of manual tests with devmem2 to ensure the edge cases are handled
correctly, but I've not really seen any errors that didn't also show up in running
stressors (e.g. stressng) or just memhog on the memory.

Jonathan

> 
> > 
> > Joanthan
> > 
> >   
> > > ---
> > >  hw/mem/cxl_type3.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index b0a7e9f11b..2c1218fb12 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -805,10 +805,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr  
> > host_addr, uint64_t *dpa)  
> > >              continue;
> > >          }
> > >
> > > -        *dpa = dpa_base +
> > > -            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > -             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)  
> > > -              >> iw));  
> > > +        if (iw < 8) {
> > > +            *dpa = dpa_base +
> > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > +                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) &  
> > hpa_offset)  
> > > +                  >> iw));
> > > +        } else {
> > > +            *dpa = dpa_base +
> > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > +                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) & hpa_offset)
> > > +                   >> (ig + iw)) / 3) << (ig + 8)));
> > > +        }
> > >
> > >          return true;
> > >      }  
> 


