Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF21EC9830E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB1i4-00057R-0G; Sun, 27 Sep 2026 23:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB1hp-00055W-PO; Sun, 27 Sep 2026 23:07:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB1hn-0003Rr-BF; Sun, 27 Sep 2026 23:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790564823; x=1822100823;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=n73BAL9P9YHmniCA6wjBcISfcz0ZxolHh58/C6SrZQA=;
 b=XwhITd+UuBQIh83/ZNnDzjoZDqby8XHDHOAEqOD9S0ZViuQnNQ3oHvsE
 ThgR2zJtd8q4JIlEwAWhwO6kLKm+62zgNd/ycbfQaz+r8ZLZAu7u8ps3p
 RNNupzQ5Jk5rzjgV7bw6kAEXmPew5RAcytgfVqdEy/gFlGEkTVGgX7JJ6
 eBGShISAiF9MHQsu7BLw38IGCylPq2eriHH1PwCjo6RBpqwUrawMftHAB
 Ot5910D+cIYddRCywqH1fPCFS/gpLpMA6KjWVX3uUB4WmXpOASOUJkGMR
 Or1/rV7i/bBVpSwq5ALteDxw5ne5ZcfVoGZ2iR7s5IBlT+te8Ln7hP2q2 Q==;
X-CSE-ConnectionGUID: 4DPpdDrAQdGwI153XFiAaw==
X-CSE-MsgGUID: ViY/f5dCTxew6+kXV6S+Gg==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="157645181"
Received: from mail-northcentralusazon11013036.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.36])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 11:07:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbcRelASs1KCH82ZcrMSbKj+M4itmJ6St76egQZYj0t2WQWNdBkA+5L6uK3zuqskg4Z+LJemIu7YTihBjlxgvZduc3MPBsdHbl+R5CWac49nGsf2VJLz48FdWVtc/j8/qsyP2Xw/0MeyCUl2FYHCdwljnSn2vwwyxLUBFULS9gtVyIdZqveA6iaDnpgsED5yTFcLoHHZHMq5vTWuPIAbkaVw1UjnOhtB061WjVqvMQ6endaN16lp7EgCmPJsSAO9OmaP7RotRE65fnWZKzi8lwQ50VIMeLGGjmBp3dtrw7Jb0PrDDWt28TGR4gq4qrEL4/wYbtGjqOwXE3E3+IQasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n73BAL9P9YHmniCA6wjBcISfcz0ZxolHh58/C6SrZQA=;
 b=G09UJM1+nC0OTWCcmI36UmTA6CyJOA/0eza1M43vLu0j84xNIzYpNm0KsGfVHM52dWRHrQmsqw5laOzcaJFxBVCGwt9do1qzEbtfas74j7HHkPT5r+3bZs0EoBfOqJ5vBVFrztNX254twy42GKTWShoYJozpH3ElsQMt5cNiEW8QgajfwZjnNPBMW4cUTMI7c3NCxmluugOzaJ14jyhK5KFnfct0BOYTh/d7vmNV7Zo91X+BVUtIlG6TmSS63CU/Stnh8aeDvsnawEpAUU1UgYgIxckzvCEtTCwSwPMk6W8/qDbdbYH7bZ0y4jezqJpOdp9t68IkUhhntV3BF4WUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n73BAL9P9YHmniCA6wjBcISfcz0ZxolHh58/C6SrZQA=;
 b=Z+zs3O07zMy66W10MX9N9N7AgMpo8uEt1Lzvx5o84zBTeziNIwQia5WqdQJhBX7Fwksrb2awLZ4U8u0EPC2AOZkVAF8eWOHwuuWPPUZCXGJFrsSZy8GwKq4uscq4SFdsiKMMZqAteiV5cq+kqDhjIUMH5hwts+I8ytYJSexUFZc=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SA3PR04MB8645.namprd04.prod.outlook.com (2603:10b6:806:2fa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 03:06:57 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:06:57 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "tangtao1634@phytium.com.cn"
 <tangtao1634@phytium.com.cn>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v9 3/7] target/riscv: add dret instruction
