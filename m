Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC8AC30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 00:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnrj-0005cS-2r; Tue, 02 Jul 2024 20:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOnrh-0005YW-8k; Tue, 02 Jul 2024 20:28:53 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOnrV-0006wP-Df; Tue, 02 Jul 2024 20:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719966522; x=1751502522;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3UhkGG/QLvbxD1h51+kcPNetkSW7Yheow5HLe/wshUw=;
 b=wuO5dZBHy4ANXucRsC3XsdriBn3bxzgn4msk4rrjyj29KiIMzFgjejW+
 rA88IejDnXBECh5XdLEneXhT2ltNzC6uY6u6y+Fqt/Q4fhLJOjbev5XQr
 h9kbaGQm14w5r4tNtya142UzUwVz6Dg+U+e7m0Pb9cgPwRSEh/iR+8VTG
 nkf0zUdObWiCYULtSaLa5ExsxceWhphNR9hnIshjcTlxVz/fQCL3m8uqt
 y4kT/6Skxdr/G61eZLmFky9ifRHyfEeG5s3yRtmNGhDS2Uc5gyyI2OVJG
 9J375pnm6wObu54SUUCLEbFShsLSne73mWkskxEnNZ3M7CUs2jswfcQAI w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="124388040"
X-IronPort-AV: E=Sophos;i="6.09,180,1716217200"; d="scan'208";a="124388040"
Received: from mail-japanwestazlp17010002.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 09:28:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fq7yPTE/Of/jButrsoCs09C+p150ZZG66QXMtNmXndSATcdVdtUMq2jZuZZDPM5bTMVSrr6vtzjZSWLzMbw3lkT2EDP3ktPkws0pT4g61TpTGWgmbcqZv8s9Fm7y693SIlvEgB8N+Vvf/op5CLlhKkHXgVENAM9muyzWhXQZCTVScenb8yH1E+lBDKN5XJhKWDATZdyi1RmOZ2LUvQoRgZe3IbwcrCMPpwirgH0t2DHdfRm15emzDREd10GygHcoIk6DEVbw9tMKJVpE8xqWAWgtl6fQr2JzD+e/l5mU2vVC/JAfJNpF2B30uNuIDQllqdL4f4NuSF3ehQs7VavekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5nTaWExigx3/M/grbVsGLrITVm1pbBaOz3htxIFrF8=;
 b=XkDzIbs/ON9Pf39zuBhkKR+LVRPm4YR/8IUPvyaCfwI8mYvd4pd7QFG2DiScQUiHnmxgrQyNTlksH7Ic3WrS8MJgsURGR3it+LXTG+AFppHRTWG6qGqdTzR12c9Xgb1U2QCRxecbNjw9fJznroZrdBKVyRHkjPza2//MFWGNqs+Z62YtnmT483Ls/PkCLxYsRoQCtVXLPW2pgdfyBfANuFlJvtqqg+7tNLpCN2dWYg1aSTuuVxKh1TEN/gc+FQ+T0c6/kygF+cA5JicPBFAoHRwPLlTpoyAj7yUk1+L982nqDqSu1kpuT/fNq9SIoR89fpf6F0VkpGzYg4xv5VqpBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYWPR01MB11751.jpnprd01.prod.outlook.com (2603:1096:400:403::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 00:28:29 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 00:28:29 +0000
To: Zheyu Ma <zheyuma97@gmail.com>, Keith Busch <kbusch@kernel.org>, Klaus
 Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>
