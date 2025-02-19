Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18EAC021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOx-0003Sh-GE; Wed, 19 Feb 2025 09:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOu-0003PS-VG; Wed, 19 Feb 2025 09:50:12 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOs-0007V3-2G; Wed, 19 Feb 2025 09:50:12 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9LnWr011251;
 Wed, 19 Feb 2025 06:50:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CbYCxq57zE19zKX5mUO4iVNHgd4VV/+dCMgQHeUY/
 Js=; b=vJpQ5MxpHNRXB5yRinqVGlSGdtEN6urn7dYMklgF4x/ub/OThW87osTZ/
 CSbds7aAaT3RpcXSQ+Ihrrxpym0gv8/0pWYr5RU3p+PSSeo2YNEAzO6uz+eksX2O
 7QQPxP+Zn418UTPYg+ovBGLLyaSBlGjO0bwLqTO3yvTyn/nFxfnKg0I4/El4qNiB
 0/nydOc9x8KBl/oSofGQhVFXaCe2wmTreG15vM0deax8NQBGwHaTpUXe88ULt2/6
 v7s6eYfVn7cgu5hyK2MtmUXlRiDEUPWxWdw/7XDq63wI9HSOaMM3Lb1r2q4S9vVa
 SOzSmfjA/ZKKM2NdB4btl09R2VZnQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4bdhxxr-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrmeCOoEU0qiDdomy9mluVjMDjlIbFcBMjLeQBNlimRVifGazUIzI6tatzfyC4e+C1rc2us7iBVca5/EZnH+NGUUqxl+m0buNGw3ayo8K6dGkHhX9g+k4/HWOSYxDWfUFmucwQgFfCtVk7axOdnnnE3qCelynQqXLDY6A8Nr3Fzhd4bAGCWXYGBXhlCJ95fVeJz0qElAG1OAiSsCd9oX1wRaCwhrONPQG3FPtV5ARH2EpBNu6wWRI3xcmZKNlItlGPCn6MoymM80KcHHeFnywv07Yfvfk7gzGj3TIlGHKYA+ic8g4exvkshKW2bpn29KhBTSxYD1XChyjNS7oA3Ihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbYCxq57zE19zKX5mUO4iVNHgd4VV/+dCMgQHeUY/Js=;
 b=EDee0+WGUDOoutrjxQ/0lDniQPzwEnKmGl3Nfz8Ptb71ZLBH+W65HDtXXEhev2djkhb9MfHv4JwWTgLzF6M1quY+yuV3mxIXd4crjXF09i7pSXaAjwsRC9zYd8w6NEbyFK8NlkwxM71rdTruSZWSz8NaiwXbki3/zGzqw9X2EvRqqrXGdAl/PhihpOohy899H0bKz5UuSbCj7hQJjXvdMQ2q5g2p7W6uef5j1G8NPpzbDHr3pNUE6vxoORnJ5RfZKaGFvwrioM3cDAYPTJparzIZuDnKd9h/iCx3K7+f6SXwEXkCOa72fYzvignTFUxJqaXM6MprrP/y4Ke6Zn4Bfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbYCxq57zE19zKX5mUO4iVNHgd4VV/+dCMgQHeUY/Js=;
 b=cFDMuwhFeKzMVW5pRdF3EiPwrfW4OUJoLZmoH/UW7Bi6XO6K2t9CLKPxP76GGzAphvKnHz/CrHJEJJoEnzIKqtniezmv+QsRZ8ftNoX9f4yj5qCz99hzMTjSlh/eU9U1KE8GvfuGwjFZ6fd20raPzd/a/n6hoE4dD7qeo0qkOWXcFIHC+BahvXssZxcyaaObjkv4llgSbGKOd5yAKbZEJh3UPcYSpL5SdQy3tI39bkP/PfBfGH1le7N1TyktqfWjTlKaureesTQFCLmLID3cAy6uRYsJM35RmcG3wF8b/htCFW9ZFj4F4OasvXldWIl1obAC+SHszEM9M0sMQBK9EQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:49:54 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:54 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 13/28] vfio-user: connect vfio proxy to remote server
