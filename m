Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40301CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImzQ-0007Xv-Qf; Tue, 11 Nov 2025 06:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vImyc-0005Lm-UW; Tue, 11 Nov 2025 06:55:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vImya-0005Mo-F6; Tue, 11 Nov 2025 06:55:58 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5Q2f1HJRzJ46bY;
 Tue, 11 Nov 2025 19:55:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 021AB140371;
 Tue, 11 Nov 2025 19:55:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 11:55:52 +0000
Date: Tue, 11 Nov 2025 11:55:51 +0000
To: Gavin Shan <gshan@redhat.com>
CC: Igor Mammedov <imammedo@redhat.com>, <shan.gavin@gmail.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <mchehab+huawei@kernel.org>,
 <gengdongjiu1@gmail.com>, <mst@redhat.com>, <anisinha@redhat.com>,
 <peter.maydell@linaro.org>, <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/8] acpi/ghes: Extend acpi_ghes_memory_errors() to
 support multiple CPERs
Message-ID: <20251111115551.00003385@huawei.com>
In-Reply-To: <2440a0dd-6543-4590-9c0f-06b05bdfc8a4@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-5-gshan@redhat.com>
 <20251105141455.000052f0@huawei.com>
 <cc07dfc9-f58a-4654-8854-c16a2e85fecd@redhat.com>
 <20251110154957.5c481df7@fedora>
 <cad74549-a313-48b6-8260-f23f6be1e8c8@redhat.com>
 <20251111100746.00003136@huawei.com>
 <2440a0dd-6543-4590-9c0f-06b05bdfc8a4@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 11 Nov 2025 20:55:17 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Hi Jonathan,
> 
> On 11/11/25 8:07 PM, Jonathan Cameron wrote:
> > On Tue, 11 Nov 2025 14:08:13 +1000
> > Gavin Shan <gshan@redhat.com> wrote:  
> >> On 11/11/25 12:49 AM, Igor Mammedov wrote:  
> >>> On Thu, 6 Nov 2025 13:15:52 +1000
> >>> Gavin Shan <gshan@redhat.com> wrote:  
> >>>> On 11/6/25 12:14 AM, Jonathan Cameron wrote:  
> >>>>> On Wed,  5 Nov 2025 21:44:49 +1000
> >>>>> Gavin Shan <gshan@redhat.com> wrote:
> >>>>>         
> >>>>>> In the situation where host and guest has 64KiB and 4KiB page sizes,
> >>>>>> one problematic host page affects 16 guest pages. we need to send 16
> >>>>>> consective errors in this specific case.
> >>>>>>
> >>>>>> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
> >>>>>> hunk of code to generate the GHES error status is pulled out from
> >>>>>> ghes_gen_err_data_uncorrectable_recoverable(). The status field of
> >>>>>> generic error status block is also updated accordingly if multiple
> >>>>>> error data entries are contained in the generic error status block.
> >>>>>>
> >>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>  
> >>>>> Hi Gavin,
> >>>>>
> >>>>> Mostly fine, but a few comments on the defines added and a
> >>>>> question on what the multiple things are meant to mean?
> >>>>>         
> >>>>
> >>>> Thanks for your review and comments, replies as below.
> >>>>     
> >>>>>> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> >>>>>> index a9c08e73c0..527b85c8d8 100644
> >>>>>> --- a/hw/acpi/ghes.c
> >>>>>> +++ b/hw/acpi/ghes.c
> >>>>>> @@ -57,8 +57,12 @@
> >>>>>>     /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
> >>>>>>     #define ACPI_GHES_MEM_CPER_LENGTH           80
> >>>>>>     
> >>>>>> -/* Masks for block_status flags */
> >>>>>> -#define ACPI_GEBS_UNCORRECTABLE         1
> >>>>>> +/* Bits for block_status flags */
> >>>>>> +#define ACPI_GEBS_UNCORRECTABLE           0
> >>>>>> +#define ACPI_GEBS_CORRECTABLE             1
> >>>>>> +#define ACPI_GEBS_MULTIPLE_UNCORRECTABLE  2
> >>>>>> +#define ACPI_GEBS_MULTIPLE_CORRECTABLE    3  
> >>>>>
> >>>>> So this maps to the bits in block status.
> >>>>>
> >>>>> I'm not actually sure what these multiple variants are meant to tell us.
> >>>>> The multiple error blocks example referred to by the spec is a way to represent
> >>>>> the same error applying to multiple places.  So that's one error, many blocks.
> >>>>> I have no idea if we set these bits in that case.
> >>>>>
> >>>>> Based on a quick look I don't think linux even takes any notice.  THere
> >>>>> are defines in actbl1.h but I'm not seeing any use made of them.
> >>>>>         
> >>>>
> >>>> I hope Igor can confirm since it was suggested by him.
> >>>>
> >>>> It's hard to understand how exactly these multiple variants are used from the
> >>>> spec. In ACPI 6.5 Table 18.11, it's explained as below.
> >>>>
> >>>> Bit [2] - Multiple Uncorrectable Errors: If set to one, indicates that more
> >>>> than one uncorrectable errors have been detected.
> >>>>
> >>>> I don't see those multiple variants have been used by Linux. So I think it's
> >>>> safe to drop them.  
> >>>
> >>> even though example describes 'same' error at different components,
> >>> the bit fields descriptions doesn't set any limits on what 'more than one' means.
> >>>
> >>> Also from guest POV it's multiple different pages that we are reporting here
> >>> as multiple CPERs.
> >>> It seems to me that setting *_MULTIPLE_* here is correct thing to do.
> >>>      
> >>
> >> I don't have strong opinions. Lets keep to set _MULTIPLE_ flag if Jonathan
> >> is fine. Again, this field isn't used by Linux guest.  
> > I don't care strongly.  Maybe we should ask for a spec clarification as I doubt
> > implementations will be consistent on this given the vague description and that
> > Linux ignores it today.
> >   
> 
> Google Gemini has the following question. If it can be trusted, it should be
> set when @num_of_addresses is larger than 1.
> 
> Quota from Google Gemini:
> 
> The system firmware sets this bit to indicate to the Operating System Power Management (OSPM)
> that more than one correctable error condition has been detected and logged for the associated
> hardware component since the last time the status was cleared by the software. This is crucial
> because a high frequency of correctable errors often indicates a potential underlying hardware
> issue that could lead to uncorrectable (and potentially fatal) errors if not addressed (e.g.,
> in memory, where multiple correctable errors might trigger a spare memory operation).
> 
> >>  
> >>>>>> +#define ACPI_GEBS_ERROR_DATA_ENTRIES      4  
> >>>>>
> >>>>> This is bits 4-13 and the define isn't used. I'd drop it.
> >>>>>         
> >>>>
> >>>> The definition is used in acpi_ghes_memory_errors() of this patch. However,
> >>>> I don't see it has been used by Linux. This field isn't used by Linux to determine
> >>>> the total number of error entries. So I think I can drop it either if Igor is ok.
> >>>>     
> >>
> >> Lets keep this field either in next revision if Jonathan is fine.  
> > 
> > I'm fine with the field, but not the value.  As far as I can tell form the spec, it should
> > be a mask, not a single bit.
> >   
> 
> Agreed, lets keep ACPI_HEST_ERROR_ENTRY_COUNT as zero in next revision.

I'm even more confused now.  The GEBS Error Data entry count should be field from 13:4
and the value taken should be the number of entries in the record, so 1, 4, 16 depending
on the page size.

So that define of the value 4 is garbage. If it were DATA_ENTRIES_SHIFT then I'd be much happier.


> 
> Thanks,
> Gavin
> 
> 


