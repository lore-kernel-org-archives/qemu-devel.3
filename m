Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60562C44506
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 01:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj5Xm-0002SS-Ef; Sun, 12 Jul 2026 21:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=64731fbe4=Alistair.Francis@wdc.com>)
 id 1wj5Xk-0002S1-QP; Sun, 12 Jul 2026 21:33:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=64731fbe4=Alistair.Francis@wdc.com>)
 id 1wj5Xi-0001Qw-1j; Sun, 12 Jul 2026 21:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1783906391; x=1815442391;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=5vxBbXT3DbTPT0cUEVEsi+0E+ZlVEfrbgUnyKeGzX1A=;
 b=Y8ObAhpWeZeSaemPXiXjvZyIZrR3jRZg9rNOvdeDu2vu7K5PsXVI1gDY
 kQrA14c/0VYeLvuJT+1PXJlikRccJQNu0DMw9z63BMONWZUVEz3ojtjzJ
 Pp0lEgJdasQn5HDzwQqy1u2etohWHQrwah0LGCYdU2y2lI/8j+BZXJ09h
 tT8BYACnTuduhyo0I2caNlvqLyD7HhY0q/sO3guW9/RIQ0Nx8JXG+9/os
 JmB9AU3IAcC0m3HpoQtqbv37SsFvoJWyb6VkJNrxc8WglG/Mvm62GA83+
 8ZuX3DFn/HJZyYyDA+4ecNUbl1c3k3OLjQfawbgvJEMrNv2yBd8tU4f/H A==;
