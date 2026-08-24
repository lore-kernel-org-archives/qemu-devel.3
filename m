Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBAFC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 00:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyIrn-00038U-Mg; Sun, 23 Aug 2026 20:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=689c12928=Alistair.Francis@wdc.com>)
 id 1wyIrm-00038J-C3
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 20:48:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=689c12928=Alistair.Francis@wdc.com>)
 id 1wyIrj-0005Dr-Kd
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 20:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787532527; x=1819068527;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=J2w4qVKNYrE0Wm8lTtJKy3foGXMcWGiBRs3eIplTurs=;
 b=h+7qslNnQucpen5bl5YnfNcFKWEn1uvqw9YRfPGR4ctcvugJRGEdZ+Xv
 H6/Vc3rSdqBuLzAnVvIENNPtdEwpha9S8MtuEpuMFzGz6tVCimavPR9Qn
 ZsRhjHYBDjzKCHFIn5XvwSi0QHTCbeDWVzMALuZRcX/vujdwp3EznHHuY
 FEzYqBC37cHDZpktRPJgapkP8Cfbgi9cdBRHOIL7YSGx2AOi65jIkOrCv
 OafSwi9FGrpzAm5oddNKipdaHm3S03ZWRq9smQYz4ASvSPtNRSrYlnZQV
 44p6ferYJdqtEY2pNa2r8s15tQgsRE+vuRNc+49V1tZhyy5mKK2Zdltgq Q==;
