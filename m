Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3809DCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 15:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2AHj-0008Pk-R6; Fri, 26 Sep 2025 11:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v2AHd-0008N7-Mb
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:22:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v2AHX-0006T5-2J
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:22:53 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58Q86BIC1591828; Fri, 26 Sep 2025 08:22:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vKoI9++jsyO8PMQtQbaTTeNh4fgTtP3bsPWmLX03f
 cs=; b=v+L0hXOe3UIGqvTQ1v02P+5a7o6l8Bx3asBocrRD5TMrKpN+s+hDmLQSv
 cguiRjCzasw4MprLdraapmvAdhMi6wTH3L70evo5lZAwliV4SDGwPsZsg84fzuOm
 uT9buonUAje4EuHy/YkgpRs5bRf018N+YDuvOMdBgNQ4PP4Gw1gbV+xW8O07KLhA
 5GTx2+eU5rT3xETlLcSJ6Fpkm2P7M67PfMI1LGoI0ydGuZOS4N1SNMw3yqOSJKkM
 jDagO3IP1CfIqVYDCh7N1NSpmrtHyj6GfZRWBK3aUHgjU2qqpedL+jo2E+kzR9uE
 BZ3MhExLPlQQUoIW4FLCNz9KQCvEA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022126.outbound.protection.outlook.com [52.101.53.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49dbrejb0w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 26 Sep 2025 08:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLKwMzpw/xny/eOUPFznqL6LHu5ZugS191S6njDP3yt7yitYSX9C7zAgFB6EZoK0W1KHNxEg/wHXJoT3KYfFxYfh3MoOusN+Os/1UUUUm44O3+ajVs/9vHPk3Xo0ZqYeBef/j7IeOKSGojAGLHDs2ZEux8e3Q1jyz+vm7AurfC2t2+++8BnssydtkRZdmLxdlm49o5hO/BijNeYfkl/YlkBeDXRQFsRITc8ZwLPZ5oKPYnMTLvy7PAJOV/zbUn9vdEOfp0stndlnaLQPTbxzfiY3SEtoH8YC1XMTIcSdEkFXI4OmohFz9YkJMmbaFnipEvH1RZ3TCgb38Udme2Ze3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKoI9++jsyO8PMQtQbaTTeNh4fgTtP3bsPWmLX03fcs=;
 b=nnr/Pe9FS1k0MoDugnpscvSEVD+9GOgoVZ31M/JN9jLXv+P02wYMLjvm2mqckXyhW7/ci7cnCRiD1qeILSId+GsVJTq8u+rcQdvK4/i7HIHINsJ70e6IiOeEuIqYpo9UQzzAUlYPcm3sfDZ6aefjh/zNH/67yoOQXRrnbWFW2QxqO+fgwUvPUc+j1hMmphauL9LdEobZHul0FhOIsUf7ayvUCpfoRbtDB99iV8i67JX0huH/sVP0JBJSKE+D9hhqSmzAJBCz/FB9t6OYjoqWSk2dmTQJt29pkQMzIvU4jFIsGWSMmhE5AGksEcfXFV7IG4Jmxe7r2rgAs/EaEbjX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKoI9++jsyO8PMQtQbaTTeNh4fgTtP3bsPWmLX03fcs=;
 b=fc2m5Su1+d6sE98ExrHVBAU+I162KXcqdOQBWY0lI++FZBSZ5FYCuZMGuBzlJCn9poDy4dNTkBVd9vqKm1y8RpPygo3zHzBccEPyt/EsogokIAXnzSUzVQcRtUJ8E5J3Z3nMuMKu6GWGI7UPSS4EqoPMZXOO9P/dre6ixbZkXnC2kMIMG+i19n2JqZnNnNQmPfH5N6x/GaDOYKp9nMNtSNIn3UOLfvlK1VhInTTSWU/fO2O4Ec+CxkGoWCML+lpzTkB9IV1VktAvtbGwsG7hApizBlaM7K9AN7uAze231FyBIuy+pJ9ZMIQ7uKFzxH5pn99I4mSp7t2bkO9v/aSmVA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9226.namprd02.prod.outlook.com (2603:10b6:930:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 15:22:36 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 15:22:36 +0000
Message-ID: <063bdc3f-7767-40b6-b5d4-bb806f692d10@nutanix.com>
Date: Fri, 26 Sep 2025 16:22:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/i386/isapc.c: remove support for -cpu host and
 -cpu max
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, imammedo@redhat.com,
 philmd@linaro.org, jdenemar@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20250925160453.2025885-2-mark.caveayland@nutanix.com>
 <87wm5lo37q.fsf@pond.sub.org> <aNaJl3J5dZEt6n4_@redhat.com>
 <70ff12c0-9ed7-4c19-a7cb-d14a5176d3f7@nutanix.com>
 <aNabaxWyioLXgfFH@redhat.com>
 <0c125c3e-001c-40fc-b2d9-7ef3c1d0451d@nutanix.com>
 <aNatTdDfJw4FL4Is@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aNatTdDfJw4FL4Is@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:208:1::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb874b1-b5b1-41fc-30bf-08ddfd1085c6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU9RcGswaWp2M3RFRXpsSXBuTkFtcFhzTmNLVlJyeDAvcmRGQ1c5VmNRaVUr?=
 =?utf-8?B?Q0h3aEY3UmFYb3Q5clZCZ250N0d1bFVGQjFMN1NjVDZwa3Vsd055cEdneUJO?=
 =?utf-8?B?TDFibkR4OXkrUDZSY2NwL2kzQ0RZK2hnOWhMREdyeHo4d3NGdmlBWjRaUlB6?=
 =?utf-8?B?ejZSdVRpei90TXNUMWxmMUhvOG83MmNMOXV1b2d1dS8vQ0x2amRsRFBKUUha?=
 =?utf-8?B?d2h6Y1NpSGk0QWpmWGE0NzZyRmYwSGxDelRFZHpwRTdBMitMWVFNeFdvd3Iz?=
 =?utf-8?B?QWJJaU9mR0NMc3RuMDZUaEVKUkRqWnpwMWE4dllLclM4VXg4S1YvekQ4WXla?=
 =?utf-8?B?WjNMem1UOTJhRlhrZWUya0JEOUlBMVlpZG9xQ2lCZnhzZUN2WHRuUGFGQXBv?=
 =?utf-8?B?Tzk1aWE1RGVQZTJ2bnkxZTJIKzNUc2VEYUJyQTMzY3JMdjE3ZkVpRjdxR2JN?=
 =?utf-8?B?T2pmVjBHSG1ESTI4blBGT1c2QWd4ckpaaFoyYVdpNWxWTFRNOWJSNXVpWmly?=
 =?utf-8?B?RGVBWlc3YzFZcytPQVlMWnV3Y3ZyS2NiN3FXNDVPT015ZjBQL0pMZ1YrdHNH?=
 =?utf-8?B?Skx4cE9tZGpqRWlUYnoxRGhpeVpWenloRmh4TXhWZEpDRDQweHNZNndsd2Nx?=
 =?utf-8?B?dkgyWjZreW5NZ1p2WCtjTjE5bFhwL1BXZHlNWklkZm1WNERQRUVUTzBzOWox?=
 =?utf-8?B?WmtlN0ZwZkxrb0dxQjk4OUVTN01vZU5FZlNpYXl0VnJPU3hOcEJkWVpqTjJF?=
 =?utf-8?B?RXppZHo5YVNkKzNtejRTdzk5OEtQYXdXb0xHVzk5bEk3ZjI5Z3BvL2V0TXFy?=
 =?utf-8?B?Sll4U21OeE1pb1Bvck1JN2pRSU1pcExpMnZ6MjJPb3RaSHdNeVBhL0VTOVJE?=
 =?utf-8?B?WkJWK3dQbFhReUVyZUV6eGJaOVRTSGhvSjNrY2c4WndoQlF6azI5RTdmN0x5?=
 =?utf-8?B?ZjFIL0NTbVhMc1lSM0liK25FUm1YTERHMXVqSFFWaWk2L1dpcmNITCt3d25Q?=
 =?utf-8?B?ZDAwNnU4U25EU0k3YXFNZEFwclY0RWFuNktlUjFReVhFa3JFMks1d0cwSEVL?=
 =?utf-8?B?cjhyelBxK3ViVGtZTzN0b3loME9qc3hENnFzSWpPUkFPWGtpMThkWDk3Mi9B?=
 =?utf-8?B?N0Y5M3gvbWpFMEFvY3d0SmlmS3FadGpyYlFNR3lmLyticnJOWDZGejNpU1FG?=
 =?utf-8?B?N1hwUEtucVdiSnB1WnpqWnZkc21LOWlHQ0Y3dnRhMEd1bzVzNXB0aU9ZOG9k?=
 =?utf-8?B?enlHczZuNmtoRnhIZzI2NG8wZTZYSk5TWmdxemMwRCtHZDVyczEvcVFQdVBD?=
 =?utf-8?B?Wlc4Q1ZWV1Q5MldIenJYZjdTdXpXVzlBMWNCVXIzeVJwS1lrZEdxT0RJVW9l?=
 =?utf-8?B?bXI1WjgwRmk1UmdkbHgvOFZkcnVWOFd3elNvT2YySEJNNGFQS0NycEl1UzRL?=
 =?utf-8?B?dGF3Zkc0S2MxZzExT3k2ZzNTQVBMTERPSGprVW1aVVNDM0FDZTRqbVJnaTNm?=
 =?utf-8?B?b3M5Qzl5NGh5QWtSOGQzWW5XRkNXQVhudlZoYnJ3blA1VnJxd25VaXdLUldH?=
 =?utf-8?B?MTdUV1g3azJiL0FpRnByWUVseTVUR3I0ZjR2blhiQmNXNUdBQzZNaVRvWlRy?=
 =?utf-8?B?aURwS01TekloNHpkamFKNlZHaFBMbUpQOENTWVI5Ni91ekltakYrUmZkRi9o?=
 =?utf-8?B?VjJ3NHpqNnVDQTZHM0NKKzNDcktHa1RDandqSkNUUVRxejcyNjg1ZStGaXVW?=
 =?utf-8?B?MmFyYUZQZnRMYmdIakxLRmFVbTRaMGdWaDRBV09iVU9kbTlMNG5pcnBVYU4v?=
 =?utf-8?B?MnUzOG5UTlJoUG1uRHlHOWpocERIZkMyN210UitsMFg2Z3F4eWhibzBTd2FU?=
 =?utf-8?B?VlZRak9YcHp5Zm9zZUorSWtQWFIrMDdHTjQrYnZaMDBQRXppeHA3NWx0dkxx?=
 =?utf-8?Q?KCyuYqqYlvwTizuft0DQsGFb0hYUcOpr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2tCMmo2a2V4QzdlNnQ2MUowZ1haYi9MQmhMenZFSENZclVhUW82VVhpL05u?=
 =?utf-8?B?aEpVdEFONzR5VlZ6RWFXN2RxTW1ERUVRZ0xTNVRIck50WlppWXc5SmF3ZERp?=
 =?utf-8?B?ZEhQMVlzUkx1MlhTZjYvYSsxdUE0RkRDRVo5VzJxU0V1cWNmeGZHZENucVRR?=
 =?utf-8?B?K29HbW5WZFpISkVBcHVMWDlzUXpsU2duVEEySjhqbm5GMzFxWmtsN3ZWMGlw?=
 =?utf-8?B?V1ZCK0FQZ1NkMFpMbjRUcHIzTFpMeVhHNkp1WVVBdXM5QUhqSzRZdG8xdFNr?=
 =?utf-8?B?SlVvTjZXbFoxRHQzdWlXRDRjSTEyYkJwOFd0SXdTTExFcmgwZzkwN0VTNDgz?=
 =?utf-8?B?UUFsOEFjVmgwcmkwdVk3cVAwY0RCQzVWMUJtazBhUU9VRmhveE9QRTNhZURF?=
 =?utf-8?B?UXd1UFVpajRXZjdIUFhQQmxIOVY3cjhlandvNzNhRTdFbUJLbmdabkNVcVRj?=
 =?utf-8?B?cUhtbkx1OG1BRVFiSzI5SGRIKzhxRDdQeEE2bi9uUU8zOXhwVVg4WVNQRHBF?=
 =?utf-8?B?ZjFLOEwrZUpubStWUmlYaVI4a2lKdDJ1QnpGL0tIeWlldTkvbmhIcTIxS2JZ?=
 =?utf-8?B?cGtFa1c4S1IrWXZkd3RselNxZWpibW5KM1NTUytUV01ESjQ0c1NaQTltbVBj?=
 =?utf-8?B?ZkVJc1o0cnlDMWtLRVltdWVmeFlLdDV2cnJEK1dDbEIwYW9WbGJhbTlaaGp0?=
 =?utf-8?B?anBGWjNBZ0NhTFlWaW04UTNDRHZOR2RSUW95bWNZUWxjcDdTNGJYR2JTVlJN?=
 =?utf-8?B?V2MvcXRxbHRwNVNweGdQZVFqYk4wdVk5MS9JTzlSbUsxU1llWFR4RTNGbUxv?=
 =?utf-8?B?QndleUhWcjdjdmQ0Y2h1TlpSQmQwWDJscndNcWgvOWIwUTlIeFZnbWtwWSth?=
 =?utf-8?B?SlBFT2NBRjc4cGFtUWxGZXNKb2x4dDRsd1dQRkxFazZKNVpMUGVTUGorVGFx?=
 =?utf-8?B?Zk9MZ0VFdXFmc0hKNXJNVGZZblBTMmhUb1RDN3JBSmZxZzRNQW1tWlhXbkcw?=
 =?utf-8?B?c0lHNklrODdoR2lic2pMUkcvMWU0cW50YXRaVHFBRWtWLzRnZnpaZ2tPVDZs?=
 =?utf-8?B?T2JYRjduaXhJQXZmY011MFhaV2FXeTYwZHRNQ3VTWEhLeHg5dHJTdTh5K2Uw?=
 =?utf-8?B?UFU0N1hEVkhJMW1zL1QvdTF0QUxhNXZ2bmVaWmlwRkptKzZQN0ZxVDloRjlP?=
 =?utf-8?B?QVg2R1JqckEzMkQzanhEL0ZYeUhoSzRxaHFLUWxkdkRZT3pTZisvMjhBR2ha?=
 =?utf-8?B?Sk1WRGd6Uzh1ZFJaZzQ3SjBaVm1tSTRSSFdOQ2J1N1lsTFhJUk1STFhZa3lO?=
 =?utf-8?B?OEZFVUQ2aWcwdWhRNWlRTENOcFlUcHpuc3lLemxlMHlvaWVsQUxHalZnUDlu?=
 =?utf-8?B?anErdkpOWUhJZ1I0bmFvL1k3cG1rQisxejIwTDFXalFOd1V2RFNaY2FLaWg1?=
 =?utf-8?B?dms4QmErZENKbXZ0OUNBRFNGWEU1YnBwa1d1VWx3VzNxVm9EbDhZTy9ZV3pa?=
 =?utf-8?B?Q3FoQUFCRW01N0d6ZE8vU0hCbE9hV1Z3Y1VwRUxKcmpFdHJkZE45R09SQWpy?=
 =?utf-8?B?Q2ZUU0QvNGZiWWk4OXpWZVVxWHlyYkJSRXJJRHJ5dC9nb3JtdUNWQTR6RjB1?=
 =?utf-8?B?dU4xTVROQ0gvajk1cWpYM0JUbDBlbDlIWXdaYnRSK1U1MDcxNi9PZDBjc0FV?=
 =?utf-8?B?K0U3UEtFRHNIaFhvUStJQmxKTHdBYm9UaCtTeTNJMTJVaDAvL0tUNTVESFdG?=
 =?utf-8?B?dzhsWmkyNDVCM0EvakxQa25mR0xQa1Ewd0RWaXNhb3crd3JEeHFUYy94R2Fh?=
 =?utf-8?B?cGFUN2p4cjNURGtTQ1Q1RGZEWUhacU14NVRESzVTS1B1alB4MHdaNzNBcWJi?=
 =?utf-8?B?Mi94NFVQeWovZzhNREcvdzE2RmJXeEVMbGJ3SWtocUQ4NnUrZ012K2ttM2N1?=
 =?utf-8?B?WWtNSFR1VldNWFpZVnovTGpCZlBlZU5KRzZUeWFoRW84MkJCdXBBWXRFMy92?=
 =?utf-8?B?UGxVdm5Hb0NCT1R3QVk0bnhHb2Jjd2NKdWtjOTlRUUlTVCtiS3YySWZtaXhQ?=
 =?utf-8?B?ZUZWeGxjQ2w5SVBCTHNOQlIwUkE0TEIyUnlhNS9aSnBqYkhxVDhOSS9Yd1kv?=
 =?utf-8?B?cUhtSkgzNkFiQTUyV3V2a3d3Ykd2ZkFnN3prajdSMUQ1SXBXNGE1YjMzS0JS?=
 =?utf-8?B?SjRpOXBJV08ydmdHTHNmUzFneEhaTUFFaVdiNi9ObGJNeW5hMDVSOWNvRUMr?=
 =?utf-8?B?RDU0djVWRExtNEpkWTV5TTZjUHZ3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb874b1-b5b1-41fc-30bf-08ddfd1085c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:22:36.3254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzclOYzj8QckaRYhbLjNJ5mrpA0JC0/WzwiDuuee6BcWoTPYja4qNocQAl5llj1oh7JjBPXIWAnixWaMfZ/ctGLlY+M5dbAaS47fpN/L0QM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9226
X-Proofpoint-ORIG-GUID: vf840RJJGWDg8NFZX2RMW2N4OuG2ft44
X-Proofpoint-GUID: vf840RJJGWDg8NFZX2RMW2N4OuG2ft44
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDE0MSBTYWx0ZWRfXzGqxyvoOwKm9
 jBmjLR4j0ppZVhVWZpjgjmzggpUQlnhOfSHOriFE81A3eGkvWDMFqTy6KwFoYpbqfq4bVCtvAMa
 iFsYbmOc8pIKjXfJqzn0LS4FTO/zZGbhF2jkbFgmSWj/Xbf4QgVWQZiYEPswKVtYc2U7Lp3f1ij
 CqJUvqDnsHojadKAZ4G6A8wtWANnwk67Uk6/t23jUSRLMEwP/cOrrqylk0qd34ToaL/hUrQ2WlK
 fZibDQjA0NkPUmfnDWMjEBap9Xo+zCzy6qNKiwtQTKVuCbRdaRZEplH7wybUKLDRS9qHEZAdDAi
 CZSZez4GtpECHtziUdPj0v9+DXLJ6uu56ULFhAkyLuKDGf5AD8bOrVFDfQwxK2p9zr+9wH434nA
 QLT460iVbNAoEsRjaDWC74H8tTB3LQ==
X-Authority-Analysis: v=2.4 cv=ZIbaWH7b c=1 sm=1 tr=0 ts=68d6afbe cx=c_pps
 a=JYnLkSCsv6yBtrJOttUiwg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=I92PUnxBS0ylmlG6VmoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_05,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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

On 26/09/2025 16:12, Daniel P. Berrangé wrote:

> On Fri, Sep 26, 2025 at 04:01:23PM +0100, Mark Cave-Ayland wrote:
>> On 26/09/2025 14:55, Daniel P. Berrangé wrote:
>>
>>> On Fri, Sep 26, 2025 at 02:49:00PM +0100, Mark Cave-Ayland wrote:
>>>> On 26/09/2025 13:39, Daniel P. Berrangé wrote:
>>>>
>>>>> On Fri, Sep 26, 2025 at 01:36:25PM +0200, Markus Armbruster wrote:
>>>>>> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
>>>>>>
>>>>>>> Following recent discussions on the mailing list, it has been decided
>>>>>>> that instead of mapping -cpu host and -cpu max to a suitable 32-bit x86 CPU,
>>>>>>> it is preferable to disallow them and use the existing valid_cpu_types
>>>>>>> validation logic so that an error is returned to the user instead.
>>>>>>>
>>>>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>>>>> ---
>>>>>>>     hw/i386/isapc.c | 27 ---------------------------
>>>>>>>     1 file changed, 27 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
>>>>>>> index 44f4a44672..6c35a397df 100644
>>>>>>> --- a/hw/i386/isapc.c
>>>>>>> +++ b/hw/i386/isapc.c
>>>>>>> @@ -41,31 +41,6 @@ static void pc_init_isa(MachineState *machine)
>>>>>>>         DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>>>>>>>         int i;
>>>>>>> -    /*
>>>>>>> -     * There is a small chance that someone unintentionally passes "-cpu max"
>>>>>>> -     * for the isapc machine, which will provide a much more modern 32-bit
>>>>>>> -     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
>>>>>>> -     * been specified, choose the "best" 32-bit cpu possible which we consider
>>>>>>> -     * be the pentium3 (deliberately choosing an Intel CPU given that the
>>>>>>> -     * default 486 CPU for the isapc machine is also an Intel CPU).
>>>>>>> -     */
>>>>>>> -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>>>>>>> -        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>>>>>> -        warn_report("-cpu max is invalid for isapc machine, using pentium3");
>>>>>>> -    }
>>>>>>> -
>>>>>>> -    /*
>>>>>>> -     * Similarly if someone unintentionally passes "-cpu host" for the isapc
>>>>>>> -     * machine then display a warning and also switch to the "best" 32-bit
>>>>>>> -     * cpu possible which we consider to be the pentium3. This is because any
>>>>>>> -     * host CPU will already be modern than this, but it also ensures any
>>>>>>> -     * newer CPU flags/features are filtered out for older guests.
>>>>>>> -     */
>>>>>>> -    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
>>>>>>> -        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>>>>>> -        warn_report("-cpu host is invalid for isapc machine, using pentium3");
>>>>>>> -    }
>>>>>>> -
>>>>>>>         if (machine->ram_size > 3.5 * GiB) {
>>>>>>>             error_report("Too much memory for this machine: %" PRId64 " MiB, "
>>>>>>>                          "maximum 3584 MiB", machine->ram_size / MiB);
>>>>>>> @@ -162,8 +137,6 @@ static void isapc_machine_options(MachineClass *m)
>>>>>>>             X86_CPU_TYPE_NAME("pentium2"),
>>>>>>>             X86_CPU_TYPE_NAME("pentium3"),
>>>>>>>             X86_CPU_TYPE_NAME("qemu32"),
>>>>>>> -        X86_CPU_TYPE_NAME("max"),
>>>>>>> -        X86_CPU_TYPE_NAME("host"),
>>>>>>>             NULL
>>>>>>>         };
>>>>>>>         PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>>>>>>
>>>>>> This reverts the "smart" part of recent
>>>>>>
>>>>>> commit e1e2909f8e74051a34a044940f90d4650b6e784a
>>>>>> Author: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>>>> Date:   Thu Aug 28 12:09:44 2025 +0100
>>>>>>
>>>>>>        hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
>>>>>>        The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
>>>>>>        possible to specify any CPU via -cpu on the command line, it makes no
>>>>>>        sense to allow modern 64-bit CPUs to be used.
>>>>>>        Restrict the isapc machine to the available 32-bit CPUs, taking care to
>>>>>>        handle the case where if a user inadvertently uses either -cpu max or
>>>>>>        -cpu host then the "best" 32-bit CPU is used (in this case the pentium3).
>>>>>
>>>>> What is written here made sense from the POV of use of isapc with
>>>>> qemu-system-x86_64, but in qemu-system-i686, both 'max' and 'host'
>>>>> where already 32-bit CPUs IIUC. Both this original patch and
>>>>> the new patch block them from being used in qemu-system-i686
>>>>> which feels wrong given the justification above.
>>>>
>>>> I tried stepping through with -cpu host/-cpu max on qemu-system-i386 and
>>>> it's a bit confusing: I think we end up with some kind of custom AMD vendor
>>>> CPU but with LM disabled. I can't easily see a way to understand what
>>>> features are currently enabled?
>>>>
>>>> I must admit I'm struggling to see the usefulness of -cpu host/-cpu max for
>>>> isapc given that older OSs can be quite picky when it comes to hardware.
>>>
>>> But x86 CPU vendors go to ridiculous levels of complexity to retain
>>> historical back compat over many decades. If anything, I'd be surprised
>>> about the opposite - an OS that didn't work with -cpu max.
>>
>> It's not the CPU vendor I'd be worried about, but the OS vendor who may for
>> example execute CPUID and become confused if it returns an AMD vendor ID
>> instead of an Intel vendor ID.
> 
> IIRC/IIUC, AMD sold i486 CPUs with CPUID present in the ISA era, so I
> would have thought anything checking vendor ID should expect to see
> more than just Intel ?

Unfortunately I don't remember the specifics, but I have a vague memory 
that someone has mentioned this to me in the past.
>> What do you think is the best way forward? I'm still not convinced of the
>> utility of -cpu host/-cpu max for isapc, so what if instead of mapping them
>> to the pentium3 CPU we follow the standard deprecation path and emit a
>> warning on startup, and then remove them from valid_cpu_types in 2 releases
>> time? The advantage to this approach is that if people are actually using
>> -cpu host/-cpu max with the isapc machine then they would at least file an
>> issue in Gitlab and make us aware of it.
> 
> If we want to deprecate it the formal route, that's fine.

Works for me. Igor, any objections?


ATB,

Mark.


