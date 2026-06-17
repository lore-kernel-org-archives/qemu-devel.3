Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81DACD98F5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnhF-0003Fj-Ej; Wed, 17 Jun 2026 06:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZnhD-0003Ey-FH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:40:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZnhB-00050R-9o
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:40:35 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8Yabb1079680; Wed, 17 Jun 2026 03:40:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=stA+6cai6SZfJpUg7CYg/prZeEx5ytVcZb/jr5rnq
 uE=; b=khBss0cjLNRwuIaOJhNDeRbVvVo0eTtqvPt/iI7dnpQsJDX0HdChwkgfb
 2APQDU9eQoLeZGiBU8UVNUo9wtA2eYqNZ4yLfAPjoWcM6EdG/s724jcBNPoKfs1m
 O1o8TavzjOTxZTCHKrmdt3i52R8Sg1IJ1RL2cIfWaxIN/MymOj4TcjEtPjsTtYFG
 Qj0GtEfnYLqQblVcHt4g1jjxwVNounZ+B2O/olvUZiZL8EPx6pyuCyO/S59g2xXK
 R+8G7Bbzgt1NeCuWsiW6VCsdFspd8nEMgX7md77d80h4PWd6e06cQLUGaoKPexqB
 +q/GuV5Aj6DJvRmlxWudAfUWR1MkQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020114.outbound.protection.outlook.com [52.101.61.114])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4eueg6sfx3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 03:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HloZfDyHGxWjvLWxxDosqxBeJAU28y6aAhGLRQw4zbOS7Qaw6OvEjTPDKUmVrWpDJN9WjUOzjoT81rw2+o7gLdnos59YdagoSKmRaJ3Aln/vJjI6Z8M0nqQ4t9sKy7XXse2lvAmXX4XaosR1im3ubNqrk6JUTG19xzbcnP8vIQYz5z4e6KASFHGuhmb8UDWUqszNb1X8sDN3jrK87Ha7yuWgg+RIE4PazeU+zzc8SCjYQgLXsd2ynhLYSU8vfAQgnU0QNOiM/5IFvWCKSUs16dePIRPVHl5/LrGjxLebSZcumykgZqGoDvp6xCdXtfN7Og4t4XummY0ONP/AdmwTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stA+6cai6SZfJpUg7CYg/prZeEx5ytVcZb/jr5rnquE=;
 b=noVHHtq9wCGES0doIu4pqlhZjdLqvLe9GQJkTGKJaXLWxHcyELikUMEtm3OBMsfVI/2WijYGPQAtve0eH52XY9tVGfIpzjXQ2pJjZpZiROS2422jotAgj0hcbsMOTDPcU5m1vgO7KFgAp1NyHuwWDFs3v8dwNTsRBrz7oiCIQwuqFo/bhk4eHvlt4lUjOMK9nL8LvlAhtkAI2HWy8ZQLSyXrALI/2gFiPPP9PD2u8xD2RP2lyoHm3Xx3AlPbVggOjpSEFrkVyYhuZyhmKIjbtv+xDsEFhO824+MSUO2uruA5zcb5TTTm4it4ZoYrlRpg6Fhi6O+4G66XZ8HZBo8VeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stA+6cai6SZfJpUg7CYg/prZeEx5ytVcZb/jr5rnquE=;
 b=tw3zmyes2IyFhSNkQPCrOpHJMMWgMK3XvxZW5clYrUmqxwMC2o2PPghDWCt4RATIcLkiFA26TAyWv8wlEauZWHYk4XOlqvL9XsANE9Y8PujM+exm3YUlSQPDVHCkhQmsjMciINw1f30Qn9PDBCXUGPIuZX7w67ioY+gw5S9MTleMKQv9cgLis/46IfDJQ4QOXkN6FQx1Glf+2f4Dh4K9PEatYLYO3+LwYwxO5FwpNYdCkbUo7j6igRUMPwtJzr2sbKBfyq+xQyHMMOi2c2+fIAo1WoFKkQ3yOp3GFXRp3lPlmDzWw0mfHybqoigoczXiBJ3J+72Sx/cKi4IJt95ATQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB8374.namprd02.prod.outlook.com (2603:10b6:510:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Wed, 17 Jun
 2026 10:40:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 10:40:03 +0000
Message-ID: <49a8b482-57f5-4d0b-907c-13ddb77c400a@nutanix.com>
Date: Wed, 17 Jun 2026 11:39:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] qom: deprecate embedded objects and instance properties
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <CAFEAcA-Mmt8=1iPOCbF=XsghFzfNN-=GHyLr70iUNDFFN0OKcg@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA-Mmt8=1iPOCbF=XsghFzfNN-=GHyLr70iUNDFFN0OKcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0044.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 1872d3a8-6414-4a56-38ce-08decc5cca47
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4ZXDwrE/NtndbKevjrz1SEHlNnvISS3L6o5yovtVnt0Fiprrkuqi9CSLNhAg3+iLjuGWHiYz0DzudbsR/1fnGWepTthvQF4NenzBBdVEyOR//fRfl4jO2mxjdo+2yRlRvlu+M+BPH7jvqRkOaIDL1oVUBqeVO4HRQT482oDlKg4WonWtuP95qlFH2LcwhnhCIONf2M11jnnM4LXAALvPGkgbEvAxyr3D8O2Locvm6k9tS911Ec08aOHqb9GPdSc/q5WZkrRLhqe3NuRBSEhOW29J1STYo/Vnlpolro9PEQ7ojnl25Jkq0B9h/MBEdiIISPRfd0djr1ktj4OwNvjhvVC8jVDxWJtdmy1TOeUxv137kzeVWE3PnPXWVcpy798yC8StO5Jg2aO3gLFIzlVJ/uGny1Zz8VkxEIjfdLqDdbzCsgNaAnLv2aSOljGydD8wDI+jdIucBVVFM2Qr4Bo1+zfhz3X3ztzNcrbZHWpD6Lnl+3vQvtwq3hR/WK8g/BUaeyWdyEriKYIatMPdM3Se54a2EUtvZI6gEEOvV3vVzPnFQim4XAUwHn4JeaYON7mgEiz6XJzM1134tiGUqc+C/lQLueKVMF4+0C4ZHwKCH2M4Z87a8UJFiKXEjp1kplw/ZntQM7MifnKzUX/ZT8PG29kaBYydyvI8s19+42eFUjgAH5liVbPXfRB6yPUMr/rJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnZFU3FjN3Uycjhpd2E4dXJTd0ZRSFZqSjJzc2pITU9OWVhVUUo1dDBpUkZh?=
 =?utf-8?B?VVZ4UDR6a2VDR3VEQ0p0bFU3LzNrNmxabmYxMUk1eWZSUXZHSmZPZDlnNVly?=
 =?utf-8?B?aUdHcFloQlNqMDVScXF4Qjd6RXRBYmE5cEl1WUtpVSsvYWJpT24vbnRBc09M?=
 =?utf-8?B?OElHWGVCMjJRZFFqMnlvRy9tWVhvdTE4WW1qYWdsME9xNm5qWnBRNjFFc0FU?=
 =?utf-8?B?SVNDanl6SFJKTmJMMjlqbHJwdEs3MWpNdDlhUndmOGg1eVE1UU9QejlVMldN?=
 =?utf-8?B?dUNRVWk1cFdTWTRUYjkrdkhGVWxvV0dTbklpbHlacDg2K3V2cFVmSDlTODVX?=
 =?utf-8?B?d1hLTHBObnRlYk8rYUlYNjZOTGJ6bU9GRDlJZ2hBOGNOOEtzNnVPTW1obVV4?=
 =?utf-8?B?Z3lGK1pwbGR1OEgyRFArMkc1MFkybzRSWS9PdU91UzU2VlhNd09PTGZyL2t5?=
 =?utf-8?B?VHhsYlRjUTRzWnEzWDRLTHptUEY1bDhzYnV1YU5CQWt6cml4SzRhKzNxZDRE?=
 =?utf-8?B?bGVMcHloalRLMkx3MDczaTVoK0VqTHloNHFHREs2NFpvRTdWcCtFakRSMnZP?=
 =?utf-8?B?SzR1TkVUL3ZrNE13Q0UxaVJRb1BGbVl4UUVXYkF4ZzZnT0NPUWpWYmxkV1Ar?=
 =?utf-8?B?eFFpTDlxd0N0a3oxRjl0MVJ4TUd1R2ZwbkVtdVJaTG5qM083QVZSdW9IQzUv?=
 =?utf-8?B?MlVQbXp1QzJhcGszT3lWZFdqUFZ2Ykk1OGJybElCZVVyNkdOcTQ3NGc1bTVV?=
 =?utf-8?B?YlBtUUpFbmE0Y3VSQllPdnBkSWlxbW9Cb0UxaU9LejRhZjQ5VnpIYVFkY3NL?=
 =?utf-8?B?QzBmNjBVdnYyUk1zTEs5ajFUVmsvWjRESlN4aDR5di9MejVyWHpsT21nR215?=
 =?utf-8?B?TTNnbVgxUmdDMDVFeEF4L1N3aENheUNtMlA3Qis3MTlRaExnZWdGenRVWExF?=
 =?utf-8?B?SGlQdVNzZXQyeCs1ZVVrUDljYUdUcmJzZytBZ0ZrbnprN1RaaXltL1AwYlg1?=
 =?utf-8?B?cHljbWtpb0QvWWNVUVB3blZnY2x6eFdZSFFpbmxHWHppT2s3YmhmNmJMOUlS?=
 =?utf-8?B?QkVLS051UjRjbUQrTEh3SlpneE5EczM0TTF6RWQrTGNuSUF0a1lGeDI2Sm8w?=
 =?utf-8?B?UmdFYUZ1MkxTRlNhM0tpcWJuSmlyelQyWnJZRDYzNTluNnQ2Sy8rRzlOdnI3?=
 =?utf-8?B?ME5ZUERHQVNUWnd3SG5yYzB5UjhJeDFUM3dGUHpMZXE1N0V5TUp6RjRmb0JK?=
 =?utf-8?B?bEhlNlZQZ0REb29XZHduR3hML2JLK21xL0hHSllrNFdNbGQreHlQK1NMcDBu?=
 =?utf-8?B?NVdXMjFvMDkvNmowclQyUUVDOFJJeVBoRWVsaVlIZWJXSE14R2JnN3BzdnV4?=
 =?utf-8?B?VEw0V3htcVRaeXNIY3pEM3YrcUJoUjNNZk1TSVp5cmlBQTVqRlhGa093MzRa?=
 =?utf-8?B?ZG91M0lUdHgwYStLb0I1bTlOdzIrNEZkdXpzaXY2cjJBWnF4a3M2RmFVR09T?=
 =?utf-8?B?V09YM3RtMGZxa1FCcGtCcDREWm44TTNhb2RUbE1vYWpSbmtFVU1wUjF2S0JV?=
 =?utf-8?B?TkN3b2dmZE5NT0tSVFBzTUpTOUMxU092L1VPLy9JMWxDanA4NzdWRFY4QmhT?=
 =?utf-8?B?Q2VIYXkrMzNSTXcwdWpONWZveVRrVURBSlpRTzJyVFlTWHEyaTBOVE5Vc28v?=
 =?utf-8?B?cUVmTU1IZER3Z0MrbHVKcTdOcmtpTDBvdVEvOEc4K2xaRndxSHNybHJTTjUw?=
 =?utf-8?B?TGFhL29FVXpOQTZQNjlNTC9QMDF3QWFSOERBSnVOdXZPSGNxUnlOUCt4Q0VG?=
 =?utf-8?B?RHBsWExZaEM1b0tURWVINmhibUtSdjI2bktyYlhvd3g4eERtazVNaUZpZFky?=
 =?utf-8?B?ZDhUQjBNK1N6bThsYTQwUTlVUGxKV1VrRVpZc2xpVVdTanlWV0djZTN6L3pO?=
 =?utf-8?B?c2YxNUpzdzlWRWNxM1p4MHdETjlEcUd0Smt3eUpvTWJtSEJxajAwQnRDZmd1?=
 =?utf-8?B?N0xlQjh1RXpKTWgydDZjZWpxWm1EVk1qcitJV0tTNnFiNHlYWlQ4UDluOGs0?=
 =?utf-8?B?N3pvSVVvMVF6VzVZU1VUQWxvYXNSUXkyeGw1ZWRjemt0SzVMNDBYMGlQRnJz?=
 =?utf-8?B?NHJyZGxXY2FiTExxN1pxU2hhUHE3QzRXVVNhVjd4SXh3SHYxeFBVK0Jzb3Ji?=
 =?utf-8?B?UTN6bHJ2OHBkTDhGU1VjaHIyNHIvV2JydUkrN1UvZmhSRGNuZ09Nbkh5cnN4?=
 =?utf-8?B?M3YvUHNyckRYQkV6Y1AzekZNTHBNSEZMK2dvMVU5cWcxU0h1RStTM0ZnMHVB?=
 =?utf-8?B?THhQNmxaMmVXY0FxYVJNUnZxSDlXTGZrZkVuMW1Rb2s3NENwanU0eE92eVNW?=
 =?utf-8?Q?lRW4wGLSOXtKtm3Y=3D?=
