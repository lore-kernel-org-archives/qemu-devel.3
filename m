Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABF4D64062
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 16:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Roj-0007cO-1D; Fri, 08 Nov 2024 11:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1042aecdd7=nelson.ho@windriver.com>)
 id 1t9Roh-0007cD-QV
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:26:35 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=1042aecdd7=nelson.ho@windriver.com>)
 id 1t9Rof-0003dV-DB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:26:35 -0500
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8CogJf027369;
 Fri, 8 Nov 2024 16:26:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42s6g5gtsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Nov 2024 16:26:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gx6QAVtmntbAlNfeBMZ++JA05R4WS1dx4dUa1/Qq4egqhlScppFAqXe4jtkTjydWwhI+lgJ4/owrnVJ8lqBtoq2R86YRaYlFQ64rwgjV6c8xMRPGR+1aipSo3l26K6Q/A+sjSURl8ebB75JTd+o/3+MSfwbubnM7QX16kmKrpQWHWTAlYhduZJq6epdietvFZOaJjAh/zONL9iitcLAnVSW7j2ggF6dSNDZIf/OUVGD4vW7iof5X3qb+KvgDpVUn1UwCL7m+Eoe3ioFR2Pkez4KGyOa5gES+AoK5dJdvLybWtf6rfDpjMOcWYsx/VSp5q3mQBIR9OIi6NrV7rpSfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPW6DJIEW64WIotAKvgO/TigYHc0pPFDKJNntSLo2m8=;
 b=hqBGwVDolO/OazA+qk6nXnZZSQKcc2bFbnwqwQ+l5kFx7KJwOtGUNodpL46TbEwB/urOWlxE//uD3xdgs3gIvf6GK16230UePAGCpk+ZT5XZnj/8SbugdgqgTM7MTKQ2CLk8/7Un3ct9Ex+d2Dzz1TXTUED0plcc5AQQnnxS0jvCEMHRuzl6Xv4ronnNSpVB6X7QlPIn9xWVtJaHLJN4C7Hxb5Ykv3YjiRyUOzXUyGsRdbagj/wFyxKORi2ryuR0y+zkhJmFR6DVTJcUOecpkyYSyE3C2nyU9F14tU4ydQ+YNeAyN2icpt1+TusGfMeZkjCpjGyetvR1ZjTqa48lVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB6693.namprd11.prod.outlook.com (2603:10b6:a03:44b::21)
 by SN7PR11MB7140.namprd11.prod.outlook.com (2603:10b6:806:2a3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 16:26:20 +0000
Received: from SJ0PR11MB6693.namprd11.prod.outlook.com
 ([fe80::2291:a1fa:bd8f:ade1]) by SJ0PR11MB6693.namprd11.prod.outlook.com
 ([fe80::2291:a1fa:bd8f:ade1%4]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 16:26:20 +0000
To: "edgar.iglesias@amd.com" <edgar.iglesias@amd.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: xlnx-versal-virt smmu
Thread-Topic: xlnx-versal-virt smmu
Thread-Index: Adsx+TRJZuaewGwNSleN/955J7GYuQ==
Date: Fri, 8 Nov 2024 16:26:20 +0000
Message-ID: <SJ0PR11MB66930672DEE042F6AE1E7421E75D2@SJ0PR11MB6693.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6693:EE_|SN7PR11MB7140:EE_
x-ms-office365-filtering-correlation-id: 9467bfa1-7a55-4ffb-da21-08dd0012140b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RoJi6cirTQpXeDSg7IT8o1HLcuncAWLQH9Y9iXMpiTlB+Rx/gRnOC1QxbQKc?=
 =?us-ascii?Q?kCdZSN9ZCc3wvU5NGcMK3JyQBliNvnUPXsh1lSYO9/G7lo8eROYZ4o3kpbxl?=
 =?us-ascii?Q?T2oA4jWE0QurUofKYoguQKRWEVYH/STUjF31gQJxNGut5ExlgDUkw/+Wa3y6?=
 =?us-ascii?Q?VsEoUQflkdDO5M/JAvr0Qgn4bw46P22RkiwqbRkwK5zQPpcHlMEUifAvn08A?=
 =?us-ascii?Q?Go8/etQaIt02SKONcQkZoTzRK+ORULtel5MmQcE/EpXQ0sknYaxLkO8aP9S1?=
 =?us-ascii?Q?4EwY0+POKYSIS56wBVjHz73g6pZx7uGKj+1TjJZ6ru1rDTACOSi2he+rZn7V?=
 =?us-ascii?Q?EOyXHQl/kv7kUi5/wCLkpX9yuxDX0So5/AYAWWJ64B4lW93k6kQmIKQ7XMxK?=
 =?us-ascii?Q?GMPTzBsVHQC+FTzBoRebhqPdReVI1uiWy46YcVNJpG3xzIcelHhOiqVJQvQR?=
 =?us-ascii?Q?FAHo0GVewNZOMP7VBqXUV1KqlbHifa4WKHam4Nv2+hX5Iv9sfrwf13wPXc3Z?=
 =?us-ascii?Q?m1XSWVXvLClNXgInzKQ4Su8dNZyrFUjVl9pt9KP2b05alpepWCEcbFknDkEL?=
 =?us-ascii?Q?b26lHsF3y7MDGfrqbPGV2+m7N5oNlaxm3nqPhKCTQsHupSdOpVKblEFNXE7/?=
 =?us-ascii?Q?ntzvK8AbuXhJWBtP8Y66FZeu8zghlN57+D6Ft30g2RuYYHRm+7KejQPMGebr?=
 =?us-ascii?Q?GTPfjhQVRh7bl+2nyk40fZWhRjnginYw+GMW89yxpPW0ciw0jHoXezqYTVV0?=
 =?us-ascii?Q?q8jB7Hu9cck2Fmm4lSYh8DpLF2Bit6pyTr1LBX9lyEAqJPcPhWAokLNrrfqx?=
 =?us-ascii?Q?qZJiO0F+ebbnhbIIu7Iz+TgeHWNV34D66BTMFWK2bQTvGY9Or//ER7BfIDS4?=
 =?us-ascii?Q?3m0xmlDbRXFzDd20Vyl7Sdc7P6iRS1YA7Td8Wqvox7a34G14mW0WVkJFwzjV?=
 =?us-ascii?Q?+02yIiyAAs706QCXUi7ay4rBAB8rvC86K5DzJuOhe+k455XQFU/MCqhkPOLw?=
 =?us-ascii?Q?eKhkI8f5tcbduBKeMg/+mqd7dSHszdBDaIMJLYE16dNHTeXOeLW/LZ+8bwMN?=
 =?us-ascii?Q?MSma0l6JWchLOILgviiOkGsiItbyTKIouDXuOGt+vb8b8adS+zuLGEgyXSQP?=
 =?us-ascii?Q?MEGn+T6LlhMQghsEK6++VHT57FFpoAubqJiAoHV8s+DaoKwumeTtIZsen0Gw?=
 =?us-ascii?Q?p/GrRdAUp0Vu1IHYKdoHSq94afwZwEOapsG1B3KB2tmBR5d+IcS34235wZ9d?=
 =?us-ascii?Q?KjlHHm5nHboCE8gk8DazTt67MZ4Nd6NMfHT9ZzgoJioCsy3xHy6B8XFX+hD7?=
 =?us-ascii?Q?hcbXjhOlAfWfgVF1yCm4Jw+gmk6if9FKBqGqjHbE2JvAh88OMqEl2mBvleaS?=
 =?us-ascii?Q?l/GYz1I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6693.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I+mt8ziXABHe8c7osibeHnRujjScabgTXSOo700T5DNUtmrR940Zg6hJKD5D?=
 =?us-ascii?Q?0ZE57ZFqRgoDy+QQFRYazrHCR2cS775gz/7Cv8ZtDcrl94DF6qsFnZYbFiAD?=
 =?us-ascii?Q?5i1XXrzRcFVgYdBRTb9lrjdEK0SqEpitqNsBZI/HpxRJj4X9pRwoySRSlUMk?=
 =?us-ascii?Q?hy2LVms+mhnLSOgJ7Tn0gRO2yYyDs5XRDLaS6vnIFKMvqypOPeoFjItU4e8+?=
 =?us-ascii?Q?Mn4hnF5+yG9eZJz0aY2zhAsisEmscBfncMz+KcuqpAs1Fi76J8bSG823f1HW?=
 =?us-ascii?Q?sCoK7EIJTMoTPzRhtROzj3Y8yoL43MQSBjKfnxwni5GdK1wPkhhyLTwwfUx9?=
 =?us-ascii?Q?VNu4JLgauzDQ3STI0rjdrTAvMUGuLvEO2IuAqf73D4TgktUIpa4+VNb3f1vY?=
 =?us-ascii?Q?pTyPT8TDPxuSE2aDvoJsaguox10y40rqz60oYQp0Zucqk8E3jgilNs8S0kKp?=
 =?us-ascii?Q?F1Le9EA0VlCidHSI/LmFEoOGbcbXLZk/jGUPleZkxDuSif1ANoAgzdDubmpe?=
 =?us-ascii?Q?rf2FyLtxSNBY+AHWk2h4RP09HNioP1HFVQUv/dFQC5E5pHhAhou00+auToPu?=
 =?us-ascii?Q?TcvLDTXukW1fTx/2VwPlBIeLpuw9DFbpJuLFCj8EHYXrarll9Vqgyq+OGzCY?=
 =?us-ascii?Q?iIFXqWcnmFlX5+XEf5QnEQUmQnE8OwFtLEwc+RGe5YBOLj1CxnnfcxSXD0Jd?=
 =?us-ascii?Q?Z621nTeL3MEY6DRwsyUQGxgQ97yMootjm0xNtE35YeyRhQ62cEWGm70dYt3E?=
 =?us-ascii?Q?b+c9lJd/6X2IkjaQRefUiUtSnNjXpih1VLJ8gUqQ1YrFWAR+NuWfIxNHl7+q?=
 =?us-ascii?Q?ufHy+5alE+x5XsrFlnB69/oMAInTCV2bqi7ulHIJMCrTFcmni0GDaM0yuVLV?=
 =?us-ascii?Q?OksezPIoUUjYKBKU33Hmah/AGQWZkjmH0DFOGJ9b0FjcbmCNQyVOKKkGiIem?=
 =?us-ascii?Q?g1nae/63rVBKWmxnsLEZFtD4BEoIUeMtH2Lh5cnWAx+BuuT1bsxfg7I+/E62?=
 =?us-ascii?Q?yUmINotlj/79kx4v1NGzAqMSDPLE2Zg0FvGkgU3MZs5d948NwpxzBJCb7dj3?=
 =?us-ascii?Q?2gdN0vDixMRA3unCkC3knz1qCAmY3jR4MYli7Xk1b5kvhbsstd84gMfz1AMc?=
 =?us-ascii?Q?kQZHbxHrFZ8Yli4hvUTMfk6kCdhutH1NPfPuCKI5k4YHUnVHKDP+g5ijfTn9?=
 =?us-ascii?Q?VW5Q2rqmAIumglH/yXsJ2lLeWoT7AalxASAWvTBqouleiiPKA3qDIvnXJP2m?=
 =?us-ascii?Q?c1/m8oCEH7OIEUNCKfHZkRAQX3mBHAyiXn7C+rzMMOPe3U6UHjNTUBV4ZpbI?=
 =?us-ascii?Q?RbFmpq9L2WSPdev4FmnXyFVSXRf/SZYoe5V88GpvdV3lJ4/4qzTlysjXpTa8?=
 =?us-ascii?Q?tTQLSmOH/f7t0zh9uwBTrNQ4uIHqnbPFDg5Js2WxLsO+R/2o7jo9thibTSmR?=
 =?us-ascii?Q?iFIC5eyGBQaiLWD/e42easigqYqDGhDiZROin8jpKU8Tat81WH1XIjJfnWdp?=
 =?us-ascii?Q?wGrqDyWvgRt/p7AAC7WoxZBv69l8i3oUnL3Wn1i04vcVvLbyHTBLF+LIYVyc?=
 =?us-ascii?Q?KdzEIAkr+JcHWHaa3fxEsIshcCqtx9R3ZQyqrMdCpGBb/ELbiW/53mSqVYU6?=
 =?us-ascii?Q?jA8p1CTdGY7JIXBKxEgCfYqZ9oFkVn7gcYSbLb5JNt5k?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR11MB66930672DEE042F6AE1E7421E75D2SJ0PR11MB6693namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6693.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9467bfa1-7a55-4ffb-da21-08dd0012140b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 16:26:20.1633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWcL462nlywmpsA1F+eL4zmvJOETarZRiImShVKV64yTGmOEABvrCWZcgulKgAiBgcMaG7dsSG7iChsydB9N4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7140
X-Proofpoint-GUID: fQhJmc_0zG2hIlhh2jnU2WSIs6rf7LR6
X-Authority-Analysis: v=2.4 cv=JoCjr94C c=1 sm=1 tr=0 ts=672e3bb4 cx=c_pps
 a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10
 a=bRTqI5nwn0kA:10 a=ddOBEFa1Kli-3RmFVtgA:9
 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=qW0DF_mnvJ8s_TrNcIcA:9
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
X-Proofpoint-ORIG-GUID: fQhJmc_0zG2hIlhh2jnU2WSIs6rf7LR6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_14,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 mlxlogscore=288 spamscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411080137
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=1042aecdd7=nelson.ho@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Ho, Nelson" <Nelson.Ho@windriver.com>
From:  "Ho, Nelson" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_SJ0PR11MB66930672DEE042F6AE1E7421E75D2SJ0PR11MB6693namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Edgar,

I am working on bringing up the Wind River Helix hypervisor on the xlnx-ver=
sal-virt machine, which expects to find MMU-500 SMMU where it lives on the =
Versal SoC. I understand the -virt machine is not intended to fully emulate=
 Versal SoC.

I found an implementation of the MMU-500 on the Xilinx QEMU fork, and am cu=
rious why this was not upstreamed, and if you know what issues I might enco=
unter if I try to integrate this MMU-500 implementation into the versal-vir=
t machine?

Thanks,

Nelson

--_000_SJ0PR11MB66930672DEE042F6AE1E7421E75D2SJ0PR11MB6693namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Edgar,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am working on bringing up the Wind River Helix hyp=
ervisor on the xlnx-versal-virt machine, which expects to find MMU-500 SMMU=
 where it lives on the Versal SoC. I understand the -virt machine is not in=
tended to fully emulate Versal SoC.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I found an implementation of the MMU-500 on the Xili=
nx QEMU fork, and am curious why this was not upstreamed, and if you know w=
hat issues I might encounter if I try to integrate this MMU-500 implementat=
ion into the versal-virt machine?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Nelson<o:p></o:p></p>
</div>
</body>
</html>

--_000_SJ0PR11MB66930672DEE042F6AE1E7421E75D2SJ0PR11MB6693namp_--

