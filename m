Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CD1F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdMg-00017z-9G; Mon, 09 Mar 2026 12:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vzdMc-00015m-82; Mon, 09 Mar 2026 12:21:50 -0400
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vzdMY-0004eL-FA; Mon, 09 Mar 2026 12:21:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4k1wjqLlm5HyjI9azYMIP1syel1SnjjjADx/m2LVfkiTKFDAz9xq1tvpOe3ZcekBuhIoMrqZm046LW61lqve9SJ34lXoXlf7PWpfIBijPRZMpRH7WqDL1MMKXdYv5TnvDG2ITOE0Q6bmdtQTir9p4DRmvUwJ9xwI2WVATEnvfamUt0FObxV1PDnTtgXt+zGFzNZBkASQOJwX1QL039lZfNRJURRlYaiFvHh3GIXqWWzVMYpQc8ezeCiCg5Jf88A4UbghMsAS2HT1iyDSeuWVxo5NyK3PJBvOFRiY+Xi5fU+++rkQr1gX0UkHzSlmInQN9s1eqqjb1971I+xlKMTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/QPthUzuwPyhUcDYOX02U7fCs1iDZIbSjBXmildZ9U=;
 b=gLAkdZiavvt5fra9fN9rPyGmya7LMIvi2r1PStAOr4gA+ADRdUeu/fad6MSFCstluV6WPmnrUUBlzo85XwI219Dksv3k8F8SkEx301hp/hGLywUr/egsgXaYK4N1SDZ8Isu5xcqMhy0JU/Al5SRZpq3m8LuRsoEFr4cdY2lL0VszV3Zn3lVegE/vCBUUkaAMIJn1NlLq66cufIp4/a6af2ohnBZsc30v7X2DFiLE06myDxJOE0bD4lDLiuGnWz6nTprzQZyAL2q0/Jv0iC54QklVMqgFpHvRC+jw+u5ntheH+KszLWL9n7v7/qT89m7rzDl5yXaGGOHfGtiYGigPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/QPthUzuwPyhUcDYOX02U7fCs1iDZIbSjBXmildZ9U=;
 b=NPGNPNaaMhu1WrfCu00qBCEubBMoUM9DaBL5pWZRJkA2U4u7wdhIdg1LZ91Nx9lhAZWY5+6uE+//2/OchDyAeRyZfsrc4rIUKc9LWDxFXxrZnXBgXF0E9Fvt8QUBl/2EmGl6C9r+Ek612TTLuJsVUFO8+P3FB0MiJmHnvB0AniA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB1646.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 16:21:38 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%8]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 16:21:37 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-trivial@nongnu.org,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Subject: [PATCH trivial] plugins: add missing docstrings to qemu-plugin.h
Date: Mon,  9 Mar 2026 17:21:13 +0100
Message-ID: <20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260309-add-missing-plugin-docs-159d7ff315f9
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7429;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=J44wResmZl5LyQLX1v8frlyabpDuWkkLuYzFQUFnogc=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBprvMZ339MFQrImkeCxsPXhyE+y+N9Tum7yv+02
 LQTwG983PuJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaa7zGQAKCRCW6ye6MV/H
 fOB+EACn2ELs3Hn/ZBQuDAFRE9tKvS46acl9N5ZPpek9G+yx9hsY+iJd9TN5df4eX8sM/Cr03yo
 rub3SabswQ+S3ILGt+BqohJkY+6Zvm4yB8J0XTfHZ8njoH/rIT1he80hyvZTOjmlEriBLV94t1i
 NDjIMDWzceGinD/7zeaLIVio79HDDEIFbYqJ1OwHb2EzA2rBvJd/ZO920097vPGTWljkSBwxTw+
 w7xpFseuJnlFWvqo4Q8kYGF7leHMgzen+Mf7d+biESRdFHI7bXDM0cw/RBUn6+qVdGhk6E/fFiM
 VVhJGhBN21BlTVFcr8/v0vBW88VzDwY7ZspUNBfUadQHu0JikbLllFIC9NWZFsQrfGgcbE/orWA
 GDvYoHZpiosTXlFxR+A0nZFTb3WPEbTyHRAPPS3hQemhcAOELrptO+29tHVoY9d/Cbh2r9ya7qU
 mUaqJzxEkDn+RJvkTu13A64v08muFb6/NIhFBIoIYyahgrbPFuX6TrGoDyg/+mPEdhOtNxiK0Bt
 OJI1oGLIA326+LF/s+v83LJNTgokBmmS4pN02HnwWXubMEEc51dOqteNBmXvnwO5xXVfJ1qP3tv
 85Z4j43sR6L1Ou2RBoK+R8OQlH1Tggxn+tgt14obFYQY7yjiH5me5VzJn7fqxzzw3N71ZxzaJAC
 XjeZzas/y28BrOQ==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB1646:EE_
