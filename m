Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F31C54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfg1f-0000vx-H2; Thu, 29 Feb 2024 08:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfg1b-0000uY-LQ; Thu, 29 Feb 2024 08:00:35 -0500
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfg1Z-0007za-Jt; Thu, 29 Feb 2024 08:00:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZ4NiAzZ7Wg2revZ3ihYO5M7ZssffWtXmA3tZ3f3pNlD7TsCU+XaTkhV14PykMk98mKXSese/koZmd8QNvOiB2dKOyFpyisPZQ7t2efdbltRgmxrBNohcXYSdwe8XVxiuPWUzGTDRCf5NGIOgp9MqRIftkPmgYzDd+izmn2s0jGyBd6+y+Do5mCIdu5mikIPNPMvWEHZRNNCQ0b+MYQaPYafCIsYD8euqqt4prbER/LjZ12coINliGmdrOhfGeYvuhaltMriDuvC1yQF7yMgIx1rMnkjFzY/ksrlq0k4MoR80DqVTPqFDKCFfBFi6auOMr7sK8bN7LxmnTgl1oHKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rieHtQfVbEX5HoYvHWayXRVnirS7OSuur2kb3mlYyys=;
 b=EcLryChizSap8M9iObx2LMg93BcV9MR8hj+ISA92dqKyrulHKRlhfRmLrTe78Ud2DGU+9l5i0gd6yyhMwD0Ndc0/rYH/a/DwaywA3wX8gJmB/+tD3jsoudEPe7TZL+omzkBRQRDH6h8fNfd2lDaM7EigfE1MHCuQjT76o3JKOa8topzHxp6Zxp4JMUxh6iMIhFggOj/2QxPEbqOZ4KUb98eqSyWa1lniw/uptYuW24tCth1MCUhrbZrwXaVycstse3Ka69Mlf0v9quvf8hqJwNJ6eSv2NumnkoodAJ0jHM8N80gX5pJiBdn9z1/p5MWNzVxtkzA52CmnXshQ4MsyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rieHtQfVbEX5HoYvHWayXRVnirS7OSuur2kb3mlYyys=;
 b=YLBkW1MKLtABZQeW1IF3wv43vurvvOBvDeBmRWBb8h6x7OjOYMjxixJPAfAGRMCoHeBaz5fGxkDz9q5rE9IRax2m2CvaNZ6dVIL4XvZ5IZ/wvfflKWbbWfLvjXv0MtJyHdZyD+4JpvIw2g0A8OJDAQudnKrjsjQj5LJhGHdBmsH7TT6w6KDoMblsOG/xXGPw5ANF1LqCbVFYep/zPxx8yHbz0PVLwohf1KR73swzB/NhMqCLMEgyJ8b6frbn9OkM44tajNpvGBJ2OMNbEjhPwYWbQf7E9txaGqMJ57d/TSOUSoURbFeHjtWFkUkIUwZ5mn9ta3i4kirMFQaFhBUxag==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Thu, 29 Feb
 2024 13:00:27 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 13:00:27 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, Zhi Wang <zhiw@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket
 Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 1/2] qom: new object to associate device to numa node
Thread-Topic: [PATCH v7 1/2] qom: new object to associate device to numa node
Thread-Index: AQHaZlXRpHP8fv3NL0CqBnE3t10aOLEfZKrYgABqHwCAACU5hYAAC4X6gAEmMwCAACTghA==
Date: Thu, 29 Feb 2024 13:00:27 +0000
Message-ID: <SA1PR12MB71993D9D99F4756C17CAE9DBB05F2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-2-ankita@nvidia.com>	<8734td3uty.fsf@pond.sub.org>
 <20240228135504.00005d12@Huawei.com>	<87bk80vaft.fsf@pond.sub.org>
 <SA1PR12MB7199F868F1C300B1E795CD39B0582@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240229102230.00004277@Huawei.com>
