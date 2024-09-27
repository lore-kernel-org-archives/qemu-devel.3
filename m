Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D49CDD1AE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAzF-0005vn-U9; Fri, 27 Sep 2024 09:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9pj-00040R-97
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:12:27 -0400
Received: from mail-db8eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2614::700]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9pg-0001OH-G5
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:12:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/B1AKCk3gloLtJlQPfUK9ts8x/tRarica2QekCfmNXp1t3eeD8gqBioL2NlZopWtIi0uW+w4OL3LRSSqn+aIDg2CWW09pDpjIvy1kXGqvGBX7h2d71ZG4fwdgGM/HxJp7b1vVqOCLGt/hlUE2ByLKAXt00MUN8CmcOIHo/dmOMdmKwGZusH/MFS/err1AwiY2NBgMl/7dhuhY3QoKWZnJlfQOXT4606Oo0EHWGiVyrR+U/5ZV8GtPldV1ORUCxEgzVyEzwTZhKoYvsqaQlosO2Hn8VnQpaDK0ldf4c3EGi7lpTWOF0PyO++lvGhdPb0UQ82QfdgACg+zwIny/1Azg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2+QTR9mUH+zXO5msczgYFd7iKvZ39oTTgXaZLsCQLk=;
 b=y2w72+poo7htYUAmestEXNHwu2rH9i6qg9jPKOyf9iA+zyIH29bUJDJ+Hu7cdbYkrvj/DFfw8aw6sjIR1rOJb9wBf0ShbVeH8qTgGVzupakJnwqTjTuAVyaBJ1oZew2nu6x5tXTEkEdBtkAcjLwKoWoxAywpqPnu979kt2oM0ZWnzsc0lLm0Ki/aMKMlGwb7F4bLOPOY2n5meIZ/MAvhAZGXOn2Nr80rqDRAvWH1X4ZptUswWrC/6wxl8F5jy3tRTnVFDqvXjNWyoGWkPjSLd7uu2lb7L9YRmh2mYY2yuKbF3uWwBhGT9XS0PXEN7eZfSzIMlN69AYpge7ZRnq2z7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2+QTR9mUH+zXO5msczgYFd7iKvZ39oTTgXaZLsCQLk=;
 b=BqRTsE/K2tYCOGJhuQKh+jWlsaqiOnotK1PyzwjiBk4bM7U+B2cqUEq9ZmxvsCJfcgE47CUgUMpN35RrM9kWzvAxXskM86qgLN+IaNS6Zlg7GE62frD8bsOEt1nTT9yj4DUoJKgJunY34xsEKUSYco9RoA6TNcz3XRxyzPGUYnY4JMsOgGordXFy1ax9n/A6iWkuhE7G9K0iWNm3JAg7XOfH2CQHpgmeXxLnK//o63f7SZGMOLcYLiWJEIbxFCgwHgHxy+75eexQxChQMMbgHrmFcCn6A+M+dmUs3U6ukN8PIlEoqRUUkT+chNSZRQjHBFMIgFSZDc/UtIG2NpHewQ==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by GV1PR09MB6906.eurprd09.prod.outlook.com (2603:10a6:150:1ab::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Fri, 27 Sep
 2024 12:12:17 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%7]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 12:12:17 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>
