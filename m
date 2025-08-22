Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F171FCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQfK-0001hu-GO; Fri, 22 Aug 2025 08:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfG-0001hF-Bd
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfE-0000lC-0J
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:38 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M807Lr667100; Fri, 22 Aug 2025 05:14:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hqVCDIy2KRR27aDRiYr1f0LLOv6zNVLHQMYYw/h+h
 bo=; b=iwpU3/wBw7/NAg2OmyQFHpk+e7hgZjI3r44YBAN98TzRDXh/3uVP2QVYS
 qKCpb2dbeowVr7kqZLkw8xDbCad/5J+I9rI/fIG9FzbfIovPrFiKb9ug0UJ41hMc
 qzpXC+vKbIExSyJSdSn/heqhjnYT0SA2WPueyBMdz53piOZb977kVVJ9F3wVs13i
 0fIz5THqEjSskZLAuWe7Kr3PFRkKHmNb1khn+0WzD8QGcPOMpK5lqGVzhXBKsj/D
 hQj1bSBx9ei2hLuTR5+ANB7HGXgkXM0E5p8OPHossucJwSe0pvfNtuqhXm9AgcGE
 t3mmUfDJ+WxRtiC3cfam5wH+HmldA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2108.outbound.protection.outlook.com [40.107.220.108])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye8qef1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/Waaow+q8FHQ0mSK23HEixtwCtAaeTwvPQh1MHgYuSpPCUaXTBYw3H4SyLPnVsnrImUTMuzvTnuA0aMzOvlebnONbyNgkedaFTXE9O7EIq82UJvP/GJ95h/BvIMpU1hgMaXe3otkST3eREhrSqy8EzynmI1se5SL4vEedeKEj7j02ORzFdzmZoDNcDdMCYkof0kP3Ql776JE0X0puqFUGhzh52+/4RyJRHbjkEcqZ/4bg5K4chI3CYdAO60/LYeFFAB9/1qPhtxG/9wxVIydu9bOS+/fkDhny/3f/B78Nkt3EQFmMmQI1SjCQl+MtAqeRCPeNDYNKzigYwRRNMYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqVCDIy2KRR27aDRiYr1f0LLOv6zNVLHQMYYw/h+hbo=;
 b=o6Shx5oDK00riK1deZPwXjqTh+26szrTrjEuhUXAecndHPDCKQq7qr0ii59Kbadu8NUnuFPb/rapDqBsPnj/7Nz9GnzlxNBfNECo01XBX/zvQzKZhmN23UyeRhoikZ+CigdfOb8bcOJR+JiQbC+lJe/INrrEWfGbUV5VHKbpJ1dZTEnw54cboSuyizdWhA4/BXJkLirpIX3/PnYxOlhClQlpBK87zkgaX6Rc0lFxgWFrq20lQ9VBLFnu4ZGJcvLrtDgHX2RLWtbRWvmUeyrUaFIwaw/CddBo6xro+oFyvKuYumFEaphdC5UBoTBQPSxVVbOkxT8P148NTiyRZCl3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqVCDIy2KRR27aDRiYr1f0LLOv6zNVLHQMYYw/h+hbo=;
 b=SQAJ9i3ezIh8noDNgsHJwskLt/BT5Li6LHSIbuEfEKAa9lozIBU6HYYd0YxFvTA5jm09dgTXjJO21/82eqWW/sXdjekAAwXwEy8a/veer4YAEcXeVLB1IBOaPbz9ZSIIR+1WoTQRfcpVllmTviOp1JSPSaaval1M2E5AiiGEI5z93TkLwZp/duDkuUgNsUmc6GOXaO2EBBUC5eoptH9WcJqCpssVF7sLmJTGYwzBggXk8BU+PvWHI6v/VAYKps7RchQPorV9mrvjRHN0kiOXDi0lFcCVcnwtUBxJpV4Gdo4/jhRIpa7U4x14kipD0I18DkdiSIl4GKr+H2WC7dNTnw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:31 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:31 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 13/19] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always false in pc_init_isa()
