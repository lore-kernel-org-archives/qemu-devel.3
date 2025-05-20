Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16988C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWJ-00032q-EQ; Tue, 20 May 2025 11:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWG-0002zC-HE
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWE-0002MC-6Y
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:40 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7Liba032060;
 Tue, 20 May 2025 08:04:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eWP6uHNLUeLO4UNzBVhqKB0I4i+YBFTfg4JH5mpqV
 BM=; b=BhasDBRB0kwrLS+kLta0UU+bWtDUld+px2IJCw0W4toEl2AV+3/PUUC7z
 6saz2joCRpOVkhuWLV+PCrvjZsUA+90nywq55CmcGJcxI1cN5gWLtnoYOD6kRKhY
 Tc7Is3kw0Md8NepTB/3CLdhoeGGZz4YYwUTb4XVFa6XgCil0uPpnSKDT5rnhw4Si
 anDFI2U+jRO3aAcLreANRPgipot/XKbqMpwJocawI3PrMHpvTL7Ojsv44v3tkDmM
 7+yGwu5knonlRk9Rv84EVEccuIGeNRFAaMCdKvgTq+ag93yOB1beaogAD+uSwxmq
 Lc5tXQ2vcLybFs75SazbVJlFcJneA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46prjheabp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTKGxsMCgkHMQJ6PxL8b0jn8ZAI/qVbh9UIE4A4X7tCf9eu3byP9R+IupD0QtImwYWvOsMt0ISK1YBvIugjfNgVOv2GrSa2Q8BtBdWUZBc/acdo3UrM/n5wVBQ8LW8aNk9CFRI+t3zJuFw3ZQjuMSBM2b42Zr6kr6aRBRyfKrWRMtcnqEYjfTc6+ncafLG13sYQG6xZGrh8ySckbmqRwUaMtpUCRBpvosqw6i2+tR6XeiDI2DqdcAp20ETBylCAFWnstu/q3cmlR+Do1aC3ruStT/sozgKUUENM0bb24kilOeC2h9sjjsUstpbA5Njp6NO2y5LPz4DKRecU6pqrQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWP6uHNLUeLO4UNzBVhqKB0I4i+YBFTfg4JH5mpqVBM=;
 b=F8m1FOE95+hQuRu/otqobphjyoVsfAN5AitePTE79d13oY/dSr8+Rj08fGOTfjrmyWgPCkY4MaFMws0NaAMWRwtHTU5W2n/zI8JlQSpic6APpTsgokoV5AXmpp664HshCjhJrX/IpzwWBwFHWGRGUcEweUCHRj0i49PdShk84rJmSfrD4gAqHgSJh7sBsN4+kIFPYitYuKKmtTGiZASjpMAedTg6pW8i8NcdexRE8lybckJnLcWh6uuAz9fBsuOvRE9WHgLJPc2qenqR4hT10bphw3OGeM3M+RgwVlhfQPgxO7kWFUeSum/56lms5WB563PurKmAdzlbEsjzuD95+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWP6uHNLUeLO4UNzBVhqKB0I4i+YBFTfg4JH5mpqVBM=;
 b=PrN9N9o0HUO1D0F1YFk80alF8q4zslyeaK6fa81aurLInuxmVlhK3/n6wtXaQQvyvp830TP0AvEQr3GeRmzLSh4XD5YtrUl7my7LA5NIKIe3pY+N/G1po5Rc1LnhCTwTGghmtmcXaEZPtT4Qaha2FUZqngbEZYtsZz4h4RI4BjxIoDIUoN8kBaAnrzaMVhmrGlUAExKXdqE3CYAxmUpx6OHqsurnipi+qTupw8B0ENX3tawnNUC3wHbWsneceOZf2SwT3FxR/Bymf3K1A/M7Gp1k7FQcI34ykPKSvcdTkvWbsBjN3nPQCuMeyEvkP0N7DczG6z6EP2I8SYEqsvA5ew==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:04:34 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:32 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 03/29] vfio: move config space read into
 vfio_pci_config_setup()
