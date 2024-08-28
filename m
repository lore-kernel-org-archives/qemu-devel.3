Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40B1C5AE5A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 14:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjK6F-0002B9-1N; Wed, 28 Aug 2024 10:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbonham@nicmangroup.com>)
 id 1sjJ9F-0006iS-Ae
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:55:45 -0400
Received: from mail-dm6nam11on2102.outbound.protection.outlook.com
 ([40.107.223.102] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbonham@nicmangroup.com>)
 id 1sjJ9C-0003zY-9r
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:55:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtHcOrsL8WfX1VbRWpRrLbuSJI93qAxwSkE3Zxc1BcWDkYa0qV9J4GEi6CxXotGFCQOzRP+bT/B8aCWMiMhLswICFtFS91u6s0GfZNQHs0r6oHfhXrlZ5ZV9GMpG8vA6DGk6UMOHhFkH9AIL7COuS5E6E0NVySKuS/FgKFz6IReKwPGSSGv+jkbVTyq2xXeudSk3Ye2S39/5aBoHU9pC+eKskk6eZBS0GdE4FNt7+T6yAYzD6nDTcU9oFJaZDR82YO89KY0nC/bnWDr662Q2RSdhzn/BE5AENi9nfvny9UTTqsNxqSwJ8BprP0sz44TjYAS7hJ3jFyCq0i/lIdSw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnzhXjG5B+ZIdNrXG8hxIFizdmjCoPLtg4Mmfd1xf5w=;
 b=vP++m3EczM6LeffIR0EqA/vOzf5UV5SePvHU9RayiyIp3f7ggAg00zdtpO0cgJm1u4LvRNgJvDe2fEsrLXPqHHHVSLik1TxQHD7bJx0y0CeNWxYLcOoJCgBqWZYUQ5xd8O8RvtYivNBwK2jV/TxpVVa33IV766u+Lzt6K19tdMUK5xEZZzFTsVIx3nwcOH4VxtDXXs5Qpe1khTUm/XzIVUgkWTeRkhtvdupAk5/Ip9EtN2fXDBK7W+hFi1Y0l0Y4FXXUGFrX73ObWm270sxYS4e0kn9ZKrCXcoS1iEkNPyjafXgF8Mim6TAiABxJpNZTBkjhXzq7/52oNE4r4O2BYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nicmangroup.com; dmarc=pass action=none
 header.from=nicmangroup.com; dkim=pass header.d=nicmangroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nicmangroup.onmicrosoft.com; s=selector2-nicmangroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnzhXjG5B+ZIdNrXG8hxIFizdmjCoPLtg4Mmfd1xf5w=;
 b=lKkbYGhiWgNsapZN1RalSVty5LYPFD3ccgU83KDvDo7m928R4UXZ5OpQrORI79pgPjDzsRRcNllMoHjiLprIf0jDWMtUfbDE21KtEGTYyiYMYSpe+yg0cqEcHwiHAZMxLRW3yJHiPV/3gg2M0feNXIyy/iE86MQngyao6ef4oVM=
