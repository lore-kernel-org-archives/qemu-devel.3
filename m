Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CDBCF3959
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 16:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srJfu-0000Ui-LE; Thu, 19 Sep 2024 12:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.schmitt@starlab.io>)
 id 1srJfs-0000QD-3S
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:06:32 -0400
Received: from mail-northcentralusazon11011015.outbound.protection.outlook.com
 ([40.107.199.15] helo=CH1PR09CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.schmitt@starlab.io>)
 id 1srJfk-0006BW-1b
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:06:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAxZc8oYogcfIY/EgoZCVIwmdxqHpGgvrmowoY+GC7DuOqJSSjZaCty/OCp78b+BWgDwRomN4UmDImMRPRYKE5BpzrhmJypqMbJ4gO0kSPUwyU7Ooj9krEif0YWEBqBHJ4/kdZLSkIMaj0llwWzE4f48CJr+wdZTZt3s0k+E0VtSKPGuwTuTh9WOovuPLhu2r7EL1LbV9gDNeKxRVuBZD79q5LdrHfa5h6DcwZvXmtFp4YPdUHIbxGJuVq3l4eCPVKyYFOJ/J6bZssVXjZFSddvX3QRLG1DQgE6XWi3u/PZIUet3HgCYxNYV0VXTlmtZNtKpTa6MvGbzqEgJhewFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKflAHNOilPxZTyTJuTpBZ1InaS9img26si5NMj2qPw=;
 b=jkM5GMpYqcX0t0yhTe6i+tVxwWz1NyCaBXm1pYA4+rNo9G4PvrMgCZRd4rYytiCwNXK0iKQFhwnzHWB9tYt/qucCfp0azzoqTFU9uLSKFYZ2bk0tZHiMG6snr6e1K4ZFcpuLtBwxWA+LOXvCaSjgGn3INl95WB2Go6nCGeyRQ/kuN82WHe7oowIF/CgR0ntbW8vqpCaN08im0F8xkXwXq4mb3znzxK86YgvV201tNIeWUKvar1dX4xkElFqyDsAQ6Ub0yqPm4vz5M59HCVJtL8wAhD/4a0XGZYRuL7DR5IlUYXtVD+1xGuAQMF1U1YJE8x1IKsDpSYZBI6eMdUttVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starlab.io; dmarc=pass action=none header.from=starlab.io;
 dkim=pass header.d=starlab.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=starlab.io;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKflAHNOilPxZTyTJuTpBZ1InaS9img26si5NMj2qPw=;
 b=IZGySVfJDBHbYVPn7f0ihZnBMyvLNzwHf32wgP42dcEV+YjFAscRviec4xiDPfqojZlO9vlcfRO+yEzESfaJE90C8bNbjSd6wyoq93ivFaX3xBKwQTO3x1gJBVfL2c3ZQwMlikUbcGhoODdCYe7bLeHCJBPWf/1Y4xPgZynIrVE=
