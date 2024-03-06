Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89779C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 18:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhwBl-0005cf-GV; Wed, 06 Mar 2024 13:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhwBj-0005cU-Oe
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:40:23 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhwBY-0008MZ-LG
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:40:23 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 426IP9pk002771; Wed, 6 Mar 2024 10:40:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=XZYQ4fLzQHL9
 myQ0dayZkVFBuOmnJKXEyFRwZvcb/jE=; b=qSmTDxnaRFTL91P4K9o4aJHnVTuZ
 HFZDDlKEHpR6p0qT/U/JiKX1p780/QkLyu4349aqs3tjSSGWtlZvOvXvyHpdrYXk
 itCX3RYVE/aPjery1xVb+Y4fXVNV2bULrhUDTofE5Uzc85Chksify1KyZSOE1hmq
 qrLxUqSHZ1oqxSRCwEZGAfImiLpjr1O69drmbpKlL790R6b+mW5cm29hiEUo+TtA
 m7D0uRvHZXhuXgvprPd3NZDTP6dfJQ2yEnoOssYVd2K3E39l6hn0J/AmULFU4ion
 6rhPVcuGb2hi696zsbK9MpfF6AfjHV501TaDQ4zg5pswpr8zHue2vruPAQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm2hb9fae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 10:40:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sfuf8pkFkzCZ+T2YAnU8lNUo4Aw8CbFjIEiNFyBNV3qupIpGRSc5bkxOn+MniL0qDWqO/nJSS6jXmzVuxaQQmQP7DLjwe6bEbXX2kJURXT3z1s4dOhO52DR2LSW3nxAhrM/jFw6XYPfYCNPU/Q7Bu6i/mUBs6pS9k/wOCSM3IzHc+Z6ng6vgFKmefZypJo0xZwqKiY2vUkZGWTKUzSVbPZ0PEKzdH0jHNAxhug4uNvC326zyl2GSYMVxWySkwTI9qJGLxMstHPgGn9+VWAL3FiLfO04oepLTfn2ZkTdatU+KT5+dzxLPeXHiA9c2NMO0xwgIUpVbohch/d7NQVdRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZYQ4fLzQHL9myQ0dayZkVFBuOmnJKXEyFRwZvcb/jE=;
 b=hv2E1MDZBTiUM6EwvUxUMsgxvuNScGttXf+Q+V6K5PY5HYE1ZKSFOtCK667S6fl+/jiFDbFVinfJoQZjZwjn9zz24lFY58Je1UwwjQNGn/q87tjsM/Kvb1XdJ2O6TYkue9V6aymg+4uMyy/65LwhwVPkECVX/xwIthFemPkRgH5QgREvtG5VHjnD5WPRShbtxY+DqXi17EAn6CnB37meJFyRyeEtoa7Mj5Idxo+9PBgI9SXAZWSEE8mp9X2Ixzozw09+CuQTucjwOGO7eGMtV7yw2ftkf5Q9Dz4Ppqk5bfVApncHwe4GhdmX/xdYt0r6bPdzPn0WcTHC+36g4uxVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZYQ4fLzQHL9myQ0dayZkVFBuOmnJKXEyFRwZvcb/jE=;
 b=nugJ+8wA0ZOaJCfv0EqqblOExtsm6VofmbBqJy9uALu2RukiNxtT0uTJz0MgT6VtOtksu2EcmU+4vkoGfWB/YlswQzGYyjSIspuc3Or+dZvoPWArVHVo5zSRysvR0L8AMo+ewH7mvVJFKSid+S0/7PuX1BcQD8frZbCizoyUDTIDRCTXAl+sNnek3EVwvfMUVLdwhHhLaravU9gBFHkfVqqtIxeKgCTXcOuLoMEl7Y08CRwm7y+t7IiIMTbqoRCnyD3jP1AVHKfPVLi2DKmuhQoGVOtiD7tONbcb/Cv64igGYE5AjfVaxs9RRZ1t9/2vs5gXLKuggEiWh6uJfV+Xvg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CY8PR02MB9566.namprd02.prod.outlook.com (2603:10b6:930:76::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 18:40:08 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 18:40:07 +0000
Content-Type: multipart/alternative;
 boundary="------------zH0keVOj9xz5Yy81U3EGReCY"
Message-ID: <2d77c0f7-aae1-49ca-9807-38b60cb62f06@nutanix.com>
Date: Thu, 7 Mar 2024 00:10:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] Add multifd_tcp_plain test using list of channels
 instead of uri
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-7-het.gala@nutanix.com> <87edcns8jc.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87edcns8jc.fsf@suse.de>
X-ClientProxiedBy: MA0PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::7) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CY8PR02MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c641661-a310-418f-58a4-08dc3e0cd8ab
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4XBKeKH1rZAxhTxIJxX+mai3HX08J+T5i3rAsfoy3PLOgkMp5sDQs03a/4miAkl3kmRF61OmDbfsbVHR+3pn8rZROIMpH6+jPzFTeiEzXoLWVrZN8U94Gb5h1Cob9FUBlALiTp0GE1NQjzgByfZAB4pHFsJiaxCwiWEY7NCcVMSs67k0Tz7bioEBCNzogjAAfpHvw0TXkkkDO/gI6snNvbVpxX/pp3y+iGjPIUXN+4Xwm+7EqggIahcVvhsTV+9D1Nn3W/+3zg0vMWivyZaKwUXGImPnFFdBllgDBT8VY7ecQ1eiD11j7vzXrrqK+nCBHT8jAnXBpklUsJyTnov3628h3Ln6uRNmu87nbIneM5Bpkv1xgGWKm5eWCzyog4uR2PjdzGlYytALs4XqsaeBIJUCYU3nlGVcuHVTGfdAgnoJ0yY+QVbUgeckBiQZbYmmDyxm6hIAi3Yc/L5082fPGwXiQWKIjS2oyfsjptHfhSbMO+AaYOfqRGnYWFBOjyVNr3Ya8+uUyz2q7M4Tj8GWgqfbBOXHSx8O4tBmEmi/GZk3V1rhVKl1sf0i5S2dKqYGh/apr3aLyKUMbPUM3UKyrZfOSjV3wBDsaDc3hngA80tocHmTYyl2tstTQyqsi3Sp5ifSyRVOf1EcJHfuGKBIna1JEHRGRkPkAIDD3EYfGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0lvbnJnU0ZUb1ZUQ0JaencxTHZXdHQ1Mm5JMyt0c1RGaW5NV2ZiREd0eWZu?=
 =?utf-8?B?SGJaMlg2V092eU1WUDVpTUJ4MWREalN5YWk4cEJ4Z0ZjTUpITlBHQ2F0RGdH?=
 =?utf-8?B?QVdhcHFLMWl6NEdPN3RybEx3M0thbzNBSHFEeDVxQmtXNVpKTzVmSHVmc2U5?=
 =?utf-8?B?T0VrczlZNHJZaHU4SXVYUEtnOFhtb1VUSEdLVlRPU0tmaHpVQ0hla1Eyb0sv?=
 =?utf-8?B?bUJlQ3Y2UlF6OE1FU3ZyaEFGcHF2N3VqL05zK0xrL2thQjNqd0p4QVIzbU8x?=
 =?utf-8?B?ZHpkL2VmYTM3M3lLSjhxek1LSDdBVzJENmJ5NFFmY1FpVklVV0QrcjVmZldN?=
 =?utf-8?B?MmoxK0ZKcTNjUi9Uc05HQjZJTHZzZDVUdngxY2haN0MxclArKzJpR3FaRm9r?=
 =?utf-8?B?Z2JMR0JIQ01pT2JKY2h6cDBzS0VsR3gwL09uNmhMY243WW8weGFXNjhWSDc4?=
 =?utf-8?B?WDArZWlVczNoWE0vZUVQcFc5VlFERy9nbXhONmNmdFEvdHJVY2F0OGJYbVpk?=
 =?utf-8?B?L2JtenFHQkx0SlBaRkFVdFFsLzNwaHE5KzZEM2lFWjlLZlZINjlHaWZTZDBm?=
 =?utf-8?B?dGlLTzJ5amdPOW1kQkF0ajNrS2poQTNqZEkxSGdCWlBZQ1Q0cm5NMlhuQWVG?=
 =?utf-8?B?Y2NEbVNpNjlxQ2lXb2ZrTkxFa3Vmc2REcERaMHkycVVid1BmdmR4YzhjK3cx?=
 =?utf-8?B?SnUzVTgxcFpJenc4ZVRCZ2hieTZmNmxLR3cvZnR3SktOK3lnNEVXbjgyamZY?=
 =?utf-8?B?WUZzb0lnTGZlUmZsV24ydGxHT1prcGpvMkh2TXcrZGdDcFZRMGFJUkd1bGN1?=
 =?utf-8?B?aTQ4bXNFdC9aSFl5bG1FZFFyQm45YktjdFRMT1BVWktjUTNnR3JpR0RFcnk5?=
 =?utf-8?B?NEl0dFhHYXhXRTU0dmd4eVFVeGt1RHQxWlhDQzlGaE5PYm9kZDBFbkJZR3Ni?=
 =?utf-8?B?K01FeFlmM1d3VU9wdm05elZ3RzhuUnFWM0VYU1RNNlBWc0dkcHl4eVdsYktT?=
 =?utf-8?B?cGZSMGhWNytnRHIvUytGSEtHdzhjemFPcGRWWjVCcWpEVmoxa3BiVUFpWVdz?=
 =?utf-8?B?aG1aQmErLzlydFRhZmlXYlNuRCtIaXo4dmljYUZRRFB0V3dyZnZ0cmdtbmlp?=
 =?utf-8?B?c2JaSlNGQmxYMUlBc041N2hVVTFldENMVkRkdGtNUTFNbldNRDVHTGVZUVRG?=
 =?utf-8?B?bEF4eVprOWQ3a092anRFeGFrY3NWZ2JySldvbHg1NHlaSVRQUzJpd0MxY3Y2?=
 =?utf-8?B?TTU1bkhtNkR5N2poNllVQkdxS3NLdFBSeDlqZm5JeWd5ZjJuV2dQRzJLVHBM?=
 =?utf-8?B?QzBKeGo2eEVVZXBnQkRlRjVMcFlQR0F3RWN3bXYrSkgwam15ZVhLRW5IT0V2?=
 =?utf-8?B?b1ZoYWpzaHRUa1BwU2Y4cEJEQWhpSEtqM005Mng5ZnkxVTlxcnNZNE84cm9U?=
 =?utf-8?B?M0lKM0dRcEZVMkhJRWhkbTVOa3hIUmp6M295WU94Tk1YTkpsWnV0RlkzNFF1?=
 =?utf-8?B?QVN2QURVZ2NYLzJYZ21ERkg3dmppREdncE5uWms1cE8rQUZ6RzhXd01nQ0xS?=
 =?utf-8?B?MmYvbWlzRHRlRDBaK0s2Ykw0RElOUjgxK0ZkTkJNS1NlbGRyM3pITndGMEhO?=
 =?utf-8?B?bkJKS2VhWVlLV2xSUTBvQjBrcGdQUDBvZHh5NFBJcGxYMFJVRkdtVVBNNm5F?=
 =?utf-8?B?VEh0dDBGZXZUNDZ6WW1xWkVUT2pJdkVpaVYzSGM1SkUyQjlFcTltaHNWUDlo?=
 =?utf-8?B?YnZicUsxaWN3YWovaXA0WFJONEM3SDMybVhHeGIveTJUdGdjYzBSdHJYc001?=
 =?utf-8?B?dEpqSUJkaGJYMWdCeWhUdThid3VKbTZoT3A1d2pBdVZvQlFiUmZxWUVkeXRP?=
 =?utf-8?B?TXNhanRoNUl4RmtsQXZoTlJjYlNxUXBXM1NvYVlySTRxQzIyMGFrUmMvb2VY?=
 =?utf-8?B?bkFGM0ZXM1hnZEdxbWVVZEdaeFB5cVZHWXNYay8yVVNFQVJvUlJjcXFESjB0?=
 =?utf-8?B?Mm1CWmRTZHFHR21FbW9EOUMyWDA0dFF5NmM5eHRqYnZ4ZUM3ak9IdHBncWtq?=
 =?utf-8?B?QWZzU0JpNTY5SVVkZmFReUxKVU5sS3hTODhkdmVlWFJWZVVnK08xbnJEVC8x?=
 =?utf-8?Q?cDOE2z0BYbjPOOh4T705Hn21+?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c641661-a310-418f-58a4-08dc3e0cd8ab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 18:40:07.8651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93gPROsFQS/Ht03g7X0t3gicXEBnVKuapv7y4gnoqBTriCvipMNayOFMEUGRe0XAM2tEIx9yF1E0sUbfPINrcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9566
