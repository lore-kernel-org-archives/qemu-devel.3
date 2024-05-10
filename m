Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B550CC25B4F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 07:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Kli-0008V0-GF; Fri, 10 May 2024 03:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1s5Kle-0008Us-Fh
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:34:10 -0400
Received: from mail-psaapc01on2132.outbound.protection.outlook.com
 ([40.107.255.132] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1s5Klb-0007j4-Lq
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:34:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEbOMV2+Gm4XPydQy5L7MVbglPQKest3/KLG8b2CcABXZWdqQXuTJUqjcOFQTABN1+oEft5HjGBUwEdiAnxRbj9S9YqYMzycPF7JHzm0TloK3sEYsdUtag0Y5Oa7rj92mxJE6DcEbipGoSk3zUXSu1G4M7a4GYYFcJl0EUKxKnhJ1RBXXL/U+IxB1xrKlhEiH42qxF36jo72PFEL3Fa2POH9BNmSpWaSQzX83gJqqxph5fTviphuEizQF5+XwJ2m7Foq5X7d84b008bP71ipr3pybltrwIPbayV2F2yupa2GXoE7LfeSSeRpivlrrFjwFVz3X83VPQfzn6Usp/dYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4SyXo5LCdaGG7sh5s3v/VTZLyCIQcxRld+eOfuga2M=;
 b=bk/VOmcZEicZR+CugRpdJNUmOxN+7FqJdcpxPiNmSGbBPu9oCp/gLQh+jVITsWNT4bWZtm2N0EBq/4S6/yhInDDunkEmXUHgDmh8hBh2uLEGcVbS/5PMPN4PxEp7F9b9VWlGBjc0TTKSj66QK150UF53N+csRJDGmcXBM9AHX7XHyiZ6ac/sY1KLAmVRFDNjtz0XuuJDo7zFFd3pCTHNlRCv3pNHlsQRXhgTvFSnN8qktvibL8/mYP2yfCfby+AoDuk/aurIdLnS+jNHKaNrdk6mvqa/x5zzz8ZoDljGE0CAM74K5L2B6/JWJDwAwkIhW6SVAInIbJMyyoi+1mHfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4SyXo5LCdaGG7sh5s3v/VTZLyCIQcxRld+eOfuga2M=;
 b=M7xWpXgDa4HCJIaATRrOfz0qWyyHSzItbHIYI6LeVwYnCwufQZcWwt7SVwYsvbg6Wxqhvs4awLtsjLCFcX/ids2SdqElJ3HW8unl7afYHoIZmsURKDo138n4lj70iBcuUobh6ojwCFehWhIX5ZMW8JOJ5l5CSiCUofj7Apsbb/evnchUPcmnbJM+UBQhnwcIzBr1ibFHRe0OoJMAxppZlOIoKDOBYUQnpcEJeXyVHbWAXIxBB+2yP9Dcdbh8XR1tV5NJjBx/PsHu/4KL/KavFXyHBzSpB++jXWPCY2DhNQkbtTKlH3HF0a0MYGplpjYS8N2BqykUCsGtszwh9/OD/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by KL1PR06MB5969.apcprd06.prod.outlook.com (2603:1096:820:ca::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Fri, 10 May
 2024 07:28:58 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::b6f8:321a:6742:9bde%6]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 07:28:56 +0000
From: Wafer <wafer@jaguarmicro.com>
To: eperezma@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com
Cc: qemu-devel@nongnu.org, angus.chen@jaguarmicro.com,
 Wafer <wafer@jaguarmicro.com>
Subject: [PATCH v3] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Date: Fri, 10 May 2024 15:27:53 +0800
Message-Id: <20240510072753.26158-2-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.27.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|KL1PR06MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 1661f4f7-6055-4bdb-d499-08dc70c2da0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|52116005|1800799015|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3hJRUhHYWN0bUJTbk9TWFhoUWtQd0pCcy9tV1BnOWM5WXoycHVmWStkNFJ5?=
 =?utf-8?B?OTQ2ZERxSmRMWlpKU3ptdmNjR0VGVHBvQmRyK0dOZytjVmJKWWdrVVlUKzJl?=
 =?utf-8?B?VStKcFdzNWI3blFBRjN5U3VOU0dlakhIeWxIOGtiU0cyd0d1VXRYa2hsaTVW?=
 =?utf-8?B?dk8vd2VmR2VydWFqc2VjeFJNeXZqaVVmeXRkRjlzQU1HY0dyY1k2UytHaGZi?=
 =?utf-8?B?S3ZHTHJ0Q290SjBLakNkeCs3Zm9ST3JQRzl0UGRvRGtTVkxVOTBQaEQ5M1dJ?=
 =?utf-8?B?NEFvcUQrUTd4eVQ2NDEyZFBuL1hMTFFKYUF4ME1VY0F0b05ucEtNUjl1WmlI?=
 =?utf-8?B?WlVoaFRmT3E1YjdYaWxaMjR2aVhJclVGN0t4TGdpQ3J0Q3BVcldoMGZPU2N5?=
 =?utf-8?B?a29PTWdDZ2ZzMEhoRXVsN2NzOGFTbGczQVNUSjhPdUs0OHVGU1NWMEtaaGlC?=
 =?utf-8?B?N0t2Rk1tRTJKMDNKRzVQQkxMV3gzRzZDckhjcGJrVDB2RmFnUHYrYUFzVVlG?=
 =?utf-8?B?S3FWMm9oNFRRNTBhdWxCOWhOcGhZV3M3UXRtTjhNUHBnU1NyY01sT0cveXJH?=
 =?utf-8?B?S3NSSXMvVm1uTFFmQlQvdVU1TmRQMjBiekxFdmJRMXpwcjFXNnYwTW9vK05G?=
 =?utf-8?B?OWZxbTcvSnJlbXNOc1E3aklJeXRWNzBtWHZ6UVJVVHZRRXdhMGMvN2RyQ0ox?=
 =?utf-8?B?aWpKdFNnT3RqWVlzemc5YS9TQ1RTVUlJcFVoUnZ2a20vT0pQa1JJVGIyMzRJ?=
 =?utf-8?B?bjBUaTJVdUdBOEhXQWxCSXRCOTczMVVTSWw2dTF3TGU2QjVJNXdKazQxNElG?=
 =?utf-8?B?QXdQZmZvbnVaY2hGNk43dlVQRzczdDd0dXZ2Sml1MnRVYUZUYkpYMHFEdEZK?=
 =?utf-8?B?TENHVWQ4bzZXVENENmV0RHVodlBoWTdvWUJLalBFRHp6YWxuL3lua0dFRTVX?=
 =?utf-8?B?MndVQzhRcGloS21YbzBER3Zqb1hoUkpQRmpCdUhXMjlqT3FPeUpHL3oxdWNp?=
 =?utf-8?B?TFp4T3hYb2RUeTczTGtvL1F2S1IrLzY1RUYybVo2TWJqUWJ1ZWdZQzk5K3Ir?=
 =?utf-8?B?QjdTL2pVd2pwVUpHbVF4UEFTQ0p4ZjBYS0VYdnBlUURxMmZuOERORWtQdkkz?=
 =?utf-8?B?Z1RPRlFTNEc2M3RMazRLVDhNYUNuZXZnZ0xCYWRMZG1EMUVYRXF1N2lGRUpo?=
 =?utf-8?B?bWVWNktQdkdvNG9HK2IvdDI0SlRBYnJ5K0E0ajFueFhnSndXWjliU0VteHNS?=
 =?utf-8?B?bTBoSWoyZXAwWnU0U1VpV21pQ2xXa0FSTzlxMlc1dEpCaWFxSzd5ZHpNL1pP?=
 =?utf-8?B?N01kQmhLenpmTkxtVk04dUFDMjFFTzdlS00zYmk5a1hzU1dHTDJPYUxXKzNE?=
 =?utf-8?B?UHJ0NWtvU2VKVFR3UHV4VDVmbWVsZmxyWVBHQW1PbTdPWDRRMnV0aTFtb0dO?=
 =?utf-8?B?ZEtHK3RtZ2craXY2NlNybGFXd2tJNjJ6RXlWVDhwSjYrWEYzZHJyN1NDY0NR?=
 =?utf-8?B?R1NoTnBpSGc3d1FNZ1pDalZ0eDhRZjdhakNUZHBoKzhMUFhrNnR3c2ExczZw?=
 =?utf-8?B?dndBaHFKbzlZOTdDSEZybDVudmtoWjUxNjlublRKU3lqQUVUNWZXS0x0Um1X?=
 =?utf-8?B?d2E3N09QdGxOSG1uV0k4NmZuQ2had0FpR0Ntb1gyNWg5T1ZFU3UzU3JMS3Ez?=
 =?utf-8?B?dVZYSmUrWXdIWmFXMHhRd3R6TjYzK1JJNUlTWmJyejV2NzlEZ3VFeUZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDF6amVBZjY2RDhGWkJoaXlYTHhGcHV5Lytzcm4raitrWGcrcXNjNWd1Zlgz?=
 =?utf-8?B?dkszbm9iczI1ZmVVNVpQcTNlRDQ1ZzU1WWI2TWN5N042bkRGdHYrRmRWemxC?=
 =?utf-8?B?UGdIZ29qTTlsYlRHeitSK0hTSm1FYW11WFhxR1lzMkd2SGNzQWNZSTRsN1hv?=
 =?utf-8?B?NER0dkxETzU2VGxvbHlSM3dXVGZnNkZiZVpYQ3ViWDdpRzU3andiMHhBZFVo?=
 =?utf-8?B?ellkMDByUnh0bTFzR3o1S21Sd1ovZWZKZ2E5dS9waHE2NTF6WjNKWEd1azdK?=
 =?utf-8?B?SldsMjFDWHl2M1AvUnZXejkzeFk5cFBaVmZhdlczVXI4Wnp0a0VxUGV6TnpG?=
 =?utf-8?B?VW1aWFRtaFk2WEZrVGNIaFBZNXFhYW4zQVdPZmJxNGNkQll2eXk1aTdmUnI5?=
 =?utf-8?B?ZjdtNktqMHRrVEcxQ3NGR2V0ZjJBZFV1bmxFNC91ZHJobWVRVmowNUV1a2Zv?=
 =?utf-8?B?MDg0N2RxK3plUVozWnVDYVdGazJEZ3c5emNwWEFWZTVEOFppMFFDNTFqbS9R?=
 =?utf-8?B?dTR4NXFlMWhMdjIxM2s2WFNLYXBJYmF4elBQbGJrOFQxQU9ycnBEYXJqNVp3?=
 =?utf-8?B?OVFLbkd0WmxaSzF6Zys2MGp2dGplOXlCOVVsM2tVYnJXNUJmdlcva1ZaR201?=
 =?utf-8?B?MjI2ZTYxRzgwdk54ektSMlBEQ2Y5L0VPTXpRcFFQZFRrbkt6ZEpySEVqcW5C?=
 =?utf-8?B?RlVUYmlYUGYrRWU4a0gvd2RwZCt4WlRpN1JRQ0dJbU1xd1JVMGJTNVplVmRF?=
 =?utf-8?B?MG5XcU9zQllmVUlxeHVrVEd4UXorOGRmMHY5OVIrYnFreExOaWZ0bEVPVUo3?=
 =?utf-8?B?K0VuK0RQcjZBZHgydFJHYVN2bmhkeW1yNnd1VFJOY3k2T1BrY05qUU9iMlpy?=
 =?utf-8?B?UGRGNmpCMHkyQWtibEs5VDY1TUxJOEhSalJGeXBhOGZYQTNFTG9JZG1mK2Zy?=
 =?utf-8?B?ZFdobkhFNTZ5bXUxMG1iUDRteXgxK2xEUkJDN2RzLytDb1NZOXBicVArQ01u?=
 =?utf-8?B?cEpIQ0FUbjBObVVLQTFqZ3hZSGpiV3piYTArNEhKeVBOazhqQ3NWRHh3ZU90?=
 =?utf-8?B?c0d1Nm9vNlJheGljSkl1OXorY3dLOER1aFIxaWxuaGhHMm92QUxTaXZubGtS?=
 =?utf-8?B?ZVYzd1g1NkdaZjVncmVEekFJaEg0R203WHE1bkFyRmsrcnBkaUF0WkxVNGpx?=
 =?utf-8?B?cG53cEg3ZVBIWjllTTdhMlcvVkZTRFVFUlVtYmhwMkZFMEw4MzU0NmtLSk9K?=
 =?utf-8?B?eDFaQUd4T2RXalNZdVdmNm93Vks4Ymo2NlVseDdHc0xhU0lwbjN0anJ3V2hX?=
 =?utf-8?B?d0svR2tZU09XdU1UVllPdTFlSlFQMExxOEdPUmdkVVNZMHVMRVlibFJrNndE?=
 =?utf-8?B?cTRadTM5ekhoUVp1WXZxalJGdW9sZDVpaVUrWXBLbGZoRXRrYk91clYxWEpM?=
 =?utf-8?B?b0N6SkJDcm1ncklIYWtCWUZESmdPQTJIUWh4VHNCekZBUFVwSzlMdURremxI?=
 =?utf-8?B?dzNEOGhhbnVDbkZPKzBRSGhGMmlBanJiRWI5V0Q5eitJZW51OExQeEk2VUs5?=
 =?utf-8?B?eFZvWCtiSnJ2NUJVQXVyQjlvZEtWTkN3eFlPamRERll5Ui9laXFXWXJnSlRx?=
 =?utf-8?B?TkdVbkFZM24xQkdKcE1oSGZrMkd5S2x1Q2ErVjVEYllveE1kSmowdVNiUVdo?=
 =?utf-8?B?NFlaWW5McmVMc1J3UU4vcnp5SGRMVEQ2M2o4dVZ5UzVBTGxWelllSE92clJH?=
 =?utf-8?B?U0tYY3dKS3F6dkhNZS8xN200bTc3VVRVMnIwcUhQV1NuWmllMjZ4cm80cmlS?=
 =?utf-8?B?c2FmcUJEVXhqeFdudWFmS2tmQW1jN3I3NGZlMTBQL05rSml6a1B4K0xGWmg3?=
 =?utf-8?B?Ymx5QUVQSmtmb09WQU50TUNVTW9kbk5aYm12MkduYnNRUzBNajEzclF4dVIz?=
 =?utf-8?B?TmFKcTRKMXF2cENhTFBvVC9odXR0YUEyYlpsQzRSblhPZ1hMRWJ1bmJuM3hD?=
 =?utf-8?B?Y2JXSjE5OGZya1V5eENBTzJaNkE0bjE5MmRIZ2t3SUhFekUyWlVuaG5ndm9a?=
 =?utf-8?B?eWFPUGdRZVdXdkRMT1hTRWZxTHNzSGRYWE9mNjZXMHp2VWtRczJQZUNMOGJv?=
 =?utf-8?Q?8uhxi2POCf5j0fz1DrE0pRPM2?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1661f4f7-6055-4bdb-d499-08dc70c2da0e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 07:28:56.6490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Yf3hTW957Vu5icS2CMX6/oBuke3Al+7fJOx9U0PgI5sFLFHoR7HZiNyljbUEO/vXB6doK6uba0k3VYtoxLiDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5969
Received-SPF: pass client-ip=40.107.255.132;
 envelope-from=wafer@jaguarmicro.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The virtio-1.3 specification
<https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html> writes:
2.8.6 Next Flag: Descriptor Chaining
      Buffer ID is included in the last descriptor in the list.

If the feature (_F_INDIRECT_DESC) has been negotiated, install only
one descriptor in the virtqueue.
Therefor the buffer id should be obtained from the first descriptor.

In descriptor chaining scenarios, the buffer id should be obtained
from the last descriptor.

Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")

Signed-off-by: Wafer <wafer@jaguarmicro.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>

--
Changes in v3:
 - Add Acked-by Jason Wang

Changes in v2:
 - Use Jason suggestion: Move the code out of the loop.
---
 hw/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 871674f9be..e9e8447878 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1744,6 +1744,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
                                              &indirect_desc_cache);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
+    if (desc_cache != &indirect_desc_cache) {
+        /* Buffer ID is included in the last descriptor in the list. */
+        id = desc.id;
+    }
+
     /* Now copy what we have collected and mapped */
     elem = virtqueue_alloc_element(sz, out_num, in_num);
     for (i = 0; i < out_num; i++) {
-- 
2.27.0


