Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938AAC61DD3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 01:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1a4f-0007uG-7k; Tue, 01 Sep 2026 21:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6980a3afb=Alistair.Francis@wdc.com>)
 id 1x1a4b-0007tu-Us
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 21:47:34 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6980a3afb=Alistair.Francis@wdc.com>)
 id 1x1a4a-0003D4-DC
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 21:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788313656; x=1819849656;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Qqp50t+7cD2mjbbvgfNj2f0QE0MeDcw2tZe0mhceILQ=;
 b=Toj1dxZ1qrJN7DkV0lNJzYEYqIRWim6jVAKPnx3iHg0bklNEzXcg5Q5N
 FB7DX/Vv7I4dUPHk0aaV5kUOtUxX7hGmnZNaZbUV5Fq8QqnpqdgS/dTVL
 CiLgO8F2xn+Zys+vF3XhvTFdcw8CEUok3Atb/u107mt2/+M9kbAjdwNNl
 OJcKDvfdteDmxHroBZkqANAvo19/6y8eV8MwNM5d2qP8tZR09Eqg/v4Bd
 ju4m7K9vq90CvHTSFnqkElZg2cKgM9XlJSUeY9RjUm8ghcpPNzQmQDwwf
 TyLcoiBs3OFnJfeIkP5HP0ogPc/8F7beGtdpdxb5BWdzG3Nezthw8tM0w Q==;
