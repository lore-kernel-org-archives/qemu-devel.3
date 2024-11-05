Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3F0D1CA3F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 07:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8EDr-00048G-R3; Tue, 05 Nov 2024 02:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t8EDb-000432-Pw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:43:15 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t8EDZ-0000iG-SK
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 02:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730792594; x=1762328594;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HjmCfQUcr1ClgvS6+0SaZJ383bXExJBWjboO6yRdB/0=;
 b=NI6ma7cPSA9dB+Ydj46mvoEkqQK/mp9ulUrrA6JOb6VAnXkFLbUjwfAX
 dRjF3DtiIU+VD0UJW1AYi9sACCE6eZ43Rb8va6AhGQKwGo0Low+7DJfV0
 xbm9Ttrcwy8rOM/kFWZvc/2oc25qobn7WR/o7su2YYX7qwrIxCHVt/Kra
 kUrhGyWpdKtxOhuoFTqpXa3JVYysyodHY+a5uebhnkaxSxJqgPAa1kdfi
 qlBUyQPq7ZW2ZdA9Qh0xZZNxnhu6WmVCY59uH/THe0nW4qi9gGcIW/vIN
 twFdJ6yZFbM28ozP8JIuBJAswdrwG/I7PKH7WCEpfzbIPZPkcRhn0dCVp g==;
