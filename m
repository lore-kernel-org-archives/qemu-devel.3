Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665E8C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 06:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcgWj-000346-8L; Wed, 21 Feb 2024 01:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1rcgWh-000335-26; Wed, 21 Feb 2024 01:56:19 -0500
Received: from mail-mw2nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:240a::601]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1rcgWd-0003ZZ-V0; Wed, 21 Feb 2024 01:56:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQcRawYbaC0koM8Nt2gEcj7Za5qemnjoYA12WLJP/jQy6AW1Qnr2szf5ZsSupZndGC5YRd4LYcpBNEbVPMZITWGSSO4zE3JUxqHf88WWLUmPTv/ZGHr14NZ8kqw+6Aak8ojaJQYerDJeyCdjmHsd+eh/yQmJzsQsS4/JK/QPF69+A3WpeONMuKXJQbIBmMRaV+me39msiFtfGSj7KAlRN0nMn7r3/MUNDcgiX5br8tfEFZ62q0uTKjNBk+CLo7clV4uZQMFOURhfoNnGRv1XqxWTXPUF2f4memmnRCfCPqbZ3bAJGMRDPmKiSJaSEPhCp0R2scStiHYaAETUZdtPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbALR0gp6Mjs8DJ4LRfs8MjuN0jzebzMtfw12O8aVg8=;
 b=Y1bCdja8KyusqeDRbPY3JHYaxDxgViELOtP1lP3sA23+k9/gYtJuc8MzlAYo6VRyhhiKANPMx1kFDlviPPJE67lnBCYjNBsS500UCkgIJnCbMsqTnroXX3M+BnRgNLqiU5ZvdlD1MJqUUku9+reo7vPbOXfHcHhT2Dj+4KmUxNDjAwKG2Zon5g7RILX30IX4MrdyyHkgkGcx0LLQTKhiNfFE1Z15KGI4M1FkwHbF9p56+sw5nKtbkYZqeEyqYKRP2dnuuYU3fDKpmJaSd5rgugtdhvTP8WbuBiLHZdypYULdKQOsaLjUst5AzmKuiYjvdqCqeYAXTjcvhfnaz6Bm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbALR0gp6Mjs8DJ4LRfs8MjuN0jzebzMtfw12O8aVg8=;
 b=FoDsEpKndTIY6KGCKldDHn+fBQAJvNoh0on9eYYP+AVOsLhTlJSbaUnECzNC/VxatmKfS3QNlOKncyA8gQTlipIENVYgWLIuXR1BFWlRGK8bPsS6yTQLL1a40CCteRLqoZPKFyK4ple4o/L3Cay5MQ2mvVrO1avIBTXNEkZJluw=
Received: from BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 06:56:04 +0000
Received: from BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::966b:10b0:c403:7c8]) by BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::966b:10b0:c403:7c8%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 06:56:04 +0000
From: "Ho, Tong" <tong.ho@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/char/pl011: Add support for loopback
Thread-Topic: [PATCH] hw/char/pl011: Add support for loopback
Thread-Index: AQHaWYL20Hdq88DgJEK63my40I/IYrEAUxMAgBQYSvo=
Date: Wed, 21 Feb 2024 06:56:04 +0000
Message-ID: <BL0PR12MB488255D9C3286058E51CBC3AE6572@BL0PR12MB4882.namprd12.prod.outlook.com>
References: <20240207050308.3221396-1-tong.ho@amd.com>
 <CAFEAcA-JnKM9TCbp5=_Ogsnz+GSO96CcP1T-_5jTrSEXAyXc2Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-JnKM9TCbp5=_Ogsnz+GSO96CcP1T-_5jTrSEXAyXc2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4882:EE_|SJ2PR12MB8876:EE_
