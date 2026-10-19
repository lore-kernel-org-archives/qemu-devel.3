Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277B3CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xId8p-0000QH-2u; Sun, 18 Oct 2026 22:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId8m-0000PO-To; Sun, 18 Oct 2026 22:30:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId8k-00026Q-W7; Sun, 18 Oct 2026 22:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792377019; x=1823913019;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QQnJ94PauFeC3TsHBMMenFJHB6aIJc6tW7/wCAVn/6s=;
 b=psUSwb/ttCRT5Qt3X9gaxtc8XYP5ijNMfXU/1iJGI7tWaFUoCUTbElDz
 UCPuxi+WhnNDxdMkxF164YN0GDbgtxGAa186Z2rpoGFzGwQVCQ0kT269A
 fkWPAnPRatqk61NqcHHOUQLgRosqnYmLEJcWtQUzkUmHaLFhchZY65ITc
 FAVzUqgVTnz2i8k8jYaA8Dk5TSgzGFi5pvG27VTJMh42/GgGvlIs6DJI1
 fnk6bnbLgDSOai9VgmZopR972GoEaOAYrOfyGGngXoUs9jziLgelMMPr1
 ErLNwsPt7Zt+/IzETiNq8vDtNFkifYPw3mNVpJwKLjNzPhGDFrGXAJWDr A==;
X-CSE-ConnectionGUID: 0rbgz2RCT56+g+fLHJT53Q==
X-CSE-MsgGUID: fFzoI95SScirp2ToiVlemg==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="158416994"
Received: from mail-westus3azon11010016.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.16])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:30:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrxoaZVf1f0Cd7W6y+XKCvDd95wxWIr9PP3AW34e64sUCwuezuwmhVZlVLKb5DAIX/jpD2nT3WNoxGGhTpE9dLztRxc/77UOfDRpApBd90wOqwOb2atkO1ESEscZ3m54A20EOtOSPrFFETA7ogA/pc/5GAlry39ldWMpvth0wMKG1IpiwcrtPLJH86McUs/iyNkMwfQE1GKQB9+7alPOKblEZ2zo9XaULx385ylIJBN57UjJFkO09Ldi0GTA/nLIpRE7ZJTTIgCupRreRzTV8xjtZn/STGckLVDI8cjL97HOrFDu5+UfHK93++X5V8lJrR7Q2LDCRQBKTKEVjjcqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQnJ94PauFeC3TsHBMMenFJHB6aIJc6tW7/wCAVn/6s=;
 b=r9YW1JRzlGBGwj0VN0MBQCTDzfcloVo9Pb2GAX3FdrNdla6pdSaJ+LQt8DNBv9vnwU+7s9cb2LbUzX6c3BnI0QA/hacNzOzePc66T6ic//34dO6JOqpGjzxNYrSgiBci+9+oqKWcEWpJP8I0eLQeUruPIU/sp26c/uaNrOG4VhhRLCu1paTcUucudmrU8zWH1/tBCv7YVGLmwgZmybg85ecMh9HotnNYnEhsg+4UhAPgtagoPcb1PFei6JYEG9E6cxvd2T/7vR21TtwaCyYgfvbVSfviQIufIx9kBm9c4Lf3rNfuSfWBCwlXah2AGLm1Lb8lpG4sn61WCBWoEQlDDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQnJ94PauFeC3TsHBMMenFJHB6aIJc6tW7/wCAVn/6s=;
 b=XVLhh8phPeYvVuvBomsw8Nm17BRxzdJeWHomABNt+XbkHyZyKY48ZbQ0vpenxclloNcwl1FyW/+kcI0iCLYt9P74bpuK5VEDP+IdubFHjlBuMNMRpXbbWWmGtBwKkx1/YCo/wM2SzFF2MPzPFLre+kqkUqA1otOcUzPziVxk+6w=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by LVXPR04MB9981.namprd04.prod.outlook.com (2603:10b6:408:37e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:30:14 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:30:14 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dingtaodtdt@gmail.com" <dingtaodtdt@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dingtao0430@163.com" <dingtao0430@163.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH v3 5/5] hw/dma: fix k230_gsdma integer handling issues
Thread-Topic: [PATCH v3 5/5] hw/dma: fix k230_gsdma integer handling issues
Thread-Index: AQHdXwp2Yejy+bOun0iFxoFTdQKCCbcEJXSA
Date: Mon, 19 Oct 2026 02:30:14 +0000
Message-ID: <1e2a0c00af8e584169c8e4f25a5f5f0ad1230a7b.camel@wdc.com>
References: <20261018141006.16398-1-dingtao0430@163.com>
 <20261018141006.16398-6-dingtao0430@163.com>