Date: Wed, 19 Feb 2025 15:48:43 +0100
Message-Id: <20250219144858.266455-14-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV8PR02MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: 85357136-f640-4288-7f6e-08dd50f4ac06
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlVIVnJJUVZpVk9DRmo4eDNDT01FUnp1Z2ZkMFp3VmlXaHlkM0pBL2d5MWtR?=
 =?utf-8?B?Y0wyUGZlRVIvcTJ6WGZpMCtWNStMV3hLczdBYVlPY016T2RaZjk1c1NsQ25R?=
 =?utf-8?B?Z0dsbTZpYTlwQllIaGRJRmVWMTc2dDhzY3B5bkVuV2lqRHpBemdOTm5WL2Rq?=
 =?utf-8?B?R1RVd2YzV21icUEvMkJpWEJVYzZ5UXdKeU1TMHRPNGxtWVRZN3prNGVUbGY4?=
 =?utf-8?B?M0VrU0YrRHRoRWFXRFRObE1iekEyL0pmQkZ6WXNKVUhmeWwxN1ovajllSjMy?=
 =?utf-8?B?L2RzZytSeTMyTjVjMnBGa0xtcFBsRC9ycHczRlIxdWhtay9mVEs4R2JMbjlY?=
 =?utf-8?B?dDRyNS81TUhtb2hZZmNOMVcxQWs0T3FUYVRVUStTTWdhcjRPMm52a0w4YkhB?=
 =?utf-8?B?UHhSNFphSGVkQjN1a29MTUZJSE1yMUdGSDR3a2RZdUMzZDArbThlc0NuSVlm?=
 =?utf-8?B?bjB0eUczSXVrRlF6MXZJYjRlcEpZYnFSODVZb2lNc2tnaDFreHZhWVYyZW1H?=
 =?utf-8?B?V1FDMnYyZFl6dElZdSt6aGhib1c5aDhuNnJWbDk1OTZJS2VnazNqZmNxQXpI?=
 =?utf-8?B?b2NwTUd0SXhaSTVhaW8zcmVhenRLbXdQaTlmek9QK2tMT2NNK0JtOFI0VFZ3?=
 =?utf-8?B?aWk2ZEo5SDBDSU9OV2hsSVpseVpWVkZ4ako2RzZvMlEyc3lsRk1jTkdBWVFy?=
 =?utf-8?B?NlB1SG5CSkNtWFB1Nmhxc0RIY3dvc0dkbThYdjJvZVY3UlluZmtXYTdzdjUw?=
 =?utf-8?B?UU9GbnAwWjBJMS9uSnVCYmhHL2ZPTG9FWXY2K1paTlk0dkwxWmZOM0I5cmVt?=
 =?utf-8?B?d1ROWUVBZUtHZ09vK2h2dEluNzY3TTluRmFjWkw0bWZ0ai9lTVpBRWJBZ3VP?=
 =?utf-8?B?ZzIwUXA5T2pOL3NmZlBleDZBOWRjS1ZBc1BnOExTL0JUdEtJRWZIVUxKWk10?=
 =?utf-8?B?cWdzRDdLOFZCZlR2V01meG1tLy85MGVLOHlVYUxySWhuTkVUMzcyWGNPaTla?=
 =?utf-8?B?NkthQUV5RHI1Rkx5UGhjYzJ6anlOZ0VUMUw5cSsrcHZ2R0RkZHpkTkZmNkJF?=
 =?utf-8?B?NVF2WnE0Y1VlbDh0NW1KWkU3VVI4cVR3U1AxMjZ5dUx2aHA0Y1dlVFRBdTAy?=
 =?utf-8?B?dGZvMlRldDVkL1lEN2xGUU5ZbDVRbWVWajhkTjIwcCsxMFVwbTdqQzBSTThj?=
 =?utf-8?B?WFFRT2dWV2pDVDBBaXRwbjQ5MmVmWGhhMjg2Vmk5YU42REpObm9IUDdReHYx?=
 =?utf-8?B?QlhrMEZVWTJqL1h6cHZPU0J3VUpUSEgrL28rU21CbzA4WFI1MXBGMFF3aENQ?=
 =?utf-8?B?VFlSby9INVRoeFNjM1F2ME5TeVNqV3FTeHlDNEEwUDNUR1lWWVVDL2x2cjkr?=
 =?utf-8?B?MytuSXRDVzV2eTlkNXhNdEQwY0VRYlZjaEE2L3hUbXRhL2FPdXNiZS85UWdM?=
 =?utf-8?B?VjRnVUN2Q29NTzZMS3dJanlZWDkyamlORWVoYVV0N2phakpJN1l5OEFWY2p5?=
 =?utf-8?B?SzBTQksySERIWWdYVFdyU0RDZ1hGZ2M2Mm1FWURSbFhyMDh0Q29VR2pGK2k0?=
 =?utf-8?B?c0FNSnJmSXMxcGh5RGx3WXdpLzlYa1Q4N2lMa01iQ0xJZTBDZG53c29nSzRx?=
 =?utf-8?B?K0d5cWQyV3lmY1NONThuWWdJeDg2dEdFMWoydUlHOCtzOXpuYUs0WEdxR2Uz?=
 =?utf-8?B?eDlYODB5Z2JubDk3K1RRekpQdUpudUcrbTBjMkN2dVNQVFFCWUx4bDAreVF2?=
 =?utf-8?B?M0RVTlZGM0pMMFVsY05NeTNlK0h1NHZlKzJodEoweXNFcFR0VGlqYzdFb1VB?=
 =?utf-8?B?cEZPbU9wUHdCNkNpMEtzVzRrZXR0NlhVOCtwQ2NmVGtqczNYdjNRWlZQYVVP?=
 =?utf-8?Q?X8qw5IEaN+zgu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RERrTlBkRWZQbkhpNVo4ZmJJS1d4bTd3SFdhbFYvald0MEZ0dVhTQStoa3Vz?=
 =?utf-8?B?MWhIMTNVTkFsSkxsa2UvS3lZMHEyVVQ1eG41N1U4TkdEa1MzTTBxYlV2VFVD?=
 =?utf-8?B?UXVuWXZCVFBSczVGUmFEV2hGQXdFcTZHWndReUVjNkdWd2NNbmdRaTYxeXdm?=
 =?utf-8?B?QWVOWDdCZFg1bldTcysvd2dpYUJhR0hEYW9NY0c2RFNiMXBtR2ErdC9MY0NM?=
 =?utf-8?B?QUN6aGRwUHlIUDVaelFMbDZiWXBQR0tsRGVPMUVZK1Z0RmlaNTdmTG1NelZL?=
 =?utf-8?B?UTk5VGEwc3FYWmZlY1k4MVRFbjI5TlRuWnYzdHdIWm9YaEdSRDBKd3JObnha?=
 =?utf-8?B?Y1NTRzdDVm5uRkxGUWVhMGRSd0t6bWJmcWFZRnoyd29FeU5KMnhCYjJLMDAz?=
 =?utf-8?B?czJIdW9tRlVpUzhHVy9GejJlM0dqanZvTFZlOW1CZWJtTkowenoyR0FWRzJw?=
 =?utf-8?B?YmhSRFN2cGUzSlY0dm1PVDRPRmNoZWEvOXBEZ2EwUHhJblJVMmRHdjE1TkRT?=
 =?utf-8?B?amR5Ylp6cTUzS3RVY1I0VnVwWHRWbXRPV3FOK3g5UlM5MEpjbXVzOVIzcDFP?=
 =?utf-8?B?ODVaaGlTTXBNZU5wajN4dTlkQ1NneUxXYmc3VFFGR3l0M3BMbXV5ZzZ1Vkxq?=
 =?utf-8?B?NG9hMk1FeGtXR2dVNkJpUkNSeEUvblU1ckNkUW1RRVorREpvd3JWUm5yZGVs?=
 =?utf-8?B?MlYxdk9wNjVjVHNROTUxVEFEZlVOQnVPWVdSMzdpSUZpMkRpb1d1dVBaR2tT?=
 =?utf-8?B?RGUzTi9SaUpOQTZCb1JpNmJBZ2xybUpXSWlsNVFrNGs3Vnh0SGtaQ3BHc0dF?=
 =?utf-8?B?aTNXMWsyRXc5blVkekdGYlNCN2N2TzYyRVJoUzFnd2p3QWQ3MVZjdlFTZjhp?=
 =?utf-8?B?QnQ1d0hBN25iSzRhN0VBSCtwdTlFekJIZVhxOVhZUGl4QlFRZTJqUUl6ZkVj?=
 =?utf-8?B?UFpPazdRVW5pNnl2TER4bXMvVTBsMUhXdmZiQUU2M0FNY1pCb1ZaMElxTEVr?=
 =?utf-8?B?YXgrT3hoeHFhdkRrSUxvbFlZSHBxY2ZLekFlcTJwVkE3MDlZRWlLRkQ3ZlAy?=
 =?utf-8?B?YkR1TnB0SThOaUk0dkp1T3MwZDZjeDVJZFREWi84WVFDelFIOUd3QmRVeXlJ?=
 =?utf-8?B?dUVKN0Q1TkJ6Yi8wMTVjTTRzTk9KNVRDVnZZenBtRVZMTkwydTBER1ZLNng5?=
 =?utf-8?B?N1p5cmVYWW5PeGliWUREdDdwM3FZMlU4WjM3bnFaL2hWWjVLOFdEeU5MWnVY?=
 =?utf-8?B?V2NMRVJUQkpoaktTOCtMK1NoNWltaHZrSUpweEsvY3RoUVIzWGZSNVNTbnBt?=
 =?utf-8?B?NXduSWhWYTVNMkJhVmk3Z1lzR2NlVkQ5UnVVOU5SL2dUTG1NYWZmdUlyWlF3?=
 =?utf-8?B?L3k4b2ZYa3NKSkZKd091RUZYbHUvTnFDYVlvcW5MWi93d3A0MGtYSitkL3lQ?=
 =?utf-8?B?eGlZeVJCRDRjSmIrRlVvZ3pMSWwvQ3QvZDU3TlRlOHNHRk1TMXUzczI5Q0Ra?=
 =?utf-8?B?OXYycmluTWM2VmJORmhFY3A2RElMYkpmMzMreDZXNzNqWUhWN1piRVo0Sy84?=
 =?utf-8?B?QjFNd2JjTnpSaDE0dFR5S2RubWZaYXk3RUZENXRQZkxmS2llMnQ0a0dqSkZW?=
 =?utf-8?B?NTZOSHd0WkhpZGg0S28wVXY4Wm1HcGVrUjlMS0l2Z3dlRC9UUTRKRDNpdEpD?=
 =?utf-8?B?TVBIeTNyeUJHcFg1cFkxYVk4bHhGZmRMb3R5c3BhNXY5Zm4rblFMV1daNDh0?=
 =?utf-8?B?ZjhXZGtTbUFxTFpDeHhtTDNGdW8zS1lacjJ5UUk2Q09Idlo4aXZ3SEo4S1Jl?=
 =?utf-8?B?TWFxUHNmdUR3RmdjSXdTa05qbzNkTlUvMzN0MVk3V1ZXY2xKdGZZZjMvb05D?=
 =?utf-8?B?Q0cxUzRVVnhYNXV4WnlKcmxiQnZDTDBWaDVucEZ6QzZBZURKa2txY2lCMDMx?=
 =?utf-8?B?YUVkaDZVYTZsN2ZBU3dkRWJkei85WTVza2Q0REcwVkExTWtPYmRUREFSQWdo?=
 =?utf-8?B?UGYweUZNZ2hXVkJOZVZNaU1mVzRLSUliWUtUeU9sbjJvVGpKcmtXSDZ0R3Ns?=
 =?utf-8?B?VEN1ZWVVMTI0TVdjdmhLQjRmOXp1SzdzQ1MrL1c0cjFYWVZiVS96ME13WFpo?=
 =?utf-8?Q?DumT+TjC3aPBbZ2oSYjSfMSaU?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85357136-f640-4288-7f6e-08dd50f4ac06
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:54.6659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7HVAsugf9UkMmXKgC2JYcIkBKAyy5384pVMWqtI8nvH1u7pbz5WhM0TLQnQlLczfwQqgnshr7rNX6hPXPmHTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-ORIG-GUID: Eyxtzb7HSPh2SmtgFrvH8s-oR1ALwBCL
X-Proofpoint-GUID: Eyxtzb7HSPh2SmtgFrvH8s-oR1ALwBCL
X-Authority-Analysis: v=2.4 cv=Fo7//3rq c=1 sm=1 tr=0 ts=67b5ef9e cx=c_pps
 a=di3315gfm3qlniCp1Rh91A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=vhHEnE-nI2wpHcbFAcgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Introduce the vfio-user "proxy": this is the client code responsible for
