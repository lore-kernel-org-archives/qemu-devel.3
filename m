Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D642C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 09:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujwZd-0006KB-Ec; Thu, 07 Aug 2025 05:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bschubert@ddn.com>)
 id 1ujwZZ-00069j-FF; Thu, 07 Aug 2025 05:06:05 -0400
Received: from outbound-ip168b.ess.barracuda.com ([209.222.82.102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bschubert@ddn.com>)
 id 1ujwZU-0004Hn-No; Thu, 07 Aug 2025 05:06:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2111.outbound.protection.outlook.com [40.107.223.111]) by
 mx-outbound45-237.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 07 Aug 2025 09:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEq+ENqKd1r+2E6mfwLWn/r7Ss7FH/mjge5UDK9bPYPp4fco9NmT4ugygJvcxK0AfYUiyRV6b0b4tbLAuXyDaVljFlCZMeRULAusv/CaGXn0GFsU0L2k9VKdVh9+JSwdo4AMnuRhDjFbQqL+0Y9fQW1phymp+IRIU/Ei4lC6k1NP8ctkVf5+wL/94/56J7WfIoFwLbJcMyNArPgbBmqI05XQz8JkEw3c+DXM1M8UVEp3Cf+pwyS8xPadibDO2VtW2MopZg+2uM++yotvMH40iMxYxvz74nlN2ohCXJRbeyyjQooio76LVxCLqGH3swL4P1QKEbjDoA/5mr+6WzDPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDmRhIZn4zw8M4gQDrT1ra+FzmpK7EGWgQ/zZzranFI=;
 b=BdGr70aDxCuFJbrHE5hyzR84dGFbYv+X+geMP7y9id0B5Hf7l7jhZ3/FGMFkiHRYwDaqAdlPZqYGbnG6MHLV5GMmuHDia/jFUxL88hMytybf+051ts8OmxKcoHKbS0gVT6LnGZcv2eyh1SjXGPjv5qYZQDKzNuXBu83TOEsbRkLGwybARByNob2Sh6/s/1aH/3QG8lTkFeyMLI3UCcXlgOHprjsqbUQLLwLZcnId7rXgixn3YoK+FwVs+e230Ukglt0G6S/9cF+ZxKv/zQZAywrn5229c78qV1A4jzMn8HMnuJcTVO7faRlrM8BFu6mC93Kt9bSDYP3vxWPcs9W/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDmRhIZn4zw8M4gQDrT1ra+FzmpK7EGWgQ/zZzranFI=;
 b=E55gxz2afpIoaAObPaWKYnoeWWSZgK/aTyx9gommDH6cS4Z5AB/qpYusNCnz3D19gzwG4ozDxtYhYmDEqUnhFOTMbmn19rgHIoo0y4kLYAy/Fj73c7yZeN2KxcUQcWTGO/tMcwhDak4UjBqU0jbIA67hq6tTLfPnqaggUX9ahU0=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by LV9PR19MB9111.namprd19.prod.outlook.com (2603:10b6:408:2e9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 09:05:26 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 09:05:26 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Brian Song <hibriansong@gmail.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
CC: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [QEMU/FUSE] Discussion on Proper Termination and Async
 Cancellation in fuse-over-io_uring
Thread-Topic: [QEMU/FUSE] Discussion on Proper Termination and Async
 Cancellation in fuse-over-io_uring
Thread-Index: AQHcAv6033ZujoIkg0aZu5zlVFY7rbRRmBoAgADJCICAARbWgIADdt2A
Date: Thu, 7 Aug 2025 09:05:25 +0000
Message-ID: <0569dd4f-c07a-40bf-8136-c639b41d8053@ddn.com>
References: <3867ced7-efb7-4a0f-ac0f-465631950bdb@gmail.com>
 <dc326a4b-f6fa-435a-b614-208e03f61556@gmail.com>
 <577bf373-92cb-4160-a49e-e29d3615a308@ddn.com>
 <dbcfecfd-01ab-4ca4-b835-f3a3e6b3686e@gmail.com>
In-Reply-To: <dbcfecfd-01ab-4ca4-b835-f3a3e6b3686e@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|LV9PR19MB9111:EE_
x-ms-office365-filtering-correlation-id: 1a8ce56c-8de7-4e66-99de-08ddd5918c27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|19092799006|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?L3BjaGVISTN4UG96WHJtRmZNSWJrcEVMQkV2dVkxbWFBb1dYLzBiUlZpanJa?=
 =?utf-8?B?cVdZR3VoMG43Y2tjSEYyLzlwR1BPcDhKUFJYL1k1YW5ENUlaU251ZHRITGNO?=
 =?utf-8?B?dDNYK29lMDYwSmpRc1FxVkZkWERqMSt2VmxWZVhiVVJXYWE3OGRCeWRKMGFp?=
 =?utf-8?B?c0Nrb09nRXQva1UzcUhpQUVEOFB6R24rZ1JvSWF6dzJhYjZXTHdVSkYvdE9M?=
 =?utf-8?B?WER2S1VWRmxUNFhxTUxGZXYwYUdFZUlrMWNrWmNMbUFseitScFdkbmg0dlFP?=
 =?utf-8?B?RDdNeGthOGZYclZxM1JSYXNkd1B0T1pmL0pveUgyZVJjcGcvcFRuK0lnTUNL?=
 =?utf-8?B?bUQ5VDBlT2M0R0lqdHdqZ0JkOEs0NW9GUUM4U0l5cDlRNEgwTE5nTmxHYnpG?=
 =?utf-8?B?SmRmRHoyL3hOMk0vQWNZcEYvWmZkRTlTTzdncGpnNmdJSlQyanFMbjVHVG5U?=
 =?utf-8?B?dFAvSFNZSkZDTiszV09ibDczby9PNnZEWlZOUGJOSW1jTm9nREpYc1ZRbXg4?=
 =?utf-8?B?MHBQODI2K0dKcUhoblc1KzFqZUJHY29aUmkrbkVTQ0hjbFZmaHZOYmpJWTdn?=
 =?utf-8?B?T0NiTElHaVgzUDJvUUhkdUtzU25YTEZzZVdVZkFYUkZJNjhySndWdUNYaGVQ?=
 =?utf-8?B?Z3doY01WWDBWeVR2WVdYVWd5RTRLNWFGcUZ2dWR3WUNMNVFCc2FEVlhRYjBI?=
 =?utf-8?B?ZjlrYU5zbzY1eXBzRk5sNllXV0xWSDBBcjY1N3ZsWExIclNKZ2s4TWhYKzYr?=
 =?utf-8?B?eWlPSUNubWhaSFZsZ1VKMXA4aHJMS0pBQmZiS0NnSHk0ek5tNmd4ekxrK3Rs?=
 =?utf-8?B?VjlzU2xzdGhOdVBXc1RIU1ZjQ3djUVFtTDFkV2ovaWRPdi9LTDF5K0x0aCtz?=
 =?utf-8?B?eDg3Q3VsSkxiSnFLeHpPZ3A0Q3kvZXd0UXQ2ZjZCd242VjBtQnhJdnlDWml1?=
 =?utf-8?B?dENtZjdkcmQxaTNTbGxVZEVvKzBoQWxQbTZqdmtDL3ErQlVFZ3lrSkhHOFZl?=
 =?utf-8?B?YlRIWDE3emFab2JveHlhaWlmK082V1RIaTZuK0ViWW4xb0dOLzJXWnpyaUcx?=
 =?utf-8?B?TFJrL0JsWW4xdUpPVU5JQUhIcVpjMU5kTGtZQ3N2OC8vUm5oSlI1WUs4SnhE?=
 =?utf-8?B?TUJRUVMrdlRVR01kZjRtdlpoRmxYaTlhRElWU0kyNTR1WW9ab1Q4RjV2V0J0?=
 =?utf-8?B?MnBNcm4zZXZDWXl4TmZ0UlJETVY5b2QxNUExUkRySkJXTEtRaXB5bWxtYXVS?=
 =?utf-8?B?SnRxb1NydHFnU2ZQYk5xbkV5NFloOC9la2lKYXVMZ25mOWNEalVWQ1c0dTZY?=
 =?utf-8?B?b2V5VzFMRHU1c1IyWEd0bXdNRFhTb2xNejRzeHdNMW1yaS9IbkFEeVFJMzF4?=
 =?utf-8?B?NTFSak82UkliNVlTOWJVVVEwNDA0Y1orWVRWV1V0THAzbTBtMkFlSUljbWNC?=
 =?utf-8?B?K0hBVWNEck1YS2ttNEY5TVZFdmZ4bkNDcndsazY1bkJ0b3FaL2dXTGxIZDdl?=
 =?utf-8?B?a1g1bW1hejYrbXNEVFRuUU5BNjloVHY4WnpidWZ0eVF2djdBZFU2NXNiaXBs?=
 =?utf-8?B?cmNSZ3BsVyt2cGM2N0FOaTkrdkpZMHYwYTJmcWlrNm12MlVCUnEyV3RWc0RC?=
 =?utf-8?B?VjFZbGU3VU1SUlFuczdmM2JHWElzUVNnUWZWenpMdlF0YWE0a2IzZHdTK1lt?=
 =?utf-8?B?Ty93Q3RrYjRUVVkyY3lSc2JDYVV2RjlVM2RQeWh1UlBRT2R3enh0bFZJUEZn?=
 =?utf-8?B?ZG45ZlIxMUtOWlV0a2UyTThwUjY3ZEJQNDhUTkNkZjVJem9xaEtLbjcvc0Na?=
 =?utf-8?B?eG1PelZnQzlCN3NzazV4ai8xTFZmQlhEOFV6elBZVEJhME1va2g2Q0gyZmg3?=
 =?utf-8?B?T2Q3SlFPWU9oSUF2dGphaXdBVVJicEhHMVNSNjdIekZadmJZZ1A0WERxQnVN?=
 =?utf-8?B?cFNXZ1Vld0lqeDE5QmhyWUNPaklkZDZ4YXJjRWorZ1JocWFHeTFtSzUyaWNN?=
 =?utf-8?B?L296SDlJV2pnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR19MB3864.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWJQSGRmbEQ0dDFNL05pWE1neERzdGxCUUxiMm05YTcxOUs3ZUx0WHhaV0xU?=
 =?utf-8?B?K1JyNi9SM0RjaHQ4TlRHOFBFUzROQm93WWdNKzRVTDVKODNTN2VXeGs0c3ow?=
 =?utf-8?B?MTNiUWZrK2kzek13YWxOdzdwU2xjMFpMZVNtdE5JQ3JSYUJzSjNMdGFidCs1?=
 =?utf-8?B?ekJ6SktLeTdOcmFOa0MyWlFyTUhocWNCMVZrc3NkWUFUWVBzWE5mWnlvNmg3?=
 =?utf-8?B?TWNYdUQxTkhUV3RxVHh2UE5vYjlpNDVMaS9hZk9lSnB5M0JhK3dJb1hOMzdq?=
 =?utf-8?B?ZHMvVzc0OXRHQ2IrVyt4WXhpRmtFeG1YYUZUMksvRjdCK0UySXBHWGh2Z2pk?=
 =?utf-8?B?V0tCVXdTYXhLcFM0SlpUaTlkSjZGS0lGaXJKM2FrYW1lRGE4MnBBbThPSndK?=
 =?utf-8?B?WS9hUkZGYnNaOUJZbHpISnRaaHF5YUU1M3ZoYmhrZEt4RjB5WTB4bnJqT0xJ?=
 =?utf-8?B?NU04ZDlnSFlDN0dNeGpsdzRlajdqc1ZIbVFoNTRtdU9VbEJhYUFmVXMyK3V5?=
 =?utf-8?B?Sk5Sc0duZ05RWEVNRll6OHVKeVRuVEFVU1RBVjFJamcycGp4a1M0VWN4a2lJ?=
 =?utf-8?B?WFg5WGcxdHdWWkY4MytwempGS2NTNnU2dlpKajNZMHVWd3o1UFBXTmVMYXNz?=
 =?utf-8?B?REVxNjN1K3ZmM2xLdlcxUXpnbFlUQW9KbHZ0RXlIYXVuK1J3T0xTTncraUFr?=
 =?utf-8?B?Mkt5Wld0U3lWbCt5T2puYVpTRkpxUUN3Uko5S0xaL1RwaDlRTGs4N3c5c0Y5?=
 =?utf-8?B?VFcwN2FZZzJEMThUSngxMVNLWUdleGUvRmYzZnZHLzJNMGdsOEc0R2huOXVM?=
 =?utf-8?B?d2NoUFlBa3IyMzFNQmxTRW1scTBranBIYU5LNFdlYVBmYVIyTHVnQVhwZ0Vk?=
 =?utf-8?B?TGxWa3JqZGRZaFIzelNDUkJJUmU0OUxQV2ZkUWp0SXBmcnp2VVFjOXZ2WHc3?=
 =?utf-8?B?TUlLTUlGMnF1SUZQWTJYZnFZb3ZRM3VJdU52WnVQQTRNazBiazl5WEU4SFVX?=
 =?utf-8?B?UkFYcDRLYWhKSkc3NmFtSlIrVGhFb0dOTkg5SFp5bVlLSm9uR0pLcUFUV2pJ?=
 =?utf-8?B?TjdIczRnZVNkNlRRcDJadFNQVGU1ekYvUU1UazNSaGx1Z0VsTzBIZW12K2Vp?=
 =?utf-8?B?cE9BTXJFSENsbmk1eUp2QWhrUUwrelYvanZPb0l2WG5Db2NsNzZucHVIcXA2?=
 =?utf-8?B?TUw2QWtERzFiRnFjMnhVMEQ0aWRKSmRGR0g0bnJJQ3ppVGpVUU5CL2JVODh2?=
 =?utf-8?B?MFNGUVZ5dExFdTBEckJaYTdrZDRvd1M1ZXlsRVpoVENpUURqODc1VWdZLzdG?=
 =?utf-8?B?NDNLdW5yOERxbmpEZGN4VXU2ZkU2cy8xWXdUd29IOU05SGdZQTVmYlVUNXo0?=
 =?utf-8?B?WWtaZjY3Y21MeEdxWFR0c2trbFhndWV4YStPdmk4RlRkSm5FQzczUW1VbnJ6?=
 =?utf-8?B?OFlHenRqNnZJMEkrL3lFMnFQQ0dSb3ZaQWNiWVJoOUE5MUY5d1Z2VExnOXU4?=
 =?utf-8?B?a1BxQ0VIeFdTNUgwMmhhUDN5a0lqRExEMVBJMzVVUlQ1SVNPRVdZQ3lEcmd4?=
 =?utf-8?B?R2tKcjUreHowKzR3RGFEZXZtVVpYaitZSFZKeDIrTHZlMDhaVTBLODVrTmhR?=
 =?utf-8?B?eWV4TU9TVEk1eVF0MVZnS3lwTXJBZndxNWllM0NIOXkwYWpCY1l4RC9pNXhh?=
 =?utf-8?B?alBicFRDUEZ5OW9rWWcxSlJYVituekI2UDdzMURkVFptTVlrTjNJRzRXSlNn?=
 =?utf-8?B?SWZuZXduRXFCRWd6NHQ5QlRSOGtJMEtCVSt5U0lySVgyZlBGUzF3azk2YTVz?=
 =?utf-8?B?RlFVclRRaHYraG9TMC82ZnE5aXpOWTVHSHh1NmJNTFA1Z1ZHSTFsaHZVWE1K?=
 =?utf-8?B?dXA2SXM3bnR6d3h4SXZMenlDdnlaTVljRFdvQ1JrMTVub0dtdzdQYlpTT0Ro?=
 =?utf-8?B?WjVUVWI5L1J0aUFMMGhNbG9QQUxzdEtMdjhKcFNIblRNZWVUKzIxQUlLVElx?=
 =?utf-8?B?NlpsdkdZcGV6SFFHWkdVZmFRWDRqQ3UxcXdpcXFXNWt1UHlVaHBBajRaejdM?=
 =?utf-8?B?SzB1ZnpVM2JHdkhRV1dEWEg5YWVjUzlqOFdocnhhT3p5NWkyNCs3NTBzWERH?=
 =?utf-8?Q?7vHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F69AC7DD2F58E24F8A486E35A3F01C6C@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fElAwti2nmfEppYZTcIRNiH28i1wPA1utWB1ON77Cry5PEHl4jOvepJNV3erMPUQcnuCiOvK4GID/oM8NNGAANEaWMWRwYAQ4+5ZLDzS9FismU3Smr0LOMJSJar7wXxedzLEAaJDCX5l1Ib8KOnVrtGV2Z87nP+aw+W2rCMATab8uDP+ZC/xbOmf6IH7RF2nydKaGbM8Q4vQfnRSOYwZhacLhsKRUXwmFr28GfTV/dUDY6JZl40FuLS7uPTaBaUyJexRGkukCnuJqyyd1OT34XTlITPixMK6B0CQAIjhR539cyf0mzAMyVxoMXSDTyPcfWjI1nLUBo5xqJfpUo440QdIZ/Zrz+5qB0N1BPWbZDCMA3eVlj1tZ7XVY1njmCb+YgyI/ysqQQ3/tI13dc0Rzg+EfdWX08G4WHsQ0e8YtjNcfKPayzfPwFhe2HNlEMTwJ6MtiDubA2ZXm3EUqFNd87+rtp2tJB8is7eQBPZyR9uBVcubhaVeleyFLIXm/MDogErsYVhgb8Tr+JYU4lF/IHi2gr/zZZvO+DucbuE3U7aWsJg83gvy+5rMlsxU8YyX08O7KEyBjuU/UrAsZcZJMbIjguJYCKvPU0eMOpPwZS2bPXSZZZkjuKhuQ4yXHgvigzvIGEgi9+tH1ikDCdN/Mw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8ce56c-8de7-4e66-99de-08ddd5918c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 09:05:25.4593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9xZy61uB5SAuwSUrwOBmiUEMOwmJp6ovOnPVX75JDUv4oZoQYwVWqzzCbjfhRpoOIs7h5oGc7KTJh6MBQXb3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR19MB9111
X-BESS-ID: 1754557529-111757-7684-15740-1
X-BESS-VER: 2019.1_20250806.2144
X-BESS-Apparent-Source-IP: 40.107.223.111
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkamxkZAVgZQ0DTJOMXUMiUlxd
 goOcXUPM0wJTHR1NLEwiDNPNnEINlMqTYWAAM3cqJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.266605 [from 
 cloudscan8-151.us-east-2a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Received-SPF: pass client-ip=209.222.82.102; envelope-from=bschubert@ddn.com;
 helo=outbound-ip168b.ess.barracuda.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgQnJpYW4sDQoNCnNvcnJ5IGZvciBsYXRlIHJlcGxpZXMuIFRvdGFsbHkgc3dhbXBlZCBpbiB3
b3JrIHRoaXMgd2VlayBhbmQgbmV4dCB3ZWVrDQp3aWxsIGJlIG9mZiBhbm90aGVyIHdlZWsuDQoN
Ck9uIDgvNS8yNSAwNjoxMSwgQnJpYW4gU29uZyB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDI1LTA4
LTA0IDc6MzMgYS5tLiwgQmVybmQgU2NodWJlcnQgd3JvdGU6DQo+PiBIaSBCcmlhbiwNCj4+DQo+
PiBzb3JyeSBmb3IgbXkgbGF0ZSByZXBseSwganVzdCBiYWNrIGZyb20gdmFjYXRpb24gYW5kIGZp
Z2h0aW5nIHRocm91Z2gNCj4+IG15IG1haWxzLg0KPj4NCj4+IE9uIDgvNC8yNSAwMTozMywgQnJp
YW4gU29uZyB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4gT24gMjAyNS0wOC0wMSAxMjowOSBwLm0uLCBC
cmlhbiBTb25nIHdyb3RlOg0KPj4+PiBIaSBCZXJuZCwNCj4+Pj4NCj4+Pj4gV2UgYXJlIGN1cnJl
bnRseSB3b3JraW5nIG9uIGltcGxlbWVudGluZyB0ZXJtaW5hdGlvbiBzdXBwb3J0IGZvciBmdXNl
LQ0KPj4+PiBvdmVyLWlvX3VyaW5nIGluIFFFTVUsIGFuZCByaWdodCBub3cgd2UgYXJlIGZvY3Vz
aW5nIG9uIGhvdyB0byBjbGVhbiB1cA0KPj4+PiBpbi1mbGlnaHQgU1FFcyBwcm9wZXJseS4gT3Vy
IG1haW4gcXVlc3Rpb24gaXMgYWJvdXQgaG93IHdlbGwgdGhlIGtlcm5lbA0KPj4+PiBzdXBwb3J0
cyByb2J1c3QgY2FuY2VsbGF0aW9uIGZvciB0aGVzZSBmdXNlLW92ZXItaW9fdXJpbmcgU1FFcy4g
RG9lcyBpdA0KPj4+PiBhY3R1YWxseSBpbXBsZW1lbnQgY2FuY2VsbGF0aW9uIGJleW9uZCBkZXN0
cm95aW5nIHRoZSBpb191cmluZyBxdWV1ZT8NCj4+Pj4gWy4uLl0NCj4+Pg0KPj4NCj4+IEkgaGF2
ZSB0byBhZG1pdCB0aGF0IEknbSBjb25mdXNlZCB3aHkgeW91IGNhbid0IHVzZSB1bW91bnQsIGlz
bid0IHRoYXQNCj4+IHRoZSBtb3N0IGdyYWNlZnVsIHdheSB0byBzaHV0ZG93biBhIGNvbm5lY3Rp
b24/DQo+Pg0KPj4gSWYgeW91IG5lZWQgYW5vdGhlciBjdXN0b20gd2F5IGZvciBzb21lIHJlYXNv
bnMsIHdlIHByb2JhYmx5IG5lZWQNCj4+IHRvIGFkZCBpdC4NCj4+DQo+Pg0KPj4gVGhhbmtzLA0K
Pj4gQmVybmQNCj4gDQo+IEhpIEJlcm5kLA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIGluc2lnaHRz
IQ0KPiANCj4gSSB0aGluayB1bW91bnQgZG9lc24ndCBjYW5jZWwgYW55IHBlbmRpbmcgU1FFcywg
cmlnaHQ/IEZyb20gd2hhdCBJIHNlZSwgDQo+IHRoZSBvbmx5IHdheSB0byBjYW5jZWwgYWxsIHBl
bmRpbmcgU1FFcyBhbmQgdHJhbnNpdGlvbiBhbGwgZW50cmllcyB0byANCj4gdGhlIEZSUlNfVVNF
UlNQQUNFIHN0YXRlICh1bmF2YWlsYWJsZSBmb3IgZnVydGhlciBmdXNlIHJlcXVlc3RzKSBpbiB0
aGUgDQo+IGtlcm5lbCBpcyBieSBjYWxsaW5nIGlvX3VyaW5nX2ZpbGVzX2NhbmNlbCBpbiBkb19l
eGl0LCBvciANCj4gaW9fdXJpbmdfdGFza19jYW5jZWwgaW4gYmVnaW5fbmV3X2V4ZWMuDQoNClRo
ZXJlIGFyZSB0d28gdW1vdW50IGZvcm1zDQoNCi0gRm9yY2VkIHVtb3VudCAtIGltbWVkaWF0ZWx5
IGNhbmNlbHMgdGhlIGNvbm5lY3Rpb24gYW5kIGFib3J0cw0KcmVxdWVzdHMuIFRoYXQgYWxzbyBp
bW1lZGlhdGVseSByZWxlYXNlcyBwZW5kaW5nIFNRRXMuDQoNCi0gTm9ybWFsIHVtb3VudCwgZGVz
dHJveXMgdGhlIGNvbm5lY3Rpb24gYW5kIGNvbXBsZXRlZCBTUUVzIGF0IHRoZSBlbmQNCm9mIHVt
b3VudC4NCg0KPiANCj4gIEZyb20gbXkgdW5kZXJzdGFuZGluZywgUUVNVSBmb2xsb3dzIGFuIGV2
ZW50LWRyaXZlbiBtb2RlbC4gU28gaWYgd2UgDQo+IGRvbid0IGNhbmNlbCB0aGUgU1FFcyBzdWJt
aXR0ZWQgYnkgYSBjb25uZWN0aW9uIHdoZW4gaXQgZW5kcywgdGhlbiANCj4gYmVmb3JlIFFFTVUg
ZXhpdHMg4oCUIGFmdGVyIHRoZSBjb25uZWN0aW9uIGlzIGNsb3NlZCBhbmQgdGhlIGFzc29jaWF0
ZWQgDQo+IEZVU0UgZGF0YSBzdHJ1Y3R1cmVzIGhhdmUgYmVlbiBmcmVlZCDigJQgYW55IENRRSB0
aGF0IGNvbWVzIGJhY2sgd2lsbCANCj4gdHJpZ2dlciBRRU1VIHRvIGludm9rZSBhIHByZXZpb3Vz
bHkgZGVsZXRlZCBDUUUgaGFuZGxlciwgbGVhZGluZyB0byBhIA0KPiBzZWdmYXVsdC4NCj4gDQo+
IFNvIGlmIHRoZSBvbmx5IHdheSB0byBtYWtlIGFsbCBwZW5kaW5nIGVudHJpZXMgdW5hdmFpbGFi
bGUgaW4gdGhlIGtlcm5lbCANCj4gaXMgY2FsbGluZyBkb19leGl0IG9yIGJlZ2luX25ld19leGVj
LCBJIHRoaW5rIHdlIHNob3VsZCBkbyBzb21lIA0KPiB3b3JrYXJvdW5kcyBpbiBRRU1VLg0KDQpJ
IGd1ZXNzIGlmIHdlIGZpbmQgYSBnb29kIGFyZ3VtZW50IHdoeSBxZW11IG5lZWRzIHRvIGNvbXBs
ZXRlIFNRRXMNCmJlZm9yZSB1bW91bnQgaXMgY29tcGxldGUgYSBrZXJuZWwgcGF0Y2ggd291bGQg
YmUgYWNjZXB0ZWQuIERvZXNuJ3QNCnNvdW5kIHRoYXQgZGlmZmljdWx0IHRvIGNyZWF0ZSBwYXRj
aCBmb3IgdGhhdC4gQXQgbGVhc3QgZm9yIGVudHJpZXMgdGhhdA0KYXJlIG9uIHN0YXRlIEZSUlNf
QVZBSUxBQkxFLiBJIGNhbiBwcmVwYXJlIHBhdGNoLCBidXQgYXQgYmVzdCBpbiBiZXR3ZWVuDQpT
YXR1cmRheSBhbmQgTW9uZGF5Lg0KDQpUaGFua3MsDQpCZXJuZA0KDQoNCg0KDQo=

