Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3918BCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3PGb-0003Ac-9v; Mon, 29 Sep 2025 21:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PGY-000398-V4; Mon, 29 Sep 2025 21:34:55 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PGS-0002pz-AU; Mon, 29 Sep 2025 21:34:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WF16BEWg4ibtfUwzkG2ioBh9tqdJEqQtAjwxXdngNmpcV4w0F1wW7QEZIm3nET9VD3L2zCKxFNS7TNraD0139aBepbwtseGtvpOmkx/YCT5Bbgg5gCibgHKdM2S1APkDimPL52xujJQcq+8Q6Q/KMUsM/8y+5idccJoRyVQhslPtXuocqyLephWMtdgyzILDWufxm1bHQFTtwvv2HuLNcBBXhUkEhWy8Yj3/gbHn+vI+KTubf4IWZWhIboDb9oQmEoGMQIyPjib7zaBgsENPDIc0zBp+c4PIm89IYt3ebIjfaBXZr59qSivFE2VSecTIr5zH5UpJDEO15ZCuauR1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/ZzfwX62pXMsHOMkx4gEcGg8+pGF1lvikYLXvANVG0=;
 b=SmrZEDRvZq4hokDRjt+4yLJWcJZIy1srS1DZV04qCanWPT9+18MdNA+Ov7UFzMSiCF/jNYA7dtctN4Waxgt/ZssJC8aWVpAxWWOxJfext6o3sBmXkXn+46hs5xdPtDpJT/nup9lIqt+/T43iwNkQkhYLE0741f7W6JOtirzpVfUh6w16rWE7siZ78BegICB8LwBVOzvWsr/sIZqrEQoOYV+yNROF3yC4i8AO61LRsamWe0amSpqXfnGZqk/w1BQ3rS05H8Nqlz2KcbQSSBRKK9VRumn4a8IJld54C+RWoYVfGgLEGP/66zMcyaSzrJmsWeyP9R++fmGOfbGGeyUnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/ZzfwX62pXMsHOMkx4gEcGg8+pGF1lvikYLXvANVG0=;
 b=qBi3gqt/YoG5wtZ9n5Ygl5QddhRp0iqAMg6qayeBwVyApGuAENUFWXn8VttABXPwyyH3UYMx6cNBm6lOJLHnGKHRtSPFU+7FqZtPh/zTsXSfv6wWU9f56wbLdrsXimlwfFXLZGTJEnJNVQvdrrcGst5trb9hdVTWDuYHIgGFJPGXZn6o2gTO9mv6DR21J3lyPbcXQ/tRxbOuhd0++AbvYVbB4K+SRfinxOLOEVTze2kFkUNH8p/fTm/329ku2SwYlc4qIoBO0BCFVtFNgohCUisIgOiDYBm030FRSfZ94bbT1YLciYswRWmisnDfzA958HD/68F5gJqcUd2kkcgDwg==
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com (2603:1096:405:319::8)
 by TYQPR03MB9459.apcprd03.prod.outlook.com (2603:1096:405:2ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 01:34:39 +0000
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956]) by TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 01:34:39 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Peter Maydell <peter.maydell@linaro.org>, Yubin Zou <yubinz@google.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Titus Rwantare <titusr@google.com>,
 "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>, "CHLI30@nuvoton.com"
 <CHLI30@nuvoton.com>, "Avi.Fishman@nuvoton.com" <Avi.Fishman@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "tali.perry@nuvoton.com" <tali.perry@nuvoton.com>
