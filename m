Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAECC79FA3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 16:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcmxK-0003Ed-Py; Mon, 05 Jan 2026 10:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vcmxI-0003Dw-Vb
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 10:57:17 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vcmxG-0000JS-0y
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 10:57:16 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 605EpWYf3489983; Mon, 5 Jan 2026 07:56:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=fXTrvi28bKIEeu2NDZX0od1373jez3SQ6AGr+deNw
 FA=; b=msETs3K+peVot5su0LioMgNLPeu8HqIBE3x6zOZn/fuLQ0/OtOoRNu76r
 u3m2PJ6GUx/1ejVLOz7WjQQ3aF6n9LWE4er2ikMyrYGIyEDm6nhXnhlzDPajIqw4
 ibOt2vIw+8iU089aG0ROHWtYmaU1nNZwUqp5ExiDlJrxSwHX0TsfU8OBdpJ1W6ri
 D1C+vurNHGgq5Kr4hQaINm7iFQJaHxPtTdLYf3Ba04L0+HMt2jUlLCHzHdQosObS
 I2PZC8VSZNrLQfNm7joG9bHdRckjlSTdRHDoi1pmj1B8ucPv04ovY5MhOpQWiGx6
 TuTMkiWI5fw78N7xGCzQ6fCl5QHnw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020108.outbound.protection.outlook.com [52.101.46.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4bf3h1kcds-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 07:56:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFlWMwNaH2NZAr9nPDD6rXv26eNZTdcCawSGce9IVW3ZpXzzyYW7xyFdRa6K9OOtbje6C2DrmGDjDSRrsSwTMI88rAZnUE+Lmg6B0KQGAR/LhXIUpxvRdQp7hhWYx4Acp8AXXpVswVYWJI9tdZ4QQG+E5qpoi1vMLcW/orPWWwYMUOa2DOooG/ZJdc4YMOC3knvkGUgmJLnvMgXWW7Z9woUYRw1qX7JB2H8ZuGRq4jwvDsZxi8S+aduDW7Dq268LUCROJx6g0HA0E3O8h2EJP1KSF1TOwqMiQx7LXse3tjknJNRgaaWjW/8xeUi/K4mbBL6lFy4i7nJpm7fUuBXgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXTrvi28bKIEeu2NDZX0od1373jez3SQ6AGr+deNwFA=;
 b=ppg2sogqwYGMOrSZfmOQzRWHLmr4ECOdoIVd6iBiFDbjGHVApF4EoC/Wd0EpsdjAF6j+LjSFIQ7ksTf/HWouQVky2aM5rtLvtDNu18RKN2AcaFnHbjC0LS7a5v6ESKkqYdTyHfmd38fc1rKka3LLomCQ2OkAu3B661Mw2IHGUnFKS4pJJAniellgsa7Vbmhu5FV/tevddxWIqWRnQ2++5EpnU6954p3yVphMxFty60MXSspZFtdYd9qabRS0XhQIKpP9K0T8E+UEUFADHTCYDu+Hn8WVQ9/Evtup+eszJ7+HUv3H+QecuROe7TkUGdHNH3sKyUnWYfB5AaB5vMGcPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXTrvi28bKIEeu2NDZX0od1373jez3SQ6AGr+deNwFA=;
 b=iPirHNMJVGc4g4iJgEj+69PtNS3S0pE4iCkfpYyVkI+xIZqVL9AkzD/HaIx1n+v5sa0qOk4SbUEcwizxKLgSxJ4MVj6suTBliXm27LjlQQy/D/TzJKrrvmxHVsNELS/Vx8xJoLR1IOqZdUslMK3G3oxdsR0oe59eBrIhl+NlRAmvXoALguOgF7HDy0a9QTD0Gxgnq1cg8JP5PJuI24y2a8BB+tfFvNJG1HCRJA/P1wYkYOTqU8eVORkRFt0TjH0il4/VIQJ0ZGsyvcQFC558qTKelmMFWzDBotP//qZMjBy9XrLBZ1ff4Z0/ZjvFy5vgo6CgVW4y9TJFYIA48qba9A==
Received: from BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24)
 by CH8PR02MB11020.namprd02.prod.outlook.com (2603:10b6:610:2bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 15:56:54 +0000
Received: from BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8]) by BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3eff:7198:f537:d1e8%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 15:56:54 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: "philmd@linaro.org" <philmd@linaro.org>
CC: "minyard@acm.org" <minyard@acm.org>, "farosas@suse.de" <farosas@suse.de>, 
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, "corey@minyard.net"
 <corey@minyard.net>, Jonathan Davies <jond@nutanix.com>
Subject: [PATCH v2 1/2] hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel
 config
Thread-Topic: [PATCH v2 1/2] hw/ipmi/ipmi_bmc_sim: Support getting fake LAN
 channel config
