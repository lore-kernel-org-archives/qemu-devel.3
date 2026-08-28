Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF67C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzy78-0002Pk-59; Fri, 28 Aug 2026 11:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy75-0002PD-Fk
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy73-0008FI-B2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:27 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDUIEG3069547; Fri, 28 Aug 2026 08:03:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=Q344dBVyAm/iJ
 JIvKEOR1LQuR0MOczbsuAKx5YieYtU=; b=YHB9RNFyAd95MQieO1+xe1c1tgYzw
 CeWLGadAFa/yWfEZ7Rmy33thvJyLED6Hv2Y6Of5I/0M8+u+DMxM0Hpsfm2kLRz+a
 Ii6gGVSm5AQyuqV/6eqfn2DOTnCjMabBQxwZJjvWUzrBvQZHvJt0rWMwyo6zNAz5
 0d4YcWbOdnX0KeUelKXuPd7DX9gn0+6kS4fCUDZD4yurFdtRqg726Pyi2OM3TYfL
 uFirlw8iZbHkzFNkmdHTtBn9us9+fVZgFqLXvlFJ0ugdXy7GU8aZyNGvlSOuoaEu
 G8QeaGzaoRcdUYG5C6Ij4lYVLIO/n9DaVnQ5B0y6QiwnBiYnLn5okxGzg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021143.outbound.protection.outlook.com [52.101.52.143])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gad5ccmvr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 08:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFuIYSKtIaTRiZD3ub4MCyNIkbtLbjy3RJa9LauxXEvBJqs6CsdH1yKR3hjuGt90cjh0NGyjZjfa4bu2P+m/Os3eiVYxVaezy1o088sFe+5eJ7lXghKGNUmaFHeIKljarXfu/5MbguDYyDaYRtC5qfCHC10PJwBZOtgloRfRCzjGb4EhNbIFVFKaaBKmKXfNM8NiDajrjn2uEzZS+Hjsq1vMjdWXlK2s+NIh5TwjrpqpmLYg2GJrc9su/ImX+di1twxCgCbi+yNWkq8voQ6inKuu1JJTIJ9gk20C/Eq0eEBoxvZmAL44UM/3F8Xe2xAaLkyt6zcYSrN6pYDDhVj3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q344dBVyAm/iJJIvKEOR1LQuR0MOczbsuAKx5YieYtU=;
 b=mVrKM/hHuz+DpwD336757+7GsxDH3fcNbmeNdcrUYlJwk1QRCQu6klG6E9bhmFLLh7wfOSO5w/gNHdsfY5ey6BEsW2Nwzy44Uq+VlO5IWV9ldh5pGHvM0Z64dhPdRMbBF646dxvCI83qKkdB5A4bP/4oIpUidHDStOzjMHDQid4cH9Yxaivvr2eSw7k5+AD1iVwuxN2d6aKCj6E53LsA5peDs9v77OPihjHYEib5ESGsGvXdRLz2iQjOha1yKW2hvcfII3p/Eyz1q2rJfQVyDT1+GT9+x/KEe86u/P8lWOz0vkh38FBRsao+E7E7tHCEwSj0K1HsQ32dt+RtXsWUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q344dBVyAm/iJJIvKEOR1LQuR0MOczbsuAKx5YieYtU=;
 b=JuOED3AJhVbIQjbmD79L+tDe58hVLucsHoueQjx97CvLtAicIawCkbt7c/zF2s2MGydJPf6a+1AfJ8/+bECtYcORxTpPqovJLrJwy9jYgS5NW0OlwWlFOLRQ0phHeKJP8A+7w7EoCfxaZAwZn0Ki2vFtSa1n+WU/I9cW1AXWBISPe3lguZzG/zi8S/4agapc60N1v/v0nPxQdXHejpdCIDo5w0p58TI1QGjX19qko8gzdR98GQwI10amqkm+YGMRilLqUzTQoaSjYePBS8vCt3nGJYu0NE+bakZ7CGWovetmd65xghrKi6BqVsQGd4oUrOe15Y98WUHX68tRmW1bWQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB11917.namprd02.prod.outlook.com (2603:10b6:8:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:03:17 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:03:17 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] hw/i386: convert object props to class props
