Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE019C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 20:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUWWn-0003ws-Kk; Wed, 25 Jun 2025 16:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUWWl-0003wi-4A
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:15:28 -0400
Received: from mail-northeuropeazon11022139.outbound.protection.outlook.com
 ([52.101.66.139] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUWWj-0006Ce-7T
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:15:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAG0AMY7PZb4vvw6K3BatMwbHfMLQIb7KEthJE1aW0NpwahxZQ5XaLBfi+hyIlvAQf2XAoM+TCmZEF1zWS3+DifLxvCtyXDDH9chyvdxnHYAJmN49QD2FJYr9XcStHTp/2/o/ZXGHG1Vj0PcMynk2k0aVB1CPZXfT6+TQyzMAFXnK7iYzOnztiKZMvkbl4wSw13KT3r4sYRXW0YiEpoUd/X8hYiMwksQ1tPRTVwCTTurdgkTPN+YiD/hnfALMHSco01mYcnUTHgYQ7JR213kVeJmXPEOdTReTmMBx/qITIIk21YiysZVJw3SV8WNqkgtah+Fjb+D0WlBCE6haAPrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZL/3NcpzhpID71twlu611K007O4MypGjScYocFM6IE=;
 b=bu4jwQn7vyJBWZuijCUh8pqGv7x8h0ZKgovM2oMoKyzkQW9rz9bCcWCbV0if2sGPMFZzgtfshIDYgxLukT1RZQiKYMc449pBAvTZ4cOAkFuviqCm7cPYLdGuPl2U43ZNLUnNBRL+jcticFhUXK9cKMI8tg1vncFo9Mdg6vjmlQGimTzy4R/UMzZpePhwNahPNmXeeyx1wfbNsX20IalA9s0pHAtdCo10Rp5nryf9EjdEo2SNwXYuQZBr28EC0eVNM6hz8u2U6+YkBhqXoLrcUqNaHzJnnqlWYn455Eqh1L+v8npB63uKf6ZKc040H9wXz9m26VcwvMnj5ssXgFVTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZL/3NcpzhpID71twlu611K007O4MypGjScYocFM6IE=;
 b=LzF3EtniPDMgg7ErXnJXWR6w1aSRmT++eaJj36WNhkKY9UBLIA9sf5wq7Jbgm7VmbLZhdLSa6ymfcCd9I1oKNQcEH8F4rQN0rzOUq26fG6jeMtm2U69feoPvrVqQj5wYMghdiFfeR9qcYbtd4DUlDgmf96ShXNNPGD3gwpH1b3gkOWn7twcGEk3Nc9RPwRWbBHPAYrmSWL/MPY9qWkcV2LhtFBtnOpm75r/nvvc27icJR+LBsd3AWiYUxx50u/8kVbFcuyWNRtf2LI17Up6810IXVfMftP170Rd4HjE2FOEd3k6QbVzrarZl0b9/yIAI2K9ZiZRURo+0pgCL/h9iFQ==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by AM7PR09MB3687.eurprd09.prod.outlook.com (2603:10a6:20b:109::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 20:10:20 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 20:10:20 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v6 0/1] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v6 0/1] Add support for emulation of CRC32 instructions
