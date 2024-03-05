Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448C6C54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 14:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhWGP-00038s-Va; Tue, 05 Mar 2024 09:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rhWGM-00034b-UZ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:59:26 -0500
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com
 ([40.107.244.85] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rhWGJ-0004Gn-Bb
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:59:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fir+hUfXDGokqkfMtZQtco1Zzd/akmWaUAIFNI6MBr7m3HxprYqvpZeCqi/v8nj/wynMqPfSYHXKFiClJcJwFTeary7uPEQ4gMAYHkS2laCQUSjDpjpW13JKPAcHR3pm5hdprk/xKPbAEgHnwNatEQupztfsjEMYMQtI7P5YI1sIOYK/eSzCOlpfEUUhZ4G0nMfRwxNVLkYoV1x6U9SPb06UXsLkrdenW+TdQ6b1r6U0T1gxWwx+K1YjydEObf3jpVb9DsBAtUJRW3T2AH0l0rIFOq0Cku1urF7ztw2NbB8Nv8JrIYpMTi0HAYk7BH9MYNA89BPM6whp1NvT8xD35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynarQMuGSoX7StWFgCiboZbD5/mgCYV6BhX3xeTYn6g=;
 b=lU163vqORiF6auYQ74DH+0wFRk8uznEaqsw/S5HdhjUHg/pGsJ8Rf2bcZfn4Ip0rp7Qth9UtkyjRscOQiDFAqcx2nVV9o8b2cill8+sXgd+BsCTmPKOCc29BelMAPOPrkpuFBZ43UtGzT5iI4WhvVQiVn+xNWkAd/QM8fBEY2+3yv790XaeGSxbv6hiyl7gvh5xjQ4r3vLLaw0d+HjcP/fdW1PRzCGpQqgM77RVIZOsf65Guf7pEZOs/1dq1C+rdY9luZ9AoJE6AMxuOc1yuGuku5QQOs8+VrX6RFHN/R+R04GltHv0+mYyhuruqSMibMTq1QC9U2UbK66kWGHopow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynarQMuGSoX7StWFgCiboZbD5/mgCYV6BhX3xeTYn6g=;
 b=dIlx0jhUQKDUN4J9/s1XTG+Z5JMF5KmxsXXy/isFwpnwkFTAsCgHmIJpCB/pnshdGOQDZkct+BGPLlpecaoY0QpC2jvVsVzZ3rwWSsUAlANu81FSbrT3f201w/vJUk250yXuttTd8pczBg7/WRonJ7Eq4xEqYFn+rKQYe7vsbC+Gc850gqh/jPQSsKacoc3zc8AFvYQZ6U2sXoevVe+gaTdkaRwXMLJ0fnD68NZXK6fy3+zCdMz1JaJ5XeT0jZFYbNsoTUWkganlh3GjdJGGAwQTYwbhhonDZwT70+XG8ZoqoqhevGoO30prAComNne7SI2UC/Y5VJWIn2yfby7uxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 14:54:14 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::2bc1:5563:c496:8076]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::2bc1:5563:c496:8076%5]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 14:54:14 +0000
