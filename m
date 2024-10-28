Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F58BD13570
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 06:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5IxD-00010w-Qu; Mon, 28 Oct 2024 02:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t5IxB-00010d-G8
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 02:10:13 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t5Ix8-0005Ac-TQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 02:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1730095811; x=1761631811;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JU78l60Edzz5NLlCdnV0zhMWz4l4KE3UvOh29+JdAiA=;
 b=fCsyt11wFwqBIpYgl2pNp4YJs+m/JAcclBUzHHlM4BDD803di9f9OwlC
 pC2NsnbnXOf5QYfpBCHGMDIEufeenf7M+kjOi28yiKCvXY3eyPCp7Ci9V
 4UvSEK2Vpmw/d66NqJvhuSTM+MYeO5RJE8C23/vACY7vaZTDP7igzYgdh
 eav6oAhFLGJdTxPeEzTBWx7PClweDfhEDYCmw2ffeLjbWjeet+RVPsu4F
 BRukOT4D/s6GFo4Q8BhCQPyVqmQZBf2PAEBa8ahdfWuxP7xRSkMkQWvMP
 TZ6beebHCZT86kxCKUFuyB0fC7odWLTD5Gu6dFQTq7stQToSpj8ejYlgP A==;
X-IronPort-AV: E=Sophos;i="6.11,238,1725314400"; d="scan'208";a="23212240"
X-MGA-submission: =?us-ascii?q?MDEvdhjtHZvDWqYpLG7fZaYNW6MDMV1OTCtwUX?=
 =?us-ascii?q?zywTRVPtQ3/XxoHIbXb093RxW2FdPIwdrK2SP9I7p+M1FAACD8G5RV3X?=
 =?us-ascii?q?DuXRABHeWNHHzoUQiiSXrZR2p98TmEKbU77bvQr3dd3SNKnd13vfXsl5?=
 =?us-ascii?q?JYTXDQ2Ry6BG9qpnQXhv8SGQ=3D=3D?=
Received: from mail-db8eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.106])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 07:09:48 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3+73pQyj0InhXQ1yC5Cxdy3ohzwCMtYVU1C1fVCVndBXX6HaUBOIjYR3FXHeWpVnJq2a3wJHfVCkMd90YVGhE6EAJiboLcvvHP6EyAea6dnO/KSqKgz7cAmNGOioMhmKfG/dCaV2HGYkvmeoiot/0a1e7NjwnHp/yC4OcMQwXmi0uD0Z1hOhgVeugsJwj1uiFDnq/W7QWsjdJILFDdD3s73EvxVoPq1R6YQ2k1Iv70jx4/DvtGYVUePIi/O3yI3aArKEx18PeL9o+jVWXEL38LEEE/6IE4Iw+0KkDg0KSWNbI2S5BxKx9G/JR3kax4FRNWthcN+F8OY53PPOlzdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JU78l60Edzz5NLlCdnV0zhMWz4l4KE3UvOh29+JdAiA=;
 b=wLEZ50jM+tb3BtyPliYFWiiChB2ZNgnlMuzRooLtEoC7A78dxWwscZHl3gaqvgtdWGjR6DxWF2MgW9wHhi2eGXwzUfhHcXter7gyZKwBiHOQRZwzucHtkQrrnA99sxuyFSi4tJ4p64c9gspFO0x+2LiMAVotcB0kcdLOB6QcHTB60apaQI3jS/+vD0G532slVZT/GcDvwXxRiiP9tFTtInbF7j1J3Op6Uxi4ERSoycs1xT9alXrFNj4UXtU/0Pjoqj13jdVP+Yzit1RnOW1YzLYvllRzlznjot1BmcHrYvuxCKkIEsrcztvkblgvhKv9Qp8ULJxgZr2p43f53F7J9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU78l60Edzz5NLlCdnV0zhMWz4l4KE3UvOh29+JdAiA=;
 b=RNJHt2erR3dPLkMPMNjeb2RTkCMd82Dvo9cXis9I9BXjeHAAPvIIv0spo/bLePrZh7aQ6EtMI1aarK7jWlGdwd4avvX4hnkUDg/mcdgigEzmMIUYuN/tRa2MEN9qX3eAo4KBu1XbDkl8PTxDjmdOouVMTE0mTI2tFQPEHqHQZ4hHrlVq+rTx839ifXMVB5IJjMUJeoyoQCANOKKRYyrxvom4NxPMetqfQqRHjXiUBF3b+SpC+ebB7bm8kxZitmhgDKlsMe9ikXVo/v3B/bh4RLcutiV7SRpbh5XZvn//vnus0L6XHWyR5pzkMLvyXW/+4s/ay+2s0qQT/f8yxCZTnQ==
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com (2603:10a6:102:c0::19)
 by VI1PR07MB6637.eurprd07.prod.outlook.com (2603:10a6:800:180::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 06:09:44 +0000
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393]) by PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 06:09:44 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "chao.p.peng@intel.com" <chao.p.peng@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5] intel_iommu: Introduce property "stale-tm" to control
 Transient Mapping (TM) field
