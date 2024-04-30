Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817FDC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 20:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tf5-0000yq-Hg; Tue, 30 Apr 2024 16:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <boris.ostrovsky@oracle.com>)
 id 1s1tEp-0005H2-AN
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:34:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <boris.ostrovsky@oracle.com>)
 id 1s1tEb-0005Gd-CG
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:34:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43UHIMv5026796; Tue, 30 Apr 2024 19:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7llaUWpfyuQse4qnjoAWIn5esGkaGniniUUKU+lZ0uc=;
 b=H+yLXKpWOVSe09txYe4QrKvKE62suA0u29Yp8aSnIDa7VMLGgBfVbFsydvFotns1Qp8n
 7kfMFM8xmk8FVUUo6+cCHrjtbb0mAUojLWQUAs8I1+D58GtdFQSi6UHYdOdYLck4zP7i
 r30foi3gokFvqrNXD4L4QS7Y6GjWQyTuRX4ZrvcjdYv190jGTcjRQ8lHsRojjSUXnI09
 r0fEi3WO2xn9Pj//W5OihTuTBeihZcvWj4XFBtrtTiXGbGx+rejmjmrXRwDs/+NkUizw
 IkZV7ZMLEubnHr1aZWRm8eAAL7m5UcJ+aZGv8wodZtGQRZeJ6Ejt6aGQqVEtOXh2rRhY Qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54dy80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Apr 2024 19:33:43 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43UIVU9P016670; Tue, 30 Apr 2024 19:33:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqteen8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Apr 2024 19:33:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOizwyKxBYHT7r0wan7dj/GEOPH9sY0yGSVdRa4E4J7fBpKJN4pPEG9hjhQmxthcZO0zLJjMhsvz+1A92iqsZyne/gkiL2kZVj15rMDm7N0PxsJhJXTM387fCK8OJO7zERgEZZMINHRcK1N2RQBeeH+2R1kiDNlsLiCy4e0Wlm3DeP4KT2Gu2lGFDcuh3drEQ23k/M6+Ct6vKMLrZq93pYBRt5SfygUXK61r1VVhUH22Xu+C2jk0XFMYlRNUIUGZNUFF1fPunvJujQ4wBHjBa8HvCD+fkhwhmXbd2MaSJTxgiQVd1j/nDM6w770WS3KYWR5Z6O/j+jj3VNQXckqEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7llaUWpfyuQse4qnjoAWIn5esGkaGniniUUKU+lZ0uc=;
 b=M5FQhy4f9BT/vnzTwtwbC5g1T5lZ6ajgINRHg/9y1KgBSHp85t4fHApK/L8Y6Sd+HhyBbPuLdB7RnVSPQMtCEI3v8Dx4iWygBldOiS0efuF22QffQ8fat4rmN/IPrjj5GPlI+5OCFSm4sHoFAtjA65jSQ+sMnMf4zQT8bVJaDA+ZbiKLnEjz8mZ0vBq+HBgCF/V7x7HePbgbJDje5k2v7nbvQDDtjzvHt0Yj8cREv7GfkeZnpYdpe8BcbZvT+5+N75m9jqF5oz5jURd60a+EigElbFEkW1mxc/9z7RYFOOvFx25Fs/XAUFWQMYYLd6fcZenxhMvGCVPyegA688citA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7llaUWpfyuQse4qnjoAWIn5esGkaGniniUUKU+lZ0uc=;
 b=ZzIy6ifZl5l7shQnyMZmSzivIt2HrKfiqFZ9Cjrz5BmhEqbtsvTSNldfnlVtCnaA4yALjmulAFKXmdzC6fVGOmMKH/3yR+CUJCHVr3ZYM/GtVL8B0AAtQE3yeh18Rc7TAzgXJPpZPGk/E+LvimrVlVwNmdVpTECXfs32xNO5k6k=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 19:33:20 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::a088:b5e0:2c1:78a0]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::a088:b5e0:2c1:78a0%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 19:33:20 +0000
Message-ID: <fee59103-4d70-4862-9f28-c718fb846552@oracle.com>
Date: Tue, 30 Apr 2024 15:33:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/qdev-monitor: move drain_call_rcu call under if
 (!dev) in qmp_device_add()
To: Igor Mammedov <imammedo@redhat.com>,
 Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mlevitsk@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru
References: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
 <20240430162739.7a6e65de@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: boris.ostrovsky@oracle.com
