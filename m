Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDAEC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmbj-0001Hw-0M; Fri, 02 May 2025 05:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmbf-0001Ha-K5
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:22:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmbd-0003iR-RD
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:22:55 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54286FbY002523;
 Fri, 2 May 2025 02:22:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vVsc05ICQoWM6N7knEq1wshspR04HpyuoRmyNnVfm
 cY=; b=TjhQgcySSmadm2e5PHzmlHX1yu43tfVicmzvwI+f5gWBBdYiXyDeiG64A
 fu6zG8VWkrHFPr0SdUr20BEIlL+cbLDLlalLWsO8FdjJ5S5F2S8pUxhIHKs5w/6B
 yPkhpNp+X581x18y9VkYoDaD1Owx+1QU4m9XRX0JN65zE0E9N6qrxA9nop5Yj/Ec
 PbTf+eZcJfaDiPfDl45waATp6Br5Lop5kYqtsulIpsOBR3+MYrbgKsoibgHGatBr
 GC8mmogXxcRDGlgkpDjnCDsQaAdq5GAKcIjv40LfejLRHLULCfWVnODzWqz65uZr
 MB7doo/CcWY7K4cxTGI6Bcj02LT8g==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468y10dspk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPpqJsaDVWuPVtE8QPhIKaA9k5eZsDe5uz/ND4/uW7OyRmQAiN9021F2EzSopj7P2BswfbwpkWvIlXViRhAy/lluL9jlpegbwnKU3xbe/W0DUQegY1AaJwlWVnbDKBiZaUkpvMD+938xlCadhsdka4oKJejfE/qWzQg4PYqI0xOPD2nYhqwIh7p7zYF0cy2v+dEFAN0SgBDewG/pf9zNV+ahwx9iUhbKUchD+j/qYV78VUmbrSUChkcO3Z6PdWzV57mO90P+LB30F0IT066g0BYr3MGOqMghB+aB4S3BaungaR0wtIZFJM4jnffSe4jSgm8fCegOh9SL1meXWJPziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVsc05ICQoWM6N7knEq1wshspR04HpyuoRmyNnVfmcY=;
 b=xNoGybOMaf1tTQjF3NJ01D3B2Cl/19cMRb5Pw1lRsbYo9y5Itkj6eDmQNkbUP6VsuqUvIsd/uN89vmClM4f+Y6C//MHfPQNxp3CJ8fnmvX0S5z2n01/tvkeoyVfBZjWt4QxygM62bRDbE41AN3Q/IuPgYFBoN2ecz1ro3GaODh4G+YpVBnikTFuMjM/awo0KhfuwOG/ZcintXbnJmYjD1XDtCRFScjLrIJIO/QdM38Fti2M3zrGR7FPTI/fvTDeAn2a/ygp7VXOokvI3chOvO/fKdQjNYogOCmoEWC5ccpV/C0hLtTbC9p7+bQP4NN6lx70kh7VpX5b//9xkPAHBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVsc05ICQoWM6N7knEq1wshspR04HpyuoRmyNnVfmcY=;
 b=bJ+AnGsaIeJNHT2IgmmpA9d5r62W3zBbLKmH5DvQmrPonvEbMBtk2v7/ei9sAFTG8RnKNKswYJJLYmZomZkipj42BuXHe/sxV5tJRzua3BZ3JLLZ85HhkQCBVNui3sgfQG8v87goJ6yU91lWUxThzyYTtlMk1JwZ5ED1CkMy92/vxKjBPEgkZIv5+uZrUuYxgBz98dgDzt0qhbpVda9208pOp43widRpPHaz0X7fgPtFD4WVdl8CPnd6tiJ4S0JbrOcGUg587vLTZqO4qthHhEK5spdRtXd5pulfEmjjvZrOfWWsvTzc+t2feQ3wfaWZh47C6L0ygFh402dZA3OPVg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 CY5PR02MB8893.namprd02.prod.outlook.com (2603:10b6:930:3f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.22; Fri, 2 May 2025 09:22:34 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:22:34 +0000
Message-ID: <51195fd2-505e-47ad-a885-8e8b9ed01ca7@nutanix.com>
Date: Fri, 2 May 2025 10:22:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] hw/core/machine: Remove hw_compat_2_7[] array
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-12-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::25) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|CY5PR02MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a750ff-1272-4684-c18d-08dd895adf68
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG5wYlo4amxGSEJCZWNRS3hVYlZmK3hBd292cjRUWjhhUnlPbFMzQmdZVW1h?=
 =?utf-8?B?N3J5R3lsSE9LVzlpcjJkK2NiaW1Mb2RxK0l2MlVTM21lN09kY2VBeGljRTZJ?=
 =?utf-8?B?U20vWEE3NkRZZ2hRRkJidEZkbGdYZTRyTUZmTTNINjNlN3UrOGkyeE56SHNn?=
 =?utf-8?B?MVgzRzNyNllVUVFOaDFHUFd4R24ra1pqWnVCMmpoR2dQNWFjU04vdGtIVkhH?=
 =?utf-8?B?cDV5blQra0hXOXdxVnZzUzVyZENXNkJGSlRLSlRXdGg5RXJqOXZQQlZObXR3?=
 =?utf-8?B?Wk5sZlVwU3VaTzRDdjVZSVdCYXZaMk1IY3hxOHpYQUoyM29uNnd4b09vSDFT?=
 =?utf-8?B?bG5QWTNmckdjWUJUQVhxUGRUdlZhQ0tQOXlNelZGVDVwZzVJckltUXN3c3Y4?=
 =?utf-8?B?bXBvL1JPZzlGUHFLbms5R1R1RWZKeU5aM3htb3lldS9OTnlNZnFFbzlLaGF6?=
 =?utf-8?B?OHlsWWN0cEhzUXI3TlJ1WGtEQXJhNWVhR3l3YnJjYVg2OExrRHpEemR0dStp?=
 =?utf-8?B?dE9jclAwT1FaWGtvS0FUbXFaWEZoRXpyTHhUWms4VExEOHlrSEtHNWxiTmdx?=
 =?utf-8?B?U1A0UzkyWUtJVmhQSUpkdHdpaWlibzF5U2YvckMyS3doMU9xWUptS0lVMDVP?=
 =?utf-8?B?elBhT2NmM0VQVDgzWEYyWkE1a2ZEL1ErTnBUVWx0L25lQkdvSGNBR2VubWJT?=
 =?utf-8?B?SEJsSkF0QVpnb1g0ZkRSM3dlRWdWem50RDVQSVpmZGJYdXhTTXd3aXM0cU96?=
 =?utf-8?B?YzZZNjY4bnJUeHY3ZFhyMm4xNFJTU2M2bUUrZGtUZHpGYm02QkNmZ1p6c3Qz?=
 =?utf-8?B?YUFLVnFWN0ZMeG9TelRmdE5GcGxGR0ZqTmh2aHBOWVY2Yk9lL2Q0YTArNmtL?=
 =?utf-8?B?OUszR1BDdHpHSjI4eXY2Yk90bTBSZkNOeDd0TWNLQmNXVTFobU54Y2xKUzVu?=
 =?utf-8?B?cUw4WnZ4bDQvUmlhRXh2NFYvOU0wdTNRMWFIdTNjaGUyd1g2NVRnQzJ3U3Vx?=
 =?utf-8?B?UWZydkk3TXF6cXJqZUNsOWowbWdLZFJuSzRkcEt5b3EwL2c5QWJzM2pZc1kw?=
 =?utf-8?B?aVNKTVdDR0N4U3hrVDhxbXZPY3ZKdy9FQ3h1cExOU0d3MXg4TEtISUQ5dzJz?=
 =?utf-8?B?V1FVNnNMY2FySFMxa3BONlY5S29yQnNxSEZ0dkg2bVJ6QmFWNWV2RzRtTm9Z?=
 =?utf-8?B?L290WjFWOGpWUmRLZENRR3A1RVIwempsOWRZcEFPaXZ5bGFuNVZuVHVSUXBo?=
 =?utf-8?B?b0hxVEszdlRLczdoMHdqNnpFTFBCNGg1NmZndEdLUlpDVnU4WW9zUlgyeWxC?=
 =?utf-8?B?a3NDNy9pSjNuaWJNQkVmcWJhWDBycC94TWc1ekY4YzM5MExRRUV6bVF0UkVm?=
 =?utf-8?B?dDBwNUZQd1pmQnFwendtSmJmbkRTNXhxSmtlRnExY3ZiaERkdytqa3BiSGlh?=
 =?utf-8?B?emZUNHJ3SVMvdUlpVHpYeHkrWVNwOUEvbzZuOHRteFpMazFSL0VEajQvRmhp?=
 =?utf-8?B?RjhMZ21lR0JnVjJLMmNwd3l4Yy9DNmJ5dnpDVU1veTZkYnVNTUR4ZEFOK29Q?=
 =?utf-8?B?Nkl3WnB3bjBqNTlXQnduaFBsUWVia2lua3piTEs3M2xDYUZ4NHlPTnVoWXRF?=
 =?utf-8?B?QjlTSDNDSHZPY0RKUHkvcEFqTGJRVCtDWkYzSFlGRCtNWUdkU0JTbUlPVjJk?=
 =?utf-8?B?c2tUak5HSERkQUVYOGRRU2tpTWd1NzcxZzNsdzRrZlJQZzVoSFZIclNqUTNL?=
 =?utf-8?B?VW9tbFpmOHBtbmhtMUI3eG50TFJLcnZKeXdFSjNVb3RDTlAxRlpIb1k2dU9X?=
 =?utf-8?B?eWxVRSt3TzQ0UUtLUDJBeDVDOWdPd2hIby9vTHBqelpka0tjemR6ZnNYR2c1?=
 =?utf-8?B?cGdDY1hBNjhMZDRTNCtkNk1UUkNsYVdCaEY5SDlhZm11ZTMrZlF6TWtMSGFn?=
 =?utf-8?Q?TwpMJR2VkLY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkZ5REoyN1RQZUxQMGpMY2lhZUdvNUdia2tNZ2NDMkV0c1hDKzlJUjV5Rklw?=
 =?utf-8?B?cWl6akl6YVJUSzZ3QnpOTmZSS2VHcWF5bC9aVURkT0hVeXd0TnpWampCZEZj?=
 =?utf-8?B?ejNGUXFkcFk1V3NRYVovaUJsbHI4SlhnMjEyLzJ0UGg5S0RLT0NTMkN3Wkln?=
 =?utf-8?B?OUdac3p3T0tGUlVGQ0xCY1prNXI0ZkVMa01yaHlhdFRFNTRnY1lORGdJYkdU?=
 =?utf-8?B?bENqTUl3aEp3aFhweDBqcXJlaGVRUlRucEtoZlVaK3dpdEwvUUM4T0tWd3ht?=
 =?utf-8?B?dGhIYU8yY0Z6aUpWS3ZNYjcrd3IrZlZUWkZYc0hUdGRNc3VRbDQzU3pkZ2Jv?=
 =?utf-8?B?ZGJXdkFCTk1CYWhxQkRDa0ZGUHdZbFQ1bnZxUndpUFRNb1N0WnF3QStobjdI?=
 =?utf-8?B?WFRYNWo5TFdBMXFqQ1FLK2NFdjAxL2VUMGc2Qkk3ZVFhQ0dETWR5cFR3eEpw?=
 =?utf-8?B?YXpzUmRCM0phU1ZrWkRQcEFPSHFSZ1BYM3BIZTZqNnMvZHFkTWhvMEFDMnYz?=
 =?utf-8?B?S2t1eHd6U2lIaU5xSHVhZ3VzVkFhSDk4VXNIUGJyNFpieURmbDhxY2dFSXVN?=
 =?utf-8?B?bWt0OUZ0RjRVNGVzOXArTGlTVmRHOTdmK3R3OGdBbEVVT1kySmhiMis2aktU?=
 =?utf-8?B?MlNVKzFheUtGbWRWTjhJTUlxTEZwbUFXMjNWeXJacWMxbjF4Wi9Jby9aSXhW?=
 =?utf-8?B?UUFHUGs3Ry9MTnZsbytHSU5wSG5FNUZpanNUNkZDMmNHKzFtSzJyS0RwZlhG?=
 =?utf-8?B?V3NpcWxNajQ2WU1CY3llYytrbjFmQkFCU05nS0tTWk5EQU1mNml2b0VFU0JF?=
 =?utf-8?B?OGYraVo4SzAxQVdtQm9XS1Jyby9uQkpUWTdpdW9TRzhvYnhJbmVtUnVPSFd6?=
 =?utf-8?B?TTNmcGxPOUNjSVJwNXZiaWRYWWhqTnR2c1F3UlVLa1EvVjY3UWg4R1hxSVBm?=
 =?utf-8?B?dUJWdjcwdXAyNTQvSjU5Tmd5VTNIZ0hQa0lXQlQ4ejhOTXM3QWswZnFCSjgw?=
 =?utf-8?B?VktoL0hiTFdDNmlqeDFjd3V0aUlyTDdHUzQ3N2JDcXQ0N2NuZUwyTnM1aDRB?=
 =?utf-8?B?c0NkNTRna1ZyWGJYRmlZSGFuUElxK2VIOGhzdndrWkRFWCtMMWVCTW9CUS94?=
 =?utf-8?B?bHM0R3VldHFaWm9taE1hUndWMTltbEg4NGUvVWhPVjZxekZacHJRRkxUOXNC?=
 =?utf-8?B?TDJiT1d0WHFybHFWSHo3d1dES2tkQStHVHlSd1hGOXFjV2lzSm0xbDVhdW8z?=
 =?utf-8?B?eDRXZ3hZc2lOeDRtRlZzVlBkZEZwNWM3Y0NrZjk3aXNidkpTV2lXVk9zWHBZ?=
 =?utf-8?B?TFFaR3JwWEZBeERtRUROTWIwblRjdWdaeWtBa21BeHhqbEtnOXp3cDRVd0lx?=
 =?utf-8?B?cHVsbjF5bDlkNkx0M0tiUXpsNUVrSFNHTVA3VkRkK3RWVWJndFEvNWdhc25Q?=
 =?utf-8?B?TlVUL0wxbWVlMlVqUlgzaXV0cWtKeHZkTzlUQlA0SmlaU0x3UmV6SW5XYjR0?=
 =?utf-8?B?dHl6dE11TVNWZ0s5djVsbDhiVi91MW02UStUQWJEbjdvcGFpdVVHby9wUnRl?=
 =?utf-8?B?U1VDTi95Q0FpSmNYV2VmaG9JNDlVUkQ5MG5VaFJuQ1R4S21LeHlRMWZic1c5?=
 =?utf-8?B?ZXliVDF0ZStCakREc0llb1VSTDVPS043d0hTTnRzYVNOWUd1cFpBSnF0N1lx?=
 =?utf-8?B?RFljeWk1MWp6V3pZQ3l1QkxEaEMzSTN3ajVhUTBhL1VaL3BXdUZnd3ZvSFNX?=
 =?utf-8?B?M040U04zaWxWY1NoTlFEUitqTmhWcHhMSGlZRmdtd0tQRVZJSm81Y3MwVGY0?=
 =?utf-8?B?ekVaYU4vMGI0RUxkUzVlUFF2ZlNvbnA1cllUbllMQ1k0Nmk4UDhnTFdKQjQ5?=
 =?utf-8?B?Z2xJUk1iVE9oMFJvbmk0NVVVKzllYUlKajJnMllwdWRJSzNTbk4wV3VjdVht?=
 =?utf-8?B?UFQ1YmZoSHBmeXpVVVh4cisvZXJvZEpBTkFlOWVLZ0JsYmxqeldpQVVFQkY5?=
 =?utf-8?B?amdoOU90RTBKVU5WZlFLVVhZOVZtMytEblBmREZkR1lScFhMZjVHa2tsQUxS?=
 =?utf-8?B?K3hDZjFIS09pTkFZaDREVG1IREtXenphSS95RlczSlpmVHd1V3Z5cXAzbHh4?=
 =?utf-8?B?MDBhY2ppb2dOR1owN0RIckFjMVViTGo0L0VBQmxHNzFXQXVycDFxUmpudUti?=
 =?utf-8?B?bjJ1eGtuMkJDVmUxODRSaENPV0c1MzZRQkdVaHE5TktQK05yNENmekcrN1Nj?=
 =?utf-8?B?dUlvdlF2K3I4S0dIOFFIWjhHcmNRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a750ff-1272-4684-c18d-08dd895adf68
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:22:34.6755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMrbKFaGkKXb7KexvL+gSvF6d9b/9bbmNdNUIXelsqm0YtjLbE7dqD1lo/yzsLwDCjoAld6rq+Y16rXN3DIN43evlNVRrl1l96a5VeZ1i6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8893
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3MyBTYWx0ZWRfX7U6cw+W9p+I+
 3Cv+E0iAMop5a4UzLu76Rz0vNMK461MJCbIiT4HMijH4a0/J44ahuIszIjZyvE6Kt85RV5fMei0
 P9+wIXOoO1rlNJGRpV7EYt7w5TbZbMOPFoatNa/Nnepg64fj/edbhBZLSbccbPoDlN1HPPzLW75
 k6RPijG699HduKqsYvVDHauh8OWtWs60s35CoBsurs/LwAxP/hEZwhjrqq6ZeK4j5/CYii6T7OS
 IFwP2Lo072IyWalvZNKZGZf04UnG7J/1ChUloSSiaaBYVL4QuOVnzuDhp14Pp1D6QZxRwVfrzro
 B3SnAENGK6mq/zUR9fjUEgj6iinwQwq47RijyE7gR256yD/k134SiPEau2ia/X9bhb5OXMm0CpO
 b5UEzFe++oExt8BwaWlwEmiB2bJetkGBJjbZ5ms2gjlFKPh1ibwbX423fwpylBIS4pvR8+S2
