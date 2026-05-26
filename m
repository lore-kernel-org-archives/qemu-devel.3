Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B30CD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 23:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS1TJ-0000Kk-0g; Tue, 26 May 2026 19:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1TE-0000GC-Bu; Tue, 26 May 2026 19:46:00 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1TB-0003yA-7Z; Tue, 26 May 2026 19:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779839156; x=1811375156;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4UNPKOK1OYDijz4g8oLmmn+PRPKKgebqj2jTbPSAiuQ=;
 b=bgMmojEbf7MvHlvDDrFJ49B28pI+NVq+7kOMTwaRUYCF3oKS41PgrMt4
 jQRYwTHTjhELWtGSLoLnyfr9keTF7pahkXdZEK8SGbegGbSAkNX0MwkRw
 r9Ka/4jPamqK5I0XU7eN967ecbNS7BTwxbVJ9qHMA8BQ1YLNqbwLFgIt1
 09Xdrce6p6Ojf9Fp+x61A/NNfEJ26jwVDpKseKNKi5gLctAgqRovZvlMt
 Ng389+wk9nRJB4f0Ftqg31wENkCJ1X5uoHyrYMWxGhoRXduH+HsYrk+RJ
 D1N0/GEpARAOnMjuNw262xbciCndtM38maN+ZkyikSRFybeSiU9iWxAWp A==;
X-CSE-ConnectionGUID: 5AeWcRiVRky3el1Sbo0ibQ==
X-CSE-MsgGUID: Kuke4AxkRrKFxwzqUmoorw==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="147467783"
Received: from mail-southcentralusazon11011041.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.41])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 07:45:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpnEyIgHz1mIKkaZbPXYfb3vT7+wOxpPfcuGVHhx8/aO/LqbmcHCW1qA0AvU3ojAiYn1gd5FHsWYf/7ll3iC1JgQtagCNEm8Ko4p/LsgLlx33AXRkpKpm+pxJZMtYDnWt3ShYiqHzM5Up26XF3Kk5qeS+B4QgBg/bmnPCmgUBVLjyHbjYlceW7H95nsGZWUWrPJY18CLIcARhm6sBSB46LqAyUwg/go4zbn2Z1O0KDljzMY8MB+BD2ulGChDSJ9VV8/2tIc9DiXei3SNesUQrkyg+9s9YSJ5B3SJyYu3n01pNa5ZMxh6xNepi6TRNnq+pPpNUBFqAr+Om8vKL1a+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UNPKOK1OYDijz4g8oLmmn+PRPKKgebqj2jTbPSAiuQ=;
 b=HWguEulYZ3RoI8LU9HuZ0seVoOJsPSEKjkz2joHgPo1mBuxBisZ2lfa71VBFHIausDtSTL73HNCu4NLKecovTQCC4+J7yyshlh8dCbo9JmksTDY4GvQHnIfY6d0I6SLzGOf+w6n1pSS69sJJ+2ofWApDl/XYappeyniJUoV1r7qBfcpTLI8TcuZUYa6pUUpsQfrJa9cZGW0zN9a3B9vNmgoPTcX74Tj+9Uj7j0hl3MNx+laEFLAmeA+rCp6fSquWpZpwsPfqD1uanjQE6WwnO/tnCZA//9O7tpBLGF0SEsaghvH3FS1/mZrrOxDKnJxS4/2ivsw0U5/d1VD9NXl3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UNPKOK1OYDijz4g8oLmmn+PRPKKgebqj2jTbPSAiuQ=;
 b=WMUJNFVALD5CAHd21TOtX9LV+to+iKCsE517NSp4fhjdclGRdJRlxSCZmGvDMz4HE/1zEpw79aS7zC5nTtIwdEEqyKhrvqiB7cM9hohzxdSgLApgXcuPjaxucLvfo6OmQe3cbMkR2zcxHYlLbAsbbl0uvyNlQo461uLMh1L2/wQ=
