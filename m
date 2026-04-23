Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6D3F94CDC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 06:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFo1l-0001bc-EY; Thu, 23 Apr 2026 02:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wFo1g-0001bC-Qn; Thu, 23 Apr 2026 02:59:05 -0400
Received: from mail-westus2azon11012061.outbound.protection.outlook.com
 ([52.101.48.61] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wFo1e-0004Ir-77; Thu, 23 Apr 2026 02:59:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcNzmuVQKjjeNofd1c0hnAjKCY29OKk/IZFUcHfJ0k7TDUZtmmo4SzzdSzcM4Ph/j5HlxvDIvvnHYMs8ltmSbG/A0aHcK19mk9y922d0XD/xaDSU+Jiz+WQz65WU0ZzIo+LdCfhCR0ZvAM38AHQHuBUIB8XMFERUO1kvoPNey3WJYypqqbSbiGUz8oK176d/SLiUm4FeyjCf67Ab4ySd14QOIcHO7tFy/EwTJATxv+aUqO9CyX51Yn6G0U2XeeGJfjTTO9BAaylWWo1slCDmnk1g489s5urL5oo6qMcLbxIJfzLV6sS3El4zY6bfoIlFCQMeD+CrX611SCtg5vBpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyJ9tmiHKSc2uRRfJof2iKwtdqnQQWXuQq9vvkbkSn0=;
 b=Y2Yn1MzgPSRnaM3hScSUIjsLTVqwjnGpARNf0UhsKEJsiQagbu7GAMIoHTJiRZbt3Pi2wLmhEiHD3eynpRaM5Y8KMNs/yCoutBFrOIqfdoD4MJ3k0MZsTF1YG8EybIWQ4SmNHiUFvaDVQADtR90q8yxkdVSqV5EXiJr5Z8R/pxlotXX7uH/scvUXqtT2KxfYoM3b9QmK3E9UzuyvS3CSHMEZ5wuaSUGpGWy0TcAANxrQ4GDl2w4DXJVHqqod7/Z6Pd/W4sLE4Q4R29UF/sygphA8vyAfzMkvUQD06t9tN+i9BOVBtCfimaz6hfweLoK+jwu+Z1mRGwWeZ8oyNeekgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.55.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyJ9tmiHKSc2uRRfJof2iKwtdqnQQWXuQq9vvkbkSn0=;
 b=GdUZfWOGVfsQKz68bKqDiXx98af79QdQP6ra6nG1PFlV0kQm5LD+THivekhOHTK3qQBC9VPEXu9O45X9vi9rBEJdgDetaQGyeaqVDXEjUcmCQ5ZTMvxvVtfL3iDhlTZjbOci/CaTLNYFKqagmJx93biOqJxnytyFn1o1JqZ78Lo=
Received: from CH2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:610:50::30)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 06:53:53 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::cd) by CH2PR16CA0020.outlook.office365.com
 (2603:10b6:610:50::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 06:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.55.251) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.55.251 as permitted sender)
Received: from satlexmb07.amd.com (165.204.55.251) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 06:53:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 23 Apr
 2026 01:53:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Apr
 2026 01:53:51 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Apr 2026 01:53:50 -0500
