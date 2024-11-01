Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3930DE6F06A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 15:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6tQw-0005ml-60; Fri, 01 Nov 2024 11:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1t6szM-0002IP-K6
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:51:00 -0400
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com
 ([40.107.244.77] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1t6szK-0005E4-C3
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:51:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJ3dBrhlIkgV04II9Ljk6NNEu3P4hSIr6MEtij0pO+YWQyx+zMaU941gvBYJo0B6Ota6MvI4Ew9Qe8AA5nekAAwXaTytkajh69nu4cY2xlABzGOkFWecMQfOeuy4UHyxOzNAn8o3cZ4hBN/B8259PV1KkCbFpVD7vFCNaX5IKvp9jnwjoVIlHivBQL4xnuT23TqME4Oi20QXmCW5d3J/6cAqjG6ZG8qL1w5aoeSRfLatymhpz0qjQFQVV56bqVnZA15zQHrHr121oOQDzFIkZL+5tiHt/Na1A683v4ozETknUfDWU8VBpF24MjrupYdbeBbewgvS2nfIcPg+Bscwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3JTmtVTyJMP3PGbNetA9C+k2MU73J2eTLW012MZ/ck=;
 b=jP1BZ0BpUSi1NhdQU/5YLKN1F56aM5xxlMo0GWaDoCF3RaT5bVqK3Rp1wASRcw20kqOkT2oDuM4JcqQ3nE03MOZk05tlbFyP8g5mqwYwlN+56oab8IRUN+H+V/sWz1Ka/5iYnoW9BBAzFypKUeI214LuI7i2lm7emloffUPz5dvSzStQhBswT7JnbJB5MSS2V11FUlYctdQnauIZyljX9fpKxQad3kz3OHUVxmb3Qm3eC0f034h2nYvZUjfukQltuD4tb5HkP012ykkwo8zh98dP752q1iFMkAsJGfKtOnIeM0i0uKig9Vp+gc8DK2oDY8qFikqMIlUT5iAXUXwEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3JTmtVTyJMP3PGbNetA9C+k2MU73J2eTLW012MZ/ck=;
 b=FpUR7t9uZKTOBvY/P9ZWq0yKXEefO6mh4f9xJmPp5Xi41OR9gYdIqdJLUCc+EFLvucIETP3APOUnBWri9MZ6AptMwUv5OcGfmfx8W1E+KSy4QIrNUpIX6pYhGqLdIU0YVwtozM2FmI93yg9/olD42azZ/jM+FShECY7L4R/WMYc=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.27; Fri, 1 Nov
 2024 14:45:44 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec%4]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 14:45:44 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Gerd
 Hoffmann <kraxel@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: How to pass the EFI_MEMORY_SP type to VM in QEMU
