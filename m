Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C27C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgaN-0004zO-9S; Wed, 07 May 2025 11:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaK-0004wA-Q7; Wed, 07 May 2025 11:21:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaH-0005vp-B9; Wed, 07 May 2025 11:21:24 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5478Rjo2015395;
 Wed, 7 May 2025 08:21:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=44EcA4x/cJM/78Hfi29dKZcvOUxsf4crzbFzVW9BG
 ek=; b=lc61sgrAQCj3RkLP2SWdptiV8+5rzf2lTYsKp9N84j9uYK2bTLwj89JFY
 V2rJrmpTPpXRa8KfhsmIFGg+dJCtSSauErCq7S8e039KkS5+c3lyj8jt+JurDvhR
 JkTcel6f20qXtQlMhe6z/HkkR0v1j2+68gcQxu175Ik4UYCb86WX46pCTwnWrVyW
 egGbwYfAlbQbzpCwFWxDDayaikHV2j6Vw5MRYNV2BYT55X7xa2YVw2ZidJIDbyS+
 pEh7rwAqteFwB+V1RqDPxrQ6y5NKgjT2KMSS0VSs8DwGOJO/fnCeZyD6fXHAWZZt
 qrqvkKCWCjPNRawClfqPqsf42nZNw==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dh8j1c9r-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8qJzq852+48SxcYNMm7JU440B3x3NAWSfXYLhrn0NdVF08L6/ejC1hIf/hsIuVg1KidxPPqjKDg6oFayOlHs/cUIWYcfVgTL12WmPn1di6bwr5REI0ECJniVaVISeAe7RY7Pjl45S6k4B3CjCk1HD4fcmjzVg7m2xdfO3JKpszRAQ/v1cbM2ugc7xOkxfwQDd0q63MIaCMX5+4T7gma1A3/I92GAERqqtIUa7MQCj7w1zqwAXZbZ6uory0JvWcn9UhJ5ENKySVBGL/Gb9OT9ezBR6mkGxdjAQ9kTeA60z2tXYjBV3OcVpCtCdON4UgXT47dZSmktgKiv3O1APKSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44EcA4x/cJM/78Hfi29dKZcvOUxsf4crzbFzVW9BGek=;
 b=CxGvX3q8cmTbFTJZlgMR0tFWnUjJ+GYGXyCX7gdIy+M/kANPeEOQwf1bF5fjyxT0ErFbETTQ5pzLh8btKD3qg7zBnA8YBL2EhX5p9ny/+vNd5cfezPpOn71gs3IfcekM17RUHdoj7nsSP3mi6tlZSj69E9GPuUkpMttyEkM24jcUZe4EvygvQbE2kaFOU8YWOhYq33bmF4KkITh29gRjlcqI58jF4PLoXlJQqQVKeRS8MpEZjnsycDfaocUgdEZEkDCXLVWW2rr1pQjyDkthQZz/Zy37NFFboEDuUiAUCFrfbxohH+QeIBZls+oDurDQ5q8StxDvPEfL5gmD0Gk+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44EcA4x/cJM/78Hfi29dKZcvOUxsf4crzbFzVW9BGek=;
 b=Wx3D9kpJioV3k5cj4Py+rR/50CuzYFmnj+/t3nU+bkk2eczjWv3jwwV4mArNyzAC5DHEY7EgPyomiWmqbhgm8QeIjSaKRMoDvUWAvkA8RQ6rkx5Y0UTjsCPaXnBlTXvPA/+gy2UmKL6SToNZzxiEVkayCCtCTuxMxx0XXWPKeTbHxDoppCL9N6Gn6D3RDYP5mjz8GRKI/Z80kFrAQ06LsEQW9QNbkapmIDNpjFz4SKIPs/DTNMDipM+0PzOsnFloEx7Mr593mqHkLvn/0bYKY7sAltzD6SPOd7zNiK7XUKXo3pLk6aa43KvTyZmvHnxQg58qvyhVm34RFhSjgQSbow==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8220.namprd02.prod.outlook.com (2603:10b6:208:342::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:21:08 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:21:08 +0000
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
Subject: [PATCH v3 14/15] vfio/container: pass listener_begin/commit callbacks
Date: Wed,  7 May 2025 16:20:19 +0100
Message-ID: <20250507152020.1254632-15-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 29e0e207-23d0-48bd-a043-08dd8d7acaa5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUgyZktmcnlSdnZaTGE3c1E0VFVKeDlxQlpvYU9uWDhlbnlpWjA4K1JKQ0Zz?=
 =?utf-8?B?YWw0RVlVNDUra21EQSt6M05KZ3k2enFidERQTFEvbG9wVG9lQVdBSlRpS3dm?=
 =?utf-8?B?NVJqRmJnNWk5OXBZQ0xjTUJER2VIMWNCc041akl0T0luM0JQL3cvcmhpVkQ1?=
 =?utf-8?B?RGpPeTJaeWhmRThBTzl3dWkveXcxRm1waDJMOUhQQmx3WGNkSW04RjJ1OTZH?=
 =?utf-8?B?KzVJUVlaM1dTMmY5M3IwbFZrcEhjQ28ySWJYdXZseXdJWC9qWXdCZzUwWmRQ?=
 =?utf-8?B?ajVRL1VtY1VoYnJXZEhleUVMVkpNQ1pQczJiejUzUEQ4MkNrYjdrMWkyZTNK?=
 =?utf-8?B?a0ZEd3BOcTA0dDNjR0xLWnl0RU9jS2pGZHJEcysyTWNVSFJQWkZleTJGbVdr?=
 =?utf-8?B?R0N0VkQxTXJFckowNVk4emV5cXM0S1RyL0ZiNU12aUJpQWFZdFRMZ1F2dE5k?=
 =?utf-8?B?Q1BwNzJNdW1BUUJEYlFKbWxEdFFldDd4RkxGT1BsSFh3SE5pd1NUZHdoNnVp?=
 =?utf-8?B?andCSXZSSUFhcjJRa2lRNy9LSlZxK2pMK2tsV1ZYcHlqTHZEdXBSRTFud1B0?=
 =?utf-8?B?V0RPWjB6cHA2TXdTU2dtdllOTFFndjNoL1ZtV1psQVYvTnNWR1ZBWE5OT3lV?=
 =?utf-8?B?a0dMVnZaSExxT1pCVDBva3RGcEJnbXRnMDdBeVFoS0RjYjJqUVlTUTIwWUhq?=
 =?utf-8?B?UHczZmM0a0pBekpzcVZ0Vmd4UGx3OHZ2NzV5SFYyRzE2R1F6MFpUK3lNWWJr?=
 =?utf-8?B?R20wZ0xneFp3bWJUaVMrTnhibXpZRTNkUkpJd0tCTnZUSm80a1NJajFnQW5W?=
 =?utf-8?B?YUxFeEEwZHptOW41Vm1kckpYL0tSd0NJaVJnbk9sVGFBMm1RaXh1QkNSR1cw?=
 =?utf-8?B?aE01ZUdaUWNQL0xQSlllTldUUVdHOWhlNjdhNGdhMmNsdm9rZTJNQmdQeUxM?=
 =?utf-8?B?WE56NjJzYldiaUthYy9SOFlOcmkxYjhtNWFoVTB5bnJWZ3I2UDBUVnRDMlZ6?=
 =?utf-8?B?NmZNY1Z6d0lXTjZrbkltZW9qZzVsQVRPUUM4b2V1ckx3RytIK284dzM3Znhq?=
 =?utf-8?B?V1VxSThTRkRETlg3bkNNT0JEU0hxVzJLVkVwRWFpbWtlZFlZQmt2RXMxdUdS?=
 =?utf-8?B?VmFTbE9jNlRlZUtqcDM1NzlIeUhCbFVTc3hrSDNsdzZHSloyNlV0aS9DTVZO?=
 =?utf-8?B?SkZmRzFPZmxHc2c3T2VPTUkxZWpKOEJ2Y01kTFNKL1JsR1VORnVERm9mVWlM?=
 =?utf-8?B?MEx4VGc1bWQ5UGJiRVlwWkhZcFpvVUozaVVoMXJNRUl0dEZRSUlUZzY4TnFl?=
 =?utf-8?B?NW9aZVRaRlloYkZTTEtRejlpN0NUVHV3YjJ4dFA4SGFHL1dPNjdQdjI1cEFZ?=
 =?utf-8?B?dUw4c0NlUHc5QVY1cjV4bUJRVk5PcFhJVWRjU0J2SER2NDZNTW1zUDRWOC9L?=
 =?utf-8?B?MnRORXkrN2pYR21EMTFmeE13aGlRUi9xdStQMGI0dTFRVHZiR2VrR0Q0eFIw?=
 =?utf-8?B?RTc2b3pEK255czFjbDRRMllwUk5yN0FuTThnd2JkL3pkbFdlSEcrdFNQTkQ5?=
 =?utf-8?B?b09XaGNnUHpxUk1nSzJXbmFzWTJ1R3JudzFQRHk0VHUxRUFQUm9zajNSS01m?=
 =?utf-8?B?cGs4Z1ZsNjRTMTFYZEZOeDVNdDZSV09Kays4QlcrK3pOdWlKYXJRRzRmS01X?=
 =?utf-8?B?QkY2NlUxZUZ4UU8rakg2dW9jUElCeU9JNVlpaWZIbllsUVYvRERFVEx3YWd0?=
 =?utf-8?B?TElDWVpOeFVNRkFzdzdqajBzY2w4TXVURjB5NVZGdUZlYnZUai9QekVicWNY?=
 =?utf-8?B?a0Rrdy9hTE56c0FuN3k3Qnc2MjZucDFiWDlHbGhaNTc0bzUwSGJRNE1Fd3Na?=
 =?utf-8?B?L2hPWHE1MlU2TTlEdEJCdDRKM2NyOTF0YXQrNGtndmJnenFCYUdtUFN1alMy?=
 =?utf-8?Q?RU77rmqqiYY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXlCSEhIZGtnNFIvdnpvdjF2OWlZemRNK2RpUUdJbVhLUm1KM3JaY1c4alRz?=
 =?utf-8?B?dWM3VjhISTQxMnhucmdCSHNoUjlrZ2hkN3JnS3RQcU45RUVNRzBSa2ViSFA2?=
 =?utf-8?B?NU1YY2xVcVRpTVBLUlRDdERaSFlNS0YvV2dDejRSWDVFMkxyVDJvVmFMeFc5?=
 =?utf-8?B?RmFPNFYwSS9xK2c1ekFEQmI5ZVVuS3ZxeitGRVZXQk93S1Npc2YrNS9aZE0y?=
 =?utf-8?B?RGJpYkhIWnhpczZxQ1FsMklWdlFsSkNjZTZway9Ia1dMRHNNMTNTSnQ3aW1X?=
 =?utf-8?B?U3kyR0hHU3V0LzA0elV1bUFzREh1TGE3WUFBdm1EcGFWd21mTEVlc2dIZ1Nl?=
 =?utf-8?B?aVJNUXFXQnJTOEJ3eXh4NXNCM09XZkpUZ2dwRkJTaS9lU0F3aW5FMHdhdFFG?=
 =?utf-8?B?dkFqOUxjRWlYQ1A5T2RtTjYzenBsc0NITG1Ta1FzM1hHK1U0Yk5uUEVRRkx5?=
 =?utf-8?B?VW85Vnd2eVp2cU9xcDZMUC84KzNxdGpoQ3ZRMnEvZkRFb0plTlRiOHVhcU5I?=
 =?utf-8?B?di9WNVBHS3o2NWNKRUFwbkFXOWdNQnNpSEVxWHkremM1Q3hQN2NtRW1sUTI2?=
 =?utf-8?B?emQzdkN6MzJ5WGYyMGoyNHJhN3NWUlU0MTRMRjEyOUFXQXlJUjBoeU1mT3g1?=
 =?utf-8?B?Z2RDdWNtcTFITGsrSmNhZm1aYmNtcTRyTzlkczV0djRhYU9lOXk4dUFSSDh1?=
 =?utf-8?B?N1FvOENDMk5xTDFKSmZuRTQyMzlNYmllVEgvYThEbHpwYmZNaEJlV2cxUmVH?=
 =?utf-8?B?WXZRekhWeHFHeWVlMEZHUXM3QzBMNWV1TS9tTmhvZmlqZ1pFWThxUDdoR2JT?=
 =?utf-8?B?V3RGSnlZT3BpNS9ralVWQ3N6ZklBQS84L0hrOEJFRy9SVWRzQzErb1JaVmRC?=
 =?utf-8?B?aUNHNk1GVTNlZElJcFhXM0twYWRkMWgvbUEzS3lxay9mMTQwMzBvaHp4c2Ns?=
 =?utf-8?B?a0FrQWdaVXpsR2JXTnExNzJYL0FHa3lDT2tEM1g5dk13NEJSV05xdi9NalZm?=
 =?utf-8?B?OTVVcTJOYWttOXF0RXBoMUJEOGE2M0x5VzNvZGJYWFhNN3MvMzRVSlB1T1Rx?=
 =?utf-8?B?djAwdkZENmVUUjI4YVFrcko4bnFsV29SUGpyV1Y1aCt0VlhScXRoZ09yQmV2?=
 =?utf-8?B?OEFZeUpMdFh5MjI3Q0xPY3ptTnVMTG5LSGlFMEZrV215ZzgvUDZqVHAwbVlm?=
 =?utf-8?B?ZkJPRVoyQzBycEZ4ZG9MY3JaVFlhZHA2NC9sbWliSVBza0RqeHZ2clFCbC81?=
 =?utf-8?B?U0R2SDR4YXkyQytNdjZTQmJRVmY4RU5ERUpxM3VNbUFQU21lRWYvN2pjQTNn?=
 =?utf-8?B?dndEOVRodjBlWkVlSHMvY21rSmR4OVhDSUI3YWZEbVNVdmkwckYxSjV4Yk5q?=
 =?utf-8?B?eUlLdjBIY1VjQWNwSGloZWR1VmFSUi8vb1JrRmJWSmIrbU1uTHh4OUF1SCtk?=
 =?utf-8?B?WVQyT21HNTVJbnkvSVpjY1dzcDJMYUdxeEVCRkFMMmFJZ3BGQXRPb0o0N2ZM?=
 =?utf-8?B?S2MwL2lteXlpWTk5bXVJZVJRaTJtQjZ6eUJyNmxHcWROc3JZUkhBSHhzWEFT?=
 =?utf-8?B?dzVyamlsdE5XNUxIOHhhYkZnY29jSGRxRTVTblFiM3l6b2Z3aDFVUlR5TG44?=
 =?utf-8?B?dHJUaFNSQ3Q3YmZFcDQ3czhDS1MvQkIwRHh0TU5WU05KNnQyQWFQaXVJMFJC?=
 =?utf-8?B?ZkQ1VHZaYU9lQVhIY2tMNWRHcGd0dXRmMFZqeFRrSnVHa2V1VDlVQnBkNEJ1?=
 =?utf-8?B?ZzB4YjJta3FFbldoQWxuZ2ZVNmNIN2t0NDBhczI3SE9yRjhsb1RJV3ROTlJM?=
 =?utf-8?B?RDVROEZHM3pMRlZ2bWRoUHRCbkttKzhVUmcycVYySUdYbldLWC81RTlUemZP?=
 =?utf-8?B?aWRncVB5TFBXUk9tdDFENXF4QTdyeFROaHppOCt4S2UyVVZPVThBQVZJdE5Z?=
 =?utf-8?B?MENVeEZMSlJmdlRCVGJTRFdhQ0dGdDRXWUN0Z3hDdGFLNWxLYUdJc040QUpv?=
 =?utf-8?B?NDl4WENCY05aN3VXSWxCSGY5YlBVMmxLbWZTVGNTdWxWUjJDRW5OdHRQT1hR?=
 =?utf-8?B?dGlqcFlMdnBQcDA3dHpkOCs5TC95TVBPanVsZzZRSHhnMDJ6dmFpVHNVTGhs?=
 =?utf-8?Q?U5kmQ28bMmCptILkl40StTrKi?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e0e207-23d0-48bd-a043-08dd8d7acaa5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:21:08.3223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aneup38wRHzhUkDx21SbHpTa0JsukaAwD6fFjTnHik2FyPVSc5cyNWk4mh9FrDdpSgr2FB1mdw+yuC/TKRR5Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8220
X-Authority-Analysis: v=2.4 cv=B/y50PtM c=1 sm=1 tr=0 ts=681b7a6d cx=c_pps
 a=iOysuCQqHAn0ffzU2nlaNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=cdKEYpEidkMaME58ALQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: C3C-2jrMpR0AJ8yV3lteFITOlsY5ZY9V
X-Proofpoint-GUID: C3C-2jrMpR0AJ8yV3lteFITOlsY5ZY9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX5+mw99l4DkYP
 0vSH/FKn1kA3H9YHXT4+HejJxX2hJVxpNBk0elCWCXys+byCD/NCFZj55wvaG+RUm2iY/WjcG7I
 4EE43qitSBdAygGM7+oUew3amXbiD6c7tJ4qDZLqe1lNzTs+88EZx1dpHCEn6vIQkJxXa/Bp//c
 Fv6aYuN62IkPZXBp4+0ScJpId2intaV74cvo/21DLVslFA40Z6WcNnk6ihU9PjER64tQb7lX1e4
 ecxRFCLS8fy2EhNzH7uIeP5/A/Pn+woKU/vssSvIXiTOUiFUPm7immDa/At4zLDfHVj5BggPY2e
 FP7ZgC32vB8i5+NDzwafbmdbK6Tz84ErMAS3nCUTXXANG1aHsgeLLIxuy2CH3fcyDTy/3v5rLOW
 c00z3dJnLIpk7GUwOIJQu2Iv5XsiCPiLFMcXXpNxqa5aa/1HY9Z0Mch+S7mP/jtnsKdPmLrw
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

The vfio-user container will later need to hook into these callbacks;
set up vfio to use them, and optionally pass them through to the
container.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-container-base.h |  2 ++
 hw/vfio/listener.c                    | 28 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 59f07d26e8..3d392b0fd8 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -117,6 +117,8 @@ struct VFIOIOMMUClass {
 
     /* basic feature */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 2b93ca55b6..bfacb3d8d9 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -411,6 +411,32 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
     return true;
 }
 
+static void vfio_listener_begin(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_begin)(VFIOContainerBase *bcontainer);
+
+    listener_begin = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_begin) {
+        listener_begin(bcontainer);
+    }
+}
+
+static void vfio_listener_commit(MemoryListener *listener)
+{
+    VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
+                                                 listener);
+    void (*listener_commit)(VFIOContainerBase *bcontainer);
+
+    listener_commit = VFIO_IOMMU_GET_CLASS(bcontainer)->listener_begin;
+
+    if (listener_commit) {
+        listener_commit(bcontainer);
+    }
+}
+
 static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 {
     /*
@@ -1161,6 +1187,8 @@ static void vfio_listener_log_sync(MemoryListener *listener,
 
 static const MemoryListener vfio_memory_listener = {
     .name = "vfio",
+    .begin = vfio_listener_begin,
+    .commit = vfio_listener_commit,
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
     .log_global_start = vfio_listener_log_global_start,
-- 
2.43.0


