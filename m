Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1795C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 05:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWUNE-0008Uu-7x; Wed, 24 Jul 2024 01:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWUN7-0008UK-Np
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 01:17:05 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWUN4-0008MB-M0
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 01:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721798222; x=1753334222;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=m6wPOFXCaglzhrwAYokFXxbfYn3IQVsPUT1CSAmEspM=;
 b=oYvJ0q42T7XFelLGDlcM3Fx3Vf8DOHkau4QIymTypkhHFQ3fp333isCH
 mXhiUD2lxOAtZEf7ZiTlpNxvEHSnMIY9/e5o+WhHNoABIDTSZK3SUDaFE
 /C44JchSMYXa3lKHu6coXd5uybWFjQpjMPLs6nWxHjX5MCa+t6qm5qnia
 izv8BRbdl6Ybf547ZbxJ3b2Z9iYpnjxnp+cgXGzKxqq1hFV1xmqDt0a+Y
 Si8Nh1MWsZgxcndb89P494ltSv2cb6X7LsCOQctQmclh832j9Y0vJL03w
 uK/cd+uYP3iPc/3P+AIOjL0K22qk5mlJqwv0SFU1GzlHyL4zyeq/yBSA4 A==;
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; d="scan'208";a="17218160"
X-MGA-submission: =?us-ascii?q?MDHPFLh4lh/NDr+NHO/r9QJqviVoE27eUzZH0i?=
 =?us-ascii?q?kIztNp1Gg6kv3ZOvDgsOd7H7SRyCpY8lkB8R+EITqBE8whP+nAGze0hI?=
 =?us-ascii?q?gbCh5N9IGIUDHiewLkr3yh3o/L1kfqQuXRj5K67Qke/QeabiFR1I0NAV?=
 =?us-ascii?q?BF0fDw7AvqbpN7EyBp/guVlQ=3D=3D?=
Received: from mail-am6eur05lp2113.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.113])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 07:16:58 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apNHtqdbXm0Z0X5iunxnzXeR/a29rNQ7hbMVLlSA6/9AUSEs8nGEzHmQ+/Xj6M7r0qD8sGDJE8+ShhFbCPlEQh9PxYYD5yR+SHV0+RURPE4GLRUq2UjZsrH+LI8uv01HYJYXL1nCJm4+1/a65BvqvQkv4ZGuF3WFlf94fptpuIggBjdZn0uMndYpkcPv7DHsF27Dzm90SNPg/ODdorLyJBYTq+4IU4M0WpV3u58ex/39rVdBP69eNWbIy2MPYLFiv72huApHJAKJCkCUN8Yj2eAiQoe18s42r/aUXLFMe5Q8kCPS1b2e7hbWlqBO8ipwZnlFvmJXKVW5fbXd1NcrzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6wPOFXCaglzhrwAYokFXxbfYn3IQVsPUT1CSAmEspM=;
 b=CijhMArJqs1Gzi4oT5ruob/Rgp8AZcCIuHq7kUndA9FRWZomyQ9gbj24goN3GJ4U0J+GqiADm3rARMKjBpVL06FfQd075ILYH+BJlpUEDrL6bFOrZZE1b7jbwdME1AToLoDoVAI/FZhj4IPSSqnwlvvB5LuX0jfKPDmHJXefSefmc+iY1kBC5DZp8S3oL6MVI8DAS9L+0YLINDbW3CMg0G82dCmXALu2OQyCmWc6buJCcoO25680u5U6wMNTxtp8eCg7uNyI0Nh7Im28HnZWn97EdbyeuQ7OIrGWXopcFyeroygYX+/YpkkR1oKUAQcmwu86LXoSD0Fq4huNooU3bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6wPOFXCaglzhrwAYokFXxbfYn3IQVsPUT1CSAmEspM=;
 b=XbShEj1JF0T/EpeVpg4/D4QIANxrEZAoCyT7kwgbbV6FN5oDnHVS1/yOSfzY4AbZatTAYD3WxjQ6Z4KquFsxcnt7ockFVKVQ93cLc+3Pm0YS8Sn+hOX776NrB61oS7pw4TMNO2QrEWFex7fWaCrdCxLJQ6m93JRfF7N7HGlb2/SQyZQXuZBTrLyXdGXC0qzbRVs8rsDNeMqYc02KbmY184n+359E87b9au53scCRyPD0Z5yUc20gvaT06l0l9EoaYTe/BPV+AwbRTEL4+SmrMF0fhgKqPmwrKxZZc8R5sWtZYxqqPcDxP9pSDfN/PGelruvG+79ou45g7ewgB3e/mg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DUZPR07MB9958.eurprd07.prod.outlook.com (2603:10a6:10:4b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 05:16:57 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7807.006; Wed, 24 Jul 2024
 05:16:56 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v1 04/17] intel_iommu: Flush stage-2 cache in
 PADID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v1 04/17] intel_iommu: Flush stage-2 cache in
 PADID-selective PASID-based iotlb invalidation
