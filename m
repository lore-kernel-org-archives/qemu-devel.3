Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987C3C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 16:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7zRH-00035R-2q; Thu, 24 Apr 2025 12:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u7zRF-000346-0O; Thu, 24 Apr 2025 12:28:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u7zR7-0001Mt-GU; Thu, 24 Apr 2025 12:28:36 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8G1Wb013735;
 Thu, 24 Apr 2025 09:28:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Q0eh5+zQpxupPKb8Btx7rHE8weHlpnDkz5XIXdFZx
 lw=; b=bFHtTSHi0ZeDj3mHL16lNk+2/t0wQPDLpWRPmVdbiPhb18ClnpasJP3DK
 ix08ug11NAkgbdcVbMaN83I0u9rXCDDI5NKk81ROyrkjYHkMhTy18ifeqOEZSS8L
 VEl7MX9B3dUyx6icJxBoI6gsnpBH/CCdhRvehsGeS7K26yCWgBJhHeXD8QiTpC/X
 YcZNbghE3R4XqNwwKE4cx7z5vniIIdJIYxNjW+4hyOKvu/MSnMXzFPPydkKO7hTg
 ShdS4Php9H2KGEUL7LUFagKcbNzVLlwQXa5XvWsFqZldZDjuB9xxsvlSvrFywL8N
 3Iwpj0J2t4bcJtKpJU1k7xDjaz4Zw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhvw65r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 09:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btFUdLR+R437Qsgh6xqRGUI4E8qM5cfWJceMww6FU+kmmW2pOORPNJL6lM7lZbrJM/yQEKOrDzFQ0xvMZpUp8Umy8Gq/mqqaLMU5u8qF1CZ0D90Bww9CDXsp73NtiO+tzdtQ5iDIRmflpHuIZIkEdR/voHa+TE7lDyW31dXbEgl6NlO7QeYF5fD3ujRvx2QGpMERtwq8GeIS9D5RelisOoLVyIR2bR4iGZn99l5MIb3LJSeqg29C3gy6z2S0FV1Il6c4z6RZbamww8/Yepj1nX3i3frBx6y81hMkauL21QhwZgDCrbUlAm29iWqDKxN4yQTktCX794J1RZ3cOkuuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+oc/ELJZHhGH4bP1O7YIAC/gVRlc9ymmpHC+1+3Ccw=;
 b=D7dNdB6VBOQv47XMuCx4opbTbMi0rnos07BMg5oWKIvTYs2c+vJaR4A5bSehyP6l+OQgSKxWl/OhlDnol4gGjJXCzGQ59zyeb+xNKwI6CKA8uuxK/d2+RiRKVQnPeVEIRIJios/OT30LaAhtLA+MCP3LrNGHF0qBDY7rv2pqAli+qqi99yvnxuIZXLOCT/HGXLRyQRmIOIO44NdN9Aa9+eRtCVncn2Aj0JyyF1Hvuxu7U5bMB2BEwNkAd+OvX2ywbDWFp0fPqhr+Os7CgYgb4iFjrTqrDRWzQMiMETFHegxV+p9ln6IX4eXsldQUJH+yalG88UsSMYltQ0sWtAHd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+oc/ELJZHhGH4bP1O7YIAC/gVRlc9ymmpHC+1+3Ccw=;
 b=Z57vnZ+GTAJQ3HCUC/Dg2DhiMXAo7i8RXTXCaIlQN7mZODjoc7l+1aOj31J0claXv+7lhlBNMpQd3Aa1CgJVmkIIgsfvdINSDlMxBKSJYfiMrdQ85uc6E0KNrsL38r220DPfCUAoJOlFhdBjLm1UWjnPkO0ZJLomH6dawrGx50vjcxTY3O+6RiNSwXW8Z7IXH0WKNltCPJY005A8wVJzg2CxvtJSTaUDleOkiahT3l58vA5xKoFs98dfKCZ1qSw6E9VUUnHP04rKklOx9o9kzow6wX9xKv2QdrpjmXnjiTwC3RmbaLZk+14H3qbwASqBB8Nh928JuSrfkvBjykzJAg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB9848.namprd02.prod.outlook.com (2603:10b6:806:38a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 16:28:20 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.005; Thu, 24 Apr 2025
 16:28:20 +0000
Date: Thu, 24 Apr 2025 17:28:16 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH 05/14] vfio/container: pass listener_begin/commit callbacks
Message-ID: <aApmoIOn8yixVEpB@lent>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-6-john.levon@nutanix.com>
 <5d87f16c-6e67-42f3-864c-e4e134816d70@redhat.com>
 <e58eb220-f371-423c-a3e3-c905be6752f8@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e58eb220-f371-423c-a3e3-c905be6752f8@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::16) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB9848:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd27f5c-e026-4be6-06c2-08dd834d06a2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?SqQrfetyX83nuiO+qTZCzOqIDkkymJWNFkuLy7p5cS+fs+aqYn7Aq0UP+8?=
 =?iso-8859-1?Q?uJYrgyimD0azOxDxrcO+K02rrgNP4Jkj2ZG6oBzav3X4yASkg2XDmaXX+F?=
 =?iso-8859-1?Q?NP5JkMU+3zGmE/N11/CiWsNN0YSYlsdi+ck58vXcWNBEld0ZMAhWXsFPvq?=
 =?iso-8859-1?Q?atIS4clkRD5OoIoFPdduPN8kEamRwBOso0/bqDJmlO/CPynw0NXzhS6kSQ?=
 =?iso-8859-1?Q?4bOgg2b22SSsv9fDmWkG+A01CittdLqRjt6sj1XKV0DGRRHtjTdvG7Tqwe?=
 =?iso-8859-1?Q?lP8lPMOw9N6fN9nhVNFWkpdnViWqqfwTdkbM7cOLtuojRDVbJ7uMYtcRoy?=
 =?iso-8859-1?Q?ESCVnYWrJqvQeybiNsKmchEVfYHWi0VIMWCz/X/P0obMGl6L+QvtFnjLum?=
 =?iso-8859-1?Q?rw64xEt5I35pKodkOrei4rDs038fCgN16oSv6ovkOOmAgwlhSm0Vr+knLg?=
 =?iso-8859-1?Q?bIcjbFQiUu3PoFrjqCkHsU0AqLaIBVq+65wFN7WbnRG3ATdXdGstadlCyb?=
 =?iso-8859-1?Q?x661W3R3FTKR2Ge5yEAQ4zqhgKl/KyFJLyLIvsFmeMQ7Q6YhyuYaPuwyBW?=
 =?iso-8859-1?Q?R/iF01bQi9qDRrMLqiPVnJS3I6QZqOVAtWaklwYatkkeDMsE/FrgylMkNS?=
 =?iso-8859-1?Q?9675jvfzOqzM5uoY/N3fIVkrKIdMpz7fidTC3vMYRzT+Pm4BIdqJzGY+CS?=
 =?iso-8859-1?Q?rH1Q3Fo3fJEC8A9G893MOP8tSn+e8wrpKgzQlakqfV5a6ATt2KwCpQhVAG?=
 =?iso-8859-1?Q?Ufni0u2M30roZZ5Naa41nSqeDZtfOr6NoLIdrScdNYIAi7cydpYSEtLseX?=
 =?iso-8859-1?Q?HnheDkLxy6D+28PRSg/WSTcgOQ1OaIsxBekU2KgsOPxxW9NOjcQXNE7OYW?=
 =?iso-8859-1?Q?Avd3MqCiEVxrftKDpBejtJiAIlBKWM/CaLegsfDQCspd0/s/LaBYj7FZ8w?=
 =?iso-8859-1?Q?UQ8BLq+4hGILehu/h0w/QAdGym6g9Pue/+Oqoke7EIccDXGYrWw+2ika+x?=
 =?iso-8859-1?Q?SjmQrmqvhqbQuSaNefwod+I0acA/agkcojT5WR76SuT7XfWE4KOwnwXMGR?=
 =?iso-8859-1?Q?ks9OouzPXMGtYkkLtW+EfUOAgCxYWrUFkYiHrpif/fk838UhAS/NNqqEGa?=
 =?iso-8859-1?Q?rfwBWeUIp1bciT/Pqivpnv5AKGKbu3dSewVMcL82erloCnhD/gLJ5EEcxk?=
 =?iso-8859-1?Q?9k6QxymXDXIZ4df131QEU0UM5ptz6WAQIZY+liOvzAOa72ZbjqZW+owhSN?=
 =?iso-8859-1?Q?MLMQJkxkUKO8oHaXdSNsnp2DgOB/Y6c+Gyf9lVvnyLJo68wdGnSEXTkW1R?=
 =?iso-8859-1?Q?/wVxCQVvEjCWH7IDQNRESXbC7/6g1OLOsUcnGesqQapJgJKpRqUFAI40Rl?=
 =?iso-8859-1?Q?g8Q/WkcSjATpFa/JFGaARA20zST8KQ5tMsY0Y5wn2ycbtcR2To4hofbdh2?=
 =?iso-8859-1?Q?sUVjE5ujAcOD5T8KygaP6PIig3yVvTT3wWRMCiXpLrcuAD9O+ZPFjs1qS0?=
 =?iso-8859-1?Q?o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?F31hZ1wLXbJvlZTn7P41IvYrdCZGz4nNkRBk9GaTeoMUa/ErOnOWSMUcRA?=
 =?iso-8859-1?Q?JkmphwP8ALanuykDwmcgGObZB3/vsGsePagH9ZnNiM1FkFI9r5vnEOiI+9?=
 =?iso-8859-1?Q?9fUHimKbhMNuXYpNBzxS+14+ubXRU7GH+X/U8Stk9u5hmP729h0pqjTneq?=
 =?iso-8859-1?Q?inJ/xaM/mvTyKXMi9umabQ/F1k0UAQyftq3+vzCsLXyp0c8PauZDMw86Ot?=
 =?iso-8859-1?Q?TENOt3jPuB0o1FGgw3vnwqVSMao1dyhYl9DbFwWzYXdLaKkiKBW2tgGr3z?=
 =?iso-8859-1?Q?+oXAY73sRn8XNg491kp81m0E/WgUycY4bRdRusu3/JqP96v8krtlEZ63/g?=
 =?iso-8859-1?Q?lG42yyjxr3TY/x8rQKIhH6mTo9bHMhFmSHCvWwdRJD5RSqDdlS4Xi/nMiN?=
 =?iso-8859-1?Q?wm4xSaDeCK4py9xlFeM1n0XYPN0WHVJH+Y0+qEsm20EkSxmyMHTLoEPRGf?=
 =?iso-8859-1?Q?hv+D40p+8kqKreFFs/aK9vJpXH05MO5rAghG/hXAfe9BZ0Pxv4mJzNyVmm?=
 =?iso-8859-1?Q?n92bNITheRwzLPRXE3FwoQT5zxJAIXHm5OVSrQYofFRAvU8a6xw7Ivj2sq?=
 =?iso-8859-1?Q?gMeiAOrSWBLwvmDVw133ZZ4Bb9nXt5hf5IKSaTcC4SpSuWcMMb+GplsKr3?=
 =?iso-8859-1?Q?bKpK8JjORhGqU5wxf2gJeA9YhsmUW0Wc3wtvMk1uFDikFsrZLn3Sl/fx28?=
 =?iso-8859-1?Q?I7IrL5awRbhGyyK/2+/jewuLMF3//R4uXJB+YKSnM5w74xwVRXY0LkDv8Y?=
 =?iso-8859-1?Q?7Co3ccz4qTS3vrAsLKM5Z8InREPx+iN20t2M6eRyJSEJm/LKkV4zaXKY3N?=
 =?iso-8859-1?Q?BWLRjUbS6CmSk+cO0w9DrQxO5gAavtSRQs1gJiTw6cgqYB+B/neF3aCSqE?=
 =?iso-8859-1?Q?Sde2GzBpOYm1qcEpaj4olLTqRFURyfFTvMjsFb2v8KbQyAEXGys3nE02+E?=
 =?iso-8859-1?Q?9wgx0+ISpAyfYcTTehPuAWpxGa075ySolg8fonQ3MumZkZDVjAPLJY0Qkv?=
 =?iso-8859-1?Q?gt1tjOyPzwaoOdMgzkdgZE8kRnrAEqKa6fvFNa4GILf0fQbXfYnawHpkbD?=
 =?iso-8859-1?Q?riBzRiwZMflVwJS+fq1dTPmJGBTCFK2Vc+GjZSCpRYvjyHewH7IcESFK63?=
 =?iso-8859-1?Q?dMvnZqxtltVxdec9AIRLrryxbV6N/bJ0uZgSzrLLg0C+Jinx6nUlH9a2RY?=
 =?iso-8859-1?Q?k0pvUy3u6T4M09dUnOnHo49W40SjNsr6RSNZTKnJYxtgXA7Oo/tS+WUbw7?=
 =?iso-8859-1?Q?E14gu1rU762VbOXRfqM1T7mUM6YRr5/dwL7BS+GHuVFoXAahblAohz0rwL?=
 =?iso-8859-1?Q?AAKn3cGn7/1BGy/+FDfh/WwXiB/mQbj41TkYvSc+VDR//KmN4OgSVLzVqm?=
 =?iso-8859-1?Q?mt+nNJ9Eq7hGBQV2jpPmROah+VNx6rcvXNIqboioMfnxCAWgmFu4quhrHW?=
 =?iso-8859-1?Q?egFKtMPFll6N0YSkSSCTx4xz9/b/9WzkC2MThW5tumgjyrDA6LGtYvAuVq?=
 =?iso-8859-1?Q?lkVGZJ5NuUzpMOoHYFEZquyO7Ljz0//AUnsIgDeBkX/ZjYnMF36HUlTx6W?=
 =?iso-8859-1?Q?b4sDT3F7xvgF7cqyX8Zxbg882DLXDbypZPo0bDixHdlRNt8RF4ne7G3LDU?=
 =?iso-8859-1?Q?EjF9ZvBDW6KQcpT2miAEDmMdCewxejX1XW?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd27f5c-e026-4be6-06c2-08dd834d06a2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 16:28:20.5992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryNsS9eGJK16nrx2v5Jlen7KSr3S5NArglrEFkXMVE8EryYgXfCRNuq6yuLLOpYo1eqo3jBkBP18Mj9ap7sZPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9848