Thread-Index: AQHcflvpeUVc3SzaHEOB7NNRGQ4OWQ==
Date: Mon, 5 Jan 2026 15:56:54 +0000
Message-ID: <20260105155648.1037077-2-yunpeng.yang@nutanix.com>
References: <20260105155648.1037077-1-yunpeng.yang@nutanix.com>
In-Reply-To: <20260105155648.1037077-1-yunpeng.yang@nutanix.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5029:EE_|CH8PR02MB11020:EE_
x-ms-office365-filtering-correlation-id: a126c815-b06f-4591-d297-08de4c730c7f
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TRWvrH3ydW+c1A1I7y/0Y+atIGYcQQyQYTst0LBiVkuTWbIY8UdfSQ17G6?=
 =?iso-8859-1?Q?qmgW4tzza+2ZlIVhyMbf70FyCVbroJHMhvW/hnJY8FNKY5e9570/t2rwI6?=
 =?iso-8859-1?Q?M7Dc+dcIXc13jnqGGmLdFBmt6skjjH0ehjF6JXMbBnE44Vt3i7zMjD+UfL?=
 =?iso-8859-1?Q?4Daaoj2Zo4/Ljz+CwJzzk0lLvYUD4O23Gmf/9og+K5kyLQ6LzvUaF/ENci?=
 =?iso-8859-1?Q?9XnpYZJ/nCdqFTJ4et1mWYn+HxlCrXgGzjvgEULY5h1pbXO0A68et2RIKD?=
 =?iso-8859-1?Q?03gkDEyq10PtbBPbQQI/v1ZpAAN7UOt5zoaAUWDwqeK+NYiaxXsjMaVhC9?=
 =?iso-8859-1?Q?/cuBaVXRx3+ip0q6nN73vYEIJ79M6poBisw0KdYHidUiEf9D3lDnUKSkEf?=
 =?iso-8859-1?Q?bK/hpGFHDfgpkuKvuZJIBjEXr1Uy2PXUKNt2fkP1ZzYnqGcsh5MtDraqwN?=
 =?iso-8859-1?Q?Cx+BojX2wb+yUkhFm2GzTSJ503YX6ESbDFw0w7K6hu4QkM9j4PMPCxTB4+?=
 =?iso-8859-1?Q?T1lc+zUX2TvI4HV4e8hF7Vd4vBxvWYf7A2ngz7mpkthOTHuEdoJJLujCEG?=
 =?iso-8859-1?Q?8LpN5tQ98VRL5Usy3PqqRRXCCEd5YfMRpaawq9VFjn5Ns7TQubdy+jcVNl?=
 =?iso-8859-1?Q?u6yIO3Hzr5/4hJB3wl38T6OSsoZcWW4VPPEzL5+4M+zJyBQUi0qIhnz6XP?=
 =?iso-8859-1?Q?3rZg8ZMjctgU0IoduBGDKUTHgXydie3EhVgq85JLeqp4fDBvpiRee6IZMY?=
 =?iso-8859-1?Q?wvSgF8vGq0f56zhwtKrDxY7PHNhhvGsSr7T5mgaFrhqt+XvaO8AApJz/cT?=
 =?iso-8859-1?Q?8nfBqTxl6srA/KzD/XS5NVABH1Id1hojrxgEyaEF9y0oqfoiJeAORhyruy?=
 =?iso-8859-1?Q?t4iNRecXpqdh0/Umjba/6kTKpkr7CyOxpj0JXj83VflWv1PvLuuFaSaf+j?=
 =?iso-8859-1?Q?BGCq9N65M7VF+9e57NWcBDsILbeSFB1Q4E15vkdVGXgh6oDmwUAndhC1bF?=
 =?iso-8859-1?Q?AUph/jbFCdsxu0GiRyvismDpbrca/n8XpAKGFpBd52g5xQY+FtBfNMAPf5?=
 =?iso-8859-1?Q?7S8tQx3rCagCzIAVE8PZnWD5zD1Uh5OOi4FQz7CzGwH7Qg79egN+FBK0a1?=
 =?iso-8859-1?Q?1I5pgSTvE7K9rSc8Eo2Irht91bac6bG2Fn6wo2YV8K5+JJgA59qIxxQHhq?=
 =?iso-8859-1?Q?MlW0oboD5MhKGugSthn8WXk5zYAtx+zK36nBt4W25l4KkzZ3OTzbQNo42m?=
 =?iso-8859-1?Q?J/bYVNyEVSHbr3XBCCo2VsOLO+zuhyVUUknHuPMHeqD58HysU/1aSuax0a?=
 =?iso-8859-1?Q?w76h5GSexKS7xyMCmuRjCICko0tJ7ZzRk/ek5eTZJfb996IRlb4aW/Pwxm?=
 =?iso-8859-1?Q?pTKvavTyFlJCy7wpUqqOT3e0Mpi2CO5Vx8PM9B1qBJxLIycZMRCCN9jLda?=
 =?iso-8859-1?Q?8/lEDwytjy3ZNRbBAmIhSYa3QtZN3VhV71vBoE+G+fs/2Jh0P3iTJipfez?=
 =?iso-8859-1?Q?Wh8dA88bBnnr8uw+2iSYwc3Fr2BFp56eL+BI1STcDbPppRPoVRjx56R6yE?=
 =?iso-8859-1?Q?p7yIaoWhOl3MObHa9b31EEqsYuE0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5029.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vmr/+ncM1gzHZhPmanLULqcz7iMCv2NRpSSafL11Dwd9bZLLhKA02YJhjP?=
 =?iso-8859-1?Q?O/z7UZm0dC7S/MsAW3L+HCZZJXUp7Jm3RuUGNYJJqvnXvH74jn3c+pSk6r?=
 =?iso-8859-1?Q?z9bWEQlCXLTiHWztzG5bw58SyGCunMUVIW5rEP8crZvO+rDKfjHWZ92Man?=
 =?iso-8859-1?Q?V6i3ZEzfa+nGE1aH6du9OCONq2cQtHJsbRVWPg38Fx0nqbNb2YNaj/Zvpo?=
 =?iso-8859-1?Q?VEjbNloSY3o40ehI3IgWDcvJX4YWhWNsTuHuXHOI5N8cKxBr6D5wbEVcg9?=
 =?iso-8859-1?Q?rsqnwjlaW3oSjlenmhNFKm6vEOmhtvQTNZ3RGtY0mysw8k95tjAyzw5ZEl?=
 =?iso-8859-1?Q?8Wq6twX4cORGuykHrJ4lZo+4D4eDT/usxpQCtazl7yeCW6IKHF8TxSIHzI?=
 =?iso-8859-1?Q?V+0pI0GktKRED9BhGVW3L9+NhfC72bGvo84tbiGHCm0XUBA6UOMppwfkgr?=
 =?iso-8859-1?Q?JHF6E5RwhcWE/Y9Dmb8rlROcL1ga3IlfXmBVGR9tMAOk4KT7K427ImS7FM?=
 =?iso-8859-1?Q?XoP87v33swqBC76yCET7AOgrObSwKN8FdzJ2rlCT8AfWkBWbht5zM5NF0O?=
 =?iso-8859-1?Q?CZFxjwU40YeN6r38n5fqAHa9XHTfqgm1DRzMVPNJ84ydDAUAGusPO2pNhA?=
 =?iso-8859-1?Q?5ZjE7feuZwxEQ0F8jCHUktgHS9jUK9OeWZuB+C46TBzhnIEj7olKFp9XJX?=
 =?iso-8859-1?Q?EZm1s2r+EjYVQG+duUCNVEyIyQ+BRwAEl8bcOCD13v37oW34yKt0NLAKVp?=
 =?iso-8859-1?Q?03im/D2mTyDq+2DZkG18ULbnAB+PGFdlUjhLW5zSSXz4dg2LRiYzSb/3Zu?=
 =?iso-8859-1?Q?C5A41+y67t+ckZ9v6i0iGmD/8jwBNpyY4rnVXRNMngd05uwxyQsYJTv32F?=
 =?iso-8859-1?Q?ANLR69Gq0PHeORGaIwMh1cyCD3vPmSokTFI2EiAexmdfnlpLrNNMSLWkRg?=
 =?iso-8859-1?Q?7u3hj2afWTYsLzFz9sGEn0HIlLlTbNMvYtFmLs9k1SjwYhH5CXNQx5z0AO?=
 =?iso-8859-1?Q?kxmhKdVLNfkEWdVoA2rF11wgmP3Hrnh3w1ZaRpn5/3Pu+H4bWwaKUpE+DT?=
 =?iso-8859-1?Q?yhviZJbgkbapIf75jARkGb9o79RrX+3kSHcKF7xNMbuItL/VLDxO8EFPhE?=
 =?iso-8859-1?Q?fgwtklSbnVnO3Cxu3EeVwq1WFgVHHHbwyrAQ5E4NhrSDzSYsQqFdNiSpUo?=
 =?iso-8859-1?Q?fr/6GfdAQJPI7dtj/Lo8o3Y0O4glAPtqG/7Vbdf/A0Tdrrr6pv8pNWrEAl?=
 =?iso-8859-1?Q?NUAEhqJa4Z3MaWIpyLvf7Uv01V2CCNh6qS5yp2G7tpn6/91mdBjX1QSyGf?=
 =?iso-8859-1?Q?aYNsrEHJf/KIQJthAfLuqOi9p9Irg3g/IYaQSbkLfb76XoKd306qvkE52c?=
 =?iso-8859-1?Q?tDxDH0ejzOCUjo7uq+86K6OqR4tN01mFK1K4yleUBSAZbXNQuJy+iH2Rpx?=
 =?iso-8859-1?Q?pLjHC/6Yjz8ry+cY8FgZYoYB6en4+tmRCtJ0S8NHO8yfr3YE9QmBrMK0w5?=
 =?iso-8859-1?Q?OVbOMcdJP3wnIBbj5oLCeFCSvnEo9TKjxpthDQuA7nJajGX1sWW7b7eKZ9?=
 =?iso-8859-1?Q?XUj43cEhUrV7ZvjQ+8lO0OuK4N+Cusq+IMmlWNXJwjRqpwLTr971g7Bgo/?=
 =?iso-8859-1?Q?T9XbvthBf6S8zlgxtt5GyeNrof/0Qp0yti2QVDu3nbbFSDWPZrBPmnmkLX?=
 =?iso-8859-1?Q?JBtirR3GM0in5QdqQaxB2Z7KBwFQ/ic6sbnytL2NwBKvvcNMFszP3hI1ff?=
 =?iso-8859-1?Q?/cQlq1PN8CzrkfQ23UjKaVFfLmrvUQx8AmxQnAx11Pe/uPAcYZhIux8H8J?=
 =?iso-8859-1?Q?E3KE0iVz0Q5B4G3T+BLpLj6kjSVxJhg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5029.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a126c815-b06f-4591-d297-08de4c730c7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 15:56:54.7340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +gTl5zlp337eDbnYg/Ytl6Dk8PsXvEw6bDg29+S1LjS5z/KrTGRB7+tK+jr7dnOZyQWRBl38YuUOaOYJdfPgnwXoLKhgqMU5OOOBsiC/j+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR02MB11020
