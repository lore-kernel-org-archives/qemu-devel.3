Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71703C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 11:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTKqN-0007GF-MI; Fri, 26 Jan 2024 06:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rTKqK-0007Fs-A1
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 06:57:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rTKqH-0000KJ-V2
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 06:57:56 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLx2F2t8Zz6JBFG;
 Fri, 26 Jan 2024 19:54:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 4C898140B55;
 Fri, 26 Jan 2024 19:57:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 11:57:50 +0000
Date: Fri, 26 Jan 2024 11:57:50 +0000
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
 <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>, Ira Weiny
 <ira.weiny@intel.com>, Huai-Cheng Kuo <hchkuo@avery-design.com.tw>, "Dave
 Jiang" <dave.jiang@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 <linuxarm@huawei.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 09/12] hw/mem/cxl_type3: Fix potential divide by zero
 reported by coverity
Message-ID: <20240126115750.000027e6@Huawei.com>
In-Reply-To: <ZbGjFiKKPhC_uiOF@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-10-Jonathan.Cameron@huawei.com>
 <ZbGjFiKKPhC_uiOF@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 24 Jan 2024 15:53:58 -0800
fan <nifan.cxl@gmail.com> wrote:

> On Wed, Jan 24, 2024 at 12:40:57PM +0000, Jonathan Cameron wrote:
> > Fixes Coverity ID 1522368.
> > 
> > Currently error_fatal is set if interleave_ways_dec() is going to return 0
> > but we should handle that zero return explicitly.
> > 
> > Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> 
> > ---
> > Note this is a stop gap until a more complex HDM decoder verification series.
> > ---
> >  hw/mem/cxl_type3.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 1b92a065a3..24211703c6 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -794,8 +794,12 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
> >          }
> >          if (((uint64_t)host_addr < decoder_base) ||
> >              (hpa_offset >= decoder_size)) {
> > -            dpa_base += decoder_size /
> > -                cxl_interleave_ways_dec(iw, &error_fatal);
> > +            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
> > +
> > +            if (decoded_iw == 0)
> > +                return false;
I've obviously been lax in running checkpatch.
Brackets needed for qemu style here. I'll add them for v2

Jonathan

> > +
> > +            dpa_base += decoder_size / decoded_iw;
> >              continue;
> >          }
> >  
> > -- 
> > 2.39.2
> >   


