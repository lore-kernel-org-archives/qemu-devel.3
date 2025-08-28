Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAEACA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXK-00080B-BL; Thu, 28 Aug 2025 07:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXD-0007vS-U8
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:16 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXB-0004yF-Bx
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:15 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S7hYMq2893263; Thu, 28 Aug 2025 04:11:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=mr7Iq0xJ/ie6H
 +UuxcfEgDiAkj/8SViFk4xdUPhVNoQ=; b=F2c6hbKAG+cHiXhxyQsodBWsxD7CT
 UMlHtrD3CqxXHWzJMHmF5WvMQx7Phum0RD6G1UBrBlu85rE7KoazHf2cxqipdNoP
 +uT4IUJBFbZKxuOk53uEK3tlimKJy4BPwnL4DkQOdWU42tki8Z3A5JEiy6dQIpsR
 eDpagH9aLgWH21l3bMWwxzjGe/kAwKXtHHGB4Jin/AIahaWUtxCxlpU28igWTw3T
 J2zyCr5JBc2bIoWFOjtrLgDcShj/aLxCopJubOyoaPjsaWYzAn+vtbRN/Dr/LTtb
 K/gZerPcPslaCZtDZLFsjUHERWHFVhMXgn4sk65Qj43LgRf8HniUM5GlA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2108.outbound.protection.outlook.com [40.107.93.108])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48t7sy1pfh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQ8ZVgv2uYciMO7K6Clkru7NA+rKUGTS5lc9Oy2zKrQPMWv3BGorTaOn9Zdh8c1XN7hlKth32l5Jw6nRKr4ym+fS+FnfmdhEGK44yYZCxmTxmWk0JnlbkgOerDHEYxS7QQ4l1ZTq6raig6rWaEGCb2gv3HGzV8bpsybgNXcja8nEDbYmGUQrPHNZItSImlJPA9n3uERKIQvCzy5m31ydhmLnqimblah0bXxnlRjxC/5qAmu+c6Gi9J3LLbtSkRpUYkVqD6Hw4jzXrc7w1bfOM/FhSFiasy3QIZsskut9+tHKKfhJeAjcHOq7LlvUE+kYXTjQQkJb+12Yp5PIRZSl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr7Iq0xJ/ie6H+UuxcfEgDiAkj/8SViFk4xdUPhVNoQ=;
 b=G362GZ1VtsNAPbUF2gVGe1EwrI9Gz6Fy+AQtJ7i8v5fkiqANzWbw54SoD3BltxgBoPn8wFvmWJErXQ4eCkPe5rZ7HEPGOz8GVuprbNriwLFMWKRHUfvKu1H8Ws7XVWEhW9vmrnvBTRDJc+cx+22/Z2GKRyt5q/zFD7238qZYVWlirZzrmSDDZi2Gd7SxoR53xaUrXup9uz6zzNbwKUBh9IuZtWTAzDxbWpUbu1vpcj6L/GU6ML7Lerw5sb24BjRhaskMqKU8y0FCQPAsSChBEldoGXhFLiOtiZD7W5mcGtfXoXvRY+EnvpQOn+Zq2nEJAVf6lObhkKumaTSRy/6KbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr7Iq0xJ/ie6H+UuxcfEgDiAkj/8SViFk4xdUPhVNoQ=;
 b=Gmw0zv+emPLxs7cDrCFQQfOhEFVGXiQNUyGx+WwVFNMMPJJGMpcdgVchkeoKXQcseMsPtzDgF0PGayzSzCBfYD/J2Q4QpivFPaDqdGJKFpd5/zy6ekuCxMEmTqbYBYAEMEiPNIk+JGBJGvbdkqu96fGXPBTaLsCmPXmGvY4KOU4XhPXZxrPI6YeZ6arqmaHcCnJMknIe71fE3KOPmgkDJAFo4zk+s0C35EWaRASGa6YXpWn1sZSuv4Lld3cG8GG3H29jhfwDuVTpoYOQmOiBLjB62OzHEOJF+z43mhA1pDAOphkv6GkH5YlEpoS+cUKnP2ExHrjBjG+19aQx5FII2w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8891.namprd02.prod.outlook.com (2603:10b6:208:3b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 11:10:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:10:59 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 00/19] hw/i386: separate isapc out from pc_piix
