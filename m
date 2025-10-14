Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F19CCCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 21:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8mTP-0004YC-Bs; Tue, 14 Oct 2025 17:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Praveen.Paladugu@microsoft.com>)
 id 1v8mSv-0004UT-Mv
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:21:53 -0400
Received: from mail-southcentralusazon11021133.outbound.protection.outlook.com
 ([40.93.194.133] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Praveen.Paladugu@microsoft.com>)
 id 1v8mSt-0006uV-5s
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 17:21:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWU/px9XnK4lUlps1O2K3k+CX1XgZApULs0l8pzssRDoX2dUanz0PdfB+ybJpD2Ty+5+z8OjGzK/K4u6fFo87oTndBHtLF5+RAaw+sKXelBokFW7TnzG21JkpHGsCk69anabOCfPI3Zws0JTj1wUFogfFbmK7EipGF7e92g4EsbFtg0MjUHfZcJbfohlnS5RX5ZPbxw3xJyfb2o1E6kyrbAbDjeqjbPBQuuM87wFyBrYpOePaSAZ1iRwDthmG7aLxFxWcZVJmkyYNPBQRYc2Yzsx6qMgjOiG6iUQJeyEU6w2LCFcOI/j8n1rACqLXR5or2yeDjuggURl4TptBkgykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jJtSWGZbPnPrm1R24iogvco5AzPCWRQfKxaz49zt10=;
 b=Dw+zxlhrtAoaURSOGO/WkUSS1ahJtC4W8Bp8GcCX/5Mo1raCXMKSWXvSCX3DH2alTJnLfH809ShXo9q7hK/abkWGaehHHK0SDmJpLg4cFDKUUEWE/qqyha1wAOs14fG5aNAw7mYshWdpnmQ2grI7DNNgryMBEUgCC8tKdeGFZowQvtgU/4Y1vDhmpwJXHmUEMeVZXuiYwnQ+sgOZi4Hwe5xJPgN/ykAV9d7inHWGysDEmFCICY7HVLcc7M7/H3DtGOXDcn58OHXnAxmhgKZWp+FunRXRrX8Q3Dlb1OeLhdejjJrqUrdGLWXD0YCBp5q11K4LkqsMXC126wUEW2CtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jJtSWGZbPnPrm1R24iogvco5AzPCWRQfKxaz49zt10=;
 b=N4i8hev2RchGcXzhU5LPOMmN/NQOwE7vu+1o0a8qYPW7a4+MAcEKj/anijXmecSXgchf8q7TsK0IwAK/bAAAJN8mcAdlbPGx+4gTv/x3koo2I93nDAMlnRGfUvYMVGoe+1Eslsv0r2OvB0X04mRs9v/ha2NgZeMiXAsQSwt7mhI=
