Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB83DC43327
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 19:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdvQh-0006gH-0K; Sun, 28 Jun 2026 15:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1wdvQf-0006fv-Lv
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 15:44:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1wdvQd-0004ul-VW
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 15:44:33 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SIiec1569489; Sun, 28 Jun 2026 19:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 qcppdkim1; bh=LCAQRHx2ELgAkaxL4j3iG0SzGUWMxZKl6SkwmZmcVT0=; b=Ah
 P1yGPFjZpaPEXiwfGhOXXmfGIOai0yIggPqI+pwcF4OjJwEwAEJxmuupMBsHoQFf
 p1xJRe1LdLcYYF5uAogARcrY96nfhv4HeEEBDS2JCpLSw3ZvoCYeRqOJln6u9jEY
 NNBS9aFach2+akoFedZxpYYtVi+9P3PANOLQCtbd2nMyYILcPHTJCQHfDn1bOwSk
 rJyDD1uGa8XRw++R2Z/AN4Tacu0IvKD1o1awbEcKTYcG+/gfkUH2wPUM/+2hT0OD
 sBIw3y6CS0y+K8ravgOn/1h13fLhSxRefEPGTKQB41SmwJZVjfE5I6sCvHZCkmX+
 PPcW1cGhwwEOTY/qhTyQ==
