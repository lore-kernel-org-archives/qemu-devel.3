Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351C5C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIL-0007pD-Mt; Wed, 30 Apr 2025 15:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIF-0007lq-Qt; Wed, 30 Apr 2025 15:40:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADID-0006Aw-Qr; Wed, 30 Apr 2025 15:40:31 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDpuEo004896;
 Wed, 30 Apr 2025 12:40:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=E+lRL1bobcdFN88qyL5jZfY6472X7XpXva0aDq64B
 Fg=; b=G6fOnpi876UYOj5dISZQax9RV0YFwCNmgG2Mca8fVCcD7GdwS2VoNFNgh
 FkdCFR7TR7Aq1ZpgBfbS+Jh9NiOEJy+/CFHx3r4qDKUwLIxAoKWCdzX8vZMUMWcg
 TRuFNGySB//1dHc2xiStcCbWUiMGYX6o8dlTYJIDI/m21cGy+ID5qZcEiD9cE3rN
 93VPOWExSf+mY5ad/5pHSwQ6ichY56OuAFH7/oz6AfM+em8IklFk7m5QR7QypcJw
 YgVvZuZp+LRUl+KVQNvAfUv4z0eHuM/AzWeW5A2YKTqM6/rczKpmmP34uYpgfR79
 u6uF2VjuHs+9g47OxXoZl7I1l7jag==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468y109ybx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGuJPoF81zgEnSKe2V5ecxFyM0EgFisEBFV36UCuNkGqPeKpIvRwUsh5elQrff/8llK+2/Wrwt0xci4mrHsi+2jjKWFZd3VvkeJzRitHr6DRVf5OFA+KHmEfMdoWKc26ifdAnfbJ8LMcVUBxl5w8d0fIkKS5QlHSfW8MZDcPpJ7E1EPUNu3/QugaOOV+D/A62LVlFoo7IuuubekTryOFHHxx0FwBn+LEcy7YkL2yR/xZe+zxIpYPpXn7NLPYWcHnwSTybUdly+p9qxy9+kyMwxN9pe8nEwTp5WI3PxyDgDJ4wYDSnfHvjy1nEx7KSokHjKt7hjZpEX5/ssHfXIi29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+lRL1bobcdFN88qyL5jZfY6472X7XpXva0aDq64BFg=;
 b=MfsHf8HEhQcn02Ml9rZ1JFLcaENBkvQxR+c9wD1ToFHNp0mVxmJi+a1Q50EeICCVnb9WhUh12YYqGDWTSYHazx+N1PYNtz77cObl03WI8OM0HbG4uxEeI1PVnD4Xo3lw9cMuywr6wyUW+kteX1dojVietIUjOtc6RVUW4ZFb3O5UtpxZpdye0H+7xGvlROhp5ag7q90xRxXcsEUsqasjno0YTscV6e0rGRZNXITIe8BoK401Ej7ax9CsEWGyRX+TWUr3M7PlSRRQv35CJ/EOkgMNq2bIQ950Lz9oslwueo4tVqD4nOQQjI/637w84e0wyyh8xV0cP/ALMq5dmzqIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+lRL1bobcdFN88qyL5jZfY6472X7XpXva0aDq64BFg=;
 b=njCVmS+JCYyE7/sP9h/PR2gtBPTZQbbZV3ozA9NV8NDIX2XFquMLWCZDITgvWFwxKofPSlLHYpPbEpthia0DhWlpac5vRVdiAvLuMNWNhO8/Q+I0ShHSPGs6XT8GaL+LJT2AH7jZ8sI4Iw35LnSn+v2lgCtAa22Ktn02A5Ao6yrveY0Wbw7f+ZnHdSxYAiOjd7Sy0NE3IWMxmFGrUjLnYnU4PIYZdMdg21BDvsxcM/mw8SBZgxRB6X1yBPFz5i5QQljs2ajoS/+Hng3JnNAxfxgN7b18i9cpM5PIDmG1Pu2oTyX9686V5IBxQtl3A6Uex7isQVjPVMW5d0/eaR9qxQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV3PR02MB10054.namprd02.prod.outlook.com (2603:10b6:408:19c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.11; Wed, 30 Apr
 2025 19:40:22 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:22 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 04/15] vfio: add vfio_device_get_irq_info() helper
