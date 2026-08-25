Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489DAC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrSB-0004Ey-TJ; Tue, 25 Aug 2026 09:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrS1-0003zb-1F; Tue, 25 Aug 2026 09:44:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRz-0002aQ-Cj; Tue, 25 Aug 2026 09:44:28 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PAvsk1058074; Tue, 25 Aug 2026 06:44:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=thv995sBhI0vMHZ+6xwo591BtJi6gBrbi+JET8j3s
 l0=; b=I7d+J31/WP/5w+wu1XF3VvXhQXl6H+/RqV8HYtFjfg22mVKM19u7bC0jY
 4LCspWoUuNZDSoOAmzqq0veYEIRgCRPJLoWfpe7eInqxbIll9Fsg3YzUV2M70OgG
 RSLtE/vGzgU9/V2TAP3HGKaQCQEG4Z8Y1mt4vo+pwAiq2o+mW2c4EsQivtutEWpj
 OWT0X2g+UzUBeABpkHZJFfiPGuhzWxVf3GuhisktdcjCVa3ZXHAJXAtq2hNGPZie
 G4CaSj/JXPNRERepAS86aq9p0jOjRrrRU0Z/seFuBHs4kGFQLGEqve2CFIj56p+s
 SxrpvHXZTxXP2OkPC1DAksmnov2Lw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022116.outbound.protection.outlook.com
 [40.93.195.116])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g97as0ryx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gecNhxVxJHaoLvE32ZurOk0B2Q/ogN7owjRT+Mw48Kg1Yl5Xex94mWPn/cycgljvpt+ItYCf+HApqmVPf8nubgbnz/rvyl0EdNa1Qbbxv1FODNoFaRMyvQA723yPYhGGEAXjpb2dNrC1S3H+SPjUOwfR7VZ6cipM1+eXXsXFBI+GkIWH1nFtAQXOen5DKIQBeETvqFEUjYchUJ4XAtPDVgDAZpUZTvHxLPH/XsMhIrb1fysFE9TGnGfSdTbrb7o6PljcxvL6PMg3O8bodLR9DMFdG6vhpY6VeKQGs7IzKKENHeKVOPDJYdnHPHOHE3/5maXd/7BSsf2fHTBN7ijV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thv995sBhI0vMHZ+6xwo591BtJi6gBrbi+JET8j3sl0=;
 b=wDOcAWD0pjo8EbMY3YPq52ISPmCrzFJHnU+RxmTXHihhDzYLoCAFQFDXhBVgLiPNdPVdA9K1h2lghZfdTM1+D1MeliBQvwM6jEiXmSKuzvq29rM5Two1Oe2RP0RriaxRnBbcV2Rt3ecy19vkCc00AgoYFO9FVGLveIsWq+lYCdxVOxjsCKGdNvMm1CxfPEWdzT6IH2TTyJYuRJahn4zs/2kGKG5XEhPwR390sXav8jsKGH1859qnonnGdujUs46Q0xggR2cfxwpHbRP6I6poZwbxrfn+7w776XiD9RJPtQ/izdihSmSsDSZEB4Mn5b0hMesUM8jhhOGt922j7afnxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thv995sBhI0vMHZ+6xwo591BtJi6gBrbi+JET8j3sl0=;
 b=yFC76VEOslaTRS5OWZ/Q/E5IzXJhZC4wv+CJJpzaLUAN5ZtATMv7f1/Jn7tnldMozMZXrTUsgcL0IXWZryx6OJceIXA51QOnudvHGEJvT1XMGHncxFwazYuyzy5o3ebs5z0JmHpcD9FzcOvdzdhNgjnu1vrARb8gWT4RXAYLdlUquGfNK0npLQ0XQwh5qxNy/hQ4AJKJypCc6rHKRnzDCTVqmORPfk/MCCIJzlRLp+p+FaBE0JN6gDqvy8VZrYO3BQdYZ65PVSVm6wrPmCTVyG6cgdw8rpcFybvSliSndqULdHEXhNy6YO6yfq/OoLlEa3FhaP3cDin2XCtUI43hDQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6926.namprd02.prod.outlook.com (2603:10b6:208:201::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 13:44:14 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:44:14 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 16/16] hw/acpi/piix4.c: convert ACPI_PM_PROP_PM_IO_BASE to
 a class prop