Subject: RE: [PATCH 4/7] hw/pci-host: add Nuvoton PCIe root port
Thread-Topic: [PATCH 4/7] hw/pci-host: add Nuvoton PCIe root port
Thread-Index: AQHcIda0RcyFVWdBwUO6ZHKlMzLy57SkMvMAgAbeExA=
Date: Tue, 30 Sep 2025 01:34:39 +0000
Message-ID: <TYPPR03MB9497A36FEEFC42A288378212DB1AA@TYPPR03MB9497.apcprd03.prod.outlook.com>
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
 <20250909-pcie-root-upstream-v1-4-d85883b2688d@google.com>
 <CAFEAcA-cKA1uNAVjETGRjDTLzp5psY5k9nRNjS5Cr2gZ7KY7fQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-cKA1uNAVjETGRjDTLzp5psY5k9nRNjS5Cr2gZ7KY7fQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR03MB9497:EE_|TYQPR03MB9459:EE_
x-ms-office365-filtering-correlation-id: 47da0b51-93ef-49b5-b22e-08ddffc185bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?akI4V0lEOWp2SWpIUmdiZXU5SnBEZVlFdnVIYkJHSW5WOFFoZml5YS9oYXJD?=
 =?utf-8?B?S0I0UTgyR3NOd3p4K1hSWHNhbWtyTGJGaW03UlRzNndpQUZIem1CdUJTRUFt?=
 =?utf-8?B?K2ZacFA4cTZJMERDcElZSXZjUnpTVVBzV3h2U3JpN2I5eHFrMHdteW9jeFR2?=
 =?utf-8?B?Z0RTa1Zzb1dabFc0RlczdmhvemZGWEJlcE5BSVhCTUY5QmtNY2tQSFJFcVZk?=
 =?utf-8?B?UHpMR3pwajVTMVMyVEtYZmZWeStaL1lFQUlwU0szNTEybTdRWS8wOEpsZ0c0?=
 =?utf-8?B?U3IzT0c0b3R4cGhrQklZSzdYNVJWZURKN01RbHVGcnl0YzZXQ1lXZ1NDQmlG?=
 =?utf-8?B?WnQ0UmdVV3F0MXB2ajBGbVYvamRlUFg2ZzBuNTlKdDlNUFh3anJUS285UTA4?=
 =?utf-8?B?b0dDZm9LcEh4SkFjU3JyUHAvTDRGQkkvbUt2dXBiMnp6eGJuOVQvTitCaktH?=
 =?utf-8?B?Z1N2a0xvMWFQeDVhYjQxejloRVpIdG1RcGFYMVR2NmsxbDAwVHc2UURybUJh?=
 =?utf-8?B?ZXVPMDI0WUpOQWRTMVVDMUhnUmIvMElSR3k3R0llMzFoUTFIbVEvYXpPdDVn?=
 =?utf-8?B?Tk0yaUY4ci80ZG1VdWJVLzAwZGROZmVUMGMya1BBNmRYMmZPQnJLWmxVRUFy?=
 =?utf-8?B?c2VjR3liaTB3cHJpUGVXL2NYdlJjMzZETU5ES1VLZk02OEREY0RSc0N0SFNF?=
 =?utf-8?B?NHdkUlBGUkcyMmp5VVpkMjJGV1drNkx5RjROZmw3VW1TTGlVakdhdVNCTE1Y?=
 =?utf-8?B?dkhEa3FwUlpPRzNNZnpTU1Bkai84U1BHcFlBT1Jidjg0MnU2eVlxRGZlcXVp?=
 =?utf-8?B?R0pmMG5OWW1HdHJXTUpqc01PbUZUcWRqREF4Z21nYVpyYmVSMGoyY0M4T09O?=
 =?utf-8?B?VWFvM3RWVFd2cFFPK2NjNWdVVFNTUDZpZWtTNVgxb3FtZWM5RHNaSHJ1am1I?=
 =?utf-8?B?aDlxbEpta0dEVHJpNGI4OFRTUU5VcW95U1V2YXVyUFJjQ2lPWkY3ZzhmRXRF?=
 =?utf-8?B?UDUzUmZUMHJnakxzaGlaVzZ2Y0Fmc2lOK3lmdytaMkp6Nk9MWGhoQkdGR3ls?=
 =?utf-8?B?QW1Wc21EOEFyV0tKOUtoOXY3ZEhwVTlXVHdTcDBsMllXTDlVa0FlWmxyVHhE?=
 =?utf-8?B?U0haZ1lxZ0VQc2hSbSt2S295WWpnaXJacDJNdXJTRUx5WFJSSnJXOXVZMmJV?=
 =?utf-8?B?bW5oU1JaL29RSzdCak41WU9GMytPR3A1YjJuN0Y1WXVHSlkvMGN3aW81Y3Jm?=
 =?utf-8?B?dmZTQWF6YnFkYXMwSjRVQUVtcmJDczgwQmsvS1p3T1lpakxiRlVldVIxa2xv?=
 =?utf-8?B?Nlk0N2F3N1RVdmJKS3FZWDNNUjVpQlJDNXJ4N3NUeEQrais4MmdKRTMzamcz?=
 =?utf-8?B?T0FPell4cnBJd1NnSVcxamlZUnpUY2tYMjROSzlmMkJBclFWdkNXY083WGgr?=
 =?utf-8?B?d0swQ2JUMUlqcjc0Ukcwcy9YWmdubTlqU0NJNEZHSHFuQUtOZzhSbFZrb0lt?=
 =?utf-8?B?RXlUcFdNZFRZSFZLNDdiMnJaK0RsV0FueW5sM2tLejV5RU45dExIZ3BCekxB?=
 =?utf-8?B?VEpYY0ZoNWszb1o5UjYyN09FaFFzcS9OR0FySXRrUmRrQ2xCbDJvYlp3WTZm?=
 =?utf-8?B?NXUvZlJzQm5aNmhUNlJ1SUhOTHdCcm9YNE9UL1ZsVjlrbVRsUWdGL2R4ek4y?=
 =?utf-8?B?cU96TkJlRTFVZTlnckgrZmN1aVc3WTNrVXUyRDRiWXdKYzBjN3RGVXNlRjhS?=
 =?utf-8?B?bkZKVkdyS3JzVWVYN2pSZ2orSU9tWC8rbXF1L0U5U0k0Y2JzVktzdnZTTGFI?=
 =?utf-8?B?VGU2MTluSFhPZGtlVU5NWnU4UjhOd2RqbUY1c2tINE1oMkJuM0JBNzZwQ3lz?=
 =?utf-8?B?cXloUWhBREVYNkJWTjNSZ3ovUEQxaFIxWVM1YXJBdTBVL1lBNzRyVUYreGJP?=
 =?utf-8?B?UTBTUWNSQXJtRjd6dFQ2VFNCOVpEbEM2Y09DUGR3TFVuS3k3ckR6L3E3bUdj?=
 =?utf-8?B?QldjcWtKVWZtQzlaTUZGTzR3YVI3K1hCQWlQSVpMTTZwRTN1WG1WTXJ4eEFV?=
 =?utf-8?Q?YLtOJf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR03MB9497.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajB0Tk9GcGNxVnl5NDBOSmI3VE1lQWhIbSt3OTZXV3YvK09YMkowZEJ4RlQ4?=
 =?utf-8?B?eHcrMmRsbGFVNTZsN1ZLKzI4enkyUlVPR1pUMWVyYlNlYUdoYjJnMVlZMzBR?=
 =?utf-8?B?ZjJ3ZmlTd0J5bjBVUEpBY3VJdHVaeU5GSUdERmNvZDV1R2JkOG5Tb094Zzcx?=
 =?utf-8?B?TTZzYkhBeHhUUDJmN3lHS3Y1OHovRkkyNzBXTnpHWVVoVFRGazIxb09tcXBV?=
 =?utf-8?B?eEZaS3J1WWJycllES1Z3cmJQZ1FQenA4ZDBhcG14U3E4UUFSOGdyQWJYdk1M?=
 =?utf-8?B?cmVOUlFxcVB4ZVBZRzdSd20xL2FJOUxrdDdneTVvN1c1ZUE4ZGUzRjBJTEU2?=
 =?utf-8?B?UmNGNmJRbCsxcVdyeHhHVmoxdWRyOUxIa094RTk5OWpwaXV0RVpFTFdZZVBQ?=
 =?utf-8?B?b0VMRi9TVG1pazdxcnYwbG5TZjVWYkRqaVlocUswUVF0dUM0Z2hnZUIyQXRt?=
 =?utf-8?B?TWFyRmlZaE1WL3VVY2FxM0laTkxPVklJMlFVTGlVWUhrSk4xUVpQTlhySjNt?=
 =?utf-8?B?N0lId3FNc09VSmpLSU83cDlsKys4U2hNUXE0WDlUUDJZUzV4M0FNT3BTY3Q4?=
 =?utf-8?B?TW8vUFV2Y0YzWFMwdmJ5OXVNYURkaFlVdHl1Wi9JeGpNTGF1c2NtaC9EeVkr?=
 =?utf-8?B?NFRmeFZVaFdiUU9YR0xpbm1lSjd1djMxZG9ibW81eFE2TndJektXUmdOdC9Y?=
 =?utf-8?B?Qi94eGJIWGZLMlZnRXRyaXViWlZmVDNqczdyVDZQUkhQcEJaUU51VTFEVUdu?=
 =?utf-8?B?OHlNbHdqK1VPdmRGUlh4Ny93OUsvbzFnYld6clhqbjhpRDUxaTQ4aVdIeUhH?=
 =?utf-8?B?UThPaURnMHNqalJFQ280VkJPS2FHMHZZcHNJNDVOSnFYQ1dKVHh6MG15SVF3?=
 =?utf-8?B?Ri9OeElUaHgrT0RUUkVrWVVscXUwZ2dOMkE4MHZlaHE2cWdCdVpVWnpnS083?=
 =?utf-8?B?bHl4Q2xmVE44N3JKSE1Va1N2S1RZVzdabmpnc0VONXJqL2FjbzFVVFJOejZu?=
 =?utf-8?B?OE1TUDU5Y3ZVMTBsdXJXbmlSZmJKQnp1L0RPSGliNUg5TUVDcHRCTkliN1Rp?=
 =?utf-8?B?M3NBa25yOTJUck1YUGMrY0dDMUVRODNyZVFOejY0eHI2YUZSNlVnYkxiWmpl?=
 =?utf-8?B?VFp5VVFXaGJCZHVMd2FHNkpEdldQTVlrQkMxamhnRDRXblZmSy9MdFhBdU81?=
 =?utf-8?B?a1NjN21ReE8vYmxyUVRGeXhJbnlOWDRONXdGVDZjMlpteGV1OVhtUEQ5OFZv?=
 =?utf-8?B?R0dpc2FzSlVTN2lCOE5BVzVmM3RxWFY1RFBjYU14dkg4QnZudmdvK0RMNHBN?=
 =?utf-8?B?amNPZVBiRjZkY3RkaGU3S29Yczl2TXpaNTlES1V3SWF3S1pXSGxsTXJTcktO?=
 =?utf-8?B?TnVVVjEwV0trQlUvZjZ4OXpJUC84cXNIdFFCbFFnWngyanMvWitYbXorZFpl?=
 =?utf-8?B?Tm5oMU1zd3g2T3hCMEllektWYVZJRTJFQXh3VlQ0NEdtZEw5aHVMWjdNTWg2?=
 =?utf-8?B?WklKQmtPMkN0cHd1NlpJNGpVMDlGV3MzKzE2T24wSnREcGF5RG83U0J2UjE4?=
 =?utf-8?B?YWNoWEJsOWtUaFQrNVJoVUpGODFUbnk1SVJPWWVIZHVkdHRiNnh2YnhhbzZz?=
 =?utf-8?B?UXY0VUY5YWxEWnMyQWdEQjM5RUQ1eUpxaDFJbXRkangvTWVzOHNXL0FUVHVk?=
 =?utf-8?B?SnovQXpOVlpBanI3bVJCTm9tN1M5WEo1RFBPRjRtT21ycWRRTk5uMjlKL0N5?=
 =?utf-8?B?cDJzWlRVS1Vwc2RwZVZGeW5mTDBXNDh3SUprcGMyL1BkVE8vNGR5QUYyTStM?=
 =?utf-8?B?WkRkaFgrU0hWeXlPVE53eGlxUklScTdMSFlRd0ZNVmljQUpSQ2V2WHRYMlpY?=
 =?utf-8?B?bnUvNDd6dFdnb0swYXFRMWFxUWdRd09Kbml3UGZMeXllYzlRTGt5akxFb2xy?=
 =?utf-8?B?YTNZZm44MXFIeDg1blJNWkFQa010Z1RDQVQ2bC9FTFU5RllMNUdQUzRrOEN2?=
 =?utf-8?B?UHo4VkdNL0d3eUpuayt0bWU3OXQ0ODRWM2RpclVCSUhFOWUvdFAyNUNCWUpq?=
 =?utf-8?B?em5oRFM3L3lxVzIxSU5RNk8yTnRwVmpWemVOMVJxcUZDYkptazUrb3FqVEVX?=
 =?utf-8?Q?SxNidDPAoQWm/nl9Z8fNx6nBf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR03MB9497.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47da0b51-93ef-49b5-b22e-08ddffc185bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:34:39.3411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+XSoFOOUPGtRiJa8KrUVL2EJZO3lYqDLvuLp6f9yPjqiLs3GXexBzHDblGDactpOpf1h1uq2GosMrjvlEoHfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9459
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=KFTING@nuvoton.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

