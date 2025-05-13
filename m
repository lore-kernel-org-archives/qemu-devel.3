Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25F3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEna2-0004Ec-B5; Tue, 13 May 2025 07:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uEna0-0004E6-KU
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:13:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uEnZy-0006Q4-6i
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:13:48 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D7EBjU002543;
 Tue, 13 May 2025 04:13:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=oycWsSAQvl6qGj3pIdbgoV47yF3N1XDCg3YJYMtix
 14=; b=RJSoEEB55NVu4EZ/De23v+ndp+tSj8uOtgLDOMrOPLIxIlaPTN/Ukct1J
 pHsIxYVvO/WZkdzrJxFeafHS7j8+ZCmMN/W25dyeHKPHVqWAgKgHZdyU4GEBD8v/
 9TzWLjrgUPP7PU8Aa5Q3aEyHs9RK4A9RCWKC58+8YRLdmiq3E1le6vcBt2mCs25q
 pMwQ4E7Ag4mkqR2USpC9AEGcM8rJbYePXZ+SGlWatvJg9Nc+teCpvB21xyRHe/KP
 t19Dpl0iFfqEaTLcoZE0jpoBVKLCwtd11prB/yvdr1QLg5+PuVgZvvxgO4Ub9HqD
 cyeXSoZiB04wiIVn6gDpU3TCN75lg==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46j6b05pe6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 04:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tI7xZ+7vs60qbQv2gHpFuKtRN1nhlRCf0MtRKDArS97nIFJwJQT0AiMFT6Px7/kjmU8O7+V0JiV89VoscMM0qDE1jRl00P5vXdliZb/JBxxX7QRqPsPVvaSQmHRasLCo62JZGIoU1FDnYt1p2AVTS+f8w9xQOGUB35Jeh6cQplbFPbpviOQ3uEp9gVhAKktOasADm9UNEm8uHwUZQbV6zHzsOejDHfd28bCfaFIF/17W92b6VYjLXeqmLtvCMPHI/KaxK4EvtmaEACD3w/VkIz4xe6CC1UgAl9lD+iG7XOMrQpHRSYrS1x1wY8smhdVvTebjgcRSR4HtudYXgKorLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oycWsSAQvl6qGj3pIdbgoV47yF3N1XDCg3YJYMtix14=;
 b=pswHXJvWLmob9t9ZXrSGgI7d+OAIMICSpx8wDBbU9TrejBVmp6OxL54aukKjnuGyv2Z6A9CoXoHmFZvny903nQDbBriufb4juQzJ3658hWwq7SbWNdNxILwJcNnneQwGUNBC5IR6CPqiKRuUVbZ8MtCT3xrHiRY4gDd3iGm74Gv/AkUx2SMHzP02YhC7NAcrLRJHOs20nfm2yEAaF7WWN99X0x8Ehs1fsIZAjuOKn8mGjSsD12uBLPsoPmgGHSwf49WtSt8aX7x2rKB6g5zKG8noSd0QAAVbmGnUagN5nRr/7GiXMnDAbCPHTqRLR0U8KjOXGuJSfbNmVnLl6PbrQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oycWsSAQvl6qGj3pIdbgoV47yF3N1XDCg3YJYMtix14=;
 b=aNR1kRTkBxsPAIfFasLr+AmkKN42Nvv9vuJt1VhO5o+HRFi9OxeWX+15pz/0/SAkSBvPeFIH3XFTGnr9lz6raDOR0a8izS2R8bFIB7CIPqUqMjNKsMW2iLlXimhjG/y4668TJldNTEQ2HPgQ7JPDvLVJe1YAbCNm3rE6G7kHtLrbyUlOelxETR0oHBIbC505VBObyhju6VyjTWeTH/1uDZc3gCsSQbJnKxy/UsVgaaYVtcg+USvGG8Udg/Fc9AtbBmKBiinwRcLjp5bT+BTgB6wO6MdvNo0sNYfODES8h8Lv7dCzqMGgUU2hY7epQTsZuF5+IlXUz239Vfy+jGJpfA==