Thread-Index: AQHb5g0ty47uRcKYlUaPo4qVlFvYrA==
Date: Wed, 25 Jun 2025 20:10:20 +0000
Message-ID: <20250625201005.1480421-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|AM7PR09MB3687:EE_
x-ms-office365-filtering-correlation-id: c85e94fd-bb26-460c-4502-08ddb4244f96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nLrIhDjwPkFdNq2Pwjdaku2w1sMlt+ORlWJBRJV2v1pHpUATC/A2xw1E4s?=
 =?iso-8859-1?Q?CnyfZ7QQ5lX+VfGGFb+KxNhpa0A4+y+MsACE+6f8Wk285Jdrln9B1t49Gv?=
 =?iso-8859-1?Q?ilwv6xJK464ya2MadJ20YMdOejWUewFB9VnTqVhjiSXUVQiUnzD1T5OoQy?=
 =?iso-8859-1?Q?njWduZrKE0Onys1eFhDyvAQQuNFJd0uXJFieFO+mE6mnEIoMABwiX6pC8j?=
 =?iso-8859-1?Q?BvCmhhkdPwVoHLdh/DTIYRwuTFZ+yCvu5m+64J+z/i/Ri0hUgq3l2684dH?=
 =?iso-8859-1?Q?yeQ2yLn7Zg3V8tkO8RIlbJa3r7myNRXpezG2k4g+9Ii78eMYvJ7CrUwLDi?=
 =?iso-8859-1?Q?22EbZ0//KdUZ4aU1b/zXM0g99TuEpBuSyxBn9ms7sgAZtv3+iubcJO44cd?=
 =?iso-8859-1?Q?feM/uanDhBQfgY0YT/MlUQvRpfIKbUCBfqqQJYA4Yyssf9m7rkSd+ULIPR?=
 =?iso-8859-1?Q?bHwTPiQ0M2UbIWplgf0lEMM9qwArKgg1fKfbY9uN7c1XQt6MTSYX1xl5TW?=
 =?iso-8859-1?Q?XwT9x5xmtw8f3NQlX2p2r5ahGZKwCBHWixcpMcsFLG/FtUH2xdjW3IxAgd?=
 =?iso-8859-1?Q?AgiwNzWzZj+vCmux03axEwjrmlW+15tIuxSFuSns3rATaEEm7jYvuAFWth?=
 =?iso-8859-1?Q?V8DsSsCq4mAQ95u/BaLrcJCo++sjvYP+s03YeERq1qeAc11sDR9hllZtzl?=
 =?iso-8859-1?Q?6LVkFInnUfb0RJ0ED+fZaRGOYrF5/itv1UoHhpIoabn5/49FwrDVtG1FbY?=
 =?iso-8859-1?Q?B9KnEp2BZZGpe5vbuJWoJ/mSy4W0IkUcgw+gHfoF5tY/GcxxWdh6CD/ymq?=
 =?iso-8859-1?Q?FkRpjRh5YnY4CRKoHnAZTTfTYoH85kVhfYlOQvzOgAFpOKK4nlC30+LdT7?=
 =?iso-8859-1?Q?hop9mdGDqCNmmcHMN6tmdQesW0Po1EuGuPRfFDrGf2HTAwuo+Dx9g3JI1w?=
 =?iso-8859-1?Q?AHPfv2ey9QxlIweV892gvfzspUygtqpYJU6JIjhGJ69e+JzbCmKVUl03Lo?=
 =?iso-8859-1?Q?iAFDqQdZauXTUhah772NmybpaFkH4LHQf1CdSWZ7pO3gXXBjrikQaepvQk?=
 =?iso-8859-1?Q?N+6SwrYlSps3Io13XqzzJ8EKzIK76ZogvLEkys/B09zh6eY9H2vepdjBW4?=
 =?iso-8859-1?Q?MbnTWkRgjrqhjCx29gQIHZ4gUvlEjCYN47YWNLIWjmByqVMCoZDLCvgOMy?=
 =?iso-8859-1?Q?6tZ+tgL3sSc0ldO+JwfvdTNcejPAUah9xuAyO6hgbYQW8XSSNl7l7FP0v0?=
 =?iso-8859-1?Q?bsY11CNyf9edqZNqdZ1DrMc4uI0ZemEML6SPFHg/+RAykYmj3wG3DbNgF9?=
 =?iso-8859-1?Q?wII3DA4YVZ2Xoal49Tw2WW9OMbeleqRnkZKl32N8WyNxD+KOF76hGy9x2B?=
 =?iso-8859-1?Q?CkZxZId+z/diSwrvxhWtiGjdQarnKdvS/0tOECAUVdoRMmXLPVtfhK5LS1?=
 =?iso-8859-1?Q?/fm6Z+VIOIp83JQtXXkx9mLGerPqlxG9FRK+wuj73ff00kxEDwIYSmDKvf?=
 =?iso-8859-1?Q?BgfRZV21aBQ9UXTspROl60x6sf8DoP+OGy6837a6qC+g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZGQ8RBHHYArDFq4ycNB3HyKqS+Zq6dlmvnoo3b8Gj5o6G+0LUILT+a0nu2?=
 =?iso-8859-1?Q?aX298ec2ZKFopoiRwqjX0XoRfO/B+S2EHmiQZeY88MWc1fYHDNcNH+yna0?=
 =?iso-8859-1?Q?0TAkwg8WQ7lDkqc8XmLbROdOEmx6XpGv0jDRcXhaCdmIZU0lSE4AAD6FQi?=
 =?iso-8859-1?Q?hjSW44a8E8uDkMB3W+zOGvn/SdbNGbXPvEF+n72p4LOYpXHwE8t2TmRvt6?=
 =?iso-8859-1?Q?IXzgK2GdKs0dmvZGHUOrH7+q/VWvQAItoWHnjozAazhu2UAn0WA59/ObBS?=
 =?iso-8859-1?Q?1BwO7iVRvFOcT1YyTC67uGqkygOKuwrk/55rnoThIC62ZpuPEyHpNIrcO7?=
 =?iso-8859-1?Q?uxb6LVUSHNvadzMcNJVkpUXv/96e2KlsbRsh7ZApI+JAMMZOBSWW/iAmbF?=
 =?iso-8859-1?Q?CcdCcZd1g6Dv2DtK6KglKUF2CJj88eymLOIRhtsZ/y8hD8FqXh4MM+aM19?=
 =?iso-8859-1?Q?+DXj06xQJ6K0sDej0A3D3hrxUb9a7nJrHZLr8BZ1gfdeAh3MN0LHRlfzKd?=
 =?iso-8859-1?Q?6dBFYuMqMDi54JU/TP3eapPnUss+OhS+VcU2INCAZjrHUjshdKdj9K60Zt?=
 =?iso-8859-1?Q?SVn2sEWu/YQwdk8Tvkqe8To0lkobC/fZNc0Yo6vWD1fkNI5vpkiXZfXn0T?=
 =?iso-8859-1?Q?PbRzlB87BIyhBlNygx0O4r5mvCc4R729lMUjsJ8SPBt8bH2D4B1lHqjpLn?=
 =?iso-8859-1?Q?6/Mqu0o3PqHAtd/030Z6rMAk8JNEvrZ3zxwxIngPdfmLwNGIiQJEmxXGs4?=
 =?iso-8859-1?Q?r/1s1ofq4MwZ1OJH306isLk/nnEIWrOO962L3/zAXFtW2swQ87ql+Spnaj?=
 =?iso-8859-1?Q?DoqUZJTk/yylskCcetUhuZhdZMF5Zyv4P1hfQMq3oczzOvQYnetvdLLVxc?=
 =?iso-8859-1?Q?7/M43T1WTEO6yfadDnkDN//7xUzfwiOyA2pKNbNvJNfUBBy/1bwgCcnhhI?=
 =?iso-8859-1?Q?TTbb91IOTBxoJSvSimqW79Tdlg6QydEUlheO9Oy1CIWWwoy9YI1BdSlNui?=
 =?iso-8859-1?Q?gVD8u0DtKx5hWxG8ymZ8sZyS0+0NETkzr0f42jPZyrw+4lTVGUZnOQAdRy?=
 =?iso-8859-1?Q?GG81ybCx3TPxJvToq6e0i9bHBOn6dpNjQQVSl2rsGc4tnGy51KQce0bILr?=
 =?iso-8859-1?Q?xwdHf1O2fcXZjWP6LfksswbsaFYpoA0k3ezd9GlQmxHp76Ur69eFKuhHZO?=
 =?iso-8859-1?Q?uZAA76rJPEKPftD/5UxjbU64iidn+Wl2e4oKhGdxXg1KUr1u5/6U5kQpJc?=
 =?iso-8859-1?Q?Eb5foWuJ1hJzCcjwXuSBmpbhqd5csaaIxHz74jffnbCNqqbX27LOfyPoIA?=
 =?iso-8859-1?Q?POKeu2i25HSokSukv6UDGYp1RCtYqRVoiKd21ZEwAuu02BYzjtbwnAUwZt?=
 =?iso-8859-1?Q?B4ioSYQ+hGP0qP7XnajGj5IOvzU2wNtXOwWwzrqxxGDTBkDZr3PQprRhZI?=
 =?iso-8859-1?Q?XLkHaFA1NzKZ3sgAgDPEYANY9DybHeepLZawuyDTxbpcsss05+RFqzkZMH?=
 =?iso-8859-1?Q?t+16ZA+LnWe3aKNIBqgSiVKHOhTZA+ySv1oIp83INl2UVjswfQ5Eja7+XQ?=
 =?iso-8859-1?Q?inhbKX80XVR7jwnsGqdISKOi/Onx312nTVwNBmlP/eLNHZj1HWSE5XTymU?=
 =?iso-8859-1?Q?6cZMv34Wn3NFIWyL1u8+ZXKg1NQksiHf2iRSYNocxIVG2oK6CLtKVMJZ3O?=
 =?iso-8859-1?Q?x7OfK7vPnx2A01NfFIc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85e94fd-bb26-460c-4502-08ddb4244f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 20:10:20.3227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkkmMaayMpkQ8/7YeayiaeXeB6trfqFOmQCV0Dzm8j+e/qOJsGCACverukh0/IbkHuIvIcBHaUaJ2xMiLvyhnevZQPMS7/yiUs2WBI2RmPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3687
Received-SPF: pass client-ip=52.101.66.139;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

This patch adds support for emulation of CRC32 instructions for
the Mips target in QEMU, and enables CRC for mips64r6.

The CRC32 instructions are available in MD00087 Revision 6.06.
Since the disassembly for crc32 is hidden in commit 99029be1c28, the new
version of the patch is basically identical to the version 1, except
tests being added.

Kind regards,
Aleksandar Rakic=

