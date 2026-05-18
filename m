Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBA5CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 02:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOnSR-0003dM-Gu; Sun, 17 May 2026 22:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ryan.zhang@nxp.com>)
 id 1wOnSO-0003d5-Oq
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:11:49 -0400
Received: from mail-westeuropeazon11013007.outbound.protection.outlook.com
 ([52.101.72.7] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ryan.zhang@nxp.com>)
 id 1wOnSL-0004EQ-UM
 for qemu-devel@nongnu.org; Sun, 17 May 2026 22:11:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu/QcnjXH+oxBC/xDqY5meHifgUbnaq23qB/pVkRsLT5iv3Gb7H2Op4gE9mn66MsfQazh3X1fnv4hSnCTi2HNTSGQpZqnEcLYcYQz3Fmzju+jXUpNNkOmC9u7xZXsvgCBxeIXRLvROYro0PqrqWNTw6c69tpsi1jzQCCRkGK8+ZfQDgNBfRiBkrtVCssggWRKRaXr4KjDtoeZROtZ4f8ZsPQ840AAec9p7Zr//05HrQ/tNrHLrAGU9GMHe3EE5MteFRHfo0w07F2y9yhD+cA0NjfEisGiSXHhLhSMJokj30okMC/pa2ZvgeyvFKKVBNzh1YQtAlQOkWuSOjrBO6yKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mgdG2x7Pp3pDkJC66eraBDx501tCXeGeF5/310sZgo=;
 b=fmv201JPoEj524jSXbVZPBFowtB3MBg/KNvHJ25tcH9KgARACmSycSbr9aM6JuY1mEnTcrLUd/1G52ETb9/5gEVQTMujCSLPS98uDU55bZt7Sl/c37/pC7BJ2o/2QsrzkfNGNPps/9MvLXbuHbru3qi0yYK81SFXVh7acStUTJ/GYsBMUZc/vYyqyNmmArC2BJXffSaEp3UoPh24TJyWx75ZQNXaJtfF/AAYPxlYWaNLFwlYaop20Ubh04HRAIPdO2yviWdT0UKQ23TUGbOvDwY5CHvnJshjj0XyZv3dFIFPODj+u+Kobba57tw86jW+q3UVAtjDRjPhV7zzSmYh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mgdG2x7Pp3pDkJC66eraBDx501tCXeGeF5/310sZgo=;
 b=Inq9q4+IK5GDZOUGEybYOlfAqHzuaGUp+7ZqUHRvvLvUToybCCUPM7RpVlN9gCV+TT17cM/y0rHodP0rLuBTWbH345z8D0aHVC37pJuiP5+jBK91sEUgzWcCOP4zrIWGhPwq7C91kKDleHn04oLI5A/aSrl+JesteAe4rHQ6T1kYPf7aDZT+T8aYSpO8II8F3mrlt0vxR2s793vcIqpStPWleZAUo1bOiTBnJJ3UW03et+nh2Rlmp+PAhnBT2zZHTPrmKQaVqnhJ8NvG5r3e6457TefSHxWS+R0YYops6Kniq7Jhs80i1SVHvNG6kbVcPlqb02qnaeNuuGb/q15TbA==
