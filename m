Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9990C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXS-00089J-Kz; Thu, 28 Aug 2025 07:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXP-00087C-RS
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXL-00054y-97
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:27 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S7hYMt2893263; Thu, 28 Aug 2025 04:11:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vR1vnKko24eU/idjwrdF0zDBhRAmB5/IkfWIQUv+k
 Pw=; b=EF+HYv9zfvcZtQ6wy2T61tQ+/Ufqq0mw1/vHVXuq4TH/8UeOfmtveJN+6
 e7mMXoUz4eyY056dW267j7fmj0S3hAd7hBG1/725E4RA5JzDzq2k12TubpMEMfx/
 SBF/qJJgGfk3Rmmf1z4j8l9e9bxWxLUbsa6eyI8QAbpC5/VD4YrQ7OdlgKMhdyl3
 XgBauaJ8LXGWsTs7WJpew+aUj4Mzab9p6kr+2T/ItymhpmqrpjnbG7806gIXDZuO
 rgTu5lp9epSF8/7B18VVtyrkUTZLdzAaxJ4LPOmkXjr4kHyEYfsihB4wSwHJOabu
 lBFMH/yctO/lGkHtA3RXAfPOry3Pg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021093.outbound.protection.outlook.com
 [40.93.194.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48t7sy1pfy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sxj+XaX/mUjdEJc/Bn1myRt++c2tKufxYoKP2G56VXTneCrhzqHKVsJtZXT5BbuhU2zHfCe/StwC3eqJoniUYViDGU5C/SjrmpQ2EP8ErFL2TfNe70VAYyUHRJR7zKMJ6dpT9UAhvCq/h16WJ/uwiBNT5YgbBLKA+9gVutL9a4Lh72GGuJ6x4BuJjtDRSSxgqevD4M5jFSJuAakk6gCINbJix0gMgLF/nj/2Gq0bKXYmKH30UPaKNRPue2vTfyAnPkMviZ4BltbubBRJadP9TrbEZtipUzLcD98qgc1p9NyZRHUdkOjeAjtbb0Ub8C0EQvZYB17GOfNmnYNftjmA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR1vnKko24eU/idjwrdF0zDBhRAmB5/IkfWIQUv+kPw=;
 b=AC6cJkEoAhaGucOuhlp/gNix/3+09oACUpaPaZqpOXMrWcfSjYOFYpIfgKLPT8DqpQq63fnP7dhi2/qWiqfA6rShqI9+eXdo8olt+Jn+HcqepdRSlOmml68qPJve3m+9jzHg6m7oQTwRxNw2RW/AH30c5bsMrQD3IVvPCyhcxnqiUD1FxrVY/hC3WPbtpXao+DXLv/9OFlG0/sILSN6PdNQapm/fmDnBklqSCUhfEQUolsDwF3P0WeZLQujWcx53BW0eAa3LVIO8KzlJo1sNWXHAVOInWNVhfBZP6UX8kuenMCuItjeTlpKKAjh3Z3Lc5EpKAN+4hRHhasOQxOa9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR1vnKko24eU/idjwrdF0zDBhRAmB5/IkfWIQUv+kPw=;
 b=wCJAiUkyRg89bdHCl8oV1KgPZ53+U8JyHnA9I9rQo6AZ4OlqILQ4w8IAXDfTQKc1VSGnyF8s3HnxI7HTFd1rFJYk6fkLB2kM6dyzFAAZt6ZfG6Ir/o5XTSEgUh+0UdtBWiVg6oHHkYFEXx5y4Lv72Z7WMrV3czEbTkVOtZwMn/EkNgNQS9yE+T32ULFw8JsOMopZlhPCQSkZcn5CaFGbqCtFuw2xM1SawQJhpuJ7NB9HX1M+2Gr+hh0Uxp6rdh010cUfpvTKBKQIe9ul1txQJoSipiGK2cxWuBx7/dgdi7fp5d4EUSW/6t9ekOCRSlj0DxG7ieqzX5xeSQ2+LjEbKA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:18 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 05/19] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
