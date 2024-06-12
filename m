Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C2CC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 23:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHXUO-0004NA-SS; Wed, 12 Jun 2024 19:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sHXUM-0004Mv-M3
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 19:34:46 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sHXUJ-0006wl-Uh
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 19:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718235284; x=1749771284;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Siy9PPiIyqRwl9YulYwD1VAi2V1awUtFHB1XczaSDsU=;
 b=eVbwuFAYIaF3Wtx/kqChnZZE/qsV02g7Kb7UL/5nrOviEu0D1xWOjgPi
 Y78gmRnxCTeIOZc5Gf4Ml0C6wrbqOsFWAgKIw4ndGvX/PvLV995Vhw9Jx
 2/66HZI9gGNhEwakdnYBL3Tqo4JDNCWX8JAwxZ3TuWYyCUPQ64HNWjLvH
 OBqId+iW/4uhfgO6GbSnHXKaTUduzDryVXhFUho9wzXCLrT0uRRm9mqtH
 M2uA4U/gymudyV+eFSSyvUnNbd8wZnX1K9npPTtisBC3I4z96i2RAKmP4
 o/stP5xqIGFb0Y7Ih3/Va1dYFC6lU2h+1YOME7wzCFFgxVdCDRdOcNHSL A==;
X-CSE-ConnectionGUID: MOZElTb+T1upRGDxv52uiQ==
X-CSE-MsgGUID: JcFUo6TVRXK14hTk8sZboQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14828808"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="14828808"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 16:34:40 -0700
X-CSE-ConnectionGUID: IZbtgHc8SeK1F2ysJcFoig==
X-CSE-MsgGUID: FqJ9EssbQ4eBO8zReIoxZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="44487029"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Jun 2024 16:34:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 16:34:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 16:34:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 16:34:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpUfiK1NMfnl4OAmI9X/BQEmeNvqSY8kKR8hjBjflVmwLTZxkGI+rVTfteEdoqEubK4RvGBtM4mGhuxYD4RYnvQAPcl+rqpaWR7VfAceTGdZwUsZLZQVKqXBePT/oRHfYWp0AzV1xyta57N+x3e6zf7Lk4FxUVlGEK/ASXjP/mkuce2JXzokbLXKqYB4JowwvpmqBkREqYhTP0Qybc/OAXo0aIBCB3by5C6tliz9Imu6ciaRZzPLH5oTkPFcTRLIQIDPsIU5xQvI/fg65Vjw5l5Mlft94EgDSmvvAXk+L31qxU5MAMkAO88dgZBBlGAAudehnofqlseFp8Nu6WNxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5dGrux2CQ3TCaT4RZPdaC1DLwUDr0ijrc+Rnj036O4=;
 b=jGNPRKyceq5LGGD3cr6w+nzWSrF6QTAtX1N/YBf2UjR/y+YhecrbtpmL3x0MySPkiThW2Ab4WbdTjKJApBtQ/iQEt9rw6NsFp/W6p1dF3EF3Utrkgfv9Z+pZXLhJLHNR1ZVaHLUXbuPnh6J3KfMPcGmabcwcLQxuaN4SE/TJ5z9a8zapqqTyLJ/mT1kRJQ7XY5ewn7fiKfqByMVnbmK3KZqzDORmIoGffdlLGL1iI8uuRkNqaDpYDtCbQIRN224OwmkbE41ZZAFG+kZ7nj8sJD4j5fl6NqaemkrCCvSwDK5LMabsf/7JFHFvaz1vOvhh7nwhBTpicuBxiv22eF6vhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 23:33:58 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 23:33:58 +0000
