Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919E8CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraY8-0000LS-25; Thu, 28 Aug 2025 07:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraY2-0000GF-6F
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:12:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraY0-0005Yy-IO
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:12:05 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57SA34ev3413602; Thu, 28 Aug 2025 04:12:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=vsWN1p64wfTMpat4q3DpLYXXNHcQKGKjDoP0jdwRh
 xk=; b=VLpsUWudoeJm5+gCdYCucbp93qznC4X2TqFXviORLm/yGSooNxdCjNi/D
 FbAYRt0b28Gp+EEJJxyF7eKI459h7utxZrebQtS+8ymk9T2gLjCUdw+v2SunPvLz
 SJPNLIg6OMmrTFbZK+EQY8PghLpvGT6yZsyeUYE5yQEMrkfe7RCEueNF6bZSk/OX
 0kooP2V/1XvKcBaA2Oi9MbFLTDOXtMTWd/vBABeD3WJXUVhAnlKdT59RXz1ixs5D
 s2hrbCUe5g3zC8Yx6VZMaXetb3TjHUvRYdxL6C8U1RpXmsfUTt9LL/fKnZACW4jk
 fHtaTgNVt1a0Im95n0dXsOykhYhyw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021128.outbound.protection.outlook.com
 [40.93.194.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48tbd9s9bk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt1egR44QGadK67d0Dxu9DXVJnPf0wbLv85QQcjFN/+Ps8y3Mx57VvvH7p0Kv2ZPrdC/UEyIb8nJlwAcVdqymeXoGfw+cp713WlHPDeSRcJxPy6Err6menVkPxpOznYcDeyqeJ22rQ/RccmjvHWdCkjU4cNH+bKf5zCX92YGW2LwQR4z3BSpElc9xm/FNYk2Mh+KDhcsiwtNQgaJYYYz7K0cXlSxzOzaTm7OG+1dwp+G1mWH6a10lgWQCht8/gVdjKPfxd4fdpoYZDszRFI8K78o7dwE6I2SaCdkGJvZ8reh4XXTgPriA+PbOeuTfzKd8hDIb3BdiSXJziVZWSHJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsWN1p64wfTMpat4q3DpLYXXNHcQKGKjDoP0jdwRhxk=;
 b=YDS6BpOFQrsa8+QLpMlPs1cH2fSN5w+in3zKmEqBuHeKeWUD9YWkh1tE27Dq6+3kRwyXIuSvwxxhAbVxTGstA4jbIyFcF5qZMFqxA2ehIHN6tQE7yKcwJHIBAsxw412f9eNsUo+2Hl0i5deKz70GK2+AlF1zbqYw3dhfYl6dndBEbYrzEie+aPS8r/EADoModcoNu9VncCePFxxMgwWZj4ouRxH/o4fKlJ44sZvDYJDyoFlaoPACXW9QfFK0oyGOelc77lThuBw8VHQbIsP/nCHKarozDkxk2kT2aGOVC70cf4GzmtxKt0xHGguJ539ZTKiwVCsFvmiTHobT3qOyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsWN1p64wfTMpat4q3DpLYXXNHcQKGKjDoP0jdwRhxk=;
 b=dAUwgLsuqaDOluyyHlS1gM7frxH5vX7HPOlWtEA6byby3KyqvX+2yuYgtekHX17EPggHBABU7ZWbtyt1M/fbMvdqM59z0awkSP4UzQ3f9MgZDYwKWO58zfa0KokXDJjhsMSMX68hYycZQ0c740s0qgdVaYmNn33mLQ5v/WgP5B+7MjvdKovqYesi054mtrXM9EwUfBHGbXsR/l6GoDdRDnsqtJ/iXtHUZzkc4Ty7/n2Kg/Leo4Qkj+FNSe7xo9aNdi0OfgX08kIS8bbGYcxfog052c9cQJnp4jJdD8Be4c5/tSGTC4seXpJA7kHEiOYjMuhLHqsWdaCgvK9POPoBMg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:55 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 17/19] hw/i386/pc_piix.c: remove unused headers after isapc
 machine split