Date: Thu, 28 Aug 2025 12:09:48 +0100
Message-ID: <20250828111057.468712-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0013.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 6555cc63-d666-41fb-e219-08dde6239c6e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm1PN2k1bFJIR2lBSHE1bFltRUVVV2FyWjhaZ1RFWXQ1alRjdWJpWGNnSFdV?=
 =?utf-8?B?NFFKamZtRE9UeTI5elpqamlvM3FsNW84d1VNYWwwdDNZL0x6ZkVKUzJGcjlp?=
 =?utf-8?B?VElONEVuVUIzVmlxcVpNYkQ1dEJSR0ZKVUtTSXhPaTBlQjFOY0NQejZJZ3pj?=
 =?utf-8?B?RDNrbTliZi9QMlpPdDM4U3N2QnNYUG01enhEQWExQjJGV2dUMzc4MUN5R2ZZ?=
 =?utf-8?B?K2xGQk9CR3BCdWQ1LzJvZThJdSs2b3JJZGJXTTFpT000Ym9QVXZWTlpIQ3Zs?=
 =?utf-8?B?NHRHSUpxSk5sU3FhVXpyZjVFZ01sZWI2bUEyYzVLUGkrd1ZNNUsyaTJJQjFS?=
 =?utf-8?B?cU05N0hkUGtiQkpzNCtXNWxCWkVvKzZ0a2t1eGtKV0JFTVc4MzdCQk5rQVZu?=
 =?utf-8?B?RGRpdEg4dWFGZG5XaS9RSVpkaFVpV2NmUjhRS1ZNUHk5SXJNUnJJdEdJcUtn?=
 =?utf-8?B?cmhQR0dJYzc1cU14NTZuNEVDYVRHVStkcTZ3UVhrRE01M3F5K0RQQzhFbzE5?=
 =?utf-8?B?UkVRZm9hVkltRi9iZUVYQnJTL1RQL3JUUS9wM2ZiMVU0OEY0aCtIaWlCdDJV?=
 =?utf-8?B?dnFBUlVKSS9uVTdqL2lKSWEzUzRDR29VN0l4MWlTNllsZkd6WjIyM1hUQzV4?=
 =?utf-8?B?SnBLcTVjQXRFMXpGT21NaXVMY05LTjNqNXU1TTZyaW1WeVFrcHJiejZnYUJz?=
 =?utf-8?B?S29sSTV6RHFCQ1c3aStJUXBQYnlLeTJ2QUpQQlJmNXVlVmhXckozUmFVbExy?=
 =?utf-8?B?ZE9NdVlGNUpQMG13UUZZRUFCR3BYaU41UmZyR0E5T1FmeVptWGl2UWQyNnF5?=
 =?utf-8?B?bWZxR2NkUktxcTc3MTM5TFVIekk4NG9FanhhOXcxLzFKdWQyc0k5NTlNbCtC?=
 =?utf-8?B?ZkNmMkRCUFV4VFFFcG56QXBuMXJValkxZ1JWVFFqSVFhTFduWFBnSEswalRY?=
 =?utf-8?B?eDlSS0JmRlpyQlBGb1B1Vi96dUNoOVNqQllWeG5vdW5sU2V1a2NKLzA5eU96?=
 =?utf-8?B?Wjl3TTNqbWRBQ1lTWmxoSHpLUGRES053VlNxek96MzRMTnREZDBzL3dGOXdz?=
 =?utf-8?B?eXR6WE9rM243VmNsR0hNTmVDS3RPUDFiTUZON2FxNkZ4bml5MkcvQmdvR2x5?=
 =?utf-8?B?d3RkWGFONUQxT2w0KzltT2Q0U3NSeHM4bUU4ajJsdFJmR3UzN016RVlEWjNF?=
 =?utf-8?B?RXJhb2IzR0I0S3hQM0VoY3hIRDV6bzdGeG1OYWdsUnNWQ3c5bnFGVkFPQm1h?=
 =?utf-8?B?UkdCTjVIQUJqNWsxUlZ5L0VtR0hDVmpPdmt2WkRjZXBvWnhvLzl5RGZyTWw2?=
 =?utf-8?B?Y0VGNjRuMDFhdWhrazg3cFJxNzAzL1NVbGNCRHIvMS84K3JqeFVtSlpHUm01?=
 =?utf-8?B?L0k4WFhxTTJYMGUzcXY0eFp5YzE1anRCNVhWemRkMUU2M1k1UGtLOVd1cDQy?=
 =?utf-8?B?STc1RzFkTnVSVjM1aVVGRFppbXhlZktUMy93Vk1vWkxCYVpUYXBaL1U4anU1?=
 =?utf-8?B?bXNDYUZGcW5Rb2ZMV1ZLVnRzUXI5L2tVdTBtTHcwamxpcUJPc0tzS0ZLbnN1?=
 =?utf-8?B?NXZsVGNJSGFBdzQxYzdGcHBrMlVHeGRTaTFwZDZCbCtDRXlqV25FMjlFbHdw?=
 =?utf-8?B?QlZUQlhpdXUzOFZMN012RlBGbHFzUW5ORUNHTVpra2FVOXFpN2pxc0hmdjgv?=
 =?utf-8?B?QTVTYm16Zkw4Mlc0bEY0c3oybWk3N2Z6VWN2ZGFQb01HcWtuTDI1bklFZjhh?=
 =?utf-8?B?NjBkOEpNOFZxUzQ2ZnhkMlNoT3pvbTNGOUVkaGM5YTBmZUlUS0daeVNPaDVl?=
 =?utf-8?B?eDkrWnBqYXNadS9kQkk2WjJ0UHVnRzRvY2Z2L0tpNTAvQlZXZVNNYTNTVWFM?=
 =?utf-8?B?S3pRMDhpcUt1VVg4bnJkUXBlSTNuQWZsQnRPUjkyTThBWG5tSXkyelcyMEFN?=
 =?utf-8?Q?R0rHwA53bpQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFN0OXlrWnJUOFprNDBtbXZ0YVJrOVN1NFg5Z2xqclo0QlNkL0c3b0cwWDZ6?=
 =?utf-8?B?amdEdm8wcVJEMCsrSzhFTFNsbVNxbnF6Vmh6b1d3OGNEajRJUTBQVWF4N3RM?=
 =?utf-8?B?aDZSTFpKemI4RGQ2bXBDaDFaNUtXSWs1Mkhsbkg3c3hoRHRQbm9td0dnRkph?=
 =?utf-8?B?YlBkb2lKYlBFd1FybFo5bmVFTW5XbjBNN01pMTk0U1gzUVhmV3FRSDdVUU8y?=
 =?utf-8?B?ZHhCRXBuOEltblFBSHA2RzVCZXVEaWtFZE1yQzNXaWQrLytTdUExMFYwVWR2?=
 =?utf-8?B?bjRkMGhrMStnTFVKY3hKSzlDZHpRWFU4bHlmOVVoU201T3NjTVNrTGxkcVlK?=
 =?utf-8?B?ZDg4S1NoY2JqV2RrY2ViWGhqQUNMYis1bDdVWWpDeUgyek1sdUdnczNQL210?=
 =?utf-8?B?VldVbnJCVXB6ekdVa2tiWC8rS0hpeEFEcFFrNFlvREsvRXZQdnp3WXpFaHRF?=
 =?utf-8?B?VlZPSWpSODN3RVdKOEJmSmdqVkUwUk5QdUtCQjRSODJlL0xWcUdOZnMxWE5H?=
 =?utf-8?B?ZW43VkZ1alRiVVJEc04rNEhEYWJOTjF4ellDNldDRjBreS9sbXpRZnpaN3BM?=
 =?utf-8?B?czJMeWxrUU80emMyOEo1Vk83dVErVHEvbllvMVlYUWJKQ3RaMkRxL1N0Q05S?=
 =?utf-8?B?Zll2RjhHYUtIejNPSWFHWmR3cCtGcXNZeGpQVjFENVlvVzFjelNGaUU1QnZB?=
 =?utf-8?B?WXlVMy80UUNtNHA2VjM4cGlmS2NGVCtFVGY2WlhqeHV5VjhhZDhjQisyblZv?=
 =?utf-8?B?eENRbDgwSWExVDhpZ0tlRWRPMmgvZjQ1Q3V3MHJnVFZhM01IVFRGRm1aZk1E?=
 =?utf-8?B?UllRVUY2dmg1S3lobUd0STFpK21XbEF2WW9JeFBmTVFtODNNRithcGpSMkdG?=
 =?utf-8?B?ZmplZ3V2c21Ca2pNeU55WG1CRzNEcHlRK3pMRk56bkh0M2VTcDRBR0pud1NS?=
 =?utf-8?B?K0ptVHRxaG41dUFvTCt1eHRRcHZSWmY1VUlXUGVUVG9KWVl2bkNYWGdMVUha?=
 =?utf-8?B?UHJ2OWpxcFYveHpobXovUDQ4YmtpaVhkcXZsUHh1aEY1MTRCMDIyTWc5dlRt?=
 =?utf-8?B?OUtQdVNOZnRKbHc3RXcrTER3U245S01LcnI1K2xKY0Y2UVhvdSs2bTFDMHpV?=
 =?utf-8?B?VUJuayt4cjloWndWU1ZVRDNhSE1jYlkvNnhTdklQaDlzVS9XaENvdXJTNWQ4?=
 =?utf-8?B?THdTeGZGQkhYbGVwQXIzL1ptZndlZG5TU3B3UDE5dExXc3VWdDEzZ3EvTVFI?=
 =?utf-8?B?NlZ5aXdTSEpBdHpPVXQ1UHpGNyt4bTZKNU9jZ3JxRGN4OXRwQkhOT0FmbVVY?=
 =?utf-8?B?SW9NTGxCQjdiMk9WUzVtd3psQmNKYUd0ZHZRWnlRcUJvcHVHL21HMktTTmZv?=
 =?utf-8?B?V0xzWVRJSVhUZHZpemFEYURmY3VsTzJSaGJFQkFub0trVTlwUy95YXkwM1Bw?=
 =?utf-8?B?bkhVT1MySjNkbDl1NW9tQ1hZUHllYkxDeWpEZmRmM1dBUytNZDZuQkcyYXBr?=
 =?utf-8?B?YWk2YmlHSm5UTXVqb0llNUNnekxrTEY1YmVjZXRQVisyTGJ6WWxSSG0vaDJK?=
 =?utf-8?B?elRkRDVYZDJXaTNJSGwrVWFTVlh6QVdKdkphRi9VSlEwTFpQYVdXQkJtUkEw?=
 =?utf-8?B?bmdtVExSMDBhVnM1ZVgwTHdOd0NjRzZiSkVtTEh5c1JoM1B4S0YxcUZYUzcw?=
 =?utf-8?B?UHFob2RBb2NJYktPMGVrYUpNOURuY3FIYU55czB4RUJEbExWV2pSN0QrdEMr?=
 =?utf-8?B?RnFBSDEvV1BWUVNzZGVDUmRLVTVUUXNBSUttaUZyUm41REJBT0t4WFBaY3VW?=
 =?utf-8?B?aFZFRGpiRmUwMWtlclBFOHdJdE84SDcrRVB5RWZacFhJUU9PL1hqMklNVUxO?=
 =?utf-8?B?RlRrU3NVUHRYMWNEWkpQYklsUHlNdU9KVmZjVjRYdGNvMTBvMEU4K1hlR01z?=
 =?utf-8?B?KytqdHdDQmdwcHVNQnc2aDYyVnpuR0pMRFMyYzRZOEhrdnNvbXdLRmFYdzUw?=
 =?utf-8?B?SWdnTmRHVUZaYzNLYmhwQVluT3VxYm1NajdEN08zODd2WWZmRURyWjhqZWVp?=
 =?utf-8?B?cyttOWVmb00xaFlxY0Q1OWlYNlFIdVBuMlJGNWF1bDdmNXgrVkwwZ1luTlZD?=
 =?utf-8?B?ejRDZXZTTjJ3YXRjc3RPRjhwcWpPNHdCYklTTFppQmk0THVMNjZseitRZVB0?=
 =?utf-8?B?TEdIMU45T3ZxZXEwajlja2thME1yNGs5TlZsVHhxTllQdG5hV1FVUTh2T0R5?=
 =?utf-8?B?WGp0dXdxbjNaOENTekNEeFhMM3FRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6555cc63-d666-41fb-e219-08dde6239c6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:18.1392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5s2qAWqirDSh/slF+MduUHyCmP9la7yRKZM5yH/3jqVPAb041tn/CF/BGsVFw+h6gi+FMIjz8KIZMvRkTM9WlIpsbOmuPjJJQImR7NYZ+mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX+LHkXAdlRHpZ
 tU87DRW+les5Yp5Bi7qPq+2mrpiEsUc4ayaX+ClDODkY8Uhb/55y67+zUVzCEtA+bf5zFhl4N3S
 Ytowqr+1zZJpWx87TNVpMMTgSLlMTfA+rykcZqg+hNs+MwrNTYWI1m3d0GcWCJ2irvJaOVuhbDh
 opNXXcyA8OZwhsZ+V0Yti8/YmgaFs49AckQQ2PLmp7UlDjWpIrZHEvJ/zKGY8beqhkiV04bQPVN
 QAfeLCfbH11mm09hivLFbv9mqhHFmSny4FIXDOmjVbCEYhEOk1xRiLtGfcllu6HbjDtEEMDWGL4
 452RtXU26DTiPjXiLDsukTtOkFJFa6xusOqdtBZyI5iTiiiSO0jajzgNhMor/g=