In-Reply-To: <20240229102230.00004277@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|CY8PR12MB7515:EE_
x-ms-office365-filtering-correlation-id: 51fc21d8-bdac-4722-b4ab-08dc392666d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sXAr1oIKPxuqfpUafOHq2lrzE7CmnRLp+zy3M5J4LN2l3YkPtDioV/M6Gq0P5Em0yqu9KR1KArtOLl3LdqPtl8OrWOUuIoEnHseombDIRoyqxroRgeVW0VW3fJDTaUmqn9dF+oYDhA7mQ54N1xLE+6XpyompFG3kwK8t1vfmNwAMLVpEnMquhJZ6vPwicz3LZDJbTKNr4BZl4PWrAY4jrpMAYWT76RYgkbP018uMefbb8EpjOx2t8FhKFA8zNE/FDa+Q27+mufuL7M9Zeq0WoAaTvqDLV6+NOxsCGAODlgI4E7pU3i6wWPXzHzFz+UftYAWwP5T2R/gRt4hhvvLFK0ThWqKm1YTXGYkf/OakfY8RzPnrq3bFyvg+t2KcTV8hD12uwlP6kA0xIXG7zq7Fbde8TtWnUCcZ36ApIeCfuPdMlGm2vmTH3W93RW+a6DeuVeMFly2wkU6qKAXI9neDO2kZ+Hof02Zf2JQJ29EI+iSZHRSfI/EgW1O4BOk1dVgLQyr474gzHgcE5PxKPGUeHE46IBapfH7efff9paTP9sFmf7DQ3vi/hnz81rHcc4ooC8MHtD2p0nEV3JF8MLkg1A3Rx/nuLJwwI/QOlp5UFedd415wUPoHgeGfEdLX4xthvYzDZGaFSvkNPK2Nb24kC9mp9KfcBc/YtHaGPc3diRhL1olTDlIa2udxcCXHEYvkLFDc9bUzCgIo/PRO0ddCwHx8Khwq0DICDysEZKwWcA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?scCblnm0WhxqoLUPSYR/OB3aTU2cXuh+UeOgMtd5kl4Uz9AHdrrZEzEIKw?=
 =?iso-8859-1?Q?FVNWCEAJ0XptTNIjJw4D619OtgUwZ0oISxsJj2g1rY+5R9ABuZ5G2JhlMd?=
 =?iso-8859-1?Q?iCuJlkIqGuG95DIZwFNodKpbYl44AQ9SQdcRR8o4Y2BK9UUqs6ti2iXza5?=
 =?iso-8859-1?Q?mEaj0ANToDedgn1p5FtNSkvWVE8ZKiPvezN6cu1SUu2l2J5UQNNihUJGUp?=
 =?iso-8859-1?Q?/4VDwiayjjDSSuLKQvlPECL1cxhkgRr6rwfMRpJRoWJM23lFzysMslFh/l?=
 =?iso-8859-1?Q?TIy2t1oyH/F6hSc+OKxM7lBUjyReoBSQhLPdyN0iw5NcK0K666dFa73n25?=
 =?iso-8859-1?Q?bUDbZNFs7k+HPV6nqBd9clbKMBq9iNZtqU29oqMSM0sorP5wdCSNDNNj7W?=
 =?iso-8859-1?Q?GBnClV8Xt4UPpd+UTgTVKzsnJ2svOa7uHQ7WtuP41E2xhaEdzEVVc7o8Th?=
 =?iso-8859-1?Q?0iDhnU5YXW1TlkVMlJPICVPZvgvIVdhZ0D4U6Jky47n4zMmZpRYMGGXZdC?=
 =?iso-8859-1?Q?FEeyB+opXpvN0hsGzaERe9l8TV72+ZkgfXxXzHeuWT0mThYcDzIs4VCsBw?=
 =?iso-8859-1?Q?GHNij+S8SbwDQnPGyG86wJb18/hNcYyN+4Fvyg5jMjGhEn2JvdfMGU0sCC?=
 =?iso-8859-1?Q?pkv/D+yhus3DY6lpvZ+9Qf5rYiZlTjO2hJnTXf5d5nBl4QQ9/j12ruAlj3?=
 =?iso-8859-1?Q?J7tFDwkq5WKrMKPJeIE2NC4wViC75G/quhhjvfIy/QTkYe5v6xZ/9pF/Tx?=
 =?iso-8859-1?Q?bHsc6CdBsa/cqiA4XKCtrWqivB9Z6FhpAshvPRTPZB+uIWGyV+pIjnvXb8?=
 =?iso-8859-1?Q?7a6RsPrmyMR6td34wrPzdSU6aY0yka1dYduvxCEPSlJzsEOq2EgzVfrJBG?=
 =?iso-8859-1?Q?8+uK/Jp8N2yEuDlWtuk9iZSTWAtj9/erRQkFb+2gh9EqUQPhs5/U+56myc?=
 =?iso-8859-1?Q?mcF8kdYoQ1MhGOVVhG8cbkxcnYO53sS5BOTTDhQepm5sPBZSxAZDBKzUve?=
 =?iso-8859-1?Q?THJ0LinsHgNQ/4f5GH1t9Gv5BVXQGVQC31fOa2JaMql4Fxi4TBt7X+oRi1?=
 =?iso-8859-1?Q?1McaLKefbUsRmWaA6d29x3ZAu+nTl5Re9kShR8P48kxJyWyVNrD1n/4Wxg?=
 =?iso-8859-1?Q?jpM3zXcrRzr5k0eKXeqUAD/htCh8N9cUptCBiUihZJlbe8FDOzuyzpC7gz?=
 =?iso-8859-1?Q?D1SsL7iUpOmBynhpNzoR0ATIHEmoLIVRougroiq5JhhpPEDj9qDhA+mdEe?=
 =?iso-8859-1?Q?n4PGVKsnBvR8nIaDXCbJhNBtgf1LOJepfbZX7Sw8fSf/x+Vm6iJfYW8JiH?=
 =?iso-8859-1?Q?8GOpcClO9sFiKkMOa2wrTOJgY4sYF+T3SiCyZf9lsr1bVA+OCKAJqQBqQG?=
 =?iso-8859-1?Q?ZBrPTpzORN2daumdT8ksuHbbLUwDxUN6BLu4d1+YAoDb+iV0o/QHVLbeTF?=
 =?iso-8859-1?Q?x4WSoRPoao2KabrQJoD5XWH5W4mpXOG7QEMKwF+3VO2wdP5U6+h3GzmA60?=
 =?iso-8859-1?Q?OdUdl/QOKKox5x0rBo+zHNre26U2Heo7IIaAY3ylxK5LEnq06WGPdQhFdB?=
 =?iso-8859-1?Q?p3MescGn9SR02QlfVOs1ty5Zfl9QSWaLDn7zG5paHoPMjI409F/1XrRc6k?=
 =?iso-8859-1?Q?pat+lQgYSsjPM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fc21d8-bdac-4722-b4ab-08dc392666d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 13:00:27.6177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDu2ktjMU7zyQVCFspb/iYnmrOj6LewZAzdQ/J5d2Q+LeD1rS6isMaphcSsu+2gdNPqlvWXpJZy1lvDt8Rbn0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=ankita@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