Date: Wed, 30 Apr 2025 20:39:52 +0100
Message-ID: <20250430194003.2793823-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV3PR02MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: 2902e732-5900-4d48-324c-08dd881ed8c7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mk1IQkdiL3VKVEtUd01LOTlLZlRnd2lIM1VSS21RWllTaWRwNlJlRVlIbGU2?=
 =?utf-8?B?Q3gxUjIwTmNYa0Y1UHV6QmZEN0k3ZDZLRnp3QmlIYlpVQlREVEtUdm1XYVg4?=
 =?utf-8?B?QTlVc0tUZ2ZPbmI0bEJuSWMya2pZSWE5SFIvTWNDOXc1RlpDZ2FuNjFxY1hq?=
 =?utf-8?B?Q0xlaUc4T1FDbi9zbXNpTkQ5Z0MyOFNvRy9vV2JxYUZMRm10RDV6TWMzcFo0?=
 =?utf-8?B?V0lLQS9GaS9XZ3lwa2FoWmU2eWJOTkpaS1k4VGlCYkdKeFEvSDR4UXFOMmtR?=
 =?utf-8?B?eDlSQjk0K0dndTVYRWlHN0FoRHpzSTROSisreHFSczhDUTJ4TWRtQllBVWww?=
 =?utf-8?B?ZGNEaEZUL2NrcG4rdG5lRTdWaHhlcWM4YnZjdlpneUVTTS9QMXBoYU9uZHJQ?=
 =?utf-8?B?QktjdnNnT0pJZjF2Q3RxTDFaV1ZOc09tVnl5WGh4ZmJhd3hEenVoRU5LWEpj?=
 =?utf-8?B?cjhBVHZhajVNelJMcGsxNncxQjc5cUpEenhpUjVjNGhlRFh3R0xiRE8xZ0pq?=
 =?utf-8?B?NmdhRU9JanJqaFFZRGg4cG5DaEFNeEtPL3Vpa1VkSWwzR092am5YWUlVNWR2?=
 =?utf-8?B?bndiZ0FYRlFBci9INUVTOVJyQTNZZ0tyeVZLUFZOaWFxRU1vUkI0Ym1BOWNw?=
 =?utf-8?B?OEgzeXUycUhzYzU1N3hFWXNBNTZGa3d3Rm1BMFZmZDI5WHBjL0Q5Y25hWVAy?=
 =?utf-8?B?ayszY3cwcVF4dGF3UUpSNkRtNDEyUkx5MC9YNVg5ZFBUWWFQRFhCdjFhakhB?=
 =?utf-8?B?M1RkcDNaQndoRnhTVlhrMmZBVTZDOE5QdTA1OElVcFNXNkZYamF0R3JFelJU?=
 =?utf-8?B?VVowN1RjcVBnWVlwM0QveGhtUEk3N202QzUwRjVVVXNDTndRcGFXamowY0I5?=
 =?utf-8?B?M0JSc1dHckpkRWt1TzZPU09WeDdFLzBRZEVDVnRNRktEbDBRbytNZ0xReXNa?=
 =?utf-8?B?cm5yT1RKVDBhcjE0TGdGMVlwYlN3SzQraGl1YkVKRUI3dUYvblg0Y1dYOXlu?=
 =?utf-8?B?cFd5Q2RmKzBJVkZid3Ixc2pqYkxiTWY1ZTJQY0EvZ0cwY0svbk1KVmZxMGhu?=
 =?utf-8?B?RWZxdkZMWUQrTmIxMzZWZjBLUkZsaDV6VEhVTm0wcDVZY1V5RDA4U1d3YnVl?=
 =?utf-8?B?U1FmVTdiNGtJRnYwS29ZUWwvVkk5MDR1R2FuRElvbEtaQzVBelJZZm1IRmhr?=
 =?utf-8?B?NGxUOE1OVE1FbnlENFB4ZUZEaisrU3FoN2tYdjB4Y2NHZi9KMTd2TzQ4STky?=
 =?utf-8?B?d3ZocU9vWUJuWXlGYWltOXdyQ3R0UFkvK3Y3aTZFdVZwZDJ2WDNJUjFvK290?=
 =?utf-8?B?TkpGbjMvM0FVZXFOdkI4dlhlSmNrQXBVKzc1MmhKVjR2OGNTSjgyNlRlU0w5?=
 =?utf-8?B?TWNsUzJ5OHNQaS95NWZ4ZFloZDJRdlhtQzJGeHRINURFSngvY1lMUFZCVmpl?=
 =?utf-8?B?MmRsNjZLMkdEUE9UVDV4NnRQcDQ5aTFNRzRSdGFhZTc1Lzg0WCtYVHVZWk9Z?=
 =?utf-8?B?bWF3YVlZNnNVczZNT0IwYnpCTlVGVTB3RDlGZGVieUNyNEhsVGVWa2RJc0tE?=
 =?utf-8?B?MGk0ejBuVm4xSlgrcXRtdE93RmVnaElKY2FKcHMxQTUzZjJTemdtUXZDUXht?=
 =?utf-8?B?K2hlWHZibU52YmhRMkRZRlFxaUF5UGpOVkUrcC9pN3M1Z09lTEc4UXhJOExE?=
 =?utf-8?B?YXpRUm02R1VXUXJTTjNrV1A3eTA1UnpLWmN4UzZ2dC9rdFZzUkgwaUhsdk8y?=
 =?utf-8?B?RWIvdFVaVW5VTDZVSkR3NmtORU9hdXlTSUtVb2U2NmdBZmxRYUdZK01hSStp?=
 =?utf-8?B?SEJaRW52SGFaK0tHc3FrLzhKQzc3RUdNVVRJbHZRVXJkcE95US9VcTN0ckov?=
 =?utf-8?B?cEhVYVE1angwSGRMVUpiL1RUU2RhWXJZQitMZHNxdVpyZWZWam1XRXptVW9i?=
 =?utf-8?Q?WywtheOQDUI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdJcmZaOWtOR1VDWGhkZHBZSDVSdDYzSyt2NnZlbGhMc0srSzhDOUVjK3g4?=
 =?utf-8?B?a1owSzNOdXVQbjlGejNlREZmMDNsWkpLSEFlZURUTmlGUUwzRGJNcUdmQ0h4?=
 =?utf-8?B?VVp4WlUvVW5QKzdtVjFtaE5KV0NiMmx1clpTMm92ZlUrUUxSbkJ1bmlybWJk?=
 =?utf-8?B?K21DL2FQRUp3SnhwTVA4YU8zTS9FQXdVa3NiT1NCcHdLQjJ3dytWUStTZGpp?=
 =?utf-8?B?Ui9pMXhidlhXUnRKRE9halZsT0owWjA1bFh6TWJUQWVLazFGb212TW9USkQz?=
 =?utf-8?B?NXA1SGk5eHozUmhlRGVyN0FJWTBQK24wVGxWQU8wNGVZdk5HeUtqL0lRWWFK?=
 =?utf-8?B?WUowUkVtMW51NG9MdmxxZnJQWTRjb3VvbnFxMFd0QlFMbFpMcnBGbkVRWDVr?=
 =?utf-8?B?L1g0SVVmQnZNdUtKYmZGeHJYTnR0cW44SHJGazYyc0VVL3g0U0lxemdWU1lk?=
 =?utf-8?B?L2Rxb2NOMFVuazRtbjBBMFA3THJITGV0eHF1WnhpUSs0WU44ZGovQ3paYlBW?=
 =?utf-8?B?V2RMREFqR09pb3lZYm9hS2xYUUhCckJXWUVPRGRxVE41RXNkWUVoZWloYzRz?=
 =?utf-8?B?MlR0Q0ZGNTNvck01ZXpwMURnWFhCVU1lTmRWSnFwWERVVHlmWTRLYm1Qdjc1?=
 =?utf-8?B?ZmJoZmtLZlhYcVVsVjVwVzJSYW5oM1d4ajFMODc2aVZwSDFLUEsyQkZaVmNV?=
 =?utf-8?B?UDBMdHdHbGhIa1B0QlpSMWFlYm1FbVVLYmpoZ0E5SjZIZzdSK0VGb1pQbytx?=
 =?utf-8?B?ay9aai85Y0dGSGdzQVFPYnhyTDRqbDFMM1RHRWxVK2ZITVhzbFZCNzlVV1M2?=
 =?utf-8?B?QkhCOG9IRThWM1dQdTBSMkxOSjdseHhIY0sxTHRzc0hEcWJJcjJNT1BoYzkz?=
 =?utf-8?B?Sk9peTRDeVFCc3NVaG5mRWJ0bDUySTJVTEszUmZXZHltT3ZtMjBWdFVYR1Vj?=
 =?utf-8?B?TjNhODhrVkwvL09aU1d4ZFV1UVh2cUF3MHRwRVFyVTQvQUdwc21hZVRYamVX?=
 =?utf-8?B?Qmd5RnZ0Z0NLVHVmd3ZTUERQTHZHejdPV3czN0tBKzBQTzY2RDRVNCtsSmFu?=
 =?utf-8?B?QjRXaGlhRGpEWTBRdzdrZ0pKbnVmZVBPNERKWWtTeG5mRVNCWmtVbUpKcms4?=
 =?utf-8?B?V1lXdXdZeTYyQ3RqSlRVWVJVZ2p2WkdNaHVEWU1DRk45eGVreWllRXA1cHRL?=
 =?utf-8?B?d3E0SEM4aklaWlRMY1J4U3dmczdRL0ZGSUNiYzBKdjVsUkloNHozWStYck1l?=
 =?utf-8?B?STQ2ZVNuQlpSNzlkeTFmQ295c1BvdEFyNVBtREVjYUJjNC9JR2FrRktwUUJl?=
 =?utf-8?B?b2ZMdTB5NGlWQzhNdTh4bjY4SDgzdVVjRnZLMzF4WkliaysrTmdvVCtZTzc3?=
 =?utf-8?B?MWZ4cSs4ZFZOUlZTTFZaekVKaUlLU1VsM1I4Tkt2ZW9ZTFFLMHBOdWh2UUxH?=
 =?utf-8?B?RSt1WWg4cy9MS21Ob1FpRUpua3dHWXhsT2RDQUlLaDg5NEJ6VzZJN0I2UCsw?=
 =?utf-8?B?QVA3bFo1RWVlaFBvZEFxOTZERzlQUHJCY095M2MrNTlQd215UzRVcThub3kr?=
 =?utf-8?B?WGJ6alk2NnBkeElTbGNiQWVhWDhpWGhZRytncEN2cjU5bitTNXFrUGl2UVdk?=
 =?utf-8?B?a1N3T3B4VG04cTgvWkMyWXJuU3hHb0lyUk1TNWJtVG9La09uT3lxNWNNNHcx?=
 =?utf-8?B?MUV4QnFNQUYxQVFoUlVEckZ5Qm1GTzRtZ2FoM3cxN29QZW5UNWxHQUZvOUtY?=
 =?utf-8?B?eG8rOFpxRWt5NzAyRjlHb1RJbVZ6ZjNtM0tzR2NLVEI1MVZmWmh3YUxvK1kr?=
 =?utf-8?B?a2JWK2R4cjNVY2pVamJGbXpTNU9zS2x6OWRBOGlqUGFWQXlnQ1hENlgwWHlN?=
 =?utf-8?B?L2w1b2ZDYkhlR3ptQW5pN3Q2MkIxWkttME9ZZmZRb3BqTjNOdmtWQStuV1hQ?=
 =?utf-8?B?c0xoS0pLdlhnT3MzNUZibTJlQnFqR1B6aHdHY0RuNXJDRGhzaDRRVkF4SS9R?=
 =?utf-8?B?eEJZZGlzODVtelRPR2p6V284WCtZMk9jK3N5eGw4K1RPNGRYVFY5UURtTzc4?=
 =?utf-8?B?Q0gwZWVEcHV5SWRNSnVWY0wxN0dsdmwyeHVTeUplRU1xeFFnMkQrbS9LUkt5?=
 =?utf-8?Q?FaAbT9LliF3ZsZCF5/CV2n4Ta?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2902e732-5900-4d48-324c-08dd881ed8c7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:22.5199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9Hxu4hwcUka3Ru3QAbv2zDeko1ppLbmzGRenqK6+nTg5Ws6dV/k2uTd4vOLEOjdi7QvggWYhbrH+3Q5lbIurg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10054
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfX82MMm3nscu9Z
 GKiLxEA2oECysrdWIQs2QqDR42inr6kbS6+1PJdVBA5sRFWrXTRxNIZZR0bPClQUIEGY3G1obGw
 kWwunmqfWGjrhpkGvIyRE3oPAUH233D+kPPLYy1IBjxRONd+9i0UvUmkybRR6Y4/QO3YrxZVFz6
 rNICdKKs1WQZ5gSLKqPeBZQBp7gC1pLuGEUZImpt7XnOv5rjK4q7jAI7/iPw9mvc1LulFEvcHvm
 WaOuutu4fTeIYAHbWR5dSgBNHOSosaOPuX6DA7mWnOHmiYs4s86i7lyymQWI14I99vw0TUEfC3D
 Dpw5Y5hIK2uPLtVBSTd/mV4//hzzcs6NWL8P+it3Hb/DTEaXZdZJkGh7/JG+Hz0LxsazzPSTNJC
 vIQoAWNmUteOyPqAkbNLu4R8L5tPVaA18X1NNi5kBJiZ0GADEfcrWY99wt3dEzIzu6BBVxMw