Received: from SA9PR09MB5294.namprd09.prod.outlook.com (2603:10b6:806:1e::12)
 by MN2PR09MB4873.namprd09.prod.outlook.com (2603:10b6:208:221::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 16:01:09 +0000
Received: from SA9PR09MB5294.namprd09.prod.outlook.com
 ([fe80::4143:f50a:3118:3f92]) by SA9PR09MB5294.namprd09.prod.outlook.com
 ([fe80::4143:f50a:3118:3f92%5]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 16:01:08 +0000
From: Richard Schmitt <richard.schmitt@starlab.io>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Disabling Monitor Commands
Thread-Topic: Disabling Monitor Commands
Thread-Index: AQHbCqyVKCrHU9T9IU2rRo/cccRwhA==
Date: Thu, 19 Sep 2024 16:01:08 +0000
Message-ID: <SA9PR09MB5294CF70074D9006E20ED1809C632@SA9PR09MB5294.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starlab.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA9PR09MB5294:EE_|MN2PR09MB4873:EE_
x-ms-office365-filtering-correlation-id: ebb89f5c-f6c9-4b3f-3ce0-08dcd8c4466d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?yDeZHEWb2EKQFJGoGsycragA2gfedMtdpBKpBu4QXVxgJhYA2lO8F0lL?=
 =?Windows-1252?Q?vyUUUUN3F+eCTRtj/tpa1pu0q0cQjQPyvKTo/29nbEGk0+mkw5MVLGuS?=
 =?Windows-1252?Q?dXunsv1p7tgsaUX+ynFsauM/kMrCOc47ofoBnBS3E0QVnKyOjjStlXNq?=
 =?Windows-1252?Q?V1mhHSUNTntDxmUxNQKoqVnTsdH3ser4atX4eC2zO6RL4nCJadwfL8HG?=
 =?Windows-1252?Q?Jpf1zIboNB+QMdz0MHGyGor62IyKPFXMXoRn0ZlpxClT+NdH8FQ+sYvL?=
 =?Windows-1252?Q?u4j2BOpFOCK+9hscSx7bN1p7oePgoeWZI6mLtqR9YKpWZ5qtRpWdaxti?=
 =?Windows-1252?Q?L3MPBgMcXZEb92hcmCRnkD9aOfGmwENVOM59276OwixGXZg1lvgZwZml?=
 =?Windows-1252?Q?OHxwKvOhe2RE1aNdXnk2xuSd0WVRuSEemGXxWS7W+MjauB0IvsNOB4/B?=
 =?Windows-1252?Q?2LmAFkwcOkliKKo/3mH7FXhDYMJSAK+OdopM0Nv03cJnwK5fsTDFTax9?=
 =?Windows-1252?Q?tnqyQ4/Olu0MGX2X8V+OBJQ2v5qtwjbV2kW5EG3z7gB4GI9EBEnbBXng?=
 =?Windows-1252?Q?engopLYKXUBQHgqnlrSH6dsFognDHH24mCCegiplFg6jA3lReJSlox9Y?=
 =?Windows-1252?Q?k9nTbbAJLZgPqlZ7d78t0O/0lXilkUtfaj2QayH4v9oQiLAtf048T9gV?=
 =?Windows-1252?Q?Y5TXa9efSnbIShMH6Bcea0ZUq7vKPa/gavv+8VQnQngsTyDNwmul5pMP?=
 =?Windows-1252?Q?oWKIPgROnra3F4HptG4RgmyC8FwVY0ztnyM9hSRoNsSUrvIA+uzoNvsT?=
 =?Windows-1252?Q?f88sbFG4iX8hCZpuZGKJzFJBpahVPfiYViH9xAZ+m7nK6PtX7qC1YbrT?=
 =?Windows-1252?Q?R5rzkNJ/dXUDkYXLymWJDs9KyWNsPRyvRt+hFMbEpaR9kAsjI/IDTF2/?=
 =?Windows-1252?Q?BgjE4KbNS3De+5ys0nsxDVvGE5owyWgn7h8xDQeMMcWlWsMSbVWagxjD?=
 =?Windows-1252?Q?xKW3BRCqfGvkyO8tUTZh5+5Hgb0Vv20vHsDREXoYfcgLxJM0GIvr6Pzu?=
 =?Windows-1252?Q?JtHvUPmq+0rqg1f5AMm1LCU3C64IK6CzV1+eQ+LhtgRxdsyrN1QZFyJr?=
 =?Windows-1252?Q?VF63vUZmdg5CgQ2XpsofWyn7NMEgE2tW8+2APdaYvRlBCOaVHNRR5Vhs?=
 =?Windows-1252?Q?qa146KvWUPTvsiJ4AF/I5dres0525YSLfFEH77N4o1gnXa1wqAJ/tJkk?=
 =?Windows-1252?Q?iAlNiJaqvyr8+L/aTIhYPAsREHxSxPcMuAVq1Ss33jwi5wH8cqT+s3nz?=
 =?Windows-1252?Q?Qb7C0LRNSnkAzpZ4SpTD5nF6Xd1AdGVKrl+zE3i9KDOO0508i5IvJjMB?=
 =?Windows-1252?Q?x1kMA1SMaVRTelSc+Sv19Bg3dskW861REI0HSRXx3LxmVU/DEsmoe6LN?=
 =?Windows-1252?Q?wRHd+d7NQkNpxVP6cZRWK66ndS/gid6CYopog81uFBv8vYLborIPDniO?=
 =?Windows-1252?Q?Ih5lEfqvxpu0ar6XZhNOJ/VYYB5fXQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA9PR09MB5294.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?7d1yIZJuyNncOfKAshT7HFPLdYABPmTGVYFS8uRtVydS9OnAfRdv1MEb?=
 =?Windows-1252?Q?ByZANhWOIlfd2p01enO5efh0ekP/Cc8Y1tn57iAk9KjieX1rN7Ws69DD?=
 =?Windows-1252?Q?rWAWHaR/KZJ2Ez/DXVigAtqrYGeSTPTPuDgr7uwTv75X1xGdOcjnjz71?=
 =?Windows-1252?Q?n/6ec6Vklt2c6WrbH6vIJmYVxUJ6pIETZjedz4ziuh4hvLWM7QmFmn1Z?=
 =?Windows-1252?Q?NH+gmAdJAK3jdsUTt8qPo/vDEtq1mMojTNlnTsEysyD+HJm6EfSw7N2X?=
 =?Windows-1252?Q?2B8ZK5tpjq10ckqQWgK3x1XPdlVK9aWyyGPHQwRVnBmcrNTOcESLgvgZ?=
 =?Windows-1252?Q?I0sZsZ9dKdIFLdN9M3i5154L5t9bKVCLz+VNogh1DpekKAhC2NQcaqQZ?=
 =?Windows-1252?Q?z78YzFhO2u/Xi3L1CWOm0W7g5krAfOjoWNnZbVy2jY8qPxKnUgO0BYTe?=
 =?Windows-1252?Q?ke5CAYLkGNJDV3xg5iyQJPvtdg3HSq89r6ZxjezPSSAUT8snQEVcwYSU?=
 =?Windows-1252?Q?VlESNNSe1tQDK9UkZD190jILpe0xoO1wqR4WVpDnItXSxW9fy9GfQmYF?=
 =?Windows-1252?Q?0tvHutbgtmD3oKBBrh/oLYsrZJBdDuY9YklXqyu4obOEX9VKdtAs12LS?=
 =?Windows-1252?Q?aNHSZ+iSZSilKHc6wVyFsRgtAaud9Y2ljfjZoRfGD4sfC87xjwSXND79?=
 =?Windows-1252?Q?PDvXUHf4wBXmYdWaujpEflh5QUgWAdxlkuZNFA6TAeVGCybYbiF1Pb2e?=
 =?Windows-1252?Q?TS/FeUKBaN2h7WoKEIbsMK569p3qJGg+5c7k5bbJOk3uLkRvoeCFUmX0?=
 =?Windows-1252?Q?qlgBzg+fQS3s7T7ZG8QSoRer3BvOit3hGLnTfhah4niAqjZAQXI/UbVk?=
 =?Windows-1252?Q?Fa758RthI6S0aq9HF4B2mJzkPLNeJwI1WBoqYaPTFDLcr02r0CMPq2oT?=
 =?Windows-1252?Q?+JU1NAwZz7daisKSpPp5aLFkl27x3c9n8B/jI9++2UcC+1ghrVtQiaFt?=
 =?Windows-1252?Q?tTxTDb0nSJcJKFge/OfodQHWb6xpbKShJOT2IC/mFdhsnOtPF9M6LcnJ?=
 =?Windows-1252?Q?3Z5fQZ2oH9hHAM/Nq1YmMsGKgHbMcUYiyhg5qmmmYpXx4lniaYTmzEDA?=
 =?Windows-1252?Q?tQP/+CHILGEYaO/hWEeI3rrEiYD01IrrD/L4tbPkuMA/U0286DHCIaXw?=
 =?Windows-1252?Q?Ack5R+hH9/6TkjBoOi9jIF/TOP45lmvwaF2hbOmDwz2Yfa6WzCiOwlPY?=
 =?Windows-1252?Q?CcZMaNiZYBwJd7EODpO2yN4zWra/lDZRxNaE8ii03Z7tslk9/KNvBX5X?=
 =?Windows-1252?Q?vJFYLMcZxeF/bTORzP60vQWZX9krIHPijyTsun1Ndo9aPP+cfNTZsvCY?=
 =?Windows-1252?Q?Hex2JvIEMiMRVLRubN1lvtE5kiy5POb4sTRGLXuwD0C8KDfhcWBtL81+?=
 =?Windows-1252?Q?BmCGALzT/Gs4DyNKXcEYW93eORe+2R5eLtHlK01Xg1xLw1vPBsTYsrbP?=
 =?Windows-1252?Q?a1Qyhdx6B8C+H3B48hhm6VbMzPOXmmdO6b3vXx/f6rnny1mmdwG9CpYr?=
 =?Windows-1252?Q?EsQy6ibX3kMAM7nWno7orWUDjrMtXhViccGXsUeZQJO82uKksAJToFce?=
 =?Windows-1252?Q?GU5KDb9fTw9VBAENBaUdytZ9ATG4ta8yChJAjHaTIgASDHxKIr9qPw5n?=
 =?Windows-1252?Q?N5sr9Uc4jy07cmGFnQEVl88b6EU2OrXlWQQVn0ITpVK2pBWy2WC51uHC?=
 =?Windows-1252?Q?+3xcLbU8l33rmsEw6H4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA9PR09MB5294CF70074D9006E20ED1809C632SA9PR09MB5294namp_"
MIME-Version: 1.0
X-OriginatorOrg: starlab.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA9PR09MB5294.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb89f5c-f6c9-4b3f-3ce0-08dcd8c4466d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 16:01:08.5897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5e611933-986f-4838-a403-4acb432ce224
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR09MB4873
Received-SPF: pass client-ip=40.107.199.15;
 envelope-from=richard.schmitt@starlab.io;
 helo=CH1PR09CU001.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H2=-1.048, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--_000_SA9PR09MB5294CF70074D9006E20ED1809C632SA9PR09MB5294namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

We would like to deploy a hardened version of QEMU where certain monitor co=
mmands are disabled.  I have found references on the web to a `-monitor-dis=
able-cmds` option to qemu yet it appears non standard and not in the mail t=
ree.

Is anyone familiar with a fork of QEMU that supports this option?

As an example, we=92d like to disable the monitor `screendump` command.  Th=
ere are other commands as well.  We are looking for a generic way to do thi=
s.


--_000_SA9PR09MB5294CF70074D9006E20ED1809C632SA9PR09MB5294namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">We would like to deploy a hardened version of QEMU w=
here certain monitor commands are disabled.&nbsp; I have found references o=
n the web to a `-monitor-disable-cmds` option to qemu yet it appears non st=
andard and not in the mail tree.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is anyone familiar with a fork of QEMU that supports=
 this option?&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As an example, we=92d like to disable the monitor `s=
creendump` command.&nbsp; There are other commands as well.&nbsp; We are lo=
oking for a generic way to do this.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_SA9PR09MB5294CF70074D9006E20ED1809C632SA9PR09MB5294namp_--