Subject: [PATCH 6/8] Revert use of clock_gettime for benchmarking
Thread-Topic: [PATCH 6/8] Revert use of clock_gettime for benchmarking
Thread-Index: AQHbENXwCSxMwStOOE+aS0fRSePVgA==
Date: Fri, 27 Sep 2024 12:12:17 +0000
Message-ID: <PA4PR09MB4864AA639F005B9B625E9278846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|GV1PR09MB6906:EE_
x-ms-office365-filtering-correlation-id: 7298f89a-11a0-46c3-7adf-08dcdeeda134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?d7Dt7nvq+V+/ADBWf0trAUquzQvuV0I0Vxf7Fo4PHZvlR7xpom4CEXG83g?=
 =?iso-8859-1?Q?WKc8VuL8nQwFFFfbBfe398/LFhUprHElApB9mgCEd8inW/Jo8YKbjBiU1l?=
 =?iso-8859-1?Q?9Vny0WDBYPXbGavz8zl6Qr8TquSCUWj1wZVCTrWWsSIznus8XEziiPrZ9j?=
 =?iso-8859-1?Q?XEJdsHYstjua06GjqtdSEYo66aFsCxCYTlGPELjJnvc/Y7WwiNmz6NY8PG?=
 =?iso-8859-1?Q?tspPbQ4USv+6umTWRJ2RX4iq6oyeGWT3EqOPgLcknjPje/Vjj9OGd8CFci?=
 =?iso-8859-1?Q?guIMXAZkDrKQEaVhiCnz5Xc8hBXO4fkQsZQgZhEcVZgowfpqppDPSbsIFg?=
 =?iso-8859-1?Q?HV4nEj61dUzoJqoKzfWmojrnpDhDjEP3exjKcm3HxiwKBDqElx+sAQmnk4?=
 =?iso-8859-1?Q?VsYaZIjph/9YukN7j9/oSefSaUG+c6WcyPashmQopjBqWn9gvnOan9uGeI?=
 =?iso-8859-1?Q?8SYEvyjq9cdM2JHIQsT53hQsDC1RsGH3SP0bif8jA5v9lxTzkuj3SZmgJ/?=
 =?iso-8859-1?Q?Sgc5EsBFImeXmFxO3n6v1ySIrEB0RIAxCQoTGRsjr8hPe+sMAwPKDH4BG+?=
 =?iso-8859-1?Q?BJDecE9CXbwlqzqD4LKtR/ZTx5WHxyqtptABJmUww/6WDZeQ+PqlmBXy52?=
 =?iso-8859-1?Q?b70TOe/sk6lALoIxiEUT3wivXvd03B1NlCsYJxC9q+OjIkJm+O7inCVtp9?=
 =?iso-8859-1?Q?5XucJmNwGDBcNV4aAISiTg4hpejSbM98QSSZ3unL4BJMTKLHu5jSxH5fVU?=
 =?iso-8859-1?Q?BBULBUJUCUqNbNuTjiROs5PCzmsW4k5vMhLtadsZrbY2hn3blxcREH8z35?=
 =?iso-8859-1?Q?OhHGDmVCcAkwMzW/1F7wmZ93TAM2M4ld4jFWWb4S0adQJiLMC0NPsidg7t?=
 =?iso-8859-1?Q?N2I2cBPVzzoJrO3v4Ek5JOO6mZP3YYJeQEtDECfD8Jex1xd3rQSYOGWm9h?=
 =?iso-8859-1?Q?hJcP+hf7J3CQb/SJAmxEcyBWsFbMYHDLzEMEYRPFq7F2Cm1CVyh00ip0pt?=
 =?iso-8859-1?Q?vvfxQAq/e5Ae0rT5RpUlJXITVdsAFodVaZ506g2m/VkZP2EUF16BVDq+H6?=
 =?iso-8859-1?Q?xoeX/nqUlveqdm7GKpV9wFm9J20jRzt0vn/r6tLNWwTX9UeYM3AExdOlwO?=
 =?iso-8859-1?Q?kXtv4AxGsYUy0mWWUa/DvVL3bikf+GSSDvIQenzKdw2ckcTlBZPlljU7Ww?=
 =?iso-8859-1?Q?M1uv6rwrwTZvgT3poZZV+L0DMOg6hZ+vieOqotV//ShRQFad1M6DVDOzjy?=
 =?iso-8859-1?Q?cRIRIhyH2tAgSagG3sXAS4XXC0BMMQTJQH3rO/asqsr60uzfTSCBesg4dd?=
 =?iso-8859-1?Q?FhtUy7TZnAjYY5wIjSq495Rkt/14k2ABECN1tROGolery7rSqBGsReV4fX?=
 =?iso-8859-1?Q?emU3u2ZUJy5qdG7mhc3y/N+u/WV2vxtFpBiM2nKt8iStqd9qTq/B3DQtA9?=
 =?iso-8859-1?Q?eor51v+GCPwKJdw4jEN30+YIsFe3BQR8YRQ9SQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VnnyblhtwPUPkPB0wWbQu1gkDqepe08zdHymvMVjPeOR29nhd4SZvYnVst?=
 =?iso-8859-1?Q?xuco9pGLCtS7495ZkE9EPJwjMFThWiNCMvUBiKFJNxoJ5qdXPSRfUm0dYk?=
 =?iso-8859-1?Q?1dPLklAH6dp0HwfzCLYh89tgKf76Quesje/f2cnMnpyzihLWx+0cv0MyeT?=
 =?iso-8859-1?Q?2mTtlS0AIMZQFxFDxEHmdp+3b9211U/+fhhpsb7t/iGfB5SgVqjv02JsHI?=
 =?iso-8859-1?Q?MxFEtxiNIGpa7fIo8/5M1aBXJIEE4oUlnQ6UQmc6otAExQw+sx2UezkdkC?=
 =?iso-8859-1?Q?Ug0KICF1QGcBXN8ApKZR9cUeDAgejL4N44R/JN+q8Ppofvpu41R0sqblBL?=
 =?iso-8859-1?Q?wWZopZRkOzYXSpo0A53hoqOx3sqmV8eE6d5eIO3hgcfc0AjZ/H+8pnqMOo?=
 =?iso-8859-1?Q?nGdflM6JlLv0pwM6ETBywfzX3CNrG/bmxmL7MZ4PicvpMBFIzrNerf66vY?=
 =?iso-8859-1?Q?T/QvZGOkohVy8zE8nWea1aCC9qcARhUWnoSZy3mM3QTf0zmvTMnLtC+BjP?=
 =?iso-8859-1?Q?BCFsYngpFABxRg0zeegLQlb20bBOoqR8hm/h8182cP/5EctDE2ls3wsYan?=
 =?iso-8859-1?Q?y7n2clHItsEPFFG/qjsNUzHxzaQKBjvGKmfy4+OwETJOeB6NdEgj5KTPUp?=
 =?iso-8859-1?Q?JQsxdAzgk+6yQ0dhrAmp9ARyq8C2ijxXloyqoNb7eHcKqNO1nOuhoV2z8c?=
 =?iso-8859-1?Q?pGMBWnIMc0uY/wrwc/vod/3dGr/bQajTPRQDkftDjCyvJyrRQEtsNl/uK3?=
 =?iso-8859-1?Q?Mv8ERSefqqZPGRHDcxGB800Qoeepcax7DnJnTN0ucvB8m8fFIYuasfzuJ2?=
 =?iso-8859-1?Q?mSfhPJORftLli9pGnRtxFIpfbbWMYqtjeRuRFspPS9HJM5L8HcN3iS/6sQ?=
 =?iso-8859-1?Q?UvnCTDR9ZYDGUp9pYA5tREbZ3unisM6Q2A/nhmkvhwg1qRyWD79ZZWK+i7?=
 =?iso-8859-1?Q?toCC6aI1advpFpicideaX0hlQwMOhx4twg8N7DNZmo/P92rzknuJo5vhh0?=
 =?iso-8859-1?Q?1bJ1sOIEd2O9pCr/+s9yz+MYBti1xazHegV7igB03oWH86l7D8DBSlRVfO?=
 =?iso-8859-1?Q?weVqcqAWVUNkI+cs+hIUGUoZ/jdIQhlkyHp//mJFdNLH7S9HcmRUyf+i3O?=
 =?iso-8859-1?Q?b2ZPMbek57XqFhQY3LllLANibKK6LYFtOF/HBW01qKdMCe51k5awW2zNWq?=
 =?iso-8859-1?Q?yclUOZRdu4KoTbuo1bRxdrnhVt/Bji0wpO0ZCIIkUc9/Yz2a5OC1SOHEQZ?=
 =?iso-8859-1?Q?6skAfJP1praYagryrZnn+POSeoQFL8nq2MYW9xAzUqRPvvYGh1acIQHnaI?=
 =?iso-8859-1?Q?Ht8BfSxof/trBKYZ4NiqPz/9pYkcWj+cfirALOzGzh+ThWzBL7U/blhBrE?=
 =?iso-8859-1?Q?/7o4nr5US784D2HooC1qQIkEW+soZ7onBC7fquht+aa99Sasx3mstAgq0l?=
 =?iso-8859-1?Q?ehMdiKcbkgN7/UrPfV9Aw5DqMCc6ShqXdtrXJumJJv6BaMwUS+OiRePEEJ?=
 =?iso-8859-1?Q?mc5GORM8KRPOec8/eaJrOqkiI2goJQ9RzToLbEZSfg4EGEYfYfqar4Rukg?=
 =?iso-8859-1?Q?DsND45+P79yOeZTF7Qhdk44ryuDCvsQbTBHMpWM/5m9Pl6+LIDjYU6OEju?=
 =?iso-8859-1?Q?+02thBRsROrlJhZvECru+vDGJ8TqCyAIc0WWXCCjTD2gJ6tJklp+6zew?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7298f89a-11a0-46c3-7adf-08dcdeeda134
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 12:12:17.2672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g7ZUz48v1NYRDfx2Wo92FNkJ2PUfbGOH5mo1Bz4X0zCGDPCq0uMGAUSJYTNqYd2HwIRJfs63l/FhJsuQlp5EHSisVteh+9sNWZYflnfJBR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR09MB6906
Received-SPF: pass client-ip=2a01:111:f403:2614::700;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Sep 2024 09:25:48 -0400
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

