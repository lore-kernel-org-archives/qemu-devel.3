Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9722E87846
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJ3W-0001Vb-Qf; Tue, 03 Feb 2026 11:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnJ3R-0001Tk-Jm
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:15:06 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnJ3Q-00055F-1n
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:15:05 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6138tBOr1996593; Tue, 3 Feb 2026 08:15:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9XuFhzxlumfaU3HCIrGdK9EpRxHHOXFL4rlpUb00F
 lM=; b=i+uQs36Q511kGO9vb1GZPnt37+VfnpJ+VfltgJI4gF/gskC0TbkXofRs5
 Aw16TTxgedPcDAf8dVSNxwX8GPAx3qZKFJL4oAdHF3dprt4K90cxXkbpCpqEAcb5
 99Hm6bFWQNqwkGSBFJBc38aJvq84INf2yk0cZltwZppBMomucaVeRtQBZmrzlma1
 EHiRd5roUc3gkoTQ7h7bghZfkZKyO8tFW6uy1BeJI4fozbm9gEch0CvdX8EIkuKK
 cXKDhduwXjjzcWr+/2SuiwRsBOMinVKsNfGeDbuWYtXVSUTBwkOE/fd1m5Yiwi5D
 QnnQLXkPhmDXftm3aYBo9CX9jam3g==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023121.outbound.protection.outlook.com
 [40.93.201.121])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c1gqhf655-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 08:15:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkaMB54A+mlzVrcx84qxJ72hieBXGlbfGgBTMjAQOLJ4BtWIQORb+K7RRh14m8pqQe5rDRqaun79ShDzpNy9fHZKztW9H5gMqRlbT2Hf76OosDqjCb9YY5uuL8FIzBMIPayf6DfXMOnXdcNmGLlpdciuhgdTQ2XK4j9gV0XdjXZDhyz7CDzbuUycVA7yIKYddK9G/JR232hxsqGQ/BtuFBFnZZeLVh2jPqrhsJhTmLfWrLlQtSA7F0+Pb0G+fkczTmB+m40v8a9SOb9vcG1SwFnGoKab06wkKZmVzlPV6yddYIfZ5aGun3vRoixZuh0hTK8vMd3YgLkEBfBbj8rt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XuFhzxlumfaU3HCIrGdK9EpRxHHOXFL4rlpUb00FlM=;
 b=pTe4aJQftIdRq7otmgv2tW+tmNJbFseru2LggyVSzior3U6G0lNoKDuMRMgYwBFZP4w0BVgYrFUXxoGHplBFMU5tejxWboVpvehNA83smEDMhHroYQAUBSoD3rvDIu/xn2+gzp4HEPFYvffcugTjc1wb2gUzCQSs95Rg9eCvlGK0jLpCvJ90wOFA83PH2H1PUv3ACaXd8fDD36j5ONIBEonirJ40XcRd3uK9f2sOv1pfyxprKqEW2Vog5sMaz8JXn3Oh3hSLoykZD06Ce+t2UqRFPtZerqAlFTBhW+EThPhIhBn9mCSSb2mSjyIABXQteaRGRb8lMFeWHci2IOFbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XuFhzxlumfaU3HCIrGdK9EpRxHHOXFL4rlpUb00FlM=;
 b=YIfWqpFu6w6jRDXs2TjWO0MBZ5BzvB4C2AbNBctd5JxOKU0C9Lgi+gzx77EcBucgby/wH3X0u/0qcIS7yNiv57nGcSIby4AX6EVhx+JeyGw/Dcq4Ou/bJdPLdZLf3UDgxwaqNAOydDfPIm3ngWIUv2AGu24CXCKheJ0GFYsYlOrUl3ysxwEjq1OUrwR74RJKzRn7b6baCxGYAgAGOPWIRNFQ3sTbIIqLjrMzjIeuW1bS6atAapJs2NywTk6hCNb8+BTXT1Xa63JDiPXVVrCi/hD7tsIN35pwk/8HgxBoHbHQ2nsMyizH4+2IAi0xgZpudotfXHiKS9VtoYlc25Tn7g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH2PR02MB6693.namprd02.prod.outlook.com (2603:10b6:610:a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 16:14:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:14:59 +0000
Message-ID: <b28eac6e-7d72-4017-8f3e-a6c3100d0f45@nutanix.com>
Date: Tue, 3 Feb 2026 16:14:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/37] scripts/modinfo: make --devices optional
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-15-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH2PR02MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7dc93b-f57f-4485-7dca-08de633f60b2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnF6NjFzaDZuUCtyZU1SNi83SzFIdG05dk16UFFCdkNpVUxPeURNNHBwajho?=
 =?utf-8?B?dTFJWWRFSTFBT1k5dk1qaGhtemZMc2lSRXVzeHRyV05kSEVDRXY3Y2x5dERn?=
 =?utf-8?B?eTJycTRWUlpyOUFtRHB1OElDbzdtUmk2dTdMRnZjb2pIbEJvQ2UxRGk0S1JH?=
 =?utf-8?B?RG1Pd29KKzNqYUhvRjgvU3V4ZDU5UllvaWhjcDBCYVBKZDFEUnZ4ZnlKUWRL?=
 =?utf-8?B?QzU4S045c1BrWktXWFdxcHFSMXFkdE9xeG9ZUmJkT0VYOEhHdjBJRnArR2F5?=
 =?utf-8?B?Q01taTREekd1eGlDRGtOZ2lsQ1Fpd0MrWnVvN0FoWjhaYmw3S25aWTV1c2J1?=
 =?utf-8?B?a1JmSU9Tcnl4SXEwY2UrUDI1eFZneHhuQVhYdUYwVUMxVGlLZDVLNHZ1aGVm?=
 =?utf-8?B?amZPai81eUhXZGFqUjI0NElpODhOa09Vbmk5UWVRMXhZRzFpYWl0SjJrWGE1?=
 =?utf-8?B?QWJWTnhPMTVCWDdLc2dHR0lBSGxjRzU1aEVrS1JiYVVPVHY4dUZJSTl6OExs?=
 =?utf-8?B?SW8xZTNRdTVReU83N3EwcGgvTWVCT2FYcFRZTC8weWlMR29EclZlcnc3SHV5?=
 =?utf-8?B?VzgzSER0aEMxWEtINkRvNjVFZnFCTFNmd3pNUDBXdU1lcTd0cFBEQlhsRW4y?=
 =?utf-8?B?eSt2bnNZaEJyWi9WQlo4eFNua2dTc1hrZU51cVJWZGV6ejZ4c0Q5emE2YldF?=
 =?utf-8?B?NGFTZU5EOG8xSGVpT1N5cU1iditEL085N0RhL2VITXNoMVduRURlZDJWU3c5?=
 =?utf-8?B?aHNEenhqd1dVaUVYVDY2ZDNKQld4a2NsbkRzSCs4dXNyUjBzOHJLWStTbFha?=
 =?utf-8?B?bEs2RTJjSzBPUXZxOVVnaGdZMzVqeHdHSVE4Q0Z1K0hNejl4VjNCMElMcndY?=
 =?utf-8?B?WXI0eXBCc0pZOUJUMW9pVU44RUdTMUhlS3NRbmV5MUViWFY3V0RPS05IK1No?=
 =?utf-8?B?eHBVbHU2VlVsTmFvS2VLNzMwUWFsOUNPQVpMbHZ3d1I5bVFHVnNzdDhOelYr?=
 =?utf-8?B?Qk13KzNGSk9HTy9sSWl2aXgyZnN4L3RXVnM2REV1bVlLaS80RXUrNlVXb25z?=
 =?utf-8?B?b091ekdFQVlqYXlJU1kwOGNGa1RaSXUycjl1QjB3dG9jV0twajJsN1JTVVNn?=
 =?utf-8?B?QnhTb1hyVy92MDc2UEh6cWxaWktWVmxyOEFMSHMrYWt6Uko2aW04R0lwWU02?=
 =?utf-8?B?ZkNlZ0tDREY2N3FyRmJya0tjZ1MweXk2VzA3Y3R1VVhkT3JHQndEdmh4ajRa?=
 =?utf-8?B?dE9EeUpWMVdXNTZEb0xBSVJ5aFlCRnRkTXFSR045QUl5eHp0VGZXTFhKS2V4?=
 =?utf-8?B?R3RNUU0zTi9UWEtlYTF2aVlmUE8zT0l2Z2RLaStqcW1ZMVNQRldKNGRzNmRW?=
 =?utf-8?B?T1N0M1RmbHphYlpvdGordURvdk81ZFQvaGdiQXhEbExFWDY1eVUwYzl2L1VR?=
 =?utf-8?B?YnJTVlhlVnlkb2s3WmE2bXFNcENQRTVaN3drUjdaMEFGdTYyYnZGRWVwVFd2?=
 =?utf-8?B?b3FVbGlRZkF6MFRxbG4rUVgwemNPa0I0QmVxMWwzNW16V2FFazl3WTNHWlR6?=
 =?utf-8?B?dnNjTUoxYUFPdE44N3NpVGQxN3hJK2JTdkhOV3ZjTmdkb3NsTUx4VTVFckRV?=
 =?utf-8?B?ZVVSYkRmWjE1cEN5RVlzTUZraDlNaVJOYitreTNsbmhNL25lMS9PTGkwTnA0?=
 =?utf-8?B?cVhCbkgwekEvZ2FtKzJ6SFFvQnBKcGplSEE4RzducU9PMDJ4MTAyWVVqY2w4?=
 =?utf-8?B?UFdwdlFaUEQ1NDNpVWt3YlczWUV2MWUyZUY1NEwwKy9NUTZFRFA3bDVKaGlT?=
 =?utf-8?B?TGg1SEF1QS9HTHNtQjhpVm1ISGduRHFUS1R1UXA2bmpsb3R3b1RWWFVhOVQy?=
 =?utf-8?B?d3kzVGFSbVFDaWFIbllCNEh3czdaNDlGdXM0Wm9RQU95c0Z1b1FtUU9sVDN0?=
 =?utf-8?B?L3o1MERkbmV5MTlSaHA0eENqRjdUWnpUaTB2UUc5WlZ2QXc5SSt1VXhzVm9i?=
 =?utf-8?B?c2xjV3dLdzVXMjE1R3gwS0ZRQ3JzanVqTW5sYXZXY2tqRFEvV3JhSVhCZFRl?=
 =?utf-8?B?ZnNMMERnWjdNMFoyTFJIdkNTZVVIbTV0YkFnYkIwYzN0Ly9DbkdNQ3NoLys5?=
 =?utf-8?Q?cYEM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUdZeEJnVUllK1VZWENPdXNTUE9xSVhWeEZMdFgvOEkwdFpWTXhrMzBQR2V6?=
 =?utf-8?B?MGt5em1kL0FDMStMOVFnc3FCbDdqdXFFejlkRnhmLzBjMDlJeWRZUWlXZHNG?=
 =?utf-8?B?QmM1Vm5NclYzUFNvdHRmWWNLMG5SYUNtUlJKT0FCMUpXdWw3aFdVbng2TmRk?=
 =?utf-8?B?VnJrNzJVRmJyQnVIRVJ6ZjBrNDBLcDZBU3VYZlNaaHFDbFc2bnZWaEF5RzBI?=
 =?utf-8?B?K2FkMHhoSkhpM1Jxam4wQy9HeCtveGtZNkpGZWVZNzZ1VUxVWm4vY0hZYVEx?=
 =?utf-8?B?QWdnSWtWT1J2b3lzazg4ZWVLMWp2cUxuVHFlVjVJZnNXRzFpd2kyT3l6SmFj?=
 =?utf-8?B?NTJPU1JLLzlGaWU1ekRYS1hHTlRHbTVJMjJPK1NQZklNR3ZpVHJYTW1CdjQ1?=
 =?utf-8?B?MGFYYlE1ejR0Q1htWWdod3RsN2Y1L3lNZDgvVWpUajk4d1RGbnJtZ01hWElY?=
 =?utf-8?B?STB6Z3UvVGVxNjY0YnIwWXdhOE1td1MxQkIrejY4bUdvNk9iMjhzeDlzOEVn?=
 =?utf-8?B?eG1mbFVMTmlsalNUTDNUNlhpL1R0bHJwUElKNHlrRWRQSzBiUVFDcGppK1JW?=
 =?utf-8?B?N3QrQUYzbEZxS3BwaTFhRWVRWWlYWWpRQjhRa0E2dnlqNFVxbStPWVhGNUR1?=
 =?utf-8?B?RDJ0R1VJT0pvQWYrUHZVSUlTTlkzMnpQTW42V1ZLVnNwMXMvOUZTTEc1K3NS?=
 =?utf-8?B?bG92VDVJcHpvdjZoOUNyL0J5Q3ZQT1l6RnE3akZlV0lZNlJNL2tVQndLSU5S?=
 =?utf-8?B?VURKYjMyeWNxOFdiQkgwVjV5emx5OVdFOU9lZHJaVFYzVURMUUErc1RRWjUy?=
 =?utf-8?B?aG5GcDI2N0N3MTByc3VYUm42U3RQTXhVdDdsYzlKbkNHVDM1cmFKcnNlOFgw?=
 =?utf-8?B?UGFOMHhDZHZJL3grZStHek5lejJ1MFIza2M5b2N2akp6amE5a2FTRFVXamt0?=
 =?utf-8?B?OEljWWZLR3FnZnNNZmppVGxUZFNWaElnMy8rWnhpcjBSTGMxY2pxMWdHbkhE?=
 =?utf-8?B?M09aN0pHSTNxZi9BVjJkZU1DeTFhRmJLMVdxdXN6NlJhSXV4VWxyenhSbHcv?=
 =?utf-8?B?ZlI3OTIreDBGeWRSV2R0Z1hZQXM3V2QzNERGdXBwejZYc1VrQVYwdGJaSjVv?=
 =?utf-8?B?cFVwSHNSdkVEamlmRFBaVEM1RCs4Z21oRXRGWWVHUHROa2xGU2lYcWNrSXNX?=
 =?utf-8?B?VkxDWk9sMi9iZ0hLTXlvZ1dJSlZyQ1hYOWJ2MGN2SWtnY2Y4SEo2MDROS0F4?=
 =?utf-8?B?ODhyNjhHSXZpZ0didndWV2xJWUZXVkprY3NSbDljREJZVklVUDB2RXJyTlJ4?=
 =?utf-8?B?Yy83RVpiek9qRkNPOFAxMldFSkZ1REw3ZlNCVTdwL0lXdyt0SFVpcVhHTFFB?=
 =?utf-8?B?aWVpQlE0RHJzc1lxbWhWT2gvYm1HZ29SbDZmamlKTmJoZ1dPQXRIcDhYQXJP?=
 =?utf-8?B?VnZDNjg1YjFKbzlMNTRpaExvZTdSbEhzeGhFd0J5SGRyMWtUaWF6NDh3OG9x?=
 =?utf-8?B?dFlHMW9sL3l4S1pLWGY0b0JQcmdVNGdUQlJ1dHZNZWVUZG9DS1pSbi96RExX?=
 =?utf-8?B?dEJQU3pCVjAwd1lkWk9WRUJoM2hyMUt2NHVacjg1dTVyMnVtZThPbHRDQnQ5?=
 =?utf-8?B?dGhHY1dmdTZQOEYwWEhid29vQ2FDWk9JSnNvakNSR2RXMGw5WWpGdDE4Q0dq?=
 =?utf-8?B?V0dyRCt0YVFMZDkyUWlpMVpDdFhSRXpRNXNzNkIvTXM5aFJvN2ZBbTBoNlNX?=
 =?utf-8?B?RmpMZTlnQXRZSy8raWIrTy9FcFBZcE16d0VJN2tndW4rOFZCTmVWUzUrcG91?=
 =?utf-8?B?Y0M0dGFQdFF5VjV5SmpkZkZidTBjNlBZbEEzRFFqOGdSR2o5KzVnYVJtc21F?=
 =?utf-8?B?V1pGR0hHQUtzYTBrYWpqUy96OFllaXRQVHV3WHVPNnVpWEpvc1FCQlpXYnlS?=
 =?utf-8?B?YlZuTnBJSnVGbDNSVytOOWtSSGR1eWZTN3Z2bTJHQUJhL1RjeUMxTEtTWEla?=
 =?utf-8?B?bHM2dTFzaERhQWI1ZCtRMFhJME03QjFSQXd3cTE2cTlrNXM4dHRzNmFDbU5E?=
 =?utf-8?B?UGNOVjVQTHREckIwbnFJdlY4eFhueDlNNzUwVlZvUTllcEV5Y2s4MzNvS3Bm?=
 =?utf-8?B?V1dOZ3QwME90TFBwNi9uWnlrTVBQTVRxVUxGdmZyMzRhVTMvTC9TWUIyTVh0?=
 =?utf-8?B?dVJxU0JjQm1RQ1dOWklMUE5VV3JJcGtJbWZWelJsR0F0b21UQzBXSHNpWXZC?=
 =?utf-8?B?S3ZOUGRrRkZFeXJsYU13OHpFc1hTbXE5cjZ6eUI5blJqVUlRSkx4THNSeUh3?=
 =?utf-8?B?eHM5U3lCL2hEL0xqcnVZa3VGOHBVRU1JcWxyYnhEclY5SUlaOTAzdnNUa3dF?=
 =?utf-8?Q?+lzO/u3qDpj7n2/4=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7dc93b-f57f-4485-7dca-08de633f60b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:14:59.1028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrRqzRNTlJANFCS/XO4yQXggDGpHa7ico/2QlFF9uo/9hJ923jPPBmPKkFctCiSwiH/Sx9Pz+ngiNBcLF+BD1jeOUgpxYp1NnFg1v9JUlQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6693
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyOSBTYWx0ZWRfX/Zsf2MGgthBO
 f2o659/bfhTySTh6KoeogYp/cW5vuo5t71WBA+mWWCMBXmHM0tv5xBCxdgHNF1kW/ZheByQ6kNm
 88+mmTl8fTdhg+wf77s5MpWs++GEwyFc33ZOMSguW3o3plmiH2tVIEex9D68EhKu8DNnEPi8+ua
 S34rUrFUkxrLHFqlrg2b5YgGsmKGAIdeHfSf/0PQTU57hfP25iwzwQJ6B5gTWO9WFTqrtpS6Tiz
 ZlL6HPe8B2pdf98ucKcBURCiXspKPU8Arnce3br6qdjt2XBQxJCI4rf6fHoCqBTywnOOe+qyT4R
 acvX21NLFJDMgKD3363AlllGanfKG0UaZhnOzolBPVibi0yBBvGems6D6XBRzE8D7aXEtXNB7wl
 Jo0xZHHrapS6Mxh9fEWHopcGlNQfKJFwGjRSNCmC4T2Kn3J3K5LcsBPnUPmLz2IISdgZ5Zxz2PF
 QRcilDmqdzHcgeiPKug==