Thread-Topic: How to pass the EFI_MEMORY_SP type to VM in QEMU
Thread-Index: AdssabKydgSiEnpeS2KT2d6BYKpm8A==
Date: Fri, 1 Nov 2024 14:45:44 +0000
Message-ID: <BL1PR12MB5317899723624202EDF03FC8F1562@BL1PR12MB5317.namprd12.prod.outlook.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=ba8e94ed-fde9-473f-a583-85c655062c5e;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2024-11-01T14:42:44Z;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|CH2PR12MB4133:EE_
x-ms-office365-filtering-correlation-id: e9d11d81-52cd-4cb2-a7d5-08dcfa83ddad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?e5Ba1A18IpcJN+VaV0n5XcMfwrQIZQmpoACQ+OzjC2AlsBKkbNfMVQlZiT?=
 =?iso-8859-1?Q?jlZshU3WqMrqe0720u3zelIt5igdevp7QB4qHKkIuDfp2xzsjcbr+JTzYW?=
 =?iso-8859-1?Q?eEQBqfOp8LPyKxuPFAz/37JDrN6Kop98gm3Fy4HKc7j72VEKfyRedM3NmI?=
 =?iso-8859-1?Q?rynWG+QTZyH7TLH8+OaU/9zbzhf1Bq0NADnHGVN6Uz1VNkVpOroz5o5Mrs?=
 =?iso-8859-1?Q?uyJw02yAyrh282JHcft080eRTsnOEnOVpsvEFh+GoKychT5LmzJPrlZkbg?=
 =?iso-8859-1?Q?4bzZcRo0a5SeGUCW79A2iujCUBytU/IH/y9cOJn8mVB3tJs/TnZJ/fc6QO?=
 =?iso-8859-1?Q?PbeNPabMliOTcz1cog/K/QZj4h37b2Tq5a/QZRJQ/uRMG91zL2l33FE+iA?=
 =?iso-8859-1?Q?SSHs3kJrMKgmW9JbmK5o4fd2QJ5SFAEwuugJ4s7O5e+/pf0DjzN0ckygen?=
 =?iso-8859-1?Q?TgC8bbCIpOF/WBDrLC/ZxO2G7tK1FtTaQ1F1BOlszI/QY0Ldyv3dvjUmAI?=
 =?iso-8859-1?Q?4TclcDm7r8ZAquR+mXoVCv5K4NIrTMzYFlZtrBjlfT/uAwqqEak7lQBRVm?=
 =?iso-8859-1?Q?HsV2yBWpOFB8pBQDyo2rt8aoPjHHY/4es5ooCspfaCiAnORZEQUjYCV1hN?=
 =?iso-8859-1?Q?bNi4dzdmqgEKXoyMaGfbTYZbkrccXqB3ZfLJ8yNTS/rJ2gzxXLFyKMVkCY?=
 =?iso-8859-1?Q?Qd1+8OQyY4GpDJJH03ePKaeStDZl5lUJC3W119Fje5EED+RTGrJ3unVU3A?=
 =?iso-8859-1?Q?pPASP8PDBCMz9dkFJcGL3rQHGwZrAxBnLBaJCarRTujMoQDOrR3LXM/ZDt?=
 =?iso-8859-1?Q?QsrPKyFpA2irqVUYgOuY8C/m0VBkvq7lN2rKFPZG7ozo3UyCLOULjstIVS?=
 =?iso-8859-1?Q?MqXOuGQUPNwdJrmQKSeetDA9hAFaijJb4if9lWwIQ8CIX7+p169kGbc+Dy?=
 =?iso-8859-1?Q?0fDDqVz1aN9NSOZ8vlZjujAD7LjLiP3m4JT+bbP1p84U8yaHQzbYH9ID0d?=
 =?iso-8859-1?Q?KKjf/FxPoZk+0a30Sx9h8UNgNjw5kx6P82070/pCAtPytK3eQTKCgzc+4C?=
 =?iso-8859-1?Q?WmVJUF54jniOkOPWaSohzk2g4+r7V8tmWKouEx9LzY3lWMDLNc+4Vq49q3?=
 =?iso-8859-1?Q?Dd6JKo9PjMfla/oHABMzhK3lAMDicXNIA1+xfyJyHrWbs/RnkDB5lY8M8X?=
 =?iso-8859-1?Q?M8vtIlc/YVWddG00fF1iSeFG1koWQaWKTcDRlazoEFqh4hck2cE9OoCiBT?=
 =?iso-8859-1?Q?VKcUAiCbMR1I0IAo9Nf94PjnCz4EGytGXfp3qqVYl3Xs7P/VqW+LVS4HUl?=
 =?iso-8859-1?Q?H9bA12aaPDWwCYRB+HA26o+NannL06JYwgxMc9+5CW54San848n3mbFHGB?=
 =?iso-8859-1?Q?XtIcAm2e00ldMM1nuj7XKFAUnBK/T1S8G6aKBsz7GoV/Hb6M2d9AQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HPptVdgen/2KogxLza9lJUy9/HpazYZoTM+uzs1fpsGjcwxuU83WjeYiRB?=
 =?iso-8859-1?Q?UCiDWh9fMsLGmGBPrTs2AxxQP3egE7e/BDVO4lI4S98cEPVV9L4CPcGcOH?=
 =?iso-8859-1?Q?pz3tXtcXHWLTIgJf6/cPZ69PbEtvZDD+gyDL2vbVqHTDF2BtG0GBVzqT/e?=
 =?iso-8859-1?Q?g0vaA+pPTj0MhbibTjwOPsetZKmzwkhdEovkurhDZvw6anz9wN8VZ+rnzT?=
 =?iso-8859-1?Q?QaEnR5uwGLkXsL/vbmu5wSrFOCpJKNp0K5DGuMzsNavSaaIrQMXDHP+a2Z?=
 =?iso-8859-1?Q?UJ/WrKVgReI4eWASNwqu63kG7dmdniCGyJMkzycl7FXDWrYG+n7LFgMWM5?=
 =?iso-8859-1?Q?+NxvJSzkTWb3gnDyhPvPvlieCc1nmFKMnmDYMTdsfxmMv1vUyl+Xg3A17I?=
 =?iso-8859-1?Q?CLaiNH2bKYYN+Y50XwAfgzTJxQoWiWxdDZTVgMmxlGq7TX5GVcpxclEPe8?=
 =?iso-8859-1?Q?+v1r+z6fAMNBxOYcQriaQEqtkBYYyQzJgxX6AA0lt4vkQoW+P5Ovj1YOLG?=
 =?iso-8859-1?Q?suKYdOYIYXPlDEfKCpcx8b/Q6KbHdd/H1vR7IZoLbhSXk6f517xdil+DhS?=
 =?iso-8859-1?Q?B+enB6LojpUBFOw4Qp4oImqgVC4KMeEh5WXLrKDmqbQITZrKSr7QKmD0Ib?=
 =?iso-8859-1?Q?7PVYGWMrLbc3ky0L70XvphC86dKvqhmR+Xvu8Sb/4MHFUYgaSJq7OP1y9B?=
 =?iso-8859-1?Q?7b0VvkxEDUQGRYmts8oIHtmSRFqeeRndqnqR1aaJM2wo6sQ3XbM859AJYN?=
 =?iso-8859-1?Q?yMXfGmFmYlTldYhkWLcMxTqX0u9KsEcNfP1x0FWvvgucSqz4UtdwvJ+qmx?=
 =?iso-8859-1?Q?Hn8LCas/O11VCjKfhy927g/SfszXEMp3v7WF0Kg6lriz8QPk/mgurH+TZR?=
 =?iso-8859-1?Q?RgFLc/jLc8BfO7Cki8KEAKI4F/xF5WIEEIVRap5gXVZ5swF+1ankvNoHZu?=
 =?iso-8859-1?Q?7jGqvyCVRJX3bxBQ6JZ5nmb+al9YGGG5IXstcpFQCBVVczwpupr/gfkBsa?=
 =?iso-8859-1?Q?2uQ0z29v9LPm6r+6R12Zv039gcCimkkTuxgY0rYR2fvoj08U9Lw+FG9wf3?=
 =?iso-8859-1?Q?lkdZNh3HjYdp7w2hYrL1hKuexuaZmpBOCC9+hYDe6WbyDmuzRA2k1HxsOH?=
 =?iso-8859-1?Q?JI1BkeJxThgTlcfMV0oUwjG2gTvvcmlp68Ifb9DvKXrL6D04JT6uvobz6t?=
 =?iso-8859-1?Q?bIWWjdiYfohG5+ANccGkwVkP3MCKa/6MlXFlNToUpgH3GFqdIeCmRnNyWO?=
 =?iso-8859-1?Q?sYhPvk50Cth82cgOm+alO70tZFAZcHyjYJccXEqiv4EdaBDZvpFL7JcKDa?=
 =?iso-8859-1?Q?nZSqcfvvW8583hU+wtXsjH/UQVNtgZyNn4IjeDSN4OKRunlmjngzelL2ou?=
 =?iso-8859-1?Q?3m63UdLo5wdDrjwYokh+lLVjWuVTKlUogep/z564EcQZ6imjGmOVpGJ2x0?=
 =?iso-8859-1?Q?XpNChnCIRsnp9FnOogZraCFUgmT135lO3kbYiA4c/mGv6gWyt2LyQ55yO2?=
 =?iso-8859-1?Q?s1SV1H5vRNYuJ25LXsCgF9yaS5Q/pscLH2/Y7Q356ELGamJIP83kZWtshn?=
 =?iso-8859-1?Q?md6j88LBkvznGUhzscThdG6HnS6xgSKl6GctpKDgYm3KoGtrQqVhbFxES2?=
 =?iso-8859-1?Q?GFUeR5vx/Xxwg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5317899723624202EDF03FC8F1562BL1PR12MB5317namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d11d81-52cd-4cb2-a7d5-08dcfa83ddad
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 14:45:44.6254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZEkIJVApZMLTtIxQRKkK39DiUCOrYkkxKQwyjy1IUc2/uc7CAfFgz02x01spsq8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
Received-SPF: permerror client-ip=40.107.244.77;
 envelope-from=Zhigang.Luo@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 01 Nov 2024 11:19:29 -0400
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