X-Proofpoint-ORIG-GUID: kv_F7nq-1lm_GjbAJdwFgA4PUcPSw3Ef
X-Authority-Analysis: v=2.4 cv=QcBrf8bv c=1 sm=1 tr=0 ts=695bdf48 cx=c_pps
 a=wnlGNIUL0AhmB29u2vspYA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=64Cc0HZtAAAA:8 a=cZESGH4Fb4bm021qM-AA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzOSBTYWx0ZWRfX/Y2a0d/baeld
 XYNP12b2QzSrd8T/Vl8vUW+77Pwuwiyi8Ee/gY2Q6HB/nT9PnnRK5ffQwCHoByh+dvmrwX3PjwC
 fl3BYVTYiZ2MN7tpzZTP7czWwjdyTgQZTN6Xpe4QLV7phy45QrZ9b5m09c+Fueqgs3fkYTjiodm
 bvdHIjgzBdC1a2dB1BD9dG2ndlJxN4SIvz/6B0CS2yuU/PeoDRbfCUmpOa3v4zdtBshoYUopYvA
 aLAzV+Fg1SGmkNdTrmOxxlARczdg0xGfPNKnkbBlpRKBlsJilf4a8GDHmW5tQTEqljRo5rx58Qw
 7Y7XQSJsLibyJa/PH6xwm2+RTgfhwDbmM1gZfkaA4oIAstgeZ4x/erB9vJaCTNqAfnr5BfHwf+V
 kKyUNc3igeobvkC5uMGIOiaJbfGsM+4iuHsHvCIuatfBgkrbGiXOLcP9WBZVwW7ReWoCUbSwJbM
 yELUg1DNWOETJd1gmRQ==
X-Proofpoint-GUID: kv_F7nq-1lm_GjbAJdwFgA4PUcPSw3Ef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following IPMI commands are added or modified to support getting=0A=
fake LAN channel configurations from the `ipmi_bmc_sim` device:=0A=
* Get Channel Access;=0A=
* Get Channel Info Command;=0A=
* Get LAN Configuration Parameters.=0A=
=0A=
The fake LAN channel configurations can be specified from QEMU=0A=
commandline options for device `ipmi_bmc_sim`. Inside the guest OS, the=0A=
configurations can be retrieved from the device using some IPMI tools,=0A=
e.g., `ipmitool lan print`.=0A=
Note, there is not a real LAN channel. The fake LAN channel is suitable=0A=
for testing purposes.=0A=
=0A=
Signed-off-by: Yunpeng Yang <yunpeng.yang@nutanix.com>=0A=
---=0A=
 hw/ipmi/ipmi_bmc_sim.c      | 302 ++++++++++++++++++++++++++++++++++--=0A=
 include/hw/ipmi/ipmi.h      |   1 +=0A=
 qemu-options.hx             |  26 ++++=0A=
 tests/qtest/ipmi-kcs-test.c |  60 +++++++=0A=
 4 files changed, 379 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c=0A=
