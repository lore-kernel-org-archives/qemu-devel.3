Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A734BEDF148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqlz-0004nx-3w; Fri, 13 Feb 2026 05:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqlx-0004nn-Hu
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:51:41 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqlv-0001Cs-MP
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:51:41 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DA6BhQ3534639; Fri, 13 Feb 2026 02:51:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=n7XcvExclRM48bmwvIC6MQ3h3tOogkY+wtbI8gqdz
 64=; b=vcpG/A378geqZ5U01Dzk7b71wrHfYRxcBOj+TWkRUfO/Cc1RfbxTgufJt
 dW9Yc1zE+5tLvtx+8V83uU3Bkr5e6qGn+JW6kC8jVvW678Ecy4QMOP76rf19Gr2C
 5qtUGotU00mfVEB3xanUIWHQ6YUk5bzfp4TuXmOeKJAG5xU5XpUvleGkISDF6qk4
 PB3LFGJM7kfC2ntOApjUFOO6o/QNqynhn2/qOFUsuk5MT/UVLkogL+ttm3y2V+MW
 oLyspFN7e/Ae4oHvzKRmADN8w2NEju7dYiKwVXw0t+ulhnRVlglsVg+AYCh0AwxN
 8o1uJrK4Yhsnrtyy/oExQgDkWWyyA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020084.outbound.protection.outlook.com [52.101.201.84])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8q4d72yu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:51:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4xJODmfjyEwAtCkVHD3BOadrXFJFhW8yiregifuATAnEjXmWUrgBHyVi+TVWLz+JVcBd+i9wAk1hczOkpbqfthngAmFy1WzqkGkiZ6ENf4Nrnl0L7EzH0B7GaUcxW+0yIfbl8BZg4Wa7p9AjT46Tgbr7LGK7mLX/Wk+kyS/5saLN6C82agAcOCRU4WyNju51NgPK0ATPcCF7opXgmcPxz08AfOit9bdlp9JmzV9jMcvHOQFp5K6N58Od1O98iLSKh7o30jWmGEvJb0X5Nttz/IomjR01NeQUQf9UdXOHskuVaJ5nRuSz1hVpro1ZDzSBwkT+BxWRWGH/9WObUP8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7XcvExclRM48bmwvIC6MQ3h3tOogkY+wtbI8gqdz64=;
 b=Y907aKCDigtttwb02p7BqJhhY6xF1C3ximLQZAsVLklop9eF1fgd7B0RLFhoBsxoiU/VSWz0OczLKoYT68icPNg3ILAzi4uTfiM+huLh7+VW8KFmyRDiCrtZoTzAa/S2EGwYWTlfUY6FZNPv3VLMI97TTXGg383PLWH1EN6CzJXJtf1ykIHtlRkEMUXA7Mxxc09qCQe0mooF9zbTHL7H1Zm4P3OKZzZSu1c+R8aP8Wt9vaDY32G045nkUAewOAuO7tSYy1GqHrmSvMlMOntJq3hF0I6nVj9QjB2t+ENbnwpWwi6IxldVdhXjfp5Ttr9DQCGICrQuLMqfNsbS4ysF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7XcvExclRM48bmwvIC6MQ3h3tOogkY+wtbI8gqdz64=;
 b=awjwGCqHfQ+VejNFd9shgzU1Y0OU1qzK91CYe/LKzAFIJhqVBfMJ5ugk2LvVovX2CBba5wcIAK88tq93nyr86tmLDWY5+PzSME+4R6ZcNnKH7KUuLKthLr7uPoKQ9kBjLbaUUF7cBOwv8nHMepp/PF4LUZx/5nNsnT3dZiNDK351q6mfRXLTLz5H3toUYHtNSbmATIxSaYaW68RFHm/vm54NymcDCsvc0zNsM8MCF+tcLmdLeN3yH96Z8mx/6XLjv6EiXjM/AxJooxgL/7QJqBxM1ZrgGz2vgvkGYCoZIOb5lz4FxlV/ruAzEikYW/nZaBP6eJvmqu0UYm8+41+QWA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB11162.namprd02.prod.outlook.com (2603:10b6:8:2f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:51:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:51:35 +0000
Message-ID: <96c73e8c-6c13-4957-b457-852d7a22fd97@nutanix.com>
Date: Fri, 13 Feb 2026 10:51:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/43] audio: constify some add_capture() arguments
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-18-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB11162:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ea44dc-adb7-49a2-f7dc-08de6aeddb78
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3dab1FtU3B2K1k3V0tEK1BWZ01rNXdKWkFsU1VEbDVFcmtqbVFOVGlSc0VD?=
 =?utf-8?B?bjJaTTIrdVpFRU9JUWs4U2FTNTJaSTgxaHo0Sml3Zi8xam9YYWhRSm9OcHhG?=
 =?utf-8?B?NFBGdFg0Q3FyS2JxOVBJa3MxRFB3QkZmVWFaa3Y0QkJwZXVLV2lSa1JSZE4z?=
 =?utf-8?B?Y1Bvd2NzVlBzU1h4ZlowenJrZENiRFRXVlpKQnVhRlZ4cEdvelozQjlFQng0?=
 =?utf-8?B?eDc2YnYrNWJteWJxcGsySmxhcTRoMG1VZEhWSXV3YkVHYTFWMG1EQWpYU1dt?=
 =?utf-8?B?V3RiM05GRSsya2NrZTlYQ3Z4SnpQdTBTcTM0dGhOQ3dLN3RCcGwrUCsxNW1C?=
 =?utf-8?B?YnUvUEkyM0N5di9BbWZTZkRGUHpxcXp3Rm5vTmYwbWpmMytlTCtaK2MycVRn?=
 =?utf-8?B?ZklYQTA1d2xiMVRjckhBdHRCcGVxUXMvVDFVMEFtQ0JISW9jckc5d09FelBk?=
 =?utf-8?B?a2ZkbG9hcFBhNVlJSThhSjRrUGloenIrMFNrNURJQ21oK25ua1duZDNvaWRJ?=
 =?utf-8?B?NzRTYWlKY2J2clg3RW1uUlhZc1VZUDdNSzhVQ1FFQUFmMHNHNVBOZVptVjBq?=
 =?utf-8?B?cWpkOTFJTWc4cCtPMVpNcHpnMm1ONFdhSUQ5NjdsL3FoREEycVlrdmJ3NVpB?=
 =?utf-8?B?YmJYUmN6cGdJSkVKK0NqbC9wVWpwdXNCN3lCUCs1OTlQejlGYnpnUVRyTkNt?=
 =?utf-8?B?OTJjMmtUMXlwaC9Oc0ttNGFEUU9OUmozaVRoQnFneDhMWkhPam1jczB4NjBV?=
 =?utf-8?B?S0NWbmdaNi9NeEFkNkI2Tk9oTzk1djl4UEt4ejBReFVXa0xHVURHTWNUUGRm?=
 =?utf-8?B?Q1hVTG52eloyeGd1S1pXYUlST2Z4RzhHMGNHK1NXYTN5TSt6bTRnc0QySkgr?=
 =?utf-8?B?RFplL1cvMmJFc3FYMjRUY1pJelF6bVdOVzVYbTNqdDNaRnducFk1TTR3WXdo?=
 =?utf-8?B?Z25LTm41TXVjVnZ6YUNKb3dnMURjTThtQUVMU253cm9ndVU1djNpV3Q2WWxy?=
 =?utf-8?B?MGNCeUxkajZ2ZEZxVkFzSjB4aHhLQkJqbXdSc0FHRVhCVnFOU25lQnlYak9I?=
 =?utf-8?B?OTBvcWV1MmRHbHNXQmJHU1FwbU1BR1pUaVBQMit1bHk1NFZ0b0htT3FkdGpO?=
 =?utf-8?B?OFg3UXZUdHRNK2NxN0RTcUZqTENYMnJwNmZXclpEODR1ZjNSdzBXeWJ0WnlB?=
 =?utf-8?B?VzEvYklYVkh1Z0NGWlZpU3JoeWNYdEFzRXhxWEF0WFlzVmlmYml2OUpBRHRt?=
 =?utf-8?B?REMxd3dTckRNK2NRT3l4RVhKelNZS0ljcEJveWVKeFo3Nk9DUzM0Zkl3Ym9p?=
 =?utf-8?B?UDhFdFlFMHZFVUNTRW1HeWNNT2RPV1Z0eWFxWXZjUnNsa0cvUGRmcGJhQUdL?=
 =?utf-8?B?d1lOR3REUFhLS1NOSWNHc01PSlFuRlJEMUR2UVphcXhqYmZ4c2swa2haSjBY?=
 =?utf-8?B?UHBrdFowYlFwWm50ZFdsU0JldDE1N2wybWFqZG5uTmVITERxckVqQlRYUU9S?=
 =?utf-8?B?aEZIVzhZY2E3d240emRqQXZYU3p5MWxUTkVuMDAxN1NxcTNFQ1NFbjBncFFl?=
 =?utf-8?B?K2lWOEwva3p1Wk9haEcvOUdJckNSV1h4RUtVTlhzdHlISUorTy9vSTE2Y0tO?=
 =?utf-8?B?cS9nQzgreG1PK1l6andOUU1YZTM3MWpHb2s0RzY1cGFCak11Z0l1RWhYQzNr?=
 =?utf-8?B?Zkp5VHFGMGtCSDg4VVpiamF6RHczMndwVjFtMlQrVmFpczdJLzByNHFjYTJp?=
 =?utf-8?B?dE9NRytsakREZmlyRC9DS2pxRUMyWFFyNXFhYUdpWkNKUkRHR2RaR0h2MmNX?=
 =?utf-8?B?SytIeUI0aWVvZVRPUWVtNHFCcEt3NmZOYzBxMXJNUE0vQ2FKYlNXa2NhbXR0?=
 =?utf-8?B?WDIyTXZLUVBZUWFsUkw5SzVVVE5FWUR3SjUxWWpOaU5MVXM2d3dhR1AxVUZq?=
 =?utf-8?B?cjdiTHBjVU9qczd5WGQwQTRJbmlaQ01Ba3grTFphNTFBWjB5b2V2azY4ckZO?=
 =?utf-8?B?ZHNPWFc5b1JySElyL2dCc2YyVERTcjdGR2NRTGdCbVRyUDFBRzQ4SEx5Ny96?=
 =?utf-8?B?emJnVGt2Qndlb3lUa0JURGxMeUM4QkkzVUMyYjNOalZCZGZKQTA4OTVtTWJu?=
 =?utf-8?Q?SHMg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXNjcVIwSmVYQ28vU2ZDaVNjZ3pnRy9IaTdESExIYkt5Q2xoeUUwV1JLOXcz?=
 =?utf-8?B?T05jdmgxYnZTS1IyK2tEdENzcmVITW9YOE9tSXF3U2ZRZWUrT29ubHovRmpX?=
 =?utf-8?B?SUN2TDNPYktYeDQxRUxXU1ZSWEI1bHo2RXNVZSt2T1ExeTg0NTBsNGRGdWwr?=
 =?utf-8?B?Zk1oNmYvaGsvbmgrd3Q1ZkhkY1pWUk5FT0JSZ1RZUnkyMCtSQk5hYzIweWp1?=
 =?utf-8?B?WjJxbUlFUmNMclJPeFdqbVpma1JCMnNaYlVvbzhnUGk2Nnh1WkE5UGllSnNj?=
 =?utf-8?B?OGJMOWNDRDZWMzNhL0liQ1R0OENZUTVhTUppODdkY3phNFdETmRIeEFmRTNQ?=
 =?utf-8?B?RjZVYjdUV0xkUENlT0cvdkhKU0RyckRsWmczWTIyaGVUR25SRXpPbHIySVZp?=
 =?utf-8?B?Rk1KbFd4ODVLOVZsY25NR3VQZjdNSlJGWVJRUmR6dktWc05LQnRmNVIrajNP?=
 =?utf-8?B?c2dCekU1VkNEY0ZRcjFXZlpleGNNc1hPaTJSVWJXUjVtNnBZR2tuOEFKbmRE?=
 =?utf-8?B?czlZQVFqc0diUTFpWDNVSWZ2ZlI1V29xZlBMUU1hbFFQcWR2VjdPbGZmSXNj?=
 =?utf-8?B?ZVh6Q29ZVy9mODhULzFYb2NkMkVPbmp6eitYMTJvd0UxTWlDZ1JJcUZrQ1Bw?=
 =?utf-8?B?UVFXeThnV1oxMXlIR1Y0Nmx5am1od1FLdEZJcWxzZkNzUGJiTEtkaURmSDNj?=
 =?utf-8?B?WS9rajRvYU55ZHBzL291eGdwdFdRNkFCaFRyU3ZIZUJycFlwbEhUOHFWbXlx?=
 =?utf-8?B?RUZEdC9Ja25qa29qVURiWG9nWTRtWThLWVhMRlp3aDBlNXlDaGtwc3ZQSEtH?=
 =?utf-8?B?eWR4SDdsLzg4Z2NsTzNWZmhvaWNOQkpKLzg4ZkpCRFdEaWZOTGhOWjllQUE5?=
 =?utf-8?B?ZHpPSlFha2U3cm92NHNWK1pTUDlaWE9DbHFYZlF3VFRXdzZJdWZEZ3A3WFB4?=
 =?utf-8?B?QlU1NG13cGJJSUw4Q3NKTTk3VGd2ZGttQ3R6ZmxDdEF4VkNKcjE2WXBEYTc3?=
 =?utf-8?B?YWwwckJPako2SWpsWjZTUVkzMmJHUWhIbjlDeUJhQXczRWJ2b2RZaDFxLzl4?=
 =?utf-8?B?eTJTMVVDYTA3dGI5NGVsNXJRQUVXWFhKNTM3MFJJUDdEZmFUa3FIN3Y0MTc2?=
 =?utf-8?B?SmdlWmtVMi9XR2VHM0E3QlNCYXJCU2lXRGFOL2RWaVJ4VnlEdTJLa2gxV3pU?=
 =?utf-8?B?SnBjZmNadVYrd0d4NC9jbFRvZDl0SnM4SG1VKzhoL1NrWWFGY2JDblNrQnZV?=
 =?utf-8?B?Z2lZb1BSeWtnaVUrY1E4ZTNFOE5CUkplclhMTkJFRnRrQ0oya2t3cUtma0dI?=
 =?utf-8?B?Q0FPaEI5aDBwRTI3elJFcWlvZVp0Wk5yblVmZXdwQlNvQXBMNTk2TzV2cFhx?=
 =?utf-8?B?VnhNejNxT0tKa2E0RlExK2lPWlNtNGRJZEJBdmZnYzJiM2c2Z0tFSUxkQ25F?=
 =?utf-8?B?cGdRV2VUekNhaVJnaG1nOENRc0tEUXVMbjgxd2x4azlaR1h2cll6bzdPKzNS?=
 =?utf-8?B?WDJSVXZIdTZFZ2E4SFJUT2NVQTlJVFBYN1o0N0VzcEpGOUZLZ3N0R0wvL2ov?=
 =?utf-8?B?OG4xT3FHWnE0MGhKbXNBSUZvMmhkNmNKa21kV2pzRXg4TURPVUg0ZXo3bFV5?=
 =?utf-8?B?Yy9aOWUzQ295S056YW0yWTZ1S29FRFJodkFTUDR5S2xhYmExS3kxMnJxSGlL?=
 =?utf-8?B?YmIxaHlMR3lpS0xTNXEycTQ0Rys3d0dScldEN0tpSGZMcjNLVU1rdFlNWG5C?=
 =?utf-8?B?OWR6WFZOYVFqaGMrZVIyN0x1OWVDNGtuUnpyVUhvUzN1WUVROVlTMm1aMkhi?=
 =?utf-8?B?SitxNXowTDR1YmJCbGt1SWxrNHJ0Y29MbFd6UGFnaWIrWmFTTmJaUC9Bdno2?=
 =?utf-8?B?dHFVQVE2NlAyb3BNZDYvNGVyRVRWQmdHQWVjbk1GUFhxUGZ0T1JmMVNHZ2sw?=
 =?utf-8?B?ZGtHSzNHbjl3NWh5dnhwUzN5RnhQamxmZksxcSthMS9qZ1p1bklCZi9kZkhw?=
 =?utf-8?B?VUZ3TWtrUW1IeFJrT093YUpLNDRtYTFxbEFEQ1JYNmdjYUlNOTFFOFIvcUxY?=
 =?utf-8?B?M0pwNURtcWhKdllzSnBpZTFRampKaHVBMGxDemVUR3IrY2lFYXZLYitHZFcr?=
 =?utf-8?B?Q1ZjRENGTWd4MG5ZYnNURkIrUERncnVMTC9tb1hoWUtabVpyNHlzMzFvdlZY?=
 =?utf-8?B?Tlc3cVZ2bmxFUHhhK21Gc2oyL1ZPY0JjSFU2MHp6K3RoQUhBRzI3elk3c1JP?=
 =?utf-8?B?cEpYbGxNbVFQaWxRdFRaVitSYTB2TFJSdUc4M3k3NjJyTHNOTHhGcjZQMXJ1?=
 =?utf-8?B?Szk3aEg2UHI0M1AzRW9vTzUxQUVzVGU0TU9CejZDazBVVmNzaVl4TVdMbVFq?=
 =?utf-8?Q?o2Gh+GJDZzeoyUYc=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ea44dc-adb7-49a2-f7dc-08de6aeddb78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:51:35.5953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30wE1XiVQPC5Bw5Zj1WH4+OIRcxm3/0mfTgVx+bmeDbscbStS6+u4KExXdG8AO1zTCArlTgPy9MaagdffkgtLu8qhwmJjKvy959ak00D1bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11162