X-Authority-Analysis: v=2.4 cv=MNVgmNZl c=1 sm=1 tr=0 ts=68127ca9 cx=c_pps
 a=hHPfuxNGWHHq0fQgDGst2w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=Hi8EXRwGPg4AD4QmvAsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: g-l7WZEFSmVCjqUYNrGe2tKn3QAfJhuD
X-Proofpoint-ORIG-GUID: g-l7WZEFSmVCjqUYNrGe2tKn3QAfJhuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Add a helper similar to vfio_device_get_region_info() and use it
everywhere.

Replace a couple of needless allocations with stack variables.

As a side-effect, this fixes a minor error reporting issue in the call
from vfio_msix_early_setup().

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/ap.c                  | 19 ++++++++++---------
 hw/vfio/ccw.c                 | 20 +++++++++++---------
 hw/vfio/device.c              | 15 +++++++++++++++
 hw/vfio/pci.c                 | 23 +++++++++++------------
 hw/vfio/platform.c            |  6 +++---
 include/hw/vfio/vfio-device.h |  3 +++
 6 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 4f88f80c54..4f97260dac 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -139,10 +139,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
     int fd;
-    size_t argsz;
+    int ret;
     IOHandler *fd_read;
     EventNotifier *notifier;
-    g_autofree struct vfio_irq_info *irq_info = NULL;
+    struct vfio_irq_info irq_info;
     VFIODevice *vdev = &vapdev->vdev;
 
     switch (irq) {
@@ -165,14 +165,15 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
         return false;
     }
 
