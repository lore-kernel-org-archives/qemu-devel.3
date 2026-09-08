Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAD8C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3y7k-0000mX-Bw; Tue, 08 Sep 2026 11:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3y7h-0000jM-QN
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:52:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1x3y7d-0008El-6J
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:52:37 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Eh6ir3514602; Tue, 8 Sep 2026 08:52:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=56WreGBft8lDEyBHYNsZvPU20/y4YVjn6WcAexfMa
 H8=; b=N2CmIAhYfvayqlgOVeCpGo72A2mU0JUO9kabdUVeP2QTTfKYdfqPKLrXh
 I9sE5zump0jNFCS4wr/bqz6/fW156Wtw/GtdqgWzn7JyDyfjFH96N23lvLzJKgc0
 swSj9yH8UifMBcUACdgMgGwjx78JFFL9/AysE8QyeC00aY81dqnrBcbHAktOH8Xy
 QCWkM1p81brTQLR5TIr69RU30vyArg1ux74S8lVvLWK0BRcKRKPIQglEuovnYtSK
 0GDRq8p0D3quwaV6z4/YOOsZ1aA8wcuu/S1akdrBno1ZrtcgSEWcIcnZQdKWpyRN
 1I6+HTPOfEZx2YssJT4oBrbXi1E2g==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021081.outbound.protection.outlook.com [52.101.62.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ggh6ex0sq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 08:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vICOc8gvqef2DNpuexuAZ1cXBBx/XGeLHghTCkhSD5GRNkysUT53o+tdKjDby9C1+GVbPIlpEM25pUIcP+kCc6xecQljK7hDe89rHvuifJrLEvR9rR5g/pphFDzxCejWb+kRr6cbzU2lZhUha/LatCFWD9pgMEkhJtJ1iFY3zCwTD8DX5geqGSxrUCFDrfcfiAaLQqDf0VChpXPkx7tI+EYQv/rykCWoNzKCQJ5H7iGTrM21pKrcWcjwy0T1v4yY5vVJlB5Wl70luM7zYPgASHOCb/817Uo+I5lJbvnEGL4RRKzc+tGFlvfriB0y70v8AvOyCoA6FejtLDGQFYfz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56WreGBft8lDEyBHYNsZvPU20/y4YVjn6WcAexfMaH8=;
 b=MlPymJVOtIhckPvaxGlCo40SwT6YdaCidkFBZCwT+HKNB/YvTXGGP3ZmD9EK58YevGxjX0f3z1gZ/zGLVGmW063P9XI1SMpg7ql83aNYrn+J3FbeOoEnnn+e1iDdF210Srtvu5LLXU6ad/lEqNoor1A3cMmPDvx8AcP+4VSPfH6j+LR/YRzM+PfwDkKYYKLH+Oif0W8eksTxsxMDAL6h7uV+lx4PanxGvkBvlbIjHvHIa/CU0BZ9wQGhY4j1adx/p4UOfFIpnD7FzRf15QSqTXT8ifQOgLAqDXBEHXUpGm2TCmTgj7D0dqwM1arAeGYvDdSWa8CVr1gyDWGcZefRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56WreGBft8lDEyBHYNsZvPU20/y4YVjn6WcAexfMaH8=;
 b=YNWU8LHobkhlFeofxzweEPYaClt8li1GAxuUydP5CoWKxZRd8r/zFPeB+HEdoy/jiYc5mOWr5tVwcN5b01hfHMj4nuMregnf+VnQKgcG04fJBIoDzXBD7YdSaON4eKpcZxWoDjY4gKlp8vrTfM6iBsIwhIEqObkTrMKK11Sq7JjHCOaWexT+4lE78kRVdTa4RGHSEO/CEgnOkMZD1AdbiqV59HEUvwl3xSePy5Tr6PZkQllCbh8i3yFnhOWu+LKqH/3Dufbd6R/4ElnXIoEOMZbV76y0RVdl7dXIxfWd9pJItNjMfKx6Kr1pf4OteuJytO0COqutgIaVLhz1YIFwNQ==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by BN0PR02MB8064.namprd02.prod.outlook.com (2603:10b6:408:149::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 15:52:25 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 15:52:25 +0000
From: David Vrabel <david.vrabel@nutanix.com>
To: David Vrabel <david.vrabel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: [PATCH v2 1/4] hw/pci-bridge: Add generic PCIe switch upstream and
 downstream ports
Thread-Topic: [PATCH v2 1/4] hw/pci-bridge: Add generic PCIe switch upstream
 and downstream ports
Thread-Index: AQHdP6oKoOxDpQhQrEW6ShZWnXVwPQ==
Date: Tue, 8 Sep 2026 15:52:25 +0000
Message-ID: <20260908155223.164787-2-david.vrabel@nutanix.com>
References: <20260908155223.164787-1-david.vrabel@nutanix.com>
In-Reply-To: <20260908155223.164787-1-david.vrabel@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR02MB8368:EE_|BN0PR02MB8064:EE_
x-ms-office365-filtering-correlation-id: 954a1c8f-2bf1-42c1-8c8a-08df0dc12dd3
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|13003099007|18002099003|22082099003|38070700021|3023799007|5023799004|56012099006|10067099003;
x-microsoft-antispam-message-info: Hdgddk99SPUVaQ9rrMDZef/Q8ehf7WJ/PcWTDi1kFfd43MXkOWqdkruR398Y0EhpaO058cqUGbfR4H7V5v4XjXi584MDpn+8wg/8cNh0j0OKGrUcZtP2N8cJeam+QzpDCB68Ov883+vBfjvv6m+ONmE9+KGA3HcvGYupiOklrT11Vyx+3/6IvneYVzoIjXqUH3gvGFEeE6T+Nbsw5VODMO5vFAPxC6LT9OAw2YHes4jgjdDaLmQ6bWtER8bXcfgVAtxgD/9ANek0EjGhy3TwvgDe0s/Xgotr0m3Nj1xuWv+ktfcc+8Os+PRwwOoM4Oi+uRiP6bGdFqGywBwNsQry4l74Qwy5+xeL6+P9m+n07CmBmBtf7IMHMk0MIWfer4yIAd+xsjr6MYdaUwLdwe3TsUcQsubTH4121xhnxu+MjGAfqrs7CSBUIPWIPHGZ4KLCV/jgxKzYTTGd6M7znmxUfR1ITbvpjRLWdPLtb1cy/2dE1X17SvslPvxqCuYL/EMPkNiZ2cMUwWW3wkthvgmenEaQpt5UzXutOtBF/+pVba5XwGKaWuwGQs2+RkDVSvxbYklA87KskN2f4IefMD50wWy4YsphqevLQhqOlaQtJiwC3an8tvv4DJYz3RKMtecdy8o40a/Clkfd1HqFFY3g/kng8OMVhdezmgCOF3QiQf4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(13003099007)(18002099003)(22082099003)(38070700021)(3023799007)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v4jqV+WW3QoJgDLxfd9kFNO7/cDOCzilFmCRMWozodG2PNXRImtanJUSI7?=
 =?iso-8859-1?Q?T7R9a/97dJYxub5SoN3ZPq7jXUCowWB9EUwj0L+26lphxfiBDmNFWjO4Fc?=
 =?iso-8859-1?Q?8LeyEHzbyNbtyhAxBj8V5LLn4zZpfqgAgk5VplTBrvmZiZEjkhinAN3Ms8?=
 =?iso-8859-1?Q?Il2TLpZFDZ37s8warmPFvvhKT3+3hlz8DKZ2fKTcMXMf6//Au+r/3vNOlI?=
 =?iso-8859-1?Q?dEbi58GQ43Mam49xR0DCEbIS1Bkf7KcRTSLwxtQFF0Z/G1acDSI0G7Rp8g?=
 =?iso-8859-1?Q?j/V9kFyPss7Cx5bAJ/Qy7YdmI9w9Mc9uz6LBdWVWVHD1FgjgatZyPlbQ0E?=
 =?iso-8859-1?Q?4InHPhvYJLMSQiNP4o24cEt4mttLVcHEYXrJKzoLGZUTXs0/2+Le9iH3AH?=
 =?iso-8859-1?Q?ubaKiLDq2+rfInyWv206h/CU9sA2VHrk5Us3WDopeym2vqsIFD129pV0bu?=
 =?iso-8859-1?Q?dxKc3D+sDyRkHy+AfZ9WNEMNWGyL1LrqFkPI9GeqYnShigcv4I7lx3gv9/?=
 =?iso-8859-1?Q?54ratCCpOV7LmdB1KO1EDH/eugOUwP/G8KVepQkRn/xTRQyq/F0k1IDdfE?=
 =?iso-8859-1?Q?ox2f/vQ7HPHpeHau0knilI/J7SET02bboEhP1NXjR6/QwOvGaSKEwFp+S3?=
 =?iso-8859-1?Q?RrlPfeybIqBKAa49pUWFwdHc35hQ67Jhh+OnSG8Kyt4aJQavFdSyX7LFhz?=
 =?iso-8859-1?Q?Ff1y+s3/0AQ90BFxGf1CxDbUO7xLvWBspCC+u9nLNRtJykPnKFIOOLgfnJ?=
 =?iso-8859-1?Q?0tjWEyzSfK2rvMxBjQixFWtd4VFuArhh4SnFpSfcAY/mWb3zDXb2rJ3ifj?=
 =?iso-8859-1?Q?FmBtVqrGn3xtcz29VmNXeAleDGw7Kw5153XwBypukHtohDmv0E6Kq/r21S?=
 =?iso-8859-1?Q?gVswmwdC8gNfWEskMbTegUGDPD5RXCg/ba2smXD1vgTWy9bBQKFZcIVxYl?=
 =?iso-8859-1?Q?Q+9uKEeTOSG3n++AgIe6EL8Qh9LIfMgsUnBldW9osIH7qA/BF+aBpj3txG?=
 =?iso-8859-1?Q?Rtl5niYVn27XHfC7PAwsaTzTAiuSWC72/dsa5gGEKGhQBEV3DukdnBygao?=
 =?iso-8859-1?Q?90dASIh8ogr4RaKQ47CkEv/jBZM9Ro8fu/Fw8gl6ujbv2AFqFwD4kbPar4?=
 =?iso-8859-1?Q?4mZEWZ9cpHLDfeBzfGSQZt00DHG/RgyqRd6YAhrQS4sdfLceYyyqjvb9oP?=
 =?iso-8859-1?Q?4Y9C6pXv8C8nCVlGZ6iVD4zUsP2s4D8wbgj6nlpVsE0shE0OTd/PnqDijW?=
 =?iso-8859-1?Q?EBP1gwffkdpCWZMKdxriYRNnPhFPH4JkxUKoZJrnNX3ZxBQc//tlzNe9tG?=
 =?iso-8859-1?Q?Wi8XTivZUaPnoaMtYiX3Ij1PQn4tURa/WpWuTcQlQnAbMgtwYiWdkkQZKA?=
 =?iso-8859-1?Q?+FRg+r4nUNIQLMaT734VuXBj0d51I7/6y+IOck/21Qr2VJLNbbD50fUsM6?=
 =?iso-8859-1?Q?o6H2vm7gXiH1i5usfONCZmFq5FqGIgOKWDvSl1tXOQNxHbCzrlUame4lJT?=
 =?iso-8859-1?Q?9AmEbn98sHhyIM2D8ez2Gxf4bdeIN/nV4aX6afPY9DiZDhLnMLN3Yjk+sG?=
 =?iso-8859-1?Q?SZxw6fJdrQj/L4xnopibFoJcTYD3Io1Nuh8pu/EDhRwzaiIS/orWz8TaIC?=
 =?iso-8859-1?Q?2aM/3kSf0RXr6nASih2h1NDBet5uz3wYAMnmu+u6qbrdhuB/cXZzPwLxxd?=
 =?iso-8859-1?Q?MhlNpuLzf67TAZ7STDNmTHQrM8Az5IkX3WzrGFiJ5Z1jzRpTjJ7KJ44uXe?=
 =?iso-8859-1?Q?ZjkHea7Ovt8nBPIhi1iDJikrc0AYXK5a3nOKLYHs2iXN//C9j/iKevIGCp?=
 =?iso-8859-1?Q?CmpMruNfSG85uun5IRGCwttUrsyesUk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b5tjxscYBnplcpIB1eOWu5P6Ue5RWjN2gL7UD9b2aYUdkjYwaku2ezMbbnb9QKyNA/DpTEF8Y+B7XWnKLMxglcxvm0C1WIkeEY5EyIK9OG3yJO2vNXQMhpdRAcORFcvbgQnQIGeCXecUXU7uG+6v4lqwqzFpHLa4R5Lk+VkRfTtdtgEm+wx6mYk/Ef/ATV4y8lDVYOPbWBOi8bkVPsWO/f1ipsuwXKf1ZivArVInsDIkanBeE3wAyjEc7OJ8KEYYy+yoBFNUpBXZOZEpPYQyFV7cmfzOT//CBFvc4XL4ch5iyJ1KfsgP9aISWsFqFfhkFVT04jvRfyVJWW8/n8VG8g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954a1c8f-2bf1-42c1-8c8a-08df0dc12dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 15:52:25.1538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VD7q+dv4DS+ZyaBqD4nGIyh+ED75eaNfMg9XHaLIJZHp9vAAY8g4ALCq1/h+rBtHwCi8C2TPSGIRhmcOoLwp1AWcYqq6sAVZfriMuX9Yjv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8064
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3MSBTYWx0ZWRfXxupdC4mjtPKb
 VI/k05UJ76D2mF1yOBxIRZi6E8o7i2VNQecxFhhHPOS2WzbnYf+lwP3+pZmHCIrms/cMjlgBwnj
 JOwnhjR85s+D5BJQVvXWMxBxywclEzdjEyDIPbZOju/Dwfoy+tAqeE5BEbYbe/UBMVyRKnVwplv
 bOz8P8LS/dCDRrGA9mQ07/OHD9JBqCaympWblqRD1CmMx4Kob6/Iapeiaq1Q2kplaKLhu040QCA
 ltAu/PxtgcdaYijLI+Y/+9izFbZfQ8D6pRf9B86Od5n+jYT7pZd+BWrq3x+hb26JBf9Eij9Ni0f
 hFvprWxGSU0YmvCbuLuzh7rGbfL2kfkaPepSy3cKhX02Iz84t43plilhT/RoMRDyL4R1WnFhh8h
 wpAoCGbAS3WB23/DdFLYqsFYS2qu496qfumdfy94M2j7GrB11aihUPmXn4WW5MMMcQr9xRTkbM6
 ppNgcX8Ba1gB7d6sFBw==
X-Authority-Analysis: v=2.4 cv=I4hVgtgg c=1 sm=1 tr=0 ts=6aa02f3b cx=c_pps
 a=7ywGlyDdJUFJDTdbuALIzQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22 a=vTr9H3xdAAAA:8
 a=64Cc0HZtAAAA:8 a=59scvrWWz1I71DQtTbwA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: bLvtBPxt38ZXQMrQ6tY_PnJ2fNMCZLSw
X-Proofpoint-GUID: bLvtBPxt38ZXQMrQ6tY_PnJ2fNMCZLSw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3MSBTYWx0ZWRfXzURoDnT8gPfY
 8qbJv7YPsd+1nyNAz8pxIm+u4oOLXZxVjnuJpjyIMfZe9YzHkvmrEuPw1MJ2CZCsHyeNbDhA0yt
 2YRkGDF40pJ0L+i6zVm3y8z0HJLNbTM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=david.vrabel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The TI XIO3130 PCIe switch is a vintage Gen1 device, so we add generic=0A=
PCIe upstream and downstream port devices that are Gen6.=0A=
=0A=
In guests with pairs of passthrough PCIe devices (e.g, a GPU+NIC pair)=0A=
often need to place the devices behind a common (emulated) PCIe switch=0A=
so in-guest software (such as NCCL) can correctly determine that P2P=0A=
transactions between the devices is possible.=0A=
=0A=
NCCL also needs to be able to determine the available PCIe=0A=
bandwidth. If such a guest sees the TI XIO3130 PCIe switch, then it=0A=
incorrectly calculates only 2.5 GT/s and x1 is available, but the real=0A=
hardware might be 32 GT/s and x16.=0A=
=0A=
Instead of enhancing the existing switch and claiming it is more=0A=
capable than the real hardware we add additional generic PCIe upstream=0A=
and downstream port devices, which matches the existing generic PCIe=0A=
root port device.=0A=
=0A=
Signed-off-by: David Vrabel <david.vrabel@nutanix.com>=0A=
---=0A=
=0A=
The device IDs are placeholders and will need to be properly allocated=0A=
from the 0x1b36 (Red Hat, Inc.) vendor ID space.=0A=
---=0A=
 docs/pcie.txt                               |   6 +-=0A=
 hw/pci-bridge/gen_pcie_downstream_port.c    | 206 ++++++++++++++++++++=0A=
 hw/pci-bridge/gen_pcie_upstream_port.c      | 182 +++++++++++++++++=0A=
 hw/pci-bridge/meson.build                   |   3 +-=0A=
 tests/functional/x86_64/meson.build         |   1 +=0A=
 tests/functional/x86_64/test_pcie_switch.py |  98 ++++++++++=0A=
 6 files changed, 492 insertions(+), 4 deletions(-)=0A=
 create mode 100644 hw/pci-bridge/gen_pcie_downstream_port.c=0A=
 create mode 100644 hw/pci-bridge/gen_pcie_upstream_port.c=0A=
 create mode 100755 tests/functional/x86_64/test_pcie_switch.py=0A=
=0A=
diff --git a/docs/pcie.txt b/docs/pcie.txt=0A=
index df49178311..f12a9daaad 100644=0A=
--- a/docs/pcie.txt=0A=
+++ b/docs/pcie.txt=0A=
@@ -85,7 +85,7 @@ number of PCI Express Root Ports per PCI Express Root Bus=
 is 256.=0A=
 =0A=
 Prefer grouping PCI Express Root Ports into multi-function devices=0A=
 to keep a simple flat hierarchy that is enough for most scenarios.=0A=
-Only use PCI Express Switches (x3130-upstream, xio3130-downstream)=0A=
+Only use PCI Express Switches (pcie-upstream-port, pcie-downstream-port)=
=0A=
 if there is no more room for PCI Express Root Ports.=0A=
 Please see section 4. for further justifications.=0A=
 =0A=
@@ -120,8 +120,8 @@ Plug only PCI Express devices into PCI Express Ports.=
=0A=
       -device pcie-root-port,id=3Droot_port3,chassis=3Dx2,addr=3Dz.2[,slot=
=3Dy2][,bus=3Dpcie.0] \=0A=
 2.2.3 Plugging a PCI Express device into a Switch:=0A=
       -device pcie-root-port,id=3Droot_port1,chassis=3Dx,slot=3Dy[,bus=3Dp=
cie.0][,addr=3Dz]  \=0A=
-      -device x3130-upstream,id=3Dupstream_port1,bus=3Droot_port1[,addr=3D=
x]          \=0A=
-      -device xio3130-downstream,id=3Ddownstream_port1,bus=3Dupstream_port=
1,chassis=3Dx1,slot=3Dy1[,addr=3Dz1]] \=0A=
+      -device pcie-upstream-port,id=3Dupstream_port1,bus=3Droot_port1[,add=
r=3Dx]          \=0A=
+      -device pcie-downstream-port,id=3Ddownstream_port1,bus=3Dupstream_po=
rt1,chassis=3Dx1,slot=3Dy1[,addr=3Dz1]] \=0A=
       -device <dev>,bus=3Ddownstream_port1=0A=
 =0A=
 Notes:=0A=
