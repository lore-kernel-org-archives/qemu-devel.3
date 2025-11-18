Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC57CEBF93
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXq-0008HP-0g; Tue, 18 Nov 2025 03:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXn-0008FF-QT; Tue, 18 Nov 2025 03:58:35 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXm-0003Vy-Ft; Tue, 18 Nov 2025 03:58:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyJFL0zObBRx9Esjr9zS3LkNybyuOuQ5XsJ+nKyADIqtpcL14Wy91txNsF9qrTQkf9zaIp2K/sqyfHDX6WTwJm+177mCdswjqxoOgjN5rypBZxb7k6aL4KWZK5x8qPwT115W74lydwtDOyIjxoKBmbCOqB23+t9pJTdraHKYlTSb3WZEtQcy1firxol+0FKKgg854wSrghmuE/C9JXkywI94xvpK1nCddqQHzBkcDUqjj+Hf1Ebap7NXgiKc7tWbJSIHgw4wbVRgF7CkfIWCTTkN0ywWZJE3Cm3lmuG60n2alyU+054uCC5c40nUMTa4gdmQA1ygP6OdhkQo0kBm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gruHK7RxKmfg55lNGlHomrjer4BXCPlWKs6DcT36GM=;
 b=lhwlXgiRAFKvradr8M/odpMM7c1+oglmQ3zUul0Y5lhV70s7PklGidyMWi+5Jhxa/7jisPjRkOEC9BxUwqrM3u7uB+AvUZjg1u6F2JXSgPsiLG7aZjawrR2xy4VvINEB0r97EJYzVn9qL80Q80dG347woLlGmOZ5wfioEQiMi1qF0G5OryDxOr5MksWNf17jsmHFUkkAWCORYqdJSIWJCbF6WuzGnamda1hb16Un2Msd6cn1Oq2M4d7O5bcbuaNWUEahUo9102cvbMBiS6pW0QxeolJVlEZz5nXx/RTVioes6Ewq6cEKazOTYQpHTXGFuY8v1yPjDuY0LwLUKsS7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gruHK7RxKmfg55lNGlHomrjer4BXCPlWKs6DcT36GM=;
 b=qTUuoc2PlBEOyCJaNbSeJ8DLok8St+PzflwCIXc5odG7V581yRIUqx+ycMfUs2qgIKapaH+QyM25uedUvF81G/FvyITVqBJ8lnCwC4xj+RH09PlKGRQDoONjkNz5cgfwFfbZ27TRXbeDY59w/hSKIQgPCSTyIa4yMiqTblCazn2+MigxNJOj6z/FSUX5wwyMS8VgtD1TQtniBxbQpahZjh0Oy/VNeYesrw+2fnJpA9Daz0YR62zcIE/fn4T6W0ZQS6LSRqSCV5l3XVxeanAUwxOD/XwOd/YKfIdgLhK5SmZypMhNhIaYvAmLahlkBuHC9/0tYCXiH3LwN+UBYFCU1Q==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:12 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:12 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v14 14/14] scripts/checkpatch: Check DEVICE_NATIVE_ENDIAN
