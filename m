Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCE6CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKi0-0006O9-DD; Wed, 10 Jun 2026 11:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXKhy-0006Na-Og; Wed, 10 Jun 2026 11:19:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXKhw-0002hV-Ts; Wed, 10 Jun 2026 11:19:10 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AC7bxw774524; Wed, 10 Jun 2026 08:19:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4pPALB/TMO0cSQo6eFwsqLRqHx4P7HNId4Niizxj/
 A4=; b=gUxp1dZsWZHqmWVUsaMMexjFNKCrqhsXncPIlXElfQMD7lmeclmdxRF4g
 eUfXDOVTG3Di8ccAHImThb+aU6O36USCKIWChLfMpGITUn9KtY5hPEDUES7gbErD
 OWmt7Frc3ZM4287/OSOt4GMQ5QpKWpmgwkHUR7TVLPsUcsyLkqW1NY6VjMewVLxm
 57Tk46NYMdYZ8wrQDhMqnrkoHP5rIgUZP5mJ1CdEbL0rCZP0VeYQb0TPptlXmp8N
 st9sRjBQDvyuS3jLdpQRW4Uo5FYGFQ2n3hf6xsfcJ1TJe98uzCDFx36ufU+QSXAZ
 Xol0S+IbF/+rwvHaZS8A7XEu3s8+g==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021126.outbound.protection.outlook.com [52.101.57.126])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ept6vafr8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 08:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weSNCZUhcIE5yaHYeIMV4DxxshckqwtOIEJ2BgSNGq0SCN8Ym0+c+LMXLHA2hm768fG+mgGR5t0CxvX1ZxKj5H3RoH1EJty9nTYxBx6Ydc7mWSiXUApqDZIHY53f7P2aTB63AstjeuccrxcIUNwP13DLDsf9Loz8lkXuoKPVW7TEe5zcCIvoFQ5iArhTaQhBXssuqxdhRmEpleLK5I2FpGEPlGqtPfLIOfJInUAB/oRMlzkDEEB/ThKLDelqpKgurdPYCRedDSN7t+cA6/H9f3eoI2Y5X8pEyF2jGiNTgheFNSR8MMpm+wdAI968wtL678Di5KrozLu3DarlWGgF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pPALB/TMO0cSQo6eFwsqLRqHx4P7HNId4Niizxj/A4=;
 b=e4LRtV2wFO2MjXdZ8gE4I1mb2iHR5DQ/7tihFzDVAuHelCO0r6BJAaKC80S5h5v/AqQGoZZZ1kJNUmZiaycCwVgx2duU2Zcf53v0es9qT3eYLUsAKgd4Fw4tppjEUavnGAso1RPiUOne6bYoNDw6brLo5ZcMHHDKbetrIno5aAfUwckcJEC1v5NQi86j0O0BgrPIfssSYWb+06Ln2h7Ke89UxPU9yINkxQXnF+7L6jwB5dL/3/y8A4acYmznCq6f/IhGjHWaPdZMFbgTdrGfS3GiO1M3RRrNKu4ymx9d795G6SGp1djvfsbfndOT7Vm7vKBFjYH+IOqViz0zTnn28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pPALB/TMO0cSQo6eFwsqLRqHx4P7HNId4Niizxj/A4=;
 b=t/YzemDVtUTiv3SgI/c5Uzzves4BzkwhPIcG6n9ouhXECwc3xIe5OeW7JqtRgt9/cEUWvBWlxe+QBIrFr9x98LQUkQJIYhME4KVSiPkEQhmdaWAMYS7UUNo3BGxNt11qGzIzdPw81PCuawSyeKK3NZqK2TPpdQcatAFlA0JZ731pkNu1cU3DTgaJMww5/uyq4BiabNLSOEdTkWT/ykVeu5SUHMZeJgJN/FD6MTszNy6Rbmk3zyQ9pY6NVh+3tf2EGIDN6/jBBBOXTxhRnYbfy8K6Q8m2w38jHe4cNoFRaUikajfXmfm+3b4XA0/NklOg6wN5QIpOLSf9gHiqKB0c0Q==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by DS0PR02MB11085.namprd02.prod.outlook.com (2603:10b6:8:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 15:18:59 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:18:58 +0000
Message-ID: <a80709ba-4e51-4b75-9c5b-cdc88ab1c169@nutanix.com>
Date: Wed, 10 Jun 2026 16:18:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] qdev: Export global_props()
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
 Markus Armbruster <armbru@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-3-peterx@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260609172514.2037645-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0052.namprd15.prod.outlook.com
 (2603:10b6:930:1b::9) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|DS0PR02MB11085:EE_