Date: Thu, 23 Apr 2026 08:53:49 +0200
From: Luc Michel <luc.michel@amd.com>
To: Thomas Huth <thuth@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 2/6] hw/core/register: add the REGISTER_ARRAY type
Message-ID: <aenBv7JowYFfHpMX@XFR-LUMICHEL-L2.amd.com>
References: <20251017161809.235740-1-luc.michel@amd.com>
 <20251017161809.235740-3-luc.michel@amd.com>
 <86c40a92-76d0-4121-9347-929cfcd32f2a@redhat.com>
 <9eb1d421-2183-4093-bd93-ab015414bceb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eb1d421-2183-4093-bd93-ab015414bceb@redhat.com>
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a00620-7de7-41c6-2266-08dea1051520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: EHTTG7cCaUrMKb+jL1vlNu62i+7uUrDjEm4KIWszFNaMKtVboLH96QzbGudVTNpJSRObiIhJcfqmEe0/cjpofRLb/eSf6b4H0RIZDa4G2rGB6Yket3aIb/83+Svum5aXxrG2txqhrZgYeIJlTM3v+VofzmOAZ8bkp1Oa6EusXdNjyt4dJl+EYHdaC3TeKlws7n61rQubFGGomhiMs6svah05bnhXpbzIreQxdqwmzUXPDcJBvhHAkOnMv0sZsEl0q1hbZEOsWduIepMO2Mh/3967p/7lV4cIkmredvd6JkNXNn6+GlQkCBHvVqf2ZbUAYQapdpdEfBLKHrdR4TK5uQa9gBPfmU5jzWDJAA62THkTNnVB/er14hv2zVMkBoCUCnA5wpDediTlah7bRnU3T9HsB+rfp5wfo+dp25ia+2hKXGBy2hxJHJIFAM+dyjjyfSco36vNZH5ezpFGRVAbxYMm86dBQAr96QvshRs1wKa+YbzyGdqLhOa7aEQrzEMloUGoe3kdqG0BugrGWxe5dAKGyXdjlL56KtxEp5tQ6i+hua8aPfs/p/VjUGa5DRkF41m4PjpKQVSqvVlQ+dw9ryelNDdoImRW0NL1SO35hvVZ+u1pYiYPa5eom0hwEvk9iRyd6jtCK/R4tXNKRoZnugy6dcgRMOR9yA/8CqWsGBNA5F6rJLhGrKxBIq9Q91FWXZUnerWdXEN6vDQvmLEXobe1hkbz5+iGLPjOwKHjxS1YgB6sRVqwGXW+CLyzc+h7TTLa9VpchlhBxrkErClxVVMXJPV6tPvrVEPHFQDHUC4=
X-Forefront-Antispam-Report: CIP:165.204.55.251; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(13003099007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q549dHILmz6+aQI8fAVhfdwlc68xUQS3HNOnOpk+rMfmEIFURC1f7L297LtdN7CxlWPdYeWnqzxWxmi1ot1ZJUwUvUdq9aUq636qtUsNNPuHdF+XdX4PLQLwSoHuh6VAropPKLkwc3rpizwxfWH/0nBtAb02oHqQ060h5bfiFtpMCV2RVNyzpWefg1hkB9R2ovO32UJ6OjbT6RExrOCJ7/ceOzvitszj7FpeB5sDtH8QWyUHKAKUfGoobT9LuRr+gUpLZ7I3F3tnuuSxQ7LWrqz5qpGA7+nebC54eLdvcSn+e8AnPsXhpNEKEN+5LqySzsxWG3JBaDD+OnVGQkFsiPPiPUDifkZtIJZVuVUenIgTan/n8TS878vOfXeMbYlAiQmy3qbTsZbyzggfRss9Ko4gpAXFQTF5g7VUC0k1qZPsgEv+LzmEOqiMdNI5LBn7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 06:53:53.1646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a00620-7de7-41c6-2266-08dea1051520
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.55.251];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
Received-SPF: permerror client-ip=52.101.48.61;
 envelope-from=Luc.Michel@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hi Thomas,

