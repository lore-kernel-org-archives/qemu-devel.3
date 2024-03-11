Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6011C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 14:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjggp-0000JJ-3m; Mon, 11 Mar 2024 10:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjggi-0000IW-LH
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:31:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjggX-0001a5-Hq
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:31:36 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BBacLl030345; Mon, 11 Mar 2024 07:30:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=XoTrRwdNMKz8DvUO03iwZGwc6VRsYxW4/01Ih4SA8
 5E=; b=SqRyixKBgipmMtSUYVUrwGBFlLldOKb0XDLhYs8EYt0c/nQDlylpexJ64
 v57vcadhClbX1gfTbWzF4s1f3dFUQV9JkQTWf45DSHUvSGoKqW87NXXhJMatW+JW
 Z+wQIpW0J1kyYQIh4iH3Wn3pLf7c0P3VJ4U/lkrhzROeqfqm7TUCQPNaKF0UFMRM
 GbLiJ6rwfrrRwLdt3nV0npamEIDGEAwIB03cSsi7XoM4zrjQZoiNoFBPdWvYKeKB
 PI1YQpTSbx3Ze93hBXH7M2ppoHuL+3Jf0cHaGbPrYR9tzgETDWV+UVHbWBBouVA2
 P6mXhCeQE/jCb3mt8Rfe8wBRC9clQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrprkkecf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 07:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3jRf9NJ0nq37QUqzzrH3vHiU3Tr1K7OE1mM6G76nHIJFPRdhCOnIlcnAEMis0kPWlHm7JiwP4GdbpLdO/J7knq45ibRaVMInkuqYDMAhPKqCyNw6KKDpY5G5phBClQGi/RQFS4zVaU2YlIs5Wrgxh5HS7JdpE//fv1DT2w0j/nihXS1Y55fYNknClFq8oNAikfUHlORTsiq3z1U1zN4RLSBtLFU2UhFi7TCBdtoKSIY4jSmsFJVtkXWfcfEAAjlTZ9cfaH9j++jSYwAwkNn9grf/p/YliJ48ibqrlQjUG5d6xNnhA8DGE9f76CwGpxghvfFm8byHi0mlGa/EsQR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoTrRwdNMKz8DvUO03iwZGwc6VRsYxW4/01Ih4SA85E=;
 b=juQ4yIXJXC1XHxQF7iwlqIHEctH04hAL8/icDccn616ARaha7Mtf6OLMCW1i3qeej1chmCKX1Jcp/Vz9iOx9BxiTMl+uaEB/q+d7JKIh4OoJzzA0GTAEwyNJStnFvUdUM6br85r9REY00Vc8OyhjCAx8Hr0+2ZQziID+8mni3/WbEuEAhNYt2YR46duNiAGQD5QaPWdDwfGMCk9ZDu40w92ItSrMLdf73VcRrX02TBnX/bNlUhvRIhqRBIRrLmhxzMPVBQVC4ABuB4G9mgaC3jaR0LyRyX2t9ilqMsM+WWIampZXK03CUf4xcz7x1ILxbNEPE+TLZY+gnUyxdWiFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoTrRwdNMKz8DvUO03iwZGwc6VRsYxW4/01Ih4SA85E=;
 b=AsSzJ/fwFH6GsvIMAYq5E9EYqPTSjFFrZG+9g7m/xR5NsWlpzc5tshmO3uc+G0AOwVDvQ4ZCW46PZkiU3vf7Pp9sQMUKeo8x4zUUCCk1szxbobwZao2jTJyEn4GmhBMQNw2db7UAZ0jnmGNZZ7UnU0c4ZVjseRFNZV/KVYZEEPWJFToStyoNah2tkyzikOOskU9/HWVhhZ8B+7a30TxP50ENWy5FQXdp3S4knySKfGMIbdJ+gAvu8uL9eyAwQ5ZkYbLxlA/56jKyisSXrRjLktIqEFFDK21Lc9Stu9upp0K1WiITYZX1OdIuDzXYvnrJz2gCbb7tcidfsrw8oxOBwA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SA2PR02MB7834.namprd02.prod.outlook.com (2603:10b6:806:14e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 14:30:15 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 14:30:15 +0000
Message-ID: <a5d4b5fb-e3fa-44c9-b7fb-37c3d1ab2bb3@nutanix.com>
Date: Mon, 11 Mar 2024 20:00:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with migration/rdma
Content-Language: en-US
To: Yu Zhang <yu.zhang@ionos.com>, Peter Xu <peterx@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel <qemu-devel@nongnu.org>
Cc: Jinpu Wang <jinpu.wang@ionos.com>,
 Alexei Pastuchov <alexei.pastuchov@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
 <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
 <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com> <Zek2UFoAyVrC7yh6@x1n>
 <CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com>
 <CAOQbQt0+UbfZNPrticjLD4X+S2KR4r+yWPATnhEhTRuxbwvGiQ@mail.gmail.com>
 <CAHEcVy78iCXVGmwr-2snpFwOyCxv3wxYrYJonK6nZF9UfbX_bw@mail.gmail.com>
 <CAHEcVy7kun92b8drEdDZndcWBBT7uvjOpHfqvVbqP0MqvJO01w@mail.gmail.com>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <CAHEcVy7kun92b8drEdDZndcWBBT7uvjOpHfqvVbqP0MqvJO01w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::7) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SA2PR02MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 184a6780-7b61-4fac-38a9-08dc41d7c472
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +k6G/rVgQufPY9khrQTk6ZhWpRUCEkIkshQrv79NsLOSrTfULbuc8RDzJyQbkCJ5bVWtI2aYWVAjRoMw7qGOj9eJ7h7QvRFCEt8GXOwtxllFUUGUjHhVVRbmMWe4ZOVCZKwVX2HPFWo8XvVGtrAtlIetb9psNbO+9QTU7h0WFdQWzoX/HRkvTYMfNm9qWrGrF8AnmDTV0S2Xu2XAX4e1YdRNjogTuPK1jB/9vpxXgyrYgWM4SB6vSoKmfYs/KQNlkYjKP/Ekon+ojeS/W3WZigyLpItgP+0uyHpjZPvKxoO0VAuK/pqd5AmD4HxXNttvnONC/1uv9K1WflSXXwiG/ZYkQ/kZE14B2/f4K/21y2c+ZtK5hTSwaqQ9Sqff1MKJkI/4DdkQ3a6fX4LURCFKnXndPYj/j+cMdtP+ElYMp7SfoBObHJCJ6o0oVUP6SDdjXWI44YTS1lV6e83WBRfLU+rYyCgBromran+YoNUslDExOWRRSDJE+bOmeIEUWHerAPIFflH1kaq3tzk2ENVkj8B90c2S91bSpmkQu/mWrBS7sIAaygtjcPAbk84Pafn7byMts/efeRKtuaP1ESXBYmI5o1tqvOiOE36KvuH9Zh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkFQUFlaNlBuYW9uOVBUZkpYNit2NmdVZVpzeXl5Nk4zS0Q5ZWJMSVRmQW1X?=
 =?utf-8?B?THZnNjhMQUFwWHhtVWhaUEcwREtLV3BWU1d1RUx2VzhRQzdHT1RMNVh2akNT?=
 =?utf-8?B?Z202ZTg2VSsxVE9nN3NaNDVoOC9sbkFOZDlVd3pRR2JWdlhneDVFdFFJdlR1?=
 =?utf-8?B?QTgzRjhHVE9zMW5WUUJzbkN3RVhBMFM2T1B5K213akJTQ0tFanM2Rm9xZm8y?=
 =?utf-8?B?cmJKcnZieEoyOHFGbGt1M2FXRVkyNzZVY2l2V1g3NTFkQTBpUjdyRkhRZGZ1?=
 =?utf-8?B?RzZQTTllMlgvNjFwQlkySFhLcTJkWGVWd0ROektrS0lISytlU0pUUENySDUy?=
 =?utf-8?B?RHBTaTNwQjE3UlMxbUZib2RwVXdWQUdqNE43YlBIbXJxZFMwaG9BK01ackVx?=
 =?utf-8?B?Ly80eXo0dkZ4b082eTZJS29SWDhNVFJMZHVNWEhpMmkxK0dTcjhBQW5lUi9X?=
 =?utf-8?B?dU5jWGxIc3BiYjlBSDN5UWZrUzFVNlhWNEh6ZXJ6V3puZFhnaS9tZ3hPNHhj?=
 =?utf-8?B?UXFEdmJJbTRrVFRVejJZbHZvb2JFWEI4WHg3WFJvU0t2Y3d5S0ZRSWpOdnd6?=
 =?utf-8?B?RDhnQ2RlYmNuSjVMZ2pvZWUxcTZ1bkl5QjdQM1N4K0QwWDRmc1N6dmwxQlc3?=
 =?utf-8?B?MFdwVUhyNXYvUnA2L0RuRFdycFFLazZ1SFJRUVdKUTN0bWVZbE9oSWhDSGlS?=
 =?utf-8?B?azBRYk55Z2hTZUhGcGhJV1FhTXZEeFp6Tk1kdGttOWppTGxZU2kxY0kvK2FC?=
 =?utf-8?B?cmdLTlQzb3BHVXgyMUU1aHpKdGpzZldaK3RaT2VjS0JYdGRpalYwM0x1NFBn?=
 =?utf-8?B?Tlg2eFY3ZnorOXkxbGFGNDRlT1o0WmZXenpqUk8vYmo4dWIxdGtNeHFNMjlN?=
 =?utf-8?B?Zng1K3A3SkpXc3NMSEg3T0xFbEJDMktCc1RaZllpR0VxZWpDWFI1VEt2Smhl?=
 =?utf-8?B?eDBZQUdkd2wyUUVka3JSOVZKYW5JQVRwakdCVlZmNUJhZFFkVnIyeEZqbFRL?=
 =?utf-8?B?K0YrenVmdzhKei9id2VtdEE0a01hSzlrQWxjSVhjaTVPZFppK3RpYVExQzc5?=
 =?utf-8?B?YVp5d2RoOVIyZ3hyNUFCMlVxazJJODdTUjlzbmFCZUh3OVpDRTRFejRuZ2RL?=
 =?utf-8?B?RU5LYk81R2kvQmx4WUNKcVVJaW8vYnpYcWpvNFhHWFRqb29CdzcrTFdyaHZp?=
 =?utf-8?B?eXdkQlZXdFl6RnBnV09Eb1IrMjNpbURLRTZnbU9VcXpTNGwrSW1kSkdsUTlD?=
 =?utf-8?B?Zzh0NU5yNjBtd3pIS0JYU0wwekp0cmlSOEhYQzNyUmJBSzJrb0JWdURxVm9j?=
 =?utf-8?B?SkpLUUdhV1FRQnFWbURKZk9kQ3RtU25MbjdxZlI5MlB0SVRMdDNpREhqVzU5?=
 =?utf-8?B?K0lmczIzc3lDSTQ2Snk0RnQ5UkxCSlFSMUxObDBtbDJ2S3c3a0tIVERDZkJE?=
 =?utf-8?B?VDk4VURpNEhGSXRuNlJpOXFVeWkwZDBqR2xWNktHa1BKcUFSYk9mZ1FsWU4r?=
 =?utf-8?B?VmROenIrVTU5QmxKN0l2a21XcFI3bnVjWWZvOVZLU1pDWXN3SGIreWhJQkhC?=
 =?utf-8?B?NlUvY0dGMCs4SWNocHBvZFZlWUhOb0FPWjBTMDZFb25TU0l5WlBzQzh6bFVx?=
 =?utf-8?B?dWViZlQwVktodjZDREdJb09RM3d2VGpHcE4vL0oyUGJ3M0x5djFqUHoraWtx?=
 =?utf-8?B?ekw3SXJoem9ONW5zaE9xeHVWc1JxSXJUc3FOSFBERmZJbUlOYWRCc3hVdTFK?=
 =?utf-8?B?SUM3cm5MTkdDV3dwSzFqeVhUSGd2STNsWHpPMGhhZGNhSDdHbzVWZUhTOW9C?=
 =?utf-8?B?a1BLdEpFSGF6Rk45bVZLenZPd2ZuYUMrdGFzbGNQUDgyWmNaZ1VmTklaUmpF?=
 =?utf-8?B?R3dSTjZhdTVnUVE3UmRzR2xsVGhucVNwSTNqZkdJQjFyTVRmZUVxUEFaSDYr?=
 =?utf-8?B?dFZldUFjMGVJWW1WRlVLamNZWFpmZFhvL1ZWdjh6VDdXaGNObWNpci9PVmVS?=
 =?utf-8?B?MVFVbDFWWmppa2h4Slc4TUpwSmVrZ3k4RENLendCVnRzaWJuSU5oMHhSeUpB?=
 =?utf-8?B?NzIwZzZHMUVhbE1mMnlVZFltOWo5UDNrUmVhRHB1cFE4Y1c1NzE1SnU3dXJv?=
 =?utf-8?Q?RBSGzei8HuVWl/x67eXkzQDpN?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184a6780-7b61-4fac-38a9-08dc41d7c472
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:30:15.2416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtmQwoCMK5KY0EPtUtV0vsiD+V05Q7yXvdQB66EysXeI4+9UeQXJ+bnIYyWpe3s+DYjc19rjYZx4Auqf5vvnZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7834
X-Proofpoint-GUID: wqb-hftH0uuPzrFB3g09mUAEBkBSGXte
X-Proofpoint-ORIG-GUID: wqb-hftH0uuPzrFB3g09mUAEBkBSGXte
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