index 3d4fe1a699..d88aa22b72 100644=0A=
--- a/hw/ipmi/ipmi_bmc_sim.c=0A=
+++ b/hw/ipmi/ipmi_bmc_sim.c=0A=
@@ -27,11 +27,13 @@=0A=
 #include "qemu/timer.h"=0A=
 #include "hw/ipmi/ipmi.h"=0A=
 #include "qemu/error-report.h"=0A=
+#include "qapi/error.h"=0A=
 #include "qemu/module.h"=0A=
 #include "hw/core/loader.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/core/qdev-properties-system.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "net/net.h"=0A=
 =0A=
 #define IPMI_NETFN_CHASSIS            0x00=0A=
 =0A=
@@ -70,6 +72,7 @@=0A=
 #define IPMI_CMD_GET_MSG                  0x33=0A=
 #define IPMI_CMD_SEND_MSG                 0x34=0A=
 #define IPMI_CMD_READ_EVT_MSG_BUF         0x35=0A=
+#define IPMI_CMD_GET_CHANNEL_ACCESS       0x41=0A=
 #define IPMI_CMD_GET_CHANNEL_INFO         0x42=0A=
 =0A=
 #define IPMI_NETFN_STORAGE            0x0a=0A=
@@ -101,6 +104,10 @@=0A=
 #define IPMI_CMD_GET_SEL_TIME             0x48=0A=
 #define IPMI_CMD_SET_SEL_TIME             0x49=0A=
 =0A=
