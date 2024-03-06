Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5743BC54798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 02:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhhDw-0004LB-Am; Tue, 05 Mar 2024 21:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rhhDt-0004Ku-Sn; Tue, 05 Mar 2024 21:41:38 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rhhDr-0007h1-Fy; Tue, 05 Mar 2024 21:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709692895; x=1741228895;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iCYqWfblRWc/89nHH14jMPzZ4arZOOp2Gqj2lz3/cNU=;
 b=P0miICQGLL12Dy2LuJx9iXnoqK7YuUaxsraH0TnN97pzTt9Dve87VYZZ
 ecSHhM+v9mqudAMOQl3nVwQdQT5i0xx4pi7V68290Gh9KKUrFMrba9Qzu
 mDRsrrSg+V1gpEIFka+njJuGHTLY7hhw138LoY5jJi8pqw5zN0Y5gj/GZ
 QM8mjwe+3xBdAp2MxaR4JOB2m/463M0ZthbviIg/hHt1z7xrFFz3blQ56
 gKqntWZcJ/j1Y5KlJBmBAXNNgnTwGmE8DWduKBo7VufoU1l3zhNci7iDB
 2Ni+Uz4tfywIZjivNv7KODAkbRZ7pde6uqOc00KlP7mOJypYvlBWPH3zN A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4455841"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4455841"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2024 18:41:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="40471474"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Mar 2024 18:41:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 18:41:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 18:41:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 18:41:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 18:41:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id54OYHF6oSjf0moZO1I4IubntSXbXuIpiuMzJRsrAeWHs3MJskFPqGFRZScVsJmziJqwleeLtpJcapgo4Ou9dmlKeFXRZKoLp3TCdEUsqu8KbV3z87PoG083PufcmMLcMHcIdMRXb/5fPI2EJuSXGm+wP12MbOhgYYGXNaPn/wtmdfCOJGQLfRz3+IqQHAyhGT+df3RcEAMzEx5I1k0Dy5jDUGBk0eakADB3muSXg7MMgbHd0vkyAf9kHDM+UU9VavVVIidsUbpzbHKRnclNOE/GqTMhUZ14kwvSILlFCwypQ+4rNLijnSFWvaPoq3Hghyw5SYc8h9olHJsWKlQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwizUWbrwVdfZv75o4qQOrpBB/ij9emI+Mef4Dwe6hs=;
 b=ZlKH7o2u8W01TIdn5+VHxQevO7UoF6cGx1hlU8atS8a+grjcWLGoPIz7ixsP6b2i4ngmfij1/OWn5lZUbZlXmlqtDgYO6iiLHK85C2bEUzvadkDohoy5bDgxqU/fuQbPFvr1JJfPDpv7bQ3lXr/NkMwiSPWiLxsr9D/VDIBELk5EdKsnQtL7b6gxy/xxvHiqZZm/nzHk2yCBCQVvBgpLRS/a1dYe89URqHXoQl1mSIeD7vjawl6ueBivD3FbolyYU5Kla6nQvVVBPzrNSrvnkzgIhyGEcYp67TUvhRyDov35c+MfHu4qtOOx2qNUgRYweiuJsOrr2sFJOAgKRQvYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12)
 by PH0PR11MB5046.namprd11.prod.outlook.com (2603:10b6:510:3b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 02:41:25 +0000
Received: from CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261]) by CH3PR11MB7895.namprd11.prod.outlook.com
 ([fe80::8ff0:84de:f95c:5261%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 02:41:25 +0000
Message-ID: <9e1b19eb-2775-4950-ad60-fbf7d92a6ac6@intel.com>
Date: Wed, 6 Mar 2024 10:41:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] hw/riscv: Add server platform reference machine
To: Conor Dooley <conor@kernel.org>
CC: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>, <andrei.warkentin@intel.com>,
 <shaolin.xie@alibaba-inc.com>, <ved@rivosinc.com>,
 <sunilvl@ventanamicro.com>, <haibo1.xu@intel.com>, <evan.chai@intel.com>,
 <yin.wang@intel.com>, <tech-server-platform@lists.riscv.org>,
 <tech-server-soc@lists.riscv.org>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-2-fei2.wu@intel.com>
 <20240306-peddling-superglue-fce995d0be84@spud>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20240306-peddling-superglue-fce995d0be84@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To CH3PR11MB7895.namprd11.prod.outlook.com
 (2603:10b6:610:12f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7895:EE_|PH0PR11MB5046:EE_
X-MS-Office365-Filtering-Correlation-Id: 037a1c58-7c1a-41f0-919e-08dc3d86ea9d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 67KN3hrP+ix9iiYkLhTc5dWDJwDgNnpJu9VkQu4WeKHBJQJNg/ZqSRbbSd+BeoGfZcO+Cf1UNHay1000oiCdt1xsJjaINWcmkjGPYE+GyvkmQagyLHT4zS5yjinD1O0f42vMcqOaJwZ8dI1b05XOgW/ATgGQaGb2hRAE2HfF4YHXy4+gAcbLEZtmLgCSkiZKhkHHSw6eXf4zzgYcX9rtz6VBZ2jeD7prFiZ2sYPmyLfgol8JJXDKsHi2XAmw/BNF2bHRpEBrwLzNzV8ufHgqKFyRUdntdSSkMmRA6LBZEY4y8jAdrrkP35famqJQLnBK6xPdZMyP1TNubrTh89fINaOC7BbKQHtIChmgeo4+6YzVnzzKhrNS463nqPh0luZe54SQ7Y82ExdEiB+6q88Y0X6RlzTjKLGl+/dkgTCtELX8a73moT44MF9GFEzF7mVZX0nammTM1oQLo2zU1zFpojldRpHCHl8elKc3QXo9Lw0Xmd++qqtQQ7WEWmsgc/jjTCFP3uXpnM8ZNpUYaOP8Jh5jZ0dUTujKDmjEdRjP+gkk8pJRF7eUOOSq7+6JUUi6ROatKtlT8H2OzmG19+NenEAHQBr4HOfWSfVrfSGy3lSA49NUGG3TyMlAaVAmvcS9O50gBymnmXNTL4megXpUIcWxkCFlybgOBXfd2D+poOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7895.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmlUVDBZRHM3SEpUdlZPMjBES2thWDNQTEcwV0dFSDBaNVY2bUYwNmRBbDlI?=
 =?utf-8?B?Mi82Y2ltemczazVKYlE2eHNzTTFMcjBnbjNwMGtlWGJIY3dIRGtjSEVwRTVr?=
 =?utf-8?B?U3BTZDAzNTBCSW15c1ZISUZ0dGxocjRBMDdEcDhUQzFCa3FNY3NyWDgzYWVB?=
 =?utf-8?B?NWp5czhld3RzdU1iZW1jSTkxMmRSS3ExMVZtMm5raEw3Vk84d2dMYnRGY1l4?=
 =?utf-8?B?Vk80Nlc4VzR0d3phYTRjYlJ4ZXplbHFvYjQ1dWdmRnpmREtCdVRNVEhGV2tK?=
 =?utf-8?B?RS8zbFppWm9QN2oxVXg5dlpaRGZIWGhoNFFTN2ZJNSszUERFQVpIVXNTTHli?=
 =?utf-8?B?KzFQRkJLZEpQRTJ6SUtuOWQwa2JqSDNXandjL2RtTVRhRFNpVGtiNFYyU0VC?=
 =?utf-8?B?NzIrVEg2QTlIQUpwdEFWSkZuQ1pxeUI3bDhGRzA1NVJJTGpUbDZYWHh0enV6?=
 =?utf-8?B?RXVLTkZBU29TNVRWQWhub05RNk1NYVd0aFhaUW15ZzhpR0tGMm1abkplaGFT?=
 =?utf-8?B?VTZVczY0OC83OU0rODhaQnFFdkhMTEJja3czVWFhalYzK3NPbHI3SnNPbWxq?=
 =?utf-8?B?YlZReVVRYTIwM2QzajhiUjZQQ2VRbW9BYkFHOVRQY0VBeTZxKzFtS0luZW1D?=
 =?utf-8?B?Y2p4QWhaZHdzcGtVNWFjV1N5S3pyYjlOdjNaU1FWMHlwSE1TdHhzdWNsa1Ba?=
 =?utf-8?B?NytJbEN5ZTNwQzVTT1VaRWZWdXNLK3VhK3BZVi9KVjFQTldid3NyYnNod09i?=
 =?utf-8?B?QXRqekNDeDNKMEduMEpmS1pta0FWUld3UVFmSHRaMDV6NisyZGtEcFVpeWFx?=
 =?utf-8?B?V0pLSHI2b1F2MW9PYTE3QTE4MElNbyt3SGdMSEdrdWxWVHpERjM3QXY0SG9X?=
 =?utf-8?B?bWc3cktQYnZmdFpmdjFGeXRqYXNid3JrWFhSOGZaQittSiswMFV5eUpmRVkx?=
 =?utf-8?B?RGlhUS81bFFSTHB3U0pHZHZaV3dLWHNJeFdVZkFNajgzYnBtNHVudkVDQm51?=
 =?utf-8?B?Y3p1ZU05RGY5LzdCc3NIUk15eVRLcDV3b2F6TG0yVEUybGZpbnBQTzJaZnFo?=
 =?utf-8?B?N24zQnpTVzQ2ek9yYzRCYnZNa0FyVDFPTlV6UG11UGNBODlOYTZQU1FJdXFH?=
 =?utf-8?B?Z2Ywb1lJcHlKOFh5TXMySGxSRk92dkxFK0lwQXlkRWwxNHQvRmUyc2ljeE5X?=
 =?utf-8?B?dUhDN1E2RnhJQ1JJSUZPd1UycWFyV0Z1dGh5V2s5bHhVcTlzY2lJN3o3V3JO?=
 =?utf-8?B?WTRsNXpRalBvNEh0Ui9vVTJaVjdabTdMcXhITUgyK1kwVkFoTVlwaFNvckJR?=
 =?utf-8?B?WkpSNHhYSitmRTJ3czY0SEc0cExPTkZoUnZjeE03TWpGUDRuUjNsRnU2Wjd2?=
 =?utf-8?B?SmtGdDF6Q2s4eEtJRTVGWEtVWExBRXdSOFFOTmx6RU03TUttZU9PK3FIVTdZ?=
 =?utf-8?B?azk4WE8wbFlmUFVhMllVSUZ6cGlDVWVtUS9MQzd4VmpES1gybXpFbzhCeXZQ?=
 =?utf-8?B?NXFRMVhMbUtsb1VVUFZ2Ym1rWEk0UzZId25rSHllZ25hUHhYdTVkc2Fqd0xI?=
 =?utf-8?B?ZDRBMm9PbWlrbkM4NTgvSlMwZ1pPUis5aWUvaXN4WjkzWjQvRGIwSkpGeVRl?=
 =?utf-8?B?QUV0b0RvMUN2cG5BZmxTeUg5V08xRk1SVGs5bE1Idk1seUdFcmo3Q0loTXZo?=
 =?utf-8?B?Wmc1ZnlXVnRLQ2lCeFQ5dzhDTWdqU1JsWnhsemJaMml4aU1pTC9GT1BSdnpa?=
 =?utf-8?B?emQrVC9DaGpEZXl1d3BoNUpla2hyazNWbmNNSk9XdUdZV0trSXo3ZmJZbWVy?=
 =?utf-8?B?ZU9ONkxFY3VFOHNmVWxaOVgvTEY4WVB3WVo1aHRTNU5HeTNqTUdjWHlSMkxB?=
 =?utf-8?B?Uk5YL1hVZlA3U1VDaHM1NXNBcW1iRkVua3QxZWVRdDEvZnN0bmlYK3BuZ3ZH?=
 =?utf-8?B?OE0xY0EyamxSNFBrSGV1RkREdFc3N0VmclBHa0YrUWZyUDN0OVlkSG5iQi9h?=
 =?utf-8?B?Y01BTzRJTG50U2Q4aG1SRUFWTThTTjFoVExHTWRtdW8wVW5SK1ROSXNhalNl?=
 =?utf-8?B?VmhYY0k0NWpzWWRTTDloNGppSGNOZDMyZmpxN3B3RGFZWC91bkNEVi9GSXZq?=
 =?utf-8?Q?HsPNC4aexme75P39yxWo1YuT+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 037a1c58-7c1a-41f0-919e-08dc3d86ea9d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 02:41:25.4388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: af37MnhF+Bvfy4Nkz6D1q8QQfypsJdfiKmmyt/tmZRJuShkZbKbzNtwBEW7CWQICju/ufQAwnCi+z1lEtPxazQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5046
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Conor,

On 3/6/2024 8:27 AM, Conor Dooley wrote:
> On Mon, Mar 04, 2024 at 06:25:39PM +0800, Fei Wu wrote:
> 
>> +        name = riscv_isa_string(cpu_ptr);
>> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
>> +        g_free(name);
> 
> Please use riscv_isa_write_fdt() here so that you populate more than the
> deprecated property here please.
> 
Sure, I saw it's been done in virt.c recently, I will catch up all the
improvements from virt.c to this board.

Thanks,
Fei.

> Thanks,
> Conor.


