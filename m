Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD82C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk84a-0007Sq-Cg; Tue, 12 Mar 2024 15:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk84L-0007RR-PB
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:45:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk84A-0004jX-00
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:45:44 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CHgkgv009166; Tue, 12 Mar 2024 12:45:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=yi54PEVV20P7UjrIIUvxMub0hOxXiwcChc9pGtroN
 P0=; b=L6ZZm37o+BELxMz7GhjNmeX/HNVPHwn6G1AXjgwDOTjjmmJO/AKOfKC9L
 jmb5LP9C33FktzZ0w2oGirfKy5f3+l2RgD6KEbbO6q6Ds+1jbZXuWA4+WNOl7zn2
 wj4vDDNdfuqU72Nwv7sARhCq8W/KEn/RDKKcVNm4JMBdcOWYd0yMM+wKvcPTcQ+e
 vThGvsIjb8Ezor/oJKOYJe5/sdDl8t3N6vKHtE6nbFsv759I2akVyGNXZaHcqVMu
 AJJMtsNTpBukV5uQY6jtW8inHwvvptZWkd+8XK6LTnrFDOpruqZN6/n7MTdDVXF0
 YIDOw2tmqGB+Ubmak4qMw/G64HWCA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrmj9q0g2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 12:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY6txGcYHapWh/l1rf403OngSJLweriUbkqg0lAiY7Jc6nJXktJW6rtlQ55/nyf52uDiPWBV3O2eteE28SPpTW0GIN2qI4mAW2DZi7T4TU9C++OVUmGtXX4KztUoZLsjmACFYUqr+Dp5ftAtbJsspUWDVU1/fOcnj6MLFJ9KODl+OGkARQOAnnLfTIUI+xaIhWjeio3QY9jcvPIF5Ii3sIv6hbUcv7KqlsqVGhjTN2V3cr2fRz9lQACRQf5gurrwpU1ky9yRyxLCn/zaKVDjEfQcz7m2R9UWFCz49U005UW1h3Iw7ehvOwCHN92mfgbnfKEYO95IGMFLzRultXa/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yi54PEVV20P7UjrIIUvxMub0hOxXiwcChc9pGtroNP0=;
 b=OXwqV2HXKHpU+7+XMNjBmgGSsHViX70x/JDnfOdQ2GDiXGqP00Wz8Ebg4koDGR95Hmru+RBpwYo8hIvHz2mkxfm21opDV/qliPIDD6kPmHp8dWXq8WULmtM+g00D68mFn/bTM9atTORIQ2RV4ZsMpwcZJKmNlLwz0ZFBsQRDoxTRA5r+wAlUd9RvhEXgq1s2fL7/xLdXxfT9/Fi+nR1xHFyeQ39ejkGSJo+MNis0OiHdnSGl8pZSLw3NMC11onGSGzMehdXCxGfw6XO1gdaL+mNRVypXj6yz3qI1CsZBZ5NkvoMArqg8ucuKwEo9LWGghv6rhkr8EHrjI+N0U+mHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yi54PEVV20P7UjrIIUvxMub0hOxXiwcChc9pGtroNP0=;
 b=XIWKzEHT7YxYNQ5NFhgqcJsW+tEZKmo1IzDEaO8x/g1EimzniOA9mnY8KnWNYzWLaOuVwYO3SYGR3S7vJFPeXJP//GxIt58k5L6Foa5Wi24PGkHgHBqtnmyMWFTLzRfuAMurmErtJYjb8oHctuJdQeW6jk0UJFegtScr9hL5ZOopSUQ8lfSaX3FSWa9PGWcltdr5O5MM6svnuZ6whWRpb+iOdNFFiJSwortSoVJZ2lG60hRPhP7HzKj0H+sqks/BQBvAhJXDp6DaphduVD/J1+8hNtHgN2ImBHupglg8pyW6igCM+tNC/MH34SkGK1zoKai/KEOlQ4oGaOi8di1Gug==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH0PR02MB8133.namprd02.prod.outlook.com (2603:10b6:610:10a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 19:45:30 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 19:45:29 +0000