X-Proofpoint-GUID: tAe-U93iD4rmrtCleahc5sRINX-RLAlY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExMyBTYWx0ZWRfX6uOhnGxyQsBy
 WxSBmRMYChyQa2TdJrWh9pmpQFr/cPBK4+wTkleggIcinefeYaSPYzGaqVMJ1BW9pLNAVywLxyA
 Bg19Kl4JEEY2Q6jozwC8y5csOWx6egC8m50VCYBrSoJVeV/69PN7yx/Bv5JmQaczZ7UvfeHRoOf
 cTW9/AXoXa20DoU7MVAhfE5O9Lxzl8RUyo3skrLMEMrIidpqUdcxk8ZUdxYMdLX39ujU15eL/5V
 DlX5nG1tvVTNDH+2AwmeBlvSnMYnsk+4cLCI548SDqCRP9vFeSnG6zWqrHOxNOTndXW+c/gJu6T
 nJGgYTGOfj4YuTrVFO0Jh2/WDu6PHDnPI7PuTwN5Y8WOCxQ0jKAzxsNEhu6e0dxiPPK8Jz4zrRG
 U8L0oEui3lNXIC2TZMYEOIl86LDD96Fv+O5IlGOzbt3K/XVknu7BkhhOxefYEcqqhKervEDp
X-Authority-Analysis: v=2.4 cv=PNMP+eqC c=1 sm=1 tr=0 ts=680a66a6 cx=c_pps
 a=l5p8UTqLmUd1ApN92JXWiQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=kiTWpfxpL78nYGjdGDkA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: tAe-U93iD4rmrtCleahc5sRINX-RLAlY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_07,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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

On Thu, Apr 24, 2025 at 06:24:23PM +0200, Cédric Le Goater wrote:

> > On 4/9/25 15:48, John Levon wrote:
> > > The vfio-user container will later need to hook into these callbacks;
> > > set up vfio to use them, and optionally pass them through to the
> > > container.
> > > +    void (*listener_begin)(VFIOContainerBase *bcontainer);
> > > +    void (*listener_commit)(VFIOContainerBase *bcontainer);
> > 
> > Please add documentation for the new callbacks.
> and it is not used in this series yet. So we can keep it for later.

Will do, I thought you wanted the general vfio stuff separated out, but can move
to the vfio-user specific queue.

regards
john

