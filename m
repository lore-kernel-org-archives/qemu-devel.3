Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803F6CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 18:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rttq3-00085D-5i; Mon, 08 Apr 2024 14:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rttq1-00084x-FO
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 14:35:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rttpx-00031x-VT
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 14:35:25 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 438Gk3j7026647;
 Mon, 8 Apr 2024 11:35:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=FXJU3RyoOkSE
 u068WsqdPXUs/gCn/VhsdY5IF4seozg=; b=YAnAcZfaXPU2xdlwFurZ/y5I0kpN
 qkDFe1av6l6cPZZsATeTEt7z+6DMJDwxmgKEs5CqHJc/sNNX6D6qqtd39s7ck73a
 09G7uVbmuBDfpwyIRWYQQGW9eRFuR0+HSVvH0lpcY843598tOts9CSFnBM5fi+wl
 xhOFo5TmQ1eOU2UiazFAJdyqv97bt2Q3cCH780BRusWNka2UO0dB/ic86EC2+b9l
 d/26MXjiS4ST4FlweOCZhIYQE6IdCh3z12ruvkujgWp+lxnCecy0/RwMHS5q6jFE
 Yo7c/yOf/vLict3wOAWKeBi9HjE9wJ51U+4zjd/74lryVmKdvwhP7vARfg==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xcghwguxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Apr 2024 11:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxwDTbn8GJayCikOjW/Md0g7eTt9Gdx8QCEXUZS0yKnEI/RbJeyPzY2Z0TKfflnycLW1b5Y9eHl1YT96i4yeiPt5fqiAcpKKLmhhl4Y+N/jMM/L84TDVEqopi8OsUxcaK/XjLn1uWfWNmWwmTGCUjJEhILcqhwKpBj0AUet8sIi3ahswwzzrk1VWgBDoNCG7vibA1hA44bnUGYMz9XiGTUL44TJ36nl+Ik9plra9JXpl3pv3mPZDjAQpOt7+JuMqH4IRKBAc+r4In5/+C5tgFIN4wISKJZZvO26uwV3tYgd4J1XjQ2ZsW0W/kbDs4m+tkSs731C0IE7UC7fgGZeflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXJU3RyoOkSEu068WsqdPXUs/gCn/VhsdY5IF4seozg=;
 b=figlkJ3qbNU6+xBs+K4mLDUq4GpKQaGTF8a9yjYMVBdAzzEpOU+DgT4sC9Y9t5O1xVpE2qRI792eSWrK/nG/H0ZJL2t9mLwb3u+liOAAMVyAEKuBKaKzRF2O2IZxnX/K38PZz8Yqho0vw9+WkGdwdtHLoE6or7VDaTW/mmdafnKBD8P69drOzAyuuA4j0sUliD5mhN6yiRd2q7h3QnRiwOFHzQO9FhnjtNTYUeSg/AwKEFOVQVvPJ2EMtjLgIONSTAWu/ncz5LClKP5lxZR5vLv5HFFt8J8+pYk/Kfc3v4XHnnZnqXh09Yif8OJJZ79c1iZywfpPhHu3uR6Njp7uKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXJU3RyoOkSEu068WsqdPXUs/gCn/VhsdY5IF4seozg=;
 b=oqNYMQEYv2Wgp8FTOVqrhTubJRtNOgI9if+dYenr8vgUBNJYeryuEy8zi7nXeW4Xs7foHSUmf1iVwey7HPdAqqeA86VjlpmsyX1UQRgdXmv1WSly3ESCqqg/2XLgiHs04C1k3XlZwfx3r3EGrX+jvdwcO6Bbn25PnroS63tWk1EWjhwIjghnn+P/aPdVNKZfDpTaweeCnWLbG0N1BjRUP7wK8SsqwnMTq6EvcD4IaRsAVvc4uAwImro+880Tn9QLnYV9SVE4Xmia+Ot7GHMzzF26acfmuGbZsYfVd4gIuEaSfFUTjRq5KfrjTBURush1bj04O9/jyXh+c7iS2g4FQQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CYXPR02MB10193.namprd02.prod.outlook.com (2603:10b6:930:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 18:35:16 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 18:35:14 +0000
Content-Type: multipart/alternative;
 boundary="------------yUu0Jfh4tF92wn05pQXGaboo"
Message-ID: <76fa8f88-02e2-4431-bb28-5c29bbaa8436@nutanix.com>
Date: Tue, 9 Apr 2024 00:05:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Fix typo to allow migrate_qmp_fail command with
 'channels' argument
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com
References: <20240407132125.159528-1-het.gala@nutanix.com>
 <20240407132125.159528-2-het.gala@nutanix.com> <ZhQOzMuQBNiqQVsi@x1n>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <ZhQOzMuQBNiqQVsi@x1n>
X-ClientProxiedBy: MA0P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::16) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CYXPR02MB10193:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UzsvqQ1ux0cnCN+W1GvzsmOygtKWxw2J8a+dC7Gz9BYyRbtD99WP/ynQXPFjIZRKAh0m6ENi+5R1PuhE7ptBMFur7FisWxzLfh1mrQ5hx93yFTaHMNapCNeXuGCV1VFdDG6/eRYi4oaRMajBl9nz8AjCv+R6dFZ5GoLotc6XovBkVNz0yi3n/7RjoAo9lgwyLt87PhO0pYW70jNeHqZ7Tx4R+PZrvN3Eb2bkx6vEUyBO2UUef6Pd2g9t7SSNs2ASJ49YHHqLtVUS5zKzozvJ8/+BkeqXtSJbkMGN6rImHQreFEHgA/ze+RfAxSlZMhYlF3Yio+C7dr02owtedY6n/QIXSSj7jAdmUsoDmCmGLiS/hjXAbLA5h1bjijTTu0Jx2vA0+pb4CS79wHoyHD5GxZWKWQy9ovQIIQPuLTxe070iWVkvZ2Y+9w76VIHGijbiz2l1Pc52WM+w6vTPv4j3z9ntzMFx6uEvWabRUI4eViUsk3eeuES0RwIRoMmgzIuI6hSsPnyjy2+Rgp6CGqJBs8PnUBlVZllK5AY7QUccimuT6oUsa4ff8hpJiWY1Ait3Ej3np7uS3q3o5UrRLtfpGcJ5qUeNFvDHSDOWl/orXwRpftz1Z2nblRdn+Ox0BXLZmueMB+Frb5yMldQeFPngQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2kwZjRFcysrQXhiZ0k2RFpiTzlzZFlYMmVENW1TaHZHYjZjQ05yTFB5dUZC?=
 =?utf-8?B?QWhCdFY3VFZyUDM0TTg0dUJrWkFDUHVBOEExV2tRRWUwa3I4Mjk0c2p0UlBY?=
 =?utf-8?B?N1JLSmovOFk3OE9jWC9uRTNXaGF2YnVXQlo3SXM4VEp2VnZ0TncvVEwzQmoz?=
 =?utf-8?B?UFZJc0xRbCs0eURIYnltbFVFNTFaeHlZTFlmZE5ITjVmd0orNTJ5UWVJRjRv?=
 =?utf-8?B?TktWV1FBUjUyR2ZxYzVJNnlPZlU1RDhlMVlVazR0dWU5N1BrbnZJUWsyVVlQ?=
 =?utf-8?B?RjlzSGowQTNvc1RQcGt2WHJvbW5UNDNGTnhkcXZDaHNmeFFraDhyV2VVcmdl?=
 =?utf-8?B?WlFyZmdrUzZBbER3bzFnYWZQVmUzOU9wVDErR2lyTWQ3L05pT0NncDQ2Q3Ur?=
 =?utf-8?B?MmFHN283bSttVEk0MkMwZ2hxMXZoQjdnVFgrRXA5SEFib3pVaDBzODV4bjND?=
 =?utf-8?B?SUpUQk5pRXNDUU1jalkvckV3c3Byc1JmMmZjVWpTaGpQNWtsZGozb2ZHQlVQ?=
 =?utf-8?B?TFR4NDNnUng0TUJxdzd1RFFORW5teXFLRkoxQzBQNVM3UG1HTTc3cWVhMEpQ?=
 =?utf-8?B?OSt2S2pPdlN6Smd1OW1FQVNnbGtwS1FYMmlSa21MYktHYTI2Q3BrYUpBUVMw?=
 =?utf-8?B?TmxhREZQL3U3MkdGWm0wVEJBd0hQU2RlZG5Ucis1bCsxRjZ3djhSeGwzSUhP?=
 =?utf-8?B?alN3MFBhVTJoZVRMQ3VOU2sySVFDQmV4d3R0WCtUM2x3NUJ3TUxwQnBvdDFG?=
 =?utf-8?B?Skxqeml2SlRnRjZ1UnVzNzBndGZCcnNIb2RTN3ByZlFYTnBUaHIwbXl0MHhQ?=
 =?utf-8?B?RUZ0SDJ0NUtFY0NxU1J5NkpJd04vdmFOOGIyemgwVXk2MEwwcFZBYnFaZjV2?=
 =?utf-8?B?TmNjL0hwSU5VRmd6Qkk4dkJYNnpZNHJENzlZZWVtTlliYnpjOWZmRi9GYm1H?=
 =?utf-8?B?WHVoN05pV2Z5Nm5MRXpHbWJVbnh1RlFqSUsxeHIyQWI0NEs4Z1YyWERDL1pw?=
 =?utf-8?B?Ym9HRTU0cW04bWxxbWZyK2tBS3ljVlJ5SUxiS3RCd2xDeFpCaVVDdTZPSWVN?=
 =?utf-8?B?WFNYWjg3L0wzWm96RHVNREZZMXNWS0NzV1dNK05kQVFGckgwcTc3Wk9YblJ6?=
 =?utf-8?B?WWRYMmRYa0xJUjJXdm5yMVRWOCt0dXFETnd6eWVjckFBS2lhbnAvRnlXc0pZ?=
 =?utf-8?B?TysrbDZQR2pmaUlNQit3M0UxSThFbVI1N29NRDY1QUpVTWtVSUVzQzdZbVRG?=
 =?utf-8?B?VGxsQlFBNHhxa2xIUFNrNDFwK0s0RlY1ODQ5dGpMNTNFN3BvNEFOSm9pcGp4?=
 =?utf-8?B?NzBzVjhQL1NESWYyemJid1R2SG1rZ2x1Vnh3NjBtK3Bhd3N2M09QdFd2UUV3?=
 =?utf-8?B?MmppQ2FSRjdyVXQzZTl1a1lTaVpFOEFoMzk2ZzNwUHRDcSthNXBJNko2Z29s?=
 =?utf-8?B?NERYU2JFdDVhcFZFWUx0TzNOUWFYR2dsUmx1WWZab0FORk1aUjNtellKNmFD?=
 =?utf-8?B?YXVqTzdKQmNSbHkyYURvZWIrOSt0K3hBK1R6a1g4RUVhb3kzSHk0V3FIUjda?=
 =?utf-8?B?VE1Zdkp1RVI5eXAvK2gxa1JvRGs1dmt1UjFLQjhVODg2OXNyc29vVmlJNHpp?=
 =?utf-8?B?RlFIdGN3WVhTUi9xbnpPQ1A4cGFZOCtWZVdpME13UGp1LytiQUs0SnV5NTE3?=
 =?utf-8?B?azA4VFlyVkpvVjcvamtESTdVWXU2a0tUQXBvZFNNcTdCdFY0Um5NbEJIcm83?=
 =?utf-8?B?ZW5Wb1JwK1FtU2lyRURYRlVsYWVwY3hvTmpkaHU2Z25MdTR0WXNEUDhFdFIy?=
 =?utf-8?B?Q1dWUEEwZGNEUnlrNXBZckQ5MjlvRmtWbnhUVFMyZGtzSnFVb0pRS3NRSTlL?=
 =?utf-8?B?S3l4UTliWHVjK2Z5NlNuNlhmMk5RelNrejM4eVMvZWMraXpYRjhXSGtnQ3FB?=
 =?utf-8?B?MVFKVHRmbWpWanNDL1FzV1czVDM2MzNUd2VMak9URENrbVJmc1dMaHJlSWFp?=
 =?utf-8?B?ZUNaUkhXWFd0eXhnRUFiUjdzSU9GOUNDWXc3N0dIWjV3aURkb2hERXU5TkFq?=
 =?utf-8?B?anFiUXE4WjBxSjl3azdrOGkyZmRpeXBBOHNIdXF1MDFFcEV3M2hlTkd0Uitn?=
 =?utf-8?B?SEE1OWdvMFp5NW5lb2w2bFhXVUZyN0d5ZVpEV2RlSVNUUzFaVjBybUM3UE9D?=
 =?utf-8?Q?Qj4JjhLwY9Do/PiKzqvt3/awfOs9T7XF/6Pyus+RzHdU?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d93099-28bc-4a83-995a-08dc57faa161
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 18:35:14.3702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cl7WvhK+ZwcUHSzbuslMJKTy1sJ+Evx+CJpgQ392kvivBk4Swl0bDeQXdUcFnDwZZ0tvFXZXUFOz/yXGbnccIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10193
X-Proofpoint-ORIG-GUID: 7eW7izMsjk9V0K6BG5jJ-DTQ0qGP-_hx
X-Proofpoint-GUID: 7eW7izMsjk9V0K6BG5jJ-DTQ0qGP-_hx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_16,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------yUu0Jfh4tF92wn05pQXGaboo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/04/24 9:05 pm, Peter Xu wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> Hey, Het,
>
> On Sun, Apr 07, 2024 at 01:21:24PM +0000, Het Gala wrote:
>> Fixes: (tests/qtest/migration: Add negative tests to validate migration QAPIs)
> I think I get your intention to provide two fixup patches on top of
> migration-next, which indeed would be preferred so that I can squash them
> into the patches before the pull.
>
> However please next time use "git commit --fixup" so that a better subject
> will be generated, and that'll make my life (and Fabiano's I suppose in the
> future) easier because git rebase understand those subjects.  Then you
> don't need Fixes with an empty commit ID.  They'll start with "fixup: XXX"
> pointing to a commit with subject rather than commit IDs.
I apologize for any inconvenience caused by not using "git commit 
--fixup" in my previous submission. Let me resend the patchset with 
correct message convention. Will take care of this in future patches 
too, thanks for bringing it to my notice. Regards, Het Gala
--------------yUu0Jfh4tF92wn05pQXGaboo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 08/04/24 9:05 pm, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZhQOzMuQBNiqQVsi@x1n">
      <pre class="moz-quote-pre" wrap="">!-------------------------------------------------------------------|
  CAUTION: External Email

|-------------------------------------------------------------------!

Hey, Het,

On Sun, Apr 07, 2024 at 01:21:24PM +0000, Het Gala wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Fixes: (tests/qtest/migration: Add negative tests to validate migration QAPIs)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think I get your intention to provide two fixup patches on top of
migration-next, which indeed would be preferred so that I can squash them
into the patches before the pull.

However please next time use &quot;git commit --fixup&quot; so that a better subject
will be generated, and that'll make my life (and Fabiano's I suppose in the
future) easier because git rebase understand those subjects.  Then you
don't need Fixes with an empty commit ID.  They'll start with &quot;fixup: XXX&quot;
pointing to a commit with subject rather than commit IDs.</pre>
    </blockquote>
    <font face="monospace"><span style="color: rgb(236, 236, 236); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: pre-wrap; background-color: rgb(33, 33, 33); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">I apologize for any inconvenience caused by not using &quot;git commit --fixup&quot; in my
previous submission. Let me resend the patchset with correct message convention.
Will take care of this in future patches too, thanks for bringing it to my notice.


Regards,
Het Gala</span></font><span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------yUu0Jfh4tF92wn05pQXGaboo--