X-Proofpoint-GUID: ZWoiVApevml2WCLg80HDrOTLUL7KDg_n
X-Authority-Analysis: v=2.4 cv=M/VNKzws c=1 sm=1 tr=0 ts=68b03957 cx=c_pps
 a=G8VycjxW3wO8/D/xgNJDKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=13zc6MqDSUu7KqF3LJsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ZWoiVApevml2WCLg80HDrOTLUL7KDg_n
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

This is to prepare for splitting the isapc machine into its own separate file.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 275 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8e302dc013..60bf18c680 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -435,6 +435,23 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
+    const char *pci_type = NULL;
+    PCMachineState *pcms = PC_MACHINE(machine);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86MachineState *x86ms = X86_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_io = get_system_io();
+    Object *phb = NULL;
+    ISABus *isa_bus;
+    Object *piix4_pm = NULL;
+    qemu_irq smi_irq;
+    GSIState *gsi_state;
+    MemoryRegion *ram_memory;
+    MemoryRegion *pci_memory = NULL;
+    MemoryRegion *rom_memory = system_memory;
+    ram_addr_t lowmem;
+    uint64_t hole64_size = 0;
+
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
      * for the isapc machine, which will provide a much more modern 32-bit
@@ -466,7 +483,263 @@ static void pc_init_isa(MachineState *machine)
         exit(1);
     }
 