Date: Tue, 20 May 2025 16:03:52 +0100
Message-ID: <20250520150419.2172078-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f1bb70-68f3-4aed-e5b9-08dd97afa0a5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elBwNERENlJscHYrdFcvNjBmdlVDNW5WeHhRUHhXQjBDRUUxMTg4N2RCRnpG?=
 =?utf-8?B?SnNRUFRrd1k2QitZc1haNlViWmhsempPbDBTTHRFbVhtb3VnYnJDbUJ6YjBE?=
 =?utf-8?B?enIrdGUrUFVhTEpQRTJuUW1jaFY0bmVESG5laG1ZMFhCeGhqWUY2eG1OTklL?=
 =?utf-8?B?Q1Z4VDhzdE84MlZwUkx4aTBkdFFKR3R0RnVPdWxCRkFtZ0NaUEphajh6NnQ3?=
 =?utf-8?B?RzhoWlRUblJ6SWxZWWliN0ZwbTdlM1B3QUpZT3ZYeTR2bEhIME1ISzg4SjN6?=
 =?utf-8?B?RFhGZkRDSm5XUDE5ZklBMkw1UFFrVENGbWY1MnNJVDB5Uk5yUjY3UEtGOHZm?=
 =?utf-8?B?NzJCNEEzNUh0NGlmQjl3Ni83NVhIdlZhMUFEeUpSeVRPZmc1QnZhQnNEZzFp?=
 =?utf-8?B?UkJKZkpvQURZc2w0U2pKUUlYQjUydWtJNlh6alBBMk42cEc2SWh6TkxXZHl6?=
 =?utf-8?B?WUVCTEVrZWdJdmZ1Mk9TZXRyeHhIM041ZXBNNlo0RXBJd2o1V24zcVNFT1pp?=
 =?utf-8?B?VnJrbVJrVTd2VTZRTkhicnZWN3ZaYzkwUVBtZzVEZjIzVm9pTE11bjZvQVZF?=
 =?utf-8?B?ZXNJenBoQzVSMHI2NFBGQ0QwZVQvcVJmM0lHeUlkWnB6aXF6Z3ZXWDZBNXdu?=
 =?utf-8?B?Z1hFKy9QNi94TnZ2eEFlSXkxSFhOSW9pSHVoQUMzbDcxOUNxMElTRTROaEUv?=
 =?utf-8?B?RXd2Tk9ub3pCUmswTHJHalhtaEVIRDNRbnVaRUhIR3RTWHRFSnNxRnQ2MFFH?=
 =?utf-8?B?MGVoejFldHRlVWo4RlA1WXB4c1ZFbWl0ZXpMUXNtUW8xZThQQ3prTVIrMmdk?=
 =?utf-8?B?V1VLOEZNbElQRnlSeHZOZWUrT2NNeFArakVEdkpoZU5BaktqSzhGSHVyMUV3?=
 =?utf-8?B?NFNrM3NQU2FqNlh6QVJ5NUtiT210WW1reEIydU5RYmJSaWNmODhlTGl5V1Ay?=
 =?utf-8?B?azF2QUdTVUp1VjZPNm0rYVFKQklIbTcxZCtXU211TC9paVNYS2RzamFlNCtl?=
 =?utf-8?B?djdXWGloUlBnWUt4K0gwSVluc1dvZEZhUE1TQmNLeHpCaWFNUmVGeWtWOWJP?=
 =?utf-8?B?UHFGYVNQVFA1OVFsajVwWFh0UmFOZm1YM2syaU1vWkUzVHZ0c2pFVTk0T3Qw?=
 =?utf-8?B?ZWRrb21ueGR0VEZEZHg5R294Y05GVHFRQnpEc1dyZThvbUZNeEVEL1A0M0t4?=
 =?utf-8?B?TmhqbjNmSU9CSnVLZEw4REZSWWxlM2NpMkc0bnFCN2ZvZzllL3orVUcxVGZK?=
 =?utf-8?B?Z0tpYkR1SmZkb0RFQnN6RE1HdG9oK2EzQlRKWWwzTUdzd09MYzlOSFlwais1?=
 =?utf-8?B?Z0VCZlpvaFFlUy9ZQ2MyU2VFb0tURC96QndvSFZzSjVTd3E5ZG1LNVpPaUY1?=
 =?utf-8?B?dVBYaXBzU3RPdG5vSmtqc1JSVTlIVHQ3U3VZOU5pbnJJZXo1SnpyZVVFeE8w?=
 =?utf-8?B?bEpoR1o1ZC9rdlRsM0VBcmppY0M0eTRXMFAraGttbkdkcjRzMTVEa1pLTXlJ?=
 =?utf-8?B?VGtibGEzMkVoaWlZdFRLamtscW9JNzdCQS9jMExHYnNLc01lcHp5MGUxVzhR?=
 =?utf-8?B?WWRsMGJSSVM2N1N1ZldxRXBSanV2OHpTNWNLVDZpMitPNWpYaTlkejFLa05H?=
 =?utf-8?B?bTVvWmxoejBQZFBuVGphOGJPdzRuQ3dqU3pXY2xadFdsMWVUTExST0VMQ2N1?=
 =?utf-8?B?eTRqMUJsUWNjT1Vpb0dIc2pMUWxCMSs3NjB2RkJPcHhvL09HL04rcnlYZkdZ?=
 =?utf-8?B?OU1wYm82RG10UzZNclZQSzBTamgwWHlSTytCbmVjQkRzQXRNc0h0aEFXaHJZ?=
 =?utf-8?B?RDdjc2JoNFBTUjlHdlprNU1GSVIvNnl0UFBxT01zMU91anpFV2g1UVNKQ09M?=
 =?utf-8?B?d2NGaVFhaGZ4QXdTd2FtOWx1b3VHY2xOVCsva1RQdTNZNkQ4WUV1UXF2bTNF?=
 =?utf-8?Q?WA882db2wf4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ujk0MzF6ak0vQzl6WThOMFA1SlRyblJWSTdCTUI0YWhNWlZodk1rQzNqRkYv?=
 =?utf-8?B?Sm1BZlAvMHl0ZEJLYlRJYVZ0eEJTYUdhQU0yUG5obDBKNmd1V0NYNGRybi9S?=
 =?utf-8?B?NURWN3lPRmIvTnhYbE1HM0xqbzBzQkhaZ3FOK1NRSmVnK2lDNmV3L3M5a3J6?=
 =?utf-8?B?SmNHSVhlYUt4Ums2aGNCN1c5dExaWmgzcjBDSlVhN2VZWlBpcmdEdGM5VmE1?=
 =?utf-8?B?VktwdVREY1V5MUdacG4yY01EVDhEWnhhQTFnc3pVSHN2Z3FRWDU2RWd6Tjly?=
 =?utf-8?B?WWl3WGR0bnFhbEYwWmZXTEtESWFjdjk3ZWxENk1CTytpMlQxTWpNK1FCcjRL?=
 =?utf-8?B?SWxGYWpyWVlKMU8vUTcwVnRxUXFjTFpVVTdEK2ViNFFiYWg2aHlwZE1SRHJQ?=
 =?utf-8?B?U1BkQ1pRL1p2RXkxcG5YWXRaU2lYUEZQYUh3WXVWbzByeEo4VzFrMHhqeERW?=
 =?utf-8?B?WkRMK1FINTRzKzl5Z0t6V3hmNzRTa0dmVkZjY29neWorRHFCSklzdlJLR2pK?=
 =?utf-8?B?eW1ZOFFnUEFVd2N4M216TnM4U0ZtN1VZUlRMOGdLU0oxUjdyeCtZMlJwNlJi?=
 =?utf-8?B?ajA3WGpiS3JZOFN2OFhnMy9vR2FoVVlHajhjSU1BTWd4cWF2WjVWMHl4cTZ3?=
 =?utf-8?B?QzZlZG8rYTFLMURpVEVaRVRMKzNXTDVZY0tmQkZtV00vd0VxN3QxNFVPRjdZ?=
 =?utf-8?B?blBncDZLTU04MEQ1L2RGcTJpdnpjWXNGamNXdkNLQmpPUWsyR0tycWJsTzdC?=
 =?utf-8?B?RUlzaHB3MVorcHg2U3Njc1lsQlR6K3VMbFZ2VVQycnNrNXVhNmI1WmhlUkY4?=
 =?utf-8?B?R25Td3BPWnpIYUFIdEN4NkxmVVZiMURIeEc4NmtxRVIwa243UXNjTHF0Z2pp?=
 =?utf-8?B?ZVp3MkFXNTBYeTViUXFpeEwxbjdkWXFmcTcvQmZRZGQ3TUQ1NDV6bUt6bHVE?=
 =?utf-8?B?NGxNYnhnYzZ6UDBzT3NqVW42Z0s4c29hY3lDWE5RZ2sybDFiWi9qNzY2bTJP?=
 =?utf-8?B?TnlwL3FzSm9YV2JaSWd1ckt6R3dYQzY0RldYZmdGS3ZIdXFwVjdLWXQvK01D?=
 =?utf-8?B?QU9NcGtTYzlMTEl6V2lPbVBJbE54eGRoY1BIVUNDaDg2S3pLRXVMcjYxc2Va?=
 =?utf-8?B?ckFsMmZlazBob0hnNkZKTHh2Qm1zZXVDLzl4WmJRNE40VkNBZDU0c1FGR0Ji?=
 =?utf-8?B?VFVxSlVhNFlDTzY2a1oyb0RyTFZuUEhpOFFlVTRJVFhYWnZiNnhWelQ4NThB?=
 =?utf-8?B?Q09BMUozU2t3b1RIaVFSRDY5YTF4NUZPcHYrUmZMUlpFSXRrL3FNVGEvMnFx?=
 =?utf-8?B?d3JqaGUwV1BGWE1weVRVV0ZqT3ZxVitmcnBTVStxeVhOZWZlWWlhT1R1SUhW?=
 =?utf-8?B?S3A4ZG9XdkVSMVgrOEIxQ0R2Wi9QNTZRcVJmZ2w2Y2JvQmRBRjNka0dBL3dM?=
 =?utf-8?B?S1J0TDZXZ3h1M2IrTlAwZVFsenFNMjF0dUZxSm9jei9FaW5MK3BLUURnV1VB?=
 =?utf-8?B?VmhiazBoalJCUWhvQmlZd3U4M3F5WDRBRC92VUFQSGNXeVlnYWlRWlBsdGZs?=
 =?utf-8?B?UW1MZkVjcXJ4TnVlbXVETFR3Z01ySXNJQnBPUEhwMVhtZ2RPRlJtcnhQQzJl?=
 =?utf-8?B?U0c3OEUxR0hLQ2dLN1ZhcnB1Q05nd1JWeFloWm9paVpMYnQ4cGpLcmFVdDlu?=
 =?utf-8?B?Z0xuMHNuWTl1WWtVWWU4bGc3N1JhSURaSm5PSVBlNTlQK09heDBaKzQ1MTVh?=
 =?utf-8?B?b1RBbzN2cU12VnljbUFkWjZEcDQzZ3ZxN0t4ZTlUdDVPQkN4ak01bTdUYk4w?=
 =?utf-8?B?QXBkN2p3SVBDTS9QM2dyMmdtRkNINSttNGwvRUlaQXdtcnhjRjRlaDd1cWRa?=
 =?utf-8?B?VDZXUHppVEZZajZEdVY3N0U5NUY5b3dTR2VMZ2xBQWc1U3Qra1RtTk9Ha3A5?=
 =?utf-8?B?c3ZUSUJ1TlRXTFJ3bDNUSnE5K2FtMTB5Qm9XYzBPZ0xPdmIwK2lDNDBLUFNK?=
 =?utf-8?B?VVNERXhQT3gweGFiNEJIOWFhVmJ1c3RwUjlDUTFyanplZXVZSlczMmF2aEpL?=
 =?utf-8?B?VStzajVuZnA0TlV3VWo0TVNmQjYzTnp3d1J6TGtzM054c3Q5bzhqWXNLaCtX?=
 =?utf-8?Q?2SzLf+ftDkCzGToHCzvRUzwwR?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f1bb70-68f3-4aed-e5b9-08dd97afa0a5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:32.8105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pT+ElHkIlmWK+ZyM8jPKjQEcHisDIdcrYv8HlIH1XoqezlWHsAZtSPcqBuI0DyP8OFkfira9KIlHMU6aZvMnng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX5K0oLeY5GmTv
 hf9wbAalbNgC/QdWzZra0dNudMOgcdWq2kjLP3+07ZcaWS0bayQUhAYU8k9zN5KEJL89MFGCZh/
 1H2Z4JrIdT3FxD/E3shCPrPAxC0yoFTBSK80bDhCdmqXKnoWx/2vHzGXyBVRx8ofWu/DYf63rRa
 pJnFMzi4S+JQPHyTHpQJlaQwR8nmqDPxf5w7vQU9xPzyMzTApNYNWR6d+pSlKG26LG18/ZUNWpt
 lFiGxX7JtzeUwWuALLF5xuYkWn43hXJRDiZl97wV1F6NQFlMlPISMeGfEf5k+Q4aVOZbSQaKHu2
 ZwB24M71gKa+1UghTsDJaMj7NbB4RzKBLo0uJbAv/YqYGK5OYHZh8w26h1+g7o66SzAPbi/iTQz
 tezcAvJRTcIF8jkhOgGt+0sKMpKgTN3dO61NTnJXqaFU5yN2GzDtMqK1G+DOeFx8IgVHMPXu
