Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110ECC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 20:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVHcF-0006rf-Vo; Wed, 31 Jan 2024 15:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.charney@os.amperecomputing.com>)
 id 1rVHSE-0003a2-Lc; Wed, 31 Jan 2024 15:45:06 -0500
Received: from mail-bn8nam12on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2418::700]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.charney@os.amperecomputing.com>)
 id 1rVHSC-00035q-Mw; Wed, 31 Jan 2024 15:45:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfKQZKMfBDs1pa8i9lPMAzyPqAAy3b+r9zDwMvAAc4DZ7w/WsBRV+VR5UlEWWJCoHd6TPjKVcRxCwGOaysgvanor7SdhUPpxpBImOBG38rlJ/rl244/4ZkL7vfzcq36E4UCBkSHBTw9dsU1Wx/gG0PrGERODxDqONH+rq6G7qJeCEKk+MmYd6p6jZpzSXvXyM+v1e6C9xJYQRcY99eGApVUynC227My5xeqejH1tZdfFbBLeTiS/Jb12PFA+SqvNJf/UgrEl2Bk9ahimX4wy2mFOAGlQ21ftroRzOh0JX2CT33vYS1l1/mrkwWfTsI3gn3q5y2E9ezR26hBMdjyFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XNZZWN1GY1PJmnRTS4Yyv5+Drjpiu7QMIq1mVygUUk=;
 b=J2hS57TWo2JYuIp95P+TRSgoeexN/0VqWdsGaIGDeqoV3xqzLhE3t7JWaiiBt9BtkmQA9kmCW76FE2MQJgiCrGTm7wGqY3tHPP39Oj0omg2Rrw0mPHXrhiwObCQliawxiEfLwWKn+/AjFXUnrQ7DqSdVwys9DkEyNIck2xWFCyE8Zi9MI/D+jDlY3rmTUTHAzPICMjZnchHs5UYQd13srFgaAPfmO872WhbobMo8QsmGOv0IfRCDvAYRzCbIhJ4zXZWum25/YZJSkCrPF8zyxuW2vCkt+I4mTq8bZwHpnxaagZTKxotuvwYM1aN+OY445EafUnHIb+qmvRq/HrNfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XNZZWN1GY1PJmnRTS4Yyv5+Drjpiu7QMIq1mVygUUk=;
 b=kXs+oPEgVI6BrqB8X75bIqeu8zH1xRRY7On6IVxEcmgpCs4fRr0BA3ubxm0DeUThS92ivf5InRD3OEMpYc8a3CJt2I0fJZlG9qi66Qu5IEmvSTG/IAHAVbHGg3nfzY/gXAeH/fEa+1+58qLXX+xMHGEbD3g8O9pTgGxZUUTHapI=