X-MS-Office365-Filtering-Correlation-Id: 391d006f-30d2-4e06-10fb-08dec70397eb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vvebun+jtQqAazrcezK3WKlix7RcYHuDfa9BIqCFhIEOSCJc27qxllWB97IU6t2x0DObVEIHMxr0fVcceX9xxua1OZAe0e5MDVao+woCuIqh+25x/lfVQ9hWKUmoxvYOuNbJrpS6ZdtuIL3aTd86VgsV1q03eSzB8+SgyT7tDV0mMvC1QziXT5rVVrecOGoj1Zpgy5Wa/jc03DdI7sNNPmH5UKnQCfSvAjv9MwEOUvupvRal3KhIod2wZly7WIj1DeN3qLYgkjgkS4mSXqpgnZU7R/4uJwSD343HwdYTrPcHTlPamU9HZJxxfA+lBgyDmzEUfcshO7iNN5LuSbosb0v3NX90vb53YsAaH2+k0Jjd2fTHFChwtBQNz+GTgoOqJVk3ghfWHOMuzHeXoShG+fEBvb8dKthL/NzYuxUmijFG/GuBIDndXV7GFM2gB3LlbIy3piwHXMClmnAQClH93/qHNzUC35OXPpDXvHXSYb7DNmdUhndzBeEc0jqLQCpdy0VDF5menjuUQCnR5s9JxukhnZ1Vj8mCFCGx3ZygfBJCtyC22tzDMcBwqEFwqdgaqS++zfQiotLJmUNamMBBiDeiVgB9pJpZOUfD+l+Y8Wm3/IcGie4IzTYkiwxEtr28/y4JWljgYTrWv0uJ6O+8at0FlV1454Uur++Jh3ifI+J7eW1rs0ilO5oX5IO8jzuo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW9hUUFYVkl0U0l0M1ZzU2R2cXZENnBYM251SzlUN1lYMTd1ZWxibi84TGlK?=
 =?utf-8?B?UHNaMWVydVNpU1RIL25mMWg3ckkvMFE5M1MxbTJBSHNSZWJNMk00ZGo5UkhD?=
 =?utf-8?B?VktQMzlLM2RQTnNZcFRuZ05aQUtWQWNvUkJ4RzRhRzFLRWR6RUtUaG5mSVZj?=
 =?utf-8?B?OHVvbExWQ1plWitFeDB6aW5xSDVxUzEwa3RUR0U1OFpEend0K096YUJydnlt?=
 =?utf-8?B?ajJjeCtjOTl3clJCYzh3dlJmeXVyTFBEbytUUGgyRlNpekF5M2Z1Y0xOZ1Y4?=
 =?utf-8?B?K2pnblBkWmxtV04vTnJZK1ZDckFkTUlEbDNNdjMvNVZrNWVwNHBVR00zTWI4?=
 =?utf-8?B?VnlPTXhmSG9XOWhoVlQycnQ5engrQVFxVDFNb0lSa1pJSWM2SkN5b2pxQTJM?=
 =?utf-8?B?VlRpRFJFMC9McWJPaFBJRi9kWnNpckQwWENDeFB6cm1KM280UzhGRzRnTFlp?=
 =?utf-8?B?RFZZZkF2cllXZXlDazI5S2VkOFQ2QWV6R2ZNdkFDNE56c1NqQzFCL2x3ZVhX?=
 =?utf-8?B?TlZjbGhKYy9Mc0JwaVRWcHFhcGw2OS9LbWZkZlc2M1NSeFpBc0YxUGtzUW45?=
 =?utf-8?B?S01QVkl6aklEVmZzZVNaUGlCaE0wL0doTVdPTVFZZmRFMUFSVGtBQnEvK3pl?=
 =?utf-8?B?NW9ha1VRWjMweWljS0dKSi94c09veGJIMFZ0RWpaaDNVb3NIZFdTRzZ5QWdZ?=
 =?utf-8?B?UFhGN1pOV0twYkZLSkwwSVBNUEhKUFEveUhzWmtxOTRsQ3hOdmh1TERMNGtz?=
 =?utf-8?B?TnFUam56bVFyT3hLNnlhR0FHdWxyVzRCalpKUkhjVTBxVk5OMnhWQThLS0du?=
 =?utf-8?B?b1UrSmpua05NRzBJMUpjVm5ZWldDSVlyVHJabzNJM3k4NDlmaWdlT08wR2tG?=
 =?utf-8?B?ZnFGK21LN2hWOGJQeHN5SGJkR1RoU2M0NUVsaTV4UlZCM3Z5S1h1dEdVSXcx?=
 =?utf-8?B?azh5bjVsYjZjbHRxVlV4eC9vbEpMUi9ZNGJDRGYzRUNDU0tZY3NOUGtnTC9Z?=
 =?utf-8?B?aThQVnVWd0ovWDV2TlZFK1RROU1pWFVBWjJwRVRPOW9kQTd3dVRiWmp0Rjhn?=
 =?utf-8?B?cUFhQlVaRSs1cTNoQS9lVVBSNWorRHh5MGNTYWM1SHN2dDN6SlRMMk0wL2hX?=
 =?utf-8?B?all2NXdHdTdHTXlGR3ViTXQ5RkpGNUhJSnIzR3FiZzMzZWFkdnZibXdvVTNi?=
 =?utf-8?B?MXlaNDNoaitGdWs2RU1nSFBsUE8rN3FiTzU0OENkZlRBcVFRRjVXckRoZzhm?=
 =?utf-8?B?NVFubXAxMFZQUG1aMlgwZjRvaFhsTmNvSHdxRzJyTWNxbDNVQkxBTFlpR1Rx?=
 =?utf-8?B?U2p3QmpIMHBuakppdktMaGlLbkp5SnhLV2VLSmlyL3ZUOEFaTXhWY2NhR1Ux?=
 =?utf-8?B?Q0hjZ2dzaGZRRHpvSXNiWTFXVWJPaFpHVXlwRlZlVnZ5OEltZDJ6bEJWd3hM?=
 =?utf-8?B?dXNjcVdESmhDKzJSYXR0blNVZ1pvemhJancxQ0JKZFdpN3ViNit1T0ZweXlk?=
 =?utf-8?B?VXM5cTVhRTFMTFFZbS9JUUt4dk9CNm1yelBkK08zQk95TGhQb3MrcENRYktO?=
 =?utf-8?B?RS9HWHNWa2pkLzBEdmF6RDhITVlCcEgyN3VyS2VZUHRVWFhheE1aRzR6WFQ0?=
 =?utf-8?B?dHozS3BhYVVreDRiV0pyUUV0TTRUSGxkV3hibEFGeTM1SFZlNjUyclc3aFRj?=
 =?utf-8?B?SUhIVE12TjFwNFdpNUJ2bWgrRFo1Uml2bG1pMzlkYWR6NEwwWjRnRGFzYU1q?=
 =?utf-8?B?ZENrMHZFNEZvdW5nNlpDKzBkTHhGZW1HaFFzbTk1UCtFVWE2ZlZ6REdwL2NV?=
 =?utf-8?B?dVlaS2c1ZDFodkFKaEJ1US9SYnZhRzYzSGFUZGFQaFQvMExieDl1TXdTQi9P?=
 =?utf-8?B?bTVYL0EwbTFxcUdRN2xCZVVtNEpBTkRjdkJzQXplQmJiL1Q4cWYvbUF5NGcv?=
 =?utf-8?B?ZEZrd3ZWc1VyWUc5SWZvcnh0UDh2ZXFYcGJjbDJDMEs3dTJMWmdUZW1HTFhj?=
 =?utf-8?B?UWJpWmZCTDV0RDlJR3RxbWtwQzFBZm14U3IzekhMQW5EbStPWW0yVGw0R29N?=
 =?utf-8?B?NS9uQXBaWjNLN0pKekEyMUVGMDNLcm1acWJlLzA4dzFkR0ZEam8rVGl5RGV5?=
 =?utf-8?B?azJ6bTNUWFRmT01RMTB5SUtYRm40akVDa2lUQ2tnUkZLTFpDWjBqVzRjZm1u?=
 =?utf-8?B?TDZZQ0ZtelRXazJJWUczU0NDZTJKYnFCbGUva1NSY20wejhwWXlIRTZ6L3Jz?=
 =?utf-8?B?eUtac25LU0JTZkxmS2ZJMHUySEIza3dFeGFibTVqaUo2U2ZnNWxIRUNRaXB2?=
 =?utf-8?B?N1htSGtTdHBqM1NZaFRsRVprU3Rrc282WHphZnZEUVVrRjI0QXBhei94M3pm?=
 =?utf-8?Q?LmwOtU0NGQlobKns=3D?=