Date: Tue, 25 Aug 2026 14:41:37 +0100
Message-ID: <20260825134320.1039012-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:806:125::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaf3fc9-59c6-4fcc-8fdb-08df02aef354
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|921020|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DHOhTReDrEF5zhs6/UrnSyNOLzy+zxqXzO0euJcwExwxzSo7QtnCuPHaVw3qR5HHouej/D3WHRMfZvQ6HLC/i/bXFGk1fkp5AiJI+QfMpvsO3gCweW7xrTumKD2yLO3ewP8is/BwjDCl0TPxApQL/92MtZy3PLHByQpEqLoR8bRpPTo/+YZWF2RtABbjg+r37GUocQpERtP2Sddle/Jq4ADQW7rbWcbPHDPFiuHa84iwQEXNOyY6JCEkhgWJifulJjaJccSbHjlgkEkznnAAL2aAb+AoF6g3kePhEtnfnrJzT0KIPD/p8UWOe1Vpyovawf0fGP8wCTakptOX7tnyxPZFlnWf+5JfbGaSskw6NR/O9+Ve9gXqblyYxBDqtPKkHKjqUONUubXqlchT7LrrXyKIGFopppUFjeVu60osajHBykrIpJBdZLhHgY0C3+NdE6oX0dnq43cPOq+qyQTZLe+4Aaa281NoAChCIc7Px2jYVcDkt4g+DTnJrMq1A1DVQK29Tg+CZXSZztNl0y1fMc+JSC6rHLS1ZWF+G7ifNzUqRvjBWd2UjJE+hdiXe3qz+IqVCtIWBZHhq5n3s0lLr0Rih3ezxhM1RWlJzhQltv308s5kCv5rEdJ9bju89jKUUg5Ub7UvsJKjsuOrt4419S1U7xx2MwOH9aSZ11YqqLEFRk1C5LEGL1p+dI6BVUq8V7uOncfFGO+fb4qKv5QiJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(921020)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WS9FUHZ1Y0pINGRuN2NmUWhRVWVRYkwydi9ETEFWdUxoKzVFS1JyNlRBS25S?=
 =?utf-8?B?My95amRqUDY3UEkraVg0dTlNS3p0MFljZXRHcEMwbXk0UFppWGZoUVVqcDdV?=
 =?utf-8?B?dGRwbnhGQzM5dDdtSjFTY2d1NVB1ZU13aDJjWmhCY1ZqdllWUUVRb3NiUDJJ?=
 =?utf-8?B?VUJmNE9oVDNSWmd4Wmk5cFo4MGNoQ3VzbFp5TWl6Mkh2Si8wcGhpQlVDMGZl?=
 =?utf-8?B?YTBlN3JoTGloSHliYkNnbTNXdVQzaDI2YjhNV3pOdHByazZEd0svUDd4Q0Rw?=
 =?utf-8?B?VkJDVm5kaWJSU05za3RLOG1sbWY0bmhhaDZ3bUVJS0E1YTBYZkw0K2poUFBU?=
 =?utf-8?B?NjB6R1piZjVZOHc3TjNoUmZ1UXh1aForYWkxL1B6a0kzL2s0VytDZnQvc2V4?=
 =?utf-8?B?L2w2cC9DNFh2TEpuTVpxamlqRkFocGF2V244MXhXMVZPVU5DNFY0Z2Y3VnVJ?=
 =?utf-8?B?RWVjSSszTTNjZG5ldDI5VXBicHBaODZlMzhpVFhnNS9JcFh1bGtXNWd5czVs?=
 =?utf-8?B?Qm9LcWREL3lwRFVLcWwzVFJjaUtMVnROTDEvUFhEUjNLNmtvbzhpT3ZRc1VJ?=
 =?utf-8?B?YjAyekRHUDBwNmV3czVRalE4eCtEekhmbjhibHJiRkRqMkpJRStPZ0FKQUlv?=
 =?utf-8?B?RHJqcUM0VEhTRjUvTXBIWTJRYWwxQTZVT3VpQkVwUTJiaFFsK0U1d0dHL2xK?=
 =?utf-8?B?aWdTVEZadnNRM0ZWQkZVQUtIUTNqYTFLdTJPNWcwK0ZLNmE1dVJlNnkzMngv?=
 =?utf-8?B?ZE15OU1aT1c0STF2Qlp2UTRLVzFaQlYxVmViTHRYM1d6VkFSTUJWNHcyejR5?=
 =?utf-8?B?bzRtY09OVzZEQ3ZiN3dOZmpDYTNYV242aWRxNndXTjA2d2o3V1hPa2I3RktR?=
 =?utf-8?B?ZjdKV3Z4MXdoeVMzS1JyUWFTV3V4cHpiY2JIc3NoWE5hN2x4SENuTVBibWZV?=
 =?utf-8?B?enVJa1NLbTdPNmVKN0c2bUdQanAxNW45Ri9ldGtmYlkvRGRCYW9GZlpiSHZT?=
 =?utf-8?B?STEzTDB5bXZiakxzeHdQN1RmQVR2TzFwZGNYczFzMlVYa3ZCRGlaQXNReTQv?=
 =?utf-8?B?UUJ6NHU3aG5hRkEzOTZGS24zYzhlVHVyaDRuWXZtWTU5K3VxSDY2L005SGdO?=
 =?utf-8?B?R3p6dzNIVzVCSHZjRjNOckdzRWhOdHIxenBGemdRUjRUK3JXWTlxWWl1MFJD?=
 =?utf-8?B?TWlLVkZ6Tm55amtXSXRuZWtlZVIxTitBWEtLTzMxOE5hTWYvbzQvd1IvVC9t?=
 =?utf-8?B?OXlCMXo0OUUveHpocnp6alB1cUY2WVVwOXF1bTRpTFhEWStqaC9aTmNjSUY3?=
 =?utf-8?B?bVpBcENLYXRjVy9oTmU1M3J0cGFwRGoyT0RVTHRycU1oUzR5US9VdTNTQ3ZP?=
 =?utf-8?B?eW1NMWNFTCtqTmNSSUk0N1QyeDF3KzhCbEQza0ZzNlVsZGpvYUw4MGM3VWdk?=
 =?utf-8?B?d2M5NmloS1owaVNvV21ULzMzQURCdVN5ZWJqeG9ueEZnRStDUTJIZ3czNy9h?=
 =?utf-8?B?ZnJmeUdOZStPd0xOb01XUTAxSkRxNURtektRQ0E0ei96RnVkQTZIUHE4NnJB?=
 =?utf-8?B?Y2Z4ckJiV3daUTlHMFBFaWtpWXZmeTA0bTZ1eDBhOVZKaWJFbUtMd2h2bjN4?=
 =?utf-8?B?UkFaU1dzaUhQOHVRNHNVOUUwQUhYalFyb0gvZ1V5dTdkby82V01rU1BGSWR3?=
 =?utf-8?B?Rkw0aHVEMHFDSXVabXY1bzVmZFdaZkRTdFkvSnJGYmJHaFZ4S0orT2xoRTZB?=
 =?utf-8?B?ZFdOeEZLcDh3enZQSk8xMC8yU296Yzdqdk5Pa1Q4RzVmSk5mcnl1U3A5eURC?=
 =?utf-8?B?eElRNDJtUDJ4NG1KQitUUGZWRUk4eE44WGpVNStDMGxmM0NGYXN5MFExNjRw?=
 =?utf-8?B?QmRHUXM4MWNmTzZCaVdEMzRBQ2ZiWGxWTlB6WGZMdEhSWG9GOGZqZFZQaGI5?=
 =?utf-8?B?SlZHM21uOEt1R0ZwbmhBczI2R0twVSswUjRKUUpUdnd2R0lUK3h2aHEwY3cx?=
 =?utf-8?B?ZmVwRTUrNUdub3RvSkY0dVAvUGxTazl5SWhUZWRMNU5pVFZEQld1ZG0wWS93?=
 =?utf-8?B?cjFwNkV2elpXT0Y0bjVVenZWNjBRelpkc1FlenVDTXBMQ0ZZaFZLais1N2JT?=
 =?utf-8?B?YldpZEY0N1g4b1pxT0pDeG1QUE1OTEk5MXVTZXhBTlZVNU0zRkYySkF1aktW?=
 =?utf-8?B?S1h2dHZsTjVCZ2J3YnpVeG15emdLU2dkeS9VaFVmV0JyODMrdlBYcmVqdm9r?=
 =?utf-8?B?RFN1aklpVnU1RVBJVEVta2dQT2lKS2xiUDZyUEhob2VVMEZVKy9mQVRyM0tt?=
 =?utf-8?B?aDZyTUhRYytuVmNjRkl5d1kwMHJCS2wyWml4bGExT1UrMlhaWW84eXdjMHNF?=
 =?utf-8?Q?bIjYRgfRGyKZBhqg=3D?=
