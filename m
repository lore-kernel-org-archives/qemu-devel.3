Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BFAD41D74
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 01:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTs0z-0007Lw-AK; Thu, 11 Dec 2025 20:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.cooper@citrix.com>)
 id 1vTs0x-0007LX-Fv
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 20:32:11 -0500
Received: from mail-southcentralusazon11013006.outbound.protection.outlook.com
 ([40.93.196.6] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.cooper@citrix.com>)
 id 1vTs0v-0002W6-VW
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 20:32:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygeIXvM6ZWFrlhA7XJsSljl7ORpRS8+g/rlLNgle+35A+gNe+s2qeOIledaJy4j22HqtbVMmAZwBfVu9lQju17a59KYulPyym7IaJoWNDEMwg4HsxAQTZQvWn3OJPHJdIFGUui6zbkyRcZMDvHhuVmt0yqaWvBQ4JA3cRwGhggKhbR4r0FrvOZK2ihQPfnj0lcJ4r+Mu5C9BfM/IjZtQ51cMMKSTsGVU2nDXPzDC8v6A4917H/OgkaJ8KACwDanqNFljkY08m7O+Nb5uLV6mdxZxqPPWf3F/YkQrQCSmHhCYPijoUDkMukCdjLhoI4vlnnon7tDsf9P4W8BQHRh9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYKZ7RklR0CzzuC1e2IbreIrsaXAeeuHQxVydHcLHCk=;
 b=ypr21PykL0TsDqsmbinq6mK/PmYGQ+mg+nDaexs9mLgXJGLyyjlzvecE6gkfvNWOvbn0IdXwIoQWkTXDy6B0/LQSTtEKzE7/ol8TNy0raJ5dCDYYxlhVGS+pDv/CiLo6x8FQ5cADNRnaEmpDpogoj+2KF1hO0BAIXWqqN48B+aT/eWWoAo9C1MUbsvMZuWkdpWjBjlRRybs384HR0b5YAYIiPp506laLgSawU2uNe62gP4kQAd1rVIQgYImBkZshOVNwxgc9TzUXpcT16y1enLWzMGIDGaoELVks0/+/BqcwcorXyoqcatMNvTnk+gxTvonMDXsdNPfEmVPQReP47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYKZ7RklR0CzzuC1e2IbreIrsaXAeeuHQxVydHcLHCk=;
 b=T0Xqn/kQt0ZzdmIlxSGuRZQ3m2n58hrm4/86JVt0Lo1hXSMHQsLA2hAKNztgWzTPEX1uPXHcN3B3diAV3AnBnRxuOMM2nzp3sZgsmu3GqhR5SjIRcXYFQxrOYU62KdD1FMrLpuqTfD9ZZAOcvjGmYg++4anWVMPmdtvosL25iJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by MW4PR03MB6991.namprd03.prod.outlook.com (2603:10b6:303:1ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.15; Fri, 12 Dec
 2025 01:27:02 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::b334:94c2:4965:89b8]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::b334:94c2:4965:89b8%5]) with mapi id 15.20.9388.013; Fri, 12 Dec 2025
 01:27:01 +0000