Received: from BN8PR02MB5745.namprd02.prod.outlook.com (2603:10b6:408:bb::31)
 by BY5PR02MB6470.namprd02.prod.outlook.com (2603:10b6:a03:1dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Tue, 13 May
 2025 11:12:32 +0000
Received: from BN8PR02MB5745.namprd02.prod.outlook.com
 ([fe80::13bb:c756:a495:74f1]) by BN8PR02MB5745.namprd02.prod.outlook.com
 ([fe80::13bb:c756:a495:74f1%5]) with mapi id 15.20.8722.024; Tue, 13 May 2025
 11:12:32 +0000
Message-ID: <49dad632-fd30-45fd-8dac-80c8bb446809@nutanix.com>
Date: Tue, 13 May 2025 12:12:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 26/42] vfio: return mr from vfio_get_xlat_addr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-27-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <1747063973-124548-27-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0089.eurprd03.prod.outlook.com
 (2603:10a6:208:69::30) To BN8PR02MB5745.namprd02.prod.outlook.com
 (2603:10b6:408:bb::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR02MB5745:EE_|BY5PR02MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f0c2cd-b5b4-4db8-a666-08dd920f0e6e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmFVVkJMaC9wUTcrUnZoTmRQc01EY3AwYkFjYjhiWi9wZVVkZFo1K0pGL2dZ?=
 =?utf-8?B?ejFuQ2NxY3h0eE1zeDhzZFlOVDFXNVYwUnJxUDJSeUhzeE5BWk5xemUyN0kz?=
 =?utf-8?B?MzVDVU9uZWNoYkkrMnEvRVdCN05rUW1wUFFXTlZjNUVWSEx4aWp1elhDWDBm?=
 =?utf-8?B?SStSY2FCSzc1N3Z1YXcwR25GU2lFL1RJeE02dnNMdWpYTnpid2ZHUzRRRng0?=
 =?utf-8?B?ck5PUS9ZVDFDZWUwTW5YajRobDBPekRvWFdNbXlYbzBGc0ZKSXpFdS9jeEY3?=
 =?utf-8?B?R1ZzOGhVRjl6RWM1aGVLUzdmU1FPTkhwaHRCWGRCZy95K01TOFV3TXJPb0h6?=
 =?utf-8?B?L3JkQU1nNnA4dGpCL1JFWnFwTFVxamJiamxrZmh1NXJodHZsZGlOZm5ETW1T?=
 =?utf-8?B?N2tIc24vSlZqYm5LWVFnL0k3TVRSY25qWDhzNkJ6Q1kzbFBPbDZ6YlNObC9R?=
 =?utf-8?B?UnFFbTZDd3pJNEJXM2FaNkowM0Q1WE1yekZJMk9pWlUzWDQ4RDFpSHNXdndM?=
 =?utf-8?B?RzNzWDh4bzdWSWYvcDcyeEdyaXFGTVZSd1VoTUx4a2xOR3JtNTBnM0pXZ1BF?=
 =?utf-8?B?azd2cVZVSC9McVdMM282aTRtemM5ajJjWHM3cjU1dVRnTzIrR1JEZ0NLVUM3?=
 =?utf-8?B?dThRNXJBbitDRWFkSURzcHg5YXZwMU1EQTdTUndUdUExUzNYYVhEV2l3RlFT?=
 =?utf-8?B?NFhIZHJVOE9EWmFsWW9TVkdZM2RCWHhWUlF6L1RhSTR3OEh6UnA0UjhxclVN?=
 =?utf-8?B?bitqTkYzbi9SaEhvSlZBU1JnUEwva1VNUm1BdFdIQzhyTW1tSlArK2xJSmNi?=
 =?utf-8?B?NjNlYUwrN1piRWJWVFdTYU52Q1MyTEJ0RHBadTQvekZ0aCt2UUFvLzIxTXpY?=
 =?utf-8?B?dTRtQ1QxUm5EYXZlMjAwRXFUWUR1V0pHaHZGUkR6S0d6MFNhZHNWZ3EvYXFD?=
 =?utf-8?B?aS9RaERla3k5ZmpsVXkrc1JXVW85KzJjblBac2pKcUNwVWRDdXhmYkpiL2Q0?=
 =?utf-8?B?bjFQaEVITzg3NHN4M0c2d3luUkFTUGRkWXJENE03UHpyWVFUZ2d2bnJGR1F0?=
 =?utf-8?B?WDJFa0N2ZmIrVEY3bHZSSUp4QnUvdFdRVGUrS1FmTXJhT3dXYlJnNEZEWkxT?=
 =?utf-8?B?VUpyYk5aOXZkamlYS3NrOVFZc1JtNnRQOXlNZnNydHJwOVo1TnJKVjVjemtp?=
 =?utf-8?B?cG4yNk1iMHE0YSsyTTAyNnNtZ3g4MnRyV1hMNzhZNkwrRzJJQld6YjNPZ3dO?=
 =?utf-8?B?aDlMWE1peEtCempVZk96SExSbXlwTXhyQytZMmJ3bkcra0R5bXFZelBoVWhV?=
 =?utf-8?B?Nm1VQnh0TUsyWWFyVGpyVTZxalc3bzFta21Oemw3cUNJWWM4MEZrUHZtblB3?=
 =?utf-8?B?dm9vRlRGcDBodDYxTWdFUWVsK00zUlpVckFlUDI5VVNxRmRrdTRRYjFhZjk1?=
 =?utf-8?B?YTdkNHlod2Q5WWZualI4WTZDYmFjVEQvd0liRE9kSlVhelZvZXhEYkcxejh4?=
 =?utf-8?B?NTY0UHhWR01URk8zY0xmaFNXRzh5OGVPblFPRDEwNGhSbVIvbTJvMFpzRkRT?=
 =?utf-8?B?WDZEZlRPdFZ1QjBRME5oaXpSd1RrazhRcENIc3lDS0lHdEpOUGRsQWNvOXpx?=
 =?utf-8?B?THZiTklSSFIxTll0djRsVFpsa0M3VGZwcHhYR3lnUEZ4RVpDcGpHc2M1b2pS?=
 =?utf-8?B?bXZraWpBejRjd1ZtV1hhNkU2K0IzbVJHVDdOQmZpQWh6QUdQVjFRbUVibEtX?=
 =?utf-8?B?b21JSUNnQ293YVdCQm9WemRxMk1wSG5neTFQSUVxQXdCV0FsUU5tOXB6Q1hx?=
 =?utf-8?B?SVFzWGo1SWFwN2swU2hQQm9iUk9RcWowYmpXRkh1WU9XY3pTK0ZYa1UwdktH?=
 =?utf-8?B?eUYwbGZSdjdvZ2pMQUhxTEViVTBqaFE2MmZCdGVNdVU2UnUyVThqYmN5cjNP?=
 =?utf-8?Q?cMuBPryp9DE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR02MB5745.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2p3Z1R2VEV2T2dpZGpHMzM3N21IR1hjK25PaU02NGVWSHF2Y1VSd20rWDlt?=
 =?utf-8?B?VFlqdWdEK0JDa0JKWlZXTmRoenY5RGp3WlRjL2xOaUg2TzBLeDg4MkRNekRu?=
 =?utf-8?B?L3NyZkMzMzFFcTZWU2hrWHJ0cWdIUldCd0NWckRDUmYyMnJiTUxuQzRvN2VQ?=
 =?utf-8?B?dmdMQVNoV0FjY3QyR0VGeWUrM0ltVW5DOFIxU2kydVpFNVcwRCtVbmRlaHpu?=
 =?utf-8?B?cjFRWDVxRFRvWE43U1orSjVlb0xpUE1pbVAydW1PRzVBM1lLbnJ5NmhBamt5?=
 =?utf-8?B?ekM0aTMrVkNaMWE5U2dDZjZRMGJ0ODVJZmtQeGhwMnBlOHUwRXB0eDNaejZa?=
 =?utf-8?B?YktXQlhSNTkrNm1RTlRNTVY1aGt2UldiZGZlckJsSFF4ZitRakluZXpROWR4?=
 =?utf-8?B?WlI5ek5lVTJKQTdFTVpYUUl4TFlZUklpMVlhNU5TYXc5TEMzWFVtbFJJblBO?=
 =?utf-8?B?N2xIZnJkelo4MThzMHhGbStESmlBSU9CZUlmaVFSVlNhNFVGWmIzRnFyMnRn?=
 =?utf-8?B?VWdvWjgvcm9SaXhndi9zTkpjMDhudGx4cHhnY2xuRSt0MHpQRW5ZanJNNUM2?=
 =?utf-8?B?Qm90MkNuQTRtUkI2RTM4dHRDdkZRQ3VNU2UyZzBBY3FLV0s0d2J4UWFjcjFy?=
 =?utf-8?B?ZWF6MmMyV09pUmhkcFlyMlhyMXRjbXFBL3hYYWN2M2llbVF5MDBnaHp1R2lk?=
 =?utf-8?B?TGhUNC9KZXFqby9QNXFTVkwzRC9mZ2RsQThjSG9wR1B4YTdZenRHQWRIOHpU?=
 =?utf-8?B?Q0hmWGRyTkc1eGxxeGViNDhYNkNUKzRaYzJEalB6Um00YU5jL2dvS3k5a0VB?=
 =?utf-8?B?cU1PVWFwNWxwcUZUSVN3VHhoRFdhNi9OcFI3M0tlYzdHR3NvMmRKQjVqd0RN?=
 =?utf-8?B?cTZOekR2azlyVnFDZVRTSkIxYTl5bVRqa0VJa295VnI4ZnlSTEFkZnpQUldr?=
 =?utf-8?B?QWx4dk00b1l2MTlxT2dHMjQyQnUzY0tVVUpZeGcxaHA4VHM5aVcva1pPWWxN?=
 =?utf-8?B?TE0wVUFBWE5QeTFLenFQemdtZDVrUmxJNS8zVUI0NWJ2c21lQ09DeHcrK1hG?=
 =?utf-8?B?NjZCZFNHYmxCVTBySVZBenc4SU9ZeVRHV2poZmEybVlGV1NSM2RlOVZIcm95?=
 =?utf-8?B?TDJ3eHFlVG54YXhWR0w0UDFxNDdEYnBFNkFvZit1YkRCc3J2MlVsbThUWVEv?=
 =?utf-8?B?MDFMM2NkTlpaSHlXdGFzTEdMb2gwZ1FLQkhaMFl0V2JIQXF6MDNHcEZHUTB3?=
 =?utf-8?B?S3FPc1JrRzZFZUwwd3RCaDlTWHJDRWNOSkUwdGd3NTJnY2VpUzFtbUdCYUQ3?=
 =?utf-8?B?Ly8zT3RvTDJBVThndG0yL2UyRlBlYytMSHNmRmVpaHdYazd5VkNYdTFPcitY?=
 =?utf-8?B?UzY0cTRRV015ZS9IUlVzK2JEMmMvZWZicEV2ajZDOVN4by9BdElnMW9NNXY3?=
 =?utf-8?B?L0dGNmxBODArcCtxMUhaSzNyNHVXdWF6YW5uWWcwSzV2bTdyUnZSNGFYY2Yx?=
 =?utf-8?B?Tk13YStIRnRML2U4djdDd0MrbkJvZWhYcDAya2NLZ21sYzYyMDlpZDVnYW9W?=
 =?utf-8?B?NTdEZFR5eDV3NDlOcXE2K0FXSmJxQVd0cUZTUUhDRGV5QVMwa3djVk12Q0t3?=
 =?utf-8?B?MU83ZGtQS1k1aVVKZFgzVDRERUhHUUkvNUY4TURGQnN1YXRGTXl2ZGlSUHRq?=
 =?utf-8?B?c3lMMzAzOTN1cHRwRThBcVVDekZNZzF4TjhTR1p2TUNYYi93UytxTHZsQzBT?=
 =?utf-8?B?MWlGenp3K3g2cnB1YUNHWjFtZU1XbUJSN0V0R1Z4akROOWRXU3ZMQkRtVVAz?=
 =?utf-8?B?M05WWDFoQkdhZUlkdVcxaHJMZUVBdTdxaVl6anRaNVhsNVE1S3FhTzJmU3I4?=
 =?utf-8?B?K3RNMW1PYldlelltOGJuYUN2aG0xNlpIV2NCMDh4M3ZzYWVYMHRVclF1OGF1?=
 =?utf-8?B?eStwQjcwalNTL25SRlR0WkxCZ3U3TFNEb0E4b0tCZ1VOcS9EbFg0K3ovVUNp?=
 =?utf-8?B?Q3BMVWljRHc1cEJqbkk5YXNJelJ4UmZxbzAwaWRNcmU0RHMrdTBJS3ZzckpQ?=
 =?utf-8?B?QzB5V1JQdmNYYS9YM3BlOUw2cjA3cFFCdFFGaVNwa1NkeWF5bHJ3RkpFc3Ru?=
 =?utf-8?B?UE11QS8vVm80NHhOTy9lc1BMTVI4clhlMDRha2pWV0dyYkEyTFgwenA1MkFJ?=
 =?utf-8?B?d1lhc3FaQ3E3RyswMUhSTExPWjAwQkppckpkTDRwT0ZGNzRXaHZrYU9vamV2?=
 =?utf-8?B?K2ZiRGpPWlBKWVEzQlVIaW1YYTFnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f0c2cd-b5b4-4db8-a666-08dd920f0e6e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR02MB5745.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:12:32.1733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xf+S2m+tOeqameqwoE8EhoHujASSFfD/xUGzqQKUfpxqcExv224YKJncbvMA07eQcVh5HGMBLDsoIIXyIIeZjjTKiA5xLdz49fpuyP4FfQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6470
X-Proofpoint-GUID: oN8jrcTY493Z2uPRSbLxYg-ZU-aPIyR_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEwNiBTYWx0ZWRfX2DnsrUUfrJPp
 lLIHU7aM3hU83dtjEoMTwuMLgLJLofOyRAVdptWxMFdPvkatNe2IxPpo6DfluQ3xAtIl6RRBK8k
 0KqNhCL0UDRSKVttZRH8f6NLxQz7vBeDEO1QNAFZD3bGtGfJaRITGSZq9653/sL0L0x3DjOHB1l
 JNN0BnmMK+czw3tkgsG2/FXh47RQdOjvke9ytU+7BE+OT7Ujvm5eeJRcHwI+cKWnETh8uu5/rdF
 PLubwqMAyFtpRcbL7By1VB8HKGoxKP8ZYvJZQ4h0t/TcPg++PElz12kydMraR6ZAqhUWPanAF6l
 /MrTf+fXh9dfwd1+bIafLu9EbJD1WVlne4g/cIVrMQOa0HNPZXPFrcakYkCNzqHI1KXFrrF7sVM
 irHztp8oLPJGumoh7MARsm/uOD+WXlF9VDGHXmMLlnBYMm8xpxZa/Qj1uyQuXHqCncVEKNiU
X-Authority-Analysis: v=2.4 cv=FZs3xI+6 c=1 sm=1 tr=0 ts=68232965 cx=c_pps
 a=elmNFn2UsiM7gRQtfbmgVg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=ujMz6IM2wRIdrFV31dwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oN8jrcTY493Z2uPRSbLxYg-ZU-aPIyR_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

On 12/05/2025 16:32, Steve Sistare wrote:

> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
> region that the translated address is found in.  This will be needed by
> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
> 
> Also return the xlat offset, so we can simplify the interface by removing
> the out parameters that can be trivially derived from mr and xlat.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/listener.c      | 29 +++++++++++++++++++----------
>   hw/virtio/vhost-vdpa.c  |  8 ++++++--
>   include/system/memory.h | 16 +++++++---------
>   system/memory.c         | 25 ++++---------------------
>   4 files changed, 36 insertions(+), 42 deletions(-)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index e86ffcf..87b7a3c 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>              section->offset_within_address_space & (1ULL << 63);
>   }
>   
> -/* Called with rcu_read_lock held.  */
> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                               ram_addr_t *ram_addr, bool *read_only,
> -                               Error **errp)
> +/*
> + * Called with rcu_read_lock held.
> + * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
> + */
> +static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
> +                               hwaddr *xlat_p, Error **errp)
>   {
> -    bool ret, mr_has_discard_manager;
> +    bool ret;
>   
> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
> -                               &mr_has_discard_manager, errp);
> -    if (ret && mr_has_discard_manager) {
> +    ret = memory_get_xlat_addr(iotlb, mr_p, xlat_p, errp);
> +    if (ret && memory_region_has_ram_discard_manager(*mr_p)) {

I'm trying to understand the underlying intention of this patch: is it 
just so that you can access the corresponding RAMBlock in 
vfio_container_dma_map() in patch 31 "vfio/iommufd: use 
IOMMU_IOAS_MAP_FILE"?

Given that the flatview can theoretically change at any point, it feels 
as if the current API whereby the vaddr is passed around is the correct 
approach, and that the final MemoryRegion lookup should be done at the 
point where it is required.

If this is the case, is it not simpler to add a call to 
address_space_translate() in patch 31 to obtain the MemoryRegion pointer 
there instead?

>           /*
>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
>            * pages will remain pinned inside vfio until unmapped, resulting in a
> @@ -126,6 +127,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
> +    MemoryRegion *mr;
> +    hwaddr xlat;
>       void *vaddr;
>       int ret;
>       Error *local_err = NULL;
> @@ -150,10 +153,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>   
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
> +        if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>               error_report_err(local_err);
>               goto out;
>           }
> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
> +
>           /*
>            * vaddr is only valid until rcu_read_unlock(). But after
>            * vfio_dma_map has set up the mapping the pages will be
> @@ -1047,6 +1053,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       ram_addr_t translated_addr;
>       Error *local_err = NULL;
>       int ret = -EINVAL;
> +    MemoryRegion *mr;
> +    ram_addr_t xlat;
>   
>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>   
> @@ -1058,9 +1066,10 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>   
>       rcu_read_lock();
> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> +    if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>           goto out_unlock;
>       }
> +    translated_addr = memory_region_get_ram_addr(mr) + xlat;
>   
>       ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>                                   translated_addr, &local_err);
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 1ab2c11..f191360 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -209,6 +209,8 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       int ret;
>       Int128 llend;
>       Error *local_err = NULL;
> +    MemoryRegion *mr;
> +    hwaddr xlat;
>   
>       if (iotlb->target_as != &address_space_memory) {
>           error_report("Wrong target AS \"%s\", only system memory is allowed",
> @@ -228,11 +230,13 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>   
> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> -                                  &local_err)) {
> +        if (!memory_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>               error_report_err(local_err);
>               return;
>           }
> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
> +
>           ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
>                                    iotlb->addr_mask + 1, vaddr, read_only);
>           if (ret) {
> diff --git a/include/system/memory.h b/include/system/memory.h
> index fbbf4cf..d743214 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -738,21 +738,19 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>                                                RamDiscardListener *rdl);
>   
>   /**
> - * memory_get_xlat_addr: Extract addresses from a TLB entry
> + * memory_get_xlat_addr: Extract addresses from a TLB entry.
> + *                       Called with rcu_read_lock held.
>    *
>    * @iotlb: pointer to an #IOMMUTLBEntry
> - * @vaddr: virtual address
> - * @ram_addr: RAM address
> - * @read_only: indicates if writes are allowed
> - * @mr_has_discard_manager: indicates memory is controlled by a
> - *                          RamDiscardManager
> + * @mr_p: return the MemoryRegion containing the @iotlb translated addr.
> + *        The MemoryRegion must not be accessed after rcu_read_unlock.
> + * @xlat_p: return the offset of the entry from the start of @mr_p
>    * @errp: pointer to Error*, to store an error if it happens.
>    *
>    * Return: true on success, else false setting @errp with error.
>    */
> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp);
> +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
> +                          hwaddr *xlat_p, Error **errp);
>   
>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
> diff --git a/system/memory.c b/system/memory.c
> index 63b983e..4894c0d 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2174,18 +2174,14 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>   }
>   
>   /* Called with rcu_read_lock held.  */
> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp)
> +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
> +                          hwaddr *xlat_p, Error **errp)
>   {
>       MemoryRegion *mr;
>       hwaddr xlat;
>       hwaddr len = iotlb->addr_mask + 1;
>       bool writable = iotlb->perm & IOMMU_WO;
>   
> -    if (mr_has_discard_manager) {
> -        *mr_has_discard_manager = false;
> -    }
>       /*
>        * The IOMMU TLB entry we have just covers translation through
>        * this IOMMU to its immediate target.  We need to translate
> @@ -2203,9 +2199,6 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>               .offset_within_region = xlat,
>               .size = int128_make64(len),
>           };
> -        if (mr_has_discard_manager) {
> -            *mr_has_discard_manager = true;
> -        }
>           /*
>            * Malicious VMs can map memory into the IOMMU, which is expected
>            * to remain discarded. vfio will pin all pages, populating memory.
> @@ -2229,18 +2222,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>           return false;
>       }
>   
> -    if (vaddr) {
> -        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> -    }
> -
> -    if (ram_addr) {
> -        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
> -    }
> -
> -    if (read_only) {
> -        *read_only = !writable || mr->readonly;
> -    }
> -
> +    *xlat_p = xlat;
> +    *mr_p = mr;
>       return true;
>   }


ATB,

Mark.


