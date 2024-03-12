Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C20C54E49
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 05:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjuwJ-0005wc-BO; Tue, 12 Mar 2024 01:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjuwC-0005wK-Fs
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 01:44:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjuw7-0007Cs-27
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 01:44:30 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BISRtf002631; Mon, 11 Mar 2024 22:44:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=1LL9gP2XUofxemUQ5nzHwX7WHJ4CpaSXL6fIsIUU9
 JQ=; b=wi71/qwO57sQ57ZIAXTXeVObnuholyxw6vNtuf7ZrN6zR3WjE/H9bvkhQ
 bPR7df5hh9Zpw3w2uD7f3kORC3CuaqMsLu4gpaLFu9HIB9JKgWaAaWmgwN6CcaeW
 zDoWcBOfqSRZitg2n0mgPoLFtpxkqKQKM4oCTM/Tb0W+sX+R+TpEG5YduP3FP6Xu
 TnE9FPN7nV8z18//bfcRMKJQd7SRvXDeTiL/s7mBlfch8xWgdirxiebTqZ8MqRZ7
 1O7vH6nn96OvNEIIo8wMQVFYBRtBQLB5qNmrqt5CAHv10Ylha4riGM+mk4bwxA+C
 fYBqqM2p/7ldI5oR+uxZRfpaeDhfA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrmj9n55y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 22:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUiVvwrg43EH+/PhRPBFtaGuPa/JQ0E+XCVC2fpV17Z98NX6jNlDXEp3BknBmLJVg+oaIfXBfaSrpSROb1hvZyUXrt8r6/m7O1RWDGeqS/8N+B8X3TA2Kf3W6CwroayPLdpnmLku8WcO0hQIiNeqrK8f/wHYdMrYBIj0jmdlUwFeZCIE63Rx6azaaxm67hfBvv3MlxPsfPYvCxtXqI3Ad0pJF2vc4+ecTRPp14mcoqo22a9Sf2zy40DvkjFBoBlQIQDppngR6WllnaBXIruTa03EoJl1FgYmzvaW5EaQ0GvUiJ1X7V3VhhNReqpPHt1WHXoCDOIr/h2xRuTXpLmmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LL9gP2XUofxemUQ5nzHwX7WHJ4CpaSXL6fIsIUU9JQ=;
 b=FSqphH/Gx1tucA3vTV4XUsBB++oAThl1vNPTEJ0nvcbLamIRviJhKsiuumV23rFtQhj3yh1hUCVRocIWkL5Q99NeRw0NXPigPXES9ScG8JXVuQwavb/cpd8gCFYwsEFSOYFGm0JTquVNUwwvvlkvBt4mhCIzWxc913NG/KtIOybaME3pplJN0nvjsXOZVnXwr5cl3w7VAJd/OTmkPhN+2PtCz1cTj4Ap3hx7FoiYeAuXP9ZhC1lJrD8uKW4MMT2OoBiPe1qi+t9ZZOPi3G1tpnG571Hp9zEWlRk6Ajhmk6YKb8HrlAVaqpvsLlkuQyuEBEVm8BACbi3LF48CctKNXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LL9gP2XUofxemUQ5nzHwX7WHJ4CpaSXL6fIsIUU9JQ=;
 b=jcMoRRobFrcTX+zzYqMQIFlZT3+xYxEIQMMrfieuXU99RPSiwaXLqlwShD/REJ/dSuK0LOSx5n+AeRGslXN1EJ+DNZhRTh/wwUVL+Tq2ME3fm1sWsTfxJPWUH3Hf0sdbZ80pf0dyyZSKWRdNd2TSuGbnt5idgBr4FfgXRxBAuBeFLYJxshsWsZNnhAcJAKwFV9hKQHuyZiLo/Y2fbz/8ZcrJc/Bs8+BewjKYHNR0V093KMF/l9PFxS3guD0jE8aq+ArPlYsvNZV7pmq6fp1kRuib2n1nVXPGMPJzTKUUI5M9LLA/UHwGHuKYMilRS1i2+ccHI8phKhIoGYwPetcF2A==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO1PR02MB8363.namprd02.prod.outlook.com (2603:10b6:303:152::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 05:44:20 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 05:44:19 +0000
Message-ID: <548c8430-a2c9-47e8-90ea-65291ddaf656@nutanix.com>
Date: Tue, 12 Mar 2024 11:14:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] qtest: migration: Add tests for introducing
 'channels' argument in migrate QAPIs
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de
References: <20240311215358.27476-1-het.gala@nutanix.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <20240311215358.27476-1-het.gala@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::29) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CO1PR02MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: f5912e0d-3206-493f-9e39-08dc42577630
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: heRBshrqBKTey8P8c1yYSgsDitMKvs0P0lHfr5V3UG5MsQ36HpQmE7D6a/gjTSQbcR8YGRzbrJTiehEyI5lSXvvsJSvGtOVQw/TOYlnvXM5PUee1Cg5aSqx9Aw1b8ou1GE7X58HYISBY/fOfqRq9z6lNXwL9OdwAtTLWhtf/tkHJsZJyX1TfOU2DhxlOqD+OMj5ul8HhxQMTwcbAzBxkk4rk0bA3xfqy3YuygOcrnWBEaagfhWCv9f/LOIlh6iuwqxkdH3b+cQ1wKyQ4qa5ukTxvF1Q/LeiFgV4Ro0tJnli9hiB3wWJu1j3CwYAN2YP13BIT9OSdEhJfotdiOP0EcQDw/wlLFJbPxwQ1cp1FtROtfY+RBft6It+9bpMdQtYOM304kPp8NY59Hl68ZacMsX1c+uuBiZTLoVGPt89EpdPtRSKYQC0ToJrgnhyMoPYc5TJ0u4yZfrGjuGg0N268ro8r6IzwZ42WffwvMWhfGSU0AnWviMKWtO/+3t3ui+Ss7ri8gh6TsyTirlIy5B/1fEbda371h5apcVUGONA9LF++maKQu97i2CapNmWEcoVanKRH3c3TWD6X88H4WFSJVQ+KNHYdbIgoP0ohD/m/YTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTJLalhMbmlqZ1BKMXNFTEpFV3IvUEhjOU1XSzAvQ3ptTmNVdDJHbWpUL01G?=
 =?utf-8?B?RkJSU2xPTjVZbGZRNklIR3FoOUtVVVk1Z2g2OU9XWUxQb3V0RWU4MUk2R1Uv?=
 =?utf-8?B?MUVSYjQ1cnJ2ZVRmUlZObXJZM2pPeDdQN21vZjN5OERRMUM5SlI1V0U3VGNo?=
 =?utf-8?B?RmNyTDVkdnMzU3FBYXloWGRUdStPcnl1VE1JQ3Zqd1NPY2VsVXJqNmpIeDVN?=
 =?utf-8?B?dGNUdkxkNDIwMjlqYllGdGk1VHdvOW1ZWUJwODBRdVdiZVFrUGY1eldpcGZW?=
 =?utf-8?B?bmk1dGpGWGNmU05oL0lWbWFvNjdEc1E2N2gzZW9ZYVRGVUx4dkh5ajMvWWY4?=
 =?utf-8?B?RTc2Vm15YWZ4d2Rsc1RkTldwUVl4QTUvSzA0SlppSml5RjQwQnNHNk1ISzlI?=
 =?utf-8?B?aGJ1NGw3M0p4ak9DMExOZXFwMkd5UW5OUG1CQUx0blVmQnFEV3R5WjhhMjlE?=
 =?utf-8?B?dS9HaUdpaHdkbDg0OVpIUnE0a0s1d2psV2ZYUXhVNzAyem1ML0hDKy82NWdM?=
 =?utf-8?B?Wmw5ZTd4dFRXYjFvb3U3aWlvUEdwR1RGVEk5YzdvRnpWbzVucmJrWW9uaTcv?=
 =?utf-8?B?OEFuaXY5RXpTSmREOUtEeVQzSXpjSXY4MC9acXZzeEQzT0VRVUkrdTlXNzNS?=
 =?utf-8?B?UGttYkkwYWpUUTNNQnBrZ1BHWHFhSkExSmFTVkIwMmZGbjZWdzVuQThQeUl2?=
 =?utf-8?B?RFFZcDJrWG9UU3dnZlRiWnFPSlRzNWZnZE03WDRRSHNVMmc5VzV3Nzg1L0xk?=
 =?utf-8?B?eGoyMS9IN3EzL0R2ZE1sSEdFUVVKa1lVQ0hpWkFzU2ZCdGxjNFB2dmxLMnJ1?=
 =?utf-8?B?Mm4xeU9mdDZzNE12Ti9kWDZGK0MySWVlbTBaRFhxWXpUdFQ2WXEzUk84OEQr?=
 =?utf-8?B?QVRQQzNXSE5tTmFIM3k0RlV5TUNHVVR6cWE2Qy92UDNRWEFocVNId1c4L1h2?=
 =?utf-8?B?UnZsczZFaTBWekl6azcwWEhvMGVWMXp6SHFuOFp6a3NQNG0yYmxWV3pXZDlY?=
 =?utf-8?B?NW1BV3JPUURtRHF3a0tBNzZ5bmNJdUZtWXUyR0V3bzRuSGhBOFkrR3I4Skhl?=
 =?utf-8?B?K0s4TnVNOXl5RGhRbXB2MTZxNHFwOElRMWJxV0J5S0twdlRKSmE4VHIxSXN1?=
 =?utf-8?B?V3A2SU5PS3hrajZqTXlTYXFNM09oN1ZadllIaVgyZTBEenZWS3hGMkhxYnpp?=
 =?utf-8?B?dUxSMVRRQnora0lZV3hjWDNRU1R3eXRGejRDQ1BnRzdIdUdnNHpPU3dHQWpK?=
 =?utf-8?B?Uk1mSGpGUXVsS1d1VDQrRzhyaEUxWHJQaTlhK3NIVXpqZ0FDUTFwYXlPcjhZ?=
 =?utf-8?B?WVRkYk1rbWNoc3BtcUVKOGs5NnBSdzFOZEg4Z3Ezay96T1dLeWRaS0RxSmho?=
 =?utf-8?B?L2R4ZFI4Y0JVQVE4YXFkZXNYMy9KRm0yeEtsSHU5WGE2dEFWSlNQajhJUnla?=
 =?utf-8?B?b3VWS1RicUplOE1FdDRjWmN5S2t0azNEdmRzYi9aT2dpamdRM1NYYTNrWU5p?=
 =?utf-8?B?emNlRi9pZkloUiswZlk4Tmt4Y1pXZFNiUHhpdHAzdi82eCtjb0wyd0lJNzND?=
 =?utf-8?B?N0R5cmpJMlJhZWNDUnVMdC9CTTlDUkpWRUhFM1VIVTN5ZnQzWHFTcjVTcVE4?=
 =?utf-8?B?MHFVcTY0Y1NUdVRVbEZwK0dpcE1xWVJkWlRXTlB0Q0xweXJKNThyOGVoTjlw?=
 =?utf-8?B?cWRPUVltUEE5a0RmVjJwSXkyNWg2K2Zsa2FaZXFRanFOWUUvZGhuMXlDTWVC?=
 =?utf-8?B?U3I3TkVJdm1nSHF2clI5VWx5SFBtTHNDRm04My9CdjkrQ0VDRXhjSG5KM2hX?=
 =?utf-8?B?SndzeDZvUXZpcG85WFFuSU9JWHgybGd5c3Vodk93T0NLQUR4dTA4ckJOMFZa?=
 =?utf-8?B?WUY2VnkrSWRlM0JXMVNBbndJMVYrQ2pJaHhuUGpoaVVKOUxLdCt4U1pWZlhw?=
 =?utf-8?B?d1pXQVY2OTY4aUhEOGpmR01vdFNhS2VQd3grRTcyRU0yVlhKWCtxdUlleFNs?=
 =?utf-8?B?ZnJpMFNkL0FTUExVS2F0M1hpbEliaVFLczZDa3JRbmxyandHUGUxVFA5UGtx?=
 =?utf-8?B?NXFKcndEMmFweWJFUG02azd2aHZTL2ZnT3FyR3dkMG53YVlpZkhuOTJDTGxY?=
 =?utf-8?B?MHAvRDZpbDY4cE5ubUZYS0ZVRC9GZGt4Z1lPQjhRbVhoQlhJMDFTWGVtUTNu?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5912e0d-3206-493f-9e39-08dc42577630
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 05:44:19.5750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ADIL2GI7KJBBnGyadXU9pgxLhAqDyzFNoM9y7njYSK1oaNl4DEW0XBrJssY9Ol/Yu5OFI4/R/eeR5364/jWAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8363
X-Proofpoint-GUID: d6Dpj6BuTF-urfX6zWlF6LpeGN5iCXwO
X-Proofpoint-ORIG-GUID: d6Dpj6BuTF-urfX6zWlF6LpeGN5iCXwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_04,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