X-Proofpoint-ORIG-GUID: MoY3U3F7BN0j4MlFqgiI-HvkMiKE3Sao
X-Proofpoint-GUID: MoY3U3F7BN0j4MlFqgiI-HvkMiKE3Sao
X-Authority-Analysis: v=2.4 cv=PaLyRyhd c=1 sm=1 tr=0 ts=698f0238 cx=c_pps
 a=MpfTxiBaMh6MIwR6HTKnTw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=3bAgsajF-Z_X0NWY73UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4MyBTYWx0ZWRfX/iy9E8ujJDb1
 8EaVT4b9A3HTnDmtvDi+kwIvWS9M3XkqMuGLIzOY4ap88BkddfmRAd0R/eBN8+S01JaSjJc/t7T
 ojXecjV35GAmos3JKwBKKu7IDL2dtabISF4ONcHXuZCEgnKZFgysEAvaqyMU7n1D8eD2GedxMsN
 msrzY2pUwDZONb0ailaLR47nEbdSuDu6ulJJuTni8eKe5HaGXjk5rTbI+KY2KpJLAYwLVW7b1Hy
 OCUAdaFqIE+vONnLXjSJzftUfkn3bUZs3KXjGWaM5o+Bd9jQoqqoDSdF2mi2UmrnAEWydfVYoBJ
 zqByy5A2GwpLQkONtTXhv11APfSUJW+fdbU4bGHe9iSShK9VFQ3ERSmKBqJ1LmOevgIWAZQR9hy
 W2uS1y447bnzQIS+wSoa4xe6RMxbicuwNGZwNF6zGETSAJ2d8p9NDRuLngcfiGPI8p5PiGCNoKR
 i2xgS5TKYH0HRx653UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ---
