Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B55C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 08:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYM0D-0001Oi-SE; Fri, 09 Feb 2024 03:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rYM0B-0001O6-Lq
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 03:12:51 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rYM08-0005k0-M6
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 03:12:51 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4193UESe002778; Fri, 9 Feb 2024 00:12:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:from:to:cc:references
 :in-reply-to:mime-version; s=proofpoint20171006; bh=7ZQVLNhDp9Q3
 dvkOM25H8yPBvDIU8PnEY7yXRc7P+dU=; b=btBInEs2G7uOVc2lhjQApomqvLjy
 YD13zUpyu8qOIddpGAOfhQfn5QMMXQT2cGH8kiQRyO9g2QmRpXaxD+kdBdUtW0pm
 FO1P2RHhTe8ruUj7v75ANHFeWvAF+oTOnm2u9LCMJgEZxoNXWysMbZm3dyiXtu5U
 HmIc6zJDASlPvLhMW5JP2EIiahywJ6ndwRcYw1u+XpST0HBSTulDZF2f3NWO58IN
 SXzVw8pm4bO3rWOoxcKG8F5JaeCbvUamYV3t1mamos9iyBRD6/tX1kP932w12A2E
 kmBBDZhlRKpTMLOobKNEIY6aMiJ+Ufax7yZkyCLG3xl1xx5NaPc0IDJ8JA==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3w1nx0m8mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Feb 2024 00:12:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKv9tu/WIYz8VUIvfol1LHttl0q7Lnl8aI/e3zdLHUp4cTIZeH+Dx2hjQrIZPrnsQWFApCxG/9OpsW+DitGwDXXJIvryr3p7yIok4yrjTyHBP4NCTOeFidu1N6VM/d5vqp1+nxAZbskhVsrEW3BKqoHnBYxaF2iJfD51CINwcrPv/9rsu36hD2O3FzUK29HKfsPx5z6fdXedjoXrIF+mFrHh4PfAqlyM4SKyTZJDfJVOjjdjt8Hz1yc3Sqa3XPQn1w5thPBgdwNjk+T30loXckay2nVcyjf8IX6QjXHV6J9W1ra+5aJ4y/HTGrB6Cch11oD5ude+AfHG8VswS/gFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZQVLNhDp9Q3dvkOM25H8yPBvDIU8PnEY7yXRc7P+dU=;
 b=NfNLmu51TPUotaWSmPoXwU+9WpnLcPgDdcMUPa6OcWNjha1LWE8rvpT9IUF9sXbPr/pz0wMB1XIQbZ0bPPbu2HYzCrT8wqf4QgoVKtndN30zd3fiNtGTAsgDIfI6bdJZ1l4Oj8lmihScrkQj36BmiKFcHLTn3nqXFNuDZjGQLZgDaQJ3J9NC6gNxQHybP79pWwOVxrTOS8yIx2vft/OL3y9xzorZUV8b7XysgXqbudnZue2Dpk+grYfLrd/cPLtPGKkfV0mVLToOC5bF05YOI29nu4RWD2v/kMiEK64sOgvrcdyecGdlXM1nFfmdyM098klAq8RbbgV4qIUcZ9FKow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZQVLNhDp9Q3dvkOM25H8yPBvDIU8PnEY7yXRc7P+dU=;
 b=xgd16C43rhlDxHKbSOXnIenFkPJ9B5034G096GHiOyi5SJ96DtPgAewEqzqWrHByJy9oitoAegVIJD0Ui2II1xcqyi53juvKCBQnUDp43Rvt/Fht+3xp2Uur/xzVetZ4Zdmok2yVxLUPDID2Ei/kIU/Gk1RlPbsdD/XXFVXJqjHTPx17CvjXZsNqPTpDRFUnoBD/6ztXDrQDsUZrh5tc3P/qnTmB7xZsoLdDPb+w6SlylvYn1V+xtb9ijm9u5EWA8zkAmEfzUUDTP3S9CJvtkyY4rkZoTZ9E9JX28obmkAh3Lp601GnW9mXAZsgZ+IrZhvn8ZzDqe5JWClA88MzaUg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SA3PR02MB9277.namprd02.prod.outlook.com (2603:10b6:806:31c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 08:12:41 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 08:12:41 +0000
Content-Type: multipart/alternative;
 boundary="------------55lkpdRStfF2NxdMOGk1a3n0"
Message-ID: <6be21f72-35e6-4b4a-a670-51465c12c0ac@nutanix.com>
Date: Fri, 9 Feb 2024 13:42:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qtest: migration: Add failure test for 'uri' and
 'channels' combination in 'migrate' QAPI
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peterx@redhat.com, farosas@suse.de
References: <20240209075128.226237-1-het.gala@nutanix.com>
 <42395f38-d3e6-43a6-97eb-7f5cd6c2b3f3@nutanix.com>
In-Reply-To: <42395f38-d3e6-43a6-97eb-7f5cd6c2b3f3@nutanix.com>
X-ClientProxiedBy: MAXP287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SA3PR02MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 5adcfcb5-2388-4daf-36dc-08dc2946e2c1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVvLC5Nzy5NNcL5oxFdtXb1DVZK5tvQ/rMzN0xFU5jKtc19SplCGtbxCv6XIyKjdvWb32RH3AjDlCPSO+ExVPtFlrX408B2Ec2NEKAcPc+nAkL3tBvLfWBllxoOmmGm8Bg+7hgqawI2a9VT8bk9CQo2grfS486EPcGKmzET9m5glBHWENlZSGBTKB1fXQoiGbgkaVJOz0jsNwuY3I8vC8XSVf1MYgf5lCFGclIwElrAEF9wvCcafo/4e17zDAeJKIhVAG943kyDg4OLPjHkMafV+m0nwJ4XlB91BByMcqvNH/1VdRWB2cwFnr0A8uNHCfwNrU/DU4jqQrRoQhHvyYXb/IxjQirfm9M7psFKm1vD1r9HKfsnA/6kCItsiXleoq+3iDxyV5zhDKf6AAGaObSjLxclDui0SH93MklqxDJAS02mPM8GP+90Mxwy99y0X8IydwPkEnu7Z7ZDmypSoiU5S+a3hCyEZkzXFb6bHcBd+pUxJQI+y5EpCrhd5Y2UnM+RtB/9sfVxz6qz0tA01J06u1vWMvckfc4zx2rmVSDaPgFMXVpmQVnxg35MIwC0K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(6486002)(6506007)(31686004)(41300700001)(66899024)(30864003)(2906002)(5660300002)(44832011)(6916009)(316002)(36756003)(53546011)(33964004)(66946007)(66476007)(6666004)(66556008)(8936002)(8676002)(4326008)(26005)(6512007)(83380400001)(31696002)(86362001)(38100700002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXpjb2hzY0M2M3NwK2RXRHplNXk0L2FsUThmYkFNTllzS0h5WFd1WnJ2ZkFq?=
 =?utf-8?B?NHlkM1c2eXdIM2Z4ZG1jRTBranp0UTR1MjFhRGxpVkNUcDZ6K1hHd3pLcHZR?=
 =?utf-8?B?NndxRnNXVHIzSUZoM3FrQ3NISFl1aGt2a3lPU2pVeVJoTE90dHJjbnBZQmlH?=
 =?utf-8?B?Vjkwd0FFY2pYbEo5SzhXMkYwZFVJQjRMVndkTnVteENMdTVVUHpXS01PdTNv?=
 =?utf-8?B?eTl0UkJoVzJEa3dvOVRqWnFuYjg2YUl4UDdnMGwxNm54TTFoSGVVVmhQcStG?=
 =?utf-8?B?SWdLWFQrVnNJRXphL1pjZTVmaTYzVjl6anNrOUpocDRLbXYwNDBLL2Q5OHRq?=
 =?utf-8?B?RW9zcDBTcVJtYjZUdmJ6OEFZc3ZXUkJUWHlKVmlIUDRhN2xsUGFLSzI3TnY1?=
 =?utf-8?B?OVNtSEFVclhPZkQ5RXhFbjRJVytVKzBiZTJyM3VnSlAydG42N1E3Tis4VlRv?=
 =?utf-8?B?cmRUTGh6a3AvQXppc0RuRWc3SzZkT3NvUFVaT2U0OFVkeE9IYzc2akFDcm9F?=
 =?utf-8?B?b2JoMkJpT3ZSL2FLYkcvcHhYVGhtWVRibXY5a2dzUDAyOSt1Z250OEJ6T2dX?=
 =?utf-8?B?S1hkSmw1NTl4ZnVoZ1BkVVZ5WVVMQ2w0U0J1bnV4Zk9Rbi9OeXFscENVOVRU?=
 =?utf-8?B?bmpTRiticVY4S3Vldkw3bkFTMVNZbTMxQVZVMDQzb0dvUVNwNGg4eHFJUnV4?=
 =?utf-8?B?MGp4Wmg3N2pwdDg3dWZtUDJDc25kbHVML0VQa3hFR29zVmZSVDZWSEhkY0hs?=
 =?utf-8?B?b1lMZjZJMVYvclNIUFNlM05iSDFpZUQvemF2Z2U0UHdqOUhFdXhnMjJKbGpn?=
 =?utf-8?B?SDBMYVp4SXF1azNuMGZWUFdiQ3EvQnJNMlpXSlozVnhVNktBTmtJYnp0aitk?=
 =?utf-8?B?a29TeW55Rzd3SGJnbjNFM2Yyb2JuSGpXWFEzVzZNN1dQVEhmTDlPUHBaMGRH?=
 =?utf-8?B?VG1PVzI2ZzVZMVkyQjk1SWgzb2tGd3BNakg5UzIyYVNHQTJlbmpoYXRkL1Fy?=
 =?utf-8?B?NTQremk2VnNtaytFMlZ0YjNjRzYxTDNoVCtaR3BsWm9RTEc2MDFVWDFSb080?=
 =?utf-8?B?Vk84WFpIcHRKaStiTlJGUGhaRnA0N3J0OWIrRjRlbGdreG5DRFVsdmtCOWZO?=
 =?utf-8?B?TTJDZVV2eE5wMVlaVHpPdVB4MmJOU3YvTllqZWc4d09MUmFIVHBWMFc4NzB1?=
 =?utf-8?B?L2Y2TUtzYVVJaEFyVG96b2FibENvNEgvMFd6WmRVSzNDaThDTnZjckJ5NXQx?=
 =?utf-8?B?eEdUNy8rZHA0Tk1ETnRrVkx6dDJDaml1azFJVGJoUzI0QmovTU1LbGl1ejJM?=
 =?utf-8?B?NFdLRWhaYlFzZURzbFpQYXc4emdCMU9zdVNnYWtsREplRC9xNnBDQlVHRWJ5?=
 =?utf-8?B?RXpVd3pkREpvT0MzYmc2bWMyV1IyNVRMK25sQWhxQ1BTU0lTTnRpWllvZ2hS?=
 =?utf-8?B?cmdQZGJuRGtNTnlWQjRmeUhpSEROUXZFTVVMTFFiSUwyWHRyTXNjaFlwRDJ0?=
 =?utf-8?B?R2FWZkJNYlZoaEhuUC9wZ1ltbll3V0pTVHhZRFQxWkFZaW9mRXpITm1yeVps?=
 =?utf-8?B?Ym9SUmZJRzIwNFlVRXRDQkFQVGhKbmpnQ0l6eFhIVGZnTU1BMjNIM0JjaUtn?=
 =?utf-8?B?RW10U2RpQXhjTmVKOVo4YWozWFkzTzRFdEdqakw5ZnpzK3RkcXNWVmgwY1J4?=
 =?utf-8?B?TUxUSG5PRUo3elluYUZ6VUxKODZIcHMxQXlTRm5hZTgvbUhqL2NiRG9qaDVE?=
 =?utf-8?B?NVNQWmlheUJQcUNsaEVqeWRuL0tEeTRsVDRwd1d6cmRkZ2FLcDd5UzE2eG84?=
 =?utf-8?B?NCtjVDRlU1ArMEpVemE2ZitPSGN2Ylg3aGd1Y3pmVjRxd0xyV3YxMFRvY0RI?=
 =?utf-8?B?K0U4WlZHa1k3Rmo3MDgveGhFV3MrK0RaSXBRQ3Z4NTNYMld2Z3RsUGJSTkU0?=
 =?utf-8?B?M2JlVDdKZEhZZUxBSFJCNTV2Q1k5OStiS0U3aUdpYmZjMHdndUllQ1Y5aTMv?=
 =?utf-8?B?b1R2WGx5N083OFg3MnpnMENuYVJFYkFILzI1Z014NmZPd2ZwSWRSWFRsQkN4?=
 =?utf-8?B?YlFJazg5WE10VkI5aWpBMWFKbk8wWTNMY0ovS1drQzdlRVFSYUtkMHY1S0I2?=
 =?utf-8?Q?nhk7y5BYutrk1E5r5+kUkfr6W?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adcfcb5-2388-4daf-36dc-08dc2946e2c1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 08:12:41.1664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzTIuZYNA+x4wR62PNOv0Yy2mUX3B4obbgsiYMCMd6u/SJIR/489KOBJ4KixTbRa5CWhYLRpDVTok5cvj4Yvnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9277
X-Proofpoint-ORIG-GUID: 7g1nN-kS-XEg3pvqHXQaM1FU86Bk2YH5
X-Proofpoint-GUID: 7g1nN-kS-XEg3pvqHXQaM1FU86Bk2YH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------55lkpdRStfF2NxdMOGk1a3n0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/02/24 1:33 pm, Het Gala wrote:
> I wanted to share an update regarding the patch I've been working on. 
> It seems that the patch is not yet fully ready as it encountered some 
> issues during the check-qtest builds.

Test fails with error:

55/59 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 ERROR           25.77s   killed by signal 6 SIGABRT
>>> G_TEST_DBUS_DAEMON=/rpmbuild/SOURCES/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon
QTEST_QEMU_IMG=./qemu-img PYTHON=/rpmbuild/SOURCES/qemu/build/pyvenv/bin/python3 QTEST_QEMU_BINARY=./qemu-system-x86_64
MALLOC_PERTURB_=71 /rpmbuild/SOURCES/qemu/build/tests/qtest/migration-test --tap -k
――――――――――――――――――――――――――――――――――――――――――――――― ✀  ――――――――――――――――――――――――――――――――――――――――――――――――
stderr:
Could not access KVM kernel module: No such file or directory
Could not access KVM kernel module: No such file or directory
Could not access KVM kernel module: No such file or directory
Could not access KVM kernel module: No such file or directory
Could not access KVM kernel module: No such file or directory
Could not access KVM kernel module: No such file or directory
Broken pipe
../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)

(test program exited with status code -6)

TAP parsing error: Too few tests run (expected 21, got 7)

>
> This is my first attempt at writing a test case related to migration, 
> and I'm aware that there may be areas where I could use some guidance. 
> If there are any gaps in my understanding of how to properly mock a 
> migration or if there are any other issues with the test case, I would 
> greatly appreciate your assistance. I'm also struggling to understand 
> why the test is failing. If anyone could provide some insight or 
> assistance with troubleshooting, it would be greatly appreciated.
>
> I've cc'd Fabino, Daniel, as I believe they may have expertise in 
> migration testing and could offer some valuable insights.
>
> Thank you for your help with this, and I look forward to any feedback 
> or assistance you can provide.
>
> On 09/02/24 1:21 pm, Het Gala wrote:
>> Ensure failure occurs while adding validation test for 'uri' and 
>> 'channels' arguments
>> used simultaneously in the 'migrate' QAPI command.
>>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> ---
>>   tests/qtest/migration-helpers.c | 14 ++++++--
>>   tests/qtest/migration-helpers.h |  5 +--
>>   tests/qtest/migration-test.c    | 60 +++++++++++++++++++++++++++++++--
>>   3 files changed, 72 insertions(+), 7 deletions(-)
>>
>> diff --git a/tests/qtest/migration-helpers.c 
>> b/tests/qtest/migration-helpers.c
>> index e451dbdbed..2dbb01e413 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -43,7 +43,8 @@ bool migrate_watch_for_events(QTestState *who, 
>> const char *name,
>>       return false;
>>   }
>>   -void migrate_qmp_fail(QTestState *who, const char *uri, const char 
>> *fmt, ...)
>> +void migrate_qmp_fail(QTestState *who, const char *uri,
>> +                      const char *channels, const char *fmt, ...)
>>   {
>>       va_list ap;
>>       QDict *args, *err;
>> @@ -52,8 +53,15 @@ void migrate_qmp_fail(QTestState *who, const char 
>> *uri, const char *fmt, ...)
>>       args = qdict_from_vjsonf_nofail(fmt, ap);
>>       va_end(ap);
>>   -    g_assert(!qdict_haskey(args, "uri"));
>> -    qdict_put_str(args, "uri", uri);
>> +    if (uri) {
>> +        g_assert(!qdict_haskey(args, "uri"));
>> +        qdict_put_str(args, "uri", uri);
>> +    }
>> +
>> +    if (channels) {
>> +        g_assert(!qdict_haskey(args, "channels"));
>> +        qdict_put_str(args, "channels", channels);
>> +    }
>>         err = qtest_qmp_assert_failure_ref(
>>           who, "{ 'execute': 'migrate', 'arguments': %p}", args);
>> diff --git a/tests/qtest/migration-helpers.h 
>> b/tests/qtest/migration-helpers.h
>> index 3bf7ded1b9..d49e289c51 100644
>> --- a/tests/qtest/migration-helpers.h
>> +++ b/tests/qtest/migration-helpers.h
>> @@ -32,8 +32,9 @@ G_GNUC_PRINTF(3, 4)
>>   void migrate_incoming_qmp(QTestState *who, const char *uri,
>>                             const char *fmt, ...);
>>   -G_GNUC_PRINTF(3, 4)
>> -void migrate_qmp_fail(QTestState *who, const char *uri, const char 
>> *fmt, ...);
>> +G_GNUC_PRINTF(4, 5)
>> +void migrate_qmp_fail(QTestState *who, const char *uri,
>> +                      const char *channels, const char *fmt, ...);
>>     void migrate_set_capability(QTestState *who, const char *capability,
>>                               bool value);
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index d3066e119f..3aaffc2667 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -18,6 +18,7 @@
>>   #include "qemu/module.h"
>>   #include "qemu/option.h"
>>   #include "qemu/range.h"
>> +#include "migration/migration.h"
>>   #include "qemu/sockets.h"
>>   #include "chardev/char.h"
>>   #include "qapi/qapi-visit-sockets.h"
>> @@ -1773,7 +1774,7 @@ static void test_precopy_common(MigrateCommon 
>> *args)
>>       }
>>         if (args->result == MIG_TEST_QMP_ERROR) {
>> -        migrate_qmp_fail(from, connect_uri, "{}");
>> +        migrate_qmp_fail(from, connect_uri, NULL, "{}");
>>           goto finish;
>>       }
>>   @@ -1869,7 +1870,7 @@ static void test_file_common(MigrateCommon 
>> *args, bool stop_src)
>>       }
>>         if (args->result == MIG_TEST_QMP_ERROR) {
>> -        migrate_qmp_fail(from, connect_uri, "{}");
>> +        migrate_qmp_fail(from, connect_uri, NULL, "{}");
>>           goto finish;
>>       }
>>   @@ -2508,6 +2509,59 @@ static void 
>> test_validate_uuid_dst_not_set(void)
>>       do_test_validate_uuid(&args, false);
>>   }
>>   +static void do_test_validate_uri_channel(MigrateCommon *args, bool 
>> should_fail)
> Not sure if should_fail is of any value here. The test ideally should 
> not enter migration also. Should just fail even before making the 
> connection, at the QMP level itself. I added it here, by taking the 
> reference of validate_uuid tests.
>> +{
>> +    g_autofree const char *uri = "127.0.0.1:0";
>> +    g_autofree const char *channels = "{"
>> +               "   'channels': [ { 'channel-type': 'main',"
>> +               "                   'addr': { 'transport': 'socket',"
>> +               "                             'type': 'inet',"
>> +               "                             'host': '127.0.0.1',"
>> +               "                             'port': '0' } } ] }";
>> +    QTestState *from, *to;
>> +
>> +    if (test_migrate_start(&from, &to, uri, &args->start)) {
>> +        return;
>> +    }
>> +
>> +    /* Wait for the first serial output from the source */
>> +    wait_for_serial("src_serial");
>> +
>> +    /*
>> +     * 'uri' and 'channels' validation is checked even before the 
>> migration
>> +     * starts.
>> +     */
>> +    if (args->result == MIG_TEST_QMP_ERROR) {
>> +        migrate_qmp_fail(from, uri, channels, "{}");
>> +        goto finish;
>> +    }
>> +
>> +    migrate_qmp(from, uri, "{}");
>> +
>> +    if (should_fail) {
>> +        qtest_set_expected_status(to, EXIT_FAILURE);
>> +        wait_for_migration_fail(from, false);
>> +    } else {
>> +        wait_for_migration_complete(from);
>> +    }
>> +
>> +finish:
>> +    test_migrate_end(from, to, args->result == MIG_TEST_QMP_ERROR);
>> +}
>> +
>> +static void
>> +test_validate_uri_channel_both_set(void)
>> +{
>> +    MigrateCommon args = {
>> +        .start = {
>> +            .hide_stderr = true,
>> +        },
>> +        .result = MIG_TEST_QMP_ERROR,
>> +    };
>> +
>> +    do_test_validate_uri_channel(&args, true);
>> +}
>> +
>>   /*
>>    * The way auto_converge works, we need to do too many passes to
>>    * run this test.  Auto_converge logic is only run once every
>> @@ -3536,6 +3590,8 @@ int main(int argc, char **argv)
>>                          test_validate_uuid_src_not_set);
>>       migration_test_add("/migration/validate_uuid_dst_not_set",
>>                          test_validate_uuid_dst_not_set);
>> + migration_test_add("/migration/validate_uri_channel_both_set",
>> +                       test_validate_uri_channel_both_set);
>>       /*
>>        * See explanation why this test is slow on function definition
>>        */
--------------55lkpdRStfF2NxdMOGk1a3n0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 09/02/24 1:33 pm, Het Gala wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:42395f38-d3e6-43a6-97eb-7f5cd6c2b3f3@nutanix.com">I
      wanted to share an update regarding the patch I've been working
      on. It seems that the patch is not yet fully ready as it
      encountered some issues during the check-qtest builds.
      <br>
    </blockquote>
    <p>Test fails with error:</p>
    <pre>55/59 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ERROR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25.77s&nbsp;&nbsp; killed by signal 6 SIGABRT