On 13:06 Wed 22 Apr     , Thomas Huth wrote:
> On 22/04/2026 12.56, Thomas Huth wrote:
> > On 17/10/2025 18.18, Luc Michel wrote:
> > > Introduce the REGISTER_ARRAY QOM type. This type reuses the existing
> > > RegisterInfoArray struct. When `register_init_block' is called, it creates
> > > a REGISTER_ARRAY object and parents it to the calling device. This way
> > > it gets finalized when the device is. The memory region is parented to
> > > the REGISTER_ARRAY object to ensure correct finalizing order.
> > > 
> > > The finalize function of the REGISTER_ARRAY type performs the necessary
> > > cleaning that used to be done by `register_finalize_block'. The latter
> > > is left empty and will be removed when all the register API users have
> > > been refactored.
> > > 
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> > > Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > > ---
> > >   include/hw/register.h |  4 ++++
> > >   hw/core/register.c    | 26 ++++++++++++++++++++++----
> > >   2 files changed, 26 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/hw/register.h b/include/hw/register.h
> > > index 4d13ea183c7..65c82600e06 100644
> > > --- a/include/hw/register.h
> > > +++ b/include/hw/register.h
> > > @@ -81,10 +81,12 @@ struct RegisterInfo {
> > >       const RegisterAccessInfo *access;
> > >       void *opaque;
> > >   };
> > > +#define TYPE_REGISTER_ARRAY "qemu-register-array"
> > > +OBJECT_DECLARE_SIMPLE_TYPE(RegisterInfoArray, REGISTER_ARRAY)
> > >   /**
> > >    * This structure is used to group all of the individual registers
> > > which are
> > >    * modeled using the RegisterInfo structure.
> > >    *
> > > @@ -94,10 +96,12 @@ struct RegisterInfo {
> > >    *
> > >    * @mem: optional Memory region for the register
> > >    */
> > >   struct RegisterInfoArray {
> > > +    Object parent_obj;
> > > +
> > >       MemoryRegion mem;
> > >       int num_elements;
> > >       RegisterInfo **r;
> > > diff --git a/hw/core/register.c b/hw/core/register.c
> > > index 2553cb15aba..1612ad174f9 100644
> > > --- a/hw/core/register.c
> > > +++ b/hw/core/register.c
> > > @@ -243,14 +243,20 @@ static RegisterInfoArray
> > > *register_init_block(DeviceState *owner,
> > >                                                 bool debug_enabled,
> > >                                                 uint64_t memory_size,
> > >                                                 size_t data_size_bits)
> > >   {
> > >       const char *device_prefix = object_get_typename(OBJECT(owner));
> > > -    RegisterInfoArray *r_array = g_new0(RegisterInfoArray, 1);
> > > +    Object *obj;
> > > +    RegisterInfoArray *r_array;
> > >       int data_size = data_size_bits >> 3;
> > >       int i;
> > > +    obj = object_new(TYPE_REGISTER_ARRAY);
> > > +    object_property_add_child(OBJECT(owner), "reg-array[*]", obj);
> > > +    object_unref(obj);
> > > +
> > > +    r_array = REGISTER_ARRAY(obj);
> > >       r_array->r = g_new0(RegisterInfo *, num);
> > >       r_array->num_elements = num;
> > >       r_array->debug = debug_enabled;
> > >       r_array->prefix = device_prefix;
> > > @@ -265,11 +271,11 @@ static RegisterInfoArray
> > > *register_init_block(DeviceState *owner,
> > >           r->opaque = owner;
> > >           r_array->r[i] = r;
> > >       }
> > > -    memory_region_init_io(&r_array->mem, OBJECT(owner), ops, r_array,
> > > +    memory_region_init_io(&r_array->mem, OBJECT(r_array), ops, r_array,
> > >                             device_prefix, memory_size);
> > 
> >   Hi,
> > 
> > this likely broke the xlnx-versal-ospi device, see:
> > 
> >   https://gitlab.com/qemu-project/qemu/-/work_items/3422
> 
> And also:
> 
>  https://gitlab.com/qemu-project/qemu/-/work_items/3421
> and
>  https://gitlab.com/qemu-project/qemu/-/work_items/3423

Let me have a look and come back with a series to fix those.

> 
> ... I wonder why nobody noticed this before? Are these corresponding
> machines completely unused nowadays? At least we seem to lack a proper
> functional test for those...

tests/functional/aarch64/test_xlnx_versal.py does exist but needs some
improvements to better cover those machines.

Thanks

Luc

> 
>  Thomas
> 

-- 