-    argsz = sizeof(*irq_info);
-    irq_info = g_malloc0(argsz);
-    irq_info->index = irq;
-    irq_info->argsz = argsz;
+    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
+
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
+        return false;
+    }
 
-    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
-              irq_info) < 0 || irq_info->count < 1) {
-        error_setg_errno(errp, errno, "vfio: Error getting irq info");
+    if (irq_info.count < 1) {
+        error_setg(errp, "vfio: Error getting irq info, count=0");
         return false;
     }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index fde0c3fbef..ab3fabf991 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -376,8 +376,8 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
                                            Error **errp)
 {
     VFIODevice *vdev = &vcdev->vdev;
-    g_autofree struct vfio_irq_info *irq_info = NULL;
-    size_t argsz;
+    struct vfio_irq_info irq_info;
+    int ret;
     int fd;
     EventNotifier *notifier;
     IOHandler *fd_read;
@@ -406,13 +406,15 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         return false;
     }
 
-    argsz = sizeof(*irq_info);
-    irq_info = g_malloc0(argsz);
-    irq_info->index = irq;
-    irq_info->argsz = argsz;
-    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
-              irq_info) < 0 || irq_info->count < 1) {
-        error_setg_errno(errp, errno, "vfio: Error getting irq info");
+    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
+
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
+        return false;
+    }
+
+    if (irq_info.count < 1) {
+        error_setg(errp, "vfio: Error getting irq info, count=0");
         return false;
     }
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 9673b0717e..5d837092cb 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -185,6 +185,21 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
     return false;
 }
 
