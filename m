Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FF5EC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPVR-0007fI-9r; Tue, 03 Mar 2026 08:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPV8-0007RD-Ft
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:33 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPUz-0000OD-LF
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMYUQLXh04DfcqbdbF0YczW5DCJ5JkAqVLCsk2Q51fx+VOZIx6cwW5nCFZKKBYCm8OnbuwjWthTTUrEJPpQISVqUDGaocuWHBZYeL6rSqXaHXNn6vyrVpxOuLF97/1bJ/o+FlOyMhkj5Rxx4R6dyDuPs7nxuHyZMH2NSW4kae0uwQEgjlk3G/Wq6StVW5gQLFYKx/GihAzY9JofpdHacEFTIooBRryLuQ8Fhe+6ta0IzWrJvPy4AUVwGJrd7Dx9YCLczWwPDHX0dSKD3bA2ZLgfwDnqtvUKxGYkk0IIg8nd7pl8qjpKmUybKLT/QyQTUn8WwUPupHwr0is9RjF6Yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUXnfatmEsAmfIU5ILZBfL/gIZ28r9pvMnP8uEMKOxA=;
 b=Mv/Vmlk9eYd8gWT5T7F2Jk2GppMcefCoaQijsGzTZ5ixeqTDHZ7z4ewmYDh0qyzJtswHHyGc+50RIJ/+la0lBWiRN7HxijJyZOER+UOKSGEEoC3cjnyPBb8/ZdkoxSmNcyuXsK72fLAmHUNa/f+LZCV4esYZ8OfWF6FjAgFpsZlpCFAnCIzXP4/9Y1yhshdhY2V22PV9EIUiLZGDw+abU0FR5dip3CFcK4GG+81kRqAzpYvmuU2A7lnO90cJKBiQw1kzKlm11kgSh6+8B3Pj4bkFBMpHxBwQxsz1kQgyQwKkAj8TFwm6qoZIWTaz/ceqMui1+u6q+X5TPo6B7kIipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUXnfatmEsAmfIU5ILZBfL/gIZ28r9pvMnP8uEMKOxA=;
 b=lLvCQayB2Y/vkSVN/9WnjHUcDtXays/QvEnofdMKg/Qick8kziyWYen5lu43kXNLSl/4FSHioM6BF57aQXf27MFBpD1eV4tUacHLO6uVisBwJ+uX2CkMhX5ftYM0ip2t3w+uEv2j0381hU4CpMjxFanP/qDV588g4sq62KlJ+og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by GV0P278MB0984.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:08:43 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e%2]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:08:43 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
Subject: [PATCH v6 1/7] plugins: add flag to specify whether PC is rw
Date: Tue,  3 Mar 2026 14:07:27 +0100
Message-ID: <20260303-setpc-v5-v6-1-15c77cfe184e@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7742;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=1eBfWvBd2sU0mz5+WSHjXxLNi8omPy0N6ZUjNno/wHI=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBppr1fShCASXNACa2uOdgGn7fIxsiDUoJflPgw7
 weUJhxbmQiJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaaa9XwAKCRCW6ye6MV/H
 fNcLD/9iBErgiOsN+VR18frTu9w86HH8CwRsFbaD4KGb/o1OE+/iktiO29Yrue0P4OA7vYsjUgq
 kbWaagbJYr3mHvocwZBkDai23ZDaiNMUYc5zynmB9pOVTPFnTSun5idp59z14zmOTV6g4CcLdsL
 BtxipS4F2c7P5n0IuagNK64FhKMO/s9Wn80P8GmgZPkrE5LfbkGs90FiDgzijjeMnQxEYAmwKe0
 /UWryWFuALAWkLpPJujUnPVEBCCpsU39dTO0fp5Udwq2ZYbfn+618H1mHagBQlIvKKkqWFp58IA
 1whBxCacVmYinrR853YgpoUea051ALTKgWbfNb3RFUvXFfzmRhGAXQt6+ydLcZaX7C5Y3n5wCd/
 J0VvDgRkZsgwF9y4Iv3QOhv41JzyiRzYs6oL8fkUqerdhv5Nr9geT+U4aMjaa6Ksjm+oywZOjMe
 2Zms6f9B3bdbP2fhoMxsK5jdd1i04id6jJypArSKSbS2tNSD509j9oS+0sFwaD84lZpBCB6ST14
 LC7LHMDs1N3HeE7co6pW+4varpjuYc6LeYtd+wkT/wXh3OhPTpIVPWPKILe4CgRq60ggYEPOxU3
 89Akr8xDPw2s/EmLFVrcM1jPtrX7vcyQqnKmLOHhPiDEO7PJA0B934ELbXVBomNM2LbX7WTiOFn
 31ls2Ta1oOOXpEw==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::22) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|GV0P278MB0984:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef384bf-be5d-4d7f-9629-08de7925ff42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|376014|1800799024|19092799006|366016; 
