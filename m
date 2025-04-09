Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2BBC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VnA-0006Cy-TX; Wed, 09 Apr 2025 09:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vn7-0006BR-Ag; Wed, 09 Apr 2025 09:48:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vn4-0005bZ-Jz; Wed, 09 Apr 2025 09:48:32 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539ABnMi024552;
 Wed, 9 Apr 2025 06:48:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BDGBxzzjxLjKnpc5zeTGTq4gng2DG170Yq+BvTZ1X
 us=; b=O4DCN5ZalE1ovHFqJQWfhxak4jbO6/XxlyoBODSFZ441T0X3GBlz3SnJz
 a39kZu++kmb7FZ4Q52xfgSoLtA3muR+eMNRdVm/T6jsgNo+YHx0nxQU9uNhJyVEp
 XDyKRGywcDE56VBwB1s6US6QHSQUnK4VQ5spO/QrtbZSI1YCECYq9q+alpM+mZxr
 unN0P+ccWQfMJ0kP+TGfPzCmrz4ahsio8cas/deGve/B5z9oWMizB5m4l7lvSVFI
 oHN3mc4DhbmmCWo3wU0Exaa2dz0jVO5/kV8/IQaipQWbkbClKKPEhiKuBQAcYGid
 CO+W+egt0UOaZt/6eHgn9rwTo6MZw==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazlp17010002.outbound.protection.outlook.com [40.93.13.2])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45u420syha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZK4SmfllsQjd7tAVgGW+eG8WVO3wF293CZ1mX/5yYkc9CWE5uDz8W7Zu0c6wm1nHQgTcmK/DK9HQ0or5H7isYTIUvF+sEV4lZBf8jB4HFNS0MLoyVUe/yeEW71DRhPFnPYH69N/DuieYQQ8yzhIB2d5WFEWKFfXtCj2s6de87ugmc6trYlmKIWVe+nTwHc9dTXTh5yvx76OOdWoAGhglCFHbxTXz4YgM+vsXNEG/UbvaMJk0igIW8Qwz9GcY++J2SJGDBhkKXlHMVBluIH/XIc6YaPt0A/YSYrivW2R68lEbQgQEHH5HzLrgAr2VzRCjmN38wGoRUCA2mHllSWchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDGBxzzjxLjKnpc5zeTGTq4gng2DG170Yq+BvTZ1Xus=;
 b=Nc/zsslmFZhlpQCNAZoV86Zk3jEaRd/+SKjIQcVnU5IGCTFcwzRPAosbiypTjGxRHP/1G4z/HC/K7FsHVBtpuYN9ju2AXn5CehTo12bu1gND8ETGhqAqr1cy8oJfHX7TSOuDxZxs6mEWyTxi9rHPbeTnxWIgtk/ZMxbD9ywF1lRJIU/k05JwVz41fU7mXfPNV7dzYCkvvx0UT3LjFm78Woi+vy4ha5qXDDSkQLmV8pcF4+abftZb2MI752aBBvx8lmmy2BfmUKm2Fv24fiQsnVuIc3vFOG9kmhVOsBhk0erG6VB46y4vz3Rg+fvIxbC7dN0NwomjKtcPriVLpI3L5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDGBxzzjxLjKnpc5zeTGTq4gng2DG170Yq+BvTZ1Xus=;
 b=WrOL416OyroxaqsR4P6DfwyJhhZckulY1m78pOQXGjdG2UCK7zLjD6aBntUq9ViSFdg3F+ghpaSdRnqDqAz3DsgFr9okC8fWyA4GVZZ41OsDe6gn4lbTyA1cY3MWgvCTN5UfmqJDeBsmoXBqllsFXNy58mZfdRK7nqU25AT/mdmk//AfXVZk+0UUFXjIyXuYhKpBXpI12dVb3IyktksffgDOCqvq2vESXPH2PRbtXJGPZgUCjv8pMTq0JJjDgCkkY56Vt9LdQg6RYCq0Z5TZRe6uv7F5X5WsjUwdPHpwHjGDWxGa/vLZn5McUPobDmeNLiWCnFEytMLuy0sOFg4CDw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MWHPR02MB10356.namprd02.prod.outlook.com (2603:10b6:303:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 13:48:24 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:24 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 02/14] vfio: refactor out vfio_pci_config_setup()
