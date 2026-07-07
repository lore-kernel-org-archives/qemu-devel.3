Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BABC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5dY-0002pv-NB; Tue, 07 Jul 2026 09:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wh5cT-00020F-OK; Tue, 07 Jul 2026 09:13:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wh5cR-0000UJ-2L; Tue, 07 Jul 2026 09:13:49 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667CBcfR2375199; Tue, 7 Jul 2026 06:13:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zSJJTtt+elD71UjpYEucNJ45CeKhcVgqM5RFnl6Nr
 Hs=; b=inJ0Y/jucnSkWnzzskO9EzOy69Ji5GZPc4/zaPlLHlFdmiEeGY5lUsR+G
 Ux9qSTP4lk+4QZb1iDul8khDKiEw2p24NpQ0Ui3rLGrfkLEqrsgncEFLnG/oZIfQ
 soH1tGw9UhP76zj1YZEPEUHrRqUqVyDE4oEse77I333cSinxjRsBTmBZf8W0RwWP
 t51DTeadPBYhuskyV3USH9q6AmzH+9Hybadfi8DFSxSJqBjOkQB6WbM3LDzNoe6b
 rdOoU/pqOlozcw4LleQeltuYBMbAUJMpZNft2b/hJok/xosgqDF6olQin6ML+ATx
 4ZASZnzIXj1RpmZyauGY2/jvIIB9Q==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020098.outbound.protection.outlook.com [52.101.46.98])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f6xgsemhd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 06:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hd8vdlnfmKAZhepf+G4E8Kvj0hCunPEGtckChex1q3HqzEWkVV6JOJtsiBwNQlFO4EkYi66eKaGuL99Ip4NyMvHS5InKZ++DhjXIJuFsJrWdP6wiv5cqRHVr69B3L4ORrBh+Z0Cz/bBLBMs+ofe2jChN1MVI/1hRFfwNF3QJQf5nh89oTAtDwvX1IIbiN9J140EzuTm9X4JMl9gDg35c8wES5wyKzREgAKSuz8VCByezZovNdZhh/zdT4UF1HvXpGwdRwztLjcckznOZMVPTr/oNUdqQBXsbiDvhBEqXEgyUJ7A0l8HO4zPJjyNlohwViVc2kMwU3tyys4X1qTutuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSJJTtt+elD71UjpYEucNJ45CeKhcVgqM5RFnl6NrHs=;
 b=zNokGhUZQ131iow6wacBMRarnQHnbFJhu8lHE3mXME3L7lCtM+VPh3IzQl4Xt2AWK1RB2Uovy/7Bl7TwUO4FIiMfTjzeDRDGgB/+KhwD7cyxBY/phhMVs45XOFboS/fdlzGdXcf3XJOZB4Y5HjBgiUXFc2/HWtWwTzIqNBgaR4L+/Pmp7H6Bl7ZzHxib7ZjzSNKZ3kVUfGbXZFkIEIsfN4EQ4Q3Z7f/PkzisJUNg9CTiJsLZfG/lUMPGOS9+tKffHhp0FCMfbViWtynhuiXHzSbplZQcQ+l95vBTcYDOnkV9/TeB+UpNnBifvfce+i3TNmz67t3EEKty65kKsaL8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSJJTtt+elD71UjpYEucNJ45CeKhcVgqM5RFnl6NrHs=;
 b=cwgYYauZ8JNtJuYfWkqweqYDz1CpatNseIqFJ8PAxsep8fd9fLkZZaLrws6VpPoIG2hA5wXSBTHL4C95XuChU3+C1gFcA7vlMCK2JrABMZtEJQIEMhm7ekAoDs0tw+gVjMflBj1HpNunSK+USTiRR6aRNonA4pcbNwU1cfILD8dHWconRbyXd9qeKumCELN+gUncIZ7qtEnIllsM42SR6Qv0I+ubvLbEPjFfERXdmztzMeZ3jDD/i9O82U+ZYde1qNGNJYdSv24/NN/Hn++F4bNcK9cD5Y7ttkqMOAx2v5JV7ned3Tqu2IS7HUfheh19SCeqxpFfiO+ukdEmI7fI+g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW6PR02MB9765.namprd02.prod.outlook.com (2603:10b6:303:247::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:13:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 13:13:29 +0000
Message-ID: <84bf8ce3-5595-4b19-a156-180550d7fd4f@nutanix.com>
Date: Tue, 7 Jul 2026 14:13:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] qom/object.c: add
 object_class_property_add_uint8_ptr()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
 <20260703135512.3213964-3-mark.caveayland@nutanix.com>
 <akzuQ-YiaSmToNsg@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <akzuQ-YiaSmToNsg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW6PR02MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a697374-c6cd-4217-1338-08dedc2989e5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: w9OAw03a8mx7DpRhcem7gSrnNx7FCCspnNbXRVhwQX2PhM8XYhP2a+gROLqjqcUnkZ4xYasYS4C4Oi7sSH4EfS+gaWastZ8mta00blTEPSJZQ2KVKC1IhC4U+AAmit4C9091Omru0R0TIS7Ub9srFQvWSnV8fmOqkHjXPAUEYf742ZRZ1qlfJ8dc8FV4YmHnQtSjtb5glbkRCyDxFoHBylgdWNBFLg5vr6rs0pl3z791bPgWi3ss5MBaqm8sP8wU2+GuOF44KNBVzVyjehpjsQKAgcHdhoH5iG/NoQ67vhMv2WTc8vmlNv1pMKWa5iKsDSJ7hu14B348BL5yk2IshDX2wclr2taysrttL8p4zLioEVEUXUhfQfaOgbSCWHyC4dIOM+xokf93+hHC9y67Sa81Uva/YpEzJsjDsqWJVK/D9Xsc61i4+av1UNHoLVOy8USe6Wzk2LQQUL8CyN+8pvucxTTkmTGEC5L2Y2zOY4NA6OhrStfX86H7B2QCERsIWADB34byydCkksnxSCzDTqcGnfxmgumQHeKnjRqFr5lSXuQSMmjD1pBcuJtNbHde9akEhvYYLiWTzdD7j5Ax5O4n7cf6yoNL+zwlwG942ngBlPpS9qeXz9z1IOxPRUggGsJTWLUt4eAOKUhVDruUlx4pAo8i4TSt1MfgdhvqgXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGpUSmJIZHFBZzF2R1JwR25IRGE2R1pQSTNadWd6NVFhUUF0MlhERXBmUVVZ?=
 =?utf-8?B?UW9ZczdvejhLY3dKOFJxUVd1RVZZR3N6c0pMQSsxbDhibyt5V2RiVzRhenE2?=
 =?utf-8?B?UlV2NzMzbkVzWmd1VVEvalVkRS8rVEFHTGJZQU9EWWdQTTVIOC90Y3h2Qy85?=
 =?utf-8?B?eGp0dW45aG1HclFHRG04S2pBcUY1SldWYkJ5a3BRUVNETTFHVG82aThLaUFP?=
 =?utf-8?B?c3drS3orWFpLNjZ4dE5ydTJ2c3pFQXRHbzRWRGhuMm81cXNUMVAxZVNSM3hN?=
 =?utf-8?B?dXY2bU5lcDZRdnZMRjRkOE9YTSsxOGhrOTdOMGFOYmZ4eVE2ZmtMemRPQ2hn?=
 =?utf-8?B?dTAzMDJ6emFPd1JWODdpU1c2OFR3amNFU2JWMDBqQWRZdWUzSW5haSswbktx?=
 =?utf-8?B?WGFhVmNjNm13elplZmVhdzJrTU5RTUZHWGN5S0pJK2NCaVVIbGJldURqWFY3?=
 =?utf-8?B?ZEE5anpsSTZzV2RLTUJYUUdVcUJRNGQ0T21iY0M1d1R0Z2xHQzkycHpFVTRU?=
 =?utf-8?B?aFFRUmVuc1Q4eVdycXBVbi9nR1JRcGIrS0FGVXhMcWdDdnFRenk0Tnc4VURX?=
 =?utf-8?B?MjEwWWNsOHJUNWJUcDkzS05VNHAzbEdxS2pjckt3Q2E4QitTa2dqbHdyYVFu?=
 =?utf-8?B?OU9LZ0o4dmVKSmpkbGlmY29IV3hVS0ZVYWI0VWx1NGxzWklQLzE4V1krSnVl?=
 =?utf-8?B?aHRrVWVzQmtyT1J3bGZyYUUrOGc1QThsQkpXanlXNGhwT2xRMTZUT3o1ck1j?=
 =?utf-8?B?a0JJV25KZVpjd25BOGFwd1pBaWxQMk5CYk9iRGN6KzkrOWwwdlAxcHZHVjNW?=
 =?utf-8?B?TlJCak5sT3VKOTNFNWJBdU02dEJqYytjTEo3aUZpcmRqK0Q2NXpkZlBHdlZM?=
 =?utf-8?B?RVB5N3FtV2hPUU5kYng4dk9ncUpUd1R5SklSbDdTNDRtODJYM2pZd3VyU002?=
 =?utf-8?B?U0FYaGQzSjlDd3lRQWc0Q2J5L00wZEUwcEs5MHNrTkF4b0gzMkw2VHhTMCtL?=
 =?utf-8?B?bUY0MTdhaTlnS0dpTTNWVE9TdlI2bS9HNkVxV2w2OVBud1lnd1d4aWpDUnkr?=
 =?utf-8?B?ODRzTVlMcTRvbkZ6U0VnSjJwbDdwNkw2Q2VERm5hbkJNZTlOMVFvNzIweWJz?=
 =?utf-8?B?K1ROWkY5bjREOG93RHBoaFcrR2tqSkJick0xNEJ2OENxbll6RldqTW40Ti9y?=
 =?utf-8?B?OUFXTFAxNjRmYjNFTzRlaDhRL1RoVVhrQUhtQkJLaTJRalZ6cUszcDFxbldm?=
 =?utf-8?B?eUt3QWVhTDN1ZEhpUEorQi9jVWtvRGtoQWVXclZWUlhuVVp3MTRvWXI4SUhX?=
 =?utf-8?B?R3ZFcFdYaTlQUWx6blRGWHFpeXc4c0JCVjBSNDZxZnJwYUM2TjZWM2sxQ1Rr?=
 =?utf-8?B?NmdoVmFrWGJMUTBwWC9SeE5Kb1JZelVQWGg4RkwrNHVLTUVETE9UZWtqdWhp?=
 =?utf-8?B?Q3V1ZGl5aitrZXdteC9WQ3FLcmdMUFBEdnZYOFhHT3Vna2ovdmZsZTZxOFIz?=
 =?utf-8?B?N1FSb2FySHV1YUo3dmZGMW1JRk00VUZJNnRPZ2tEQWhSSHlFSWpxT2NpWVAx?=
 =?utf-8?B?VDNFZzFsZzlLN2lKdHV3Q29ydXk0Yi9FTFA3TEhYdUtxU2lYN1BhUlE5aFQ1?=
 =?utf-8?B?OGRwQUxoemFXOU5rZ2dsbEdEaHJjenFyOXExdFMwdkhuMUU1RzdjQmhHSk1r?=
 =?utf-8?B?ODEzUUJIYnZPQklRSzhWVUlRVGhJNUNpMFhBTFRLZ1lwZkFuNjExMDg3SC9u?=
 =?utf-8?B?Vk03SjRCZkFmOFU5WDFEaGNrYmZ1ZENidVpJcDVHOC8zdzFJNFdQQyt1LzVU?=
 =?utf-8?B?WEJvalpDOVJ6VDE4cTJoVXlWY3NtSHdlQUoyUGZIRGtIUFJKQWFvZHVVcjMx?=
 =?utf-8?B?bDhNRTZjOTVKRUpqVHZtYVZvQ1RJOCsralN6bGR6RlBMd2VpYXVBQ1djTUFo?=
 =?utf-8?B?Z2g2clh3UXUzK1VEeVR4bUtXTUNRcnA3b3BCZWN0NWswK3pPTHpOR2J5SThw?=
 =?utf-8?B?U3pEYUpualJCYUw2YWFYSEJMaWlTaFNkZnViL2Mvck9iVVhza3lsa2RuVWNj?=
 =?utf-8?B?eUh3ekVpVm8zZmxGS1h5SWY5UkhEc0hxdG1iZTRzRW9GTVA0UFJjNkZGb3hJ?=
 =?utf-8?B?cEY4WnlGM25HVGJmV2paNmQ5TnJyakxOdmgxNHV3YVFBWGdNYVhYMGlScWNP?=
 =?utf-8?B?Z1NYaU5QeUZNSGxSM3p3b3dCdFZZZUZ2UTVZQ2JiT2dva3p1aDg0WG4rdWFu?=
 =?utf-8?B?V1QwK3RoYUl5REtoMEYyUFJKZ0hFU1FPZnpzWVVCMENlMng5c2l2cWtBRXd3?=
 =?utf-8?B?bHg1cUFMMTRPM1ZDQSthaStLdGFPdUg3VXpNQUxhamcvWVVTMm5QMmtldy80?=
 =?utf-8?Q?Fj+Dl1OhHu5+c8eg=3D?=