X-Exchange-RoutingPolicyChecked: ogaJTw/TCZVs80DaQiQgfEwLeAra8Zhxs3rXYtIBlAAr1mLyv5W4meATMSONO1cWONWt/wC2hpzxcWbkKWGhis5rViNE7huAgU9k3VYBsja5Fh3x3qy4quHVnx8mJTVs/3Qz2/I8APPmle3+O8zJNrCP7z8jiajjo0aNtRf8EeBNMjNVztnocpkThceKP/K3eLj+IRT1pmDBDgEW1vhIs3tiFLVip9pB0ztk8dLp+/Rkvx981TrpO3NiP2qpCbkK2X8RAPNlrv59CO+JDASKozk+6s4MjKPF9/sivy/HlpFRJlCOcsPh1/vDz5+3E9iUB1ahhJKaOZ6rsFSMhlxGOw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaf3fc9-59c6-4fcc-8fdb-08df02aef354
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:44:14.0541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //w5HCys70fh5tGRirFBRvmnCbJWhdJZcbLoylJ+EtjCTyrF/o7iLl0885Q+QG1EJNaiiLZy+30ukftXy21DNErQtOUHiB+BQGYbywAwBI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6926
X-Authority-Analysis: v=2.4 cv=DJu/JSNb c=1 sm=1 tr=0 ts=6a8d9c30 cx=c_pps
 a=z2sj+kS3ni7iHMEfy3uXWw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=i3SjWmbloiJ2BglgP1YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfXwmDbqC2cpVyk
 nK2KoG6rIjyXNyP4NI5k+TZvZh6ywB+rYnrAKLG74wvm7MF/RHI4iZPPXcSGKTO7UvT1J7R+PeF
 EfIm4xqZaNPvOBH5Enx+PnOnuS+qVFs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfXwAmZXp7ZbIid
 SsZZyhWBOvqMR+J7LHnuln5LCtki4auFbDNsV+Rga4Cppjm7ENdPAEkZWQmlI1H0gV0dXmtNmMD
 M+ZXYhZ1dPLfmCWIiRH+4fmNLd7M+LRLE2Q2cn54lssTUmmZp+tfV42gJt0Z5iucXNERUbWnveM
 /RxE0O55MVw3x+BRw8vB5JL2EjV1PEpWuFgbQ2S6vD7TlbVWxdHlZrcJSrV2Sh+oPu81u2HmCcX
 YVFS7Y4hwIPDUnLbx1rzPDY0VHVA/OdAKwlJN8TxyZUHn5eQRoc6+BV1ZfIUwueFzIE7LmLsY8J
 RfSl1wh5gLXAJlXqPMLUWBAhXW3ZwLcSXf2RsLs6OGb8dPf7sWOU1J2XCIyx8BfhbwA4S9zcFCq
 Xjl9dKlDuRTYZbJHNta+hHd3k2ikcANYT0yXBrEJfRBfL2y2/52PjnETGEwqbw6Ofa+aUeeH6ky
 3PdKckgQeytz3I5kZ4w==
X-Proofpoint-GUID: CyHfSEeU58XDgUNltieIb0fSzwGHZH3D
X-Proofpoint-ORIG-GUID: CyHfSEeU58XDgUNltieIb0fSzwGHZH3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

ACPI_PM_PROP_PM_IO_BASE can be converted to use object_class_property_add_uint32_ptr().
Remove the now unused piix4_pm_add_properties() function.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/acpi/piix4.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6462ba970c..52bd61667f 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -405,12 +405,6 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
         (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
 }
 
-static void piix4_pm_add_properties(PIIX4PMState *s)
-{
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                   &s->io_base, OBJ_PROP_FLAG_READ);
-}
-
 static void piix4_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
@@ -439,6 +433,10 @@ static void piix4_pm_add_class_properties(ObjectClass *oc)
                                                 ACPI_PM_PROP_SCI_INT,
                                                 &sci_int,
                                                 OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint32_ptr(oc,
+                                         ACPI_PM_PROP_PM_IO_BASE,
+                                         offsetof(PIIX4PMState, io_base),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
@@ -494,8 +492,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
 
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
-
-    piix4_pm_add_properties(s);
 }
 
 static void piix4_pm_init(Object *obj)
-- 
2.43.0