X-Microsoft-Antispam-Message-Info: d9Ue9BgKYT28MH+ZwJ+EP+Sibh9cemb5J7wJEPKuE0jD8V8hfJmfTNsibB54+UDYKoN+AKsG+BJJcOmK9l4fwscJJoiEVxI4i7JaaVKJiPUHO5l2CkkhSdr8YRz1Wu2SX26ZGNQpBYWx7G0JB6wQeg4PaOiRkDtJPlip3eH30yX8fimaKeUBxmdUJHsAgeVrl3M2s4lsTNCoka6eyVdte+hK61OA3BIPTHYdg1M2twWLJtR+40vRV99ZVww1VMDe0ZMCQ5UaUOkdxBVyjwsiivBDNLrf9HJNoswhosWgEpmLcIBXDz0rOLRurs6oOL7/jPa5YCqKhO5qozz18lJu9R66qgOsxfL4buhLZriUt5Q8fcr8XMvTd9TsA8K5hDwaj7XJm45TY4Fknd+d3jvUTQLIR+gH0H+bpKwVJpvO2novu1ddBhtcadf9L2Dq1v3BhBRM/bM5yndmOZcmyNfceWT6lWgOuKtkxw7xnlMQ9l9EypzVl/2e8mcpE2ZzmkhhrDVjJTsk3nWQvdxf8OU3eq5VGWdXm2cUkS5YU6FZqy1jsT5n14P3Lzwsxtu9z1r368B0kRAtbUBxN2i+xMcH5teBZHQUPzZK6xhjzvvdJxcpTuamd8iAo16YDQ/tgJmFQCWUBfaCu3cgbsHSDoMaIXSVZ27DX5qaFt7kqww4Uu70vQG+K6hgusSXnUFj4uhU7z7UDeQkPWRD3Vd4i3eCg0QiLNJyCO0tEtmZ2psbTMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(1800799024)(19092799006)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhoOTJOMVk2ZWpsVWNCcVRBUmw3Z1hPMlJvM0dsVEV1aVV4RkJqOFYrOEVF?=
 =?utf-8?B?bFBRUHdCbXlpS1UyNGF4QzRLaHk1YlVaZy9QK3JJczRWSGhJSWFnY2hXMGRU?=
 =?utf-8?B?OWlMZ0ZRNWluZ3BueWdvVUhUelp1a1UxTnMvMzlkSHhTcS9IUjhZcWhFR3JD?=
 =?utf-8?B?N0RGOHRpVlFMVlptRHVnTWY2enBOQTVJMVZtaTR6VkNvNy9XSnk2cS80VDVD?=
 =?utf-8?B?U0JBZXF6V3cvRDBVbXMyWjZFZUJVNi9lZmxRU0dpU0dMU3prWGVBdmV1WE9v?=
 =?utf-8?B?VDlta2NzK2QrczJzRktrM1NFTE82Tk1UTjZGK2dUWXAvQXIzMjc3TGR5U081?=
 =?utf-8?B?QVdoRmM0c1VndUhSL0JDZkVlOUZqZjRvVk1QdVJ3TXE3NHJJWlRTTVh4VXBQ?=
 =?utf-8?B?WkNiKzNpZWxRQnpxSktFYlNkaGdLRmdPU3d2bUp2QU1PUWxWQXJvQVdJTzM5?=
 =?utf-8?B?WGpIMUx5SUlFVlI5UjRKczF3dThXY2JsMHA2OE9NeURKZ1F1Zld1TkN4dS82?=
 =?utf-8?B?Uk04SENkWEE1cXU4YWFIRmZScE9DMTh2ZzVBZkNwVURSZlBpQlREaWtyNTY0?=
 =?utf-8?B?bG9nSTh1U2lrT01XWFhtZTJZczc5K3BXUHBYZDZaTjZYaXcySlN3dnRaYnl2?=
 =?utf-8?B?YmRuK2ljbnlVUWhEQ1pER2hKNmQxalZnZWU5TmlGRC9VdVI3eGl2Yi92Zzdw?=
 =?utf-8?B?WCtoYkowMU0zOGJGK2VWQ1B3cGJFTVRSRkZOaGJOQlVTUHlyZ25GeVUrVFpQ?=
 =?utf-8?B?ZEdkNEM4WEkzVXY4N1ptZW1pYkt0SWdzSWMxdGhTSFhDaXk0UnNVR0JWUzgv?=
 =?utf-8?B?TWZVRDF5NHY1VC85RmFQMHFqVU9qMER2dGl2QTl3LzJBRkl4SURKVGtqVFJR?=
 =?utf-8?B?K28wSGdkRVl2YjU4SU9HbWR3VkdPMGhlMFZReW1BeEt3OVp6K3UwYUFsSnMz?=
 =?utf-8?B?VlVKOXgyRWFYbjVHSjNSZU4rRDJVZzNKZGYwdXoycG12ZllkNlM3VXVMSWJB?=
 =?utf-8?B?NEJ6VjlnUzVhSDc1Z0FyVXFTQlc1K0hTa1oyRnRISTJMVHhzSG9Hajd3SmRT?=
 =?utf-8?B?ZHpid3FWeG1TZERObU9xZ21iYTF1NlJzSHNTY3ZxMEo5K2tCK2lSc28vMm9N?=
 =?utf-8?B?MGRLdFJScjlEeXFqUHZsTndZWGkxMjdRZW91ZjB5emVJb2hhWit2SWtSYUdh?=
 =?utf-8?B?blh1TEFvamtsSzg5dXR0WEtSNzZWbkNtaHhPTHZxTzFDcU0zZ0ZIbWpuL1RV?=
 =?utf-8?B?YU1WMm9OOVdwMC93TnFUV1BRKzdmTG9qYlYvcUp2WGFrMEZRNGxldkxKMkV1?=
 =?utf-8?B?djBybnRpUzRhT2pzd2VGUXpBODlJUUVzbzh0VkNDQ2dRdWJCalRzUnpERkRG?=
 =?utf-8?B?V28wTGVYKzl5c0pQcGhpUkdDMDdhUEM1VjBjWE52Z1FjV1RQUDJPeldoMmhk?=
 =?utf-8?B?STNvenNSOXB6S3p3R0NuemVkbDlEQVBZbnNKV1BpdWhxK3hrQTRYWnFDWSto?=
 =?utf-8?B?ZmtZOXNjQTZGbHVOZEtoSGhMUS9Ud0E1cTNMTzZ5Q25UUlJVU292QWN5VzNN?=
 =?utf-8?B?NU5EZ0M5WHZ3ZSt1OXFvTEtOWEE3c3NPMW0xdFBYayt2SHVCUlpmODBZVWRx?=
 =?utf-8?B?T012SFMrRXJGU3g2TnA3WENURkh0NnEveWZvdGVacmpVdlkzSldFU2wrQVhP?=
 =?utf-8?B?UUlMMUV3d3NzK2ZOdlVHbm43dm5WSEE3UE1VWkpQcGpCaDE0TFRjc1NEd1Fs?=
 =?utf-8?B?NjBleGpKSkRhdnZMY3BQUGQ0c2lLNyswOFl2cDBDVjgyZFdVc25PWnhDa3I3?=
 =?utf-8?B?SDd0OHNDTWlXZ2IyWTZuV0h4UzhpbVdacEpiaDNqdFBia2xaa3BsVnBBRXJ5?=
 =?utf-8?B?d1B4a0xnSElGMktWRkFRbU45dXE3cUdRbTU5bmc5VlB2U1drZVFvSGpnUW5V?=
 =?utf-8?B?TG1yZFlnRjQzRGJOdnQ5dE5IWGxuWnZSSVFydUpSZVFGY2VUSVRpMU81L2tQ?=
 =?utf-8?B?M1lrTU80T2gzbGxDN1E5S0JPMWRLTVFaODFBckNtZmJHR04zeUtaV1dVUzB2?=
 =?utf-8?B?N0d2aHZ1ekhBTk9jNk15MUpLNTduRTl2ZHlMVktVUDRlVGhtMzJJUndKNzVz?=
 =?utf-8?B?R25nYzJkRjF2SlR2VlhKTCthUE9PRUJTQ3lRclZOblFTWVNkYkdqRVEvczc2?=
 =?utf-8?B?R0RpUHlBaTNuaGd2M0xXc21PdENVR0k1WXEvZVRXRCsvQWlxWCsyZGcwOHBp?=
 =?utf-8?B?aE5rOExtVnBqTlN6KzBFclB1ZTByVE5xUEFGR3lWaUs1VDlzS0FwM1BvNTVM?=
 =?utf-8?B?RjQvUnBjOEw2SzNiaWYvSEFBNlZYdEcyb1Y4NEx6b21sZVFIWWd2UT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef384bf-be5d-4d7f-9629-08de7925ff42
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:08:43.7908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/5ciuEtCdEha86zuqn30Kl9zx2EjKh/lx2jIt2tEwU+ewYH+a07Ymcd9jQEMnijfQTEsiC+jVXgh1M/fWqUY9ghsN/+FNOnXP8anoNxTPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0984
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

