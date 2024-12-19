Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C778CE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 20:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOMtn-0004V8-96; Thu, 19 Dec 2024 15:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jholdsworth@nvidia.com>)
 id 1tOMte-0004Ul-NF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 15:13:22 -0500
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com
 ([40.107.223.77] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jholdsworth@nvidia.com>)
 id 1tOMtc-00081o-Id
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 15:13:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSQfjd3O6rc9vSkNh3xtaO9v6X9v24BdrWwvY0c0BY27dAEq9j7AKiaE9Y2RM5D2ixzfO/kUFcDVD77he4OFshyNAO2dMOPRW6mCDJ/UsrN5t9pm3xz8ydddl2Q6ztbt5Gc1Y54jObBkTTwCXkc0RaubvKGm2RvdYATwtZeuOpzxel+D1IynD33j6pwsghNpHe26NigxFLjTRVB5u92P/eYsyiVKziWU78BKlcsayicXr7OiLqFochhtkPTenninczCbZzxiAAE3twSPfiH8A0ZTlw3kb57ilgNP+YZcF55eMuMjUKxTnxiyjcB8+Dyhr4lIY8CZOAFqPipBc6dXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyHEXUXyWczGdiimnV7+sgeGi6DpiI1KaUKJSm/VKM0=;
 b=C3U0Q1hSG/uFJilnqtJycdneuUFXPglB40gcTDhf9hhmtwNcn8maBNf+A5KZKhx1YBOVB9g9livCrlJxKJHODNqcDYS/P5kPO8awdlygtL/WqKKMTHpz1RUzQGrkDfSDw7gBF5HIhWt0/XYHuYtuQ5L+TzT8BGzkoXKxB0QjZ1CRipgKI1rv4H7xvZGJnk4xyaqzlszV0/WidntwLWzle/ILbDd32PAOGBlABDhmNvSQdzlgSsqdXXl++7KUReG1pbv++UD/JI+fwZRMaimdVTspZebZtYzQwzwdU2w00OSGVV0p2WlFxIaqeN2yRMZeU/Jv+Uj3Hcpm6R4znHlaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyHEXUXyWczGdiimnV7+sgeGi6DpiI1KaUKJSm/VKM0=;
 b=M5IdNwHDEkON9nAAKePdkDHPT60e/ZAbqdVPj/Y863oLq10n0vBLEd+pPcvHAwqKbe/Wh0Ya4Oiq9/pudx+kp1pehOKrAcs27TGUNvYPbG6abmEFWCRJ2Gs+Xlyc/aa8Nj0cfST8YHjsIr+hgli+daImEokQ4HVHxq5wuJf5Zl2yssKFDesnMsDMQ5Y01h/dBn2j0wev0eqdwanVqza55CLS4ZTyO+tLURMVILkWTYCvbk0LW2jJz9VYbYUe8QnUVYJdQDGwf67UoTcBbrMywQPn1P7K+A/LRAew4/eDMndbjgLaO3D+5Y4rebZ9/zMYfZmaScfumMuUsaRs1Zq32g==
Received: from DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) by
 MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 20:08:14 +0000