Date: Thu, 28 Aug 2025 12:09:43 +0100
Message-ID: <20250828111057.468712-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:208:1::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fd3426-9a42-4371-c3d8-08dde623917f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bytWbGVQcTBHbzZzYkhVcUp2WGlTUHcwWGFHSmZwMGh0SGtCV3pVb3dTY3Ir?=
 =?utf-8?B?TXhTMXBSRkVrVjZSMWtELzU2clBVOFZWd3c4bmRHTHpQcW05WklxUDN6M3Bz?=
 =?utf-8?B?cGNuOU1jR2RFM2pTcmh3NEx5Z2FKMHRwL0xXbmF4YUR0YkQxQ2FUVTN3aWxE?=
 =?utf-8?B?WWhDU0xlSXBLc0FsY2hGYUxUaVErYTJyaDU1RUtPTUZiWmdvNFFuNzN2TWpO?=
 =?utf-8?B?d2NWYnVMd2tndGQ4Ung4S3hFZWNmY2wzSmRoTklKVkduZDFxeDdKcnNya0lw?=
 =?utf-8?B?US9mM3dnUnI1UkZnNmRndWFObUpPY3FZVCtaZXJleWNCOEM4R3ExT3VHQncv?=
 =?utf-8?B?OGYxc0g4VGphbkIvUlFnUUNjc25UbjQzU29tUVZZM09VMlFLUVFhenh0S1Az?=
 =?utf-8?B?dmo2eFM4WEVJMlQ1NXRyRkxRTnFvRElrMWxFRkZONkFuSHpFcmRYcGRVRXFE?=
 =?utf-8?B?OGkxWjRER3AwckF4MElBYzZIeHVTL1VCQ0ZLdGdlVzRZdTNEY3RKZXkrQ0Zs?=
 =?utf-8?B?eE9JejZFZ0Jkamo1dmFwMkh4R01MZlNCNUNHRnNzM0dRdUJYZkQrNTZ4ejRq?=
 =?utf-8?B?REZGeGJsVlNzTWFaVWRkajZIS1Z4dUw5L0VnbmF1Y0MrWUpPQ01lM1dBN2hN?=
 =?utf-8?B?QyswWmN2UG5OcHZUd05jM0tvRllsVTRCVzdDaWtZbHduVDUxT21XV0RvRUxK?=
 =?utf-8?B?OHdHSkhPMSthYThDR2ZNWXR1RHZmdFlrVlBrWjAzdFdhZVo2bXpnWVBRNEpQ?=
 =?utf-8?B?OG5aWWp6ZlJVNTRVYWRSQldEY1B4cTBxY2Zjd1VobW8rSElxd1J6UWxDcG1l?=
 =?utf-8?B?YXpNU0RIenpLa0w0UERSRXVjOUZNSGtyeEt5YktQNjFpdGhWMlpoN0Vzdlk3?=
 =?utf-8?B?UitPTThQVmpGc0IxQ3lIMXJDRmJnRDk2TzZDZmZFYUZxaDRvcWQxb0tmMUpa?=
 =?utf-8?B?MnJDOG14L3FEbThwMEdCT0FuZ0hTU3hFeFpFOGF0NjRObkQxMW5rTVU1anh6?=
 =?utf-8?B?b3VIWFpoOS9ZM2pQUk5GU0p0VkxuL1pEdXNUbEZwK09RNU42U3dHVGxzM3hG?=
 =?utf-8?B?OUFrYmpXQm5sWGF6eHVLTVZ0N0pBaFdBQ2c0WWpiS0lnVzViQzNTV0ZvUVhv?=
 =?utf-8?B?SkRMRUtYYUxjWm5HMDRTVEEvODFmSm4vd1VLckVFaXhBaU1hUUFpeUUyWUti?=
 =?utf-8?B?akltbGxOQ2RGcDJaZjV2Ymx4elVtY0syMnI4bTdyUGxyK00zcHlTdG5GUzJo?=
 =?utf-8?B?dHk5SVBReGZnUGIzcDVkdmluSU5IY29hRGNnQ2N1WHBBS0tmOG40eGpWcU9D?=
 =?utf-8?B?blUvNld6TnUyMjRmQUR2dE9lbDAzOUpnMkk5dG16Vnl2aHpYL3grbmZzNjZ6?=
 =?utf-8?B?ZTMzTVVld3krYUd0MXNMdm1BQTZPQ1g5TnZ1QmIrNVJkaWlEU3NmaEt1bERs?=
 =?utf-8?B?ejJyWlN6dmNHbko2OFBnS2JINmd2RkQvcURla3VWcnVvQ05LN0lkaGNNNFdl?=
 =?utf-8?B?V2t4RTM1Zk9ralAzKy91c0lKODhhemtoR0hndU9wS0hNTWQrQXc0b3BubkMw?=
 =?utf-8?B?bXByOVhyVWVSek5ncGZscjNZUExFUFUxeFFBeGMrNUFFWk01QWZyZWIxMGhP?=
 =?utf-8?B?UmFNYzUrRmRpT2JSd0V6SzRUMmI1anNZRmpBcDhKcVJRUUM2WFQ5STQzQmdy?=
 =?utf-8?B?NjN4Tk41WFBoM0NMdmFxdmNRM00vWWNhd1N1QXI2NFVmeTNRdklkVWJWN2Jv?=
 =?utf-8?B?MDloMDFQUG93dnBjbkRkc0dPVGtJa1dNQkZmcWlxZDBiREtxeUlCc056dEVX?=
 =?utf-8?B?L3hZeFZLaXRrcDlKNnNYbG5KVnhSUlF4ajM3bnJtNWFZb2Fwam10SGJjMytG?=
 =?utf-8?B?WVZMRzUwMUFyb2VENkZpZWhPV2YwWmcyZ3FaVHhMZ2JKNGJLY0pGb0Fqd2FY?=
 =?utf-8?Q?CGgY1t5m4jM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFlCMG02dzNWSjhCeUpWK012STJVbmFWZ2hwTThaVGpzcXNZR2lWdCt0Vk5w?=
 =?utf-8?B?WC94b2E0TzNTZythVzV0OUd5dmNsUlVLcjNYcFJlL3ZicmF0VkVkUkUrZUt1?=
 =?utf-8?B?VEhTSi9UVkRSSDJXRGF6QXVJemVZQm8vNlRKVnJCQWdBQmNETVk0bE5Obm9G?=
 =?utf-8?B?eExqQ2xzNU1hRU1sMXNEWU1uUjdSeitCN21sZ0ZtOHhkdDZJczlaOXZtSEVH?=
 =?utf-8?B?b253dmFwNkJrMmNpUU5PelJpV2g3UEVZSTlsbU9YZ1E5MmV6ak83b1M0cXJ3?=
 =?utf-8?B?bld1eUptbXlQc0dkYm5sVHNaSkVvdG0wT0poZy9Da3JiQ3JSSWVrcjI2eTd3?=
 =?utf-8?B?RDMzMVVRejk2Ykc4OUtNdk9hYlhmb0prMklyM0ZxbEhFUzdDNTNERnNFaFdM?=
 =?utf-8?B?Y2ZhQ1JwNy83Y0licGxBd3g1M2Y4UUdPM0loSjdUam5ncG1aU09QcGY4d25t?=
 =?utf-8?B?eFZRdWhqTXFBNUpXdW5vditXZTNvU042U1cxU3pnUFhLcThhNU1ERDBPbkcx?=
 =?utf-8?B?NW52bG5qNGlvcXIrNXYyTmozck5IcUFWTXl0aTJDWklZZkp4TnoySzNscVFQ?=
 =?utf-8?B?M0RaZkRwRXNiQmJCeUtFYUorSXdkZVpxWWdBcWpNM0V2U2lqK2dzOFJtVDhj?=
 =?utf-8?B?MHRwWEp1eFBvVjY4bDE3ZlFVbzBOdjRaQk9hUS8wbWxaOTFiMERLejY2QU5t?=
 =?utf-8?B?dmRyUkNkZ2g4T3dhRHhRV29pUEkrOVBITGgydE9wTnF1ZmxFZ1dqM1BobUZJ?=
 =?utf-8?B?TFJpT3g4aWdyaEVuTCtOS0xwb2l6Y3p6UjBsenVQcE9JRklaNm5BNHdoUkh5?=
 =?utf-8?B?Q3ZUZWxSbjJ4aFVIZzJOa0c0MHdWM0lJc1BTT1V0bjdaZm12Y2wwT3JOZVlC?=
 =?utf-8?B?YkFzc1kvUzl6emwwQStCdlJjc2VQWTRBS3NkdXpVUzBpUE81T0V4UzA1T2ky?=
 =?utf-8?B?RXVqTEQvT0Y0Y3ZCSUlWQUwrcnhvYjh5RHJDUXA1T25xdjJTN1kvQUxtT3NW?=
 =?utf-8?B?VHBMdG9XQ1U3bnRKakpyRFc3eGVFM21IYjhlMDZISWhockdxVmp1T3ZWbHR2?=
 =?utf-8?B?SExoYUZOaWd5SnZRTUhwQlpEQnA1Q1N1bUFGQk1iT045ZDAraktyRnlnR1ZT?=
 =?utf-8?B?Vm5JZG4xZ3B3b0Q4VElINlMvK25vaGQ4ZUs4NHVWM1ZBemdEWnBlZ2FjeE9W?=
 =?utf-8?B?RjAwRG1lSFpaSjU5T21qamV1dFdQdFU0d2RUWXg1eVg2UWhOeUNsYmozb2c3?=
 =?utf-8?B?eFhaNDhaMlRsRTBMZ3I2SlZKWUVaUjFROFJTaFpaeGJVMTAzdTFVenFXWFBu?=
 =?utf-8?B?cWU4eVpsUFFZTjUrQzdLY1QzU0psVHJRc1RXQnNGNWI5cFVqWldlWXo5dTQ5?=
 =?utf-8?B?SFArdnhGMDFJT1NBQkt2TlVSUEI0UC9Cci9nbkRLOVZhSVEwN3ZTb1NmaXFE?=
 =?utf-8?B?OUF3d21BVXppUTNOQzNSWTlrb1BncFVoVWNLZkYyd3NZMXUwWjhjRzFEY1Zj?=
 =?utf-8?B?dlNTeFdqNTFTN09PQ3Zoem9jVEZISWdINTRrdkpqMjRKQ0k4YlRpa29WQzR6?=
 =?utf-8?B?YkE5OUhKTFNnbUtwMzh3bnJCVGZzRW9ZRnRySXpxK0Q1QTY4VkJGNHpaNll6?=
 =?utf-8?B?UDdKU3k5ZnFCaVprZHcxQU03NWwycEhaZklZenpWRm9pWXQ0Vk9lNllnM1g5?=
 =?utf-8?B?eTFCVjkwYTYra2VKK1NWZDIxYnRETWlRR2NrYTQ3dXZuS2VKaFlsVUhUcW9V?=
 =?utf-8?B?WkJZRHZwUEYyOVF3SnB2ZmpiVFZaL2dOSUpFSjc3eVRRb3Voek0zQVUrNzFq?=
 =?utf-8?B?UndyYXpyMjRYc21BY215WlBJQmhYcWRjcjNZME9VS2o0d0ZhRWJvc2Q0Y21i?=
 =?utf-8?B?TmZ4WFRhcUxsSFBuWGlWYXVNWFlvY2l2NytDMFRFUkRUVHh3SUdkd25BR203?=
 =?utf-8?B?NDU4cEhLTTlRbC9BZnY2WHhlVjdJelg4ZnVYYjgycDd4V3ZhYlpqNmNjTHg0?=
 =?utf-8?B?UXBmazhPcFllV2t5dWVJZ2dZTnQxZjBtZ0RKNWVwR2swQXFVR0ZiVTRyckNT?=
 =?utf-8?B?c2N2bTI2UUFLZ1FPMTlmRnpQUVFlMVNpaEFpbDlqS3dqTkRHLzNFVUNNdTg1?=
 =?utf-8?B?RFhYRG9aRE1rQ0F1ZU9qeVArYWtlYXAzOU5oWXkzMWtUWC9NcHJNS2ljck9w?=
 =?utf-8?B?ZTZZaGRJVUJlN2lJODFVa1RaYWcyYWt3U0ZsYVF5eHA4MHh4VXh0N0FYVVZR?=
 =?utf-8?B?c0dZMXRWS01XN05Nc2ZFNW1vclFRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fd3426-9a42-4371-c3d8-08dde623917f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:10:59.7577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKGiIIlUzkmJHaRhJfF/bDSBRogFieCw9qRKEx6YFHw5opPitckp0w1LY3Gsk2Wog+Kiqw1rHcllQFrEQy0S8iCD3jl9fhWS22ZVwJhkgrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8891
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX8PBWBHfc6WF8
 iDcHf5kEzPyr5+gz6L3Oi+J9A8KIDH2e12a07eqeQvTBfS6UvFYuZmREyOvqw0y1izzwSrIpWhV
 UrcfnxVdNIqWVbPYB/3u+HWfGJDQBAF1QTHD93S0dtuBi0m1oUHb4KOJET+/9SWV9fZbBdKMkhM
 X62YmSx2C1ZNrqj9JvZB8ZwJxu1ZV0GROEYUA37MZTshSAR/Sg4mQJzHLgIINimrvnRvukRZn/s
 8XjD1kTbn69A3WfJgElwSc9U9vgwG1GzG+qI0Up2qzPmzGri4E+5mxkq9R9uD4dqEx8mTj6zbc7
 Dv8ZUOXVCvM1t8oLXb5H4vtbAeA3H3EEYH8j3AeiP3FcrO5Bqcng6TBWbDc/8s=
