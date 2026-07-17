Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46E6C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkj0J-0006IM-CC; Fri, 17 Jul 2026 09:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj0H-0006HW-N6; Fri, 17 Jul 2026 09:53:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj0G-0002Wg-1e; Fri, 17 Jul 2026 09:53:25 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCI46c3859152; Fri, 17 Jul 2026 06:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qTDN7XbHBUzrOz9C96BOxLDINo7du4LJp54Cf0313
 u0=; b=i8e9QT4AfieT2AJqottgbf/KqjFeDrkzDYlwQ3sbPn6axXXZoIcMPOEXS
 3zJgQpWcNJzD+Ue4gc7CXACeR0fBjLatxhP2e2J/O6T+lkTQFaAvdv7ZpkCHsU/J
 Q8hE+cbL3wlBxQQrTqe/Yts5m/KnKNoQWPuig6uI0STKVLRKPEB8kAZDH2zVlrnF
 OiwLmgvH8vXW2hnolsPGNy2G8Z4yn5Ak6Np+N2kOxmv4M2IBPPUxfLKiXGirYmmH
 VpjuSuXBYsSSoTDosG+/4mRKnKsLWchr+OpPvsejt8dSbDS8BZRcwo6qC62wifk1
 /waLIkDT4eA9eCqi1itBMMPupwFbA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023115.outbound.protection.outlook.com
 [40.107.201.115])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ff7ks1rjx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 06:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ok7IDb7Ile/8lzC9n1daCZ+GTppC26H4e+fTzEzBUHrxzNmtX5LTMhwnBrhh2fnNeFQh3tapQRlKYKy9ZZhN6ST7mt4QtFTaBf+Nk3+ocB34CQPQA1U5Gu/icwpdhS9mwYqpSeJhBYfE2p9HblWzK5kgMe3Ga/fR3HiX9asKKItvXNQ83eqiQRigMOrH4FKRDyJvwqHqysyVFc/2v9IOsmuFm5j6YiOcIvnb9ksdqCV4jYs/tFuwYPThKJm0j9SxwQdVSOXZWLCFsNQW/aBFB8mPi1IFFwvkTMWGVM9L20r4Nm9MXUlh/OfUNHiyxy95usTBd6Hh5YcXu9qCWUNZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTDN7XbHBUzrOz9C96BOxLDINo7du4LJp54Cf0313u0=;
 b=B/wLLTRFv/Kxlk5wnx6vOUCxZ+206uakXBW5HHAOToL55qTHFwKTNOzWPwL32IpIMDu8d1dSCpzw0f1Ndddt8oZTKzaSqh29S9ngbGhifYct7XRBd4oi2nqpird7T4tM+f5+8aknRMEMcQmp2uJN4ly0VqsLoD7SCfhijNYFzr41mkxfpXknykErfbH6yd7YG+cVkFzRTEspMaDhb/NEP2jkYQG+iQ1DGhY9/MNfzzFRbpTtMmdNkgrFpp000nJYZVyIiI/KU0Bc22MXE7IC42Sjv5pYU5CPD+3KK6Z/y19UZ0S/9vKogcnw6Mk5ex6Ke34/ewwy9zr5ds+6nG0gvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTDN7XbHBUzrOz9C96BOxLDINo7du4LJp54Cf0313u0=;
 b=iv6c1owwZXUuZLq48mugArHTgJP8t8Jq+KXztBotrrqTmLLx9oithdJVcP7nlseRuit0i74QxxFYsQo2XMbxLqGBnoSN/NpiwmXM0BAYt03nGfSzdF3rMVaYyAhBOfLH2YveEBagFQmH/qhb15Ip0z7iFbEDAFz4unosFkuogiUOEq1xtAC/xc/V4QWv3jq8Mh2MPTOyCzMg57BjxhXc0yR9Iex953J/R2idXyb86kjvKU6odnW9AwJM3QL3qquAigVSFk+oYpmY8yrw1uoQguV5fR29kBOzu3nebrt4TfTXL3zs0mu91byqqEbFZItE46wXibVeYCHGvyY7t91lBw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8540.namprd02.prod.outlook.com (2603:10b6:303:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Fri, 17 Jul
 2026 13:53:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:53:11 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, berrange@redhat.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] qom/object.c: introduce
 DEFINE_OBJECT_PROPERTY_SCALAR_METHODS() macro