Date: Thu, 28 Aug 2025 12:10:00 +0100
Message-ID: <20250828111057.468712-18-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0008.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbbdfda-528d-485a-a133-08dde623b310
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkpGU0FFdVhrUVdNUEhvVGRnYTlPODZJRVJIVDBhZG9GSWdvbitjS3JsQ2xq?=
 =?utf-8?B?M01rd3dxY1J0Q0JabkFxTTZ2bXFwNXVNNUVOMG5kc2JlQ2lSTEpzcG9tTVR1?=
 =?utf-8?B?RG04Mm9vdGdxd0VQTFdFZ3VrdVdWR3ROQUpVaWx2YnJ5YmVnNC9CZC9PTnRN?=
 =?utf-8?B?Q3JJY09SY2pLR01LdWxMUlFwVi9ncE5yQTY0KzRPTExCSHd2WjdEakhzcktk?=
 =?utf-8?B?RHZXd21sMkZ2NUxnK2VWU08wZm1CaUR6cm1lMW1BWVYvc0VFMVI2YVNtUzhR?=
 =?utf-8?B?N2Q5aXg4T3phQnNFQjI3bmpNcDlPZ3pWQWxXMnpBV09UME94dWEvWGZwTnVH?=
 =?utf-8?B?TWZEMW4yRzB0anlsb0hlNE1iNUY3c0JFNmZrODMybVFuSWd5SWF5YXdIV1VF?=
 =?utf-8?B?elhDRDUyRG1tYUNBSnFhcEF6TDJZY01TZmkvZUR6SUk5bjVnR1JjNkJ2SGdp?=
 =?utf-8?B?NVFGN0NIY280T3loK2NNelhNVSs2Wjd6UjVvckxDODZjL1lZRU1lNW5MclpG?=
 =?utf-8?B?MzZnVmdveGZqM2FqZTkrZmMveGxYL1FBU1RqZUpvYWVoaG1mRzRnS3I4a0xN?=
 =?utf-8?B?QmZ5V0lpSU9QUHIwUi80K3FGSEdWaHRTQjk0NXFFcHBPb1lkaGord3BJQ09i?=
 =?utf-8?B?bW4veUZtM0N5NklJSW8ySDZzdmkrM21ROUpJcVJGek0vUkdjNWZHQ0JUWit5?=
 =?utf-8?B?Sm05R1p1U01uSnRrRWMwczJYQ3Jyckw3d3JtUU1PTGt3NXMrck1qd2NoNWw1?=
 =?utf-8?B?VGkzVS9rRGg5bC81bkxPT3Bxem53dk10ZjlwTnl3U0ZoV2wzWlNLSEw3Zkcv?=
 =?utf-8?B?Ky9PelROVllPb01Gc1lvT3IwMXRGbTdFWDNkZUIxZXArSW5NdUd6NWY5MGdZ?=
 =?utf-8?B?R29PcG1tQmoxeXRpU3JxYkx3VG9PbTZzbFppRXZIc3VGenE2M0NQQjN4Z2Vu?=
 =?utf-8?B?dHZNbysrU1BSMjMxM0RCRTVlSm9wK284eXdyRVVZQlpaWTFJTy9kdXd0c1Np?=
 =?utf-8?B?MlB3ZzFTSTdVb01WOTdIMi9NaHdTUTNZaG90VzNFeUtUeDNIY3Y4T3JRK2Ux?=
 =?utf-8?B?THoyN2ZlMHp2U0s1VkFjcnp5VXN4VU50TTB1ck1uSVIrV1E4L01VaHFrRHZr?=
 =?utf-8?B?bVdiZmdIOFlIN1NvTDRPR25WUFlsUHRudExlV0JtMEZxdi8zY05PKzh6bEVH?=
 =?utf-8?B?YUlvZEFtRFdPa0ZBSmY3REJzS3MzTHYxT1NQZ2xnUFB2ZzlzWENJVDEwaWpn?=
 =?utf-8?B?cGRQVTVSUWJ2OTR6YjdmT0JwUFJLVVMxeS9icnlsRkRlVHFuMFhwRkVjQkR4?=
 =?utf-8?B?OGllV0xnaGsvYi8vUWtnR1VXZmh4bzFGYVFVUk9ydnZwdVNGZ2pocW11SGpS?=
 =?utf-8?B?bnUzV09yblZxbHdlQWN3TnM5SHI0WHB0US9OU3NMM0l4dGpSbjQyQTNqM2Uz?=
 =?utf-8?B?QWJZMXVvUUZyQXpXaFJQUU9xMU82NVRZSVp3Mzl2UGp6ZFhScWZMdnBKVktj?=
 =?utf-8?B?cWY3WDMvQVpYUHdWU3ByUnZ5WXJUOGJydkFVdDZLeWxEUkJ5Y3VxcU5vdy9k?=
 =?utf-8?B?cUZPTmtHUU41UFY0bXdMQU1UWTArL2w0d0luZFZHM1NNdi9LeGE1c2ZNS1Bm?=
 =?utf-8?B?QU9ISnFCWmRLc0I5dFk5NTVNMWF3VzBZUkQzK2E1NkowajIyOHdLZ0NXWm9W?=
 =?utf-8?B?MVZ6MWxFWFNFdThsSlZsVXdvYlVmZXp4eXQva1liSFVQbU9ab00wZVpHQWhE?=
 =?utf-8?B?SjcxSFNaTXZHS2JxVDR1TG5wK2Z4YWgzQWxKOGUyRzBEdVhVVDMxMEV4ZlM3?=
 =?utf-8?B?L05SSjZrVUNKYWtsMnZzdEp1bHNYVkkxKzNrcTZPYkhpSFdTcXNuWW1ndmRX?=
 =?utf-8?B?ZlpjaDJScU91ZldNc3MvMlFNMHVxS1J0V2VqRmRGQ3d2N3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3h2ciswRHltVHUrcE1KbENZN0hUajczL1hpK3lScW9oQ3FvclJWUVVqanIw?=
 =?utf-8?B?TENSVjN2WnIxYTlnRkJvalFFZHFOZzg1L3R2anF2UlRNQkhYNWxJaTFNV2RV?=
 =?utf-8?B?MDdQWFVXY0xOTnpHaGlkd1QvU1hITTdkckR2ZkxCTnVDdTh4TDJ2RFZsYm1V?=
 =?utf-8?B?aHE1enlMbGZiYVA1dUlNamczcmQwY2piZnNvMGhrSW1vTHREdUVnTmNtbjhY?=
 =?utf-8?B?Zm9QWUx3N3VncVFVNFFoM2c2NlZpbFlPR3VaTWFvVnVpbGZoRFN1dGo4ZFJG?=
 =?utf-8?B?SForN3NkUmt6eWdDUEk3U3NrVWdlOFNZY0QxcWk4WVYwdFFycXRPeEw3K0px?=
 =?utf-8?B?SUFSWnJZejFiZTBCL0hnSUp1NVlEZndNNnQvSHE3YXNBOWJibmVGU1Nra3Q4?=
 =?utf-8?B?T2Q5a2ZJK2lHNlBEUWNEenM4azgrcGkrS2JwK05ySHpRMUFTaVFJZDkwVjFi?=
 =?utf-8?B?RFdNN2ROSGQvejZEdm41b0ZtQXFndzZmYTJvdFY0dTh6TS9jTktrMU5PU3Rs?=
 =?utf-8?B?REd1aWNzWjdhOFJwY09VN0piWWdkRXhrMU5EQWxjNG50R29lUWdYTStJQkpU?=
 =?utf-8?B?WGphU2tidkZMRkN5VDFPQkFoUmFnaEM4amp1dFBZRkhBNEV1UklYV2VnNHo1?=
 =?utf-8?B?Z0ErZXZtbG5ZN2gvUFgvZkJIRFhjQUJya1p1bSs0eGx1eEFKNXBiSjhLTHZK?=
 =?utf-8?B?bUM0RElFY3NEZVlwclAxT2JQd3EyQm9wWFFzMmZYdGxQUzcwa0d5ZzN0cTNI?=
 =?utf-8?B?MlByRFZDMnZyL3hKMlhCOXNteU51Vlg4TlBtWkNLbFR6MTZIL29UaTVUQkJ5?=
 =?utf-8?B?aXpzT2k3ZkRsVkxxU1ZqZlJEUkFxMkNCOVAyeURFMnlnQVBNTDh6bHBGMVdS?=
 =?utf-8?B?ajRYanNTUm1XQ2hvdXdsWnIxT0NGQjlhYXBOcGtDZ0djNkU5WlRtdVlSK1My?=
 =?utf-8?B?MmlsTEtnRllvU2tWU09mSU1ydXdQK1RZSWFyRHUrcUNkMzRVa0RweW9YRC9Z?=
 =?utf-8?B?UTFQcHNKREV1TjJMTUdGdisrcHhSRHhmUGhwd1ovSHpmdnp1Q3JhdnNJeGFS?=
 =?utf-8?B?dWFxMDFqQkNodHRzcWZ4WlI4YUl5bVBPcXd4MHloTW5BRndDdzdIdjJpK3FR?=
 =?utf-8?B?RVp4aGlvUnRWWWovb2luOVN5YXZqMVZJSDRCUXZjT3VhR1ZYZUx1WmVIYzNI?=
 =?utf-8?B?cW02VXhBUjV6bW80U1VrcVZ3aGROQlFRc092TXBYWFZIWWtIdll5b0xiTU5o?=
 =?utf-8?B?TlcrRy94Uk4vY0VMSjdrL1Qzb2I1OWlVZW1HWHN1T05jcEJtR2p5alp4YWU5?=
 =?utf-8?B?WHVmdGxhcnF4OTJmeVZMM2dhN0ZkbXJKYkN6ejE2QWhPMVpXN2k5S0RVVUQy?=
 =?utf-8?B?OFdpRlkzZ0hDUk5rVUtuakZTSy9kRDhmc3lUR0lRZjh3M05zUDB0YzZuZXB0?=
 =?utf-8?B?UlkzYWN6RXoraGp2bytEbnhwRnBualh0aEFmU1JmYlhLZUNOY2Q2dWlGSDI5?=
 =?utf-8?B?cGFZUHdpK3NlOXNWNGtsS0ZJZUdhbWtWV3RxNWxIMUwxNGlnbUpBakZJZzhU?=
 =?utf-8?B?ajVkRlVwR3V0M3k0bGFjVDY1aG5zR1Y0QXJBb0I2bG1WUEFwcTVBRTVIRlc5?=
 =?utf-8?B?NmVjU3lVbkMrNmczT1dKVWRTUnVWMlk4UEJpVlBnU2FSNW93eWtnRHNUSm1R?=
 =?utf-8?B?RzVvcHhCZEFscWpXM2s2RFVWMHhVWlBURUR6MHA1cTNrQUd2YmFFcGlrU0tV?=
 =?utf-8?B?dzIwbUt4dStoSVBQWHJwS1YxRlpIbU5EUGRESmZKaGRJVnYwOXE5V1FUdE92?=
 =?utf-8?B?UWxhQlhuYUFsVlJROGRCeDhjZWRLUDRWUmkxR2t1SysyZUo1RC9wS2M3MTdh?=
 =?utf-8?B?d2dBWUNwSEdVQTJvYnpxdmRKakFtZ3ltUXRBbWdLS0VkbXE2U2FFSDJWdzd0?=
 =?utf-8?B?bVdGYTF4WGZiaktWak5LM2ZYTERHSysyTVJCeGdvWGRnSFFPL08yME41Nit5?=
 =?utf-8?B?bTVCUkp3Y2VRVFd1RGJpekM0TlJrQjFZRXZ6NVNNYmhlYWdyWFNWdUhRUXlZ?=
 =?utf-8?B?ZXYrN2ZBSFJPUWkrSWhaNXQvL2xPWUhRT0pveVJpTVEwZjZhVVN1WEJ6Tjl0?=
 =?utf-8?B?c0Q4Y2FQQ0ZyTFZoNUV3ME4yREEvWGdZbWZ5UXdac3lTRFVIKzJkbGhlTGM2?=
 =?utf-8?B?KzRTbzNzOUNaYUYrZldNdkhnZUV2cEVuUStTaVBnYm9SejE1VS9HK1AxR0JY?=
 =?utf-8?B?RStGckdkalNlTTZWN2JWNVUzWEp3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbbdfda-528d-485a-a133-08dde623b310
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:55.9527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmPNgTcwUpKoHOCGLhkb6VrDjAwbAYh210PHqOwKO7uiZ9X1e3fRYRY1AdGvgerfj5w+6MY5YjmguLQCIOuTUyDP5Ylq0cQ0P6z5MMCop/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX1tWQbCuIStlH
 vbvC5r4BJyeFvuGCMGsfz34slRIYBPPg27V3cgyYHJkCuUU6Y0I5BCkP3Q2JVL2sZ061iJUtQgs
 9OZ2c76t8V/4pCBwIieaakGyTcH06WfBiC7b/3twTsLx6HBLnFP42KsXgfUxT+1GOrDLmrUp3Ep
 YKAoZHqxPaegN9qJydH1EFMOn9yQlBHtYHVY4C18E5atSntS/RJ9+i2cKrvp/FcT6GMdEiwqqmR
 mkwu4prEG2FAejidQ4Rv2qlal/fYiyeLgzR0ZIGSxY6K3xaQlwiaDfA6mgdHkIg3dii5mqb/rVd
 NONzV2uIeca7qapFGTpwfWBgL5U2l1yLNu3ctDOv+EJ6Fk0yzWejKfZz0pA3aU=
X-Proofpoint-ORIG-GUID: X_dbuVZVf7fGUyKq7BsP1MQaeO1qIrAt
X-Authority-Analysis: v=2.4 cv=IZ+HWXqa c=1 sm=1 tr=0 ts=68b03981 cx=c_pps
 a=iGETFsOoOHXRiUW2e12q2Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=VVXk-92eaM9LjyQm6BwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: X_dbuVZVf7fGUyKq7BsP1MQaeO1qIrAt
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

The headers for isapc-only devices can be removed from pc_piix.c since they are
no longer used by the i440fx-pc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_piix.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 988c9edc32..627de09c70 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -27,19 +27,16 @@
 
 #include "qemu/units.h"
 #include "hw/char/parallel-isa.h"
-#include "hw/dma/i8257.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
 #include "hw/pci-host/i440fx.h"
-#include "hw/rtc/mc146818rtc.h"
 #include "hw/southbridge/piix.h"
 #include "hw/display/ramfb.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/usb.h"
 #include "net/net.h"
-#include "hw/ide/isa.h"
 #include "hw/ide/pci.h"
 #include "hw/irq.h"
 #include "system/kvm.h"
-- 
2.43.0