X-Exchange-RoutingPolicyChecked: rqK6LauUKqmyoB5fA2B2OBR4MuHxJ/b1vZNCN6aVh9T/RngcVsS1pgitipp5IqULgwK/BhhZGLY9tApFCiWaf6/kFrlVmgoA6T7YcqpDeYSNfpgsTHrR4uhQ9Gig8yz79TsVdg6h+Ulh4l0B31uF6h3W/rsHeiXW41XWHmgS2pZwF6xDPzzn2GMhICCPPjW3SBd8Ey0pxWobpz6g0ST66QVR5JczyvRHoCDPeXJM5IOEgkw9YVjrRUE1Zk3gpq0ZIArlNPP4MalZ7Muz6fvz51NENUAWw5csSHMjJX3LLiuoLwrnjbnQzalHsvtXpJm132qvH3SHwMDiYtkVzs2PjQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1872d3a8-6414-4a56-38ce-08decc5cca47
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:40:03.6994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Bn/Jikf2DqWQffX9e8GKCc1L77pPxauuZvyDGnKshaIMzY4KpdR9FdXRA9RdQiFigfePYFSzlWXYHGOr8+JG6N4EBQ76Pm9Au7uHA99vz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8374
X-Authority-Analysis: v=2.4 cv=CL8amxrD c=1 sm=1 tr=0 ts=6a327986 cx=c_pps
 a=cOg1uqDXM20bBY9WInewpQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=20KFwNOVAAAA:8 a=c6htxPSo_WKaxa_pPLMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwMCBTYWx0ZWRfXxGMmtUEHMgxy
 q3D9CZLKh6GC1hlJeeudpAJYiZvR3u0UWya3/Z6M2yvdR9o/XxR0Anr4fsYQG3mcqpY+PMMMacD
 VWgYiu8BjmA+0DMnJ2aij0Cfp2sovqmmshR7jDaPLFHkgxbdPLj3VsvKURIAUr82pPP+VhzCZcp
 ppyKit5r1DlX6cULLH+oCANGknkKgMnbZQ7kzWIbgonAu/PzScbd9tR88h6i6A0zBc02opmQnmt
 X662NNxIL40998Du2/07VVH5Agwft+yuQJh10rrdJ3pESAnuHRF3dZBdNb+4wA+E5/9MsmpsiPa
 Cu0wThBOCr9Fuw6Hf0BW67PrX6WoeTXQz1ECmZWGBjU67WrOLaE6rHOU1OlZdWjRMzDcEHHMT3W
 ZzaqseejBsFLiOFt/07AbBC6ofZkhAiCLWPxeb5MeaDnVySy8082E1RZ5cTTVILKBPJz1QqBbhK
 +HwjoDhGs3LolYM0WxQ==