>> >>> Jonathan, you pointed out interface design issues in your review of =
v2.>=0A=
>> >> Are you fully satisfied with the interface in v3?=0A=
>> >>=0A=
>> >> Yes. I'm fine with the interface in this version (though it's v7, so =
I'm lost=0A=
>> >> on v2 vs v3!)=0A=
>> >=0A=
>> > Looks like I can't count to 7!=0A=
>> >=0A=
>> > With NUMA capitalized in the doc comment, QAPI schema=0A=
>> > Acked-by: Markus Armbruster <armbru@redhat.com>=0A=
>> >=0A=
>> > Thanks!=0A=
>>=0A=
>> Thanks! Will fix that in the next version.=0A=
>=0A=
> The following is really me arguing with myself, so can probably be=0A=
> ignored, but maybe it will spark an idea from someone else!=0A=
>=0A=
> One trivial tweak that might make our life easier if anyone adds=0A=
> support in the future for the other device handle type might be to go=0A=
> with simply dev rather than pci-dev.=0A=
>=0A=
> There is a sticky corner though if a device is a PCI device=0A=
> and in ACPI DSDT so maybe we are better off adding acpi-dev=0A=
> to take either pci-dev or acpi-dev?=0A=
=0A=
That use case does complicate the situation. Do you of any such=0A=
use case for generic initiator?=0A=
=0A=
As for your suggestion of using acpi-dev as the arg to take both=0A=
pci-dev and acpi-dev.. Would that mean sending a pure pci device=0A=
(not the corner case you mentioned) through the acpi-dev argument=0A=
as well? Not sure if that would appropriate.=0A=
=0A=
> Annoyingly for generic ports, (I'm reusing this infrastructure here)=0A=
> the kernel code currently only deals with the ACPI form (for CXL host=0A=
> bridges).=A0 Given I point that at the bus of a PXB_CXL it is both=0A=
> a PCI device, and the only handle we have for getting to the=0A=
> Root Bridge ACPI handle.=0A=
=0A=
So IIUC, you need to pass a PCI device to the generic port object, but use=
=0A=
that to reach the ACPI handle and build the Generic port affinity structure=
=0A=
for an ACPI device?=0A=
=0A=
> So I think I've argued myself around to thinking we need to extend=0A=
> the interface with another optional parameter if we ever do support=0A=
> the ACPI handle for generic initiators :(=0A=
>=0A=
> Jonathan=