Received: from LV5PR21MB4779.namprd21.prod.outlook.com (2603:10b6:408:2fe::16)
 by LV5PR21MB5448.namprd21.prod.outlook.com (2603:10b6:408:300::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.8; Tue, 14 Oct
 2025 21:16:44 +0000
Received: from LV5PR21MB4779.namprd21.prod.outlook.com
 ([fe80::a4b5:e19c:1758:8e4a]) by LV5PR21MB4779.namprd21.prod.outlook.com
 ([fe80::a4b5:e19c:1758:8e4a%6]) with mapi id 15.20.9253.001; Tue, 14 Oct 2025
 21:16:44 +0000
From: Praveen Paladugu <Praveen.Paladugu@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>, Magnus Kulke
 <magnuskulke@linux.microsoft.com>, Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [EXTERNAL] [PULL 16/28] monitor: generalize query-mshv/"info
 mshv" to query-accelerators/"info accelerators"
Thread-Topic: [EXTERNAL] [PULL 16/28] monitor: generalize query-mshv/"info
 mshv" to query-accelerators/"info accelerators"
Thread-Index: AQHcPQ/HSIizVnKiWk2wDkOamGKY5rTCJTrx
Date: Tue, 14 Oct 2025 21:16:44 +0000
Message-ID: <LV5PR21MB477995204F4D6E2493EF087A8BEBA@LV5PR21MB4779.namprd21.prod.outlook.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
 <20251014133713.1103695-16-pbonzini@redhat.com>
In-Reply-To: <20251014133713.1103695-16-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-14T21:16:43.330Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR21MB4779:EE_|LV5PR21MB5448:EE_
x-ms-office365-filtering-correlation-id: 5038fbbe-3774-4f21-c984-08de0b66f9ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?P/Gyi999jXWdZ5nm/vxTHgaCE+CPH9bGRL6VFKlsGxH48HoFiz1euUABO2?=
 =?iso-8859-1?Q?F4KkyJSzHRY0KA6K5xJHf1EW7UT5qkdXAJbniKN9bF5qjD4Xfkz2MGYwQs?=
 =?iso-8859-1?Q?wBAKmYtbWesZXvVKf92Y602mEYxi6t9IuMiK7NhPow5a3lyjcPOcLKF3eE?=
 =?iso-8859-1?Q?2UhEOpSJvN+6EWNV/eFgGnKBt6stWu23h7bNa+G+8yH8Ci19//JpBjYxBA?=
 =?iso-8859-1?Q?dzXPGMHlGSoB22gWcDeK+hYl8g5Vjm8rSgaIjf2+Ef1SMMwgxa27H1i1Ht?=
 =?iso-8859-1?Q?9XMjnqbbhEIa413y0r+7/qRhKjDlAQBF1W+zAxH4JoEhF51NjlF93HPV/2?=
 =?iso-8859-1?Q?NzcfwxV0yxM80+JNOOJoSKMpEhHBbY4OLkHVkbw0jMA+9SBLJ9PuL0JaeI?=
 =?iso-8859-1?Q?7SIGGxnsgDfdZ4HnvmyxDfjOZUo2PTubyYOeM2d7iBmseW8bLxfqwV++Zk?=
 =?iso-8859-1?Q?chm9a2NyKG/z7oaruNW5VUPn5F9nTcJVSbd5J5Fh473gURJLXgFx4JWT6m?=
 =?iso-8859-1?Q?avSlJRpk4+R0heKaIssbfVQb2rFHEzgvLXfOormE1qnz+StGx2RaX36FfD?=
 =?iso-8859-1?Q?gijHP3SR2DwpI3hapjJ7XScE49t/RMo2ggVTe3up9KBukHYL6RplacQ7Q5?=
 =?iso-8859-1?Q?9wu7m4qGRKuJbgPA5A4qXsgaEibUiuv8CO2oxoSEjaaCQXgfO8QrhWHP9G?=
 =?iso-8859-1?Q?cw8MTf1k+TyEYYfGJidt0W25C/IbHxVeDivXIxuM39wlxoLUSJIYmvwE3F?=
 =?iso-8859-1?Q?i4AnS5YLSVbtmdcll20uHSteQ+5uUcru0/aJO7hOpOQ5//wyCfpCADlVsp?=
 =?iso-8859-1?Q?16pU7MYCVc110d+XLbsF0S2/2QwrywVP5KvdDVR4Zx0rqZRteqc3mS8XJA?=
 =?iso-8859-1?Q?f+6Ra0IHp/6Mj3wmrs8PnZcQ5jg9MXSyjIWalAsLu5PousuGZbd3xY6n3B?=
 =?iso-8859-1?Q?46WpYU+8/pH9BcNc5RD98yr7hVSYM9kef8okHTH+jTti50IbaefZZlsGmE?=
 =?iso-8859-1?Q?GLn2kmmSR/RBwqhUGJudxErfrle9dNBQ5mEHFiFAeUhLC//0GawYbIQ65G?=
 =?iso-8859-1?Q?MulS6eJrnH7Q7RnohZKWXPO0PTVn/5xVnXafOBnvvPYBRmz4F/94KkOrVE?=
 =?iso-8859-1?Q?k3pR51Wk5hUDGC04UdrdPbIazACXv2dgk4PzmnPvAa2utcpPoFfIR3gVaK?=
 =?iso-8859-1?Q?I3rUpO+x89vf4P2ADB/2t2xYKlbbknEzhvoR6Z4VstqkAxL6cvP4AFgjzv?=
 =?iso-8859-1?Q?OhGPU7nkUYEDRhjsk0GL+g9oMRYc8XwWEQRSqM5+HLmvDuK6gFRtEt7mu6?=
 =?iso-8859-1?Q?sHVN5SjiIZFDXwhpMr+bp0K4oDwxO/SO2Nt9emxPYW/6MAFmoURPOqDi6b?=
 =?iso-8859-1?Q?9FrPNfy7OgPFZ/iHou9oCduirBQNhHiWDCz9PvVINgEbmekQ9gmdffFUe5?=
 =?iso-8859-1?Q?5ma7vATW8zsC4IGv6n8IJlz+5JzDumGjXC06A5FIm7XXoUSCSpR4QaGv4Q?=
 =?iso-8859-1?Q?/v7AzoY0iUTJ+8vYWya/+LCPw7weuxzqz2caXux9GFvipLiKaXI/3aLgF/?=
 =?iso-8859-1?Q?VwZ5wjd3NESczmvgFhi8aKaBwC4s?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR21MB4779.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mVjPXv6EZac21Y3OBR/PmgyoSAeggOwcmelAoHjTGFgGLQv2B0+oQISnO8?=
 =?iso-8859-1?Q?sJBDNJMnnAfWsh0ZUFiMaWEv/J3Xu9UF8X9AVPlmSl7EvkuMTpCyHDi9yS?=
 =?iso-8859-1?Q?svNGkTSLYvvEXUWDtpS9RmDIig21rshpqsM+DVRCeEYFbqthK+n4uhYQF2?=
 =?iso-8859-1?Q?aQRkn67nWMq2W3lemcZVMsR2WssZrC1sV2OLP1kwgsnNj5UVFW/fmTHmLe?=
 =?iso-8859-1?Q?t92ONe1vhEUCIGZLbRrjoCxJrjRE7vY5GcWxUeG1tt2lfDWT6TmN9r4TxQ?=
 =?iso-8859-1?Q?hk5m4ZqhElg0TuOSYcf1/GYQwm/1ooLKDD+kJQhGHNRSvy+kGoIuK4DX12?=
 =?iso-8859-1?Q?Cp3z9PRsEbB8gy52IBiGIHhcFBoAfTnWK5SpWg1H0hD+e0ypVl5YVG3M/0?=
 =?iso-8859-1?Q?04p+ce2M0XPc4vNs6sNny1eXqFkekpvHgRsNEbjc0zAd+wOIxX97/O8tT4?=
 =?iso-8859-1?Q?vVhER4GG5yklx2JhjTQM+p3KHlH5RgFTiHE6EedXiZ/Lqx8esvEmMfY1La?=
 =?iso-8859-1?Q?iksXUZgTfG127b+UAQisDhw+I7XWyKsZ1xdfCYK2AaFMj5ghYidyohIMdK?=
 =?iso-8859-1?Q?Ec9jkuTn7vl6seAEz7U3zPz0DHqdl38xHy7/zbzhwXLrqLn0lGVqZHYi70?=
 =?iso-8859-1?Q?H3rKdBSmY1BPoZWyqBK/nhqWShTdTQowYc8gY/U98ihLoETZH2wx49zecl?=
 =?iso-8859-1?Q?EIPUnh2bzQEPv/aLh7Nim0h1w6KqkBDM0UCSqWnZbYoxn0WG/TW9o7NM2A?=
 =?iso-8859-1?Q?NDnehm9Iur6mhYkd0W0YGmuAMsKnGDQ7s1qsIPk0Y2K+5tyitTvTh6nYra?=
 =?iso-8859-1?Q?tNmcIfQkZd3vKsMEPImkQR8MgBiNtBkMyd5LCj8NoLqLflLhrBo3YOLr9B?=
 =?iso-8859-1?Q?G0qeovA6/n5194hl78i/eld4BUPvVDQscFcnYud9F9oWbcCLIH9AJJ8tlL?=
 =?iso-8859-1?Q?vSBh9S5htj6vKp0dIrdI0AIrQocMuZ6am5rHRRAuZbb7+MfDN7xbg7CSSW?=
 =?iso-8859-1?Q?Mq6/xaSGvguoBbMIZ5b31Lr7s4WsJNhnotl3N+m8I9h+8o/C8TodBGR6pa?=
 =?iso-8859-1?Q?J+lIBSD2EhxdgDizJ3pYy7Z5QyCpAZ5j5NJOYkmFQNT8Cd15x7qKFQwRaa?=
 =?iso-8859-1?Q?/IghOwxLpp0Qa00oAl1O5AOy6r9oz2TkzbO9OUCFDm31nxUgurhw9uId2+?=
 =?iso-8859-1?Q?8B/nXi7KWH+9YOMELfpKLE2goB2jE03R6grazy7ALvoZAVG04ac3JDVEhr?=
 =?iso-8859-1?Q?xEk/Gn/w0waIENcXOwzk6qnS9AahJpToKoQPLNdTtfUO5O6fHaRXbIVoK+?=
 =?iso-8859-1?Q?g9KIEeGSZV3fRDDEyBGb2+CkU+V+KCBIiTn1JkcFm0NgZBHqgJvywApAUN?=
 =?iso-8859-1?Q?nh7t9b4Wif35Ss0BqHa1DkmF2Rzx22G/BPjMEn+P/rXtKkgasnNj2Q0jU2?=
 =?iso-8859-1?Q?FKuNvNWXihPYpnnJj9EXwzySPXMWYnUNTO+yg36+C5OZC5PbVbkZOxwivy?=
 =?iso-8859-1?Q?jJ/Gq6vzE3q+FHKN4xsZiZtY0qapwec9R9qVxwvxXRH2EZjCOCKulxTMPM?=
 =?iso-8859-1?Q?7rGOOENxE6y/ym+hjrU9k+KOS3WoizQKXRJ37G6Qd61vGl8tqUMwsERMdr?=
 =?iso-8859-1?Q?fE/H1/yMBn6ugz2ne5IXIDpftTHfWrDBde3XK0+eqBfB2v+IpvU4xIwA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV5PR21MB4779.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5038fbbe-3774-4f21-c984-08de0b66f9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 21:16:44.2008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xB6uD/wvamvbD5YNbuW02QFwNq0jDBivZN8L+KIF7/arrkrQqU1zgbZ8tqpfGODGSuxR+JCIX4SanNwM4tBneg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB5448
Received-SPF: pass client-ip=40.93.194.133;
 envelope-from=Praveen.Paladugu@microsoft.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 14 Oct 2025 17:22:21 -0400
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

<div class=3D"elementToProof" style=3D"color: rgb(0, 0, 0);">Reviewed-by: P=
raveen K Paladugu &lt;prapal@microsoft.com&gt;</div><div class=3D"elementTo=
Proof" style=3D"color: rgb(0, 0, 0);"><br></div><div class=3D"elementToProo=
f" style=3D"color: rgb(0, 0, 0);">Regards,</div><div class=3D"elementToProo=
f" style=3D"color: rgb(0, 0, 0);">Praveen</div>=