Received: from BL1PR01MB7795.prod.exchangelabs.com (2603:10b6:208:39a::5) by
 PH7PR01MB7931.prod.exchangelabs.com (2603:10b6:510:275::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.24; Wed, 31 Jan 2024 20:44:56 +0000
Received: from BL1PR01MB7795.prod.exchangelabs.com
 ([fe80::93f7:ce4f:5253:1269]) by BL1PR01MB7795.prod.exchangelabs.com
 ([fe80::93f7:ce4f:5253:1269%7]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 20:44:55 +0000
From: Mark Charney OS <mark.charney@os.amperecomputing.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Aaron Lindsay OS <aaron@os.amperecomputing.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>
Subject: QEMU 8.2.0 aarch64 sve ldff1b returning 1 byte when 16 are expected
Thread-Topic: QEMU 8.2.0 aarch64 sve ldff1b returning 1 byte when 16 are
 expected
Thread-Index: AQHaVGIniO3WZ/GXMk6DS8JgnshVfA==
Date: Wed, 31 Jan 2024 20:44:55 +0000
Message-ID: <BL1PR01MB7795E154CD5AE6ADA60C0D53A87C2@BL1PR01MB7795.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Enabled=True;
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SiteId=3bc2b170-fd94-476d-b0ce-4229bdc904a7;
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SetDate=2024-01-31T20:44:55.082Z;
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Name=Confidential;
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_ContentBits=0;
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR01MB7795:EE_|PH7PR01MB7931:EE_
x-ms-office365-filtering-correlation-id: 6bdd755f-73dc-4645-6182-08dc229d7b42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zB3leId2fto/2k0WKnR8GeBglT/7dRsjQvrTQqWwd8KxUMzYZmp/KjRgjeXZaRinGp6cPife2uDi0XkVUuioGltBtBeqnKVnkkUw8/FUtD0OBTIYdyWI98u9+K4TxtigcxOoOH3/YKkrXj+j7O41Iw6JZ9IBKOXUoCvEcyzAyQB0H4vkq/48OY7D3pQvnuqRBTgM+f/zrGSvn1SgZuwzvl5ZLegoNRlQR4eD/xuN3DDB2rl9HvQKqI/Yman57ftcjrqcfN6xKMBbsgB6ism/XozMeHoCVHPhaNWuHy1BW7DPK4NEhQYqNSl4pZhTgXEwnrmqENuQsIncKxqQTboShkPtpKroBjurXDRdaqw/bIES+smgSum1dFbOY4Ova4LSqYoDDOEDdFVM24G2PV7XzY2DjS/NeCsWkyUEoOEx5n54ruu0lyBGGnJH3sgjr6c4dVeHve3HYebs0mlPIOq9LSNqYp8V0w5qxnNVvTvFSWGyTMP7GaygIZb0RxJRixj7zDpLvw/5DoSdUGPRK2OjYmIOV4X0Y43kTaUD90P+CIHHlejAAmpLdtINfm61x0WvKAGM4RSLbF69P0q2h/EhyXm8sGFQx4G4BuhW4ydM5ezGSUfgwRM7cXt4AZselA7Ro3j+rK5icvS9JgelnkqEwWi5yUN+lz2oCC/WEDu1+m8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR01MB7795.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39850400004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(55016003)(41300700001)(54906003)(38070700009)(64756008)(66446008)(316002)(66556008)(66476007)(6506007)(478600001)(9686003)(38100700002)(71200400001)(7696005)(122000001)(66946007)(8936002)(5660300002)(2906002)(76116006)(91956017)(86362001)(110136005)(8676002)(33656002)(4326008)(52536014)(32563001)(357404004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QrX2HxqV6q6p8i8EUjOif9DuB2YMNBKCIdOFvVvS4fx9WbQv9CQN4JyEvP?=
 =?iso-8859-1?Q?vxrTn68rbFUpie0k3q23JaQiSv/wT4HhalIDPQD1fifuujh4njIOAmb/PN?=
 =?iso-8859-1?Q?0dHjtF80q6UgBXsfXZ2pyXxjxLp2RJZ+OL2RpE1vG0gQRGPPYYVSgQ7goD?=
 =?iso-8859-1?Q?mb/KKohbpWKRuSpuAsVdfVmFWNDxjEitmtZN0M/axB3qDBx2RmYDQyrWpW?=
 =?iso-8859-1?Q?18nD1oMC6tT/qsXB/DBhxpB/BbWRlvCyCM72cM0X+jDsSdUhZc+SkLUaBS?=
 =?iso-8859-1?Q?2QIFBsv/UuXky0cKXPcezD0p5GSzwXoX1dgWObSQbhFiGVMUe7cO7H/HB2?=
 =?iso-8859-1?Q?UImvqpBg57mOkupLJPZ/Z5VD1SKF9/vjkIAcbV8SjfYdW9jrThzMmaN99U?=
 =?iso-8859-1?Q?t6T8ZGn9yhqISSq0ACD2IglWDTf61X9i7uKaMi8naC7PzZW6n5hf9Qjgvn?=
 =?iso-8859-1?Q?hzsw/fqwkhhXTO5LxCLARNsKGgbNdCJjZSsHZmodMAaXFCDT9HZGc0iQ8j?=
 =?iso-8859-1?Q?Voyinal0GJor5tt+/HUTf9ZlCLYpyf8aSxRGx8UhrjQFtaChF6Xsb3aBXh?=
 =?iso-8859-1?Q?pK/BaYSpnxUjVlMOHdl+pwnqmTup3Bm/ZuZt7X8ELyLPfx2KaOr4N78NJI?=
 =?iso-8859-1?Q?0DbUeio2COPp6VNOzKWZvkoggRtWpkWM4wt/Un6bd7TPHHEcdP5QRq5y3R?=
 =?iso-8859-1?Q?o6uActNhLnhksaReqetAcvIckLiAr5pwc+1ysykTbqmTgTgI7WfX4BFaDj?=
 =?iso-8859-1?Q?1Tf1CYRvjG+vknKd0wfnFKJUpNJf0uLydipZlbTjS5/z/raJ5OLrc+SG4d?=
 =?iso-8859-1?Q?wyldTtSF2z4Odre7H1kM1EyxL+7dauWRTRYsainuU036ebOiz1DUcrE7fl?=
 =?iso-8859-1?Q?g+/ZGGzUcmR9+xawrnU8NYl4hvl6DbqY0gxxjIgT+WTujpYbJWFdRI+rIY?=
 =?iso-8859-1?Q?hPyFEbUi3dqTwCXcaW5fcTwKQYzV+UKN5UTDi9NIPffDyayyN9XnI/gw++?=
 =?iso-8859-1?Q?DM3MCLaoY4nAVMGKd8dpKdiy/oaOUbk4QNCfOdkf5T0oxPGUWMZaeBcfRQ?=
 =?iso-8859-1?Q?UkjhY2SnwNk1oYawsKWzUvrZTzha1VLi6plu+frL1OZhC+6O+d8ageQus8?=
 =?iso-8859-1?Q?BWllqlJ3BFjANcYc98zMVzENMsXmXGUzWZTUVirbFUpqHWdTBy2r3Pxvk/?=
 =?iso-8859-1?Q?TxP6JEHOSK/z5my4q1Bg2P5bZDSguYz2VhdVTBjhkO9pQW4i5uVfH5svnv?=
 =?iso-8859-1?Q?NM50CHzf1GtxnPh5SIKFdtgQUGGOFhxzLFMZQ4iuyHGC0jVb4LGSmg4ohV?=
 =?iso-8859-1?Q?nmeyAn647akAeEIRgY5tubOV2gUXHl/0ONul0c4bJYwxDN3hJmAXRMP2jk?=
 =?iso-8859-1?Q?dQD8Sz0KGVl74MCEORbNuItl4S9OuoWVDJRGXEY0xaw70rF/T/PcOW2qZf?=
 =?iso-8859-1?Q?6Dwyqp+tZ2Q1Oevlwrt9zalXMCbTznBsir2dVdBBNRHEhcsRNO5YXCD4hq?=
 =?iso-8859-1?Q?265/9qP3o1EE/cyjI35M4k6wo+ZBaByx4UHzZV4XokDUz2I7N5SMPIHuEH?=
 =?iso-8859-1?Q?NVW++HuuBEHu+FkKxyuQ6A6HHazSVcxKH6mGQyQ3PXjVbIB2LzeDiP57tq?=
 =?iso-8859-1?Q?QAE+4th8KB4tfBJ7dcGzaVgSs8aC2+SYodLkT3DRMqC37tOMoDb3foVVZA?=
 =?iso-8859-1?Q?k4X8UcYdS4JvwVOzKIo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR01MB7795.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdd755f-73dc-4645-6182-08dc229d7b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 20:44:55.2864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oY/KfUP2FgR7eV4EsNPSCErqi+olMvoa9RAn98/20JSUsBADMiajD0mMWOq+wRsXJMNAnSWZfYfJXxSt6xJnyePDbIMraRF+bvekOByaXo8UbpqUKGs3XUCSd5HSbF8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7931
Received-SPF: pass client-ip=2a01:111:f403:2418::700;
 envelope-from=mark.charney@os.amperecomputing.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 31 Jan 2024 15:55:21 -0500
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

Using QEMU v8.2.0 (and also the HEAD of the git master branch), I=0A=
encountered an unexpected situation: an ldff1b is returning 1 byte=0A=
when I run with the QEMU user level plugin (and setting FFR as if=0A=
there was a fault).=0A=
=0A=
However the ldff1b actually loads 16 bytes when: (a) I run this same=0A=
test natively on a system with SVE support (no QEMU involved) or (b)=0A=
when I run this test interactively (logged in to a console) in GDB=0A=
running on the QEMU (with no plugin involved).=0A=
=0A=
I was wondering if this one-byte-per-ldff1b was a known/expected=0A=
behavior with plugins?  I guess it is legal to only return one byte,=0A=
but I was wondering why QEMU did this and if there was some way to get=0A=
QEMU to return 16 bytes in the absence of faults (or as many bytes as=0A=
it can up until the fault).=0A=
=0A=
There is *no* page boundary being crossed in the examples of interest,=0A=
and no MMIO, so a partial data return is not expected. The page=0A=
referenced is mapped and previously referenced.=0A=
=0A=
Talking to Alex Bennee, he pointed out:=0A=
=0A=
> I'm wondering if this is a result of the fix in 6d03226b422=0A=
> (plugins: force slow path when plugins instrument memory ops). This=0A=
> will always force the slow path which is where we instrument the=0A=
> operation.=0A=
=0A=
I attempted to revert this commit locally and no longer got memop=0A=
callbacks for any SVE load operations, first fault, nonfault or not=0A=
"normal" predicated SVE operations. But I believe ldff1b are returning=0A=
16 bytes (judging by the control flow).=0A=
=0A=
Our goal is to use QEMU for tracing with a home-grown plugin.  For our=0A=
purposes, we were expecting to observe control flow like what we see=0A=
on SVE-enabled hardware where ldff1b returns 16 bytes in the absence=0A=
of faults.=0A=
=0A=
If necessary, I can provide a reproducer, that includes:=0A=
  - a sve strcpy loop from one of Alex's talks.=0A=
  - a simple user level plugin=0A=
=0A=
=0A=

