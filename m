Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFBDC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 06:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wulQU-0004SX-A7; Fri, 14 Aug 2026 02:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wulQM-0004S0-Pb
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 02:29:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wulQL-0000P5-0s
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 02:29:50 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4TKus751029; Thu, 13 Aug 2026 23:29:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=L98wHLU4y5zz+eWDZG23My5HRwRquRKQbGSRJG+Br
 K4=; b=o3jJomSAgDyVJK31vVdLmFbHhuLQlegkxN5tjsoi3JmKzOKIxs95v9zve
 ODcb1vhhOkJpAB+bxzSCdq8adXrtDocBQyD5My2UPHeZLEvCEUsyLS3qvkLM31qf
 CPr5/qii/rE+N05zAu+vaT+WURNhhHHyNJPtxYPyMdHtypDpgTpaRF3br9SsuXph
 Ch0ouob39ELFF0mLYQZKg6XocnwEdpWqnbn1gE1/a68z9LHiB8pH7aL9nWUMAw4I
 s9XbViuLs3p2H+O6BcDH9j4+9my8WVQGUF78rjU1LsQJY7ClZJS9bh20VtzM8KPB
 IeRE2SGTvTTzh90YUEX/oUQzBjUUQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021106.outbound.protection.outlook.com [52.101.62.106])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g1p1d0uhw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 23:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlCWq4ZDjgE5h5znvn8Zsbtmfu4eV+RIpsIbfnrGvcO6bn/eR1w0Kuu10Rrs1zI+go9N2icqDkI7HtqXHfBV5/xLXh0L7T6pMorpAMUtzC1Ftez1dregJRnAzboGmdyGI94ZL5szuFmRJV7CG2DoHUPKBJ38krecuWeDfL2Ns3UgnLCBfRBIxgqZaP6uN7LRbTf3rdPrMWpltl+6saugvhmvN9v23GvyKTz/uQI+qopNngYS820td/FG3mJuMwpYJWLgi8FjuhH/AhsRl7WTIu01UpxkXKDndUVrwBH2Qs0CxlKdWr6Q5Vdlp/Ni01M4PgjzW4Jd7QSFiZRft8iH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L98wHLU4y5zz+eWDZG23My5HRwRquRKQbGSRJG+BrK4=;
 b=out0wac4N8gGtPaARDNOFInXiXP3pRSAS9iyi0hCaDliYnaPoXSYgb6oYsoBRqXYM1kWbuLyZ88lwQZn/qtKNoNKWnUkXWln+huu7OA/wiDPy4r1LCPOKJ3UjwQWF+a3SLWcQ3joy/dDptZ+rfwlNcCADxAQaxJUWeGoqOVY0Hh6uVBBLKqgueP2F5EsLsV/v3iIt/Nn9JncN+WYKwrojKG8Cof4czkfz9FZY1r1wsZokaivf3D8DbNGcUnMkgesR7JzRxHQwlw2/2u8HmomuyUxfvcJHKd6Ub2UUxgNza1tifDbwAjMf/4AfzMlRnPH+TFepkr2N1tgk46kDCq72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L98wHLU4y5zz+eWDZG23My5HRwRquRKQbGSRJG+BrK4=;
 b=OhJrLSipWvqgz2Nf5LQidayYq3MmcxczdooyDpfY89ZnJCI+zOCFLyVMPa9KFEIU966R02H6eNP0bCHDNA9V+Amz4Q95XWSjrzbeXa9xZcRiop/hdEg55z0iF+Wjtf/pgI4LNq4LUdkubqLPVjHiM46DQY3z+EIogojJm+MiWAfhBNlBwRc7yzY72ndnH77A9TdrJlQwZG6X2lb+8w2X2QDK0YKues1K9mkQg1qDi4i+TL56v5d2ZIFlOaQcdx/fBKZAi3uK4N4PRfk27NCwoSArAtVWNkFAOv1xzkf+ZpW0Qfe0FsxM2Qx+MBI11RCNMQkDFpRWcMeJ/YvFjvgJjA==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by BY5PR02MB6977.namprd02.prod.outlook.com (2603:10b6:a03:231::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 14 Aug
 2026 06:29:38 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%4]) with mapi id 15.21.0315.012; Fri, 14 Aug 2026
 06:29:38 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Hugo Komatsu <hugo.komatsu@nutanix.com>, John Levon
 <john.levon@nutanix.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] vfio-user: reject failover during init
