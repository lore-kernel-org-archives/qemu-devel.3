Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0287C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 05:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZlCF-0007CL-T3; Tue, 13 Feb 2024 00:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbhagavatula@lynx.com>)
 id 1rZdm9-00070L-1X
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 16:23:41 -0500
Received: from mail-mw2nam04on2097.outbound.protection.outlook.com
 ([40.107.101.97] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbhagavatula@lynx.com>)
 id 1rZdm7-0000jD-1s
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 16:23:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDInocr3NEYyF3wtOBVr4y/Y7AuXBw/wNuAYXA8vPyYF8D41MAWGQfooVE3Pxls38h6f4wIx67VRPhoONIn3XJmAoZ6IVWUPxq4oRPAlcTEanZEonXoDB4BxjPl1yTnkYM0DD9cck9ILKRFZobfpUxJGYGi3ZB5LQfFldyhr0ovV+HjialjLi/0G9TsZCQop0vEjFP49gt5BqlKj9kuki2bqMpgoNL9RW7dSNH4Sql+NpCEQdkZF2lZa1mFMN9wv75sW+3AZRxpXV8nePJx75PedhtTr01TjJeIfTt0mKzQu7CunBw4N0mKpbx0x5rqtdU8BO8su9OM78FmP1Yzp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3vyQa3UwSzDRPKlTs9k6sMZ1SYWDCGyxI6VnbTxCjY=;
 b=cKaS28sOCMNAZgatInuyvrshrjEz8llw+ickkROcyC2ZGOdatkPrb/7Jj12YBlpY3Q+f3+ZK3Oa35U975QHqlkuSfWFSLQH6zS6UYlbU3ZCo48d8V0kUIDxml3x5Sejv6jYdrP1CkwEtXc42b10pjH/Sp3imSoHaHWiPBhS/u2UVt213b+y8saGPbr7qTTxPUgB0JRWyF8c7C79xu8kHfMTp98a2x7cZV3S84beuAD6+4x4ptdmMl/mbDgzO4Bh8MEUwOOrzECTUrQ81vyf8d7ne2pKShbifxxmRmBgpPZWSOMv30tO23pdorXh5NVXX/zTBMlpznzf65hiEKX9WjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lynx.com; dmarc=pass action=none header.from=lynx.com;
 dkim=pass header.d=lynx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lynxsoftwaretechnologiesfor.onmicrosoft.com;
 s=selector1-lynxsoftwaretechnologiesfor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3vyQa3UwSzDRPKlTs9k6sMZ1SYWDCGyxI6VnbTxCjY=;
 b=VVJF2zlKGO6ClkV+VlY8kwPbAb/kXmwDTkHyMrVamlm7MnDhT1AVFTRAHj0eYBi+7Ir0n1BXL0RLVNj3qquDql1Ma9UyLGEN37F0Fd7LWyWNomxvtGbM7HhqjdPqoUQA0x+WgsSv/kSrVALg9g3NCfQMDogQnD5TwLstdWdmt4s=