X-Proofpoint-GUID: A8Ffj2jb2Xm-G3jgU_EIjavpVaWP16qX
X-Authority-Analysis: v=2.4 cv=M/VNKzws c=1 sm=1 tr=0 ts=68b0394a cx=c_pps
 a=/SftibAerhb+Okdi1L3afg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=mDV3o1hIAAAA:8 a=64Cc0HZtAAAA:8 a=IfIlM_kdIUSuck7g6WgA:9 a=QEXdDO2ut3YA:10
 a=Y4I1g1QRc_YA:10
X-Proofpoint-ORIG-GUID: A8Ffj2jb2Xm-G3jgU_EIjavpVaWP16qX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

For various historical reasons the initialisation of the isapc machine is closely
intertwined with the initialisation of the pc machine, which is preventing some
future improvements to the pc machine initialisation logic.

Since the consensus [1] was that the isapc is still useful for testing and running
older OSs, this series splits the isapc machine and its main initialisation
routine pc_init_isa() into a separate isapc.c file to reduce the maintenance
burden on pc machine developers.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg06137.html

(Patches still needing review: 2, 7)

v7:
- Rebase onto master
- Add R-B tags from Xiaoyao
- Squash patch 13 into patch 5
- Add new patch 2 specifying a hard 3.5G RAM limit for the isapc machine and
  adjust max_ram_below_4g accordingly to provide consistent behaviour between
  TCG and KVM accelerators