X-Proofpoint-GUID: G5FbLVwk8XznZzPe0APC_4iqcsnFFw4C
X-Authority-Analysis: v=2.4 cv=aNX9aL9m c=1 sm=1 tr=0 ts=69821f05 cx=c_pps
 a=0rRmVCaqev1jNxcJeZKYQQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=qT6dup1CUBKweUtZAPUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: G5FbLVwk8XznZzPe0APC_4iqcsnFFw4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This will allow to use modinfo-generate in cases where devices aren't
> relevant (tests etc)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   scripts/modinfo-generate.py | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
> index 777d419aa33..e7d35242414 100644
> --- a/scripts/modinfo-generate.py
> +++ b/scripts/modinfo-generate.py
> @@ -84,7 +84,7 @@ def main() -> None:
>       parser = argparse.ArgumentParser(
>           description='Generate C code for QEMU module info'
>       )
> -    parser.add_argument('--devices', required=True,
> +    parser.add_argument('--devices',
>                           help='path to config-device.mak')
>       parser.add_argument('modinfo', nargs='+',
>                           help='modinfo files to process')
> @@ -92,11 +92,12 @@ def main() -> None:
>   
>       # get all devices enabled in kconfig, from *-config-device.mak
>       enabled = set()
> -    with open(args.devices) as file:
> -        for line in file.readlines():
> -            config = line.split('=')
> -            if config[1].rstrip() == 'y':
> -                enabled.add(config[0][7:])  # remove CONFIG_
> +    if args.devices:
> +        with open(args.devices) as file:
> +            for line in file.readlines():
> +                config = line.split('=')
> +                if config[1].rstrip() == 'y':
> +                    enabled.add(config[0][7:])  # remove CONFIG_
>   
>       deps = set()
>       modules = set()

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