Received: from MW4PR17MB4826.namprd17.prod.outlook.com (2603:10b6:303:10b::5)
 by SA1PR17MB4657.namprd17.prod.outlook.com (2603:10b6:806:194::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 21:18:31 +0000
Received: from MW4PR17MB4826.namprd17.prod.outlook.com
 ([fe80::5821:ec8b:faae:4ce7]) by MW4PR17MB4826.namprd17.prod.outlook.com
 ([fe80::5821:ec8b:faae:4ce7%6]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 21:18:31 +0000
From: Ravi Bhagavatula <rbhagavatula@lynx.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Nathan Field <nfield@lynx.com>, Arun Subbarao <asubbarao@lynx.com>
Subject: Single step (gdb) issue on QEMU without KVM
Thread-Topic: Single step (gdb) issue on QEMU without KVM
Thread-Index: Adpd+Qbau03pAonPTDGD9uHRdYh4Ng==
Date: Mon, 12 Feb 2024 21:18:31 +0000
Message-ID: <MW4PR17MB4826CF1B7A7893F92C320331B2482@MW4PR17MB4826.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lynx.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR17MB4826:EE_|SA1PR17MB4657:EE_
x-ms-office365-filtering-correlation-id: 6520e794-ccc0-4149-5c70-08dc2c1029fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uapAnxXcP+xmyiNPBy1vrJr4G5FXJA7+fFIl7p7O4kf5tCdzkRDkOb19lcVFcke4NRMN6KefVzNtg97vxtWMHFr3RgQOaNBfBVUKoYh+ApdmmYbOTxpzeGCoiUmWiW8/TXdyCdpc9GgIPqhWaSRMfJ5tItKFeePpviLZXqWGDCYhPTd6v+DxmAUijjIcuG8oT49FrTGd4tJrydolo1rFzxXdfnJAMmqxwLTWBKZ1ZBNEd9HIOcNEZDlWpImkAAIF4TrG1J+9n2dTiAUzyO/r/9DJt71qUVKA2vzXZ2qt5pgbdwwghxSAVQgHpjwRfSLnM+vsSvgj/yWuv0MvAeDbylg52cUslDy4v9K+z1qkGC3/idxEalIbJeV2fPecvq+U4rvq9w7ga5t3Shrc29PCxfoht4NLwWMLiMzVNLge4RPZD27+EMFjav7hAKHAyNmPqZpT9Vsg6z0c17QA/ucksITAlbaqIgNFrA4qREpHyao7q55U2v7Zg3uCsTIgrc5IjN923OVrOYvGtOZrBPRcgTuJWg4nax0yh4Ak+2uOjeFJNMdbkHGzN3RyCJFYC089gqrr36DmOvmS3BJIkAwF8G10RMSEgdXRDSaQioNJX4s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR17MB4826.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39840400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38070700009)(26005)(41300700001)(107886003)(8936002)(4326008)(83380400001)(9326002)(8676002)(6916009)(66946007)(66446008)(66476007)(71200400001)(478600001)(64756008)(76116006)(6506007)(66556008)(316002)(54906003)(52536014)(122000001)(86362001)(33656002)(166002)(38100700002)(9686003)(7696005)(55016003)(21615005)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n75Q+nA1aVULAOZWWYzCj2JZZaQWAeBZdEUw0gcH6SpuJGzdYd26vP6ZE8KA?=
 =?us-ascii?Q?aVGSSg2zwQr25Sek4nRnovA9u4wkfGcaC9iVyvRjLkU48xl2N1NxVfPmqtZG?=
 =?us-ascii?Q?5zA9AIFpWMaseiWVju3NM+zcYxbG6aebUtV2+rsTznRKhkzUcY5yyLJLviHr?=
 =?us-ascii?Q?H18qH3++tM4dfoEv5iwfPRa/cqPXWcQy6wypnDArTgig18cTsjQKiOPGJHcQ?=
 =?us-ascii?Q?Fo7A+m7Hfo89AVoZSXLKYdRjDI88GfFnASKVQw9J0tEXFCWHxyanuR5VMoeg?=
 =?us-ascii?Q?k5lthcn9cXn7WiNzj56ndaR2SWY4Q04NToxchKP97Cp08PfbAp5fKsZjT+Cz?=
 =?us-ascii?Q?zqKNuh7VuaLV2URRLw8xA2Xl32kDGn7Z817b25/tYIbjIMzpbSWx6uIOpaGg?=
 =?us-ascii?Q?6dVEfn4+Mm1AckHaigCb5GEdHE/yQoZYG9XCGLYoRL898XFjrhu1Rhlo3uQ+?=
 =?us-ascii?Q?S3ACwS6k2aYMKtieRTh2ovZ3wOgK61P7FQKlb3AmvmPrxopgQTlTr7SZKhgV?=
 =?us-ascii?Q?Y9HT2A+DRQ8wQMh0LlXGRxuyLHCd5v5w2hB4P6KBkAK7ZlINFl5LYA2RVXU/?=
 =?us-ascii?Q?Y1DWBjbg+uQa8OmsZc/7q2usSanNSYo0IIPBB5+m+YiHQcyIn0GcgeNK4UOT?=
 =?us-ascii?Q?XPPcNbq5QEOjzWow9IESfiU64M4j0Hv3ezjD12nkyvSHOU6gAvxxgabDS0yM?=
 =?us-ascii?Q?3hGB9lewSyNoY5SLqJ0AkcHKm7a0OM9BezXl5wEXYK9oLbkt2g+08tVeU2rH?=
 =?us-ascii?Q?78bYlrMWENTzieraxCyGSUcp3zlg3AE/a8NRuh5sRrpvpAcyUx4vDOoZd7E8?=
 =?us-ascii?Q?sV7gwPqlqzEvCcbjbbF4VVCWkij3MCPHbEWEeM5oBttpbFIKLZhoDY8ClPI0?=
 =?us-ascii?Q?ti4NUHBTVU1RKYrmaPbY6jswP2h0NBnHj2F2+eVatfTL2U62ZqSdlVoQjrbA?=
 =?us-ascii?Q?oBDdRGU4CWlgvTXi3GjiehKd0aXZwD5gWEHi9ulEVvXtA4CYqblzFPX8oWo4?=
 =?us-ascii?Q?stZyWdQ5VxpEEhZMMLZoER8r/qB03nLy7inxEB+FFh0GMBfLFysGe2Y4ZN4k?=
 =?us-ascii?Q?KqW9fDFX/F23TcqLylCc/puHVe6xzjGIZL+MnER43rmBa9AXlSTQyuvOz71F?=
 =?us-ascii?Q?oeXp9VdewTUo84c0iNr1ZKLj55321sp7LgayRDtETz+aEu+YfRpINA8GfS+I?=
 =?us-ascii?Q?rYVl04TNFQnItZbnr0i4Z/YOygXahPE9gkj+Ql0UUfAEoxYRX0SBuL0mHQ+N?=
 =?us-ascii?Q?Km9jF6EtD0Wj6x2CqGd6CcBjRF5iSWGH9Wj1wT5+rdiyyEITCs38GyO33CLr?=
 =?us-ascii?Q?yP9ZdpMVHkKdPllerLjVocdBcOurqsnHM9dxlkf/Hjt5raFewmTVV+ba0cY/?=
 =?us-ascii?Q?a8Ocekj51a/taLcYCdn9jPU4bYqEeqWp7GoNDE0ldLt+r/AWHrFpueKb54Ab?=
 =?us-ascii?Q?7695O8EEeCeGONvLwaVouAkibY6x/WjbG6y12OsQik6063y+KvKmKdy6+xWB?=
 =?us-ascii?Q?+WVLaTTr1j2OeaXT8KQjW03Oq8tyrGJltap0s27Wcbn1OdRHa1YirNDYkwpc?=
 =?us-ascii?Q?ewl76jok3u61QSYoiNTjEF+m5xzGEkEBf66yZKha?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR17MB4826CF1B7A7893F92C320331B2482MW4PR17MB4826namp_"
MIME-Version: 1.0
X-OriginatorOrg: lynx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR17MB4826.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6520e794-ccc0-4149-5c70-08dc2c1029fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 21:18:31.5091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcd2f523-b055-4bea-b9ec-dc33b14bbaa1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VKrrzBS/JfHvoNSDhJtFSNXcNZRJVLaFa+EKvFGJtaFdfayydwc/kwlgHMKk1GELIXN10UK7llWAgZC9q8usw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB4657
Received-SPF: pass client-ip=40.107.101.97; envelope-from=rbhagavatula@lynx.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 13 Feb 2024 00:19:06 -0500
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

--_000_MW4PR17MB4826CF1B7A7893F92C320331B2482MW4PR17MB4826namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

We are running into an issue using GDB with our RTOS on QEMU x86_64 system =
emulator without KVM. The same works well when we re-run the test with KVM =
enabled.

The scenario is following:

  *   ptrace sets up a HW watchpoint using debug register
  *   ptrace sets up a user program single-stepping through TF bit in EFLAG=
S register
  *   ptrace kicks the program
  *   the program hits the next instruction which shall cause a debug excep=
tion due to watchpoint event
  *   the program shall also cause the same debug exception due to single-s=
tep event

In case of KVM QEMU mode - TF bit in EFLAGS causes "int 1" in user mode, wh=
ich is handled by LOS178 ptrace_debugerr() function (user mode debug except=
ion handler), which does the following steps:

  *   clears TF bit from EFLAGS
  *   checks Debug-Status Register (DR6)
  *   since watchpoint bit is set (B0 bit in DR6) - single-step bit from DR=
6 is cleared and watchpoint event is handled.

This sequence is described in Debug Status Register (DR6) section of Intel =
64 SDM (https://www.intel.com/content/www/us/en/developer/articles/technica=
l/intel-sdm.html) as follows:
* BS (single step) flag (bit 14) - Indicates (when set) that the debug exce=
ption was triggered by the single-
step execution mode (enabled with the TF flag in the EFLAGS register). The =
single-step mode is the highest-
priority debug exception. When the BS flag is set, any of the other debug s=
tatus bits also may be set

However, in case of no-KVM QEMU mode CPU behaves differently:

  *   debug exception is triggered because of watchpoint event, execution e=
nters etrap1 function (beginning of watchpoint event handling)
  *   TF bit in EFLAGS causes CPU to execute int 1 in kernel mode inside of=
 etrap1
  *   debug exception in kernel mode is handled by SKDB, if it's installed,=
 so LOS178 enters SKDB
  *   SKDB doesn't ignore any debug exception, even though it didn't use an=
y debugging utilities (like BPs, WPs, single-step), so it puts the LOS178 i=
nto SKDB command line mode

This sequence can be proved by the CPU state after SKDB is entered, here we=
 see that etrap1 was interrupted in the beginning:
* t
fp=3D0x00007ffffc67bee8, pc=3D0xffffffff80005348 <etrap1>, sp=3D0x00007ffff=
fffdfc0

DR6 (DSTAT) value shows there are 2 bits set - B0 (watchpoint) and BS (sing=
le-step):
* r
...
                                DR0                                   DR1  =
                               DR2                                 DR3
0000000000213610 0000000000000000 0000000000000000 0000000000000000
                              (DR4)                              (DR5)     =
                   DSTAT                           DCTRL
0000000000000000 0000000000000000 00000000ffff4ff1 00000000001d0402

I've tried a few different -cpu flags for qemu, but it doesn't change behav=
ior, so it appears that no-KVM QEMU implementation may have a bug, which ma=
kes CPU to execute exceptions in a wrong order for this scenario.
I didn't have a chance to reproduce the same scenario on Linux, but looking=
 through the source code it appears that at least KGDB verifies did it set =
a single-step, has the user thread single-step flag set, and ignore the une=
xpected single-step exceptions so it may handle this case seamlessly, so th=
e issue might be hidden on Linux running atop no-KVM QEMU.

Any thoughts or further steps?

Thanks,
Ravi Bhagavatula


--_000_MW4PR17MB4826CF1B7A7893F92C320331B2482MW4PR17MB4826namp_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
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
	{mso-list-id:1000348918;
	mso-list-template-ids:1914588794;}
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
@list l1
	{mso-list-id:1357464589;
	mso-list-template-ids:-885387570;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2
	{mso-list-id:1791363198;
	mso-list-template-ids:36322322;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2:level9
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
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">Hi,<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">We are running into=
 an issue using GDB with our RTOS on QEMU x86_64 system emulator without KV=
M. The same works well when we re-run the test with KVM enabled.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">The scenario is fol=
lowing:<o:p></o:p></span></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo1"><span style=3D"fo=
nt-size:10.0pt">ptrace sets up a HW watchpoint using debug register<o:p></o=
:p></span></li><li class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo1"><s=
pan style=3D"font-size:10.0pt">ptrace sets up a user program single-steppin=
g through TF bit in EFLAGS register<o:p></o:p></span></li><li class=3D"MsoN=
ormal" style=3D"mso-list:l0 level1 lfo1"><span style=3D"font-size:10.0pt">p=
trace kicks the program<o:p></o:p></span></li><li class=3D"MsoNormal" style=
=3D"mso-list:l0 level1 lfo1"><span style=3D"font-size:10.0pt">the program h=
its the next instruction which shall cause a debug exception due to watchpo=
int event<o:p></o:p></span></li><li class=3D"MsoNormal" style=3D"mso-list:l=
0 level1 lfo1"><span style=3D"font-size:10.0pt">the program shall also caus=
e the same debug exception due to single-step event<o:p></o:p></span></li><=
/ul>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">In case of KVM QEMU=
 mode - TF bit in EFLAGS causes &quot;int 1&quot; in user mode, which is ha=
ndled by LOS178 ptrace_debugerr() function (user mode debug exception handl=
er), which does the following steps:<o:p></o:p></span></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l2 level1 lfo2"><span style=3D"fo=
nt-size:10.0pt">clears TF bit from EFLAGS<o:p></o:p></span></li><li class=
=3D"MsoNormal" style=3D"mso-list:l2 level1 lfo2"><span style=3D"font-size:1=
0.0pt">checks Debug-Status Register (DR6)<o:p></o:p></span></li><li class=
=3D"MsoNormal" style=3D"mso-list:l2 level1 lfo2"><span style=3D"font-size:1=
0.0pt">since watchpoint bit is set (B0 bit in DR6) - single-step bit from D=
R6 is cleared and watchpoint event is handled.<o:p></o:p></span></li></ul>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">This sequence is de=
scribed in Debug Status Register (DR6) section of Intel 64 SDM (<a href=3D"=
https://www.intel.com/content/www/us/en/developer/articles/technical/intel-=
sdm.html" target=3D"_blank">https://www.intel.com/content/www/us/en/develop=
er/articles/technical/intel-sdm.html</a>)
 as follows:<br>
&#8226; BS (single step) flag (bit 14) &#8212; Indicates (when set) that th=
e debug exception was triggered by the single-<br>
step execution mode (enabled with the TF flag in the EFLAGS register).&nbsp=
;<b>The single-step mode is the highest-</b><br>
<b>priority debug exception.</b>&nbsp;When the BS flag is set, any of the o=
ther debug status bits also may be set<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">However, in case of=
 no-KVM QEMU mode CPU behaves differently:<o:p></o:p></span></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l1 level1 lfo3"><span style=3D"fo=
nt-size:10.0pt">debug exception is triggered because of watchpoint event, e=
xecution enters etrap1 function (beginning of watchpoint event handling)<o:=
p></o:p></span></li><li class=3D"MsoNormal" style=3D"mso-list:l1 level1 lfo=
3"><span style=3D"font-size:10.0pt">TF bit in EFLAGS causes CPU to execute =
int 1 in kernel mode inside of etrap1<o:p></o:p></span></li><li class=3D"Ms=
oNormal" style=3D"mso-list:l1 level1 lfo3"><span style=3D"font-size:10.0pt"=
>debug exception in kernel mode is handled by SKDB, if it's installed, so L=
OS178 enters SKDB<o:p></o:p></span></li><li class=3D"MsoNormal" style=3D"ms=
o-list:l1 level1 lfo3"><span style=3D"font-size:10.0pt">SKDB doesn't ignore=
 any debug exception, even though it didn't use any debugging utilities (li=
ke BPs, WPs, single-step), so it puts the LOS178 into SKDB command line mod=
e<o:p></o:p></span></li></ul>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">This sequence can b=
e proved by the CPU state after SKDB is entered, here we see that etrap1 wa=
s interrupted in the beginning:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">* t<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">fp=3D0x00007ffffc67=
bee8, pc=3D0xffffffff80005348 &lt;etrap1&gt;, sp=3D0x00007fffffffdfc0<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">DR6 (DSTAT) value s=
hows there are 2 bits set - B0 (watchpoint) and BS (single-step):<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">* r<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">...<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;DR0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;DR1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DR2&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;DR3<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">0000000000213610 00=
00000000000000 0000000000000000 0000000000000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;(DR4)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(DR5)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DSTAT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DCTRL<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">0000000000000000 00=
00000000000000 00000000ffff4ff1 00000000001d0402<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">I've tried a few di=
fferent -cpu flags for qemu, but it doesn't change behavior, so it appears =
that no-KVM QEMU implementation may have a bug, which makes CPU to execute =
exceptions in a wrong order for this
 scenario.<br>
I didn't have a chance to reproduce the same scenario on Linux, but looking=
 through the source code it appears that at least KGDB verifies did it set =
a single-step, has the user thread single-step flag set, and ignore the une=
xpected single-step exceptions so
 it may handle this case seamlessly, so the issue might be hidden on Linux =
running atop no-KVM QEMU.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">Any thoughts or fur=
ther steps?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">Thanks,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">Ravi Bhagavatula<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
</body>
</html>

--_000_MW4PR17MB4826CF1B7A7893F92C320331B2482MW4PR17MB4826namp_--

