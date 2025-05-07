Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1F4C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgZy-0004Ym-Lp; Wed, 07 May 2025 11:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZu-0004Xo-NR; Wed, 07 May 2025 11:20:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZs-0005rp-KH; Wed, 07 May 2025 11:20:58 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54785SK0025158;
 Wed, 7 May 2025 08:20:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=LPzp7O3+XfxWWElUT+96P0eydKBodyDpW0HEPkVmI
 3I=; b=AYVBKT7pGBfxxYugsssO8e3eti1sHRg7NNiTR2jY+4Jdlx4lmV1zv2dIC
 pWy5fYil8ftvpfnvYFAOirFGt1ISD47DUBWqT8lUpyBmooQH/tSi6C/3TUGigRSe
 0KUAX+XRPP2bYJkEyJuGqnj5JMxedzk3id6fgpy4deCDQgb9P53cajBnZp3+WoHU
 VGQrcx8NYs+4xqVAykZeWZs9EYc3G4qwlUUGeUd1hfIE5yDV3Pa5kbQV/2+XS8y+
 p9DlxLx3lQBaW9ZvtGoTApTU/LgKh1z+Xo3ki3P/xx3GT0fv7pWnibOfHTs0HvPZ
 OFEn6sG/vXqCey/g3Te4Op6yul7XQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazlp17010004.outbound.protection.outlook.com
 [40.93.20.4])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dh8j1c8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmtyKzpJSy/vr8C4cz3j7ozqaP4bIIhxJUeqS2XqJezYyQ3ZWikzU5yVdTkhmm124UxULiZ2mQyREKOJ1I5fAPChhmjUVBIMNwMeAjJZxkKTK7TVJWnLmGNsaaG9dMODeT3Yo8MZjxDPHfCM7gdp36eVSRNAP6vPBYrTgkcoxFrnNJvBD+Cq0Q+Eoo7EG8s6om+W2rPVrNoCyk8ZsGtysgz6pNOuXdsBMPvt4k91LBMZVG95Ud/MCK/xQc/VyEqvZmLk0VIVP0bR10qbji3kVhpUDAacJUYBrq6ZENTrIQHEegeXWzHT0qIldJ3e7Jmn/qr4w/D9Lk1UZq0L6mj9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPzp7O3+XfxWWElUT+96P0eydKBodyDpW0HEPkVmI3I=;
 b=ofXhfE9uA6BsXCo3w48TzxWCIS0Rcv+7U5rw7pkdtTFytppzs26FvJAKk8LNuo6bHhqle7BP3QVYf7fzwyrm62C84UUECvoH7sf9CrTcZWWNx64zuzkRTh5MRIdKVmtQt3c/2CAbIf9PKyDGlYf1qguYRp1VvbslC+xpBaaHyfafneuK9oU/N98Vv/hFW6QL6/aILei1dsnG70KBGPfS5lRx0UET15xfhTp3IoCFj9twTyNf1Mq3sa/GdE18xn4UP5XYZ0vJ6GbPzCPPvz5a5FonBu7ayvXUES2YU2fESvEZCMHQNepiaB8I2eNMJI/hctwpTyAbfa6ASOOoqt+Qmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPzp7O3+XfxWWElUT+96P0eydKBodyDpW0HEPkVmI3I=;
 b=PRjLz8ypYITVDQTvK2bfrRQk1vDB2cmWlGXSMRrpHinTwPvL8Dg2WoXf7f/s9+fbWYqKKTdH8VXibIJzMFQFgOcuSB4OmYkhfGFZ1XR5FjAPxROR6SD9JUOZ0zOn2s4T0usU7e6GqIwR2nz8r+wdPNaahpmFF0xB33c85DJYfsLZvQapAIsyxBFJEirBbAYX5PMwGAaU/F5qgeDRUyme2uoChYqvrQPdFp3kuLljKtjY8WKF1s5NxNEgs24KolJUdl8Rk2HVR9ZmxgXCn5SKbGGHlDW5TSEjG7OPmR9iQv8uuvZb6xpKDI8RFm7no2eoUuBpYzlTD9mM7a3Xaps0+g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8220.namprd02.prod.outlook.com (2603:10b6:208:342::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:20:47 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:47 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 07/15] vfio: add vfio_pci_config_space_read/write()