x-ms-office365-filtering-correlation-id: d9fdacaf-5fdd-4464-7bf4-08dc32aa2c18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zj+jk4Gozjf+mUlfNY/iamIIItjY48OUAZ1HjxoVYh4JgFQ0IPXqtUlB2Y1g1KYz/4gEnhWnEOb+Np6fLNBDHrEmD946ShQFeHLDRwyHDWYKqkvwhkcGU7Xt5XPko1p3+gDGvf4VP9kDWHs3J0BDgy/jZr6skWROsjyd2Kv3mXmAhLp1zQZOLrY/vpNvuCUy2MOc/JhuotnJwlkJ200ifC4Z/UQQo8dIPsWuDdHr5lX1IVSfDNOxld4VLklXwEgN06qSboTs/Qmzm/l7JWBsEmUzQ7pXzw5UI5MQph9TFQdc4DV5PU0VXV+T4I8c8qeOFOlvnJpkCABkMgMPv1yks582NprdeGWYaj1zcUf2CG1iHOL57fGHUgXuYLkJ5wwLm2mrgqkMOhMdnITXT7a7fQniN2epZ+zzD71Wg/WqokpvQQNZ9QKJ+swrWLvmiqDMWnHSWgD/FFUMvp4zzK5YhVG4rL2L4Pi1BIPcZuTQyuLZ34qpZbxfHPBj1pz2xKB/QoE77E8zqGvRZdfurf4H2N7a+p8UdXWKu0YoCfIz00DVWQFUsLLC0s2B+KLoZq42VHj4cz1h0YVEf6zaEFGb8iDwKwQIwpeXxA5+ZcjxNek=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4882.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5bfaouJD0jujr5ODyFCZa9c8MmTc0YxK+ffOwInk8jRrIH/baHev/rC49W?=
 =?iso-8859-1?Q?6+vZdH1DDwKmMlycP77M/bZ0TeBnQB0m3RAT+QKh7JkTqLN+3jOxiKHjCI?=
 =?iso-8859-1?Q?xNmrHhCviSlujer+mX8h81697LYVgMUV/e/cvqPF2vLQajIoasehy+uI9/?=
 =?iso-8859-1?Q?Cwe6dUUrN0lZpjD7bkYXYbdMHWZUQUhfKmVaZTUjKsrCo1Pw1iy8GlL7qy?=
 =?iso-8859-1?Q?GFDOQpYL3MfdMJiBXTlIt/aRm9+y/Ol9vtztabQf8eiJjNLnV1fPXbMcL4?=
 =?iso-8859-1?Q?hMZJB61eQa/un/o7h/gX2ZV3Zot1pSLQrf8RI6f+yMnfgw2MkmGjYYPCPO?=
 =?iso-8859-1?Q?xjWp/7fIYyZn14NT+qv83guei3EEiNAL6Q41x4YGG5AMwYLi4jRI09+IUR?=
 =?iso-8859-1?Q?qwBBAub0mqDuRVnKTthexuAvwVa+00XqGX9X5gZ4tQedF/830DPubA6uic?=
 =?iso-8859-1?Q?tSrMQtOwjAlHnzhx926ZvdvjHojOfNu5rWv8kq+rjJ5I3TYvc21Hp/HxYw?=
 =?iso-8859-1?Q?bHzx+yW3A/dZrupBf5VltwmPh/RJENDgXRrJYVzQD6ccfA5oOMGNNZOI6K?=
 =?iso-8859-1?Q?Mo6WreCZmT2feNTmeR2CJTJkRg/3SI8mJNijFNZboBjeyVFHFq2C5RMeaF?=
 =?iso-8859-1?Q?MPe45Yay7KUQCwF/RWwV+B14DB19IU6dhUienRLnuJMkpWAoctvEG1cx46?=
 =?iso-8859-1?Q?NjHvXXLl/L6L1fEJoXSPBuZUOOr01rFEzc6oujfx6wRIxsl9/vQy/Yp2Ut?=
 =?iso-8859-1?Q?Pi1tNtNZEx+NtktFiH7QzORFar6e5XcenZoR82dYpgdg9Rpsn2ZONZUlxj?=
 =?iso-8859-1?Q?iZTtLTsWOix7lwy6jRZDV+6BYSU4vPhS7eAM/RRBXKNAjYveTDSA1FnKpB?=
 =?iso-8859-1?Q?+gWADZuQWtxyQ78PnCiwNWTRGuZ1QbkYXlM4y3OUdse14iCQYXl/1SZ4ey?=
 =?iso-8859-1?Q?jC0TZwgkuAvwoBLS0tFBR7FgnqyQLMvzvOOhlW/bsIaFLDMntjOevh9nuY?=
 =?iso-8859-1?Q?7HF+kl+gY4EpaM+enymEo11HOH6miZVcSgIPMEbDD63I4KoYH7JqobmNJC?=
 =?iso-8859-1?Q?1g31XCQomcPxOyISvNvo1PX3cC6nCB/I1kU8e2UQRMS9fApkFVEfzQOva0?=
 =?iso-8859-1?Q?r7GTv8lD2Zc8YaH1ZC40Voj6d7PlKaQ4amNpEERvzL+FkWGljQ08TRMIQw?=
 =?iso-8859-1?Q?kSASNoLtXbq6FLUxV7C7rHvIxNBXm44ulndt+S43J21uCHecOboj6fcSGM?=
 =?iso-8859-1?Q?phpSMXjmgkTYBrkJpZrdiYIIU3YcCQ4kkQ3TU9b8Ue4RmkAsPxxBCWJeL0?=
 =?iso-8859-1?Q?5sO3eRa097iqIwUIqEosmfNLv81tNG3kE/g2uTPb5eNHuF4zvRElvmjJab?=
 =?iso-8859-1?Q?QRpwQT9dn+nnrfiZmYLI5xOyOMcd/sWjVmNwIaHWJoo9N39k6V5GszoUP7?=
 =?iso-8859-1?Q?hrTDq13cDKeHtE4rlefX/sSWp5asqZqDno/FFe6Mcsf/rGH6dtsvQ/raFV?=
 =?iso-8859-1?Q?72L0GH+rowvRsV4RTFswIbsJtjYIC3CoURTxVcVHzMk/wcsvskIt3rEPOb?=
 =?iso-8859-1?Q?4CDSNcJ7GGk32OgumCIGlSmX0Y/fytrdWdRpfrkb4uldwHW8NcvcUwEpIJ?=
 =?iso-8859-1?Q?sJa81bD80MEps=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4882.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fdacaf-5fdd-4464-7bf4-08dc32aa2c18
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 06:56:04.4924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGQzV52k0WYWvYAEIa+ZeZh64qmQxRt++6rswUf8eb/j6Y3c5/aFdVDBPSkIxg6U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
Received-SPF: softfail client-ip=2a01:111:f403:240a::601;
 envelope-from=tong.ho@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 8, 2024 at 3:36 AM, Peter Maydell <peter.maydell@linaro.org> wr=
