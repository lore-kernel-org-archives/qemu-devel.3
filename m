Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E98CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbm8k-0007qU-Qu; Mon, 22 Jun 2026 17:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wbm8h-0007qE-Lr
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:25:07 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wbm8f-0008MH-Ag
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:25:07 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJceOI1109343; Mon, 22 Jun 2026 14:24:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=D8Uw/+T+bKcA2uAGQJZVQPAQ7V982bcTl79MfKBQu
 iQ=; b=pGfDNtE/Tks4f64+XF00BFMuyZ26FiATJ3IY8lCKn1y1q1xbIe+diYaoc
 THgGeYwVhXQG+UkgJcndik7yLXtOSqsPy1oY18aJFU9dDNL0bbTAr04OIeCr1GiM
 e0qI31LD8K5RlSr9G/JvNqlMmOXlTY5vvdllC7v/8OQHBi+qyQewMr3ODave14FX
 LQIrm53X7A2Efc+PL1Mu5C98jSnDudeEEcAU6GeamyttsFZis9wwMhmD2uiebn4B
 qO5kKosLFqbN/npWRgwpMuK/PGQDretMJiND0oZgi+LQMwxc3KLbd4ZI6o+m2RGJ
 QbT69E+A7KeJJ00vpD2ayjDcSWuUQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021101.outbound.protection.outlook.com [52.101.52.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ewtdumum1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 14:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7U9IfjDURzVKVTlKvUYza6hB+aBtMx32ocJbLUS6F9HvsRYDDO4PuqwLxpekJuAVXySPqbl0tJCvkN2MaCmUAGNAhWU/fb6xr2iDsymlSUMgTh0W80WSzu3EJtlePvIuN99ge1gcGrAeJkAvGM+g5oFAKgSySaLRWM1M33IQ2AoTiYkNQ55NhfLPv5c+IB/OKUB+9qcUGXgjqaIwQQ5kYQyn58k8I9s/voWNKNhUSMfL9tgENJg+emzQN8oN0XoJJlMUWqqKvQun+sfBJmuZCCByNNZ4D9qz7kF62h5i8EiAEjpgXrO7S8HyUD37XTh7VNQo9OSAX3rm5eZZ/Zd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8Uw/+T+bKcA2uAGQJZVQPAQ7V982bcTl79MfKBQuiQ=;
 b=T3vdF8hfHVUdnba2qy0QTWFPKAoZPdAzlnMfpq2EzzGuat1/DTvWix5EinyNje5dKGSsjjbmiMv96M/r65VpMiZ8inH354nqZnSsz+QQEOSd7MjyaXQZycMdx9dbEVmJ+5bameEmTYaqNHgEJcoM/XUw/WyJ9PD9L7FD62qdIMw8XEYa1QWmYu+TXAO28v6GTP6tUzEzoUKtA58iSmmD3jVTdrc1CP2SyNa9wzgqAnEcGi13Nqp50ie5MPFJ95Clgetg8zw9OtDT8+PEcKssqcx0p3VB+Eh5WeYELuETsKXkfCShK5nQ1ZDRS/sOxUmYjawKlYiweR6/0uitgY+7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8Uw/+T+bKcA2uAGQJZVQPAQ7V982bcTl79MfKBQuiQ=;
 b=dd2BarUmKHxwGksMj1uo10VDXnutaHRq/mi7/tLc8q3C3zAaIyKxuH7KjNf/mknsZbqEc1EaoZVf/IUUqA5VZA8iARQK0FQV5ZjcXr1M0EQcYld4JdmgCkUDfRKeswn71MS4yUeJF5kM4MClaUtiz6bWkI4BnJfBajYar3OZWY9/epda7hs/emypfVZUMbGx9kz5k+bK2keqYzVxsXYDgVyUXNcms6rcGzxrRjv3SBtxD8nhaYQkDs1ecPthGwdGZrf2BQIu4evE1nviRe6JL5CvLQHVTFatB7ePgbjhgrcwW1G5js6jnt7AxItCcnHeHROZK+EP/XB1h90FeAsmnQ==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by BN0PR02MB8080.namprd02.prod.outlook.com (2603:10b6:408:16f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 21:24:31 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 21:24:31 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Paolo Bonzini
 <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
CC: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>,
 =?utf-8?B?SGVydsOpIFBvdXNzaW5lYXU=?= <hpoussin@reactos.org>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas
 <farosas@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, John
 Levon <john.levon@nutanix.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
Subject: RE: [RFC 4/7] system: add memory_region_new / memory_region_new_io
Thread-Topic: [RFC 4/7] system: add memory_region_new / memory_region_new_io
Thread-Index: AQHc/ajS0o5znkToqEKJgn3Ax0eVeLZCtEiAgACmAoCAArzSgIAElryAgABurmA=
Date: Mon, 22 Jun 2026 21:24:31 +0000
Message-ID: <IA0PR02MB94625343624EEBC89B3AE86F8BEF2@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-5-berrange@redhat.com>
 <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
 <9976f829-7c33-7dce-b38e-aa6f04d6ec9d@eik.bme.hu>
 <78798c63-5ca9-4acc-a878-8638724d487c@redhat.com>
 <2660c118-474e-4160-9b26-25694d02d676@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <2660c118-474e-4160-9b26-25694d02d676@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|BN0PR02MB8080:EE_
x-ms-office365-filtering-correlation-id: 34504041-999f-4728-129a-08ded0a4a610
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|4143699003|5023799004|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: vzyBIXXEFXJOdPaPBHTyx6qwrC1tQ3isyiKG2gpqJ2p1+I0tUmkLbxD5trEXeLVPRwg28hFceGmWwhP6L+qPzTb+hCCfSoUVmxGq0ICy643N0/9L2KWBc1lgXv3fq059AwA0OrpIY2y07tu1cyuKwuRD7lKn4E8UHuyN0QA9tU8N58/EXy21kIbmK/9HkK4kiRRLnaWy1HlkfbZveu5kXtgNPdDx5LN9Bolomaz0tWMt0JzBU6RX7u8AZ1gsOWSELPi8HbAt6WuQLb4d+XShrhGY9sgxjMMyU3PUNLoSNpR3ASQOrLrqmkKKMMjqySFmjxewNf/hXT5zxeVj5Z9eTWu8HTqiShqfowB+Q/wlxOiosBGTljcqa0slGuqOaOKgCqjygBJERbaI8ENvvK8eWLr2C3I3ZPA1JjM7JnFynSF3WHPdxsuIvks+ofOcplKRylgiFxIPRR3mzsGNJBdQtXLTLMxBmBY8mda4bnrpcfs6d42Z+lHv54jUrmrIvotSBjZtPz8aaAGMyqv4brpUZVDjyaDq8TV6/hLgwgcRLOr4SvK6652VmgUPznNnnbyIQcCNhoKsna4zatj/YxZUXPmGIioMQF2UYIXstDcuc+K7ICCMlWaLzgL5kXkcwp5Zqq1C0xRM/qCOe9wgUFN8Id71BrDq6fdhMXq26gWJHC27lwOW/t3cz4Kx7QEQ49xRfUPtGxl2QUgIO+b9L3kQGMLdoPRXR9gFs+pcJJ2Qar0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(4143699003)(5023799004)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3p3V3N3SWUvVDRKR2V6aXlmdjFEMTZNOVVyZHZnQnh1NHgxV3FkNzZqNFVB?=
 =?utf-8?B?Tk9DUmQ3K1N1dmtvZktsdUdFVGxkbEFWWEJKWm5PMlpzTzNWc3VEWkNtU0tv?=
 =?utf-8?B?bnNZOWRHcmNJbmphc0NWT3JpMlNzTXY1amVseHh6QkpJYU5lU0hZMkRsZWVo?=
 =?utf-8?B?ZDRrV2c4bUh0ak5sb2lWTDREQUlVNkdWUTJLZVIyWHdzc0RLMUJ4anUvQlR0?=
 =?utf-8?B?R21LbFlkRERJMmtoNnp6clE4SUJaRjJkaFZ5SzgyREVCTFcvUjlSWitlV055?=
 =?utf-8?B?UTBnZnpheDhwS29MQUFVVGZJVTN5NkF2YitjRVVLQVdoSVNJejN4TXRVMEZI?=
 =?utf-8?B?Y0oxbWJERlNiVlFYUHdOeHIwQWZlcHVGNW10a2N1UUZjZUtNOTdocVBNTS91?=
 =?utf-8?B?RVJuclZGQ3hJdWpWTm9qNGdLLzEwTUh4K005bWo1NnNtdS9Sc1c4cmloYkVv?=
 =?utf-8?B?L3o1VjZEbnFsVERDZTVBallOTEkzL2xFVEFtQjZtM29pVXpiZVgwWlpzNUVy?=
 =?utf-8?B?SEZLMW0vUnowTE8vNEhpSGprOTUrdXpxNVkxU2UrMDhyMTYvK2hmSFg2bmw3?=
 =?utf-8?B?OWJheHpJMlF6eHQxMzRiL2tuSFBLZjl0SDIzcWhlZjFhb2tSWjlwZjRPNGgx?=
 =?utf-8?B?NHhxSi9ScmFDdkt5MWg1d05HQXpvZDBNMGtsd3ZzMXNHSmtQbzBBaXQxSGM5?=
 =?utf-8?B?QVhVTTV6NXE1MEhiaWlkZGQ5OFlXWWpCL2gzakZnWUVuc0Ftd3lmYUpuT1hi?=
 =?utf-8?B?RThSdlZJdWdUdndIY0NvcEV3RWFqbWFJSXpMR2RoYmNmeUpMNUh3WjY2U09T?=
 =?utf-8?B?em1nUHRCMGNDUC80djh5cGk3WFhYZUlYZWxOOHdySTNaYUpZQ3FRdGdXQ2VU?=
 =?utf-8?B?dWdqS3lmTUc0UnVac1RoUVp2aHU3K0dxMFBFK1ZDOGJwN1lmeVZPekc2Y2Zk?=
 =?utf-8?B?dmcyakNqTC84NXpmaTdWSDBJSEM5Uk5mTlpNTnlYbnJKR3dIYkllMFo0SjJB?=
 =?utf-8?B?S2YzYXE5QWcrMUZiQlRhZGRrU01oSnB4N3pQanRmbHptdjMrSDNCdC81aG5m?=
 =?utf-8?B?cWYxVSs0c1NWdEJaaHY0bVBJSVJMQVJtcmVNeFBTZ0NGWGpNUUQrM0E3K2p0?=
 =?utf-8?B?T1MyMHE1RitQOEQrSE1kZG9rbHB6SjRDZjExZUNMWFpkeFZia2hoL0tNQnVz?=
 =?utf-8?B?MS80a3ZNTlJJRW9taHI2OUZxNFh0ZmdPQ0o4Zk9ZTUtNcVV3MzlqS3JvUWZp?=
 =?utf-8?B?UVJsR2NHZTZWL3NpMndyS0FDMk5HL1FqbmdLT0FHdk5pQmlhN3d3c0VMQXZu?=
 =?utf-8?B?b0UyeXZwaVNmWkdidjVZcDMvc2YxSWYzOXArY0Y2dkxYdHRIR0lVbDhJcE1U?=
 =?utf-8?B?Yk1kQ0FTTTc4OHd5N1pRVWppUHBRUGtuODEybmlmc1ZIUzBiZThlR0phdUhV?=
 =?utf-8?B?MEdwQ3hzQlZ2ZGpXbzhoSjJDRDkzWUdqckkzaXk3dkVkeFZEUnd4WmFtSWZk?=
 =?utf-8?B?dnVvTm9qcWlqbk5jb28vdW4vcWxxYW02MWZPODBKeS9hZjd4UUVoMDdSLzFM?=
 =?utf-8?B?M0dRRVNZSEJMTzdPNXhjRFhGUGUycVhjOW11L2RXdlRJUXZDQjh5V2wrcXlE?=
 =?utf-8?B?M0U0d24zSnZTWkZDTkZXQnA5L3lBZSsyd01HeHkxalV6a2JXaXIxT3RTcU5h?=
 =?utf-8?B?d3pqVVVFNzFlU2ZKMUhEaGdodEM2cSs1cG9yUmgrRFJpZVVjMllQcGFQOFgz?=
 =?utf-8?B?eitCamdtYWMxd1p0bGJRdkQvSHFhWDFKOFpMYWhBVEIwMnh6QjJFTXNUeGlW?=
 =?utf-8?B?NzNYZGpQOFVtWEJrR0I1OGMzb1RaVk5CUlhoTURaWS93UFIvUTZGcGhXcjl1?=
 =?utf-8?B?a29QZlBKeSt3MFEvNmJ4cTVta3NzRzN4eHI3c1hrM014SnFMV3NnNU52QTEy?=
 =?utf-8?B?MWxnYVBXUGxiQjFYdWQrUUZvQnQrVjZ6aExWVCswYzMzTVJTOTFoVHhpNVNy?=
 =?utf-8?B?dWdEY1FPRmJZTDg0cXRaOWJweHZEYTdOQU1rNzBpNHBZZUYrYlkyWUMwSnVn?=
 =?utf-8?B?dWpYUWxGRDFRQkdQR0FOSTJBam5hazQ3SXlVdi9MUkpMd2FyQm9USEN0Yjhv?=
 =?utf-8?B?VFM2djZqYktPbVdHZlFPakpMdWYrbEJSTHFjT1pxWTJpT3V3dU5rWitMVEU3?=
 =?utf-8?B?NVhVWEwwV1ZvUSs1Nm5OajdnZ1grUnlrT0dNOFBKc2J5Vzd3c2k2clpBR3A3?=
 =?utf-8?B?MXNTYUFGRjBFVi9VUFdiemhtcjA2aDlJOW9UMnlraXJQWmxYS3VZc29ISTdv?=
 =?utf-8?B?NzZmTU5aVVVzYkkxWEIzZE1STWR1SGJrWG55QnpwWitybjF4bVZFUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: meH7qJUTRGbvK939e0+us5bO0RbI8CX0Z4f2buzeAzTi6Rarj0cKAsYF9QAE+CGCVBozxBHu6cLrWVF2NAehmdprEJktlcEbLQJ7HVy/fSMe8bu6i7wAKoS/7N2V+RsZmn0jLrzFTWtG8M8HNP+8iG/7ouljV2gy5PMSBiOOFV9SzuYSNrFGSyQojAuStORnGkZCozlOoysjp6q8nUrf3lT+TheXozg+lfHukI6FBMvd+WkqFB8Rr2lKpbUQoDsW6AcRGI2S4Q1e4n28aQs6klvccWP0q7mjWz3tpmzAAqwHj39fSTnCk9hjJ449o9/q6aQx8wCLPTczDZGTKZKiKQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34504041-999f-4728-129a-08ded0a4a610
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 21:24:31.1858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pq9oMbxdgBhDdu+wJj72r6R9qiIs/rXDN1jS8V/nF2aM6jWhyr108VfG/0psQ8lK2IK45215EIDm3BdpuEzzXq+WXDIthrRsFKcdusH0S08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8080
X-Proofpoint-GUID: Sck6dzTVpWiAvmOItI4ZUDeufiCXSchL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNiBTYWx0ZWRfX1CbPr6C+r4Cx
 IOnDPUT620OdY8HU6ispiXmh7n2t31uzrmQtCZTO7XG4iMKVHq0K6HXYqRhrIDnlTyNm4qV/xg+
 Z2O2Ve+v1F8PbwEOB0JSlM8WdTo0dHQ=
X-Proofpoint-ORIG-GUID: Sck6dzTVpWiAvmOItI4ZUDeufiCXSchL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNiBTYWx0ZWRfX0crCcpCQ+MqA
 hRr4rz4p0IWZmA2xYw01fDLkPuICCi9nVk6udPDl7xFjuA6XsOOdZ/eK80WR7mnt8JMUB7bsLn6
 WvZAxw5a5M8WZFOQEfT9mJieu/RTvRsvP/hiVPdtsCOMOTiU8+dJun0vgb0Nam9Pgh0n/HwlO5T
 7IeHaLOtpo/dM1gHDPD2ML08sz/lzEQzBB+yDUM8dHzKrG64IpwBFzh4byPBGmYgrODmJC8mJgR
 O6aBDsfHh8hCznDGoSAszqm4h1LI3qYQ/AxTOaDVx4irtXGywVH5FpLTGfEW+H9OinDMPgipHlF
 SBZXIui1qBGor6eq5egAJad6pVzUDcJiyR95mtgu84uH3OBN3hnFsjpz8+R5BmcZd/YoUUQkECK
 SLPIbAdde/OazypB+LejJVehQw7eeJlPsxVIxbotK2GCNYz4BbIrczLIuq7u24bi8gx99FWSfGH
 W15oPr29dAr2QLIvHew==
X-Authority-Analysis: v=2.4 cv=VpITxe2n c=1 sm=1 tr=0 ts=6a39a812 cx=c_pps
 a=3cYuoP5kWG2k1oDcrssWdQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=20KFwNOVAAAA:8
 a=69wJf7TsAAAA:8 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8 a=up-X0YpDAAAA:8
 a=KKAkSRfTAAAA:8 a=hXZgYZo4AAAA:8 a=pcZqCyVeAAAA:8 a=64Cc0HZtAAAA:8
 a=xgwHZRAv8z4PqNmtEpkA:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=MH9Ivq0PDQRhlrFuIVvX:22 a=86FmjZgct7XXK6GGpxvI:22 a=cvBusfyB2V15izCimMoJ:22
 a=37BJPeUnzxYkbV1yBC-1:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBa2loaWtvIE9kYWtpIDxvZGFr
aUByc2cuY2kuaS51LXRva3lvLmFjLmpwPg0KPiBTZW50OiAyMiBKdW5lIDIwMjYgMTU6MzcNCj4g
VG86IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBCQUxBVE9OIFpvbHRhbg0K
PiA8YmFsYXRvbkBlaWsuYm1lLmh1Pg0KPiBDYzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFu
Z2VAcmVkaGF0LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBtYWlsby5jb20+OyBQaWVycmljayBCb3V2aWVyDQo+IDxwaWVycmlj
ay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+OyBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+
Ow0KPiBIZXJ2w6kgUG91c3NpbmVhdSA8aHBvdXNzaW5AcmVhY3Rvcy5vcmc+OyBBbGV4IEJlbm7D
qWUNCj4gPGFsZXguYmVubmVlQGxpbmFyby5vcmc+OyBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPjsgQXVyZWxpZW4NCj4gSmFybm8gPGF1cmVsaWVuQGF1cmVsMzIubmV0PjsgRmFi
aWFubyBSb3NhcyA8ZmFyb3Nhc0BzdXNlLmRlPjsgTWFyayBDYXZlLQ0KPiBBeWxhbmQgPG1hcmsu
Y2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPjsgTWFyYy1BbmRyw6kgTHVyZWF1DQo+IDxtYXJjYW5k
cmUubHVyZWF1QHJlZGhhdC5jb20+OyBKb2huIExldm9uIDxqb2huLmxldm9uQG51dGFuaXguY29t
PjsNCj4gVGhhbm9zIE1ha2F0b3MgPHRoYW5vcy5tYWthdG9zQG51dGFuaXguY29tPjsgQ8OpZHJp
YyBMZSBHb2F0ZXINCj4gPGNsZ0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyA0Lzdd
IHN5c3RlbTogYWRkIG1lbW9yeV9yZWdpb25fbmV3IC8NCj4gbWVtb3J5X3JlZ2lvbl9uZXdfaW8N
Cj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgIENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSENCj4gDQo+IE9uIDIwMjYvMDYvMjAgMTozMiwgUGFvbG8gQm9uemluaSB3cm90
ZToNCj4gPiBPbiA2LzE4LzI2IDAwOjQ0LCBCQUxBVE9OIFpvbHRhbiB3cm90ZToNCj4gPj4gT24g
V2VkLCAxNyBKdW4gMjAyNiwgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gPj4+IE9uIDYvMTYvMjYg
MTc6NTUsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+ID4+Pj4gUHJlcGFyZSBmb3IgdGhl
IG1vdmUgdG8gZHluYW1pY2FsbHkgYWxsb2NhdGVkIG1lbW9yeSByZWdpb25zIGJ5DQo+ID4+Pj4g
aW50cm9kdWNpbmcgbWVtb3J5X3JlZ2lvbl9uZXcgYW5kIG1lbW9yeV9yZWdpb25fbmV3X2lvIGZ1
bmN0aW9ucw0KPiA+Pj4+IHdoaWNoIGNhbGwgdGhyb3VnaCB0byBvYmplY3RfbmV3IGluc3RlYWQg
b2Ygb2JqZWN0X2luaXRpYWxpemUuDQo+ID4+Pg0KPiA+Pj4gTWVtb3J5UmVnaW9uT3BzIGNhbGxi
YWNrIHdpbGwgY2VydGFpbmx5IGFjY2VzcyBmaWVsZHMgaW4gdGhlIHBhcmVudC4NCj4gPj4+IEhh
dmluZyBhIHNlcGFyYXRlIG9iamVjdCBnaXZlcyB5b3Ugbm8gYmVuZWZpdCBiZWNhdXNlIHlvdSBz
dGlsbCBoYXZlDQo+ID4+PiB0aGUgc2FtZSB1c2UtYWZ0ZXItZnJlZSBpZiB0aGUgTWVtb3J5UmVn
aW9uIG91dGxpdmVzIHRoZSBkZXZpY2UuDQo+ID4+PiBMaWtld2lzZSBmb3IgYnVzZXMuDQo+ID4+
Pg0KPiA+Pj4gSWYgdGhlIGRldmljZSBpdHNlbGYgaXMgZW1iZWRkZWQsIHRoZW4gYWxsIHRoZSBp
bnZhcmlhbnRzIG11c3QgaG9sZA0KPiA+Pj4gcmVjdXJzaXZlbHk6DQo+ID4+Pg0KPiA+Pj4gLSB0
aGUgZGV2aWNlIG11c3QgYmUga2VwdCBhbGl2ZSBieSBtdXR1YWwgcmVmZXJlbmNlcyBiZXR3ZWVu
IHRoZQ0KPiA+Pj4gZGV2aWNlIGl0c2VsZiBhbmQgaXRzIHBhcmVudDsNCj4gPj4+DQo+ID4+PiAt
IHVucGFyZW50IGZvciB0aGUgZGV2aWNlIHNob3VsZCB3YWl0IGZvciBhbGwgZ3Vlc3QgbWVtb3J5
IGFjY2Vzc2VzDQo+ID4+PiB0byBiZSBlaXRoZXIgY29tcGxldGVkIG9yIGNhbmNlbGxlZC4NCj4g
Pj4+DQo+ID4+PiBTbywgdGhlIHByb2JsZW0gaXMgdGhhdCAiUUVNVSBhdXRvbWF0aWNhbGx5IHJl
ZmVyZW5jZXMgdGhlIG93bmluZw0KPiA+Pj4gRGV2aWNlIHRvIGtlZXAgdGhlIE1lbW9yeVJlZ2lv
biBhbGl2ZSIgaXMgYSBoYWNrIHRoYXQgc2hvdWxkIGRpZS4NCj4gPj4+IFsuLi5dIEkgZGlzYWdy
ZWUgdGhhdCByZW1vdmluZyBlbWJlZGRpbmcgd2lsbCBmaXggYW55IGJ1Z3MNCj4gPj4NCj4gPj4g
SSdtIHRyeWluZyB0byB1bmRlcnN0YW5kIHRoaXMgYmV0dGVyLiBUaGUgd2F5IGl0IG9yaWdpbmFs
bHkgbWVhbnQgdG8NCj4gPj4gd29yayBhY2NvcmRpbmcgdG8gdGhlIG1lbW9yeSByZWdpb24gZG9j
cyBhbmQgaW1wbGVtZW50YXRpb24gaXMgdGhhdA0KPiA+PiBtZW1vcnkgcmVnaW9uIGlzIGFkZGVk
IHRvIGFuIG93bmVyIGFzIGEgY2hpbGQgd2hpY2ggdGFrZXMgYSByZWZlcmVuY2UNCj4gPj4gYW5k
IHdoZW4gdGhlIG93bmVyIGlzIGZyZWVkIGl0IHdpbGwgdW5wYXJlbnQgaXRzIGNoaWxkcmVuIHdo
aWNoIHdpbGwNCj4gPj4gdGhlbiBnZXQgdW5yZWZlZCBhbmQgZnJlZWQgYXMgd2VsbCBpZiBub3Ro
aW5nIGVsc2UgaW5jcmVhc2VkIHRoZWlyIHJlZg0KPiA+PiBjb3VudC4NCj4gPg0KPiA+IFllcywg
YW5kIHRoYXQncyBicm9rZW4uDQo+ID4NCj4gPj4gVGhlIHByb2JsZW0gaXMgdGhhdCB3aGVuIHNv
bWV0aGluZyBhY2Nlc3NlcyB0aGUgbWVtb3J5IHJlZ2lvbiBpdCBoYXMNCj4gPj4gdG8ga2VlcCB0
aGUgb3duZXIgYWxpdmUgYXMgd2VsbCBzbyBpbnN0ZWFkIG9mIHJlZmVyZW5jaW5nIHRoZSBtZW1v
cnkNCj4gPj4gcmVnaW9uIGl0IHJlZmVyZW5jZXMgdGhlIG93bmVyIChub3QgZGlyZWN0bHkgYnV0
IHVzaW5nDQo+ID4+IG1lbW9yeV9yZWdpb25fcmVmIHdoaWNoIGRvZXMgdGhpcykuDQo+ID4NCj4g
PiBBIG1lY2hhbmlzbSB0byBrZWVwIHRoZSBvd25lciBhbGl2ZSBleGlzdHMsIGFuZCBpdCBpcyBt
dXR1YWwgcmVmZXJlbmNlcw0KPiA+IChzbyB0aGF0IG5laXRoZXIgb3duZXIgbm9yIE1SIGRpZSkg
KyB1bnBhcmVudCBvZiBvd25lciAod2hpY2ggc2hvdWxkDQo+ID4gd2FpdCBmb3IgcGVuZGluZyB1
c2VycyB0byBjb21wbGV0ZSBiZWZvcmUgcmV0dXJuaW5nKS4NCj4gPg0KPiA+IFRoZSBmYWN0IHRo
YXQgdGhpcyBtZWNoYW5pc20gaXMgbm90IHVzZWQsIGkuZS4gdW5wYXJlbnQgb2YgYSBQQ0lEZXZp
Y2UNCj4gPiBkb2VzIG5vdCB3YWl0IGZvciBwZW5kaW5nIEJBUiBhY2Nlc3NlcyB0byBjb21wbGV0
ZSwgaXMgYSBidWcuDQo+ID4NCj4gPj4gU28gZW1iZWRkaW5nIHNlZW1zIHVucmVsYXRlZCB0byB0
aGlzIHBhc3NpbmcgcmVmcyBvbg0KPiA+PiBtZW1vcnkgcmVnaW9ucyB0byBvd25lciBhbmQgY291
bGQgYmUgZml4ZWQgc2VwYXJhdGVseSB0aGF0IG15IHBhdGNoZXMNCj4gPj4gYXR0ZW1wdGVkLg0K
PiA+DQo+ID4gWW91ciBwYXRjaGVzIGFkZCB0aGUgcG9zc2liaWxpdHkgb2Ygbm90IGVtYmVkZGlu
ZzsgSSBkb24ndCBsaWtlIGhhdmluZw0KPiA+IHR3byBzZXBhcmF0ZSBBUEksIGJ1dCBJIHRoaW5r
IHdlIG9ubHkgaGF2ZSBhIGRpc2FncmVlbWVudCBvbiBhZXN0aGV0aWNzLg0KPiA+DQo+ID4gVGhp
cyBpcyBkaWZmZXJlbnQgZm9yIERhbmllbCdzIHBhdGNoZXMsIHdoaWNoIHRyeSB0byBmaXggc29t
ZXRoaW5nIGJ5DQo+ID4gbm90IGVtYmVkZGluZywgYW5kIEkgZG9uJ3QgdGhpbmsgdGhleSBkby7C
oCBDdXJyZW50bHksIGlmIHRoZSBvd25lciBkaWVzLA0KPiA+IHRoZSBNZW1vcnlSZWdpb24gZGll
cyB3aXRoIGl0IHdoaWxlIGl0IHNob3VsZG4ndCAod2hpY2ggaXMgYSBwcm9ibGVtLA0KPiA+IGFi
c29sdXRlbHkpLsKgIEJ1dCB0aGVzZSBwYXRjaGVzLCB3aGlsZSBwcmV2ZW50aW5nIHRoZSBNUiBm
cm9tIGR5aW5nLA0KPiA+IHN0aWxsIGxlYXZlIGFyb3VuZCBhIGRhbmdsaW5nIHBvaW50ZXIgdG8g
dGhlIG93bmVyIGZyb20gdGhlIE1SLCBzbw0KPiA+IHRoZXJlJ3Mgbm90IG11Y2ggZ2FpbmVkIGlm
IGFueXRoaW5nLg0KPiANCj4gSSB0aGluayB3ZSBjYW4gc3RhY2sgZm9sbG93LXVwIHBhdGNoZXMg
dGhhdCByZWplY3QgYWNjZXNzZXMgdG8NCj4gTWVtb3J5UmVnaW9ucyBvd25lZCBieSB1bnJlYWxp
emVkIGRldmljZXMuIFRoYXQgd291bGQgbWFrZSB0aGlzIGEgbW9yZQ0KPiBjb21wbGV0ZSBzb2x1
dGlvbi4gQWNjZXNzaW5nIGFuIHVucmVhbGl6ZWQgZGV2aWNlIGlzIGFuIHVuc2FmZSBjb3JuZXIN
Cj4gY2FzZSBhbnl3YXksIHNvIGl0IGlzIGJldHRlciB0byBjbG9zZSBpdCBleHBsaWNpdGx5Lg0K
PiANCj4gbWVtb3J5X3JlZ2lvbl9pbml0X3JhbV9wdHIoKSBhbmQgbWVtb3J5X3JlZ2lvbl9pbml0
X3JhbV9kZXZpY2VfcHRyKCkNCj4gYXJlDQo+IGEgbGl0dGxlIG1vcmUgY29tcGxpY2F0ZWQsIGJl
Y2F1c2UgZGlyZWN0IGFjY2Vzc2VzIHRvIHRob3NlIHJlZ2lvbnMgY2FuDQo+IGhhcHBlbiBvdXRz
aWRlIHRoZSBCUUwuIFN0aWxsLCB3ZSBjYW4gdW5tYXAgdGhlIG1lbW9yeSB3aGVuIHRoZQ0KPiBN
ZW1vcnlSZWdpb24gaXMgZmluYWxpemVkLCBhcyBtZW1vcnlfcmVnaW9uX2luaXRfcmFtKCkgYWxy
ZWFkeSBkb2VzLg0KPiANCj4gSG93ZXZlciwgYWZ0ZXIgbG9va2luZyBpbnRvIHRoaXMgZnVydGhl
ciwgSSBmb3VuZCBvbmUgY29tcGxpY2F0aW9uOg0KPiB4LXZmaW8tdXNlci1zZXJ2ZXIuIEluIHRo
YXQgY2FzZSwgdGhlIHVubWFwIHRpbWluZyBpcyBjb250cm9sbGVkIGJ5DQo+IGxpYnZmaW8tdXNl
ciwgc28gUUVNVSBjYW5ub3Qga2VlcCB0aGUgbWVtb3J5IG1hcHBlZCB1bnRpbCB0aGUNCj4gTWVt
b3J5UmVnaW9uIHJlZmVyZW5jZSBpcyBkcm9wcGVkLiBUaGlzIGlzIG5vdCBhIG5ldyBpc3N1ZTsg
aXQgaXMgYQ0KPiBwcmUtZXhpc3RpbmcgdXNlLWFmdGVyLWZyZWUgaGF6YXJkLiBJIHRoaW5rIGEg
cHJhY3RpY2FsIGZpeCB3b3VsZCBiZSB0bw0KPiBleHRlbmQgdGhlIGxpYnZmaW8tdXNlciBBUEkg
dG8gc3VwcG9ydCBhc3luY2hyb25vdXMgdW5tYXBwaW5nLg0KPiANCj4gQ2MnaW5nIHRoZSB2Zmlv
LXVzZXIgbWFpbnRhaW5lcnMuDQoNClZGSU9fVVNFUl9ETUFfVU5NQVAgaXMgYWxyZWFkeSBhc3lu
Y2hyb25vdXMsIGl0IHNlbmRzIHRoZSByZXNwb25zZSBvbmx5IGFmdGVyIGl0J3MgZG9uZSB1bm1h
cHBpbmcuIFdoYXQgd291bGQgdGhhdCBhc3luY2hyb25vdXMgdW5tYXBwaW5nIEFQSSBsb29rIGxp
a2U/IFZGSU9fVVNFUl9ETUFfVU5NQVAgd291bGQgc2VuZCBhIHJlc3BvbmQgdGhhdCBpdCByZWNl
aXZlZCB0aGUgb3BlcmF0aW9uIGFuZCBzdGFydGVkIHVubWFwcGluZywgYW5kIHRoZW4gYW5vdGhl
ciBvbmUgdG8gc2F5IGl0J3MgZG9uZSB1bm1hcHBpbmc/DQpBbHNvLCBzaW5jZSAoQUZBSUspIHgt
dmZpby11c2VyLXNlcnZlciBpcyBvcnBoYW5lZCBpcyBpdCB3b3J0aCBwdXR0aW5nIHRoZSBlZmZv
cnQgaW4gdGhpcz8NCg0KPiANCj4gUmVnYXJkcywNCj4gQWtpaGlrbyBPZGFraQ0K

