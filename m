Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F681C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAWV-0005Gi-KX; Fri, 11 Jul 2025 05:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWS-00058e-No
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWM-0004je-Hi
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:28 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B70gmU032396;
 Fri, 11 Jul 2025 02:58:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=jcatWRTL485JS
 nntGaX3rizKbZH6ndw4H2wn9qPhyOc=; b=UasW0Qj3Ni/s3VtCVOK0zJepiVvR6
 ikMUVMi9dio90qKfeygKO3SH/xAqT6aLZu0dNcTf/P+Jn9GqHZQCAcDOHQgtkqQ4
 sea8a6wM6xt+p4NRHpKbVu9VVg7uhzEKuY/dt+Hg9cFbDa8JrOjB0T6fqIB1nv+2
 O/Oi/ss3HlYvhBXONlNDpPVAB4TywZz3lgJqMaloIyuadI8Sg41XnTgvowjZL08M
 uVRnT03Xay5kNbmKfeAfa+MhGspWOM50SugiHOnAe2Qicmxp8BRKBTicjgYVtppq
 ah8tLyWSg4LzwT6zHf+tFp5jstdWVHkEAIVSv7+n55LreGYSTsvtI8MdQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022093.outbound.protection.outlook.com
 [40.93.195.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q1karqjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiQEdOPeKLAtDFr/UXPesYdDfDktLoaYlpCHD7Uh3VVEkYTahkTX8bjxr+VVyBKt8GIfwrwLS0mYoKttnqJn8iRz0J9qBS9Kq6o/QMitdmpDKwEVnDfV00om/MAqQrQQzDlF0vevnrryivWJkID7A0aBbfYL9j8l19wYnUr+pW1xPEZuyNfqeHzuvc4b2iz5RzeGFbQZLG/gyl6Eol8QUZQj4QS0v6j88+EFUniTNqpVR9XhvfNDhhE79UAG7xtsf971ZxzTDnb8KFTNmNGOoYbtO+kbkFH/e8E2w/cjULtjLiIPug5IeJMlnCW/YBGwcfBK/LRCtMn0TBeMUW2P2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcatWRTL485JSnntGaX3rizKbZH6ndw4H2wn9qPhyOc=;
 b=ruuV8dxaI6oRxkjXvn87cEx5IF10Qm8ViVDr4jEzx7m5Sd+CT3pWuPqVdE6d6UxYbIn+egM7h3kFUo6GDWOF6+9S29xmwy8GYN7VmksQYJy4lj3SMd1XUhewAdNfp1Ic5+eq8m+NKzzvAwigxCzjakQgt/K5VWcG5jESvM7VwFu44GwNxAXC7MY6BneaxTOJYgXlbTtyUeNTalc5ZNRwyZOT94NIo5TEJRWiTlTBw83AAZ9UqFhmBlkYil40c/GElhczVm85zPXqKehqcy9x/nq5eUjmXE7BloXNhHhGPgtx0wBQshtZeaQb6gT+N/pvXY7ZnCX16i224xqWq5KGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcatWRTL485JSnntGaX3rizKbZH6ndw4H2wn9qPhyOc=;
 b=iiUVjtjxUnHPzSJocWyBcrW7gN0f5krFAMdiiTGJYwnIza/GEewmxvrzWLqPGQwMCsCrMaPhw7G5VAk5Pcd8+w6odjRdHRf4l2xDVKatFoureYt71HyoPyxx0yAISkRBtEAyWsUDIzswegOcfPG74/9FNuNYrzDdA1pFeHrLhcZTJh/JV+54jKTKKGL15khDyvdIcaPqR2U/dOIshMZ0PQUuB8Xn1XDCFrXPaVNnje4LO+dCNqyxYzJbSpQZLHZJvF/SdP5bKbD3M/ztXGyyGeKMNQpDUxm0YQ6YF5TbU3gecEchC7f6ZVWqLG4kKgItDoSTnQ48jaAgJOSt3dYtjA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH4PR02MB10681.namprd02.prod.outlook.com (2603:10b6:610:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 09:58:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:15 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 00/19] hw/i386: separate isapc out from pc_piix
Date: Fri, 11 Jul 2025 10:57:02 +0100
Message-ID: <20250711095812.543857-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0113.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH4PR02MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: 343e1d9c-e5b0-4506-6cb4-08ddc0617490
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTJrdXMxZmcrQ0tvVVowc2hsRE1DNElPbFo5eThGazREOVlOYWlkV2E1dWNv?=
 =?utf-8?B?d3JVUitPQnRMbSt0NWxVVEVMTjRwdVgvcVpKanRiNTd2M2ZoMDVIVlBjQm1k?=
 =?utf-8?B?U1Z4MkZuWmJMZk04bFRkc2owMVhYbE1PN2pEalpoWWxQcWRjeXlnaTBkSmM5?=
 =?utf-8?B?M0ZRMW9LNG1CeXdya1N3bisyVmtPY2pIQllJeStrdHZPZkJYNUlpbXhDZEdK?=
 =?utf-8?B?L0E2a0NBY21zRHc5b20vZ0l0SUk1emJ1R1VJUlRnRHFlbnZ6dE11RCtJSXdw?=
 =?utf-8?B?NkNrci9CV3N2SDNOWXdmZ0V3V3l2dzgyakdnWFJldlRxQk9OYWtXbklQaEth?=
 =?utf-8?B?dzNxRS9FejN1WFF6cVJBSmVFV1EwZ2h2Qm05VCtGbmtpVXJ4OW92SGx4Q1Za?=
 =?utf-8?B?eS9DU0JkN2s4VHF4dTA0WDc1WGtXcTFuVVdsUjd1ekh0T29PYnZjcTVFQ0Iz?=
 =?utf-8?B?Q1dJV1M0RFpVdTFnQ2NFUnFBbTMvNk8wTVFZeFlxS0pMeWtkZy96R0ptSW9N?=
 =?utf-8?B?bWxDT21hY0xWV24xeVNuYkIyNWVZb2lvaGhDMmNVTzU3TlltM0MvNVJQZlM4?=
 =?utf-8?B?NWltNDVleVA5MG9HYmhXRmx5SFI5THg0QW1NTU5TbFhNR1JlRWFJMzc0b2N4?=
 =?utf-8?B?d1h6eG53blRlenIxL0VOVjFhSGxaUHgrOEZxaTAxUXg4VS80RngrbWtxejNU?=
 =?utf-8?B?YVZ3MDJHNExWNEp1UDAvY2MzTFIyK25zQXpsQ3Nleld2UTNaOEdUR3BrbzZl?=
 =?utf-8?B?SGZoV3pTbk1kRW5xKytpdVBKaUg5Q0ZpVHRtU29yQUZkKzNabmZSbzB4TnZH?=
 =?utf-8?B?Sld2OTYvM1FVZ3FzS1hMNTUxU1BBUDNTbDgxYnZsaW50dFdub1dPYTN6SXZ3?=
 =?utf-8?B?OHVwb240VXpYUUFCN0RCeWxSdGd6K2hZN2Y2ZjVXaTIyU1JPL05CWGo3MERR?=
 =?utf-8?B?bGduNnpVSDhJQ2lKOGtmNjFaeDVkdnRORHp5M2VPaUREcEhLa3kvejdnM2cr?=
 =?utf-8?B?a2JrZ0srSVNkc3VBWkZTYnFSQnFBNktTMmFZRCs0VHJHYlNBZmRvWEVocGJY?=
 =?utf-8?B?RHBMWHZKbDF0dWJIWmQ0SzBXWThlMmhzR0JTYTd0M1c1dEYyZzFBV1dCa1FV?=
 =?utf-8?B?aHFQUGkyVXhCWFlqRXBFMVZTK3RiK3ZwU3VrZSs2V0tEdVNZT05VRFhROVBw?=
 =?utf-8?B?M0w1QTFtdUZRZW5IQXVhSmEvemU4RDZlUktsWSs2OWtDOVVQSmVrRHNvTGNt?=
 =?utf-8?B?bVdXWXo4TGo2ZTE5ejdobm5tWnZjM0pjalhYalRsK01BcFBORG9SUmU1dUE0?=
 =?utf-8?B?MXJiT0pLNk9jc1V2dlBTanhubGR2cGhjZWo5NmpGeEozRGtMakhtc1loOHA4?=
 =?utf-8?B?U2swOVpQN25JWnVSaVRYUzhsc2QxaXgyU09BcmQzWmNTVVhPN0RCbG5mc0ZY?=
 =?utf-8?B?dGhtWXlBb2JnTE94MExRbWxneEozc1puWWcwVlJSMTV2bWdNMnNPcllMT2VO?=
 =?utf-8?B?cGtnazFqVDc3MmxiMmUvVzJiRTFWTnk1K1NrSFJSbXhDVEVvc2UwbVlHTXVU?=
 =?utf-8?B?VldYTkR5aGNnS1k3cDhzZUVDaEtQY3ZpbXJXNEtTbGNqUzRYZ2RISEtnM2hq?=
 =?utf-8?B?Z2c4TjljTy9qdGdaT0NrUFJLanJyMzQ0Z05MVjBLUC9DeVZUbGFSYkdkdlBB?=
 =?utf-8?B?ZXp4eWs2WWFjcVhQVEVQUUxzSlpESEZLQ3dVcStTbnZRbnJpZjhYVm0vWk9J?=
 =?utf-8?B?dVMremFsVUFtYk1TK3JQa1l4Y0VwYktEVCthWWtxSTJuSXpDRFA4Z3ZlZHdt?=
 =?utf-8?B?UVNPTUZ6M0tRN2tiOW9Jd0w4T2cxLytidWhmRDI2M1UzekhsMHp5Wll5SWNj?=
 =?utf-8?B?eTRvOERtYkJkWFpFYkt2Z3FtZnJ1TzBWdWpqWXNneWVkSUFlVDJTeHlrOE9E?=
 =?utf-8?Q?t/scprHT2OI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUJwSjRSYS94TEhJNThqcXFBeU9PUWo5TEJrZmN1L2hZb2VuZXdoRnpCdFpB?=
 =?utf-8?B?UVpHQzNEK2dwZWlUSlhEVXducU1Yb3RONnN5NlhnOHQvbmduN0tmUW42Z2ZN?=
 =?utf-8?B?dzVId05ockRzSElLQkJVeC9YcFVORWtOWml5WDBqUGhYd041M0xLcERLVWpx?=
 =?utf-8?B?UjQ1elRObjdVMmVsOFpZL2hSZXpVUTVpbWxiNVN0M3VYSGFueHhpZWVjUUtD?=
 =?utf-8?B?eTVEY1pBMWJ4bXBQTGl5STNjUU9JcE1xbkpsMTBHbkkrQXg4REc4alo4a2dE?=
 =?utf-8?B?dm45d1RDeHBhK3dYNHZmd01aK2ZlUDJsNkdZbndzcFp2ekxGeURjWmxtSWMx?=
 =?utf-8?B?SDZkc21lUEFtc2diS2NjaFc4bWVYVDB4ZmlTV05WcWJadlc4WEQraUV3ZHVv?=
 =?utf-8?B?MU9KVHo2RDA5UW44TEJ2UU5SUk1DWDMrUVNreVNaVUpMeFg5ejBWMTVlRWNJ?=
 =?utf-8?B?WkVPdHByaGZ0VVJaOWd6SmY0VnI3dGdtNFFvUzlzOExvckI4WFBhRVk4cFE2?=
 =?utf-8?B?YUp4UjIrSDNkZmJQcmxyRzB2Mk1pK2JXR0kyNWltREI5NVptUzltV1hjV1h2?=
 =?utf-8?B?ODQ1Z2FtVURSTk1iRmhGOU1HSUhZejFxY2V6VUlrTE9iRUZFRmtoRHVoRFdK?=
 =?utf-8?B?YjZGNkpNeTVTN2NFKzZRTlUyamJkcVFSYkM0Mm4yek10ZEkrYkJhVWtEQ3BZ?=
 =?utf-8?B?ajZHRzc2R3RNYTdUTWVlcGxNUytNYkVwUHQyaDJpRTVEUTcrUXBsMDJobytN?=
 =?utf-8?B?Q0dEZkhPMEltekNXcCtqUVJRd1ZvSUtMYTdzbEhHdGw4dUgvdkl2K1ZoaUJz?=
 =?utf-8?B?d1dLTEhQaEF2M3VEREFUQ1hFbXZBVzAwNnN1czU0MVRaUmsrdW00UUlNMWhv?=
 =?utf-8?B?YUoyRGIrUnRPZXVSTTZTN0ZwdVhqeDgzU3hYUHVCOXBNVmU4WkhjUUdxcm1k?=
 =?utf-8?B?c3JBUUJCNHpVSmx2bnBzcHIrZkxnZVBJZlV2VWRHelVPZVVyT1dEeHYzbDh3?=
 =?utf-8?B?clNvbG9GdGx4aE5adGlBNzRIbXVVQ25SKytpRFBkckhZcFB5djVBdUZsRzdL?=
 =?utf-8?B?L0p6RFNVWFpSMjZUZ0o2OVJTNFRnOWc5MDhwVDUrR1lFM2NOS1dDbGJpUmFo?=
 =?utf-8?B?RHJLTEZvVE9WMnVRVW5Bc00zeVZ1aEs3anVid3JjeDRNTFdSa1N3dHBjazF1?=
 =?utf-8?B?WklvUm41MDV3WElCbHl6U01IUUpESnd3dGp2ZDVubjR4WUFaUnBYT2JhVmMz?=
 =?utf-8?B?RXRCNlYxVCtqMlhKWHptSXIwYWVjTHBQR3NnMEp4T2RRdzRReTV2S3ZrU2NG?=
 =?utf-8?B?WThPUVZyTDBNc1BuZGpOQUZjemx5VmtxdUxFU2UzNG92UGIvZzRaY0N5Z3pn?=
 =?utf-8?B?RmRrcFh4RUYwSEFqZVF0THdRbllWaEVnM3p6bnRtK2FBcFdlZjQ2dDdUR2Qy?=
 =?utf-8?B?N0l0dStlTERLQVV5N0FaTWxobjJ4alF2dFMvaFF5b3lmQ2czWFJVc0EwYkVy?=
 =?utf-8?B?djlkY0xsWmNiRnczT0lFNXZFdzM5L01JdlFaRHJ0UnMveUxKV0JqYkJHUWlt?=
 =?utf-8?B?bTEzQ0NYZ0l4RFFxWUVuamxnU3JkQ2ZwS3VNRTVSUnh4eVJVS1Bob0hzWGcv?=
 =?utf-8?B?V2FueXlOMDA2T2k4TXIwSjcrOTh3emp2QVY4U3pkMTQ0NFVIMkVxQVpadFE0?=
 =?utf-8?B?WXkwNyt1MU9FMGFnUnc3Y1l4bllHM1A4L0d0ZTRUcDRxanVoc2RDVUo3aUNY?=
 =?utf-8?B?M001L3ZHeXhPZnBuNTBhSW1aelZ3UVZyS2h0bTJzbmZGK2twUnhydldIMU9m?=
 =?utf-8?B?ZGhJR0RpNHpzWWZ1MUNPejlPVlVrbVRUN2c3amQvbFFEUklwSXpEQTVkaDE5?=
 =?utf-8?B?eVlvRis0VjYvUE1VaitQWEN0MHA2K2kreGJ5T2gzRUY4QjZwTlpRK2FPMGNS?=
 =?utf-8?B?eGtLZGpVdUpLeFlHcjFWUWhHdkd2WXBWcW1LSWhQb1Z3WkRJa0lVcFJDckZx?=
 =?utf-8?B?Yk9RNmtVV1d1VVRCZlVNenNwOEYxTVp1Y0lqemo4NmNJelEyb1NuOFRtSlFt?=
 =?utf-8?B?cFVNeWRxMkEwVFNCcnFkTnhQaXlBVG5hVjYzYUthVWkraEdvWE5kZU53VlI5?=
 =?utf-8?B?Q082bElRc2NORnp6OUI4aGo0OGJvUXp5RnNLOEx2V3M1NXRCYVdIWU9GT3d3?=
 =?utf-8?B?ZHcyOTBjTGd0NUVHZ003NTVLeHcwWmFhdG96dEV2RnByR3dnelYxRVpxTjlL?=
 =?utf-8?B?dWM4NUZ4VWYweFltSmp5ZHl5a2tnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343e1d9c-e5b0-4506-6cb4-08ddc0617490
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:15.8605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +M9XRvyuOivDFMQDXdBTDTV2SqkdgvTE3YveQrerEZ2lx/zt6ROffUA6R5OFNnoU8ABm2KZ446KUuJFOnMc6kX+1lfK64Py2Zw9K1XqT3uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10681
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX7aMJkDXVCKFR
 Nu6C5wu0ZldgCFHkdcAn+yWvmpe4qI7RwAyjRcq7MvYmIkWvVypsTe32Q7p6hDo07Zz3+yGFy7N
 Y7LkKuedcKUZ1uOSjU6OcUiceURMtHhySnYZ+C6+8W2ujLbJZTH4bK2AvYqfdpNhmw1KikjQLzA
 YeB3IjVyWWJ2eClWCN0N1n36eR2e6F620guO70w8C0kFARGMHgSinZ9WS4zbbt8AdPhIqdCCnys
 RoByFladVCBi241gJ7M6a0kwq8W7vbdzEbhtNskTmtkPal4XgaJxfuwb9JDGwwyMaG8qE72qr+H
 BG5j9YGXdom7FkCs+dTbOkKS0PXxk+KLeAeJ/OsiPTM6vPF4Q72Gy0wFyBEqOkNQqXlPsI052+i
 iTFMlTBk94no8x3hTDB4PDTuJJcR3A9FfcagNdItBbK9GCmQxn2fgm083T7yNxnoJHPotSmo
X-Proofpoint-ORIG-GUID: Xz4-jwfE9hcrB2yHfqNI00mzpGRubzBX
X-Authority-Analysis: v=2.4 cv=Do9W+H/+ c=1 sm=1 tr=0 ts=6870e03b cx=c_pps
 a=0DdwKqzxgU9dCJ3Pc4DlvA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=mDV3o1hIAAAA:8 a=64Cc0HZtAAAA:8 a=HUHtNuVqNzIun27e13kA:9 a=QEXdDO2ut3YA:10
 a=Y4I1g1QRc_YA:10
X-Proofpoint-GUID: Xz4-jwfE9hcrB2yHfqNI00mzpGRubzBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

(Patches still needing review: 2-3, 7, 9)

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
  hw/i386/pc_piix.c: remove include for loader.h
  hw/i386/pc_piix.c: inline pc_xen_hvm_init_pci() into pc_xen_hvm_init()
  hw/i386/pc_piix.c: duplicate pc_init1() into pc_isa_init()
  hw/i386/pc_piix.c: remove pcmc->pci_enabled dependent initialisation
    from pc_init_isa()
  hw/i386/pc_piix.c: remove SMI and piix4_pm initialisation from
    pc_init_isa()
  hw/i386/pc_piix.c: remove SGX initialisation from pc_init_isa()
  hw/i386/pc_piix.c: remove nvdimm initialisation from pc_init_isa()
  hw/i386/pc_piix.c: simplify RAM size logic in pc_init_isa()
  hw/i386/pc_piix.c: hardcode hole64_size to 0 in pc_init_isa()
  hw/i386/pc_piix.c: remove pc_system_flash_cleanup_unused() from
    pc_init_isa()
  hw/i386/pc_piix.c: always initialise ISA IDE drives in pc_init_isa()
  hw/i386/pc_piix.c: assume pcmc->pci_enabled is always false in
    pc_init_isa()
  hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in pc_init_isa()
  hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in
    pc_init1()
  hw/i386: move isapc machine to separate isapc.c file
  hw/i386/pc_piix.c: remove unused headers after isapc machine split
  hw/i386/pc_piix.c: replace rom_memory with pci_memory
  hw/i386/isapc.c: replace rom_memory with system_memory

 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 169 ++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 250 ++++++++++++++------------------------------
 4 files changed, 250 insertions(+), 173 deletions(-)
 create mode 100644 hw/i386/isapc.c

-- 
2.43.0