+int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
+                             struct vfio_irq_info *info)
+{
+    int ret;
+
+    memset(info, 0, sizeof(*info));
+
+    info->argsz = sizeof(*info);
+    info->index = index;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6908bcc0d3..407cf43387 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1555,8 +1555,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     uint16_t ctrl;
     uint32_t table, pba;
     int ret, fd = vdev->vbasedev.fd;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
-                                      .index = VFIO_PCI_MSIX_IRQ_INDEX };
+    struct vfio_irq_info irq_info;
     VFIOMSIXInfo *msix;
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
@@ -1593,7 +1592,8 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                   &irq_info);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
         g_free(msix);
@@ -2736,7 +2736,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     g_autofree struct vfio_region_info *reg_info = NULL;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
+    struct vfio_irq_info irq_info;
     int i, ret = -1;
 
     /* Sanity check device */
@@ -2797,12 +2797,10 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
-    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
-
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-        trace_vfio_populate_device_get_irq_info_failure(strerror(errno));
+        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
     } else if (irq_info.count == 1) {
         vdev->pci_aer = true;
     } else {
@@ -2911,17 +2909,18 @@ static void vfio_req_notifier_handler(void *opaque)
 
 static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
 {
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
-                                      .index = VFIO_PCI_REQ_IRQ_INDEX };
+    struct vfio_irq_info irq_info;
     Error *err = NULL;
     int32_t fd;
+    int ret;
 
     if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
         return;
     }
 
-    if (ioctl(vdev->vbasedev.fd,
-              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
+    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX,
+                                   &irq_info);
+    if (ret < 0 || irq_info.count < 1) {
         return;
     }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index ffb3681607..9a21f2e50a 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -474,10 +474,10 @@ static bool vfio_populate_device(VFIODevice *vbasedev, Error **errp)
     QSIMPLEQ_INIT(&vdev->pending_intp_queue);
 
     for (i = 0; i < vbasedev->num_irqs; i++) {
-        struct vfio_irq_info irq = { .argsz = sizeof(irq) };
+        struct vfio_irq_info irq;
+
+        ret = vfio_device_get_irq_info(vbasedev, i, &irq);
 
-        irq.index = i;
-        ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, &irq);
         if (ret) {
             error_setg_errno(errp, -ret, "failed to get device irq info");
             goto irq_err;
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 666a0b50b4..5b833868c9 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -146,6 +146,9 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
                                      uint32_t subtype, struct vfio_region_info **info);
 bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
+
+int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
+                                struct vfio_irq_info *info);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.43.0