Thread-Index: AQHa2Os92r050du/y0KH7fcUu/AiKrIEgXOAgAC3qoCAACZpgA==
Date: Wed, 24 Jul 2024 05:16:56 +0000
Message-ID: <75146be8-2ee7-4b7c-bb78-06c4a846bb67@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-5-zhenzhong.duan@intel.com>
 <8bc5a4b9-9b25-42dd-aeda-8140a81e1505@eviden.com>
 <SJ0PR11MB6744432BBE635975409412CC92AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744432BBE635975409412CC92AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DUZPR07MB9958:EE_
x-ms-office365-filtering-correlation-id: 97c860dd-7778-4394-7ae1-08dcab9fd682
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Z1dRZDZPQ3B3VThwd2J2M29KK29kRmRBeHhOR1Z6MFVVQjRGVWFodHM3TFEy?=
 =?utf-8?B?Zy9aWElHUG1EbHVIVmpJZ1pPR3pQdzkzK2Qxb3lXdUp3d1JlTkh0UkpRSzZh?=
 =?utf-8?B?Qy9reGtodHJJWlhicWFyS05MaUxSeDJwWks1eDloQ2pFaks1bXM1d1hVZGFl?=
 =?utf-8?B?WUNWWDg0bWVwZHpaTDFmaTV6eWhRckVWOUdiY1ZoNHdUVFBQRjkvSkVjU2hO?=
 =?utf-8?B?cDE0N2tJL2dFWm1TZ08wYkY4QzY2UEIvYXE0dHl1bDlMeGlubm1PbEFWTk9Q?=
 =?utf-8?B?S3lpcmMwWjlrQ1NnQm1oR3diSjZTZEF0aitjbDBWaklyVG9uL2JsQlF5MzMz?=
 =?utf-8?B?NWVtTXdTZlNScFVsR3Fsak96V3lyYTBzejZ5QjZzUy9sMStFbVlOMlkvMXg2?=
 =?utf-8?B?VVF3YUlqeUl2a2o2ZUczRnUxY2VpRzhZdExBby9WeXM4NU5ENUl1dVdoTkxW?=
 =?utf-8?B?RXlYV0VnTUhuTU55b2tCaWk5SHJMeFpNMW9IZ0ZqRG5GMjJHdHJEVFYreHN0?=
 =?utf-8?B?UGlacjFldjREK091NHR4M0FtT3hXQVpjUnpqa3oyeHVRc2FGWWhvNmY4dUFH?=
 =?utf-8?B?UU9OcjhrMVhCMkhpQTVhODJsRmdjVEdDbnlQelBsOGNKRVJPc1FwRlMrdjhs?=
 =?utf-8?B?REMwR0J2MmJoSVd4YnVJVDJwVzBwMjJreHVSSmRYeGViOU1PdjU3VXdhTHkv?=
 =?utf-8?B?VzUyaFRxaWUvYW1TZ2VEUmN5VUkwODFveEFPTFFtcVhwWmZ2K0N4ZC8yZDZI?=
 =?utf-8?B?TW1KSXk2NGZQSGF6YUJPQTdqMHQvZEVnOGNkbjdsd1hSVUE1RmF1MVpwNDc1?=
 =?utf-8?B?ZDFkSUw2RVVvcnFKd1hRM0VrYVpuWVp4L2ZCL2xXNVp1RXJaU2ZicEs0ZkVo?=
 =?utf-8?B?djB3MktQYkwwRTNuRU5NSFk0U05rR1daZWFxYTFjY2RXaUNQbHZvT1loRTdD?=
 =?utf-8?B?Z2tKMXFRQXlQNWNEZjRmUWo3Z0tTdzZRWGVXLzF4dWpEb1J0bDNlM2s1a2hD?=
 =?utf-8?B?YXYzSnR6SzVuam5ZWC82UDFSNWUyVmFvRzdxMDV0cEEyZDNseGFSY1RQR1Vr?=
 =?utf-8?B?UDFMZW1UbmJhNmNPVnU2S1ZsejlyVS9NclNNNlFTTlE4R3B3dUhZekF3ZHZS?=
 =?utf-8?B?M1o0MGdGODhOTkkyWDFVdUtMWXRIVzFTbnJpNWNPaVhkZ1dtRVRaK3h2Y2Nl?=
 =?utf-8?B?ZlFTUjhMMERDNnNhck41cEZRcWlXejVUaFRoTmFEaUR3TnhsTEQxR1UzT0lK?=
 =?utf-8?B?bkc3UWVsSHpiTTRseGxPZkM4Zi9JRXR6N0lkQnBRSEo4KzhnZEdHMExXYllQ?=
 =?utf-8?B?UFU2TUo5S010ZTNVWW8rK1dMaXI5elNEWFYxSHQxUzl0TEJKellCeFJkVTAr?=
 =?utf-8?B?WEw5WE9ENjZUZVNORFVXdWR3dzJTSWVYVGErUVdudDFmWE0xT0VHamZGZWRk?=
 =?utf-8?B?Z3ZOM0xMZitqWW5KdE1mK2VlVUlCcm5ZOFNSWlNjQ051bVhxUDNtSGR1Z3NW?=
 =?utf-8?B?Y01kUUVZcVgvRGlWV1ZXTHhMc2xzT2d5YVdVZ3BmY1g0L0M5TEVPalBBR0dm?=
 =?utf-8?B?dHJDcE8yQ3JEdTRKS2RtbFFlNzRBaFRUNE1KdDVKeWZIVDhCcTkzc0VFQXdW?=
 =?utf-8?B?UnBGakdieTlEQ0VFeERGcW96WDgycXFIcjN1NUlqallkYm1PWE9iL1o2NE1O?=
 =?utf-8?B?cjlpdUM2M2U0R1p4MnhobWRKNCsyb1N4NkUxRkRuUFJmcFhYYjROWFl3b0Iz?=
 =?utf-8?B?YzBLRTFtak9UY0xTaXp0cWhkWkRZLzZGZURwaElLVHVtT1RQYlVPcFloMmhs?=
 =?utf-8?B?S2tVeVVBMTYxUkFWOUliSkxCTkVnRWxZMGRya09JeSs4ZjR6N0xmMWZFRG9p?=
 =?utf-8?B?OFdCM0V4bEdpejQxRWw4b0NjU2VheGhhTEhZRUVEZGZFUnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkZoYUZDTVczQzl4ekgyT0tLNmpIMlhGcUhxNFFtenI1bHhSUVpGZU5HZ1dN?=
 =?utf-8?B?eEtOTmd0Y011a0RQUlREdWNiU2VlUU4vVmV0dGMvRnc3ZjhkYnV2U2NZbTVm?=
 =?utf-8?B?WWFWM3hZd2d1TDZYZkRyWmxhbmdCemc0ZktjQ2w4WTdabnA3ekdzY2lrWmJa?=
 =?utf-8?B?V0NkVkVzUkc2c0ZCaWNIYUVMWXZRRnNvMVluZDgzc244YTJKYkRXUXlqc0pE?=
 =?utf-8?B?N2I4N2Evb0FRSm9kNkdBOGpxOTZkaTcrVzZKY3VHK241TnVMNEpteHVTZlN5?=
 =?utf-8?B?L1gzT2hUZWRrMi80YWUwWHdMQVFzV0JNUlREZ0hSSTVxTUpwNXhuM3JhbkFW?=
 =?utf-8?B?UjN4K0IvNGNYZVJXWjllRTQ0b04wWEtZQ2FwUnpUKzJnbXFGeUlHVWhXK0o2?=
 =?utf-8?B?Mkl5bnhkVnBJYjhnZjd6VEtNVkdCcUxaTW9BelBtaTBla2tpdU5hVlZiTnhz?=
 =?utf-8?B?ZE9CanpINk1IRGVDZWwxT05paWVkOVYyWGNWdm9ZdHczRlZNRTg4OXh2VzZi?=
 =?utf-8?B?M3VBYWh2dkhTWEloL3BXZzR5dnpYdmEycFRBZGQwbS8wYlE2K2I0Z2VOZG8r?=
 =?utf-8?B?dXBsbU5ycHNMUEEyZkhqZWlGdGlnWWdSbjRtZStMeWgwRUt6djJKMU5RVEFz?=
 =?utf-8?B?YWRtVG1NTStmbVYzVUVGRkJLTDZWVnV3ZFdLQ0RXR1RBMjhrREtiVkRZQVpG?=
 =?utf-8?B?Ny9oVFhoYmtDK0pwMkM1ajZCM3FmenZmSWVyVEsyR2pmdFlqR3NuUk1KdFo3?=
 =?utf-8?B?aWJmakkrbzJzMmtUbTNtTjJrUU1NRkh5N2pTWjZENDByeDc2Sjl6ZDV1cytr?=
 =?utf-8?B?K2syc1FOYVhuSXBTV2h6VmJPblNxSy9IeEd2UkI0anNaR3ZRUXltNFBrZ1kr?=
 =?utf-8?B?VXhoQ1BzUzBUWXdIWkVmYnpiSnFaOTFmNStNbUQzcEFCM0dzY2J5dW5GeEFi?=
 =?utf-8?B?SVNrNCtGa3RBMU9Qc29HdCtlRU52L1hZdmQxQ2w5L09Lc3lHQUNaM2loeXFj?=
 =?utf-8?B?N25RU1kxa0Zya0pjK3UvV1NxZkh4UHdoTUI1WU1uazAvUjF6NUhOVzRiU3Fn?=
 =?utf-8?B?WmtIR3RkR3NRV0FoYTRRaDR3TUU1WjFkbTdtamJ6SytJNFdrV0V2WVhsRnpP?=
 =?utf-8?B?eWNVNDRhWDFzazkxVzZMUVl3ZFV3Uk5kcDFjb2ZWUEpseW1sUTVENWRzcWo4?=
 =?utf-8?B?ZEJ3U09nQ052QkNsaTY3WUE2Sm5TcUpOZzNHRDNzUVlENERsQVRzS2IwT2Ev?=
 =?utf-8?B?c1pTSkU4SGM0SmFsK0lZOVJFYzBMQW1NOGFPeFFSblFXcmlxd0JTaThYR1Bx?=
 =?utf-8?B?R2xhZXd0WGlGbWthN3RLaGpPVjBDK2czUmhLM2U2ajdUV25ZblNpd2xGNVNS?=
 =?utf-8?B?dUhBSG5kd081L3pSRWVFNU9MR3EzQ0RFNVJ0TnJNd1VrdkF4WExYaUtkUDh1?=
 =?utf-8?B?NzhXQXdCZzhrUDNvdDA5U2tRQUFaRmhuNmJvU3ZUSEw4bnhCREdTZHhneWxK?=
 =?utf-8?B?VWg0Z1ZNazRYWUo0a0ZDQmRwNUpPNyt5clBpR3FqZFRZeG5UeE5FcEFjbzVy?=
 =?utf-8?B?R2VGekVWT0tKY2JBK0xtN2R1RXRpSmRnbUJuMDZTWGdwdFFWaVp1Q3NJMlNS?=
 =?utf-8?B?OWg4VjVnWWVBSGNKTmtTS0QzOGw1d0MraTZFUGc2MmRNeDlSbThkMWZZWDkx?=
 =?utf-8?B?Yy92dERKelNpY3lsS2hpbG5teDFDVlBlZ3B3T0R5eDJkanQzbzAwdnVKTW5V?=
 =?utf-8?B?T1FXWkZtVy81QWhuSHZETjZsQzdOV3ROT2dnL2cwcVBDaDY3d3RmdjlTSkpO?=
 =?utf-8?B?OUdrQmVRVU5sT3I2aXRFVHc0TFNGNmJFcFNiUTlDQ2VSbkI4S1ZNWjlLSEdy?=
 =?utf-8?B?YzdieW9oZDVENnlxU0QrS0l3OUNtb3VJUlZwQ28vTFFrMSs3RHlndmFPc21T?=
 =?utf-8?B?OTZYVHBkNkw5U05OZTcyejgzdFFBUEh2dlJuNGdteEd2YjltYlgvdEJPcnhJ?=
 =?utf-8?B?UERZM1hRT1RCenBsY21aSytESEs2d0xGY1liT2dGbVNwK0F6ZmxERnNQWGFl?=
 =?utf-8?B?Yi8rWFVsMXJqeHhwc0oyRlRuR3F3QmFkRTYySWtYSkE0M2NONkFCUGx6bUVa?=
 =?utf-8?B?cGtVNldEbkFIMStucy94K3lhYlI5VlZGYVMzSHp0NmNidnVHVkY4WVc1Qmk3?=
 =?utf-8?Q?63PIm+FJasEWqLdDgRZohBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAB94487326B5F4B856049526F879392@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c860dd-7778-4394-7ae1-08dcab9fd682
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 05:16:56.6310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3PYfIFUB6lKA7YylxpcJIz8HG/JI4bakSau//wjFZLCW5bZFHGGNuXOGDq4K+Qrwn67DR3Wa06iQJlI5F78KktxVFI2GebRRYKOVRsQzAzoCPA/tnxEsT+OAbjNDbY7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB9958
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIDI0LzA3LzIwMjQgMDQ6NTksIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA0LzE3XSBpbnRlbF9pb21t
dTogRmx1c2ggc3RhZ2UtMiBjYWNoZSBpbiBQQURJRC0NCj4+IHNlbGVjdGl2ZSBQQVNJRC1iYXNl
ZCBpb3RsYiBpbnZhbGlkYXRpb24NCj4+DQo+Pg0KPj4NCj4+IE9uIDE4LzA3LzIwMjQgMTA6MTYs
IFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBu
b3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMNCj4+IGVtYWls
IGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNh
ZmUuDQo+Pj4NCj4+PiBQZXIgc3BlYyA2LjUuMi40LCBQQURJRC1zZWxlY3RpdmUgUEFTSUQtYmFz
ZWQgaW90bGIgaW52YWxpZGF0aW9uIHdpbGwNCj4+PiBmbHVzaCBzdGFnZS0yIGlvdGxiIGVudHJp
ZXMgd2l0aCBtYXRjaGluZyBkb21haW4gaWQgYW5kIHBhc2lkLg0KPj4+DQo+Pj4gV2l0aCBzY2Fs
YWJsZSBtb2Rlcm4gbW9kZSBpbnRyb2R1Y2VkLCBndWVzdCBjb3VsZCBzZW5kIFBBU0lELXNlbGVj
dGl2ZQ0KPj4+IFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbiB0byBmbHVzaCBib3RoIHN0
YWdlLTEgYW5kIHN0YWdlLTIgZW50cmllcy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56
aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMTAgKysrKysNCj4+PiAgICBody9pMzg2L2lu
dGVsX2lvbW11LmMgICAgICAgICAgfCA3OA0KPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKQ0KPj4+DQo+
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gYi9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+PiBpbmRleCA0ZTAzMzFjYWJhLi5mNzFmYzkx
MjM0IDEwMDY0NA0KPj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+IEBAIC00NDAsNiArNDQw
LDE2IEBAIHR5cGVkZWYgdW5pb24gVlRESW52RGVzYyBWVERJbnZEZXNjOw0KPj4+ICAgICAgICAg
ICAgKDB4M2ZmZmY4MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERfU0xfSUdOX0NPTSB8
DQo+PiBWVERfU0xfVE0pKSA6IFwNCj4+PiAgICAgICAgICAgICgweDNmZmZmODAwVUxMIHwgfihW
VERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00pKQ0KPj4+DQo+Pj4gKyNkZWZpbmUgVlRE
X0lOVl9ERVNDX1BJT1RMQl9BTExfSU5fUEFTSUQgICgyVUxMIDw8IDQpDQo+Pj4gKyNkZWZpbmUg
VlREX0lOVl9ERVNDX1BJT1RMQl9QU0lfSU5fUEFTSUQgICgzVUxMIDw8IDQpDQo+Pj4gKw0KPj4+
ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUlNWRF9WQUwwICAgICAweGZmZjAwMDAwMDAw
MGZmYzBVTEwNCj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRfVkFMMSAgICAg
MHhmODBVTEwNCj4+PiArDQo+Pj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9QQVNJRCh2
YWwpICAgICgoKHZhbCkgPj4gMzIpICYgMHhmZmZmZlVMTCkNCj4+PiArI2RlZmluZSBWVERfSU5W
X0RFU0NfUElPVExCX0RJRCh2YWwpICAgICAgKCgodmFsKSA+PiAxNikgJiBcDQo+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURF9ET01BSU5fSURfTUFT
SykNCj4+PiArDQo+Pj4gICAgLyogSW5mb3JtYXRpb24gYWJvdXQgcGFnZS1zZWxlY3RpdmUgSU9U
TEIgaW52YWxpZGF0ZSAqLw0KPj4+ICAgIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIHsNCj4+
PiAgICAgICAgdWludDE2X3QgZG9tYWluX2lkOw0KPj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiBpbmRleCA0MGNiZDRhMGY0
Li4wNzVhMjdhZGFjIDEwMDY0NA0KPj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+IEBAIC0yNjU5LDYgKzI2NTksODAgQEAg
c3RhdGljIGJvb2wNCj4+IHZ0ZF9wcm9jZXNzX2lvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpz
LCBWVERJbnZEZXNjICppbnZfZGVzYykNCj4+PiAgICAgICAgcmV0dXJuIHRydWU7DQo+Pj4gICAg
fQ0KPj4+DQo+Pj4gK3N0YXRpYyBnYm9vbGVhbiB2dGRfaGFzaF9yZW1vdmVfYnlfcGFzaWQoZ3Bv
aW50ZXIga2V5LCBncG9pbnRlciB2YWx1ZSwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBncG9pbnRlciB1c2VyX2RhdGEpDQo+Pj4gK3sNCj4+PiArICAgIFZU
RElPVExCRW50cnkgKmVudHJ5ID0gKFZURElPVExCRW50cnkgKil2YWx1ZTsNCj4+PiArICAgIFZU
RElPVExCUGFnZUludkluZm8gKmluZm8gPSAoVlRESU9UTEJQYWdlSW52SW5mbyAqKXVzZXJfZGF0
YTsNCj4+PiArDQo+Pj4gKyAgICByZXR1cm4gKChlbnRyeS0+ZG9tYWluX2lkID09IGluZm8tPmRv
bWFpbl9pZCkgJiYNCj4+PiArICAgICAgICAgICAgKGVudHJ5LT5wYXNpZCA9PSBpbmZvLT5wYXNp
ZCkpOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICtzdGF0aWMgdm9pZCB2dGRfcGlvdGxiX3Bhc2lkX2lu
dmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDE2X3QgZG9tYWluX2lkLCB1aW50MzJfdCBwYXNpZCkNCj4+
PiArew0KPj4+ICsgICAgVlRESU9UTEJQYWdlSW52SW5mbyBpbmZvOw0KPj4+ICsgICAgVlREQWRk
cmVzc1NwYWNlICp2dGRfYXM7DQo+Pj4gKyAgICBWVERDb250ZXh0RW50cnkgY2U7DQo+Pj4gKw0K
Pj4+ICsgICAgaW5mby5kb21haW5faWQgPSBkb21haW5faWQ7DQo+Pj4gKyAgICBpbmZvLnBhc2lk
ID0gcGFzaWQ7DQo+Pj4gKw0KPj4+ICsgICAgdnRkX2lvbW11X2xvY2socyk7DQo+Pj4gKyAgICBn
X2hhc2hfdGFibGVfZm9yZWFjaF9yZW1vdmUocy0+aW90bGIsIHZ0ZF9oYXNoX3JlbW92ZV9ieV9w
YXNpZCwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmaW5mbyk7DQo+Pj4g
KyAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4+ICsNCj4+PiArICAgIFFMSVNUX0ZPUkVBQ0go
dnRkX2FzLCAmcy0+dnRkX2FzX3dpdGhfbm90aWZpZXJzLCBuZXh0KSB7DQo+Pj4gKyAgICAgICAg
aWYgKCF2dGRfZGV2X3RvX2NvbnRleHRfZW50cnkocywgcGNpX2J1c19udW0odnRkX2FzLT5idXMp
LA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ0ZF9hcy0+ZGV2
Zm4sICZjZSkgJiYNCj4+PiArICAgICAgICAgICAgZG9tYWluX2lkID09IHZ0ZF9nZXRfZG9tYWlu
X2lkKHMsICZjZSwgdnRkX2FzLT5wYXNpZCkpIHsNCj4+PiArICAgICAgICAgICAgdWludDMyX3Qg
cmlkMnBhc2lkID0gVlREX0NFX0dFVF9SSUQyUEFTSUQoJmNlKTsNCj4+PiArDQo+Pj4gKyAgICAg
ICAgICAgIGlmICgodnRkX2FzLT5wYXNpZCAhPSBQQ0lfTk9fUEFTSUQgfHwgcGFzaWQgIT0gcmlk
MnBhc2lkKSAmJg0KPj4+ICsgICAgICAgICAgICAgICAgdnRkX2FzLT5wYXNpZCAhPSBwYXNpZCkg
ew0KPj4+ICsgICAgICAgICAgICAgICAgY29udGludWU7DQo+Pj4gKyAgICAgICAgICAgIH0NCj4+
PiArDQo+Pj4gKyAgICAgICAgICAgIGlmICghcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+Pj4gKyAg
ICAgICAgICAgICAgICB2dGRfYWRkcmVzc19zcGFjZV9zeW5jKHZ0ZF9hcyk7DQo+Pj4gKyAgICAg
ICAgICAgIH0NCj4+PiArICAgICAgICB9DQo+Pj4gKyAgICB9DQo+Pj4gK30NCj4+PiArDQo+Pj4g
K3N0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX3Bpb3RsYl9kZXNjKEludGVsSU9NTVVTdGF0ZSAqcywN
Cj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlRESW52RGVzYyAqaW52
X2Rlc2MpDQo+Pj4gK3sNCj4+PiArICAgIHVpbnQxNl90IGRvbWFpbl9pZDsNCj4+PiArICAgIHVp
bnQzMl90IHBhc2lkOw0KPj4+ICsNCj4+PiArICAgIGlmICgoaW52X2Rlc2MtPnZhbFswXSAmIFZU
RF9JTlZfREVTQ19QSU9UTEJfUlNWRF9WQUwwKSB8fA0KPj4+ICsgICAgICAgIChpbnZfZGVzYy0+
dmFsWzFdICYgVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDEpKSB7DQo+Pj4gKyAgICAgICAg
ZXJyb3JfcmVwb3J0X29uY2UoIm5vbi16ZXJvLWZpZWxkLWluLXBpb3RsYl9pbnZfZGVzYyBoaTog
MHglIg0KPj4gUFJJeDY0DQo+Pj4gKyAgICAgICAgICAgICAgICAgICIgbG86IDB4JSIgUFJJeDY0
LCBpbnZfZGVzYy0+dmFsWzFdLCBpbnZfZGVzYy0+dmFsWzBdKTsNCj4+IFRoaXMgZXJyb3IgaXMg
bm90IGZvcm1hdHRlZCBhcyB0aGUgb3RoZXIgc2ltaWxhciBtZXNzYWdlcyB3ZSBwcmludCB3aGVu
DQo+PiByZXNlcnZlZCBiaXRzIGFyZSBub24temVyby4NCj4+IEhlcmUgaXMgd2hhdCB3ZSd2ZSBk
b25lIGluIHZ0ZF9wcm9jZXNzX2lvdGxiX2Rlc2M6DQo+IFN1cmUsIHdpbGwgY2hhbmdlIGFzIGJl
bG93LA0KPg0KPj4gICAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiBpbnZhbGlkIGlvdGxi
IGludiBkZXNjOiBoaT0weCUiUFJJeDY0DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
LCBsbz0weCUiUFJJeDY0IiAocmVzZXJ2ZWQgYml0cyB1bnplcm8pIiwNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpbnZfZGVzYy0+aGksIGludl9kZXNjLT5sbyk7DQo+
Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiArICAgIGRv
bWFpbl9pZCA9IFZURF9JTlZfREVTQ19QSU9UTEJfRElEKGludl9kZXNjLT52YWxbMF0pOw0KPj4+
ICsgICAgcGFzaWQgPSBWVERfSU5WX0RFU0NfUElPVExCX1BBU0lEKGludl9kZXNjLT52YWxbMF0p
Ow0KPj4+ICsgICAgc3dpdGNoIChpbnZfZGVzYy0+dmFsWzBdICYgVlREX0lOVl9ERVNDX0lPVExC
X0cpIHsNCj4+IE5vdCBjcml0aWNhbCBidXQgd2h5IGRvbid0IHdlIGhhdmUgVlREX0lOVl9ERVND
X1BJT1RMQl9HPw0KPiBXaWxsIGFkZC4NCj4NCj4+PiArICAgIGNhc2UgVlREX0lOVl9ERVNDX1BJ
T1RMQl9BTExfSU5fUEFTSUQ6DQo+Pj4gKyAgICAgICAgdnRkX3Bpb3RsYl9wYXNpZF9pbnZhbGlk
YXRlKHMsIGRvbWFpbl9pZCwgcGFzaWQpOw0KPj4+ICsgICAgICAgIGJyZWFrOw0KPj4+ICsNCj4+
PiArICAgIGNhc2UgVlREX0lOVl9ERVNDX1BJT1RMQl9QU0lfSU5fUEFTSUQ6DQo+Pj4gKyAgICAg
ICAgYnJlYWs7DQo+Pj4gKw0KPj4+ICsgICAgZGVmYXVsdDoNCj4+PiArICAgICAgICBlcnJvcl9y
ZXBvcnRfb25jZSgiSW52YWxpZCBncmFudWxhcml0eSBpbiBQLUlPVExCIGRlc2MgaGk6IDB4JSIN
Cj4+IFBSSXg2NA0KPj4+ICsgICAgICAgICAgICAgICAgICAiIGxvOiAweCUiIFBSSXg2NCwgaW52
X2Rlc2MtPnZhbFsxXSwgaW52X2Rlc2MtPnZhbFswXSk7DQo+PiBTYW1lIGNvbW1lbnQsIEkgdGhp
bmsgd2Ugc2hvdWxkIG1ha2UgdGhlIG1lc3NhZ2VzIGNvbnNpc3RlbnQgYWNyb3NzDQo+PiBkZXNj
cmlwdG9yIGhhbmRsZXJzLg0KPiBXaGF0IGFib3V0IGJlbG93Og0KPg0KPiBkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQo+IGluZGV4IDMyOTA3NjE1OTUuLmU3NmZkOWQzNzcgMTAwNjQ0DQo+IC0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCj4gQEAgLTQ3OSw5ICs0NzksMTAgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZE
ZXNjIFZUREludkRlc2M7DQo+ICAgI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0FMTF9JTl9Q
QVNJRCAgKDJVTEwgPDwgNCkNCj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUFNJX0lO
X1BBU0lEICAoM1VMTCA8PCA0KQ0KPg0KPiArLyogTWFza3MgZm9yIElPVExCIEludmFsaWRhdGUg
RGVzY3JpcHRvciAqLw0KPiArI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfRyAgICAgICAgICAg
ICAgKDNVTEwgPDwgNCkNClRoaXMgb25lIGlzIGFscmVhZHkgZGVmaW5lZA0KPiAgICNkZWZpbmUg
VlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDAgICAgIDB4ZmZmMDAwMDAwMDAwZmZjMFVMTA0K
PiAgICNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDEgICAgIDB4ZjgwVUxMDQo+
IC0NCj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUEFTSUQodmFsKSAgICAoKCh2YWwp
ID4+IDMyKSAmIDB4ZmZmZmZVTEwpDQo+ICAgI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0RJ
RCh2YWwpICAgICAgKCgodmFsKSA+PiAxNikgJiBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgVlREX0RPTUFJTl9JRF9NQVNLKQ0KPiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+IGluZGV4
IDA3MzMxODA1MDEuLjlkZDQxYjgzNWIgMTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gQEAgLTM3MDgsOCArMzcwOCw5
IEBAIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX3Bpb3RsYl9kZXNjKEludGVsSU9NTVVTdGF0ZSAq
cywNCj4NCj4gICAgICAgaWYgKChpbnZfZGVzYy0+dmFsWzBdICYgVlREX0lOVl9ERVNDX1BJT1RM
Ql9SU1ZEX1ZBTDApIHx8DQo+ICAgICAgICAgICAoaW52X2Rlc2MtPnZhbFsxXSAmIFZURF9JTlZf
REVTQ19QSU9UTEJfUlNWRF9WQUwxKSkgew0KPiAtICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgi
bm9uLXplcm8tZmllbGQtaW4tcGlvdGxiX2ludl9kZXNjIGhpOiAweCUiIFBSSXg2NA0KPiAtICAg
ICAgICAgICAgICAgICAgIiBsbzogMHglIiBQUkl4NjQsIGludl9kZXNjLT52YWxbMV0sIGludl9k
ZXNjLT52YWxbMF0pOw0KPiArICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQg
cGlvdGxiIGludiBkZXNjIGhpPTB4JSJQUkl4NjQNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIiBsbz0weCUiUFJJeDY0IiAocmVzZXJ2ZWQgYml0cyB1bnplcm8pIiwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGludl9kZXNjLT52YWxbMV0sIGludl9kZXNjLT52
YWxbMF0pOw0KPiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgICB9DQpsZ3RtDQo+DQo+
IEBAIC0zNzI4LDggKzM3MjksMTAgQEAgc3RhdGljIGJvb2wgdnRkX3Byb2Nlc3NfcGlvdGxiX2Rl
c2MoSW50ZWxJT01NVVN0YXRlICpzLA0KPiAgICAgICAgICAgYnJlYWs7DQo+DQo+ICAgICAgIGRl
ZmF1bHQ6DQo+IC0gICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCJJbnZhbGlkIGdyYW51bGFyaXR5
IGluIFAtSU9UTEIgZGVzYyBoaTogMHglIiBQUkl4NjQNCj4gLSAgICAgICAgICAgICAgICAgICIg
bG86IDB4JSIgUFJJeDY0LCBpbnZfZGVzYy0+dmFsWzFdLCBpbnZfZGVzYy0+dmFsWzBdKTsNCj4g
KyAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiBpbnZhbGlkIHBpb3RsYiBpbnYgZGVzYzog
aGk9MHglIlBSSXg2NA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAiLCBsbz0weCUiUFJJ
eDY0IiAodHlwZSBtaXNtYXRjaDogMHglbGx4KSIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgIF9fZnVuY19fLCBpbnZfZGVzYy0+dmFsWzFdLCBpbnZfZGVzYy0+dmFsWzBdLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbnZfZGVzYy0+dmFsWzBdICYgVlREX0lOVl9ERVNDX0lP
VExCX0cpOw0KPiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgICB9DQo+ICAgICAgIHJl
dHVybiB0cnVlOw0KbGd0bQ0KPg0KPiBUaGFua3MNCj4gWmhlbnpob25nDQpUaGFua3MNCiA+Y21k

