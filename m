Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72378C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 02:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1wkf-0001Gs-TB; Wed, 02 Sep 2026 22:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wkZ-0001GO-6O; Wed, 02 Sep 2026 22:00:23 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wkX-0004pG-9v; Wed, 02 Sep 2026 22:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788400820; x=1819936820;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ziOrL5YrAEK0tjl1d/Luwxbq8R3kVDpq/bgCGxDs1V8=;
 b=kCuXSM6t7UtXtIHrxou4qEYHzlBBE4hUhb8yk4MX67N3gnND+sBLDvE5
 zXB/jTUootLMjbscGVH38TvqH8oNKgXR5cZJbGaOHw1D6TAS2jXw07QCm
 1Ad2a/Jph57TEcF+xxIEBg+8gH+1fskEnMm4jhMFpWeK83+Cf7DUFccYK
 NJzX8Kms0h6ZM4lLNPeALTRJw2wgt3Yhuhtl1lyz12qP8gib/ewTF3F/F
 NQogYsVuMwLws3LIChV38vdXoMWCellTLAkQ7MapJU+cQRblU50GltWRe
 YoSdv8U+dtL9BXR1xMwlyAtNPofIvsk7VMVBPWPTmaYcbEi99yeC+pzpb A==;
X-CSE-ConnectionGUID: eSwYyBzQTeCAp3b91kEhkA==
X-CSE-MsgGUID: jXE4qbo9TbqG7+UQlGaWvg==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="153255318"
Received: from mail-eastusazon11012052.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.52])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 10:00:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW3Kgh3MMBXG5ieX4ga1w5I/Pfelb7+mbynGDBjznCPHk4QAScjuWts6F8f+qTqD6IDhINDycXF3xqCRjX7Q1Ie8eZayDbP0N/uUYHvoQSUFzJkCd0dNQyIsTQX2LN2HIfEreVwD0qutpBM6mu1eiIzH003l1UXl85uAXku9et77kvB/iOcIPDOCyMlLcUWVGK8QvHGsnZK+A/QfG04T67emG89dvpxyJIrZpZRkfEfSkLX6T3GFIcK73Viw40TcZkQ1aeXIjo7gV3MXkWgfn4BaUkr2Ebla6iNIU1P64UkkHIgpxjnx8mdntZ8RgaYjDJlZ0irsYmx4QdP+aVJayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziOrL5YrAEK0tjl1d/Luwxbq8R3kVDpq/bgCGxDs1V8=;
 b=eM8Jr07Y/g73guyP6RO07R2SGtHRsqwTw0mf1AMw+g5vNhwTcYiE5PYNO/KNqlkIyxBoo/hKurijpl+/PtdxGloFENSmu5rT8NDRYkGskHk1O2WoxQZT/Fice8tddAk7tH112nw2OXyMnTNqdGcKKXLPg2n/KmyF5xIypauVp/hogJk/BF9yyOa7qJsaFFJ9kECzmPwfYoatfp75M+EtaXRFOkNoLJoBKbuVZXNGDkbE3qhYO9xYDT0IiS6rPod1mesYJtERehGv1NSL27dFcMiKcNbeQpfkHq/WB2OpogXaSSehlmdqKJHBRHe6IpYIFLbptvzUmLqtRIM9+v/u0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziOrL5YrAEK0tjl1d/Luwxbq8R3kVDpq/bgCGxDs1V8=;
 b=Bl4kkKZXS8830IODgjJyyUxYCYrczJPO7CjX6Wlbx+UVm5sVBZs7bqak8f0kwAZQVOX0R3HtYLFQQlfyomvWi3eECC0JqDDMphq/XIitp+0wx6x01J2OQKDCC+mvPoeL1PjVNvH9GeghCoOxMeAWCtd5tOnmOfGDX58JxGvKPv0=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by EAYPR04MB9969.namprd04.prod.outlook.com (2603:10b6:303:2bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 3 Sep 2026
 02:00:15 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 02:00:15 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 13/16] hw/riscv/atlantis: Make TTAtlantisState own
 memory containers
Thread-Topic: [PATCH v2 13/16] hw/riscv/atlantis: Make TTAtlantisState own
 memory containers