Let me send a proper patch to qemu devel mailing list and cc all the 
people involved.

I have reviewed and tested the change. Have tweaked the commit message 
accordingly.
I hope that's okay with you Yu Zhang :)

On 11/03/24 4:44 pm, Yu Zhang wrote:
> Hello Peter and Zhijian,
>
> I created a MR in gitlab. You may have a look and let me know whether
> it's fine for you.
>      https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_qemu_qemu_-2D_merge-5Frequests_4&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=BBbf8F-Z4S5Gg9uS4sGrM2VjND752LeFYFQa4wRG27sLihZCc3Pot0NzTBxor1IK&s=1GBQqozpModsL-VR_THJwca1SMdWBo8pznn1un5RsPo&e=
>
> Best regards,
> Yu Zhang @ IONOS Compute Platform
> 11.03.2024
>
> On Fri, Mar 8, 2024 at 10:13 AM Yu Zhang <yu.zhang@ionos.com> wrote:
>> Hallo Alexei,
>>
>> vielen Dank! Habe probiert, aber auch an Permission Problem gestoßen.
>> Ich versuche, Google Application-specific password zu erstellen für Zukunft.
>>
>> QEMU Upstream bietet diese Lösung für kleinen Patch an im Notfall.
>> Sie werden es behanden.
>>
>> Viele Grüße
>> Yu
>>
>> On Fri, Mar 8, 2024 at 8:09 AM Alexei Pastuchov
>> <alexei.pastuchov@ionos.com> wrote:
>>>
Regards,

Het Gala


