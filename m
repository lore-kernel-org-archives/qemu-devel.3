Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F039C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2b7-0006ml-90; Wed, 15 Jul 2026 12:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@ibm.com>)
 id 1wk23k-00034L-SG; Wed, 15 Jul 2026 12:02:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@ibm.com>)
 id 1wk23h-0006YZ-Ig; Wed, 15 Jul 2026 12:02:08 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FEBl1O313799; Wed, 15 Jul 2026 16:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=czcIWeigZHKiVk64/ovaKRzM3ctIkB
 DAWFyh0i6COg4=; b=MqpU3dJFcHjMUc2avkbga0EN1YdcaY9+bZMQDGc3KWTBec
 XZ1g9S0didSPwkav5KOPsfQPjOLPP4JOvOBizTWSImykNBIkeiP88bE6rlHnttG3
 ssyGUVMrH9xIEMbVCf3I4AHhQinlPjZ6qvyNOm+PshmW2fyEKjefG+RxvrzTmTVz
 jDLwrioqhi2ToSpYJZwYSE7xUzBh81siN+Wi9oJ6xTylPjvXYufwubs3VPyPw1v8
 9AaCOMZ7/IRG/6rjX3TMnE91Q6xq0VpJE86UuBnybtgT1IVCmvaq0ILImjbYnkJB
 gami5yxNRhycF1gmY+WwdbzXchtP1cVqe7/mOxhA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwusf5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 16:01:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVDtyMH8Xa3q8Szc9xMzDERUhUB7Wu1UA4moNGdohvmUFTEeHA2wVgtcaVNLmdsf5kV343gGaxygTStSrGqlK62oHs6Z325UC+m3jnpw40c06EAM5WvTKSlUpgPRKbcN+GKz666bpNRE4GR+EnvszMPW2WxGELZL6z9uhQKyYMWRfDBO63kAiESggUnPj5Z45Rfw+sn4Y28gdtUnnsw/T5OpkW5mHap3vV/FJsIBZnt4ZuTyS07B0UMHbwNSPvo/IjJwoFuVEcPyR6A85ynM/jXMZYKgVtQ8Wy+mo/+LAXAnPhIPSN6kamg5vJieILP36D61aCdafL8gFt+Je1C12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czcIWeigZHKiVk64/ovaKRzM3ctIkBDAWFyh0i6COg4=;
 b=yW9SwUpnBnoBnMxNFXlery+TnAtJpayvCaqOURdN5wjNOv917KZFlVDlMlIH3UWfmoHLZoK9I4oTS6/6eCaBksumYGaaHl1RU8swLopVErUEctLj26pUiArfYKfOIoTOp+n+dJv3JcNRE5cBVmuPQxLYqIVO6hMJPNHT6OtBuJrAUVRTiQXTOs7knAwiAOCt4jhPnMwPjcWfBGhFB4r0iM9qt2Wo57RW2UNP6ka4lAc0uLfaDcpt3sXSgqz/5n0tpaZVPS0bLrBNMIm4p3ATMdfJxpX4Y2NZLfAmN6lRnCpQ8eV3Bi1B29pqxoDf1/JCZa4yXaUBtBvn0w+0w9eu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from PH7PR15MB5151.namprd15.prod.outlook.com (2603:10b6:510:13b::12)
 by IA3PR15MB6532.namprd15.prod.outlook.com (2603:10b6:208:523::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 16:01:39 +0000
Received: from PH7PR15MB5151.namprd15.prod.outlook.com
 ([fe80::5ecd:c398:4ff1:cd86]) by PH7PR15MB5151.namprd15.prod.outlook.com
 ([fe80::5ecd:c398:4ff1:cd86%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 16:01:39 +0000
From: Glenn Miles <milesg@ibm.com>
To: Mikail Sadic <Mikail.Sadic@ibm.com>, "clg@kaod.org" <clg@kaod.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, "ninad@linux.ibm.com"
 <ninad@linux.ibm.com>, "titusr@google.com" <titusr@google.com>,
 "jeuk20.kim@samsung.com" <jeuk20.kim@samsung.com>, "philmd@mailo.com"
 <philmd@mailo.com>,
 "steven_lee@aspeedtech.com" <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "jamin_lin@aspeedtech.com"
 <jamin_lin@aspeedtech.com>, "kane_chen@aspeedtech.com"
 <kane_chen@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>, CALEB
 SCHLOSSIN <calebs@us.ibm.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 0/5] Add IBM Huygens BMC machine for AST2700
Thread-Topic: [PATCH v1 0/5] Add IBM Huygens BMC machine for AST2700
Thread-Index: AQHdFHGzk/CfXe10t0mbQbzwBCF0+rZuvS/I
Date: Wed, 15 Jul 2026 16:01:39 +0000
Message-ID: <PH7PR15MB515180D1B6F069668AD594DFCAF82@PH7PR15MB5151.namprd15.prod.outlook.com>
References: <20260715155037.2237011-1-mikail.sadic@ibm.com>
In-Reply-To: <20260715155037.2237011-1-mikail.sadic@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR15MB5151:EE_|IA3PR15MB6532:EE_
x-ms-office365-filtering-correlation-id: 26151065-7be8-4196-2354-08dee28a5adc
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: VnMUF/8OIG2GYpu60VuqehAU42gQD/3AhilMggOVZiS9VOlEnAsWVf9+wbM0yC/icmshZrf3rZCb5bMn08q/kHay3zGavcPNICx1Yq13d71uNbmn2HdVopX7qYcIlbL3aR5hGxPoviSvM2KTMk9qN6Kbry7PLF+65RHF7YPoemR9xfv8Zcwh3R/k9t+UifZXUrAkPEycwPl0DPD69zw7T9uiuslHtdnG7+xxuYZvoQELptT75j9pUxg0O3zRAOsMW+sHaRRHgRR8Xp46GLs2dS5JluYkMqL6uPVbnWEt1jXcEyD8EeRAiSPJrHyZ+xUg08mjpzMWdzcoaEKMhRpQcYp5r6FHlVmAET1jaBmLIA3//c0rf6CVKUDrrUkPweykbD6vgEc6FFgpWgt9TvtsFWPWvkmkAWzCxysyKJHOblAJERnQPfqfTYiY00wyC2StnSTf2LntzjDQEeT6sRCHtVTMkplmnNqY4m0AqZ70vjKYQ99NRwyGAbkpd+Z+SsdVmkntPdH+qttjIQ/m1ff0hKpifViUWdzZP+pnWW7p16RCz0gfpBi/RNmKf+vWZWwoVHnpWepdh8GiymSPmQ/Se5n25S3LyIE6vQimllls5CtVtytpfklsf6u+JmEd+3PWuIMZ1fH3CwpADPiTmJKOQYs+xtk6t5JEtbJebik2wrodA7dl1hDS9wj5MSQhZMaaYjqAqHUR/XtjkiPmzJrDGVQv+89qWXCTmtlaVzmP9UE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR15MB5151.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uqFBOWwT01IQQvxahy0sfA92d75TpnKnFYe44zmjlaOuiLA96sakxtlcFdBC?=
 =?us-ascii?Q?V6j4Z5N2SDBUpYoa6igXsvBBq+H6WTHARruvXHClCbIZXydCBdUB5bo6n5Yy?=
 =?us-ascii?Q?cYBdgHrqPTsfEQVMHa40XdkOVPyq1ydwFoEg9ywrrC6rEM/XVrHkf5bRhr+5?=
 =?us-ascii?Q?hYm6QX3RV+1jyCN7GN4DmEuluNkIqq/bKsYg1p0aJsPTEJxpKs3PTNW3Z8D6?=
 =?us-ascii?Q?VHveXbM8M1zda7QXy4T4CoEwM1HIdKU+7HBmxSOhJphEZNhpnd010bPsuzDP?=
 =?us-ascii?Q?cjPMWQvNDZNWYXX+bq2xoZI5bAsDHifsiZ9TZrFIU3JZebQIl5/b9D8AD/9T?=
 =?us-ascii?Q?FvwQSloBkj/UmB88QwpUGSKpDGHa9Wa2ku2HiafHY0OYnLuioUhAiK6LvG6m?=
 =?us-ascii?Q?C2qDJ5rcpWyBv21kUxgF+J2zI1Uhk/3RFRMBcRgYIzi1SzvsPkOlxDGS9PWI?=
 =?us-ascii?Q?dLOrKG9HQxYhpiRNsQYOTP7fC2xpvROFgbDi1P0nhYZjMeBHAhqrmFRzgon9?=
 =?us-ascii?Q?dzvLVCNaqjhnovRkXNZ50sGwQ0h0XYopxXiqtCZr/bxjajYnkeYSotUwnY1m?=
 =?us-ascii?Q?eb9wzg9SPwugBicFcD0/SylWtW1VCKEO07DV46j2UkjZ23cxoVZr0rY8GDM6?=
 =?us-ascii?Q?ky319Yj9fB6FKrNODunCN6jkKnTIr7RO0qry5xbEbGqjJhAXtoYS8jFyBnvn?=
 =?us-ascii?Q?S84zG119k1a4tKJesfR6CuJGZsesziBaoXUe0UFuH4IvAn744JLo1gkRKYwI?=
 =?us-ascii?Q?Qj09P47Gl4elwXxBe349+gGwCW7v10BJKJUmeYHCFVz+EXiOPzN1eFLDUKx0?=
 =?us-ascii?Q?9wlWlXRbL0eyvDgjewn8coLQ3K6iI9zPKVu8Pn8vV7dI5+3LXzE1ITfGgkdl?=
 =?us-ascii?Q?g5/18PcKnmMAHYkJAZhAt1QEqqp2ROP9GpBHq/xJ8aFTMbB35Bapld3tBXkm?=
 =?us-ascii?Q?1Sfq8FbMyx4JK5p71pabOqzajIhZrjb3S9bigfZafT8QXn2FaKiufCsE6HcU?=
 =?us-ascii?Q?IM57xwS1vf7kHUB4Mw32BbOEIOxAiGM2E1M1sYBSvhBAHGybnWl7GDti2+Uv?=
 =?us-ascii?Q?mxx3omtM5LZ3C952mQ3R2NK9suMtE86KI/kLrCoVVqAmryk4gNr8HKXaG3T4?=
 =?us-ascii?Q?nes2ZM15JVBI41g7KHm9hE95t4pol2sNZT4fOmvKmiPzq0FpIMYpI3jDjYE/?=
 =?us-ascii?Q?NYXBy15EE8Fndr8w+gNXXZx6WWAaHkh3l4pi+0S7BPUr7sST8v9TYoPMu/48?=
 =?us-ascii?Q?/VM4qBSoWnqNKgQ9NLZ+VJ9yAlWfZzNVyA197KXv8zl7C1nA8SuxN0kFp8ne?=
 =?us-ascii?Q?gqEm35bbc7uk6ZkELv/2dt6tDiVB38lbYYUMfNnrL6llKbBE/mSOcJAEHLFU?=
 =?us-ascii?Q?9SC2KGtDSOTs/K+54mREK01MjAV2SzoR/Scj76jb2DtgGrRve5Gf4KbMgf9d?=
 =?us-ascii?Q?aCVwItp8v+7Nwrafrc0iZ0xklOfBupjlSuzpfDvzVITRtGVU8WSvFm/sZzl9?=
 =?us-ascii?Q?DBl4FTNURnj9HovI7C0m87Zd2vWGAEQMCre5V8uLmL8p1qAUN9Svut2uCU1Z?=
 =?us-ascii?Q?7nb1xd/ZeNOszSYy1x+9EEntgsn5zYwrnb+05H5tkscFUrPpoYifWwZybJc3?=
 =?us-ascii?Q?oH5cXiK9Gs9QWviyE856fSZcZ7NibmX1vCiZHpwcbrN32ypoxTnecVW5awha?=
 =?us-ascii?Q?3UUydpnPcdp4aaD6f0M8eLt+wVDcPBbg/beuiYnRbB3F/mOg?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR15MB515180D1B6F069668AD594DFCAF82PH7PR15MB5151namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: apH7yzg9a9yZABAzPhFZTtLifKdIBGngjLh7m80CtQSa+SKxtBzIU7XQutoAtGm1YN8bOajRJigJ/r5aJ6TihHCcdB+wOi8fjgvTiJZPGuNQ4aSRkO3FRCkM+eJ5VX2cnS9+jgYXmpxkoBI+xufXeJFzcieII1naG5Mq63Y4DbBzDagWP1fOPKkaKO7ZhYTltzv4Vu2Qpw+lQSneGyjs5YSA66J9Vr2yZWvlyFk9WE5pKu/YwguM2WcZNXgUXQ9JH1bY2tpkHisFaFqubwTMahsXNr77K3EfqISmDMxm91XFkIcXOe7wNtJT4aO7M909tTdHnesVABobpBsebKN6+A==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR15MB5151.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26151065-7be8-4196-2354-08dee28a5adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 16:01:39.0204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXWV99YVhgUVYpiIK+HCfNOOQ23ElTmAkATeWP/903jzEX2NKGYq/Lh1N1cVxceg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6532
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: unhKgWxwgvzzhF2vdEvI9DERMEjIsCNT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfX7+ko/wA26epL
 PeUST+fcoTgT6ffyFTDkApygrSx2FHVb2teuNtCoE8jFeh7RYmA48ECNmyA8Fj+g5vcT7wRpkyH
 No+Fjw28xq3IhPfF7MwGe09MuK8kALssfysMPwqe+7OflhGfPKRBviJAy2fPTBABtwot8SsHVp8
 FE8PsBKTtATtDet9dtVdwesuX/espJpAL/Ky6X8gW8KWklgMYlWiNTp37ZQov3MS6FrThqGnDWf
 85YIpqbg8VF5qf8LqfjRjDG9sjdNGH0peAFdV+ZTou3ICvfG5lO9HxqHEq2kHxJC7xMKO2Dsynw
 WbEL1OSzjwB86bTy171Ig7FHd91MbI0LEzK9df2p2vCUWo6IuXaJJ24vlOWV3dZfJ7wDj8G0xVN
 1jelvKcYpcC6PNxmqNCaA1ivJiIjfFGSizFYs+fxpxfh5AcsPzdQ18jic9Z6XJ/mYM0/3STmWir
 KTZ+Mcui2vXdD3BNyYA==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a57aee7 cx=c_pps
 a=L3hcPeoaDr12kb94poMUUQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8
 a=1XWaLZrsAAAA:8 a=hD80L64hAAAA:8 a=S56xvJB5AAAA:8 a=V2NxCb60AAAA:8
 a=pGLkceISAAAA:8 a=7KBfExy5AAAA:8 a=69wJf7TsAAAA:8 a=YnYxBVUDfpumnXdzggsA:9
 a=CjuIK1q_8ugA:10 a=zfUYtMfrBnJaN-fz7VUA:9 a=201ISDeuEE_Kwwc9:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=gFNbaldVC-z-bsjSTzMo:22
 a=cvBusfyB2V15izCimMoJ:22 a=MH9Ivq0PDQRhlrFuIVvX:22 a=3L6qF29SlnrayQqPM2jZ:22
 a=eL7OMsOqQ-6kYQPn45L1:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: dpdRMQjtzbCCbllURxw78g14ZQtr2K6l
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1NiBTYWx0ZWRfX9D/beoXEZ6RE
 z8CP4PjZ9zE+OzrLaCDaouFSWz0G/AMPhBhXRHxIcUM5OfX0aiJFEdcisrXGUyhASVIAWNFhszM
 vuhzwSO8Tdmv+qKtxI9bjtjOQaBd6YQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 Jul 2026 12:36:13 -0400
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

--_000_PH7PR15MB515180D1B6F069668AD594DFCAF82PH7PR15MB5151namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Mikail,

Could you use my milesg@linux.ibm.com email address for patches please?

Thanks,

Glenn
________________________________
From: Mikail Sadic <mikail.sadic@ibm.com>
Sent: Wednesday, July 15, 2026 10:50 AM
To: clg@kaod.org <clg@kaod.org>; peter.maydell@linaro.org <peter.maydell@li=
naro.org>
Cc: Mikail Sadic <Mikail.Sadic@ibm.com>; Paolo Bonzini <pbonzini@redhat.com=
>; ninad@linux.ibm.com <ninad@linux.ibm.com>; titusr@google.com <titusr@goo=
gle.com>; jeuk20.kim@samsung.com <jeuk20.kim@samsung.com>; philmd@mailo.com=
 <philmd@mailo.com>; steven_lee@aspeedtech.com <steven_lee@aspeedtech.com>;=
 leetroy@gmail.com <leetroy@gmail.com>; jamin_lin@aspeedtech.com <jamin_lin=
@aspeedtech.com>; kane_chen@aspeedtech.com <kane_chen@aspeedtech.com>; andr=
ew@codeconstruct.com.au <andrew@codeconstruct.com.au>; joel@jms.id.au <joel=
@jms.id.au>; CALEB SCHLOSSIN <calebs@us.ibm.com>; Glenn Miles <milesg@ibm.c=
om>; qemu-arm@nongnu.org <qemu-arm@nongnu.org>; qemu-devel@nongnu.org <qemu=
-devel@nongnu.org>
Subject: [PATCH v1 0/5] Add IBM Huygens BMC machine for AST2700

This series adds initial support for the IBM Huygens BMC platform based
on the ASPEED AST2700 A2 SoC.

The series introduces a new Huygens machine model, adds a dedicated
CFAM-S implementation for the AST2700 FSI responder framework, provides
a PMBus model for the TI UCD90320 power sequencer, and implements the
AST2700 UFS host controller required for booting from UFS storage.
It also includes an initial functional test covering the Huygens boot
flow.

Patch summary:

1. Add the AST2700 Huygens machine.
2. Add the CFAM-S model for AST2700.
3. Add the TI UCD90320 PMBus device model.
4. Add the AST2700 UFS host controller.
5. Add an initial Huygens functional boot test.

Testing done:

* Booted OpenBMC using UFS storage.
* Verified OpenBMC reaches the login prompt & Active/Ready state.
* Verified `make check` test cases all pass.

Note: checkpatch has some warns about MAINTAINERS for patches 1, 2,
and 5, but the new files should already be covered by existing
wildcard entries in the ASPEED BMCs and FSI sections.

Mikail Sadic (5):
  arm/aspeed: Add AST2700 Huygens machine
  fsi/cfam: Add CFAM-S model for AST2700
  hw/sensor: Add UCD90320 model
  ufs/aspeed: Add AST2700 UFS host controller
  tests/functional: Add Huygens BMC boot test

 MAINTAINERS                                   |    2 +
 docs/specs/aspeed-ufs.rst                     |   69 ++
 docs/specs/fsi.rst                            |   58 +
 docs/specs/index.rst                          |    2 +
 docs/specs/ucd90320.rst                       |   36 +
 docs/system/arm/aspeed.rst                    |   41 +-
 include/hw/arm/aspeed_soc.h                   |    3 +
 include/hw/fsi/cfam-s.h                       |   26 +
 include/hw/fsi/fsi-master.h                   |    2 +
 include/hw/ufs/aspeed_ufs.h                   |   66 +
 hw/arm/aspeed.c                               |   12 +
 hw/arm/aspeed_ast27x0.c                       |   31 +
 hw/arm/aspeed_ast27x0_huygens.c               |  242 ++++
 hw/fsi/cfam-s.c                               |  145 +++
 hw/fsi/fsi-master.c                           |   10 +-
 hw/i2c/aspeed_i2c.c                           |    7 +
 hw/sensor/ucd90320.c                          |  144 +++
 hw/ufs/aspeed_ufs.c                           | 1095 +++++++++++++++++
 hw/arm/Kconfig                                |    1 +
 hw/arm/meson.build                            |    1 +
 hw/fsi/meson.build                            |    2 +-
 hw/sensor/Kconfig                             |    4 +
 hw/sensor/meson.build                         |    1 +
 hw/ufs/meson.build                            |    1 +
 tests/functional/aarch64/meson.build          |    2 +
 .../functional/aarch64/test_aspeed_huygens.py |   49 +
 26 files changed, 2047 insertions(+), 5 deletions(-)
 create mode 100644 docs/specs/aspeed-ufs.rst
 create mode 100644 docs/specs/ucd90320.rst
 create mode 100644 include/hw/fsi/cfam-s.h
 create mode 100644 include/hw/ufs/aspeed_ufs.h
 create mode 100644 hw/arm/aspeed_ast27x0_huygens.c
 create mode 100644 hw/fsi/cfam-s.c
 create mode 100644 hw/sensor/ucd90320.c
 create mode 100644 hw/ufs/aspeed_ufs.c
 create mode 100755 tests/functional/aarch64/test_aspeed_huygens.py

--
2.53.0


--_000_PH7PR15MB515180D1B6F069668AD594DFCAF82PH7PR15MB5151namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Mikail,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Could you use my milesg@linux.ibm.com email address for patches please?</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Glenn</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Mikail Sadic &lt;mika=
il.sadic@ibm.com&gt;<br>
<b>Sent:</b> Wednesday, July 15, 2026 10:50 AM<br>
<b>To:</b> clg@kaod.org &lt;clg@kaod.org&gt;; peter.maydell@linaro.org &lt;=
peter.maydell@linaro.org&gt;<br>
<b>Cc:</b> Mikail Sadic &lt;Mikail.Sadic@ibm.com&gt;; Paolo Bonzini &lt;pbo=
nzini@redhat.com&gt;; ninad@linux.ibm.com &lt;ninad@linux.ibm.com&gt;; titu=
sr@google.com &lt;titusr@google.com&gt;; jeuk20.kim@samsung.com &lt;jeuk20.=
kim@samsung.com&gt;; philmd@mailo.com &lt;philmd@mailo.com&gt;; steven_lee@=
aspeedtech.com
 &lt;steven_lee@aspeedtech.com&gt;; leetroy@gmail.com &lt;leetroy@gmail.com=
&gt;; jamin_lin@aspeedtech.com &lt;jamin_lin@aspeedtech.com&gt;; kane_chen@=
aspeedtech.com &lt;kane_chen@aspeedtech.com&gt;; andrew@codeconstruct.com.a=
u &lt;andrew@codeconstruct.com.au&gt;; joel@jms.id.au &lt;joel@jms.id.au&gt=
;;
 CALEB SCHLOSSIN &lt;calebs@us.ibm.com&gt;; Glenn Miles &lt;milesg@ibm.com&=
gt;; qemu-arm@nongnu.org &lt;qemu-arm@nongnu.org&gt;; qemu-devel@nongnu.org=
 &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> [PATCH v1 0/5] Add IBM Huygens BMC machine for AST2700</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This series adds initial support for the IBM Huyge=
ns BMC platform based<br>
on the ASPEED AST2700 A2 SoC.<br>
<br>
The series introduces a new Huygens machine model, adds a dedicated<br>
CFAM-S implementation for the AST2700 FSI responder framework, provides<br>
a PMBus model for the TI UCD90320 power sequencer, and implements the<br>
AST2700 UFS host controller required for booting from UFS storage.<br>
It also includes an initial functional test covering the Huygens boot <br>
flow.<br>
<br>
Patch summary:<br>
<br>
1. Add the AST2700 Huygens machine.<br>
2. Add the CFAM-S model for AST2700.<br>
3. Add the TI UCD90320 PMBus device model.<br>
4. Add the AST2700 UFS host controller.<br>
5. Add an initial Huygens functional boot test.<br>
<br>
Testing done:<br>
<br>
* Booted OpenBMC using UFS storage.<br>
* Verified OpenBMC reaches the login prompt &amp; Active/Ready state.<br>
* Verified `make check` test cases all pass.<br>
<br>
Note: checkpatch has some warns about MAINTAINERS for patches 1, 2, <br>
and 5, but the new files should already be covered by existing <br>
wildcard entries in the ASPEED BMCs and FSI sections.<br>
<br>
Mikail Sadic (5):<br>
&nbsp; arm/aspeed: Add AST2700 Huygens machine<br>
&nbsp; fsi/cfam: Add CFAM-S model for AST2700<br>
&nbsp; hw/sensor: Add UCD90320 model<br>
&nbsp; ufs/aspeed: Add AST2700 UFS host controller<br>
&nbsp; tests/functional: Add Huygens BMC boot test<br>
<br>
&nbsp;MAINTAINERS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp;&nbsp; 2 +<br>
&nbsp;docs/specs/aspeed-ufs.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 69 ++<br>
&nbsp;docs/specs/fsi.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 58 +<br>
&nbsp;docs/specs/index.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 +<br>
&nbsp;docs/specs/ucd90320.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 36 +<br>
&nbsp;docs/system/arm/aspeed.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 41 +-<br>
&nbsp;include/hw/arm/aspeed_soc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp;&nbsp; 3 +<br>
&nbsp;include/hw/fsi/cfam-s.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 26 +<br>
&nbsp;include/hw/fsi/fsi-master.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp;&nbsp; 2 +<br>
&nbsp;include/hw/ufs/aspeed_ufs.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 66 +<br>
&nbsp;hw/arm/aspeed.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 12 +<br>
&nbsp;hw/arm/aspeed_ast27x0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 31 +<br>
&nbsp;hw/arm/aspeed_ast27x0_huygens.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 242 ++++<br>
&nbsp;hw/fsi/cfam-s.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 145 +++<br>
&nbsp;hw/fsi/fsi-master.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 10 +-<br>
&nbsp;hw/i2c/aspeed_i2c.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 7 +<br>
&nbsp;hw/sensor/ucd90320.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 144 +++<br>
&nbsp;hw/ufs/aspeed_ufs.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1095 +++++++++++++++++<br>
&nbsp;hw/arm/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp=
; 1 +<br>
&nbsp;hw/arm/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 +<br>
&nbsp;hw/fsi/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 +-<br>
&nbsp;hw/sensor/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 4 +<br>
&nbsp;hw/sensor/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 +<br>
&nbsp;hw/ufs/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1 +<br>
&nbsp;tests/functional/aarch64/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 +<br>
&nbsp;.../functional/aarch64/test_aspeed_huygens.py |&nbsp;&nbsp; 49 +<br>
&nbsp;26 files changed, 2047 insertions(+), 5 deletions(-)<br>
&nbsp;create mode 100644 docs/specs/aspeed-ufs.rst<br>
&nbsp;create mode 100644 docs/specs/ucd90320.rst<br>
&nbsp;create mode 100644 include/hw/fsi/cfam-s.h<br>
&nbsp;create mode 100644 include/hw/ufs/aspeed_ufs.h<br>
&nbsp;create mode 100644 hw/arm/aspeed_ast27x0_huygens.c<br>
&nbsp;create mode 100644 hw/fsi/cfam-s.c<br>
&nbsp;create mode 100644 hw/sensor/ucd90320.c<br>
&nbsp;create mode 100644 hw/ufs/aspeed_ufs.c<br>
&nbsp;create mode 100755 tests/functional/aarch64/test_aspeed_huygens.py<br=
>
<br>
-- <br>
2.53.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PH7PR15MB515180D1B6F069668AD594DFCAF82PH7PR15MB5151namp_--