+#define IPMI_NETFN_TRANSPORT          0x0c=0A=
+=0A=
+#define IPMI_CMD_GET_LAN_CONFIG           0x02=0A=
+=0A=
 =0A=
 /* Same as a timespec struct. */=0A=
 struct ipmi_time {=0A=
@@ -170,6 +177,23 @@ typedef struct IPMISensor {=0A=
 #define MAX_SENSORS 20=0A=
 #define IPMI_WATCHDOG_SENSOR 0=0A=
 =0A=
+#define NBYTES_IP  4=0A=
+#define NBYTES_MAC 6=0A=
+=0A=
+typedef struct IPMILan {=0A=
+    uint8_t channel;=0A=
+    uint8_t ipaddr[NBYTES_IP];=0A=
+    uint8_t ipsrc;=0A=
+    MACAddr macaddr;=0A=
+    uint8_t netmask[NBYTES_IP];=0A=
+    uint8_t defgw_ipaddr[NBYTES_IP];=0A=
+    MACAddr defgw_macaddr;=0A=
+=0A=
+    char *arg_ipaddr;=0A=
+    char *arg_netmask;=0A=
+    char *arg_defgw_ipaddr;=0A=
+} IPMILan;=0A=
+=0A=
 #define MAX_NETFNS 64=0A=
 =0A=
 typedef struct IPMIRcvBufEntry {=0A=
@@ -215,6 +239,7 @@ struct IPMIBmcSim {=0A=
     IPMIFru fru;=0A=
     IPMISensor sensors[MAX_SENSORS];=0A=
     char *sdr_filename;=0A=
+    IPMILan lan;=0A=
 =0A=
     /* Odd netfns are for responses, so we only need the even ones. */=0A=
     const IPMINetfn *netfns[MAX_NETFNS / 2];=0A=
@@ -265,6 +290,36 @@ struct IPMIBmcSim {=0A=
 #define IPMI_BMC_WATCHDOG_ACTION_POWER_DOWN      2=0A=
 #define IPMI_BMC_WATCHDOG_ACTION_POWER_CYCLE     3=0A=
 =0A=
+#define IPMI_CHANNEL_IMPLEMENTATION_MIN    0x1=0A=
+#define IPMI_CHANNEL_IMPLEMENTATION_MAX    0xb=0A=
+#define IPMI_CHANNEL_IS_IMPLEMENTATION_SPECIFIC(c) \=0A=
+    (IPMI_CHANNEL_IMPLEMENTATION_MIN <=3D (c) && \=0A=
+     (c) <=3D IPMI_CHANNEL_IMPLEMENTATION_MAX)=0A=
+=0A=
+#define IPMI_BMC_CHANNEL_IS_LAN(ibs, c) \=0A=
+    ((ibs)->lan.channel !=3D 0 && (ibs)->lan.channel =3D=3D (c))=0A=
+=0A=
+#define IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED    0x80=0A=
+=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS        0x00=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT      0x01=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_ENABLES      0x02=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_IP_ADDR                0x03=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_IP_ADDR_SOURCE         0x04=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_MAC_ADDR               0x05=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_SUBNET_MASK            0x06=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_IPV4_HDR_PARAMS        0x07=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_IP_ADDR     0x0c=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_MAC_ADDR    0x0d=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_ADDR         0x0e=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_MAC_ADDR     0x0f=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_COMMUNITY_STRING       0x10=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_NUM_DESTINATIONS       0x11=0A=
+=0A=
+#define IPMI_BMC_LAN_CFG_PARAMETER_REVISION    0x11=0A=
+=0A=
+#define IPMI_BMC_LAN_CFG_IS_VALID_IP_SOURCE(v)    (0x0 <=3D (v) && (v) <=
=3D 0x4)=0A=
+=0A=
 #define RSP_BUFFER_INITIALIZER { }=0A=
 =0A=
 static inline void rsp_buffer_pushmore(RspBuffer *rsp, uint8_t *bytes,=0A=
@@ -1231,6 +1286,25 @@ static void get_watchdog_timer(IPMIBmcSim *ibs,=0A=
     }=0A=
 }=0A=
 =0A=
+static void get_channel_access(IPMIBmcSim *ibs,=0A=
+                               uint8_t *cmd, unsigned int cmd_len,=0A=
+                               RspBuffer *rsp)=0A=
+{=0A=
+    uint8_t channel =3D cmd[2] & 0xf;=0A=
+=0A=
+    if (channel =3D=3D IPMI_CHANNEL_IPMB || channel =3D=3D IPMI_CHANNEL_SY=
STEM ||=0A=
+        IPMI_BMC_CHANNEL_IS_LAN(ibs, channel)) {=0A=
+        /* alerting disabled */=0A=
+        /* per message authentication disabled */=0A=
+        /* user level authentication disabled */=0A=
+        /* channel always available */=0A=
+        rsp_buffer_push(rsp, 0x20 | 0x10 | 0x08 | 0x02);=0A=
+        rsp_buffer_push(rsp, 0x04);  /* privilege limit: ADMINISTRATOR */=
=0A=
+    } else {=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+    }=0A=
+}=0A=
+=0A=
 static void get_channel_info(IPMIBmcSim *ibs,=0A=
                              uint8_t *cmd, unsigned int cmd_len,=0A=
                              RspBuffer *rsp)=0A=
@@ -1240,29 +1314,29 @@ static void get_channel_info(IPMIBmcSim *ibs,=0A=
     IPMIFwInfo info =3D {};=0A=
     uint8_t ch =3D cmd[2] & 0x0f;=0A=
 =0A=
-    /* Only define channel 0h (IPMB) and Fh (system interface) */=0A=
-=0A=
     if (ch =3D=3D 0x0e) { /* "This channel" */=0A=
         ch =3D IPMI_CHANNEL_SYSTEM;=0A=
     }=0A=
     rsp_buffer_push(rsp, ch);=0A=
 =0A=
-    if (ch !=3D IPMI_CHANNEL_IPMB && ch !=3D IPMI_CHANNEL_SYSTEM) {=0A=
-        /* Not a supported channel */=0A=
-        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
-        return;=0A=
-    }=0A=
-=0A=
     if (k->get_fwinfo) {=0A=
         k->get_fwinfo(s, &info);=0A=
     }=0A=
 =0A=
+    /* Only define channel 0h (IPMB), LAN, and Fh (system interface) */=0A=
     if (ch =3D=3D IPMI_CHANNEL_IPMB) {=0A=
         rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_IPMB);=0A=
         rsp_buffer_push(rsp, IPMI_CHANNEL_PROTOCOL_IPMB);=0A=
-    } else { /* IPMI_CHANNEL_SYSTEM */=0A=
+    } else if (IPMI_BMC_CHANNEL_IS_LAN(ibs, ch)) {=0A=
+        rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_802_3_LAN);=0A=
+        rsp_buffer_push(rsp, IPMI_CHANNEL_PROTOCOL_IPMB);=0A=
+    } else if (ch =3D=3D IPMI_CHANNEL_SYSTEM) {=0A=
         rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_SYSTEM);=0A=
         rsp_buffer_push(rsp, info.ipmi_channel_protocol);=0A=
+    } else {=0A=
+        /* Not a supported channel */=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+        return;=0A=
     }=0A=
 =0A=
     rsp_buffer_push(rsp, 0x00); /* Session-less */=0A=
@@ -2045,6 +2119,135 @@ static void set_sensor_reading(IPMIBmcSim *ibs,=0A=
     }=0A=
 }=0A=
 =0A=
+static inline bool is_ipv4_netmask_valid(const void *buf)=0A=
+{=0A=
+    uint32_t netmask =3D ldl_be_p(buf);=0A=
+=0A=
+    return netmask !=3D 0 && clo32(netmask) + ctz32(netmask) =3D=3D 32;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Request data (from cmd[2] to cmd[5] inclusive):=0A=
+ * bytes   meaning=0A=
+ *    1    [bit 7] revision only flag, [bits 3:0] channel number=0A=
+ *    2    parameter selector=0A=
+ *    3    set selector=0A=
+ *    4    block selector=0A=
+ */=0A=
+static void get_lan_config(IPMIBmcSim *ibs,=0A=
+                           uint8_t *cmd, unsigned int cmd_len,=0A=
+                           RspBuffer *rsp)=0A=
+{=0A=
+    uint8_t channel;=0A=
+=0A=
+    if (ibs->lan.channel =3D=3D 0) {=0A=
+        /* LAN channel disabled. Fail as if this command were not defined.=
 */=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);=0A=
+        return;=0A=
+    }=0A=
+    if (cmd_len < 6) {=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);=0A=
+        return;=0A=
+    }=0A=
+    channel =3D cmd[2] & 0xf;=0A=
+=0A=
+    rsp_buffer_push(rsp, IPMI_BMC_LAN_CFG_PARAMETER_REVISION);=0A=
+    if (cmd[2] & 0x80) {=0A=
+        /* The requester only requests parameter revision, not the paramet=
er */=0A=
+        return;=0A=
+    }=0A=
+    if (!IPMI_BMC_CHANNEL_IS_LAN(ibs, channel)) {=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (cmd[3]) {=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS:=0A=
+        rsp_buffer_push(rsp, 0x0);  /* set complete */=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT:=0A=
+        rsp_buffer_push(rsp, 0x01); /* Authentication type "none" supporte=
d */=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_ENABLES:=0A=
+        /* Only authentication type "none" enabled */=0A=
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "Callback" */=
=0A=
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "User" */=0A=
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "Operator" */=
=0A=
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "Administrator"=
 */=0A=
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "OEM" */=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR:=0A=
+        rsp_buffer_pushmore(rsp, ibs->lan.ipaddr, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR_SOURCE:=0A=
+        rsp_buffer_push(rsp, ibs->lan.ipsrc);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_MAC_ADDR:=0A=
+        rsp_buffer_pushmore(rsp, ibs->lan.macaddr.a, NBYTES_MAC);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_SUBNET_MASK:=0A=
+        rsp_buffer_pushmore(rsp, ibs->lan.netmask, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IPV4_HDR_PARAMS:=0A=
+        /* TTL 0x40 */=0A=
+        rsp_buffer_push(rsp, 0x40);=0A=
+        /* don't fragment */=0A=
+        rsp_buffer_push(rsp, 0x40);=0A=
+        /* precedence 0x0, minimize delay */=0A=
+        rsp_buffer_push(rsp, 0x10);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_IP_ADDR:=0A=
+        rsp_buffer_pushmore(rsp, ibs->lan.defgw_ipaddr, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_MAC_ADDR:=0A=
+        rsp_buffer_pushmore(rsp, ibs->lan.defgw_macaddr.a, NBYTES_MAC);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_ADDR:=0A=
+        /* 0.0.0.0 */=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_MAC_ADDR:=0A=
+        /* 00:00:00:00:00:00 */=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_COMMUNITY_STRING:=0A=
+        {=0A=
+            static uint8_t community_str[18] =3D "public";=0A=
+=0A=
+            rsp_buffer_pushmore(rsp, community_str, sizeof(community_str))=
;=0A=
+        }=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_NUM_DESTINATIONS:=0A=
+        rsp_buffer_push(rsp, 0x00); /* LAN Alerting not supported */=0A=
+        break;=0A=
+=0A=
+    default:=0A=
+        rsp_buffer_set_error(rsp, IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED)=
;=0A=
+        return;=0A=
+    };=0A=
+}=0A=
+=0A=
 static const IPMICmdHandler chassis_cmds[] =3D {=0A=
     [IPMI_CMD_GET_CHASSIS_CAPABILITIES] =3D { chassis_capabilities },=0A=
     [IPMI_CMD_GET_CHASSIS_STATUS] =3D { chassis_status },=0A=
@@ -2089,6 +2292,7 @@ static const IPMICmdHandler app_cmds[] =3D {=0A=
     [IPMI_CMD_RESET_WATCHDOG_TIMER] =3D { reset_watchdog_timer },=0A=
     [IPMI_CMD_SET_WATCHDOG_TIMER] =3D { set_watchdog_timer, 8 },=0A=
     [IPMI_CMD_GET_WATCHDOG_TIMER] =3D { get_watchdog_timer },=0A=
+    [IPMI_CMD_GET_CHANNEL_ACCESS] =3D { get_channel_access, 4 },=0A=
     [IPMI_CMD_GET_CHANNEL_INFO] =3D { get_channel_info, 3 },=0A=
 };=0A=
 static const IPMINetfn app_netfn =3D {=0A=
@@ -2119,12 +2323,22 @@ static const IPMINetfn storage_netfn =3D {=0A=
     .cmd_handlers =3D storage_cmds=0A=
 };=0A=
 =0A=
+static const IPMICmdHandler transport_cmds[] =3D {=0A=
+    [IPMI_CMD_GET_LAN_CONFIG] =3D { get_lan_config },=0A=
+};=0A=
+static const IPMINetfn transport_netfn =3D {=0A=
+    .cmd_nums =3D ARRAY_SIZE(transport_cmds),=0A=
+    .cmd_handlers =3D transport_cmds=0A=
+};=0A=
+=0A=
+=0A=
 static void register_cmds(IPMIBmcSim *s)=0A=
 {=0A=
     ipmi_sim_register_netfn(s, IPMI_NETFN_CHASSIS, &chassis_netfn);=0A=
     ipmi_sim_register_netfn(s, IPMI_NETFN_SENSOR_EVENT, &sensor_event_netf=
n);=0A=
     ipmi_sim_register_netfn(s, IPMI_NETFN_APP, &app_netfn);=0A=
     ipmi_sim_register_netfn(s, IPMI_NETFN_STORAGE, &storage_netfn);=0A=
+    ipmi_sim_register_netfn(s, IPMI_NETFN_TRANSPORT, &transport_netfn);=0A=
 }=0A=
 =0A=
 static uint8_t init_sdrs[] =3D {=0A=
@@ -2174,9 +2388,25 @@ static void ipmi_sdr_init(IPMIBmcSim *ibs)=0A=
     }=0A=
 }=0A=
 =0A=
+static const VMStateDescription vmstate_ipmi_sim_lan =3D {=0A=
+    .name =3D TYPE_IPMI_BMC_SIMULATOR "-lan",=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .fields =3D (const VMStateField[]) {=0A=
+        VMSTATE_UINT8(channel, IPMILan),=0A=
+        VMSTATE_UINT8_ARRAY(ipaddr, IPMILan, NBYTES_IP),=0A=
+        VMSTATE_UINT8(ipsrc, IPMILan),=0A=
+        VMSTATE_UINT8_ARRAY(macaddr.a, IPMILan, NBYTES_MAC),=0A=
+        VMSTATE_UINT8_ARRAY(netmask, IPMILan, NBYTES_IP),=0A=
+        VMSTATE_UINT8_ARRAY(defgw_ipaddr, IPMILan, NBYTES_IP),=0A=
+        VMSTATE_UINT8_ARRAY(defgw_macaddr.a, IPMILan, NBYTES_MAC),=0A=
+        VMSTATE_END_OF_LIST()=0A=
+    }=0A=
+};=0A=
+=0A=
 static const VMStateDescription vmstate_ipmi_sim =3D {=0A=
     .name =3D TYPE_IPMI_BMC_SIMULATOR,=0A=
-    .version_id =3D 1,=0A=
+    .version_id =3D 2,=0A=
     .minimum_version_id =3D 1,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT8(bmc_global_enables, IPMIBmcSim),=0A=
@@ -2198,6 +2428,7 @@ static const VMStateDescription vmstate_ipmi_sim =3D =
{=0A=
         VMSTATE_UINT16(sensors[IPMI_WATCHDOG_SENSOR].deassert_states,=0A=
                        IPMIBmcSim),=0A=
         VMSTATE_UINT16(sensors[IPMI_WATCHDOG_SENSOR].assert_enable, IPMIBm=
cSim),=0A=
+        VMSTATE_STRUCT(lan, IPMIBmcSim, 2, vmstate_ipmi_sim_lan, IPMILan),=
=0A=
         VMSTATE_END_OF_LIST()=0A=
     }=0A=
 };=0A=
@@ -2232,6 +2463,47 @@ out:=0A=
     fru->nentries =3D size / fru->areasize;=0A=
 }=0A=
 =0A=
+static void ipmi_lan_init(IPMILan *lan, Error **errp)=0A=
+{=0A=
+    struct in_addr ip;=0A=
+=0A=
+    /*=0A=
+     * `lan->channel` can be either 0 (meaning LAN channel disabled) or=0A=
+     * a valid IPMI implementation-specific channel.=0A=
+     */=0A=
+    if (lan->channel !=3D 0 &&=0A=
+        !IPMI_CHANNEL_IS_IMPLEMENTATION_SPECIFIC(lan->channel)) {=0A=
+        error_setg(errp, "invalid LAN channel %d", lan->channel);=0A=
+        return;=0A=
+    }=0A=
+    if (lan->arg_ipaddr) {=0A=
+        if (inet_pton(AF_INET, lan->arg_ipaddr, &ip) !=3D 1) {=0A=
+            error_setg(errp, "invalid ip address '%s'", lan->arg_ipaddr);=
=0A=
+            return;=0A=
+        }=0A=
+        memcpy(lan->ipaddr, &ip.s_addr, NBYTES_IP);=0A=
+    }=0A=
+    if (!IPMI_BMC_LAN_CFG_IS_VALID_IP_SOURCE(lan->ipsrc)) {=0A=
+        error_setg(errp, "invalid ip source %d", lan->ipsrc);=0A=
+        return;=0A=
+    }=0A=
+    if (lan->arg_netmask) {=0A=
+        if (inet_pton(AF_INET, lan->arg_netmask, &ip) !=3D 1 ||=0A=
+            !is_ipv4_netmask_valid(&ip.s_addr)) {=0A=
+            error_setg(errp, "invalid subnet mask '%s'", lan->arg_netmask)=
;=0A=
+            return;=0A=
+        }=0A=
+        memcpy(lan->netmask, &ip.s_addr, NBYTES_IP);=0A=
+    }=0A=
+    if (lan->arg_defgw_ipaddr) {=0A=
+        if (inet_pton(AF_INET, lan->arg_defgw_ipaddr, &ip) !=3D 1) {=0A=
+            error_setg(errp, "invalid ip address '%s'", lan->arg_defgw_ipa=
ddr);=0A=
+            return;=0A=
+        }=0A=
+        memcpy(lan->defgw_ipaddr, &ip.s_addr, NBYTES_IP);=0A=
+    }=0A=
+}=0A=
+=0A=
 static void ipmi_sim_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
     IPMIBmc *b =3D IPMI_BMC(dev);=0A=
@@ -2259,6 +2531,9 @@ static void ipmi_sim_realize(DeviceState *dev, Error =
**errp)=0A=
     ibs->acpi_power_state[1] =3D 0;=0A=
 =0A=
     ipmi_init_sensors_from_sdrs(ibs);=0A=
+=0A=
+    ipmi_lan_init(&ibs->lan, errp);=0A=
+=0A=
     register_cmds(ibs);=0A=
 =0A=
     ibs->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);=0A=
@@ -2276,6 +2551,13 @@ static const Property ipmi_sim_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),=0A=
     DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),=0A=
     DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),=0A=