X-CSE-ConnectionGUID: Snw406cOSqOcrlCJYdjfqA==
X-CSE-MsgGUID: vWiyZeESS2S08tN5XFc84g==
X-IronPort-AV: E=Sophos;i="6.25,239,1779120000"; d="scan'208";a="152544369"
Received: from mail-northcentralusazon11012031.outbound.protection.outlook.com
 (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.31])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 24 Aug 2026 08:48:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z48eJ30uNG3Kr+cW/gJwKnPGlH5xaoPwP1Dt6wXZXYHq2WL2Te/c+sK6WQnhw7Q5v6CgInvbiuwBF4IQGRgn6kvRSpjEyaL8Al7MKP3OuGqypZctxtcns6kniheUzxPM9N+2rDxtpaMifA8GqLNPEsT0u4ZXrv+LKZxpQnZfBOZNiAVWcMPatSmjAkgiItAGouimyq7PnUXs7X4kqPdrrcVFERKMNEWB+c7NOSGRYzdo1Da/vuVSHgqGsihlYNxh7MfxP5kKRRy6i+xi40nIPNsV9oWrebI25KaTLFemurY4d5u1+ndTQI+zyLvMO7QMLgvZvb4ZNjkjbC1Y0G/kZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2w4qVKNYrE0Wm8lTtJKy3foGXMcWGiBRs3eIplTurs=;
 b=FWZ6F2kf8bEN8E8n8FcehTU6urEknNhNsxQ32+h4kv2C8irk4C4aVZhXfuo+YadjPNzG4VH72dMWPVezbUjWzYKizqboywVxuHL6B+rMijyHOGxTA1YY7GzflpuyyE+79Ai6c4Nqx/VRRuaSbXKttVCcYRzSj7kOvSjVaJr2DltoImViIA3IAx9PVc7YGIqTgNbbUn9XwGCXORK7QWODQvecIPLyx9qnXthI5GIdoM13VtxXzACzuEc/twQuN5uMhLQpGFjTiDZBF1FpMPKnDGahGycAPf36KX5JKN+AU4FpG9IhrHWxCPj5JT755SpjmWxSSfXbNwTvk4A5PvpZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2w4qVKNYrE0Wm8lTtJKy3foGXMcWGiBRs3eIplTurs=;
 b=bk11oGZ5io6H6Umq0vI/T4TFf/5zJEw71ez0O6TQy0nMaUeH5ShhS2I5iXhq7xwkT3LQUjy7P7kA+2UVQEu4gxtu22eMPf8Mn5SmzBWdTRDR4PEy1OJSmrczSc2da03jUC7jLbSDyG33eXdORtiL9wndnXTV9/J8MkSvQAvztOA=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SAWPR04MB993629.namprd04.prod.outlook.com (2603:10b6:806:55c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 00:48:39 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 00:48:39 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "flavien.solt97@gmail.com" <flavien.solt97@gmail.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>
Subject: Re: [PULL 25/93] tests/qtest: add RISC-V IOMMU MRIF notice tests
Thread-Topic: [PULL 25/93] tests/qtest: add RISC-V IOMMU MRIF notice tests
Thread-Index: AQHdMFZsUspc81++UEOuiG/F+gc1N7am/LiAgAVnNAA=
Date: Mon, 24 Aug 2026 00:48:39 +0000
Message-ID: <b5ffa2cac45fc2d2468c51beb74e65b26f21c5fa.camel@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
 <20260820034430.1186695-26-alistair.francis@wdc.com>
 <c192a3a2-c804-46c2-9603-b88609003c29@linaro.org>
In-Reply-To: <c192a3a2-c804-46c2-9603-b88609003c29@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SAWPR04MB993629:EE_
x-ms-office365-filtering-correlation-id: 410127df-ae42-4b65-1752-08df0179702d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|10070799003|1800799024|376014|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: MpIZU8K4qEcxpOLMtwjijgvq6pAF3Bj+B90rhBdlFBuOADVC1Rrb2mI7C9mSVNGkx8Ou76r1HvTvfPMHC8x1wQ6pxnqs8rhAqH+5l6igyYDjTs8xXQNLb/uaLNIyAi4pCEqn9JkGwme1GCqwZ3DbOWXUN8NFQFyyNWRnFbtkmwontMAxv6w+/NbRB/3Wo8wIYpuCCWOy/fUkJ7/0Bom6E3hrDI/YAwLr2za3yqbJrD67qLA7w/oI4gHR64Z+2e2T+8sKPXrHvb30izHqoQ88xxiLdEc9DGjsu0bt7E/hOi6oM6KauTMRiRyuQYpsEbaccT2hKguWYyiwiifyq3kdpH3UO07mJPPnbyCvztv/ykQuN5ZNQ3ODfidMy3gJBdZ2O0d8qeDn984zRiKlXXW5k3xFPBTrXw/Ll+UUAn7RrC5O28pesnrzG3Q66TEWxj18TzNp0r+YuRfVHUeMSGk0G1fwnsiW3gKqv7UV/cHE0WiQftsRMgjvOVBvwxk6ypjZ5AAkAwAlBq3nxHVe3Xfk3Ojyck/S7wT1hRKP3039svyfER63qZta5AumcpLX/jbfWtrS+YxVxByG60ZKRycaM8eclpDfFibGZXrsauZrI7j7iRqgjMZpW6w0MXQ19RpvxY4s2+/zRO6k4utVD5avYrE0sPJg50g3f2XQG7/pE16WsxBnKwakokgZWIvKGUCJuvxvH+e7gC8eW3AsreDVlQlVnD6QI07O/yo2W+rD4pE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(10070799003)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVRCa1lSbW82QW16RG1sb1ZWUEV4eEJqSVBBMGpoVzMyaHdqK0Q4NDVoRUQ5?=
 =?utf-8?B?NFIwblVnMUE2VmZXSUhBNVBYK3BkeURnNUFYVjhoSXFWN05oWVUzbi9TYTRX?=
 =?utf-8?B?aUVSTHpvQjREdEVaQVJtNStGMVJiSVZmcXJHUVlzMGZUMTh6TTFETkpFWHVG?=
 =?utf-8?B?K2txMUNXcjAvVFR0dUJ1RTM2ZVZTWmcrcTE2aTBOYjAzSHpIVWllaUtOQ0hh?=
 =?utf-8?B?NFJRbzhUSUN2b0F3NFBWbk1FWFdoUStJR2N6K3B2Uzk5U09RdUZKRFRTelVF?=
 =?utf-8?B?dXFBM2dqdnZNQmlQbnFkaFpETTg5eFBsZk1DbEdyenpldE1zcWFCRDMwdmg2?=
 =?utf-8?B?ZStPdkZLRjZtWDE1RHNXVE1naGRlM0tWMGJzSXlOaXBFazE5Y1cxM0ZBTVdx?=
 =?utf-8?B?RFJVZGRGWWZXNXhNRnVYalNVWDQzN0lyNm9FL2ovSEpUUHgwaXRlSXg3bXJy?=
 =?utf-8?B?NUhhMk10VzZSTm4vdHB4SE5uYVpKdFZTK0IraTF2VWg3RU1FT1lwa08yUW5p?=
 =?utf-8?B?RmtNbk9xRnVuUjUxR2Z5dWsxSjZzL1BDclM1dEIxSHprd1FYcGJxMGorY1hB?=
 =?utf-8?B?MjlxdzEwcCsxWFVIWEoxL2lMTEpFbER0UWFnOFhGaXNtTzhaQUtCTUowT3BE?=
 =?utf-8?B?RUhwUVVHRThucjVFNXRZWFBTbjR4cTZVeVBVS3lqOTR1ZUM4WFRRYUpLVnVw?=
 =?utf-8?B?TmhJdythMFA4dzJ4NVlrN0I4OW5hVExWZUQyeSsvWFJid1dsMTRVdXNsRE91?=
 =?utf-8?B?bVJVdk0wL3BmcURWckN0UzdVYWwyV2owN1c1bTN6WUZuRVVWNWwrdks3YXk1?=
 =?utf-8?B?MlJ2dlFTYkErekpWeGozeW1qUThVc21MVG5vT2dmdnZIenJnS1VlMDB3SjdH?=
 =?utf-8?B?TllndTVSM2xJcFcyWC9IeE5nOUZuT2ZxMEgyVHpTSXQvalVhWjMydlkvc1lu?=
 =?utf-8?B?bVhrcURWRGJPcUl1ODRtQ3NmMWNBeGEvbm5USWFLa25DeE16cGtqNi91ZU00?=
 =?utf-8?B?MVNpeVZYWVFUV1k0cHdtSC90eEhCTmpoTlJzcVN3ZzkrVjVBbjkwdjJWODY2?=
 =?utf-8?B?OGFsQmNYSnk3bHVxU1d3Rm5WMXoySFJDZ2RMWldjb1dUNUhEaTZraXJBZ1No?=
 =?utf-8?B?VnlSWG9Ia0k2bml2SldESVNFYnFlN3hJUmthWXZSS2JJL1pSQ0xJZmR5NkZ0?=
 =?utf-8?B?Y2hnU0lzYWF1NU4yc3c0blNqeS9QNXpwMWMyR29PSWtZYnRqVzVTQmlhR3Ji?=
 =?utf-8?B?WjlyUFptY1Z5dVFaV0FQU0pXY0tyam1RSERHVGpITzFHazgxZnZOMkJiUUl6?=
 =?utf-8?B?SzF4KzRsNkhLL3NSOTlHK29hR1NldVIrVGtNWDlKZmxPbk9EQjZOZURHRXZY?=
 =?utf-8?B?cTRUQnVxOUpyUXV4ZWw3QVhCS1VjUkp2SlRUNUhzT0ErVW1NRU4zYmJUK1Na?=
 =?utf-8?B?VjhsYk1CYkV1UjRRVUxOa2NObHNqemFyK1JkZU5Id1JUV21rdDdHUG5uekpD?=
 =?utf-8?B?Y090d1kycmVQWmNEeWk5TUEzU0U4QWxMRmVpOG5iN2tLdVpoSFhRNmpZTHAz?=
 =?utf-8?B?S0NtOHJSam5wYlQrdllKVXVZbkNIY1RUaFo5MEIvVGpzMlJnN1JhMnUrTHBp?=
 =?utf-8?B?ZHpDVFpUNXRHdmN4dTZWWlQvaU9MTmoybDlDZXZteWFkRmpYVjRjQng3TytI?=
 =?utf-8?B?MzYzaHl2bHhPUXRsdXYwaVljSjhyZG9hTGlGaEN4S2RiUGpRMHY1aCtheENM?=
 =?utf-8?B?Q0lVZE5wR01PT2JpUThrMTM3Vi8yeFUzMEIvMFJTUDNZMEx2UEFlSm9jZndp?=
 =?utf-8?B?MEhXSUx1THRHNjY3aTdaSHo1b1Y3blA3dGpqUldwMWJRMlAxVlByWGtnNFNa?=
 =?utf-8?B?NVZmcnZaL0MzaU1oZHhTVUZOZVArd1lsa0RMSFpvREJmMFRlRm5UdHN6bUtj?=
 =?utf-8?B?M1VEZWxGUUJzZ1IrNEtVbG9qMStIQmlwbFE3QXdKd2crV0NxN0VPMWRoYUdS?=
 =?utf-8?B?UWI0d1YxdjJKdDJqNUdoNkhJMEJYd2J5aFN3T1k2OElPT3ltNE5CZmdBdWRR?=
 =?utf-8?B?S05Hd2tENWZYQmxzdE5hYXhZLzJ0ZHVUcmg2dUcwdDQ2cUZRUmwreEZpYVVK?=
 =?utf-8?B?S21DcWRVVXJ5K2xROU40VEhocm5Qc2EwTnQ0N1BUL1J3NjlKc3ZtK1NpdU9Z?=
 =?utf-8?B?bDB4YUxwT3VXMG1Fa3BEK04wZEI3a0hhK2VBMGlHK1FkN1VzT3NSaThITWcy?=
 =?utf-8?B?M3JwZ1RMZk41V05vaDU0Z3ZRV05qaWFtQ3NpN1hTWkRpckhNRFhRUVMyenh2?=
 =?utf-8?B?ajhmTVUwZVhDcC9GdDk3Y1h1Y3hROHRsYXEyRWRXdEhSQzdIWXcxaW5YSm95?=
 =?utf-8?Q?SGvKkBM7W9kEgGZBR5YgqOEsgVF4bouwaQqw0v67tUL0e?=
x-ms-exchange-antispam-messagedata-1: JLHOyVRe2EYhjhrUpwmTx3wwPFLorqdYF3c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <431C3D971C270741B811AC467384A22B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ml2iPYVH40LbFuKNGWDaDnYV8LXlkDV+AVixteF9Rvzv4U5PdgZ2eKpD3ySuQ3Lu371SXBE9otcfEUpQx4lAHqwS9RPqzuT2tzq7hhrpdyCinFTVTaQw/GM4ExYQO8XTXX5yCZnf0QvjLgqaqQSArkwRwgRg7xSPM0w1fpvQkhRm1U/6tVFOWFV3p9i+9qXbMFdClQdUijzCanSoRBNYfvCEIyKQ3Lwwov6cSi33idFMq6JhAC1wLVO4aXKynv3P20czOC/AGMoqw1p7uawqKcbvXDnpu8Q5nH52i1nCg1qXTWzM+55i8fnYP0os1DNfrOU0iGb9xzk43u3xwg+oeg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RPe51m+of/ncxuuFXJUjtLG618CtWkI9yCG22s1vvUNNH8tUIcEhPYhfyfvOz/RMOnU8NRUEohE5n1tJ5pHa7uyJXk3OftnYrkTdz+o8md2vh4etbIUESrCXU5gnVnsktDiAZS8MN/YoC/ryDPpqNeWU8x2eFpQvBUI8kwE7xDQPmf3a+CsYOLZ7BsX0nE6jjTk7Y8sYoZ84bYxhWl+5J4fIwvVYfK8YGyKqlJ60LgGnzcrMX3kCMF2JjK1E/0vZ356sSdjqcppwia3+dBtl/MVRcXUO40SE3E1hRuQ1AFoeqm6LhixFJhho3eAfC9G10uuAJJEvQX9NHalgCcmZM0FTnD79UAseA8IEKSMVzWck9rkFa7NvNditfP5Gn1lEAgRFTwIP/E4s3IuxlhzaVdD4h5i1kkZjGhu9S+LBUZZoSdWKbxpPsYFAfb2ZtpeUjqS0rQQN8EtcariVRzjH1aQdOhN/Whtd8afK/XF5tDROga7jAncanwU5SoryR4WlnIe3FluBhVyM0drouPQUNwxrkwSJZYeiTAmB2+NepkvN1ZBDL87IXiCGdCUn+EClktgnnnQzm/C6IaLmhxMGFX6XhA37lQUTHhuRuDuGppBTPiIICIK0pWRD/jOmJzg6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410127df-ae42-4b65-1752-08df0179702d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 00:48:39.4092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpTSAQLKpYYCvKuYxiyD4dNI43lrQ8zbYInJYoo0HbdMk8cfTPMg8Kb5x5jXyAggTZxGT9dv5VwGfxXZLygQj3YAV9ELTTsfxNagiy062Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR04MB993629
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=689c12928=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTA4LTIwIGF0IDA3OjE3IC0wNzAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToNCj4gT24gOC8xOS8yNiAyMDo0MywgYWxpc3RhaXIyM0BnbWFpbC5jb23CoHdyb3RlOg0KPiA+
IEZyb206IEZsYXZpZW4gU29sdCA8Zmxhdmllbi5zb2x0OTdAZ21haWwuY29tPg0KPiA+IA0KPiA+
IEV4ZXJjaXNlIE1SSUYtbW9kZSBNU0kgd3JpdGVzIHRocm91Z2ggaW9tbXUtdGVzdGRldiB3aXRo
IHRoZQ0KPiA+IGRlc3RpbmF0aW9uDQo+ID4gaW50ZXJydXB0LWVuYWJsZSBiaXQgYm90aCBjbGVh
ciBhbmQgc2V0LiBFYWNoIGNhc2UgcmVxdWlyZXMgdGhlDQo+ID4gcGVuZGluZw0KPiA+IGJpdCB0
byBiZSBzdG9yZWQgcGx1cyB0aGUgY29uZmlndXJlZCBub3RpY2UgSUQgdG8gcmVhY2ggZ3Vlc3QN
Cj4gPiBtZW1vcnkuDQo+ID4gDQo+ID4gVGhlIGVuYWJsZS1jbGVhciBjYXNlIHJlZ3Jlc3NlcyB0
aGUgbm90aWNlIHN1cHByZXNzaW9uIGZpeGVkIGJ5IHRoZQ0KPiA+IHByZXZpb3VzIHBhdGNoLiBU
aGUgZW5hYmxlLXNldCBjYXNlIHByb3ZpZGVzIGEgY29udHJvbCBmb3IgdGhlDQo+ID4gZXhpc3Rp
bmcNCj4gPiBwYXRoLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEZsYXZpZW4gU29sdCA8Zmxh
dmllbi5zb2x0OTdAZ21haWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBDaGFvIExpdSA8Y2hhby5s
aXVAcHJvY2Vzc21pc3Npb24uY29tPg0KPiA+IE1lc3NhZ2UtSUQ6IDwyMDI2MDcyNy1xZW11LW1y
aWYtdjQtdjQtMy03M2UwODkwYWQzOTVAZ21haWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFs
aXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCj4gPiAtLS0NCj4gPiDC
oCB0ZXN0cy9xdGVzdC9pb21tdS1yaXNjdi10ZXN0LmMgfCAxMDINCj4gPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgMTAyIGluc2VydGlv
bnMoKykNCj4gDQo+IFNvbWV0aGluZyBpbiBoZXJlIGhhcyBhbiBlbmRpYW4gYnVnLCBhcyB0aGlz
IG5ldyB0ZXN0IGZhaWxzIG9uIHMzOTB4Og0KPiANCj4gaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUt
cHJvamVjdC9xZW11Ly0vam9icy8xNjAwOTI2Nzk5NSNMNTEwNg0KPiANCj4g4pa2wqAgNjk0LzEx
NDIgL3Jpc2N2NjQvaW9tbXUtdGVzdGRldi9tcmlmLW5vdGljZS9lbmFibGUtY2xlYXIgLSANCj4g
RVJST1I6Li4vdGVzdHMvcXRlc3QvaW9tbXUtcmlzY3YtDQo+IHRlc3QuYzozNDk6cnVuX3Jpc2N2
X2lvbW11X21yaWZfbm90aWNlOiBhc3NlcnRpb24gZmFpbGVkIA0KPiAocGVuZGluZyAmICgxdWxs
IDw8IFJJU0NWX01SSUZfSU5USUQpICE9IDApOiAoMCAhPSAwKSBGQUlMDQo+IA0KPiBGdWxsIG91
dHB1dCB3aGVuIHJ1bm5pbmcgbWFudWFsbHkNCj4gDQo+ICMgRm91bmQgUENJIGRldmljZTogdmVu
ZG9yPTB4MWIzNiBkZXZpY2U9MHgwMDE0IGRldmZuPTB4MDgNCj4gIyBGb3VuZCByaXNjdi1pb21t
dS1wY2kgYXQgZGV2Zm49MHgwOA0KPiAjIFJJU0MtViBJT01NVSBNTUlPIGJhc2UgYWRkcmVzczog
MHg0MDAwMDAwMA0KPiAjIFNlYXJjaGluZyBmb3IgaW9tbXUtdGVzdGRldiAodmVuZG9yPTB4MWIz
NiwgZGV2aWNlPTB4MDAwNSkNCj4gIyBGb3VuZCBQQ0kgZGV2aWNlOiB2ZW5kb3I9MHgxYjM2IGRl
dmljZT0weDAwMDUgZGV2Zm49MHgxMA0KPiAjIE1SSUYgbm90aWNlOiBlbmFibGU9MCBwZW5kaW5n
PTB4MjAwMDAwMDAwMDAwMDAwMCBub3RpY2U9MHgyZDAxMDAwMA0KPiAqKg0KPiBFUlJPUjouLi9z
cmMvdGVzdHMvcXRlc3QvaW9tbXUtcmlzY3YtDQo+IHRlc3QuYzozNDk6cnVuX3Jpc2N2X2lvbW11
X21yaWZfbm90aWNlOiBhc3NlcnRpb24gDQo+IGZhaWxlZCAocGVuZGluZyAmICgxdWxsIDw8IFJJ
U0NWX01SSUZfSU5USUQpICE9IDApOiAoMCAhPSAwKQ0KPiBub3Qgb2sgL3Jpc2N2NjQvaW9tbXUt
dGVzdGRldi9tcmlmLW5vdGljZS9lbmFibGUtY2xlYXIgLSANCj4gRVJST1I6Li4vc3JjL3Rlc3Rz
L3F0ZXN0L2lvbW11LXJpc2N2LQ0KPiB0ZXN0LmM6MzQ5OnJ1bl9yaXNjdl9pb21tdV9tcmlmX25v
dGljZTogYXNzZXJ0aW9uIA0KPiBmYWlsZWQgKHBlbmRpbmcgJiAoMXVsbCA8PCBSSVNDVl9NUklG
X0lOVElEKSAhPSAwKTogKDAgIT0gMCkNCj4gQmFpbCBvdXQhDQo+IEFib3J0ZWQgKGNvcmUgZHVt
cGVkKQ0KPiANCj4gSSBhc3N1bWUgcGVuZGluZyB3YXMgZXhwZWN0ZWQgdG8gZXF1YWwgMHgyMCwg
bm90IHRoZSBieXRlLXJldmVyc2UuDQoNCkkgaGF2ZSBkcm9wcGVkIHRoZSBlbnRpcmUgc2VyaWVz
IGZyb20gbXkgUFIgYW5kIHdpbGwgc2VuZCBhIHYyLg0KDQpBbGlzdGFpcg0KDQo+IA0KPiANCj4g
cn4NCg==

