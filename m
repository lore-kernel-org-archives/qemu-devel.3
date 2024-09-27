Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E664ACDD1AF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAz6-00055Y-H5; Fri, 27 Sep 2024 09:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9jE-0002lh-Kp
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:05:47 -0400
Received: from mail-vi1eur05on20705.outbound.protection.outlook.com
 ([2a01:111:f403:2613::705]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9jC-0000mY-OX
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:05:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DscCPdDIUHyDL07uoLz3gAX3tiV4arq9quXVqoBTf+mr01nlZxDM42fC9lntv4cGDKGZ6ytDC52fFWo6nFHJls+mCZglxeId5+tA8MwpMyRBtHaf7iVFoPxWKVTrsHc6JHSd8wYGV3hudLdimncFUwxEWHkuDtYW4Fh/a/fW6iH9+xG6fbEoy/BDXKyRdd1ncAhvtQRMUyTjZMk+M3r8DT950k3tm3mD1FWrFo+FVsKZKwDZTrrgk2NyK0pyfhDb+qxxYLKD4nUBpSaNMp6Qya588rboS4tMMtTEXjXwn6TQH8XVM0VpIf4FOfi2Ob+9Hue6nkPMf82WGsmAiTfSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMf6EVMq3PQ7Sb6HXTn246aedQEYMeYeZGB9uI4T/cY=;
 b=UnSByWLIrAfuxUbsH8qcyqOSu9j1OIO2IXjnxIzZOz6XIKJYWFLox5BUeWSoutDKiWuzIszpSpKDiPzoTMsyuNjCT/vHw8xs9tWglkDTQpaKpV89XjpyLgEXRd+988etxdgOPasdJ4v3cFfMSBhojsEAgNKqTOoy7q36hyERZCwmaHSCR4xwUHWFaQogIXyxoVJwwSdCFUStcmxk5xp9KzRpgW9nBMFK4WjmdBNEwC6qWFB04bRUvO0kLPItb1agmOm2lCK8myB3yNb9+DkRsJSo8TiHkZbaXL86PNOZak2AteeM1bqMJtayxTMyqBl7zg7tQiswd7lIYx6qSY+QBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMf6EVMq3PQ7Sb6HXTn246aedQEYMeYeZGB9uI4T/cY=;
 b=EPc1vjm7GdZH6bbEpbTJol47oS2zML9mxi3Ibdr4KMgjxoNmxmIBnL32i6zBVmqG8iBAogz3+QBbebKbR8BrJGF64/l4vg3f9m0qXdA2XMnFBupgt5gYvbl3QYBZxBcZvRxAaiaOim3HlO3BN/u6EHMv9UZUCTnAtUH/D9EucV1kcFVuRRGnCNWaecQXMbzZgXq3NTFo0rhC3yybacQNCBIYYcSfzj/LQOmL5VGhSFJ20kZ8DwrsnqvjE0vsyaTpqxhb6RV0V2SS0VCk2RuHqPRh3l0/qCTLtECaHINDd8/PXyXrcWfXoCKxIim2/2mzmqzNBNqfymLvZ9rqnC0X7Q==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by PR3PR09MB4426.eurprd09.prod.outlook.com (2603:10a6:102:32::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 12:05:38 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%7]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 12:05:38 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>
Subject: [PATCH 4/8] Skip NaN mode check for soft-float
Thread-Topic: [PATCH 4/8] Skip NaN mode check for soft-float
Thread-Index: AQHbENVIIsOIt5dgO0CP138By581Jw==
Date: Fri, 27 Sep 2024 12:05:38 +0000
Message-ID: <PA4PR09MB4864BC65090CB019679B6F9A846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|PR3PR09MB4426:EE_
x-ms-office365-filtering-correlation-id: ec4d8c66-016a-444c-9b7e-08dcdeecb391
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?U7vJ9C46CQsUMoabb46RBXOyEqSplJAzGTjGAPDKAB8mMtkLid24PBgNO0?=
 =?iso-8859-1?Q?5pt6v9A4JdshXf8eRCTx+qQMT+wyIEnPtLSttNkBcuHx7ffAz8CLLqGNoD?=
 =?iso-8859-1?Q?oeygZNriF9Q/3gmfgxwBpz4gqMUk+1Z0UzULbbAq2DdRCmZFMTE/4CtzOW?=
 =?iso-8859-1?Q?yj+tzAWA3LZHKWt3oVo7rDAFILDkQnbFufX9SqFL39TKFf78naKjgnMl3X?=
 =?iso-8859-1?Q?gEgE73O0BRcmnFvkNcV+kc2vbJoPwMCh2X1XaecxCZ/frAlyyQF0YdGrlT?=
 =?iso-8859-1?Q?rAUAnsDvXIxcrEYHkUcBsP/J2aO5DARNl1/kfAGbrhKi2cblngoel7JiG5?=
 =?iso-8859-1?Q?0vp01avTRdflHO13IvneauyCR3VxBlAUhXwybzPrDv9iP+2Sq2Aqel69Zq?=
 =?iso-8859-1?Q?Jka5OZqn/T6WabAp/QkXBZKCfvR+qUfC14IdnPSS8esdg3M22vJv0HTkv0?=
 =?iso-8859-1?Q?OcqD9vcKNc8pCIsPCZiZW8WUt9JhO8Kszm7KkdWnOAMj05g1lvRlbmQgca?=
 =?iso-8859-1?Q?6qhbx2mdE1vyCI7gBCcm1TMO4f0iE6f3QM1yHZP0nkKB3W4v79U46CONij?=
 =?iso-8859-1?Q?tvvQnrp/lg+4yBEBfzN44E2DxJOgFacLY/uO8AM5yecgNpQwfHvWADVK9D?=
 =?iso-8859-1?Q?XFZGRKV3qjZN/MyzyUH9gG09JqoDGODMQ3YjPYTyyVqEjGUnnQfpT8ENZS?=
 =?iso-8859-1?Q?TouLwfHXxC6iSzPRqw00FYleRx/DbS3uy3In+u/VNMvZkhKmH4aH6QinH+?=
 =?iso-8859-1?Q?P84e6f/5QqpTiNDuG3Dg+qcntDuhoP5UX3exIGwIdit5BEwN7T31pacyX9?=
 =?iso-8859-1?Q?i+LWZXTnWz/bpt7Acl2YywXJ0lXe7s/vGVs74CHc/EkbjZL6a0BSvk8N6n?=
 =?iso-8859-1?Q?8MrC2wwpt5DLhoVCtmrKoLgdF1xGloJyqYTu1OdzURmXqAFxR4Y+KJ3IHv?=
 =?iso-8859-1?Q?M8YKOPTBSRB5dNXCKNs0xC6oRk/4/R50SThyTXhVmPhxBGint/fv+AEfQU?=
 =?iso-8859-1?Q?Ogho0pUQwQsdQLgoqZqPF6L7vU3tRC9S9bzvZxMsalXp+DWJwctVEmQsgE?=
 =?iso-8859-1?Q?fj0JFQZxCq27IqxK2xgrNgndpIJWzOKxZ5jpBANfa36BfCHhruFEaFJvuL?=
 =?iso-8859-1?Q?fQtiQc64YxgEOn8m5n4bewkeH0/r+L4MuanzRIRX/ajc3R9mccDFl5zdKw?=
 =?iso-8859-1?Q?Uqzm75Sc4FHMhIwgDeycOgJcbIUpBgxF55luR98ABwNOLe7nz8U876P6FY?=
 =?iso-8859-1?Q?0oB+uljwl3BRWXWjMtmP96Hrw9GkA/JbRYcfJ97OVA5NOZEXbZyxtuz5Sq?=
 =?iso-8859-1?Q?mYXTDE34PQW+qKwsCahpEVUzopyoTko8hS0MHlE5wVloUeNdEcrZzoxptI?=
 =?iso-8859-1?Q?gNTM+vEZDfz+TJ/H+svCkp/axWGlCVtl3KQE5c6PQ17cf2p7ZSO+CuOoie?=
 =?iso-8859-1?Q?AsCo9EyE6SYHC9wIfpZr3pM3hsjcf3gCArw3dg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rdhMzmWO2ARhmwO/momysJFZThJhGzf7mLQ4/wavG/IGES7+7UvIykR+sd?=
 =?iso-8859-1?Q?2QinBG7fOd/7SV0QMyxyOhhqKFi66EK+4OP1dGrGiQj1s25PtUQz0MFSrx?=
 =?iso-8859-1?Q?CMlUaDcJkFxnSZ3Jr96rPYx8tzuRBuPIXSx9rCm3bROGnsv+ieybrHyFNK?=
 =?iso-8859-1?Q?MGzxcB+OxJsZ3eYCUZgynpRDWEQPxme5j+TiSSv0Ci9xm/GfCTqNMi0tEr?=
 =?iso-8859-1?Q?spkakykokMwLPGpgjNBGg1drSANRQVO9Acf/1GMWC2g7mAo1fieIWRbRh1?=
 =?iso-8859-1?Q?jlxFV61H8bt2v5MrIBNp0dHYkbE7LBBIRbAkBwwgu1nwHmxtaJZQsVBExc?=
 =?iso-8859-1?Q?p17b59e/6HRA0qSoajTL/hWOrniDBNfzLS74AXO3iUqyI6KCiemwdHSdLd?=
 =?iso-8859-1?Q?P+7VwgACcJr/s41chEBeHW11f5eIyb47c1lp0Q9mqQdOeRuIngjx9g1Aa/?=
 =?iso-8859-1?Q?HC1muQEv9HIL+DZWhgu2pYFusZINziF/3PXCnJaZiibzzSjdnVvoiAQgCq?=
 =?iso-8859-1?Q?9f3qGCi0Q7GG7iRmxUAxBCG22AhHpSsCSqfuib/VcLhdh3EiBOlXO7ZjJq?=
 =?iso-8859-1?Q?3gKTyP12EprOJN6ujiJYM8XcpK/tTHGaPE/59/6iPC3+FZftgyz5prDzJ1?=
 =?iso-8859-1?Q?LD0zlt6rygLipUAHqga7f+H4EgNg56/ootqAGZJWWLqfRcp0unAMeSQSju?=
 =?iso-8859-1?Q?ySvhyJtbFyyFaCc1q8xgQdywFPkNSSYKsjN2YxOE7DhD0xwEfgvNGn8pgB?=
 =?iso-8859-1?Q?7Lfk23XWjtVTNUJx8tCkwWGkOeheMzI9PuPJyoVlYgOneYG/p/TrA1kUI2?=
 =?iso-8859-1?Q?mSiW0ov55hBxt8axgrX3obaWEzWkC/V/Gh+YSjyDpkTB1zOrXHy1HBa5J4?=
 =?iso-8859-1?Q?Iy0ZdpD09mq5ZifEcywWz/dMfmd3aNbsSFFQzVoUH85biHRAIlZcNtpPEu?=
 =?iso-8859-1?Q?N6asBZ7g+jIi3JDl9Q562rq9TQzaCGY/iJ24KR6LPU5wGYgtRko2KpUJvM?=
 =?iso-8859-1?Q?agNFnHo8x8vNGgFRVM3cTIG1ZSV716QfdolGD5FpUjh6RSeCMDLE5nsc3t?=
 =?iso-8859-1?Q?wmhFsQpjO82nWBjc9ayo6+c1nxMGVF2lDZR6qnr9wdPcMiC9ghUv41RyPK?=
 =?iso-8859-1?Q?6CMrlCka2bgfG5R1YU5X3YyTo8om5TUZdLHKNK6y8Gehyl/NvqPaxfuzrI?=
 =?iso-8859-1?Q?oRUJE1xS67DISuvyhWcbYKxQhOhbY09SDZe+Okkg3bopJ4yLo0U2OfQhsD?=
 =?iso-8859-1?Q?G/KCHu86w+5wqoWzLkoBvR5s/lPk8a85pnAYvQbBxjqzawp0SBYHz4NlTN?=
 =?iso-8859-1?Q?T4GIPQ2xyFMj9lkjnsoUwdP5NLlcPVLftsdeYGmYadXf48P2i6cyOJzxO+?=
 =?iso-8859-1?Q?5xZorbs4rFm9J4qS6AvPEXvxEsj8xHKC+pAXamkpCmLDWJQwl4fBe67N0p?=
 =?iso-8859-1?Q?jzeQdyDYVwY1DLzFnBSXe0ab/n+U7l65NzBtK/d+flygYR7zG3B/fw4NXs?=
 =?iso-8859-1?Q?B7gt55bj2SYyz7g+ozH98P9+a6Nrm7LOwhGVzw5ht90GrY+2vOCxtsmq2m?=
 =?iso-8859-1?Q?GAJ1lipBp6b4PhnhrDTxANy7tL6fWv4wpg9mBABaaAUKC+Tj47oEQ24/TD?=
 =?iso-8859-1?Q?eku60LPvGZYLxfu/ibCQAbyTE7vha2nGd52+HlNvf95pDHeVv0KZgg2A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4d8c66-016a-444c-9b7e-08dcdeecb391
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 12:05:38.5625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZfoF75STJVS0WYcil0UsZR2TScf63tvrPQFfLVdfKW9uALiXCeUo7xTnbaxBR+kb1MtDg3CDOGUIeSRLBvGacVU2p+pHBQQGIvEKc7MlEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB4426
Received-SPF: pass client-ip=2a01:111:f403:2613::705;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Sep 2024 09:25:47 -0400
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

Skip NaN mode check for soft-float.=0A=
=0A=
Cherry-picked 63492a56485f6b755fccf7ad623f7a189bfc79b6=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 linux-user/mips/cpu_loop.c | 6 ++++--=0A=
 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c=0A=
index 462387a073..07c1ebe287 100644=0A=
--- a/linux-user/mips/cpu_loop.c=0A=
+++ b/linux-user/mips/cpu_loop.c=0A=
@@ -304,8 +304,10 @@ void target_cpu_copy_regs(CPUArchState *env, struct ta=
rget_pt_regs *regs)=0A=
     if (env->insn_flags & ISA_NANOMIPS32) {=0A=
         return;=0A=
     }=0A=
-    if (((info->elf_flags & EF_MIPS_NAN2008) !=3D 0) !=3D=0A=
-        ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) !=3D 0)) {=0A=
+    if (info->fp_abi !=3D MIPS_ABI_FP_SOFT=0A=
+        && ((info->elf_flags & EF_MIPS_NAN2008) !=3D 0) !=3D=0A=
+           ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) !=3D 0))=0A=
+      {=0A=
         if ((env->active_fpu.fcr31_rw_bitmask &=0A=
               (1 << FCR31_NAN2008)) =3D=3D 0) {=0A=
             fprintf(stderr, "ELF binary's NaN mode not supported by CPU\n"=
);=0A=
-- =0A=
2.34.1=0A=