Date: Fri, 17 Jul 2026 14:51:43 +0100
Message-ID: <20260717135254.508701-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717135254.508701-1-mark.caveayland@nutanix.com>
References: <20260717135254.508701-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:930:11::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5b0a7c-56ac-4c09-316b-08dee40abd93
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: bkI2/t3S0c0iYlCdcjOTae1v2SlxZYy9YLj2gHO2ELoBXCAD1B9YJGdsxFzzuOxkZiaOrgl+Lg3Z4EWGkEyASgSQHLLWsCdQI9YZ/n5EAu6pgygyQmInVKj1kMECdmAzRUT40Pwz2kCaUNs7ZvZ0xkj1lfi6o86PRljpyfUxpfto2AjNXwv/taEsKexS/k4DYlFroUIdtYtqCcLJ5g60T5fRGWjzxUfvfXnaD0G65q0X1ndzXFxz01VWNmBRJjuNViJCgTG+4Z6XegMNXF3efO0hPtg76AGtyp8BwW2b/IoW+lIZCWx92wJ32wlLI5xhzA5viLH9W8c3yTxlKOgdBUHhpaSOGuD7HMvMWWO4/2gHCqbyANiC4wSBpJWi9s0e7xdXK3OnUjJrUEqykxrmmk5F3ULhM1Vn9HObOPxRMd08virnGSS9+hHVxiAm7W7LfTWSvwThik19AG6QUPrpEpPnI9IV2nCnHVCsgWeZWBZmYTNe/jx7k1tZdKkCZUi6XoyINYzTsZ5xVWqSuM5t5w3s0CLQnvQBQANuXvIBaYkmPbGoX6up/sIwZ+DxKeFUzEcF+PjhKEP9uQNV2OU3UlxAd6l5yL0X2twbtm709e7UIvBMRL/ngSv0dxtmcYfcCZZ3KKGs7ei1NNLcTvP6RPq4eTWx4G3YJzF9e7bo6/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmZhYTBNb0Q4RDBpZnIwSHZ1Nk83ZTl3d0NabEdQanMrMkNtY3dHN1c3Rm5o?=
 =?utf-8?B?NkFxYWNxbGZkb0tDODVVNmgyTHExWjJ4a2wzVWtOZTVNZldTQkNpNkx4TEZP?=
 =?utf-8?B?NVJpWllvdXNzN21LVkllbjlyVmZwbUw3cXJyZE1VbU15YW04WlVmdHJ1SGF1?=
 =?utf-8?B?c3ZsaEJYOHI5NlJEMVpRQTVKemxjNmpWU3MrU1ZLUGtoTG9Oa0VFRlZSWDg3?=
 =?utf-8?B?eGlRUzA2SmZ1TmN3Sll1UjlabnpZRG5xaVhoeXh1MjIybVJUWXgxYnZnZWtW?=
 =?utf-8?B?Y0JMTFgrd0VJanloeVFUbzl1Q0ZWaHVtTGtmcjNST3VIRGZzOU90NEJHdXRD?=
 =?utf-8?B?aWhKaFRJaGptK2R4QnRJMVRYZFJRWnNKc3VxTUsvaEd0Ykd1V2gvdnJGd1No?=
 =?utf-8?B?Nk13ZXhnYXVKaGhQT3V5elJxV1FRbFd0eG9hZjNBS094K1luamlYSXhmZE43?=
 =?utf-8?B?TWx2cWx6cmV1am56QzhLTG9ocUZ0R0xBVFhiaWNrSjJtUkZsK3doZ0NDSzF1?=
 =?utf-8?B?M3M0UzNQNk53MDByOHRVRFVsVGh3Ukh0c1QvS3k0RWZwc3laQkFKSXBQUm52?=
 =?utf-8?B?WlArK1djUWNiZkFiUGUvUFNyd0pTc1dzRGVEZmZCa2lFbDJhNnR6eDRkRzVY?=
 =?utf-8?B?eE9rN3A5aVpWU0U0Yk05N2F4UDAvaG5OYzNNelYwb0hweGFzUG9jOEp0bUFz?=
 =?utf-8?B?a1BOOERzbEZjTVJrVHQ1VS9NWWFHdHdWM25HTEdjcXhHc2xyeEkvRWovcHRl?=
 =?utf-8?B?cy9vL2d1UTdMT211NHlmdVNhRmNvOEN2WS9QZVBrYlU3SkpmRjhNY25ST0pH?=
 =?utf-8?B?LzRRODVzTkUzYWdQbXMvWGxPVTBDRUVIbDhlcmFrN1MyM2lnRGo5WksyWHhM?=
 =?utf-8?B?MWgrK0Q4NDhzL1F6OExhVkVudEJyL0hVSXJOL3Rpc0JjSzhjVjZlSWcxVUhS?=
 =?utf-8?B?MVJaU1FCOHZuMjNNa0FNb21IUGRENFNvSHFHK3Z3blVuWHJpZzlrU3N3Qmxk?=
 =?utf-8?B?ekRjZy9yOWFSRXZhTXZSOGdRK3J2MGxSNWZmak1DcGdHZkNpQVV6U3A1cDlZ?=
 =?utf-8?B?b2NXNGtIeERwdTdGc050a2tBSG5UdjRBeTdzcVk5VWszRjBoRXhtZjA4WTls?=
 =?utf-8?B?TFh0UCtlU1RMUE9QWks1MURjYlZjeFZPa2hGNm5iR1k0b29lK3hVb21IZ1Fr?=
 =?utf-8?B?LzYvd0ZjU25hcmlPWG4vdk9yM0gzVUNhNjZaVWVXR0d6Sitzb29pSU9VRCtx?=
 =?utf-8?B?TWF0SVFKOVhsTWJmdXkwYmd2RUJ4L1hORllhOHhCeCszS0hoUHlRc040enNt?=
 =?utf-8?B?cUxwQkhLRnR5aHpHRHJSZmg5TmpnN0dGMnZ0WWhpeHNWRklFODcxVWkvaTVu?=
 =?utf-8?B?S2VXUzlRMjNtUC9mTWE4OExrNHRnd0tudTdUSm1ibzE1b3Nwcm8rWU5iU2Zt?=
 =?utf-8?B?Y3hOU0FPWmpMWEYzSlJISUtPMUl1bnFFdGoyMmo1YUQ4TkRzS2lSNE9OeFdB?=
 =?utf-8?B?UngwSktNZWJkUW0zR0oxelJJY3l0dG9jem1zbmNQT1ZDVVpqNC9hSW9KVUFJ?=
 =?utf-8?B?L3B6OGt1b0haTUJQOHh6cFVoM01haXVNMSszNUhKZXZIVlJaOUZkcHhicFBV?=
 =?utf-8?B?RzN2M0xHQTVuc1ViNkdkS2MyZHB0ZkRwNFlLdVRrODNnWENyL3JJZkIxNjJp?=
 =?utf-8?B?a0JwbmR5L052Zmw5QUI0N3hXaDQrV3RNM2dTK2dhNEE5dnV4TStzRjA4U1ZN?=
 =?utf-8?B?U0RVYU8zalNncVBkZUJJSzQ5YkZaSTJXc25NaFhqWWpzZnh5aTNudkVTQThj?=
 =?utf-8?B?dWJuNkFoRGZPNzR0VlAydVJ1ZUVzeWx6dWFLOGZRN1liQUtGRWc4SWxvM3da?=
 =?utf-8?B?N29pSmcxZ3BIaVcrZUlTOFpvWkJIZnNCODJkekJOVExucTdHNm1GZ2k2VkY4?=
 =?utf-8?B?enNERmUvNHZjV1FzSU1pRlQ0SXdHOGwrV21tdlBhdHhZUTJXNis1eVE5R0Y5?=
 =?utf-8?B?V1ZROEpoOURBenBKdWFXa2VjTHYySXRPcjhDWHpWR2FTcVFyc1BqUzhjQjgw?=
 =?utf-8?B?R1owK0NRUUd6L0JDQStPbmtKL2NYQW16RFF5czF2dmVzeWt1MlNOa2pteExn?=
 =?utf-8?B?eTJTcVJLaDBlcUpsWEtwNk9QK1psaFozcnZVdnhVWFN4Q2JzR294MndOSnA2?=
 =?utf-8?B?dTd6eDg2VGcvdm0xU3ZJdHZYREtISk9HYXZ2YlU2UlVHUWtEUzEybzd2ZUxU?=
 =?utf-8?B?NjM5ak5BL012eFNmbFROcjQ3bmVLSVk5R003MTEzRjQxUmhVakZpeitPcjJW?=
 =?utf-8?B?TUF6VmlvMCsxU1IzbTNmSFNwb0FuOE5RQXg1ays5cTViVkY4ajJtKzNOTmlH?=
 =?utf-8?Q?tOKJTgXRWbumi+ok=3D?=