- Add new patch 7 to remove igvm support from isapc (it is not supported according
  to our own docs)
- Add assert(pcmc->pci_enabled) in pc_init1() and remove incorrect #ifdef change
  from patch 15
- Add warning if -cpu host is passed to the isapc machine similar to if -cpu max
  is specified (these are both effectively invalid but are added in case of
  tooling that may generate incorrect command lines)

v6:
- Rebase onto master
- Add R-B/S-o-B tags from Phil
- Specify isapc max_ram_below_4g as 4GB as suggested by Phil

v5:
- Add warn_report() to patch 1 as requested by Phil
- Add patch 3 to inline pc_xen_hvm_init_pci() as suggested by Phil
- Add R-B tags from Phil

v4:
- Rebase onto master
- Add patch 2 to remove unused loader.h header as suggested by Bernhard
- Add patches 16-18 to tidy up the pc_piix headers and the pc_piix/isapc
  rom_memory variable after the isapc split also suggested by Bernhard

v3:
- Rebase onto master
- Add patch 1 to restrict isapc machine to 32-bit x86 CPUs as suggested by
  Philippe
- Include logic in patch 1 to handle the case if an isapc machine is
  launched with -cpu max as suggested by Daniel
- Add patch 13 to tidy-up pc_init1() for the i440fx-pc machine in the same
  way as patch 11 does for the isapc machine as suggested by Bernhard