TG9vcCBpbiBtb3JlIE51dm90b24gZm9sa3MuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQpTZW50OiBG
cmlkYXksIFNlcHRlbWJlciAyNiwgMjAyNSAxMjo0MiBBTQ0KVG86IFl1YmluIFpvdSA8eXViaW56
QGdvb2dsZS5jb20+DQpDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBQYW9sbyBCb256aW5pIDxw
Ym9uemluaUByZWRoYXQuY29tPjsgQ1MyMCBLRlRpbmcgPEtGVElOR0BudXZvdG9uLmNvbT47IEhh
byBXdSA8d3VoYW90c2hAZ29vZ2xlLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7IFRpdHVzIFJ3
YW50YXJlIDx0aXR1c3JAZ29vZ2xlLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggNC83XSBody9w
Y2ktaG9zdDogYWRkIE51dm90b24gUENJZSByb290IHBvcnQNCg0KQ0FVVElPTiAtIEV4dGVybmFs
IEVtYWlsOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGFja25vd2xlZGdlIHRoZSBzZW5kZXIgYW5kIGNvbnRlbnQuDQoNCg0KT24gVHVlLCA5IFNlcHQg
MjAyNSBhdCAyMzoxMSwgWXViaW4gWm91IDx5dWJpbnpAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+DQo+
IEZyb206IFRpdHVzIFJ3YW50YXJlIDx0aXR1c3JAZ29vZ2xlLmNvbT4NCj4NCj4gU2lnbmVkLW9m
Zi1ieTogVGl0dXMgUndhbnRhcmUgPHRpdHVzckBnb29nbGUuY29tPg0KDQo+IC0tLSBhL2h3L3Bj
aS1ob3N0L25wY21fcGNpZXJjLmMNCj4gKysrIGIvaHcvcGNpLWhvc3QvbnBjbV9wY2llcmMuYw0K
PiBAQCAtMjAzLDYgKzIwMyw3IEBAIHN0YXRpYyB2b2lkIG5wY21fcGNpZXJjX3dyaXRlX3dpbmRv
dyhOUENNUENJRVJDU3RhdGUgKnMsIGh3YWRkciBhZGRyLA0KPiAgICAgIG5wY21fcGNpZV91cGRh
dGVfd2luZG93X21hcHMocyk7DQo+ICB9DQo+DQo+ICsvKiByZWFkIHJvb3QgY29tcGxleCBjb25m
aWd1cmF0aW9uIHJlZ2lzdGVycyAqLw0KPiAgc3RhdGljIHVpbnQ2NF90IG5wY21fcGNpZXJjX2Nm
Z19yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsDQo+IHVuc2lnbmVkIHNpemUpICB7DQo+
ICAgICAgTlBDTVBDSUVSQ1N0YXRlICpzID0gTlBDTV9QQ0lFUkMob3BhcXVlKTsgQEAgLTI0OCw2
ICsyNDksNyBAQA0KPiBzdGF0aWMgdWludDY0X3QgbnBjbV9wY2llcmNfY2ZnX3JlYWQodm9pZCAq
b3BhcXVlLCBod2FkZHIgYWRkciwgdW5zaWduZWQgc2l6ZSkNCj4gICAgICByZXR1cm4gcmV0Ow0K
PiAgfQ0KPg0KPiArLyogd3JpdGUgcm9vdCBjb21wbGV4IGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXJz
ICovDQo+ICBzdGF0aWMgdm9pZCBucGNtX3BjaWVyY19jZmdfd3JpdGUodm9pZCAqb3BhcXVlLCBo
d2FkZHIgYWRkciwgdWludDY0X3QgZGF0YSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBzaXplKSAgew0KDQpUaGVzZSBjb21tZW50cyBsb29rIGxpa2UgdGhl
eSBzaG91bGQgaGF2ZSBiZWVuIGluIGEgcHJldmlvdXMgcGF0Y2ggd2hlcmUgdGhlIGZ1bmN0aW9u
cyB3ZXJlIGFkZGVkLg0KDQp0aGFua3MNCi0tIFBNTQ0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQogVGhlIHByaXZpbGVn
ZWQgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGVtYWlsIGlzIGlu
dGVuZGVkIGZvciB1c2Ugb25seSBieSB0aGUgYWRkcmVzc2VlcyBhcyBpbmRpY2F0ZWQgYnkgdGhl
IG9yaWdpbmFsIHNlbmRlciBvZiB0aGlzIGVtYWlsLiBJZiB5b3UgYXJlIG5vdCB0aGUgYWRkcmVz
c2VlIGluZGljYXRlZCBpbiB0aGlzIGVtYWlsIG9yIGFyZSBub3QgcmVzcG9uc2libGUgZm9yIGRl
bGl2ZXJ5IG9mIHRoZSBlbWFpbCB0byBzdWNoIGEgcGVyc29uLCBwbGVhc2Uga2luZGx5IHJlcGx5
IHRvIHRoZSBzZW5kZXIgaW5kaWNhdGluZyB0aGlzIGZhY3QgYW5kIGRlbGV0ZSBhbGwgY29waWVz
IG9mIGl0IGZyb20geW91ciBjb21wdXRlciBhbmQgbmV0d29yayBzZXJ2ZXIgaW1tZWRpYXRlbHku
IFlvdXIgY29vcGVyYXRpb24gaXMgaGlnaGx5IGFwcHJlY2lhdGVkLiBJdCBpcyBhZHZpc2VkIHRo
YXQgYW55IHVuYXV0aG9yaXplZCB1c2Ugb2YgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIG9mIE51
dm90b24gaXMgc3RyaWN0bHkgcHJvaGliaXRlZDsgYW5kIGFueSBpbmZvcm1hdGlvbiBpbiB0aGlz
IGVtYWlsIGlycmVsZXZhbnQgdG8gdGhlIG9mZmljaWFsIGJ1c2luZXNzIG9mIE51dm90b24gc2hh
bGwgYmUgZGVlbWVkIGFzIG5laXRoZXIgZ2l2ZW4gbm9yIGVuZG9yc2VkIGJ5IE51dm90b24uDQo=