Date: Wed,  7 May 2025 16:20:12 +0100
Message-ID: <20250507152020.1254632-8-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e64b5e-0171-4697-8936-08dd8d7abdfb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1BuVzBVN2hMZnNJdjAyclJxNUN2N2ZMcUJjTDlWU1ZGQlpEdEt5Nmt1TXcz?=
 =?utf-8?B?RlM0UDNBRDhkMndHZFJ3R1AzUGViYnIwdG5rWGt6azh6d3ZYZWJOUzZkWGJm?=
 =?utf-8?B?dHJ2TEJYN20yemdFVkVGY2dNNllXdVNnSVBXeVR6ZUE3b1FyOWNUZzlhSTgx?=
 =?utf-8?B?NXFTL2pOMkY1UmQwMzNuQW00WVhSclFQbGd1ZjJuaEF2MUR5NDBKZUZmbDZ4?=
 =?utf-8?B?ODdMNFF2cks0ZkZWWnJvUXpRbklPU0pmdENNYmRxUmhLZkFlN0JMWFRMNmFn?=
 =?utf-8?B?WllyUXdhdWNEaDE0QXczbjJ4bGoyVUNBWHZKelVDK0Y2VEUwQk1JMVhocEVO?=
 =?utf-8?B?YWRjejBobFFvc1RvenZiNjNONitRWGU5cWZWN1dYS1RUc2k1SjZwRnpDUGFJ?=
 =?utf-8?B?d1BjMENxV0p1MEFoc0NvbmRxWG8vT0RYN1FqL3ZQb0kwcmtCeUxlY0tkY3NP?=
 =?utf-8?B?K1B0eVhpVWVZTS9pdW1IRExid1oxcEY5N3BhbTZYYXpWQXhWWWNjK3dBdzZ2?=
 =?utf-8?B?QXM0RzNKVDYxbnRWQjkybXNwQkV4NmFGeUdrKzhJaWNRa1hLd2cwSVAxenU4?=
 =?utf-8?B?dC9VaUxob1NMczhXRWZ4QzlDbUVnQ2lYSXN0d2xnam5CRFhBVit3RXVBd2JM?=
 =?utf-8?B?VkxEc3Y5bGplcUtLTTltMkdNWjhjQzZqSXRmQmRZRktDb2t1WVVyTFNveTJB?=
 =?utf-8?B?RmVIL1ZTMnpuM3B0L1EySTBoR2FBcVFPamZBdGVZWGtBdlFIZXBDV29ES0ln?=
 =?utf-8?B?cE1GbFJObFlCeTBxaFdNME9CUkV0UjR3MGN2eDNIUldRYkdHWUwza0VGZ05m?=
 =?utf-8?B?VnNnNkRUZGRZakxXbVBhb2pmTlExZ28renFaK1hUemE1Smh1OWZkZUYra1VL?=
 =?utf-8?B?d2JlblByeWVoL3BRcUJvcGV3VGVOKzB1OXRzb2FZOHZ2WkZOekZzQ3NEa0pp?=
 =?utf-8?B?STk4Wi9yemRoOHBNUGpJMWJZUk82K0x4cTBTSW03MmQ4Si9FUzR2andRZzVa?=
 =?utf-8?B?S0QzTHQ3NW1TcDFjaVZadDgxZTBXUitHOURIQ1V5enEvaHdzenp6clNIdVUy?=
 =?utf-8?B?QVd3UGNrM1lmUXhLZkVTeEVSSlFVSmZ0V0JqOFRWUHhDYWxRN3RUK1ZvbHor?=
 =?utf-8?B?NVpscURUTDV4STBMNEJxaHNlaUp4dWxuWmV1U3U1SzExRXd5VzQ5MWFGYnQr?=
 =?utf-8?B?eStGK2hVcktSV1VjbGdjWkxMRU5OSC9tMkZPcTJQaFVYMzd6TlNsamZKRDh5?=
 =?utf-8?B?YStVNEYrRW9oWlM1UVptNURubHU0ZG5iQ3hPTUpnUy9DRlRzVU5ZbDlybnJn?=
 =?utf-8?B?c0g4OUlhcDIrTEFsRVBvM2VvK0VPZzdEdVc2S2NZbnlVVVB0MlpETGwrZGdm?=
 =?utf-8?B?NmllQTBNeTg0WFNTcDJlYldLaTVtYmZwT3lDZ05VVDBJZFJqVjBIWTFWUHlw?=
 =?utf-8?B?M2s2N2FEOVRUYVVVdHdqTlR4Mi90VXJrdnFkZmN6K2ZHK1U1Q3RHWkdiNVpL?=
 =?utf-8?B?WHBQbWxnaHBTNFVRSW85V3Zxc1N0K1ZRb1JremVHbzRBL0lBc3dEWW9pSmlC?=
 =?utf-8?B?VUZnYStkQ3pidGpzaXhDbGF1VHFaQmx6dVQ3SEZTQmpiUU43dm1Cd0M4VTZG?=
 =?utf-8?B?K2Z6Tm54SkVpcVdJeDNpeXJjWktHSVVkZWl4RGtUMnpWU0Qxb2t2SUJPMXFq?=
 =?utf-8?B?OEhFc2VPWlNVNGJtd3NleGpxcWFjUGYyTld2dGxBa1ZlWUhUL3lBQ25FcGlE?=
 =?utf-8?B?OWpJK1FadmxyWlg1YVJ2OTFTQ1EwSXU2bkI2amgyRG52MUtBSDV0ZFNKV2Er?=
 =?utf-8?B?WExQQlFBWWlvejYraDh0MnplaTFqbnVwTjIyQytjSDJYN1VUaTBCR3g0N0Js?=
 =?utf-8?B?Y2JSL1NxeEE1Ukw3dGdsMzlQYXpYN05yTm5xNTAvSzRuOUtuSjBlOXV6Zkxj?=
 =?utf-8?Q?esFpVzLN9OA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajJLQmJZZ1hOQ0ZrNXNjUFdYZjF2ZGVvU2NRWUVZRVFmbFU3VmFWZUtYKzI1?=
 =?utf-8?B?bGhUaHFnbUw1SzhUK2xsODBzM09IeW94dllxVTZTa0RQOC8rekw5dldVZjhn?=
 =?utf-8?B?YS8yaDFKRUIzcVIwYWwzT3QvbE9LSnVoa0RJdVltVUUwdy80SVE5WXh6bjJF?=
 =?utf-8?B?eHlrNlVyRW51Q2xOOTBFWW5RYlNIZVBFQjVSRU5WdklHeXV3RmZGcXN1M1c3?=
 =?utf-8?B?S0Q2R3ByYkEvNjBkMnRSUDgvS3Z3ZDZITVF6WnpqZ2tQVzVNUW5oakJnQ0Ri?=
 =?utf-8?B?d0F1czIrTFJJRnZUNG9DdlJhZ3B1VHR2OW45d2p6WE1MZ3NCa3hUbVdzMDZx?=
 =?utf-8?B?MTEzMHExQ1o0VFRObGQzREJLOUZIMCtIT3FIb3J3Z3JJVWh2VzlhL3I1VHpE?=
 =?utf-8?B?bzlPMVlHRlFiS1VMWUNiYmNUUWIrK3JrTm5wUjhreFJBWlo2Q2FZdHIwNHhl?=
 =?utf-8?B?aHhZSGVuQkt4NTZ0VG9UUm1SYnJMNlBJYzR1czRPWTNDbDhSNEwrc2xUL1RQ?=
 =?utf-8?B?SmVxM1R2YWI3MzNRd3dwS2NubnJMaHZVL010MzlUdTY0TG9lREFHNE5GVGdX?=
 =?utf-8?B?QnNNUXRSeTlRR0hPK3cxaDZiYkYzV29kK2txaUIzcng4SVNWWmh3aks3N1VU?=
 =?utf-8?B?bnkxMS9DRmNlcUtIZnEwVytUeWxpMTUxaDk3dU91dDFqcjFJYkREcGJ5R0JQ?=
 =?utf-8?B?OWFTNE5vWGNZQ00yQ2haTzR1MHVKNVpmL3ByR2pjMGNRWGhrNFZXTHY5SDB1?=
 =?utf-8?B?R2h3d04zYXZGUkZ3bSsxV2NTSWp0Q1JLcFI3UC9qV0tsU3A5bGYwSElla0xK?=
 =?utf-8?B?aWlUTmtiYVRHTWtubUJoNnR1NVUwMHRCdXEvZWVGRW0vWTJkRlpDb2d6YjdT?=
 =?utf-8?B?SjFVMDNLek9sU2dmWnQvbjg4MjZPa2RJUU56enJuWmRJY0RScnU3Wk11THlO?=
 =?utf-8?B?ZDJDUEZGZkN0VXFOWTB1aXB1dHMrRE5iWms4QVlqZUY2ME9pUitoeHpTcmF3?=
 =?utf-8?B?RGFEQU15cWNwdkpzYWtYMjZuOTFNRmxORGpjWGVENVB6UktTQ1RRc3EwcFlv?=
 =?utf-8?B?T0R0Z2RtZDJ6bXlwSEtuU2FBMC9SZ0owMHlQVytTdHlVenJ6OUlmMy9tKzIr?=
 =?utf-8?B?KzVPMEZaUFNwcUt3emQvdklrOVowNDdYRy9NeWxzZ28rRFFOZThCbFZnbzI4?=
 =?utf-8?B?Uk5aWkdtTGxsMFpZQ3IzOGdIb1FPdjAxNko5aEsrcFR6ODlIRmRQUHpPN1hR?=
 =?utf-8?B?eVRLdGNMTUJLdlp1TnRCM3RiZUMyUHZROHpOUWNJSDVZNTRkR28wYjdDdmlt?=
 =?utf-8?B?SG1QbC9GejllVFVDQkNSczkrUXlhUVBYMHhuS090QnhTb2F6MVhPbStEMjFV?=
 =?utf-8?B?dUNoN3YyRW9yTUNad3BWOW1mZFVWaG9hdStaa2FhcDlTa29DOVZ4eFE0SGNv?=
 =?utf-8?B?MFRpSnpqbG1hTkswaEUyQnRtR0N2aXh5Q1h1RWUvdEw1Z1Jzb3JBQm9jQlds?=
 =?utf-8?B?dDZjMk9xODVyVG1jckVKSWFVTUdZQ0RQOXhTOGFEQTZJcWVtSzYxRUdyWDJx?=
 =?utf-8?B?QlFGeDNWUjBUeWt1YXpNM0JzbTl0c3lKOXY0L2UwRHYwbURFUnF5VE1mRGFV?=
 =?utf-8?B?RGxVU2pldWQrT2NXcDNldW9ZZ1hNSUd5RXlHVXhBU0I0UUNlekJuSVpYeXJJ?=
 =?utf-8?B?ZTdFeWdmcHNpeFR4UEFrQW1YdTI2L1gwT3Iyb2twdkcxOG9nRy96TWo5N0dy?=
 =?utf-8?B?eU9oczZRTjVLT2ZFZFNEVjZ5SG1SL3VlclMrdmVrdHZ1R3lLMlZ1emVxVUY1?=
 =?utf-8?B?L3pOMEpOMDdlTTVVa1JFQW9WYnZyN3llWnBYL3dvZy9VRkRxLzkwN3pIeFBn?=
 =?utf-8?B?eXJ2aTZmZktXN0loZzBMSjVYMVlITVEvMTF4M1hzVElpb0V0SkcvKzgvMlhy?=
 =?utf-8?B?amxkT0ZWNURSOVhMNzlNRjdNaHdIMk5sTXdRVmxEV0xYYVZKaytwQnRqdUR0?=
 =?utf-8?B?RUM0NjV4OTIzRUNBRVRZa3AzbFFuV2pBVG5UcHA4dTk2WVMyVXdGUU9hZmd4?=
 =?utf-8?B?RWVqcnNDR2hxTlJhdUJaWlhWUzJ4Z05BbUxJZG0weERpbnU0c2k0RVpzbUpR?=
 =?utf-8?Q?vdbexJHL8pwWlHU6AWoLbwcG7?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e64b5e-0171-4697-8936-08dd8d7abdfb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:47.1808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQZtn429ypQ1UXoMHpWdZRDMnm8kir5Icwk7gKn7GA9ilq5KGic1P7+R99e+DqrpCi3dNR7yJb/llHTM74gCXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8220
