Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0772F01822
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySOH-0007an-Js; Fri, 06 Mar 2026 05:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vySOF-0007ab-KE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:26:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vySOD-0003r3-6P
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:26:39 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS2cJ050czJ46n2;
 Fri,  6 Mar 2026 18:25:52 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id D4F5D40584;
 Fri,  6 Mar 2026 18:26:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 10:26:28 +0000
Date: Fri, 6 Mar 2026 10:26:27 +0000
To: Gregory Price <gourry@gourry.net>
CC: Alireza Sanaee <alireza.sanaee@huawei.com>, <qemu-devel@nongnu.org>,
 <lizhijian@fujitsu.com>, <anisa.su887@gmail.com>, <armbru@redhat.com>,
 <david@kernel.org>, <imammedo@redhat.com>, <linuxarm@huawei.com>,
 <mst@redhat.com>, <nifan.cxl@gmail.com>, <peterx@redhat.com>,
 <philmd@linaro.org>, <ppbonzini@redhat.com>, <venkataravis@micron.com>,
 <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v6 3/3] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Message-ID: <20260306102627.00004d5f@huawei.com>
In-Reply-To: <aanx9AVMvca5n2yY@gourry-fedora-PF4VCD3F>
References: <20260226152034.1523-1-alireza.sanaee@huawei.com>
 <20260226152034.1523-4-alireza.sanaee@huawei.com>
 <aanx9AVMvca5n2yY@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 5 Mar 2026 16:13:24 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Feb 26, 2026 at 03:20:34PM +0000, Alireza Sanaee wrote:
> > +        /*
> > +         * Optimization: Looking for a fully committed path; if the type 3 HDM
> > +         * decoder is not commmitted, it cannot lie on such a path.  
>                                ^^^ committed
> 
> ... snip ...
> > +                object_child_foreach_recursive(object_get_root(),
> > +                                               cxl_fmws_direct_passthrough,
> > +                                               &state);
> > +            }
> > +        }
> > +        dpa_base += decoder_size / cxl_interleave_ways_dec(iw, &error_fatal);
> > +    }
> > +  
> 
> Div-by-0 here for invalid values?
> 
> int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp)
> {
>     switch (iw_enc) {
>     ... snip ...
>     default:
>         error_setg(errp, "Encoded interleave ways: %d not supported", iw_enc);
>         return 0;

It will abort because error_fatal is passed in. I believe we've always sanity
checked the value at write so 
That's not particularly elegant so I think we should do a check on it being
zero and just return 0 if it happens to be so. 
We have similar checks in the other uses of cxl_interleave_ways_dec()

On the todo list for a long time has been adding more sanity checking
to the HDM commit flows.  As we are getting closer to this stuff actually
being usable for virtualization as well as emulation / testing, that will
need cleaning up.

>     }
> }
> 
> Or does this abort before return?
> 
> > +    return false;
> > +}  
> 
> You're returning false as an 'int'
Good spot. That should be return 0.

> 
> ~Gregory