Thread-Topic: [PATCH v9 3/7] target/riscv: add dret instruction
Thread-Index: AQHdQGpaOBJTsNJuP0qml/3CKPhS+LbjbAEA
Date: Mon, 28 Sep 2026 03:06:57 +0000
Message-ID: <963e26dccb67ea207d85efa10a5c93e936e33387.camel@wdc.com>
References: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
 <20260909144841.1766921-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260909144841.1766921-4-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SA3PR04MB8645:EE_
x-ms-office365-filtering-correlation-id: 152e7d2f-3243-4559-94a3-08df1d0d8ebc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|19092799006|23010399003|366016|376014|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003|18092099006|38070700021|3023799007|10086099003;
x-microsoft-antispam-message-info: xCckgzKseL+k3nUsnYo7fROEe31tqh2EKErV+gJYPxOVX46yAwiPnWFMh4nhgBwsNouxIoVueN018q1w93LIrMtpDcGxzIlQomPtIqE65ITlP7ETGBaChAPx9vUGwMr8vLwC6ct3lONewdEgNEvjRJ1pJuM6uACwn+73sQenKIQ6wYEDBe2iuuM8QfZRXKYpba0/PPOb2a88SUXP58jrnY3KdbMx7DtlsRKLE+aCqhZgF8DPC3HPLG3OnxfqQ3Fvy3L+OsPOBIYWBHbDXgcvt9Kshz8O8c8NxsVt4/KyfomJvuujlGjhg7kkEC3q0iHAY/VAtOQWNrjjZgoOKjD1sf/fW1T0loRJrcgYrE2YfhOMRJWw9Ed+FMpjTBzG0LU7FPcUSA36oZ3wFzEB8a5sRfoIdW7Uw6hPJAXA2wBOaibWqMeuV1+LURRHHVs2ym5ytyL4IbZNKW+HGtgFov+c5bQOBuEmnO4y/rpk5Bgg4pKoSVEQU2Sc0VroyjwWwdDQ8fn/7wuQS/Utx9deD5IIAuQXxaMH0nP8dfwlKO6EeK9vCKh9pV3fC2YfJRmiBkbyWk3t6XfmQWrx3AuVHVzh3EA2TKUsG4kht8JxZOPZtDFGnH8XOT2vlmySrknkTHY3zEGGPTZl2REVcO9sBxFhTC8HOqB7mclo1C9evElT30weN0Y28yHl5AP3OWLiRa1pr0znCeainBBvMlEIeqUSJPqmePCGeVrDNEWMicJ9nfg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(19092799006)(23010399003)(366016)(376014)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(18092099006)(38070700021)(3023799007)(10086099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWIrZnZLTnRGMjFITHFDc0hTRUhwSEY3QldxamRocFR5eWZ5dFJEc0xIeXBr?=
 =?utf-8?B?VVdiUHBFYlNXUGVQN1JPTlRiZm9LQ0lnUGtqNk9zRk56NmF6dHNQMEhzeG9n?=
 =?utf-8?B?d1VwYXFvRkJFMUs3OEE0QnB6QkV2NnhLSXN3ZTBHZlFQTnZtNUhQOVEzTFho?=
 =?utf-8?B?ejd6WnFSeXpKM0d3dkdOK1NUTzg2VW5zZUhyOUVDKytWQ0Ftd1NxNjFhODEw?=
 =?utf-8?B?dGVwSm1BZDJIM1l6MkFaejJybVVIdlJhQW9JTW8wdG5JWFN1WTh1VjdpL0Jn?=
 =?utf-8?B?NGhCWElWUXRwaEJURmlBT2tDVndHREk5akhOV2wwbCs1UE9kODJVSU1JR0Ri?=
 =?utf-8?B?MzN1Z0N5ZHhVMnkzUGxDYzEybHRGV0RqdjJ4OUhJcXE0UEgyVTMrd2F2bW5Q?=
 =?utf-8?B?UlRTTHVKM2xzdnJST21JWlpHN3VQeSttajA3SFJqRllkeVVlY2FyVXB5RlRo?=
 =?utf-8?B?TzI2Q2tkQk03Sk5URVdZN1RCTU9nTVNJL1cxVUpETCsybHVOcmJXYWlldEhH?=
 =?utf-8?B?aVZ3MnpSQ2k2R2YzR2t6ajc0SXI4UnpiSnR5R2tCSVp4OERLYU1jTFZ0R0Zo?=
 =?utf-8?B?eWVmVHhhR3RuQlRBenpBaWdzV3pXS1ZmZVF0OWhsNzNuNVhHa0J1YzFGazMw?=
 =?utf-8?B?YXdKb0FrbFl0YUZ3Ri9hYWdPSFdGRUVwVE03aUpUQ2pCRDNhSnhTb2xPUlQ3?=
 =?utf-8?B?T1RYSmJOWWlINHVrc1BvcFB0c0JHZHQvZFlBNWt2MTVOVlB4eTU5THk5QjBy?=
 =?utf-8?B?NFdnbVhFQU1GZUtjWU1wb0dhWkg1b25uZmdDeW9meG5EMWluQ1Y1NDB0bEpN?=
 =?utf-8?B?dk9NdXpvd3dIeEIzQ2dQemNOdDJSNXczZm9xMFA2aHFlZEo1UFpyNHZwOFRC?=
 =?utf-8?B?MVdPbUVRV20xTmZoVEtKemxXSll1RnZ5RzN0VlZGN3V3cmpHRk93b1JZZlRo?=
 =?utf-8?B?cHZIQnFBNytUMXhEN2pJMXlhbDhLY2dQOGd4c0RVWEVmK3V6cS9BZHBIL0Rk?=
 =?utf-8?B?bHZXcHl5dHROTnhCRUcwSEhVeHIzZDdkVlpWNisvWkI4NUFrYnV5K2dlV3NR?=
 =?utf-8?B?SWZBeWo1VDFSeGFYd1lvOWVvYUR1VCszY3gvWHlPdnpJbElsTXdLSmpDVlFV?=
 =?utf-8?B?QUkwdUJqRWdseWp5UDBGcGUzSnBuc01MMk9iczF6NDdZNUNTcndCUDY4eHYy?=
 =?utf-8?B?ZEFlSkRvZ1VtUExidkpIMFFtaitMUDZYTi93TXJ1dVoyYjJLSkg2cStlSm5q?=
 =?utf-8?B?cVFEdkVyWEl1eWp1U3YrRFU5TzdFUWdLbytqTWdrTTZoY09rZnphdUd6Tzh3?=
 =?utf-8?B?UUhJeEJNUWQxTTk4VlpvNjJsZFphSXJpL0NGMExYK1JaaW1JcDQ5RkZCdmtE?=
 =?utf-8?B?NzV6dkR5U1NicWluMGQ5Rmt4RVR1TTFFV3BCWGRpOW9GZndFQ0FFeEU4TUhR?=
 =?utf-8?B?N1JtSlEyWHNxOVQ4bW5hZURrWjRQT0JoV2V3eitKblplbWVhYU1hcm9Kc3RS?=
 =?utf-8?B?NVlKMHphVTB1aU5VSkpYd1Z5T0hXUk1TdnY5ek4zNUs5VEtPbEhCNCtycmdt?=
 =?utf-8?B?Tm01STREQ0tWZHM5dmV5dEdYZ3JqNEIxRTRYaklSZmlPVUt6VkZZSFV2ZnE2?=
 =?utf-8?B?cmdJS2xLekNaWCtISGVRcGg3TlVQNzN3NEN4ckpmcU9wdkVFZlFpOUpkTGNR?=
 =?utf-8?B?d2hsd2gwc3dlT2YrUWl4TGVOS3RqYWRMQlA4azRiR0UwbG1QZEJmOWl3SkRj?=
 =?utf-8?B?THhnbVdhQnZsVVpUd1ltN2d2bWtVdUJqR3VwVzREQjdrWnhoTE4xNjRBSHlX?=
 =?utf-8?B?SnZiQ3BwL1ZzRHc2ekoxVTdrLy85eE5zMEpoMFVRTXF5ckYzSml3UHZqOXVn?=
 =?utf-8?B?UHkwck9yWDYxczNVSi9iQUc0a09Ed0pOT29GRUFZNTZUQ0NQS2RPaW1GUkRB?=
 =?utf-8?B?WEdHYVYyVmhiaWVEVnlvQThLaDRvd0pSYzQrZUlJOE5BSU9TUkZTSHVKb2FT?=
 =?utf-8?B?YWM3MUR3UU83N1R2TmdlTXhMYXpNRTJUR1NRbml6dUlCY0QrenowTDZBMVBx?=
 =?utf-8?B?ejA3cU95c2YvYVowYjFsOS96TFdIckJmTjByQ0p5UytXdy9uQ2thSXl0NTY3?=
 =?utf-8?B?NHc1WW1UcE8yaVNLYjZlcUpxQzlHOWo2UTM0Y29yM3RlYzhQOWVGM2ZLN1F4?=
 =?utf-8?B?QThxMGJBVWk2YmxGQ1JuZVh5TVhQT3FjN2JYRW14OTJPdHY5V3FEV3E5Q0ha?=
 =?utf-8?B?aFJCS2s2aUk1cFRmdU5ockZ6Nzdsb1N1T3dBcHEyZFp1WE0rUUpkbkhqejll?=
 =?utf-8?B?VEt4TmRsc2lIU0RWdnRPdGhTdmlTSzJZcGV4K0p0SjAwR0dQVGtnV2hKYUpF?=
 =?utf-8?Q?9sCj/LZKUNDX6Vc3ZCzbevckx1wbuLlDqPDc+D/qILlIC?=
x-ms-exchange-antispam-messagedata-1: L1c/gEZsFlz3swQ1vSZmbxV1skUYNOAVzOE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B46DC50445D5245A9F55AA94EE24CBB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uIk8t1CacQKSfO4TmH98lnItyvEstnmB69NjfDhioX76A79JoCToPkLVcwYe19IMF6yO0MbLM6tSLqob9RthSVyBPDHCz9siIrStUohyXw99pAToZYkpH0MQYDa+lN19NANlZag2lRvqsx/IRLVL7CgouNXd/nnJMhjNiSyVGvt8DPlCTdW7CGgFDAB7mxlonkdqL34/KBpoa6bXNd5MsRjJZF5uKwwY/Zxs1Rh79zvQdHdwPEhTJ+NgX3xaRlZyppmeA7fMhHsqqtVYivdI4zFJ9XgwWViss/ynJtRWVnQ/WL7oTvM0E0ITg8CNqKIEgbaQ9tm7esBXGVOtPwj69w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AxeaqEJ80+8OAkA72HA8uunyeWzYVp277Z87W95A5dlaNu5UyCdEmIRS6HG/CWZbB/6v1iKmAVYIl7ROGlilt9QMLLLsWEvYrxWjGd8EAejqAXn0ob8Ei4HuC0w/UVNCq6GzK0/p2vl87DfrcgqW8e9q2d7XmO240PnLWq1JP98YID3dEm944HajvoDKhnXCRLmzcYbVxEKQfP3pUN6jxr4PrA4864sXPwZBPjBDXb8KdOBK3tkfdV95xWpmXrPmSRYwHYNxb4HZF7V6+L4uVPCZzHKWujiFTC8XuT+4FGpCVLfGk9vJ/FeNKYBGarD29HRX6SPrHSnuxz7NL1PlaLADytCN5c2w4Y6Ul1ZFwvtYNj1vmySbv7maqTOr5+VmVA7v0TxI0VK2O2xVez3WbD7JI82USTwiS2LdfidLWLHR0OXB7eKzmmjjXPPgzpR0ozmwuEOrriDO5dH5ktH4AoY6vVmH8Vn3wQRUkrpJj1iBAMSHqwVpR6AokgMiRfSPefRDbm+WTPgHn/TBTmyG3J0JY0ARlNh1HPdQVDd6Lp5ja+Zov5GDOTAe7DxHS2GMKXVVd+bC9+MWE7ejYBmyTHnBeBo8Ac7zgDklRDXKiEDQCN85CSKZIFLRfgf9/swC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152e7d2f-3243-4559-94a3-08df1d0d8ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:06:57.6373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wk5rhU/lFesB0z5hBIbeP0pd9bx44oTrQYBdI3nnupnqPXc5zpzfGw+TcpwICQaj+Qx5EYnSLqodTMmJOZAXV/sZb0V4irWkGby7/SMAbQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8645
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gV2VkLCAyMDI2LTA5LTA5IGF0IDExOjQ4IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gRnJvbTogQ2hhbyBMaXUgPGNoYW8ubGl1Lnpldm9ybkBnbWFpbC5jb20+DQo+
IA0KPiBSSVNDLVYgRGVidWcgU3BlY2lmaWNhdGlvbjoNCj4gaHR0cHM6Ly9naXRodWIuY29tL3Jp
c2N2L3Jpc2N2LWRlYnVnLXNwZWMvcmVsZWFzZXMvdGFnLzEuMA0KPiANCj4gQWRkIERSRVQgZGVj
b2RlL3RyYW5zbGF0ZSBhbmQgYSBoZWxwZXIgdG8gbGVhdmUgRGVidWcgTW9kZSBhbmQgcmV0dXJu
DQo+IHRvIGRwYy4gRXhlY3V0aW5nIERSRVQgb3V0c2lkZSBEZWJ1ZyBNb2RlIHJhaXNlcyBpbGxl
Z2FsIGluc3RydWN0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBMaXUgPGNoYW8ubGl1
Lnpldm9ybkBnbWFpbC5jb20+DQo+IFJldmlld2VkLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YQ0KPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCj4gVGVzdGVkLWJ5OiBUYW8g
VGFuZyA8dGFuZ3RhbzE2MzRAcGh5dGl1bS5jb20uY24+DQo+IFNpZ25lZC1vZmYtYnk6IERhbmll
bCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0K
DQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRhcmdldC9yaXNjdi9oZWxwZXIuaMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqB0
YXJnZXQvcmlzY3YvaW5zbjMyLmRlY29kZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDEgKw0KPiDCoC4uLi90Y2cvaW5zbl90cmFucy90cmFuc19wcml2aWxlZ2Vk
LmMuaW5jwqDCoMKgwqDCoCB8IDE4DQo+ICsrKysrKysrKysrKysrKysrKw0KPiDCoHRhcmdldC9y
aXNjdi90Y2cvb3BfaGVscGVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCAxNiArKysrKysrKysrKysrKysrDQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2hlbHBlci5oIGIvdGFyZ2V0L3Jp
c2N2L2hlbHBlci5oDQo+IGluZGV4IDRmYzJkM2ExNTUuLmI0YzQ3ZDA3MzggMTAwNjQ0DQo+IC0t
LSBhL3RhcmdldC9yaXNjdi9oZWxwZXIuaA0KPiArKysgYi90YXJnZXQvcmlzY3YvaGVscGVyLmgN
Cj4gQEAgLTEzMiw2ICsxMzIsNyBAQCBERUZfSEVMUEVSXzYoY3NycndfaTEyOCwgdGwsIGVudiwg
aW50LCB0bCwgdGwsDQo+IHRsLCB0bCkNCj4gwqAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4g
wqBERUZfSEVMUEVSXzEoc3JldCwgdGwsIGVudikNCj4gwqBERUZfSEVMUEVSXzEobXJldCwgdGws
IGVudikNCj4gK0RFRl9IRUxQRVJfMShkcmV0LCB0bCwgZW52KQ0KPiDCoERFRl9IRUxQRVJfMSht
bnJldCwgdGwsIGVudikNCj4gwqBERUZfSEVMUEVSXzEoY3RyX2NsZWFyLCB2b2lkLCBlbnYpDQo+
IMKgREVGX0hFTFBFUl8xKHdmaSwgdm9pZCwgZW52KQ0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jp
c2N2L2luc24zMi5kZWNvZGUgYi90YXJnZXQvcmlzY3YvaW5zbjMyLmRlY29kZQ0KPiBpbmRleCBh
YTAyZGFlM2M5Li40NmIwMDQxMWZmIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvaW5zbjMy
LmRlY29kZQ0KPiArKysgYi90YXJnZXQvcmlzY3YvaW5zbjMyLmRlY29kZQ0KPiBAQCAtMTE4LDYg
KzExOCw3IEBAIHNjdHJjbHLCoMKgwqDCoCAwMDAxMDAwMDAxMDDCoMKgwqDCoCAwMDAwMCAwMDAg
MDAwMDANCj4gMTExMDAxMQ0KPiDCoHVyZXTCoMKgwqDCoMKgwqDCoCAwMDAwMDAwwqDCoMKgIDAw
MDEwIDAwMDAwIDAwMCAwMDAwMCAxMTEwMDExDQo+IMKgc3JldMKgwqDCoMKgwqDCoMKgIDAwMDEw
MDDCoMKgwqAgMDAwMTAgMDAwMDAgMDAwIDAwMDAwIDExMTAwMTENCj4gwqBtcmV0wqDCoMKgwqDC
oMKgwqAgMDAxMTAwMMKgwqDCoCAwMDAxMCAwMDAwMCAwMDAgMDAwMDAgMTExMDAxMQ0KPiArZHJl
dMKgwqDCoMKgwqDCoMKgIDAxMTExMDHCoMKgwqAgMTAwMTAgMDAwMDAgMDAwIDAwMDAwIDExMTAw
MTENCj4gwqB3ZmnCoMKgwqDCoMKgwqDCoMKgIDAwMDEwMDDCoMKgwqAgMDAxMDEgMDAwMDAgMDAw
IDAwMDAwIDExMTAwMTENCj4gwqBzZmVuY2Vfdm1hwqAgMDAwMTAwMcKgwqDCoCAuLi4uLiAuLi4u
LiAwMDAgMDAwMDAgMTExMDAxMSBAc2ZlbmNlX3ZtYQ0KPiDCoA0KPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3ByaXZpbGVnZWQuYy5pbmMNCj4gYi90YXJn
ZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcHJpdmlsZWdlZC5jLmluYw0KPiBpbmRleCBh
OGVhY2NlZjY3Li40ZTU3OTAxODgwIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2lu
c25fdHJhbnMvdHJhbnNfcHJpdmlsZWdlZC5jLmluYw0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNn
L2luc25fdHJhbnMvdHJhbnNfcHJpdmlsZWdlZC5jLmluYw0KPiBAQCAtMTI1LDYgKzEyNSwyNCBA
QCBzdGF0aWMgYm9vbCB0cmFuc19tcmV0KERpc2FzQ29udGV4dCAqY3R4LA0KPiBhcmdfbXJldCAq
YSkNCj4gwqAjZW5kaWYNCj4gwqB9DQo+IMKgDQo+ICtzdGF0aWMgYm9vbCB0cmFuc19kcmV0KERp
c2FzQ29udGV4dCAqY3R4LCBhcmdfZHJldCAqYSkNCj4gK3sNCj4gKyNpZm5kZWYgQ09ORklHX1VT
RVJfT05MWQ0KPiArwqDCoMKgIGlmICghY3R4LT5jZmdfcHRyLT5leHRfc2RleHQpIHsNCj4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsNCj4gK8KgwqDCoCB9DQo+ICvCoMKgwqAgZGVjb2Rl
X3NhdmVfb3BjKGN0eCwgMCk7DQo+ICvCoMKgwqAgdHJhbnNsYXRvcl9pb19zdGFydCgmY3R4LT5i
YXNlKTsNCj4gK8KgwqDCoCBnZW5fdXBkYXRlX3BjKGN0eCwgMCk7DQo+ICvCoMKgwqAgZ2VuX2hl
bHBlcl9kcmV0KGNwdV9wYywgdGNnX2Vudik7DQo+ICvCoMKgwqAgZXhpdF90YihjdHgpOyAvKiBu
byBjaGFpbmluZyAqLw0KPiArwqDCoMKgIGN0eC0+YmFzZS5pc19qbXAgPSBESVNBU19OT1JFVFVS
TjsNCj4gK8KgwqDCoCByZXR1cm4gdHJ1ZTsNCj4gKyNlbHNlDQo+ICvCoMKgwqAgcmV0dXJuIGZh
bHNlOw0KPiArI2VuZGlmDQo+ICt9DQo+ICsNCj4gwqBzdGF0aWMgYm9vbCB0cmFuc19tbnJldChE
aXNhc0NvbnRleHQgKmN0eCwgYXJnX21ucmV0ICphKQ0KPiDCoHsNCj4gwqAjaWZuZGVmIENPTkZJ
R19VU0VSX09OTFkNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmMN
Cj4gYi90YXJnZXQvcmlzY3YvdGNnL29wX2hlbHBlci5jDQo+IGluZGV4IDNlOTQwMDVkMmIuLjU0
MjY5ZWZlZTEgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmMNCj4g
KysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9vcF9oZWxwZXIuYw0KPiBAQCAtNDczLDYgKzQ3MywyMiBA
QCB0YXJnZXRfdWxvbmcgaGVscGVyX21yZXQoQ1BVUklTQ1ZTdGF0ZSAqZW52KQ0KPiDCoMKgwqDC
oCByZXR1cm4gcmV0cGM7DQo+IMKgfQ0KPiDCoA0KPiArdGFyZ2V0X3Vsb25nIGhlbHBlcl9kcmV0
KENQVVJJU0NWU3RhdGUgKmVudikNCj4gK3sNCj4gK8KgwqDCoCB1aW50cHRyX3QgcmEgPSBHRVRQ
QygpOw0KPiArI2lmZGVmIENPTkZJR19VU0VSX09OTFkNCj4gK8KgwqDCoCByaXNjdl9yYWlzZV9l
eGNlcHRpb24oZW52LCBSSVNDVl9FWENQX0lMTEVHQUxfSU5TVCwgcmEpOw0KPiArwqDCoMKgIHJl
dHVybiAwOw0KPiArI2Vsc2UNCj4gK8KgwqDCoCBpZiAoIXJpc2N2X2NwdV9jZmcoZW52KS0+ZXh0
X3NkZXh0IHx8ICFlbnYtPmRlYnVnX21vZGUpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHJpc2N2X3Jh
aXNlX2V4Y2VwdGlvbihlbnYsIFJJU0NWX0VYQ1BfSUxMRUdBTF9JTlNULCByYSk7DQo+ICvCoMKg
wqAgfQ0KPiArwqDCoMKgIHRhcmdldF91bG9uZyByZXRwYyA9IGVudi0+ZHBjICYgZ2V0X3hlcGNf
bWFzayhlbnYpOw0KPiArwqDCoMKgIHJpc2N2X2NwdV9sZWF2ZV9kZWJ1Z19tb2RlKGVudik7DQo+
ICvCoMKgwqAgcmV0dXJuIHJldHBjOw0KPiArI2VuZGlmDQo+ICt9DQo+ICsNCj4gwqB0YXJnZXRf
dWxvbmcgaGVscGVyX21ucmV0KENQVVJJU0NWU3RhdGUgKmVudikNCj4gwqB7DQo+IMKgwqDCoMKg
IHRhcmdldF91bG9uZyByZXRwYyA9IGVudi0+bW5lcGM7DQo=