Thread-Topic: [PATCH v5] intel_iommu: Introduce property "stale-tm" to control
 Transient Mapping (TM) field
Thread-Index: AQHbKOEQC+g/cRUI2U2QiXAWyOF0UrKbrjOA
Date: Mon, 28 Oct 2024 06:09:44 +0000
Message-ID: <847ea5fd-b977-4d38-ab04-cb39ddf9d85e@eviden.com>
References: <20241028022514.806657-1-zhenzhong.duan@intel.com>
In-Reply-To: <20241028022514.806657-1-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7613:EE_|VI1PR07MB6637:EE_
x-ms-office365-filtering-correlation-id: 5b9bcc39-b0d9-4e5d-d3de-08dcf7171e7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RXhlNm1LWCtHVWlJcU1hU2VhdGlwV1JyRzlteVZGbTJBayt4WmJ6bDRkYktz?=
 =?utf-8?B?WE15SjEzeXFPUi9IV0J0Q0ROdGpTQ3ZJOTZMWVI4TEJHNG5HRHNZejArNXZU?=
 =?utf-8?B?a0lDenVxTDRqTU5icStqYzNOTTZKS3p5b01pMkhqNWRhclVHV0JybDdQd0hp?=
 =?utf-8?B?M3VheGUyOWZhZGhoM2Mzb281MVRQOWJEcTRFZUJxdnFqOEkrelFpQWJ5bGpv?=
 =?utf-8?B?UEFKUnhnM2FFQnNndzR0cVJjeWRHRUF0NzZ5RWE3cHYzTkx6WUNhSjFEMkNm?=
 =?utf-8?B?eVlWbDlQRi9YcENJT1B5aW8zSGFseTJxUjc2c1ZGUjFJVytsVmdRSEFES2pU?=
 =?utf-8?B?b2VFQ3JCamwxdmh4aVlDWS8xRXlYUWVWeWpXME5ISmdtcEVSVFdob0ZMNzBm?=
 =?utf-8?B?N0xibjh0QmhhMWg3T0ZCa2luQVRLZXB6cUI0eFZwVEhVejBrZVB6OXBkNUtm?=
 =?utf-8?B?L0thV2hQRE5INE9uYnRUUUF3Tm01Z3NIT0hHL1NQb2pXczQvSk1ROTdKSnpS?=
 =?utf-8?B?ak5rc0RNcWNNSlgwVlV2QkZkWFkzTi9mcEFrdWltY1pkUGlKZDNicWxFTTNN?=
 =?utf-8?B?MlFXZFN0ZE1SUGJTRTlPamZzWm5vdU5zMFlORHRJcXFnc2k0VFpmTXhIc1ZQ?=
 =?utf-8?B?cnZjMjJSV2ZEQTkyTklEWDdRWEdtcktjdHV6WU00YXpHWDVYOTlNUmxEb0Ev?=
 =?utf-8?B?S25Ed255TUZjMVVvb2dLRy8vSVVZNFVZbnNUb3ozdDJYLy93cGhMK3dJZWRl?=
 =?utf-8?B?djN2SHJxT0dod01ablFRenA0WWI5V0lacGs1NCthYnlpa2FNS1JhTVhwSHVU?=
 =?utf-8?B?aFQ5Mlp4Wkg1cWcwRkI1aklmV3JkNWJjUnpBYW9FTU8wTVNBV1UyQ29DbG1z?=
 =?utf-8?B?aUtoZk1KeFljbFBRYkhvZTNZUjhVWkg1SGZHdGhMbkdWZVJqWFovd2pNcnlT?=
 =?utf-8?B?RXU3ZTlIbm9jOVlPUnNYcVlIRDZVYVhVYUNEZllZN3FYZ2cwSkUybllnQWRK?=
 =?utf-8?B?WVFROFRVQWJXRG9udnB5WkhGSUFJQlV4WUhjK3NRNlJmSDBPN1lXdGFTWXAy?=
 =?utf-8?B?b29tWHVveWYwNG10L2VaOUdET0hUNlZXRjBRZHhBOHNneE1JUE5WS0w3dk5R?=
 =?utf-8?B?RnlHZmNIMTdQdmp1Z2s4Z1NZdDA1L3lhajdSM01oL05rNzZIRm5zdUtFSjFM?=
 =?utf-8?B?SS9DR2oveUpCcGwrQzRIT0J3cXNwdWZGQVBwZ3psL3I1ZkFKZjBidnJjcWNr?=
 =?utf-8?B?djROek5ZVHFCRW9kbVp6MnM0QlZ4MGt2ZUZvWlBQNGk4Wkg0QUtRZS9WU29V?=
 =?utf-8?B?NWF4QkF6THdGelBJOWlnRjB6M1BaRTBneWJwTXZXUUYyWkpyR2NRVVFHcFZx?=
 =?utf-8?B?SzNYSFdVN1lhQi9zcWRENGFCT1BrYU9aMERybXVLbTRjQk9zTm0zRU82MnhK?=
 =?utf-8?B?citrOUVOc1Y1TlNHcEw3dnJqOHN0c3RqQk4wcjdOdUZSVVpvMmM2SW9VUTJ4?=
 =?utf-8?B?cERhTU5VeDZOeUlIM2IyZG1ueFNCcWljc2t6RXFSVlMzSlRJWVJOSW1Ya0tu?=
 =?utf-8?B?enI4WEh5S3dvMGZiTEcvV0oyS0MvVFRtaWVTOEl3TE04anRxc0xpRURQc0w0?=
 =?utf-8?B?MndXQWFrcXU4L25RRTc2d2RNZzJMQXVyck56T3lsZHJDQnNiSWUxYnpLcWox?=
 =?utf-8?B?MzlRL3FDeWZWR25heS9vLzF2R1VLYnVrQ0Q4K3ZpZzZ4VERnTTlWN2d0c0R1?=
 =?utf-8?B?SENNSkNwaXJVazI4NS85cU5wUkVTbUcrRHQwTGxrR2hOTk80N2UvbkkyLzVt?=
 =?utf-8?Q?vpyY/eUA0y6bWrCa+h/c7EbkyA6kXvOiCxJwM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7613.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REp1b0ZqdFJEZkJXRzRHQkszbS9aZWhxaEdFRnFOQU1tdUwzZGZVZkl5c0Rn?=
 =?utf-8?B?SEcxa2RtbWUzRllSbTJtMHVuL1ROa09rTzc3ZVdlc0dxVFJwbndpM3A1Q0oy?=
 =?utf-8?B?NUJsVDg5bzNzQWpZeEg0bldKU0JsazZLSjUyaFR1T2I2VmNWRno2WDBnNDhS?=
 =?utf-8?B?ZEpQSnpLM3ZZNUhJcUw2dUEyTkk4Y3hTYzE4clBGUTBrbk1DeHVBeS9ublNQ?=
 =?utf-8?B?eVRZT2s4WkJ2Q0ZkSVowa2xoMnlpM1ZTeHJBaEJEVTc4cWRKNVo5V1VhMVFz?=
 =?utf-8?B?c1ZDK0UzNEM0VEpZYlpKeEtTMVA1VVR0S0xMQ2d5dGpWemIyNE5RRm5RTWdT?=
 =?utf-8?B?bGtlZG5JRmd5MkZRREhZclQwMHBodnZXenVsYjR2cTVRZ0FzVDJheFJxclha?=
 =?utf-8?B?aXRkK1BvYkxFdy9PMU0yRWExMWFQanp6ZjFvN2toVzNXem9FNHBlT0FhSHZv?=
 =?utf-8?B?R1Q3Y1E5SHY1VDVPM28xZFFhMWRaYUp4NXBXd3ZGQzR4VG10K08zOXVNSXNp?=
 =?utf-8?B?cDh3eXRtWDV3NWVtNG9kK3dURk9BSTg3UjRMN1hoa0krWE9LYmpPblNpS3Rz?=
 =?utf-8?B?QU8zNlhCcWdIR2Z0ajRNNWNlMXpZaS9nZURCYytlL1V4V2U5dEl4ZXpOM1gv?=
 =?utf-8?B?UzJPMmNrbmJpSVdZT1U2aEtNNnRiYzVsMytKRUVPY2lLK2Q4M0pqYVprNmRi?=
 =?utf-8?B?Vk0rd24zOWJvbmV2SFV5blhsWkpFcGFCZ1FSN2gzTDBYcElCcjM0VmRlMzJh?=
 =?utf-8?B?MitDL25jS1lITDgxWGk4Vjl5RnRIVkgwb3ByMlpWYncwNFhFQ3ZTclFleEZl?=
 =?utf-8?B?c1Z1RHY3ZmxvUnVKbU5aTkZCWHZ2QUpMMldVMVRtanpOc3FkbzhOZ2pZM1VM?=
 =?utf-8?B?aGJkMEpaRmtDa0lkc2pKWE1ZalJNbnZWZ0VOQlN6TVZZbGdJZ3lvMjdXMFRN?=
 =?utf-8?B?ZHM2OG45SGxzbWozeFRNS3haL21iRkliS0J4eFRTaGxHSkVJWTNpSk1FSVpY?=
 =?utf-8?B?RVAzeDA3aVhhcnBQLzVtTFQ2UCsvb0xsR1ltUEZFdDlzeTFIK1Q3bzNlNHlE?=
 =?utf-8?B?ZTJkck1UU1cxb3NTWlB3R0ZwMVNnWHJnb1pzZTRVbFVCQnU2d2ticzJvNU5i?=
 =?utf-8?B?ZFNwT2tVbE9iNjRxU3RTeEdVaTQyeStRYmFMYkgrdFluNit6dzh6cksvVWVq?=
 =?utf-8?B?V1NmNitsY280Z1VjZkxCOGZZODk5K2FNa1dUTTVFUVc1L2lkRWF5WTF6dGIw?=
 =?utf-8?B?TVFhejlPZFFWVGZOcklxTCtrWmZYN2JmQ0FSNXpwcW96M0Y1bVRjUXg3TXJL?=
 =?utf-8?B?dlhkY3piUFdJQkVSQUsrcEl1OXBhUjVUOVF1a2UxQ2x0eWFVcVFDb2dwbCtm?=
 =?utf-8?B?NndtaWJpVjVNRGozUHFPMksxK3dNNEVlVERxNUxmVEZ6RzNrTEpnR2NHeG81?=
 =?utf-8?B?Mk55VWJodE1BYWM5QitSY0dNQ21xclRpdi9GcHJvRS82N2JvdnI5SjcyZk9w?=
 =?utf-8?B?b0ZKNy9YdWxUcDB2KzhhT2c1c2dVSzNsTzQwK1BhQmg2ekJqMG8wSTM5Ykt4?=
 =?utf-8?B?NEhHSm1DOVpjUUgvZW1iSmovVVF2OHNiVVd6aWxTRzUwTGZMcy90TThrWUpM?=
 =?utf-8?B?QndEMUc1NXE2Y1Fzd0w1aEtyTit0NVpXL0FrMnVxOW50d1ZNMGdtTmRhS05L?=
 =?utf-8?B?VjQzdVduQWVnekhaeU5PNzZnaWdmaGFGb3VZU3NOdjYxWDBwZjVxNXFQM2VT?=
 =?utf-8?B?NkFlMkVSSW5uekhtQlk4cWJ3b2pwRnlrQ1N0ZTZSdHBESWNyK2NCd3JRYlpQ?=
 =?utf-8?B?aTBCODlvcWhZc1pnWEVZMndaZ0dPZ29hWEp3REhUUzlSby9PWkZDL3ZWVE15?=
 =?utf-8?B?bDJrZWh1TmdzbU1VRkVuYkFkNFY3UUYyUVRnZEhuRHlZN3ZJMUIrRW1OL0lE?=
 =?utf-8?B?TkF6NHFoOVg2bTNBaXMwc3Jaa1kxMVdVTkg0Z004UmhpMlVuUmIrYVM5dzFU?=
 =?utf-8?B?YVZ2VUZDbFhVZFFHY3h3dlRISmwyMm9rbUJ2QkpMbGtXbDlhczV0dlRQT0JT?=
 =?utf-8?B?RUNNY3FPN0dYU0xYYWhFa004djZNaHlIcWxCNW1GdWYrOTJjK0h5bzBFdHZp?=
 =?utf-8?B?ZUdETUp2VXF5SGZ4MkNIejltRXgrSDJ2OWUzUmZQcnNxWVVKTGFDdFVQcVdm?=
 =?utf-8?Q?JY0/zlPz1hsrd+GO2FT9Ggs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <359A16E25E84C849AFF29026A7879394@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7613.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9bcc39-b0d9-4e5d-d3de-08dcf7171e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 06:09:44.7523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epA13+DzFIhaBlc143gq6LgiRyuytE7gLoMKcr2C71VlYI3L9Cg/QhlWOXcctOvKMgUZox1v7rgKpYsfob7YhrjfvMgFKImC0/7X+KGbskOAyfsEMcgOS8hrxQwzo2ck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6637
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNCg0KDQpPbiAyOC8xMC8yMDI0IDAzOjI1LCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRz
IG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2Vu
ZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBWVC1kIHNwZWMg
cmVtb3ZlZCBUcmFuc2llbnQgTWFwcGluZyAoVE0pIGZpZWxkIGZyb20gc2Vjb25kLWxldmVsIHBh
Z2UtdGFibGVzDQo+IGFuZCB0cmVhdCB0aGUgZmllbGQgYXMgUmVzZXJ2ZWQoMCkgc2luY2UgcmV2
aXNpb24gMy4yLg0KPg0KPiBDaGFuZ2luZyB0aGUgZmllbGQgYXMgcmVzZXJ2ZWQoMCkgd2lsbCBi
cmVhayBiYWNrd2FyZCBjb21wYXRpYmlsaXR5LCBzbw0KPiBpbnRyb2R1Y2UgYSBwcm9wZXJ0eSAi
c3RhbGUtdG0iIHRvIGFsbG93IHVzZXIgdG8gY29udHJvbCB0aGUgc2V0dGluZy4NCj4NCj4gVXNl
IHBjX2NvbXBhdF85XzEgdG8gaGFuZGxlIHRoZSBjb21wYXRpYmlsaXR5IGZvciBtYWNoaW5lcyBi
ZWZvcmUgOS4yIHdoaWNoDQo+IGFsbG93IGd1ZXN0IHRvIHNldCB0aGUgZmllbGQuIFN0YXJ0aW5n
IGZyb20gOS4yLCB0aGlzIGZpZWxkIGlzIHJlc2VydmVkKDApDQo+IGJ5IGRlZmF1bHQgdG8gbWF0
Y2ggc3BlYy4gT2YgY291cnNlLCB1c2VyIGNhbiBmb3JjZSBpdCBvbiBjb21tYW5kIGxpbmUuDQo+
DQo+IFRoaXMgZG9lc24ndCBpbXBhY3QgZnVuY3Rpb24gb2YgdklPTU1VIGFzIHRoZXJlIHdhcyBu
byBsb2dpYyB0byBlbXVsYXRlDQo+IFRyYW5zaWVudCBNYXBwaW5nLg0KPg0KPiBTdWdnZXN0ZWQt
Ynk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPiBTdWdnZXN0ZWQtYnk6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFu
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+IC0tLQ0KPiB2NTogZml4IHR5cG8sIHMvaHdfY29tcGF0XzlfMS9wY19jb21wYXRfOV8x
IChMaXV5aSkNCj4gdjQ6IHMveC1zdGFsZS10bS9zdGFsZS10bSAoSmFzb24pDQo+IHYzOiBzdGls
bCBuZWVkIHRvIGNoZWNrIHg4Nl9pb21tdS0+ZHRfc3VwcG9ydGVkDQo+IHYyOiBpbnRyb2N1ZGUg
Ingtc3RhbGUtdG0iIHRvIGhhbmRsZSBtaWdyYXRpb24gY29tcGF0aWJpbGl0eSAoSmFzb24pDQo+
DQo+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMTIgKysrKysrLS0tLS0tDQo+
ICAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggIHwgIDMgKysrDQo+ICAgaHcvaTM4Ni9p
bnRlbF9pb21tdS5jICAgICAgICAgIHwgIDcgKysrKy0tLQ0KPiAgIGh3L2kzODYvcGMuYyAgICAg
ICAgICAgICAgICAgICB8ICAxICsNCj4gICA0IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gaW5kZXggMTNk
NWQxMjlhZS4uMmY5YmMwMTQ3ZCAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiBAQCAt
NDEyLDggKzQxMiw4IEBAIHR5cGVkZWYgdW5pb24gVlRESW52RGVzYyBWVERJbnZEZXNjOw0KPiAg
IC8qIFJzdmQgZmllbGQgbWFza3MgZm9yIHNwdGUgKi8NCj4gICAjZGVmaW5lIFZURF9TUFRFX1NO
UCAweDgwMFVMTA0KPg0KPiAtI2RlZmluZSBWVERfU1BURV9QQUdFX0wxX1JTVkRfTUFTSyhhdywg
ZHRfc3VwcG9ydGVkKSBcDQo+IC0gICAgICAgIGR0X3N1cHBvcnRlZCA/IFwNCj4gKyNkZWZpbmUg
VlREX1NQVEVfUEFHRV9MMV9SU1ZEX01BU0soYXcsIHN0YWxlX3RtKSBcDQo+ICsgICAgICAgIHN0
YWxlX3RtID8gXA0KPiAgICAgICAgICAgKDB4ODAwVUxMIHwgfihWVERfSEFXX01BU0soYXcpIHwg
VlREX1NMX0lHTl9DT00gfCBWVERfU0xfVE0pKSA6IFwNCj4gICAgICAgICAgICgweDgwMFVMTCB8
IH4oVlREX0hBV19NQVNLKGF3KSB8IFZURF9TTF9JR05fQ09NKSkNCj4gICAjZGVmaW5lIFZURF9T
UFRFX1BBR0VfTDJfUlNWRF9NQVNLKGF3KSBcDQo+IEBAIC00MjMsMTIgKzQyMywxMiBAQCB0eXBl
ZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVzYzsNCj4gICAjZGVmaW5lIFZURF9TUFRFX1BB
R0VfTDRfUlNWRF9NQVNLKGF3KSBcDQo+ICAgICAgICAgICAoMHg4ODBVTEwgfCB+KFZURF9IQVdf
TUFTSyhhdykgfCBWVERfU0xfSUdOX0NPTSkpDQo+DQo+IC0jZGVmaW5lIFZURF9TUFRFX0xQQUdF
X0wyX1JTVkRfTUFTSyhhdywgZHRfc3VwcG9ydGVkKSBcDQo+IC0gICAgICAgIGR0X3N1cHBvcnRl
ZCA/IFwNCj4gKyNkZWZpbmUgVlREX1NQVEVfTFBBR0VfTDJfUlNWRF9NQVNLKGF3LCBzdGFsZV90
bSkgXA0KPiArICAgICAgICBzdGFsZV90bSA/IFwNCj4gICAgICAgICAgICgweDFmZjgwMFVMTCB8
IH4oVlREX0hBV19NQVNLKGF3KSB8IFZURF9TTF9JR05fQ09NIHwgVlREX1NMX1RNKSkgOiBcDQo+
ICAgICAgICAgICAoMHgxZmY4MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERfU0xfSUdO
X0NPTSkpDQo+IC0jZGVmaW5lIFZURF9TUFRFX0xQQUdFX0wzX1JTVkRfTUFTSyhhdywgZHRfc3Vw
cG9ydGVkKSBcDQo+IC0gICAgICAgIGR0X3N1cHBvcnRlZCA/IFwNCj4gKyNkZWZpbmUgVlREX1NQ
VEVfTFBBR0VfTDNfUlNWRF9NQVNLKGF3LCBzdGFsZV90bSkgXA0KPiArICAgICAgICBzdGFsZV90
bSA/IFwNCj4gICAgICAgICAgICgweDNmZmZmODAwVUxMIHwgfihWVERfSEFXX01BU0soYXcpIHwg
VlREX1NMX0lHTl9DT00gfCBWVERfU0xfVE0pKSA6IFwNCj4gICAgICAgICAgICgweDNmZmZmODAw
VUxMIHwgfihWVERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00pKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggYi9pbmNsdWRlL2h3L2kzODYvaW50
ZWxfaW9tbXUuaA0KPiBpbmRleCAxZWIwNWMyOWZjLi5kMzcyY2QzOTZiIDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiArKysgYi9pbmNsdWRlL2h3L2kzODYv
aW50ZWxfaW9tbXUuaA0KPiBAQCAtMzA2LDYgKzMwNiw5IEBAIHN0cnVjdCBJbnRlbElPTU1VU3Rh
dGUgew0KPiAgICAgICBib29sIGRtYV90cmFuc2xhdGlvbjsgICAgICAgICAgIC8qIFdoZXRoZXIg
RE1BIHRyYW5zbGF0aW9uIHN1cHBvcnRlZCAqLw0KPiAgICAgICBib29sIHBhc2lkOyAgICAgICAg
ICAgICAgICAgICAgIC8qIFdoZXRoZXIgdG8gc3VwcG9ydCBQQVNJRCAqLw0KPg0KPiArICAgIC8q
IFRyYW5zaWVudCBNYXBwaW5nLCBSZXNlcnZlZCgwKSBzaW5jZSBWVEQgc3BlYyByZXZpc2lvbiAz
LjIgKi8NCj4gKyAgICBib29sIHN0YWxlX3RtOw0KPiArDQo+ICAgICAgIC8qDQo+ICAgICAgICAq
IFByb3RlY3RzIElPTU1VIHN0YXRlcyBpbiBnZW5lcmFsLiAgQ3VycmVudGx5IGl0IHByb3RlY3Rz
IHRoZQ0KPiAgICAgICAgKiBwZXItSU9NTVUgSU9UTEIgY2FjaGUsIGFuZCBjb250ZXh0IGVudHJ5
IGNhY2hlIGluIFZUREFkZHJlc3NTcGFjZS4NCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBpbmRleCAwOGZlMjE4OTM1Li44NjEy
ZDA5MTdiIDEwMDY0NA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gKysrIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQo+IEBAIC0zMzcyLDYgKzMzNzIsNyBAQCBzdGF0aWMgUHJvcGVy
dHkgdnRkX3Byb3BlcnRpZXNbXSA9IHsNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgieC1wYXNp
ZC1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBwYXNpZCwgZmFsc2UpLA0KPiAgICAgICBERUZJTkVf
UFJPUF9CT09MKCJkbWEtZHJhaW4iLCBJbnRlbElPTU1VU3RhdGUsIGRtYV9kcmFpbiwgdHJ1ZSks
DQo+ICAgICAgIERFRklORV9QUk9QX0JPT0woImRtYS10cmFuc2xhdGlvbiIsIEludGVsSU9NTVVT
dGF0ZSwgZG1hX3RyYW5zbGF0aW9uLCB0cnVlKSwNCj4gKyAgICBERUZJTkVfUFJPUF9CT09MKCJz
dGFsZS10bSIsIEludGVsSU9NTVVTdGF0ZSwgc3RhbGVfdG0sIGZhbHNlKSwNCj4gICAgICAgREVG
SU5FX1BST1BfRU5EX09GX0xJU1QoKSwNCj4gICB9Ow0KPg0KPiBAQCAtNDEzOCwxNSArNDEzOSwx
NSBAQCBzdGF0aWMgdm9pZCB2dGRfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQo+ICAgICAgICAq
Lw0KPiAgICAgICB2dGRfc3B0ZV9yc3ZkWzBdID0gfjBVTEw7DQo+ICAgICAgIHZ0ZF9zcHRlX3Jz
dmRbMV0gPSBWVERfU1BURV9QQUdFX0wxX1JTVkRfTUFTSyhzLT5hd19iaXRzLA0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4ODZfaW9tbXUtPmR0
X3N1cHBvcnRlZCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
eDg2X2lvbW11LT5kdF9zdXBwb3J0ZWQgJiYgcy0+c3RhbGVfdG0pOw0KPiAgICAgICB2dGRfc3B0
ZV9yc3ZkWzJdID0gVlREX1NQVEVfUEFHRV9MMl9SU1ZEX01BU0socy0+YXdfYml0cyk7DQo+ICAg
ICAgIHZ0ZF9zcHRlX3JzdmRbM10gPSBWVERfU1BURV9QQUdFX0wzX1JTVkRfTUFTSyhzLT5hd19i
aXRzKTsNCj4gICAgICAgdnRkX3NwdGVfcnN2ZFs0XSA9IFZURF9TUFRFX1BBR0VfTDRfUlNWRF9N
QVNLKHMtPmF3X2JpdHMpOw0KPg0KPiAgICAgICB2dGRfc3B0ZV9yc3ZkX2xhcmdlWzJdID0gVlRE
X1NQVEVfTFBBR0VfTDJfUlNWRF9NQVNLKHMtPmF3X2JpdHMsDQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeDg2X2lvbW11LT5kdF9zdXBwb3J0
ZWQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHg4Nl9pb21t
dS0+ZHRfc3VwcG9ydGVkICYmIHMtPnN0YWxlX3RtKTsNCj4gICAgICAgdnRkX3NwdGVfcnN2ZF9s
YXJnZVszXSA9IFZURF9TUFRFX0xQQUdFX0wzX1JTVkRfTUFTSyhzLT5hd19iaXRzLA0KPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHg4Nl9pb21t
dS0+ZHRfc3VwcG9ydGVkKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB4ODZfaW9tbXUtPmR0X3N1cHBvcnRlZCAmJiBzLT5zdGFsZV90bSk7DQo+DQo+ICAgICAg
IGlmIChzLT5zY2FsYWJsZV9tb2RlIHx8IHMtPnNub29wX2NvbnRyb2wpIHsNCj4gICAgICAgICAg
IHZ0ZF9zcHRlX3JzdmRbMV0gJj0gflZURF9TUFRFX1NOUDsNCj4gZGlmZiAtLWdpdCBhL2h3L2kz
ODYvcGMuYyBiL2h3L2kzODYvcGMuYw0KPiBpbmRleCAyMDQ3NjMzZTRjLi44MzA2MTRkOTMwIDEw
MDY0NA0KPiAtLS0gYS9ody9pMzg2L3BjLmMNCj4gKysrIGIvaHcvaTM4Ni9wYy5jDQo+IEBAIC04
Miw2ICs4Miw3IEBADQo+ICAgR2xvYmFsUHJvcGVydHkgcGNfY29tcGF0XzlfMVtdID0gew0KPiAg
ICAgICB7ICJJQ0g5LUxQQyIsICJ4LXNtaS1zd3NtaS10aW1lciIsICJvZmYiIH0sDQo+ICAgICAg
IHsgIklDSDktTFBDIiwgIngtc21pLXBlcmlvZGljLXRpbWVyIiwgIm9mZiIgfSwNCj4gKyAgICB7
IFRZUEVfSU5URUxfSU9NTVVfREVWSUNFLCAic3RhbGUtdG0iLCAib24iIH0sDQo+ICAgfTsNCj4g
ICBjb25zdCBzaXplX3QgcGNfY29tcGF0XzlfMV9sZW4gPSBHX05fRUxFTUVOVFMocGNfY29tcGF0
XzlfMSk7DQo+DQo+IC0tDQo+IDIuMzQuMQ0KPg0K