This patch reverts the commit (with SHA=0A=
50290c002c045280f8defad911901e16bfb52884 from=0A=
https://github.com/MIPS/gnutools-qemu) that breaks for mingw builds,=0A=
where clock_gettime and CLOCK_MONOTONIC are not available.=0A=
=0A=
Cherry-picked d57c735e1af1ca719dbd0c3a904ad70c9c31cbb7=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 qemu-io-cmds.c | 77 +++++++++++++++++++++++++-------------------------=0A=
 1 file changed, 39 insertions(+), 38 deletions(-)=0A=
=0A=
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c=0A=
index e2fab57183..a846746553 100644=0A=
--- a/qemu-io-cmds.c=0A=
+++ b/qemu-io-cmds.c=0A=
@@ -259,21 +259,20 @@ static void cvtstr(double value, char *str, size_t si=
ze)=0A=
 =0A=
 =0A=
 =0A=
-static struct timespec tsub(struct timespec t1, struct timespec t2)=0A=
+static struct timeval tsub(struct timeval t1, struct timeval t2)=0A=
 {=0A=
-    t1.tv_nsec -=3D t2.tv_nsec;=0A=
-    if (t1.tv_nsec < 0) {=0A=
-        t1.tv_nsec +=3D NANOSECONDS_PER_SECOND;=0A=
+    t1.tv_usec -=3D t2.tv_usec;=0A=
+    if (t1.tv_usec < 0) {=0A=
+        t1.tv_usec +=3D 1000000;=0A=
         t1.tv_sec--;=0A=
     }=0A=
     t1.tv_sec -=3D t2.tv_sec;=0A=
     return t1;=0A=
 }=0A=
 =0A=
-static double tdiv(double value, struct timespec tv)=0A=
+static double tdiv(double value, struct timeval tv)=0A=
 {=0A=
-    double seconds =3D tv.tv_sec + (tv.tv_nsec / 1e9);=0A=
-    return value / seconds;=0A=
+    return value / ((double)tv.tv_sec + ((double)tv.tv_usec / 1000000.0));=
=0A=
 }=0A=
 =0A=
 #define HOURS(sec)      ((sec) / (60 * 60))=0A=
@@ -286,27 +285,29 @@ enum {=0A=
     VERBOSE_FIXED_TIME  =3D 0x2,=0A=
 };=0A=
 =0A=
-static void timestr(struct timespec *tv, char *ts, size_t size, int format=
)=0A=
+static void timestr(struct timeval *tv, char *ts, size_t size, int format)=
=0A=
 {=0A=
-    double frac_sec =3D tv->tv_nsec / 1e9;=0A=
+    double usec =3D (double)tv->tv_usec / 1000000.0;=0A=
 =0A=
     if (format & TERSE_FIXED_TIME) {=0A=
         if (!HOURS(tv->tv_sec)) {=0A=
-            snprintf(ts, size, "%u:%05.2f",=0A=
-                     (unsigned int) MINUTES(tv->tv_sec),=0A=
-                     SECONDS(tv->tv_sec) + frac_sec);=0A=
+            snprintf(ts, size, "%u:%02u.%02u",=0A=
+                    (unsigned int) MINUTES(tv->tv_sec),=0A=
+                    (unsigned int) SECONDS(tv->tv_sec),=0A=
+                    (unsigned int) (usec * 100));=0A=
             return;=0A=
         }=0A=
         format |=3D VERBOSE_FIXED_TIME; /* fallback if hours needed */=0A=
     }=0A=
 =0A=
     if ((format & VERBOSE_FIXED_TIME) || tv->tv_sec) {=0A=
-        snprintf(ts, size, "%u:%02u:%05.2f",=0A=
+        snprintf(ts, size, "%u:%02u:%02u.%02u",=0A=
                 (unsigned int) HOURS(tv->tv_sec),=0A=
                 (unsigned int) MINUTES(tv->tv_sec),=0A=
-                 SECONDS(tv->tv_sec) + frac_sec);=0A=
+                (unsigned int) SECONDS(tv->tv_sec),=0A=
+                (unsigned int) (usec * 100));=0A=
     } else {=0A=
-        snprintf(ts, size, "%05.2f sec", frac_sec);=0A=
+        snprintf(ts, size, "0.%04u sec", (unsigned int) (usec * 10000));=
=0A=
     }=0A=
 }=0A=
 =0A=
@@ -467,7 +468,7 @@ static void dump_buffer(const void *buffer, int64_t off=
set, int64_t len)=0A=
     }=0A=
 }=0A=
 =0A=