ote:=0A=
=0A=
> This implementation will send the transmitted characters=0A=
> to the QEMU chardev and also loop them back into the UART=0A=
> when loopback is enabled. Similarly if we receive a character=0A=
> from the real input we will put it into the FIFO still, so=0A=
> the FIFO will get both looped-back and real input together.=0A=
=0A=
> I think we only have one other UART where loopback is implemented,=0A=
> and that is hw/char/serial.c. In that device we make loopback not=0A=
> send transmitted characters out when in loopback mode, because=0A=
> the 16550 datasheet explicitly says that's how its loopback=0A=
> mode works. The PL011 datasheet is unfortunately silent on=0A=
> this question. Do you have a real hardware PL011 that you=0A=
> can check to see whether when it is in loopback mode=0A=
> transmitted data is also sent to the output port as well=0A=
> as looped back? Similarly for input: we should check whether=0A=
> the UART continues to accept real input or if the real input=0A=
> is completely disconnected while in loopback mode.=0A=
=0A=
Hi Peter,=0A=
=0A=
Here is what I found using hardware I have access to.=0A=
=0A=
When loopback is enabled:=0A=
=0A=
1. Receive is disconnected from the real input and=0A=
    only accepts transmit from loopback.=0A=
=0A=
2. Transmitted characters is sent to both physical=0A=
    output and loopback to receive.=0A=
=0A=
#2 is also collaborated by commit message for=0A=
   https://github.com/torvalds/linux/commit/734745ca=0A=
=0A=
However, the same message also suggested that=0A=
#2 may not be the case in other implementations of pl011.=0A=
=0A=
I will work on v2 to address you other comments=0A=
as well, with a property for customizing whether=0A=
transmit will send to both in loopback mode.=0A=
=0A=
Regards,=0A=
Tong Ho=0A=