X-CSE-ConnectionGUID: VdkcpXSZTueg8glJGwvbOA==
X-CSE-MsgGUID: WQXtKKmzRZ+cwqMgnET7Dw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; d="scan'208";a="149938914"
Received: from mail-eastusazon11012064.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.64])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Jul 2026 09:33:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKZ6JbDmk1q5ignO5PlqVS/LejAfLDhlKYK4ON4ZLqk3FBdMaclNd2EvITEi8bXRSgGmXdkUhuHxXDEYtvm8l+g1nPAEmW8HCDoDJ+EbJU/KlHtT48AV3HfsGqMLA5AtSXCvjroqx5bi5dIajpnImh3FhJR7fHWB/gU0oB3AZksotIA7GUAno+6F02/vsMAUQ2VfQFWs3TcsZVB2aSGlUkNX2ucomZr/iyRqpT0Zs4vE7kPaouXli3wuDiVGQJmoWCXu7NFwLPanTcPVCm7BZ7w9y5tzWzasz2uf+n5jMoUdDgIs4ULvny1v189bwHnTmvhM0v5+A305K/PU7awPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vxBbXT3DbTPT0cUEVEsi+0E+ZlVEfrbgUnyKeGzX1A=;
 b=XFualWyC2umLpwnxlZTBTxW3iS+D5/NK+taK5Gc1AC9gQHiMueoOQv0Xcs/iNZ0asLnCh/zm/js7ELnpOO9yJDu/Ko/tQ4SG+/woyRgshr6St+NXeH6pR/fLxv6H/kPcgY3l8351lpmQNhFi6IwVyxjGwmTehAwwoiGYFuLnf8PKbtsuRQ8OW5zl684yExxB82KixCrb6OgBIvvQSZgAK1ONxdEPMzm4MuYkX/f6XCwOE5hbZBSYO+9XQbh5LUoA0xYqE3p/g7JR61mI9AxqQbqiR5NfTzPgXvSSdJ03+C2HVWfIbfQuNCXSYVc66MX8oSSHHEPMokMHLGjomG+Ntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vxBbXT3DbTPT0cUEVEsi+0E+ZlVEfrbgUnyKeGzX1A=;
 b=ot+trYDdU0Iog9duIeg+aBKqFQKR7AhL34QNiABt/5OQHj2RLCGh+vZr4pVsZhDtiFHmtVLOjVX6LZTOWqHt3qzfMUfJRuVpzn5d2cAzhrE8a9Gl8CriqEMgDWwzJJq+w5xwyUF8HNgBB2hlot6IvwY1bKvMch6g8PXuzMTcU5M=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SA0PR04MB7194.namprd04.prod.outlook.com (2603:10b6:806:e2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 01:33:02 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 01:33:02 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "flamboyant.h.01@gmail.com" <flamboyant.h.01@gmail.com>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "farosas@suse.de" <farosas@suse.de>
Subject: Re: [PATCH RFC 1/1] hw/riscv/k230: add IOMUX register block model
Thread-Topic: [PATCH RFC 1/1] hw/riscv/k230: add IOMUX register block model
Thread-Index: AQHdECNDmhRQjKqZqkC8eKuazy/xUrZqrs0A
Date: Mon, 13 Jul 2026 01:33:01 +0000
Message-ID: <4f853faa294e5005fe38b5f0a28a62032ac4f8d9.camel@wdc.com>
References: <20260710041845.67170-1-flamboyant.h.01@gmail.com>
In-Reply-To: <20260710041845.67170-1-flamboyant.h.01@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SA0PR04MB7194:EE_
x-ms-office365-filtering-correlation-id: 411baf06-73c7-4992-2cd8-08dee07eadd9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|10070799003|19092799006|1800799024|3023799007|18002099003|22082099003|6133799003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: QAZSFi+nsJjvJrU+mm1YYyT5iTg3xAfAkoTu0aY2vhPsaIfg6AFlMJE3C8sCd0ZKmsVVjdocxV0lMA+grsphF1Xm3wUYR2SQIXCFNWgv6N/laOlvLP0BwCbIbUIKCpZjZd5rRVJz6T93t1HVslPWm/3B4dn1gkBkOxH9l5OqzrZmv9dNnYE5RP5Xxo1AZZeW+QxB05XRmdxFxGryDecg/8jw9Nr1FOImnPGGZPCQH+R5a+OiG+XsfifYcbL+BZdV/2D7TiCV9zK9IY8LVmuZrQhzVGqnXB/pJKXzpHLMBLlvvGd+QaoMqp8sR/cyIa0L+Ri59bkQnl/VxkijWRqhqZ07875nNfD0F8KednJ4LaDTbqNqV41oc7wV/U7rUcxmvOs7FnynQA54yD0raxUi65FQeA6ApTJ3epabPrIGUTJonfBuyT7Izv63gz5k2P/XaNlzq9u9a/8tfCz8/yGn5BONaXYzI5s3u9Fl4xkKMrD/B2PJYfETuedF9S5W5SoD6GH7V3AJCkV0RjJnLHUsoyVAecJJt/bL3v8nVKi5ecqE/8r6r2M/UI51B/413PIuS1jtm8kHS/gZULv5KE1cW1pv7NLLSVY7RfbQI+cUoZplOkUke6GNTdusMArqmralwUkYEeI4Tl8Izts+KSiQMxy7Ewm6bcgG4uSn6v3xc/4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(10070799003)(19092799006)(1800799024)(3023799007)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2F0NkljKzExbmFWLzVCRldVQkIvdEdLeUtWd3BlN082M3E3dDBiLzBFbllX?=
 =?utf-8?B?OFVWYnQvSXZXb0ZZT2VXQ0VJejBncDNxbWdOS1ZDMGgzR01QY3VlWUNQR1pq?=
 =?utf-8?B?dW5RK1RXVGtDd2xqZHJZQ3E4YVV2V1hlY205WGllQ2NlTXRDNVBGa2s0eUdT?=
 =?utf-8?B?Y0cvUlBVQXAwNUtVT3FkTFY3T09pa2Myak50Q0daU296ZUlZYnA4VEwwaTF2?=
 =?utf-8?B?T21mczVjSUovTjBGbC9BcnlTNmkrb0VaZHBXSkxoZ25FdUx6eG9GbjlGSU5O?=
 =?utf-8?B?YUlFbmRXSFozSDFNb2hVUlB0Z2RBQ3RvR2FmVU9qelFmb3J3UDJIenE0WUJy?=
 =?utf-8?B?WjBhRHhRbnRSR2RRN0NpSjlqQzg3TGNpRkVZM2lxVE55Qm1qTDhzNktBbDRE?=
 =?utf-8?B?cTFYSVAvUkNvZmdDbUZoU2c5ajNhU1JVRitsZTFCd3N5MVV3K0JTbXdlZUJM?=
 =?utf-8?B?aWJGOUhWWG9qbmdycWZyYUpkTG8wSVlFemJ5U2NCTTlOdlBLYjRkS2tDa0x5?=
 =?utf-8?B?amxIazhwNEVhcGMxcXlmK0cxd0VnS21xejFybXI2WmZsOWJ6endpcTRJRzFG?=
 =?utf-8?B?MmZFcDMvd1Q1Yzc0ajdSNW1LU1ZsY3hxN3JROCs1L0FQYkZYa3JJUkdhQ0Vr?=
 =?utf-8?B?MUc4OE1hSUNTZ1NXUW1kUFNxaWhUeVovQzNYOWFtVlMyZEhPY0c0Y3ZUSWFP?=
 =?utf-8?B?QU9iTnZlZ1VPRlN5Tk9tQlNiVFJYQnhnZ2hPZFJSZFZkWFNERk1iUXd5YUFG?=
 =?utf-8?B?Z3B3QjVLdXFTUGRuY3B4enZNK1ZhTThuTWZYQlU5MVVRT1dOOGhJM1MwMko2?=
 =?utf-8?B?NUp6SWszdmVkOTBjcjRHY3pJemlwdGQ0UXNTRGpYMi95STRmNVJlMHYwTWZs?=
 =?utf-8?B?NUVNLzdQSDdBbEdKMnQrc3p2bnRIVWUyUG51REh1V2wyYkp6cmYwWGNMKzNR?=
 =?utf-8?B?L0hVVDcyR0VMaFdMc2NIZ01FVjNLTUh0TkVzekJvWTA1Q1NKYlZ2a210d3lL?=
 =?utf-8?B?VmhqYWVQbkZUaVZqYUpOZG91MldPVy80UjdPR1pOdVZZU2VNVXBmZUZGS3lV?=
 =?utf-8?B?KzFNcHVHUjQ4RmlhcVFMRDVLN3ovN1pnQjNYTlUyMW1sYWRuaVNSOU9uR0lw?=
 =?utf-8?B?S3VKNlZHREFTN3B4a0xtQVp2bFpCUVlDRklVcDh3VG9YWmNnckJOZmEzNVpk?=
 =?utf-8?B?RmN4YlJmRFM0elhoUTRKM2R3V1c2VGc5alJCQjlJazlIUG9QR09kWGV0a3NK?=
 =?utf-8?B?VDJlbm1Wa1lGeUt0VW5KQ1E3UThiSVE4SkpGUU04V243NjdmS1hPUlYvTVkr?=
 =?utf-8?B?cTlOVDdMNHdYazdpODg3MUNONnRtelozZlhudTNXQ1FmQytKL2p6MzdQSkkz?=
 =?utf-8?B?OEh5QUUxU3g0WDBDcHpKOHBCVlgzaWZIMEs2YnRjcmJzaVhsVGFLNEgxcXMv?=
 =?utf-8?B?VndaMmZLOW95cVVjdWFiUzZlRXJVSitHZUVIeEViRVROOHNBRmVidEZNQVg4?=
 =?utf-8?B?TEhxNW5FNERMVm5reWhMVGg1WXF2SFVXOG1ic2pkU3MvQlE2QUxFdXBwNFZy?=
 =?utf-8?B?VEhLNDM5NFppNXZ2djdxazcwN3hFUHBCQjFxN1FvNTNZekdRU3NheHZvZFRk?=
 =?utf-8?B?UzZzSksreGF6WDd5L0tpb2dKc2tYaE5GT2RzaDN3WnVEWW1DYmp3OXNrbzhp?=
 =?utf-8?B?U3B0T2dmNHZDSFZlVi9EZkUyMExTSStQYVcvdUZtd1FGQkNSZndQMWFmek5z?=
 =?utf-8?B?L0hjZHRvU2dGaWJXZVZHRHVEaGw5Y0c2cFJKSVVTWXRFcHBYSEdUU3VBT25K?=
 =?utf-8?B?YnIvT1d0cnRlRGhFdGRwbTNQbXJZdTFSamx2d3BHamhlNlI3ekgvcmtISFdP?=
 =?utf-8?B?VExuZzdtbTNqTk1wbE5ZMFU5THlLRlVoOHZvR2R6cXFMcU5HZWRzbnJQeTUw?=
 =?utf-8?B?MGRYdTBMRnM2cE5tRDlNVkpPTi9wbDQxNmQ5UStpZWFEK3J3cXcwakNWQUpD?=
 =?utf-8?B?SVhZUFBZeFRGSVNuWDZoMnlWamRnTHpvRFh6SlZtNUpyOGhVcmd1YUplZ3V0?=
 =?utf-8?B?YTJua1pTTWZTV24wSUMreHpvY21XeklPb2kvS2hkQm1BeTZLVmVCTzJ3b3FR?=
 =?utf-8?B?UVFSdXJMS0tIZ0xmZzlTMWZyS0xpV3Rrb3J0WUlCZFlEbHRGb1hMVnNkemRx?=
 =?utf-8?B?Z0JsaUZFYzBBaG91UUxWcTBDWkoxcnlvM1h2N3RJVWNjN2wvRHgxS2hUWlFP?=
 =?utf-8?B?SGlmL05HZjRhQkR4WUtoSngzTUFoZHBRd0hFdEM3YWtNcFJrYjZPMk1peDNh?=
 =?utf-8?B?amhCcGdNdGg3RHNONjlBMG5NVUYzWHd0Tlc3bWpVV1dvSUV2WlBwQlZZS1dt?=
 =?utf-8?Q?LBuVH/drzMud1hEioHub/G2RAeGDKOIE2+zkQkDlMBpBC?=
x-ms-exchange-antispam-messagedata-1: /pvfE85zJCFPdlNIfUtuz9qtcVi+riPXymg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC8D01327E0BF0488CCB5ADE368C15B0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GrKi7Q/2YRBwMQglqx7/UzeOCfxnVxa9jPCQ1tr3VTFvspgaglAON0NYPLWUkuAHQeJXeZd59oxfbt5ybzl9omwABjwYoH6hQFI6BT66p4MglA3gF3dnX+GPLFYDgyRiYgqKTUPnBEwfSX6gLGPGlqrn244/iJGWaO/k4NYMuUyhAfc/nV/P3he4YO3N/Z0SR9ddgHr7DkTPYmEoXlRia2YdzlunzmKEmU6yJGO6hrcu8k7sarquNtw0bIDoYpUf78rMVn2/N9N5a1QJGWRnrDQdX74PjStqak1aOXlZMn6I3dzT/VpdFZUWIS/jxezG2f1h6VtUrAouDN4/YjS7kg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NWSFGmBlnXm3mpRzFBSmAWlkGx1JajnslR4MFQo4y+RzlEomw9xOl9CZrDGR4W1DH6K0krcyh8YjL5rpqng+QvCaJePplXrRIjsz+FNhw4Txxi9OJ+0d47uZ4YuJ18rkOj93RUmm2ntcD91PPPbejU3oG22HoXbnrY6bz4GJJenTvBM6Df3SSFhZ3ZBFJ835ZAJQAgtQmIc2cky5HRzXzo8WyPvQeGpl01s4eYZzm8oPczuG9P366ARFNocamJJDFBH25z4foyW9qJy376POfHO41LtCiBzP/8dFsNoY21+0pYXcBoK57Ici1rCv31Fqyo9XNSGgBgsLSzNgrvlUibMxBkYQRvxlkpTkyefUNXF7fNFxnPzQDXoDkDAGDbQLPCgfRQbro3P4wgXR+dIiDAtKxc5Hkw0Baz+d1i5yVKYc8dlLGd3ObbWJgRidOb/33lk2rywFimCGPMClo6DVyp0j08m7Z3RXdGJOsjEW6xrV+pa5idpmJ0Ao88pq3JA1I6vx2USwF4+fXajyzaJJKk4Kr7bMfPcKKO+sO+oA4cpDjMUgDUOxSegiYHsKNdyhZizaeO/agkljieL+Drixold4pBAhbeE7Qz9hZcpcurKf6AX1t+56Pb6VnTU59dGD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411baf06-73c7-4992-2cd8-08dee07eadd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 01:33:01.9841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vokxy+OuL/GZj0NZz0xlSod4pGDqfZhzdvaCG3ABp1nTpRvWpEAaUjHyRyMGfTqDkrQnBGOAVEw0TcgQlcKmUsMojuHTWwwNtWa5C1OXp34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7194
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=64731fbe4=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTA3LTEwIGF0IDEyOjE4ICswODAwLCBLYW5namllIEh1YW5nIHdyb3RlOg0K
PiBBZGQgYSBzeXNidXMgbW9kZWwgZm9yIHRoZSBLMjMwIElPTVVYIE1NSU8gcmFuZ2UgYXQNCj4g
MHg5MTEwNTAwMC0weDkxMTA1N2ZmLiBUaGUgbW9kZWwgZXhwb3NlcyB0aGUgRnVuY3Rpb24gSU8g
cmVnaXN0ZXJzDQo+IHdpdGgNCj4gdGhlIHJlc2V0IGRlZmF1bHRzIGRvY3VtZW50ZWQgYnkgdGhl
IEsyMzAgVGVjaG5pY2FsIFJlZmVyZW5jZSBNYW51YWwNCj4gYW5kDQo+IGtlZXBzIDMyLWJpdCBn
dWVzdCB3cml0ZXMgdmlzaWJsZSB0byBmaXJtd2FyZSBhbmQgdGhlIG9wZXJhdGluZw0KPiBzeXN0
ZW0uDQo+IA0KPiBUaGlzIGlzIGVub3VnaCBmb3IgU0RLIFUtQm9vdCdzIHBpbmN0cmwtc2luZ2xl
IGRyaXZlciwgd2hpY2ggcHJvZ3JhbXMNCj4gdGhlIGJvYXJkIHBpbiBjb25maWd1cmF0aW9uIHdp
dGggMzItYml0IHJlYWQtbW9kaWZ5LXdyaXRlIGFjY2Vzc2VzLg0KPiANCj4gV2lyZSB0aGUgZGV2
aWNlIGludG8gdGhlIEsyMzAgU29DIGFuZCBhZGQgcXRlc3QgY292ZXJhZ2UgZm9yIHJlc2V0DQo+
IHZhbHVlcywgcmVhZC93cml0ZSBzdG9yYWdlIGFuZCBzeXN0ZW0gcmVzZXQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBLYW5namllIEh1YW5nIDxmbGFtYm95YW50LmguMDFAZ21haWwuY29tPg0KPiAt
LS0NCj4gUkZDIG5vdGVzOg0KPiAtIFRoaXMgaXMgbXkgZmlyc3QgUUVNVSB1cHN0cmVhbSBzdWJt
aXNzaW9uOyBmZWVkYmFjayBvbiBwYXRjaA0KPiBzdHJ1Y3R1cmUNCg0KVGhhbmtzIGZvciB0aGUg
cGF0Y2gNCg0KPiDCoCBhbmQgbW9kZWxsaW5nIGJvdW5kYXJpZXMgd291bGQgYmUgYXBwcmVjaWF0
ZWQuDQo+IC0gVGhlIG1vZGVsIGNvdmVycyB0aGUgSU9NVVggTU1JTyByYW5nZSAweDkxMTA1MDAw
LTB4OTExMDU3ZmYuDQo+IC0gSXQgaXMgaW50ZW5kZWQgdG8gc2F0aXNmeSBTREsgVS1Cb290IHBp
bmN0cmwtc2luZ2xlIHJlZ2lzdGVyDQo+IGFjY2Vzc2VzLg0KPiAtIFBNVSBJT01VWCBhbmQgcGh5
c2ljYWwgcGluIHJvdXRpbmcgYXJlIGludGVudGlvbmFsbHkgbm90IG1vZGVsZWQuDQo+IC0gVGVz
dGVkIHdpdGggcXRlc3QgYW5kIFNESyBVLUJvb3Qgc21va2UgdGVzdC4NCj4gDQo+IMKgZG9jcy9z
eXN0ZW0vcmlzY3YvazIzMC5yc3TCoMKgwqAgfMKgwqAgMSArDQo+IMKgaHcvbWlzYy9LY29uZmln
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICsNCj4gwqBody9taXNjL2syMzBf
aW9tdXguY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDEzOA0KPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+IMKgaHcvbWlzYy9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDIgKw0KPiDCoGh3L21pc2MvdHJhY2UtZXZlbnRzwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDQgKw0KPiDCoGh3L3Jpc2N2L0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqDCoCAxICsNCj4gwqBody9yaXNjdi9rMjMwLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxMSArKy0NCj4gwqBpbmNsdWRlL2h3L21pc2MvazIzMF9pb211eC5owqAgfMKgIDM0ICsr
KysrKysrKw0KPiDCoGluY2x1ZGUvaHcvcmlzY3YvazIzMC5owqDCoMKgwqDCoMKgIHzCoMKgIDIg
Kw0KPiDCoHRlc3RzL3F0ZXN0L2syMzAtaW9tdXgtdGVzdC5jIHwgMTA3ICsrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+IMKgdGVzdHMvcXRlc3QvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqAgfMKg
wqAgNSArLQ0KPiDCoDExIGZpbGVzIGNoYW5nZWQsIDMwNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL2syMzBfaW9tdXguYw0KPiDC
oGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2MvazIzMF9pb211eC5oDQo+IMKgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0L2syMzAtaW9tdXgtdGVzdC5jDQoNCkdlbmVyYWxs
eSB5b3Ugd2lsbCB3YW50IHRvIHNwbGl0IHRoaXMgdXAgbW9yZS4gVXN1YWxseSBvbmUgcGF0Y2gg
dG8gYWRkDQp0aGUgbW9kZWwgYW5kIHRoZW4gYSBzZWNvbmQgcGF0Y2ggdG8gY29ubmVjdCBpdCBh
bmQgYSB0aGlyZCBwYXRjaCBmb3INCnRlc3RzLg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZG9jcy9z
eXN0ZW0vcmlzY3YvazIzMC5yc3QgYi9kb2NzL3N5c3RlbS9yaXNjdi9rMjMwLnJzdA0KPiBpbmRl
eCBjZWE4MjAyZTU1Li5iMTYwYzQwMWZkIDEwMDY0NA0KPiAtLS0gYS9kb2NzL3N5c3RlbS9yaXNj
di9rMjMwLnJzdA0KPiArKysgYi9kb2NzL3N5c3RlbS9yaXNjdi9rMjMwLnJzdA0KPiBAQCAtMjAs
NiArMjAsNyBAQCBUaGUgYGBrMjMwYGAgbWFjaGluZSBzdXBwb3J0cyB0aGUgZm9sbG93aW5nDQo+
IGRldmljZXM6DQo+IMKgKiBQbGF0Zm9ybS1MZXZlbCBJbnRlcnJ1cHQgQ29udHJvbGxlciAoUExJ
QykNCj4gwqAqIDIgSzIzMCBXYXRjaGRvZyBUaW1lcg0KPiDCoCogNSBVQVJUDQo+ICsqIEsyMzAg
SU9NVVggcmVnaXN0ZXIgYmxvY2sNCj4gwqANCj4gwqBCb290IG9wdGlvbnMNCj4gwqAtLS0tLS0t
LS0tLS0NCj4gZGlmZiAtLWdpdCBhL2h3L21pc2MvS2NvbmZpZyBiL2h3L21pc2MvS2NvbmZpZw0K
PiBpbmRleCAxNTQzZWU2NjUzLi41NzNkMjRhOWRmIDEwMDY0NA0KPiAtLS0gYS9ody9taXNjL0tj
b25maWcNCj4gKysrIGIvaHcvbWlzYy9LY29uZmlnDQo+IEBAIC0yNTcsNCArMjU3LDcgQEAgY29u
ZmlnIFhMTlhfVkVSU0FMX1RSTkcNCj4gwqBjb25maWcgWExOWF9aWU5RX0REUkMNCj4gwqDCoMKg
wqAgYm9vbA0KPiDCoA0KPiArY29uZmlnIEsyMzBfSU9NVVgNCj4gK8KgwqDCoCBib29sDQo+ICsN
Cj4gwqBzb3VyY2UgbWFjaW8vS2NvbmZpZw0KPiBkaWZmIC0tZ2l0IGEvaHcvbWlzYy9rMjMwX2lv
bXV4LmMgYi9ody9taXNjL2syMzBfaW9tdXguYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBp
bmRleCAwMDAwMDAwMDAwLi41ZjVlMmFhYzUxDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaHcv
bWlzYy9rMjMwX2lvbXV4LmMNCj4gQEAgLTAsMCArMSwxMzggQEANCj4gKy8qDQo+ICsgKiBLMjMw
IElPTVVYIHJlZ2lzdGVyIGJsb2NrIGNvbXBhdGlibGUgd2l0aCBLZW5kcnl0ZSBLMjMwIFNESw0K
PiArICoNCj4gKyAqIENvcHlyaWdodCAoYykgMjAyNiBLYW5namllIEh1YW5nIDxmbGFtYm95YW50
LmguMDFAZ21haWwuY29tPg0KPiArICoNCj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9yLWxhdGVyDQo+ICsgKg0KPiArICogUHJvdmlkZXMgdGhlIGxvdyBJT01VWCByZWdp
c3RlciBibG9jayBhdCAweDkxMTA1MDAwIHdpdGggdGhlDQo+IHJlc2V0DQo+ICsgKiBkZWZhdWx0
cyBkb2N1bWVudGVkIGJ5IHRoZSBLMjMwIFRlY2huaWNhbCBSZWZlcmVuY2UgTWFudWFsLiBUaGUN
Cj4gbW9kZWwga2VlcHMNCj4gKyAqIGd1ZXN0IDMyLWJpdCByZWdpc3RlciB3cml0ZXMgdmlzaWJs
ZSB0byBmaXJtd2FyZSBhbmQgdGhlDQo+IG9wZXJhdGluZyBzeXN0ZW0sDQo+ICsgKiBidXQgZG9l
cyBub3QgbW9kZWwgcGh5c2ljYWwgcGluIHJvdXRpbmcsIHBhZCBlbGVjdHJpY2FsIGVmZmVjdHMs
DQo+IG9yIHRoZQ0KPiArICogc2VwYXJhdGUgUE1VIElPTVVYIGJsb2NrLg0KPiArICoNCj4gKyAq
IEsyMzAgVGVjaG5pY2FsIFJlZmVyZW5jZSBNYW51YWwgVjAuMy4xICgyMDI0LTExLTE4KToNCj4g
KyAqDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9yZXZ5b3MvZXh0ZXJuYWwtZG9jcy9ibG9iL21hc3Rl
ci9LMjMwL2VuLXVzL0syMzBfVGVjaG5pY2FsX1JlZmVyZW5jZV9NYW51YWxfVjAuMy4xXzIwMjQx
MTE4LnBkZg0KPiArICoNCj4gKyAqIEZvciBtb3JlIGluZm9ybWF0aW9uLCBzZWUNCj4gPGh0dHBz
Oi8vd3d3LmtlbmRyeXRlLmNvbS9lbi9wcm9EZXRhaWwvMjMwPg0KPiArICovDQo+ICsNCj4gKyNp
bmNsdWRlICJxZW11L29zZGVwLmgiDQo+ICsjaW5jbHVkZSAiaHcvbWlzYy9rMjMwX2lvbXV4Lmgi
DQo+ICsjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4gKyNpbmNsdWRlICJxZW11L21v
ZHVsZS5oIg0KPiArI2luY2x1ZGUgInFlbXUvbG9nLmgiDQo+ICsjaW5jbHVkZSAidHJhY2UuaCIN
Cj4gKw0KPiArLyogVFJNIFYwLjMuMSBzZWN0aW9uIDEyLjkuMi4xIEZ1bmN0aW9uIElPIHJlZ2lz
dGVyIGxpc3QuICovDQo+ICtzdGF0aWMgY29uc3QgdWludDMyX3QgazIzMF9pb211eF9yZXNldF92
YWx1ZXNbXSA9IHsNCj4gK8KgwqDCoCAweDk0NCwgMHg5NDQsIDB4OTI5LCAweDkwOCwgMHg4ODgs
IDB4OTA4LCAweDk0OCwgMHg4OTAsDQo+ICvCoMKgwqAgMHg4OTAsIDB4ODkwLCAweDkxMCwgMHg4
OTAsIDB4ODkwLCAweDhhOSwgMHhhOWUsIDB4YWJmLA0KPiArwqDCoMKgIDB4YjllLCAweGI5ZSwg
MHhiOWUsIDB4YjllLCAweGI5ZSwgMHhiOWUsIDB4YjllLCAweGI5ZSwNCj4gK8KgwqDCoCAweGIx
ZSwgMHhhOTAsIDB4YWJmLCAweGI5ZSwgMHhiOWUsIDB4YjllLCAweGI5ZSwgMHhiOWUsDQo+ICvC
oMKgwqAgMHhiZDAsIDB4YmQwLCAweGJkMCwgMHhiZDAsIDB4YmQwLCAweGJkMCwgMHg4OTAsIDB4
OTEwLA0KPiArwqDCoMKgIDB4ODkwLCAweDkxMCwgMHg4OTAsIDB4OTEwLCAweDg5MCwgMHg5MTAs
IDB4ODkwLCAweDkxMCwNCj4gK8KgwqDCoCAweDg5MCwgMHg5MTAsIDB4ODkwLCAweDkxMCwgMHg4
OTAsIDB4OTEwLCAweDg5ZSwgMHg4OWYsDQo+ICvCoMKgwqAgMHg5OWUsIDB4OTllLCAweDk5ZSwg
MHg5OWUsIDB4ODkwLCAweDg5MCwgMHg4YTksIDB4OGE5LA0KPiArfTsNCj4gKw0KPiArc3RhdGlj
IHZvaWQgazIzMF9pb211eF9yZXNldChEZXZpY2VTdGF0ZSAqZGV2KQ0KPiArew0KPiArwqDCoMKg
IEsyMzBJb211eFN0YXRlICpzID0gSzIzMF9JT01VWChkZXYpOw0KPiArDQo+ICvCoMKgwqAgbWVt
c2V0KHMtPnJlZ3MsIDAsIHNpemVvZihzLT5yZWdzKSk7DQo+ICvCoMKgwqAgbWVtY3B5KHMtPnJl
Z3MsIGsyMzBfaW9tdXhfcmVzZXRfdmFsdWVzLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6
ZW9mKGsyMzBfaW9tdXhfcmVzZXRfdmFsdWVzKSk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB1aW50
NjRfdCBrMjMwX2lvbXV4X3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LA0KPiB1bnNp
Z25lZCBzaXplKQ0KPiArew0KPiArwqDCoMKgIEsyMzBJb211eFN0YXRlICpzID0gSzIzMF9JT01V
WChvcGFxdWUpOw0KPiArwqDCoMKgIHVpbnQzMl90IHZhbHVlOw0KPiArDQo+ICvCoMKgwqAgaWYg
KG9mZnNldCArIHNpemUgPiBLMjMwX0lPTVVYX01NSU9fU0laRSB8fCAob2Zmc2V0ICYgMykpIHsN
Cg0KWW91IGRvbid0IG5lZWQgdG8gY2hlY2sgdGhlIG9mZnNldCBvciBvZmZzZXQgKyBzaXplIGhl
cmUsIHRoYXQgaXMNCmVuZm9yY2VkIGJ5IHlvdXIgbWluX2FjY2Vzc19zaXplL21heF9hY2Nlc3Nf
c2l6ZQ0KDQo+ICvCoMKgwqDCoMKgwqDCoCBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiJXM6IGludmFs
aWQgYWNjZXNzIG9mZnNldCAweCUiIEhXQUREUl9QUkl4DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiBzaXplICV1XG4iLCBfX2Z1bmNfXywgb2Zmc2V0LCBz
aXplKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiArwqDCoMKgIH0NCj4gKw0KPiAr
wqDCoMKgIHZhbHVlID0gcy0+cmVnc1tvZmZzZXQgPj4gMl07DQo+ICvCoMKgwqAgdHJhY2VfazIz
MF9pb211eF9yZWFkKG9mZnNldCwgdmFsdWUpOw0KPiArwqDCoMKgIHJldHVybiB2YWx1ZTsNCj4g
K30NCj4gKw0KPiArc3RhdGljIHZvaWQgazIzMF9pb211eF93cml0ZSh2b2lkICpvcGFxdWUsIGh3
YWRkciBvZmZzZXQsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1aW50NjRfdCB2YWx1ZSwgdW5zaWduZWQgc2l6ZSkNCj4gK3sNCj4g
K8KgwqDCoCBLMjMwSW9tdXhTdGF0ZSAqcyA9IEsyMzBfSU9NVVgob3BhcXVlKTsNCj4gKw0KPiAr
wqDCoMKgIGlmIChvZmZzZXQgKyBzaXplID4gSzIzMF9JT01VWF9NTUlPX1NJWkUgfHwgKG9mZnNl
dCAmIDMpKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJP
UiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiJXM6IGlu
dmFsaWQgYWNjZXNzIG9mZnNldCAweCUiIEhXQUREUl9QUkl4DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiBzaXplICV1XG4iLCBfX2Z1bmNfXywgb2Zmc2V0
LCBzaXplKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gK8KgwqDCoCB9DQo+ICsNCj4g
K8KgwqDCoCB0cmFjZV9rMjMwX2lvbXV4X3dyaXRlKG9mZnNldCwgdmFsdWUpOw0KPiArwqDCoMKg
IHMtPnJlZ3Nbb2Zmc2V0ID4+IDJdID0gdmFsdWU7DQoNCkRvIHlvdSBvbmx5IGV2ZXIgZXhwZWN0
IHRvIGp1c3QgYWNjZXNzIGFuIGFycmF5PyBTbyB0aGVyZSBpcyBubyBvdGhlcg0KZnVuY3Rpb25h
bGl0eSByZXF1aXJlZCBoZXJlPw0KDQpBbGlzdGFpcg0K