-    pc_init1(machine, NULL);
+    /*
+     * Calculate ram split, for memory below and above 4G.  It's a bit
+     * complicated for backward compatibility reasons ...
+     *
+     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
+     *    default value for max_ram_below_4g now.
+     *
+     *  - Then, to gigabyte align the memory, we move the split to 3G
+     *    (lowmem = 0xc0000000).  But only in case we have to split in
+     *    the first place, i.e. ram_size is larger than (traditional)
+     *    lowmem.  And for new machine types (gigabyte_align = true)
+     *    only, for live migration compatibility reasons.
+     *
+     *  - Next the max-ram-below-4g option was added, which allowed to
+     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
+     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
+     *    but prints a warning.
+     *
+     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
+     *    so legacy non-PAE guests can get as much memory as possible in
+     *    the 32bit address space below 4G.
+     *
+     *  - Note that Xen has its own ram setup code in xen_ram_init(),
+     *    called via xen_hvm_init_pc().
+     *
+     * Examples:
+     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
+     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
+     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
+     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     */
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &ram_memory);
+    } else {
+        ram_memory = machine->ram;
+        if (!pcms->max_ram_below_4g) {
+            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        }
+        lowmem = pcms->max_ram_below_4g;
+        if (machine->ram_size >= pcms->max_ram_below_4g) {
+            if (pcmc->gigabyte_align) {
+                if (lowmem > 0xc0000000) {
+                    lowmem = 0xc0000000;
+                }
+                if (lowmem & (1 * GiB - 1)) {
+                    warn_report("Large machine and max_ram_below_4g "
+                                "(%" PRIu64 ") not a multiple of 1G; "
+                                "possible bad performance.",
+                                pcms->max_ram_below_4g);
+                }
+            }
+        }
+
+        if (machine->ram_size >= lowmem) {
+            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
+            x86ms->below_4g_mem_size = lowmem;
+        } else {
+            x86ms->above_4g_mem_size = 0;
+            x86ms->below_4g_mem_size = machine->ram_size;
+        }
+    }
+
+    pc_machine_init_sgx_epc(pcms);
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
+
+    if (kvm_enabled()) {
+        kvmclock_create(pcmc->kvmclock_create_always);
+    }
+
+    if (pcmc->pci_enabled) {
+        pci_memory = g_new(MemoryRegion, 1);
+        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+        rom_memory = pci_memory;
+
+        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+        object_property_add_child(OBJECT(machine), "i440fx", phb);
+        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                 OBJECT(ram_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                 OBJECT(pci_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                 OBJECT(system_memory), &error_fatal);
+        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                 OBJECT(system_io), &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                 x86ms->below_4g_mem_size, &error_fatal);
+        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                 x86ms->above_4g_mem_size, &error_fatal);
+        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                                &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+        pci_bus_map_irqs(pcms->pcibus,
+                         xen_enabled() ? xen_pci_slot_get_pirq
+                                       : pc_pci_slot_get_pirq);
+
+        hole64_size = object_property_get_uint(phb,
+                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                               &error_abort);
+    }
+
+    /* allocate ram and load rom/bios */
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+    } else {
+        assert(machine->ram_size == x86ms->below_4g_mem_size +
+                                    x86ms->above_4g_mem_size);
+
+        pc_system_flash_cleanup_unused(pcms);
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
+    }
+
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+
+    if (pcmc->pci_enabled) {
+        PCIDevice *pci_dev;
+        DeviceState *dev;
+        size_t i;
+
+        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+        object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                 machine_usb(machine), &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                 x86_machine_is_acpi_enabled(x86ms),
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                 &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                 &error_abort);
+        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                 x86_machine_is_smm_enabled(x86ms),
+                                 &error_abort);
+        dev = DEVICE(pci_dev);
+        for (i = 0; i < ISA_NUM_IRQS; i++) {
+            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+        }
+        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
+
+        if (xen_enabled()) {
+            pci_device_set_intx_routing_notifier(
+                        pci_dev, piix_intx_routing_notifier_xen);
+
+            /*
+             * Xen supports additional interrupt routes from the PCI devices to
+             * the IOAPIC: the four pins of each PCI device on the bus are also
+             * connected to the IOAPIC directly.
+             * These additional routes can be discovered through ACPI.
+             */
+            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                         XEN_IOAPIC_NUM_PIRQS);
+        }
+
+        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                              "rtc"));
+        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+        pci_ide_create_devs(PCI_DEVICE(dev));
+        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
+    } else {
+        uint32_t irq;
+
+        isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                              &error_abort);
+        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+
+        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
+                                       &error_fatal);
+        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+
+        i8257_dma_init(OBJECT(machine), isa_bus, 0);
+        pcms->hpet_enabled = false;
+    }
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pc_i8259_create(isa_bus, gsi_state->i8259_irq);
+    }
+
+    if (phb) {
+        ioapic_init_gsi(gsi_state, phb);
+    }
+
+    if (tcg_enabled()) {
+        x86_register_ferr_irq(x86ms->gsi[13]);
+    }
+
+    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+
+    /* init basic PC hardware */
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
+
+    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+
+#ifdef CONFIG_IDE_ISA
+    if (!pcmc->pci_enabled) {
+        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+        int i;
+
+        ide_drive_get(hd, ARRAY_SIZE(hd));
+        for (i = 0; i < MAX_IDE_BUS; i++) {
+            ISADevice *dev;
+            char busname[] = "ide.0";
+            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                               ide_irq[i],
+                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+            /*
+             * The ide bus name is ide.0 for the first bus and ide.1 for the
+             * second one.
+             */
+            busname[4] = '0' + i;
+            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+        }
+    }
+#endif
+
+    if (piix4_pm) {
+        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
+
+        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
+        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
+        /* TODO: Populate SPD eeprom data.  */
+        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
+
+        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 TYPE_HOTPLUG_HANDLER,
+                                 (Object **)&x86ms->acpi_dev,
+                                 object_property_allow_set_link,
+                                 OBJ_PROP_LINK_STRONG);
+        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 piix4_pm, &error_abort);
+    }
+
+    if (machine->nvdimms_state->is_enabled) {
+        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
+                               x86_nvdimm_acpi_dsmio,
+                               x86ms->fw_cfg, OBJECT(pcms));
+    }
+
+#if defined(CONFIG_IGVM)
+    /* Apply guest state from IGVM if supplied */
+    if (x86ms->igvm) {
+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
+                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
+            g_assert_not_reached();
+        }
+    }
+#endif
 }
 #endif
 
-- 
2.43.0


