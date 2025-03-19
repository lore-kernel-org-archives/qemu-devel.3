Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692B8C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvyh-0003mm-96; Wed, 19 Mar 2025 12:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tuvyG-0003eG-Lb
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:08:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tuvyE-0004cJ-2O
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:08:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JE225t016559;
 Wed, 19 Mar 2025 16:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Oz3+Hz8O2XqAjTVBLVDRYoW3s7h7cmQ9BjEtaB9dKU4=; b=Dv2LekeQPXowBLIs
 8tbb0Q9ngc17wYwddKUZCoOHUro0sgBIRGpng+DZJN4RoB0pkHxq/LrPXD35PZ2h
 Jn13xdcKG/njGHz0oQMxlN1uxQ/bwvikUssdgmKMyZE1m0I/VcSynOYRIjGl+cOu
 eFq/9+XEkTek9H+GjDOXTHf/DG3BJOVDQmlqVR7d61zpFElGnlWA1dOHXr8HV1jx
 /iYUbZren3XGZfnbo1e/vFfAtC/J9cyU6QSX/cPpCJUdvxfTDYqHn2kHzBFhV4Dz
 c1DMX5Ms5XyRZSUKT3hwhTnJPrvDvPL1rMrHVW2FBIh5oPFNrZ5ZPs8GxixEGlO+
 gKlvVw==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fd1dkagc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Mar 2025 16:08:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjMMDMz2ZfZtBRFdFQb2gWZn0Dt82co8zxt6u1LgaemdQjLU+VyqcyQGLd1srmJe8XC9Zi1bCCOTsJLqWD/FVpGxWrSKFvp1JfyzsNOkHudPW/xP1CzBS/GCJ3fwknb07+q0Bp3/K7M3Sham63OhAuLMFJZQLeckp/1qJTANasgNSMs+Kd1fC0lPZSQLDG7YonAsOr/USwTKESotVBuDMAfSLMGlev1mtwCLTRbJOS5GuuYIWtlZEhld6xY/8AWaH0BzG0uZC5YM8OBnWXxLPMZa4rmyOx9u5hzf41ul6NS9PeS38RhD1s8MEI6r7FSYRf3sfkQD+yrWiYJUlysfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oz3+Hz8O2XqAjTVBLVDRYoW3s7h7cmQ9BjEtaB9dKU4=;
 b=A+mDQLooxYibGZuQHmhFLbcmt0Hjtsh9DxqJO3OiwzlWa8cfpYAcrRoZRNdICMpcTPd2CWXZ6KT6nnNLpzzH0ElF715DgEXnwlN4+RMRXUQ5lPTes8MfRNFoNa8LPVhFyMiKv5GJLg0JR0MGTR9gcnQ8eqHe6PJPCyCgru1tFBWzLugM55r6BfeIOgU+RdastvP+oSyke2mtMhvXEh23FFepdGofgvot7rQ2knDAr0SAiMh1ln8JnqZAf2g8mtfaG9cU8I3dv7+04g5SZr81u60vuVclMH2uNc/lAQ1kr3QbWUB+bxdHkNIEr+WtnsMGor6cfm900E+H48N3tQMjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from IA0PR02MB9486.namprd02.prod.outlook.com (2603:10b6:208:403::18)
 by MN6PR02MB10606.namprd02.prod.outlook.com (2603:10b6:208:500::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 16:08:16 +0000
Received: from IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891]) by IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:08:16 +0000
From: Sid Manning <sidneym@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>,
 =?utf-8?B?J1BoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpJw==?= <philmd@linaro.org>,
 'Brian Cain' <brian.cain@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>, "ale@rev.ng"
 <ale@rev.ng>, "anjo@rev.ng" <anjo@rev.ng>, "Marco Liebel (QUIC)"
 <quic_mliebel@quicinc.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "Mark Burton (QUIC)" <quic_mburton@quicinc.com>,
 Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