X-Exchange-RoutingPolicyChecked: scMLGVLv1PY2nHAh/esYAeOrlqERjywcfAqaQnLYoz11hJcXhWMoEv5Gpvgebv1i4+avitW8aDw1ZK+xEdMtImhneC/yW9GhW34WL+4KaWBKGPLLilHT0OhSgxf7dVuBnSxmyxee6ex5uhE1GNqtaolBg3Z+KY9gxt9KXK2BHNSSJ9TFE7LOPx5MExR+AkE/sOuvGr05gqGNUVgndwrk3WlJIpZJUOGwxy32FvaYBeL2c9bTFKYKBXgQytEvCB5c8whAF2Wnt3K2cUuKqt7aDkewfHyzGeVKj02tXodeIuUXy0O2z/xFl4bErNZZRSpaDkFJmlpZVZgIwBtcSlfFfQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a697374-c6cd-4217-1338-08dedc2989e5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:13:29.9112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcJc5wMOq3BCQdT9BwEEgD9F5YXcQW5OUPMNLjM98soBgEIm8wEOaMPBjUyVzOtwyn32nU+1PRa6En70/uo1gIUD6bVRSuZyPUcC3MshN7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9765
X-Proofpoint-ORIG-GUID: 3NYtLR2cMgMB1Q6fKEtRkDVQyzUM4uNm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfXwDzDYcyjZlqj
 AUOY4AX5YGmQqyyO4duZ+BIR6OrqKBcyuC6hOSVZkCFu4w8f5ey257gHC6O/45rylIs6And5Y87
 +k1EnQbDY3MwB3mRbNw1cZyrJCYQpv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfX/ngaSGoT51qG
 qLvzfvDntrHQggQpZiZLDGqRyRKhgTKqK/K7FdIrPhoXCOOt6FsW6AWO+iJ36xbTZnqpY7ZHSn1
 y872bUg2j4MF5rUTP7FfH8GW+Qx15xLydzuYayp02OBM9ahnLz2NHp1/dtfuGORKTgXLLYFv8Bg
 8/GyNHmGYbVrLwCWJIBqwgMiEvlBvKo70ZN3mD30TPtadhdjl/9hUPojTdmIHlRjjMtbxcajxUl
 kuF9jBGCERQembwEBsRK0NxiGjW7j6k5dE23BdQxqbGD3yjGZixn/IX0UrxD0ipyzY3kRn37MHO
 6gEJjc61uswAsuV1eZq8lDL8qdUFnxVbrdcmhYGdGHhpBMYsh1qk26ixO85QTzPBaSWfB85CUd9
 gmZaZRIPaVGxyWurKUVL6oCccF0MuQe/rilh8b/pFfz7ew0fefyKUmVEkQPls9cfGEZ5A2HSIrH
 2TOEDGeOSd+sd5MQeRQ==