Thread-Index: AQHdOO7EQphApB/pSEuI9K9NGRH6eLa8Hg0A
Date: Thu, 3 Sep 2026 02:00:15 +0000
Message-ID: <eb4d8c5b241b258b83d7c29489a31506fe47c7aa.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-14-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-14-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|EAYPR04MB9969:EE_
x-ms-office365-filtering-correlation-id: a2f7dab9-2edf-4469-0d8a-08df095f18e0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|19092799006|376014|7416014|366016|38070700021|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: aNfja0X6O/cAH4oD0iDWad+1iRN640wMrtaMO7pYBkwqBg/H7OMmFRSj4zAo6vmh7Q4/rRWtbbkFiqWNJVPb/ViHiOxlry1stA3xqWQcsRxLEzIHQoAMlPu15vkvYrluJdaTlikcPhuv/axye6YkBgMH5HDt9myyTvET/aR/rmSRjVO2EEbYY1hGCrKivTU9y11EQNd1JUHlqsAv/8eaodihtoZeX57Ms0skT+ngRWVs5omKOj5yCfDoBp1ualL7T+B68cjWqWTLnPCM//uSUcH9rsjQKu5jXob/RrNRWOnb9Ux80d37EuDPwZniPdlMUfj30osAwmM9j2l4U46Rov49aBmHjwfZa6N7WRTjrfy/Ts2MrvQOnTzv6JawgzD/MGkKzbe0UCTo1MZ3ws5vz3XjYp2J5/5VnfwsIS+mWt2jglwcME32XwM/H6Jma828AkvBl+6Ggm6YnnPsE+WwhIZ2F8hhs6IZi6JJQFFAW/fEOFd2dMdnukFT69dHyeCx1OADWc45Osf1X1yZmvsN10/9oziKZQKIu+uhQPJq8CqBKCIERp40+7rQkv4ouPD48GVFqyAncbOXqOHRpu004vXB1FrYajDJgKY7B+eEYugKcQajj8f1dpPZL5L/tejKfMz3qEbVv4yZVVW8/1yPS8or25DcZ4gFMrckQ5r+v6je3Pz5mLRnKB/S5NRbY6vp8WARg8tVVfowYQEAPY3qdgiNkMrAX8FBdVSxadccMPA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(19092799006)(376014)(7416014)(366016)(38070700021)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVlzOUpCSG1QT2owTVFTVUxQdHhRaHp0UkhNRm11a21oek9lc0tYVDlqK0gx?=
 =?utf-8?B?SzZxU0hHUGZmcnZXQUhNWCtaaUdXMGNmQmhjelZsejZOYm5QVzlxRmRySjlJ?=
 =?utf-8?B?SEpqbjlOdzRQNitwV2xkd1F3Yjh3WFlzZnZDZDBmSlByNlNxRHEwTTVsQktC?=
 =?utf-8?B?RThwMkRwMDkxbVZ5WFcrd3h5WEJsWXVnN1ZKRjY3Y1pRM21HcHVWTDFkZkpK?=
 =?utf-8?B?UzJaaE1DQkdZb2JGQ3Foc3FjU3BlWWhuaU5xQVd2djBxVG16VnBJR3A0VGo2?=
 =?utf-8?B?R0VrdmVNSUxTY2JYemgvWWIyR29LNHo3Y1B1cS81SFNDWjBrN1Z0Q05wbVAx?=
 =?utf-8?B?bGV1enRCTFJqNGNGOTJ2SldpZURJNUJDK3dHZVUzd09OOXRqcWRMZ2pDNm40?=
 =?utf-8?B?Q1lWK2swdm4yNHBRcU1ueUZQRDlmWkRzN2dwakRBRkVSdFpRcDkyaGxLTFZ4?=
 =?utf-8?B?bnJwUnkrOXpQK3dQc0k2Rm84c0ZnM1NRRi9kY2dHTWo5Z3k2cnVGRUphN05Y?=
 =?utf-8?B?TWtSSHNXTTgzbzYwN25xbTJRRnNnRGJmZ00vVGZnaS9aUzEwUFppNE45Z2dK?=
 =?utf-8?B?SExqa1FEWnJncDc5T2ZGVUxyMnJ2NkV6QTIxdUx3VGFyMFB0Y2x6RHZTcXUw?=
 =?utf-8?B?NFNaVzM5TGwvZ3FrT1dRK25aelZiYnJSZ0t3UTlocGJpZk03RjA5V3JIM2FJ?=
 =?utf-8?B?MTlhMEMzSVNTYUlmRzd1anM1eXdHUFBBZUcybXliM3U2NjM5YVNvLytlU0JX?=
 =?utf-8?B?ZytVczRRMzBKbnMraUFnRmhHcDlmTkI3K2NQcHlxUGRhNUtHY09NZWFRTU1R?=
 =?utf-8?B?ZzUvME9rT0U4MExZNnhFZmgrL1V2ZE1SMVhKZGRBR1RreE9TcWlsUFg1UkUv?=
 =?utf-8?B?NDJ3K0FuekxJaGtmSm1ZM2QvUUVQVzFjZk96OEo3cVk2R0ExekZ1NUhrVStN?=
 =?utf-8?B?L3NQTU41ZC9ERDdzMEd3dkFadkczNk9OUVNZMG91OWhKQUY2SC8zb0hmN0pr?=
 =?utf-8?B?UDdDSFo1cVdsa3F3MXdHQ1BDaXVGNWNMV01IQ1dEc0tXTjJvY29nS3NqYW9J?=
 =?utf-8?B?QlFPeUkxamZwZUlHS3NqQTZpREIwWEVEZGNacFg0SzM2WmxnZVFhbE1tWW9S?=
 =?utf-8?B?WHFGMDlMUDJGM25heXdrMDRweXhuMDZPczZMRGpqNWpEZ3RYcmVJZEVPL2Vz?=
 =?utf-8?B?eWk4Y3ZBditqR1ZvQWRsbllST1QzME1YZklWSHJoNUpaRWRKYlNlOWF5UUtm?=
 =?utf-8?B?TWtxVk9GWWNuam5jNklHSDQydHRpekd6dEZYRGtGVDM2YUJJcGU2TDhyVjNl?=
 =?utf-8?B?bGNIZXNuMTRIaFJ1L3k5UjFQa0thL3JETEdFUE11ZFZqa1VBUWFZK1Uvbk5I?=
 =?utf-8?B?M3hDMXhUZU1ZT1gxYjNoSGNqVklrK3hHZlplZTF3WERYbzNxT0FMZXMyUVZC?=
 =?utf-8?B?QzJLQU8vVjlleHpVVTdrSi84alhsdmZvejNYVXZVS1RVdHM3QmlWUEhtNXJR?=
 =?utf-8?B?czR5czQ0S1orUksrWng3ZkEvdUR6d09CSU1TSG0wUDlmVVhvUFFNQ2prME9P?=
 =?utf-8?B?TFJ4cTE4R1k4cHR4QWpnMEgxck1tM2pzYmRjVUdDTGVwZFU2Yk9vL3VxSEpL?=
 =?utf-8?B?MUY4ZVJHdG5YNEpPVW9weGIyTDJFOXhOQnJMUURHM2FNYmc3Und1MHhnWmZW?=
 =?utf-8?B?RjFneVlHM3h0bC91OEUxYkRHSWJhTXBYaGs1a3ZlZzAzUXUvZGRtWXB2ek9y?=
 =?utf-8?B?ZEh2Qk5kTWN0RTVEZ0xEb2ZtTVNkeHE4Z3gzYW5GcUJDTEtYUUg1SGRvNERD?=
 =?utf-8?B?Rm1tTUMvUGdqeDF0eWlyL0FCUDZzc29oYmM3K3VtdXhSamlyMFV0S2p6SHNr?=
 =?utf-8?B?V3oxL2NHdlM3WE9tYnZZZTh5azFETDZycDNNR3BtZ1E5cjJ1S09nZHVlajl4?=
 =?utf-8?B?N0kwMm4rY0JrNjlTZVpTT1VjclVPZlRDNkVXbGVSOUI1Q1lXTzN3S2JFVEFK?=
 =?utf-8?B?NDBDZ0xsVGU5YjlxZkZ4Z3VtTjNKWFNCUk15VVc3cWk5VUVEa05yKzlTUFNp?=
 =?utf-8?B?L3k3OE5heDBXRkg3OXU0SmhMak01aWcrYjU1NWRqWmFBNGRwR1BnVGh3d01Q?=
 =?utf-8?B?SDAvejVjeVNxb1RRL2RlN3JKZ0VFVmRHUzVySWw1T2RHaWRZMTVlTERXQjNS?=
 =?utf-8?B?bGdZKzVtSC9vczI2Uk80S0s3TkVHcGwyeG50emlHeWhVVFRWUnVrSklLc1pK?=
 =?utf-8?B?b1lPaUZacytDZHFZZEhidEVIRTFjTnZBZ29Od0ZtbnFhS0oxRGp4V0tmSXdR?=
 =?utf-8?B?VjJjY0lmdE1rcXJWWGtSekhsSkQ2cCsxOXdtS0F3eXVHSWVVWVJObVF2c0g2?=
 =?utf-8?Q?foiG2mKnFcgS+AnSzn+2FKGKnwqGf4vV/S3+dA/n/Tlcm?=