Received: from DM4PR12MB6565.namprd12.prod.outlook.com
 ([fe80::dea4:1281:3be9:2bab]) by DM4PR12MB6565.namprd12.prod.outlook.com
 ([fe80::dea4:1281:3be9:2bab%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 20:08:14 +0000
From: Joel Holdsworth <jholdsworth@nvidia.com>
To: Stafford Horne <shorne@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] hw/openrisc: Fixed undercounting of TTCR in
 continuous mode
Thread-Topic: [PATCH 2/2] hw/openrisc: Fixed undercounting of TTCR in
 continuous mode
Thread-Index: AQHbUk/BK6WJCRg7Ek+LImIh/NoRxA==
Date: Thu, 19 Dec 2024 20:08:14 +0000
Message-ID: <DM4PR12MB656535602DEDBA2D60321A54C8062@DM4PR12MB6565.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6565:EE_|MN2PR12MB4175:EE_
x-ms-office365-filtering-correlation-id: a8c8ccf9-4fea-4240-63ed-08dd2068dee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?6ZZVszyailO6xEEdWmRNCx8SVi4wREJRX6QqEI4PhDggcYfW+TQwamyAtp?=
 =?iso-8859-1?Q?n5v5ySMvRboSmK3NC2KpfMfBGGt+zAfBUkOF5c0itG0iDUL+TX9GzptsV6?=
 =?iso-8859-1?Q?yQ/LAsFQl8QmO+4NuOYOKr1ON61BWk2dVdAiWAkUoGOsIrZbgsopw1+3rX?=
 =?iso-8859-1?Q?RC5PkcN8mr5qJNr6mKnR74nTEeqT3kMguvtOswbv81HySmZF3P98zPfz0I?=
 =?iso-8859-1?Q?+re2MNMB1MiO/D6L73eOYnJehjRV5T2AKjRufVPRNUxmEy8rh52vNGxkGp?=
 =?iso-8859-1?Q?cqtDEFxapcGWzmvjwem/1ChYryHZ39imwR5yzEFYZZ4VoYnOwUMbeUbA+m?=
 =?iso-8859-1?Q?lBPyMhloq71MsBc7Ngw6rJNWQDoMbMusuFQSstURZ/q5rNIRB9rPz6X9zm?=
 =?iso-8859-1?Q?msTXuDfpf0t7sXNCs9/FMJhEOvmJ8iOIAQO+x19GMeBIzcGMVbJE/GZ8Py?=
 =?iso-8859-1?Q?bkkjXP28ITFqg8PlZ695Jbd3ObA+nmzXhhoAZjNzrQi1QFwqKjo/jXVtSx?=
 =?iso-8859-1?Q?sBLEcx963f4j/h1ihLWJZMpb08+hVy73oM7rhq33MDuvfS0v3+u161E1Bd?=
 =?iso-8859-1?Q?4TcCHNNQ7AHT2gtO8psJFRzIsiSqdNQ7f7dXfoODPqjCI2dWSowWpeQgnn?=
 =?iso-8859-1?Q?19+NHfaKRELyVS8jUpLSeSjiuWrW4ci485+euSAlRtR+p+yfDVyuIPYp/K?=
 =?iso-8859-1?Q?t5Y97uD6HWgPxWGM1RS5y7qztac9JW4vvWvL36AwV9DYv4wRaBxLeqSMfA?=
 =?iso-8859-1?Q?uxhVm2ZdNbw7v/1JKrs7Y8NscrfsEz+wC7s3VcUigSbKKfCZB0fkzvpvVF?=
 =?iso-8859-1?Q?ezd3SMUOVTtC1lxZ+n7DvF69mYgv1zfQUVDadif/5DVOeqtmiTeEKgSnmZ?=
 =?iso-8859-1?Q?WLYCizHkBW/NWvdBrgDiC5MnllN9WQM48ZNkSd+YsEqaBkeTAkPnk+aLrI?=
 =?iso-8859-1?Q?UHbR+QUkzjkBVpTIBXlCoYCpzkpYDDonXahVT3M3GJRPTUp0BRYTVngpyX?=
 =?iso-8859-1?Q?Q/gQ+W8ma1BekOKNz9Mdd3hTRzHXzZXfVLF0kgjH9T50DnhcRATuoeXZ33?=
 =?iso-8859-1?Q?tvzULC7IlSbs6i5mT4wo4038hDxZ8ZJPN9Dg30ivyR9YW+/yUm+/CPcNoq?=
 =?iso-8859-1?Q?Bps7FkGHgzztA+Pb3O3JMTegldsc3cFKKEGZ9HRuwmafVnXt/cFl0tnclp?=
 =?iso-8859-1?Q?7V5P+EF0p0ojozOYYNE/tgPPxXLtdop4/viD901clvKeqrA0191vMkERf7?=
 =?iso-8859-1?Q?sSFouogaoY08A5moEarmG2lvX6BFX20q7u8xqDnh001ze4mdfCXI/Jwt1a?=
 =?iso-8859-1?Q?aCzRaHzvEc0Z526guIqXZ7vZ29O/k/lXELAs6Dkl0lHb6QnOl85VjopJPT?=
 =?iso-8859-1?Q?Y3pVU5RwQsk0U03/S6DRqywf9uvayalpFgpxPq9fG0et+bJETX35KEjguH?=
 =?iso-8859-1?Q?YYkw2YlDPpEKLhvRANM+36A+/QnWvslvp214hoqBwTxqjjyqPS2wAT4ZZi?=
 =?iso-8859-1?Q?XGMzLg0hiTDHfAv97RO7Ri?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Pq1GvZLpROfrFfbSdmRFA3W65bbcygO5/JJKMnHHGCNKhA/QbYuODyTEU5?=
 =?iso-8859-1?Q?U3t79Acz6zwuHgjXWLEVdA38jAnTF+BlyPwL5IrbhbaYc8KtBhqME0HY6t?=
 =?iso-8859-1?Q?QS1ssRMnygfvsEBV1LebwVLw0SwqkKnq4Trp2JvgJvVTL2EhO3v0RtpydS?=
 =?iso-8859-1?Q?dvFlXZJ8L+7lgIUcjKsLJPbUiHzpGBh58WlesItFaus73SHtheFf3cj94n?=
 =?iso-8859-1?Q?AA+Ol4eE3Ur7D+d7yrYjzcMfRxTcDXC7QmbfmDREDDmrvquKqHI+rDLW8S?=
 =?iso-8859-1?Q?WPOubPimd12PgHmufggEGzIUMSS2QvjRy7htdhKqJoncPfFU/+LOAOJx6l?=
 =?iso-8859-1?Q?JORCWa8cG4I4YSXPQqhXQ+yqNtuQeSt5doVQgPoQt3TaPnRgeWWL7BekWQ?=
 =?iso-8859-1?Q?SsxMw3sPqHbD0npVU3HgntVkI7pw+1PQI92RsGcDGeMkVbZxtc/ghpiUI2?=
 =?iso-8859-1?Q?qCry2GhsBkMfI3rkOtb9F53svIY1oGTlhK9wPQWUgcLlNYGT4d8JfdEPYY?=
 =?iso-8859-1?Q?h78BAhSVaVM1nII+BbeLwZDUwX9gHreRhr8jihwJIXz6SgN3DLKXqparuw?=
 =?iso-8859-1?Q?FVGr6lNXlMFMNsMOnul2s+UwMJC7/HPb1Rwfg9ADQpNTiP+oGcRm3HngOa?=
 =?iso-8859-1?Q?ViJ5SWsNP4KkOpSYr9TuL1SrIxFpAhnghXFLfHz1wk0laGY+zsWv6h5xy/?=
 =?iso-8859-1?Q?EUjFskBZlh07Sr1XfG03RvupeWXVqvxQUHF4Z2rGocX4INnrWTKdZJBLzC?=
 =?iso-8859-1?Q?RPhw7xZ4lrQmncrvsn/IgaZfr/+UfXmfLUJQ6LB+uxtg7RunWG3QHevBNJ?=
 =?iso-8859-1?Q?MIK0/jaF8e3O3LiTjGYhKTQQ8y0gRtHlAdsyhXYfqNnhESBVUDXPuCrCdF?=
 =?iso-8859-1?Q?r5kvzB6ZmeXHFz91iGU0IMq6J58GVvCnY1/UXWNb5JO6MpjQcttBRyliiE?=
 =?iso-8859-1?Q?xJeEFmMQAHSIeRsGVFhkqaIfimtNUPtUU6mZLHDzq9pa8YnRpNZKUMlEP4?=
 =?iso-8859-1?Q?vovy4JnyNgDwmZjO9W05b0Nbh3GF7DrXZgBQNE6aZ1kx9e8KWRxzfT4b1C?=
 =?iso-8859-1?Q?L9PP1evenE+/SkDZavTFUZD/f70JlPrHBVBOVNFjRXF6Kb+AhX1HkYDn7I?=
 =?iso-8859-1?Q?RhmKPVPGGCstw2BbH1TjDb4mvN7rLHEILgJcXPiytbbS+vw130tCzc8JG9?=
 =?iso-8859-1?Q?ZH/uSg2MctvIu8BwJ6MtrRaXLk7PVT8AxRxyEYajGHTwlJUgzWoCzHw3E3?=
 =?iso-8859-1?Q?fOrk0DgbmuBrCxZNFJ4QJ6SeR/sgdFexd8JTJa3Upz/RdyDf/L4nY0zI56?=
 =?iso-8859-1?Q?pX6qXGSHQKATpFybF/g5cbvAMYLibS1UNfYfSB4DvW4WA8OTFwRpeK+68d?=
 =?iso-8859-1?Q?Finu3obCqXn4Tw9hxJM8klmOuIac0U+2Y+qLUZDl9LJV0sABfiOONM9IRy?=
 =?iso-8859-1?Q?mQYjOgQ0RtGPM6yBpROjcq6BYlDvG6XroaGufqiNGiSQaJS1uBfcFMNBTI?=
 =?iso-8859-1?Q?DA17NzxYd0uDCDvyXpVDXVCoPysL6wkrDxi5BaXkPtZBC9jLUG7CX0J0k9?=
 =?iso-8859-1?Q?oWpw1BMINz4LTWL4Hf2ONi8gVoB0cWuLd/8k47rmGMsmWZHie7X1ZkbqLl?=
 =?iso-8859-1?Q?FpXSUdL2F2EKHeTWiCmpjF70AvkYpMv5S1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c8ccf9-4fea-4240-63ed-08dd2068dee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 20:08:14.4529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nd8h7GrHbrhMUr6eLGqEUamB2uQKiSEff6JBQ1MNcP4++F1naZ0I+4HxfHpPGlaP3dPuOfW9d7LzqNBocUo+XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
Received-SPF: softfail client-ip=40.107.223.77;
 envelope-from=jholdsworth@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> > > > +        /* Zero the count by applying a negative offset to the cou=
nter */=0A=
> > > > +        or1k_timer->ttcr_offset +=3D UINT32_MAX - (cpu->env.ttmr &=
 TTMR_TP);=0A=
> > >=0A=
> > > Since UINT32_MAX is -1 in this context, this appears to be off-by-one=
.=0A=
> > > I think -(ttmr & mask) alone is correct.=0A=
> > =0A=
> > Thanks, I did send a mail to Joel asking about this bit.  He didn't res=
pond for 2=0A=
> > weeks to I just sent the patch as is as it appears to work.  As I under=
stand,=0A=
> > yes UINT32_MAX is just -1.  But why the -1?  I guess it's because after=
=0A=
> > ttcr_offset is updated we call cpu_openrisc_timer_update() which calls=
=0A=
> > cpu_openrisc_count_update() to update ttcr.  Since a few _ns would have=
 passed=0A=
> > and we are rounding up it will update ttcr to 0.=0A=
> >=0A=
> > But maybe I am reading too much into it.=0A=
>=0A=
> I think you're reading too much into it -- I just think it's a bug which =
isn't particularly noticeable because the clock is only off by 1ns.=0A=
=0A=
Richard is correct. It should be:=0A=
=0A=
or1k_timer->ttcr_offset +=3D -(cpu->env.ttmr & TTMR_TP);=0A=
=0A=
Stafford: sorry for not being responsive. I've been very busy lately, and i=
t's been several months since I touched anything OpenRISC-related. Are you =
able to push this the rest of the way through the acceptance process? I had=
 understood that you were looking for a more elaborate overhaul of the Open=
RISC timer design which I haven't had time to work on. But if the patch can=
 go forward in its current form, I think the improvement is worth having ev=
en it doesn't address other design issues.=0A=
=0A=
Joel=