X-CSE-ConnectionGUID: Ijj4kVG6TOKUSTUyeCmB4Q==
X-CSE-MsgGUID: Fu9LD0+BTomc9PHFLGZTIQ==
X-IronPort-AV: E=Sophos;i="6.25,257,1779120000"; d="scan'208";a="150541905"
Received: from mail-westus2azon11010067.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.67])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Sep 2026 09:47:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWhsYHiU8UHi4kwntaHR7biI7RD5eKVwfCEBzFqm3nlcntBrOf/8j2jMEpa84LkxvCv6VNrCABesb/kBP2/kMuxp7gjjMeCWA2nfKJH5JniG+GErmSgQwe20EDSXkZLo/54sDSNx8PREZw7uVhh0RGAZ634aPA870bKN4gYtEe7LQbdvfPA855Vey3vlqmtPNdctLjmJ5Ee+W7CLeu4FgIKUG7w9M/uLYJqvbHHn3WMcJPCGE9se1h6OxkRp71xf5Bop70yvP/UnTNqlwbqK8XxEKqeIED1nEEI8ewXBiLMtkw9YKB44hMfIjECMKx/2IjHdEyd/A+aMG2Ci5j0/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qqp50t+7cD2mjbbvgfNj2f0QE0MeDcw2tZe0mhceILQ=;
 b=gTwiy4DEJQAUsvT9lSRa5GESmMH1mtj5qv19IbN6AoGEk3/dUfPN2OeWRNTsUchJEO1YsAsEnKJ1xoOBY4/Wglp1RLABy04wZgcVknctA5mDvFLHKsCSy0q0mz+eLmxwwjiyJekqtSvkgCamzDta+PP4o/i6u25aIyoZs/7w3m7DKmZtp+m6GxOlUHmC1wGvWM9G1BMRdGdOxenKn2+k2fFTLQ3DrxtpJbv53gMdBgfgtv2V1ibaHet+CIvG5AAe3abFYqd8bnDIxUBtVzupldECWbtecHT769nwnqdUKFX6PoSmKng+o71ZCwd+98VXbJnwD/4hE24Tr1ALX0B/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qqp50t+7cD2mjbbvgfNj2f0QE0MeDcw2tZe0mhceILQ=;
 b=YDb4LNZBVyMgWl+kzwA+e2z+tkmdzJCknBXogXxPEIzEgTwB52c/iXdI+YcaLRYdGIcygkfGBR+9lnrfSLKx1VYJRX13ZNxBEUkqfznFQdoO7n54INkXyiLXjsXbSNl4sQVVQBfj0KNwESHrAQJps5mfT7Typz0A0AOXuNbRQLo=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7697.namprd04.prod.outlook.com (2603:10b6:303:a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Wed, 2 Sep
 2026 01:47:28 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 01:47:28 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "philmd@linaro.org"
 <philmd@linaro.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "balaton@eik.bme.hu"
 <balaton@eik.bme.hu>, "mst@redhat.com" <mst@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "berrange@redhat.com" <berrange@redhat.com>,
 "imp@bsdimp.com" <imp@bsdimp.com>
Subject: Re: [PATCH 4/4] agents: add CLAUDE.md and GEMINI.md
Thread-Topic: [PATCH 4/4] agents: add CLAUDE.md and GEMINI.md
Thread-Index: AQHdOi0G6NWbKrL0CUquoSizwrHgCra6hamA
Date: Wed, 2 Sep 2026 01:47:28 +0000
Message-ID: <b5f31ec6d8de83847f8ecf4e8ccc07ad1b9677df.camel@wdc.com>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-5-pbonzini@redhat.com>
In-Reply-To: <20260901161422.314581-5-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7697:EE_
x-ms-office365-filtering-correlation-id: 9617d7a1-594d-49fb-dd46-08df0894255e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|19092799006|23010399003|7416014|376014|22082099003|18002099003|56012099006|38070700021|10067099003|11063799006|4143699003;
x-microsoft-antispam-message-info: GdJkm96kjLgZuiqGxHh/8V3MOSySNP4oGf+74JtF9JL5qyV6LoRwntwb8Nwp1kGSjLpvxFPL0JpP8luLDP/a1dtbXAv07weHGsgtUdIi8ESVkVLEsw3IpyNMlPRI1DgUn2t0gDjh1Q1GZpF2bZBDgjNBPTX6qAKwaxA4Zz5Rv8lfUL3BN6WfxATdMrqBPlymkeRw1291qZrxkYYM/XlCP5vp41UT/qcQSjL00fBm6vCF1i1p6Taf14mmiAZOfKm1JO61vVchq/VoSgRC07iEgFiC9PkJeRlY7zj+WfYmRf4SSu3ZFTFT9af1ZuMCaYZhje4CAZqIjtua0We8ubIPq2l53GuiGDBwpRroYleO7EkP2kWU1jRbNc08RACPNSXEZpFFWmBuWS9oROEXl6ZzIlSIt/SN5Pbr5/f2AUc2gS8DJVQS6iJfjDNnA/cxPJDmlSkWF4rdOCzmkvxG9FbkuZuGx3zv8zbRKwqa6sE7E5lBs/+UYWUtzq4jAUfOWa5p6FGUXRPqJbd0T/dlLkJ+XXekn3yrhj15gdgt5gfUsoD7AaUgsH2FQzFuFlId8gMUO30MIdDMUXnifoqkski5MH9PPCqF/uyYnA4zmrJBUhfCiz8LKFuehy0BgNAe613fnIX+hRcq+AP3N/wUTCiHDrEjKxMfZUmFEam9vq870KVPCpxBv/Z+W6xZQB7qV5wFLmwNsMXpxQCeS2Dh3BPmHiH9jJEhIYsT3eeC3FxGlSo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sld2SXBOSTYyRGJhc3BiaDU4d2V1YWlYTkhKZ0ZsSjR0NkJxNFMzS0ZOZnhV?=
 =?utf-8?B?cDJyamZraWJaY1dsY2VRSDhvcEx5cWV0RDAzNDNtdUxxY1lZRlFadExSMlBR?=
 =?utf-8?B?cERpcW05TnVnRjRRWkJyTG5kSU44RE9CRUhXM1BrMlFRcWtvYytrbkd5ODVv?=
 =?utf-8?B?Mkp0QUsxMEZQMEhUOVpJSWM4OUJFaEVTZjVIR1JNais1a1pFblNYMnd0c3hx?=
 =?utf-8?B?dFRYTWFsUU9rRHRMdEZqTDRnQk5TRXp0MVRRaHRjbnd0UHd0bmZMYXl2dUVX?=
 =?utf-8?B?b0Q5enZDb2dyOVByeHY1YnlaWDlJZE9PdVBvNE85dnBIZTU3ZTdRVnNqSjNV?=
 =?utf-8?B?Z1dYUkgwOHBVWU5HYjhJcXJrRkFJNlFobGNIa2gwbFZBTExLeStrNmx0SlF3?=
 =?utf-8?B?anVOV1dlTGx1cGJ0eWxTZWduRzQwZHlFZVQ3QklCMFh0ZHJOQksyRWFtWW1Q?=
 =?utf-8?B?cjRzbndZRHNyNmxnSmcvekg5QU02UkVhVW8zeUJha28vYUJReHFmL29VVE12?=
 =?utf-8?B?aDNaNGlBTk5ZYmdKdnBENzViUXE1SDB4L3EyZGJ6c2ZXYmRlS0QwSjI1elh3?=
 =?utf-8?B?enUySHEvTGRoQldJMCs5SG9sMTNGQ3M5bC9PY09XVHRWWHlyT3hYSjloNzQ4?=
 =?utf-8?B?N25obzNyWTRZSWxhcGZTK0ZQY1V2bHZFMTZSVy81S1BSdGZBRWFTSk5yUjRH?=
 =?utf-8?B?blNiTThoWXlLZFRRUnJydXd0ZVh5QjRpd3JaOEltMk42UzhnejBXRDdpcEYx?=
 =?utf-8?B?RDFScXhhVDhEc1RLMnQ3TXJkZHFSSTZpK25rbzF6cmlhZGdDMW1CQmJjelVP?=
 =?utf-8?B?d1dZRkFkS2pUb2J1cDBsdmQ4dDgvUFhRck9rQnJiWitqV3hSN05mWC81cFQ3?=
 =?utf-8?B?OXE0Yjh4bWZGNDJJSWxxTDN6M1pEUEh1ajNoeUc3WElnQWhPTnRHTCtJUkNz?=
 =?utf-8?B?V3BiQTlURkVhODYzdnEvdVFqRnBLTnlIWHY0NmZKM0ZlSzcxQ243a242TFli?=
 =?utf-8?B?cjg5QXVka0lPbmpLL2JScjB3TUhMOGZ6V2I5Mm9kZE1xZDVRTEtJdDcyRDFn?=
 =?utf-8?B?MmMyTm96ZmtnUmdMT3VkMW5wWUpXcy9qdkZrNGpZT0l6dWhaL3NBdFNzZDdE?=
 =?utf-8?B?TXV3VmxZc1MweTVqKzVtWUpydGFBcGgyU3NzK0RHd2QxRjNWUWFvQnNleXg3?=
 =?utf-8?B?OStiUUYxd0JMRy9HOHRkRW9NWHMvcldXQ21JN3YvOXBLbzBvMWpUTFk3NkE0?=
 =?utf-8?B?eHRsaEt2MzJIdGxtemRvUXovN3BFTXYxcUFrOUsxTlV1ZkpSV0NtVllValRF?=
 =?utf-8?B?SUZSa0tycG5CR2ZxdWVXZzBFTjZXNDQ4b2FNbW1NOXkwdmZ2L1MzNmtINHNu?=
 =?utf-8?B?UldRNkprS2VoSmQwNjFwWklNTVRaZEZTa281T1hta0RvSnJDS0xYZCtNM25r?=
 =?utf-8?B?LzNjVlV3dVhBMFVPeVBORU1rNXlpckU5TnNMTGR4YzNQMkZKSEpyN000aDJS?=
 =?utf-8?B?dmErYkFMbzB0NjVWYk9YOEtCUTZCN0N0TEZoTGlpVXgxc2dOMGJCTithbzJG?=
 =?utf-8?B?OFFtbU0zM3oyUmczU2lWUlJrU2lTQy80dEhlRHcyVWIveVVCaGMzU3hZUUdC?=
 =?utf-8?B?T1RROFJ0ZlJMeU84TGJNUWFscUVzcmRzL1ZVWlZWTVVVSzZKeHlkWUl1eE93?=
 =?utf-8?B?My9zTlhOOSs0NmsvZ3FkRHVDY0xBcmV5WjdtNGdCTnRsWEpQYVRVeWE4dDM1?=
 =?utf-8?B?d3hvWmtuQWpyNUYwbXQ0V0paSlVaN21VczZtbmNwR1ZCM1FIZW1zbnhXVTdy?=
 =?utf-8?B?VHcvamNRU1hzTjEyY1NnTDh5MHJiOVcrVE5KVzhLSGhWdTBFTUdOZ1lSeFg1?=
 =?utf-8?B?NWZZNmltZ2lBV3RqYTZKeGpoUUF0YWtHOEl2VnF6bE5jcUVXYnJ0RlBKZURy?=
 =?utf-8?B?bmx3RisyeHFrSEt0cjE5WFl6ZGI5NGxzK3phUTZRdDY1ZXRIU3VrS2pBdTdw?=
 =?utf-8?B?Y1ZrSnJvWEtvd3FpN093TVBDOTFEd2ZyZ3hMbExtd2d0Q3VHWnhqUUZlUEZh?=
 =?utf-8?B?UGg2SEZDQVI2RlR4SENiajdKdU14b0ZEeHUwdGZnUjVUYXNnL0RDUlRjQmk4?=
 =?utf-8?B?emVvUmoxSTkzcENSblJhdTBMTDdhZHNDZHM5K0FmcmtZbnI5YkttTXZoN3lx?=
 =?utf-8?B?dXU1V25vZm10YTI5RHg5VWhkZ1AvN21La0tzTGJRZDBsbXZrMTZZbnkwNEhC?=
 =?utf-8?B?b0RKRmpCVWRkMkJDbmhkSXE2Z2xFczR0MzFIbHdjUEZmWTJOdHQ3Ri93ME9a?=
 =?utf-8?B?MWp5cWZHQzYydDlNekFTSVJaMWpISVFIanIzT0NJZE55U2FMcXZEVTBDM1gy?=
 =?utf-8?Q?MbDmEjZQuJBuQoWMzHcJqGqFluArnJCLd7phr4nEX9uW9?=
x-ms-exchange-antispam-messagedata-1: Xw+BtqDwHF+Htmdd+PkCECyir1Dw3Ibl2Dg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1170BEFB6C1FB348A0128E3714F8631A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IfCk+mb+JtdUjMn/mzLtOU6KzKxgq/hjNPsXf60ZL2p94qlF5ixIgr0216qM0pu449Je87xiJAaM8RgjD1T5LxVmzQ+VntgYgA2gluUcSnRqJ3iGaU/uq4dnNlSpiI8JZGCJ3ev1xvfPMbMNV30ju+k3yRimAzVzdczXhAF+IbCj991Q5BhT2miQUHLuMozfhea3OZ1knhph9sanbrCeD62cGN6t7VaKLZZmp0plWhwyU5pYJoLgKbDw776MB4DokCHHDKpuGO2x+fHWLuRbpiVelDKZaFVLWcNLmrgRx63Zl/QKrQZ5eREWxkGQXaD10WoQ9Edat39F0BRbEhkyfA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fu/cDMSRM3+Z1Fm1MT2IPQneUWParepYjEWWszLKayrF8BPyhd0ZK6EtoUrvioweIZ3Q5MnlPiPO1+B2VeWlipv+pGqV0yY0aSiwR9vEjVrqvIJyi34d00NK76VXFcMwsBSn8Cj7L/bOwZSZjM9aicANimN9y4QbIf2TJXDI/htOXlytY9E9dG0CQhZM2Hp4dCi5Dv+B3YvDBHJMZMedkAlcxWSOoM5rn6xrg4+MvSjHrmRy66c5AOq2kOO1iDknY4RU/T+BEg4QYItXE2/5T47YmMty6ayH0zJoO4+xqivx3wN2jRrijiX5la6g3aBf3C1hMelALfnqb8UrTuLjv78fOXk7LzW9euN2X8ExwHViGugkwOlul8EGiqNsof8HKxOSa5iP5fTpuW5qiUd2OWZvAJ6MimBmlR6gqbHnoOp2Wlo7dLqMEawvNEbk77ivAfECr2DvuI1SF+lHRshQCW9M5Zr7K9eKprn8NTfiuwsuzG1xtSB4RYbu2GBcmCcC+5Zzs8XJ9f8FFe/J/uC22TIfxVMfKXzJ2sfykW1agE6lshGvnPH2YAtZpZAhHAb92infB4Qp63wg4Mtz4g4IDI3JRyEgjxLxNLbBpXy68RgSkEn3wJmYwFXi49FhfbOL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9617d7a1-594d-49fb-dd46-08df0894255e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 01:47:28.4442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WpDO7Dd+Mb9tQ2yUah4qvgpIg0lg+eljMpeeNRWzSlnDVhZRlq+21QEaKSMrX+vcwab1VWdJG2EJ3Igwdlpjh47cRETn8kzBiuh0ZNgLXGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7697
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=6980a3afb=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gVHVlLCAyMDI2LTA5LTAxIGF0IDE4OjE0ICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBDbGF1ZGUgQ29kZSBhbmQgR2VtaW5pIENMSSBkbyBub3QgcmVhZCBBR0VOVFMubWQuwqAgUmVs
dWN0YW50bHkNCj4gYWR2ZXJ0aXNlDQo+IHRoZW0gdG8gZmFjaWxpdGF0ZSBmb2xsb3dpbmcgdGhl
IHJ1bGVzLg0KDQpSZWFsbHk/DQoNCk5vdyB3ZSBhcmUgc3R1Y2sgd2l0aCB0aGVzZSBleHRyYSBm
aWxlcywgd2hpY2ggYXJlIHByb2R1Y3QgbmFtZXMgOigNCg0KQWxpc3RhaXINCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gLS0tDQo+
IMKgQ0xBVURFLm1kIHwgMSArDQo+IMKgR0VNSU5JLm1kIHwgMSArDQo+IMKgMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgQ0xBVURFLm1kDQo+
IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IEdFTUlOSS5tZA0KPiANCj4gZGlmZiAtLWdpdCBhL0NMQVVE
RS5tZCBiL0NMQVVERS5tZA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAw
MDAwMC4uNDNjOTk0YzJkMzYNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9DTEFVREUubWQNCj4g
QEAgLTAsMCArMSBAQA0KPiArQEFHRU5UUy5tZA0KPiBkaWZmIC0tZ2l0IGEvR0VNSU5JLm1kIGIv
R0VNSU5JLm1kDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwLi40
M2M5OTRjMmQzNg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0dFTUlOSS5tZA0KPiBAQCAtMCww
ICsxIEBADQo+ICtAQUdFTlRTLm1kDQo=

