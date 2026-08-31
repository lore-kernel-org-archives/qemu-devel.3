Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948B6C61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0qnp-0004ei-Jv; Sun, 30 Aug 2026 21:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qno-0004eM-7d; Sun, 30 Aug 2026 21:27:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qng-0000zo-1k; Sun, 30 Aug 2026 21:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788139628; x=1819675628;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=biUW+RI+RVHuMrTuR/cXtoMAt3mXEs7F+geiJytxjb4=;
 b=dcyjkMHUEPKK1nBC1O4ohTuIHCQlUOBBFNwws3i1yO2uyjCmbFToyctW
 AKIe5BK0zpfuz32MXfTwJlk4y4sl7nr1fkzbDSJtIAL2OiUgJWBYTzs3Z
 WeX2dSVGfUODwQZL2XfzlDB8/OOSsjGkH58/iz2DeLB9HpGjWiJjsq7EY
 6cVHrFI15KSILQ2GNM59P+1GFMIrrMHeP+tWolcPak2yDUU221Jfqc99L
 f3Oyamyl+aam40irNExx5uDreOBrmDNfdMRuIUjq2L53SkjVVPGrWeZH+
 IhwdnIzpdFTJTJ11RdK5g4Si/XhYGvo3XKCPUNZQid+0ENipfcmAnOoco A==;
X-CSE-ConnectionGUID: F3vrdGDtTZiFWx12XYbiOw==
X-CSE-MsgGUID: vbCSUrilSKCzlcT6v29SAg==
X-IronPort-AV: E=Sophos;i="6.25,252,1779120000"; d="scan'208";a="154586991"
Received: from mail-westus3azon11010054.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.54])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 31 Aug 2026 09:27:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaqeCKVaYNzcRKwneBL2X6pzWF34gfzS+9SvOUxbgsOMY+CGAe4PLkpsHo966RO4trcm2OMbIQr55BUS1VmXTgnWoOMskn5Yii92XYLdqQZIXPTcy5gyM7Esd/J07lYZ95jvZViGEzkuyg4VG46zGkOlVtOZcE+FbUT0+MPNDxWqPoykjinkeKwJX+NkznrOtyLbhzw/eTZVsCnt3jNCK/oEbjZ4dR9RmVZXPqk+QQ5S234+NhCLcqe/5GFYJJPRoR4mtuqI/asX3VOywBydE/jldxqG82/mRpSPY6GoVtk1vZB0BMYrxSPpjEV5EUg7fI8yHNsBITa+tpTzijnJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biUW+RI+RVHuMrTuR/cXtoMAt3mXEs7F+geiJytxjb4=;
 b=o/+2aozU5cVjwmJ86APvyP0IbFNooOf3vdjSKjn+2dDKOyALcvFspsrW/593z9hCfgj9wSDtzDY3UFwxA9ZwBHaWnZAedn4bCZ5yHV8Bv/a8DvEKiUXgliaITqMZ/eyYol9ub4iLqaOrAvYht1MzMEIXmert8OPivPtiX+8yZpbQLoklY78NVMpzQhJ9p2IlJu/3DBxGrwa9V0ikqcZng+LfVhhWkc3w5hnaGM0DPlpYXypOrNdZGXCA+7wkeHN+0Oa7xABp5ZAvmb1psahffCLM8jXr+hhKsk4zTd3j97Py1jtXbnehH7mjmaDOpG5kyU62rWlkXN7IEOoiTyIFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biUW+RI+RVHuMrTuR/cXtoMAt3mXEs7F+geiJytxjb4=;
 b=UbLsCA32nqb7wVd+RQ6Zyq8qgvk4WgE8ghu726KcSU16K8whMBODcpuOJDZcUDwIoQWaysESoXlCxwGEsRc+wtU5X3bdZwi0fpgZQtMlBjUg7hNmkxavWMUWE8/W5KAJ0Eim1D+7x5VsjBFBudgfW5+owRZt0K+uo4mcwdBQx2Y=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9402.namprd04.prod.outlook.com (2603:10b6:208:505::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:26:59 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:26:59 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "joel@jms.id.au"
 <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 12/12] tests/tcg: Check vector memory tests contain vector
 ops
Thread-Topic: [PATCH 12/12] tests/tcg: Check vector memory tests contain
 vector ops