X-Authority-Analysis: v=2.4 cv=B/y50PtM c=1 sm=1 tr=0 ts=681b7a54 cx=c_pps
 a=i94dX+5hBIrr0Xz7fFY0Kg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=uWZQxr4v0eqUK10gj4gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jvDrF7tOr3RRXz3M5d0d7ZTA9W0aLtLU
X-Proofpoint-GUID: jvDrF7tOr3RRXz3M5d0d7ZTA9W0aLtLU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX3b3GDbot5tju
 QGnboozfaoyfOqkh9MieIR9bTXFHNDRtRrRw544KuRI4Tb3x4k5sXe6Wr1InR0pBfgGA0n5WKp5
 qDg2ReMoGVLjEvUuTOfUJ593ZMXvcTzUTT8CsGZqN2oZ4gkoDO/ba2FUN6dZYfIZW/Sc44DGIoj
 I2tSvaKPSnMZAjrRKTuJ1i2JGGVz3s5yoRxQoXr9CWaZoyRgHrC1CBuFhQUVrwC9TpgRH8iC9Vw
 3+9BKAKzi5K5q0yUgz07K/LrAEFPtfpeuzFFfpIO2ODWVXNy5KE1JbdQgFUWGNqj1ERBbxS4xkG
 5+205avZ/BGz0fylB2ZuPMZfnO1Um3F6FiCR38zlVDkZSuzXgzGlQ6p/UDMePbqE74NrEJmdRw3
 biBMr6dQ8PjPa3MMo3bN3Kz08lye1UVyMOH12z0R3/nh49YXG3kDrOsPmyx7wiT0cHme6u90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Add these helpers that access config space and return an -errno style