X-Authority-Analysis: v=2.4 cv=ENs2FVZC c=1 sm=1 tr=0 ts=6a4cfb7b cx=c_pps
 a=jzpQLMhUvwWo5cn4Ul+sFQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=14Cb58WfC2kDD8ILuuMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3NYtLR2cMgMB1Q6fKEtRkDVQyzUM4uNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 07/07/2026 13:17, Daniel P. Berrangé wrote:

> On Fri, Jul 03, 2026 at 02:53:04PM +0100, Mark Cave-Ayland wrote:
>> This adds a class property that references a uint8_t within the object instance
>> and is intended to be a replacement for object_property_add_uint8_ptr().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   include/qom/object.h |  5 +++++
>>   qom/object.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 57 insertions(+)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index 89c23d45ab..a55f9d0e97 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -1956,6 +1956,11 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
>>                                                 const uint8_t *v,
>>                                                 ObjectPropertyFlags flags);
>>   
>> +ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
>> +                                                    const char *name,
>> +                                                    ptrdiff_t v,
>> +                                                    ObjectPropertyFlags flags);
>> +
>>   ObjectProperty *object_class_static_property_add_uint8_ptr(ObjectClass *klass,
>>                                            const char *name,
>>                                            const uint8_t *v,
>> diff --git a/qom/object.c b/qom/object.c
>> index d10bf848c0..263c313cd2 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -2741,6 +2741,38 @@ static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
>>       *field = value;
>>   }
>>   
>> +static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
>> +{
>> +    void *ptr = obj;
>> +    ptr += offset;
>> +
>> +    return ptr;
>> +}
> 
> Perhaps just
> 
>   #define FIELD(obj, offset) ((void *)obj+(ptrdiff_t)offset)

