Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DEBCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKuk-00067X-6Y; Wed, 10 Jun 2026 11:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXKuf-00066l-Sz; Wed, 10 Jun 2026 11:32:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXKuc-0000Xr-VI; Wed, 10 Jun 2026 11:32:17 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AC7bvi774525; Wed, 10 Jun 2026 08:31:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=x2uBJTwPW/mxJwCaO3JZBwEvXRGN1uKEI6GZSrdfC
 ok=; b=PjJUCqeSquy4WShTLFLsdKtpcy//Ko37nKPnREnLcB8P7exEt3ommDRxz
 SXIlQonw7W6vAeY89ybzcdj+ZLsrfCovXLqkW6l7bki5R2zFBzIzxV0/PeXiNLaP
 q+L7pHs25kg1KYxNmqQMmwkGScEoNC3uKaCm+BGCbc774z40TDsDSpdGa+o6WOvG
 4oiPpT+SoOaOvGqrtvO1dXr69jVHVaLGJVaJq4jLTQT+wpF19a8yfwA0F1Aum9yD
 Cfbv1ycIqX3soxG+pEZ/CxPxi1xqSJYEVDurJZUPPttX0P+AYXkFCQx9w1nbwHDN
 QgCzXYSVZ8zjRoC7nGWt7c1VWBZbA==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023122.outbound.protection.outlook.com
 [40.93.196.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ept6vagux-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 08:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3ymQdl1Vsj5XX2bUJiv45abj24aNZHNlNqWhhzStas0vLyEoM5IEp1mnIjqWiu90YkWxRUnMPlMgFFhb6WKMLBSlktxouq/2Lh3Wdfd+0c5H+U7s45q5gOXXpxK0GY7HOufNer53593AsxGQDS9lDrsFbtF03kHyBDSJ9KzuoUbsWoXlOumZwSwwLOePyhgEKbirMq/cKEydMzI/4j5m/clA4kqpw31HRYChrFmmB+EXnd3O4Mcd7S4VzynAHWJidMADWo1yd7i8Y/sz9Zvi8Td5Fuot/VFu3dljVFOv6435zmHcqd2VizQEJhBPPcRwCF/JCDguCWHaxKiidd1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2uBJTwPW/mxJwCaO3JZBwEvXRGN1uKEI6GZSrdfCok=;
 b=ZxpYW6LfA+92Wbrct80dcvaocFaUmYDuh/VwlXttSRNs3SyZu80JV83shUt4BH/MW8uDxU3Rk6WXpUgzj4KLxKtfxCX+ii1b55tLBTtuoV1OhO8f4akC5qaDwJksBBPkbxJYCbrW1R9tryiO8pUXE3SOhcrkPd4mbhe6MxgWlZdv4kPqBGIfceo3aWqCN1YyhJl3bBOBwskgG5FxUXzf+jSIomCRBUWWr2dOILGdXa2oTpYif8NhpMXoIfSs1WdMfwdWM2d4M90IGXrzhSRjtpVyel9+XKgMP7AT75Xxs+w9EXvOMZACgNWcuMJsd9PE5aWkfk0pdaDTM7Ej2Pfb2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2uBJTwPW/mxJwCaO3JZBwEvXRGN1uKEI6GZSrdfCok=;
 b=b1u0WSX9E2FDtSsDXo6JiSSW9o132+42QGVQM3F28UbWcLqNL4QoFSLVunHmGzFDephnu/Utr9QNBzzeg6fvJJkbbYfdquQdq0axVJ5nFzD3bdeC5QDuhxDqfvTRAiEBqP6G6RR44HTePkTsZQn6WJiSNbCIGuuj8OErsxLYnNX7HV6ePnA9QNITpik+KHptchK/nImcCi0ase2sspm6DwW8zmyWpx4V6R4Jm5I8QN+p+nR0yVQYn8EYNOZFQLwFWmGkYpELHSNCrijtW3J5vuvDy+g60LQv6eK6B17wpog9RGf7cZYK6q8igQFTivYrb9zT3DpahVb4vO0VLxyN1Q==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by DM4PR02MB9262.namprd02.prod.outlook.com (2603:10b6:8:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 15:31:56 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:31:56 +0000
Message-ID: <be759bf4-727a-4b14-bef0-80ec83b22c7d@nutanix.com>
Date: Wed, 10 Jun 2026 16:31:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] hw/arm: Use nodefault version of qdev props when
 not needed
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake
 <eblake@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Marc Zyngier <maz@kernel.org>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-5-peterx@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260609172514.2037645-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:930:d3::13) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|DM4PR02MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: ca30c030-cb4a-4b40-226a-08dec70567a4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|366016|376014|56012099006|22082099003|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: umoeNfltxtmap5IXsXEJkIVMQh6u+2FYFqNH9JuSqMdMkr7sUyZX+QEA81nRVqkOzI+9M2sHkGFtC7TEe3JK30AJt4cCv96LBHykkqRCGOX/olHY5djoRpKDQucMVeu/b3ja7pb1Ecxx4CGBFnsghVdVCx2TNLL/LKinTYpLMd+Y/AkvMxiVpPtJ5tVuxtVQwsa6XfHnxmgOFddul1PXiby33F3NsGWi8fixaPg6x6GM0yvcza9ljxb2e7pIc1KDXneYFs2SPuR6EK4eRHxXMg6lQvZhlMOwE6icEGaMfJZ6MMu7OMOJTvCvA3QVrUbdo4REEkpw6e/oYT2H6BtdYGZ+YjzHqqhyaVQafMLS76fvw/31+0F2M5N5ZlpqnAH+NxU2Ql6XpscUttmAsTskMhayYVxhI+9yfhNnHcjEXvsg3ZDcidAVqKpokil3XoBHRJlSSSFDBnA6QMEtsG/SbhaLVOS4V1TduAMt83BTc1h7NvkC5qWgiqvI5IgDXPG5W/F7wa7n59ODodi18pjM1UxLQ0+2v4+SxEOvhUbPJDbYPk5etieQywJ3i9BUmKsfQY2nhRP84PsKFdUtnm/zQEtBBaAyd5omxOohMNHBqCB7fo3G+ba/y7um6l3CKew3LUVGINwRLo1ZACP9gm1DwosCzIKvIKIcBqkgvnwVxcPVM/YCLJJaZ40frXyT0PIf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(366016)(376014)(56012099006)(22082099003)(18002099003)(4143699003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MStldEJvN3hFa0ZqeUUreFV3QWw1OTc3WlpMZDJJK015U08vRjdZUGJraXRV?=
 =?utf-8?B?cVAvZmhPVlRKSVY5WDl2cHdrMmVYVlE4L0tJdGxKdVdzakxjaUkxM3JpcjhR?=
 =?utf-8?B?eVpaNGw3WVZLalJYTkxRcE1XY014aFBHUzZKUFpqeXRlMXUrMDluNUpsbDEr?=
 =?utf-8?B?NGU2RmtmcE04SHB3V1JHRUd3MnpmOWlwNkY2LzdRU2ZvT0lOaVg4UWoxMWhl?=
 =?utf-8?B?VUtjQmE2N25oekZRL0xqNjhkdWRVQXdPV1lPUHhaNWFienRCQnE2Y1BFU2pa?=
 =?utf-8?B?elJvYVdydnZ2Z08yYldPQlgvN3l4UDZCTERPOURWV2pvSHo2UXBXQXVaWElE?=
 =?utf-8?B?RVVReVR2ZUFPNFlDWXlBbTEyRDFwbCtBamp5RDRxa0xWbFQvU0Mxc25jUHVS?=
 =?utf-8?B?YjFiWllXVGJwVThLYm0xYXFOblJnWU1IbmVTbEdHSXlTelp4aFZqVnNuVEcx?=
 =?utf-8?B?SElLWk43U21KcWNMT2hwNVVqUUI1eGU4dml3TU5IUS9VcW8vdTZxRVFKc0ho?=
 =?utf-8?B?S0ovMW91dkdTc2c2N2plOXB2L0JrY0c4VytsSHZ3YUxuTW1tK2xzRU9TWDV5?=
 =?utf-8?B?K3IxUGdkUlpFa1hJbUxka1h4amhFL1ZhMVBmL2dsb3VKUlZ3dFBVSzJRN0JF?=
 =?utf-8?B?RG1WbU96Z1NGSzRyN2prNktLS1lTOGxDa2VIeE0zSDZsSHlBWW84Y0UzT2JV?=
 =?utf-8?B?bDh1WjBNbTIyL1RQcWtseE9BbHRRM3BRQ2xqTW9TSDJEa0tZYUdLeFplUndM?=
 =?utf-8?B?R0xmc09nekp5QitoY2dPSmtMdEdoYnBxYlFOR2pJQy9CWlhrTThScnlyR0xx?=
 =?utf-8?B?dmw0RkdOVjk4L0s1WXhPMU9rbFFWbVNrWCs1dExoMXBvalRtRFVBUXZLOG1t?=
 =?utf-8?B?WjAyYUN6V05qNi9jUnh5S0pXNHpzWlZPUE44Z25xaEJiY0Evdnh3SkxrTnZ6?=
 =?utf-8?B?SlFGRGFGckFGTTRXYSt6Yi9tNVUyTUpPTHBrczkvbENqaHR0YnluTjVQMFhi?=
 =?utf-8?B?S3FPY2FFekRGTURFRlpCTW5lMkdwMU9hK1QvREtqVHFtbmViMFB0cGkxVG8y?=
 =?utf-8?B?c29BTVhFa3MzZFljbzFkQW9lT2t0N3h1ajBOYVZISkVzdjhMVjRKZTM3TGxW?=
 =?utf-8?B?Q1BQUXhzeERvR0ljVFNVS1Z3WUR3dGxIR0tFK0M4Z0MzMVJBUTNmQk9NVG93?=
 =?utf-8?B?UmR6SmpmUzYwRjdpVXBzN2FhMUhXWTlXRU5ZT1Y3cHA2eXFpY212OVcweExv?=
 =?utf-8?B?SXYwOUczLzh0MW1KOXN5dWJXNlU0MExaNC9Sdis2UmRLSVllaFdRSGR2K0c2?=
 =?utf-8?B?TWpMNXcxamRZTXRtZEtFV3B5YXZxYXY0aU9kd2RQMlRJMHJvRXFRTjZqazMz?=
 =?utf-8?B?bDNJMzZ0S2pvSkw2bS9UUFZBOEgreCtReEFYWEtnbkNhK0hObEoyOXpXelh6?=
 =?utf-8?B?bjM4ek1OQThyWEMvYVNscVA3bHdJSWJiSlZtczJYaHIxd3RJWkN1ZEUwTFAw?=
 =?utf-8?B?MFNtbFM2eXRLSTNBdHlCOWtOL0xNVlBnR3R1WG82bVlpMUpoVVJpQjhMWHFK?=
 =?utf-8?B?Smx3VUJYbWdRNVpSZU5QT1pCbzVBL3NQZENPQzU1cllFZGdWdVo1WDZVWHAy?=
 =?utf-8?B?NTFGT1VlMWMxRDI2N3REYW50R1JHTlJHVm5idjJLdGJWS2FpZktRUlVVTUxN?=
 =?utf-8?B?VkJBYUd3WlYycnY1bVRidHU2aGJhZmQ3RmRLTTM1L3U5TmxYZkd2dVZWZi8y?=
 =?utf-8?B?ajBRemVMRjUzc0FBRERDUllwNk9sQU9tWm5HQTJYbWhKc091dWRlZWppQjBu?=
 =?utf-8?B?ZEFwdjBBQUdhTWhMS2c2L1NZZmdpeE1hdGg5Y0FyNXFvYU1UN2ZMMlJYR2lM?=
 =?utf-8?B?WTRKS2JmL1N3Mm9GRnVSVVZwclcwUTJiVEg5T2pwYVkrT1E4eFlSZWtDTU5U?=
 =?utf-8?B?THE3V2FJTm9oQnVWalFwUXF0SXJHaGRYcEpPZy9TUzNxaXhicEJBdFA3ZXI3?=
 =?utf-8?B?WXYwMlpGN0tsOG95NFc3K2trL0tobWhJeWh1Z3c3YjNxSExFWHJEMkY0NDBl?=
 =?utf-8?B?ZWo3UzlCS2o2bU9rSUJ2TTNwMFRDR3ZWNDBweDBnOENYcVZaNVlWbHRyWVRG?=
 =?utf-8?B?VXNwYW4wRlhvOUNQQWNIaVlVQ0tFejBuVGt3Y3AzMWQxZWxmOFZuRStKUm5i?=
 =?utf-8?B?MmpoNDhZVjhqYitUVmZXbmsyZ3BTb0dRZFBBZmRBWkhGUC9Ua2pEcWtsMWRQ?=
 =?utf-8?B?L2gwN0p0VlYxL3lEZ3Y3Qi82a3k0NjZWa0M4NTRWR3c1d1Z5U2EvaVQyMlov?=
 =?utf-8?B?MHB6REpqd2ZIaThIcXdsTVJKbTFDMXplK2dtVHVrNGZkMlVDU3FycklHbk1Q?=
 =?utf-8?Q?la8A5Vd6BBr/aM9k=3D?=
X-Exchange-RoutingPolicyChecked: bZOnhFCWxyVmgY9HUPRRqooYIYy9z83VIM4tJfLECIGMGbVuujhwVqFZk+WJxR7C38cwdBYc6Z18+DAgx6VyZNCV640m8ADlzmmI+6px1F45aiWbhPzOK20YXKb0RjSWNp/SlLvcqrX2BGjsSLJtk1ef/dlTiZG9TLrAtRTIlh7v7not7PTjuBxpIQC82zgYPOSuQlUGv1TZKhQ9C2kVTKTKcq82TeeOBoYUqFrKVoMfZ2AdbZO0Fy7bN4LaF0rmEbX3n4t/A07in/wlNcrlvoVdLz+OuuADy3mv8kf1Jk/2fB6VgZkhA8wlIJmQ8r9YghDNGcf0yuckKolTU5fTnQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca30c030-cb4a-4b40-226a-08dec70567a4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:31:56.1945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDF+PUbYPLAdq70fP36mRDRs5QiBRW2F1q2hkx17aaZTcskxAwvGZ1NqVwk9QRHkxNxsEBZ6V0igkf905hYYL7VromHrXWwdWTR4vTb92Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9262
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE0NyBTYWx0ZWRfX5DxGegBBNN0o
 ydDzyz1Mkqf4mxUsPSBwsLYkY39qu2kJgCEMWJcW0f2nhQJcll2exNzUZZBlQyp5mDF7FLEYLEp
 fuLC64hPLzu9O9If4eYIm9eEGp39sj4SFVEUW+xghzSH1+ETJRPc3eueQAJNyFy/+gxRBPxqwzo
 szIL5BM4+DuHFNTbRn8Orn6pc1Tqdq6iymm38ePxTBiC1Jcb7y92C/4B7BCjgo+HLFT5W2bRsfO
 WnhkrVZS6MbXXo/18Tb/dmfodlZyIp6xdTxa/BOWSUAqsEKpZgmGdBQJpIlnqCFlnkajrFeBZAV
 Q1+yvxs4lCKRvM4SkOngBfAwc1REgnfZE31S06u2zyZoR1b1BwgWU83a3lXTsjQz4t4IsLxxxQ5
 ifqyjINC1U/EdkTt1yM/WIoLB8UhIXiQAvM2MiUk4CLrdEU7izUHIZsHiIbpjbLDJi+AXfw1mMg
 BmNGphZIJlj0f/tGE5g==
X-Authority-Analysis: v=2.4 cv=N5QZ0W9B c=1 sm=1 tr=0 ts=6a29836f cx=c_pps
 a=+8ozu11IBk2Dcx/W9SapsQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=VwQbUJbxAAAA:8 a=S56xvJB5AAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=oA5VVhga_OJsqttTzQsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-GUID: 9l29LoNYyqEHg5vreplGAOLMeHL6C3jp
X-Proofpoint-ORIG-GUID: 9l29LoNYyqEHg5vreplGAOLMeHL6C3jp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 09/06/2026 18:25, Peter Xu wrote:

> We're going to introduce defvars for object properties just like qdev-props
> defvars.  It work slightly differently in that props can be added in
> instance_init() with default values, then the default values can only apply
> after instance_init() completes.
> 
> It means any explicit set of property values within instance_init() when
> used together with object property's default value (or qdev-prop, which
> builts the default value framework on top) will stop working.
> 
> This patch touches two of such use cases where the device may add qdev
> properties with a default value first, then quickly set another value
> within instance_init().
> 
> These are the only two outliers I found across the QEMU tree that do it
> this way.  Switch them to use qdev-prop's NODEFAULT APIs, and always
> initialize the values manually.
> 
> Example 1:
> 
> bcm283x_base_init() adds qdev prop bcm2836_enabled_cores_property with a
> default value 0, then it immediately set another value inside the same
> instance_init() hook.
> 
> Example 2:
> 
> aarch64_add_pauth_properties() adds qdev prop arm_cpu_pauth_property, but
> then it will immediately update the same field (cpu->prop_pauth)
> conditionally when hwaccel_enabled()==true.
> 
> Without the change, some arm test may fail (boot-serial-test) after
> introducing object property's default value framework, because devices'
> values will be overwritten by the properties' later.
> 
> OTOH, this patch itself should introduce no functional change.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/arm/bcm2836.c   | 3 ++-
>   target/arm/cpu64.c | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index f4ecea908b..9e4d30c99c 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -19,7 +19,8 @@
>   #include "target/arm/gtimer.h"
>   
>   static const Property bcm2836_enabled_cores_property =
> -    DEFINE_PROP_UINT32("enabled-cpus", BCM283XBaseState, enabled_cpus, 0);
> +    DEFINE_PROP_UINT32_NODEFAULT(
> +        "enabled-cpus", BCM283XBaseState, enabled_cpus);
>   
>   static void bcm283x_base_init(Object *obj)
>   {
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 2816735577..a3a014a994 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -635,7 +635,7 @@ void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
>   }
>   
>   static const Property arm_cpu_pauth_property =
> -    DEFINE_PROP_BOOL("pauth", ARMCPU, prop_pauth, true);
> +    DEFINE_PROP_BOOL_NODEFAULT("pauth", ARMCPU, prop_pauth);
>   static const Property arm_cpu_pauth_impdef_property =
>       DEFINE_PROP_BOOL("pauth-impdef", ARMCPU, prop_pauth_impdef, false);
>   static const Property arm_cpu_pauth_qarma3_property =
> @@ -660,6 +660,7 @@ void aarch64_add_pauth_properties(Object *obj)
>            */
>           cpu->prop_pauth = cpu_isar_feature(aa64_pauth, cpu);
>       } else {
> +        cpu->prop_pauth = true;
>           qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_impdef_property);
>           qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_qarma3_property);
>           qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_qarma5_property);

I checked against the commit message for 5cc56cc687 ("qdev: support 
properties which don't set a default value") and this is exactly what 
_NODEFAULT() is intended for, so:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