Message-ID: <e22a7b81-9604-4b88-8d74-1203991e5204@nutanix.com>
Date: Wed, 13 Mar 2024 01:15:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] qtest: migration: Add tests for introducing
 'channels' argument in migrate QAPIs
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, farosas@suse.de
References: <20240312162025.44212-1-het.gala@nutanix.com>
 <ZfCpgJ6dvorlpfO1@x1n>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZfCpgJ6dvorlpfO1@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::31) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH0PR02MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: b168521b-e3f4-4b95-5933-08dc42ccf8b3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXUQitoJK6Su8Sqv6mchu4E9fe69wVpSFTEYsuo6oefqX7SPCcR+ghJxhRZhwF+zpRmFG7M23IpPzsTU4fh9+0vL8X/7aQMu5STjfDbtqoJze83cWdlZgDdQ9uq1VHYTmQnKvVwzpWMak9LuzcEE+2fgxvJP5IVPluXCwfR4z4o9rAhCf6wj9ZqTkGy3cYZ2Q0DqcdQVVxfZ0rRot1CKAX97sx2Yp86VsDnDx9MsjzKNPCgbVw4ZLLMTZA3drcu6/9jLATav9AuxNAotqvI5xeIT/D7CozhyKa64wbdnjy8lTWGTAp8dZliQ5hOoAT3/T++WrmX+HHdY5DjhRITf99fkCYa09W8Jomxd4bTo71hpiPNFWpmkTv9DWClSeE7j0bP4vHinuor5Eob/jNjg2sk3UvqwGTGhZJW+0RIYWR/2jRfBYhgT7kWdEegwxv7JiCQl5c2cqR+b8GtaK9uk/3WpEsNLFTFZ/RcOgnvG900Ph3aV0pnGDaK7i2bbk8vzT7Un9lv8Xpeots6FzxUSyMah32OVTj0FzkIm4z+1IqzrZE9FSsxMTPGQXRgGBtMH5HlYN72QwnRkLGDfD0CuwQ35FvtezmMFKDVx5keOCVxnk2xFQOnjtyAqsmuikfqupvVv+2u6abfovzeXOK7xNMYgHEtYr9j8M2H14Pa88Gg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clVVRzNLOEpZR0l3QmhjNDM3TG5CYWVxWGVqWUtUYjRZYWNUN3d5UnRKQ1dr?=
 =?utf-8?B?VC82aU1QdXZlZ255QnZCRks5Y0E1aUFJZjBrVG12dGMrSzhpZUNraE1NN21I?=
 =?utf-8?B?YUlKdDRrVXlHZkdzRmc5U3Y3SkVtTk5FNWEvMFpXZkdINnNNUzBtYlAxTHdN?=
 =?utf-8?B?aUVVYnQrYXM4Ni9pWk5HcjNRaDA4ZCtrUDhTenVXZ0M5R3RHMzA4VXYwdm5h?=
 =?utf-8?B?bVJaaDQ3SVA5VmNGRmFtb2IrbXlvbjBwdVZDdUtDQTVDLzcwSTVVdmpsTERw?=
 =?utf-8?B?eCtadHFlR1JYSHk0Y1lYQlVyU254WFpZRkl1U3pLTURaOE53Z0d5Q0REVVpK?=
 =?utf-8?B?ZUNrQlBvd2tGNUxGMnJuZm00emJ3cVJlcHFRS3cxbVRnNmN0RDJudzd5Rjlp?=
 =?utf-8?B?Vkt5MDNPT256WlMyZXJJYmRCOFRsNTB3MDJaUUgzWmF2dEwzR3NSbHgzbWx3?=
 =?utf-8?B?YXZaay85ZUppWEtYWG5KaXl0YnVQUThwdEVOMVI1aUQyZGRvUUczdSt3TTl2?=
 =?utf-8?B?QXF1Q0NsZzVMR0JWNjR0TDZXbklvaXU4ZDhHd0Q5NUdUWnpiVGQvSzFrUEJM?=
 =?utf-8?B?U0dRNWVtM3EwcEVraFNxQVhiL2ZLMUlkeDBSMVVGNWtKeDh4VmpYL0l5c3l1?=
 =?utf-8?B?bkFKbTF6RkJPMXVKTGVCOFVEcnVqSlhyQ2JxZFpYOUFRVzVETTNjUHhvNC9M?=
 =?utf-8?B?bFBjNEgzc1pMN3VJelBHTXIrMWxWbDg3NWFwUVJWN282N0hJOStDeitpTmJB?=
 =?utf-8?B?eTJZaGNMdjhPK29EWE5YK1Z3ZkNKK3J6TUFvRmJPUmpGRkVSRjRUVlAxOGZZ?=
 =?utf-8?B?V2hmYkpCdGhvVVdmWG51clBoZHRodW82b2FrNUdTZnlaZGRGbUhKa3ZQbjdh?=
 =?utf-8?B?dEJvUncyMkQxWDBNZmd5VlhCWjNDTkl1OFNlakhzQ01nU2FDdTZDYTR1Vi84?=
 =?utf-8?B?RnJwaEhFNjRmc2NablBkTVREVzA4WUMzLzlLblFrNktqa00xRkFYK2xmRTdJ?=
 =?utf-8?B?T0tRWWt1MThLTWkrN0Z6VittcExXMUNUYy9oVzhQK0pwdkVaZFN3aURJWVZs?=
 =?utf-8?B?eTgxYng5WEt3clYzQUVRZ0t4MkR4TjZNSWhjLzZoREtIOTE3Z0Yxc2lWSTVu?=
 =?utf-8?B?M3U0ZHFEN0lRTWltWSs0MEllMHdMeWhWZzZyL0pKQlgrRDBMU2VsUm1RQXZx?=
 =?utf-8?B?OXlEM0JNS1lpd3dYK2JxZGJhY2FwVjRwbHM0MTdLVDNENS8xcWhESmVWdjh5?=
 =?utf-8?B?WXlMamxBWnM1aGRtTWFrSytUN3JHdXd6RVl3TE1qUXdvbCsydXVZTmdyaG9U?=
 =?utf-8?B?cjVEcXFjZWx4RENUc0pZdTZwZ3k4K1MxSFVkL0s1TC8yaEFCT090UlBpblFi?=
 =?utf-8?B?c0xvakF0N25LazcrZktYaEJRUGNGNDJWaUZoMkhlMHE5czFuRDZmb2JKRlM0?=
 =?utf-8?B?RW1pSW5PeDVKQmhRUkJjT2ZyWGx1YmFqc3RmUC84RUVoS1FpNmVOVFBGNW9w?=
 =?utf-8?B?U0ExRFBhaDhHTzlFYkxIVWorUjEyWFU3NTFGRnFUZzlvR1N2ODJDM1ZHanI3?=
 =?utf-8?B?K0dNUnU0anJNbXZBaUR1ZlJMRUpmclJjQlZ4NDBRaXo3eDhpTkVKQ0s4b201?=
 =?utf-8?B?dy9oSEJUTlQyV1FydTBlUUdhejdNSlB4Sm1jTStCLzNaanVyWFE0aFFQdUFK?=
 =?utf-8?B?eTJ2bmJoRnVFUTdSRW9YcEdvcjY0U2FWbXpsdTVyelFVWHhBUUxLbHVNVy9U?=
 =?utf-8?B?VVhPV3ZuK2JTZ1ZLTk1mNGplYmtsWkhBT0FjWDNKeGg0R3RrdDhEaW4rY3NG?=
 =?utf-8?B?UTNNYlZpRC85NkNMUkxyUE43ZE1Bc0F0b2pSVlFTL3dUeW5OSkpzWXIyUVJJ?=
 =?utf-8?B?YmZqdXZMOGJhZVhQVVIxdzJWVWJxM2JHQUhPZjkvWDdLaW9QVDZTZUdFY3o0?=
 =?utf-8?B?N3ZDVzRUb1VYbXQ2VlpiN1MwQ1lDdXcrbk1QM1BXMGhKcFVUUTlZQW9uQlhT?=
 =?utf-8?B?OFVxaTI5RjNHd1dwRE41V01IQ3d2KzZtVFdyVGsxSzRnLzJWRkZnZ0QyVm1F?=
 =?utf-8?B?Sml1RUl2QUluU1RnOTdNUUZqeDFEdXBuMUVNK2JwU3EzczhZRzRtb1NsVkkz?=
 =?utf-8?Q?MxIjMvgH2Xbr49spiYFImXEfa?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b168521b-e3f4-4b95-5933-08dc42ccf8b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 19:45:29.7348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaH8MLAj/cpdviWeWZYgyZXPRbML5YjJ+P8/fhU9USjWbccoBIfc7JJu1zd++orpb/soIjqNajdzv/QS9gqU3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8133
X-Proofpoint-GUID: LYTTeM4fsX2Z_6XR7HsZfD_3G6136TLS
X-Proofpoint-ORIG-GUID: LYTTeM4fsX2Z_6XR7HsZfD_3G6136TLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_12,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 13/03/24 12:44 am, Peter Xu wrote:
> Het,
>
> Could you rebase this to latest master?
>
> Meanwhile, please provide a prefix in each of the subjects, it can be any
> of "tests/migration-test:", "tests/qtest/migration", "tests/migration",
> etc.  I don't think we have a rule yet.. but any such prefix is still
> helpful.
>
> Thanks,
Yes, sure Peter. Let me rebase it to latest master and also share the 
latest passed build link.
Will add "tests/qtest/migration" prefix to all the commit message headers.


Regards,
Het Gala