Thread-Index: AQHdNeKG1HemV+Gpnky6AY1iq3DNg7a3Y9wA
Date: Mon, 31 Aug 2026 01:26:59 +0000
Message-ID: <1cd595d9248d504f6a290393f135409e6b1d3ba2.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-13-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-13-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9402:EE_
x-ms-office365-filtering-correlation-id: 3c135a2d-99f9-46aa-e601-08df06fef3eb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|19092799006|23010399003|7416014|376014|18002099003|22082099003|56012099006|38070700021|6133799003|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: dilYwx6NOy34a5PEcEC31sJuDVGhVm+CJz3w12h03o89nQx5wx0YBfFQTTY51XM5JH5KjYonV7w1cWkNV6kB0+RtS3Bo/kIM4XtG3U1D4yey3UPk9syzGG1l6hj2ar1M+B3auT6Nt/FkkVRh+3y8AOS23I0gi4cMO13vBQCe6Y+zeVrrn7avek0Ur+QagMamdQoSuycYa1H2Qo2vBHsNJR/IjYh947IeWWW0Z0aWT+ZoRFuvYgXCILdIqDpZzN964kDEsGcqxawW+6oi3FcPGxjvIDYINaFcnZwhqwYYvmMOKmdx+vXe10C3a9xTG/+rdMqmMPWGU4yF4Iy5vwPxxrMKZzEZ3qfQ/FgREF3hYJ18+RmSWHtK/IWQ3fKqlinx2JfXGeC+xKltH5Y10bgkHbqsJm52aZs1v5SyIWjsMh36i3/ErvO9ZOZabpTnHnySXfpqELjS/aHLfvSQZqSpPp19JfxUZo7op7Z7360yCxWFpscnXU0K08V35BTs8edWTBnY3HQPaT/u1JR1lsWApjSRfV3SxOr/axcDu4LrzexHIyhgHnDkc+RFtd1z+zqWTcsSeVgwwIW7OI7W1cPJW3Paj41z4KlMlJdwPl8Onn5c97rpUl6a7qlvpG4ujbfS7Cv5EzdLAYMBrR5IdvXzIujTCNKXvTNgjHiFBujE8nkb8OFqbJfALAGwCMz5IUyp/1B+Xn39/x1AcqGEJmFrZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(19092799006)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(6133799003)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnIwdklLSVJ5ZUZoZW4wMEp4a2xLRGVkS1N5MEx0THlpeUhzQjdQellmYlhF?=
 =?utf-8?B?K0JuNkNmR2NnWDh4Ritmd2xFeGFvY0JINTVEb3dDcHJ1U1JRcXc1S2VDUCtI?=
 =?utf-8?B?T3AxYXNYdFE5Y3NxUzVLNU1BRVU5T2VPTXVXRmR6RWFvTUxmdGVIOXZaZFJU?=
 =?utf-8?B?V2xSSHZwVEZSQnRpNHpIdkYybWduUFdKMXJUMHBlclhUNjdmMTZFd2d0TGl1?=
 =?utf-8?B?Zm1iemlGYXIxUnRBcFYxbzBDalplUlFLZXlSdDNBcjkyaVk0bSsrdXdZRWw5?=
 =?utf-8?B?RmZmNU9VR0sxQ3dlK0tYMGVmUHloQ3hxZmNNWUcrQjdhbXEwK05mYUhkT2FR?=
 =?utf-8?B?R0RGNTNYY21vUko4NEVMNmNBT2o5WDJMbnp4YWdUOGRva3FDVHVTTzdCaldM?=
 =?utf-8?B?QU1UalczaUpHNUVNNkFmWFp3ZVUvaVFMWkYvVkgvUmJQY1AwVDdvTzY2T2ty?=
 =?utf-8?B?K1NjU1BGaGp0L3Y0UXU4ckdVakt0M0hISTBIZkNzNXpxQXVkSXJvSzFzVDg2?=
 =?utf-8?B?ajkvOFlYSzFKbTlGN2lrN0orUTQxWkJISTNwb3BKOEJQelgwc3lGdC82RjIx?=
 =?utf-8?B?SE1YcldkZlpmeVpVTHRKZlArL2NoZ1k0UU1JcnV3NnRacjFKOHBqaDBleVov?=
 =?utf-8?B?Z3BwSkhEU3F2cmdsczREVXc1dlFFc2JzajNHaXhDYTd5emplWGVpS1RTa01a?=
 =?utf-8?B?ZHNpZHVtYUkzUGQ4MTFFSlN5K3RXODlzZzAxdTFUUW5WTEEyc2ZSNmQyMkRw?=
 =?utf-8?B?T3htV3JDK2FrTWw3eFhwTmxxZURMamxJWmZRUGtMYzBxZ0hrYzArQjVoeWJY?=
 =?utf-8?B?V3ZuMEIyS0JSd05FTzVkWVpHd2JOeUQ3Qmxndyt4MUpES3pyNFNPWWYzS0cr?=
 =?utf-8?B?NUc1L1h5dlU4YVdhVEdQZmxoRDVDaDJXMmRFcVFCczdRRzNQa0VNNzZKa0Rw?=
 =?utf-8?B?d0pTTG04YlNwZmpNQ0E0QUE5MGI1eG1rai9lTjh3QWdQK2VGTFJFei9uRVdi?=
 =?utf-8?B?Q3IreFF4aTNTak40TnVKbXpTQXVJSFA1SEVuWnZCZEk4aFB3VXZYMmFJR29r?=
 =?utf-8?B?MzJhb0ZQRDlVRFFsbjRGbVovUE9SM04vVkY0dEJ4bll6ZXkyMHBpV0pDSm9R?=
 =?utf-8?B?NlRYdTlVTVdxUTlqUTdDdW9XSXJ4aTJueHZ3ejduWUNwSXI2NmxPdE44OWRq?=
 =?utf-8?B?TThoZWFSRkU3UGxWejNKTUtpbDdBdDYrN0Q2eThwVjgzc0IvUm1XSWdwbXRI?=
 =?utf-8?B?UittRTFjNEFDNjFsa3c5SFkzaTltZW5icmZ3VHRVUXBkV1E5L3hrQUlmTjZV?=
 =?utf-8?B?K0pVVGtqTGJPbkUxUjVYR2dTNjdOOVV4Z3V1R0NnZWVOeTZRQ1hOQ0xYc3V0?=
 =?utf-8?B?a3ZKQ2RFaGR0ZnhpNHBmL2s5akVPN0NINkZUb24xQmtLOC9wRS80cDlWbDJq?=
 =?utf-8?B?dHFOdkpLR3BnL1VobUQweDVvUy9kRHhGM2tZdTFjeENWT3Zoa1VqNWJSNklr?=
 =?utf-8?B?d2dqUTZMV21mMWU1T3dBQ1AwSytKRnVNbENGRVNueWFhdGNBREhwSVIrZ0d6?=
 =?utf-8?B?YTZvSHN3TC9lQ0lzUWxlbUJYSnhVOEljNGhKbGl1QTg0Zjg2Z0tUdWxMdWQ2?=
 =?utf-8?B?K0NhdjdiekdnbjVJd0lJMkpuWWR2dFdSTUdFTVRzbkw2eFo1UmNSdFZtbnQ0?=
 =?utf-8?B?K2xhb04zYXlxZ3UzSmVYTDJCZ1p2NkhoVWtlUFBTZEtUdk94SE9XbDVUYThW?=
 =?utf-8?B?WithTWl5b1lvRno4SlNMdkJvOFFMZDdYc2c5UElPMHRiSTdOM2F5S2dmM3E4?=
 =?utf-8?B?NFlRbkpicHFDNVdSWUw2bUp5eHRJeHc5VjB3bWJEWFpNaVc4WlhCSkRrWVNu?=
 =?utf-8?B?Vy9rc0ZKek9CTjVpN3UxeUQ5S2hsb3prRGI1SU5LVG9xellJcXd2Y291UFd2?=
 =?utf-8?B?TzdOd1RQd09nVUo5OUFIbUhrVW82cGJ2d2xXbEo3WmNHeHdJdGk2aUNLNCtF?=
 =?utf-8?B?V3ZYeTB0eUhDcXM1L1NJblhhZGdPbmJDWGtBVFgzWER2c3Y4MTFURHoySTRh?=
 =?utf-8?B?M2RsWHFld2ZIZk91SUFWUnpsdHY1QStRem9remQ0blRaYkNKNDFaQk83UDlq?=
 =?utf-8?B?VGdZSll0amFmVmpQVmZDUkNyeVN6MVdiVHV2RlBWNkdVMVdqajB2akdxbkRa?=
 =?utf-8?B?SUhCbnZSM3RwTHl3d2tjanhYUnV2U2IvZWxDNEpla3l5R2g0NitnTTFKOGFw?=
 =?utf-8?B?L0VrMmtlMG1rOHZHV0FrZTZpb3NWWncwRllLT2Q4Z2ZWb20xd2V1dTY3NnlS?=
 =?utf-8?B?QWFhZFRYbDA1Mjk5dkQwUWR4T2FIYit1M2JOZEM4WkdyaEdyMUJLN042QmF5?=
 =?utf-8?Q?ZMmXpAnrBPgSMWIhVjqSz7XO+Z4n2zDG1IjLPwvYxEhbD?=