Date: Fri, 28 Aug 2026 16:01:56 +0100
Message-ID: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:806:126::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB11917:EE_
X-MS-Office365-Filtering-Correlation-Id: aefa7d75-c025-4ba8-55fa-08df05157daf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: B5zJDkBY+dDMDcgF2zBEbi/6CH+XkgNIGy2ZC/23nJT8YGJsOVXg/2DuJa58s6XPM7DhA36rAVfQLX2NA82VvNOtgLsmlXOmFFVLSK8E7fdQ7J6bvbggpcKtpmRMIgMiVrKBPJF68mTRVqKboQpS2CyGz8GWBzHqwq29yYDVtedTDW72TyDIqO/3ZMgV2tyAInkivl3wWvIpepkLz0UGmPxqVBp1SKiWqfNewx0B8WtAxHdrTulj6IFUu8JPwyl4s2tAiufLkZ617E6+552do86PCke+MGfVGDvo6T14ATBLYHYRIM72t+iOy3aP2H/oZuxkV9mWV2M9tL5qkj6fRwONMll2bhd6AK5MOKPbuiVr+ZhNXWSr2rfKowirWgppdz+UsZp3uXJHd6wc1hmnI0n18go5EhDvUWrGGRRnH4aTDYNGIZv4KilAV+zCgpq3SewV7flUsKmHDhUT1IoVWwXttdjYG8TJ1Ch9LbcaBbYv4YCTcpe3y1R5imME2q3+0tENhV7o+LceEidI86Wp0fzwaaPilj11J55h5759YMA6wfiqDh7Wq+ORk2/XZ2MalCAd9n3aWJpU95/aFl+hB4UC1fmOyUTJADejHQCAErcuv+qF8Q3B0MQkvhPGgoqZopcHzhpDjkP5Yp7clJaghEwKiQlX172HMTsHkqb4vCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzEybSsvUGw5ZkZUUHVqTDJzMmpSYWhpdWM0NWJCQWk2cEdxNFkraEZvRlVq?=
 =?utf-8?B?MzRyNDRIRFdzYXltNWI4SlhQS1l6ZTBWOWQzajAxWEFXSEd2czRjL2lBVmw1?=
 =?utf-8?B?OEZlTnhzQk41Myt5SWZNenF0cjRiKzFzUi9HQzNXeXVIdUVnck05dlA0eHcv?=
 =?utf-8?B?M2wzOEg5QUp6a0Q3by9JRnJrbVVjUjR6M1A3TG1ScnE4b2ExSUU0dFo3Zndp?=
 =?utf-8?B?SFRXT2Nkai9xeVlmZnF1YmVFWlNMalZqRkpmTVVvQ0RYbW10dU1BVTM4N0hY?=
 =?utf-8?B?eFNGb2tjbXphRkVTUk1uS1NvVkZ4V1ZBa3A3UW5UdnFlR1NHbEdxSXM3emFV?=
 =?utf-8?B?ejIzWnlzbmt1MVYwNHNuM0RWZUcwcXZkVGJ3dVlsRjlJOVpmNmZsLzJ1NFY1?=
 =?utf-8?B?MlBUMHgxQ3ZpaXFJMCsrc0M4YWNUM3NUWWlrTkxzSzdpanhaVndYanFFeXlv?=
 =?utf-8?B?dFMxYXdiTzJ3TlFXUDlNYVFES3dnRnJqZXpaYXVXZnZpbVBlYVZ2enJ6d0Rk?=
 =?utf-8?B?eEFMQWxVS2Z1Ny90blVBV2RCNVhONW5XNHZOVDhSbmVkcjYzMlZDMFhHME5O?=
 =?utf-8?B?NkhXMi80T3BrVEdNZEt3VkFFeDloN2JOYVhtZ3JRbDRHNitObzVvMzIvUTAw?=
 =?utf-8?B?VFhUYW9QNHhLVVBKbGJNdTRZWWNsaDFmMnVITDNraWZvTVhKU1QrMDBSRGZN?=
 =?utf-8?B?ZCs0d0h1eGZHTkFGY3VCT05kSFViS0JPQVRhZVpML0RCMnF6bVZJTjRuckNF?=
 =?utf-8?B?ek1aaFE3OXhQUkVJMGhvNmVCUHlWa3BhN0hNRnFKODhQa2taWW5RTkZSMWVT?=
 =?utf-8?B?cVpKUmt4ZG9BN3kxUVFXTTdIbGxDODhGakFsVml1amlmRWJVT3RJU0l2T0w2?=
 =?utf-8?B?VHJFRUh0QlpqdHZpblpIWE1pVHRIcGFiUjF1MTg1ZTJ4OTZKRUZ5RlVTZjA0?=
 =?utf-8?B?OEZUYzU1UlVRZk52SEYzUUVoR01aaGdBaUJHbVh1SWtYSVg2YnYxeHRqdWVQ?=
 =?utf-8?B?cVVDQWJYMUVNdUNENWVLTFhjV1J4VlBjeTZEOWI1RmEyVDVYNVNqRnhDSm5X?=
 =?utf-8?B?SFp4blIrdHJLOWo5RVVGT2hLek5kL0xQTTF4MkUyeVhKbWtJUDI4N1RiZk1S?=
 =?utf-8?B?ZHNDTGVwMHV2c0dDcXRFQURyZkNHcy83QitSRDZMd2VVdEN3dnhlVVBsalU1?=
 =?utf-8?B?VXlnV2pTeEhnRmJuNmxqRG9MWVNUd3NmNEVhY0taM1VlYW1WYTI3Qk4rTThx?=
 =?utf-8?B?WjBLVWtDSUphM3g2Z0hYL1NYQ1d0MXY1bXpOc0JIb2grYkMrOHJjWEowSWNU?=
 =?utf-8?B?M2VHSm1xbGdZV256STNMVktwZENVZFNGUTJhV0ZGQUtIUzk3QUlhNEpBOFRJ?=
 =?utf-8?B?S01OUjlqZkJzdDZHZXZ1KzFKNWxjMk51L3lRUHlQU1NMekpXdEJrQlRJTXNw?=
 =?utf-8?B?OTJiWGF1RXRqZHpRTHhGQmxnaXJ5Sis4T2dSV253eUpHcHFIQlk1bXVHd0xx?=
 =?utf-8?B?Z1BpRzFtTXR5Rnl6c0t1ZW9PTEQyUGdRSWdRQVQwNEVtdEwweWRMYTh4R3BO?=
 =?utf-8?B?KzJGbDYrYm1jbDB6VmQ0Z1RoN1FLaEhmblhaTERVR0VwRnVNczFValk3em5q?=
 =?utf-8?B?YVIrUFdSSXhYVDVITlo1YW04TUFNUFZjMGVCa25RMnIzd21DRERBSDNKOVBI?=
 =?utf-8?B?Zmx6a0ZIWHVLKzM4c1k5ZFBrK09YdnovK3ZJUHBweittQ1NmWEkxdVBNYUgw?=
 =?utf-8?B?L2dVUHM2MGtwd2F5dm1FdGpsNUROVGhLRjlYUWxCbEJWeXhJejVkVW83MjV1?=
 =?utf-8?B?VkJZSmROdjc1WnQ5cVJ5U2tTSGNjMk1DTGthNXFaUEY0TmRCQXROcUlFb1dB?=
 =?utf-8?B?OU0zRUtrbkNXWFJnNi9kb2h2aURPdE4zQnFKTmM2ZzBFdStjSGhqMEs0WGVr?=
 =?utf-8?B?Tk5lY09qV09nKytUVjVsS2NqVmVmOTg4TWw3djROaG5RMDV4Yk5jRlVHdlQ1?=
 =?utf-8?B?dG5EdWNOYUI3d3NWdDZqc2E1WmZWR054amd4UmEzNzFSVW1ENTRhaStYZll1?=
 =?utf-8?B?bEl2L3hDZVlndTExWTh4cXB6RkpBaVFBVVE5Z2tyMmo2VGxySGJ5RGJWWDRO?=
 =?utf-8?B?Uzcrd0N1S2YxclZCOVBiVmZkYXFUSGw4Vk9pWnp0MVVtOHdLSHBwdWJiRWlk?=
 =?utf-8?B?YytTbE1yYm02Mk8wcWtubkJJaGJQbjJsOCtNbXprc3U1d09zSGdOVVpIUzdx?=
 =?utf-8?B?ZUc3aHFXcmNHKytkQkwwK05uWEc0dmY1Y2szN29vbUo2OW9tSEhwMENvS2Uy?=
 =?utf-8?B?RCt5cVdPM1N4OGVja0QwNWF1WnRXU2R3ekZ5bW8rcFZqUkZxYUxkUDYxNith?=
 =?utf-8?Q?RgG9BYSdyFfhNOsQ=3D?=
