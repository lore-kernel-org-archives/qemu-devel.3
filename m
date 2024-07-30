Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B8BC52D1D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYnw2-00017S-IF; Tue, 30 Jul 2024 10:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sYnw0-0000yb-54
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 10:34:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sYnvv-0004ZA-RY
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 10:34:39 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U8fZVN021517;
 Tue, 30 Jul 2024 12:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=AHwl8vlV1/hMMn0Q+IDOBOOoNzPXmmLMQi89VPnFDx0=; b=
 VqtUvchZ1BGY53ms/gg5RIVM7bIUT2DpHJ6MMSYasLiU7BdJC/K01sLykwumkXt+
 nMS9lh1TjVyPhgnPDQtNBZVv2muIjnxzQhrMJSmUnkQ3oEWDx6hFsDq/fdPDkbai
 DYZjMySj2Ye908uyEMQiiCXpEFa9ZXzmpQCYj5VX/KtGxSMSa184YgDnLafOVSi+
 oz0RbWPBv8/VyYcjfqxEAwGVm+TdoRogJwxdUIkTn81nVc1tT16G3ech81rzlIbI
 0SLhkhFFJvv8tDMLBI4/j+5hsoTAFSB5fSqw1QpSwjOR2SUSA8hFf7bYrxGsddaV
 upFMcFzRDk1f0oTOPm1+2g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfycvwr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2024 12:31:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46UC2FKs038801; Tue, 30 Jul 2024 12:31:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40pm836ar7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2024 12:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VruIfYs7aWQE2Rr2P8YoKNE+vvoJ3Rdwvjr5p3PxE3k2Y8l+YsxfsvQOrL6g/L+ZdNry+8inoNGeC0d0emRC9Z9TyEtBjs1IS31+KjeZKAilu7AC9gf/UTQ0uB2xMZR8Gg+1BWxFUdeNcARoSPmHbpPK/7bPmqtJObRox+t45moJpSi+Mi803UzAUdJNtlxSV9/lSGR4ltG+CG6lY+lMaF9GezPQ1PTtl8GisJk3PaPs/R4Hy7PcsJTgF9NY5MOnB83gGGzpuhJOpdFu9O+44hENsdEk3LEIdgX+f6vsSrfl7UiGeIYZfRrTPDqCjwRJP7cRRr1dq315CU+wYnv8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHwl8vlV1/hMMn0Q+IDOBOOoNzPXmmLMQi89VPnFDx0=;
 b=Q2QTUsQP5hVFp74S2MICcD4k0Fz9ODbfsc/WQD2rTqr2tJusUHDKTgHgJEu7jVfYKVkwHklvEE6LHXM7QmRZA7XTEgcXheo7Kxpv8t8UL4RPv4i8g9hrFP7fk5+Jve4Ew4UOMLB9Lm1YLrCuZroXN4MEvCaCt3etdvvh5um+N8fkOYrPcIyPHkVFN2DSJvlr5TKBp68K+5x9vIVAGFBya+WsiA0l0vnI/dud70bDoAW+1W4y3POGJvKDIDmBarCktOwEN4OL6JOAXoQk8PDhz2hc5eCzclmo32QdMWMHYnr29DaXk5HNXm+llKUpYnQouicxeZXu+NJgkc0dqyXVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHwl8vlV1/hMMn0Q+IDOBOOoNzPXmmLMQi89VPnFDx0=;
 b=hUmm6GHO2BSbjmUQ0ykULZVcNjkIluhKhRTe3ZHw+GnmFZ8CczvrHi6CRDPQ4FPZVav+vdME3HnqTJBX27sOju8sQp6to+FffHkYy+SgmXpgc28IySOv67D1cGy2DhcBW1cduqz04OeWJadTCIZZpaNBFB9znGBRS7h5/SN16ho=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by IA0PR10MB7579.namprd10.prod.outlook.com (2603:10b6:208:493::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 12:31:36 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%3]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 12:31:35 +0000