Thread-Topic: [PATCH] vfio-user: reject failover during init
Thread-Index: AQHdKwZq3QjQg49MDUmMavF3ugimobadFkGQ
Date: Fri, 14 Aug 2026 06:29:38 +0000
Message-ID: <IA0PR02MB9462D1D113274A2FC18BF6188BDA2@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20260813092959.76-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260813092959.76-1-hugo.komatsu@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|BY5PR02MB6977:EE_
x-ms-office365-filtering-correlation-id: 3d2614a1-fa09-4311-f828-08def9cd6a73
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|22082099003|38070700021|18002099003|6133799003|10067099003|56012099006;
x-microsoft-antispam-message-info: PJFzTQHHgN8//7HqiScANlocCEPe+6Sqo72Ntr+KUmOah4jTx6gnwx7Oj/g2nk5WAPPmx5A261do8h0mOmntpNf8lqqFsy2yK4yIIShSrM7ACrxI4d5dO7Grh3xTuOr2uKCHQB5R3Pnk64bHG/xTqDQ/y773923tNBYHwb1a1o+kcivNrdRXMppXaI7KjeJweOZI8mivSqIASeYGpVDvmjvzP47zxdnEXbnEe9QZDxjSuO+d/FiB+35L1F/Gg+dwx3Ke9TyEKesUrpGAjvVbwAwIvsBpuSrxVv0z5ceKeydw1iKrPUlp6M4H0cklJRHgyd6LwztolaRmIYKRaB0Ekb87HAjRkyZNtONaq85JDkQs1aZMuxsX7QFrQEiW6luUMeEIrR6hRtjSGQbnlXI4znsbBir3RIWbSfh7yJsGje/7BLujM1zE56qym3VVmSyeqX0DaNJXnqg1cHlOgJ8VsygIeMy4uoiDgbRjWH3mCNLrxr7QW/LBMbeciraP+riZVVeJWOMNtZjZPsQGOx0APjk5xB5iogzS+XeSAOpVyaBgPGyk/EhpVYlT+YXeEpLfuxyaFNQ2QeHe5dWsebCxw+xZPteyRgXmQyQLxg9Anm3G0yoyzY8ioje7A+LED/XlziyqHxcgEiy065Za1WxrZqnZVm7sK7hvDXbSqQY8vJ9oPYTkiL+epXUUfm5aFyLApYZMLEDeZvvTKPEXX36wI4gJCsxj16yGtF53iJEqdWM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(22082099003)(38070700021)(18002099003)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW8zTDdYNDkwMVhwOFFFWE45K1FMNlBlMzZHMWthbitsQkJBVyt4Y2ltendq?=
 =?utf-8?B?ZDk5NThGaGErelNOdkV3eHVhNEorbnV2NGFzU0tlK0gvaElhWHl5U2tBT3JE?=
 =?utf-8?B?QVVtK3g4YUZYcy9PNENtYlJPVUFvVlhCU1hWK1VXTk9EakdhNWVYMW51alkz?=
 =?utf-8?B?d1MyTlhSUEpGczhnSlgyam1Vb3JNNkpoeFl3NjR1dXAzeG4zSTdNV0VhRnBi?=
 =?utf-8?B?OGRwcFc3VzE4WVRtb1FSaU4xWkNIdm1qY2k0NUJVYjZFZjNyb1Y1ZHpNZlVv?=
 =?utf-8?B?aGhEd0ZlNmVFL01pdGhqMDIrYlNxbWJGRWY1L3ErcjdNWTBMamtyNUlqNjJp?=
 =?utf-8?B?bmg4aXZmT21MWnlPdUZvbWxoRURQMHZJOVIxVTk5cFRrVDk2VHM1ZVBvdWJr?=
 =?utf-8?B?b0I2R2s4Q0JNZDN4Vis0YklkWWRFTlZ0b0NITU1UQUgxUmdoTlRtSDZzaVkv?=
 =?utf-8?B?WS9DTjIwMmlSSW54TUN4a0Y3cEYyaFlMOGdWRzFsaU9vSmlUVmlRbDQzK3g5?=
 =?utf-8?B?Y1VHekJEc1lrY1gwdkRyZmM2V3lxRllXUWhIS2UvK1pXQWNRblpRaFk5RDVU?=
 =?utf-8?B?WGtNV01CTVdLTTBwQ2o5aHQ0eG9Va3ExOTVtaHA1d3Q1MVNIQi9yTVBJWWhC?=
 =?utf-8?B?U3Awckw1Y290RW1mV1IyK29TMHpEWUxYV3IwNTRsRWVCZm9aUHVJR0lKc0tD?=
 =?utf-8?B?U0RQZ3V3eHg0dGdYZW5RUnJFTG9UTUN4Q3JRNHd0WmN1d21NWUh2VXdYSHRP?=
 =?utf-8?B?bmlTVks3Wm1hbXBhR3U5cW9LT3VXdVQydzMzNktuT0NyY080MEpucER5MEI1?=
 =?utf-8?B?RHo2cXNHcWxieGwzejZZd0JOSWZObGQ2UkpCZ2wyWG1Qa2JJN3Q2U1hOSE9i?=
 =?utf-8?B?WjNrNFlGa2RtcjRzMVFIUXQzYkZaQnVOS0FMeGwvMEZIZUQ5aUNvZndtNGhj?=
 =?utf-8?B?dWNEUkVYRDRZUmhPSXc1azV3VkFXRXVBOEVLeDVDdkdMcW40MHBsM1VvbHRv?=
 =?utf-8?B?S0tLdnRRa29VRVplWExQU2ZYY2U2NnVRTXJXaXdOU3gwWFd1MzQrVndCTURE?=
 =?utf-8?B?MWUrcnYzTE50VGwyUk5udmpFMjBWaEd5WlpjejdBd1QzdE4yTHNpdGV3eUh0?=
 =?utf-8?B?dnEraXdLUmJkc0pVQVFZRlNFU1VtSDhnWncvSjFwZGJRYjlYUHpNYjlxM25O?=
 =?utf-8?B?K1lobDZUdUp3anNVa3RBQTJLcjZndWV4RGdYVmJGR25teVZxb0ZWOW9VbnVu?=
 =?utf-8?B?eEhkSGRTcG5LQStKRS94ZGRBNE1nWlM4OEEvMGd3TFQwcFJ4M25tRFBVY2dK?=
 =?utf-8?B?S0syOHJFQ1UveXZKT1ZOcmNKY3ZIZGwrVkVxWHR6L3ViVDRRWTBDMW1qbFZp?=
 =?utf-8?B?QTNxMk10UkV5M3QydVBUZnpzc1Byekw0WTRrU0hWY3MvaE8ya3JXU0NKUFZS?=
 =?utf-8?B?aTdXeDY1bmpVOTAvUi9pMC9ReW96SVVDS0xwWWdzdmVQaE14bTRtNXdDK29y?=
 =?utf-8?B?UGFwSi9kUC90emZ3OHFxamxXUHpWVk5qQ3R0cnEzVFpZNllac09maGlrN25o?=
 =?utf-8?B?V09nVWhHdTFzZ1RZR2RWZU05R2d2b0J6cGY4WWxhYmsrendXRlV6aXBid3Mz?=
 =?utf-8?B?RWtVZTRvOFIydytvRG9BUWt5UlUwQVR6c093SjI2bVdIczdybjZNclFzbUpw?=
 =?utf-8?B?L3NBL1NiR3A1UkVnVkZKQnUzam5BNTJLUFQxbk93STdNN3V1dW1XdXhZYzNz?=
 =?utf-8?B?dUF2ZHFnckNoWDVSYnhCdTFXamNpS3ErVkhVcGpxU2lnc1B3SWdER01VUG5t?=
 =?utf-8?B?Vy9CVzlscTRVb2lYd2F0bGxxVGR0WERRRWNVNGV2QzRwZEpWWjAxQ0JBZHlt?=
 =?utf-8?B?aDI1U2s3TytBMUl1Sm9WZ283eDdjWG9HeFQ2TG41WFRMekdDOXhMT0pOanJF?=
 =?utf-8?B?QmNld1J1WmRhaEhNN21MNXQwSUJZNDNtZ1N4M29qdHRwOUtDM1dsQlRzUFUx?=
 =?utf-8?B?cFU1TVAvUElyOWgzSjVOT3VDYTJ0TmZxc1h5WWtZQjdDUkVtVmZ3cXh5Sks4?=
 =?utf-8?B?c0FEbUhFZ2FSY0l2cVdMNXczbEpyQVQ5MGNVSW9xQ1prZVMxODVzcjZRdmxP?=
 =?utf-8?B?bzJYQTRYQ1pZb1p6UnczYzFSbDBBUVJCK2FiNlZLOWh2NXRqbFVwdWd0dS9h?=
 =?utf-8?B?WGZCMUZFMUNGWGN2cXNUaDFabzZha2psQUJjbzltcjVWbnh4bGZLNlBIbDg0?=
 =?utf-8?B?eWZrSjJ3YnRWRVhBczR3azN5cVpTcHRUZWhlSWY3ZTY4bUJrMTdVYXI4ZzBu?=
 =?utf-8?B?dXVIQzFCR1RBVVc4d1lpY0RseGk2eThXTitGQXFPNXphYTVWUXZ0VWJBdW1B?=
 =?utf-8?Q?6FNofYbXDrITLyeS9v1G59H9dZOH81tUhF8J60V7Lw07h?=