X-Proofpoint-ORIG-GUID: t5N7CLGktdg6YCrnhNrseDGUnNZBjng0
X-Proofpoint-GUID: t5N7CLGktdg6YCrnhNrseDGUnNZBjng0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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

--------------zH0keVOj9xz5Yy81U3EGReCY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/03/24 8:37 pm, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> Add a positive test to check multifd live migration but this time
>> using list of channels (restricted to 1) as the starting point
>> instead of simple uri string.
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>> ---
>>   tests/qtest/migration-test.c | 29 ++++++++++++++++++++++++++---
>>   1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index f94fe713b2..05e5f3ebe5 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -659,6 +659,12 @@ typedef struct {
>>        */
>>       const char *connect_uri;
>>   
>> +    /*
>> +     * Optional: the JSON formatted list of URIs for the src
>> +     * QEMU to connect to
>> +     */
> You could add some words here mentioning that a port of '0' will be
> automatically converted to the correct port that the destination is
> using.
Ack, will add these while defining connect_channels.
>> +    const char *connect_channels;
>> +
>>       /* Optional: callback to run at start to set migration parameters */
>>       TestMigrateStartHook start_hook;
>>       /* Optional: callback to run at finish to cleanup */
>> @@ -2623,7 +2629,7 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
>>   }
>>   #endif /* CONFIG_ZSTD */
>>   
>> -static void test_multifd_tcp_none(void)
>> +static void test_multifd_tcp_uri_none(void)
>>   {
>>       MigrateCommon args = {
>>           .listen_uri = "defer", @@ -2638,6 +2644,21 @@ static void test_multifd_tcp_none(void) 
>> test_precopy_common(&args); } +static void 
>> test_multifd_tcp_channels_none(void) +{ + MigrateCommon args = { + 
>> .listen_uri = "defer",
>> +        .start_hook = test_migrate_precopy_tcp_multifd_start,
>> +        .live = true,
>> +        .connect_channels = "[ { 'channel-type': 'main',"
>> +                            "    'addr': { 'transport': 'socket',"
>> +                            "              'type': 'inet',"
>> +                            "              'host': '127.0.0.1',"
>> +                            "              'port': '0' } } ]",
>> +    };
>> +    test_precopy_common(&args);
>> +}
>> +
>>   static void test_multifd_tcp_zlib(void)
>>   {
>>       MigrateCommon args = {
>> @@ -3531,8 +3552,10 @@ int main(int argc, char **argv)
>>                                  test_migrate_dirty_limit);
>>           }
>>       }
>> -    migration_test_add("/migration/multifd/tcp/plain/none",
>> -                       test_multifd_tcp_none);
>> +    migration_test_add("/migration/multifd/tcp/uri/plain/none",
>> +                       test_multifd_tcp_uri_none);
>> +    migration_test_add("/migration/multifd/tcp/channels/plain/none",
>> +                       test_multifd_tcp_channels_none);
> We should eventually make a pass to standardize/simplify these
> strings. We could have a little "grammar" defined on how to construct
> them.
>
> /<test-type>/<migration-mode>/<transport>/<invocation>/<compression>/<encryption>
>
> test-type      :: migrate | validate
> migration-mode :: multifd | precopy | postcopy
> transport      :: tcp | fd | unix | file
> invocation     :: uri | channels
> compression    :: zlib | zstd | none
> encryption     :: tls | plain
>
> Anyway, work for the future.