Date: Fri, 22 Aug 2025 13:11:59 +0100
Message-ID: <20250822121342.894223-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 287e221c-6c82-42b2-abd5-08dde1757313
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0dsdmFKSmt1OXNza0w3cWZZQm9UdVgxb0t3b2NMUzFVSi9sWDREbGZNeE9v?=
 =?utf-8?B?NGdRUVpzREV0U3VQYjRLYUlmbTBJd3lzcjJiWDd5S21UdVhIZ0FxbXE1c1N1?=
 =?utf-8?B?Vk9XTjhsT2lNamU2ZzE4TkJoNjZqYXBDM3huQnVsRmlOZ0RORjVsaUozQm1L?=
 =?utf-8?B?ekdFbUVZVzU3UXE0SklBY2p4WnIwMVF4U29BaXprNmVYSzBVU2d4VUJXNTFQ?=
 =?utf-8?B?TXZibVdzcGx0TWFYOXR5a0NUbDV5NHM4bGhPNkpOZ3puNUxPNWtKTXBoNm5i?=
 =?utf-8?B?K1FZcFVIczlTSllzYVpvVHU2YWpDMlRZdkIzWng1Um9jQ2dJOHVoODlLVkM5?=
 =?utf-8?B?c09mMmVMYW5qeFFvczQ0UThDaXUwZ3N6R245SG5PdER5Vk96bEREVThrMU1s?=
 =?utf-8?B?M3RST0hPeGg0M3JMQk5ZejVqbGt1eTV1b0tJMXk0U2Z1VFpqQ2RXa1UwT3F4?=
 =?utf-8?B?NlgxcnlUUktNRWRLVTlhcGNmSmppL01KY1V4aExaR21henZ6UUJPM0VRMFNn?=
 =?utf-8?B?cU45ekRqRithSE5jbHlxR0VtRldjNVllYk1FMjZEejRCaG9kRkpVWVdYQUpJ?=
 =?utf-8?B?ZjBzeC92NitNOHEwQnZXdHZ1V09ibTAydUxUQmc0MTgvbFlVQlpWSENzZzFG?=
 =?utf-8?B?U1FKQ2d6MjVkV0d5WUlvZGpMdERJRjNIK3NLZzBqWi84RjcvQUg5QXpRUkxu?=
 =?utf-8?B?YzBNdzlVbjNRY1pQVUlyOGpIUnNNRkwwdHN3ZW0zbVN1R3UyY3F0dWJJTEZt?=
 =?utf-8?B?OUpDdDNRWmlVUC9BQmc5dkJZRVAwblhLN2c1dFBuWExKU3hpVEdrQ2w0aStC?=
 =?utf-8?B?V29Fb0VqWTB5SXM3NDEwbERBOXlnNE5DbE1iMU8ybjVIUXZIY0pWTHdBVGRE?=
 =?utf-8?B?bnBEWnBBVGpTUlo3MFJpYWZrT21LQzQzWUwyeStkSC9adTY4R1cyckVSalhT?=
 =?utf-8?B?Zm5VbnlPT0QzMlVzbHRyZkRlekJBZUcvQ0lIRWxac1JXYUdMZFpWUU5aNStx?=
 =?utf-8?B?dkprR1V1L1VrSlNaWEN0UEp1T0tiWk5vOGdyUWU4T2gwdTVIQTF0Qzc2bDI0?=
 =?utf-8?B?NS9maG9XTm96dUpQMEtHUFRJR0JrdmtvUEdzQi9INGNhOWc5TEc4TURMUFVF?=
 =?utf-8?B?NGltOTRjQ1h1U1BSclhFYi9Od1lQR2pPcnpFWXg0V0xuSWlUc0xmSzU0QVFy?=
 =?utf-8?B?dHRrOHlPYXVtdy90WmZ2ZUtxa0wxN1g4bDJ5SE9aNTk1c2RQVVZhZHhyTEtM?=
 =?utf-8?B?Vjc4OGxUTzR5UjZZaU1BTk53aEpDenBwYjI0a0pId2hzcHQvWVBWaEh5TkRy?=
 =?utf-8?B?V054Q1FyZ01BNGNpWi9Pd3kyUUlZeStTdDljSGlhSXFyWHM4UlZLZXZ2aWNZ?=
 =?utf-8?B?aGUvOHRRclgrZXd4WDM0VDE1YjFXbVBhbzVSYWk2WE9SWWlFQkowdzBPTXA2?=
 =?utf-8?B?bmxPOFAxV1VwbUE1SjlJNU9Hbm9xdnhiZlRUNFhxVm9WYk93WkI5MGVjdU9L?=
 =?utf-8?B?NEFUZWxSK1Vwdm1wQlNRekxYS242SUtTWjN6bm55YUN4QXZaVmY2eENxMlBV?=
 =?utf-8?B?WGVZK3V0MlA5b1YraEQzbjd6aDBFTUJiTi9TTFdCSzRWaHlpVFp6ZldRVGQ3?=
 =?utf-8?B?TUtBVXd1RnhVY3JwSkRmV0tFR25zVHlkei9randMcVFkcmYyTjY3dXprR1cz?=
 =?utf-8?B?dmlndG5xQ2lDandpOVdLZ3NPTGFMTmlxM1Z5NnhiazNEN3BGWThoUi9vOXRY?=
 =?utf-8?B?dU9qM1ROV1B2OWM0amRyUWljeVpoZDBQc085cHZaOHloODZQMFJBT0dZVGZU?=
 =?utf-8?B?TFczSnA1VkZYWEczVnhBbFdHMXlDSGY0ZDlPVzlybUF4UjU4TDlFdEFOVXVY?=
 =?utf-8?B?VC92SkdSdnhWRHpTai93aGk4YVZkbGNWYy81SUFIVzZXN29NMEZZV2g0OFhV?=
 =?utf-8?Q?Ejuw1l0z930=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1JmSlF2VVAxWDVxeHBzbytpaFhvNVc0c2tpWmduYU5xYXZBdnR1U0RtcXZv?=
 =?utf-8?B?YnR4REZjNE1TR0FzeVZYdEpIeXlwcGVPb0lsb05rMVUzRXNhVFliWGFGOEcr?=
 =?utf-8?B?T3ZtaU9VMm9yZldTNkNtOTVPNDVDd3crS3FZcVhTOXpLMmIwQ3JDdGhVQUNh?=
 =?utf-8?B?ajMyZS9wRnp4cklORU9LQ1pEQkVFUDBJK2FzQ0lZanl1OHF3bU1mNUVRSW5R?=
 =?utf-8?B?d2czTXRodTYvYzA5eC9UUEZrOUsxWkNZckluMXE5RVI2N2FCSWF1bW5xeHZr?=
 =?utf-8?B?M2RwTjNIeFhwLzFnUVRRRkVkbnQ2Z2p2WXJiRDMyK3phNHdxNG52VTNZWjJY?=
 =?utf-8?B?VG9Rakcza01mVXhlNTNhZmF1eDZFd3NOc1A5UktQNGZFQ3BWdGQ1ZnZxRzZG?=
 =?utf-8?B?akRNU3E2VmhWOXJwemNhN1JncHRoSDk1cVNNTmhwWFFIaGNMMFJLYWVtcW9I?=
 =?utf-8?B?Q1IvWFdoREIralB5U20wYkt0elJTcUdnRXBaRmxYSWlQbHorVFR1YkdpUmpF?=
 =?utf-8?B?NitlQWsreWptTStOMEltSkFXTnVodEpaNjErWkVSN3dTVWJqRTlTYkcyY2o1?=
 =?utf-8?B?UkpodkRSQzhRaUlrNXdybk95Vzl2WVJqNEQwc2Q5WVorV0FoWGk5Z2Iva2k4?=
 =?utf-8?B?dFN2ZDVXOXpxc3pJWWtkaVdhQmVPcHA0VUc5K3UrK2VWdlA1QW9YL2RuMTlF?=
 =?utf-8?B?a2FXWE10SFhwNDVNb1RGNXRGVlg0aW1uZFNQRGY4Y0QwM3htN2NrMXpvc2oz?=
 =?utf-8?B?MVRSTllLa1p6OHdPVXRGWlprUEVwbUVXdkdxSmVvTHpOUTRvZXFIbHE4RERs?=
 =?utf-8?B?MlNWZkpJV3ptWUlLM1RGdkJNTlV6WFBnU0dVMWpBQkZnQ2s4SDcwVHFheU9h?=
 =?utf-8?B?OVpnTDFkLzA2WDNhRGpxNHMwQ2VSc0JDVUM1dW9vRkNLdWlvSWZBbkltenAz?=
 =?utf-8?B?cVg0bTlNcXVhV2JDYmFxRUNxQ2R3ZnhwZ0NhUW1FNjVYK2lzUGtRMlJNYkQ3?=
 =?utf-8?B?WnZXTE5ZRjY1TC9OdWcrYkVnMmZaaVB3K1JQTzFEMEozN1JkK2JBUzRRaWNa?=
 =?utf-8?B?eHJ2bE1lWGUrUXB6RmNrWHd4TG00c0hER0NFNW9RV3BOSk1JaWRSYVRneGU4?=
 =?utf-8?B?UFV6R3o0Y1JqZXhxWStGV1RnWm4rM240c0tuV1N4VTBnbjZuV0pNSnQzQXJO?=
 =?utf-8?B?Z0xNUUdrOTR3Q21nMG1TTjhqanJVNnhXSHFuQ2NnMlM4d0ZEMFNZM2UzNVhI?=
 =?utf-8?B?RTlmWFJ6YStXcm5PR3dvZVNEdlFvaWJncjlDVkhVYUUxd0NyZjBscjU1TjRY?=
 =?utf-8?B?a0VTN2s3WSsxbUduNGtuSEJkZExwWmFYaU40dmFNU3hERDF1bGxTNnZUcm1W?=
 =?utf-8?B?SFdWclJKbFc4WW1EUzkyT1NQVndzZTBQVjZzZExMQ001RGpoYzVOR2NFQ2N4?=
 =?utf-8?B?R1dQQ2tuQ2tVOXNrQy9VT2xKTkNqcFRjcE5aSHUxd0RJcHQweWJ3alhvSXJs?=
 =?utf-8?B?RnlsQTk3dG9XUWdtTE52TXVEcEdKK1F6cjhNQUxKTWRoTUNza0NBVnNZY2xy?=
 =?utf-8?B?c1g0VVd2NmdYdUxIbGNKL1pNazFRRExreEFzRzQ3UGhGM2dmT0ZWOEFZc09W?=
 =?utf-8?B?SnQwMzNDOTI0aDRNaXhVVHZuNFYzUGpkS3dOTDR2QVJ4NDdVR1BKSE45WmRz?=
 =?utf-8?B?dHRkM2pwYnlRb1JBNjZHYXRVRVBFNjRwejcvL3VaNEVxaFZZUVY5TGkwc2N1?=
 =?utf-8?B?Mit4czhEQmd6WUE4TzBGYkZadDgwemlvZUhtcGk3cjlHSmJiUWoyQXFMWUVp?=
 =?utf-8?B?WjU2OVdQWVFGZnJNbXNmSzcxOXhxejgzOE9BK0lMbEd0SzdxNVFNRDFNN3Ir?=
 =?utf-8?B?UGwyVnBiQ0pnR3ZDSHVhNmhYb0tMMk9XaVNYZlBHWFphRjYwWis5azhkdWpm?=
 =?utf-8?B?M0YyWW5QTXhWV1pwaUQwM01SYWlvdWpQWEh0S1BheWYwaWtmUGVwVWI2elNx?=
 =?utf-8?B?STBaeXlzODZydUpKZjdEc1JtbzZkdUN0VUdPVmFzcjlYVURkUlZOVGVsZWZ2?=
 =?utf-8?B?TklNaTMyQTg5R0c5aWc0dll6eWc3NitHTUJYdHVoMU9IL25LeWpVWU9sdU9y?=
 =?utf-8?B?bXZmRFltNmhjbE9aaHhuR3Bjd2VraXY0TGdGZ2lSTDBNbmY4U2M1ekNhRVZr?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287e221c-6c82-42b2-abd5-08dde1757313
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:31.6198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EG2dH+47i4udjII4HNUP98Grq+Xm0aNlz94OpY9Ycu4yHIUOIZ+vfhrXTYDCZK88wxYydEgYnzkY3hYtrR7zp8f17Fd7/SnX3aKV1iSDp/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Authority-Analysis: v=2.4 cv=TdPPdRQh c=1 sm=1 tr=0 ts=68a85f28 cx=c_pps
 a=z2Lz5URPHFYbctzabGIk+w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XqeNvJXGgvzUN9CD1PIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX0gNG6pZ6Ejzw
 oNW7nfMBPXSOkL7czbkFyKdW9xsxtodzRDn9pvPvhE7yRvdXXmBB6kvfhCIy8l6NJ8KTmKh/cHy
 P0bY0FgFzyFuol/nKnDSGPlF6H/1D5RN8TDqYujK2wVOsJwTbWGMc+4NYakuGvyyiNo6fTp3Edt
 PzMsnbTeuS9fdYI+QILttzZQ18VqmfpsayhqR0fldf0saBJJWPt7TXkQC3ubOr+O9gjFLeIiIIe
 gUvFB6lP2JTHS9JQOV4V8OYEk1CLSZt7Po3kP3wEu1pQonpD76vxL+pTz0vvlPcXzDbxfmaBDnf
 HobfcyC7/k8u3clCfZjhTOK1vm2pzUTuGpXS5awLoKfy0XILYYNbs5qG9Ov5B9IxJMjM4Ve9dSD
 4NyVf/9q31Kv3KDFYDP7SheoH4J78Q==
X-Proofpoint-GUID: NrHTClghmTJm-YTUnXUOBcy9quwX-4PL
X-Proofpoint-ORIG-GUID: NrHTClghmTJm-YTUnXUOBcy9quwX-4PL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
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

By definition PCI can never be enabled on an isapc machine so hardcode the relevant values
set via pcmc->pci_enabled.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 924888b59d..e8603b585a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -492,7 +492,7 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
 
     isa_bus = isa_bus_new(NULL, system_memory, system_io,
                             &error_abort);
@@ -513,7 +513,7 @@ static void pc_init_isa(MachineState *machine)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, NULL);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-- 
2.43.0