X-Authority-Analysis: v=2.4 cv=T+SMT+KQ c=1 sm=1 tr=0 ts=682c9a04 cx=c_pps
 a=b6GhQBMDPEYsGtK7UrBDFg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=FCJwmHiiXP3F3EZgyVoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: swow5s0IQ_xmvvWBIp6ocg3YgZMaTtAN
X-Proofpoint-ORIG-GUID: swow5s0IQ_xmvvWBIp6ocg3YgZMaTtAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Small cleanup that reduces duplicate code for vfio-user and reduces the
size of vfio_realize(); while we're here, correct that name to
vfio_pci_realize().

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d96b55f80c..a873f82aeb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3017,6 +3017,19 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
     VFIODevice *vbasedev = &vdev->vbasedev;
+    uint32_t config_space_size;
+    int ret;
+
+    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
+
+    /* Get a copy of config space */
+    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
+                                     vdev->pdev.config);
+    if (ret < (int)config_space_size) {
+        ret = ret < 0 ? -ret : EFAULT;
+        error_setg_errno(errp, ret, "failed to read device config space");
+        return false;
+    }
 
     /* vfio emulates a lot for us, but some bits need extra love */
     vdev->emulated_config_bits = g_malloc0(vdev->config_size);
@@ -3138,15 +3151,14 @@ static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_realize(PCIDevice *pdev, Error **errp)
+static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-    int i, ret;
+    int i;
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
-    uint32_t config_space_size;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -3201,17 +3213,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
-
-    /* Get a copy of config space */
-    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
-                                     vdev->pdev.config);
-    if (ret < (int)config_space_size) {
-        ret = ret < 0 ? -ret : EFAULT;
-        error_setg_errno(errp, ret, "failed to read device config space");
-        goto error;
-    }
-
     if (!vfio_pci_config_setup(vdev, errp)) {
         goto error;
     }
@@ -3515,7 +3516,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
     dc->desc = "VFIO-based PCI device assignment";
-    pdc->realize = vfio_realize;
+    pdc->realize = vfio_pci_realize;
 
     object_class_property_set_description(klass, /* 1.3 */
                                           "host",
-- 
2.43.0