x-ms-exchange-antispam-messagedata-1: 5ErzS3wy9dfhC620SnW9op/POFJRnUeYFXU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0D47E185E81954EB466DAFF02C918BC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i5jPbYG/G1FtLkb+lg8AwIB6hzNt2t7soSByOu2vcNKsTXFNEg/UMnAQCLh4EXjqXvYpHqpAg8dxtJjKCp9eKCj7CqmOqgw6irafBM+/MVMQmiRxeHu5WuMPQ/ZXMnU/W3z8Nl/S+XTeuV0UtuInaCgNqmb6ieK+XPgcfFiJtfw5gXxa+iw1AUD39NY+rxnKI79KEWR54GlzlWTTIg7iHy1BV78yuClgwCp9tiy6Q2Yn8aUqaP/jtmDwlkCV7+IQ01OjSJs9P0KgMo7f01FrwfuRJrSM7LClzaVYK7vYtlbd5fqoCzBekWmlK5tzRFEHdaj7eDP/Egbh4cbluHYrhA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LmyJfN+EMZfkmK8EzIaNi9Q8ZWLet5NmGqjGmxziPhyHQ1ST91sWCGRFkTwOx0enJ0SJxQF8VCG43UUWh9YCTlB0puMQClc8+eiU8nA7myXKCWg/e1VlprmkGIW2mQk2vXIkM4LtXh1EAj7Njd/arSrPr8rH9h2Spok6srnQX4Hogc4/TRHzhbLXHaDiS6llpntQbpagPCVlrT4X1P3BmM83+wwvv/dXu4bJZ8Grs81vkgYwy2JvYFDXPstmbduX8YelxrOskYvAWajECcu3YkV3uNJR+mKuavfPV7iFH7biM6GnE0sakxzYInKNHqFbed+EJSHLUpCWmekwHSWMAwKWgOz3n0xmLMz0T2ztRgscbmMAX0xEnVFHTwuhmV6wIjGfMEphplIdxeaCNBUSeYgItCqy8cKowaHMbIXl0c9Y8nUMT9vromfT3mxj0OnFWg79SP0hWn9pGGrgYDnaoo2uMnBUI/sA+0zw2OWKjulmt7VZMOppkc5tvTfMJL4FHGvi4AQ62uZgEw0hPlE+vfUi+IdQfqOlSd+T2CK1DRBitNuzF3hmVlFvpVd/k6gHPAZaxGjmVTIWxQsB6a+zjHWGKAUnMxyckj83oxKMfagonukNCeI+5XUIlLcrqWwS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c135a2d-99f9-46aa-e601-08df06fef3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:26:59.3190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tdh5BnzAhPzAUn8uJrzVK1x3Eb+v79VV+593kHXi4Pj13vQg3QYmlYloevZ7VxlXFdr6OnwGgPz/X9EzL5Pj7PKCqsTTTSyA6pF74KCC73Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9402
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=696fae14a=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI2LTA4LTI3IGF0IDE0OjM5ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IERpc2Fzc2VtYmxlIHRoZSB0ZXN0cyBhbmQgY291bnQgdGhlIFNWRSBvciBSVlYgbWVtb3J5IGFj
Y2Vzcy4gRGVsZXRlDQo+IHRoZQ0KPiBiaW5hcnkgd2hlbiB0aGUgY2hlY2sgZmFpbHMgb3RoZXJ3
aXNlIGEgc3Vic2VxdWVudCBydW4gd2lsbCBub3QgcnVuDQo+IHRoZQ0KPiBjaGVjayBhbmQgc2ls
ZW50bHkgc3VjY2VlZC4NCj4gDQo+IMKgwqDCoCBDSEVDS8KgwqAgbWVtb3J5LXJ2diBjb250YWlu
cyA3IHZlY3RvciBsb2FkcyBhbmQgNyBzdG9yZXMNCj4gDQo+IMKgwqDCoCBDSEVDS8KgwqAgbWVt
b3J5LXN2ZSBjb250YWlucyAyMCB2ZWN0b3IgbG9hZHMgYW5kIDE3IHN0b3Jlcw0KPiANCj4gVGhp
cyBpcyBhIGNvYXJzZSBjaGVjayBhbmQgY291bGQgYmUgaW1wcm92ZWQgYnkgY2hlY2tpbmcgc3Bl
Y2lmaWMNCj4gZnVuY3Rpb25zLCBhbmQgdXNpbmcgc29tZXRoaW5nIG1vcmUgcHJlY2lzZSB0aGFu
IGFuIG9wY29kZSBncmVwLg0KPiBIb3dldmVyLCBpdCB3b3VsZCBoYXZlIGNhdWdodCB0aGUgYnVn
IGZpeGVkIGluICJ0ZXN0cy90Y2cvbXVsdGlhcmNoOg0KPiBGaXgNCj4gdmVjdG9yaXNhdGlvbiBv
ZiBtZW1vcnkgdGVzdCIsIHdoaWNoIG1ha2VzIGl0IHdvcnRod2hpbGUuDQo+IA0KPiBTa2lwcGVk
IHdoZW4gbm8gY3Jvc3Mgb2JqZHVtcCB3YXMgZm91bmQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBK
b2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJh
bmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDC
oHRlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDggKysrKysrKysNCj4gwqB0ZXN0cy90Y2cvYWFyY2g2NC9NYWtlZmlsZS5zb2Z0bW11LXRh
cmdldCB8IDEgKw0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0
IHwgMSArDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvdGVzdHMvdGNnL01ha2VmaWxlLnRhcmdldCBiL3Rlc3RzL3RjZy9NYWtlZmlsZS50
YXJnZXQNCj4gaW5kZXggZDRkZDBmZWM2NTBkLi5hNWI2OTRkMmYyMWMgMTAwNjQ0DQo+IC0tLSBh
L3Rlc3RzL3RjZy9NYWtlZmlsZS50YXJnZXQNCj4gKysrIGIvdGVzdHMvdGNnL01ha2VmaWxlLnRh
cmdldA0KPiBAQCAtNzksNiArNzksMTQgQEAgY29uZGl0aW9uYWwtZGlmZi1vdXQNCj4gPcKgCQkJ
CQkJCVwNCj4gwqAJCSQoY2FsbCBkaWZmLQ0KPiBvdXQsJDEsJDIpLMKgCQkJCVwNCj4gwqAJCSQo
Y2FsbCBza2lwLXRlc3QsIiQxIGNoZWNrIiwibm8gcmVmZXJlbmNlIikpDQo+IMKgDQo+ICsjIENo
ZWNrIGFuIEVMRiBmb3IgdmVjdG9yIGxvYWQgKCQxKSBhbmQgc3RvcmUgKCQyKSBwYXR0ZXJucy4N
Cj4gKyMgRGVsZXRlZCBvbiBmYWlsdXJlIHNvIHRoZSBjaGVjayBydW5zIGFnYWluIG9uIHRoZSBu
ZXh0IG1ha2UuDQo+ICtjaGVjay12ZWN0b3Jpc2VkID0gJChpZiAkKE9CSkRVTVApLCBcDQo+ICsJ
JChjYWxsIHF1aWV0LWNvbW1hbmQsIFwNCj4gKwnCoMKgwqAgbGQ9JCQoJChPQkpEVU1QKSAtZCAk
QCB8IGdyZXAgLWNFICdbWzpzcGFjZTpdXSQxJyk7IFwNCj4gKwnCoMKgwqAgc3Q9JCQoJChPQkpE
VU1QKSAtZCAkQCB8IGdyZXAgLWNFICdbWzpzcGFjZTpdXSQyJyk7IFwNCj4gKwnCoMKgwqAgcHJp
bnRmICLCoCAlLTdzICVzXG4iIENIRUNLICIkQCBjb250YWlucyAkJGxkIHZlY3Rvcg0KPiBsb2Fk
cyBhbmQgJCRzdCBzdG9yZXMiOyBcDQo+ICsJwqDCoMKgIHRlc3QgIiQkbGQiIC1ndCAwICYmIHRl
c3QgIiQkc3QiIC1ndCAwIHx8IHsgcm0gLWYgJEA7DQo+IGV4aXQgMTsgfSkpDQo+IMKgDQo+IMKg
IyBUZXN0cyB3ZSBhcmUgYnVpbGRpbmcNCj4gwqBURVNUUz0NCj4gZGlmZiAtLWdpdCBhL3Rlc3Rz
L3RjZy9hYXJjaDY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+IGIvdGVzdHMvdGNnL2FhcmNo
NjQvTWFrZWZpbGUuc29mdG1tdS10YXJnZXQNCj4gaW5kZXggMTk2YTJhZmE1MGVlLi45OWFkMWEy
Nzk5ZDcgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3RjZy9hYXJjaDY0L01ha2VmaWxlLnNvZnRtbXUt
dGFyZ2V0DQo+ICsrKyBiL3Rlc3RzL3RjZy9hYXJjaDY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0
DQo+IEBAIC01MCw2ICs1MCw3IEBAIG1lbW9yeTogQ0ZMQUdTKz0tRENIRUNLX1VOQUxJR05FRD0x
DQo+IMKgDQo+IMKgbWVtb3J5LXN2ZTogbWVtb3J5LmMgJChMSU5LX1NDUklQVCkgJChDUlRfT0JK
UykgJChNSU5JTElCX09CSlMpDQo+IMKgCSQoQ0MpICQoQ0ZMQUdTKSAkKEVYVFJBX0NGTEFHUykg
JDwgLW8gJEAgJChMREZMQUdTKSBib290Lm8NCj4gKwkkKGNhbGwgY2hlY2stdmVjdG9yaXNlZCxs
ZDFbYmh3ZHNdLHN0MVtiaHdkXSkNCj4gwqANCj4gwqBtZW1vcnktc3ZlOiBwcml2YXRlIENGTEFH
Uys9LURDSEVDS19VTkFMSUdORUQ9MSAtbWFyY2g9YXJtdjguMS1hK3N2ZQ0KPiAtTzMNCj4gwqAN
Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0
DQo+IGIvdGVzdHMvdGNnL3Jpc2N2NjQvTWFrZWZpbGUuc29mdG1tdS10YXJnZXQNCj4gaW5kZXgg
MzAxYTZlNmU1NzAwLi41MjYyMDA3ZTM5YTUgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3RjZy9yaXNj
djY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0L01h
a2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+IEBAIC03OSw2ICs3OSw3IEBAIG1lbW9yeTogcHJpdmF0
ZSBDRkxBR1MgKz0gLURDSEVDS19VTkFMSUdORUQ9MQ0KPiDCoG1lbW9yeS1ydnY6IG1lbW9yeS5j
ICQoTElOS19TQ1JJUFQpICQoQ1JUX09CSlMpICQoTUlOSUxJQl9PQkpTKQ0KPiDCoAkkKGNhbGwg
cXVpZXQtY29tbWFuZCwgXA0KPiDCoAkgJChDQykgJChDRkxBR1MpICQoRVhUUkFfQ0ZMQUdTKSAk
PCAtbyAkQCAkKExERkxBR1MpDQo+ICQoQ1JUX09CSlMpLCBDQywgJEApDQo+ICsJJChjYWxsIGNo
ZWNrLXZlY3RvcmlzZWQsdmxlLHZzZVswLTldKQ0KPiDCoG1lbW9yeS1ydnY6IHByaXZhdGUgQ0ZM
QUdTICs9IC1EQ0hFQ0tfVU5BTElHTkVEPTEgLW1hcmNoPXJ2NjRnY3YgLU8zDQo+IMKgcnVuLW1l
bW9yeS1ydnY6IFFFTVVfQ1BVID0gcnY2NCx2PXRydWUNCj4gwqANCg==