That could work.

>> +
>> +static void property_class_get_uint8_ptr(Object *obj, Visitor *v,
>> +                                         const char *name,
>> +                                         void *opaque, Error **errp)
>> +{
>> +    uint8_t value = *(uint8_t *)object_class_prop_ptr(obj,
>> +                                                      (ptrdiff_t)opaque);
> 
> Do we need this intermediate instead of now
> 
>> +    visit_type_uint8(v, name, &value, errp);
> 
>    visit_type_uint8(v, name, FIELD(obj, opaque), errp);

Yes, I think that would be possible. I shall give it a test and report back.

>> +}
>> +
>> +static void property_class_set_uint8_ptr(Object *obj, Visitor *v,
>> +                                         const char *name,
>> +                                         void *opaque, Error **errp)
>> +{
>> +    uint8_t *field = (uint8_t *)object_class_prop_ptr(obj,
>> +                                                      (ptrdiff_t)opaque);
>> +    uint8_t value;
>> +
>> +    if (!visit_type_uint8(v, name, &value, errp)) {
>> +        return;
>> +    }
>> +
>> +    *field = value;
> 
> Instead of all this is it sufficient to do:
> 
>     visit_type_uint8(v, name, FIELD(obj, opaque), errp);
> 
> 
> Also, since we'll be using this pattern for int8, int16, int32,
> and many more, perhaps we could define a macro that can expand
> to the getter/setter impl for any scalar type. so we can do
> 
>    DEFINE_SCALAR_PROP_CALLBACKS(uint8);
>    DEFINE_SCALAR_PROP_CALLBACKS(uint16);
>    DEFINE_SCALAR_PROP_CALLBACKS(uint32);
>    DEFINE_SCALAR_PROP_CALLBACKS(uint64);
>    DEFINE_SCALAR_PROP_CALLBACKS(bool);
>    ..etc..

That is something else that is possible: I've purposely avoided doing 
this since it's not a pattern already in use within object.c. Do you 
think this is worth doing as a separate exercise first?

>> +}
>> +
>>   ObjectProperty *
>>   object_property_add_uint8_ptr(Object *obj, const char *name,
>>                                 const uint8_t *v,


ATB,

Mark.