X-MS-Office365-Filtering-Correlation-Id: c61f5d8d-136a-4f22-bc36-08de7df7f066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|786006|376014; 
X-Microsoft-Antispam-Message-Info: 5jjVqqh4Zc6UxghTtjf0uz6E+sqHvNJ/DhkRIBHDZCH4acDZk7w03gMyhun+kwW1voe6s8NdhyxxbSuQtP0bDqV4a9nV3tzL0cqPLUMgDcjYatHyNMIkbNxq4yLENg1MHIsz32tYNfOYE7YFQ3WOyq9CjtDvVbbqKaIVMDn4S11Zxa0Io9wAZawvgY4f1E1wsFl3IzlRLO2m006421mWQscq+GYNDSXJvYwz7+sLPlIEiYygLXyDHpK6gmIqG7hWGG+wv88KMM9Og7vuKCMSmHPubqyH/EuwKVDJbtjZ1jaaJFjO3Zw5j2Dbonfxx2GtCYTH5qvaHWI1H0+8k3ahT0pAlE/8hNivk5r/ViQ/kBNMxdr7VQY6KahkIcB4M8IrsBhbrDDzLGnpgWBk+wjbbJiH0xIlldGG46j/5hMqOazf10drAhy38w4M/y/yEdjni7qivzaIOeoYqxR+YYN0Pl2cyqh1xaah5cJr70sqVzo0sY9205cWZaFD0knfwPKpypVAqnS+/++6jsV2f0SOX5vJ3XoCgyirULZ12sVpJsFCjfEqZo87evd2PQowhQjOvU+l+0qRu7ZcjErPVa5dIuvBankyiyUOyu+XKxk3XM13HaxJu3LCJ0NTss5F/tHVILIVfzlNPg43hMacxkvZLu3dMsqXWYuVhOQL+Id6qxZTpm7OkIbvDzdVLIaMHlXBb9/P/QrT8BEmJWqr2cYlAutJZRq4mDbCgIegoQeVCTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(786006)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0JmU0FCRHRkRVdhT0p2ODBoTVFOeDAya1ZnZjVEaWUxeDgzZGRDQmtldzh5?=
 =?utf-8?B?SklMZnlCbzFMNHVZVFJvUmJISjFBZHhXeVZreUpuNGpBa1JQZUhzQytBRklY?=
 =?utf-8?B?SlFoajFJeWNtK2NyNExkQ0JNaVVTTDc3cVBHMDVnbHpreDNIQjJzYUdmdkJQ?=
 =?utf-8?B?QUNZVjRqeGRodjZNSVVpTlhKN3FIbGJpdlpZRHdueWY5VGcrbG5pSG1SVGl4?=
 =?utf-8?B?aGhObTE2U1M3NDNEQWZBWkN3a054a1JDbEVhV2ZvUFJkZ3V1T3MwWVRGMENm?=
 =?utf-8?B?T2NDYVJzeGNsLzBiT0tZbU5EMVhoOWF5SzF4NkNBRzRzNXlkN1VtNW9OWTlM?=
 =?utf-8?B?WEhRY0pFRmoxTGlXQ3kyQkNUeHdjOGNwWkJRcGJXaTFoSE03TlNxRzNuajVu?=
 =?utf-8?B?YTdGZ3B0dnoweWN4MHZsOHhNQVo0Wkx2ZFVidXdiZVpzSE5ycXY5SDcza2Fr?=
 =?utf-8?B?L0ErdWtvZGV6SmxhdlFHOE9GSzRnK0Uwc3ExQkhoWFdMUUZlN21BRS80WjBo?=
 =?utf-8?B?VlFteXRKSEViMGxWQlpONFRGTHNzWldqLzhZeURCaW83NGtnQ2VyblhCTnlP?=
 =?utf-8?B?NWVieG02RW9WbEZOWXhITVhZcURIN1V3M2krZVBjUnVPRlFtK2I1dzViU3dy?=
 =?utf-8?B?cUxEcEFkbG1PNWVpQzNKb3dJSXc4MmJyYmdPdWl3TFo4Ylc1L2lWVkh4eW5R?=
 =?utf-8?B?OU9reEFoMTdtaHhFNkhUZTFWY2NTY1BtVFNyZ2h3cWk5aUhPeEkxWGl0NkFl?=
 =?utf-8?B?eUhsQmYycWVpaitBeXpxYUw5OTRwRGNUOWhHYkxvTXE1M0tsS0xjUkRkdytW?=
 =?utf-8?B?eG1icmhpTkMzWE1NdjQvaEs3YlVqSG50aFBMTWRvT1dxWDY4WitxNGlObGZ5?=
 =?utf-8?B?d0YzZWJiRzVIbzMrSmdWSFYxOG9WNGNBK0hMRmxwcDE3ZWljcXZWVDhRNjk5?=
 =?utf-8?B?b3hWZTlKRnNwc2JzKytMRTZubjVNaWZRYnFqNE0yQU9MY2htZi9kQ2dianZT?=
 =?utf-8?B?bE9CTzZEZFNxN0R4Si8rd1NQUzVJZ29GdSs5UHFNODV6aUxMRFIzdllXUlFW?=
 =?utf-8?B?R0YrenA2cmFTamt1Y2JnSU9YSkNoZGQxOWFmQ00rTmN1SUJ5eWlqTTJDNVZ2?=
 =?utf-8?B?OFQ2aUxldXlBMkpvdXZvTTF6NVQzUm42aS9WMzBjMmFjNDRtRWp5MlRHYk0y?=
 =?utf-8?B?cit1L0RkNlhpWFAzSEoyMjhJRUd6WWVwMWdiYnVmRUUrTVNwaEtiNnR2NjBG?=
 =?utf-8?B?WnZ5WCtjTkpsRDhiellUbWEzaFIvSEcyYnloZmxIWENWN3J6dnh1UEFQSWVE?=
 =?utf-8?B?NngxSnpFZ1ZLWnluQ3d6RmNaZ3c1UzRZV3pWcWk2VUdmaitySzh5M2lHN2F6?=
 =?utf-8?B?VTlrSS94WDh3TkgvaFZwc0YyOGRianV1VkdVM2NHa2JCcTVhRTBJNFNoU1dU?=
 =?utf-8?B?UVVscjVQOFVCck9aQS92YTR3bWkwZHgwTGt3NlRGaG1OYStISGZtL1NrTnEz?=
 =?utf-8?B?TWFSU0xwYWF6WVZtZmpqVW90dzlhc3hnQzh5Q0JtaExWckNJMVlmY1U3bDdY?=
 =?utf-8?B?cUhvK1JhTkxvQ3RWcmoyZ1dCRDdqalJ5RDNFdDdlejFPUDBxT01kWE42dDhX?=
 =?utf-8?B?c3Vsem9TVU4zelZDUERNS2RIbjJONmxvT3dzSjd4ZHhVeFp0eGhPL1FlOVFy?=
 =?utf-8?B?S1RWRkxSTEpwRUZhcWRFMm5HTXJEY295djRpQnNseVB1M2d1cjVHOGNNZDdu?=
 =?utf-8?B?ZmV4THg0eVhlbDNmcFR4Y05IcithaGdqUnhDWjZ0YjEzV3h3dExBeU1WYTVm?=
 =?utf-8?B?cXlrMFBDOFM1Z2srLzFseS9LU0ZjbVlSeGVrWkM4aEYxS1IxYnpmOXNHMVIv?=
 =?utf-8?B?VTY0SFFtaE05RFU4aHFnaWhsQ085YkZDVStldHRoQjJHMXJUdmpBYzVBbGVK?=
 =?utf-8?B?RDRHc3R5NENPMVNDSHdOU1NtMXBNZ3hGQzVKL2FlNUNtTEtXNFhvREdENkE3?=
 =?utf-8?B?ZzFwSkhSem5hR0lWQzlobVF1cVBjYWZZWTVkS0dtRTNaSW1tUzdiYk80MlJO?=
 =?utf-8?B?bzBsZUJiZWQvR0hvM3ZXcGtvZENITDlEZGNRODl2bllyY1AvMk9PR1p1c2ZP?=
 =?utf-8?B?MkFURFJPbnBkekVDaDY0azlFUURIQlN6STZEZU9uSGkrTTh2Yy9zak5CL1Rz?=
 =?utf-8?B?NTkrVVRyZTg1OEtrSm93bmdpRTVmVWpjNjU4cWtyM3piUVJSRDFpSlRyUldv?=
 =?utf-8?B?MEpzZS94UXh1UzNHSCtzaUM1M3dvYnJ3am1BempkOXpMUk1reTNGZzlGa3M3?=
 =?utf-8?B?M2NwWW1mcXBsSkRyZFpFRk1nVnc4dlhkUndFQ1Q4bHV2YlJTeHpnUFdJdFhN?=
 =?utf-8?Q?ynUcvrbKXCteHDRA=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: c61f5d8d-136a-4f22-bc36-08de7df7f066
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 16:21:37.8758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zheBU1DozGtDevGs5quw0DbMnyOgnAE3Jk6wLj87zb6IW9NqoNRVPj/YRrwgsv5p7PLxsBo5U5ig6C8AJog00tdKeIH2fjh8k5AeeZEagrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1646
Received-SPF: pass client-ip=2a01:111:f403:c213::;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