sending and receiving vfio-user messages across the control socket.

The new files hw/vfio-user/common.[ch] contain some basic plumbing for
managing the proxy; initialize the proxy during realization of the
VFIOUserPCIDevice instance.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c         | 171 ++++++++++++++++++++++++++++++++++
 hw/vfio-user/common.h         |  78 ++++++++++++++++
 hw/vfio-user/meson.build      |   1 +
 hw/vfio-user/pci.c            |  18 ++++
 include/hw/vfio/vfio-common.h |   2 +
 5 files changed, 270 insertions(+)
 create mode 100644 hw/vfio-user/common.c
 create mode 100644 hw/vfio-user/common.h

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
new file mode 100644
index 0000000000..e829abccec
--- /dev/null
+++ b/hw/vfio-user/common.c
@@ -0,0 +1,171 @@
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vfio.h>
+#include <sys/ioctl.h>
+
+#include "hw/hw.h"
+#include "hw/vfio/vfio-common.h"
+#include "io/channel.h"
+#include "io/channel-socket.h"
+#include "io/channel-util.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/lockable.h"
+#include "qemu/sockets.h"
+#include "system/iothread.h"
+
+#include "common.h"
+
+static IOThread *vfio_user_iothread;
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy);
+
+
+/*
+ * Functions called by main, CPU, or iothread threads
+ */
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy)
+{
+    qio_channel_shutdown(proxy->ioc, QIO_CHANNEL_SHUTDOWN_READ, NULL);
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx, NULL,
+                                   proxy->ctx, NULL, NULL);
+}
+
+/*
+ * Functions only called by iothread
+ */
+
+static void vfio_user_cb(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    proxy->state = VFIO_PROXY_CLOSED;
+    qemu_cond_signal(&proxy->close_cv);
+}
+
+
+/*
+ * Functions called by main or CPU threads
+ */
+
+static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
+    QLIST_HEAD_INITIALIZER(vfio_user_sockets);
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
+{
+    VFIOUserProxy *proxy;
+    QIOChannelSocket *sioc;
+    QIOChannel *ioc;
+    char *sockname;
+
+    if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
+        error_setg(errp, "vfio_user_connect - bad address family");
+        return NULL;
+    }
+    sockname = addr->u.q_unix.path;
+
+    sioc = qio_channel_socket_new();
+    ioc = QIO_CHANNEL(sioc);
+    if (qio_channel_socket_connect_sync(sioc, addr, errp)) {
+        object_unref(OBJECT(ioc));
+        return NULL;
+    }
+    qio_channel_set_blocking(ioc, false, NULL);
+
+    proxy = g_malloc0(sizeof(VFIOUserProxy));
+    proxy->sockname = g_strdup_printf("unix:%s", sockname);
+    proxy->ioc = ioc;
+    proxy->flags = VFIO_PROXY_CLIENT;
+    proxy->state = VFIO_PROXY_CONNECTED;
+
+    qemu_mutex_init(&proxy->lock);
+    qemu_cond_init(&proxy->close_cv);
+
+    if (vfio_user_iothread == NULL) {
+        vfio_user_iothread = iothread_create("VFIO user", errp);
+    }
+
+    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+
+    QTAILQ_INIT(&proxy->outgoing);
+    QTAILQ_INIT(&proxy->incoming);
+    QTAILQ_INIT(&proxy->free);
+    QTAILQ_INIT(&proxy->pending);
+    QLIST_INSERT_HEAD(&vfio_user_sockets, proxy, next);
+
+    return proxy;
+}
+
+void vfio_user_disconnect(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *r1, *r2;
+
+    qemu_mutex_lock(&proxy->lock);
+
+    /* our side is quitting */
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        vfio_user_shutdown(proxy);
+        if (!QTAILQ_EMPTY(&proxy->pending)) {
+            error_printf("vfio_user_disconnect: outstanding requests\n");
+        }
+    }
+    object_unref(OBJECT(proxy->ioc));
+    proxy->ioc = NULL;
+
+    proxy->state = VFIO_PROXY_CLOSING;
+    QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->outgoing, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->incoming, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->incoming, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->pending, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->pending, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->free, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->free, r1, next);
+        g_free(r1);
+    }
+
+    /*
+     * Make sure the iothread isn't blocking anywhere
+     * with a ref to this proxy by waiting for a BH
+     * handler to run after the proxy fd handlers were
+     * deleted above.
+     */
+    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
+    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+
+    /* we now hold the only ref to proxy */
+    qemu_mutex_unlock(&proxy->lock);
+    qemu_cond_destroy(&proxy->close_cv);
+    qemu_mutex_destroy(&proxy->lock);
+
+    QLIST_REMOVE(proxy, next);
+    if (QLIST_EMPTY(&vfio_user_sockets)) {
+        iothread_destroy(vfio_user_iothread);
+        vfio_user_iothread = NULL;
+    }
+
+    g_free(proxy->sockname);
+    g_free(proxy);
+}
diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
new file mode 100644
index 0000000000..3529f03df9
--- /dev/null
+++ b/hw/vfio-user/common.h
@@ -0,0 +1,78 @@
+#ifndef VFIO_USER_COMMON_H
+#define VFIO_USER_COMMON_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+typedef struct {
+    int send_fds;
+    int recv_fds;
+    int *fds;
+} VFIOUserFDs;
+
+enum msg_type {
+    VFIO_MSG_NONE,
+    VFIO_MSG_ASYNC,
+    VFIO_MSG_WAIT,
+    VFIO_MSG_NOWAIT,
+    VFIO_MSG_REQ,
+};
+
+typedef struct VFIOUserMsg {
+    QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserFDs *fds;
+    uint32_t rsize;
+    uint32_t id;
+    QemuCond cv;
+    bool complete;
+    enum msg_type type;
+} VFIOUserMsg;
+
+
+enum proxy_state {
+    VFIO_PROXY_CONNECTED = 1,
+    VFIO_PROXY_ERROR = 2,
+    VFIO_PROXY_CLOSING = 3,
+    VFIO_PROXY_CLOSED = 4,
+};
+
+typedef QTAILQ_HEAD(VFIOUserMsgQ, VFIOUserMsg) VFIOUserMsgQ;
+
+typedef struct VFIOUserProxy {
+    QLIST_ENTRY(VFIOUserProxy) next;
+    char *sockname;
+    struct QIOChannel *ioc;
+    void (*request)(void *opaque, VFIOUserMsg *msg);
+    void *req_arg;
+    int flags;
+    QemuCond close_cv;
+    AioContext *ctx;
+    QEMUBH *req_bh;
+
+    /*
+     * above only changed when BQL is held
+     * below are protected by per-proxy lock
+     */
+    QemuMutex lock;
+    VFIOUserMsgQ free;
+    VFIOUserMsgQ pending;
+    VFIOUserMsgQ incoming;
+    VFIOUserMsgQ outgoing;
+    VFIOUserMsg *last_nowait;
+    enum proxy_state state;
+} VFIOUserProxy;
+
+/* VFIOProxy flags */
+#define VFIO_PROXY_CLIENT        0x1
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
+void vfio_user_disconnect(VFIOUserProxy *proxy);
+
+#endif /* VFIO_USER_COMMON_H */
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
index f1fee70c85..b89985c641 100644
--- a/hw/vfio-user/meson.build
+++ b/hw/vfio-user/meson.build
@@ -1,5 +1,6 @@
 vfio_user_ss = ss.source_set()
 vfio_user_ss.add(files(
+  'common.c',
   'container.c',
   'pci.c',
 ))
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 6c85c60179..bfd9051524 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -19,6 +19,8 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/common.h"
+#include "hw/vfio-user/container.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
 #include "qemu/error-report.h"