x-ms-exchange-antispam-messagedata-1: W1FFc5FOmczpXg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZFlYyv77W/YMdhZq2GjPphJB8i34jtC+EppQzbqEb44PCxnJfoWRdaiDXKOPenXhpo/+rEZ+YzGgy38NOOIzGBainIEiR3BulDbwYkE9NdYPXb18vDibMjVff46zeZbiJo7mRGzxtN0qehzGLh41Y7I0gXsDieONXhJzW8Tx+ScGdM8bEjXAKP8FKc0vbtjYbyFHC7A7JfyvPMl+0J+W8RChQPJd2KEk0C9eArtFch8IIbV7Xy/6ZqOnv3oSvfH/FWiowLH/3SCI/3eWRE2S/ep7SXZZ4/FxknFGGyaeik10k8NqGnwIeN26TVE+Hw9Tss7p7sfCXna23VmQPdolOQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2614a1-fa09-4311-f828-08def9cd6a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 06:29:38.2408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PNIw/YXrb8SksHpQcTtvKS1zBXmmqfGMawbAJTZ9q2BFKaLQUGbb4MSLvRWs6W9YYaC4DS9ZnUothyas90pNNPCQNAeWqoumop/vAQQHyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6977
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA0OSBTYWx0ZWRfXy6RTEc50O0Wp
 vsUjkjpcLY2Nb2Y+nSKI7gq2gnsAwrG3Bt8vv6+RXYdecr1G86mVJ29fUQHaO9PexdHps4tcGu/
 L36BGwdTWf9cBeaEhKXOgZ+MIA/g9Y8rzod+eDdX9Kp5UbeRaW6cAE6xcHucyiW/JvWLyHxlQoJ
 m5gkMlK30bP2xFzf1eHTIt4+fQdhG6xCvJyHjZWLMwgwvYdTHevnrvATx/s4qDzSPYrakMi2bXk
 o64Kt8ly33OYB61maEN9tKvRB97+SrafmvoepuXIuvy0tFJO0XPUD/ydNDsN3/4uHoIIx76fs3M
 vqEEKogzCKCDxAaUBaZrO65sVWqgzzwDuGfepRyjkCmiR1K+AAkhMNuRHfuhvPUA0BGS8j9Z5sV
 8AcLI7YXf7N2ch0ye5eYZwuyJIheme1lsDC5ha2vr6mWrXiOEbony2oyusrOqJPd8TDwS8lFr94
 RZf8ayjWGDFDsUHHkEw==