In-Reply-To: <20261018141006.16398-6-dingtao0430@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|LVXPR04MB9981:EE_
x-ms-office365-filtering-correlation-id: 5d731019-8cbf-44d1-03b2-08df2d88e82c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|19092799006|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0YuS2pPJ+1yi9bxAtYeOQQPoSAyOHhxI7WyXkRPAFpAKN7Ba3aiZbP4Ix8Qx2OVv3GbfzSJZF+rfD/wrqVgdbIZUu8dyixIkP1XJxbu7Y0L5TBi14jFrlv8wr/6iyQnMH4vAc948YHDSVVFkMC+WvRSD6nxqwJb+WeKzOU+kGgT+iKQwTjBrsxwiPXIbIdDGHBzyc+FTK4HZB1t1KZMFTgYy4q9XcontzxKv+09IbaKxENPf5WjeIRItiddHTD4UIM7+/AhATg/8bi3j+czhGKrxbO0MnSYyLbMtUDBk+EWWILVN6BJ27rKCCwxwAazZWq2jsDQVnIcepfccVeIQ+kh6PNJnXdLIbZjOP4WX+cdTGHxYz6qf841MHvb7CMyRFC/9iDtDhYeJoCsZvbnAgBdknzvJf6RaTGrMDe/7TCWq1HGUS1SMbRu2eSTXubhbcDiZP3nzLJM7LNz037fBXRqSLdGI8R4HFFTeOe0O8O9rYFnzGDGDrx0BAEMhSde1R88UcwYxvhIS+8yS+8BOn7v0xpEauS1v8V75xPXz+tdSRrc3+sHaeVPcV8Agv0s10rZR1DBw07r9WbCUL/Ea7uy6+Y50LARL1XG2PznEx1ulDEbpp0oAm0m+LUZWrUtlC6nOBk0kjU9kUk2s6hfGJfy67XLZ9vB2CgCiVyw87GtXpeY0fuIcjh7l3pFZRte6OZZL90nDm4KWx57kqaqECs+IZ0k/c3PPPO2Z3kcDxXA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(19092799006)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE9MT2xCUlNUSDJkQmRNb0F3RkFRemdpVFRPVFQyd0RHUWF0NkUxL0thVkVC?=
 =?utf-8?B?TlBLNUhhRUp2ZkVTbGRSS3BnQk5oTkJYNmlJSUorZHpJYjlhTDhqOFhDQjVZ?=
 =?utf-8?B?MmUvZ1p5M2gvejZEVWtOOVJwc1pJckJsNjY3YytXbDJFQzJ3OUpQWEN2aGJC?=
 =?utf-8?B?ZG82aCtMR1pvS25VZGE0VzlnSnBpN1dEaEJ2WTlBVENSMmRlOTZhUGlRNEJ6?=
 =?utf-8?B?ZFBTOSt1MmFMVjFhK3RFUDVNbnJXMWJ5WmJjSnBGYTZMejFSN2JjMGs0bzI1?=
 =?utf-8?B?UXl6cHNrVk1EWEV0Ly95NFNva2VCZHppck5CaWFac2plV3VCdDhmR1k0TDZr?=
 =?utf-8?B?S29IRGVoU0ZtOXBwZ09abFBiTTFBYlJmTFJnNHhrMC83ZE44aGNCM2YxblVS?=
 =?utf-8?B?bzR0UFg4c2lpYmd2TWtNY2x5V0lkclJPS1dPTENsb0Mza2ZQL2FBQ2lRelhG?=
 =?utf-8?B?d1ArdEs3RGFWakFkdWNsaWQ4VUc2SnJlTkk2YS9wSFpJR0VaWTEyZFBCNDhm?=
 =?utf-8?B?SC8yZzVFYWFzeFRYdGt0NGlyQVBYM3Izemh4VVlWcndiODhPMktaMFZ4MUFh?=
 =?utf-8?B?OXEzdDJpMlROUHhGcy8vNHdWalB1VWNoZjNGNFRKVEJhWTdxbkEwSFJaYVQ1?=
 =?utf-8?B?YWVHTzNLRlBIYVFsVmFzQ3F2ZXc2VFpxcVhQV2xSWFRzZEV2R0tzd2pZQm9F?=
 =?utf-8?B?QmZkMUNRa3BQa2hlY2JIUmxqSkk0SUpBNXQ4TFQwZUdaMGQ2WjFnMjB1MGdo?=
 =?utf-8?B?NVZ2WjUwcGlNUjhzNWRzeFVFQW9ZbDdjUWpHRkhRcnk1WkRKdk5LMlN6VS9h?=
 =?utf-8?B?OG1odmhUR25YSjErYWsrSXVFRTZocFRHeTVsWjVLZ1pVU25zcEhHci9UZWd1?=
 =?utf-8?B?TWpJWDVYVTJuUUJiY3J5eHo2cC82R1p0aHZldUpjMExYOEFkTlVza2p3dnZl?=
 =?utf-8?B?S3FBY3FsZ1gwZ0YzZkwxV0kyRWR0TWNRK1RMcWVxNjkyTUZwREVCM1RhVysz?=
 =?utf-8?B?ZHFRVE4wQjQ1cVhqcUtVY1Zrb0dDbVdTZTFMK3BOU2U5YklJTmo0cWg2YkpB?=
 =?utf-8?B?K0tXSC9rRGRFa1FkVGcvcmN3aWM3VmhHRWFQbWRnQ2FKdXFXc29qQlYzbXUy?=
 =?utf-8?B?WkhwVEVsVnZlLzN1OWx4MCsvdXk5VVArQnVwOUJNemhOendjTnl3UUIxYXFX?=
 =?utf-8?B?cC91dlI4MGQ1NU9TN2NCSXNoRStJWFhSTlc1T1N1dmlWejBHSFB2TlU5MVhw?=
 =?utf-8?B?YVNkblpMdmh4TnZPbllVZm9RRTQ3azIyQktpUXk3RUJJQjYyR0xMUFNzblZk?=
 =?utf-8?B?akt6MXN2Zmx5SHY5aEZGNGdIc0RhMXY3aUJQWnBsVXhDb3RSTmlBclh2aHNL?=
 =?utf-8?B?b0tnK01ocVVEckF4dksrMHVDZkYrOFVwS2pqS0hrMEI5c25wWlVQa3AxeUVZ?=
 =?utf-8?B?NmFabU8rUm81VEFITlJIY3ZiYXJVck9NTTUxRUVqeE9IOXFseUVhdzI3aWJn?=
 =?utf-8?B?SVJkWjJhQXdzN1dxMllSRjJzNXZJVlZ0UTR3cjkzOUM5MDhTelNPaERDNWFS?=
 =?utf-8?B?b1dBYVZYL3EyNjJmcTVEN3N3a3ZEdFFuN21MMUNzcjFSRzRyS1c2WTZTOTlB?=
 =?utf-8?B?bDByaFVpY0gxejI0dG1vTHduZjZuVnZIdEhmZVkzNG05amJqWFdkMEhlZFpW?=
 =?utf-8?B?Zlh5VDROclJwbnd1YWlnakFXZThIaXNMd29lT0daTG1hcmluV1NtSVlLOVcv?=
 =?utf-8?B?WlV3SEVUb2VNbHdIbmFSY0xGcTNvd3FjMlUweTNrSmxsQklYQmFMdzRkSUZU?=
 =?utf-8?B?QjM2a0prU29qS2JoL2xQQjI2dFJjRnFFMHNyekZCazR5dDhKZ3IyMHZSNVE0?=
 =?utf-8?B?MEhRQkQ0TGh5eUJmNUZESUJuekg4c1BzK1plbGI5Z21VamhKMFRTL2FWdHZH?=
 =?utf-8?B?bUJ6eHRTM1VKd0wzT0pEaE03NFpiQ0p5bzNwbzhwZkFpU0RmSHppdnVBLytY?=
 =?utf-8?B?R1hnUDFSVWg0WW4yd0QxK2VlS0w2ODNCZm9BcU0rd211WHNHd1QxQUJEL3ZI?=
 =?utf-8?B?RS9lWW0wOHZLWEhiMkRybGt3a3dNWTlmZy9VcEVHK0hxQTU0WkE3ZWwyOE9Y?=
 =?utf-8?B?SEt4SHMxVFlyODVpQzlUVkNjTktwWWxVVDZFeWZOcU4vdU1RTWtETmFoZVl2?=
 =?utf-8?B?ZTRCLytJRXJ2ZkxQbHU0TVJOcEdkY0o4UDZmS1lUajhHMHFCRkFrbzVzaEJz?=
 =?utf-8?B?YmxGbTBSRVJ5NGxJR1ZxYnVUSDJZRHcxZFBPc2RycUFqaTZNY2VLTmM0M0NX?=
 =?utf-8?B?cUNYRkJJcEJ3bXY3em4zQkFmZ3VZbDh6by9vSXRieVNHVDNDSTFCRmJPUXJy?=
 =?utf-8?Q?iFNLuHByYJzo4NTjHrC8YHlM2PY0bpm33yqPlaH50Fh0H?=
