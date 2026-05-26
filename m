Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B4FCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRslX-0007jK-UM; Tue, 26 May 2026 10:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=9606e6094f=quan.sun@windriver.com>)
 id 1wRslW-0007iv-Px
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:18 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=9606e6094f=quan.sun@windriver.com>)
 id 1wRslS-00012y-9b
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:18 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QDaB29762999; Tue, 26 May 2026 07:28:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 PPS06212021; bh=D5Fx3ndMC+Tzm+IxVd/9rALEzgDJe6mS4yloUYhJ9ew=; b=
 Pp3mg+DHBu77F4nTFKQjZt4jXq0A/O0rbklVNexwYR2rWzhT4Fufff+YPmL6SqXx
 AH1OEMnRHlc5ed7BfKqKZDZqasfruBjKVDYyTh7Mms94I59ZXsaqzUvZVUplUo/e
 3N0rL78EpaU8rgqgcjvj2jTkWmpjTK//x6TX3qt39rxd5ebiGTHARCvnva1GW8eQ
 bcD0YA0eaeLna53rPZ2nWLX7P4dQLaans7/Aztb0JAsnpuGzUF2sa4OOD/eV4oRc
 yixnVw0DAAyyxYLEtPLlbiQhgDyLme0uD17bp2QXrGXbDhNRkmXgDtC+yOrOBncD
 CLvgKnJ/LZJHW/kAGYdowg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ebbrekpaf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 07:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOQX9P30QnoAviwl4gn+9GwvS5nPVT/pPUFKyR1nEEQEN/RMKkt90wFvUnAfncSQbAP7W+1TISFoAM9PcAg86hUvTHGXaQW3lxZw5Zq5+1GE9kntHxkT+LuKfiP/YwS7fWQW7j3Lk/lTlUJL02CNcEkPdS915SWi0WZr+N3mn56rAWFfg6SBwM92tuKV3NXeQPtKJFMhpZvnUKY6CBusGBH9l3HnKZRxFabYS4+FB7dHuB1nI8l4Lz5inp4tWg+/dSk8RA8r6EGfdiJa3rqpmrdlxn6nHoYUCtXPqXGx/gVFco1qtV/nSKrHRVMhkaUauGN/mroP0ETzapONetoMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5Fx3ndMC+Tzm+IxVd/9rALEzgDJe6mS4yloUYhJ9ew=;
 b=O479JODtjs1JWBFJBMALDK4mKe2itOenRXliPXl7sg6Er0uzEZg6vvpuVOzaX3rKciGVxX8zLKWzQkMUtmFP2BRUNb3EG9bN6wwuOh1T7XeKfeV3qO3OBrSIeM03c20kYVXLCnTXD8bCBX+BPHFrpE7ALk/4CkfulUlc4Nep/d8Hxx7wMHWSAMA6uoZfVZDgv8g2TkDK625LB37eD7DcxeKD3ZfEmfPrNE+0e2N42fxuY6uNJLJfhfx3TKIfwrHBDFTsnOV56TIbioSvAc+Zw470qKY2l216BVWgVGxpBSp5z5cgtDh5gIzzvMQI0la5V3PXUKt1DwZI8qpe5yo+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10)
 by SN7PR11MB8262.namprd11.prod.outlook.com (2603:10b6:806:26e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 14:27:59 +0000
Received: from IA0PR11MB7283.namprd11.prod.outlook.com
 ([fe80::6e41:656f:120e:8e8]) by IA0PR11MB7283.namprd11.prod.outlook.com
 ([fe80::6e41:656f:120e:8e8%3]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 14:27:59 +0000
Message-ID: <c783a05b-62cf-44d2-81f5-13b8e3f0f81e@windriver.com>
Date: Tue, 26 May 2026 10:27:57 -0400
User-Agent: Mozilla Thunderbird
From: Quan Sun <Quan.Sun@windriver.com>
Subject: Re: [PATCH] hw/scsi/vhost-scsi: fix build with older kernel headers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net,
 sgarzare@redhat.com
References: <20260525182730.4098543-1-Quan.Sun@windriver.com>
 <20260525183656-mutt-send-email-mst@kernel.org>
Content-Language: en-US
In-Reply-To: <20260525183656-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::13) To IA0PR11MB7283.namprd11.prod.outlook.com
 (2603:10b6:208:439::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7283:EE_|SN7PR11MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 251f2c2c-55de-4e24-4186-08debb32fc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wY7tX4KP9gXB+CKDBZNrsIv98vXFj29hQAjjXFh/vgUfx5ElMsdYZ294N7Cm/tnpAP9d/pJAC8gJCKL5N9eH+Hln7SffOPK7BEOeiwCAgbO3DpRs2ALdmlh6VoDTN91jE00cyibDjTTliR0fmCWbfbuwFGmRI4+kRKRswnPyfR/fpCKBm8u4T4riKR+XdqG1sYYBVdjcGZ421HugZnu+pBZIXOQsC6b2SqUnftcakaTpVYUCdj/1d5zTwhupzla8T9FVlz26aVAdhzdlcT6TNL5UKegOcgt7Zihk+CqX2Y9eso1A94gBBbejxGoJJVVbzQV8cqzkcSMV4PQAXrkrGPS8IIrbvbpsjIR/4cEeHqlN1Ph5FoMWBrcOEZ1jbabKx0Oa+Dp+AnsfaEpMLo9K5YzRgW6Nj0QAPQKBshzjYklTCdPeSaqhrwYBUfvRS3y/LQA+bFcs664bDEiL9c5HB273ynUwFrMIGhPFXs3Kd7e7ftUqX/IBn9Xzo5ei3ZqhU7V2Wj7Rd/RAhSsVlKsLxYl2RTkZX+g+zYuB17jymZIiSEjxrtuMRn0wA38aADyKuTv01F3vP74674navnE/SVB+RUl9WGhL/raZxfwOfCMlkFoZTLTejVmu3zf3c0sxAJMrxp2cRCLOAqZC5W1Vd07h7vBsK939yefB3oU3i8L9Lu3IMVnlZrKVQUq8qTeh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7283.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGpBL1JWWWNvTmtmNmdWazZXMHg1Z0Y4ZnI2SUY4UzU4U29tdTUxMTBuYThC?=
 =?utf-8?B?RHRxdE03Z2t1ZVNFTWVyQmtMNVcyOVE5OE85RUx1RTZJNUNJV1NETXp2d0FJ?=
 =?utf-8?B?N0VwSkVRRXdmQWxBNGJlZDEwOGxkUnZZU0tPNDFrWHhmdkJ4bERNc0YzSGxq?=
 =?utf-8?B?UnVuUjduaDI5SWdJd1NpK1J4bGtMVE1rTVdSQTNCQXY0ZWVHRisycUt1NmFx?=
 =?utf-8?B?WFJrZkV2bWRBL1IyNDNEY3hxT2RxN3NyYlN0Ull0WVQ1Q2hPczg4Y2JoRWlR?=
 =?utf-8?B?N1UyU1dvZjhMcG1lUUpubHpFNWxSSnBoUXJVb3dRTUFyS01IOHJiMnlxeHI3?=
 =?utf-8?B?OE5ZazZQc29oT2M4dVpiUXdwVGJSaHJPUER5aWpES3pSM21udW9WMlMzTjNC?=
 =?utf-8?B?c09hcE43K3pRbmw3OStXZko5bDNaNjl0VGxEUGdqeDlNRVVjZndRblpWaFV6?=
 =?utf-8?B?dUJTSGIwWk9ybk9CMmljclZuNUlLSDZISlNDOWs4ZExIRll0bTlDMlBrSWpv?=
 =?utf-8?B?NEtSL2JCSURYTmdFdGJWTUxHb3l1ajRMNnVpQUlwMlpsWXpvSEtrWUhKVzRz?=
 =?utf-8?B?VE9FSTFnL1BwdVhCZmhmcERPdzNvbUlQQmZlcnhDVVh5NTB0ZVNoMzV0ejBS?=
 =?utf-8?B?eHE2U09acXdxVUJIcnRUTlVMaWVTcnJ2TFVZN2l2UFZFY0taRUhGKzRBK2h3?=
 =?utf-8?B?WTJTTVdqWGloZVJpeDF2WEIzRk1xS0tPcWgvcFJYbXdIRVVaT1BkZEtHZUY5?=
 =?utf-8?B?dkRja2tXR3dpSU93ajd5a0ZZTDAxbWlndUZIMWcxanlHcGxDbnlNVDUvOVdL?=
 =?utf-8?B?TklzaTQzU0NTalpaeFQwS3NBOW9RMzBQQVBVV1lZTE5VaXA5K2dKMXRIUU16?=
 =?utf-8?B?bERHZ0ZZRnovMWVEYWk3QnZpSUFsc3pJdkhiQTE3Q1FJby92QjBjMGxEN3VW?=
 =?utf-8?B?aVZjWVNrV1JHRDMybS96cGxtTFgvWERkZUVKbFNoeWVRNDZtT0dCdWdSaTFl?=
 =?utf-8?B?bllnTGdJV0RkaXdtRGM3K05kNDVoVHp0Ukk3Wms2ZmpRajNlaThYdTd3ZzNu?=
 =?utf-8?B?LzRNME1qR1RCVEVKUGNnR1F2VmdvRmExVDZocTBxQ1Y0VXdKbjQ0Y3NYbXo2?=
 =?utf-8?B?Q3hCTXpEdG15c1NueloxSVZFVVN3NzJtbmlyd1VzeUZhYXllb1VWMDhqR0J3?=
 =?utf-8?B?ZVRnYXljWEJvUkM3aVkxemM0d1RlZFlmTnFCTEJnK1I3VFhVNmlJUG9VNkVK?=
 =?utf-8?B?ck5GQzM3MWZLeWRLWUdmVWY2Q3Y1b0hOTnY3dnBEUHpEZFBVaVZQVGNjWU9N?=
 =?utf-8?B?cVBmK25lL2FwTDh6SDRTYU9abXlhdW9lUUtiWlg3elFWOEFvWDdPbG9qQXp1?=
 =?utf-8?B?alZjakw2dklaNHFxemtxdFREMm5YQW5oRmxHMkNjYlhLVm9yTWdqQUtrRGZF?=
 =?utf-8?B?S0xwTlhnWW0zNEtnVzM1S25FZ3VWaEJGWU5Pdnd5N1Vtb1cyTFBIQytVb1E3?=
 =?utf-8?B?aDU5SVl5Ynh2NDJNYVhDa3JWdmg1S1MrNDNSaWwzMnFaYkRnYjRNVTN4djFX?=
 =?utf-8?B?SHdQek8wNDM1Yjh3a2VuZ2tSMS80aDZVTTdpM1YwdUNKNHpFTGxGa1E2S2RG?=
 =?utf-8?B?RHA4R3d6TklFa21VWm9JcCtGUmhEYmxxeGw2UGFWeEgxUEhUQmVHVFc5ZXg5?=
 =?utf-8?B?Wis0clZLMWlwZXN5ZHE2TE1rK2QzU1VDNGtVOStUdk94TW4zNUNVZ0NINWF4?=
 =?utf-8?B?QW5Zbm5nMzVmL3kwQ0ZNQnFTK2FSRHc2SCtiN1FvNkpBWHFyUUhVYk5nODVO?=
 =?utf-8?B?QTNsckdpTXdabTQ5TjBzblJFeFNlUHhYdVZqa29mWnJLN3VQbWM2dUFuUG1n?=
 =?utf-8?B?Z0Z1TTJmVWk0Vm94T280TzJPSkpRTHc1K0lMbkRlbVJKNWVBVlZTcEUyTGtQ?=
 =?utf-8?B?SEVkZ3B4VWpRZDVjd3Z0MU9QVXhpY3ppOHRDMGdRUXB6YzBxV3BzMCtnYTFP?=
 =?utf-8?B?Z3pPTHJSU2JoSm5nTlhNNm1RMEhNa2JDTHJxVGcwWHkyV1ZRc0w1ejlYK3NJ?=
 =?utf-8?B?M1J4RGNIeUZvc1E0M09nNDJDMnNjQ3F0UkY1bnQ5ZS9keThMSnNkWTg0SVpL?=
 =?utf-8?B?TStyMWpheTRUbU9ReS83UU9HRXhHd3FqbVBPclV2eGNGZ2NDdGVhNEZJdDR3?=
 =?utf-8?B?aTVsa0NQcFdWakloQVc3Q2pUYVExaTRwVGx4cHhsazZYcm5LandaN2g1M2or?=
 =?utf-8?B?VmZNbXJnaDc5S2hNSjBuSU85Q2U1NFQxTG5PK2tpS3ZnenpqakdNKzNiQmg2?=
 =?utf-8?B?M2VFTzE2cUFpRFF1TmtLc1FXTVBxQXI0eEkzaGlGWGhkOU9XbjE4QT09?=
X-Exchange-RoutingPolicyChecked: iYsqw1OrrgXMDNGiRF+XTnZ2UIVU96q5EZiJKQV6xwzuvwiTsP20fuWDy7wavVrXI3/FbDrI7959wRC8RlzJabK4zf6YHjF4psQCv8TdDL60N5UJScf1YLYpelYEC76d++iBVTO3nyiq1neKKU1uaehPeS7INNuwpazbncWZPOte+7e1VNNi9ZLMXs1EpX/EWrezJpGTiU5hQu40l7COISSOHziVSZUzDlyYQqh2HI2J5HHNCWrtTEIp9dlQhWlV/RK0PmllrQfEBoLwA2wzr2Fvv3WcXq+E5yS7fX4TPO2K3towaxlzIwXlYNd0po9qUE+aCSrdyi50/DzbcZQ83w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251f2c2c-55de-4e24-4186-08debb32fc63
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:27:59.2356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvyjrI6qV/OiC+fgVbLTMNkD1eFq3xfl3P8B4NO7ON+eb6hYZZINNm/xb7UJ6dt0Hfi8y2+qicv18BNHsuFMEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8262
X-Proofpoint-GUID: ziQ7h5qHnxhd01fB7DfTlE2KIvUjDQPf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNCBTYWx0ZWRfX90YXN0/pI2Iq
 e2hZ0Do8Ecao1V9R4XpOKJLllFve05/QVAm0EEw7jN5rq5X5uoOy+jCifeHJKpA6CQCPWprByw9
 uqEjlBwnM5PijN+72rH2WUiE6aImL+yYQdV3Ljgw+5D8s/5rYLVn0SBIX8tr+nk2IHmWL5kqvFq
 cOwz8FJKoo2GdGj9DSLC6k7XS5Q3eAdJW7OxtUkPtR86E0pyZDwoAp4VncFOkMJzKi0VTdBPQqD
 uYttskBrTudpS0EvO60xZieiHIiu7Kd0RI2GJw4OEdAhSjn3qTllXh6nlMqtgaRpjVuSo2A00DU
 KP6A4Y1gRbS3CW6ln9M+SNX0NQeSXgZSnjf2Fn1iEnLhmuBmk4NZBV5NTy/GjYvzQ+RTjoT6CKR
 rYHS4aupPrvF2x4wSXBi/uLNiVPk95pXt3lXHpv05Itzfh+3EOChERsmCIwoeJK2TwYAOoS1Dt0
 k2ALT1ywBcI8bcxBzlQ==
X-Authority-Analysis: v=2.4 cv=IMUyzAvG c=1 sm=1 tr=0 ts=6a15adf3 cx=c_pps
 a=XYu8HXWfxIrayFrXgJv6cg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=t7CeM3EgAAAA:8 a=PZG5FqRQqs3SQrS9_f8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ziQ7h5qHnxhd01fB7DfTlE2KIvUjDQPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260124
Received-SPF: pass client-ip=205.220.166.238;
 envelope-from=prvs=9606e6094f=quan.sun@windriver.com;
 helo=mx0a-0064b401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


On 5/25/26 6:39 PM, Michael S. Tsirkin wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Mon, May 25, 2026 at 11:27:30AM -0700,Quan.Sun@windriver.com wrote:
>> From: Quan Sun<Quan.Sun@windriver.com>
>>
>> On build hosts with kernel headers older than 6.0, the system's
>> <linux/vhost_types.h> does not define struct vhost_vring_worker or
>> struct vhost_worker_state, causing compilation of vhost-scsi.c to
>> fail:
>>
>>    error: storage size of 'vq_worker' isn't known
>>
>> Fix by including standard-headers/linux/vhost_types.h before the
>> system's <linux/vhost.h>, matching the existing pattern used in
>> hw/virtio/vhost-backend.c. QEMU's bundled header provides the
>> struct definitions, and its include guard prevents redefinition
>> when the system header pulls in its own vhost_types.h.
>>
>> Signed-off-by: Quan Sun<Quan.Sun@windriver.com>
> Hmm. maybe replace linux/vhost.h with standard-headers/linux/vhost.h then?

Hi Michael,

It seems there is no standard-headers/linux/vhost.h in QEMU's tree — only
standard-headers/linux/vhost_types.h. The file linux/vhost.h (the kernel 
header) is
still needed here for the vhost-scsi specific definitions (struct 
vhost_scsi_target, VHOST_SCSI_ABI_VERSION). The approach in this patch
matches the existing pattern in hw/virtio/vhost-backend.c, which also 
includes
standard-headers/linux/vhost_types.h before linux/vhost.h to get the struct
definitions that may be missing from older host kernel headers.

Thanks,

Quan

>> ---
>>   hw/scsi/vhost-scsi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>> index 699863cc10..10e8fbe503 100644
>> --- a/hw/scsi/vhost-scsi.c
>> +++ b/hw/scsi/vhost-scsi.c
>> @@ -15,6 +15,7 @@
>>    */
>>
>>   #include "qemu/osdep.h"
>> +#include "standard-headers/linux/vhost_types.h"
>>   #include <linux/vhost.h>
>>   #include <sys/ioctl.h>
>>   #include "qapi/error.h"
>> --
>> 2.43.0