--_000_BL1PR12MB5317899723624202EDF03FC8F1562BL1PR12MB5317namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear QEMU Community,

I hope this message finds everyone well. My name is Zhigang, and I am curre=
ntly engaged in a project that requires virtualization capabilities provide=
d by QEMU. I am reaching out to the community for guidance on a specific co=
nfiguration that I need to implement.

I am looking to pass the EFI_MEMORY_SP (Special Purpose Memory) type memory=
 from host to a virtual machine within QEMU. This memory needs to be EFI_ME=
MORY_SP type in the virtual machine as well. This particular memory type is=
 essential for the functionality of my project, and I have been facing some=
 difficulties in setting it up correctly.

I have reviewed the available documentation and resources, but I have not y=
et found a clear method to achieve this. I would greatly appreciate it if a=
nyone could provide insights, share their experiences, or direct me to rele=
vant documentation or examples that pertain to configuring EFI_MEMORY_SP me=
mory type for a VM in QEMU.

Here are the details of my current setup:

QEMU version: 9.1.0
Host OS: Ubuntu 22.04.4
Guest OS: Ubuntu 22.04.4

Any assistance or suggestions from the community would be invaluable and he=
lp me progress with my project.

Thank you for your time and support. I look forward to any responses and am=
 happy to provide further details if needed.