Date: Wed,  9 Apr 2025 15:48:02 +0200
Message-Id: <20250409134814.478903-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409134814.478903-1-john.levon@nutanix.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MWHPR02MB10356:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd8c039-1fe1-4440-6a24-08dd776d32c3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlRqSU5qVmNnY2FBZHE3dlpFemM1dDAyQngyR29tNUhYOHFZS1FUZDNQR0hp?=
 =?utf-8?B?N3dxYlBpWlpmNWxzOGc3aFYvWWhPRmVEYjkxY0xna2RyVExLLzJRdndWeVJm?=
 =?utf-8?B?eXpncGZ4M2g1K0l5cXJpeXA3UTRLZDloUWRlYzdycmxmbjJydGRNTDM5eVRn?=
 =?utf-8?B?bDNZeG52OGFxb01XbFZhZEJwSDZhSlU0M1ZzYUhiUnhncWNpdTRxWTF3RGZn?=
 =?utf-8?B?SDlVamt6R21tWmtSa2xtZ2dORmFsNnJTMW5SS2xNWnB1Y3BXblBmV1I0Y2JC?=
 =?utf-8?B?eXhWUG1yL1RMK3pGcnVpRmFpTG9uc051QS8xemdjbThoWXRxL2ZVa2NtZ3Nr?=
 =?utf-8?B?YmM4Ty9yTHpWZ3ByZWQwTXZwVC81SVNZL01CaGNyc0dJMDIva2YvZDdjcWlJ?=
 =?utf-8?B?TFVibTEzbklNRzNydktjczJUT0Q0S25xNXJpb0hWdjVyVDN3dHhLSVFvUFoz?=
 =?utf-8?B?VUkydnR4NnE5clUvSVB4cklDRy80endibnVrc3JwTGZSaXFmb2JWS3FROWtq?=
 =?utf-8?B?VW1EUUJ4alBCTFEzazhQYWtzcFdpbThuREs3ZmdBeUlzYS9lMnJHc3QyMWdw?=
 =?utf-8?B?VnJxdjAyYjIzR2xrUkZtaEQ2SEc2OUdrMExvRmM0cU1nK2hZNFdTOU1WU2h2?=
 =?utf-8?B?eHMvSktQa3FESXlWMkdUMTNrY0pYalJDZklicTM3QkhkRkdjejh1Q2l6MWNx?=
 =?utf-8?B?VWhqdXp3bmg5Mk10TDRtQ2RPZTBtbHBya2o1L3NUc0pMWXhaZ05FdVc2YzBG?=
 =?utf-8?B?MWZhUW5MR2NEaG56L3R3c01QNjB2Nld3WExuWi82L3M1M0VaVTF5YzRLMWts?=
 =?utf-8?B?ditNR1dFN0cwc0tuVUY0RTh6U2UvVkk5UEdwSWFwUzBTbGRaNDJXMXl5RnVL?=
 =?utf-8?B?dzdjWjFhd0t2V2FGV09BN3pYYzJGMzZwQkh4NDVkdUVDamxUU1NtNHVDMVhs?=
 =?utf-8?B?VmFlT0U5QXIvcGc3U2I1cmFNam13NnlIcTVGVmNzTEFPYVNPcm0wTG95bStN?=
 =?utf-8?B?ZGpLQm5kL1l2cE1wKy9YTk9yeGkwVzJaallzL2h2Nk1zUWd2NnFQbG1aZ1J2?=
 =?utf-8?B?N3RIM095bkxqdklubTM3bUkybnNubzVXbUhGeHozWFhZV1dJMjI4ZVRmd2Vo?=
 =?utf-8?B?cUxmK2tURmtEM0xHeU8wS3JzMkl5emw3ZXRtemhwdWl0RjYvODFQVm44S3J3?=
 =?utf-8?B?WXJRZ1hxVkI4L3NNbjdCUWhNR1o3R1ZnRVd3TXREVDI2MmNUSGxhbFRSL1dw?=
 =?utf-8?B?eFYzcUExdDFBbUdWUzVockkweXNSTlZ5YVJmYXpzOUpnRVdZc2hjaTBaREwx?=
 =?utf-8?B?K2pOa3FYZE10dWRoaWcxdGs3Nm5tWVZ2UmlKS3ZwbFNocW1qNEVxYTY1QjIz?=
 =?utf-8?B?eVpnSzByclN0dE5NeXZCaDBSNzlCQmExdWtDdjhYdVNzbDdUUTdjc3JlWVo4?=
 =?utf-8?B?ZUNOTGluYmZyZ0M4cjIvNVIyWGIrbUs4UitnOVhtOUNLeGI0eGxKbVpOSUM3?=
 =?utf-8?B?UDRNeG43VWE3RFJXd085T2VOU3M0TGVzVjNhTTNEdzhocklhL0ZySHFoYmVS?=
 =?utf-8?B?Y1NYbURuaVVZNkNnZXJYc3NMQXdXK1UxRitINE9IQ09mMnE2ZG5Ya0U2OVll?=
 =?utf-8?B?eWJDejZyVUZtSXBYd0gwdjVmU3p5Ui92amhDLzBQVTRJaXNyNlN6VklLdDRN?=
 =?utf-8?B?Q3E0U3JTd002bnN0enJRQ2RBSmtlQko2VG8vMWFSQ0hOcE5NQXFCNExmeTNL?=
 =?utf-8?B?dko1aWRlakpwaFIrSFJiMkJIWldXdnkxM0QyQ2JaOEl6bGhBaGxDc09zT1hi?=
 =?utf-8?B?azZyOVRObGVLdFB3dmN3SzRFenQ3N2UrOXRlVGc1Z3FKcEg5NlhOKzAxQktD?=
 =?utf-8?Q?HpKmPi6VWdQfo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJyN0RDWkp1NmFmdFRQTUN5bVRVUVlYSzlDYTIyVUF6ZS82N29oVk1HNy94?=
 =?utf-8?B?eEhTNGxKOGpBVEdtYTFFek5SUnYvcFdZS0QzSlBjSlFnbFJjOHg4Z3V5ck5p?=
 =?utf-8?B?Q1YzNU0wMUQxdVh1ODQ2VmVrRnJGS3VpMXl5MFZ0Wm5RcElPVHJNb25pUFBm?=
 =?utf-8?B?cGMxTEU5Y3Z1dWdkeElIRnZlelcxT0FMdWhTMkdVUVgwdFJaRDFCeHVWWWFT?=
 =?utf-8?B?QWM5Sm1iMHdhTTJaNGwvY1FGSWRqWGRDdlJtWGVLYzJ5YXdXNU1oejRlRDJk?=
 =?utf-8?B?dUhVNGkwWnIrZVpRS1E5MFVpTzZaK0I5S0ZQVmdKZHhTT2xVMHJmZ1o1cC82?=
 =?utf-8?B?dHU1NEpobFl4TnROZ3FjTWdIVndnLzBIemRwdmQ1SEdHSTg3SnV1R2lvdG1n?=
 =?utf-8?B?OEJyWnp3ZXEvOG1nYzBrVGtiTkV5UXBhbG5ld0hXL0V3WXgzbXA5b2hKVjNk?=
 =?utf-8?B?SytnYTB5LzE5WmlNZDVScFJzRDg1ZFI3Qi9DT3dyZU5aZXJ3ZmE2cUpQSHRK?=
 =?utf-8?B?VlFoVFBaSlZMWEhTcUlWYktKblBib1RzU0hYVUFEVlVLTVB0NktNdVBpS25O?=
 =?utf-8?B?ZVVuUGxoU0VQQTZjRHlDMk5aQ1NUWmdoaExteWQ0S3ZsMFlvT1hGM3gzMUdL?=
 =?utf-8?B?ak1pSE8xaVMxN3Y0bmxVb21YN3ZTd0tObVBaLzUzZmZITS9MYjRKL0pMbVFs?=
 =?utf-8?B?MERRaEJPT0ZoN3N2M2tXTUY5ajkrN0txNHlUSWx0Q2NsNjVhSzV4dFRuajlD?=
 =?utf-8?B?eUdHMnptSzZNdEhwRjBJU1Z3SHQxbnduT2t0RFBYZVd3c3kxaFpOMEVyck11?=
 =?utf-8?B?cytrZGdLT1hlWmovVHM2S1NoUFRqM0xvaVdFN3NZZ1dEaGVocms4YW9iNFJW?=
 =?utf-8?B?elIvWFZCRFRHVnlhZUJCRlBTeGpNenNSYmlnWkh2SHRUbVdSSG1kUkNJRHda?=
 =?utf-8?B?S1RtVEpVYndkZE1Xa3BQd2xURHJrK1R5UGF1blJkU1cxUDB4aGhic28ybTE2?=
 =?utf-8?B?OHRKWjRTQVU1aE53eDd1N0poZlZhMGxjUURVUDlxOE9yQVZDcmRSMDA2Nmtm?=
 =?utf-8?B?cmxUZnFIY1pVekt5dlRwVnFOUjBTbDN6VTQ5YXFkV1lrRDlpWkZieDM1MHZ1?=
 =?utf-8?B?OXdycnk5My9nUzR5NFpGK1p6Y0l4Z29uRGE2L1BPbVRoL0lQVmlqZ3NVQnNJ?=
 =?utf-8?B?U1E3STRhVGVEVC9DejhkUXZsSE9DczZvQmp1MG9xdjJhbVVhb2duVDlVbE8w?=
 =?utf-8?B?czh2eE12czNEenBuaWQxb2RkdGFoNzEzL3RDQ0xLU2hGdk1wbTBNZUNsYUtR?=
 =?utf-8?B?azdDUkVGMWkvVmtEZkFmOFUzLzl4SzB2b1JqWUhZSHg3UmZrQ2JlcDhCeHR6?=
 =?utf-8?B?cW5ianR4YkJHNFZXS2pMc0l2Ymk0VzdtVXcxRjh4Zk84eHdaQVkzek15OE5w?=
 =?utf-8?B?V3dNOE5OS1dKbzdEcDRFN0NzUlFnTDBTclptTkNVUHNjWUZ6b25tUHZnekhT?=
 =?utf-8?B?RmI5QzRyeFhBVWNQcHQzcE1mQ1VTZGJGOW9SbkEzQ2s4WjdjcnRnQm5GWmt5?=
 =?utf-8?B?Tk41TW1VdEk3RVN2U1VFU01RUUl4TzZNSURoazBaeGM3cVlpNW8vMkx2MUNQ?=
 =?utf-8?B?dFYrVnJLRklXMmh6T0FlektNQ25sWFFlMkxxK1ZzbEV0TjBqUU1QL0hJWkNK?=
 =?utf-8?B?U0QwbXN5UXBSY3RqNkJONDJIK2lOQ2NqWm5rQnVNWWRyVDNQdnNvRVRZQ1ZW?=
 =?utf-8?B?NlIyWDJaR0NjRE16UFp1OGYxUEJnT0YzaE15OEF5bHVoVDdtRFQ5ZXNkOGIx?=
 =?utf-8?B?Mk0zd1YxRmFXYVlmR0tDYkJBQTVyVDJkQTBpZ28yWkt3cVFQTHdsY0tuNWVn?=
 =?utf-8?B?VFZaZHo1N3dsZnU0ZWVNc09rc1JGYjBENk83aHdYYVkxYmQ0ZFZ4Y1FJNWlt?=
 =?utf-8?B?OENZdDJJUzBUL054NlRLR3BVcFVyNG9yRXdTTlo2Zkc3NkRrTGpFUSt1Tlhu?=
 =?utf-8?B?N2NvYXRzeURpUm9naWs1Ri9PVjhOWExxWUREWmhZMnp0Vzc3K0xzQ3NQS2x4?=
 =?utf-8?B?T3IyNFEzVEdBQmhML1ZsZHBBbkVrUzF6b2dSalA3aEZPTmoxZkRmYjlETGxX?=
 =?utf-8?Q?ApksZNwt9OiBU6Uh4ssPLZqVm?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd8c039-1fe1-4440-6a24-08dd776d32c3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:24.5061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knUaxox3Y5YaSUNRduJvgT9mwptRGbg6xEDk43Wv6Gmy0fDPVK3EXBSvxbyCyHoXVH7F7HiNDkebeK12+AsCtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10356