Received: from CH5PR04MB9550.namprd04.prod.outlook.com (2603:10b6:610:20e::17)
 by DS0PR04MB8618.namprd04.prod.outlook.com (2603:10b6:8:126::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 23:45:49 +0000
Received: from CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31]) by CH5PR04MB9550.namprd04.prod.outlook.com
 ([fe80::2dd5:1dc8:e3e7:5d31%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 23:45:49 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "anjo@rev.ng" <anjo@rev.ng>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "philmd@linaro.org" <philmd@linaro.org>
Subject: Re: [PATCH v3 00/14] single-binary: Compile hw/riscv once
Thread-Topic: [PATCH v3 00/14] single-binary: Compile hw/riscv once
Thread-Index: AQHc6FnATayLZWme7EiIEzIixE3+qrYhAtuA
Date: Tue, 26 May 2026 23:45:49 +0000
Message-ID: <2504fe2db3442329f649544ebe82ed7a02d6d548.camel@wdc.com>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH5PR04MB9550:EE_|DS0PR04MB8618:EE_
x-ms-office365-filtering-correlation-id: 65a2025f-b271-451e-e3dd-08debb80ea8b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|19092799006|366016|6133799003|22082099003|18002099003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: eTMsiTjTmWqJglak3vI/dotdmxQ37+lvf36kBtbKIVo66Qyd1/VJu2p4llKO150kfif56RwHq52aOJk0uM1j6mzAYDcNIj+TN6Pk4S9YKED8lE6aZ8HQsL45+23Lgq3YKCsTr1uP75f06NDJKVTVfLf1hGvqT1fWKoEYW5JaDoj0679EPAAoae2FDOcSVgh58YGXk0BaNTyNd5fGd/+VECZlEKqfGS6kE24eQ9bxDeudhuY3lXssJDWVAwlekqVdjNEhMmjv0bvwiaYah4NrKSI/zl1lRnfJVtuPk2R32pM7/u4HPYnHKO8/teCuyFdFt7HpbqU8kDzyqjgbWI/TG+JQ7z03nDIbFpJqWJjXuOZoiL+4+DS02qRASF16berPRxOxCUAlOu9CJoiGBURwTfwrVZYfOrUadycx8m8L/Giw22oOo/RRJqH7uzviKOqMsZKbxDUWQrrC9yNVlROoc16a9f932I1j8rR367CFlkGpUY04h3tGnkFUMKyiFBjyaAracghMDIFtZDCIFTLHMr3qNVAGkzyQvRSdA0GNh6J9p30FfOGblzIJM1zUxeGn2/36dSx7QMzgpa+/o9jO2Pb6n53cxQmvC/WF9mbXnd71RqRcw8y+2P6HXctDMzRjYpanbMmYphM+wINsRDfjcBzWCcXg+mGsUh6iOE8tuVNnbGAw7OnAUqPO0zkH1eUR5k60CBeaILqCJld6+ebMkFd5efBjCq9aTetAfmQOehpuO0+/F255fFEBAcqpTRmh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH5PR04MB9550.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(19092799006)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFZSOTRiNnlKOFhUT0NhSXRKUUJiaUEzbWhzOUxma0lDcTltbUFRSkdTV3p3?=
 =?utf-8?B?eitneEt2d09zTW1nNDlKTWNzUFoxTUhmdTdJV2VSUytxYnYybmFiazRzV09Q?=
 =?utf-8?B?VExQV2dLcHdMejI0L2FlamlZeTByalBGOUVGa3FxSUZBV3VnUGJKZnJWU2F0?=
 =?utf-8?B?VkQ4VnI4MHZiT1JWZGh4YkNTbmtkSnVlSENUMGlQUENwQlVBSTBsL1pzSGg4?=
 =?utf-8?B?Ri9ibERwSE1KMFZrYzluOTAwYm5EM0ZHbHdYbGFTYVE2RFZ0QTNjR3lTYlky?=
 =?utf-8?B?R21Kamh3Tmp1bWxoemRHRTM5Wm8zYlFWV2VNbjJvZ09FbnJncTlKWDE0bTc4?=
 =?utf-8?B?b2ZGQ2JoWDMrWWJsUEQvMkNJUEtoRFdPOUhFZFp6L1VtTWNET0E3U3J3SHlH?=
 =?utf-8?B?azdZbUN3d2xnbElGSWFOUDNxeUcyZ0lvWnR4NGVDT3liNThWNGRqQlEzRUVX?=
 =?utf-8?B?YXhiNXdYcG1yYjYvOEdRMThiM1FxcFQ3cnVPVjNWYzI4dzVmVDBJampCWGNz?=
 =?utf-8?B?bkQwditzUWFmc1V0M0ViU1J0UlZMT1Yxam9LRmROR3QxZmRnWjVkSFJxdzUy?=
 =?utf-8?B?R1FiakpUeDRLUEhxWERzcHdoNS9Qc2o3V0M3NzlwSFA0cVh6YmZxc0pjMkFM?=
 =?utf-8?B?RWZ0ZUZxem1qWnNjS25MOVJLeXY1ck9IS0pNTUlBQitCU2VUSzMxeGgrMGov?=
 =?utf-8?B?ZVJkcEQyWW9qZDFPQXJwWUNucVQ4QndrWnhsQXRyQXdacTNiZ09MdVVTS3FC?=
 =?utf-8?B?RnN5eVgrU3M2cEwyZTF6ZEtXcEhsOVpaQVUzWXo1WGZEaUVYK3crSW9iUkpB?=
 =?utf-8?B?SWRmdkFIVnlpWDNkS3Rmb0U4eHRvY2k1bUZ2YmtFRTZqK1JYS21pVmVxRkIw?=
 =?utf-8?B?b0JLaVhuZmZWc1ZTczhzdlQ2eXhONzNFTG1TbXlBaU1WeVBxV1pvUkZXWjY5?=
 =?utf-8?B?L3BxT1B1YTFUSWRVZElEcU9VaTBGbU9nKzhvKzhjak1KMWZuZmZmSE5pZ1JV?=
 =?utf-8?B?OEdUNzJURmppbC9XNFkrSlNYNFFBdEFsWXZ6N0NlSnJXQ2IzOEpxTklFOExD?=
 =?utf-8?B?VDl6TTkyeEhCeFN3bmRYRzVvbWttREx4N0xtdU0wMmJxYkVZRG85UWl4dXkz?=
 =?utf-8?B?ZDBpZFZkUnBzbkxGU2xqQWpDWUJ0TkdnQU5aTWt2ZU9ZYXdJbENkajF4YUFC?=
 =?utf-8?B?b05Xc2NNV0V6NzBYK2c1RzJiekRTa0prZnpyS2JhOUl0WWo0MW1xV3ptQ09N?=
 =?utf-8?B?d24rTFNDWXNVSU9DUU1HSWhTV3NmTWJMVk8xbDh5TStIS0hvWURvU29PaFYx?=
 =?utf-8?B?SS8xMXBwOUdYMnh2bEorQmhpOUxXSE1jSXhGNnc4VXhNeTk5cW5mNy93TDBB?=
 =?utf-8?B?dVcvTzkvblZENVVrcDhCdW8wRVdMeExtS1IxWVJuQTRzN2RFR0o5dWFjS2ha?=
 =?utf-8?B?N3FYZUhzYnFGam83a3pITDd3b0dDR2lDaU9qZmRDdlh1TWhhMmZSV245YVk3?=
 =?utf-8?B?VmRPQklrTEFpcVJqbWF3VjA0WEFudXVGTFRNVHdRZWxhNTNxR3hZamk5QVFL?=
 =?utf-8?B?eGxUaWM0QmwzVkJvd1JBdmJwOFBZbTBpUytRZjFYRXdLaDZ1ODl4NWpGN3c1?=
 =?utf-8?B?MTVPbHNQdTVFMkJ0Zmg4SE9lOHFuTTdKM24wdHRVVWh6TithY3lCRGNKKzhQ?=
 =?utf-8?B?a3QzUXpwcU5WamhQZU5PRlBZcG51eGdkck53ODl4MFYrQmxiOTcvK21iOTVo?=
 =?utf-8?B?QXVZbEVQbkxMSlh3ZE9ocVNua3B0aloyRzk1aHNXK3E5dHkwd3pNNEU4MFZO?=
 =?utf-8?B?ejg1V2ozRi9pOVFwTXFOR2tBNklDL1dlWXZsNnRWN0dQUUpFMVR5OHlQYjZE?=
 =?utf-8?B?M1psc2Z1amZIcVFQNko5VVlzelRHN09uQUxNQXJKRWFjT3FrRjQ0b2w4RDZ5?=
 =?utf-8?B?K2k0VjhHK2V1VzZKVldPcW1KNWZ1NUVJVXFQckJmM21TcHhnOHNyeFhqZHVh?=
 =?utf-8?B?aURwcFBIVy8xbWhqaGQ1Ui81dnJpNkxLbHA4Q3A2Q1UzMHd6VVgzR2xJaXVP?=
 =?utf-8?B?YVZKY0lzS2ovMWthTWkzYlVCd3Z2cWkvWHAwVWVNZFQ0VUd2VUtoUUhZeDdz?=
 =?utf-8?B?S09lK21qdmlrbndUQ3p1Q3lVZ1k2ZVl6SERzL3BjR1hhWSt1VmdHeVNNOUo3?=
 =?utf-8?B?ZGhYWWkwUGNhdHpxbEw4L25RZllpODY4REhYMUdRbDFkS1RyYjFpL0dWZ1Fi?=
 =?utf-8?B?VURwTWtRaVFQMjFaK2ovay9hTDZEdXlxWTFtK1A1RnR1WVVCdnl1dXV2clUr?=
 =?utf-8?B?TFAwNElXclN5ZFRsa1NlRC9tK0FudDcwcWdZME9uNHpxNnRxM2Q4OVRxSGg3?=
 =?utf-8?Q?zJs7LNMXhtnQMpHGgxrU7SF6qU76bzSFTMBLgwzOpc1xb?=
x-ms-exchange-antispam-messagedata-1: ZpjPZLiE/qmIwGZbfle7vTe8ppk8jgmVRKM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CDC0935A9A18147A0A72DAD3EE7187B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BfOVA/fuM6BrEffkNZc9gYMJzH6YomTSx/AdfNhFPTVT5oYYbd2a82xhSHtus1v3nxykKnL4/pmgsWl7191QYsGq1mJLRdMkW21RXnPfibjowPLMl4Cibs8qhuhuFXU315eQmtFND7isdtEE0oyIwvHEmJm79PMRk4Dacp4T25nDoNbApDXZx2x9nxakvdfTqB/B8j7W7BBfmnEB/kBJzagEGwn76zCTf6WaOxdQbER99wX2gmxWADKDa6bg0c1QFRKaeUO3lcDKhvbtdosMV4HyY0uIVKzSwf3n2K+irPtcw3KdWaLsx0k8xCfa33eAWnZMpbpYR6BTRuHYGOfGSw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w2+G5/NaHBM8IX+cl+/1WyE1KnuHhtlelL2FawwjKNCYM0xGXyi2AVWrfwsxy+UNev0r+F+RgsMFDYcxZeGWFN7HyeYmrS9233lOexwNb/EL7Mv5jhma5XoYLy99GfP/PYQnV2aFaYVYUoZfwX1clPKx49NC+l5/exfWu8vkSbcBtrtv2MbNw4aKn6bP1vtVobXQ4Wu8/OkiWcghkhFunc9yvNf8XiNeqmCPMkaOJFkJpnun98f4lvIaxx8xN7k2EbyFrFF5rrwvBMLffGbyiGqNpplEg8JrECmzUFehc2DODXPG7wNXuFahgxXl7AEmsuLYpZH9eSVOnwoL1lhjZdfZhT7lhqEmzXHDrdU2G1cWmix0ZYIK0BWuy7T8Pn5wmoU27Lcknen9VpzkCLAwDIgGRjQQkbAmt7cIosNj/vfYaZdVJincNdQiu92I+w4Qq6YBPLvK24Ks6aOp20xZoRs9qPiKAdLT2NDo6GcvMP/rld5JyJjqAMCLUj66FZlUQeDLH23cUjc9chLLUWY2RSsA0gZbqn2viw8BJgkAc4UfH6VEMsxh//8BPAlUJQkvmak3CZGS/sLqnTiu35NG7t3FG61Gh7chP84iL3dHEh0zREJwzbpAAJpdODtyDOdr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH5PR04MB9550.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a2025f-b271-451e-e3dd-08debb80ea8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 23:45:49.8408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LE+nlSciWKz60oduaUOCL6mpd7I3SncDJPtEvYqHpGhe4cA6GRiKLR39Jgb09BVeRKIymVRNpw0sMDwAq5/32mIzp42hSIgWn5dxunpQrTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8618
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=599a94ef2=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTA1LTIwIGF0IDE1OjEyICswMjAwLCBBbnRvbiBKb2hhbnNzb24gd3JvdGU6
CgpBbHNvIHBsZWFzZSBzZW5kIHBhdGNoZXMgdG8gYWxsIHBlb3BsZSBsaXN0ZWQgdW5kZXIgdGhl
IFJJU0MtVgptYWludGFpbmVycywgb3RoZXJ3aXNlIG5vdCBldmVyeW9uZSBlbmRzIHVwIHNlZWlu
ZyB0aGUgbWVzc2FnZXMuCgpBbGlzdGFpcgoKPiBDb21waWxlcyBody9yaXNjdiBhIHNpbmdsZSB0
aW1lIGZvciBib3RoIHFlbXUtc3lzdGVtLXJpc2N2MzIgYW5kCj4gcWVtdS1zeXN0ZW0tcmlzY3Y2
NCBieSBhZG9wdGluZyB0aGUgVGFyZ2V0SW5mbyBBUEkgYW5kIGJ5IG1vdmluZwo+IG1hY2hpbmUg
ZGVmaW5pdGlvbnMgdG8gZ2VuZXJpYyBRT00gaW50ZXJmYWNlcy4gVGhpcyBpcyB0aGUgc2FtZQo+
IGFwcHJvYWNoCj4gYXMgdGFrZW4gYnkgUGhpbGlwcGUgaW4KPiAKPiDCoMKgwqAgInNpbmdsZS1i
aW5hcnk6IE1ha2UgaHcvYXJtLyBjb21tb24iCj4gwqDCoMKgICgyMDI1MTAyMTIwNTc0MS41NzEw
OS0xLXBoaWxtZEBsaW5hcm8ub3JnKS4KPiAKPiBBbGwgaW4gYWxsLCB0aGUgbnVtYmVyIG9mIGNv
bXBpbGF0aW9uIHdoZW4gYnVpbGRpbmcgYm90aAo+IHJpc2N2WzMyfDY0XS1zb2Z0bW11IGlzIHJl
ZHVjZWQgYnkgMTEsIGFuZCB0aGUgYmluYXJ5IHNpemUgb2YKPiBxZW11LXN5c3RlbS1yaXNjdlsz
Mnw2NF0gaXMgaW5jcmVhc2VkIGJ5IDAuMTElIGFuZCAwLjAyNiUKPiByZXNwZWN0aXZlbHkKPiAo
Y29ycmVzcG9uZGluZyB0byA2NWsgYW5kIDE0ayBieXRlcykuCj4gCj4gVGhpcyBwYXRjaHNldCBp
cyBiYXNlZCBvbjoKPiAKPiDCoMKgwqAgInNpbmdsZS1iaW5hcnk6IE1ha2UgcmlzY3YgY3B1Lmgg
dGFyZ2V0IGluZGVwZW5kZW50Igo+IMKgwqDCoCAoMjAyNjA1MjAxMjU0MDYuMjg2OTMtMS1hbmpv
QHJldi5uZykuCj4gCj4gQnJhbmNoIHBhc3NpbmcgQ0kgY2FuIGJlIGZvdW5kIGhlcmU6Cj4gCj4g
wqAgaHR0cHM6Ly9naXRsYWIuY29tL0FudG9uSm9oYW5zc29uL3FlbXUvLS9waXBlbGluZXMvMjIx
NTUzNjc3OAo+IAo+IFNpZ25lZC1vZmYtYnk6IEFudG9uIEpvaGFuc3NvbiA8YW5qb0ByZXYubmc+
Cj4gLS0tCj4gQ2hhbmdlcyBpbiB2MzoKPiAtIERyb3BwZWQgbWVyZ2VkIHByZXF1aXNpdGUgcGF0
Y2hzZXRzLgo+IC0gcGF0Y2ggNS8xNCAiY29uZmlncy90YXJnZXQ6IEltcGxlbWVudCBwZXItYmlu
YXJ5IFRhcmdldEluZm8KPiBzdHJ1Y3R1cmUKPiDCoCBmb3IgcmlzY3YiOiBVc2UgbmV3IHRhcmdl
dF9pbmZvX2luaXQoKSBUYXJnZXRJbmZvIHJlZ2lzdHJhdGlvbi4KPiAtIHBhdGNoIDcvMTQgInRh
cmdldC9yaXNjdjogUmVwbGFjZSBUWVBFX1JJU0NWX0NQVV9CQVNFIjogUmVuYW1lCj4gwqAgdmly
dF9kZWZhdWx0X2NwdV90eXBlKCkgLT4gcmlzY3ZfZGVmYXVsdF9jcHVfdHlwZSgpIGFuZCBkZWZp
bmUgaW4KPiDCoCBtYWNoaW5lcy1xb20uaC4KPiAtIERyb3BwZWQgcGF0Y2ggIltQQVRDSCB2MiAx
MS8xNF0gdGFyZ2V0L3Jpc2N2OiBNYWtlIHBtdS5oIHRhcmdldC0KPiBhZ25vc3RpYyI6Cj4gwqAg
VGhpcyBwYXRjaCByZXBsYWNlZCB0YXJnZXRfdWxvbmdzIHdpdGggcHJpdmlsZWdlX21vZGVfdCBh
bmQgaGFzCj4gYmVlbiBmb2xkZWQKPiDCoCBpbnRvIHRoZSBwcmVyZXF1aXNpdGUgcGF0Y2hzZXQg
aW50cm9kdWNpbmcgdGhlIHR5cGVkZWYuIAo+IC0gQWRkZWQgcGF0Y2ggMTIvMTQgInRhcmdldC9y
aXNjdjogTW92ZSB0YXJnZXRfbG9uZy5oIGluY2x1c2lvbgo+IMKgIGF3YXkgZnJvbSBjcHUuaCI6
IE1vdmVzIHRhcmdldF9sb25nLmggaW5jbHVzaW9uIHRvIHRhcmdldCBzcGVjaWZpYwo+IMKgIGhl
YWRlci4gCj4gLSBMaW5rIHRvIHYyOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvMjAyNTEyMjEtaHctcmlzY3YtY3B1LWludC12Mi0wLWViNDlkNzJjNWIyZkByZXYubmcKPiAK
PiBDaGFuZ2VzIGluIHYyOgo+IC0gSW5saW5lZCBzaWZpdmVfY3B1LmggcnVudGltZSBmdW5jdGlv
bnMgYW5kIHJlbW92ZWQgaGVhZGVyCj4gKFBoaWxpcHBlKTsKPiAtIE1vdmVkIElSUV9MT0NBTF9H
VUVTVF9NQVggbWFjcm8gdG8gZmllbGQgaW4gUklTQ1ZDUFVEZWYgKFBoaWxpcHBlKTsKPiAtIEFk
ZGVkIHJldmlld2VkLWJ5czsKPiAtIExpbmsgdG8gdjE6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI1MTIxNy1ody1yaXNjdi1jcHUtaW50LXYxLTAtZDI0YTQwNDhkM2Fh
QHJldi5uZwo+IC4KPiAKPiAtLS0KPiBBbnRvbiBKb2hhbnNzb24gKDE0KToKPiDCoMKgwqDCoMKg
IGh3L3Jpc2N2OiBSZWdpc3RlciBnZW5lcmljIHJpc2N2WzMyfDY0XSBRT00gaW50ZXJmYWNlcwo+
IMKgwqDCoMKgwqAgaHcvcmlzY3Y6IEFkZCBtYWNyb3MgYW5kIGdsb2JhbHMgZm9yIHNpbXBsaWZ5
aW5nIG1hY2hpbmUKPiBkZWZpbml0aW9ucwo+IMKgwqDCoMKgwqAgaHcvcmlzY3Y6IEZpbHRlciBt
YWNoaW5lIHR5cGVzIGZvciBxZW11LXN5c3RlbS1yaXNjdjMyLzY0Cj4gYmluYXJpZXMKPiDCoMKg
wqDCoMKgIGh3L2NvcmU6IEFkZCByaXNjdlszMnw2NF0gdG8gIm5vbmUiIG1hY2hpbmUKPiDCoMKg
wqDCoMKgIGNvbmZpZ3MvdGFyZ2V0OiBJbXBsZW1lbnQgcGVyLWJpbmFyeSBUYXJnZXRJbmZvIHN0
cnVjdHVyZSBmb3IKPiByaXNjdgo+IMKgwqDCoMKgwqAgdGFyZ2V0LWluZm86IEFkZCB0YXJnZXRf
cmlzY3Y2NCgpCj4gwqDCoMKgwqDCoCB0YXJnZXQvcmlzY3Y6IFJlcGxhY2UgVFlQRV9SSVNDVl9D
UFVfQkFTRQo+IMKgwqDCoMKgwqAgdGFyZ2V0L3Jpc2N2OiBSZW1vdmUgaWZkZWZzIGluIGNwdS5o
Cj4gwqDCoMKgwqDCoCB0YXJnZXQvcmlzY3Y6IFJlcGxhY2UgVEFSR0VUX0xPTkdfQklUUyBpbiBo
ZWFkZXIgZXhwb3NlZCB0bwo+IGNvbW1vbiBjb2RlCj4gwqDCoMKgwqDCoCB0YXJnZXQvcmlzY3Y6
IE1vdmUgcmlzY3ZfcG11X3JlYWRfY3RyKCkgdG8gaW50ZXJuYWwgY3NyLmgKPiBoZWFkZXIKPiDC
oMKgwqDCoMKgIHRhcmdldC9yaXNjdjogU3R1YiBvdXQga3ZtIGZ1bmN0aW9ucwo+IMKgwqDCoMKg
wqAgdGFyZ2V0L3Jpc2N2OiBNb3ZlIHRhcmdldF9sb25nLmggaW5jbHVzaW9uIGF3YXkgZnJvbSBj
cHUuaAo+IMKgwqDCoMKgwqAgaHcvcmlzY3Y6IERlZmluZSBTaUZpdmUgRS9VIENQVXMgdXNpbmcg
cnVudGltZSBjb25kaXRpb25zCj4gwqDCoMKgwqDCoCBody9yaXNjdjogQ29tcGlsZSBvbmNlCj4g
Cj4gwqBpbmNsdWRlL2h3L3Jpc2N2L21hY2hpbmVzLXFvbS5owqDCoCB8IDU4Cj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gwqBpbmNsdWRlL2h3L3Jpc2N2L3NpZml2
ZV9jcHUuaMKgwqDCoMKgIHwgMzEgLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gwqBpbmNsdWRlL2h3
L3Jpc2N2L3NpZml2ZV9lLmjCoMKgwqDCoMKgwqAgfMKgIDEgLQo+IMKgaW5jbHVkZS9ody9yaXNj
di9zaWZpdmVfdS5owqDCoMKgwqDCoMKgIHzCoCAxIC0KPiDCoGluY2x1ZGUvcWVtdS90YXJnZXQt
aW5mby5owqDCoMKgwqDCoMKgwqAgfMKgIDcgKysrKysKPiDCoHRhcmdldC9yaXNjdi9jcHUuaMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQ0ICsrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4gwqB0YXJnZXQvcmlzY3YvY3B1X2JpdHMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCAyIC0tCj4gwqB0YXJnZXQvcmlzY3YvY3NyLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDMgKysKPiDCoHRhcmdldC9yaXNjdi9pbnRlcm5hbHMuaMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMSArCj4gwqB0YXJnZXQvcmlzY3YvcG11LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDIgLS0KPiDCoGNvbmZpZ3MvdGFyZ2V0cy9yaXNjdjMyLXNvZnRtbXUuYyB8IDI2
ICsrKysrKysrKysrKysrKysrKwo+IMKgY29uZmlncy90YXJnZXRzL3Jpc2N2NjQtc29mdG1tdS5j
IHwgMjYgKysrKysrKysrKysrKysrKysrCj4gwqBody9jb3JlL251bGwtbWFjaGluZS5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArKwo+IMKgaHcvaW50Yy9yaXNjdl9pbXNpYy5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0ICsrLQo+IMKgaHcvcmlzY3YvYm9zdG9uLWFpYS5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICstCj4gwqBody9yaXNjdi9taWNyb2JsYXplLXYt
Z2VuZXJpYy5jwqDCoCB8wqAgNSArKy0tCj4gwqBody9yaXNjdi9taWNyb2NoaXBfcGZzb2MuY8Kg
wqDCoMKgwqDCoMKgIHzCoCAyICsrCj4gwqBody9yaXNjdi9vcGVudGl0YW4uY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAyICsrCj4gwqBody9yaXNjdi9zaGFrdGlfYy5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArKwo+IMKgaHcvcmlzY3Yvc2lmaXZlX2UuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUgKysrLQo+IMKgaHcvcmlzY3Yvc2lmaXZlX3Uu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDkgKysrKy0tCj4gwqBody9yaXNjdi9z
cGlrZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArKy0KPiDCoGh3
L3Jpc2N2L3ZpcnQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSAr
KystCj4gwqBody9yaXNjdi94aWFuZ3NoYW5fa21oLmPCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIg
KysKPiDCoHRhcmdldC1pbmZvLXFvbS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgIDkgKysrKysrCj4gwqB0YXJnZXQtaW5mby5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqAgNSArKysrCj4gwqB0YXJnZXQvcmlzY3YvY3B1LmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNCArKysrKysrKy0tCj4gwqB0YXJnZXQvcmlzY3Yva3Zt
L2t2bS1zdHViLmPCoMKgwqDCoMKgwqAgfCAyMyArKysrKysrKysrKysrKysrCj4gwqB0YXJnZXQv
cmlzY3YvbWFjaGluZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE3ICsrKysrKysrKysrKwo+
IMKgdGFyZ2V0L3Jpc2N2L3BtdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAx
ICsKPiDCoGNvbmZpZ3MvdGFyZ2V0cy9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoCB8wqAgMSArCj4g
wqBody9yaXNjdi9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMzYgKysr
KysrKysrKysrLS0tLS0tLS0tLS0tCj4gwqB0YXJnZXQvcmlzY3Yva3ZtL21lc29uLmJ1aWxkwqDC
oMKgwqDCoCB8wqAgMSArCj4gwqAzMyBmaWxlcyBjaGFuZ2VkLCAyNTQgaW5zZXJ0aW9ucygrKSwg
MTAxIGRlbGV0aW9ucygtKQo=