x-ms-exchange-antispam-messagedata-1: 2F6p+lKub3UUXWlkR5nj/orox1jTGAjaIrg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC35C913596709458150959369D0ECFB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iEatcXwhI5pcpk2H2hji/n07Og61LIoA2w6XyBL+rOOVZpmpBfzpQN+4T/vQsuz8zZDOONI/sj+iam8zgagu3F47srPXdQYl6IoF41yE4IykRIN2qqE319dxCTcTw/zHdcSopDdksbZI6nlD+9QFxb+8Tpym7OaxLHxV+Bl3TcLx137cPzIfb8sr1rQyvD6leJ13M5FaKcorKWiCoXNdn4Y9EInF9+AWMW3JGUsQF2S6R3iHUfRdSXZCxdzZntKlDUPfZpujhgGdWkZrhhO2VL7VRPo5t80JJnR7tm1N9LKoaBns9UEEbPG+I1CcyiNANYoco9eKxN3vZhlP7pxUAQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DKBppkkISbiHx51UI4cKp61qSmuwFlJTFyuPPM8MortcKGc3/g3ThzdcpwYeMSoxxKF/1mGIagW1dtRsDS3kmUZvmSjZvpAhf+Pg2i19CNOSxUMaFz9PUN4cwfevwVoUVMq4aXvzb3gJ9V/FoXOMAhf2kk4W2keNxWoELogqaXrV9GeQ1rOt7qDdKwppdKmNDKPHsCsFcueSRRZ7Wc9Dbcm+GAdDmVpEyK8X2LX4CW+l8LyZn6pSG8wBffiWxoRFOF5cVh0Y04rZ8x+QozBIGrWj+X9wYPYya77IvGSiGnLXwI+g3OoqWun/MnlDKctUdj1SljWavF5BOdPP8Vl0Ly28HSPqKrh23WMysZgFChVB2siv40TZ3LWG6W529U2pgMrLXaNYQDwuRUaFGpTZdhz9ER693sPKSZ9JnnpL+D7+s6CVFVSRqHFQC+bSTgfC34L77B5vgLYov3c4aodCq7ElxxjBFF5Kgp3C2Rth6a99apFzLbtp2PM2lUmsWRbfIhmwaweU6u4PAh3EJJifKQhGocK3vydWnMnhOPbNzFvAmIT9MtJBbVEcbc8hDGRzFYEeOH5e3pOAZ/0k3nfd5YJn5KkrV0T9qT77HqqmA0qRh8U+u2u6Mw0UB2Mnjfr4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d731019-8cbf-44d1-03b2-08df2d88e82c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:30:14.3526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcmnqXu8j7YWUWqybqLVB80Gpfat/13gzH+OoQeIFkZ7Wd9WYueeupov2RlvAbZ3IGPdPithT9cpca3kSkQJY2pWc3vy4N4ccTC2XHSda1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR04MB9981
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gU3VuLCAyMDI2LTEwLTE4IGF0IDIyOjEwICswODAwLCBUYW8gRGluZyB3cm90ZToKPiBTZXBh
cmF0ZSBnbG9iYWwgYW5kIGNoYW5uZWwgcmVnaXN0ZXIgaGFuZGxpbmcgdG8gcHJldmVudCB1bnNp
Z25lZAo+IGFkZHJlc3MgdW5kZXJmbG93IAo+IHdoZW4gY2FsY3VsYXRpbmcgR1NETUEgY2hhbm5l
bCBvZmZzZXRzLgo+IAo+IFJlc29sdmVzOiBDb3Zlcml0eSBDSUQgMTY4NTUxNAo+IAo+IFJlcG9y
dGVkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogVGFvIERpbmcgPGRpbmd0YW8wNDMwQDE2My5jb20+CgpBY2tlZC1ieTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0t
Cj4gwqBody9kbWEvazIzMF9nc2RtYS5jIHwgODQgKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLQo+IC0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygr
KSwgNDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2h3L2RtYS9rMjMwX2dzZG1hLmMg
Yi9ody9kbWEvazIzMF9nc2RtYS5jCj4gaW5kZXggNzYzNWNkMTllOC4uYmQ2ZGI5ZTY0ZCAxMDA2
NDQKPiAtLS0gYS9ody9kbWEvazIzMF9nc2RtYS5jCj4gKysrIGIvaHcvZG1hL2syMzBfZ3NkbWEu
Ywo+IEBAIC0zMDQsNTQgKzMwNCw1NCBAQCBzdGF0aWMgdWludDY0X3QgazIzMF9nc2RtYV9yZWFk
KHZvaWQgKm9wYXF1ZSwKPiBod2FkZHIgYWRkciwgdW5zaWduZWQgaW50IHNpemUpCj4gwqDCoMKg
wqAgaHdhZGRyIGNoX29mZjsKPiDCoMKgwqDCoCB1aW50NjRfdCByZXQgPSAwOwo+IMKgCj4gLcKg
wqDCoCBzd2l0Y2ggKGFkZHIpIHsKPiAtwqDCoMKgIGNhc2UgSzIzMF9HU0RNQV9ETUFfQ0hfRU46
Cj4gLcKgwqDCoMKgwqDCoMKgIHJldCA9IHMtPmRtYV9jaF9lbjsKPiAtwqDCoMKgwqDCoMKgwqAg
YnJlYWs7Cj4gLcKgwqDCoCBjYXNlIEsyMzBfR1NETUFfRE1BX0lOVF9NQVNLOgo+IC3CoMKgwqDC
oMKgwqDCoCByZXQgPSBzLT5kbWFfaW50X21hc2s7Cj4gLcKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+
IC3CoMKgwqAgY2FzZSBLMjMwX0dTRE1BX0RNQV9JTlRfU1RBVDoKPiAtwqDCoMKgwqDCoMKgwqAg
cmV0ID0gcy0+ZG1hX2ludF9zdGF0Owo+IC3CoMKgwqDCoMKgwqDCoCBicmVhazsKPiAtwqDCoMKg
IGNhc2UgSzIzMF9HU0RNQV9ETUFfQ0ZHOgo+IC3CoMKgwqDCoMKgwqDCoCByZXQgPSBzLT5kbWFf
Y2ZnOwo+IC3CoMKgwqDCoMKgwqDCoCBicmVhazsKPiAtwqDCoMKgIGNhc2UgSzIzMF9HU0RNQV9E
TUFfV0VJR0hUOgo+IC3CoMKgwqDCoMKgwqDCoCByZXQgPSBzLT5kbWFfd2VpZ2h0Owo+IC3CoMKg
wqDCoMKgwqDCoCBicmVhazsKPiAtwqDCoMKgIGRlZmF1bHQ6Cj4gLcKgwqDCoMKgwqDCoMKgIGlm
IChhZGRyIDwgSzIzMF9HU0RNQV9DSF9CQVNFKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiVzOiBub3QgaW1wbGVtZW50IGdkbWEgYXQgb2Zmc2V0
IDB4JSIKPiBIV0FERFJfUFJJeAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJcbiIsIF9fZnVuY19fLCBhZGRyKTsKPiAtwqDCoMKgwqDCoMKgwqAgfQo+
IC3CoMKgwqDCoMKgwqDCoCBicmVhazsKPiAtwqDCoMKgIH0KPiAtCj4gLcKgwqDCoCBjaCA9IChh
ZGRyIC0gSzIzMF9HU0RNQV9DSF9CQVNFKSAvIEsyMzBfR1NETUFfQ0hfU1RSSURFOwo+IC3CoMKg
wqAgY2hfb2ZmID0gKGFkZHIgLSBLMjMwX0dTRE1BX0NIX0JBU0UpICUgSzIzMF9HU0RNQV9DSF9T
VFJJREU7Cj4gLcKgwqDCoCBpZiAoY2ggPCBLMjMwX0dTRE1BX05VTV9TRE1BX0NIQU5ORUxTKSB7
Cj4gLcKgwqDCoMKgwqDCoMKgIHN3aXRjaCAoY2hfb2ZmKSB7Cj4gLcKgwqDCoMKgwqDCoMKgIGNh
c2UgSzIzMF9HU0RNQV9DSF9DVEw6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4g
LcKgwqDCoMKgwqDCoMKgIGNhc2UgSzIzMF9HU0RNQV9DSF9TVEFUVVM6Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0ID0gcy0+Y2hhbm5lbHNbY2hdLnN0YXR1czsKPiArwqDCoMKgIGlmIChh
ZGRyIDwgSzIzMF9HU0RNQV9DSF9CQVNFKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIHN3aXRjaCAoYWRk
cikgewo+ICvCoMKgwqDCoMKgwqDCoCBjYXNlIEsyMzBfR1NETUFfRE1BX0NIX0VOOgo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHMtPmRtYV9jaF9lbjsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJlYWs7Cj4gLcKgwqDCoMKgwqDCoMKgIGNhc2UgSzIzMF9HU0RNQV9DSF9DRkc6
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gcy0+Y2hhbm5lbHNbY2hdLmNmZzsKPiAr
wqDCoMKgwqDCoMKgwqAgY2FzZSBLMjMwX0dTRE1BX0RNQV9JTlRfTUFTSzoKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXQgPSBzLT5kbWFfaW50X21hc2s7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJyZWFrOwo+IC3CoMKgwqDCoMKgwqDCoCBjYXNlIEsyMzBfR1NETUFfQ0hfVVNSX0RB
VEE6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gcy0+Y2hhbm5lbHNbY2hdLnVzcl9k
YXRhOwo+ICvCoMKgwqDCoMKgwqDCoCBjYXNlIEsyMzBfR1NETUFfRE1BX0lOVF9TVEFUOgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHMtPmRtYV9pbnRfc3RhdDsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gLcKgwqDCoMKgwqDCoMKgIGNhc2UgSzIzMF9HU0RNQV9D
SF9MTFRfU0FERFI6Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gcy0+Y2hhbm5lbHNb
Y2hdLmxsdF9zYWRkcjsKPiArwqDCoMKgwqDCoMKgwqAgY2FzZSBLMjMwX0dTRE1BX0RNQV9DRkc6
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gcy0+ZG1hX2NmZzsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gLcKgwqDCoMKgwqDCoMKgIGNhc2UgSzIzMF9HU0RNQV9D
SF9DVVJSRU5UX0xMVDoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBzLT5jaGFubmVs
c1tjaF0uY3VycmVudF9sbHQ7Cj4gK8KgwqDCoMKgwqDCoMKgIGNhc2UgSzIzMF9HU0RNQV9ETUFf
V0VJR0hUOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHMtPmRtYV93ZWlnaHQ7Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqAgZGVmYXVs
dDoKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiJXM6IG5vdCBpbXBsZW1lbnQgZ2RtYSBhdCBv
ZmZzZXQgMHglIgo+IEhXQUREUl9QUkl4Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgIlxuIiwgX19mdW5jX18sIGFkZHIpOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gK8KgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKgIH0gZWxz
ZSB7Cj4gK8KgwqDCoMKgwqDCoMKgIGNoID0gKGFkZHIgLSBLMjMwX0dTRE1BX0NIX0JBU0UpIC8g
SzIzMF9HU0RNQV9DSF9TVFJJREU7Cj4gK8KgwqDCoMKgwqDCoMKgIGNoX29mZiA9IChhZGRyIC0g
SzIzMF9HU0RNQV9DSF9CQVNFKSAlIEsyMzBfR1NETUFfQ0hfU1RSSURFOwo+ICvCoMKgwqDCoMKg
wqDCoCBpZiAoY2ggPCBLMjMwX0dTRE1BX05VTV9TRE1BX0NIQU5ORUxTKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3dpdGNoIChjaF9vZmYpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjYXNlIEsyMzBfR1NETUFfQ0hfQ1RMOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBLMjMwX0dTRE1BX0NIX1NU
QVRVUzoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHMtPmNoYW5uZWxz
W2NoXS5zdGF0dXM7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIEsyMzBfR1NETUFfQ0hfQ0ZHOgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gcy0+Y2hhbm5lbHNbY2hdLmNmZzsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNhc2UgSzIzMF9HU0RNQV9DSF9VU1JfREFUQToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldCA9IHMtPmNoYW5uZWxzW2NoXS51c3JfZGF0YTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2Ug
SzIzMF9HU0RNQV9DSF9MTFRfU0FERFI6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXQgPSBzLT5jaGFubmVsc1tjaF0ubGx0X3NhZGRyOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBLMjMwX0dT
RE1BX0NIX0NVUlJFTlRfTExUOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
ID0gcy0+Y2hhbm5lbHNbY2hdLmN1cnJlbnRfbGx0Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVmYXVsdDoKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0KPiDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoMKgwqDCoCB9Cj4gwqAK