X-Exchange-RoutingPolicyChecked: QHGbDiUXN7Pq6NH/awHzmlMLRU1I7EbGEMzHJBJhi5P1nbukIh2v8eyXSHm5gMPkvUUycUb+WjP1ajUp/24jh43uO2wnvkSCeBFSdmFyBo8nzXsTW0HeahHIJtUNkS/eVHw++hUJiEW6H3azy+cM5lutDzS7wuUUpypNOxnlOiBmd7wTxtV5nRmjOXkeZwo1YTwVFpPA6/gW+cCVYCQ3TIuL1WiH03BXW8TgxdMFofRiacG2YjClgiKvVvHa252UMiUA7CU6KIijhsJPMcPN0Elnz6XYWKaJ0NGusl+Jf2NQ8VDMg7/Ug2B2q0dZviCiATcP7rssvXfolE1bq6zMeA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5b0a7c-56ac-4c09-316b-08dee40abd93
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:53:11.6570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qx8Y3gu/B3wHd/RQdOpcAi0Zs1oDytwrp2vSpC1Pzyfl2qw+dE7NoFLfr9EEn/LLsYsPNYIeffWSqV31+DIwjHM5CNItFl0IxYtXUbsvSXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8540
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfX7zDlbCJRC9Ja
 LHxBbCZZ8rgyGS+d030h6ZtIWzGgQCVorkaIqfDfg7T06BALQg8W36E2cYUivZhTFVscFnNgSD0
 w3D6LO4aP/2AH84ARZ1bGZ911NzZJedTOO5VJ2S75jGN0/cZfw45T0uQGxswR6DTUgR9L/ygarp
 w0GexOnnvLal+0OG67WYnAwotbTydnw609etgtOpShiMGmPGvgUXuh1p+piqUGmMpN05FE3ro1I
 DX/7WP4MUOxepVc1HPzdm7zVC+h0LizBj4eF8PUkgZUJnqx7jT5hiF6iYdCSuX9l9YefIgp4R4k
 cm66ZfPwFbrNIQMAp0trhe2XHUl6W1vQu7YnQXENW7DkC6Q/rm70DzFJNtmzXr7dx3q0Ol4jN+w
 rx0XSIvv7iBCmp3yB86mTmjJJSJ/EpHw2pxRFkXtuiIaPfqL1lKt6FXgVAx52F6/h1q+4V2CR9v
 EpwclfY1xlqYOSIrNZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfXzJHeyWrYNOjM
 Z6L/g34M6DRHLUCjprwX9Je2DXpa6cjHy+pTmpPNW8YzK7hI807BmyTtOv+1BZB8dfyOXhauvxp
 7E2w3fhzr7Rt5IYGAklObdQjtp7DKW8=