v2:
- Rebase onto master to account for the fix in commit 0b006153b7
  ("hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine")
- Replace verbatim MIT licence text with SPDX identifier as discussed
  with Daniel


Mark Cave-Ayland (19):
  hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
  hw/i386/pc_piix.c: restrict isapc machine to 3.5G memory
  hw/i386/pc_piix.c: remove include for loader.h
  hw/i386/pc_piix.c: inline pc_xen_hvm_init_pci() into pc_xen_hvm_init()
  hw/i386/pc_piix.c: duplicate pc_init1() into pc_isa_init()
  hw/i386/pc_piix.c: remove pcmc->pci_enabled dependent initialisation
    from pc_init_isa()
  hw/i386/pc_piix.c: remove igvm initialisation from pc_init_isa()
  hw/i386/pc_piix.c: remove SMI and piix4_pm initialisation from
    pc_init_isa()
  hw/i386/pc_piix.c: remove SGX initialisation from pc_init_isa()
  hw/i386/pc_piix.c: remove nvdimm initialisation from pc_init_isa()
  hw/i386/pc_piix.c: simplify RAM size logic in pc_init_isa()
  hw/i386/pc_piix.c: hardcode hole64_size to 0 in pc_init_isa()
  hw/i386/pc_piix.c: remove pc_system_flash_cleanup_unused() from
    pc_init_isa()
  hw/i386/pc_piix.c: always initialise ISA IDE drives in pc_init_isa()
  hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in
    pc_init1()
  hw/i386: move isapc machine to separate isapc.c file
  hw/i386/pc_piix.c: remove unused headers after isapc machine split
  hw/i386/pc_piix.c: replace rom_memory with pci_memory
  hw/i386/isapc.c: replace rom_memory with system_memory

 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 189 +++++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 252 ++++++++++++++------------------------------
 4 files changed, 272 insertions(+), 173 deletions(-)
 create mode 100644 hw/i386/isapc.c

-- 
2.43.0