X-Exchange-RoutingPolicyChecked: q+l5QJh5+WF8fzAy9b10BtSSi5Nadv8gulaPizeLo1iIZ8tfvRDyL2nvq8qOtcRBv/oy2XKYZGf6DpLwHY/zFoGT6p6OJWuhYb5IBRKaFuiwEqNLdjxAD4TVjXOts7hp8fgths/GBmw1KHe6zSKK6Ht8ugAs6RJORxSywiJ3yG+MF/d/jN2npzunkKYcCWo45uDSqMoh4yXXGh2K4CbvO8s3D1ygPCcGMElinI3JLLJjLAHt6V852RFRS3vLwMZbmXQ/46YCGHvaZBJEQTlkshOpasdu4N6WuMuma+37v/rJZdiLfP5B6UfkDMta8r3alBtZwLZsxu9JWeQ4GFyIgw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391d006f-30d2-4e06-10fb-08dec70397eb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:18:58.8894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8Z1NVzulaeKJxfPJN7QY2eJ84vmc0C5/U+GEBU2yhKddA7mE8oAqZOOAuXArnMY5E3o+a0F1Mq9XVnHMpY0+mnTORB/PxcZ32lpFzyd5yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE0NiBTYWx0ZWRfXwN2PSS6IqePE
 QC7cRybXfwwUD/7bvxZF6rqk15QJDZofmOLem9GruexEvqi0OaGV0L7iK9izUoM5LNu7DNn5ANx
 xLyeZSBF5gx5R/hfugqemwU02rPvNFsSuDvztmwJl9uhqDrTKVTGkcZBTVQ/gaVGl3elLrfXno7
 XssmcCZyipJuevqWBcHRwwoBMPn3QUFI/GdiuQdDKNY1OEWNo3qdx+yZfjp7Nz8Fqa39JsUgqx7
 ZLN+5qU6dx61949S0dEzQgyDBulqmF9su1tuCEkCk+/FPXYzTOnQ5kFPKCcxwv8zm3VaQ3OQLMw
 4nPwKoumKNvgrwiH75tiQRhirgIWqgwynR8tmcdkXrbNln/JPpkCcavzfY92Zt/Vrid/fl331ts
 Uy3hxnWPUEmy/V5eWlXXWstiHRcFuMP5kYALm9A3orjT0YMqZgo/Y0w/AkYxQBzUTEVNSxML8am
 b02gTdEfRarAb7FHShQ==