X-Exchange-RoutingPolicyChecked: gmb8VWxOzNXWoRLqtUvBFx5EotuFQsqFZtu+SnQCOEjzWKeakqhnlrKvo8sk2drrD5YgH+1IhchIEecDku24Uw3NM4Yy34gtHEVsD6VpviVzktGAnn6E6Wf8cnBtjVIJzMAM/8gAf8gaKbSt8Ac7bqeWXGbSa7I49+oDioBnvPKRz3G+7L54itBf7S5QzO6Tx61neil6j3dfZcoxYjZT837eEHK8uLKRrcQyKun2/5E85BhficdXbXRPwiZtysmLhifR+t2L33ihVn3APjDAsVqbuWCmdknWw7pkbys/tEQl/EkWS7IIoNNg0asjdYBslCue5mdM/w0id+9jPUja4Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefa7d75-c025-4ba8-55fa-08df05157daf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:03:17.1884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7DNaE3QImpyUXFZb4L97MOeKxKXeUCPTxRNufq3dmu9YZyYIUiOkk4Ax3K5Md857vqab+qx1MVQcwljtP88FAlHmEexFJS7Jwrq+tQCoi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11917
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX4cmXaemxlkiq
 4/O+GJhM6jJ0QF7E49hmXdSY4lXloUaFzua7G72bbIgg0Ox+69tzKf2tnFGD3B6h2CTX4R2/7oF
 iXqdZhyIDYKIBkb1XpIaxd6H5Oo+sBc=