Message-ID: <70d5a5b6-9ae8-4f55-a7c9-41d8b310ec40@nvidia.com>
Date: Tue, 5 Mar 2024 16:54:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/26] s390/stattrib: Add Error** argument to
 set_migrationmode() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-2-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240304122844.1888308-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::8) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e4db06-8dbe-4035-eb02-08dc3d241e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHnRPNONnDPt67XN1Wyb2z32E7u2ZzcFkGbeTuSVkcvRAZ6DA4XetSxqDw6zRjCU1qdYYvZC1CljkvoVqQr1iR3hfe6ME2X8EGFLfQuYBokkEheIDDfamQecZWz9u7pcqOE/0+zdRnBTNnB1o2xTNKtzk/+iwABDjH8+jYdgNI6qFXsJnJgpUKY+gdqmKlrF4bkH2V++v+mCsjkYCWAmY4Yueymdppux1CW7SDKTnXShdyPTMLYqV37IwvSi2nMuyw85/vkjDGjKh1AQ0zCn18Xkd6WYsh4BxnnwTGacA5Is/Kh+Eacc7qUrFAz+ecNDg91hxxq3zFylkibFo09HMYCaW41lo7UoUiqLdXPxrzeDLUbC5A/7bYdV+nRtxoeAuNniq7j0GnLjIPrM5PIga6LY0Lzc7uioX9lBhNnwoiF6wedNxbEhYB6r8qROlCHKfgsFEpFZFHGpRXBNIHXn8IzFcHmlrt99suSVIL+1YOKK6fMbWCWjPyGnI9mWp3dw42vf5RvWvq2Gd0uqYquU4mSMjlMLLMLhG209j5q+1neFojCMQtW8PiVmrV+8SXVUo4SmhFeZ90nY9mJvo558k/d3JB3tvpN36DMUtU2YzEWqltko+jTyygnIcq1GeJFq6o4vXe5bTa8627V62/wXwkhVs4tn/zPs3uFNon5WdWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nml4bHd2REJrSE54VkFSdXZ5WVh4ZTlndFB2MkdmMk5wVS9KeGEvd0ErUFQ1?=
 =?utf-8?B?emcxUTQvYVZYMkpFbkppQjZNQWhRdE5CWTFIWldMdks5RmJMZDBTMWVxRHNw?=
 =?utf-8?B?V0dvdnpHRk9nZ2treVdnRjFiaHZyMWNQdXFYT0JuaFhsNzlmMFUrcUdTNVFF?=
 =?utf-8?B?MEx2VTBSYjFXWllzdmR0ZzVNYU1oQkp4cjdKVVc4MDlQWUUxT0Z4REdJeFMy?=
 =?utf-8?B?VCtYLy9GY2p3R2tvSzRqTHExdHpXeXpZT1B2bHNIYlNFZ3czVk1zN1JHS0wx?=
 =?utf-8?B?TWt6NGhUWml5cjJodHBKODBpdHRBam1weHl5MUtVVFVEREpxU1k3UnBSM2ha?=
 =?utf-8?B?S214S3VOSjRiZVpUM2NiWjdPZDlWSHdLWDk0K2d4K3FTbzlCMnBha1hseUFq?=
 =?utf-8?B?a01DS0pNbXpFSnZDbnI3QWd4amJkSEoyTlRMakY5YnY4UU15a0JpSi9oN0ZM?=
 =?utf-8?B?SXVYU1ZrTVNUQ3lieHRjc3Q5NDhGV084Q2pqblUvQm0wNUhLTUxZdlFnSkJt?=
 =?utf-8?B?elJ2ZDBPa0ttazhua1ljcHFUMUY3elB0V0RWUXErc1ZWcmpOcWJnOGFuZ0ZO?=
 =?utf-8?B?NWdIbndxU0JhMFE5eUM0bzhBT1FMaHk1OHZYNjdUNGFDS3VMeWdaMW9VMkc5?=
 =?utf-8?B?UjQ4ZkZjYVBiOFlLeVBEU0dRZmNuVjJwK0dyRUllaDZyTEluZmQ1Zm9OQ0FX?=
 =?utf-8?B?RFhKZDdKc2dNbGlrVHlJakw3bmg1aEhQbWs1Mlg2VjN4STZjQ0tsS05mZkZi?=
 =?utf-8?B?b29leFhsVTZxaDB3QzFlNWxFZGNtZnRGa3NNZkM0a1BNcElXMnpodmt0UDBp?=
 =?utf-8?B?cGJqcVlzalE2d0Faa3BjejdIVnF2Yy84SlI0anZ2SUdvRHNVMmV6S1o4VS8y?=
 =?utf-8?B?WlZCN2xuak10OXVncGdPaDl3a21wRmQyVXIwU3BKMkhqRjREeEtmSXpoSDR2?=
 =?utf-8?B?Z1hGZXNPK1VBV2NRNExIRUVlOXQ3c2NFZzNZTUJyZ0UwZVI2bWZoQVdhNmRl?=
 =?utf-8?B?M05KdHplcXF4OVp4S1k4Z0tFaXpqaTFCbTlWU3VnQjdNRERSUmloT2Z3bGNR?=
 =?utf-8?B?UDBHTE5tanF4K1ZSMEExNzZUOEFhN1lKZG9QbzdzKytnbkN6Q090ME11U2VF?=
 =?utf-8?B?TVRsU29mSm5CUGx4bEwrL3UydmxxTEd2YVBJNDVSa3RrZFV6K1pNZzhyait0?=
 =?utf-8?B?ZFF2bnhpTmVRWVN3Z3VCZVM2aTgwb0MvcHNNb2pKNk03Lzc5V1JRamdTcER4?=
 =?utf-8?B?ZXlDVGtRbHhoZC9JMmNpNGxncEtNWWpWOHp5WGNMdGJHaWEzckxld0hYWTk5?=
 =?utf-8?B?R1FLTTJrTlJYVGRNMUtCdStQTCtwcmhYWTNWZlVFZUJNUy9KL2p1SkxQZGRp?=
 =?utf-8?B?L0Jzbi9iQ0hkampBRXhRdm91eGxwbDlGQzExRXV5Zjk0VHZmeDdHd1hOWk16?=
 =?utf-8?B?d2htNUhVdm8rT05OelRSWmtrV1dXMEd1SzVmdmZhZWJBYkhpRjhQbk9CMFhW?=
 =?utf-8?B?Vmh1MTZyOEZKZFBEbjBBYXBBaTRxK0t1VXNLTllWUDY0UHJPekp1MDl2SGtR?=
 =?utf-8?B?SUFSV28rSDIvWU5mOWxNMThMWUovclBuckFlSEdZa3NXL09jbDNqdGpuKzBS?=
 =?utf-8?B?YzZGOElwTkh5emQ2TzR4ZkVxL1ErTGVYcDIvbFdUVEx3Zyt6aStySG01cWtI?=
 =?utf-8?B?aXdsSGNCQVBzc05iQndneFZuSkltbHJvcEVDWUx1aWQ5Wno4Q0dMTUhNZVla?=
 =?utf-8?B?THRFZXRvQXBWaHk5QmtINVROMFJQYWZrOGhkUkV2MGI3Ym5PbUgvbStFVzBE?=
 =?utf-8?B?N3Fka2Zpd2JqTHMvSUZoWlpZZ3d5WEFhTXQ1WGhJL0IyWmhKdmpVZDk3SjNw?=
 =?utf-8?B?emNPaGJDZlpTb2pWVEZRNEJ2ZmpkZ3RFNkx4RitoUWF0MGtLSFRheXJ0OEFq?=
 =?utf-8?B?dkI3SmZ4Q3pnR2Jrc1JZQmkyRytKVDVoUW9UVHdOZGhTL0NDd0gwZStocEZQ?=
 =?utf-8?B?UC83d2ZjcFhUdm9xMGZoWGFZS3dVcUw1UWpoUUU5TmZTUmNLSW9pOUdyRTJQ?=
 =?utf-8?B?R3h5d0szM1gzcWxxbEMzOFAwQWFuK1FjOGFXZWdrK0FLWm9GdVJPQXduOE1P?=
 =?utf-8?Q?pK+RL3vetS882bCh/iR489JY/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e4db06-8dbe-4035-eb02-08dc3d241e2a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:54:14.3700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufJq4hNHpDrt5aeY3nv98hYY4sU6ftMELo4Rm4k47ZHXQQJnIaK7EL7wrlj+ytDqJuGbttlIvdZEe0iVci/hqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
