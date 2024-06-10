Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE9AC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 19:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGkmj-0000Et-JO; Mon, 10 Jun 2024 15:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jholdsworth@nvidia.com>)
 id 1sGkmi-0000Do-Ai
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 15:34:28 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com
 ([40.107.92.82] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jholdsworth@nvidia.com>)
 id 1sGkmf-0003yb-J0
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 15:34:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdIlZ+amu2MgZclvPERCykX2fIZ0EEXzOupAnJyj0XlcEbGyVWLWf7hVd/fQyrj48zdGsfkZuzztxDh8kSAS8TM1hRpgO0yGv2uY4/m80dUjZkmaZO74CJncBzzMRr+UCdbiF9QpmNy+DaFmaa/sajm+DergTNiVZDox7VG4CY9GR3d+6RG0XWrn4YbNgm3eH2o8VUdXw1QS0GYIVImasi4wCNHQ2B2Z92FOvR4dM6Onae6iLdbe61h1pgAUQkHFlXbpJ4pWQVHGKE5/3efP13ao6GPpQjpfy57Z5qOtmrvg4IHVVRhsVurniy9BF2hZUnFVafrfsdOADq9zL3x2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtGVQzOM2PUuoylsOwMBfGYHvMJZZUBwZHvGtrwl+yY=;
 b=HgAYUQWL3FdYMZ1iRCXGS/Avqa+SuZ0xgj1n1jYgQb1bvdI7bD1pITA97PG2F5JBbUVJNpOFtzxFr2xFrMi+8yB8UpvSRzreTYVnELS8mGWNSNLga5NUlDl9+AUoP5btfviUYDOCSWpKo0uk5LE+aj1Ptf+HotE/PbmM9u5nCm7r6AigmQEVVDgmJbmrWR4f1UlplDhoR2PNZPfw/zPiGizgDeiGYIeLNgUuDjQM3nFPdfaRLxrlGVk1f+v3VmDZZ0EfAts9+s4XchXp7Lbm4wr6IslbwoJRkk+mpyOWaixY3ke9h8/gR3XgOxIb1oB+9se+J5FMeaO/KVo++zxr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtGVQzOM2PUuoylsOwMBfGYHvMJZZUBwZHvGtrwl+yY=;
 b=P9HI6R1Xxg2BfmX1XCAoHz3/bqvoOdEo4YPNb3B8kKgFW9LwxwZI1CzhY5iXnOMF7258k97KFx90TIGftCGIG5Bl4tRwOM3WYBTsWGpbgyikjl8ePPrZqN4bcQeSwppiIe8fx5YJoHtXSw8giivZ9fz62uIp0jfJSc1a3pp21WN1UXlC4x/nDtZc8nTp07MUZibFKIN+1DMwHiJP+k0DqCn0dbAPHNl+sUmvEABlTrPPPdzpmXpZumogDdVCXL7wywtETjA/DCrhyt/pup1pCXAPt9OC1CGbDFBa/5EgX/9wz7RQ1UebPjGwK2OUTFCr6qcwDxAZV9hiORuKjZ7vdw==
Received: from DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) by
 IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 19:29:16 +0000