X-Proofpoint-ORIG-GUID: ZTx-Kp7-wI_7qudCFSd9o29AiLW0QveV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfX6ZNAtS3+XxMJ
 2TjarirnmmLjVZO6y2UF8eT5V9tqdpWJ+LqqD1+oFQn/IgL0jL/Ff644Ao9IaKm9TXbPW9O8Ei4
 0sGSjyNKdpjV3iD4nsRQtWZ5PAL6VFcrciwCRlQijgj4EjgURtLKqW9dMR1b8uDPRjuSOmKyiRO
 zPiCOUbd7+vspK5QvjqU1ACdYN0TVJi6/wyDNwcwTEWtvLyASL3jtWUZ3q7n0+nplZZbTDOQJAP
 YdULh6QquL1h5O5cX7Acddodl2DNx6036ri1ecsqhudqm76g3yzrNHIZjxKWwUBI+S66QnYP3Um
 dbWWn8PF2wfXSIEvoN8VJGS+AX1WADMTZHktXZPKfK6Frzpi1HO2WAoiq/1HEDZdi3+fj9xfLun
 LrAj1LEypAoGfJSxeK08/fG+3AcRngwap3AlfqLfgoNXMM0Tk3SNavw5OhdVbJNylU1HZtnmJqB
 vyYwuWppsSPWmIEK9lg==
X-Proofpoint-GUID: ZTx-Kp7-wI_7qudCFSd9o29AiLW0QveV
X-Authority-Analysis: v=2.4 cv=Me1cfZ/f c=1 sm=1 tr=0 ts=6a91a338 cx=c_pps
 a=/cdxYPoEIjFnUsMTEY5PDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=fftrgsByXVBibpBSsv8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/i386 to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

In order to facilitate the conversion of alias properties, this series
introduces a couple of new QOM functions: object_class_property_add_alias()
and object_property_set_alias() to declare the property and to set it within
an instance accordingly. This implementation is hugely inspired by the
existing link class property code: many thanks to Marc-André for doing this
initial work.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

v2:
- Rebase onto master

- Add R-B tags from Daniel

- Update comment on patch 7 to explicitly describe the change in behaviour
  of the pflash0 and pflash1 PC machine properties


Mark Cave-Ayland (8):
  qom/object.c: introduce object_alias_get_targetp() lookup function
  qom/object.c: introduce object_class_property_add_alias()
  qom/object.c: introduce object_property_set_alias() function
  hw/i386/pc.c: convert pcspk-audiodev object prop to a class prop
  hw/i386/pc.c: convert rtc-time object prop to a class prop
  hw/i386/pc.c: convert PC_MACHINE_ACPI_DEVICE_PROP from object prop to
    class prop
  hw/i386/pc_sysfw.c: convert pflash0 and pflash1 object props to class
    props
  hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object prop to class prop

 include/hw/i386/pc.h |   5 ++
 include/qom/object.h |  24 ++++++++
 hw/i386/pc.c         |  29 ++++++++--
 hw/i386/pc_piix.c    |   5 --
 hw/i386/pc_q35.c     |   5 --
 hw/i386/pc_sysfw.c   |   7 +--
 hw/i386/sgx-epc.c    |  12 ++--
 qom/object.c         | 130 +++++++++++++++++++++++++++++++++++++++----
 8 files changed, 179 insertions(+), 38 deletions(-)

-- 
2.43.0