Received-SPF: softfail client-ip=40.107.244.85;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 04/03/2024 14:28, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> This will prepare ground for futur changes adding an Error** argument
> to the save_setup() handler. We need to make sure that on failure,
> set_migrationmode() always sets a new error. See the Rules section in
> qapi/error.h.
>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/s390x/storage-attributes.h |  2 +-
>   hw/s390x/s390-stattrib-kvm.c          | 12 ++++++++++--
>   hw/s390x/s390-stattrib.c              | 14 +++++++++-----
>   3 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
> index 5239eb538c1b087797867a247abfc14551af6a4d..8921a04d514bf64a3113255ee10ed33fc598ae06 100644
> --- a/include/hw/s390x/storage-attributes.h
> +++ b/include/hw/s390x/storage-attributes.h
> @@ -39,7 +39,7 @@ struct S390StAttribClass {
>       int (*set_stattr)(S390StAttribState *sa, uint64_t start_gfn,
>                         uint32_t count, uint8_t *values);
>       void (*synchronize)(S390StAttribState *sa);
> -    int (*set_migrationmode)(S390StAttribState *sa, bool value);
> +    int (*set_migrationmode)(S390StAttribState *sa, bool value, Error **errp);
>       int (*get_active)(S390StAttribState *sa);
>       long long (*get_dirtycount)(S390StAttribState *sa);
>   };
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
> index 24cd01382e2d74d62c2d7e980eb6aca1077d893d..357cea2c987213b867c81b0e258f7d0c293fe665 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -17,6 +17,7 @@
>   #include "sysemu/kvm.h"
>   #include "exec/ram_addr.h"
>   #include "kvm/kvm_s390x.h"
> +#include "qapi/error.h"
>
>   Object *kvm_s390_stattrib_create(void)
>   {
> @@ -137,14 +138,21 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
>       }
>   }
>
> -static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val)
> +static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val,
> +                                               Error **errp)
>   {
>       struct kvm_device_attr attr = {
>           .group = KVM_S390_VM_MIGRATION,
>           .attr = val,
>           .addr = 0,
>       };
> -    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> +    int r;
> +
> +    r = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> +    if (r) {
> +        error_setg_errno(errp, -r, "KVM_S390_SET_CMMA_BITS failed");
> +    }
> +    return r;
>   }
>
>   static long long kvm_s390_stattrib_get_dirtycount(S390StAttribState *sa)
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c483b62a9b5f71772639fc180bdad15ecb6711cb..e99de190332a82363b1388bbc450013149295bc0 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -60,11 +60,12 @@ void hmp_migrationmode(Monitor *mon, const QDict *qdict)
>       S390StAttribState *sas = s390_get_stattrib_device();
>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>       uint64_t what = qdict_get_int(qdict, "mode");
> +    Error *local_err = NULL;
>       int r;
>
> -    r = sac->set_migrationmode(sas, what);
> +    r = sac->set_migrationmode(sas, what, &local_err);
>       if (r < 0) {
> -        monitor_printf(mon, "Error: %s", strerror(-r));
> +        monitor_printf(mon, "Error: %s", error_get_pretty(local_err));

I think we need to free the error here:
error_free(local_err);

Thanks.

>       }
>   }
>
> @@ -170,13 +171,15 @@ static int cmma_save_setup(QEMUFile *f, void *opaque)
>   {
>       S390StAttribState *sas = S390_STATTRIB(opaque);
>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> +    Error *local_err = NULL;
>       int res;
>       /*
>        * Signal that we want to start a migration, thus needing PGSTE dirty
>        * tracking.
>        */
> -    res = sac->set_migrationmode(sas, 1);
> +    res = sac->set_migrationmode(sas, true, &local_err);
>       if (res) {
> +        error_report_err(local_err);
>           return res;
>       }
>       qemu_put_be64(f, STATTR_FLAG_EOS);
> @@ -260,7 +263,7 @@ static void cmma_save_cleanup(void *opaque)
>   {
>       S390StAttribState *sas = S390_STATTRIB(opaque);
>       S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> -    sac->set_migrationmode(sas, 0);
> +    sac->set_migrationmode(sas, false, NULL);
>   }
>
>   static bool cmma_active(void *opaque)
> @@ -293,7 +296,8 @@ static long long qemu_s390_get_dirtycount_stub(S390StAttribState *sa)
>   {
>       return 0;
>   }
> -static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value)
> +static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value,
> +                                            Error **errp)
>   {
>       return 0;
>   }
> --
> 2.44.0
>