X-Authority-Analysis: v=2.4 cv=N5QZ0W9B c=1 sm=1 tr=0 ts=6a298064 cx=c_pps
 a=XKZdELU3BU0400fiC4IFSg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=jZUcNLCEkHin2TimjKAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YY_OES8qtjZF_Em_LZeqd0EOmHE5IcBD
X-Proofpoint-ORIG-GUID: YY_OES8qtjZF_Em_LZeqd0EOmHE5IcBD
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

> Make it accessible from outside (to apply -global properties).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/hw/core/qdev-properties.h | 2 ++
>   hw/core/qdev-properties.c         | 2 +-
>   rust/bindings/hwcore-sys/lib.rs   | 2 +-
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
> index eba5436e53..248bbcbba7 100644
> --- a/include/hw/core/qdev-properties.h
> +++ b/include/hw/core/qdev-properties.h
> @@ -321,4 +321,6 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
>                                                const char *name,
>                                                Object *val, Error **errp);
>   
> +GPtrArray *global_props(void);
> +
>   #endif
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 34d7b26a73..1d531189ec 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -958,7 +958,7 @@ void qlist_append_link(QList *qlist, Object *obj)
>       qlist_append_str(qlist, path);
>   }
>   
> -static GPtrArray *global_props(void)
> +GPtrArray *global_props(void)
>   {
>       static GPtrArray *gp;
>   
> diff --git a/rust/bindings/hwcore-sys/lib.rs b/rust/bindings/hwcore-sys/lib.rs
> index 8cef4a7961..85e71f5145 100644
> --- a/rust/bindings/hwcore-sys/lib.rs
> +++ b/rust/bindings/hwcore-sys/lib.rs
> @@ -20,7 +20,7 @@
>   
>   use chardev_sys::Chardev;
>   use common::Zeroable;
> -use glib_sys::GSList;
> +use glib_sys::{GPtrArray, GSList};
>   use migration_sys::VMStateDescription;
>   use qom_sys::{
>       InterfaceClass, Object, ObjectClass, ObjectProperty, ObjectPropertyAccessor,

I'd have to take the Rust part on trust, but at least for the C version:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