diff --git a/hw/pci-bridge/gen_pcie_downstream_port.c b/hw/pci-bridge/gen_p=
cie_downstream_port.c=0A=
new file mode 100644=0A=
index 0000000000..d593846ac1=0A=
--- /dev/null=0A=
+++ b/hw/pci-bridge/gen_pcie_downstream_port.c=0A=
@@ -0,0 +1,206 @@=0A=
+/*=0A=
+ * Generic PCI Express Downstream Port emulation=0A=
+ *=0A=
+ * Copyright (C) 2026 Nutanix, Inc.=0A=
+ *=0A=
+ * Derived from gen_pcie_root_port.c:=0A=
+ *   Copyright (C) 2017 Red Hat Inc=0A=
+ *=0A=
+ * Derived from xio3130_downstream.c:=0A=
+ *   Copyright (c) 2010 Isaku Yamahata <yamahata at valinux co jp>=0A=
+ *                       VA Linux Systems Japan K.K.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+#include "hw/pci/msix.h"=0A=
+#include "hw/pci/pcie.h"=0A=
+#include "hw/pci/pcie_port.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/qdev-properties-system.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_GEN_PCIE_DOWNSTREAM_PORT            "pcie-downstream-port"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(GenPCIEDownstreamPort, GEN_PCIE_DOWNSTREAM_PORT=
)=0A=
+=0A=
+#define GEN_PCIE_DOWNSTREAM_PORT_VENDOR_ID       0x1b36=0A=
+#define GEN_PCIE_DOWNSTREAM_PORT_DEVICE_ID       0x0016=0A=
+=0A=
+#define GEN_PCIE_DOWNSTREAM_PORT_AER_OFFSET      0x100=0A=
+#define GEN_PCIE_DOWNSTREAM_PORT_ACS_OFFSET \=0A=
+    (GEN_PCIE_DOWNSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)=0A=
+#define GEN_PCIE_DOWNSTREAM_PORT_MSIX_NR_VECTOR  1=0A=
+=0A=
+struct GenPCIEDownstreamPort {=0A=
+    /*< private >*/=0A=
+    PCIESlot parent_obj;=0A=
+    /*< public >*/=0A=
+};=0A=
+=0A=
+static int gen_downstream_interrupts_init(PCIDevice *d, Error **errp)=0A=
+{=0A=
+    int rc;=0A=
+=0A=
+    rc =3D msix_init_exclusive_bar(d, GEN_PCIE_DOWNSTREAM_PORT_MSIX_NR_VEC=
TOR,=0A=
+                                 0, errp);=0A=
+    if (rc < 0) {=0A=
+        assert(rc =3D=3D -ENOTSUP);=0A=
+    } else {=0A=
+        msix_vector_use(d, 0);=0A=
+    }=0A=
+=0A=
+    return rc;=0A=
+}=0A=
+=0A=
+static void gen_downstream_interrupts_uninit(PCIDevice *d)=0A=
+{=0A=
+    msix_uninit_exclusive_bar(d);=0A=
+}=0A=
+=0A=
+static void gen_downstream_write_config(PCIDevice *d, uint32_t address,=0A=
+                                        uint32_t val, int len)=0A=
+{=0A=
+    uint16_t slt_ctl, slt_sta;=0A=
+=0A=
+    pcie_cap_slot_get(d, &slt_ctl, &slt_sta);=0A=
+    pci_bridge_write_config(d, address, val, len);=0A=
+    pcie_cap_flr_write_config(d, address, val, len);=0A=
+    pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);=0A=
+    pcie_aer_write_config(d, address, val, len);=0A=
+}=0A=
+=0A=
+static void gen_downstream_reset(DeviceState *qdev)=0A=
+{=0A=
+    PCIDevice *d =3D PCI_DEVICE(qdev);=0A=
+=0A=
+    pcie_cap_deverr_reset(d);=0A=
+    pcie_cap_slot_reset(d);=0A=
+    pcie_cap_arifwd_reset(d);=0A=
+    pci_bridge_reset(qdev);=0A=
+}=0A=
+=0A=
+static void gen_downstream_realize(PCIDevice *d, Error **errp)=0A=
+{=0A=
+    PCIEPort *p =3D PCIE_PORT(d);=0A=
+    PCIESlot *s =3D PCIE_SLOT(d);=0A=
+    int rc;=0A=
+=0A=
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);=0A=
+    pcie_port_init_reg(d);=0A=
+=0A=
+    rc =3D gen_downstream_interrupts_init(d, errp);=0A=
+    if (rc < 0) {=0A=
+        goto err_bridge;=0A=
+    }=0A=
+=0A=
+    rc =3D pcie_cap_init(d, 0x90, PCI_EXP_TYPE_DOWNSTREAM, p->port, errp);=
=0A=
+    if (rc < 0) {=0A=
+        goto err_int;=0A=
+    }=0A=
+    pcie_cap_flr_init(d);=0A=
+    pcie_cap_deverr_init(d);=0A=
+    pcie_cap_slot_init(d, s);=0A=
+    pcie_cap_arifwd_init(d);=0A=
+=0A=
+    pcie_chassis_create(s->chassis);=0A=
+    rc =3D pcie_chassis_add_slot(s);=0A=
+    if (rc < 0) {=0A=
+        error_setg(errp, "Can't add chassis slot, error %d", rc);=0A=
+        goto err_cap;=0A=
+    }=0A=
+=0A=
+    rc =3D pcie_aer_init(d, PCI_ERR_VER, GEN_PCIE_DOWNSTREAM_PORT_AER_OFFS=
ET,=0A=
+                       PCI_ERR_SIZEOF, errp);=0A=
+    if (rc < 0) {=0A=
+        goto err_chassis;=0A=
+    }=0A=
+=0A=
+    pcie_acs_init(d, GEN_PCIE_DOWNSTREAM_PORT_ACS_OFFSET);=0A=
+=0A=
+    return;=0A=
+=0A=
+err_chassis:=0A=
+    pcie_chassis_del_slot(s);=0A=
+err_cap:=0A=
+    pcie_cap_exit(d);=0A=
+err_int:=0A=
+    gen_downstream_interrupts_uninit(d);=0A=
+err_bridge:=0A=
+    pci_bridge_exitfn(d);=0A=
+}=0A=
+=0A=
+static void gen_downstream_exitfn(PCIDevice *d)=0A=
+{=0A=
+    PCIESlot *s =3D PCIE_SLOT(d);=0A=
+=0A=
+    pcie_aer_exit(d);=0A=
+    pcie_chassis_del_slot(s);=0A=
+    pcie_cap_exit(d);=0A=
+    gen_downstream_interrupts_uninit(d);=0A=
+    pci_bridge_exitfn(d);=0A=
+}=0A=
+=0A=
+static const VMStateDescription vmstate_gen_pcie_downstream_port =3D {=0A=
+    .name =3D "pcie-downstream-port",=0A=
+    .priority =3D MIG_PRI_PCI_BUS,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .post_load =3D pcie_cap_slot_post_load,=0A=
+    .fields =3D (const VMStateField[]) {=0A=
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),=0A=
+        VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,=0A=
+                       PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),=0A=
+        VMSTATE_MSIX(parent_obj.parent_obj.parent_obj.parent_obj,=0A=
+                     GenPCIEDownstreamPort),=0A=
+        VMSTATE_END_OF_LIST()=0A=
+    }=0A=
+};=0A=
+=0A=
+static const Property gen_pcie_downstream_port_props[] =3D {=0A=
+    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,=0A=
+                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),=0A=
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,=0A=
+                                speed, PCIE_LINK_SPEED_64),=0A=
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,=0A=
+                                width, PCIE_LINK_WIDTH_32),=0A=
+};=0A=
+=0A=
+static void gen_pcie_downstream_port_class_init(ObjectClass *klass,=0A=
+                                                const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);=0A=
+=0A=
+    k->config_write =3D gen_downstream_write_config;=0A=
+    k->realize =3D gen_downstream_realize;=0A=
+    k->exit =3D gen_downstream_exitfn;=0A=
+    k->vendor_id =3D GEN_PCIE_DOWNSTREAM_PORT_VENDOR_ID;=0A=
+    k->device_id =3D GEN_PCIE_DOWNSTREAM_PORT_DEVICE_ID;=0A=
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);=0A=
+    dc->desc =3D "PCI Express Downstream Port";=0A=
+    device_class_set_legacy_reset(dc, gen_downstream_reset);=0A=
+    dc->vmsd =3D &vmstate_gen_pcie_downstream_port;=0A=
+    device_class_set_props(dc, gen_pcie_downstream_port_props);=0A=
+}=0A=
+=0A=
+static const TypeInfo gen_pcie_downstream_port_info =3D {=0A=
+    .name          =3D TYPE_GEN_PCIE_DOWNSTREAM_PORT,=0A=
+    .parent        =3D TYPE_PCIE_SLOT,=0A=
+    .instance_size =3D sizeof(GenPCIEDownstreamPort),=0A=
+    .class_init    =3D gen_pcie_downstream_port_class_init,=0A=
+    .interfaces =3D (const InterfaceInfo[]) {=0A=
+        { INTERFACE_PCIE_DEVICE },=0A=
+        { }=0A=
+    },=0A=
+};=0A=
+=0A=
+static void gen_pcie_downstream_port_register_types(void)=0A=
+{=0A=
+    type_register_static(&gen_pcie_downstream_port_info);=0A=
+}=0A=
+=0A=
+type_init(gen_pcie_downstream_port_register_types)=0A=
diff --git a/hw/pci-bridge/gen_pcie_upstream_port.c b/hw/pci-bridge/gen_pci=
e_upstream_port.c=0A=
new file mode 100644=0A=
index 0000000000..57d7e09485=0A=
--- /dev/null=0A=
+++ b/hw/pci-bridge/gen_pcie_upstream_port.c=0A=
@@ -0,0 +1,182 @@=0A=
+/*=0A=
+ * Generic PCI Express Upstream Port emulation=0A=
+ *=0A=
+ * Copyright (C) 2026 Nutanix, Inc.=0A=
+ *=0A=
+ * Derived from gen_pcie_root_port.c:=0A=
+ *   Copyright (C) 2017 Red Hat Inc=0A=
+ *=0A=
+ * Derived from xio3130_upstream.c:=0A=
+ *   Copyright (c) 2010 Isaku Yamahata <yamahata at valinux co jp>=0A=
+ *                       VA Linux Systems Japan K.K.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+#include "hw/pci/msix.h"=0A=
+#include "hw/pci/pcie.h"=0A=
+#include "hw/pci/pcie_port.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/qdev-properties-system.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_GEN_PCIE_UPSTREAM_PORT              "pcie-upstream-port"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(GenPCIEUpstreamPort, GEN_PCIE_UPSTREAM_PORT)=0A=
+=0A=
+#define GEN_PCIE_UPSTREAM_PORT_VENDOR_ID         0x1b36=0A=
+#define GEN_PCIE_UPSTREAM_PORT_DEVICE_ID         0x0015=0A=
+=0A=
+#define GEN_PCIE_UPSTREAM_PORT_AER_OFFSET        0x100=0A=
+#define GEN_PCIE_UPSTREAM_PORT_MSIX_NR_VECTOR    1=0A=
+=0A=
+struct GenPCIEUpstreamPort {=0A=
+    /*< private >*/=0A=
+    PCIEPort parent_obj;=0A=
+    /*< public >*/=0A=
+=0A=
+    PCIExpLinkSpeed speed;=0A=
+    PCIExpLinkWidth width;=0A=
+};=0A=
+=0A=
+static int gen_upstream_interrupts_init(PCIDevice *d, Error **errp)=0A=
+{=0A=
+    int rc;=0A=
+=0A=
+    rc =3D msix_init_exclusive_bar(d, GEN_PCIE_UPSTREAM_PORT_MSIX_NR_VECTO=
R,=0A=
+                                 0, errp);=0A=
+    if (rc < 0) {=0A=
+        assert(rc =3D=3D -ENOTSUP);=0A=
+    } else {=0A=
+        msix_vector_use(d, 0);=0A=
+    }=0A=
+=0A=
+    return rc;=0A=
+}=0A=
+=0A=
+static void gen_upstream_interrupts_uninit(PCIDevice *d)=0A=
+{=0A=
+    msix_uninit_exclusive_bar(d);=0A=
+}=0A=
+=0A=
+static void gen_upstream_write_config(PCIDevice *d, uint32_t address,=0A=
+                                      uint32_t val, int len)=0A=
+{=0A=
+    pci_bridge_write_config(d, address, val, len);=0A=
+    pcie_cap_flr_write_config(d, address, val, len);=0A=
+    pcie_aer_write_config(d, address, val, len);=0A=
+}=0A=
+=0A=
+static void gen_upstream_reset(DeviceState *qdev)=0A=
+{=0A=
+    PCIDevice *d =3D PCI_DEVICE(qdev);=0A=
+    GenPCIEUpstreamPort *usp =3D GEN_PCIE_UPSTREAM_PORT(d);=0A=
+=0A=
+    pci_bridge_reset(qdev);=0A=
+    pcie_cap_deverr_reset(d);=0A=
+    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, false);=0A=
+}=0A=
+=0A=
+static void gen_upstream_realize(PCIDevice *d, Error **errp)=0A=
+{=0A=
+    PCIEPort *p =3D PCIE_PORT(d);=0A=
+    int rc;=0A=
+=0A=
+    pci_bridge_initfn(d, TYPE_PCIE_BUS);=0A=
+    pcie_port_init_reg(d);=0A=
+=0A=
+    rc =3D gen_upstream_interrupts_init(d, errp);=0A=
+    if (rc < 0) {=0A=
+        goto err_bridge;=0A=
+    }=0A=
+=0A=
+    rc =3D pcie_cap_init(d, 0x90, PCI_EXP_TYPE_UPSTREAM, p->port, errp);=
=0A=
+    if (rc < 0) {=0A=
+        goto err_int;=0A=
+    }=0A=
+    pcie_cap_flr_init(d);=0A=
+    pcie_cap_deverr_init(d);=0A=
+=0A=
+    rc =3D pcie_aer_init(d, PCI_ERR_VER, GEN_PCIE_UPSTREAM_PORT_AER_OFFSET=
,=0A=
+                       PCI_ERR_SIZEOF, errp);=0A=
+    if (rc < 0) {=0A=
+        goto err_cap;=0A=
+    }=0A=
+=0A=
+    return;=0A=
+=0A=
+err_cap:=0A=
+    pcie_cap_exit(d);=0A=
+err_int:=0A=
+    gen_upstream_interrupts_uninit(d);=0A=
+err_bridge:=0A=
+    pci_bridge_exitfn(d);=0A=
+}=0A=
+=0A=
+static void gen_upstream_exitfn(PCIDevice *d)=0A=
+{=0A=
+    pcie_aer_exit(d);=0A=
+    pcie_cap_exit(d);=0A=
+    gen_upstream_interrupts_uninit(d);=0A=
+    pci_bridge_exitfn(d);=0A=
+}=0A=
+=0A=
+static const VMStateDescription vmstate_gen_pcie_upstream_port =3D {=0A=
+    .name =3D "pcie-upstream-port",=0A=
+    .priority =3D MIG_PRI_PCI_BUS,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .fields =3D (const VMStateField[]) {=0A=
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj, PCIEPort),=0A=
+        VMSTATE_STRUCT(parent_obj.parent_obj.exp.aer_log, PCIEPort, 0,=0A=
+                       vmstate_pcie_aer_log, PCIEAERLog),=0A=
+        VMSTATE_MSIX(parent_obj.parent_obj.parent_obj, GenPCIEUpstreamPort=
),=0A=
+        VMSTATE_END_OF_LIST()=0A=
+    }=0A=
+};=0A=
+=0A=
+static const Property gen_pcie_upstream_port_props[] =3D {=0A=
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", GenPCIEUpstreamPort,=0A=
+                                speed, PCIE_LINK_SPEED_64),=0A=
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", GenPCIEUpstreamPort,=0A=
+                                width, PCIE_LINK_WIDTH_32),=0A=
+};=0A=
+=0A=
+static void gen_pcie_upstream_port_class_init(ObjectClass *klass,=0A=
+                                              const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);=0A=
+=0A=
+    k->config_write =3D gen_upstream_write_config;=0A=
+    k->realize =3D gen_upstream_realize;=0A=
+    k->exit =3D gen_upstream_exitfn;=0A=
+    k->vendor_id =3D GEN_PCIE_UPSTREAM_PORT_VENDOR_ID;=0A=
+    k->device_id =3D GEN_PCIE_UPSTREAM_PORT_DEVICE_ID;=0A=
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);=0A=
+    dc->desc =3D "PCI Express Upstream Port";=0A=
+    device_class_set_legacy_reset(dc, gen_upstream_reset);=0A=
+    dc->vmsd =3D &vmstate_gen_pcie_upstream_port;=0A=
+    device_class_set_props(dc, gen_pcie_upstream_port_props);=0A=
+}=0A=
+=0A=
+static const TypeInfo gen_pcie_upstream_port_info =3D {=0A=
+    .name          =3D TYPE_GEN_PCIE_UPSTREAM_PORT,=0A=
+    .parent        =3D TYPE_PCIE_PORT,=0A=
+    .instance_size =3D sizeof(GenPCIEUpstreamPort),=0A=
+    .class_init    =3D gen_pcie_upstream_port_class_init,=0A=
+    .interfaces =3D (const InterfaceInfo[]) {=0A=
+        { INTERFACE_PCIE_DEVICE },=0A=
+        { }=0A=
+    },=0A=
+};=0A=
+=0A=
+static void gen_pcie_upstream_port_register_types(void)=0A=
+{=0A=
+    type_register_static(&gen_pcie_upstream_port_info);=0A=
+}=0A=
+=0A=
+type_init(gen_pcie_upstream_port_register_types)=0A=
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build=0A=
index 2e0eb0d233..fd0ad188bc 100644=0A=
--- a/hw/pci-bridge/meson.build=0A=
+++ b/hw/pci-bridge/meson.build=0A=
@@ -2,7 +2,8 @@ pci_ss =3D ss.source_set()=0A=
 pci_ss.add(when: 'CONFIG_PCI_BRIDGE', if_true: files('pci_bridge_dev.c'))=