return.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 123 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 80 insertions(+), 43 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 866cf58d04..f65c9463ce 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -967,6 +967,28 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     }
 }
 
+/* "Raw" read of underlying config space. */
+static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
+                                      uint32_t size, void *data)
+{
+    ssize_t ret;
+
+    ret = pread(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
+
+    return ret < 0 ? -errno : (int)ret;
+}
+
+/* "Raw" write of underlying config space. */
+static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
+                                       uint32_t size, void *data)
+{
+    ssize_t ret;
+
+    ret = pwrite(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
+
+    return ret < 0 ? -errno : (int)ret;
+}
+
 static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
 {
     VFIOPCIDevice *vdev = opaque;
@@ -1019,10 +1041,9 @@ static const MemoryRegionOps vfio_rom_ops = {
 
 static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
-    off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
     char *name;
-    int fd = vdev->vbasedev.fd;
 
     if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
         /* Since pci handles romfile, just print a message and return */
@@ -1039,11 +1060,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
      * Use the same size ROM BAR as the physical device.  The contents
      * will get filled in later when the guest tries to read it.
      */
-    if (pread(fd, &orig, 4, offset) != 4 ||
-        pwrite(fd, &size, 4, offset) != 4 ||
-        pread(fd, &size, 4, offset) != 4 ||
-        pwrite(fd, &orig, 4, offset) != 4) {
-        error_report("%s(%s) failed: %m", __func__, vdev->vbasedev.name);
+    if (vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4 ||
+        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4) {
+
+        error_report("%s(%s) ROM access failed", __func__, vbasedev->name);
         return;
     }
 
@@ -1223,6 +1245,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
     memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
@@ -1235,12 +1258,12 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
     if (~emu_bits & (0xffffffffU >> (32 - len * 8))) {
         ssize_t ret;
 
-        ret = pread(vdev->vbasedev.fd, &phys_val, len,
-                    vdev->config_offset + addr);
+        ret = vfio_pci_config_space_read(vdev, addr, len, &phys_val);
         if (ret != len) {
-            error_report("%s(%s, 0x%x, 0x%x) failed: %m",
-                         __func__, vdev->vbasedev.name, addr, len);
-            return -errno;
+            error_report("%s(%s, 0x%x, 0x%x) failed: %s",
+                         __func__, vbasedev->name, addr, len,
+                         strreaderror(ret));
+            return -1;
         }
         phys_val = le32_to_cpu(phys_val);
     }
@@ -1256,15 +1279,18 @@ void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t val_le = cpu_to_le32(val);
+    int ret;
 
     trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
 
     /* Write everything to VFIO, let it filter out what we can't write */
-    if (pwrite(vdev->vbasedev.fd, &val_le, len, vdev->config_offset + addr)
-                != len) {
-        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %m",
-                     __func__, vdev->vbasedev.name, addr, val, len);
+    ret = vfio_pci_config_space_write(vdev, addr, len, &val_le);
+    if (ret != len) {
+        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %s",
+                     __func__, vbasedev->name, addr, val, len,
+                    strwriteerror(ret));
     }
 
     /* MSI/MSI-X Enabling/Disabling */
@@ -1352,9 +1378,11 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     int ret, entries;
     Error *err = NULL;
 
-    if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
-              vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
-        error_setg_errno(errp, errno, "failed reading MSI PCI_CAP_FLAGS");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_CAP_FLAGS,
+                                     sizeof(ctrl), &ctrl);
+    if (ret != sizeof(ctrl)) {
+        error_setg(errp, "failed reading MSI PCI_CAP_FLAGS: %s",
+                   strreaderror(ret));
         return false;
     }
     ctrl = le16_to_cpu(ctrl);
@@ -1561,30 +1589,35 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     uint8_t pos;
     uint16_t ctrl;
     uint32_t table, pba;
-    int ret, fd = vdev->vbasedev.fd;
     struct vfio_irq_info irq_info;
     VFIOMSIXInfo *msix;
+    int ret;
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
     if (!pos) {
         return true;
     }
 
-    if (pread(fd, &ctrl, sizeof(ctrl),
-              vdev->config_offset + pos + PCI_MSIX_FLAGS) != sizeof(ctrl)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX FLAGS");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_FLAGS,
+                                     sizeof(ctrl), &ctrl);
+    if (ret != sizeof(ctrl)) {
+        error_setg(errp, "failed to read PCI MSIX FLAGS: %s",
+                   strreaderror(ret));
         return false;
     }
 
-    if (pread(fd, &table, sizeof(table),
-              vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_TABLE,
+                                     sizeof(table), &table);
+    if (ret != sizeof(table)) {
+        error_setg(errp, "failed to read PCI MSIX TABLE: %s",
+                   strreaderror(ret));
         return false;
     }
 
-    if (pread(fd, &pba, sizeof(pba),
-              vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_PBA,
+                                     sizeof(pba), &pba);
+    if (ret != sizeof(pba)) {
+        error_setg(errp, "failed to read PCI MSIX PBA: %s", strreaderror(ret));
         return false;
     }
 
@@ -1744,10 +1777,10 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
     }
 
     /* Determine what type of BAR this is for registration */
-    ret = pread(vdev->vbasedev.fd, &pci_bar, sizeof(pci_bar),
-                vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr));
+    ret = vfio_pci_config_space_read(vdev, PCI_BASE_ADDRESS_0 + (4 * nr),
+                                     sizeof(pci_bar), &pci_bar);
     if (ret != sizeof(pci_bar)) {
-        error_report("vfio: Failed to read BAR %d (%m)", nr);
+        error_report("vfio: Failed to read BAR %d: %s", nr, strreaderror(ret));
         return;
     }
 
@@ -2450,21 +2483,23 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 
 void vfio_pci_post_reset(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     Error *err = NULL;
-    int nr;
+    int ret, nr;
 
     if (!vfio_intx_enable(vdev, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
     for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
-        off_t addr = vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr);
+        off_t addr = PCI_BASE_ADDRESS_0 + (4 * nr);
         uint32_t val = 0;
         uint32_t len = sizeof(val);
 
-        if (pwrite(vdev->vbasedev.fd, &val, len, addr) != len) {
-            error_report("%s(%s) reset bar %d failed: %m", __func__,
-                         vdev->vbasedev.name, nr);
+        ret = vfio_pci_config_space_write(vdev, addr, len, &val);
+        if (ret != len) {
+            error_report("%s(%s) reset bar %d failed: %s", __func__,
+                         vbasedev->name, nr, strwriteerror(ret));
         }
     }
 
@@ -3101,6 +3136,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     int i, ret;
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
+    uint32_t config_space_size;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -3155,13 +3191,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
+
     /* Get a copy of config space */
-    ret = pread(vbasedev->fd, vdev->pdev.config,
-                MIN(pci_config_size(&vdev->pdev), vdev->config_size),
-                vdev->config_offset);
-    if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
-        ret = ret < 0 ? -errno : -EFAULT;
-        error_setg_errno(errp, -ret, "failed to read device config space");
+    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
+                                     vdev->pdev.config);
+    if (ret < (int)config_space_size) {
+        ret = ret < 0 ? -ret : EFAULT;
+        error_setg_errno(errp, ret, "failed to read device config space");
         goto error;
     }
 
-- 
2.43.0