Thread-Topic: [PATCH v14 14/14] scripts/checkpatch: Check DEVICE_NATIVE_ENDIAN
Thread-Index: AQHcWGl3NXoEITttQUixapPSWkYd4A==
Date: Tue, 18 Nov 2025 08:58:11 +0000
Message-ID: <20251118085758.3996513-15-djordje.todorovic@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|DB8PR09MB3612:EE_
x-ms-office365-filtering-correlation-id: 2942f7ea-1171-4e24-ed91-08de26809adb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?w+VGzvbUMVj5wRzyPetTg994QJ+Ur6GxS/cD5JE5KDSO7lgK5gRme3A7MM?=
 =?iso-8859-1?Q?yMCC03xwqQIR4a2jTHjzX7GfSx2CSa+YXSk5wO5YQUg5LftYnfspG9TXk2?=
 =?iso-8859-1?Q?F6rHUpLtL4dF9BhUKJCsD+ZkpWLZ34k2vROju0Uu9oVNAk6FJ/uJ0mfUuv?=
 =?iso-8859-1?Q?IvsKiqNDflsqR/VyPE/xNkyxLS1tBpxmXyXfbNHQ+1idBTOSqMwYq8W8qG?=
 =?iso-8859-1?Q?a893Pq2HSRsvqh50FxJcAfON1iQ9qK8v5DU8Q5Qo2q8pa3awYFaTXdZNIA?=
 =?iso-8859-1?Q?J8rZesVdG60RxSUWHZ4QqrSSY0R7tJ2Iav7z4C+Br9PezT8qSCsb9B0Jgv?=
 =?iso-8859-1?Q?VVWVkCzGWItFrKDW5XK0G+WHphctmYh1Z+4Ud2WgvHA+E4qHQU/ntTMyyc?=
 =?iso-8859-1?Q?ZHrV20GDSm28+/bdI9e7qsIAYsN6Ef/1cx859PygkerutDl32JeDbZIwsR?=
 =?iso-8859-1?Q?4FiV46+F6IbLkNPZbOho6kn/G4PBU8MIHRn8uLKwq8l1uICpjY7Iaa2XeT?=
 =?iso-8859-1?Q?/t21LeuSk6Z/ILtSU/ngIc2HjiwajHz5WRyFYdc/zx0pKgsUcaji7FiBk5?=
 =?iso-8859-1?Q?8WpMl1Pow+NS3qsPoYQkr03esLtV0XmaVV7gI7ZMc0/RB8QgnfKuF2NGzB?=
 =?iso-8859-1?Q?yC/yoFV6HSwayo5UnLmFX0Q6vnblAG6szvlVnPTJW0QMhDpB20EsC2phTs?=
 =?iso-8859-1?Q?UnTpEYgE50BPmcFGj81gDtVC/1kRyUn0nzOFLZUzXfpEqwvaizYwtoUyCk?=
 =?iso-8859-1?Q?rp9WEtmoKq4FhfP5hPNx68RsRS9uo8/Mtlou8nSaHD62X6EGKee5V9ZsDV?=
 =?iso-8859-1?Q?cDKmtlC+GAqFvkTTfWm4KDIDblymlNKgyJDISQ8HBcP+oOOmn5lwMxMwmi?=
 =?iso-8859-1?Q?9gJ332onGy16vH9LQ/W3BgSMs7Mj7Iu9DAijg3y6ouRfwU0EZa5tsjco0s?=
 =?iso-8859-1?Q?wFxbgcYMbBFj3kHEjox5oGKlfFuo1y5C7AX6P/GkUbEwx4jTE7S/VQReX9?=
 =?iso-8859-1?Q?Vp+WFR2qAbg3i3c5E0DlINktP0PTlAo6uHugZ3eif3/5ayOZ1rYtGGPTom?=
 =?iso-8859-1?Q?Q3eDjwSYxY/HyjMPLTRWbfLVwo0bvMhNYXJ+KGVXMGtKhQnI6RDqcSxxsz?=
 =?iso-8859-1?Q?jzO4YuYDYIWny9G7/w2JJoHNgxi0kN6E99hS/GizeWJUPVW/AmfWYUyqE6?=
 =?iso-8859-1?Q?rsodjV/LE0NjPccrU5MTu2hhIXUH7SZXKADmJoQ/NENDPqgkn6ga25MKdW?=
 =?iso-8859-1?Q?YodMJSg6vWpgFhiuIokIIk0UO+FqUPlc3uAFJ8NC0mDG2scm3mnxxHdNhb?=
 =?iso-8859-1?Q?4i4ETcbhpI0pS1q79y5dNv1lIJjmO7bjX+YDTfuXGZNndA2wX5eCCrXBYj?=
 =?iso-8859-1?Q?Gt3kXg2miCt0Ptufc3gdWZMH9EPW0TrxoQxIt9I5UGFdwXwCjD/WoSf/+B?=
 =?iso-8859-1?Q?DLF8VLIXmzfjVTiqj543WoViqDI/5aEwnw+JuitNxhlpbWp7fG6S40Z2lO?=
 =?iso-8859-1?Q?FKz3rHR1cYQnUDEKbb2msM3lJRsVvFxLxfJSH2a7o2B9YRe+LwH9qBFtKJ?=
 =?iso-8859-1?Q?oogsPh3ouVFpND/iTi1mV1vsJal2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jca+wb+tauA/Oo/4a7NlfmlyT+YZwSbUplNTyOuswrdaQi13JKPAc1A1uv?=
 =?iso-8859-1?Q?rOAxSyCLpkuH2rY5XvkCE11bC2Lz4ypL0C74NVXJ5fxPNPFXFJC3m8pf3d?=
 =?iso-8859-1?Q?cyqvOy88pCVbNht+0AVh6yPzd8QXcXVgQowzAw1Ylcuy96tr1dVdde9ogc?=
 =?iso-8859-1?Q?GIh7HGS6D0Ha4sjLoZWlPUKR5t3UU+PEN4P+zIyAdkgBgGqUAv2d9TmV2g?=
 =?iso-8859-1?Q?YsR8zG+GTll8SDse17dRY4tywjBFvkhdma7k0PYGx4JSSgXgCUdms+Ia1Z?=
 =?iso-8859-1?Q?HIiZ0la4GacwyXtm4sjUS9sJKZl0bLVrDLdmkjiRID0Qyid9B/h4coT7IX?=
 =?iso-8859-1?Q?dVi5brk4YsaudFigGKjg/g2yksWsCVVjNl4tPVjV4gezLlujJcwR7cwK2P?=
 =?iso-8859-1?Q?HJ5JYpnn+hOcl+0/O8yct3sEwxBhQmG4Te/QP+LAI9QU1DA+d9g8XCjGSB?=
 =?iso-8859-1?Q?GSgwgBD4LvRqGhOZ8szRYAUrKwZTTIqXCKJfcQv5iXtAP+yIReoEvx0dos?=
 =?iso-8859-1?Q?LS6wqkPrxrdQLW6XGKUfJmdGMD7hdbB/e4F5S/Z1O8dheeUPdvzp5sz8dT?=
 =?iso-8859-1?Q?/DWl12wZryEzAGmNS/FMDqg3nMnOc3WViLydKs+XFtNycyNrY0hapQGnPs?=
 =?iso-8859-1?Q?3gWQQpvTx6TsSS4VNU9vCBsEyJVdAY8uVYbi84Eu1qkkH3vm1FPM9mjCTT?=
 =?iso-8859-1?Q?4PNnwJc3KhbWG0usI3Qad+VSYpW/D51hvvlTFxq9RFEtc4ovbJN2lE7iOC?=
 =?iso-8859-1?Q?aBDwsh5GZwvpCKUMzvK126JxzzJEHfAE/IwbgPyumU5CGWNPBGd6DT1TD9?=
 =?iso-8859-1?Q?9mm4W0Xxg65v/pRFYxG6hEV+FsYT21Hz/VBJeuaF7papUabToJteeefvwC?=
 =?iso-8859-1?Q?SFV8iZldQCABfbbJvusA/YuDzglze3zD5LFMgOyW9E6F5q8B/teZOdMatB?=
 =?iso-8859-1?Q?yGA81uycX2pzeRYQ6NN8LpO4Xp2mVSGhsxLZtUFh+dvxoWUAPGcSVzEeTk?=
 =?iso-8859-1?Q?rtUUtQGv3wjFmn4tsQDpac6/xq6sywhW2jFv81KJ+reovThbjXQbiw++5d?=
 =?iso-8859-1?Q?u6pB81kX/zLnBtpGqH8uNZpBLq1HZ4SDJz8pIpvYYXTGIILEaTNhc9wp2z?=
 =?iso-8859-1?Q?ngGMJbygoTHfaOxysy4MbzuGwkw9BrAVHLDh/M4xDswPJUO3tVskT4lEhr?=
 =?iso-8859-1?Q?JnZgtHc5Sk/5FscSL9Q/+BUHSVVVLCS0M/dqVsdbVyV/ia5tBzzfUyDG25?=
 =?iso-8859-1?Q?AW+YMVqwzbkD74H0iTvfnjlk6+BfKe7UasngDegcbzJwQ7tq3WpyarfU8K?=
 =?iso-8859-1?Q?UJwxGyaxBFNkkM0zy6b14AXOkyynxZbu7jGMahP1KKaXAYBedRQywN0aSx?=
 =?iso-8859-1?Q?14nbZXzaslCZy1ZFLTf1cq2D2D6NhsNEWkJCoVwefrAta2SNacGOIxNWfS?=
 =?iso-8859-1?Q?Gq7hcAPxeDmj47fE8SjK5JZdzr06Eo8o6xjFMcOnEbtu7IWC35Klp35VVf?=
 =?iso-8859-1?Q?f6Iny8BtmRtQdckHVfT/jJgYMfoF3A/YJjZ0NCTvhJ5tWqW8+WgiHZSGd8?=
 =?iso-8859-1?Q?qUSAWle1F9+xl5Gigq0Bo8dMnIz5Zw9S4uZzkJ2YD1PH2pSzCBq8xCUNxW?=
 =?iso-8859-1?Q?S2r6AOovSWJCuTPd1SuJXQMCnZKNfQSrvpDKz6J2YA7S+uHjwUQArjsu2B?=
 =?iso-8859-1?Q?iNZkWif1PvWeGWFSIT0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2942f7ea-1171-4e24-ed91-08de26809adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:11.1327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkTBueLZcZG261Vh1egsZFXW5Q9KatWktn99jVkuQlEDtf4emp5fQjP0Y+e7ltZCcMZRAPkG5WhdKc6HKI3eJseoNI434o9EsDFUgYd4X+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

Developers should specify endianess explicitly.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 40b6955c69..dc88fa4da4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3206,6 +3206,10 @@ sub process {
         if ($realfile =3D~ /.*\/hw\/.*/ && $line =3D~ /\baio_bh_new\s*\(/)=
 {
 			ERROR("use aio_bh_new_guarded() instead of aio_bh_new() to avoid reentr=
ancy problems\n" . $herecurr);
 		}
+# check for DEVICE_NATIVE_ENDIAN, use explicit endianness instead
+		if ($line =3D~ /\bDEVICE_NATIVE_ENDIAN\b/) {
+			ERROR("DEVICE_NATIVE_ENDIAN is not allowed, use DEVICE_LITTLE_ENDIAN or=
 DEVICE_BIG_ENDIAN instead\n" . $herecurr);
+		}
 # check for module_init(), use category-specific init macros explicitly pl=
ease
 		if ($line =3D~ /^module_init\s*\(/) {
 			ERROR("please use block_init(), type_init() etc. instead of module_init=
()\n" . $herecurr);
--=20
2.34.1