X-Proofpoint-ORIG-GUID: hOOkasaluiFxG15lsrM7fIM1yO8nDrAs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA0OSBTYWx0ZWRfXydDablgq/9v3
 LnROV3xyu7r4BHXn8roBEAkmFQ8yC/f5ke3XWhdG32M994IKLiTJ86pejIUSmd8qTdRiAkerUxm
 sNdrXAtP3B/mTYLIoH+zMKn3Am87MEA=
X-Authority-Analysis: v=2.4 cv=ApbeGu9P c=1 sm=1 tr=0 ts=6a7eb5d5 cx=c_pps
 a=YkHaaIsEX1QH8E31U4hA2w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=64Cc0HZtAAAA:8
 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=uqWhNtoaQTk3GqIFXJIA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: hOOkasaluiFxG15lsrM7fIM1yO8nDrAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIdWdvIEtvbWF0c3UgPGh1Z28u
a29tYXRzdUBudXRhbml4LmNvbT4NCj4gU2VudDogMTMgQXVndXN0IDIwMjYgMTI6MzENCj4gVG86
IEpvaG4gTGV2b24gPGpvaG4ubGV2b25AbnV0YW5peC5jb20+OyBUaGFub3MgTWFrYXRvcw0KPiA8
dGhhbm9zLm1ha2F0b3NAbnV0YW5peC5jb20+OyBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhh
dC5jb20+Ow0KPiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEh1Z28gS29tYXRzdSA8aHVn
by5rb21hdHN1QG51dGFuaXguY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHZmaW8tdXNlcjogcmVq
ZWN0IGZhaWxvdmVyIGR1cmluZyBpbml0DQo+IA0KPiBWaXJ0aW8tbmV0IGZhaWxvdmVyIGlzIGEg
bmV0d29ya2luZyBmZWF0dXJlIHRoYXQgcmVsaWVzIG9uIGEgcHJpbWFyeQ0KPiBhbmQgc3RhbmRi
eSBkZXZpY2UgcGFpci4gVGhpcyBpcyBub3QgY3VycmVudGx5IHN1cHBvcnRlZCBmb3IgdmZpby11
c2VyLg0KPiBSZWZ1c2UgaW5pdGlhbGl6YXRpb24gaWYgdGhpcyBwcm9wZXJ0eSBpcyBzZXQuDQo+
IA0KPiBDaGFuZ2UtSWQ6IEk4MDk4OWRkYjA4YTFjZDNlYmE4NGJjZjliMGVkYzI2Y2I0YTY1NjY5
DQo+IFNpZ25lZC1vZmYtYnk6IEh1Z28gS29tYXRzdSA8aHVnby5rb21hdHN1QG51dGFuaXguY29t
Pg0KPiAtLS0NCj4gIGh3L3ZmaW8tdXNlci9wY2kuYyB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody92ZmlvLXVzZXIvcGNp
LmMgYi9ody92ZmlvLXVzZXIvcGNpLmMNCj4gaW5kZXggZWNjNTlhOTY0Mi4uMzRmYTJmMjJiMyAx
MDA2NDQNCj4gLS0tIGEvaHcvdmZpby11c2VyL3BjaS5jDQo+ICsrKyBiL2h3L3ZmaW8tdXNlci9w
Y2kuYw0KPiBAQCAtMjUxLDYgKzI1MSwxMSBAQCBzdGF0aWMgdm9pZCB2ZmlvX3VzZXJfcGNpX3Jl
YWxpemUoUENJRGV2aWNlICpwZGV2LA0KPiBFcnJvciAqKmVycnApDQo+ICAgICAgICAgIHJldHVy
bjsNCj4gICAgICB9DQo+IA0KPiArICAgIGlmIChwZGV2LT5mYWlsb3Zlcl9wYWlyX2lkKSB7DQo+
ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgInZmaW8tdXNlcjogZmFpbG92ZXIgaXMgbm90IHN1
cHBvcnRlZCIpOw0KPiArICAgICAgICByZXR1cm47DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgc29j
a19uYW1lID0gdWRldi0+c29ja2V0LT51LnFfdW5peC5wYXRoOw0KPiANCj4gICAgICB2YmFzZWRl
di0+bmFtZSA9IGdfc3RyZHVwX3ByaW50ZigidmZpby11c2VyOiVzIiwgc29ja19uYW1lKTsNCj4g
LS0NCj4gMi4zOS4zDQoNCkxHVE0gZXhjZXB0IHRoZSBDaGFuZ2VJZCBKb2huIG1lbnRpb25lZC4N
Cg0KUmV2aWV3ZWQtYnk6IFRoYW5vcyBNYWthdG9zIDx0aGFub3MubWFrYXRvc0BudXRhbml4LmNv
bT4NCg==

