Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD401C71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 08:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPzsu-0004CQ-Hb; Fri, 13 Jun 2025 04:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uPzso-0004BJ-J1
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 04:35:30 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uPzsm-0005zp-3E
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 04:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1749803728; x=1781339728;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DZwJSQv6wSPUAAPQwpg6HQJWipeu6R4legi1WhOSmAc=;
 b=Rveg7WuZgibX63P8MXPn5j9pbtqcoC9+TlxP/VnPHjJX0PCXRzlX7MsZ
 uFWH6aXVntnglTfw6Pm733GITm83Ak8gKJKuzACJMCLOpd5WsyRY9Z2kx
 tHXaQwJP1QEd3PXjAfiISfl8F3SNeFkCKr1V5QtjTSezZFMw8pjsLYL87
 nvol5vFvMzbtG6FsLns/Qbe0YcwWqK0IfCSKLdrFGTudfAfBXzmAVbvYg
 aA31wsdYiDjI88JzB6jbvnBg+eayBZxLVfmSHBtxuFgc1Hni3lxb1NYTB
 t7k9/L79gGmEdn4EqNShyPaM+hcJjm8ExmeX07cUKB1eTdjF85e1rrV7d A==;
X-CSE-ConnectionGUID: VR3dyDjtSGeugIpscdL3IA==
X-CSE-MsgGUID: JWqg/zDrSoSZcJZLuIspEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="158648180"
X-IronPort-AV: E=Sophos;i="6.16,233,1744038000"; d="scan'208";a="158648180"
Received: from mail-japanwestazon11011060.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.60])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 17:35:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJtUy9VyF/4MAHmOin2uF0Z5+5TpHDoy/KHBMsdYhYbIJrkYJUY+b0ozyCh2Keh08yWMEi214CyInMWmChqvY4IWkgvur4m2qWPKz0E1lCBjX2acSiT8/cRyuGVG+SY8d2QUMvZJ2/03CJsKau68QNNUICzJ6mPAeyH8w4eWh17swD4wH25KBws2E+8cq8dg4ZmCIrR2t75PlE6o9/Z+V0z22SiWyMiNeCoryTcNHX6wHR4rU4ZzZ+m6WL10cWYsUu+pG09OHe8xKNAqa2aJ5ZJH7vZG2EZRXtZa8T81LCVl8RGfy1ZeuF3IdLFhrazdNAWvXlB+jasTiapMQAGNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZwJSQv6wSPUAAPQwpg6HQJWipeu6R4legi1WhOSmAc=;
 b=v5N2SSZWrrf5DO1/fq9NDvGce+SlGnZOgX4fMIp5v6UI8xpCRG3SQA+xGeB0SEkzLHuktEFmp0RHKn174ecLTRMh0Phuq4G/9y6o/SwxBkMuRdudsyFenwaROlQPVmZ3148MX41XTAPglrVyX9/sQLNadS3S9/KhitIjqgENuGXkUlxz/Sdtz8ZOXFjrkiqEUL1SPWhUaTKxSPIbBRuo3ZlghmV1+CVOunX205pHpPB9R3JUKj3+78hJgGu7ltI/pNs5oysvAonDmo1qrVac4tCVLsLfkavPBj5IUTlJBuP89zXoiFgsqUbJXPZacpSib4cpccnNdxrY5Cl5xqhtbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY3PR01MB9917.jpnprd01.prod.outlook.com (2603:1096:400:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 08:35:17 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 08:35:17 +0000
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>
Subject: Re: [PATCH] hw/acpi: Fix GPtrArray memory leak in crs_range_merge
Thread-Topic: [PATCH] hw/acpi: Fix GPtrArray memory leak in crs_range_merge
Thread-Index: AQHb3B1A9EeE99KDHEGOLQzWa2sY5LQAvCWAgAAHzIA=
Date: Fri, 13 Jun 2025 08:35:17 +0000
Message-ID: <aea50ab7-5a96-4d22-9038-b88a7154bea4@fujitsu.com>
References: <20250613044002.106396-1-lizhijian@fujitsu.com>
 <aEvcOWsugIZjCKzo@redhat.com>
In-Reply-To: <aEvcOWsugIZjCKzo@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY3PR01MB9917:EE_
x-ms-office365-filtering-correlation-id: f4dda8d9-f4d9-4dd8-0ba0-08ddaa55399e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?azhJNDZSTXJOdTBjQjNHNE1qaFNLTWZjNnNJc3huSXFqbzNoYXZvaWN4SnZJ?=
 =?utf-8?B?NUtJLzM2Q0pZWU5BcEp2eDd0emU2YU5XK2k4OEJacU5tVGNPTVoycUZrOFJ6?=
 =?utf-8?B?UnZtWkJMbjNUd0x0Y1h1cDVlOTNDajk0SnZLU0JzeHNyaS9SQUVvTmdSWWlQ?=
 =?utf-8?B?Qy9YZmE2OE15aE5JRzRZYjRlV0ZtcXROVWhXd3NkT25US3FMQmZHYVBwa21x?=
 =?utf-8?B?dDNHTWxIOTZXT2tZKzYwcU9DTmZNRm9LNkpiVFUvQ3VSNzdYVnplMkx2NEF2?=
 =?utf-8?B?SFlwY3cvcUt1VElFdGxid3FXWUs0aTNKWmsxTndVSXJZYlZzc2FiYUlrQXRT?=
 =?utf-8?B?NWJZbzNWREdlTDJQUG41Vk9WWmFEb1RBMEk3WWk1ZGIzWHFxbVB0WlNqeWNw?=
 =?utf-8?B?TnlMVzMya1VNWmc0bFJpV25HMlBNbW80WDhnSGpzcDBrbmhYRTV0NklGamxq?=
 =?utf-8?B?SkcrWmRRMVpROU5kcVNtek5uN0x1NHBYeXJVZU90VFEvQVJhajZoZ0JlSWxl?=
 =?utf-8?B?VmFWVFEyeUZYOXdwcU1BWFVzdjRqQWxsaWFOT2ZIc0FpTzJLYkx6aDdHc2Vx?=
 =?utf-8?B?WHZiVC9JbHR5a1ExbGdnYlFKQy9JcndjYlVlK1VjMFVBSkhnYlI0UzM2V3la?=
 =?utf-8?B?T3RSLzlBb1hua1JCWXNSTmVvaC9hU205VW8zVjE1dktWNlA2SnV4SmxjNDBl?=
 =?utf-8?B?M01nQW1PZDBwazlNbFZJVHRoeEZTMXlkVlBXMkdpYStVOElHSGRnK2NmclJn?=
 =?utf-8?B?ek1IZmphYW5KbXBxNDVMVzhOYjFJd1hRNS95M1F6TlIyTU9KSzZEUk9zenFM?=
 =?utf-8?B?bnVKZFB1SHJqNVQ3R2VRM0Y4djFDU3dIOXFucVR1NnFqQTdmTXdwR1lqRURI?=
 =?utf-8?B?WC8remlVazFnSTV1dTRrL3hTZTlPL2dibEEwUkxhZU1vMDlLWmJKSHlzMzVQ?=
 =?utf-8?B?RWpuV2lDaUkydjNvL056SklxVmRVTUdESWpPMmc5ZFVjbGhkNGY3U2ZEUk9t?=
 =?utf-8?B?cDRvSWVsR2k1Y2l0OThtWExIS0NUNTJkc2c1QVZFYXpWS1FURmhqMHVmc0JT?=
 =?utf-8?B?Zm1oL2l0YjhFQ1VYMDh6MytxMmE3RnZvRTI0aVhWb0p6R1poMXN0d2pmNVQw?=
 =?utf-8?B?QmxOd05WaDFGWUloVWdPVEN4dWRBbVUzakRyNWRpUThjRnRzZmlOc3NFdnVI?=
 =?utf-8?B?U3VCOUZJS1NDN0tsdE4zUmxFYXFWQTRVNlhpSGFHUmhGNS9sWEwvSmR3cGh4?=
 =?utf-8?B?b2V1Zkw2SzBCSGJiNmo1d0V3Nk5XZTg3RHpCbFNWejJpTGVacmgzZ0FrRnpw?=
 =?utf-8?B?VEVCZU9kekl3SmhSWjRxc09JK1JEY3dibDFPYVY4MTE2OXNvVjl2bHF0bTA3?=
 =?utf-8?B?V0p0eTd2b1JMR1VNalpJa2hGb3FLS0xRNElBSnNoc2prakxlN09rUmtsRFRt?=
 =?utf-8?B?N2dBUjZKcmw3Njl5aENRejZsMzRrUElSdVltdjJydkVtWjBhVkp1UW1Ed29R?=
 =?utf-8?B?VUo3bEpRMGl5SzZCaEtnOUVTbUZSKzdTK0hjTWlpbVBwNldWT3JKSlRhaXdB?=
 =?utf-8?B?Njd6aGJmcUZwbHc0UUxPcUVtS3cxY0NxWTJCUnJwNkFGZ0hkLzdXNXhQU21D?=
 =?utf-8?B?K25mS3BMa25zNjd4bTdjbGtvYTl0SUhuRHJXZ2lKbk5TWEp4Uk03MXN6b290?=
 =?utf-8?B?ejEwZlNGeXU0YnNndlk5YWZyTzdvRGdZZ3JxUXhIVnA4Q1RFNFErMU9iY29U?=
 =?utf-8?B?OE1KVW1MWHU5TjIwalUvN0NVNm5JTTdsQnB6SXp2QXltelBCTmRCSkRqSGVZ?=
 =?utf-8?B?QytBYWM3VHF5VEg5NmhWek1sR0ZqdEo2bk16ckN6YXUxdWNnUVRKVUdqRXlV?=
 =?utf-8?B?UFdTcGMwV0QvdXNZdVJ5SFU1bERncG13bGpYTENLcXdNa3g1bytwTTNKVThz?=
 =?utf-8?B?R3dGMmhyY0dWNlUxU0NoZWRSUjg0R1BQL242ODVsRUIyL0xZSWFrUm1adC9C?=
 =?utf-8?B?ZXpvZDNDT3R1U0M2MVNxQmE3SkYyMllxVm5lWVlyMWJPakZ4T0laVnFQWlAv?=
 =?utf-8?Q?stRkSe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NENxb2FvaVdGajJCUDU4NmJBdzBGSEY2SmMzTFFUeXphUzUwRnRZaVdja0pM?=
 =?utf-8?B?YmEvOHdUQWFpVXl5blJYT2d0ZWlRRlo2UlZsSlFKVHVVVmM3UEhBRlVNOHNm?=
 =?utf-8?B?bWNlOGZqWTJzQjNRam4ycHlIRnR5blB4N2M3WEdnY3RKbzNpTHBLK0h3eTMr?=
 =?utf-8?B?QTBKTml6TUVvT3p5QnY1dVBMbVgzams5b3JGblY3NmZVbnVncS9hTUdIRTY1?=
 =?utf-8?B?aXlScVJOMlhKTG9zSzhHUjRLYWdOZjZDM1ZRUWNKTlZUREY4YUZDR0pVRmN2?=
 =?utf-8?B?aG5zNkNmYk0waWlJRE9oUlVFamRCOUFPOC9vNXZUMmYzcE9yZFVwRmtYVmJ5?=
 =?utf-8?B?TjhNdHRpZms5VjlOa054ZlpRc3h5WUZCVFRXbFRJVUUrQU04Rk5rVzhjcnFv?=
 =?utf-8?B?dHFYZEl1MEwxMXVIYkVvMzg4Ym44Qm5peEFYVThtQTB0YlM2STh1aGh2ODF0?=
 =?utf-8?B?SG5wZkhFWWRYb3d1N0VCWUNNOTVKZENDTWJWTjhmZWxXeW84amtUVXp4ZjI3?=
 =?utf-8?B?aytpUkVxdlBaM1ZOb2NyaUZyNUJ2dlh3K3I0R2N6SUpoSzJRUjYzOGoyWmk2?=
 =?utf-8?B?N21iMzZTZEZib2VnY29GM0YxWDh6MG5VbVNLQnJEd1B6cEFGY2tJSFZTanBp?=
 =?utf-8?B?UDFxeVVKbS9jdW5uaUZSc0dwNVhsZ0tYTHdRK0VJbmNCVSs1YmdMKzNWdGly?=
 =?utf-8?B?cm9hYTB2cEtPN29SeVpYZ01VWCtnYi92UlpjaUplbXg1Nml5NmZyTXNpZThx?=
 =?utf-8?B?V0krSTNYUHJrZTNIbmI3ekYrUStQTk9KYnl3UHRKc1o2WXE0MjBSR0dhdVpn?=
 =?utf-8?B?YkVNV1llOTFPNGdmcGpXbzdvNG9tSGpFTVBUR3M0cUhZUHd0RmNNU0VxVzJJ?=
 =?utf-8?B?QkVwKzFFUWY4UUZ2eDk1VkM5bWZCckV0ZHRFQWJMVytCTzI3cVN2Y0pUK0Ix?=
 =?utf-8?B?NGhDRSswOVF4aWNGQkZnenZVdmZJQ2F6b2Z5dXorS3EvVktoTWJ6R1ZINWU3?=
 =?utf-8?B?SEJTSmNJNFVIMFJOQ011RHg5TWplaFAwcklzNUdaYlJrV1Rac3Y5SFAvWGk4?=
 =?utf-8?B?OVZ5dDhJeHdEWmxyV0dNd0p1VWZEaG1SM29pZEtvOVBNMkRnMklTV2xRdmpQ?=
 =?utf-8?B?eWtmbWlubUpVTXk3YUN5TE1senRHY0laM241Tm96THpiSkZjb1FPVDlKVUth?=
 =?utf-8?B?RlVPQUlaWmNjOUgrcFVmOUlndzJmUi9zYmIwUUxQZW4rZEd1aWNXbFlzQnV5?=
 =?utf-8?B?UlRDUGFhOTF5eDlCYmp5Rkg3bVZrM2w4bHJ4K041WHFhbEYzL2sxREY0aU9y?=
 =?utf-8?B?Y0w4WHRXWGZNbU0xeStmVjE5bzNzTGlGMFFUUnJEREFXVGV3SHpwTzVGTjRV?=
 =?utf-8?B?TkNjeFRzczYya2hPUGo0TlBTM1hmRnNUQnFMVVpkOXoweDJzYUY2UmJUSFdF?=
 =?utf-8?B?V3hZQVliYTNnV1dwV0xwVk0yTU12KzdYdUFITzVyNEMrY0k2N3d6eWMvaEpx?=
 =?utf-8?B?bnZaYnl2Q0hoWmgyamZsNCtYVkRWeVhiTmU5dE8wankzdXhzR1k2WXJGNjZr?=
 =?utf-8?B?L3lsd3h2ZkdCWDQ4WVNVL2RKdjZtdkJLZVQwWnZBOHJjVTFJVERHY3pYYll6?=
 =?utf-8?B?cHBUNm9TY1lNUGx0Q21sM2cxbDNHMG8xd24yZTJJY2tYNmRVTVNmMUFTNHZR?=
 =?utf-8?B?U3NFa3JzK2N2MnRQM0lzWjgrSzZWM0I4L21UUUV6VHVkUHYxMVp0bUd0Nzk0?=
 =?utf-8?B?Z0FTQVVrdWR5endWTE1ueGVxcHZlRm50a3VBbXFlUEFoWldHSUVCL20rL0Rr?=
 =?utf-8?B?bXN4QW94c1RkeXp0YytxTWRzeG9sc2k5M2J1WUo3cjBNajcwZUcvM1U2UjBq?=
 =?utf-8?B?QzUrTGYvNCtENnhYKzdTUUlhZ3RweXg0Qjg3QWlINTE2RjJQSGh5TG1nVFJL?=
 =?utf-8?B?RzVpTkZYNDdDRXFQZmZ5bC9TUXZBREU0NUZBdE5UeUZjaXZBQnRjbm5ZdUhQ?=
 =?utf-8?B?L0RVdjEzeFJJWXQxTnhTWXpHQmVrNUxYazNxZG9NdDJkMnNiVmdZRzA2WlNq?=
 =?utf-8?B?ZkpqZnJQUTQyRS93dWc0ZWN5MW5lYUxIZ0ZJamxTNGUwVlB6Njg0QWcyNHVv?=
 =?utf-8?B?RlJOYnZINVlXdG5aK3lnRmhsdHduUnJnVHcyaUZ1VzJ5WlRGSWhDQmtrb1d1?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65B3CE4ECF7F8D45A53B82FCBD6CF2E9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1hv08DbDP6lFvvD4PqO/d7QHvMS++pKbkbDcQ5xiCBwuuydlCVW8SAnXKKvzSsjfGPg7nbNAlxyznY4+dxd/jabp6RbnjIO2Gy9OgKypPjOASgj8JXGcJIqmwGQH73mNDAr+e89eBydRF9SIv0Icn8Him7zHbQWE3rXCl4wjqPT7ukpxyThvCGyUDeuHoHx3RDgUSRjqQcLrS2pJDk+E1J5AVnCoEaSS9gfNkugm9keaav08VC5F6w8/YD5X+8kNCZ5joQd7VvMu8UjonnkcJKXiS+dXA9df77ujANpAlAk4R/5GPI5w69UNPTbU4m0NaspZxR+xSstEAXqrB0vJyOBABowoS7aEfu9/CYIfr6UmKCauV4iuYgfX5fRk7/b8b7XUgaUHs4a1kROeMJ9ViBH1rQsnfMjygZ7ikHSZ8+02pt41+zp0IUz6TwBr+dnRwOtCkmy0xMRDHYs2vSahGNVUubgin1PfszXT8hit2cyaz31ACc6IpfVCJnDyPML3gE0dQe/Vdeq84ITM4pVxqBih2iuo7+Yf0bJ2h9M9DKMmCOFQ6cqs08vi0JAAkzeHgpyHs5LBij8wgYgMyoafoHNSxFPewj1ssDw1lorrohdhaL71hiNrbE45cIQPFrHe
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dda8d9-f4d9-4dd8-0ba0-08ddaa55399e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 08:35:17.1616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTk0cR6iqIrhKgHlWbxKzcXxnTnk8DCiGqQ7e0xHeW9HCxjVvLWspKP64RR6cVuJo/PoYJleCR1bNrzqMdvWBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9917
Received-SPF: pass client-ip=216.71.156.125;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDEzLzA2LzIwMjUgMTY6MDcsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+IE9u
IEZyaSwgSnVuIDEzLCAyMDI1IGF0IDEyOjQwOjAyUE0gKzA4MDAsIExpIFpoaWppYW4gdmlhIHdy
b3RlOg0KPj4gVGhpcyBsZWFrIHdhcyBkZXRlY3RlZCBieSB0aGUgdmFsZ3JpbmQuDQo+Pg0KPj4g
VGhlIGNyc19yYW5nZV9tZXJnZSgpIGZ1bmN0aW9uIHVuY29uZGl0aW9uYWxseSBhbGxvY2F0ZWQg
YSBHUHRyQXJyYXkNCj4+ICdldmVuIHdoZW4gcmFuZ2UtPmxlbiB3YXMgemVybywgY2F1c2luZyBh
biBlYXJseSByZXR1cm4gd2l0aG91dCBmcmVlaW5nDQo+PiB0aGUgYWxsb2NhdGVkIGFycmF5LiBU
aGlzIHJlc3VsdGVkIGluIGEgbWVtb3J5IGxlYWsgd2hlbiBhbiBlbXB0eSByYW5nZQ0KPj4gd2Fz
IHByb2Nlc3NlZC4NCj4+DQo+PiBGaXggdGhpcyBieSBtb3ZpbmcgdGhlIEdQdHJBcnJheSBhbGxv
Y2F0aW9uIGFmdGVyIHRoZSBlbXB0eSByYW5nZSBjaGVjaywNCj4+IGVuc3VyaW5nIG1lbW9yeSBp
cyBvbmx5IGFsbG9jYXRlZCB3aGVuIGFjdHVhbGx5IG5lZWRlZC4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgaHcv
YWNwaS9hbWwtYnVpbGQuYyB8IDMgKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvYWNwaS9hbWwtYnVp
bGQuYyBiL2h3L2FjcGkvYW1sLWJ1aWxkLmMNCj4+IGluZGV4IGY4ZjkzYTlmNjZjOC4uY2YxOTk5
ODgwMTE5IDEwMDY0NA0KPj4gLS0tIGEvaHcvYWNwaS9hbWwtYnVpbGQuYw0KPj4gKysrIGIvaHcv
YWNwaS9hbWwtYnVpbGQuYw0KPj4gQEAgLTE2MCw3ICsxNjAsNyBAQCB2b2lkIGNyc19yZXBsYWNl
X3dpdGhfZnJlZV9yYW5nZXMoR1B0ckFycmF5ICpyYW5nZXMsDQo+PiAgICAqLw0KPj4gICBzdGF0
aWMgdm9pZCBjcnNfcmFuZ2VfbWVyZ2UoR1B0ckFycmF5ICpyYW5nZSkNCj4+ICAgew0KPj4gLSAg
ICBHUHRyQXJyYXkgKnRtcCA9IGdfcHRyX2FycmF5X25ld193aXRoX2ZyZWVfZnVuYyhjcnNfcmFu
Z2VfZnJlZSk7DQo+PiArICAgIEdQdHJBcnJheSAqdG1wOw0KPiANCj4gSU1ITyBpdCB3b3VsZCBi
ZSBiZXR0ZXIgdG8gY2hhbmdlIHRoaXMgdG8NCj4gDQo+ICAgIGdfYXV0b3B0cihHUHRyQXJyYXkp
IHRtcCA9IGdfcHRyLi4uLg0KPiANCj4gDQo+IGFuZCByZW1vdmUgdGhlIGV4aXN0aW5nIG1hbnVh
bCBnX3B0cl9hcnJheV9mcmVlIGNhbGwuIFRoaXMgZ3VhcmFudGVlcw0KPiBpdCB3aWxsIGFsd2F5
cyBiZSByZWxlYXNlZCBpbiBldmVyeSBjb2RlIHBhdGguDQoNCg0KSXQgc291bmRzIGdvb2QgdG8g
bWUsIEkgd2lsbCB1cGRhdGUgaXQgc29vbi4NCg0KVGhhbmsNCg0KDQo+IA0KPj4gICAgICAgQ3Jz
UmFuZ2VFbnRyeSAqZW50cnk7DQo+PiAgICAgICB1aW50NjRfdCByYW5nZV9iYXNlLCByYW5nZV9s
aW1pdDsNCj4+ICAgICAgIGludCBpOw0KPj4gQEAgLTE2OSw2ICsxNjksNyBAQCBzdGF0aWMgdm9p
ZCBjcnNfcmFuZ2VfbWVyZ2UoR1B0ckFycmF5ICpyYW5nZSkNCj4+ICAgICAgICAgICByZXR1cm47
DQo+PiAgICAgICB9DQo+PiAgIA0KPj4gKyAgICB0bXAgPSBnX3B0cl9hcnJheV9uZXdfd2l0aF9m
cmVlX2Z1bmMoY3JzX3JhbmdlX2ZyZWUpOw0KPj4gICAgICAgZ19wdHJfYXJyYXlfc29ydChyYW5n
ZSwgY3JzX3JhbmdlX2NvbXBhcmUpOw0KPj4gICANCj4+ICAgICAgIGVudHJ5ID0gZ19wdHJfYXJy
YXlfaW5kZXgocmFuZ2UsIDApOw0KPj4gLS0gDQo+PiAyLjQ3LjANCj4+DQo+Pg0KPiANCj4gV2l0
aCByZWdhcmRzLA0KPiBEYW5pZWw=

