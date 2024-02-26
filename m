Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28EFC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehX9-0002QE-RN; Mon, 26 Feb 2024 15:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rehX8-0002PO-BK
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:25:06 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rehX2-0000iZ-4n
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:25:03 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41QG0Eq5013410; Mon, 26 Feb 2024 12:24:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:from:to:cc:references
 :in-reply-to:mime-version; s=proofpoint20171006; bh=HD/eZ6lZubdq
 IIJdyZzIuZlAmEd6MwE2/IsAO45JT80=; b=fa7qCIUNeru3GdbaUdu5ozxXk84i
 d70Ab6sRizFiw4GKR/rBPjD/x/PXRyA/v+79ouE0tBjrUM9liIRrfCxburW5NwpR
 YykqZm5Qrj4o6aPGSqmjG2SLrWuCvT0XXAi6Kr6Yeu6zps3MDULQ8bjmGFR6541r
 5r9KaGjcPDXzl/eazMzmY1MN/vRaIoxKSKlDrFTqpj3k4YhJg3YIvqTfqd/f1Exr
 nTJfxP/gEEFYCGVkWR8P73+UtCSav7cp8P8S0SBaHzfoISZjE87bls2oJTW/CCFV
 F4t2+7CzI+lMqCk3t2agHDvLGlXD/39yYbeOGOfNbdNO4kp6U858vh0OFA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wfgw0mb1s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 12:24:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnx4ACHEkkTlzPwawxld9MywPkF0HfRFQqI26uy0GAnlW/bf6QAdzbSnV95j59k/iCW02dV9liPfDVYrB7SwIZRNehgzYRs3yReK67JH1EKddZRUbTarK1mgy0GhrvmQ8LDQeJ5EKAork2sQgAXa9LVoiLf2XVDuHNCQcnt/nUNc7oryEGGjcc9vSfr3dbXr2HBScifTTcLdxpik01bofkxI2APvF7A2u7IaPnmgrY4N6RvSa/hXn/SI3Pk1FJ/hrJojOroMnHxduvRgTucbntlLsNIoDigtSFmA2F8ghPEzyK+6Sf8xquI/va8rruDleGuob/IfEuj4GTVmo0ejCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD/eZ6lZubdqIIJdyZzIuZlAmEd6MwE2/IsAO45JT80=;
 b=cNujA82299oSIpP76fDIvu0tXKovhcka6W55cpCZpjeOypC2DFNaRYPYSzNX2rRQ5SDIjIAdaAfGPFRgI96AE/86KCqnHj2nC05E0dfuJT33LS8KEuxgD96jy/ThgXQYLXjq2Eo7PsDtQrkC/2StAV2jepCIyF3DRAcc7Xp03WIBhkc5AORYMtTxDOYN2XbOrOEkqv4Mo82la1t92glXaA+jLYS4Ns/F5BAcH8/biQ//QqlR8RLtwArgRRnQzii780UsTykZPvh8BWk9dyQRJAx6d+09FH9+hTpfUJCnIoD57SK+uM+7o9vhGtX+84nCA7Wogy2TEqcySTZu8VIADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD/eZ6lZubdqIIJdyZzIuZlAmEd6MwE2/IsAO45JT80=;
 b=Sq8RhRu/pcoNd6mEUpsUJHjGBUbaey0wi9eHK6/ZqI3Wagge6sm1yjgD9838ouvNpF2dvud1XcXuB3tqmhZEGdNt8l1JR2Cdgcp7v8BKRPZIXH+xKJxsGyYQ0ePySQAv8iEn/Zw4Ku+mUdJGQ2lUdoyLFx9B2rxifnIjePFPmHRqr1DxaUPS+Of7ylcLmehm9DZcOXe2/celXMV3u8inNdsdZlTxNN5fsVbq6MKGhtUePTg6h0Zd9Xake05wBsyf/FEvltVtV2q/wnOIC4k+0ra3QRlNU3JqyxDqsyd9MhBhxuGIyXRu6d8DjWBGMrwoC9itDkHaGh1fGexDSIDaaw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 20:24:53 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 20:24:53 +0000
Content-Type: multipart/alternative;
 boundary="------------ZoYSPtfjO1Maiw10PSPFt0Dv"
Message-ID: <894b5da4-0af1-4ca0-b8a7-da288bb20774@nutanix.com>
Date: Tue, 27 Feb 2024 01:54:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com> <87zfvr7xdn.fsf@suse.de>
 <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com> <87bk83bcqj.fsf@suse.de>
 <32687fa3-78dc-457b-ae50-854d2c72c922@nutanix.com>