Received: from cy3pr08cu001.outbound.protection.outlook.com
 (mail-cy3pr08cu00106.outbound.protection.outlook.com [40.93.6.110])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tukfgb-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 28 Jun 2026 19:44:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCXSMcc9BpKxZNtHJFKDkDKnfhicK9cDQbyiYQMd77FCUhF4jwmRRKV2t3C9jqHoFfsPrqrTe+AmaYlR/FXcxzJdreSEc8e75HhoQzlVU5iE9p/AG1JQhu7C6lex+o2swASGVLYAILXhe5ji76vp0i2DI+L5X7WYTSfhIJIsB7rO7Fl/jYlaX6V7JfIQSfgSX1kkcpQkCzysLYV33qrie7BU5EssdxwuUjtxomU9S7qclmsOuYvGMozRgpRNFL+ULDfYtD5jkd0qnfqqbOjvKaVU00j3YgjkTuGRnPa2S6CTELaqS9XAytVgeTrV2RPOCBb26TBHPlQTPzIfj/u7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCAQRHx2ELgAkaxL4j3iG0SzGUWMxZKl6SkwmZmcVT0=;
 b=nrjXLMJnnJC7Eu/54SDonAOX2X7mJtJft03BD4p7rJSMrUK6lvZnc6jJ5kVUvGf9KeEfH1ioVRIExPbBdfMlwrvfuNZ2SA/4+RJ1a+1Kb0kOoKVzSdMYSNai5yt8sMhmWtDGvduko89A1RrWNcnMdRLhZc1VeUQWlOkkd30VtOsykIPQzpgchJ1dScSynjEmeSCAV35Oig7BkodMvUiLNG0mehP8iV6s4f1v5JZWIs2/vruoPRcDQDFU/GDmZoR9l43YL3ZU1qvqCztSTiEdwEgh9yN00jim0g4F3YI7GuDOqdcdyVm5uIV4tzFqO7BExuIxox3Yd7AOTzIqH5cRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH4PR02MB10681.namprd02.prod.outlook.com
 (2603:10b6:610:246::15) by DS1PR02MB10564.namprd02.prod.outlook.com
 (2603:10b6:8:20f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 19:44:18 +0000
Received: from CH4PR02MB10681.namprd02.prod.outlook.com
 ([fe80::e26c:3a42:9e62:ac47]) by CH4PR02MB10681.namprd02.prod.outlook.com
 ([fe80::e26c:3a42:9e62:ac47%4]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 19:44:18 +0000
From: Brian Cain <bcain@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "deller@gmx.de" <deller@gmx.de>, "thuth@redhat.com" <thuth@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "berrange@redhat.com" <berrange@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>
Subject: new roms/ content for hexagon: h2
Thread-Topic: new roms/ content for hexagon: h2
Thread-Index: AQHdBzVwazVFR/4y+k+2P1n5K6zAVw==
Date: Sun, 28 Jun 2026 19:44:18 +0000
Message-ID: <CH4PR02MB1068109FAF2014DE3A545D5EFB8E92@CH4PR02MB10681.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH4PR02MB10681:EE_|DS1PR02MB10564:EE_
x-ms-office365-filtering-correlation-id: 8bbe02b5-1b52-41ee-e5e2-08ded54da48c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|23010399003|18002099003|3023799007|8096899003|38070700021|13003099007|11063799006|56012099006;
x-microsoft-antispam-message-info: ExEPz3HHoDZyxzljq39IcVJE8Vr4yDWeLDd4FtR3ly6C9UAIkgDhSxD/ULWXSg5EluGh7qvTyWXtNRnaEN3oY4ZzJ4q1515Nnmkjr7xXX4AkUJ/Io7timEGz+F2WwswsGKf81EGkfNUsB60UAvE5xZCfOPQkGJVC2UqVyfB97HAnRRTClnDUh3g+Zh2KFVl1VOMYUmBNhI5+/4yz9YWUnKHBW5cfFnriARYSgFGjGmAASnST92Qri2OmH0oANK0S6e0kmNSlM2zp/E2e90OGhRz/FCxiZ/3UPaB2P796yqnNyGkSJmrSW8N6yvuIGACdtXJAx72GCg13YT4aw/+eeg4HsfHqP6OWxlZaNMbVk1i7cwQAqANh7xuIpu/VBWxxR8tW3GgQMX6ixIL1a3Bp0geGnHmY7tK/Mp7EyJl2M17tuXYQVLqMqKpu/YzoWjFVWFs6lcQow1tFrbE374SRNED9oBG2+bVD8gqqg3xFAfsfs6DuMWFiGki8RVZxlZRLs0AoQ4pDb2hJ7OgkihI00U8Vj+4B1LU7/PYDWOJM88mDNPWu6EblVqVH0I4U6EpXo/XyVV2P9B6XKJXIstfgJOwJma45esbJrD56t2GbBr+zL2+y/F2aHSQ4XIY5kj7LmU8AzJDQulQGKCg28Gwr3pMa+V5mhbKGlBV8Kq79L+1yQEVGJi2QBwBeVgxWx/7a89NkdFju/V9OsPGKbMD92+5VAU9XvmuocvQOyo+IGeY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH4PR02MB10681.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(23010399003)(18002099003)(3023799007)(8096899003)(38070700021)(13003099007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uM6+b1svJkkoZEbI3D9QPveUJTfECj0MRpMEuDW1KDgDZm1Jl4W5MvjjsF?=
 =?iso-8859-1?Q?3/5/uWWYxHCLYswgPWgo1fk53cJWhER/N5uf6WhS9tfzhB6+Zur/mJiqWo?=
 =?iso-8859-1?Q?l1hstNRQbpXJiaM3GTTeriEpQdDUt82bJewcwiTmN/l3QwdCRnBhRKBMZ7?=
 =?iso-8859-1?Q?R6ErfZ/2uYZVOXWHbWynADaP56gYaW455e3uA1pYsiJvA3wdtJyYPvNht/?=
 =?iso-8859-1?Q?28gZZ5OggJ5Y254kqPDkT+oEqg1ix4jCKY+XIZzeTIBjwvLj9NzcVRdOEX?=
 =?iso-8859-1?Q?nhwo0cDoicBu02wNZT7eGnLc877x170JXdGdibdkpQ5RZJ5WtBxRsfxNKl?=
 =?iso-8859-1?Q?PeyVdjliAHjSVplE/zrh/Fv707V1gQCyvy0q+UDJCtQUc272ednrDZhjF6?=
 =?iso-8859-1?Q?5MBj8fUisDB+1juC4kVRta2kLyJvwX3VVGEk97wNorvwMgV8gzzsAALJKl?=
 =?iso-8859-1?Q?758KMDD+tklikl+v6SDruGtAkP+eEWOH/J2TqkDeIFdtPPwa6zJQOSwvmQ?=
 =?iso-8859-1?Q?pnAiheB1VIY9bU8uuerT591lQqU4cCedrukt3L9R+t2yfY6/NyPbF5Gvnc?=
 =?iso-8859-1?Q?nf9bZ0WfUDL+uJxVV47fyrNJxemghWqN9Hq0e/1yCZFptHG/W1LtR+xzZq?=
 =?iso-8859-1?Q?4H0Vlg3SfCEX+64My+dBVFPmNF04ObQYNknE73LHQeBHiOAbPkdv2CISbP?=
 =?iso-8859-1?Q?w2424dpTWRJhNGcjW88rrbiuEQWZ7+ZSzm0T7LvJ1MfLt3fJ+EZgY2f1+7?=
 =?iso-8859-1?Q?OQglbTT2zNBfptMLCSj3poKjrC/jN8VPZjFOa+WHDDzJ+iu9cJvkf6k4+x?=
 =?iso-8859-1?Q?4rEjIGhA7Q3ueFQOLSvwLCIPIk9EOx2LSNJEzTnXSfKKU5KvHDnjAtIEPA?=
 =?iso-8859-1?Q?vllz4HqOJ70l89FVuq4u4RAUUyVb9JPXDBJnRzf8ipHJ4sgXtHemAZuu9j?=
 =?iso-8859-1?Q?p/pWCeq8johNcZhD9g3JznR6LY5LbDYBJq/8nv3IqTK29UbMQnz9QiHW5n?=
 =?iso-8859-1?Q?RQuZDwxD4JXibO3CmmzNTRRduiV9xWfPgrQA5rA9L7xfUcyDSORYIIwQ3E?=
 =?iso-8859-1?Q?kEheA2yvibWLADXJRlLUwJmyNxmoFoSOTVRhIoCTDNANlBVTNQYbXfU6BB?=
 =?iso-8859-1?Q?PkDAjG+MgyuczqMUCWX8pRDFRZZna1NEzEXRzYwru12KZYp3Arq3VUHffh?=
 =?iso-8859-1?Q?cyxTByM5bHoLWO9qXDLBXlVrQLsUC+1Uk+ipYzQBH48rVyMWXIX70Z6SBS?=
 =?iso-8859-1?Q?GktLDTN89m69rQGVlSsiyUjAsj3ad6J79yOHr48IHBzCNgnSP4I1hussfG?=
 =?iso-8859-1?Q?8eD0VdkQA7ypgtxEzmgb5fOhwEMiXD6SSXfvgPMQlFSOfVyyWEmWlXVm2Z?=
 =?iso-8859-1?Q?K8H474JLt5DDyY4/Df5JIpmn9R0eF6rYyswBzleXhA+PM+w1Tz8DLTrD0B?=
 =?iso-8859-1?Q?WNpuwj1MJIalqkfAFX/duBGjXR2j8HFe3YlG8VHauUBxBvx1g5nlTovf96?=
 =?iso-8859-1?Q?l8FgkXbmd4CJfjXQFtCjfNTaMXR/fyGpzFi4E+P3uPGYh7HKYN1ig6ZNUA?=
 =?iso-8859-1?Q?Q+eUeMoZ/TUNUlGAb1Qh1j785+tMtrpgNrrJjEsalJdaMxaL15lY0vWBm8?=
 =?iso-8859-1?Q?ggEbXQLxDzxlEkKPhPSpA8vjwvLcWqxm38IK1i+8+jpyTCG+y7gLOUftGk?=
 =?iso-8859-1?Q?An8HI8J345Xl5qsKBizRuh93UYPd5bnyD7qYO8IhW6mzPUPCPqUQaYx44f?=
 =?iso-8859-1?Q?UmK1ISdwP4EVNc7nT023yrI5Th3/wylx+FFMoIJhe5UQLOF9r3w2FEGstO?=
 =?iso-8859-1?Q?jXcQ0hftO8BRAD3de3IYeq2+l4V8PqFLrXrH6qWjDEVkfAtCf58s?=
Content-Type: multipart/alternative;
 boundary="_000_CH4PR02MB1068109FAF2014DE3A545D5EFB8E92CH4PR02MB10681na_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GrK6m71Dx8iES7LcHANjXZf1/fC/Siq96uh85dDabHl8BRizqHuCb/bFlm/ScweoiZv72Ffcb7booLibOUNWN9aHTGh7fiCYftxlcjIRqjsB8IPVvhgV6a3z4hwAluOnXpfIuQw0Lv/rqN8RBvAUXblZ1aQdMliPaVlXYwlrxM2kIlaecEHKUWjOBbTp6P7Q6j/6ZaLT3hLH1YMucWciJj3/CYJW0I2NvNlS2VbStJQeJTIIFigmoHX2UwsD7arHveELyOclZNbDiACtaI7YbuLe75OxyHauLsYXHVgaIwbNbxcJT6UBi0EzO+s5Jmqfcr/Sxc2trpmFVyddPUSOpw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5zdPCFjOSlu01AfPXyb7njkCR09ntx/+ilDnVjhJjfrZG2C4YBN0HoympLn8AXsYyipEm+sERvRs/QQ6Q2jnCqyanmg3kWe5ta8ReOI8SUy1ON88jcnXrgEXIUQ+nsamZo3Eo4aNZiZZb02FdEUouhld7VrpUpw68qpVxslzHjugZ2C2gxC3PlrgD/wsMSq2ScuijtC+7y1MSZlYyKtAQQhWk0g7plRRSd/b+yZe+VtcUWsYvgcNK0u5AqEd06B91IBxAvu1PQFov4/WxmsUgPsHyrc67E5fm94GEJBWsiHUE68ryzJzdQmZ31COhD5f3k2/wuRv5bvm/e7UICMT03qz1OqjvMhhu4+0u4uIu3RzYEhjeWOIF9XG+OXaNtJ8WuWGSl7XUwikp05J6XkQa+dtcCJ/xktmYhPY+/yLQEVLhnMSVRdujJRF9Na7nvc5vol/BXTjpk7elT9bGcnXNmiVufkw5TxYgr7W54SwIgYaDRd8/f7cmZbbCZG7EyjXC0TAS6JRamCXYOOmrEyv4KnBcWt8gE+41SLcyzdr7ixYunkaUqLN43EqG+oZ0K/DAbgKV1mPzf+JLexhLDm4qcxmpkaSEx/ICp2a6zIDBbEVw2IJJEs0FrkwAtwjDOQI
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH4PR02MB10681.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbe02b5-1b52-41ee-e5e2-08ded54da48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2026 19:44:18.2990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lpnu37Lc6boVOOloyRR897ewFNT59e2Hn2zK53sxPtLBliWpP31wgpcNW9ycXmBNThB1jJyABgpGhE6ebfS2vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10564
X-Proofpoint-GUID: 6TZ8uj6zxgrbNx5FzrqnuvxYXp_gQNdJ
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a417998 cx=c_pps
 a=06rDlZIv6fgO+JiV9OBTRg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=9rGDTX1Yfknlp0fCzEQA:9 a=wPNLvfGTeEIA:10
 a=sM_pq_9qKrTbYDpMfisA:9 a=MESoljBdj9s-mU9q:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: 6TZ8uj6zxgrbNx5FzrqnuvxYXp_gQNdJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE3NyBTYWx0ZWRfXzntomSkih4Wc
 jpjcYd4w26NzQE8u4xHsDAA8fO82KU7xSDwdhJA+KqLiYAMz2OyXGZbQJLfzk/ktqzS1rS6crIG
 HdJAoCGU+TTFRaVClXUyu4Un5P1YIKzGIn7fLg40gI7jAuTSdgeKhiwEfIpuQ9MPehjxKEol2Pi
 /Ni0Jly73QJQE9Yg78/IKjgzen+rkmYmTEPe2ux2GKeYYg4ySg/4oTXPTXoQU+Bj8/Jek/MVWFV
 QLjcFS64IvDs8XzK5ihZSt9ZBo5NPvAZuajLP1CrxuNTCQsoGU+vJS6ct+n5nE2CpPMyh3XMo71
 IYOWHZomV2yDOazNV07T1g57Q1IT3jwCOsG55eyyfe0/AdjnfqUog6ODExvygsfb2o9JDst2DvC
 9/DsTKtSrzaR08YdYzNCvTrZQXARzVcOmccVE3XlH10P1+ysaA60vcpyAct3uFpgLbH+iiX6jBF
 +ewkZ3jq8dzDPZDzTOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE3NyBTYWx0ZWRfX6SV4TQyjKIBa
 oplqnGqUcFLiFSfqyJD3h3T8C6WDZHGYexQvzGMTTVZnLPYPPuvOMh7Irc1yleyvzXusfTuJdmO
 +woKWbrcSLJh3rQs8PPi87kr4yeCsEI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280177
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--_000_CH4PR02MB1068109FAF2014DE3A545D5EFB8E92CH4PR02MB10681na_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm working on upstreaming support for hexagon system emulation and it'd be=
 useful to add the h2 vmm to QEMU's roms/ in order to simplify booting OSs =
like Linux.

To that end, I think the initial step in the process is to mirror the repo =
in the qemu-project?  https://github.com/qualcomm/hexagon-hypervisor/ is wh=
ere the code is hosted now.  And once that is done I suppose I would add QE=
MU patches to add the build process and build output into roms/.  Can one o=
f you do that mirror step or suggest how I can do it?

Thanks,
-Brian

--_000_CH4PR02MB1068109FAF2014DE3A545D5EFB8E92CH4PR02MB10681na_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi all,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I'm working on upstreaming support for hexagon system emulation and it'd be=
 useful to add the h2 vmm to QEMU's roms/ in order to simplify booting OSs =
like Linux.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
To that end, I think the initial step in the process is to mirror the repo =
in the qemu-project?&nbsp;
<a href=3D"https://github.com/qualcomm/hexagon-hypervisor/">https://github.=
com/qualcomm/hexagon-hypervisor/</a>&nbsp;is where the code is hosted now.&=
nbsp; And once that is done I suppose I would add QEMU patches to add the b=
uild process and build output into roms/.&nbsp; Can
 one of you do that mirror step or suggest how I can do it?</div>
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
-Brian</div>
</body>
</html>

--_000_CH4PR02MB1068109FAF2014DE3A545D5EFB8E92CH4PR02MB10681na_--