Can also check the passed build at 
https://gitlab.com/galahet/Qemu/-/pipelines/1209497470

On 12/03/24 3:23 am, Het Gala wrote:
> With recent migrate QAPI changes, enabling the direct use of the
> 'channels' argument to avoid redundant URI string parsing is achieved.
>
>
>
> v4->v5 Changelog:
> ----------------
> 1. Remove redundant imports from migration-test.c after moving helper
>     functions to migration-helpers.c
> 2. call migrate_get_socket_address(to) and internally let qdict_get() call
>     “socket-address” parameter to make more sense to the reader.
> 3. qdict needs to be freed, other small fixups.
>
[...]
>
> Het Gala (8):
>    Add 'to' object into migrate_qmp()
>    Replace connect_uri and move migrate_get_socket_address inside
>      migrate_qmp
>    Replace migrate_get_connect_uri inplace of migrate_get_socket_address
>    Add channels parameter in migrate_qmp_fail
>    Add migrate_set_ports into migrate_qmp to update migration port value
>    Add channels parameter in migrate_qmp
>    Add multifd_tcp_plain test using list of channels instead of uri
>    Add negative tests to validate migration QAPIs
>
>   tests/qtest/migration-helpers.c | 158 +++++++++++++++++++++++++++-
>   tests/qtest/migration-helpers.h |  10 +-
>   tests/qtest/migration-test.c    | 180 +++++++++++++++++---------------
>   3 files changed, 257 insertions(+), 91 deletions(-)
Regards,
Het Gala
>

