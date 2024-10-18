Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB5AD30008
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1mta-0000K7-Jo; Fri, 18 Oct 2024 09:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mtY-0000Ch-Id
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:19:56 -0400
Received: from mail-am0eur02on20724.outbound.protection.outlook.com
 ([2a01:111:f403:2606::724]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mtW-0005gW-UI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:19:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMCfofQU90xu7WbAtXPv2e50FFuq5cHIt7JhET372lRnc/e49vlodOCAjLLN9Na4FqyAP1JLOW3K8fPa0EJ9mfsLId4ax9YKHapOxnzYkMzb6HAB+cJoUKvD+EJMzqkD+LwsqF9XgXVFNm2g5WxZjE5kT/Zcad1wVkR3MJbv0z6udwPgh5xs9Nx2OIAW1XsVNvwW2LD4f3sVJdwHmQLfuPCyuoJtlthp8udaXTDehB4Fjg4f6mzPiGsFE91DQmzxX5ynY3U6SwQyTEDcNRicSzlpCZoIQi2gdaWy5W9E0cqFD3m5Uri25HPa/0dlpM+ksEn3PH2R1/3PzG3RwQiVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG8DwdtWCuBlvLd3g4B+ZH8HYmTKV2iNHqD+y3XPEcg=;
 b=Svc64ZkdKgjhlACmPThfEZMG3KdZbqBpFaVkEMXFmSx+7A9CdQtvgGQ+LBzbGh8pvUbrNosuyPlV9MiXe/Geeq4dRQpW6eVF/sankrvZp9jwm858y8KrIapO6GczVfXMFz/peXIVMXFnv6yWo00JL4b/Obx4bCnV5nz3u70A9cQcoEvTrA7doyj7EDZqcorFIGxlfgO/G21x0wzrSz5yJ3WxgpOIAmxbki1nn/XLXDEeilUQrfbemeGN+LgUqv4hDwzR0vQ10q+rZU7v2/yyPlTQua7iputXiuMwOe/v92H52DoecdqXSkLZGRL5BiS85/BmeSS09veKmwdmQ0IUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG8DwdtWCuBlvLd3g4B+ZH8HYmTKV2iNHqD+y3XPEcg=;
 b=hFueDQmWD9eMR1+Z8kkyJl7RBKXUnf9zVpChSIpMtBc5QQphnHY9DM2aW7RbxyQ5GfYwpDH8h5yDUZo2XJtR0XFRg2NaTkqhmwHVL++6Yy6suXQ1tHyQSLjgGNDF/RCory5MHRJZByORiMdend6xktabXNH1Tkv4qrl25DO+deePYj6IBJ1FvIgFBxaE19xKyWN5gZj6G3OqZZCfnDO3phqxB6Z5HfoBhtztk9XK7XxNqTbt6Do/9qFiy7+cqciF96UAAias95ND6J+U4bB7wZwMB/mb74l31DlSGmMvJ0cNbldb1yPgyXdaYk2ghUSC7ZzuZjNS0eGo1ck93BnGpw==
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::13)
 by DU0PR09MB6635.eurprd09.prod.outlook.com (2603:10a6:10:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 13:19:50 +0000
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2]) by AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:19:50 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v2 4/8] Skip NaN mode check for soft-float
Thread-Topic: [PATCH v2 4/8] Skip NaN mode check for soft-float
Thread-Index: AQHbIV0ja7PIGqNK+UKcpB1JtQwmEg==
Date: Fri, 18 Oct 2024 13:19:50 +0000
Message-ID: <AM9PR09MB4851C847B4402BD6C923407184402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4851:EE_|DU0PR09MB6635:EE_
x-ms-office365-filtering-correlation-id: 6658285b-331b-4df0-cbd7-08dcef778bf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ch97+Lf2pC9vobOXk5i5BbAIi3jbKQXx13KkcA58YU8M68rl5bECLpFdTX?=
 =?iso-8859-1?Q?HM2/dl+0KmZOGlgCqnskG8UzYWuI0CkGi+8RMU8FAwDQWEXIH7p8LFhktM?=
 =?iso-8859-1?Q?bCxHQtX0Eq2ZmLTVllxooQiNSmG2nCvoyEnr4nDKzxnAgfl+GmkPAIE6S3?=
 =?iso-8859-1?Q?O3AoNK/KD1vuzWAvWoAv/y3OQ65k14YSPAaE6T2rXg4ILj98GKDmSxMu3+?=
 =?iso-8859-1?Q?Iyh5eCq/89KcJvvJUt9ZJKLhJZPCmTiiOtux4/YEuy1lzja7h5kRzJLgkn?=
 =?iso-8859-1?Q?L/j5CcOJaYl6uBFIaRYFRsCfpMZ+5kP4Kc9K/Ft5ckygpDGTRio58L8FWv?=
 =?iso-8859-1?Q?QEyI+lo/tl4oHcRkpdSkR/XdoiGW3OmZ2wUJUOt5IoRHpKbWst6E5cEHd5?=
 =?iso-8859-1?Q?zR1SjIO9EDlVMc7eYTeXO9ws46E7VV0ljls0YscrqzqwlHfzH1QGAbVqGP?=
 =?iso-8859-1?Q?unMpvKaKYfFtQmwhuILgWbeLC80GIDLAdJ3DmqCIcYy7Q4TvL9mNSc5ont?=
 =?iso-8859-1?Q?YbmPb6TxR7FrazMjHCdZKVzRR43sNxhnJrRxqWrCsLptuScCAsHTifbGmY?=
 =?iso-8859-1?Q?HGopkyAi4fazrS36ZG99kNrZ5gEheg2hUxZ7lMpZiDla8WeQ/BC0UZaH7r?=
 =?iso-8859-1?Q?Z41G5GoNq59UUqx8JxhVcE0OtoEd5SLGEaWAZ3VHURZqrLumM1tHi905QV?=
 =?iso-8859-1?Q?a+95fBVRfDx3leybqr9aLPh3PopVaKsqhOgPrkYXe05fd8GMa4m/xzg+H6?=
 =?iso-8859-1?Q?2fmmBC+9iRi1MvDmYwwIGosEeOrWoerVO/JL0GUbkUl9VCBx4jPY4yPyBm?=
 =?iso-8859-1?Q?u+W8TnUdhKi3jvRvL793OkeJ8+63qmcxPrZs6DBO3/A+O6dXAFn6h+zYMD?=
 =?iso-8859-1?Q?lbOmHc5+x7tqv9P7Bw7dGflTezXXjKB+YPpfbkuohemkc+mmPjq+7soP7o?=
 =?iso-8859-1?Q?eFhI+Te/J4x8ZxUkMit8i1KLMshCxu1g8gjBXYkiuhgy1LFsA+voKuzJOq?=
 =?iso-8859-1?Q?+FU1ZhidjixlfZSI1F+fj4fsRPXg44A87KI6WBnVYYy3kTapehh484EtTx?=
 =?iso-8859-1?Q?QJIDWmKADBJGwTpD+krT4fdFab59fknnbVpUlkf2gJyyPv9mAhpbCNLGtQ?=
 =?iso-8859-1?Q?Waq5OjaBoGspJzQJ2jORbVqaJT3oUb4eUHr0m82M9ZQYPHzN1cJObpqGId?=
 =?iso-8859-1?Q?6FwU3++QY4ry2Sf08tU+ewIKui84LMWYw10JQZ6UzSmgQD4bC0UBP7bhaK?=
 =?iso-8859-1?Q?zfuXzekfW7qfOXz32hkm+h20mecXk0WLrPjYAn71vMmGLqY55MFbO17R70?=
 =?iso-8859-1?Q?sthWmNqMZUKD04H0QAqPHJA2FWsFlcEUALSUVKp0rZwDbPy8j+FhjNVEaO?=
 =?iso-8859-1?Q?yl0IOBBSRzNbcw1j18iQPkoMhrH6hucY7YMgr/eIx0RbgRj25MGkq++PZ0?=
 =?iso-8859-1?Q?kExLLpOOIaHZzPiT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4851.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0A5NG5a6tX3MjAn04lqlwDL0cfHjsjh7ouHkNNxjBHsSBPD9ZcX0VJYIK5?=
 =?iso-8859-1?Q?gIBeJ/Plikm/Z2G3ZjyENsUjb7AqfoI900E+9t7coSnM7mbpvHgHs2eQVL?=
 =?iso-8859-1?Q?Z1WdNSRhdTCfeZsXAHFfiePoTDD6G4vrmtxVJHn+ru7hbPdb90byWoQ9kb?=
 =?iso-8859-1?Q?Y5z5T7zEpLUlRQiWZS4vYGBhDSMstD665FgmoCWWFJJN62kSlvW3LTpQ5h?=
 =?iso-8859-1?Q?1UTjq8tsk62BPI1EdivjoudxNOKD/aiW4whAyVhtjfZs/x4fq2SvaAtZxg?=
 =?iso-8859-1?Q?KAE2lpTxpp0GdDG7IPS9RRfl/KMLHgnKdXS7DXaPH4PX+PfJ6HT0U3xuJ1?=
 =?iso-8859-1?Q?dlU6gnxpDeTBNZU/PRUMw0WxZcDShVToRUzyuHs2YdUiU7wyjCA5+in7o4?=
 =?iso-8859-1?Q?i4i/gWVX9nJosTbxqEzY9gbfmEKoJcrynp3jTMXUVRgZ7h0W18djHw/zeb?=
 =?iso-8859-1?Q?Anafq4GgQp1kjLVLMuAsr2FBccBTA6GK62ETKrl7NYwkAZBKCs5KK1cT8L?=
 =?iso-8859-1?Q?TcT4I6Xcd33yWdgLXKvha43fTG8rsWg4rAeDrRCdNA1t8FjcUbgHP/PGUI?=
 =?iso-8859-1?Q?kf+xprWdiWmkr1XHNVT4a1MKBfXEgYa1z16XjV9NVCtDFPw/KCYnQECoS6?=
 =?iso-8859-1?Q?VgNCI9q1L6ENIPYiIpYdAUHQW3eJl8jBQeQ672Bp6CWT0h9JxlyHJ57Oum?=
 =?iso-8859-1?Q?vvMMpP6uEsrl19VDzcBBNRgYnBh1PkV3qjb93V8bmcsiBeJXb2KDF1TOMu?=
 =?iso-8859-1?Q?DGgyVixHY7kgZIvD5h00ljWESNRIK15TvxpnJu0TtB7vxurmnsnoSYrlyn?=
 =?iso-8859-1?Q?AgEsAYZAEZRq+CN4S/dkQolDqeiZTAZeyvFlCDFgANE694J82PLid1W97y?=
 =?iso-8859-1?Q?T/3X78kzxF04JFdWMNGB2K1AATeOvpfzBGkNTZljDhroTL5e2W1U7C4Try?=
 =?iso-8859-1?Q?6TBd6RWV57fhfv9WXmvJESNnN1L3mX7LrY9g3vLpVTomM/Z7JoZai5Iahc?=
 =?iso-8859-1?Q?dOR58yXXJF0N3aOcHNDZtjAccpuCMuJV2J+A7pBVVkyq1ELP75txG1Ko1e?=
 =?iso-8859-1?Q?VkEBV7VF9fd9PQfwK1JK+FYFajJvTu/re3nTrGrhyUZZ8rKBtJoPsoo1c9?=
 =?iso-8859-1?Q?6ZZGiAFtCWQnna89GaNPJotUlbpobntuDh5KTf4gSQpblBEulPUVKqRch3?=
 =?iso-8859-1?Q?4ROnLOoZHDcYFuOx5Reb4HtHC5ffAwX/jhPa78ns3PZaVFZosxXbtBXbls?=
 =?iso-8859-1?Q?ELLnv4GKA0i5dFThTJz4aPRq5aQ6YJMA3PsL2iL9GCulTB6PtACQyZtqYR?=
 =?iso-8859-1?Q?Vlylq/a+CpjEDxTfUDASsbervVb00DK6oE7OPqoF0a82YLOeEtj9zdDoHF?=
 =?iso-8859-1?Q?iFSuq7VnLtEl8tyhI/odD/G80Ip4EqI6QUgos2MuHwUPiKqk1CU7uaog55?=
 =?iso-8859-1?Q?orO4QJL9DpdFFR8uWH1xIP3C/98wxju+xvADLQ6pdQWsuszw99doG3uXiQ?=
 =?iso-8859-1?Q?sZKfmWiBfiMtrSX+T1yvRk8UwXX6VYAArWEPc53AhNDFmzqbBTusdGi0H9?=
 =?iso-8859-1?Q?Skwq5pPgfQcP9wzs6msAAKkVPr0fBAs3mJc8sq66er6v4qydSZDy80PQB1?=
 =?iso-8859-1?Q?31+AEhaE6iMUWyi1t+2kOS9R1zHNMM8jvN4yOopXfyGbNFTDSS7ccHqQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4851.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6658285b-331b-4df0-cbd7-08dcef778bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 13:19:50.7777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnZpX1muyfnD3wYLKopLpOGbbx7G1PlkW6dE1CGwsEj8A4x7qJ16Pym55P5+92Xl3VQtR8gKqIxzCVbXYJSdFJtvlkFZzr9FNXDkliF0co0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6635
Received-SPF: pass client-ip=2a01:111:f403:2606::724;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
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

Skip NaN mode check for soft-float since NaN mode is irrelevant if an ELF b=
inary's FPU mode is soft-float, i.e. it doesn't utilize a FPU.=0A=
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
2.34.1=