X-Authority-Analysis: v=2.4 cv=MNVgmNZl c=1 sm=1 tr=0 ts=68148edd cx=c_pps
 a=dbfzVNK0jQbpEhEqKt7tuQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=UAXzGZX6NWqAfFX32GoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TshNC1LU4Be729tKMVC4b9jcOHH8WG5f
X-Proofpoint-ORIG-GUID: TshNC1LU4Be729tKMVC4b9jcOHH8WG5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:

> The hw_compat_2_7[] array was only used by the pc-q35-2.7 and
> pc-i440fx-2.7 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/boards.h | 3 ---
>   hw/core/machine.c   | 9 ---------
>   2 files changed, 12 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a881db8e7d6..77707c4376a 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -838,7 +838,4 @@ extern const size_t hw_compat_2_9_len;
>   extern GlobalProperty hw_compat_2_8[];
>   extern const size_t hw_compat_2_8_len;
>   
> -extern GlobalProperty hw_compat_2_7[];
> -extern const size_t hw_compat_2_7_len;
> -
>   #endif
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ce98820f277..bde19a2ff67 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -266,15 +266,6 @@ GlobalProperty hw_compat_2_8[] = {
>   };
>   const size_t hw_compat_2_8_len = G_N_ELEMENTS(hw_compat_2_8);
>   
> -GlobalProperty hw_compat_2_7[] = {
> -    { "virtio-pci", "page-per-vq", "on" },
> -    { "virtio-serial-device", "emergency-write", "off" },
> -    { "ioapic", "version", "0x11" },
> -    { "intel-iommu", "x-buggy-eim", "true" },
> -    { "virtio-pci", "x-ignore-backend-features", "on" },
> -};
> -const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
> -
>   MachineState *current_machine;
>   
>   static char *machine_get_kernel(Object *obj, Error **errp)

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


