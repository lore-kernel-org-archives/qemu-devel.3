Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C0FD5C0C8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9QI6-0007Fk-3v; Fri, 08 Nov 2024 09:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t9QHS-0004zY-3h
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:48:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t9QHP-0005Q0-DM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:48:09 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlMDG5yMKz6J7DD;
 Fri,  8 Nov 2024 22:45:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B8FC8140A9C;
 Fri,  8 Nov 2024 22:47:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Nov
 2024 15:47:56 +0100
Date: Fri, 8 Nov 2024 14:47:54 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 <linuxarm@huawei.com>
Subject: Re: [PATCH qemu 08/10] hw/cxl: Check that writes do not go beyond
 end of target attributes
Message-ID: <20241108144754.00003a92@huawei.com>
In-Reply-To: <CAFEAcA8LB3t0n_BqjBeEejfmVVYMbQ1rT9qwEbsNEoUDbkym9A@mail.gmail.com>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-9-Jonathan.Cameron@huawei.com>
 <CAFEAcA8LB3t0n_BqjBeEejfmVVYMbQ1rT9qwEbsNEoUDbkym9A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 7 Nov 2024 15:39:13 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 1 Nov 2024 at 13:43, Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> >
> > In cmd_features_set_feature() the an offset + data size schemed
> > is used to allow for large features.  Ensure this does not write
> > beyond the end fo the buffers used to accumulate the full feature
> > attribute set.
> >
> > Reported-by: Esifiel <esifiel@gmail.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index a40d81219c..078782e8b9 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1292,6 +1292,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
> >
> >          ps_set_feature = (void *)payload_in;
> >          ps_write_attrs = &ps_set_feature->feat_data;
> > +
> > +        if ((uint32_t)hdr->offset + bytes_to_copy >
> > +            sizeof(ct3d->patrol_scrub_wr_attrs)) {
> > +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> > +        }  
> 
> Coverity complains about this code (CID 1564900, 1564901).
> Essentially it does not like that this check permits
> the memcpy for the case where hdr->offset is 2 and
> bytes_to_copy is 0, because memcpy(invalid_dest, src, 0)
> is still UB even though you might logically expect it
> to do nothing.
Huh.  Something new I learned today ;)

Anyhow, it makes little sense to have a set feature with zero length payload
so I can check for this before we even know what type of payload this is,
thus catching both cases here.

I'll spin a patch shortly.

thanks

Jonathan


> 
> >          memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
> >                 ps_write_attrs,
> >                 bytes_to_copy);  
> 
> > @@ -1314,6 +1319,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
> >
> >          ecs_set_feature = (void *)payload_in;
> >          ecs_write_attrs = ecs_set_feature->feat_data;
> > +
> > +        if ((uint32_t)hdr->offset + bytes_to_copy >
> > +            sizeof(ct3d->ecs_wr_attrs)) {
> > +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> > +        }
> >          memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
> >                 ecs_write_attrs,
> >                 bytes_to_copy);  
> 
> Similarly here.
> 
> thanks
> -- PMM