+    DEFINE_PROP_UINT8("lan.channel", IPMIBmcSim, lan.channel, 0),=0A=
+    DEFINE_PROP_STRING("lan.ipaddr", IPMIBmcSim, lan.arg_ipaddr),=0A=
+    DEFINE_PROP_UINT8("lan.ipsrc", IPMIBmcSim, lan.ipsrc, 0),=0A=
+    DEFINE_PROP_MACADDR("lan.macaddr", IPMIBmcSim, lan.macaddr),=0A=
+    DEFINE_PROP_STRING("lan.netmask", IPMIBmcSim, lan.arg_netmask),=0A=
+    DEFINE_PROP_STRING("lan.defgw_ipaddr", IPMIBmcSim, lan.arg_defgw_ipadd=
r),=0A=
+    DEFINE_PROP_MACADDR("lan.defgw_macaddr", IPMIBmcSim, lan.defgw_macaddr=
),=0A=
 };=0A=
 =0A=
 static void ipmi_sim_class_init(ObjectClass *oc, const void *data)=0A=
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h=0A=
index dabbb9ec5d..3134a85c58 100644=0A=
--- a/include/hw/ipmi/ipmi.h=0A=
+++ b/include/hw/ipmi/ipmi.h=0A=
@@ -45,6 +45,7 @@ enum ipmi_op {=0A=
 #define IPMI_CHANNEL_IPMB                0x00=0A=
 #define IPMI_CHANNEL_SYSTEM              0x0f=0A=
 #define IPMI_CHANNEL_MEDIUM_IPMB         0x01=0A=
+#define IPMI_CHANNEL_MEDIUM_802_3_LAN    0x04=0A=
 #define IPMI_CHANNEL_MEDIUM_SYSTEM       0x0c=0A=
 #define IPMI_CHANNEL_PROTOCOL_IPMB       0x01=0A=
 #define IPMI_CHANNEL_PROTOCOL_KCS        0x05=0A=
diff --git a/qemu-options.hx b/qemu-options.hx=0A=
index ec92723f10..01f2923cf8 100644=0A=
--- a/qemu-options.hx=0A=
+++ b/qemu-options.hx=0A=
@@ -1144,6 +1144,32 @@ SRST=0A=
         is set, get "Get GUID" command to the BMC will return it.=0A=
         Otherwise "Get GUID" will return an error.=0A=
 =0A=
+    ``lan.channel=3Dval``=0A=
+        channel number of the fake LAN channel. It can be 0 or any=0A=
+        integer from 0x1 to 0xb inclusive. If set to 0, the LAN channel=0A=
+        is disabled, otherwise the LAN channel is enabled at the=0A=
+        specified channel number. The default is 0.=0A=
+=0A=
+    ``lan.ipaddr=3Daddr``=0A=
+        the ipv4 address of the BMC LAN channel.=0A=
+=0A=
+    ``lan.ipsrc=3Dval``=0A=
+        the ipv4 address source of the BMC LAN channel. It can be 0=0A=
+        (unspecified source), 1 (static address), 2 (DHCP), 3 (BIOS or=0A=
+        system software), or 4 (other source). The default is 0.=0A=
+=0A=
+    ``lan.macaddr=3Dmac``=0A=
+        the mac address of the BMC LAN channel.=0A=
+=0A=
+    ``lan.netmask=3Dmask``=0A=
+        the ipv4 subnet mask for the BMC LAN channel.=0A=
+=0A=
+    ``lan.defgw_ipaddr=3Daddr``=0A=
+        the default gateway ipv4 address for the BMC LAN channel.=0A=
+=0A=
+    ``lan.defgw_macaddr=3Dmac``=0A=
+        the default gateway mac address for the BMC LAN channel.=0A=
+=0A=
 ``-device ipmi-bmc-extern,id=3Did,chardev=3Did[,slave_addr=3Dval]``=0A=
     Add a connection to an external IPMI BMC simulator. Instead of=0A=
     locally emulating the BMC like the above item, instead connect to an=
=0A=
diff --git a/tests/qtest/ipmi-kcs-test.c b/tests/qtest/ipmi-kcs-test.c=0A=
index 3186c6ad64..d0a207477e 100644=0A=
--- a/tests/qtest/ipmi-kcs-test.c=0A=
+++ b/tests/qtest/ipmi-kcs-test.c=0A=
@@ -262,6 +262,62 @@ static void test_enable_irq(void)=0A=
     kcs_ints_enabled =3D 1;=0A=
 }=0A=
 =0A=