X-CSE-ConnectionGUID: TMyWDw/jRp+KABQR8ULPNg==
X-CSE-MsgGUID: 92Sz02K1RKqzSFBtCnS/lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30630987"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="30630987"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 23:43:12 -0800
X-CSE-ConnectionGUID: 918vJhP4Sp2lihn2MCCFvw==
X-CSE-MsgGUID: 1OLfhj0iQ1GivxpB+68EKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="84022246"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 23:43:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 23:43:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 23:43:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 23:43:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDFYYTvLzZXTBDOli5kthZigWbtgu/mD/E/uXdTUhuu8HWU0m2LgUCptoiqXKEobCtA6KOiUMIupPMehOl9e4ZUspTnqt8IoIl4LMn85nxcsWMI0L3Dxg3VJQK8qzuX8wkh6WnRUNNvbAiVve1ZLoMcU/zFeNG/OszJ0U1RLR6uvCBX2YBJvmf4HQhUTt6XeTVSFyGwdORvUdZaJ3H5HXT1ANCcY/2dENEYyE2ta+OfjvuTGHG4eNjoAHP2Q+UQb3kJvTQElghtqIo2mANVz9Lgg+NfY0R7VAru0ONpcU+lqE45DlhRRH3H77Iy9BvCPbugVxPYjvz6wQINidzC9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjmCfQUcr1ClgvS6+0SaZJ383bXExJBWjboO6yRdB/0=;
 b=lB/nJZk4l8jJ6pqkzI8poIjsI0zYmZZMbslSIvnueZZH3dvnRRqXOT/w1STxf/wIevF5x8I25BKKHpeCF2NMB2IU30DNUpgJEY/whEAofvkRJWiOvQVpIQnt2rSJKxtH0orTqNFTql4jTMAvRPcSWow+Q5REPMvsvV14MWvIhaHAkYRAkBG2jXM6mJSM7Rd9k0VRObjz2MKykdcY6GVDQXTPL+F1Tz63JiqllCV9hIWXmhlzl1yIBVYcCXTnNTt/QemlIbFTP7fHQk8thcpTsgOyTolyBsKj9Hb+iFPKs+stWZyJky3CwFED2vpuyPT39UojxiVeDfmxlkEHEHrCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7744.namprd11.prod.outlook.com (2603:10b6:208:409::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 07:43:08 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 07:43:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Thread-Topic: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Thread-Index: AQHbLrllsz/Poj6ktkWylIhCzxfopbKoIyaAgAAQvkCAAAyXAIAADkvQ
Date: Tue, 5 Nov 2024 07:43:08 +0000
Message-ID: <SJ0PR11MB6744D2E0F2ED1DA92058466392522@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-3-zhenzhong.duan@intel.com>
 <0e8716db-9a3a-4007-823b-6b0ef5ad455b@intel.com>
 <SJ0PR11MB6744D1EA9FCE89F58E83F7B692522@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <e425e750-bc4f-44c8-8d99-621f98dea7de@intel.com>
In-Reply-To: <e425e750-bc4f-44c8-8d99-621f98dea7de@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7744:EE_
x-ms-office365-filtering-correlation-id: d089d733-bd2f-4d2d-6b66-08dcfd6d7db4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YUFTZ0xjdzEvRHE3STYyUW13QVY1MEI3QjNPbTU4Z0hseUZhditBdWJMNjJG?=
 =?utf-8?B?ck5PT1R3a0oxSWdTTnQ0dWdFNTM2dHdlaC9EYVVZNTB6TkJKeCtLbnU1Y0NM?=
 =?utf-8?B?UVNHL2VEamY2aFVla1ZsVmx3ckNwVGM3d1hXZytQSzc3cG9uMUpocm95Wk5E?=
 =?utf-8?B?VHU0U2Z2dHFtUm1NdkhCa0FzaS9mMjkrbnU0RnJmaUk5SnZ6VlF4TEVLZ3dU?=
 =?utf-8?B?QkZBQ2hUMU9VamRXcklvSG9mMWJGY2liT0x3T2NwcGt0RUVhcHltSDhacC9w?=
 =?utf-8?B?NHd3blh2Y2hva1h5K3NabnFsSkQyTVhnZGNTd3dzWVJ5WllMdkhQeUVLSVIv?=
 =?utf-8?B?VTVTV0xCRWo4Zkxac2xzbkYwSkJvMXN3S05kNGZzOXZLT2pYYmtNMmZTam1x?=
 =?utf-8?B?cUs4Vm4yNXU5MDJYdEt2RThzYnlVaGRpeGVXdFZOQmhWNFlxNEthTEVyZ0FI?=
 =?utf-8?B?M1ZXT3hqcExFT0QzNk5tdlkvcjhIclRNSlNOTDNSZis3czJDZTdLMEZRbGRZ?=
 =?utf-8?B?MHJlcmI0enhZKzZ5bHlmUzVWaUhIS0hLYmZuSEpYK24rbU5TK2xIWXAvZXlq?=
 =?utf-8?B?UHB6c1pYWllhVTR1REpzdEIzSmxzYlNNbGY3Tk85R1I1WkZudlpNR1lTcVVj?=
 =?utf-8?B?R0dQUDh5dUttUy9PZUxnV2dXN2I3aHAzOGh6K1V1S05VeWFza2lzU2ZLVDNG?=
 =?utf-8?B?dXl2aWpkalpvdnJLVDVYQlVVMEdhbnBUUGUvQVJlZVNjUHJ5bCtjSjlWU1Mw?=
 =?utf-8?B?SWxKTFpwaldkMklQWm9rNFhDYXJMOW9MeFYrRnR6bFNsRDFsUVlTRWR1VXVm?=
 =?utf-8?B?QzFtMU91L1gwTUozQTFPTlFMc1lFcjJ2ak5mbTNybEVyMHVWTko1Y3dsY1cw?=
 =?utf-8?B?RHJhWHM4WnNCbEF1VlkzamhLL0YrWXlCaCs4MjFkZjdEL2o1RG9URE1ad3I4?=
 =?utf-8?B?TmhpQUNJcUpIbjkrNG5tbGRTa3BwN3Vtb1F5andpYVZvU1BSM2VGem5IWmxv?=
 =?utf-8?B?a2taRFE4WWpGNDhoSDdFakdxSTM5RGk0ck4zbGN5R1JTWHVYTDE2L2pCRzYv?=
 =?utf-8?B?bERvYzdsODF4eE1jMUdqVGh4citNU0h6U001TG1nUEIxTWxwMHdFR0JGbkJj?=
 =?utf-8?B?N1B4VlRhTHJud25sdlVkTkxRT3daK2JoaTQzc0RZZDlpdzRINURMbVMvUm1V?=
 =?utf-8?B?K3lmNGxLMlJ0N2Q1Nkt6UFVMNldrTk1DQWN4bEl1NEFxUjRrdk1nWmVpL3Vy?=
 =?utf-8?B?aDg1R0dzdGh1dnBNRm43akNxNGhZTTM1ZFpBYnZrcHJxYVBiQndzUzZ0aUdZ?=
 =?utf-8?B?MDlYbm53cFlSNlAvdWpvZFBIS3hWSjBxSFliSGlGRTR5YzFRd2pSamZBTUMz?=
 =?utf-8?B?K2dZS0JVNGdUWjNSQmZsUC8vYmJQMlFuUDg1OEFmNFE4L3IyVzhJSkZGakdR?=
 =?utf-8?B?OUF5ZGN3WWk4WXU3N1dBUXFSSzBVaTZWU1QyVGhMZEJuVE5FY1FSbE1mVW5P?=
 =?utf-8?B?L01hNUQ0eDFNKzdlTlVGL2h0TXAwZFJyakQvYTNzTm9hTm1TN256M09LeHhY?=
 =?utf-8?B?RzVpN3VxOTJGUnZEaGhZQ2RKb3I2L2c1TXFObEFGQk8vbWhHZG51eVVwR29p?=
 =?utf-8?B?em1jMkVZNTVLL1RGVWRuYUJlSjVVdnVHcitaSSswUndNWUxKREpBMW9aZXpR?=
 =?utf-8?B?SXBIOXZIWU1TZDRqY0lZTXVNWldxYW5iTmRhVnZ1WUtYclVjZmlZSWU2TFhX?=
 =?utf-8?B?aXFoQXhjYW10SFNsTXpVbHlDSjU4K0FkUmxzNy80WkMvOUZGRVhXTW5yTi9H?=
 =?utf-8?Q?u+zKk12xxK3s4BIoceKEUTqxWSEelGvNI+RcI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXlLZVkyUXdRakJiVUg1NkN4eGhJanFsbUNpRGhkaEJwL29qUnlvL2FOeU01?=
 =?utf-8?B?VDk4Q2FFTCtJVllaS2UwM3FSNU1EeDNJZ3pCaFZRSGhGdDNYTW9yNitmOWZH?=
 =?utf-8?B?RTkxVGdkbUJ0eWFpdXFTWXgvdk1ReWZHbmZ5cHdDM09scGVaMytGZFNtTExR?=
 =?utf-8?B?YVlPejJzVVIvdmE0cnpzVHlIaUtsbkdtOFppMkVYQ0lncXFzdFVVZll3Y2pX?=
 =?utf-8?B?VW1ydDBYbjNaMXJOTGFuNGNRZktPQW44N3prNlJXNEVTRWVhZWt4Z0wxMHJq?=
 =?utf-8?B?dzN0K1ByS3FJWUh3QzZJK0tmSFNPbXBVZVd6dnVpdkJyMDhjbVNIQ1pOaTB5?=
 =?utf-8?B?akhiREdRNkNTN01RNVV2UlBFcmNaNnJwUUZHRHF6aHFCWVMwbE5VL2gxTHhV?=
 =?utf-8?B?NUFTdEJvRUtuWGFzNEJPWmJwUFEzaFJNQ01qZjV0OXRVMjU1a3hBY0huMjFr?=
 =?utf-8?B?d0FhbnJqVnVRQ1RBOFArQVBtL21UcWpKK1k1T2ZzVlQ2TnU3VmxrUUNGSjlo?=
 =?utf-8?B?dUQ0NVdUbVhpbzBSMC92V1FTdjd0cVhSZ044QTljNVhMcTMwQ09TdFVRN1pw?=
 =?utf-8?B?ZHpCZEZ6RG13N0dBMW9ycU1JS1phcXBCVzMxUVRpNndoU0dvQm0xR2t2czN2?=
 =?utf-8?B?bXVNdkdoNjB1WVM2YkJYc21kS2x1encrTGJXMnlnZEpQOU9TNkdpL24xQ2N1?=
 =?utf-8?B?dWJUM29PeVMxcjEzY1kxSTVQbWdycVViYnUwbnVNNW5hSGkvckVHYWtkanJ2?=
 =?utf-8?B?TzFUblFSV1djSUh1MlBOU3hkTGJISnFaQ2c0ODQ2S3Roemg2MUNUTWhoMUVt?=
 =?utf-8?B?aVJ6dGJOV0JuWTNJb1IrbzNNRkF5aXdCZm5TNmI5aEFoU3BjcjhVQytRd1Ro?=
 =?utf-8?B?RVkrZDJHWDlYQjJERzBQQ291L2l3dGY1Z3lZa2lmeWhoNEI4TXZPVFFkSStS?=
 =?utf-8?B?Z1M1WXAvVnp3YlliamRKY1NKN1J4N241aGJVVmU0dTdZODQ5bjVLNGxmNHh6?=
 =?utf-8?B?MHZkNTFzQ0ZMTFdOclhLSkdaZmlHYkJQSUhLUXhuTXVJSzkrZ2VFaG55L1Fs?=
 =?utf-8?B?TkY2REZLcXNZeU1rRVFXQXZpQm1tTkFHSnN6Nm82V3lUZkFPVWRpWjd1UCtE?=
 =?utf-8?B?Y01vVzNRemRoTXpKVFo2S1lNdHY2U0ZaeVVacWV6bTYxMkxvSTVzMXRYaTJ5?=
 =?utf-8?B?OWxmcGFZdENEdTVRNXQ1YnJoa0Q4TjNIdGZjWmJheGpWazBPdXRrelRTMXp6?=
 =?utf-8?B?UDYyZ3BBa2pQbXpJa1JSS2dLdXVGV0xzamhnNVJXZjE5UFpoZXNOa2NwTzlF?=
 =?utf-8?B?VlV3RWo4NlAwV0FvcUFaSldrcHZ4OFRWc0RFSU11T3cxME1MUFViY05HTUN2?=
 =?utf-8?B?NElzajRXZVJRWEFmVXFENGhWL1RUN3cwektXMldoYzhZV1JKbFFlK0ovQWFF?=
 =?utf-8?B?ZmlYcHF6RlN1UmFOQ20rTC9udTFtWExZVmJhcE9MYmJONk1YT012dVJyNEJN?=
 =?utf-8?B?WVBTcFZDS3RuUml5anBIVU1KTDJjTGxCYjdtQjA1K3grOTFOQjFzYnRjTEEy?=
 =?utf-8?B?YUloTnpjd05HWWpja1NVOFNDdlF5TXpCUHM3TXNUOUZGTnhuTnMvb3BEMk93?=
 =?utf-8?B?cUUyZUliSTFaMFdtSisrMVNSU1N6QnBoMFpvVC9JN21SbUUzRitEUTErczU0?=
 =?utf-8?B?bWw3QStnRTlFNmlXUW90UExBOSsreCtEaWtqVmhzUjhtMW9tNzF2dXlzL2F0?=
 =?utf-8?B?bnBCTFpUYjc5T2FSYmtUdzRGODBYbUhWckU1UlFxZ0lCK0o3NXB0MXoyMjZN?=
 =?utf-8?B?OFMrMU5Tcm11UXBIRENESEJNdVNOa0luOGtYY3YrY0Q2K0t4YkhlSkpGUTRy?=
 =?utf-8?B?V1lPaUkrbElqVUhyUXVBcXZqeE4xejNaR0xaVEtKTUF1TERZNGhydVBIdG1p?=
 =?utf-8?B?Qk8zcXVsVUIxSk0veStpMFY2WGZNUUpTZ1JJUENWSnR2TkFIaUg2ZThpM2Zr?=
 =?utf-8?B?c09Ld25rSHlJT2FNQUpZRkRCUTVseVJLWTFiNi9SQ0RoQ3Rmc1pVcnNJK09a?=
 =?utf-8?B?bDdTWEpBQXBvZDBURnhyVUdocndYci9LeG1jL0RoREVobHkrNVQ5WnYyTGVW?=
 =?utf-8?Q?0eHWMiMXLRgkc6ywK3M0RWL/l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d089d733-bd2f-4d2d-6b66-08dcfd6d7db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 07:43:08.1601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7B70NuThBwSErqXb8AMyqfzUVyUBpOOj6YUs99ZIMo5ZOjj6dzLFVO7ZsIJgBnbUfmsBVOKtpI8amCezolvQHYq4e4khAHuDTe6ldjIYG5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7744
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDUsIDIwMjQgMjo1MCBQTQ0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBpbnRlbF9pb21tdTogQWRkIG1pc3NlZCBzYW5pdHkg
Y2hlY2sgZm9yIDI1Ni1iaXQNCj5pbnZhbGlkYXRpb24gcXVldWUNCj4NCj5PbiAyMDI0LzExLzUg
MTQ6MTIsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+
Pj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgNSwgMjAyNCAxOjA1IFBNDQo+Pj4gU3ViamVjdDog
UmU6IFtQQVRDSCAyLzNdIGludGVsX2lvbW11OiBBZGQgbWlzc2VkIHNhbml0eSBjaGVjayBmb3Ig
MjU2LWJpdA0KPj4+IGludmFsaWRhdGlvbiBxdWV1ZQ0KPj4+DQo+Pj4gT24gMjAyNC8xMS80IDIw
OjU1LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gQWNjb3JkaW5nIHRvIFZURCBzcGVjLCBh
IDI1Ni1iaXQgZGVzY3JpcHRvciB3aWxsIHJlc3VsdCBpbiBhbiBpbnZhbGlkDQo+Pj4+IGRlc2Ny
aXB0b3IgZXJyb3IgaWYgc3VibWl0dGVkIGluIGFuIElRIHRoYXQgaXMgc2V0dXAgdG8gcHJvdmlk
ZSBoYXJkd2FyZQ0KPj4+PiB3aXRoIDEyOC1iaXQgZGVzY3JpcHRvcnMgKElRQV9SRUcuRFc9MCku
IE1lYW53aGlsZSwgdGhlcmUgYXJlIG9sZCBpbnYgZGVzYw0KPj4+PiB0eXBlcyAoZS5nLiBpb3Rs
Yl9pbnZfZGVzYykgdGhhdCBjYW4gYmUgZWl0aGVyIDEyOGJpdHMgb3IgMjU2Yml0cy4gSWYgYQ0K
Pj4+PiAxMjgtYml0IHZlcnNpb24gb2YgdGhpcyBkZXNjcmlwdG9yIGlzIHN1Ym1pdHRlZCBpbnRv
IGFuIElRIHRoYXQgaXMgc2V0dXANCj4+Pj4gdG8gcHJvdmlkZSBoYXJkd2FyZSB3aXRoIDI1Ni1i
aXQgZGVzY3JpcHRvcnMgd2lsbCBhbHNvIHJlc3VsdCBpbiBhbiBpbnZhbGlkDQo+Pj4+IGRlc2Ny
aXB0b3IgZXJyb3IuDQo+Pj4+DQo+Pj4+IFRoZSAybmQgd2lsbCBiZSBjYXB0dXJlZCBieSB0aGUg
dGFpbCByZWdpc3RlciB1cGRhdGUuIFNvIHdlIG9ubHkgbmVlZCB0bw0KPj4+PiBmb2N1cyBvbiB0
aGUgMXN0Lg0KPj4+Pg0KPj4+PiBCZWNhdXNlIHRoZSByZXNlcnZlZCBiaXQgY2hlY2sgYmV0d2Vl
biBkaWZmZXJlbnQgdHlwZXMgb2YgaW52YWxpZGF0aW9uIGRlc2MNCj4+Pj4gYXJlIGNvbW1vbiwg
c28gaW50cm9kdWNlIGEgY29tbW9uIGZ1bmN0aW9uDQo+dnRkX2ludl9kZXNjX3Jlc2VydmVkX2No
ZWNrKCkNCj4+Pj4gdG8gZG8gYWxsIHRoZSBjaGVja3MgYW5kIHBhc3MgdGhlIGRpZmZlcmVuY2Vz
IGFzIHBhcmFtZXRlcnMuDQo+Pj4+DQo+Pj4+IFdpdGggdGhpcyBjaGFuZ2UsIG5lZWQgdG8gcmVw
bGFjZSBlcnJvcl9yZXBvcnRfb25jZSgpIGNhbGwgd2l0aCBlcnJvcl9yZXBvcnQoKQ0KPj4+PiB0
byBjYXRjaCBkaWZmZXJlbnQgY2FsbCBzaXRlcy4gVGhpcyBpc24ndCBhbiBpc3N1ZSBhcyBlcnJv
cl9yZXBvcnRfb25jZSgpDQo+Pj4+IGhlcmUgaXMgbWFpbmx5IHVzZWQgdG8gaGVscCBkZWJ1ZyBn
dWVzdCBlcnJvciwgYnV0IGl0IG9ubHkgZHVtcHMgb25jZSBpbg0KPj4+PiBxZW11IGxpZmUgY3lj
bGUgYW5kIGRvZXNuJ3QgaGVscCBtdWNoLCB3ZSBuZWVkIGVycm9yX3JlcG9ydCgpIGluc3RlYWQu
DQo+Pj4+DQo+Pj4+IEZpeGVzOiBjMGMxZDM1MTg0OWIgKCJpbnRlbF9pb21tdTogYWRkIDI1NiBi
aXRzIHFpX2Rlc2Mgc3VwcG9ydCIpDQo+Pj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxp
dUBpbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhv
bmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmggfCAgMSArDQo+Pj4+ICAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAg
ICB8IDgwICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4+Pj4gICAgMiBmaWxl
cyBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4g
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPmIvaHcvaTM4Ni9p
bnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+IGluZGV4IDJmOWJjMDE0N2QuLjc1Y2NkNTAxYjAg
MTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+PiAr
KysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4gQEAgLTM1Niw2ICszNTYs
NyBAQCB1bmlvbiBWVERJbnZEZXNjIHsNCj4+Pj4gICAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNj
IFZUREludkRlc2M7DQo+Pj4+DQo+Pj4+ICAgIC8qIE1hc2tzIGZvciBzdHJ1Y3QgVlRESW52RGVz
YyAqLw0KPj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfQUxMX09ORSAgICAgICAgICAgIC0xVUxM
DQo+Pj4+ICAgICNkZWZpbmUgVlREX0lOVl9ERVNDX1RZUEUodmFsKSAgICAgICAgICAoKCgodmFs
KSA+PiA1KSAmIDB4NzBVTEwpIHwgXA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICgodmFsKSAmIDB4ZlVMTCkpDQo+Pj4+ICAgICNkZWZpbmUgVlREX0lO
Vl9ERVNDX0NDICAgICAgICAgICAgICAgICAweDEgLyogQ29udGV4dC1jYWNoZSBJbnZhbGlkYXRl
IERlc2MNCj4qLw0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+IGluZGV4IDFlY2ZlNDc5NjMuLjJmYzM4NjY0MzMgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiArKysgYi9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4+Pj4gQEAgLTI1MzIsMTUgKzI1MzIsNTEgQEAgc3RhdGljIGJvb2wg
dnRkX2dldF9pbnZfZGVzYyhJbnRlbElPTU1VU3RhdGUNCj4qcywNCj4+Pj4gICAgICAgIHJldHVy
biB0cnVlOw0KPj4+PiAgICB9DQo+Pj4+DQo+Pj4+ICtzdGF0aWMgYm9vbCB2dGRfaW52X2Rlc2Nf
cmVzZXJ2ZWRfY2hlY2soSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFZUREludkRlc2MgKmludl9kZXNjLA0KPj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IG1hc2tbNF0sIGJv
b2wgZHcsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3QgY2hhciAqZnVuY19uYW1lLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnN0IGNoYXIgKmRlc2NfdHlwZSkNCj4+Pj4gK3sNCj4+Pj4gKyAgICBpZiAo
cy0+aXFfZHcpIHsNCj4+Pj4gKyAgICAgICAgaWYgKGludl9kZXNjLT52YWxbMF0gJiBtYXNrWzBd
IHx8IGludl9kZXNjLT52YWxbMV0gJiBtYXNrWzFdIHx8DQo+Pj4+ICsgICAgICAgICAgICBpbnZf
ZGVzYy0+dmFsWzJdICYgbWFza1syXSB8fCBpbnZfZGVzYy0+dmFsWzNdICYgbWFza1szXSkgew0K
Pj4+PiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCIlczogaW52YWxpZCAlcyBkZXNjIHZhbFsz
XTogMHglIlBSSXg2NA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICIgdmFsWzJdOiAw
eCUiUFJJeDY0IiB2YWxbMV09MHglIlBSSXg2NA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICIgdmFsWzBdPTB4JSJQUkl4NjQiIChyZXNlcnZlZCBub256ZXJvKSIsDQo+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgZnVuY19uYW1lLCBkZXNjX3R5cGUsIGludl9kZXNjLT52YWxb
M10sDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgaW52X2Rlc2MtPnZhbFsyXSwgaW52
X2Rlc2MtPnZhbFsxXSwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBpbnZfZGVzYy0+
dmFsWzBdKTsNCj4+Pj4gKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+Pj4gKyAgICAgICAg
fQ0KPj4+PiArICAgIH0gZWxzZSB7DQo+Pj4+ICsgICAgICAgIGlmIChkdykgew0KPj4+PiArICAg
ICAgICAgICAgZXJyb3JfcmVwb3J0KCIlczogMjU2LWJpdCAlcyBkZXNjIGluIDEyOC1iaXQgaW52
YWxpZGF0aW9uIHF1ZXVlIiwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jX25h
bWUsIGRlc2NfdHlwZSk7DQo+Pj4+ICsgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+Pj4+ICsg
ICAgICAgIH0NCj4+Pj4gKw0KPj4+DQo+Pj4gSWYgYSByZXNwaW4gaXMgbWFkZSwgSSdkIHByZWZl
ciB0byBtb3ZlIHRoaXMgY2hlY2sgb3V0IG9mIHRoaXMgaGVscGVyIHNpbmNlDQo+Pj4gaXQncyBu
b3QgYWJvdXQgcmVzZXJ2ZWQgYml0IGNoZWNrLiBBbm90aGVyIHJlYXNvbiBpcyB5b3UgY2Fubm90
IGZpbmQgYSBnb29kDQo+Pj4gbmFtaW5nIGZvciB0aGUgQGR3IHBhcmFtZXRlci4gSXQncyBjb25m
dXNpbmcgYXMgcy0+aXFfZHcgaXMgY2hlY2tlZCBhcw0KPj4+IHdlbGwuIFNvIHB1dCB0aGlzIGNo
ZWNrIG91dCBvZiB0aGlzIGhlbHBlciBtYXkgYmUgYmV0dGVyLg0KPj4NCj4+IEkgc2VlLCBAZHcg
aGludHMgaW52IGRlc2Mgc2l6ZSwgcy0+aXFfZHcgaGludHMgdGhlIGludiBxdWV1ZSBlbGVtZW50
IHNpemUuDQo+PiBNb3ZpbmcgdGhhdCBjaGVjayBvdXQgd2lsbCBwcm9kdWNlIGR1cGxpY2F0ZSBj
b2RlIGZvciBWVERfSU5WX0RFU0NfUEMsDQo+PiBWVERfSU5WX0RFU0NfUElPVExCIGFuZCBWVERf
SU5WX0RFU0NfREVWX1BJT1RMQiBoYW5kbGVycy4NCj4+IE1heWJlIHMvIHZ0ZF9pbnZfZGVzY19y
ZXNlcnZlZF9jaGVjay8gdnRkX2ludl9kZXNjX3Nhbml0eV9jaGVjaz8NCj4NCj5pbiB0aGF0IGNh
c2UsIHJlbmFtaW5nIEBkdyB0byBzb21ldGhpbmcgZGlmZmVyZW50IHdvdWxkIGJlIGJldHRlci4g
QXQNCj50aGUgZmlyc3QgZ2xhbmNlLCBJIHdhcyB3b25kZXJpbmcgaWYgYW55dGhpbmcgd3Jvbmcg
aGVyZSBzaW5jZSBkdyBpcw0KPmNoZWNrZWQgdHdpY2UuLiBQZXJoYXBzICdwX2ludl90eXBlJyBh
cyBhbGwgdGhlIDI1NmJpdHMgdHlwZXMgYXJlIGZvcg0KPnBhc2lkIHJlbGF0ZWQuIEFkZCBhIGRl
c2NyaXB0aW9uIGZvciB0aGlzIGhlbHBlciB3b3VsZCBiZSBuaWNlIGFzIHdlbGwuDQo+VGhpcyBj
YW4gZG9jdW1lbnQgd2hhdCBlYWNoIHBhcmFtZXRlciBtZWFucy4NCg0KWWVzLCBnb29kIHN1Z2dl
c3Rpb25zLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