-static void print_report(const char *op, struct timespec *t, int64_t offse=
t,=0A=
+static void print_report(const char *op, struct timeval *t, int64_t offset=
,=0A=
                          int64_t count, int64_t total, int cnt, bool Cflag=
)=0A=
 {=0A=
     char s1[64], s2[64], ts[64];=0A=
@@ -707,7 +708,7 @@ static const cmdinfo_t read_cmd =3D {=0A=
 =0A=
 static int read_f(BlockBackend *blk, int argc, char **argv)=0A=
 {=0A=
-    struct timespec t1, t2;=0A=
+    struct timeval t1, t2;=0A=
     bool Cflag =3D false, qflag =3D false, vflag =3D false;=0A=
     bool Pflag =3D false, sflag =3D false, lflag =3D false, bflag =3D fals=
e;=0A=
     int c, cnt, ret;=0A=
@@ -825,13 +826,13 @@ static int read_f(BlockBackend *blk, int argc, char *=
*argv)=0A=
 =0A=
     buf =3D qemu_io_alloc(blk, count, 0xab, flags & BDRV_REQ_REGISTERED_BU=
F);=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t1);=0A=
+    gettimeofday(&t1, NULL);=0A=
     if (bflag) {=0A=
         ret =3D do_load_vmstate(blk, buf, offset, count, &total);=0A=
     } else {=0A=
         ret =3D do_pread(blk, buf, offset, count, flags, &total);=0A=
     }=0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("read failed: %s\n", strerror(-ret));=0A=
@@ -904,7 +905,7 @@ static const cmdinfo_t readv_cmd =3D {=0A=
 =0A=
 static int readv_f(BlockBackend *blk, int argc, char **argv)=0A=
 {=0A=
-    struct timespec t1, t2;=0A=
+    struct timeval t1, t2;=0A=
     bool Cflag =3D false, qflag =3D false, vflag =3D false;=0A=
     int c, cnt, ret;=0A=
     char *buf;=0A=
@@ -964,9 +965,9 @@ static int readv_f(BlockBackend *blk, int argc, char **=
argv)=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t1);=0A=
+    gettimeofday(&t1, NULL);=0A=
     ret =3D do_aio_readv(blk, &qiov, offset, flags, &total);=0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("readv failed: %s\n", strerror(-ret));=0A=
@@ -1047,7 +1048,7 @@ static const cmdinfo_t write_cmd =3D {=0A=
 =0A=
 static int write_f(BlockBackend *blk, int argc, char **argv)=0A=
 {=0A=
-    struct timespec t1, t2;=0A=
+    struct timeval t1, t2;=0A=
     bool Cflag =3D false, qflag =3D false, bflag =3D false;=0A=
     bool Pflag =3D false, zflag =3D false, cflag =3D false, sflag =3D fals=
e;=0A=
     BdrvRequestFlags flags =3D 0;=0A=
@@ -1190,7 +1191,7 @@ static int write_f(BlockBackend *blk, int argc, char =
**argv)=0A=
         }=0A=
     }=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t1);=0A=
+    gettimeofday(&t1, NULL);=0A=
     if (bflag) {=0A=
         ret =3D do_save_vmstate(blk, buf, offset, count, &total);=0A=
     } else if (zflag) {=0A=
@@ -1200,7 +1201,7 @@ static int write_f(BlockBackend *blk, int argc, char =
**argv)=0A=
     } else {=0A=
         ret =3D do_pwrite(blk, buf, offset, count, flags, &total);=0A=
     }=0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("write failed: %s\n", strerror(-ret));=0A=
@@ -1260,7 +1261,7 @@ static const cmdinfo_t writev_cmd =3D {=0A=
 =0A=
 static int writev_f(BlockBackend *blk, int argc, char **argv)=0A=
 {=0A=
-    struct timespec t1, t2;=0A=
+    struct timeval t1, t2;=0A=
     bool Cflag =3D false, qflag =3D false;=0A=
     BdrvRequestFlags flags =3D 0;=0A=
     int c, cnt, ret;=0A=
@@ -1317,9 +1318,9 @@ static int writev_f(BlockBackend *blk, int argc, char=
 **argv)=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t1);=0A=
+    gettimeofday(&t1, NULL);=0A=
     ret =3D do_aio_writev(blk, &qiov, offset, flags, &total);=0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("writev failed: %s\n", strerror(-ret));=0A=
@@ -1355,15 +1356,15 @@ struct aio_ctx {=0A=
     BlockAcctCookie acct;=0A=
     int pattern;=0A=
     BdrvRequestFlags flags;=0A=
-    struct timespec t1;=0A=
+    struct timeval t1;=0A=
 };=0A=
 =0A=
 static void aio_write_done(void *opaque, int ret)=0A=
 {=0A=
     struct aio_ctx *ctx =3D opaque;=0A=
-    struct timespec t2;=0A=
+    struct timeval t2;=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
 =0A=
     if (ret < 0) {=0A=
@@ -1394,9 +1395,9 @@ out:=0A=
 static void aio_read_done(void *opaque, int ret)=0A=
 {=0A=
     struct aio_ctx *ctx =3D opaque;=0A=
-    struct timespec t2;=0A=
+    struct timeval t2;=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("readv failed: %s\n", strerror(-ret));=0A=
@@ -1537,7 +1538,7 @@ static int aio_read_f(BlockBackend *blk, int argc, ch=
ar **argv)=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &ctx->t1);=0A=
+    gettimeofday(&ctx->t1, NULL);=0A=
     block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,=0A=
                      BLOCK_ACCT_READ);=0A=
     blk_aio_preadv(blk, ctx->offset, &ctx->qiov, ctx->flags, aio_read_done=
,=0A=
@@ -1692,7 +1693,7 @@ static int aio_write_f(BlockBackend *blk, int argc, c=
har **argv)=0A=
             return -EINVAL;=0A=
         }=0A=
 =0A=
-        clock_gettime(CLOCK_MONOTONIC, &ctx->t1);=0A=
+        gettimeofday(&ctx->t1, NULL);=0A=
         block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,=
=0A=
                          BLOCK_ACCT_WRITE);=0A=
 =0A=
@@ -2159,7 +2160,7 @@ static const cmdinfo_t discard_cmd =3D {=0A=
 =0A=
 static int discard_f(BlockBackend *blk, int argc, char **argv)=0A=
 {=0A=
-    struct timespec t1, t2;=0A=
+    struct timeval t1, t2;=0A=
     bool Cflag =3D false, qflag =3D false;=0A=
     int c, ret;=0A=
     int64_t offset, bytes;=0A=
@@ -2200,9 +2201,9 @@ static int discard_f(BlockBackend *blk, int argc, cha=
r **argv)=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-    clock_gettime(CLOCK_MONOTONIC, &t1);=0A=
+    gettimeofday(&t1, NULL);=0A=
     ret =3D blk_pdiscard(blk, offset, bytes);=0A=
-    clock_gettime(CLOCK_MONOTONIC, &t2);=0A=
+    gettimeofday(&t2, NULL);=0A=
 =0A=
     if (ret < 0) {=0A=
         printf("discard failed: %s\n", strerror(-ret));=0A=
-- =0A=
2.34.1=0A=