x-ms-exchange-antispam-messagedata-1: 24P0qlUchGJqwwqBBNGd6pruxd9wosKtqm8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D73F51F57DEF940A332E34BEB9974AA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DlHNfPJXatbBhvPJBz1WktDlMeWoSN4PbXyH8cGBsX3rkxxj6Cv/TRHkAPlLuUvhPj5Y+CElx33coRV0uYBW4ssb1q4nf2oqazjELl0e49VYb5Hu25axsnqlb9moyDNxh1+T9Dk8GN54QrW64DFjqg5zknkivT2/N3mJ/BkZ/xZuMwB1x90v5I+iIcH9+mQICK3mei4KlO0G0WrWDmyKb//jCxCMh/l072c9KEmmydf7xINlYq4cv3yoCk6mX6gzNoV6MDuWtHIjqivAgCpAbsDCYyA5Q/pVP1YH+jkeWrdlEJHkCpiiHyOytMxtBcpXqgn6kw7fujX4J/peITCFFA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L3ZzxTPYgsGq+UXne6ogrDjnIh2c00oksYXEFq5uOwyF4ZBZ7k5fMlWpNMwbY4Bz92H+/BkgseWaNDZXMHGSzHoVUcsO1MFp/L5KqUEmiilhamtv6OzQRlSqj52EvOxpdnZw1ZKtbKwcCN9XKaLMMzLiKjLXkhA6marFAZvzbK60QqdKm6Ukf8B2qXl058Hzm/+ow76I60oQTRt+9fC+ZdEK/gW+8G6KQV4MldLBZgL7WFF9gNQ+OeifFJtKZ/U41Jf04M/+2Ft89EY/h1fYSIwGv+flJv4j7gIv0shOBU2ewrmjcXQjkMETaLwDlsrDI5KRWEx3rIM6MYXChxJpO3hAgc3Rc9kw2jU9N+IsE+ltc98Z/oMwvPIOzBP8sqADtpvcTAhrR902ws09e8G3Lk0GJ/SiUrKEfrKilbKnogu7ByVzRRGnpxzhEXc8EWTUAkqNACTA2L4jtW46aA4eM1xHG3HHlR/91b/YD9bQuc1HLA0oa2xTCNGkhu+ASnPdZC+Eq4KnSvtJlzqWkc8tBqffJ61nnux7zrbe+xBLQtqO2zCecSZMtxUsHTn4+KgrwnLTV52NohKeMubpkgfl+FzrKQjYCS/WpXPUX+1dcBJcRdqeU5tCuPkwjZdR3V1w
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f7dab9-2edf-4469-0d8a-08df095f18e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 02:00:15.3647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BsSv6NqiVJmai8HxZ6ZQodM+6zl/A7Ln7N9sRaiAudLzQ5JHoXvPbT40fQxlx278nhI+JzEFCECfY4tHvPfs+fc3vX9cu4uI1YrXbsUPZp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR04MB9969
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDExOjQ0ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6Cj4g
VGhlIERSQU0gaGksIERSQU0gbG93IGFuZCBib290cm9tIG1lbW9yeSBjb250YWluZXJzIGNhbiBi
ZSBvd25lZCBieQo+IHRoZQo+IFRUQXRsYW50aXNTdGF0ZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBK
b2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5j
aXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgaW5jbHVk
ZS9ody9yaXNjdi90dF9hdGxhbnRpcy5oIHzCoCA0ICsrKysKPiDCoGh3L3Jpc2N2L3R0X2F0bGFu
dGlzLmPCoMKgwqDCoMKgwqDCoMKgIHwgMTUgKysrKysrLS0tLS0tLS0tCj4gwqAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaAo+IGIvaW5jbHVkZS9ody9yaXNjdi90dF9h
dGxhbnRpcy5oCj4gaW5kZXggMmVjMjgzZDBmZDdiLi45Y2E5OGJmYjg0NzggMTAwNjQ0Cj4gLS0t
IGEvaW5jbHVkZS9ody9yaXNjdi90dF9hdGxhbnRpcy5oCj4gKysrIGIvaW5jbHVkZS9ody9yaXNj
di90dF9hdGxhbnRpcy5oCj4gQEAgLTMxLDEwICszMSwxNCBAQCBzdHJ1Y3QgVFRBdGxhbnRpc1N0
YXRlIHsKPiDCoAo+IMKgwqDCoMKgIE1lbW9yeVJlZ2lvbiAqbWVtb3J5Owo+IMKgwqDCoMKgIE1l
bW9yeVJlZ2lvbiAqZHJhbTsKPiArwqDCoMKgIE1lbW9yeVJlZ2lvbiByYW1faGk7Cj4gK8KgwqDC
oCBNZW1vcnlSZWdpb24gcmFtX2xvOwo+ICsKPiDCoMKgwqDCoCBSSVNDVkhhcnRBcnJheVN0YXRl
IGNwdXM7Cj4gwqDCoMKgwqAgRGV2aWNlU3RhdGUgKmlycWNoaXA7Cj4gwqDCoMKgwqAgRGVzaWdu
V2FyZUkyQ1N0YXRlIGkyY1tUVF9BVExfTlVNX0kyQ107Cj4gwqDCoMKgwqAgVW5pbXBsZW1lbnRl
ZERldmljZVN0YXRlIHVhcnQxOwo+ICvCoMKgwqAgTWVtb3J5UmVnaW9uIGJvb3Ryb207Cj4gwqB9
Owo+IMKgCj4gwqBlbnVtIHsKPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvdHRfYXRsYW50aXMuYyBi
L2h3L3Jpc2N2L3R0X2F0bGFudGlzLmMKPiBpbmRleCA3YTlmNTg3MmM3YzAuLmI4MGJkZjU0YzQw
YiAxMDA2NDQKPiAtLS0gYS9ody9yaXNjdi90dF9hdGxhbnRpcy5jCj4gKysrIGIvaHcvcmlzY3Yv
dHRfYXRsYW50aXMuYwo+IEBAIC00ODMsOSArNDgzLDYgQEAgc3RhdGljIHZvaWQgdHRfYXRsYW50
aXNfbWFjaGluZV9pbml0KE1hY2hpbmVTdGF0ZQo+ICptYWNoaW5lKQo+IMKgewo+IMKgwqDCoMKg
IFRUQXRsYW50aXNTdGF0ZSAqcyA9IFRUX0FUTEFOVElTX01BQ0hJTkUobWFjaGluZSk7Cj4gwqAK
PiAtwqDCoMKgIE1lbW9yeVJlZ2lvbiAqcmFtX2hpID0gZ19uZXcoTWVtb3J5UmVnaW9uLCAxKTsK
PiAtwqDCoMKgIE1lbW9yeVJlZ2lvbiAqcmFtX2xvID0gZ19uZXcoTWVtb3J5UmVnaW9uLCAxKTsK
PiAtwqDCoMKgIE1lbW9yeVJlZ2lvbiAqYm9vdHJvbSA9IGdfbmV3KE1lbW9yeVJlZ2lvbiwgMSk7
Cj4gwqDCoMKgwqAgcmFtX2FkZHJfdCBsb19yYW1fc2l6ZSwgcmFtX3NpemU7Cj4gwqDCoMKgwqAg
aW50IGhhcnRfY291bnQgPSBtYWNoaW5lLT5zbXAuY3B1czsKPiDCoAo+IEBAIC01NDMsMjIgKzU0
MCwyMiBAQCBzdGF0aWMgdm9pZAo+IHR0X2F0bGFudGlzX21hY2hpbmVfaW5pdChNYWNoaW5lU3Rh
dGUgKm1hY2hpbmUpCj4gwqDCoMKgwqDCoMKgwqDCoCBleGl0KEVYSVRfRkFJTFVSRSk7Cj4gwqDC
oMKgwqAgfQo+IMKgCj4gLcKgwqDCoCBtZW1vcnlfcmVnaW9uX2luaXRfYWxpYXMocmFtX2hpLCBP
QkpFQ1QobWFjaGluZSksICJyYW0uaGlnaCIsIHMtCj4gPmRyYW0sCj4gK8KgwqDCoCBtZW1vcnlf
cmVnaW9uX2luaXRfYWxpYXMoJnMtPnJhbV9oaSwgT0JKRUNUKG1hY2hpbmUpLAo+ICJyYW0uaGln
aCIsIHMtPmRyYW0sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAwLCByYW1fc2l6ZSk7Cj4gwqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl9h
ZGRfc3VicmVnaW9uKHMtPm1lbW9yeSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+bWVtbWFwW1RUX0FUTF9ERFJfSEld
LmJhc2UsCj4gcmFtX2hpKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+bWVtbWFwW1RUX0FUTF9ERFJfSEldLmJhc2Us
ICZzLQo+ID5yYW1faGkpOwo+IMKgCj4gwqDCoMKgwqAgbG9fcmFtX3NpemUgPSBNSU4ocmFtX3Np
emUsIHMtPm1lbW1hcFtUVF9BVExfRERSX0xPXS5zaXplKTsKPiAtwqDCoMKgIG1lbW9yeV9yZWdp
b25faW5pdF9hbGlhcyhyYW1fbG8sIE9CSkVDVChtYWNoaW5lKSwgInJhbS5sb3ciLCBzLQo+ID5k
cmFtLAo+ICvCoMKgwqAgbWVtb3J5X3JlZ2lvbl9pbml0X2FsaWFzKCZzLT5yYW1fbG8sIE9CSkVD
VChtYWNoaW5lKSwgInJhbS5sb3ciLAo+IHMtPmRyYW0sCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwLCBsb19yYW1fc2l6ZSk7Cj4g
wqDCoMKgwqAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKHMtPm1lbW9yeSwKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cy0+bWVtbWFwW1RUX0FUTF9ERFJfTE9dLmJhc2UsCj4gcmFtX2xvKTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+bWVt
bWFwW1RUX0FUTF9ERFJfTE9dLmJhc2UsICZzLQo+ID5yYW1fbG8pOwo+IMKgCj4gwqDCoMKgwqAg
LyogQm9vdCBST00gKi8KPiAtwqDCoMKgIG1lbW9yeV9yZWdpb25faW5pdF9yb20oYm9vdHJvbSwg
TlVMTCwgInR0LWF0bGFudGlzLmJvb3Ryb20iLAo+ICvCoMKgwqAgbWVtb3J5X3JlZ2lvbl9pbml0
X3JvbSgmcy0+Ym9vdHJvbSwgTlVMTCwgInR0LWF0bGFudGlzLmJvb3Ryb20iLAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5tZW1tYXBb
VFRfQVRMX0JPT1RST01dLnNpemUsCj4gJmVycm9yX2ZhdGFsKTsKPiDCoMKgwqDCoCBtZW1vcnlf
cmVnaW9uX2FkZF9zdWJyZWdpb24ocy0+bWVtb3J5LCBzLQo+ID5tZW1tYXBbVFRfQVRMX0JPT1RS
T01dLmJhc2UsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJvb3Ryb20pOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcy0+Ym9vdHJvbSk7Cj4gwqAK
PiDCoMKgwqDCoCAvKiBVQVJUMSwgdGhlIHNvYyBjb25zb2xlIChVQVJUMCBpcyBmb3IgdGhlIGJv
b3QKPiBtaWNyb2NvbnRyb2xsZXIpICovCj4gwqDCoMKgwqAgc2VyaWFsX21tX2luaXQocy0+bWVt
b3J5LCBzLT5tZW1tYXBbVFRfQVRMX1VBUlQxXS5iYXNlLCAyLAo=