This patch adds docstrings for typedefs and function declarations in=0D
include/plugins/qemu-plugin.h that were previously missing. This=0D
resolves inconsistencies in the docs, e.g., the description for=0D
qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()=0D
but code cache flush callbacks not being documented themselves.=0D
=0D
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>=0D
---=0D
Hi,=0D
=0D
While working on a QEMU plugin and browsing the online docs at=0D
https://www.qemu.org/docs/master/devel/tcg-plugins.html, I noticed that=0D
some of the API functions were not actually documented.=0D
=0D
I went through the include/plugins/qemu-plugin.h header file and added=0D
docstrings where they were missing, hoping of course that I documented=0D
the correct functionality based on my understanding of the plugin=0D
internals.=0D
=0D
I hope that's useful and I didn't miss anything!=0D
=0D
Best regards,=0D
Florian=0D
=0D
--=0D
Florian Hofhammer=0D
---=0D
 include/plugins/qemu-plugin.h | 98 ++++++++++++++++++++++++++++++++++++++-=
----=0D
 1 file changed, 88 insertions(+), 10 deletions(-)=0D
=0D
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h=
=0D
index 827e8e1787..fcf5af52ed 100644=0D
--- a/include/plugins/qemu-plugin.h=0D
+++ b/include/plugins/qemu-plugin.h=0D
@@ -339,12 +339,28 @@ enum qemu_plugin_cb_flags {=0D
     QEMU_PLUGIN_CB_RW_REGS_PC,=0D
 };=0D
 =0D