=0A=
 pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))=0A=
 pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))=0A=
-pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'g=
en_pcie_root_port.c'))=0A=
+pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'g=
en_pcie_root_port.c',=0A=
+                                                    'gen_pcie_upstream_por=
t.c', 'gen_pcie_downstream_port.c'))=0A=
 pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge=
.c'))=0A=
 pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'),=0A=
                                if_false: files('pci_expander_bridge_stubs.=
c'))=0A=
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/=
meson.build=0A=
index 27b31f2e96..8a83b3188e 100644=0A=
--- a/tests/functional/x86_64/meson.build=0A=
+++ b/tests/functional/x86_64/meson.build=0A=
@@ -39,6 +39,7 @@ tests_x86_64_system_thorough =3D [=0A=
   'multiprocess',=0A=
   'netdev_ethtool',=0A=
   'nvme_migration',=0A=
+  'pcie_switch',=0A=
   'replay',=0A=
   'reverse_debug',=0A=
   'tuxrun',=0A=
diff --git a/tests/functional/x86_64/test_pcie_switch.py b/tests/functional=
/x86_64/test_pcie_switch.py=0A=
new file mode 100755=0A=
index 0000000000..7088b85059=0A=
--- /dev/null=0A=
+++ b/tests/functional/x86_64/test_pcie_switch.py=0A=
@@ -0,0 +1,98 @@=0A=
+#!/usr/bin/env python3=0A=
+#=0A=
+# Functional test for generic PCIe switch upstream and downstream ports=0A=
+#=0A=
+# Copyright (C) 2026 Nutanix, Inc.=0A=
+#=0A=
+# SPDX-License-Identifier: GPL-2.0-or-later=0A=
+=0A=
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pa=
ttern=0A=
+=0A=
+=0A=
+class PCIeSwitchPort(LinuxKernelTest):=0A=
+=0A=
+    timeout =3D 120=0A=
+=0A=
+    ASSET_KERNEL =3D Asset(=0A=
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/rele=
ases'=0A=
+         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),=0A=
+        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129'=
)=0A=
+=0A=
+    ASSET_INITRD =3D Asset(=0A=
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/rele=
ases'=0A=
+         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),=0A=
+        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b'=
)=0A=
+=0A=
+    USP_VENDOR_ID =3D '0x1b36'=0A=
+    USP_DEVICE_ID =3D '0x0015'=0A=
+    DSP_VENDOR_ID =3D '0x1b36'=0A=
+    DSP_DEVICE_ID =3D '0x0016'=0A=
+    CLASS_BRIDGE_PCI_PCI =3D '0x060400'=0A=
+=0A=
+    def command(self, command: str, expected_result: int =3D 0):=0A=
+        command =3D f'echo __begin ; {command} ; D=3D"done" ; echo "$?/__$=
D"'=0A=
+        output =3D exec_command_and_wait_for_pattern(self, command, '__don=
e')=0A=
+        lines =3D output.decode().splitlines()=0A=
+        for s, line in enumerate(lines):=0A=
+            if line =3D=3D '__begin':=0A=
+                break=0A=
+        result =3D int(lines[-1].split("/")[0])=0A=
+        assert result =3D=3D expected_result=0A=
+        return "\n".join(lines[s+1:-1])=0A=
+=0A=
+    def test_pcie_switch_ports(self):=0A=
+        """Boot a q35 VM with a PCIe switch (USP + DSP) and verify topolog=
y."""=0A=
+        self.require_accelerator('kvm')=0A=
+        self.set_machine('q35')=0A=
+=0A=
+        self.vm.add_args('-accel', 'kvm')=0A=
+        self.vm.add_args('-m', '1G')=0A=
+        self.vm.add_args('-device',=0A=
+                         'pcie-root-port,id=3Drp0,slot=3D0,chassis=3D0,bus=
=3Dpcie.0')=0A=
+        self.vm.add_args('-device',=0A=
+                         'pcie-upstream-port,id=3Dsw-usp,bus=3Drp0')=0A=
+        self.vm.add_args('-device',=0A=
+                         'pcie-downstream-port,id=3Dsw-dsp,bus=3Dsw-usp,'=
=0A=
+                         'chassis=3D1')=0A=
+        self.vm.add_args('-append', 'console=3DttyS0 rd.rescue')=0A=
+=0A=
+        self.launch_kernel(self.ASSET_KERNEL.fetch(),=0A=
+                           self.ASSET_INITRD.fetch(),=0A=
+                           wait_for=3D'Entering emergency mode.')=0A=
+        self.wait_for_console_pattern('# ')=0A=
+=0A=
+        # Capture lspci output, to diagnose failures.=0A=
+        #=0A=
+        # [0000:00]-+-00.0  8086:29c0=0A=
+        #           +-01.0  8086:10d3=0A=
+        #           +-02.0-[01-03]----00.0-[02-03]----00.0-[03]--=0A=
+        #           +-1f.0  8086:2918=0A=
+        #           +-1f.2  8086:2922=0A=
+        #           \-1f.3  8086:2930=0A=
+        self.command("lspci -vtn")=0A=
+        self.command("lspci -vvv")=0A=
+        self.command("ls -R /sys/devices/")=0A=
+=0A=
+        usp_path =3D "/sys/devices/pci0000:00/0000:00:02.0/0000:01:00.0"=
=0A=
+        dsp_path =3D usp_path + "/0000:02:00.0"=0A=
+=0A=
+        # Upstream port is expected model.=0A=
+        vendor_id =3D self.command(f'cat {usp_path}/vendor')=0A=
+        assert vendor_id =3D=3D self.USP_VENDOR_ID=0A=
+=0A=
+        device_id =3D self.command(f'cat {usp_path}/device')=0A=
+        assert device_id =3D=3D self.USP_DEVICE_ID=0A=
+=0A=
+        class_code =3D self.command(f'cat {usp_path}/class')=0A=
+        assert class_code =3D=3D self.CLASS_BRIDGE_PCI_PCI=0A=
+=0A=
+        # Downstream port is expected model.=0A=
+        vendor_id =3D self.command(f'cat {dsp_path}/vendor')=0A=
+        assert vendor_id =3D=3D self.DSP_VENDOR_ID=0A=
+=0A=
+        device_id =3D self.command(f'cat {dsp_path}/device')=0A=
+        assert device_id =3D=3D self.DSP_DEVICE_ID=0A=
+=0A=
+=0A=
+if __name__ =3D=3D '__main__':=0A=
+    LinuxKernelTest.main()=0A=
-- =0A=
2.43.0=0A=
=0A=