Message-ID: <2b2bf1a7-9ba9-4da9-b220-ce516ac029cc@oracle.com>
Date: Tue, 30 Jul 2024 08:31:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Si-Wei Liu <si-wei.liu@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEvdBDFvwvqb_7YXqiPd-ax4Xw7e0BLBhCt_uD6-Uf+DgA@mail.gmail.com>
 <CAJaqyWdA_6Mx3mkcobmBjB5NDJt3tyqTJv2JijF0agnnBFxQxw@mail.gmail.com>
 <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
 <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
 <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
 <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
 <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
 <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
 <CACGkMEtrPAMb-ZN7AAE8cjEzjZY1Hnm29J7PhUYgwv26=YcdQw@mail.gmail.com>
 <84374c5a-d937-4cb5-aafb-45ad75e2d837@oracle.com>
 <CAJaqyWfekhhG+5Zp4eddpp-2N=SjUL+7zs+YqS5xx6eWxa-PqQ@mail.gmail.com>
 <CACGkMEvYSBZpVG2x6q_viekods+QWrjoCETQcsgnHM+Ng4NWGw@mail.gmail.com>
 <CAJaqyWfm1zjU-eQ-j+GaWMHGt7Dk5nGUCUEA75yCga9sBxu39Q@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWfm1zjU-eQ-j+GaWMHGt7Dk5nGUCUEA75yCga9sBxu39Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0063.namprd11.prod.outlook.com
 (2603:10b6:a03:80::40) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|IA0PR10MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: e262a7fc-88dc-4710-2777-08dcb0938d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHNnN1N0cXBaTVVrK0NieFlZalV5WjMwaUY5Q1dhZW1IeGI3SHViVHVDVmZo?=
 =?utf-8?B?NG5tQXVWTVh2QlhlU1NoMjYxTmwxM0psVGZaWTV0Q2RrRkFjZVlsT01reGdD?=
 =?utf-8?B?eUE4SnVIaE1FNk1mYlU4MTQ1VnU3WEx1N1dZT05Qak9EY3kzY3RXQVFKazRC?=
 =?utf-8?B?MGtkdVlBVzlIemNOMUpWd1kzemhWU3FtbTRFeHQ2ZzlKWnpOMWlldkY2c1hE?=
 =?utf-8?B?ZDlGa2xrUERROUFPU0xhWWFKeDNHZlMzcm1hakdzb2pLSW5lTmhsUG9RWWFr?=
 =?utf-8?B?Ukh1STRwVHZHek5HVCt5SlZ3NDBpaHBNNzZUK0Y5Tk1FZ04vSXRNQXJrU2pV?=
 =?utf-8?B?U1RXMUo3Z2NLNStnVDQxR0pDcHVYUlVhUlk1RkVwK3FjdDJ5ZStGVWdUd0cx?=
 =?utf-8?B?MEpLWU9EOWdpcEFZV3IxVXRrSy82ZEltQ3NFNE1ZS0pRT0VsN0F0R3VyYXA3?=
 =?utf-8?B?TnQwdG81NEgzUUo4em9GRldFbG9kV3pMQVlXZjlFTTdrMHcxWmxpaC9zb092?=
 =?utf-8?B?UlFCSEhEdGQ5azE4VXRsMC9QR0drYWFORjNteGx3d1pDS1c2akUwc3M5bDJX?=
 =?utf-8?B?d3Y3N2hWY3g5S0V3MVpnRGhZU1d0RzhGNUlHMWFsYmUzdWMrbGxJc05SL2Z0?=
 =?utf-8?B?N2lRSk1TWEJFK3FhYWtUbm92WVN5c3NBS2UrOXo3SzlYUXlOV3B2dFNmUGRn?=
 =?utf-8?B?M3c1T2ZpbmVoZGVaU0hCNkQ3c2UyTkR4c2haSWxEVlloa0tFNDRmYStNU0RH?=
 =?utf-8?B?U2pQcEtWUnhHank0enY3di9WalhpbE9RL2p6SE5rNXYzZVhBSG5xa25uSndR?=
 =?utf-8?B?VkNDemUwYTkvVW45NjQ2QWxKTnJPRXpZbmNMdWF4bVhGdmZLWUxMV2RaMzIr?=
 =?utf-8?B?MHJZMFYyaVg3clI2MEpUcFVPUTQ4N2dOWUR5UjIrWVZiOHRDbkFJcXhhcnkr?=
 =?utf-8?B?eW5USlNKK3ZZZU5TYjZpMlRzZ0xoZ3gyUW1FbFBOZkFRNEY4WVovcmQwMSs5?=
 =?utf-8?B?WkJZVVUxSjRVU2JzenhYTDVOenZVRyt6RnA4bFRob1AybnNoYmhBVTQzeWhN?=
 =?utf-8?B?Q2Y1NnFzN3ZiaXo0dHk5cHdxZ3BQZGdEZVVsdFoxZzFOaUtaSlFXbE1DZ3lG?=
 =?utf-8?B?MElkNGNWTjBXNkNrVkdBc1VuOU9TYTZ0TjBuOGFwcjFTVHBwUUdvc0dLVTY2?=
 =?utf-8?B?VERpNm5la0QvVG9TVkt0anVKRlNxV3VLNk10ZUJDN0FkSE82NHJpU1MrR1Nl?=
 =?utf-8?B?MTR6T09zSHFWNFQ3K29weWhyTkg4TVVGVFA1K1owUHBkMmFXeDI4ZW1ITHYz?=
 =?utf-8?B?THRJQTQrdklhODJXQUg0cyt3eGEvVG14T1Y5VUt0TllweWlra01LTS9YVjZN?=
 =?utf-8?B?Z3l0S2FUYloxQm0xWGhOVWhoTld6akdzZmFtRUpEN3d4Q3F6Z1hQZDFzWW1i?=
 =?utf-8?B?TVFXTW9NRUJXMEVyYUNHNWxXOW9naXR3ZCs2TnM4SURMRW51djJuUXpSYXJh?=
 =?utf-8?B?L3M2VGhIN0laZFd3RC80K2hqdHBVaEdGdmx0ZEJYdDhiNEdrbUZmdG84dDl4?=
 =?utf-8?B?RnVEaVlPaWxLK2xKaDJWVk1OUDdxcFV5bnBJWTFBejNBQVlDejgzQzFlTTdw?=
 =?utf-8?B?SkkyY05BdnhZMkNQRU5Qa0QvUlJaVlB2R2VaY1pXMWdJcys3cXN0SVRIYTNu?=
 =?utf-8?B?c29KeVpOMno2a1pOOXBvV2FKSmtwOVdBdTdwR21NRmgydzErcC9rM0lxYVR3?=
 =?utf-8?Q?ykScoCg0oj6VdNdm7g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzR6UFdwOWwrTVpkWmIzUzBVTnB5SEpjTG01cy9xT1NIS2dPTGY0RWRIdGVS?=
 =?utf-8?B?WDZURS9pdXdZWk9rRERqeTlKY3N3dzkzT3BMcERqTmNIalJONlFZZ3VDRlFG?=
 =?utf-8?B?b3VpNCtvN2VUOFBNUktkalhZK0dFSVcxemE4OHpKYTBWWDZURHg5QlRvcllS?=
 =?utf-8?B?cWEwZVphWjdZUzY2cmtqMy9XVS9DV3RBZXBnQUc4K0c0bGRXVWhYMk80OVNt?=
 =?utf-8?B?NlgzcXM5YVdqb01xaUpKV2NGc3lhR0NrdktHdkQwRThLUzNaTjZJSUJuY2h6?=
 =?utf-8?B?VFpPQXF6NGd5VW9oTzVNRHZMN2FPL1pZcjhvZ2ZPZXJMTktRRGFpbHRvdFcy?=
 =?utf-8?B?cWNzcjhxczVNMGFwMkRLSXM3QjNqQ3B1RDlTUUp3L1ZHaThLWm44VnFMZ2U4?=
 =?utf-8?B?NmN3Q1dEajRBVUFUenNyMER0cmw4RE52TCs0R2xQTFgzeWlDZ2YrMkZKTXd3?=
 =?utf-8?B?QzVsZUpWVGpDMXFobTBTZXd4OEluQjM5Sm1HSnJadzZ3N0h1VCtoaG51Vk94?=
 =?utf-8?B?VlhWQ1RuR2hlVXBxNlM5c3lZNk5teGVMOU1rS0RFQ2hqNERkYWFkTURxWG9V?=
 =?utf-8?B?Z3pBTzk1TndQUFRvY2xPMTBqOFg1VUJiS3AvQUZlaUZaeHVFbnUwRjdKZmcz?=
 =?utf-8?B?Y1pIVENwRzF6TEdQZU1LSnlSZTEzY2hhYUNoZ1JJSm0rVE1jSXVES0o2UjIy?=
 =?utf-8?B?YW5DcjhzekhQMFpQcTBGZjFuU2lwaU5ySkorVGJ1UTgwZWRsYnlRK0VhVzlF?=
 =?utf-8?B?OUxUYy9mQnZsOGF6RldkekpTQzM4Zis0ZHU2N3pETHE0NmRtVXpVcmswUUJQ?=
 =?utf-8?B?QmoweXRPYVBCcnpHWFBYSlI5Rmw2TkpxNnNRUWlYTmw4ZWlWMUxDQTYrQ0lz?=
 =?utf-8?B?ZUFTNkdsKzdGZEYyRTEwWS84NEF4eUhHNUZRTEphUU9QU255cHBSc0twUDBG?=
 =?utf-8?B?RWpzNWI1dllVemRDSGJBODVUNUVuQ3Nxb1dtRFdlMXJMV1QxbHBsQmFPam82?=
 =?utf-8?B?RjEwUHYyNXk5QVV1K25Lc0NXRnRMTnBkcFhoNGV3RTdOS0Y2Q3A0Zm9OY1Yx?=
 =?utf-8?B?eTRjUnVVOUhCSm5Vc0tGbS9ndzg3YVNmNENuSDVyVWkzRU9oMTBoYjBja0Ri?=
 =?utf-8?B?bjUySDN2NDEyTUdReWFDK2lTYXFSUXFzMEo2Wm9CSDVNbVdOWE9TdVJLeW53?=
 =?utf-8?B?eHVOYWNQWVp4T2NFSlVoR1hVSUNTSmZUbitmYkE5d3FET1JmQThUZGx5ZnUz?=
 =?utf-8?B?MVFTa25IQWh4djNQVHk2dGpBcCsyRlJYeStqQXZHZFRLVzFkQ1MxV3ExdmRZ?=
 =?utf-8?B?OTIxUHUzMmV2NzNBdWU1Q1hmL0pMSWRSM2RTTEx4dTY0cmxDUFR4SWVtTFEw?=
 =?utf-8?B?T2dZbnpTeFh1YjZERnJqbTFOSm1WUm9UUVBYUitqc1FvM2lBQ2hBcWpyUk9h?=
 =?utf-8?B?VFh4RmVvbDh6cjhMVVRnZ1FaaGxNK3VwLy9FTDBIZFRKaUdUdHdTMS9ROVJq?=
 =?utf-8?B?MXlVUEJ3NFhLUjlwN2NFcDQ4Z0hWN0NqdW5iR1FjeWp3WHhHdHpTWDI2RFpa?=
 =?utf-8?B?bm5JTzJIVTFYQWtvMkthTWQ0YjE2S2d5bzd2c2VWOWcwVmdyL21TbzBiaFFX?=
 =?utf-8?B?eCsrNGZjU0JueFBPVjJZakx2Nm1SZnM5eUVlS2doOVhkTW9pOG9IOG4zVlBU?=
 =?utf-8?B?M2hYTFV4NVJaRXJhTkVzS0ozS3E3cXpQQUJIRk1OOXdiR2NyNHRPd2pjbjNN?=
 =?utf-8?B?bndnWG12bmR2WU1maTEvU0FwYmhqUEVTNVlyWFdPY1pnakVWcGNKdFcxeEZI?=
 =?utf-8?B?UHR5UFlBOE53aCthMy9IVTROOWIzYVUvS2pxdXJlNWNybWJNVG9TZFo3OTgz?=
 =?utf-8?B?OVNrdEkyZFhMNlJKMzN6N08xaWpyMEQwTDFvbnpyMmhzenMrOTExZEdSY1Uz?=
 =?utf-8?B?WUZIUlEzSGZneVExOElWQWNDTmJxblBZc2JyNTV5dEl2alRsWjRNZTUzVkFQ?=
 =?utf-8?B?cnB4cUVTWUd3WmhJQmtCZ25EMUJxaEJJa1NBallIVDNLS0txeGpyL1ZrQnhM?=
 =?utf-8?B?bldnYnY1SEk4QXFUaDVzRCtlZUhJcHhFaU1DWHA1UmtOa0dwS1Ava1pmd3FC?=
 =?utf-8?B?ckNuRnMvYWhEVnlrUS85dlRibEkycFR6Q0JHZ1FnS1ZRM0xBMERuejhhVjBw?=
 =?utf-8?Q?XW+GJPAHdS13bBKX7ZO0gLk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aXw6jQ1m33PgcYa5UvIETLEhQfc7GxxqwqHYbIA7LkkS+X3WpW20OmUqAEhsV43/4wIgKVYvK0tyPr9pD+flBfnHUVOacNMeX27WbvNvc5flvzpZwm/fQlO11ThX3WLIZ8iE3zyLxxfAIL5lUaO/YRKcdluP1D2dSTVbZKSQ6plr5tQGbZkJh0LUPoy+nPNrgNQby14la1c/IKk3kf8ohGnxXE98qSViHncedN6i0euYSWdOjnsm4JqI4broZAemsp/ILYf7g2AJ2nt0otQyTD8ru6CmBlVQnXnGrTLaxYimVbUEBvRlWtCacgk9M8fbjtPqD8CNtPYLaplY/mjXO9h45W5ArrZsIZILjnRjisw/Kjo9XlWf+rNodw+QK6hZsDp8oVmOow/oUqPxVtybrp0scQqAcargE88tN+ACzMpG3gcNZRKxqtdTSa9flM/CkoeWxMrRlCDtIACb28CsOtk9UYwCaVsaxSIsCk89er55toAsYgZF/JQIuPOzhIbFuOBMVkbD1bb8ocUFAk9HpN5e4yO8otguUwPDbl91dQP3/rnjSj8GNnFg9vWpsDqbedIMaUwDePUT3zrKMEU5/dLF339DKRExAhQka9yv/m8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e262a7fc-88dc-4710-2777-08dcb0938d4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 12:31:35.9075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4dJ1nIPp6szkNUDFFRPras5NvN4Y1Mz1lNug8u9F8bMjh/vSZOKZ58aPafeAqO1OOushcW3uOTCCJKC2QvYOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407300087