X-Proofpoint-ORIG-GUID: kZ_GoBNiZauvvWPocpEn_pNoo4hCMOuK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwMCBTYWx0ZWRfXyaryUT87WtOs
 upE5v8o3c5exSu+wjWysqYTF1ksm3grOLFxEVLFQJZZLeAtU2CW0EtlW21mPtql7epOC/JCKIw9
 GE3cKkAry2KwU/SH+6f2kVLc9rBYc68=
X-Proofpoint-GUID: kZ_GoBNiZauvvWPocpEn_pNoo4hCMOuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
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

On 16/06/2026 17:12, Peter Maydell wrote:

> On Tue, 16 Jun 2026 at 16:56, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> QOM has two rather unusual / surprising features historicall
>>
>>   * The ability to embed a QOM instance's memory inside another
>>     struct
>>   * The ability to register properties against the instnce
>>     instead of struct
>>
>> While they both look convenient on the surface, they also
>> have significant undesirable side effects (see the commit
>> message for each patch for details).
>>
>> The premise of this series is that their convenience does
>> not outweigh their downsides, and we would be better off
>> long term by eliminating their usage, rather than trying
>> to add more hacks on top to mitigate their downsides.
> 
> The thing I would like to see before we mark object_initialize_child
> and friends as deprecated is clear documentation of "this is how
> we would like you to write 'container/SoC' style devices, here is
> an device written to the approved style you can look at".
> 
> Currently we have in the codebase a pretty wide range of
> different ways to write devices:
>   - really ancient, not QOM/qdev at all
>   - qdev style (lots of Device* pointers)
>   - embedded-struct style
> and I'm not sure if this would be adding a fourth style, or
> rolling back to qdev style.
> 
> (Borrowing a paragraph I wrote last time this came up:)
> 
> I'm not opposed to the idea of making a design decision that this
> struct-embedding is no longer what we want to do, and defining
> that something else is our new best practice for how to write devices.
> But I think we would need to start by reaching a consensus that that
> *is* what we want to do, and documenting that "best practice" somewhere
> in docs/devel/. Then we can all be on the same page about the design
> patterns we want and it will be clearer to reviewers whether new
> code and new APIs and conversions of old code fit into those
> patterns or not.
> 
> I think we're getting closer on the "consensus" part but
> the "document the new best practice" part is important I think.

Agreed. The only issue I can see here is that often documentation isn't 
good enough: as an example, we've standardised on using "parent_obj" as 
the field name for several years now, but we still get patches using 
different names because developers struggle to find the documentation, 
and reviewers aren't often aware of changes in how we model devices etc.

Based on this experience, I think the only way we can realistically do 
this is to teach checkpatch.pl about it so that using functions such as 
object_initialize_child(), object_property_add() etc. will cause CI failure.

I'd love to be able to teach it about "parent_obj" and not to embed 
objects that aren't pointers, but I don't know if that's possible?


ATB,

Mark.