@@ -59,6 +61,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     AddressSpace *as;
+    SocketAddress addr;
+    VFIOUserProxy *proxy;
 
     /*
      * TODO: make option parser understand SocketAddress
@@ -71,6 +75,15 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
 
+    memset(&addr, 0, sizeof(addr));
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = udev->sock_name;
+    proxy = vfio_user_connect_dev(&addr, errp);
+    if (!proxy) {
+        return;
+    }
+    vbasedev->proxy = proxy;
+
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
     vbasedev->ops = &vfio_user_pci_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_PCI;
@@ -119,8 +132,13 @@ static void vfio_user_instance_init(Object *obj)
 static void vfio_user_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_pci_put_device(vdev);
+
+    if (vbasedev->proxy != NULL) {
+        vfio_user_disconnect(vbasedev->proxy);
+    }
 }
 
 static const Property vfio_user_pci_dev_properties[] = {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ee8e7f7c0d..699e8a9376 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -79,6 +79,7 @@ typedef struct VFIOMigration {
 } VFIOMigration;
 
 struct VFIOGroup;
+typedef struct VFIOUserProxy VFIOUserProxy;
 
 /* MMU container sub-class for legacy vfio implementation. */
 typedef struct VFIOContainer {
@@ -155,6 +156,7 @@ typedef struct VFIODevice {
     IOMMUFDBackend *iommufd;
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
+    VFIOUserProxy *proxy;
     struct vfio_region_info **regions;
 } VFIODevice;
 
-- 
2.34.1