>   include/qemu/audio-capture.h |  4 ++--
>   include/qemu/audio.h         |  4 ++--
>   audio/audio-be.c             |  4 ++--
>   audio/audio-mixeng-be.c      | 10 +++++-----
>   4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
> index d7998232243..f1319c90020 100644
> --- a/include/qemu/audio-capture.h
> +++ b/include/qemu/audio-capture.h
> @@ -21,8 +21,8 @@ typedef struct CaptureState {
>   
>   CaptureVoiceOut *audio_be_add_capture(
>       AudioBackend *be,
> -    struct audsettings *as,
> -    struct audio_capture_ops *ops,
> +    const struct audsettings *as,
> +    const struct audio_capture_ops *ops,
>       void *opaque);
>   
>   void audio_be_del_capture(
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index dfe247ab8c4..b6b6ee9b560 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -96,8 +96,8 @@ typedef struct AudioBackendClass {
>       size_t (*read)(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size);
>       int (*get_buffer_size_out)(AudioBackend *be, SWVoiceOut *sw);
>       CaptureVoiceOut *(*add_capture)(AudioBackend *be,
> -                                    struct audsettings *as,
> -                                    struct audio_capture_ops *ops,
> +                                    const struct audsettings *as,
> +                                    const struct audio_capture_ops *ops,
>                                       void *cb_opaque);
>       void (*del_capture)(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque);
>   
> diff --git a/audio/audio-be.c b/audio/audio-be.c
> index 3150a57dc8a..725c860a194 100644
> --- a/audio/audio-be.c
> +++ b/audio/audio-be.c
> @@ -182,8 +182,8 @@ void audio_be_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
>   
>   CaptureVoiceOut *audio_be_add_capture(
>       AudioBackend *be,
> -    struct audsettings *as,
> -    struct audio_capture_ops *ops,
> +    const struct audsettings *as,
> +    const struct audio_capture_ops *ops,
>       void *cb_opaque)
>   {
>       AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 8f06afba821..a0e542754e5 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -314,7 +314,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
>    * Capture
>    */
>   static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioMixengBackend *s,
> -                                                        struct audsettings *as)
> +                                                        const struct audsettings *as)
>   {
>       CaptureVoiceOut *cap;
>   
> @@ -1585,8 +1585,8 @@ static const char *audio_mixeng_backend_get_id(AudioBackend *be)
>   
>   static CaptureVoiceOut *audio_mixeng_backend_add_capture(
>       AudioBackend *be,
> -    struct audsettings *as,
> -    struct audio_capture_ops *ops,
> +    const struct audsettings *as,
> +    const struct audio_capture_ops *ops,
>       void *cb_opaque);
>   
>   static void audio_mixeng_backend_del_capture(
> @@ -1710,8 +1710,8 @@ static const VMStateDescription vmstate_audio = {
>   
>   static CaptureVoiceOut *audio_mixeng_backend_add_capture(
>       AudioBackend *be,
> -    struct audsettings *as,
> -    struct audio_capture_ops *ops,
> +    const struct audsettings *as,
> +    const struct audio_capture_ops *ops,
>       void *cb_opaque)
>   {
>       AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