Received: from IA0PR17MB6394.namprd17.prod.outlook.com (2603:10b6:208:431::12)
 by LV3PR17MB7190.namprd17.prod.outlook.com (2603:10b6:408:199::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 13:50:34 +0000
Received: from IA0PR17MB6394.namprd17.prod.outlook.com
 ([fe80::5de9:b280:9583:1b5e]) by IA0PR17MB6394.namprd17.prod.outlook.com
 ([fe80::5de9:b280:9583:1b5e%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 13:50:34 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: qemu-system-hppa HP-UX 64 bit working?
Thread-Topic: qemu-system-hppa HP-UX 64 bit working?
Thread-Index: Adr5TamyeV2Y4iZwQleiIY/+4CoFTw==
Date: Wed, 28 Aug 2024 13:50:34 +0000
Message-ID: <IA0PR17MB6394A0C12D4FB7904DA116D2AF952@IA0PR17MB6394.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nicmangroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR17MB6394:EE_|LV3PR17MB7190:EE_
x-ms-office365-filtering-correlation-id: 3f596697-2bf4-4336-8d08-08dcc76863ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?r6AqMFb25f423jYhmMoA+cDPeIXOtsn32/nC3S3yYxwToNhPgwMK83YzHafu?=
 =?us-ascii?Q?0DXhEywcrWYFXgkOsxsLz/tmzG3Z6cvF08jI7CswXAE6VSrImUvW1P/qo45m?=
 =?us-ascii?Q?8i5emNJiKzyRCngyE7LcV9vPrKY30snJNjX6ndT8aZ0efeT58K507aoa1hA3?=
 =?us-ascii?Q?aN85jjPoRYDdBDEtCefRCSI0JPtNPc7z8wSrPjh2GYy4hYQ87lD2m2V3Mgwk?=
 =?us-ascii?Q?eMbB/Xfc61vrftcNZU9p7oqJt52T0UMTSridMMruJ9ron0vquWkptDoIQUtX?=
 =?us-ascii?Q?oJVfW1vG83/T9goeCQfl08qJ8R8WZGyq0BXBztEl8GnGWgRQKMgacQPUqR1F?=
 =?us-ascii?Q?Q1kvVONlzyIoZWitx4YXQWR8LDiwrzsW6DKtYBixu7RrMmyfbIDJp2/JXI7k?=
 =?us-ascii?Q?K+uHgYBeHUwrX1arAoG++ZcTlkNwY6Yx878oqpjuo2xDfUi5iyv48YG5YVzU?=
 =?us-ascii?Q?/yWTIqTJvxn8tUrLIvsVTo7hCseyNQnaeWhsf1ZhwJy3Ut/7tJ+GtkXZgEFM?=
 =?us-ascii?Q?NNHx3xbOlo5lxEU8jcLxDsVPgaK7pGG4lpWz6cMF/O7yImmxLBNeI60GLWEk?=
 =?us-ascii?Q?o7WsT1U9A62rJWd390QNs7DsL41sS41Qee5S3/C5vE+gbeC3RS0N0CYX8Idl?=
 =?us-ascii?Q?q7AJvU48bnfJnqtFiw73bJ0ymLgfsAuq/sOH9d9+6tGen0VV8OcfAolz5Gv1?=
 =?us-ascii?Q?c0uNICjrIdm7Qy6jCMrT0oFvexgOcQc9JWAHt2hwemrX0Et/+dTyR5++UXMq?=
 =?us-ascii?Q?hdToacZNugEBVgsN6VJJxBcOCEzKb3YujiQ07Hd59NboikNaiqBROMF4n7/v?=
 =?us-ascii?Q?coG5oI26/OCtfsbFs3FWs7aRx+zDwCE3TRRiOgIhFJf08F4UpEnshTuNBSXJ?=
 =?us-ascii?Q?1Y93Dddw+aqfvNoJDWzsxHoIM69Dh9QzIfJtAvNZwPUbN2y7O8hAd9RIoc+P?=
 =?us-ascii?Q?R9WuGT+SMHuMtu5AohJbwnEiaKlmWNp1AGxRvM3phIwC44wzsNWNmZNwexgv?=
 =?us-ascii?Q?IyUZhfzNKJKw38aO3FGJcJM2VD0qXb50iYyZs/8QnHt4I1GYkxybmfRYJodV?=
 =?us-ascii?Q?jGdfPuV6lrZ1vuHVPdEl9oDiA9heYVAjn8co2D06NOXphcspsvJ7HSV5QgPc?=
 =?us-ascii?Q?K0+DPxZ+84bqlCsse7+ALIls/bUXevdIvIXo8NH1lcS8RdTkmoyxgUZ1Ucou?=
 =?us-ascii?Q?fSgPzmuSim+2JKj/jg5M1Ik8NK31//JsentCLHYsbpMdlrD7UswdcewX5NPp?=
 =?us-ascii?Q?khNTIOHpEcJ0dI2rqg2o6Yy/EmCLnnn0bS94Y6+V78S7JupWLYBMaetv92cw?=
 =?us-ascii?Q?i6zq0vZ70u3R2QChhRLLewSEW+AckJZ+SLEAvYWYqx/jNA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR17MB6394.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xyGB9MTy/yrQ3GkxdlSktsL58vF6XM8EjXzxXy+GpIMow7KRJ+duF86FU5R5?=
 =?us-ascii?Q?guRFESqTPAHJYYQxY65ZoI+9eE1VT8eOf4BTI1VwPmmnE35w34cLuAVQYw1w?=
 =?us-ascii?Q?kd+XyTIZ2om10rood64TYnPWgGeIHY3sGEgImvktb7N17NJUEzZzTeC1Q4At?=
 =?us-ascii?Q?xw+p5irJz5oHVifqsRnKcc1AjeL2rtMQke/HgA0RHK0NhJy9bzbmUrj1njjV?=
 =?us-ascii?Q?fsQcBOKhO9YSA0CBHwFCnATNsuB/yjhab1Awmdj2nHf/wy1T9jBsupjLJNF2?=
 =?us-ascii?Q?P6d0VhRs0TbDKZgNO83R04cz9ZbxsPw61s+ScxXBw5woFisOKAPmYiGEFiEA?=
 =?us-ascii?Q?HSnLiIxXG2XudutuwpM6C8QWxzXjk3pDD8LmwDRL5Yz8hwFigwKCFRc+F3uz?=
 =?us-ascii?Q?V7xSo1Dq4hkmv7l7eQusjaavA7nTg8ONytdHE6iWfppr3zuOQrWT/hvCTOgq?=
 =?us-ascii?Q?tkKGvqDp/n2PVxp2ll3RIL++UpaR8O8VQmabbjYewjU2jmfxIeAloROBnfKo?=
 =?us-ascii?Q?xZ2wwO48H4GDVpvwl6NZwZA6sMkV6OcmgmVI0WiATfCVv6aypwSZiHkuuRfc?=
 =?us-ascii?Q?pCy/TC3TJWGc4Ujmucl44MHT0vDKKwowlsDUQ/yzftKGiDGznlVboCWMyXpS?=
 =?us-ascii?Q?WI5fFkLCC+KMLEwvFSZD9BosvKfsKw8o+mnF6/uyPa8PxmjkkfP+wj5BLkpS?=
 =?us-ascii?Q?dHYILcC5d1xGX+3bPRcjx0q/LCalRsn5/+g7j4uopJyDGauKmtAf7gcymJfX?=
 =?us-ascii?Q?FPg1dm0QzujkfHrTgmGYuxE3nf0NF8HWd9tTzf73cLZm+xZ4obL32Yox7pjr?=
 =?us-ascii?Q?TQeVKxN8L/31Sil/zalMRlqWtQKHsNWl0GvMoya4ehh+1wSZ4nW8RkijAAek?=
 =?us-ascii?Q?zQGhq8wl5WdehsPLWkU5XmRryAcM4n3ZRm6zUfNgHGnnsnARd+9+WmSUDmvz?=
 =?us-ascii?Q?rL6ZDlUVfc8vvyJ+iX2lj8lw62qa0H/3uZbC/FkMnxC1zBm8SmDvtZyYEQ+A?=
 =?us-ascii?Q?oreBIS3BW2GrRdpEvLC8O/jHuKO7c6Dt8Tv1qpl8YSVh+QFjAyRJWl+vjQos?=
 =?us-ascii?Q?XEYAgHmmzJyZ3pSvqHvI8rB+SQfZrx+GXCh+32dO8gUKx4me5bTRagPh1kU3?=
 =?us-ascii?Q?m89TsVwUExdPlja4OVIWywC2rCm2Rb8GGS4TEM2KhG8jSfm6vhO6CTphwGhW?=
 =?us-ascii?Q?Xedf8THMbs/P0p3EyszHDrIEh4tPrL/hjFHKJBp5g33JTczNse7fOupfqDET?=
 =?us-ascii?Q?+b77Lr3jKzYRLuUUXhkujbD3QUmZkI5BIPOWe44xrJjKTLg9p+QXpo4L+30s?=
 =?us-ascii?Q?tCK2tPyq+uoclWX4B+CQjsWG6qSuR/U5gFjD8G5yZs6h0pNmBJ6iwybwD+wS?=
 =?us-ascii?Q?Q++g3gYb3ks2j0q8wl9Z9Yaw8td27aVuoCYlzG6fy1ow1RgSS8Nx6JqQCjey?=
 =?us-ascii?Q?8rKruGo/eBfegjdwbR8P8CIYlpC6xhI0T7F1Iy265unwoqCwpoz4dGPbQtlO?=
 =?us-ascii?Q?Orgyez4fAVXI0c0QZP7F5mb+0ZGeGgsBLyjDNhuy4NwATmJfUd1PsrdxHrMj?=
 =?us-ascii?Q?+1n2slIiPEoG+f5/2yzJG6UJxsjNRZNoL1vOpz4T?=
Content-Type: multipart/alternative;
 boundary="_000_IA0PR17MB6394A0C12D4FB7904DA116D2AF952IA0PR17MB6394namp_"
MIME-Version: 1.0
X-OriginatorOrg: nicmangroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6394.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f596697-2bf4-4336-8d08-08dcc76863ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 13:50:34.6202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e171ef-379d-491c-b8b0-d4befbee7c6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjjYGbZRFwLwlfNoPUv9n22g1mUoWU4SS9DESreOqLeJuQnJ4OCF0ERI+FSKxg77j3SEUxLJVM4U4TVnAF+ngA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR17MB7190
Received-SPF: pass client-ip=40.107.223.102;
 envelope-from=dbonham@nicmangroup.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 Aug 2024 10:56:41 -0400
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
Reply-to:  David Bonham <dbonham@nicmangroup.com>
From:  David Bonham via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_IA0PR17MB6394A0C12D4FB7904DA116D2AF952IA0PR17MB6394namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Documented here:
https://github.com/hdeller/qemu-hppa/issues/2

I'm unable to get the master version of qemu-system-hppa 9.0.5 which was co=
mpiled from source to boot the HP-UX 11.23 or 11.31 install disk.  But HP-U=
X 11.11 install starts, but does a panic:

again using -machine C3700, using an 11.11 CD, it will at least load the IN=
STALL file, but does a Kernel panic:

SOFT Booted.

ISL Revision A.00.43 Apr 12, 2000

ISL booting hpux (;0):INSTALL

Boot
: disk(10/0/0/0.2.0.0.0.0.0;0):INSTALL
9793660 + 1126400 + 702592 start 0x152868

Stored message buffer up to panic:

System Panic:

linkstamp: Wed Aug 17 15:13:25 MDT 2005
_release_version: @(#) $Revision: vmunix: vw: -proj selectors: CUPI80_BL200=
0_1108 -c 'Vw for CUPI80_BL2000_1108 build' -- cupi80_bl2000_1108 'CUPI80_B=
L2000_1108' Wed Nov 8 19:05:38 PST 2000 $
panic: set_machine_parameters_32: Unidentified cpu type returned from PDC_M=
ODEL

PC-Offset Stack Trace (read across, top of stack is 1st):
0x0015f43c 0x001ab404 0x001ab938 0x003d4e50 0x00156f68 0x00152ae0
End Of Stack



David Bonham - IT Consultant | dbonham@nicmangroup.com<mailto:dbonham@nicma=
ngroup.com>
m: 850.830.6428 | f: 303.500.0655
NICMAN GROUP | 304 Inverness Way - South TL-25| Englewood, CO 80112 |  www.=
nicmangroup.com<http://www.nicmangroup.com/> and www.hpuxhosting.com<http:/=
/www.hpuxhosting.com/>
---------------------------------------------------------------------------=
-------
This email and any files transmitted with it are confidential and intended =
solely for the use of the individual or entity to whom they are addressed. =
If you have received this email in error please notify the system manager

 #SaveSoil https://savesoil.com


--_000_IA0PR17MB6394A0C12D4FB7904DA116D2AF952IA0PR17MB6394namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p style=3D"margin-top:0in;background:#0D1117">Documented here:<br>
https://github.com/hdeller/qemu-hppa/issues/2<br>
<br>
I&#8217;m unable to get the master version of qemu-system-hppa 9.0.5 which =
was compiled from source to boot the HP-UX 11.23 or 11.31 install disk.&nbs=
p; But HP-UX 11.11 install starts, but does a panic:<br>
<br>
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#E6EDF3">again using -machine C3700, using an 11.11 CD, it will at l=
east load the INSTALL file, but does a Kernel panic:<o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:#0D1117;box-sizing: border-box;margin=
-bottom:var(--base-size-16);font-variant-ligatures: normal;font-variant-cap=
s: normal;orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-width: =
0px;text-decoration-thickness: initial;text-decoration-style: initial;text-=
decoration-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#E6EDF3">SOFT Booted.<o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:#0D1117;box-sizing: border-box;margin=
-bottom:var(--base-size-16);font-variant-ligatures: normal;font-variant-cap=
s: normal;orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-width: =
0px;text-decoration-thickness: initial;text-decoration-style: initial;text-=
decoration-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#E6EDF3">ISL Revision A.00.43 Apr 12, 2000<o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:#0D1117;box-sizing: border-box;margin=
-bottom:var(--base-size-16);font-variant-ligatures: normal;font-variant-cap=
s: normal;orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-width: =
0px;text-decoration-thickness: initial;text-decoration-style: initial;text-=
decoration-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#E6EDF3">ISL booting hpux (;0):INSTALL<o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:#0D1117;box-sizing: border-box;margin=
-bottom:var(--base-size-16);font-variant-ligatures: normal;font-variant-cap=
s: normal;orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-width: =
0px;text-decoration-thickness: initial;text-decoration-style: initial;text-=
decoration-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#E6EDF3">Boot<br>
: disk(10/0/0/0.2.0.0.0.0.0;0):INSTALL<br>
9793660 + 1126400 + 702592 start 0x152868<o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:#0D1117;box-sizing: border-box;margin=
-bottom:var(--base-size-16);font-variant-ligatures: normal;font-variant-cap=
s: normal;orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-width: =
0px;text-decoration-thickness: initial;text-decoration-style: initial;text-=
decoration-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#E6EDF3">Stored message buffer up to panic:<o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:#0D1117;box-sizing: border-box;margin=
-bottom:var(--base-size-16);font-variant-ligatures: normal;font-variant-cap=
s: normal;orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-width: =
0px;text-decoration-thickness: initial;text-decoration-style: initial;text-=
decoration-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#E6EDF3">System Panic:<o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:#0D1117;box-sizing: border-box;margin=
-bottom:var(--base-size-16);font-variant-ligatures: normal;font-variant-cap=
s: normal;orphans: 2;text-align:start;widows: 2;-webkit-text-stroke-width: =
0px;text-decoration-thickness: initial;text-decoration-style: initial;text-=
decoration-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#E6EDF3">linkstamp: Wed Aug 17 15:13:25 MDT 2005<br>
_release_version: @(#) $Revision: vmunix: vw: -proj selectors: CUPI80_BL200=
0_1108 -c 'Vw for CUPI80_BL2000_1108 build' -- cupi80_bl2000_1108 'CUPI80_B=
L2000_1108' Wed Nov 8 19:05:38 PST 2000 $<br>
panic: set_machine_parameters_32: Unidentified cpu type returned from PDC_M=
ODEL<o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:#0D1117;box-sizing: border-box;font-v=
ariant-ligatures: normal;font-variant-caps: normal;orphans: 2;text-align:st=
art;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-thickness: ini=
tial;text-decoration-style: initial;text-decoration-color: initial;word-spa=
cing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#E6EDF3">PC-Offset Stack Trace (read across, top of stack is 1st):<b=
r>
0x0015f43c 0x001ab404 0x001ab938 0x003d4e50 0x00156f68 0x00152ae0<br>
End Of Stack<o:p></o:p></span></p>
<p class=3D"MsoNormal"><br>
<br>
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><b><span style=3D"font-si=
ze:10.0pt;color:#1F497D">David Bonham&nbsp;</span></b><span style=3D"font-s=
ize:10.0pt;color:#1F497D">&#8211;&nbsp;<i>IT Consultant</i>&nbsp;|&nbsp;</s=
pan><u><span style=3D"font-size:10.0pt;color:#0563C1"><a href=3D"mailto:dbo=
nham@nicmangroup.com" target=3D"_blank"><span style=3D"color:blue">dbonham@=
nicmangroup.com</span></a></span></u><span style=3D"font-size:12.0pt;font-f=
amily:&quot;Times New Roman&quot;,serif;color:#201F1E"><o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"background:white"><b><span style=3D"font-si=
ze:10.0pt;color:#4D1107">m:</span></b><span style=3D"font-size:10.0pt;color=
:#4D1107">&nbsp;</span><span style=3D"font-size:10.0pt;color:#1F497D">850.8=
30.6428 |<b>&nbsp;</b></span><b><span style=3D"font-size:10.0pt;color:#4D11=
07">f:</span></b><i><span style=3D"font-size:10.0pt;color:#4D1107">&nbsp;</=
span></i><span style=3D"font-size:10.0pt;color:#1F497D">303.500.0655</span>=
<span style=3D"font-size:12.0pt;font-family:&quot;Times New Roman&quot;,ser=
if;color:#201F1E"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.0pt;color:gray">NICMAN GROUP&nbsp;|&nbsp;<span style=3D"border:none wind=
owtext 1.0pt;padding:0in">304 Inverness Way - South TL-25</span>|&nbsp;Engl=
ewood, CO 80112 |&nbsp;&nbsp;</span><span style=3D"font-size:10.0pt;color:#=
1F497D"><a href=3D"http://www.nicmangroup.com/" target=3D"_blank"><span sty=
le=3D"color:blue">www.nicmangroup.com</span></a>&nbsp;and&nbsp;<a href=3D"h=
ttp://www.hpuxhosting.com/" target=3D"_blank"><span style=3D"color:blue">ww=
w.hpuxhosting.com</span></a></span><span style=3D"font-size:12.0pt;font-fam=
ily:&quot;Times New Roman&quot;,serif;color:#201F1E"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#1F4=
97D">----------------------------------------------------------------------=
------------<br>
</span><span style=3D"font-size:8.0pt;color:#1F497D">This email and any fil=
es transmitted with it are confidential and intended solely for the use of =
the individual or entity to whom they are addressed. If you have received t=
his email in error please notify the
 system manager</span><span style=3D"font-size:12.0pt;font-family:&quot;Tim=
es New Roman&quot;,serif;color:#201F1E"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;font-family:&quot;Times New Roman&quot;,serif;color:#201F1E"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#1F4=
97D">&nbsp;#SaveSoil
<a href=3D"https://savesoil.com"><span style=3D"color:blue">https://savesoi=
l.com</span></a></span><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,serif;color:#201F1E"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_IA0PR17MB6394A0C12D4FB7904DA116D2AF952IA0PR17MB6394namp_--