In addition to the flags specifying whether general-purpose registers
are read-write (rw) during a plugin callback, we add an additional flag
explicitly stating whether the PC is writable. This is in preparation of
a patch that allows to explicitly set the PC to divert control flow from
within a plugin callback, which is currently not possible.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h |  3 +++
 plugins/api.c                 |  4 +++-
 plugins/core.c                | 29 ++++++++++++++++-------------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 17a834dca9..a6ec8e275d 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -325,11 +325,14 @@ typedef struct {
  * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
+ * @QEMU_PLUGIN_CB_RW_REGS_PC: callback reads and writes the CPU's
+ *                             regs and updates the PC
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
     QEMU_PLUGIN_CB_R_REGS,
     QEMU_PLUGIN_CB_RW_REGS,
+    QEMU_PLUGIN_CB_RW_REGS_PC,
 };
 
 enum qemu_plugin_mem_rw {
diff --git a/plugins/api.c b/plugins/api.c
index 04ca7da7f1..32eb086300 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -458,7 +458,9 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
 {
     g_assert(current_cpu);
 
-    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
+    if (buf->len == 0 ||
+        (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS &&
+         qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC)) {
         return false;
     }
 
diff --git a/plugins/core.c b/plugins/core.c
index 42fd986593..7220b9dbb4 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -119,7 +119,7 @@ static void plugin_vcpu_cb__discon(CPUState *cpu,
     struct qemu_plugin_cb *cb, *next;
     uint64_t to = cpu->cc->get_pc(cpu);
 
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
     if (cpu->cpu_index < plugin.num_vcpus) {
         /* iterate safely; plugins might uninstall themselves at any time */
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
@@ -395,15 +395,16 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    enum qemu_plugin_cb_flags flags,
                                    void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -425,15 +426,16 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
                                         uint64_t imm,
                                         void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -464,15 +466,16 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
 
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
+        [QEMU_PLUGIN_CB_RW_REGS_PC].flags = 0,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
          */
-        [0 ... 2].typemask =
+        [0 ... 3].typemask =
             (dh_typemask(void, 0) |
              dh_typemask(i32, 1) |
              (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
@@ -534,7 +537,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -558,7 +561,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
 
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         func(cb->ctx->id, cpu->cpu_index, num, ret);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -584,7 +587,7 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
         return false;
     }
 
-    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
 
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
@@ -605,7 +608,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
     /* idle and resume cb may be called before init, ignore in this case */
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -614,7 +617,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
 {
     if (cpu->cpu_index < plugin.num_vcpus) {
-        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
         plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
@@ -885,6 +888,6 @@ enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags)
     } else if (flags & TCG_CALL_NO_WG) {
         return QEMU_PLUGIN_CB_R_REGS;
     } else {
-        return QEMU_PLUGIN_CB_RW_REGS;
+        return QEMU_PLUGIN_CB_RW_REGS_PC;
     }
 }

-- 
2.53.0


