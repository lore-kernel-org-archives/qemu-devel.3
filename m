Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD974C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMue-0006wm-TT; Fri, 26 Jan 2024 09:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rTMuc-0006ug-8y
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:10:30 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rTMuZ-0000NG-VP
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:10:29 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40Q3ZEUQ007052; Fri, 26 Jan 2024 06:10:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:from:to:cc:references
 :in-reply-to:mime-version; s=proofpoint20171006; bh=hRzZs5uVXseG
 3Aq0B+g/n8WAbCZo5IS0IlitkscT5V4=; b=YRsU3cuYmdjyOykEC4Jct8Qr5gn6
 J6kYSRdnBfiY/h3zTVgr7noy1ii9Cq3lvnuG5WIu6bIhb+V2zGOU6nfe0riurV4U
 /A2rN30JUmJOqRor7Wmt0CCYiVICvaAv0SkL6+yhIEsx3dqU41FCnhDyBmQrocO6
 JUnqg7ksrnUAsBUkwK7rF1xPeBjRa1CgRdTE68rOoOU4VQ1GL920IVipb4cXau6O
 W1NW6dtT5lVMfeqPk56D08Cyp99pYCfqd/5YSFk069Oa/FhQ4DULAmvHbvEZ24GI
 VcqfQIAhNfzdwJYDuRBTTuBvBurUwLOzqu4RUmFFpewzk4Tki9BwOFcoSQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3vtmgsxfx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 06:10:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la/9hWH117c2wveBX8jAPe7qzrPYSXFZ0O1gzKoni6OTL2FHUxcv7Zn0RvATgoX9UoKU64WhlPzTBM6lpWiZHQIC5lx1WzNwGuQjMqjXLafSQm3FzwdBDYXCOZv3w8bisg+h40fAyqxkE6NYC7xvMi35X+LLsFtY4hgfDrlZGQIMHyCK6ECkwoBeYdeS2SVVRXPnmEUsiwU2j2u97b9RHHE67BQW+m3SeAZsXTt98VslFXicXvjBbmZhgo2djXtdtgi8wam3A0X6b8Ih05xXkkAJ3Pv3KQXbTTK5mkjJKeD5OsUhLyJ8buwI04DobPHKXk8gTiXj0nYLx4+dcOTOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRzZs5uVXseG3Aq0B+g/n8WAbCZo5IS0IlitkscT5V4=;
 b=a/DqZXxwp1TJSl08wXH3kErWtHoQ+LDDYKHCuZreKusMM0SMIOs9BDU0CEDtDn8HFKdM3RXRMnN5zm8x04FmMkTrZ0hmHWs73IqAFinmUAqel59VAXRazm8wP6D42YHQEsWiSTAUSPj9fyY3NTYnBr6fUQ/Gogsd3tlvEXpTUGyHuSFOniysGOtQsLIShyHI+lsIJu+BBcLRnr4ZtrL4787eYuH4e9IBJrgg9sDyaBkw9BukeFvfGZzQkBR/wBiTIoBYYui0exjB8Xb7sa8m6gE94jTd7dO7fKlPqWWhw/SOkPINVmIzFqcJdOIZDdRQ1TeM2MiKCKwit6LugdhnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRzZs5uVXseG3Aq0B+g/n8WAbCZo5IS0IlitkscT5V4=;
 b=YerxlM16QtsGxAKygQ+MNObI8hZgc7p38r1WivDpvitWVhYX0oOIQPZMczwjzVLIHoHl6JsSEWiKQ+UF+05Ulq69TG78LB54IRVEmeasKNa4sIe/XlZWdTIm9x6G+sAYpdkVy/uO7uQl1xUObxBaopJoPhliCzOcw1DbAthu/LC18IKmO0jeTur6B9AkfTOG5aSykZYa4cRauNhC8L2yua/vlB3Zqf7m1Crob96Dkyp93StEnTFcnPozY3ZgB+ZLSjk5pkB3fIs3MhBkNLLwc/19DVYph1F+XlQorMyt7e9HdvqmWvdF3u0nQRgK7e2Pl2dZqV9aRkJz4RYmG5XLyw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by PH0PR02MB8647.namprd02.prod.outlook.com (2603:10b6:510:10f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 14:10:19 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::bf6f:93ea:cea5:91b5%2]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 14:10:19 +0000
Content-Type: multipart/alternative;
 boundary="------------SAO3YmxtNpj63t06OBJsEXWp"
Message-ID: <238e2577-931a-418d-8af3-b1461e7b126c@nutanix.com>
Date: Fri, 26 Jan 2024 19:40:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make 'uri' optional for migrate QAPI
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, armbru@redhat.com
References: <20240123064219.40514-1-het.gala@nutanix.com>
 <Za93I-50U745B27C@redhat.com> <ZbBrN-V8goSJxEst@x1n>
 <5fa6f674-a08f-45e7-a89f-028d91c6b8f9@nutanix.com>