In-Reply-To: <20240430162739.7a6e65de@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:208:32d::14) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|DS7PR10MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ade3bc-05ad-4034-e7ad-08dc694c6428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzZYc1ozNHE3b2ppVUpYN3h0dmZxMkFZdmFoYmZsZ2dVN2lCVjdQNThydXJU?=
 =?utf-8?B?RjV4VDFLc0psTDlHOW11WlR3NzNPeHRoTUk2ZHFqTmlXd2VoaVpiT204L3Nh?=
 =?utf-8?B?TlpxdytsWGFrV3podkNabWUrRlUrUUplbVRhM2ZLelcvcjZvbHdmdlpWWjVP?=
 =?utf-8?B?ZER4dWFRazRRUk1xbzQ2L2xBUmRSVmZneGJEUjhWTVFLNkFxZGUzNnE0Lytj?=
 =?utf-8?B?Z1BjU29lcjV5TEVyWHFDWjFhYXJpYTJmVktHVDJMd1VBUDA3d2RmMGw2YWlO?=
 =?utf-8?B?SnZxVGowcGZBKzFaRmEyemwvN1RSbGI0UUMzNVBhTWF1Mnh2VzZXNlR1c2lC?=
 =?utf-8?B?Sng1ZWFTeDRkK2k5L0ZsdE9KNTl3amErMFR3YTYrbDdwQkxwRk15dVIwS0s1?=
 =?utf-8?B?ODMzZVJxTkFoRWJ3c1dLK2J3aVBDTVBXbDI5ZkZLWGdSOHFYaWhZZ0tPRlJx?=
 =?utf-8?B?ZW1SOVdOQ2NKN0FhdzNZdmxSOGpnb3dwcW10NURRZzFqUFl0MDZJbEtxWWRs?=
 =?utf-8?B?SWZja201VEpoY0x4M2lOR2RXOVhFMUEwWG9QUld1YlNCcEMyUnFjazcwWG9x?=
 =?utf-8?B?NGdvdEN1U2VVU1NtTTNVODZtWWRJcmh0cXUwNzZFK3Fvdkg3emdrRUVPVG54?=
 =?utf-8?B?UzNrbHdxWVk5blBKVzJVTGhXL0k5TDNDTGNJclBONHBTZHB5YXhLQ1JqM0hj?=
 =?utf-8?B?N1lKZDRFSzlwRmZWdmUyK3ozeUovRHhIdFRMSndxOXN6NUlFTjYxRkF1YWdM?=
 =?utf-8?B?N3VCNldyR1ZKYU5oTllhYmh6Yi8zemJROHBGbGYwTmNnS3ZMMm9yWGJTRU9i?=
 =?utf-8?B?UW12ZSsrTnBOQjEvMTBSTm5Bc1o5d2Nna2dta3lYTEQwejN1SEU0YlFjZVRC?=
 =?utf-8?B?bTF3WnNmT3ZRMnV5OUxvQWRqUEJHY0NPU1FEcVV6V29sdjhRdmp4OXJxZlRD?=
 =?utf-8?B?RjRPVWZwQ2VyMXA2dk1QRktDcWNBaEJNZzIyU2F0VUpqSHNRV2F0SU9CWmI1?=
 =?utf-8?B?U1FVZUo3TWJCbTl3eVZqODhSbkFjVFdCUmp3dWZpM2VJb2lmUXFzc2I4WjQy?=
 =?utf-8?B?R3BSOVh4Wnh1aWNEak55aHpsSWF6Sk9FWC9meklWNFRpUlZpalhFcU9XbU84?=
 =?utf-8?B?RTJxTUF4NzBOemlCclJCMkRQQUlLZXU2TW1rOWlVZE1PUW1ZZ2NQM25vb0lF?=
 =?utf-8?B?aE9OYnUrRVBUWEo1RUpnUnlLTWdIeDRqdnlDQlEvdCtSYlRDMi9IVXVyQmRJ?=
 =?utf-8?B?R1lXNVM4ZC9BSGFLZy94WW04K3UyeEd2RlMyYVNxVDE5akN4THNWSkdwSURX?=
 =?utf-8?B?L0dZbTBCcDJBSnJwZW1PMjNDSVhuK1JWRzE2M1RRVFVCZkJYVjl1dWtNVk5w?=
 =?utf-8?B?SzhjVGEyWnpOb0dXcWM3eDN0dUZvczdXWndDZjlQY1oxZ0UwTlgva0U1bXVu?=
 =?utf-8?B?SllIUGF4S1R5c2hGYi9wNlo1Y2NFS2REMDdCVllmN3IyVWFKNTA0U2dVNm5G?=
 =?utf-8?B?NVczbXEzWEFtQXIxYWpreE9HUEI4Z29XZ0pCdTdzaC9FWWRIbzhxU2U0TWUy?=
 =?utf-8?B?dVFHWEFHMkZhV2l6YlpNRGVtTHY3aUdGa3d3am1MWG82Y3RCb1NDemVQWk9D?=
 =?utf-8?B?ZWF1b3FUYTE4NkRnQjNHbXA4ZDJ0eUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0Q1Qk15UHdZK2ltdnRCUUpaN2piYXhLOW42MHRBVTVxbGpwVlVsZ0Z2R2lC?=
 =?utf-8?B?UWRsYm91RGt5dncrOW13dzR3enpaeGdqUGhjNDR1NS9TbU5WMngreUt5RG9Y?=
 =?utf-8?B?Mkt4NHlweFduVjZNWEtWSitmczZGT0FTMDZjU3FYNXhNaVFUR05kWWZBM3U2?=
 =?utf-8?B?NjJzQ2dwMHlqQ1BjeVlyZnRTby9TNEU3aXBUcnRrejRxMVZEazlVdHcvR3l5?=
 =?utf-8?B?S0d6enNJdFdtdS9TbXZvTEJHVzlSQW1reVRld2JyRE1MM0NSWHNlYmRQQjFF?=
 =?utf-8?B?VHdUY1VWYldLcjB1anhkM3duajU1bUhTbnpBbGx2dVVVMGszeGdoK1pYNEts?=
 =?utf-8?B?c1pTUHNzUmsyMkdLUnRMenlNMDFpVitkUUs0NXV1dGFwU0p5citWYTNwaERp?=
 =?utf-8?B?L2NBbjlFU0Y3L2dPYmJBYXNoWHNqcTVwNkFGTTMzekRLZWZ1T2M5eDZMNFBE?=
 =?utf-8?B?YStpNVY4WTk4YlhuK1Zjc3lHT24xeHFVcHZXWkpKNXdBeHNxR1pscmZ1cWtw?=
 =?utf-8?B?UzZORjZFOXhpWnVOU3VkRENEZTNmcDcveDBFTU1ucHdBOWZSODJNN1hLcVBn?=
 =?utf-8?B?OUplRldzUU00QzlmRzJLbXZIdlU0YUY4RTVwdDVPWS8wSTVVOENwTERJQzla?=
 =?utf-8?B?ZXVRZTBHN0lNY1V6cXRta1hsblNjeVhHcmtRam1GS0VmS0J0bTl4UTRBTW1K?=
 =?utf-8?B?K1dZTUxUUnFuUFNkbk53dzgrdkh6Ty9Bd1FBNFRuekR5M3haVjJLanUvL2V1?=
 =?utf-8?B?TGtBWDVKK1FiUDJsZ3pZaWdvSzNTMEdrOVF0YzJ4UjBDU082ZFNabDVNdG1r?=
 =?utf-8?B?Ti8xcDA5VGYrTmY1Y0wzWitubEloRGh6bEk3d1pWbXZSMkxKUy8wZ2tIeUs0?=
 =?utf-8?B?Y0ZCV0QybnhLSGZSNFZlR3BnZVhzdDdDQ2Q0R005NlJwR3NkdDNlRmkwMEdv?=
 =?utf-8?B?WVZBSkMwaVpiVW9ydzZld2NoQnNjckw1Q0NSVDlHNnQ4bitndHVjUnBhQWV0?=
 =?utf-8?B?MDRlYTJyUVdoUmxtTld2bWpFT0tjRFNoMkJETFNhL3BKSzJZN1drcENscFc0?=
 =?utf-8?B?UFUxaVBKZEdTTjRxVnNvWDQ2UldoOUtJd3RHZFZoR2huTVdqMjFCcmRUOFk2?=
 =?utf-8?B?bkRhcDlTUDdMR2pTd1BTMHVNQStkMFhxbmVURE5iVWgrU25CVnN4WXV2bHJE?=
 =?utf-8?B?VUF3TThWdURXYVlad1pUdWVuZHhoV0xCYmNibytBTXNOclF1OUszTUdCbkFD?=
 =?utf-8?B?YXFzd1BIT01QbHRJYVFWZ01sRGFKc1l6ZXF6dG5jS0VreWlmZHd5MVd6MEx0?=
 =?utf-8?B?YWhEbURyUXpidWk2MjIwWlRFVDIra2lkT0pKa2FZS0x5NEs0WjlTTEsvNi82?=
 =?utf-8?B?eExweGtLNEF6UjZCeFNsUGJpcUJMa3hFSXJXR1IxLzJCMHZEVGkzd0t5WXA0?=
 =?utf-8?B?N1ppbmxvQXlnYU1BTThFTEtJV2hVNTd3NDFqWWVnTnRiOTllQ01takFWVEVU?=
 =?utf-8?B?c0QyM2pFT2FGNW9xMFU3a2RJd0UvWkVVR3dVM0llZlJ4a3BwcjJWNEwzbkg5?=
 =?utf-8?B?V2VCenNoNnp5ZGxadVRrVFV2YWpjQzN1Vzk1b3YzRkYyeHM2Y09KaEZFOUZl?=
 =?utf-8?B?OCt1YWt5ZFVYZGdrbXJaZngyUi82YmFUaWNyWDdxcURWdjRMRHpxVFhUMUY4?=
 =?utf-8?B?Sm5ubldIQms0eWZXUEJHZWY0eVJvT2JuR0FzeExlR3ErR3J0RXJUSXRoMjNx?=
 =?utf-8?B?eXFoaWZueUwvRXZTUVI3Z2EzVzE3SWxxQ0Z0VWtNS0lrb2pDeUorWnFlV3Zm?=
 =?utf-8?B?QW14WmFEOStxVFVKZTF4YmY4bzc1SENHd1lqNk52VGx6a1Vva1lUMGRtY0Ez?=
 =?utf-8?B?Q0VvcWJHellVY3RxRlI1S09pSm43OGYwKzZCbGV6WkpwR2dab3M4Umtvd2VM?=
 =?utf-8?B?dWl4TkhsU3J4MnBBZUw2UjNLc0V1RFVOcEk1REc4WithSExHUXpEb0s2dm5j?=
 =?utf-8?B?TkJhbVBQYnhqckhLNmRmQithWmROd3BEK2doUHRFU2dJWjZUeDNDbVFIcmNW?=
 =?utf-8?B?YW8vU2ZRUFFyQnowTGFzS2pxZHVmcHkzRUhSSFRwY0NRWWl5cC9NWmNzUzVD?=
 =?utf-8?B?MklsUG04WUxQUnk3UWdvQWRQZVk0OVZ0SHZQUDkzKy9HWlAzbmlZSkxOTkFY?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J0gdR4QM02L+8DJWM/XUop4Cr34MCe9vq19NJReUkHmjLsV4a51NpkPDXncZPsdmNRIDviFGAhC1qGVBEXLUwif/f7qciav5Ssli0AlfMGrbwdO8KyNpxwE7jMuF2Y1qMHyMAhli+M4sUiQ4Bjp5cXttFLK1ynyRvGZc+wZkJm/ZViGksofXxmy3+9m0xW/cyUdFUSKMJF6WYvnkuku0J0SxC9Y1PaJq7HFGgUjgWdc2rciLGup+PVTgIEmuPl4BgsMvDVMd1vHuppHAR5MusBRhlumY5ot9eiDbgpIwyODYiNkdwjikUrs/5dnIb2E5uKzzKjmNDFX9OP9iaWUWIENilDZ6uReZ54w3WV9MpszPBUOGwMgeL+31+joHuzISJyIUI/yWk0UFiVlsEs+MS0I1iVOoR2pMBGWxohO3/dhMrlK+nETciBnlgLRxbenYfipjvIwsDzytdcNXsUnLkeam+6XdJfzBrtFRGNz5oD51EvtH9OcmQpZchpC0rRIzaNwzmiXopC7PQNPl5ovp7DVWPp8SX8YQs7R1hO8M9wRNR0FDj3gLhW5d8Ygh5yUIez4opyFIfxhGZuqPl8Foq1SIlcArFQEwdSM3YSXee44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ade3bc-05ad-4034-e7ad-08dc694c6428
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 19:33:19.9689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSboZ+xckwR91eX5PSaG/3CC/N20o4kX8uSbaF+zgnlh5JJQZ9UtK+krUjs9f0gq7csnDu7FRYLKkld/mfpwJglcD2GwktVd+PlV1nXMg+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300140
X-Proofpoint-ORIG-GUID: YLgduoTz7JNOeVyujJeEc36vodQ6Y4Ju
X-Proofpoint-GUID: YLgduoTz7JNOeVyujJeEc36vodQ6Y4Ju
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=boris.ostrovsky@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Apr 2024 16:01:10 -0400
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



On 4/30/24 10:27 AM, Igor Mammedov wrote:
> On Fri,  3 Nov 2023 13:56:02 +0300
> Dmitrii Gavrilov <ds-gavr@yandex-team.ru> wrote:
> 
> Seems related to cpu hotpug issues,
> CCing Boris for awareness.

Thank you Igor.

This patch appears to change timing in my test which makes the problem 
much more difficult to reproduce. However, it can still be triggered if 
I insert a delay after qdev_device_add() which is roughly equivalent to 
what was happening in drain_call_rcu().

(https://lore.kernel.org/kvm/534247e4-76d6-41d2-86c7-0155406ccd80@oracle.com/ 
for context)



-boris