Thread-Topic: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
Thread-Index: AQHbimqq7JAlF+F3YUOZKwYJb0+p8bNv8n2AgABAdACAAAhsgIABQIuAgAAFWgCACTWPoA==
Date: Wed, 19 Mar 2025 16:08:16 +0000
Message-ID: <IA0PR02MB94864DC1BE7E60105E66EC09BED92@IA0PR02MB9486.namprd02.prod.outlook.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
 <44e23197-a2ec-4477-a4b8-a526f83e47c2@linaro.org>
 <b84bcd2d-9974-41f0-b9f5-2d416ed16d0d@oss.qualcomm.com>
 <67b33d51-b8c8-421c-8aba-efa9a0b46bf5@linaro.org>
 <008601db9448$601bc370$20534a50$@gmail.com>
 <e1216ec5-c542-4a7d-a3d7-880e7e57130e@linaro.org>
In-Reply-To: <e1216ec5-c542-4a7d-a3d7-880e7e57130e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9486:EE_|MN6PR02MB10606:EE_
x-ms-office365-filtering-correlation-id: 87007733-72be-47bc-bf86-08dd6700422c
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MXNnemNiMERzR0d6Y203MWRETXV4TGZMTFlLQXlTdXp1ZWtnMnRnQndjZzJz?=
 =?utf-8?B?UjB1WUZ0Z2txVTNDMTBWZDY1QU93bkxoNFNQaGtsYTRETkpyZnhKV2dpdG9o?=
 =?utf-8?B?RlJIeko3NEs5Q0RqZW1wWFpPaE5ERitNcnVVWlVROWhjbUl5bzh3S2dvemhr?=
 =?utf-8?B?ZjhoSnQydmpWTXVLRlo1ZjdRZGxCemZHQUlzcUh6SjZSTTY4Sy8wSWxYbXVp?=
 =?utf-8?B?R2lkRktIUkprcXRVWWJHc2dQWUw4RndQMzRtbS9jK2Z0SDVCUVZSbWNhQWpB?=
 =?utf-8?B?UkJNYzlVei9TVXZ0aGV2U2pUanZUZWRoZEx2N3llbS9FclArNmUxVm14YkFQ?=
 =?utf-8?B?T3NVZUQ2anF6UnI2ZFN2bG43TWlJT3JOWDcxeDJyN2xxenF4U05XWlkxcDVH?=
 =?utf-8?B?VTNQM3RhYTJhdUJLMjZHN1pIK3hJNjJLWkhIeXBJN3Z1U1lNU0QzQ3k0dnJj?=
 =?utf-8?B?cStFTlR4OEQ5dXRnY3FzRm00MUtwejJHMzJwRjVuK2Y2cUtsUklCV1Fici9J?=
 =?utf-8?B?VEd1eGEwcUZyS2pTeVh6ZXMrUE1ybzUzUy9QNVZiODExa1NJWExBekludG5H?=
 =?utf-8?B?TkZsdS9kbHZ5SElBSy9uTldkSnVXTHgzT0psaTRCemVIUVBFMkRwUDJrV3FI?=
 =?utf-8?B?K25rUHhESDV3RElYVytac3FpdmJVNFNBUE1ad0lhTDJKOHVWUG5DM1Y3RDdW?=
 =?utf-8?B?UWNWNm1rZStZc1V4a25KUXFNL2tsQkRMbGNkWjh0NTdVRzZnSWxwR3NYTWZj?=
 =?utf-8?B?blB5Rm9EbEdnZ3dGYXM0RnRxUDduclM3b3NOM0RPOXJmNkpid2hSZVhZTmZ1?=
 =?utf-8?B?M3F3UzlPUExVQTh5NnRoZ08reURGdDQxbEM4M1NCNFNnT0N2eGZxbkdwRVRl?=
 =?utf-8?B?Mmk2ZTU4OGNGUnlLeVp1VitMZTdlQkE4UkJ0blZPTkJrUHBlWms4aE01YmhF?=
 =?utf-8?B?d1Bid0drOUhqdGJuQUprbjk3TVFBMjlENUdqQVMwaVNRK0owL0c0aExpakp0?=
 =?utf-8?B?eFRJTExuKzUrQlhpQmlZMDlyd0hwaXBmeVdWYkZGZzlHVU90NW5xUmhENk1S?=
 =?utf-8?B?d2RjdklQUWxGaFJyc2YxRkFhU0xyTEx1clJ6UmFFUVFUdDlnV24wOVZrWkFw?=
 =?utf-8?B?UEw4S3lvSTdvY3gwT01udE1zZmNKTng4ZTZXLzFhSFQ4NkFFYTJ3SmkwbkdW?=
 =?utf-8?B?STR6NXVKMkk1aG05K3hMWGhicTNtQWpGK1RaRXB6dDVpQXZEbWZwaFZMTmZS?=
 =?utf-8?B?SDJOUzFNTTBQL1VRVklwYzMxTU9PMGxjc2FWNFBDMlY5WjVwY1N4WjhYRWs2?=
 =?utf-8?B?eUJHejBnZm1rbFY0cFdEOVlyZUJkdmVTQnJRa0h4N1lmTjFMbG9aL0hveC9t?=
 =?utf-8?B?dEtPZWtCWFlYRStFeHRabGxOdWdIVmxVK1ZqSlhraFNVbnhLaDJ2VVlKdjlR?=
 =?utf-8?B?b25DRjNRZnR0UExxWHFJRVNBellESGlrYUlwcXQ4djBVSkphNk5ZelhrWjBj?=
 =?utf-8?B?T3N0WVgvQm8zV09mUFU1NldMNFhJbnkwenc1N0liRUliejhUMy9YYmVyVWk5?=
 =?utf-8?B?ekk4VTF4TkhRTnNoaWVma3o2bGFMMU5sYjdUZ2YxMEtnR2NWL3EzdXcybnBY?=
 =?utf-8?B?Y0tDRkRxRjM2QmlrMHQvVlYvc1VacGZQa3hubEVKUVF1UUdsMGpjQUd1MFZv?=
 =?utf-8?B?dVREOEMxOVZ3eXBwNS9SMndPV1J6TnNtaE1ta29zd3NxTHRZWEJwenZ5ekRp?=
 =?utf-8?B?dktWVGhCZDMwSDVtajJ4NFQ2SjhxeEQxanJoQmFoSmZXUjFPY2pweXJOVWtl?=
 =?utf-8?B?MU1pQUdvUjNLRXN4QWJ5bmxXWklQSStOQ2NMVGhmM1d1L0lacnJmZ3RIRmxG?=
 =?utf-8?B?OHVRQ3ZjUnF6b2doWmZabnpIQjE1NjQrUGM2TmFUMzF6WWcyRjN4Q0VYQ3JS?=
 =?utf-8?Q?zWaO1/GlhGA5Q0XhA3GEakNKdFA4G0r0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9486.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWxBUVhCcFo3bXBReWU1eU9HY05aeVNjemh0OFoxbUE0TFF1WldDckhOU2cv?=
 =?utf-8?B?SVU3aHNUYUd5QkpURFRjaUpCM210cmc2dm5Bc2gzQUZjS0tDV3ZuaXVpdFpo?=
 =?utf-8?B?ay9BK3lzSzAzeklBSlhFYTRrem5pTE1WRS9mcjVPVFA1VVdpanViQ3JxVFFi?=
 =?utf-8?B?N3hacCtkbmRrdlFUN1pxMGQrN2o5VjBid1krOXFGRkYxbHVlZ1Q3SkgxZklo?=
 =?utf-8?B?RStSelc0SkhNUjB2dHlvc2xwM1pYenprS1JETGhTMEhDbGpKTFVhVko1dFoy?=
 =?utf-8?B?elJFYXlhVUh1NExDZWpzYnZwelhBWWtoeG1WZUM1RWkwTXZLVStLSSt0amRN?=
 =?utf-8?B?eGNFSGRNOTFQeEUzMDBPejY1RnA0RDdTT1BsejFJTEZFRTVDd0VCMnFveHV6?=
 =?utf-8?B?WXpMbWRwL0tTZmF4RUJueWVYTlJIbFA1MGJ3NVIwV1h3REpzNGU0UGNJMW1y?=
 =?utf-8?B?am9zR0dFRU1JZEpXNXhSTzhNY2prVjRrdnJqZWVxNi8zZ2FIbUQ3ZVlZTnpl?=
 =?utf-8?B?TGZobDRUeTRrV3lnbm9lTDdvSDl4VE5aS3NBVk1NYjhLeHluVHhnM1d5cVdn?=
 =?utf-8?B?ZXdkYmN1TE1aVmhKSTl5dHZacG45N1hELzk0SmNxenhkQ29XWXNOd0tBUElo?=
 =?utf-8?B?Nk53a0NqN2dFL25lbmM4bnRxcFhYSEdPRURBNVFYc2VsMDNIMGgzZWVhT053?=
 =?utf-8?B?Vlc1VG5YRU9PZXNiOHZvbGg5V0NpUW1qZFdIcSs5UlV0ZjZVOVBWYUNEOW0v?=
 =?utf-8?B?WE8velBIRWlNdGdURUM2RkY3QWVhc3U3aVlqYUlkSFJiN09BYjd3S3lRdlNz?=
 =?utf-8?B?N2VnV0R5NEFHZXI1cjhObmp4alY1OWhyd0Q5YTJFeTlCUE9KQlVqWlpjNUgz?=
 =?utf-8?B?ZE5ZeE1mbHhvTTZ2NlVJSGlYMVVHMUtSYTljSVgzM2ZlMmQvc1lkUDkwLy94?=
 =?utf-8?B?NU1qTFJzbzdrb1MvQ0RDVFFsckVCMGhlL1VEVGtTSlNudXFaaTd3cmt3TUc1?=
 =?utf-8?B?TGJZYlVPMWxYMWw1RFpsWUZkazJqK0NhbWM1VHNERjRsdi9zWDk5amgzWlZ4?=
 =?utf-8?B?NkxMVzRBY0d0ZmJzM0ttRlR1QjgvdS9ESVFMOExpQnY1SVozdkpUVnJuZVFS?=
 =?utf-8?B?NTBmU05BeUJ2bFc5ZlVMYjNzMkh3TEk4OThjWGZNZGEwa3UxYWYrd2JyUE1G?=
 =?utf-8?B?dVlVM3dnMkhjR0dUMEVSRk43encvQ054YVVFcFN2YVlZS3N6TWh5SGwzMEE2?=
 =?utf-8?B?SnJtaWdBS3VtOHdjWXVld2RRNVFFaFg1ejVGNCtadEpvWisxb1pQbU04cmMr?=
 =?utf-8?B?L21jZ2x2eGc3cGtDTlhFdHI0bHQyV0xQUi9zNXhkelpKVWdKb1NabmFoYmd1?=
 =?utf-8?B?Q29UNnlIYU9tWHVWSU40eGl6UzIxMm45TE1sZWlaaUR2cUg2b2U4TkZweENx?=
 =?utf-8?B?N0doZlYvRGIxRm82eG1KbnVXWmovbmF6d2FEcEFSZnZFVUF0Zkp4eVZFV3F0?=
 =?utf-8?B?VzFhSENKdXFTMGY3MzlkV2daYmlXVXBlK0N4Y1k1OEx5R2gzdmNvMXQyUWI4?=
 =?utf-8?B?N3dJUlZJYlQrTDd2ZW5WVS84aVJjNFVSbS9nbCtCWkU1VS93R3pyWXRpdXYr?=
 =?utf-8?B?VEpJS25qNnB0SXY0RkVDTTZuZ25wMitENXo0c0hqSFJva0hFemwzcmpacXJZ?=
 =?utf-8?B?USt1ZjNzSEFXeTlPVkJiWHhUM2VDbWwxTGNJZEtKQ3ZKTnE5UjhDUTFWdm92?=
 =?utf-8?B?RlNUa2dseXUzYm4rcFYyZ3dUUDM0ZWwyR3RGVUlXcVRzMjNHaXJ4RTM0NjVp?=
 =?utf-8?B?bm92Qm1iMTVkREVQeE95d3BFVWM1TFZxT2tUZGtyUTVsbVhCcUMrTS9TNFFu?=
 =?utf-8?B?SkNEaFluNnJIN2VKZU1FQzJhMzBBNGRWVU5uSm05R3gwK1pYSjlPNTBOOTI5?=
 =?utf-8?B?eXd0UFdTcGhqWGc3NjBoWXV6Tkl3dHdIVFUvTkNyQzV4c0Q2dit6eTZBWWQ5?=
 =?utf-8?B?dUlhSUJWdFJ0YkV1dXNSTUpxZlpVUFovUnphckZFUldvTUVLVlhDNmtMRmpx?=
 =?utf-8?B?bFlSNm9DVGh3SGNuTHZiUDZmaEoyNDZnTEQ4L21ONHdvT3dMK1ZkbVlXUWww?=
 =?utf-8?Q?zJNib6EDB6Giq43I2b56lMfK/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zW3q24TtRD4srtmkXmxMh7iABYfflPjcOir7jarJpSsn4WQv+S9uoKvu2ZAGU3cYRr+fV+lOQY7WGflZeoA7l53h178Rj0p8pIdY4wQ2uGQQWjUBvjvlC1AtIlIkOFtKUqZm0+fXH/2vp5agtc8+hXq0IIsQA/UfxbpsjqC7IZgx63URqh0DtZC4p6DKYJS0GGaSFBaFgH77eLn7AwxpJLfpdRRKGRYqYu2lPQOHvUSN0TGlE/+NNETeiJByWCGLTywyKxBuZWFWffZaEmwiGFD9ya/XqRVcLVA6ZNaQgbmZoBBBg6nx/yH6knZHFDQ9cUG4bg4gvA68lCEDPKrFrHLxMu8OLf3wHxF+lw2/ppE8v3Us6Dzq2gXElWcj9/oXn2Xl+Fi7yUSGh3bmKzFwJKrXRb6VYeQOmcQ86bixN6TlxM4mcawz0DJukXwQ8NIUbi2J24X8ICj78FzHvMI6ca8HS0aZUvOL+kiyUqX4QA5riKNmC2Lti4A3X3wkhjdPD81V7e7T9HTrodhMUacYWR0YdLNsvQfKaNSCT7sZs2La6EIc/W80WWjJpNVI3PhX8UWT+dfdJeEqnUmvPBG4AOou9Gu4au1ariw+5CQYcQZylhyEyyhC3gD5vF5MyKzC
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9486.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87007733-72be-47bc-bf86-08dd6700422c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 16:08:16.4076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDsKTNwb3Y5gcm4zXI4PvYQTpQI8sB2ByxnmbQOwB37FTdehuj5+ASwui2fRpnLFr7XGqqW0KpLwt2eWBbnq2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10606
X-Proofpoint-ORIG-GUID: j0WRgpv1aySX5VYnR1JKj0ok3lH2SNTx
X-Proofpoint-GUID: j0WRgpv1aySX5VYnR1JKj0ok3lH2SNTx
X-Authority-Analysis: v=2.4 cv=T52MT+KQ c=1 sm=1 tr=0 ts=67daebfa cx=c_pps
 a=joY0rRILPjs92yFVhGOM/w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=COk6AnOGAAAA:8 a=h64ntLAQPrMvR6IAcDkA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=882 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190109