Message-ID: <4ee33a7d-a16c-4f04-9b5d-f9069a63cc17@citrix.com>
Date: Fri, 12 Dec 2025 01:26:59 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] target/i386: Fix #GP error code for INT instructions
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20251212012552.1275269-2-pbonzini@redhat.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20251212012552.1275269-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0312.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::36) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|MW4PR03MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: fba07ce8-3999-4fd6-51e2-08de391d8d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXNER2ZER0dKd1RaKzMwYndxTUJjelNDUmtSNDhWay9ibnRrVzdGNURTZDBR?=
 =?utf-8?B?Z28wMVNGbWVCV0pxMkZMTWIvRXVqb3pHYUYzbmZJMWt2TEczbXp3aFhFN21C?=
 =?utf-8?B?LzBXRnl6MlhPbVNoa1lsdFJPSFlhZktkN2FRTmtxRnl0VHQ5L3BVVC8zZUFZ?=
 =?utf-8?B?Tm81NnVoSjlOMjJtNEp0cG9aNmpwRHkvdmF0aUEreWliN1JSWjViUkZhU2dV?=
 =?utf-8?B?T00rTTY0U25MLzBJb2FZTzNHWDRCZ0lBZEFtSjlITVA4ZkJXSDJRSUpDNGNZ?=
 =?utf-8?B?ZTZ1c1lVU3c2UHRBUm5XQ2Y1UDBJZVZwcWVnT25RNEtRak9JYitUcDlCWWdv?=
 =?utf-8?B?aFBSQm45VDlmdk92eWxFeWFudytuWU50cWZjV3g0Ujc5WjBpa3REVFkvVlZX?=
 =?utf-8?B?QTVkK0xCNkZYSzdiSnVtdXFtaWYzTW9qUUIzbDBXSFZFN2lFa0tFejVHN0xi?=
 =?utf-8?B?YXBJblR6Ry9yUGZCQ1JwWCtvRDhMVnhmTFRDamF2b0lNaStQSkl5dXJiNFh4?=
 =?utf-8?B?S1ljWXVvK25CWm1ORHlSU1dET0x5djIzUmNkTWh6Y2dxSUhxRVladDZ0dXFK?=
 =?utf-8?B?R2tyK083NGwzS2ZzUk1wZlA0ckMwdEw5RzNMMEdheGVxdkJVUlFvblNYZVdC?=
 =?utf-8?B?dkFSN3FDUmZFMlowbnVNL21Vay9lais2cTZmVE9xMmhFR3JiMDI1UU9NdC9R?=
 =?utf-8?B?bGkwSDd5YWxEWUgrcCtFNmEzQmVxVXJTc2JuT3ZhblVkNHVlT2hvZnF1UFcv?=
 =?utf-8?B?clV3K0hlaXkrejRkT1E3a0VQbm5TSWVhenhKcWtHQThYaEtLbzdUL3JCc0RV?=
 =?utf-8?B?NUFrWWxHQnlNREo0OWJlbWRWU0trcDJQQkJTdWxSeWtCWmxldGc5TXZ1M1Jv?=
 =?utf-8?B?NGFPZ2JnY2VnK2FSZnp4RDhWN24zZ0RoZENpenF5WUwybkxMMXdxQmxDcTRY?=
 =?utf-8?B?VEhGYWVmbXZpek1iR1VucFlvcS8rb2lZVmFId1hSWHlzdXJDR1doK3RSQTRQ?=
 =?utf-8?B?NVllbTRCZHBUN0VXV2dZM1dacDJPaFZwTnQ2MjNjSk5xekpMWGladDcrVmdJ?=
 =?utf-8?B?V3E2cEJORVJOczllMFV1eCtkcVBleFpISG1xUjVIcFc2K3BzczgvVWJUc0FH?=
 =?utf-8?B?UDltK1VmdGoydkQ2ZWxzcFRqWWR6NUFqaUdHZVJmT3U1UjlXWnZEejRtMmNj?=
 =?utf-8?B?QUYxck9sVlhuMy96SDN3N3BIN2I3VUFON3BYM2JrcjNJRDdmWHo5VUJjSS9C?=
 =?utf-8?B?WWdDZFRWTEtDNHd4bkx4eUo2cyt2MUlBT2NrakRId1crOGlJbWRCcEhLSCtz?=
 =?utf-8?B?NzZrbEFLMDNRUjQvZldTOVJwY0xxUGVvK1BWZzRtcmhZME5OcVcrcndxMmV4?=
 =?utf-8?B?R0FkOU5UeEtRTlQzZGVsSmk3ZFpxOUR4SWlKakZhKzk0U0FIdWhuOGxyU3BP?=
 =?utf-8?B?K3d2SWhmeTljdCsvZThyWFV1Qy81eUV3c2MyYVd0d3pXVUoxQWRhUzl6TkFI?=
 =?utf-8?B?RHZIZFZCNnFmZmlpcVBBcUtNSEVER1BzU0prOVd4TklIUDh5VDdLMWUwc05D?=
 =?utf-8?B?Sk1hUm10Z2YvMjVpdE40SUZKQnlWMk9Uc1BKOEhPeENFblF0WmQ4U2RwZHFr?=
 =?utf-8?B?Qnc2eHpDdUlxMUxVckQxZWVuMnpzOTlpRkJMRVFqYVJHOHVzaDh2RFk0Z1NB?=
 =?utf-8?B?TVc4eUl5OEZkeGlyaXFpUzNDVG5tQlpJaHc4S29WRG9xc0l1ajNCRmlJcDVR?=
 =?utf-8?B?T2VhazhaYnRaSWFTbDRuSnlmRWpObVIxMWQzL3ZRcWFsRGh6dW9QVXBoSml0?=
 =?utf-8?B?di9CcXM3RGlGV1NROGoyczMzRXFNM04ydEN4MzYyd3ltak42ak9GSm9nZFo4?=
 =?utf-8?B?bmJPSmFsbThnTXNmaUNMbVY5dS9DZGx2d2U0SlNiL2Mzdm11cXE0Y1JvNVNs?=
 =?utf-8?Q?HlFqvTqGDH3tzDwN9mGUci/CzB/e/irR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH8PR03MB8275.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDA3Rk9KNFZxSkNrSmZPaEVKclpUd2MxTzJNL2phTkRNQzVHQUxwK1JsbVhS?=
 =?utf-8?B?dWM3VFdWR2RoNGt6eWE3M2JJSWxDWW9pQjErVHlNVWExbmJZb0dBOVJmYVlH?=
 =?utf-8?B?VnhOMkliZGNnZ1hGb1FIYnVYdWN3SWR3NVZaTElOT3VocTB3WEtadUJJRHVY?=
 =?utf-8?B?b2o1NUY1NzhTWm52eEwxRHJWQWVnVE9IWEt0SjJkVUJBNlJNL0w0NTdqcWY5?=
 =?utf-8?B?OHdnMy9pN0xzcXVxTUw5cGZTKzdlak1oWS9jRk9BQUw2aEJlYWZMRy85Y1kv?=
 =?utf-8?B?bkxvclJ1SE5PWkUyWFlUdktPWkdGZjlCQTg2bzRiaTBLWTV3TkRBNnRMRDhz?=
 =?utf-8?B?cDJmM3ZGQnFLS3Z6YjZoRlY1d2ZOOXhhVlE0cHJWVHRGbVM4SklBeTJaZ2hT?=
 =?utf-8?B?bENGNWZPK0RaSU1Lck5jcWlJTVZiNE9DU1Q0UXR3RlpZMGNtQkhrUDdwUUdK?=
 =?utf-8?B?WGV6bTZ0RFphdktPS2dPWm1CZmZ4c1p4NkxDZ3JLYzJNbkpIdTVRdHMyTjZK?=
 =?utf-8?B?MmNaMVhzSWFhSFFwbEVYNkJYd2RNekVKVlRvalJCbWJjMi95MEJ1cEZSRjN6?=
 =?utf-8?B?V0htYkhTS0crOWxkZjZZWUhYRnpObGxPYlBIK0YvL2RxQUlONmY2OTI1a1Bi?=
 =?utf-8?B?NGxhaXFzQzJ5d2hVaGdhbEVWM1RhTVhtVmlBMHptRmdNTDVjV1RlWTVpZVdN?=
 =?utf-8?B?bFRDRXgvNkJoeTRIY3BnUTFWbHVqenFmOVM4d1k5cjUzZk5CY3FVVWZlUTlB?=
 =?utf-8?B?T1lLNVJJcUFOK1RaS3hQY2FIUkZXM0d4K25KdHlRaENpWjU3djY2Wi9TMDNY?=
 =?utf-8?B?WkhVblZubW84V1poQUJqNHJ4b0YzeDMrbVRGc3hMNk1wL1Z3Lys2ZFpCbjRP?=
 =?utf-8?B?ZFZXekF4OUE5VmM0eG5ST2hDZXhSN3p1QTRrbzBRYm11WW9INzRBTkNucWtv?=
 =?utf-8?B?amY1cDhmZWUveGZxM0hrSCtTWnAxeFFFQU0zMjFMMFB1L082d05GRjdseHdz?=
 =?utf-8?B?KzlwVTRxd2lha0tSTDRhOERKZjRMK3BqamFsZmRRR011NGdHTDJncEFxMjNP?=
 =?utf-8?B?bER2OThyV3lXT0NqWEZmbXdaZ3hGSnRWTUltRFVoaTRWQUtBeGpLSnV0OGM3?=
 =?utf-8?B?aXN5RXhMSHhNZ0tpTkdzaUVJV3JOakZIRmFKRys1YVplYk0zVjdlZ1ZkNno2?=
 =?utf-8?B?aDdYUU1UR2JrUGd2MFp3WXRMWnNtb0JpaVQvT2lDam10QWlhNHNkQWlXM0xF?=
 =?utf-8?B?b0VRUENUUWcxejRnc0djS0Z5b1crbWw4SmJwdmVvV2EvRmN4WTErRVdGT20z?=
 =?utf-8?B?T3R1dUJsNHhTZUF2YVRtcHB4eTExQXNUdkdUa3FBYVo5ZWdOYWlod3hUQXpN?=
 =?utf-8?B?UHlWc0VxeWZBRFdOYVFCRFBoV1BuZkJ6S20vVlNYT3BsbnI1RGphQnFZWTJD?=
 =?utf-8?B?Q2NvSVdHa1loU1VoZ0N0V2k3M0l0ck1TamdWM1NMUitmaE9OazhpeEZYUnpI?=
 =?utf-8?B?TCtzTHJIWjhLcTlmd0orVHFkcXdOSEVMZmhwcWRvYjdRdUppczB2YkFJQVFt?=
 =?utf-8?B?K24vNHZiZklTaDY2b1VmWC84NWwrWnlPZnFMcyszQi9FaXh5WjFlYmZSQ1Vy?=
 =?utf-8?B?NElXUUxXSFBlQkhPUUFQMWM5UjJ4eXBGVjZoa0o0TUZJNFI5RCtYK2JINExw?=
 =?utf-8?B?OFEyamtQRDJPR0pTZkxyd3Ezb0xBeDh0ZjRzMEhLQlNObGFPOWNuL3Z2QXQ5?=
 =?utf-8?B?VTlMSHlTbXo4eGhIb2R4RG55cmtBN1h0SnZCSXVZaWcyV0FmYTNDR1N1akYz?=
 =?utf-8?B?Ry9vVnZqaW1iMzFNVWxuUmwwYklUZXlIamlZN1VDeGI4bGUwdDAvbmxkUUdr?=
 =?utf-8?B?N2Q0ZjlsL2xvL3VWZEJKTU9lazVyWHZ5aGdldGtDdDUzZ1dreGUwZytYYktk?=
 =?utf-8?B?bFdibzhJRStXZXI0czE4TTdxUUdoemF3ZXhhSUVFUlZHOVoxSVlqNW9PZVpy?=
 =?utf-8?B?R3VhLzdtdXhhUWczQitHSDdHRW54aHNTYkJXQWtmai9kNjhBTHQwZ28wK2pE?=
 =?utf-8?B?cWpzWG93Nkk3T2JvNWU1MFUyZWJqMTZVYXVpZWYySWxqbTlFaVdITUQ2WUl4?=
 =?utf-8?B?SDJZUXprYXlRMjBiRUM1ZytJOVQwUEQxZis4TittZ3pmd2ZDbVdJUzZOWlNK?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba07ce8-3999-4fd6-51e2-08de391d8d20
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 01:27:01.9644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nRR2FBBEr7ugqmB4PlRaBvXlT6prI9H+/SoTn3ZhabG0ihv2QLP1OmWGvTO78zCEM5GweGF6flDtHNmx0lsSaupYKsORfUdY9Bs3UDsJyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6991
Received-SPF: pass client-ip=40.93.196.6;
 envelope-from=andrew.cooper@citrix.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 12/12/2025 1:25 am, Paolo Bonzini wrote:
>> While the (intno << shift) expression is correct for indexing the IDT based on
>> whether Long Mode is active, the error code itself was unchanged with AMD64,
>> and is still the index with 3 bits of metadata in the bottom.
> Queued, thanks.  I'm really sorry about the delay.

No worries.  Thanks.

~Andrew