+=0A=
+static uint8_t get_channel_access_cmd[] =3D { 0x18, 0x41, 0x01, 0x40 };=0A=
+static uint8_t get_channel_access_rsp[] =3D { 0x1c, 0x41, 0x00, 0x3a, 0x04=
 };=0A=
+=0A=
+/*=0A=
+ * Get channel access=0A=
+ */=0A=
+static void test_kcs_channel_access(void)=0A=
+{=0A=
+    uint8_t rsp[20];=0A=
+    unsigned int rsplen =3D sizeof(rsp);=0A=
+=0A=
+    kcs_cmd(get_channel_access_cmd, sizeof(get_channel_access_cmd),=0A=
+            rsp, &rsplen);=0A=
+    g_assert(rsplen =3D=3D sizeof(get_channel_access_rsp));=0A=
+    g_assert(memcmp(get_channel_access_rsp, rsp, rsplen) =3D=3D 0);=0A=
+}=0A=
+=0A=
+=0A=
+static uint8_t get_channel_info_cmd[] =3D { 0x18, 0x42, 0x01 };=0A=
+static uint8_t get_channel_info_rsp[] =3D { 0x1c, 0x42, 0x00, 0x01, 0x04, =
0x01,=0A=
+                                          0x00, 0xf2, 0x1b, 0x00, 0x00, 0x=
00 };=0A=
+=0A=
+/*=0A=
+ * Get channel info=0A=
+ */=0A=
+static void test_kcs_channel_info(void)=0A=
+{=0A=
+    uint8_t rsp[20];=0A=
+    unsigned int rsplen =3D sizeof(rsp);=0A=
+=0A=
+    kcs_cmd(get_channel_info_cmd, sizeof(get_channel_info_cmd), rsp, &rspl=
en);=0A=
+    g_assert(rsplen =3D=3D sizeof(get_channel_info_rsp));=0A=
+    g_assert(memcmp(get_channel_info_rsp, rsp, rsplen) =3D=3D 0);=0A=
+}=0A=
+=0A=
+=0A=
+/* get ip address (specified in cmdline): 10.0.0.2 */=0A=
+static uint8_t get_ipaddr_cmd[] =3D { 0x30, 0x02, 0x01, 0x03, 0x00, 0x00 }=
;=0A=
+static uint8_t get_ipaddr_rsp[] =3D { 0x34, 0x02, 0x00, 0x11,=0A=
+                                    0x0a, 0x00, 0x00, 0x02 };=0A=
+=0A=
+/*=0A=
+ * Get LAN configurations=0A=
+ */=0A=
+static void test_kcs_lan_get(void)=0A=
+{=0A=
+    uint8_t rsp[20];=0A=
+    unsigned int rsplen =3D sizeof(rsp);=0A=
+=0A=
+    kcs_cmd(get_ipaddr_cmd, sizeof(get_ipaddr_cmd), rsp, &rsplen);=0A=
+    g_assert(rsplen =3D=3D sizeof(get_ipaddr_rsp));=0A=
+    g_assert(memcmp(get_ipaddr_rsp, rsp, rsplen) =3D=3D 0);=0A=
+}=0A=
+=0A=
+=0A=
 int main(int argc, char **argv)=0A=
 {=0A=
     char *cmdline;=0A=
@@ -271,6 +327,7 @@ int main(int argc, char **argv)=0A=
     g_test_init(&argc, &argv, NULL);=0A=
 =0A=
     cmdline =3D g_strdup_printf("-device ipmi-bmc-sim,id=3Dbmc0"=0A=
+                                       ",lan.channel=3D1,lan.ipaddr=3D10.0=
.0.2"=0A=
                               " -device isa-ipmi-kcs,bmc=3Dbmc0");=0A=
     qtest_start(cmdline);=0A=
     g_free(cmdline);=0A=
@@ -280,6 +337,9 @@ int main(int argc, char **argv)=0A=
     qtest_add_func("/ipmi/local/kcs_enable_irq", test_enable_irq);=0A=
     qtest_add_func("/ipmi/local/kcs_base_irq", test_kcs_base);=0A=
     qtest_add_func("/ipmi/local/kcs_abort_irq", test_kcs_abort);=0A=
+    qtest_add_func("/ipmi/local/kcs_channel_access", test_kcs_channel_acce=
ss);=0A=
+    qtest_add_func("/ipmi/local/kcs_channel_info", test_kcs_channel_info);=
=0A=
+    qtest_add_func("/ipmi/local/kcs_lan_get", test_kcs_lan_get);=0A=
     ret =3D g_test_run();=0A=
     qtest_quit(global_qtest);=0A=
 =0A=
-- =0A=
2.43.7=0A=
=0A=

