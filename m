Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF8FC47258
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 02:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTBtE-0001iC-E9; Thu, 25 Jan 2024 21:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rTBtC-0001hW-SO; Thu, 25 Jan 2024 21:24:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rTBtA-0005F2-8B; Thu, 25 Jan 2024 21:24:18 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40Q2Ff23013790; Fri, 26 Jan 2024 02:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7+9uKUxs5zcDFJ/i1yJt1HRGPqg6F7VQcSPisQb3l2k=;
 b=E017FOw2+VYHte2VKDAocYwO1b9dBnQleGqfsmk5E+t1FnHaxLjGEoEkxHx3T4FeWs/J
 JprWmp8NaEXKlhZRMMYQZ55rmxaN1akdsUD/ZIObeZ68xhvU0Yyix0WttpnwQSiJ6bMr
 Vg6Voj+E7MdCbal0m7U8TK8GBuImHHzwi1kiM2kcNm4jU+ghUi4j1ppJZPI9O83h6QHE
 ftIn6j56KTmk/2BikU8USuA/0DAYBIvucBRxAsFQU9fUsK3dp+NrjKes3Ppyd5qVwYPJ
 On/sqYZi8HLgfDiEHGZYgnCG4tajqi0aPY4zpQlH9yjUVUlEH3BIRrLj4/cYn7HqOqCZ 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv2v498ak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 02:23:54 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40Q2FhmS014112;
 Fri, 26 Jan 2024 02:23:54 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv2v498a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 02:23:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40Q0JKYv026505; Fri, 26 Jan 2024 02:23:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgtrexh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 02:23:53 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40Q2NqPt20513402
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jan 2024 02:23:52 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E1035804E;
 Fri, 26 Jan 2024 02:23:52 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCA285803F;
 Fri, 26 Jan 2024 02:23:50 +0000 (GMT)
Received: from [9.61.160.70] (unknown [9.61.160.70])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jan 2024 02:23:50 +0000 (GMT)
Message-ID: <bac265f2-1a16-4631-be94-4e31541b82e1@linux.ibm.com>
Date: Thu, 25 Jan 2024 20:23:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/9] hw/fsi: Aspeed APB2OPB interface, Onchip perif bus
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20240110231537.1654478-1-ninad@linux.ibm.com>
 <20240110231537.1654478-6-ninad@linux.ibm.com>
 <329ba3d9-f61a-40ed-b069-d8da7e42924e@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <329ba3d9-f61a-40ed-b069-d8da7e42924e@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gic8tqq2YLP5xIoMBLYAcHaMd72smnIP
X-Proofpoint-ORIG-GUID: k41qrfFtaEZeG5iKj3pNpSX2ORvjwq-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Cedric,


>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> Nah. Joel you should re-review next respin :)
Removed Joel's review tag.
>
>>
>> ---
>>   include/hw/misc/aspeed-apb2opb.h |  50 +++++
>>   hw/misc/aspeed-apb2opb.c         | 338 +++++++++++++++++++++++++++++++
>
> As said in the cover letter, I think now that hw/fsi is a better place
> for these files and should be compiled if CONSG_ASPEED_SOC. Sorry about
> that. Also,please use 'aspeed_' for the file names.
Transferred to the old location and rename with "aspeed_" prefix.
>
>>
>> +
>> +#define TYPE_OP_BUS "opb"
>> +OBJECT_DECLARE_SIMPLE_TYPE(OPBus, OP_BUS)
>> +
>> +typedef struct OPBus {
>> +        /*< private >*/
>
> please remove the private and public comment.
Removed.
>
>> +        BusState bus;
>> +
>> +        /*< public >*/
>> +        MemoryRegion mr;
>> +        AddressSpace as;
>
> indent is wrong.
Fixed indent.
>
>>
>> +static void fsi_aspeed_apb2opb_init(Object *o)
>> +{
>> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(o);
>> +    int i;
>> +
>> +    for (i = 0; i < ASPEED_FSI_NUM; i++) {
>> +        qbus_init(&s->opb[i], sizeof(s->opb[i]), TYPE_OP_BUS, 
>> DEVICE(s),
>> +                  NULL);
>
> See comment in fsi_opb_init()
Moved it to si_aspeed_apb2opb_realize(),
>
>> +    for (i = 0; i < ASPEED_FSI_NUM; i++) {
>> +        if (!qdev_realize(DEVICE(&s->fsi[i]), BUS(&s->opb[i]),
>> +                errp)) {
>
> this could be a single line.
Removed extra line.
>
> Please remove the comments below, I am not sure they are valid
> anymore.
Removed the comment.
>
>> +        /*
>> +         * Avoid endianness issues by mapping each slave's memory 
>> region
>> +         * directly. Manually bridging multiple address-spaces 
>> causes endian
>> +         * swapping headaches as memory_region_dispatch_read() and
>> +         * memory_region_dispatch_write() correct the endianness 
>> based on the
>> +         * target machine endianness and not relative to the device 
>> endianness
>> +         * on either side of the bridge.
>> +         */
>> +        /*
>> +         * XXX: This is a bit hairy and will need to be fixed when I 
>> sort out
>> +         * the bus/slave relationship and any changes to the CFAM 
>> modelling
>> +         * (multiple slaves, LBUS)
>> +         */
>> +        memory_region_add_subregion(&s->opb[i].mr, 0xa0000000,
>> +                &s->fsi[i].opb2fsi);
>> +    }
>> +}
>>
>> +
>> +static void fsi_opb_init(Object *o)
>> +{
>> +    OPBus *opb = OP_BUS(o);
>> +
>> +    memory_region_init_io(&opb->mr, OBJECT(opb), NULL, opb,
>> +                          TYPE_FSI_OPB, UINT32_MAX);
>
> This is better :
>
> memory_region_init(&opb->mr, o, TYPE_OP_BUS, UINT32_MAX);
Changed it as per your suggestion.
>
>
>> +    address_space_init(&opb->as, &opb->mr, TYPE_FSI_OPB);
>
> This routine is problematic. If you run 'make check', you should see
> test tests/qtest/device-introspect-test crash in weird way because of
> a memory corruption. I didn't dig into the details but I suppose this
> a use after free problem.
>
> To solve, we should move qbus_init() done in fsi_aspeed_apb2opb_init()
> under fsi_aspeed_apb2opb_realize(), or improve the model a litle more.
>
> It seems we are lacking the OPB/FSI bridge :
>
> typedef struct OPBFSIBridge {
>     DeviceState parent;
>
>     OPBus opb;
>     FSIMasterState fsi;
>     MemoryRegion mr;
>     AddressSpace as;
> } OPBFSIBridge;
>
> Something like that. It is difficult to understand the design from
> the OpenFSI specs. The OPB bus seems overkill. It you could clarify
> this aspect, it would be nice.

For now moved qbus_init() to fsi_aspeed_apb2opb_realize(). I will run 
make check.

Thanks for the review.

Regards,

Ninad