CC: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] hw/nvme: Fix memory leak in nvme_dsm
Thread-Topic: [PATCH] hw/nvme: Fix memory leak in nvme_dsm
Thread-Index: AQHazNWOdhUgHXJcyUCX9QJ99Wln+LHkJf8w
Date: Wed, 3 Jul 2024 00:28:28 +0000
Message-ID: <OSZPR01MB64536DBC295F417828B3624F8DDD2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240702231303.3077584-1-zheyuma97@gmail.com>
In-Reply-To: <20240702231303.3077584-1-zheyuma97@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=8236f7d4-5d10-40a2-b0cd-91d5d24f9d2d;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-03T00:28:18Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYWPR01MB11751:EE_
x-ms-office365-filtering-correlation-id: 5ab6b806-2441-45cf-9763-08dc9af70fa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?Z1VNVkVGRjY3NlEwZXUzWXVFR003S1R2elZIWDFWSlVMRnpBVmNGclIw?=
 =?iso-2022-jp?B?MmpITXdpcTBJWitGUE1GMnhCek1xQXltcjhqK2RHcXFLMGZVN2czaWgy?=
 =?iso-2022-jp?B?Zmdpbnp4SC9LREQxd1J3b2NSTEhUNHRMWHY3OVJPOFRnSGU3TUI1c3Q4?=
 =?iso-2022-jp?B?RGVuYk4zZ2QxdWpCM1FxblVjMEdkUEptVjhPR05FOHFkenltaHN1ajlt?=
 =?iso-2022-jp?B?ZXc0Q2tzK3lWVSs2ZU9hY2NNRERtdXRKWkNpZ3FIQUZEY2oyZWwzZDRS?=
 =?iso-2022-jp?B?bzdlNEtOQW1YL1pqTzlnV09DVE1UeDIzMXpLTDFjUWF3eTVqNE1IR2ts?=
 =?iso-2022-jp?B?cUFOd1hDQlREZERaTTRCdFV2RytId0hZVXRSN2p3cjlJUmtlbGVPQUw3?=
 =?iso-2022-jp?B?VVkyc0k4NjR4ZGx2TnVrQytIMUp2cy80VlJuOHVIUmpoZFNtTGJuanNX?=
 =?iso-2022-jp?B?R01STzFvaHN4RkR1ekw5Y3hDQ3VJQi9FWGNyc25VWmpPamNHck4yQnh5?=
 =?iso-2022-jp?B?S3NBa1hQR2djYXVNMGFlNXRIdXUxQzZNbnVHTnVHM3hsQmMyeU1Vc0xx?=
 =?iso-2022-jp?B?cVM3TmVOdlBkaDBmSHNGMGxWWVBDaGt5Nm5RVk1UbHJHSTFKQW51bHVh?=
 =?iso-2022-jp?B?bVI1bFQ0c3lJaktYMUpvaWxnSFh4cFp1ZW1YTEgxaG5hZkJhUnV6WDRT?=
 =?iso-2022-jp?B?T0FaSVc5cDlDZDZCa0VGc0lRaXB6RHAxSEtlbjBHanBKOUJpK3dUTUtO?=
 =?iso-2022-jp?B?MHg3SEF5YWUxT3l1WEUwZXBDdHQwQ1VnR3N2TTZNWnN2dURKbHcrdGtj?=
 =?iso-2022-jp?B?WmhxZFBtY3g5TE5nOUJqT2xUQk12akhPNGRBWGJxUklSajUrYkJyOEF0?=
 =?iso-2022-jp?B?cWV2dlQ0V1pBcTJkZnp3eDArZHRKRXBVL015LzZUZkUvQWE0Y25rRG54?=
 =?iso-2022-jp?B?eFdVM2JpK2xBcVBLaDArWmMxWERRTDVhRVRGT3dUamppa0p4VFhIbHJl?=
 =?iso-2022-jp?B?UFU2UzFIdml5R3dVVSsrV09tOU9pMFhqKzYrUmJ0cXlkSkZUTjZWdDJ5?=
 =?iso-2022-jp?B?L0tneHZMUENwRURpRXpBQldxV3JPaFJIeWRHUm9CczBkR21ubkFQZ0Q1?=
 =?iso-2022-jp?B?SmU0c1hOYmV3eEc0a3ZQWW1OVHZEa3dSTjNla3oraTdnWUZwdWlucGZh?=
 =?iso-2022-jp?B?eVpENit2OWU4R3lYQkVmelFVd0RQRGl1c2t4L3ZhN3Nzbk15QXZZZ0lw?=
 =?iso-2022-jp?B?aVpYZU1TSXFOVUNIZW4zaXV5MlMzMzhsTlFweDBrUy95K292UnM4SUVV?=
 =?iso-2022-jp?B?bmdNT29FZVFIRzdwbFFHRXl5SGdMRHhBSkNPTERpUmF5NnJ0Qk92YXN4?=
 =?iso-2022-jp?B?b3FscThUcyszWkc2ODhIc0VDR2hKOFdzYm1IQ0tsdUZWOHpDamIzdXFl?=
 =?iso-2022-jp?B?T0dhVGJncnA4TG9BUzR3bHpQakZmYkNCNlp4OS92bnU3TkVJbXc3VXU2?=
 =?iso-2022-jp?B?TmxJUTNSc3Z6NDlXRTJVdjgwR2w3UUs1QUNLRGNBTklkN2NZUkhzanFp?=
 =?iso-2022-jp?B?RGsvWVNRM014RGhnWHpWNEMzUHZURjVyOGhGczhiRTV3azhUaW9DVmdB?=
 =?iso-2022-jp?B?VnB1N3FZa290SEdCL2s1TEVZYnlVK3MzR0c1c1BkMXFQNUlDSXdTajYz?=
 =?iso-2022-jp?B?YThiV2VNNE45ZEcrVmhubmZPVVJEQkl1dlpEM1lEWUdyeXFGbm9QS3Rw?=
 =?iso-2022-jp?B?NENZcEdOTFJOZmkzR0s4aGNRbkl3bU4yaHJ5MVdzQjEwdjZzVjhZNU9N?=
 =?iso-2022-jp?B?MExpK0wrVVEvTU43ek5JcEx4b2ltTTZka1dDbmdmOXI3MngwMzFuaVNJ?=
 =?iso-2022-jp?B?bHJQbEdMdkJjZ3VzT3FBZWhPUXU4TndMQlcyQjJUT2dudWtoNk44dEw4?=
 =?iso-2022-jp?B?cVB6REplZ0ZWVWN1cUt2R1lmV1NKaU5nWTVwSy9lNWxaU1hhVlBia09I?=
 =?iso-2022-jp?B?NldzYWx3aUdmZDFYTUlxUlpFaU1kd3V3ZGxEOTF1WForK2htTG8vbUJ3?=
 =?iso-2022-jp?B?ZmFNeE1kQllEWEhFa2E4NTJjVC82Z3c9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?QkU4cXppNTNUQVZqcldVQTBpWmxWRUF1U3JkV090Y3B3VGozYTNERlFK?=
 =?iso-2022-jp?B?TXV0ZUNSa2NSKzZ2YW9nUnJtWHk0Um5tMmhSVFFBUFhyRzZuN01zSG5H?=
 =?iso-2022-jp?B?cFhNNHJrdVRENVV5SHNpODVBYU9NaE0wWnpXd1Y4SHkyS3ZqejI2a0g5?=
 =?iso-2022-jp?B?cjBBSGN1cEgra1lTd1RqTnhrKzViYlpUdTFIRTdPd0F5aEw4RXZrU3ZG?=
 =?iso-2022-jp?B?Tk04S21vVkxMQ1ZNdk81ZXIwMXpkdzlMOU51cU9KRzdNdFBESDd2anlO?=
 =?iso-2022-jp?B?SDJmMTNOclhSMEx1YUhkMWEyOEVqZXh4Uy9vWkQ1OEZ1SHgxd1lKZUpx?=
 =?iso-2022-jp?B?YWNHSlZibTdqcjk0Z2pOYzE0UTRLWVdncDU5R2duMndaSkt6bWVySkox?=
 =?iso-2022-jp?B?S3c1NmZ2L211alRBSWJoNXFHaG5BVjczSXhQSWs0cEE1bmZHNHZDM2lF?=
 =?iso-2022-jp?B?MHdWQ1pGcWFENlN0OUpmR2dGZjhTVkE4ZGZzMFByamgvSWpKUHp2TzFL?=
 =?iso-2022-jp?B?Y3ZleFBqNFhiN1RtSFVRNlRVZ3A4eXZaZzBZQTJjOHgxSklFTEEwYXpu?=
 =?iso-2022-jp?B?QmRuLzB3Z1J2NWRURldsRnVsbDdkQk1Rb0IxSjVqVmptZkJDNmpoV0ZE?=
 =?iso-2022-jp?B?eDhBZEtjWU9uY2tvaThhNEpEcnRtVHZ1UTg2Ky8vWTltL3lwckZaZnhs?=
 =?iso-2022-jp?B?NCtkSkNhR2QxWFZSa21XQUZhMG93R0tOMWJEaE1QQ000REczMWFBRWJU?=
 =?iso-2022-jp?B?cEsxeVNoWnpTMUx2MDdORkhGbmtWZEVRalRla1h3d0l1SGhpeGxNMjRW?=
 =?iso-2022-jp?B?dkZQNHlxYXUydy9lYzNEeTFLcUMxTmpScGtMY3ZoRUxqcFBoMzV0b3N3?=
 =?iso-2022-jp?B?S1dFWXplS1NjaFl2cjBxK3R5cC85V0hxRHNCK0gxdXZPdXIveGY1cUx4?=
 =?iso-2022-jp?B?ZUI4SFVrVXgwU2orSkNYMmRYRDhTaFZOVWY0c2hFUTJTQ1lUYlNPRGpx?=
 =?iso-2022-jp?B?Q2IzQjhXWHNaTlgzU2JRbVBHdDZVdDZwc1FjQlJRL3R1TEdtWHF5M25a?=
 =?iso-2022-jp?B?anNDUmJIbXhHSHhKb0xiR3JQNTZHOENsWEhJZ2ZFempiUUZUVlpvdnZY?=
 =?iso-2022-jp?B?Y1VNVUFta0VlbE8zSFNPckkxSXJJcXlieE9qM0NIMFNkb0ZtZ2NKWEhE?=
 =?iso-2022-jp?B?L1Uxenc3TmJLRXFZUWZtUDd2Wmw1VnR3ZW5DL0tZQUp1aDhlTHYyQ2RL?=
 =?iso-2022-jp?B?bURMQUp0Z3FwUzdqc3VWaGxscWtacGVQRlp0OVJPR2tCNVFzS2d1bTNX?=
 =?iso-2022-jp?B?cWVHeEJLR0xZTmN5ZkpjRGlRVnIxc29IZEZpd3NxYkxRYjIrSGlmWnl2?=
 =?iso-2022-jp?B?ZG1QaVFxQVRTNytzakFxeTRDVlY4VWx6dVViRXFjcFZ1M0pWVmJNTWhs?=
 =?iso-2022-jp?B?bXhKMFJlcjFFQ25WQzdZQVdURFhwcEhVb1BpMVZJUmpVYlBlZGM5YkFH?=
 =?iso-2022-jp?B?ekNBU3BrV1I2SUxFam1WYnVYM3pmZjEwdkRkOGZKdGM2dEF3YXJkREVY?=
 =?iso-2022-jp?B?MzljL2xua0Fid1N1ZE1QcXI5S1hxNlZvRUJJRjd2NEQvVlp3emRsZXZj?=
 =?iso-2022-jp?B?RCsrckZUMXdQSW5GbHJhU2p1T1hQbkFReE13NzhzREY0T2xEeHlsclg5?=
 =?iso-2022-jp?B?cFZGaklITWR2Z3JiTTM1TzAyS1U5Vkc2SC9zWm9JUGNVRC85RHpLeGpk?=
 =?iso-2022-jp?B?M284eE8xTFhpMkE4UXBoMVFSRGxSZlVyUTR4TW13cm5KSGdmeTlia2R1?=
 =?iso-2022-jp?B?bk5yYXhsVDlnQVdhS0QxTVNRK1RxZndIa3BwZzEzdnRMRkNGYjc2SWdF?=
 =?iso-2022-jp?B?VW1Ib2tGVHFWak50YUZwL0NTQUh1dkNaNjg3U1o3VnFzZ1F6MFVQUjVU?=
 =?iso-2022-jp?B?R053Z1BaTURSSyszL2toR2ZDMHBVbHVLNGZSUDNvSWt2S1Y5VTRId0kw?=
 =?iso-2022-jp?B?eFU5Y2VyWStKVU5SSDR6VmpiY3dxT0w0ZzNuc3VaNzVnd3JQeVFqTHNE?=
 =?iso-2022-jp?B?bktVWlFYa29heGVGZ0VFZGlXZ0gxeWh4b3N0SnJIYUJGNlI1U1ZtUFJ4?=
 =?iso-2022-jp?B?NmEwU1h1NHQ3Wk52VWVWYWR4ckwzWWFtczFXZFljYmRrZHo2WGFLK3BE?=
 =?iso-2022-jp?B?YXZiZU1Xc0JkaDMvT2Z3N1ZNL0dVMWdUSzFFek5WWG1MNVhEL2g1WkFq?=
 =?iso-2022-jp?B?czlrYkRwbVlHRVNkVEFOLzJwdWJ4QStQVGlQTzU0MXVOSWJXRk9iejVo?=
 =?iso-2022-jp?B?ZkFXbw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tlyCZtJtVVJEirSNY7zxxL3D7pc9twV0d6Xmqbom7VFqVcq2F5ZDESTmheeYdGwp/8cckDxmb/w7EKEfcxxZ73u+6VkRvzEu2ZODhRZUyTX+VKpgOkP65jsO0odzyVEyINMRlzBP4Vk66/XWvxg1iBn6Zfa9mfEYu9sB63pOOr8MsXi3VUwxIMDXEhlDPAhI61Wtdl4MHQ3oQ0/pLfFMHvQJxmgevR7boaw/CYE1cRXTLCihExXLUS8Wf9a+FU13i7TTK1xwsHEgfj5YaTgwjWKliPH1FX7bm2MkgEl/OqSEjouOzs2cGIfqtvP+X6kJxDAN+1h1UBAjpHMHQPQTVRkC0LwWNajQlCqdu93J6lW26yLhxxbmAZYjNrumFPFQX4Z0m2l9ajArFqvn+JlwcSTIajLC98krgaANEC5sxwNi3GdkoFdqeiZ7KyDnsgxg6TIU52aIVSCTEFjluVPPy11yQEnUMRCgYgnmJjv1c0z9ZFg2GOX10l7hJb3LgoR7Ge2colR6tc4ThKWo+hqqtyXxLnL1smjQoilY6bv5uNeinSa2ZE9RIxg8xtYgEzPIOUacAGXjQkxU9itX6pcZZvsRT7gfN3kus3cCPv1t0SCk206l59+xldPPRWvWX8zo
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab6b806-2441-45cf-9763-08dc9af70fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 00:28:28.9400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sl1BlLHMwvKDMF8J8SO/t5eXNJ2ExMUxuobToXPh25LHURCTzcg39iRjhJYycyGLRS28wgfK9Re07tWffIz39w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11751
Received-SPF: pass client-ip=68.232.156.107;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa15.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org
> <qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org> On Behalf Of Zhe=
yu
> Ma
> Sent: Wednesday, July 3, 2024 7:13 AM
> To: Keith Busch <kbusch@kernel.org>; Klaus Jensen <its@irrelevant.dk>; Je=
sper
> Devantier <foss@defmacro.it>
> Cc: Zheyu Ma <zheyuma97@gmail.com>; qemu-block@nongnu.org;
> qemu-devel@nongnu.org
> Subject: [PATCH] hw/nvme: Fix memory leak in nvme_dsm
>=20
> The allocated memory to hold LBA ranges leaks in the nvme_dsm function. T=
his
> happens because the allocated memory for iocb->range is not freed in all
> error handling paths.
>=20
> Fix this by adding a free to ensure that the allocated memory is properly=
 freed.
>=20
> ASAN log:
> =3D=3D3075137=3D=3DERROR: LeakSanitizer: detected memory leaks
>=20
> Direct leak of 480 byte(s) in 6 object(s) allocated from:
>     #0 0x55f1f8a0eddd in malloc
> llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
>     #1 0x7f531e0f6738 in g_malloc
> (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
>     #2 0x55f1faf1f091 in blk_aio_get block/block-backend.c:2583:12
>     #3 0x55f1f945c74b in nvme_dsm hw/nvme/ctrl.c:2609:30
>     #4 0x55f1f945831b in nvme_io_cmd hw/nvme/ctrl.c:4470:16
>     #5 0x55f1f94561b7 in nvme_process_sq hw/nvme/ctrl.c:7039:29
>=20
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  hw/nvme/ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 127c3d2383..cf610eab21 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -2592,6 +2592,7 @@ next:
>  done:
>      iocb->aiocb =3D NULL;
>      iocb->common.cb(iocb->common.opaque, iocb->ret);
> +    g_free(iocb->range);
>      qemu_aio_unref(iocb);
>  }
>=20
> --
> 2.34.1
>=20

Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>