In-Reply-To: <32687fa3-78dc-457b-ae50-854d2c72c922@nutanix.com>
X-ClientProxiedBy: MA0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::16) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 420b6ce7-d0bb-4afb-5bb0-08dc3708fd3c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbnIl+Uw2m5UDAnpXcw2izFVpynE4eG39jJgFcNTez0Dtx/ezTWQiN4v0TpI3t0qCNgF9n+Q93YUsdA4OoD22SxpfCeFqih66afGyIYSuoUxU18D+mb+l0IdjxmwKMhU3ILFflqZ/FlEndzhJ/U0YhTVZtOwVJPt4Kdj1U1MMbHVR/z90rYhqV1MIfNOTCy6qu+IsjEBH0gjHoQURb2Vqt5zU+NTESnhUMJ9QQfm3X9AGCmkiAk6dYFolGYVhQBtNVTBb9kMuyDYK6ijMokFfrdrK5b0zQCh0QVgfEjDcgfVTYDg/vNVfnN5nTaUrJAG+bWdkX0bwe5740Vfoi4ajlzySgIzr2CEs7FteD5AafiUCx+k1UfIoOBrrOVZ58FKo038jQeQunHrJdA/Ph0F4oloQDMAi2PRBsubWdif9CqChh6dlti6lBvW/3xuahmkylAybMn+4w3Hgp/ZsTO31QQNj/+cgfcMe1eZMDfwYyiua0kA2Loe+A0/4/982zM89GStL35DguwjCBLrCPkVBLIFUCTJY1RN+73HIt2jRxruJsykyfBCBy/K92zkuDYgnfLY+6ojjT4KoLU9stIhEcevynvtNKlIndv5j8trT8wvESIoKjNRaS8aX8Bll4CeANnQcwiWopUfCyUg+hMf3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVR4T0ptd05tV21IRngwdGtUSTYvcHllak0vSUIxa1k3emdBWGxUb2Nnd1l0?=
 =?utf-8?B?UHl0QXFpVlZMdWU2K1JoZEJlVG8vNXN1bDZuWGl2ZkFtWURvVWp4YmZGZm0v?=
 =?utf-8?B?allJdExzSC8rejhOT1lvei9JTGlaaGRJQ09tanRCaHh1WFNKNTZNUTBvaXd0?=
 =?utf-8?B?cm5pL1ZJOENocUxGbGJzM0hzS1MySFNnMmExai9FT0I0OUp5NXRRWEd1b3lP?=
 =?utf-8?B?QzhkWGJJL2h6aXc4NEtIVGlreCtFVlJteEtpTncydjBPNW13VDlNc1JkVjhL?=
 =?utf-8?B?MjJ0bCsxQmxqaTdTWExXTy9uWVRXcGtBdWVsTit4MmdtWjhqY2c5d3VHSml5?=
 =?utf-8?B?ODZXdFcxbVVQc1VpM3pPZERQZ3VNZWtwSjZYbHRGZFUyZWNlUWpWRWhScis0?=
 =?utf-8?B?VitqVVhBOW4vc3NSRjZndTlXZ090MUh5cks1Z2JpZ0QrT2lGLzVheVRucFNG?=
 =?utf-8?B?VFJKOWFXZnZOZExVNlpDRjRJeVhseGZUQS8wNUFzTURxUHp6bWxER0tuNHgw?=
 =?utf-8?B?NDJjR0ZXNFp3WDZkdzVJRVdLK0JJajBXMWtvVVltY2ZDVS9qbUtQYkZrZUZ1?=
 =?utf-8?B?NnJ1Y2VUeFBXd0tiYnpUZ0dUQmNRVG0vUGZoRlFuV3QvWGFjT2hRS0RvZnNM?=
 =?utf-8?B?WnlrazB6QURUNE1Vc0YwVHdFRHgzUXhLODc2YXg5eExQZndIWXlJVHo0VUFV?=
 =?utf-8?B?a3h2MXVhcU5qaEk5T094REJNTmN5Rnd2RlZUV005QVBObEdON0hOVi9DMWZ1?=
 =?utf-8?B?MXRWRzdzTjVJOSs2LzVBaFJPWnM2N1N4Q2g2SG9NaWJDSU1wdzVJbzNzU2tC?=
 =?utf-8?B?Z3pXTmQ4THlmV3pvZVJ1SHloamM1SElLTVgrQ25vQmgvaEpseCtXc3pzbFZa?=
 =?utf-8?B?MWltQ1k0QWRaZkJwUGlSYTZJa1BiWTFEeWRsTndCWGhKWTI0NmVLZWlocTQ3?=
 =?utf-8?B?cVk4QzVVUDNUUG5LdzRMdDdENSsvT215WXdSQ1lEN2o1TGVsSnMrRWl4ZFlO?=
 =?utf-8?B?TzZ0cUt0Viszd1p1YXRMZVhRQkIwbzRtV1U2OThMMEhJNFJPTHV4eHRlZ3Zp?=
 =?utf-8?B?S2NtZGJlcERXRTZMNTdBalJFdGhydEFZaitBbUd6bDlIb3VndldENS9SMVdE?=
 =?utf-8?B?aWJPVzJScG1xcU5MdUdUZ2xtVlFTMWJwZjVGWEVVQ1hPNlJvY2pXSWpPMFEy?=
 =?utf-8?B?ZU91bnRPL2VYQnYzWmgydkZKV3RvaDNMdzA5SlpUZzdXaitvc3VFdmgxL1ZY?=
 =?utf-8?B?dVFGTUNUL3ZISWpQbm9TVi9uV3NhT1JISk9EY0hCNittbGRvMjZkdTMrSTlR?=
 =?utf-8?B?V3dWamJMV3haeU8vZ0Q5U0tNUTNoYTZqc1FuMkRnL1p3Y2VjS2xidDFlSnVy?=
 =?utf-8?B?bERENzRIS1ZxM2tUUGUvMUpIdVBsWDFIUG1nTmVEeWs3b2Z5ZTY4ekhEU2pj?=
 =?utf-8?B?eUdTS21MdEx6REFqcm5jT1V4blZFZUl3bEpyU0tmYVViWTR1QmE0T3VJcGdn?=
 =?utf-8?B?Q0ZiM3ZtaHI0Nk8vZDF3U1F1R2lkK1A0RjYyL3dJNW1HMFl0cHZvR1p2Nkpw?=
 =?utf-8?B?SEttWlhVN2ZlRlF5Ny8xZ0UwQnR0MnJnd2hGOWxCV0dJVU5ud2p6aHdsUkQ1?=
 =?utf-8?B?S3BlSVpGb0JvN25RNkVCTjVBc3dLU2tOR3NrUlFxTUxYYjdUanZsVDB4V1h4?=
 =?utf-8?B?YnBZdjVZcVpicW1WeGs1T0dBamtIU0Jja2RlV3pER2xkd3hvZEN3VllOcUp4?=
 =?utf-8?B?a3UrbzErbE9nbTJ2YWZuNk5VOXNqUS80dnIvQllUajh0UjQveWhLQ3prcGh6?=
 =?utf-8?B?UTcxanJDdzVSWXkzKzRQNmpEc21iRHZjTUFlQmJkdy9NU3BEWTAxVDF5QjBn?=
 =?utf-8?B?T0p6cnZFY1RDdUpRYlIvaXF2YjdFSVdFNWkyVkVyV0kyc1I3Y21MYmE3aFdN?=
 =?utf-8?B?NHNtZzZ0Vk13N2xnMlNIcmJNMFZKOEdQdms0R3M2TU1nQlFNcFVvb2lrZDdq?=
 =?utf-8?B?a3JKb3FZcnphYktXM1VRUVVsSEUwUVdyMXFzbEQ5RXJVbk00dTdaMWNlUmRS?=
 =?utf-8?B?VkFaVC9pNnM2djZESGxSbWpuM2V4bGUyZmpFOHB2ZHpxTXA2b0pMZExkRXB4?=
 =?utf-8?Q?A6dkrVtx6OLvqHC/iHAhPOQYG?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420b6ce7-d0bb-4afb-5bb0-08dc3708fd3c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 20:24:53.1351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WM4e7YDJBn1am7segUB+7+0BLYX3DhlvUarPypIwu8HXiiHgXn/JHn0JmeW4aC+OEyeJXK21NnQMwdI6RREuxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-ORIG-GUID: QXRVOHc-6XwAdQnA8wOWPlpxNHPq44wg