+/**=0D
+ * enum qemu_plugin_mem_rw - type of memory access=0D
+ *=0D
+ * @QEMU_PLUGIN_MEM_R: memory read access only=0D
+ * @QEMU_PLUGIN_MEM_W: memory write access only=0D
+ * @QEMU_PLUGIN_MEM_RW: memory read and write access=0D
+ */=0D
 enum qemu_plugin_mem_rw {=0D
     QEMU_PLUGIN_MEM_R =3D 1,=0D
     QEMU_PLUGIN_MEM_W,=0D
     QEMU_PLUGIN_MEM_RW,=0D
 };=0D
 =0D
+/**=0D
+ * enum qemu_plugin_mem_value_type - size of memory value=0D
+ *=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U8: unsigned 8-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U16: unsigned 16-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U32: unsigned 32-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U64: unsigned 64-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U128: unsigned 128-bit value=0D
+ */=0D
 enum qemu_plugin_mem_value_type {=0D
     QEMU_PLUGIN_MEM_VALUE_U8,=0D
     QEMU_PLUGIN_MEM_VALUE_U16,=0D
@@ -353,7 +369,13 @@ enum qemu_plugin_mem_value_type {=0D
     QEMU_PLUGIN_MEM_VALUE_U128,=0D
 };=0D
 =0D
-/* typedef qemu_plugin_mem_value - value accessed during a load/store */=
=0D
+/**=0D
+ * typedef qemu_plugin_mem_value - value accessed during a load/store=0D
+ *=0D
+ * @type: the memory access size=0D
+ * @data: the value accessed during the memory operation (value after=0D
+ *        read/write)=0D
+ */=0D
 typedef struct {=0D
     enum qemu_plugin_mem_value_type type;=0D
     union {=0D
@@ -462,7 +484,6 @@ void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct q=
emu_plugin_tb *tb,=0D
  * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t=0D
  * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t=0D
  */=0D
-=0D
 enum qemu_plugin_op {=0D
     QEMU_PLUGIN_INLINE_ADD_U64,=0D
     QEMU_PLUGIN_INLINE_STORE_U64,=0D
@@ -803,6 +824,20 @@ const void *qemu_plugin_request_time_control(void);=0D
 QEMU_PLUGIN_API=0D
 void qemu_plugin_update_ns(const void *handle, int64_t time);=0D
 =0D
+/**=0D
+ * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback function =
type=0D
+ * @id: plugin id=0D
+ * @vcpu_index: the executing vCPU=0D
+ * @num: the syscall number=0D
+ * @a1: the 1st syscall argument=0D
+ * @a2: the 2nd syscall argument=0D
+ * @a3: the 3rd syscall argument=0D
+ * @a4: the 4th syscall argument=0D
+ * @a5: the 5th syscall argument=0D
+ * @a6: the 6th syscall argument=0D
+ * @a7: the 7th syscall argument=0D
+ * @a8: the 8th syscall argument=0D
+ */=0D
 typedef void=0D
 (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_in=
dex,=0D
                                  int64_t num, uint64_t a1, uint64_t a2,=0D
@@ -836,24 +871,61 @@ typedef bool=0D
                                         uint64_t a6, uint64_t a7, uint64_t=
 a8,=0D
                                         uint64_t *sysret);=0D
 =0D
-QEMU_PLUGIN_API=0D
-void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,=0D
-                                          qemu_plugin_vcpu_syscall_cb_t cb=
);=0D
-=0D
+/**=0D
+ * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callbac=
k=0D
+ * function type=0D
+ * @id: plugin id=0D
+ * @vcpu_index: the executing vCPU=0D
+ * @num: the syscall number=0D
+ * @ret: the syscall return value=0D
+ */=0D
 typedef void=0D
 (*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcp=
u_idx,=0D
                                      int64_t num, int64_t ret);=0D
 =0D
+/**=0D
+ * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callb=
ack=0D
+ * @id: plugin id=0D
+ * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t=0D
+ *=0D
+ * This registers a callback for every syscall executed by the guest. The =
@cb=0D
+ * function is executed before a syscall is handled by the host.=0D
+ */=0D
 QEMU_PLUGIN_API=0D
-void=0D
-qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,=0D
-                                         qemu_plugin_vcpu_syscall_ret_cb_t=
 cb);=0D
+void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,=0D
+                                          qemu_plugin_vcpu_syscall_cb_t cb=
);=0D
 =0D
+/**=0D
+ * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall filt=
er=0D
+ * callback=0D
+ * @id: plugin id=0D
+ * @cb: callback of type qemu_plugin_vcpu_syscall_filter_cb_t=0D
+ *=0D
+ * This registers a callback for every syscall executed by the guest. The =
@cb=0D
+ * function is executed before a syscall is handled by the host. If the=0D
+ * callback returns true, the syscall is filtered and will not be executed=
 by=0D
+ * the host. The callback must then set the syscall return value via the=
=0D
+ * corresponding pointer passed to it.=0D
+ */=0D
 QEMU_PLUGIN_API=0D
 void=0D
 qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,=0D
                                             qemu_plugin_vcpu_syscall_filte=
r_cb_t cb);=0D
 =0D