Yes, completely agree with you. It makes it much easier for people to 
identify and define every test.

I can take this up as a separate patchset after this one gets merged maybe


Regards,

Het Gala

--------------zH0keVOj9xz5Yy81U3EGReCY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 06/03/24 8:37 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87edcns8jc.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Add a positive test to check multifd live migration but this time
using list of channels (restricted to 1) as the starting point
instead of simple uri string.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
---
 tests/qtest/migration-test.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f94fe713b2..05e5f3ebe5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -659,6 +659,12 @@ typedef struct {
      */
     const char *connect_uri;
 
+    /*
+     * Optional: the JSON formatted list of URIs for the src
+     * QEMU to connect to
+     */
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
You could add some words here mentioning that a port of '0' will be
automatically converted to the correct port that the destination is
using.
</pre>
    </blockquote>
    <font face="monospace">Ack, will add these while defining
      connect_channels.</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87edcns8jc.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+    const char *connect_channels;
+
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
@@ -2623,7 +2629,7 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
-static void test_multifd_tcp_none(void)
+static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
         .listen_uri = &quot;defer<a class="moz-txt-link-rfc2396E" href="mailto:,@@-2638,6+2644,21@@staticvoidtest_multifd_tcp_none(void)test_precopy_common(&amp;args);}+staticvoidtest_multifd_tcp_channels_none(void)+{+MigrateCommonargs={+.listen_uri=">&quot;,
@@ -2638,6 +2644,21 @@ static void test_multifd_tcp_none(void)
     test_precopy_common(&amp;args);
 }
 