In-Reply-To: <5fa6f674-a08f-45e7-a89f-028d91c6b8f9@nutanix.com>
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|PH0PR02MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: f29953b9-38ae-4c50-b8b4-08dc1e788702
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Anr0o7bLvJN5WNBkcemP85OF1LU5uC3S1B1YfA/04IcMDUAouO7mU5ioiFK7u1mETkVWup6lwrvD0PHPjEJGCmRyZF/evjRb50e32w0aSLszkkSRMkpxd9dVNv/rYZu3n50bAQkEi2+KYUGmzSRF17365AStja+43ncRCzZX0LGAA1e/9iV04ESyc4oJm04v4+89enD1FC89+6/GRMZYe28ESoKhYSBv1E6onENEZrf72VCO5OepLAp/WPJfYWkqZb+3LlZfvN+PPspi1yIEkOsxMs9laH4WCE6qTa8/Xrq7j9X8Q2sLUacidMoaK55TFvQ3vEi04f8YzB6SmEJtWxaEVPigMZAPZycev63IYb7IX4LH9Gzuo3QpA7KEsflm2pxpZC6zEbx6PYQunbBOMG7fGJfEaMb1w1j9lX2QLFPbpd7av8J8DljpeXoq+TkCYNz/ofZp29Vg7CCjzOxgjBkODaZg+PUGJU1qzORYkjPYOZJSOT1TI6eAaDGx/ybGo2lN2KoJSiNE6bn+efI824dqWPguMWg/u/au3D3mRoK2ezK66JLPs6N9l78h0AxlsqjG8kLKVo/9GUolYKl8p0YXkaO5RSCGIjaXYAz5mPq0LnevCsS94P53EHp0AFthCA0q0A8x6eY4NB6qeIp02Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(83380400001)(31696002)(36756003)(86362001)(38100700002)(41300700001)(66556008)(2616005)(6512007)(26005)(6486002)(316002)(66476007)(2906002)(110136005)(66946007)(33964004)(6506007)(53546011)(6666004)(478600001)(8936002)(8676002)(4326008)(5660300002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KytCNEpMWlRnMDhheVZZWWlnYVRhVTFhN3ZDdEIremdrNVl3UEM4SXA1Mmt0?=
 =?utf-8?B?cndncEJPamJBeFBmcmtXN0dCSVdOaGlWbzdRdkdiM2ovN1BJdkx4TTUwZ01Z?=
 =?utf-8?B?aHF0NkI1REVURG9SaHNiSE9pMkJpTGpnNVh4L3dZay9qeUtxWWgwZWVtMWJk?=
 =?utf-8?B?M3ZlMktQMHZjb1JNbDBwNXV5OWRacVV4ODI4TVJGaEZBZUdVa1FEdVBPbEdT?=
 =?utf-8?B?QlJkeC92MTZXS3hUTC8ydGxUR2FoWmVobmg0a0o0YmdJcXQ3Ni9QOE5zTkU0?=
 =?utf-8?B?eDBPalNabEVxcWNXelpqdXNvOXRqUHkrclNsQlJqa3R5aGs0eXBENWhvTnYv?=
 =?utf-8?B?WThhTWNKSXgwaFh5K3Z4R2dyeTcvSmo0R2o1cThwTmNHN1pqN2p4OTZFZXh6?=
 =?utf-8?B?ZDJ4bVIzMjBYT3ByVXIyTUMrMmVmVkErdExSZGM5S202elV1bER5MlR1TTNQ?=
 =?utf-8?B?WWFPUWFQNHVyaDVvR3AwVlViZjlMVWxCVVFRR00reFZvOE0zWWtkR3FuZVdw?=
 =?utf-8?B?TzBSWVN5T09zTnhVNDBZLzN1Ni95b1pkWWFueFVpbEJDMVg1Z2NobnZKT0tn?=
 =?utf-8?B?K3Q0bmoyQWVmZGJNSUJjU3V1QUxsenAxbHFJZklWNTN4MDNKMDdJclo4U0Vj?=
 =?utf-8?B?VWp6S2RXNGx5cWZvUWQ3bnpNZ3VSOXVzQ0hrTFVlenN2Z2dNNndtU1podW1E?=
 =?utf-8?B?UEZtZGk0OUhnbUVyMCtNTkNCcWZyOS84SmVRQlJ4ZStaU3JTUjhDS0JhVnJY?=
 =?utf-8?B?elMxcG9WdEJwSmNMYmM0TStrNE0xVzlySk9ZYWMyQjVWdlZzZE4vQUdTaEFt?=
 =?utf-8?B?ejd0RWFQM1l4V1pUZGg2YUpMRjNCYVUwUm1oRmp4bUZPMEkvNHRYZ3I0QUdM?=
 =?utf-8?B?bTVoclMwZ0ZOK2krT2d6QktmSEdlc1pMWEh1YmhwbFlybFhoZlUyaXpDeDZP?=
 =?utf-8?B?ZnFpN1Bhc001bXRmV0JicE1NKzF6cGdrYnZFdWErV05uekYwU1RGbEVtdTEy?=
 =?utf-8?B?M3JaYzBBMnNXUUcwYU1XOXcvdjJxczErc3VuNzlSRGcySjhjMFRxdlpYa0Z1?=
 =?utf-8?B?dHVHSjRLK2VIRmIvWDJOeVk1U0pWQTkvTVNBTzhEY2xRbTl4dDliREpSZmVx?=
 =?utf-8?B?LzEzQlpYSldFMk1LU2dRRFBrQ09VSHYzV1JMLzc4N282anVlWUZxb2JxdEwx?=
 =?utf-8?B?V3VXV3R4RkIycFdCNzFXL1UxM3lia090R0tFM0YwSEgxdmo5bzlIVnpoQ1ZT?=
 =?utf-8?B?RUhoQUUxMWJlSUw4N2JNUzJRWkJPZmpaWEZCQnVIVHVhdlNoa2xjdGVnNUNB?=
 =?utf-8?B?aExaWTBCdEJyYjBhcm1BVEVqSHNmU1Y0bWFvdWlnNlJVS2VrdjBqUWJDdkYz?=
 =?utf-8?B?ZUsxbmt3OUpRcUI1ajllL0ZqWVRZdndSbXFUZ1ZIZm5wMnNwUDRhVEg5aWp1?=
 =?utf-8?B?eTlJdFUvb2krU3M5UTZ5TmFPMHNjWUFlYjB6ZHhNaXhvL2RDSUJzUS9vN0Jt?=
 =?utf-8?B?WkQwdHVLVW1kUnB2OVlCNmFvMEk1MUZZa3UrRmhtWlVVNkI2bk5wMWh0TjJ5?=
 =?utf-8?B?SU5mMWNZOGVaL2NaNFU1Z0dhWGNuaForNyt1WloxWU5HM2VjbVFlajRiejcr?=
 =?utf-8?B?RGR2UjZNcytFUkZ1blROZkNqL25hT2JqUmR5U093cXdZREpFd21qalMwbXRS?=
 =?utf-8?B?WnpnYjFCNVBqRmlucHE2Tzd2cGY1OG90ZkF3YURvazhvcUV3ZXBrOEx2c2ZE?=
 =?utf-8?B?c25KdG4zNmZnTUlTcStHMnVzMjVoQkU5VGFmZm1KUWFxd2VzMWp1OURtTUZ4?=
 =?utf-8?B?SVh2bXpkcUJweGs0dWJnTDVUbUVvRFNjSE1LYjVjOFJyQ0ZxTnVOY09yZ0dX?=
 =?utf-8?B?RmlBYVE5OEpoS1NtRTdpNHRJdUhDVTRxK00reHVyd3dYL20rZXdFb1o3WUNF?=
 =?utf-8?B?ZG9Lb0hwU0NYY0wvSys4QzNYS1BOTjZYZEIrbzh5K2UyM0JXSmgxd3pxYTNI?=
 =?utf-8?B?ZmUwWkFQQTZoQ1ozQ3pxNFBvdUlWeTdERE13Y0VPSG0yYVJQNnliM2RXOUxS?=
 =?utf-8?B?NUhHOE1CbnA0UE9Mam9rNTNPZUg2Q3BidWJvTnZtS0FwamgraSt3R2VMbXJ0?=
 =?utf-8?B?NkZRUTVxM0o0R0QvY083VCthQUZWd1RBU0dCc2NLY3RkWHd4dVZ5elc2R0NZ?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29953b9-38ae-4c50-b8b4-08dc1e788702
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:10:19.3238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylsm7v3jDspy87CEhIcuhG5iiL9ceDl1PPBqUQE3mPZAHO4u84kElizkXJxRLcWCPYYdhycHdlgD/PLBv27+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8647
X-Proofpoint-ORIG-GUID: lPdu5nfnjN3M9dzYfKBuTKdhIDY__8uR
X-Proofpoint-GUID: lPdu5nfnjN3M9dzYfKBuTKdhIDY__8uR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
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

--------------SAO3YmxtNpj63t06OBJsEXWp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/01/24 10:03 am, Het Gala wrote:
>
>
> On 24/01/24 7:13 am, Peter Xu wrote:
>> On Tue, Jan 23, 2024 at 08:21:55AM +0000, Daniel P. Berrangé wrote:
>>> On Tue, Jan 23, 2024 at 06:42:19AM +0000, Het Gala wrote:
>>>> 'uri' argument should be optional, as 'uri' and 'channels'
>>>> arguments are mutally exclusive in nature.
>>>>
>>>> Fixes: 074dbce5fcce (migration: New migrate and
>>>> migrate-incoming argument 'channels')
>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>> ---
>>>>   qapi/migration.json | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index eb2f883513..197d3faa43 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -1757,7 +1757,7 @@
>>>>   #
>>>>   ##
>>>>   { 'command': 'migrate',
>>>> -  'data': {'uri': 'str',
>>>> +  'data': {'*uri': 'str',
>>>>              '*channels': [ 'MigrationChannel' ],
>>>>              '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
>>>>              '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
>>> Hmm, this mistake shows a lack of coverage in migration-test.c for
>>> the 'channels' argument. I thought the original series adding 'channels'
>>> included the tests for this. Either way, this needs to come with test
>>> coverage for use of 'channels', with 'uri' omitted.
>> Agreed.  Het, do you plan to provide a test case?
> Yes, will provide a test case patch for 'channels' soon.

Hi everyone, I was trying to wrap around on how to write a migration test or to mock migration.
I see there are a couple of migration tests already written, but most of them focuses on just getting the uri and parsing uri to start the migration.
I have a couple of questions for starters like me who is attempting to write test cases for the first time:

1. Do I need to make a whole new test or just edit one of the tests that is using uri, and instead send in 'MigrateChannel' struct and parse the necessary information out of it ?

2. Do I need to add tests for unix, fd too with the modified syntax ?

3. Do I also need to add test to ensure - uri and channels both cannot be used simultaneously ? (based on the above patch)

4. Is there updated document in Qemu to follow latest practices on how to write migration tests?

Regards,

Het Gala

--------------SAO3YmxtNpj63t06OBJsEXWp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 24/01/24 10:03 am, Het Gala wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5fa6f674-a08f-45e7-a89f-028d91c6b8f9@nutanix.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 24/01/24 7:13 am, Peter Xu wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:ZbBrN-V8goSJxEst@x1n">
        <pre class="moz-quote-pre" wrap="">On Tue, Jan 23, 2024 at 08:21:55AM +0000, Daniel P. Berrangé wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Tue, Jan 23, 2024 at 06:42:19AM +0000, Het Gala wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">'uri' argument should be optional, as 'uri' and 'channels'
arguments are mutally exclusive in nature.

Fixes: 074dbce5fcce (migration: New migrate and
migrate-incoming argument 'channels')
Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com" moz-do-not-send="true">&lt;het.gala@nutanix.com&gt;</a>
---
 qapi/migration.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index eb2f883513..197d3faa43 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1757,7 +1757,7 @@
 #
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str',
+  'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
            '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Hmm, this mistake shows a lack of coverage in migration-test.c for
the 'channels' argument. I thought the original series adding 'channels'
included the tests for this. Either way, this needs to come with test
coverage for use of 'channels', with 'uri' omitted.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Agreed.  Het, do you plan to provide a test case?</pre>
      </blockquote>
      <pre>Yes, will provide a test case patch for 'channels' soon.</pre>
    </blockquote>
    <pre>Hi everyone, I was trying to wrap around on how to write a migration test or to mock migration.
I see there are a couple of migration tests already written, but most of them focuses on just getting the uri and parsing uri to start the migration.
I have a couple of questions for starters like me who is attempting to write test cases for the first time:</pre>
    <pre>1. Do I need to make a whole new test or just edit one of the tests that is using uri, and instead send in 'MigrateChannel' struct and parse the necessary information out of it ?</pre>
    <pre>2. Do I need to add tests for unix, fd too with the modified syntax ?</pre>
    <pre>3. Do I also need to add test to ensure - uri and channels both cannot be used simultaneously ? (based on the above patch)</pre>
    <pre>4. Is there updated document in Qemu to follow latest practices on how to write migration tests?</pre>
    <pre><span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span></pre>
    <pre><span style="white-space: pre-wrap">Regards,</span></pre>
    <pre><span style="white-space: pre-wrap">Het Gala
</span></pre>
    <blockquote type="cite" cite="mid:5fa6f674-a08f-45e7-a89f-028d91c6b8f9@nutanix.com"> <span style="white-space: pre-wrap">
</span> </blockquote>
  </body>
</html>

--------------SAO3YmxtNpj63t06OBJsEXWp--