Best regards,
Zhigang Luo

--_000_BL1PR12MB5317899723624202EDF03FC8F1562BL1PR12MB5317namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1087265321;
	mso-list-template-ids:913592250;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Dear QEMU Community,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">I hope this message finds everyone well. My name is Z=
higang, and I am currently engaged in a project that requires virtualizatio=
n capabilities provided by QEMU. I am reaching
 out to the community for guidance on a specific configuration that I need =
to implement.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">I am looking to pass the EFI_MEMORY_SP (Special Purpo=
se Memory) type memory from host to a virtual machine within QEMU. This mem=
ory needs to be EFI_MEMORY_SP type in the virtual
 machine as well. This particular memory type is essential for the function=
ality of my project, and I have been facing some difficulties in setting it=
 up correctly.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">I have reviewed the available documentation and resou=
rces, but I have not yet found a clear method to achieve this. I would grea=
tly appreciate it if anyone could provide insights,
 share their experiences, or direct me to relevant documentation or example=
s that pertain to configuring EFI_MEMORY_SP memory type for a VM in QEMU.<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Here are the details of my current setup:<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">QEMU version: 9.1.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Host OS: Ubuntu 22.04.4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Guest OS: Ubuntu 22.04.4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Any assistance or suggestions from the community woul=
d be invaluable and help me progress with my project.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Thank you for your time and support. I look forward t=
o any responses and am happy to provide further details if needed.<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Best regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Zhigang Luo<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_BL1PR12MB5317899723624202EDF03FC8F1562BL1PR12MB5317namp_--