Received-SPF: pass client-ip=205.220.180.131; envelope-from=sidneym@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJj
aCAxMywgMjAyNSAyOjA3IFBNDQo+IFRvOiBsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb207ICdQaGls
aXBwZSBNYXRoaWV1LURhdWTDqScNCj4gPHBoaWxtZEBsaW5hcm8ub3JnPjsgJ0JyaWFuIENhaW4n
IDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+OyBxZW11LQ0KPiBkZXZlbEBub25nbnUub3Jn
DQo+IENjOiBNYXRoZXVzIEJlcm5hcmRpbm8gKFFVSUMpIDxxdWljX21hdGhiZXJuQHF1aWNpbmMu
Y29tPjsNCj4gYWxlQHJldi5uZzsgYW5qb0ByZXYubmc7IE1hcmNvIExpZWJlbCAoUVVJQykNCj4g
PHF1aWNfbWxpZWJlbEBxdWljaW5jLmNvbT47IGFsZXguYmVubmVlQGxpbmFyby5vcmc7IE1hcmsg
QnVydG9uIChRVUlDKQ0KPiA8cXVpY19tYnVydG9uQHF1aWNpbmMuY29tPjsgU2lkIE1hbm5pbmcg
PHNpZG5leW1AcXVpY2luYy5jb20+OyBCcmlhbg0KPiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAyOC8zOF0gdGFyZ2V0L2hleGFnb246IEluaXRpYWxpemUg
aHRpZCwgbW9kZWN0bCByZWdzDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQg
ZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeQ0KPiBvZiBhbnkgbGlua3Mg
b3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IE9uIDMvMTMv
MjUgMTE6NDcsIGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbSB3cm90ZToNCj4gPiBXaGF0IHdlIGFy
ZSB0cnlpbmcgdG8gbW9kZWwgaXMgYW4gaW5zdGFuY2Ugb2YgYSBIZXhhZ29uIHRoYXQgaGFzIGEg
bnVtYmVyDQo+IG9mIHRocmVhZHMgYW5kIHNvbWUgcmVzb3VyY2VzIHRoYXQgYXJlIHNoYXJlZC4g
IFRoZSBzaGFyZWQgcmVzb3VyY2VzDQo+IGluY2x1ZGUgdGhlIFRMQiBhbmQgZ2xvYmFsIFMgcmVn
aXN0ZXJzLiAgVGhlIGluaXRpYWwgdGhvdWdodCB3YXMgdG8gdGllIHRoZQ0KPiBzaGFyZWQgcmVz
b3VyY2VzIHRvIHRoZSB0aHJlYWQgd2l0aCBjcHVfaW5kZXggPT0gMC4gIElmIHdlIHdlcmUgdG8g
bW9kZWwgYQ0KPiBRdWFsY29tbSBTb0MsIHRoZXJlIHdvdWxkIGJlIG11bHRpcGxlIEFSTSBjb3Jl
cyBhbmQgbXVsdGlwbGUgSGV4YWdvbg0KPiBpbnN0YW5jZXMuICBFYWNoIEhleGFnb24gaW5zdGFu
Y2Ugd291bGQgaGF2ZSBkaXN0aW5jdCBzaGFyZWQgcmVzb3VyY2VzLiAgU28sDQo+IHlvdSBhcmUg
Y29ycmVjdCB0aGF0IHVzaW5nIGNwdV9pbmRleCBpcyBub3QgZ29pbmcgdG8gc2NhbGUuDQo+ID4N
Cj4gPiBXaGF0IGlzIHRoZSByZWNvbW1lbmRlZCB3YXkgdG8gbW9kZWwgdGhpcz8gIEkgc2VlIGEg
Im5yX3RocmVhZHMiIGZpZWxkIGluDQo+IENQVUNvcmUgYnV0IG5vIGNsZWFyIHdheSB0byBmaW5k
IHRoZSB0aHJlYWRzLiAgUFBDIGhhcyBzb21lIGNvcmVzIHRoYXQgYWRkIGENCj4gInRocmVhZHMi
IGZpZWxkLiAgU2hvdWxkIHdlIGZvbGxvdyB0aGlzIGFwcHJvYWNoPw0KPiANCj4gSSByZWNvbW1l
bmQgdGhhdCB0aGUgc2hhcmVkIHJlc291cmNlcyBiZSBtb2RlbGVkIGFzIGEgc2VwYXJhdGUgT2Jq
ZWN0LA0KPiB3aGljaCBpcyBsaW5rZWQgdmlhIG9iamVjdF9wcm9wZXJ0eV9hZGRfbGluayB0byBh
bGwgb2YgdGhlIGNwdXMgdGhhdCB1c2UgaXQuDQo+IA0KW1NpZCBNYW5uaW5nXSANCkhpIFJpY2hh
cmQsDQpBbiBleGFtcGxlIG9mIHNoYXJlZCByZXNvdXJjZXMgd291bGQgYmUgdGhlIHN5c3RlbSBy
ZWdpc3RlcnMuICBUaGV5IGFyZSBicm9rZW4gZG93biBpbnRvIDIgcmVnaW9ucy4gIEVhY2ggdGhy
ZWFkIGhhcyBpdHMgb3duIGNvcHkgb2Ygc3lzdGVtIHJlZ2lzdGVycyAwLTE1IHdoaWxlIHJlZ2lz
dGVycyAxNi02MyBhcmUgZ2xvYmFsLiAgUmlnaHQgbm93IENQVUhleGFnb25TdGF0ZSBjb250YWlu
cyBhIHBvaW50ZXIsIGdfc3JlZyB3aGljaCBwb2ludHMgYmFjayB0byBjcHVbMF0ncyBzdGF0ZSB0
aHVzIGtlZXBpbmcgb25lIGNvcHkgb2YgdGhlIGdsb2JhbCByZWdpc3RlcnMsIGFjY2Vzc2VzIGFy
ZSBkb25lIHdpdGggQlFMIGhlbGQgdG8gYXZvaWQgcmFjZSBjb25kaXRpb25zLg0KDQpZb3VyIHN1
Z2dlc3Rpb24gaXMgdG8gY3JlYXRlIGEgbmV3IG9iamVjdCB0byByZXByZXNlbnQgdGhlIHNldCBv
ZiBnbG9iYWwgc3lzdGVtIHJlZ2lzdGVycywgSSB0cmllZCB0aGlzOg0KDQojZGVmaW5lIFRZUEVf
SEVYQUdPTl9HX1NSRUcgImhleGFnb24uZ2xvYmFsX3NyZWciDQpPQkpFQ1RfREVDTEFSRV9TSU1Q
TEVfVFlQRShIZXhhZ29uR2xvYmFsU1JFR1N0YXRlLCBIRVhBR09OX0dfU1JFRykNCnN0cnVjdCBI
ZXhhZ29uR2xvYmFsU1JFR1N0YXRlIHsNCiAgICBTeXNCdXNEZXZpY2UgcGFyZW50X29iajsNCiAg
ICB1aW50MzJfdCByZWdzWzY0XTsNCn07DQoNCkluIG91ciB2aXJ0dWFsIG1hY2hpbmUgaW5pdDoN
CnZtcy0+Z19zcmVnID0gSEVYQUdPTl9HX1NSRUcocWRldl9uZXcoVFlQRV9IRVhBR09OX0dfU1JF
RykpOw0KDQphbmQgDQogb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVChjcHUpLCAiZ2xv
YmFsLXNyZWciLCBPQkpFQ1Qodm1zLT5nX3NyZWcpLCAmZXJyb3JfYWJvcnQpOw0KDQp0byBhdHRh
Y2ggdGhlIGdsb2JhbCByZWdzIHRvIHRoZSBjcHUsIGJ1dCB0aGUgYWJvdmUgZG9lc24ndCB1cGRh
dGUgY3B1IGVsZW1lbnRzIHRoZSBzYW1lIHdheSBjYWxscyB0byBxZGV2X3Byb3Bfc2V0X3VpbnQz
MiB3aWxsIGRvLCBvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsgZG9lc27igJl0IGVycm9yIG91dCBh
bmQgcmV0dXJucyB0cnVlLiAgQSBzdHJhaWdodCBhc3NpZ25tZW50IHdvdWxkIHdvcmssIGNwdS0+
Z2xvYmFsX3NyZWcgPSB2bXMtPmdfc3JlZzsgYnV0IHRoYXQgaXNuJ3Qgd2hhdCB5b3UgYXJlIHN1
Z2dlc3RpbmcuICBDYW4geW91IGhlbHAgbWUgdW5kZXJzdGFuZCB3aGF0IEknbSBkb2luZyB3cm9u
Zy4NCg0KVGhhbmtzLA0KDQoNCj4gVGhlIGxpbmtpbmcgd291bGQgYmUgdW5kZXIgdGhlIGNvbnRy
b2wgb2YgdGhlIGJvYXJkIG1vZGVsIGFuZC9vciB0aGUgU29DDQo+IG1vZGVsLg0KPiANCj4gDQo+
IHJ+DQo=