X-Proofpoint-GUID: QXRVOHc-6XwAdQnA8wOWPlpxNHPq44wg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

--------------ZoYSPtfjO1Maiw10PSPFt0Dv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27/02/24 1:04 am, Het Gala wrote:
>
>
> On 26/02/24 6:31 pm, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> On 24/02/24 1:42 am, Fabiano Rosas wrote:
>>> this was the same first approach that I attempted. It won't work because
>>>
>>> The final 'migrate' QAPI with channels string would look like
>>>
>>> { "execute": "migrate", "arguments": { "channels": "[ { "channel-type":
>>> "main", "addr": { "transport": "socket", "type": "inet", "host":
>>> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ]" } }
>>>
>>> instead of
>>>
>>> { "execute": "migrate", "arguments": { "channels": [ { "channel-type":
>>> "main", "addr": { "transport": "socket", "type": "inet", "host":
>>> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ] } }
>>>
>>> It would complain, that channels should be an *array* and not a string.
>>>
>>> So, that's the reason parsing was required in qtest too.
>>>
>>> I would be glad to hear if there are any ideas to convert /string ->
>>> json object -> add it inside qdict along with uri/ ?
>>>
>> Isn't this what the various qobject_from_json do? How does it work with
>> the existing tests?
>>
>>      qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
>>                               "  'arguments': { "
>>                               "      'channels': [ { 'channel-type': 'main',"
>>                               "      'addr': { 'transport': 'socket',"
>>                               "                'type': 'inet',"
>>                               "                'host': '127.0.0.1',"
>>                               "                'port': '0' } } ] } }");
>>
>> We can pass this^ string successfully to QMP somehow...
>
> I think, here in qtest_qmp_assert_success, we actually can pass the 
> whole QMP command, and it just asserts that return key is present in 
> the response, though I am not very much familiar with qtest codebase 
> to verify how swiftly we can convert string into an actual QObject.
>
> [...]
>
I tried with qobject_from_json type of utility functions and the error I 
got was this :

migration-test: /rpmbuild/SOURCES/qemu/include/qapi/qmp/qobject.h:126: 
qobject_type: Assertion `QTYPE_NONE < obj->base.type && obj->base.type < 
QTYPE__MAX' failed.

And I suppose this was the case because, there are only limited types of 
QTYPE available

typedefenumQType{
QTYPE_NONE,
QTYPE_QNULL,
QTYPE_QNUM,
QTYPE_QSTRING,
QTYPE_QDICT,
QTYPE_QLIST,
QTYPE_QBOOL,
QTYPE__MAX,
} QType;

And 'channels' is a mixture of QDICT and QLIST and hence it is not able 
to easily convert from string to json.

Thoughts on this ?

>>>>     static void do_test_validate_uri_channel(MigrateCommon *args)
>>>>     {
>>>>         QTestState *from, *to;
>>>>         g_autofree char *connect_uri = NULL;
>>>>     
>>>>         if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
>>>>             return;
>>>>         }
>>>>
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Het Gala

Regards,

Het Gala


--------------ZoYSPtfjO1Maiw10PSPFt0Dv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 27/02/24 1:04 am, Het Gala wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:32687fa3-78dc-457b-ae50-854d2c72c922@nutanix.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 26/02/24 6:31 pm, Fabiano Rosas
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:87bk83bcqj.fsf@suse.de">
        <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com" moz-do-not-send="true">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 24/02/24 1:42 am, Fabiano Rosas wrote:
</pre>
          <span style="white-space: pre-wrap">
</span>
          <pre class="moz-quote-pre" wrap="">this was the same first approach that I attempted. It won't work because

The final 'migrate' QAPI with channels string would look like

{ &quot;execute&quot;: &quot;migrate&quot;, &quot;arguments&quot;: { &quot;channels&quot;: &quot;[ { &quot;channel-type&quot;: 
&quot;main&quot;, &quot;addr&quot;: { &quot;transport&quot;: &quot;socket&quot;, &quot;type&quot;: &quot;inet&quot;, &quot;host&quot;: 
&quot;10.117.29.84&quot;, &quot;port&quot;: &quot;4000&quot; }, &quot;multifd-channels&quot;: 2 } ]&quot; } }

instead of

{ &quot;execute&quot;: &quot;migrate&quot;, &quot;arguments&quot;: { &quot;channels&quot;: [ { &quot;channel-type&quot;: 
&quot;main&quot;, &quot;addr&quot;: { &quot;transport&quot;: &quot;socket&quot;, &quot;type&quot;: &quot;inet&quot;, &quot;host&quot;: 
&quot;10.117.29.84&quot;, &quot;port&quot;: &quot;4000&quot; }, &quot;multifd-channels&quot;: 2 } ] } }

It would complain, that channels should be an *array* and not a string.

So, that's the reason parsing was required in qtest too.

I would be glad to hear if there are any ideas to convert /string -&gt; 
json object -&gt; add it inside qdict along with uri/ ?

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Isn't this what the various qobject_from_json do? How does it work with
the existing tests?

    qtest_qmp_assert_success(to, &quot;{ 'execute': 'migrate-incoming',&quot;
                             &quot;  'arguments': { &quot;
                             &quot;      'channels': [ { 'channel-type': 'main',&quot;
                             &quot;      'addr': { 'transport': 'socket',&quot;
                             &quot;                'type': 'inet',&quot;
                             &quot;                'host': '127.0.0.1',&quot;
                             &quot;                'port': '0' } } ] } }&quot;);

We can pass this^ string successfully to QMP somehow...</pre>
      </blockquote>
      <p><font face="monospace">I think, here in </font><span style="white-space: pre-wrap"><font face="monospace">qtest_qmp_assert_success, we actually can pass the whole QMP command, and it just asserts that return key is present in the response, though I am not very much familiar with qtest codebase to verify how swiftly we can convert string into an actual QObject.</font></span></p>
      <p><span style="white-space: pre-wrap"><font face="monospace">[...]</font></span></p>
    </blockquote>
    <p><font face="monospace">I tried with qobject_from_json type of
        utility functions and the error I got was this :</font></p>
    <p><font face="monospace">migration-test:
        /rpmbuild/SOURCES/qemu/include/qapi/qmp/qobject.h:126:
        qobject_type: Assertion `QTYPE_NONE &lt; obj-&gt;base.type
        &amp;&amp; obj-&gt;base.type &lt; QTYPE__MAX' failed.</font></p>
    <p><font face="monospace"><span style="white-space: pre-wrap">And I suppose this was the case because, there are only limited types of QTYPE available</span></font></p>
    <div style="color: #abb2bf;background-color: #282c34;font-family: Menlo, Monaco, 'Courier New', monospace;font-weight: normal;font-size: 12px;line-height: 18px;white-space: pre;"><div><font face="monospace"><span style="color: #c678dd;">typedef</span><span style="color: #abb2bf;"> </span><span style="color: #c678dd;">enum</span><span style="color: #abb2bf;"> </span><span style="color: #e5c07b;">QType</span><span style="color: #abb2bf;"> {</span></font></div><div><font face="monospace"><span style="color: #abb2bf;">    </span><span style="color: #e06c75;">QTYPE_NONE</span><span style="color: #abb2bf;">,</span></font></div><div><font face="monospace"><span style="color: #abb2bf;">    </span><span style="color: #e06c75;">QTYPE_QNULL</span><span style="color: #abb2bf;">,</span></font></div><div><font face="monospace"><span style="color: #abb2bf;">    </span><span style="color: #e06c75;">QTYPE_QNUM</span><span style="color: #abb2bf;">,</span></font></div><div><font face="monospace"><span style="color: #abb2bf;">    </span><span style="color: #e06c75;">QTYPE_QSTRING</span><span style="color: #abb2bf;">,</span></font></div><div><font face="monospace"><span style="color: #abb2bf;">    </span><span style="color: #e06c75;">QTYPE_QDICT</span><span style="color: #abb2bf;">,</span></font></div><div><font face="monospace"><span style="color: #abb2bf;">    </span><span style="color: #e06c75;">QTYPE_QLIST</span><span style="color: #abb2bf;">,</span></font></div><div><font face="monospace"><span style="color: #abb2bf;">    </span><span style="color: #e06c75;">QTYPE_QBOOL</span><span style="color: #abb2bf;">,</span></font></div><div><font face="monospace"><span style="color: #abb2bf;">    </span><span style="color: #e06c75;">QTYPE__MAX</span><span style="color: #abb2bf;">,</span></font></div><div><font face="monospace"><span style="color: #abb2bf;">} </span><span style="color: #e5c07b;">QType</span><span style="color: #abb2bf;">;</span></font></div></div>
    <p><span style="white-space: pre-wrap"><font face="monospace"> And 'channels' is a mixture of QDICT and QLIST and hence it is not able to easily convert from string to json.</font></span></p>
    <p><span style="white-space: pre-wrap"><font face="monospace">Thoughts on this ?</font></span></p>
    <blockquote type="cite" cite="mid:32687fa3-78dc-457b-ae50-854d2c72c922@nutanix.com">
      <p><span style="white-space: pre-wrap"><font face="monospace">
</font><span style="white-space: normal"></span></span></p>
      <blockquote type="cite" cite="mid:87bk83bcqj.fsf@suse.de">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">   static void do_test_validate_uri_channel(MigrateCommon *args)
   {
       QTestState *from, *to;
       g_autofree char *connect_uri = NULL;
   
       if (test_migrate_start(&amp;from, &amp;to, args-&gt;listen_uri, &amp;args-&gt;start)) {
           return;
       }



Regards,

Het Gala
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <p><font face="monospace">Regards,</font></p>
    <p><font face="monospace">Het Gala<br>
      </font></p>
    <br>
  </body>
</html>

--------------ZoYSPtfjO1Maiw10PSPFt0Dv--