Received: from DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11)
 by VI1PR04MB6879.eurprd04.prod.outlook.com (2603:10a6:803:132::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 02:06:37 +0000
Received: from DU2PR04MB9018.eurprd04.prod.outlook.com
 ([fe80::c91e:9d3b:4c71:b39a]) by DU2PR04MB9018.eurprd04.prod.outlook.com
 ([fe80::c91e:9d3b:4c71:b39a%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 02:06:37 +0000
From: Ryan Zhang <ryan.zhang@nxp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
Subject: FW: [PATCH] ui/sdl2: Set GL ES profile before creating initial GL
 context
Thread-Topic: [PATCH] ui/sdl2: Set GL ES profile before creating initial GL
 context
Thread-Index: AdzkZbmsTFRM938VTq2SUPkaSraPSQCBMHKA
Date: Mon, 18 May 2026 02:06:37 +0000
Message-ID: <DU2PR04MB90189AC0B15BC5F0B3EC4F3383032@DU2PR04MB9018.eurprd04.prod.outlook.com>
References: <DU2PR04MB9018BB3650BA218438C01F2A83042@DU2PR04MB9018.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB9018BB3650BA218438C01F2A83042@DU2PR04MB9018.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB9018:EE_|VI1PR04MB6879:EE_
x-ms-office365-filtering-correlation-id: 338f2c31-35b9-453e-27f0-08deb48217c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|38070700021|22082099003|18002099003|56012099003|11063799003;
x-microsoft-antispam-message-info: HADpMlhInyJOt2plsLyGIo5SdbySoDO3abkGx9jq6SPtntf1VrPBQdPDDiA3F+sB28ElCP6L1jGjLKFFt11eO/KE7inVh7oN7WxicJFfpxVXPERYKGZeQkgEMzKAUNsT0F2QY9GykJ8o70vuh6nLcef8YCeudxH77C9D7QYUaQmFOaF/P4YTR5boo4c8dyKlE1i3GlRg7FwmTxKhPIZ5belHHJ1bRRbs9p2H+Anhn+Ye6AXH7exf9ueBx4j5mDqqOd1hzXxb0Tulv6fum19dSX+vVxVrP6Dy1nTYPDp5VUFurdZL4DLWGhFyvwiBixQL3m+7xGst+rv98lFiG6T5FxYkSHoWBgQ+xUQLtH7+K43twyaRHmdwUOOcDMnHP+1HWeo2fYGJPYKNcgnwEieZlBnjldPpz0bMWpv9oIVP5sl2nahmR/9xk5t4IrTB3jCquBLRL3xRVSTPNLAcSTSnURgo/UiOkcTkSgglYUkomPHeoSjoM4NAyT8G8kiNeMTrFDsSdG3KWSsr6Ra7xA87Gtb1ndvUBOnWKsFZ09GQMZbZoEpWSSTTFVMO14rBPxICAwI2ncOssZt9SpwwtQ1/8Yjq1btcUjwMXe7YGH7GHPc/wH63mA9G0Pei5BHh2HFKeUa7+4IDvmN3qTLBLzIbJf36Qp2p+C58+ln6WoOOQRGUCJu5YE29xoiDgOpBmj9TMeF7tTMcD8IFuQLWVegtvmQia50L9uwOfaulObcJ+mw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB9018.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QjL2aLOKbbD6/fbwKrFjjQXslOWdfJIsTNUyX2mDEb1vigbxCydSjb3dSUY6?=
 =?us-ascii?Q?cU6wBwNFeRMPUEuJ9IiHonEdWXwcPpH1wNQO2rdzu9gZMg6iLLH90s/MCHWL?=
 =?us-ascii?Q?Ey7bR3KxlafskGBDgEzdSKO+OAqbg6NeXAEYTEZEuLGm4mEiW3s1aLOU3n2a?=
 =?us-ascii?Q?4p0+Ur/KIagxnunN5usD1IwoLUmOfeNNPyL6cUnHVQjRBE2OmJKSQ851uDY3?=
 =?us-ascii?Q?Wf5U7nRdWR2yA1O/pO2Ofg7fiILMx5z5qrlEo7O3AnAU7GMfoWbK85eUqYGX?=
 =?us-ascii?Q?BQEs+9F2pUuGZKrw/xVO9GMVu5NHBlxegEtfppB50M8t7JOmvVffe9H+QR+Z?=
 =?us-ascii?Q?qpGTjK+Fg3piNPUF0A6gNdbKnnDibN4OcGaurodEif3gIMidJxcdg8hx4Di6?=
 =?us-ascii?Q?gVIH1mKDvmzVnysYNB1E/8Uv79xvhFP7tEFrdqjUN4s+Af8lBb+W+w7W5k7o?=
 =?us-ascii?Q?sOeuenOMpOtxfUZhNo6GObY1MOKYfAv++EBRhVIcH2jhKE6vOrJPkFma1fOf?=
 =?us-ascii?Q?okuY8K9077JabcLWseU8WYY6+W5uUgKJ6+cYx4N68s//Y30wSY7EbhVLz60t?=
 =?us-ascii?Q?i+Dvx03MNVde8bjJMdPUIoJj6aQ/KNuLrA1jSinV0GATMLbPkXGU+mZO4Xd+?=
 =?us-ascii?Q?wzEMvVltOplpmzeVB5+UvsMTks/DysEb0hQjzUXJ7qPtdLl4FRr8h0mc2C/G?=
 =?us-ascii?Q?qA1gnN6GdZI5YqOopLc2rUaEB4QnG9EMbmIDUV35zKKFBe+WWtMMxphdbKQM?=
 =?us-ascii?Q?CwueKoHXnyOSI7dQZLBpFzzaV3EaagNevN8Ykvr3Dd14MwQq2lmcnH8jNa2f?=
 =?us-ascii?Q?UPKwm/8QANIjv4SlFZib5lFavqUN5JXrghuYh6sI8mey2J1ul1KEzyK+NAsS?=
 =?us-ascii?Q?P5LlnFQW4q4CXsoeGCywuqCuPiScUprXBy9uhS97LlLT1VSdRD8OtLUqq3vc?=
 =?us-ascii?Q?PvcXBYLAh4pRamfkI1xkjXSbFMqvvP7759I4LfrdyU193lkoEe/Pnbm25q4e?=
 =?us-ascii?Q?L8lkrQ87M6b9aUUqh07koIVgBi9QGZMLS0FJHFXFd+ghofd0YClAzTFN6HII?=
 =?us-ascii?Q?3KdoSMIhJlMTvr8Jejgb/Tjas58/I66OBhxwnQcN/ggdJ2oW5juVje/omqZR?=
 =?us-ascii?Q?0GsRw5GuQZVbcNZvSlcS28cFM1v5CLxSHXLa31Rb1fPyEg1tFe/ljpu6GyZY?=
 =?us-ascii?Q?2cv/s/C93hbLzoCYKdIU77gTDkQxw1kOaSFpOrF7h8CiPa921lxsEacCQZhn?=
 =?us-ascii?Q?fapJJsxV3MkDDn4bqMWr3WxDsYxtE2jQiwzxrA295UMhAPl5834hTyxYAhvC?=
 =?us-ascii?Q?95vBRWYq3V67qqaYTLx4Upj0DQ9GMSm8ZAUILArxadE6b3pHouuPIrwMXDx6?=
 =?us-ascii?Q?CBdXgiN6sELmo4dLxOTGyV5JT7cvv8PCLFE1BLNmDAEvv2jtQLysW5cCcTUK?=
 =?us-ascii?Q?bCAWnH6wckxENi6u3h5JveU9GsxHqYjt2I4jfrSUd5ZyJFJibFsgYlWW8Q8u?=
 =?us-ascii?Q?Bn9W1PHj6kliuWVn9hIp8CZZEW0gYXbQcSc5CpJrB/KCQ34onR+zbG5PuG9B?=
 =?us-ascii?Q?YSiCYvwZW8TsAaV7Vy6nW4NQaszpDtqEOz1OQ9+cm75B8dSicnB+rdIndgK9?=
 =?us-ascii?Q?X2DxCHTlVUigDbDygZonPw2ySLpo2OcocuBOycy79dodUvwBAkYc1Jpxuh77?=
 =?us-ascii?Q?/HqZS7GqrvdlrGKxJxDFlv8BgeoG7oTVB9nr0iVF403TL9WD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9018.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338f2c31-35b9-453e-27f0-08deb48217c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 02:06:37.0695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1KmWb+pC78Qs3kksIzCuT8D+IKpq6GWRv3qhRUVSGCvFmQxd5eFFrrSqjfdZLsq2jurrdecW+UX8IU1R6q01Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6879
Received-SPF: pass client-ip=52.101.72.7; envelope-from=ryan.zhang@nxp.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Qemu developers,

Since this is my first time submitting a patch to QEMU upstream, I have a f=
ew questions I would like to ask. I would like to know how to check the sta=
tus of the patch, such as whether it has been submitted successfully and wh=
ether it is under review. If there are any issues with this patch, please l=
et me know. Thanks in advance.

Best Regards,
Ryan

-----Original Message-----
From: Ryan Zhang=20
Sent: Friday, May 15, 2026 8:32 PM
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH] ui/sdl2: Set GL ES profile before creating initial GL cont=
ext

From abfc1a95936dd832fc2ad9d64d4e3f3880c697e1 Mon Sep 17 00:00:00 2001
From: Ryan Zhang mailto:ryan.zhang@nxp.com
Date: Fri, 15 May 2026 19:21:55 +0800
Subject: [PATCH] ui/sdl2: Set GL ES profile before creating initial GL cont=
ext

When the user selects GLES via '-display sdl,gl=3Des', we need to set SDL_G=
L_CONTEXT_PROFILE_MASK to SDL_GL_CONTEXT_PROFILE_ES before calling SDL_GL_C=
reateContext(). This ensures SDL_GL_LoadLibrary() loads the correct GLES dr=
iver instead of the desktop OpenGL driver.

Fix the below issue: qemu-system-aarch64: /usr/src/debug/libepoxy
/1.5.10/src/dispatch_common.c:872: epoxy_get_proc_address: Assertion
`0 && "Couldn't find current GLX or EGL context.\n"' failed.

sdl2_gl_create_context() already sets the profile mask correctly for ES mod=
e, but the initial context created in sdl2_window_create() is missing the s=
ame treatment.

Fixes:da3f7a3ab9ea0091955b58f8909dfcee01f4043e ("ui/sdl: try to instantiate=
 the matching opengl renderer")
Signed-off-by: Ryan Zhang mailto:ryan.zhang@nxp.com
---
 ui/sdl2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 4fcdbd79d3..9f826afefb 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -113,6 +113,8 @@ void sdl2_window_create(struct sdl2_console *scon)

         if (scon->opts->gl =3D=3D DISPLAY_GL_MODE_ES) {
             driver =3D "opengles2";
+            SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK,
+                                SDL_GL_CONTEXT_PROFILE_ES);
         }

         SDL_SetHint(SDL_HINT_RENDER_DRIVER, driver);
--
2.43.0