Message-ID: <0fe76150-c347-40df-8d69-18a5d132d8bc@intel.com>
Date: Wed, 12 Jun 2024 16:33:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>
References: <20240531185804.119557-1-dongwon.kim@intel.com>
 <CAJ+F1C+PG-Tf-ADFTgBGq5nvJSCEVhFW0Pk6a2Pf7gVurbJeuw@mail.gmail.com>
 <a89b283a-24e3-4117-b465-ab8d79252625@intel.com>
 <CAJ+F1CJ-4cWV81_YTit5jTEoY6FPTeu7u177pZzb61FhXw_j0Q@mail.gmail.com>
 <fa43009f-1292-49f5-bab0-618028c16045@intel.com>
 <CAJ+F1CLAJTZLHKa9_zVo=-GLRw8JHnzJT=G4fdLLsaS1sK2HUg@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1CLAJTZLHKa9_zVo=-GLRw8JHnzJT=G4fdLLsaS1sK2HUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:74::32) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|SJ0PR11MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1e0d44-98fb-4c16-4600-08dc8b3821a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDZ1NzI2UEJIRCtBMmk1bjNBRG9UTEpiL3k2UjhNalVrTjhEb3lTTDRDQnhu?=
 =?utf-8?B?dFQ0OU9rUU9kU0hTdmdPOUlwcmU3TEIyZGNwWnVqaXRGOStnUGI3MFBJTENr?=
 =?utf-8?B?MFNEM3hDNXZzZFBhanNrRkluZUoxalZnZjF3SUtsOUtHMWw5STkxd1dEbnFn?=
 =?utf-8?B?SmhvK1p2c3FJQVd4ZTZJc3dUMHJ2OEVqSm1uRE52bUREb1RLd2hUK3NNYXEw?=
 =?utf-8?B?cUVBbHN6TUNWVnY3alpzRk9lTU5BTEpjZE9oOFRUYTYydm1Ed2hIcEhsK3VI?=
 =?utf-8?B?M21kbGd6T095WmdPeGtmdWFCRDRiVUx2TmFFc0VjQmk0TWdibldBZForalVM?=
 =?utf-8?B?UVM3cVJTWWxoanBqOTE0d0gvTFpieC9xZFJLRE5qcHd0Tld5em1tTkFkYmsz?=
 =?utf-8?B?L3RmYk0xaGlQSTRyS2RPVU5FYTJkemdaVTZidTFuVDRsUEs5YTliYjVKTHpQ?=
 =?utf-8?B?eXlCV1lZa1c0VjArQjBoVC85clBEa05wNUF1cnMxWm5EeDdjSUNIM1hTZ2Ir?=
 =?utf-8?B?NytjQnhLVXlxVWZwWFBiYXNKd0lvdm1pNzRwT0ZFcHRUeDMzT2l6dUQ2NStM?=
 =?utf-8?B?d1RNblRpMmZkWWVGOW1VR3JHdFlwR0xNREZGZjRqMnhkWEhhSzY4UWNCbmlY?=
 =?utf-8?B?Y1ZKMTl3MWZkbnl2Y1RDSzlyRGEyYTRkdHZGdysvcTlDUjNIa25aNitVMUVn?=
 =?utf-8?B?dFNpNU50cGF1L01tRm1OU2F6eThlb2dEejVFcXFjeG5HSWs1aTNaTmFtQU9R?=
 =?utf-8?B?U1RtRlRsRnBKTFU0S2Njbk10bGZxc2NnYnBsSllSWmZEN1lBVjN6SWZZTnFN?=
 =?utf-8?B?OXIwbFhUMkdtbDl2dzcyaFAvdGpyeGpwZ2NINlJoMmRWc3hMcjVUODhTRXZZ?=
 =?utf-8?B?bk9GKyt5OUhnZG9RYzRjZGdDRU1qNExuaGxEYTNoY3p3MmF0UXVLeEhVd0Ni?=
 =?utf-8?B?elZGZHJDa1Q5SjM4b3piTUFJV1dVVis1bzU1T0RKcDl6MDNmMlBBd2lDRzZh?=
 =?utf-8?B?aEZLL2gwdDhiQm16MEFRWmlFQ0FMYjNOQ0VsQld6WHpIUUhjblNVSVJFNmdN?=
 =?utf-8?B?WnNlWisxQUVpdHZnNFRWZnZkM1phakRvQyt4MlZzVWtTaFBxMFc0dGtYUDZS?=
 =?utf-8?B?cVVna1lXdnVxTHdmcktDSlhnOXovdHptZ0lsN0RVUk5jTzRHS21kNzY1VGVV?=
 =?utf-8?B?dklJOUxXaWNFdzJMamc1Y2RYTVlqMm8yczBlVDFrTWE5ekdIamttTlJORTR4?=
 =?utf-8?B?T0pwSlVRaFJjZFlSeFlKazBJQTh6L1FTbUxjNnR0V0Zxbk41RmNoV2lJRDJS?=
 =?utf-8?B?QVhEOG1ET2c5TjZQc0VXeE1tSUR6WFJqM1dXRGZZNEYvNFJBT0dGcWpHdUhY?=
 =?utf-8?B?RFdKY2hnMHJqdGN0KzFZVlBvSk45N3hNUmR6bGsxTzkyT2VtQlI2YzZDdlZR?=
 =?utf-8?B?Z3RRYmxvdzlsc3JaY0JxRHFza0pEVTd4cjBRTklyYjZ4LytVVkt5NktNU2pl?=
 =?utf-8?B?MWtsTitrZ0N2Njg4eWVrUWozbG9HWk16U1NMUjA5TE1rS3B3Ykd1N3FXa3ZR?=
 =?utf-8?B?ME5NT2hvSndraDBzcDQvS1R0TGptNnQ4U1F1WkRxdVQ5NXNSMExzbWVTaThL?=
 =?utf-8?B?SlJCWk1rTWVlOWVZbTZHWGhIY3NINlludmVTVTNjQmZKTWRzVFdDZFRwV3Q1?=
 =?utf-8?Q?E8zN60xliaA9RS7KR5Fd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0ZTb3B1ZW9ZMTFBTmVVMnRTdmlpYkExOXdhRCtvUVdmanZPTEtQemY2MVhk?=
 =?utf-8?B?ZUk1YTlKSXU3MytBUSthSlVTQ0lydElnR0dtUmtPOGpFcnZHcUdHdmlRVkhL?=
 =?utf-8?B?WVp5WE5MajNYL04wTWk0UXlMbTFOR3AydzQ3ek5Bd3NJQy9JQ0pOc1NDN1Vz?=
 =?utf-8?B?a21XUVh4SEFTVDkrdnBMOTJqNGR4eWF1VXR0b0xhK0J0bTh2R3FYcEFSaWJO?=
 =?utf-8?B?cktFeGlvMWNEUXpmVXEwUDdFR1R2OWRvYVcwTjRUcVBGdDUrTnBRcHBGbW5E?=
 =?utf-8?B?a0l3UVZFNldyMHNhRGNNSG1sNGhJSFVLMEEzcWdrS0NrVkMxYytYTzRoSkk1?=
 =?utf-8?B?SVIydW5sWG40WENtZGtIeEEvVzNNc2RxZkEvekJ5cVdicnZIcFpDTHIxeDZV?=
 =?utf-8?B?a2MvMGthV2wwOFRHM2VpaGRvYTJQdjdoTXdWQjQvUjlJTjlnemh6OVlhb3FV?=
 =?utf-8?B?WGM5TEExc0xXZ01qK3pmMThHdFJvNVAzaHNCSmpsNTh5S3JhMzk5ZkN3ekNx?=
 =?utf-8?B?OXIzcFZUTVkxN2cvK2pOVG5ZSThKTTZtS0RYa0FLaDRQTFJTcitPU0NXRXBx?=
 =?utf-8?B?WVBYeUFvdVpRK3FJbitRVlhyQzBwNnVoaEl0OGpiWEVVR290Q0NXOEQ0WEpw?=
 =?utf-8?B?NE83SlBFTk1OQU4wZzJVckhmSW5vNXh1UlozdHZUclgzV0dmNjliZGp2eis3?=
 =?utf-8?B?RFlEV002dXFlaVJIY000VDIvWHJGVlNkMDFWWEFXM25QdDJscm9Mc0doVlRF?=
 =?utf-8?B?U1VVNUhJS08vUzk3Z0x0OVlaSnU5MVd5b25WS3hvNXYvam1iQ3FBNmN5ZUJY?=
 =?utf-8?B?Z2x2M1dXalNRUVNNVmZtOXlMZDVOa3J5UDFSZWFMVG1xZDhSRE4wc2UwY0hV?=
 =?utf-8?B?SUpSQnU5bHhya2VNbW83MFNWUzBENklPSVRUS0RGOVN3TmRCNXpjOFVZV3F1?=
 =?utf-8?B?cHBJM2U3alFoODRKcnFMbVFLZ1gyVmZ4ci96cUliRjBvYVdXRG1sa1VpZlJT?=
 =?utf-8?B?c3pyZ0k4UmxEM0ZxNzB6TzRkTUdkdVF6QytiZXZIc242TThqTEhtOUFDOVA2?=
 =?utf-8?B?cGpKNDE3WEx2SGR6RzFYZmdlOFoxblNDMkJYSW9RY3hXV2g4Zm14c0l6d3pW?=
 =?utf-8?B?MVgzNE9pcjlrSHpyUEtueW0xZ2NzREQ3MTc1bFNsaHhDeXJsZEpxTTMrajgx?=
 =?utf-8?B?SW5PbXZEblR5Y08vTG5DaUdORzEvM3k0dGw4bHFtWHJZRjRMcUw0WFJFTDJq?=
 =?utf-8?B?OWVLWTlpYnJIRjFkMkdML3dKMVhLV3lnZnVlVGlQNk9UeExBYlBySElySmd1?=
 =?utf-8?B?aStRNVJiVWR2a0ppU0l5ZzNiRmI2bVVhWU1JL1huYjhRM1N6YjhlZDdkZXBh?=
 =?utf-8?B?bGR5ZkZ6VnpCdkFMLzcrUVdHYTl0TG1PSXBDQ0VPQlRYRlY0Z2NpbllYTTgw?=
 =?utf-8?B?YnpOQ2Qva3dVY2hKYjR2SDljT1ZvK3A5ZFpwdjVVVjZMNnNWMmtsRmtVVGhn?=
 =?utf-8?B?RnNhYi9EVDU2STRTNjVCbnZkeXdENldEaTEyN1lsQ0xaNFJOdTRIWHV5S2Nk?=
 =?utf-8?B?MkpNY2M2dDI0dnMyVUNJZy81OWRhQ20yMnNKNE1QSXRTOHpNUWtyQkdyWXlU?=
 =?utf-8?B?bFFZak0xSmR3cExacHV6UDVRQVFqOUJsQUJ4WFpOVmdIZDJGMW1vTWZJVEN6?=
 =?utf-8?B?YytUa3EzNUF5MFBUT25IVFZuMDZtdGR1dVp4UDlLL05ET011VHVmOGtBd080?=
 =?utf-8?B?eGcwSnZwOWU2UlA4QUt0VGM5RHNlbVV0SVd3bUwwcE81ek9yNitNNGJNYjdx?=
 =?utf-8?B?Qlh4ekZoVzAvU29JWURTdEluY0NaZmI5RHhoRWJia0trZWdkSmF6U1U0M3Fq?=
 =?utf-8?B?VC93MmJMVGQ5VndyK2pnd0t6L3Z6elB3Z2lwK3BOTzBOb3VCRUJMZXBlRDkx?=
 =?utf-8?B?andocUZzalhIclNUSWNtcXhJYkY0dkZKNklPZ0ZBZm54YkhmR2szV0NvSDRW?=
 =?utf-8?B?U1J4S2lWWkFsYVdnSkNvcGNxc21XNGl1dlBCekJVUnVJTjNJZUFnTXI0Skgz?=
 =?utf-8?B?WVQ2RTd3M1ZjQWRLZzZKQTMrR2FaOW9sbUVNVVZWR3RDTXAzQUxHM214aTZJ?=
 =?utf-8?Q?HSpMQ4+5qWPyuDPwwFuYreLjH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1e0d44-98fb-4c16-4600-08dc8b3821a3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 23:33:58.0027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlWOwUM2HU8YewBhpkwupHh40eLpotXOpKNGHgVxGlF1j5JPgugFlhgJr9BmiLYNoNBa7zofejSnOFw9F7dYqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4910
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/11/2024 11:42 PM, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jun 11, 2024 at 10:28 PM Kim, Dongwon <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     Hi Marc-André,
> 
>     On 6/5/2024 12:26 AM, Marc-André Lureau wrote:
>      > Hi
>      >
>      > On Tue, Jun 4, 2024 at 9:59 PM Kim, Dongwon
>     <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>
>      > <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>> wrote:
> 
>      > Xorg may not be going away soon, but it's used less and less. As
>     one of
>      > the developers, I am no longer running/testing it for a long time. I
>      > wish we would just drop its support tbh.
> 
>     There are features offered by Xorg that are not offered by Wayland
>     compositors and again, we have customers that rely on these features.
>     One of them is the ability to position the window via
>     gtk_window_set_position(). There are strong arguments
>     made on either side when it comes to window positioning:
>     https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests/247 <https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests/247>
> 
>     Until there is a way to do this with Wayland compositors, we have to
>     unfortunately rely on Gnome + Xorg.
> 
> 
> It's a smaller and smaller number of users. The potential/future users 
> are greater if we focus on Wayland.