Received: from DM4PR12MB6565.namprd12.prod.outlook.com
 ([fe80::dea4:1281:3be9:2bab]) by DM4PR12MB6565.namprd12.prod.outlook.com
 ([fe80::dea4:1281:3be9:2bab%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 19:29:16 +0000
From: Joel Holdsworth <jholdsworth@nvidia.com>
To: Stafford Horne <shorne@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/openrisc: Fixed undercounting of TTCR in continuous
 mode
Thread-Topic: [PATCH] hw/openrisc: Fixed undercounting of TTCR in continuous
 mode
Thread-Index: AQHaufOFfAH38bytE0SmPd2VtjAIlrHBKeNa
Date: Mon, 10 Jun 2024 19:29:15 +0000
Message-ID: <DM4PR12MB65656FF201E6BFB43FDB4A3BC8C62@DM4PR12MB6565.namprd12.prod.outlook.com>
References: <20240607222933.45791-1-jholdsworth@nvidia.com>
 <ZmTbnfrp73tAt3KY@antec>
In-Reply-To: <ZmTbnfrp73tAt3KY@antec>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6565:EE_|IA1PR12MB8357:EE_
x-ms-office365-filtering-correlation-id: 9feb80ae-29e4-42ab-26be-08dc89839dc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?d7Gd1ED/Nit4ugpxvhKGvm4GgdhgdzVxUjmYevwTx8qrGbdMZsnk8ooTqu?=
 =?iso-8859-1?Q?uAkhD2mQxg8ps0dWmyEaoOCRXg8dR9Cyx13WwwGWGI4RKFE1pYhXOzFdj6?=
 =?iso-8859-1?Q?GVw7jq8sJZz79pqSMyFD3uuKvjFBpmEe0FwsEwgRlsymwE+gb82ByX+xRh?=
 =?iso-8859-1?Q?1bdR/ngqtT7+UWCTpWq9coBisgCxzc/2N4KOK+bb9VR0eSzRCMERSZKbMR?=
 =?iso-8859-1?Q?VQ9wL11jEHk0IQcIMfGDnY0joXzhb7KjB/vbTxwpdHD2hs/BV5ebIUMcGj?=
 =?iso-8859-1?Q?8aSqIW6YtkjNvwiqTaMVhpx9cCdoU9IJWn05PY9mp4WuBcmm70BPWkmNk4?=
 =?iso-8859-1?Q?cgbDa6UVwFTshd7LHfOfL7solpLGt0I6EPg0u/MYOyPCdmTjKDMSanuT54?=
 =?iso-8859-1?Q?sNX10k5sowwRBTrQRP9jDEAvhjnFqAjTd5Am0I2v12vJdwdF9Jw3WlaQ/f?=
 =?iso-8859-1?Q?q02ZpyXXhdG4X3flK3zYVA0P0mlya5ahdIbznMazok1TVrgPuyGd5b8bRb?=
 =?iso-8859-1?Q?KAw4xrIVb/WsuAtKRmwWwxoKM9Ge/GkBoFFHr+B5G6Wn2mE+8jjnPcArup?=
 =?iso-8859-1?Q?3ILsmgnABwwX6a5Bf/CcVS38phhG7cZm8Sh+7JPu9F1l3fhec4a1mhiSft?=
 =?iso-8859-1?Q?j6tht4ys/OXMm8GoYfGeSHTNJMJdqAyXhiyZ8UanqqCEb0QAqw5eBwyw+y?=
 =?iso-8859-1?Q?sk1cbAJcnSg8Eg1GIbNyiuLH8bwkyFiAeVLM1yLWZDt9L0ejTlhsW7RSda?=
 =?iso-8859-1?Q?8y4MekmbUfLIkAYX3Dd5Pu8B0D+iCKwead7Vxn4LIS8otFRYfPzr9hhpho?=
 =?iso-8859-1?Q?I9yTCme2I+ET7PDEiCwCs2MmZe0oibGdf9IzwX3kxtblCngIHAWvyvzdRi?=
 =?iso-8859-1?Q?GaJwEN/cNRI+FjLRlDYkBKDM+mpQZyyr3MqQ+E4JTC1puQA500uUdd5AUi?=
 =?iso-8859-1?Q?75MOcaKFNwwfoGYrAVexFU36ws1NWBl2yVFynfZBqDYRQXjVT4U7NvI2tJ?=
 =?iso-8859-1?Q?1Zj52wj0c3kSynCx5tYn0T2wEnTiEOEAAQcRgS+G+xwY72IuBMPIHKpYxa?=
 =?iso-8859-1?Q?pWdW8OJiFiav/3xs1c1jpo9Y5nhoHU0q0UckFdIWAJU6clc382HSuAnf8X?=
 =?iso-8859-1?Q?eG9oVUeF75FlqIVWRLFcafgA97U/T1hM/bo8aGdkdd0QU4/F0lnWdTf9Gf?=
 =?iso-8859-1?Q?yNVoJkjlTlyExyCyARI4VHtqj4M+Yqnzg3s2iJowNk5wN0wYwTZCQb3hZX?=
 =?iso-8859-1?Q?tg7OqRlgy6DujyNRNBpU4WRp3E9sczBWlQ/O/ghOg/y9IDpBWDpv5jreDF?=
 =?iso-8859-1?Q?oS6cZjtEVaH7qYMu53CPVi6liZG/8HYxcwqa34N2wZGRXzHuuIzQOvo01l?=
 =?iso-8859-1?Q?RmvatCmpEP8Mpt542JbPpD6dTr+eImFmQJPYxVQGLx5e/vMfZaEPo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Eu3aVTeVgdVfYfI5VI+Jn96+rsb4c18AMCZpu+lmxVocdyXB7UjfQKDEax?=
 =?iso-8859-1?Q?Fzm0jQLxTvg249dZn6NRUR4PlJIYkLM45caYxhGzqK7wB4YBORNXGRnDg7?=
 =?iso-8859-1?Q?pU4n7U/2TXHfieMUgs23mM5VYJUicnyEe5MUIYHq+vdmvFFRqClU5PrlcL?=
 =?iso-8859-1?Q?qkNcvecRNb8688mLyct2jgL0xOPYbIXFU1VazGa84fw4FMIQVDiwmEqjdS?=
 =?iso-8859-1?Q?nS5jX+GxVTuyRcqxS7x7dE1XG8K7vxTMdhkft6BLd8E/ibfIEX/IefiWG7?=
 =?iso-8859-1?Q?e+4ahOTId1u+lh5yMlkmjbrzU7tSBM7cYJgSF5beYcxEuMdC9hxMuJdk6D?=
 =?iso-8859-1?Q?C4LnFzpymAglBZBbmPBpI5iLMB66MI+nWVOxfRbPgMP8YoPQdliU0hZ0ur?=
 =?iso-8859-1?Q?8bQTjzMTe1F0ZqaqY2B9GNaO+Qn0sQbPIXVTfGLsoE2hQWfKinvTD6M/5H?=
 =?iso-8859-1?Q?VgjZFSqv5uo5uzryueKdg/fANByK4o3cpoEIun0X1l86NnPh5+LhJAxWJc?=
 =?iso-8859-1?Q?FmrANUhoHo8Xgkt8xjRaUvSY44YwdxsllHfT5x11UrRk5AeYSrWBogtc1l?=
 =?iso-8859-1?Q?APlOdFwzKppsc/y6IS0U3XSxc+zpcPKNCttlERK/TkT0/Kjopv6HYcvHTH?=
 =?iso-8859-1?Q?LexJ/9nLVTKkqdE4XD5NxtwpK5TXbZEV68Vd7lyhPQAzrrMA9PtXWqQOpA?=
 =?iso-8859-1?Q?5v8Wp3c1aoNUCubTaelsvHWsLZpAgw9R5SNrE6mvy82I9fmtHn9Hg+xqeM?=
 =?iso-8859-1?Q?hQf3EJn3czPtutQY9nsBtoRC96jF16ThckzhbSpIGhEIoM29BqZQ8c+q94?=
 =?iso-8859-1?Q?z29FkOSqoxlCMX0uEfOmNxR7N6ExfptzPG4QeHtAp7ueHvJHDptClGJBKZ?=
 =?iso-8859-1?Q?rnxQeqRVkHSsPXPa6uOY26ZAUTgbygRDkTQW+MTugWlItrkdKyyrCT9+AN?=
 =?iso-8859-1?Q?zn/NtTKwbuHl+VWiWE/1q6gQNceRK9dI+7vAIQWz0UM5Tq+yu3tKdQnTzf?=
 =?iso-8859-1?Q?J1DqOSXY/avbhDYb/0zvZzB0kl85Oh9/ImJWQL8WXGizz9F+3QaUnV3X5U?=
 =?iso-8859-1?Q?vIzNOOGoxf1iBrbtG9QyJXyAJJqc8jzgVS9VQjSo0rn2tJCJZ/2WUK+ueX?=
 =?iso-8859-1?Q?oGvDwviIr8qDdxMTs/+EPNcRhhfdJv3iy6SPlBVl/G1L3w3fgctw9fA/R7?=
 =?iso-8859-1?Q?2mLaO7WCevpvBZ0HHti+h4rsD/IGn8WGa3SsFhGTGVvAxmbbE8vMuEd1XH?=
 =?iso-8859-1?Q?0/UL/w/NXLXhrxMvXXpvddHaoI1BD3Bqqtkw7U1iNo261PfHBv85JhA7JI?=
 =?iso-8859-1?Q?def+Bic0rWzGYJHt4KQcIw62PwvUOB4oRJytMVAHTDcZGzai84aT9x54T6?=
 =?iso-8859-1?Q?X+HhUk39aG+PNpXNo43QY+XnQAFNsKhn4pveljY8l5E7YC+NPntPc/RkqC?=
 =?iso-8859-1?Q?3CMRoeXS1yW/W3iOte4YTdv6rB7t4tfmkthk6xlE+6nrbHmSX9mRYeycp/?=
 =?iso-8859-1?Q?z/RIBjgNXKgBxRox7vlvjT+tXUZNFvfXvXJmh3OX/0EsY4xUcizUu+4qjX?=
 =?iso-8859-1?Q?tRJ+rO8QPfT9h3zjWRbEqn762u158UenURyiiep15e+hYtpA8IAJwhJ+aI?=
 =?iso-8859-1?Q?4to9dDyyzxOG+CRQCsvW1vI0Yd3ZZcWRDC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9feb80ae-29e4-42ab-26be-08dc89839dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 19:29:15.6507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyhgDyC3gPP0T/ovCbMpf5ILA7eCw83nMcqKUvm0aLnMUmFzDAlTEQtDL2K4YX7biqQIubvwSE2S7ySo6D9JHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357
Received-SPF: softfail client-ip=40.107.92.82;
 envelope-from=jholdsworth@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi Stafford, thanks for your response.=0A=
=0A=
>=A0- You sent this 2 times, is the only change in v2 the sender address?=
=0A=
=0A=
Yes, I was just having some difficulty with Git and SMTP. Should be fixed n=
ow.=0A=
=0A=
=0A=
>> In the existing design, TTCR is prone to undercounting when running in=
=0A=
>> continuous mode. This manifests as a timer interrupt appearing to=0A=
>> trigger a few cycles prior to the deadline set in SPR_TTMR_TP.=0A=
=0A=
> This is a good find, I have noticed the timer is off when running on Open=
RISC=0A=
> but never tracked it down to this undercounting issue.=A0 I also notice=
=0A=
> unexplained RCU stalls when running in Linux when tere is no load, this t=
imer=0A=
issue might be related.=0A=
=0A=
> Did you notice this via other system symptoms when running OpenRISC or ju=
st via=0A=
> code auditing of QEMU?=0A=
=0A=
I'm working on an OpenRISC port of Zephyr. The under-counting issue causes =
consistent deadlocks in my experiments with the test suite. I wouldn't be s=
urprised if it causes problems for other OS's.=0A=
=0A=
=0A=
> In QEMU there is a function clock_ns_to_ticks(). Could this maybe be used=
=0A=
> instead to give us more standard fix?=0A=
=0A=
Seems like a good idea, and I now have some nearly-complete patch that brin=
gs hw/openrisc/cputimer.c into closer alignment with target/mips/sysemu/cp0=
_timer.c . However, don't we run into problems with undercounting with cloc=
k_ns_to_ticks, because if I understand correctly it will round ticks down, =
not up?, which is the problem I was trying to avoid in the first place.=0A=
=0A=
Joel=