&gt;&gt;&gt; G_TEST_DBUS_DAEMON=/rpmbuild/SOURCES/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon
QTEST_QEMU_IMG=./qemu-img PYTHON=/rpmbuild/SOURCES/qemu/build/pyvenv/bin/python3 QTEST_QEMU_BINARY=./qemu-system-x86_64
MALLOC_PERTURB_=71 /rpmbuild/SOURCES/qemu/build/tests/qtest/migration-test --tap -k
――――――――――――――――――――――――――――――――――――――――――――――― ✀&nbsp; ――――――――――――――――――――――――――――――――――――――――――――――――
stderr:
Could not access KVM kernel module: No such file or directory
Could not access KVM kernel module: No such file or directory
Could not access KVM kernel module: No such file or directory
Could not access KVM kernel module: No such file or directory
Could not access KVM kernel module: No such file or directory
Could not access KVM kernel module: No such file or directory
Broken pipe
../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)

(test program exited with status code -6)

TAP parsing error: Too few tests run (expected 21, got 7)
</pre>
    <blockquote type="cite" cite="mid:42395f38-d3e6-43a6-97eb-7f5cd6c2b3f3@nutanix.com">
      <br>
      This is my first attempt at writing a test case related to
      migration, and I'm aware that there may be areas where I could use
      some guidance. If there are any gaps in my understanding of how to
      properly mock a migration or if there are any other issues with
      the test case, I would greatly appreciate your assistance. I'm
      also struggling to understand why the test is failing. If anyone
      could provide some insight or assistance with troubleshooting, it
      would be greatly appreciated.
      <br>
      <br>
      I've cc'd Fabino, Daniel, as I believe they may have expertise in
      migration testing and could offer some valuable insights.
      <br>
      <br>
      Thank you for your help with this, and I look forward to any
      feedback or assistance you can provide.
      <br>
      <br>
      On 09/02/24 1:21 pm, Het Gala wrote:
      <br>
      <blockquote type="cite">Ensure failure occurs while adding
        validation test for 'uri' and 'channels' arguments
        <br>
        used simultaneously in the 'migrate' QAPI command.
        <br>
        <br>
        Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; tests/qtest/migration-helpers.c | 14 ++++++--
        <br>
        &nbsp; tests/qtest/migration-helpers.h |&nbsp; 5 +--
        <br>
        &nbsp; tests/qtest/migration-test.c&nbsp;&nbsp;&nbsp; | 60
        +++++++++++++++++++++++++++++++--
        <br>
        &nbsp; 3 files changed, 72 insertions(+), 7 deletions(-)
        <br>
        <br>
        diff --git a/tests/qtest/migration-helpers.c
        b/tests/qtest/migration-helpers.c
        <br>
        index e451dbdbed..2dbb01e413 100644
        <br>
        --- a/tests/qtest/migration-helpers.c
        <br>
        +++ b/tests/qtest/migration-helpers.c
        <br>
        @@ -43,7 +43,8 @@ bool migrate_watch_for_events(QTestState *who,
        const char *name,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;
        <br>
        &nbsp; }
        <br>
        &nbsp; -void migrate_qmp_fail(QTestState *who, const char *uri, const
        char *fmt, ...)
        <br>
        +void migrate_qmp_fail(QTestState *who, const char *uri,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *channels, const char *fmt,
        ...)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_list ap;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QDict *args, *err;
        <br>
        @@ -52,8 +53,15 @@ void migrate_qmp_fail(QTestState *who, const
        char *uri, const char *fmt, ...)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args = qdict_from_vjsonf_nofail(fmt, ap);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_end(ap);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; g_assert(!qdict_haskey(args, &quot;uri&quot;));
        <br>
        -&nbsp;&nbsp;&nbsp; qdict_put_str(args, &quot;uri&quot;, uri);
        <br>
        +&nbsp;&nbsp;&nbsp; if (uri) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert(!qdict_haskey(args, &quot;uri&quot;));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdict_put_str(args, &quot;uri&quot;, uri);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (channels) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert(!qdict_haskey(args, &quot;channels&quot;));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qdict_put_str(args, &quot;channels&quot;, channels);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = qtest_qmp_assert_failure_ref(
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; who, &quot;{ 'execute': 'migrate', 'arguments': %p}&quot;,
        args);
        <br>
        diff --git a/tests/qtest/migration-helpers.h
        b/tests/qtest/migration-helpers.h
        <br>
        index 3bf7ded1b9..d49e289c51 100644
        <br>
        --- a/tests/qtest/migration-helpers.h
        <br>
        +++ b/tests/qtest/migration-helpers.h
        <br>
        @@ -32,8 +32,9 @@ G_GNUC_PRINTF(3, 4)
        <br>
        &nbsp; void migrate_incoming_qmp(QTestState *who, const char *uri,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *fmt, ...);
        <br>
        &nbsp; -G_GNUC_PRINTF(3, 4)
        <br>
        -void migrate_qmp_fail(QTestState *who, const char *uri, const
        char *fmt, ...);
        <br>
        +G_GNUC_PRINTF(4, 5)
        <br>
        +void migrate_qmp_fail(QTestState *who, const char *uri,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *channels, const char *fmt,
        ...);
        <br>
        &nbsp; &nbsp; void migrate_set_capability(QTestState *who, const char
        *capability,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool value);
        <br>
        diff --git a/tests/qtest/migration-test.c
        b/tests/qtest/migration-test.c
        <br>
        index d3066e119f..3aaffc2667 100644
        <br>
        --- a/tests/qtest/migration-test.c
        <br>
        +++ b/tests/qtest/migration-test.c
        <br>
        @@ -18,6 +18,7 @@
        <br>
        &nbsp; #include &quot;qemu/module.h&quot;
        <br>
        &nbsp; #include &quot;qemu/option.h&quot;
        <br>
        &nbsp; #include &quot;qemu/range.h&quot;
        <br>
        +#include &quot;migration/migration.h&quot;
        <br>
        &nbsp; #include &quot;qemu/sockets.h&quot;
        <br>
        &nbsp; #include &quot;chardev/char.h&quot;
        <br>
        &nbsp; #include &quot;qapi/qapi-visit-sockets.h&quot;
        <br>
        @@ -1773,7 +1774,7 @@ static void
        test_precopy_common(MigrateCommon *args)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;result == MIG_TEST_QMP_ERROR) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_qmp_fail(from, connect_uri, &quot;{}&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_qmp_fail(from, connect_uri, NULL, &quot;{}&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto finish;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; @@ -1869,7 +1870,7 @@ static void
        test_file_common(MigrateCommon *args, bool stop_src)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;result == MIG_TEST_QMP_ERROR) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_qmp_fail(from, connect_uri, &quot;{}&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_qmp_fail(from, connect_uri, NULL, &quot;{}&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto finish;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; @@ -2508,6 +2509,59 @@ static void
        test_validate_uuid_dst_not_set(void)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_test_validate_uuid(&amp;args, false);
        <br>
        &nbsp; }
        <br>
        &nbsp; +static void do_test_validate_uri_channel(MigrateCommon *args,
        bool should_fail)
        <br>
      </blockquote>
      Not sure if should_fail is of any value here. The test ideally
      should not enter migration also. Should just fail even before
      making the connection, at the QMP level itself. I added it here,
      by taking the reference of validate_uuid tests.
      <br>
      <blockquote type="cite">+{
        <br>
        +&nbsp;&nbsp;&nbsp; g_autofree const char *uri = &quot;127.0.0.1:0&quot;;
        <br>
        +&nbsp;&nbsp;&nbsp; g_autofree const char *channels = &quot;{&quot;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp; 'channels': [ { 'channel-type': 'main',&quot;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'addr': { 'transport':
        'socket',&quot;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'type': 'inet',&quot;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'host':
        '127.0.0.1',&quot;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'port': '0' } } ]
        }&quot;;
        <br>
        +&nbsp;&nbsp;&nbsp; QTestState *from, *to;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (test_migrate_start(&amp;from, &amp;to, uri,
        &amp;args-&gt;start)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Wait for the first serial output from the source */
        <br>
        +&nbsp;&nbsp;&nbsp; wait_for_serial(&quot;src_serial&quot;);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /*
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * 'uri' and 'channels' validation is checked even before
        the migration
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * starts.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; if (args-&gt;result == MIG_TEST_QMP_ERROR) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate_qmp_fail(from, uri, channels, &quot;{}&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto finish;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; migrate_qmp(from, uri, &quot;{}&quot;);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (should_fail) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qtest_set_expected_status(to, EXIT_FAILURE);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_for_migration_fail(from, false);
        <br>
        +&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_for_migration_complete(from);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +finish:
        <br>
        +&nbsp;&nbsp;&nbsp; test_migrate_end(from, to, args-&gt;result ==
        MIG_TEST_QMP_ERROR);
        <br>
        +}
        <br>
        +
        <br>
        +static void
        <br>
        +test_validate_uri_channel_both_set(void)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; MigrateCommon args = {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start = {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hide_stderr = true,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .result = MIG_TEST_QMP_ERROR,
        <br>
        +&nbsp;&nbsp;&nbsp; };
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; do_test_validate_uri_channel(&amp;args, true);
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; /*
        <br>
        &nbsp;&nbsp; * The way auto_converge works, we need to do too many passes
        to
        <br>
        &nbsp;&nbsp; * run this test.&nbsp; Auto_converge logic is only run once every
        <br>
        @@ -3536,6 +3590,8 @@ int main(int argc, char **argv)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_validate_uuid_src_not_set);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration_test_add(&quot;/migration/validate_uuid_dst_not_set&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_validate_uuid_dst_not_set);
        <br>
        +&nbsp;&nbsp;&nbsp;
        migration_test_add(&quot;/migration/validate_uri_channel_both_set&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_validate_uri_channel_both_set);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * See explanation why this test is slow on function
        definition
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------55lkpdRStfF2NxdMOGk1a3n0--