+static void test_multifd_tcp_channels_none(void)
+{
+    MigrateCommon args = {
+        .listen_uri = &quot;</a>defer&quot;,
+        .start_hook = test_migrate_precopy_tcp_multifd_start,
+        .live = true,
+        .connect_channels = &quot;[ { 'channel-type': 'main',&quot;
+                            &quot;    'addr': { 'transport': 'socket',&quot;
+                            &quot;              'type': 'inet',&quot;
+                            &quot;              'host': '127.0.0.1',&quot;
+                            &quot;              'port': '0' } } ]&quot;,
+    };
+    test_precopy_common(&amp;args);
+}
+
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -3531,8 +3552,10 @@ int main(int argc, char **argv)
                                test_migrate_dirty_limit);
         }
     }
-    migration_test_add(&quot;/migration/multifd/tcp/plain/none&quot;,
-                       test_multifd_tcp_none);
+    migration_test_add(&quot;/migration/multifd/tcp/uri/plain/none&quot;,
+                       test_multifd_tcp_uri_none);
+    migration_test_add(&quot;/migration/multifd/tcp/channels/plain/none&quot;,
+                       test_multifd_tcp_channels_none);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
We should eventually make a pass to standardize/simplify these
strings. We could have a little &quot;grammar&quot; defined on how to construct
them.

/&lt;test-type&gt;/&lt;migration-mode&gt;/&lt;transport&gt;/&lt;invocation&gt;/&lt;compression&gt;/&lt;encryption&gt;

test-type      :: migrate | validate
migration-mode :: multifd | precopy | postcopy
transport      :: tcp | fd | unix | file
invocation     :: uri | channels
compression    :: zlib | zstd | none
encryption     :: tls | plain

Anyway, work for the future.</pre>
    </blockquote>
    <p><font face="monospace">Yes, completely agree with you. It makes
        it much easier for people to identify and define every test.</font></p>
    <p><font face="monospace">I can take this up as a separate patchset
        after this one gets merged maybe <br>
      </font></p>
    <p><font face="monospace"><br>
      </font></p>
    <p><font face="monospace">Regards,</font></p>
    <p><font face="monospace">Het Gala<br>
      </font></p>
  </body>
</html>

--------------zH0keVOj9xz5Yy81U3EGReCY--