Right, but until Gtk + Wayland offers the same feature parity and 
customization as that of Gtk + Xorg, there will be distros/users that 
will keep it alive.
> 
> Fwiw, GNOME (and RHEL) is set to drop Xorg support 
> (https://gitlab.gnome.org/GNOME/gnome-session/-/merge_requests/98 
> <https://gitlab.gnome.org/GNOME/gnome-session/-/merge_requests/98>)

Doesn't look like it is going to happen anytime soon given the massive 
pushback.

> 
> Btw, there is a similar monitor-mapping functionality implemented in 
> virt-viewer/remote-viewer: 
> https://www.mankier.com/1/virt-viewer#Configuration 
> <https://www.mankier.com/1/virt-viewer#Configuration>. Is this something 
> that those users could use instead?

It looks a bit similar and interesting but one difference is that our 
feature uses monitor labels such as DP-1, HDMI-2 which is a bit more 
intuitive. And, the other key difference is that our feature includes 
"hotplug" functionality where a Guest display/window is deeply tied to a
physical monitor to make it appear to the guest that it is dealing with 
a real physical monitor.

In other words, when the physical monitor is unplugged, the associated 
guest display/window gets destroyed/hidden and gets recreated/shown when 
the monitor is hotplugged again.

> 
> 
> -- 
> Marc-André Lureau