+/**=0D
+ * qemu_plugin_register_vcpu_syscall_ret_cb() - register a syscall entry=
=0D
+ * callback=0D
+ * @id: plugin id=0D
+ * @cb: callback of type qemu_plugin_vcpu_syscall_ret_cb_t=0D
+ *=0D
+ * This registers a callback for every syscall executed by the guest. The =
@cb=0D
+ * function is executed upon return from the host syscall before execution=
 is=0D
+ * handed back to the guest.=0D
+ */=0D
+QEMU_PLUGIN_API=0D
+void=0D
+qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,=0D
+                                         qemu_plugin_vcpu_syscall_ret_cb_t=
 cb);=0D
 =0D
 /**=0D
  * qemu_plugin_insn_disas() - return disassembly string for instruction=0D
@@ -861,7 +933,6 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin=
_id_t id,=0D
  *=0D
  * Returns an allocated string containing the disassembly=0D
  */=0D
-=0D
 QEMU_PLUGIN_API=0D
 char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);=0D
 =0D
@@ -888,6 +959,13 @@ QEMU_PLUGIN_API=0D
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,=0D
                                qemu_plugin_vcpu_simple_cb_t cb);=0D
 =0D
+/**=0D
+ * qemu_plugin_register_flush_cb() - register code cache flush callback=0D
+ * @id: plugin ID=0D
+ * @cb: callback=0D
+ *=0D
+ * The @cb function is called every time the code cache is flushed.=0D
+ */=0D
 QEMU_PLUGIN_API=0D
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,=0D
                                    qemu_plugin_simple_cb_t cb);=0D
=0D
---=0D
base-commit: 7608a95d2e0bd8c8d069ab77824d02586dd94648=0D
change-id: 20260309-add-missing-plugin-docs-159d7ff315f9=0D
=0D