X-Proofpoint-GUID: BNjFSFAXF6MkwtaRNC_NxDfFrUheYOhd
X-Authority-Analysis: v=2.4 cv=BdLoFLt2 c=1 sm=1 tr=0 ts=6a5a33c9 cx=c_pps
 a=8YD3JtO18OBpAIphJ6JiAg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=MN20X9a0icJrC1ak0dwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BNjFSFAXF6MkwtaRNC_NxDfFrUheYOhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

This macro defines both the QOM get and set functions for the given scaler
type. Replace the combined use of OBJECT_PROPERTY_SCALAR_GETTER() and
OBJECT_PROPERTY_SCALAR_SETTER() with the new macro.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 8a1f80f613..622840f9f8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2687,17 +2687,20 @@ static char *object_get_type(Object *obj, Error **errp)
         *field = value; \
     }
 
-OBJECT_PROPERTY_SCALAR_GETTER(uint8)
-OBJECT_PROPERTY_SCALAR_SETTER(uint8)
-OBJECT_PROPERTY_SCALAR_GETTER(uint16)
-OBJECT_PROPERTY_SCALAR_SETTER(uint16)
-OBJECT_PROPERTY_SCALAR_GETTER(uint32)
-OBJECT_PROPERTY_SCALAR_SETTER(uint32)
-OBJECT_PROPERTY_SCALAR_GETTER(uint64)
-OBJECT_PROPERTY_SCALAR_SETTER(uint64)
+
+#define DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(type) \
+    OBJECT_PROPERTY_SCALAR_GETTER(type) \
+    OBJECT_PROPERTY_SCALAR_SETTER(type)
+
+
+DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint16)
+DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint32)
+DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint64)
 
 #undef OBJECT_PROPERTY_SCALAR_GETTER
 #undef OBJECT_PROPERTY_SCALAR_SETTER
+#undef DEFINE_OBJECT_PROPERTY_SCALAR_METHODS
 
 
 ObjectProperty *
-- 
2.43.0