X-Proofpoint-ORIG-GUID: VRzeD4_e0Ode4lVNI2dt0UAuzWP-TZBq
X-Authority-Analysis: v=2.4 cv=TeGWtQQh c=1 sm=1 tr=0 ts=67f67aaa cx=c_pps
 a=rknZK0v7KRh+kGA6vhtu4g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=q3r9P8AP8Ax0Fte6b8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VRzeD4_e0Ode4lVNI2dt0UAuzWP-TZBq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Refactor the PCI config setup code out of vfio_realize() for
readability.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 176 +++++++++++++++++++++++++++-----------------------
 1 file changed, 94 insertions(+), 82 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 02f23efaba..81bf0dab28 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2963,6 +2963,99 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    /* vfio emulates a lot for us, but some bits need extra love */
+    vdev->emulated_config_bits = g_malloc0(vdev->config_size);
+
+    /* QEMU can choose to expose the ROM or not */
+    memset(vdev->emulated_config_bits + PCI_ROM_ADDRESS, 0xff, 4);
+    /* QEMU can also add or extend BARs */
+    memset(vdev->emulated_config_bits + PCI_BASE_ADDRESS_0, 0xff, 6 * 4);
+
+    /*
+     * The PCI spec reserves vendor ID 0xffff as an invalid value.  The
+     * device ID is managed by the vendor and need only be a 16-bit value.
+     * Allow any 16-bit value for subsystem so they can be hidden or changed.
+     */
+    if (vdev->vendor_id != PCI_ANY_ID) {
+        if (vdev->vendor_id >= 0xffff) {
+            error_setg(errp, "invalid PCI vendor ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
+        trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
+    } else {
+        vdev->vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
+    }
+
+    if (vdev->device_id != PCI_ANY_ID) {
+        if (vdev->device_id > 0xffff) {
+            error_setg(errp, "invalid PCI device ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
+        trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
+    } else {
+        vdev->device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
+    }
+
+    if (vdev->sub_vendor_id != PCI_ANY_ID) {
+        if (vdev->sub_vendor_id > 0xffff) {
+            error_setg(errp, "invalid PCI subsystem vendor ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
+                               vdev->sub_vendor_id, ~0);
+        trace_vfio_pci_emulated_sub_vendor_id(vbasedev->name,
+                                              vdev->sub_vendor_id);
+    }
+
+    if (vdev->sub_device_id != PCI_ANY_ID) {
+        if (vdev->sub_device_id > 0xffff) {
+            error_setg(errp, "invalid PCI subsystem device ID provided");
+            return false;
+        }
+        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
+        trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
+                                              vdev->sub_device_id);
+    }
+
+    /* QEMU can change multi-function devices to single function, or reverse */
+    vdev->emulated_config_bits[PCI_HEADER_TYPE] =
+                                              PCI_HEADER_TYPE_MULTI_FUNCTION;
+
+    /* Restore or clear multifunction, this is always controlled by QEMU */
+    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        vdev->pdev.config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
+    } else {
+        vdev->pdev.config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
+    }
+
+    /*
+     * Clear host resource mapping info.  If we choose not to register a
+     * BAR, such as might be the case with the option ROM, we can get
+     * confusing, unwritable, residual addresses from the host here.
+     */
+    memset(&vdev->pdev.config[PCI_BASE_ADDRESS_0], 0, 24);
+    memset(&vdev->pdev.config[PCI_ROM_ADDRESS], 0, 4);
+
+    vfio_pci_size_rom(vdev);
+
+    vfio_bars_prepare(vdev);
+
+    if (!vfio_msix_early_setup(vdev, errp)) {
+        return false;
+    }
+
+    vfio_bars_register(vdev);
+
+    return true;
+}
+
 static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
@@ -3067,91 +3160,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    /* vfio emulates a lot for us, but some bits need extra love */
-    vdev->emulated_config_bits = g_malloc0(vdev->config_size);
-
-    /* QEMU can choose to expose the ROM or not */
-    memset(vdev->emulated_config_bits + PCI_ROM_ADDRESS, 0xff, 4);
-    /* QEMU can also add or extend BARs */
-    memset(vdev->emulated_config_bits + PCI_BASE_ADDRESS_0, 0xff, 6 * 4);
-
-    /*
-     * The PCI spec reserves vendor ID 0xffff as an invalid value.  The
-     * device ID is managed by the vendor and need only be a 16-bit value.
-     * Allow any 16-bit value for subsystem so they can be hidden or changed.
-     */
-    if (vdev->vendor_id != PCI_ANY_ID) {
-        if (vdev->vendor_id >= 0xffff) {
-            error_setg(errp, "invalid PCI vendor ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
-        trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
-    } else {
-        vdev->vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
-    }
-
-    if (vdev->device_id != PCI_ANY_ID) {
-        if (vdev->device_id > 0xffff) {
-            error_setg(errp, "invalid PCI device ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
-        trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
-    } else {
-        vdev->device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
-    }
-
-    if (vdev->sub_vendor_id != PCI_ANY_ID) {
-        if (vdev->sub_vendor_id > 0xffff) {
-            error_setg(errp, "invalid PCI subsystem vendor ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
-                               vdev->sub_vendor_id, ~0);
-        trace_vfio_pci_emulated_sub_vendor_id(vbasedev->name,
-                                              vdev->sub_vendor_id);
-    }
-
-    if (vdev->sub_device_id != PCI_ANY_ID) {
-        if (vdev->sub_device_id > 0xffff) {
-            error_setg(errp, "invalid PCI subsystem device ID provided");
-            goto error;
-        }
-        vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
-        trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
-                                              vdev->sub_device_id);
-    }
-
-    /* QEMU can change multi-function devices to single function, or reverse */
-    vdev->emulated_config_bits[PCI_HEADER_TYPE] =
-                                              PCI_HEADER_TYPE_MULTI_FUNCTION;
-
-    /* Restore or clear multifunction, this is always controlled by QEMU */
-    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
-        vdev->pdev.config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
-    } else {
-        vdev->pdev.config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
-    }
-
-    /*
-     * Clear host resource mapping info.  If we choose not to register a
-     * BAR, such as might be the case with the option ROM, we can get
-     * confusing, unwritable, residual addresses from the host here.
-     */
-    memset(&vdev->pdev.config[PCI_BASE_ADDRESS_0], 0, 24);
-    memset(&vdev->pdev.config[PCI_ROM_ADDRESS], 0, 4);
-
-    vfio_pci_size_rom(vdev);
-
-    vfio_bars_prepare(vdev);
-
-    if (!vfio_msix_early_setup(vdev, errp)) {
+    if (!vfio_pci_config_setup(vdev, errp)) {
         goto error;
     }
 
-    vfio_bars_register(vdev);
-
     if (!vbasedev->mdev &&
         !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
         error_prepend(errp, "Failed to set vIOMMU: ");
-- 
2.34.1