X-Proofpoint-GUID: rtkgUavtZIT7L2-iL-0JBa406DAzm-V1
X-Proofpoint-ORIG-GUID: rtkgUavtZIT7L2-iL-0JBa406DAzm-V1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/30/24 7:00 AM, Eugenio Perez Martin wrote:
> On Tue, Jul 30, 2024 at 10:48 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Mon, Jul 29, 2024 at 6:05 PM Eugenio Perez Martin
>> <eperezma@redhat.com> wrote:
>>>
>>> On Wed, Jul 24, 2024 at 7:00 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>>
>>>>
>>>> On 5/13/24 11:56 PM, Jason Wang wrote:
>>>>> On Mon, May 13, 2024 at 5:58 PM Eugenio Perez Martin
>>>>> <eperezma@redhat.com> wrote:
>>>>>>
>>>>>> On Mon, May 13, 2024 at 10:28 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>
>>>>>>> On Mon, May 13, 2024 at 2:28 PM Eugenio Perez Martin
>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Sat, May 11, 2024 at 6:07 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On Fri, May 10, 2024 at 3:16 PM Eugenio Perez Martin
>>>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Fri, May 10, 2024 at 6:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Thu, May 9, 2024 at 3:10 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Thu, May 9, 2024 at 8:27 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Thu, May 9, 2024 at 1:16 AM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Wed, May 8, 2024 at 4:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Tue, May 7, 2024 at 6:57 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Tue, May 7, 2024 at 9:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 3:56 PM Eugenio Perez Martin
>>>>>>>>>>>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 8:47 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> On Wed, Apr 10, 2024 at 6:03 PM Eugenio Pérez <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> The guest may have overlapped memory regions, where different GPA leads
>>>>>>>>>>>>>>>>>>>> to the same HVA.  This causes a problem when overlapped regions
>>>>>>>>>>>>>>>>>>>> (different GPA but same translated HVA) exists in the tree, as looking
>>>>>>>>>>>>>>>>>>>> them by HVA will return them twice.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> I think I don't understand if there's any side effect for shadow virtqueue?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> My bad, I totally forgot to put a reference to where this comes from.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Si-Wei found that during initialization this sequences of maps /
>>>>>>>>>>>>>>>>>> unmaps happens [1]:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> HVA                    GPA                IOVA
>>>>>>>>>>>>>>>>>> -------------------------------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>> Map
>>>>>>>>>>>>>>>>>> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000)
>>>>>>>>>>>>>>>>>> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
>>>>>>>>>>>>>>>>>> [0x80001000, 0x2000001000)
>>>>>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
>>>>>>>>>>>>>>>>>> [0x2000001000, 0x2000021000)
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Unmap
>>>>>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
>>>>>>>>>>>>>>>>>> 0x20000) ???
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> The third HVA range is contained in the first one, but exposed under a
>>>>>>>>>>>>>>>>>> different GVA (aliased). This is not "flattened" by QEMU, as GPA does
>>>>>>>>>>>>>>>>>> not overlap, only HVA.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> At the third chunk unmap, the current algorithm finds the first chunk,
>>>>>>>>>>>>>>>>>> not the second one. This series is the way to tell the difference at
>>>>>>>>>>>>>>>>>> unmap time.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> [1] https://urldefense.com/v3/__https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.html__;!!ACWV5N9M2RV99hQ!MXbGSFHVbqRf0rzyWamOdnBLHP0FUh3r3BnTvGe6Mn5VzXTsajVp3BB7VqlklkRCr5aKazC5xxTCScuR_BY$
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Ok, I was wondering if we need to store GPA(GIOVA) to HVA mappings in
>>>>>>>>>>>>>>>>> the iova tree to solve this issue completely. Then there won't be
>>>>>>>>>>>>>>>>> aliasing issues.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I'm ok to explore that route but this has another problem. Both SVQ
>>>>>>>>>>>>>>>> vrings and CVQ buffers also need to be addressable by VhostIOVATree,
>>>>>>>>>>>>>>>> and they do not have GPA.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> At this moment vhost_svq_translate_addr is able to handle this
>>>>>>>>>>>>>>>> transparently as we translate vaddr to SVQ IOVA. How can we store
>>>>>>>>>>>>>>>> these new entries? Maybe a (hwaddr)-1 GPA to signal it has no GPA and
>>>>>>>>>>>>>>>> then a list to go through other entries (SVQ vaddr and CVQ buffers).
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> This seems to be tricky.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> As discussed, it could be another iova tree.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Yes but there are many ways to add another IOVATree. Let me expand & recap.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Option 1 is to simply add another iova tree to VhostShadowVirtqueue.
>>>>>>>>>>>>>> Let's call it gpa_iova_tree, as opposed to the current iova_tree that
>>>>>>>>>>>>>> translates from vaddr to SVQ IOVA. To know which one to use is easy at
>>>>>>>>>>>>>> adding or removing, like in the memory listener, but how to know at
>>>>>>>>>>>>>> vhost_svq_translate_addr?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Then we won't use virtqueue_pop() at all, we need a SVQ version of
>>>>>>>>>>>>> virtqueue_pop() to translate GPA to SVQ IOVA directly?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> The problem is not virtqueue_pop, that's out of the
>>>>>>>>>>>> vhost_svq_translate_addr. The problem is the need of adding
>>>>>>>>>>>> conditionals / complexity in all the callers of
>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The easiest way for me is to rely on memory_region_from_host(). When
>>>>>>>>>>>>>> vaddr is from the guest, it returns a valid MemoryRegion. When it is
>>>>>>>>>>>>>> not, it returns NULL. I'm not sure if this is a valid use case, it
>>>>>>>>>>>>>> just worked in my tests so far.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Now we have the second problem: The GPA values of the regions of the
>>>>>>>>>>>>>> two IOVA tree must be unique. We need to be able to find unallocated
>>>>>>>>>>>>>> regions in SVQ IOVA. At this moment there is only one IOVATree, so
>>>>>>>>>>>>>> this is done easily by vhost_iova_tree_map_alloc. But it is very
>>>>>>>>>>>>>> complicated with two trees.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Would it be simpler if we decouple the IOVA allocator? For example, we
>>>>>>>>>>>>> can have a dedicated gtree to track the allocated IOVA ranges. It is
>>>>>>>>>>>>> shared by both
>>>>>>>>>>>>>
>>>>>>>>>>>>> 1) Guest memory (GPA)
>>>>>>>>>>>>> 2) SVQ virtqueue and buffers
>>>>>>>>>>>>>
>>>>>>>>>>>>> And another gtree to track the GPA to IOVA.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The SVQ code could use either
>>>>>>>>>>>>>
>>>>>>>>>>>>> 1) one linear mappings that contains both SVQ virtqueue and buffers
>>>>>>>>>>>>>
>>>>>>>>>>>>> or
>>>>>>>>>>>>>
>>>>>>>>>>>>> 2) dynamic IOVA allocation/deallocation helpers
>>>>>>>>>>>>>
>>>>>>>>>>>>> So we don't actually need the third gtree for SVQ HVA -> SVQ IOVA?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> That's possible, but that scatters the IOVA handling code instead of
>>>>>>>>>>>> keeping it self-contained in VhostIOVATree.
>>>>>>>>>>>
>>>>>>>>>>> To me, the IOVA range/allocation is orthogonal to how IOVA is used.
>>>>>>>>>>>
>>>>>>>>>>> An example is the iova allocator in the kernel.
>>>>>>>>>>>
>>>>>>>>>>> Note that there's an even simpler IOVA "allocator" in NVME passthrough
>>>>>>>>>>> code, not sure it is useful here though (haven't had a deep look at
>>>>>>>>>>> that).
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I don't know enough about them to have an opinion. I keep seeing the
>>>>>>>>>> drawback of needing to synchronize both allocation & adding in all the
>>>>>>>>>> places we want to modify the IOVATree. At this moment, these are the
>>>>>>>>>> vhost-vdpa memory listener, the SVQ vring creation and removal, and
>>>>>>>>>> net CVQ buffers. But it may be more in the future.
>>>>>>>>>>
>>>>>>>>>> What are the advantages of keeping these separated that justifies
>>>>>>>>>> needing to synchronize in all these places, compared with keeping them
>>>>>>>>>> synchronized in VhostIOVATree?
>>>>>>>>>
>>>>>>>>> It doesn't need to be synchronized.
>>>>>>>>>
>>>>>>>>> Assuming guest and SVQ shares IOVA range. IOVA only needs to track
>>>>>>>>> which part of the range has been used.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Not sure if I follow, that is what I mean with "synchronized".
>>>>>>>
>>>>>>> Oh right.
>>>>>>>
>>>>>>>>
>>>>>>>>> This simplifies things, we can store GPA->IOVA mappings and SVQ ->
>>>>>>>>> IOVA mappings separately.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Sorry, I still cannot see the whole picture :).
>>>>>>>>
>>>>>>>> Let's assume we have all the GPA mapped to specific IOVA regions, so
>>>>>>>> we have the first IOVA tree (GPA -> IOVA) filled. Now we enable SVQ
>>>>>>>> because of the migration. How can we know where we can place SVQ
>>>>>>>> vrings without having them synchronized?
>>>>>>>
>>>>>>> Just allocating a new IOVA range for SVQ?
>>>>>>>
>>>>>>>>
>>>>>>>> At this moment we're using a tree. The tree nature of the current SVQ
>>>>>>>> IOVA -> VA makes all nodes ordered so it is more or less easy to look
>>>>>>>> for holes.
>>>>>>>
>>>>>>> Yes, iova allocate could still be implemented via a tree.
>>>>>>>
>>>>>>>>
>>>>>>>> Now your proposal uses the SVQ IOVA as tree values. Should we iterate
>>>>>>>> over all of them, order them, of the two trees, and then look for
>>>>>>>> holes there?
>>>>>>>
>>>>>>> Let me clarify, correct me if I was wrong:
>>>>>>>
>>>>>>> 1) IOVA allocator is still implemented via a tree, we just don't need
>>>>>>> to store how the IOVA is used
>>>>>>> 2) A dedicated GPA -> IOVA tree, updated via listeners and is used in
>>>>>>> the datapath SVQ translation
>>>>>>> 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
>>>>>>>
>>>>>>
>>>>>> Ok, so the part I was missing is that now we have 3 whole trees, with
>>>>>> somehow redundant information :).
>>>>>
>>>>> Somehow, it decouples the IOVA usage out of the IOVA allocator. This
>>>>> might be simple as guests and SVQ may try to share a single IOVA
>>>>> address space.
>>>>>
>>>>
>>>> I'm working on implementing your three suggestions above but I'm a bit
>>>> confused with some of the wording and I was hoping you could clarify
>>>> some of it for me when you get the chance.
>>>>
>>>> ---
>>>> For your first suggestion (1) you mention decoupling the IOVA allocator
>>>> and "don't need to store how the IOVA is used."
>>>>
>>>> By this, do you mean to not save the IOVA->HVA mapping and instead only
>>>> save the allocated IOVA ranges?
>>
>> Yes.
>>
>>>> In other words, are you suggesting to
>>>> create a dedicated "IOVA->IOVA" tree like:
>>>>
>>>> struct VhostIOVATree {
>>>>       uint64_t iova_first;
>>>>       uint64_t iova_last;
>>>>       IOVATree *iova_map;
>>>> };
>>
>> It could be this or other. I think the point is the allocator is only
>> used for IOVA allocation but it doesn't have any information about the
>> mapping.
>>
>>>>
>>>> Where the mapping might look something like (where translated_addr is
>>>> given some kind of 0 value):
>>>>
>>>> iova_region = (DMAMap) {
>>>>       .iova = iova_first,
>>>>       .translated_addr = 0,
>>>>       .size = region_size - 1,
>>>>       .perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>> };
>>>>
>>>> Also, if this is what you mean by decoupling the IOVA allocator, what
>>>> happens to the IOVA->HVA tree?
>>
>> We will have two structures:
>>
>> 1) IOVA domain (in charge of IOVA range allocation/deallocation)
>> 2) How the IOVA is used, e.g an IOVA->HVA tree
>>
>>> Are we no longer saving these mappings in
>>>> a tree?
>>>>
>>>> ---
>>>> In your second suggestion (2) with a dedicated GPA->IOVA tree, were you
>>>> thinking something like this? Just adding on to VhostIOVATree here:
>>>>
>>>> struct VhostIOVATree {
>>>>       uint64_t iova_first;
>>>>       uint64_t iova_last;
>>>>       IOVATree *iova_map;
>>>>       IOVATree *gpa_map;
>>>> };
>>
>> I'd split the mappings if it's possible.
>>
>>>>
>>>> Where the mapping might look something like:
>>>>
>>>> gpa_region = (DMAMap) {
>>>>       .iova = iova_first,
>>>>       .translated_addr = gpa_first,
>>>>       .size = region_size - 1,
>>>>       .perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>> };
>>>>
>>>> Also, when you say "used in the datapath SVQ translation", we still need
>>>> to build the GPA->IOVA tree when vhost_vdpa_listener_region_add() is
>>>> called, right?
>>
>> Right.
>>
>>>>
>>>> ---
>>>> Lastly, in your third suggestion (3) you mention implementing a
>>>> SVQ->IOVA tree, making the total number of IOVATrees/GTrees 3: one for
>>>> just IOVAs, one for GPA->IOVA, and the last one for SVQ->IOVA. E.g.
>>>>
>>>> struct VhostIOVATree {
>>>>       uint64_t iova_first;
>>>>       uint64_t iova_last;
>>>>       IOVATree *iova_map;
>>>>       IOVATree *gpa_map;
>>>>       IOVATree *svq_map;
>>>> };
>>>>
>>>> ---
>>>>
>>>> Let me know if I'm understanding this correctly. If I am, this would
>>>> require a pretty good amount of refactoring on the IOVA allocation,
>>>> searching, destroying, etc. code to account for these new trees.
>>>>
>>>
>>> Ok I think I understand your previous question better, sorry for the delay :).
>>>
>>> If I'm not wrong, Jason did not enumerate these as alternatives but as
>>> part of the same solution. Jason please correct me if I'm wrong here.
>>>
>>> His solution is composed of three trees:
>>> 1) One for the IOVA allocations, so we know where to allocate new ranges
>>> 2) One of the GPA -> SVQ IOVA translations.
>>> 3) Another one for SVQ vrings translations.
>>>
>>
>> Exactly.
>>
>>> In my opinion to use GPA this is problematic as we force all of the
>>> callers to know if the address we want to translate comes from the
>>> guest or not. Current code does now know it, as
>>> vhost_svq_translate_addr is called to translate both buffer dataplane
>>> addresses and control virtqueue buffers, which are also shadowed.  To
>>> transmit that information to the caller code would require either
>>> duplicate functions, to add a boolean, etc, as it is in a different
>>> layer (net specific net/vhost-vdpa.c vs generic
>>> hw/virtio/vhost-shadow-virtqueue.c).
>>>
>>> In my opinion is easier to keep just two trees (or similar structs):
>>> 1) One for the IOVA allocations, so we know where to allocate new
>>> ranges. We don't actually need to store the translations here.
>>> 2) One for HVA -> SVQ IOVA translations.
>>>
>>> This way we can accommodate both SVQ vrings, CVQ buffers, and guest
>>> memory buffers, all on the second tree, and take care of the HVA
>>> duplications.
>>
>> Probably, but how to take care of HVA duplications (I may miss the
>> context, sorry)?
>>
> 
> What to do with the duplicated HVA is an added problem that deserves
> more discussion, right. If a duplicated entry gets deleted, the other
> one should take its place in both trees.
> 
> Store them in an ordered list and look for replacements on tree
> deletion maybe? It would be great to locate a similar usage and see
> what is done there.
> 

Isn't what we're doing here supposed to solve this issue of 
duplicated/overlapping HVA ranges?

>> Thanks
>>
>>>
>>> Thanks!
>>>
>>>> Thanks Jason!
>>>>
>>>>>>
>>>>>> In some sense this is simpler than trying to get all the information
>>>>>> from only two trees. On the bad side, all SVQ calls that allocate some
>>>>>> region need to remember to add to one of the two other threes. That is
>>>>>> what I mean by synchronized. But sure, we can go that way.
>>>>>
>>>>> Just a suggestion, if it turns out to complicate the issue, I'm fine
>>>>> to go the other way.
>>>>>
>>>>> Thanks
>>>>>
>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks!
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

