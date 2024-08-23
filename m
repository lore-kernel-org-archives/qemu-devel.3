Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F66C5321D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 16:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shX55-0004es-Us; Fri, 23 Aug 2024 12:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shX54-0004dY-S2; Fri, 23 Aug 2024 12:24:06 -0400
Received: from mail-bn7nam10on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2009::625]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shX52-0005k5-W2; Fri, 23 Aug 2024 12:24:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5ZpK6eAF/8+c7qzwQiETptotg248UmoxSBV20Js1YNW1+g4QKnmv8cgARUxf8m7cYK5NcCdfv/InJXrqwO0XHM+cdCGMH8XBI2qjEHr8EVUv+Rj9djoXkTF0GoD3W2xBRT2uDzOU8Yh99tsz3cYv4DvSFV2H0MqZF3mQDayjbJToalsx0dzhZvSbVEbWxVIyqn5MFm3zln44WFSameDNoH+9imq56LtHS8OhJDXBU1anKiFkB004+xl3cekYmewTUfqZt2iMn/j8xmkKlhTjcPXViYsDp/0ySfv96/Pqk63pMCKFEqyMezvjCrnpI6041MgeT0qCWfR60KR67L0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF5ORAR7+8oXjWLQXhu9Xv8bqfNMUBVVIy1ks5OB4QI=;
 b=ydXSwXmQBCTLzWYNyVHLe6s0is5YMeSGhw3JQ5h8IkfD3Y5hi0jpqeInj5LSEqKJiJowX96jde/xL4hAKEnyvuSBzYLF6EfwSKZEvID8Hl58cmCZd8Cvjkls+nK80qEyJoDVaAwdcecPXPNVtVRz6UdwZLy06d4DqQ4ltz9t+/RVMv1QVRMLhOwloUHlKEX4eer38Lpll8IBe69AXrwSczbnzeLHWcSnCauQ3h7PFn9WDAQqREdTzQPeUGaW9pca3bisEK4q9BBhih2fW55jQZCn5FUp9TOWtcUf9Ac4zKIMjDLWINZiBSPIdC6zpToR3EW1o8Le7UFju1lQF5LdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF5ORAR7+8oXjWLQXhu9Xv8bqfNMUBVVIy1ks5OB4QI=;
 b=VEvVse7bPxcdX/IRR0vd10BKO/RqN0W5Rwkxa5nFaGAiwrNaupdLXYgrv95boZvx69IUT6W6F7dBxeiqXdpRkJuHADqgugKg80suVSIk+1Py/9P3U5BwuaKBJGFkE8Qk6QKSpQtfYmZuYjEwiGQgy60a8jO4z/9RI7KWx6/4Q0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 16:24:00 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 16:24:00 +0000
Date: Fri, 23 Aug 2024 18:23:53 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH for-9.2 4/6] hw/nvram/xlnx-zynqmp-efuse: Call
 register_finalize_block
Message-ID: <Zsi3mUs1XI4bgI95@xse-figlesia-l2.amd.com>
References: <20240822162127.705879-1-peter.maydell@linaro.org>
 <20240822162127.705879-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822162127.705879-5-peter.maydell@linaro.org>
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: d838dfca-8b17-4657-38a9-08dcc38ffe9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGVOVUZ6cERyMzFvWEwrOHZlMUlsaFBqQ3hhK3B6c0tTVkZJU0o2eUtBaW42?=
 =?utf-8?B?M2FMOXk5S0toRXlRL3E0ZDNOdVpCQVQyNFdNV3VsbStiTW9xQlNybTY0cFRS?=
 =?utf-8?B?R1JOWFhrZzFaRW9mOGJIcUpxa1FsYXZ2eWM5U3Niem1kS29TTEFaQ0RTVHRt?=
 =?utf-8?B?UUdYUDJGOU1IaEZwMktFN0wvQkdKVjBxY3FwUndRdzlWK0dlUUxKRVUyMHZX?=
 =?utf-8?B?WW12Y2hoRHRtcmZKUkFNT0NMZHNzQ0xmbStPdlpYTkZPNHluR2FIZGRnVGdt?=
 =?utf-8?B?Mmh0dDFVSVVDR2c4MTBXR0pBQUVNblEvSXVKV2FQVW96cHQyYkJxbUQ4T0Vq?=
 =?utf-8?B?LzBQQjk1emRDQ2hXRDREcEFOYlpIOEM1R1Jvb0ZWUWZBekdMYjY1UURPNjJ0?=
 =?utf-8?B?WVd2RnJVWW9NT0NkVHBFa0xlUUxzVTVkc3dkNVlVZ0VrSkhSdTZuVEoyVGM4?=
 =?utf-8?B?Y2tzbTJuRDhJb2wweURXb2FpeFdQZ3lIV3ZtRWFVa2RWWC96clM3UnhWYjY5?=
 =?utf-8?B?N3dhRUtRWStha21PaWF0eTU2R3ZzY2U3TCs4azVCUmYwbXFtM25ITWJFNzU0?=
 =?utf-8?B?ZkFZNVpycUNneG5YWGlpN3d6ZVRlMUYwdmdkTnVsdVZSTy9mNDl2YmIzYWJQ?=
 =?utf-8?B?aUU5UkFabjB3Vlo1bWR3QnduMklkNUt1SXZHZG1xTnpaSy9Hb2Q4dTFUZXRS?=
 =?utf-8?B?TGRxek5WRmpJT08wT3c5Vk1ITTNtZHZiNWw5bWY4R2FLMnBNZ2lOaWR1alpO?=
 =?utf-8?B?OWp6bnZPQXA4WTduZWFXS3dXeERHZTNYRlkrQkladmc0aXRxUU8va3haVWd3?=
 =?utf-8?B?OFZnSEloaVpQUVZjSHBHUDc4K1gydTNBVm9Gc2hES3MrditIY3hxY0t6dlZy?=
 =?utf-8?B?VjhMRlJKMityV3RNL01MVFZpZnh2Zy9oalpDdlV0cDhjNGxPZ3IvbTI0eGgr?=
 =?utf-8?B?LzdpRnd0dGlmRFdwZWRVUzFpeUNoTnMyUUVhMlVoTkhTNGpqVjNxMDJiMGFn?=
 =?utf-8?B?TEpaekV1MG5BRk11M0xxbGpzUWE1ckwzZnRMcC8wa0I0aEwydE1uWUNzbHdN?=
 =?utf-8?B?WG1PdFExMzBqL0I4YjVZcHVTN2lET0NkaU5XRVN5ejkxKytxQ1hrYmNFZjZt?=
 =?utf-8?B?ZkJ1RWxoSS9qL2pVd1duWnZFdlJ2VXRRUTkzaVBEOEx6TFpWMEgwWDZPdGVl?=
 =?utf-8?B?MEI4MjZoUHg5T3Rwb0lFSWJQL1BlR0Z3dUg0aWw1QVJJc3FTdVFMSGNSREV2?=
 =?utf-8?B?ckMvOFFqellBQ2JPVVBkVU55c0k3UjA4TTBZcGdzRzBCV2NucjJhV3FSNGx1?=
 =?utf-8?B?MHJsMUI3VGl5WDlYSFc4UXB3Z1R4Q3hQTlVPUlJrb2xPVVdML0svL3cyNjF0?=
 =?utf-8?B?dFZJVE1Ja2QxQ1owQWl4a3o0Znk1ZGdVdXRqS2syREtZcmxhemNEL01SMEl0?=
 =?utf-8?B?S2h5eVN6ODAva0hLVm1MdkEwZlBUUm1EOHRkRnlycEtZVHFDNEdpd2dlZG93?=
 =?utf-8?B?aWdsalpxVnRjcWtHNllRUDJaSE1IbjlWV3hZQUxYOTJscDdGeE1KSjJoa1RW?=
 =?utf-8?B?K051N2hNVHBNUFEzOGJaOWhydDJYT2RRbHhpVnQyQ21Lai94Tk81cXEwSlBh?=
 =?utf-8?B?aHR5d0ZXNm1yUExkUGhYdTFIZmlqdVhTWk03dGRTWVU4c3R5VCsyN0QyTS9r?=
 =?utf-8?B?UW1UK3VTOHVRTyt0NVZCMm9DWTVtOHZJT0E3Q291cDFQRTNrMk80WVFvL1Ri?=
 =?utf-8?B?T0VIMkc3S3BJK0Vudk55elNtcTJOL2RoamNjeS9MMS8yTk5NRGg0NGNFWCt5?=
 =?utf-8?B?RjducGo1UTZXMldTaG5XZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGxTenRhL3lNUmxjTGF3cGppc1Y4Tkx6VWIrQ1VPblBJK2lpVzlNeXJQczNI?=
 =?utf-8?B?cFd4ajhWUkd4SmpIYlE0eFE0L0puSWc5WEF6akJDR0hrMG5QWkphSWNjazYw?=
 =?utf-8?B?cnBDYk1iWmhpQkhYcjh5Rm9YL3JHa1p5aUZ0dWNQai9LRUlaTVRZZXlFbFZ1?=
 =?utf-8?B?YjZJMXZoY3EyczdBYkFSbmdtelV5aU4vNDl2cUY1STlDSFFQdG5UMmdqWm1N?=
 =?utf-8?B?eVE5eVk1OVVmaC9oZWMyNHM5eFBFd2NSVmx0ZnhiUkhLcytFVjVqdGt3NUVl?=
 =?utf-8?B?SFVuUFNqYU5iOEVsV2o4aytyM2hVSzF4SmtnK0kwbFpQelpNcWlTM2s3MkZr?=
 =?utf-8?B?dFQrVW1iT210dE1MRUZvYTJZR2t2UE9yS0ExVXFwNEt2Um5qQU5TTWdLdTh3?=
 =?utf-8?B?RWtJcnliaDJSbU5lTEduYmRTcFgza1RBT041WjgwUGNFeThYRTMrY01WcXFv?=
 =?utf-8?B?OVcvSk5OUUk2elBPc2RxQkhJdysxcDZUNnhzSjExaStFUlp0NVJka1h0eGk5?=
 =?utf-8?B?S21DS3JrdVEvRDVOMGJEVEcrM2h1dlV3Y2d4czZ0RFZ4NXdQRnNjaTRTcndG?=
 =?utf-8?B?SnFOZktQRGE3aVJmYWxQcDg1bTM3Rm5wVUV6L20xMUJuMjUxSFFmL0w4VGY0?=
 =?utf-8?B?eWtIRkVreTB4OW9memhySWJaeTNmNFVmZGs2UnBmZ1ZQOXM5L1VodjY4N2Fx?=
 =?utf-8?B?RktJcGZSUXpqRzhnb3NiZ0NQZ3ZKM0ZpbHJrNW5iTEdqNDZaWHBIUVFsM0xl?=
 =?utf-8?B?L0dqbmJkQzVYVHZWOUJBeU90Qi9OZjhONU16VFRzN05ZRGJHaWJIZ1JmM1RO?=
 =?utf-8?B?NDQrUWROMUNUa21hcnZOY0ZobmF5SDl2d2lkMExUS3piWnVGUXkwd2RGeVE3?=
 =?utf-8?B?cGJNdDFVWlJkMEF5QkY2emtTRjdMTzVBRGlaOWt6Ulp4VWx1eTVBOXRhdXlO?=
 =?utf-8?B?WlpuZWhINjRiTnBmNFMydlBWd2RrTmxJbWZ0VitBMUlCc3Vxd0ZBcVVTMUc1?=
 =?utf-8?B?VjI0aVFMK2ZRVnBWWGxlcXkxd3BBMUMyQm9nTStXTEd5Y3E5VTh5YXRjeDVv?=
 =?utf-8?B?WU9hWjlRWXhOMERRZzQzd1p6c3Z3QkhCZ0pMWTBCSm5zbnhCV21WRXRHajkw?=
 =?utf-8?B?ZTlieUs4aHdVVkpKQ29GaVpudGJhTnA4YkV1UlJDaTVJK3dRRjNoRGRMUnY3?=
 =?utf-8?B?ZzlIa0ZVQXlsLzltL0xRV29HSkpqRFFmajJwTkIwalY3b0MzOUJqS1RCM3ho?=
 =?utf-8?B?VTd4aUhSOU96L1dFNFdQWHc4N3I2dFovQm1sa0tITmtmQzd5YXRxWU1LeHpy?=
 =?utf-8?B?SVNSbGFqbXZhNFVQeG03SStUVXpjVEJWeVF5aExDQjZvTXlnWllzZkU1VHhk?=
 =?utf-8?B?dUFLQml0dkh1UlJoQlhjN3NVczNkTXNuVVYyaDdqWnR0ZlVCTnVnVFV0c3h4?=
 =?utf-8?B?N2JNRUJFRGtHOXNJT1pORGl0cXdoRW1qeGVqWW90RlZhSHRyencrMjNsaFFO?=
 =?utf-8?B?S0hkQ00vNXN2bTJVcTVPL2svMDF3OTJwVmNIdjFNQnhUS282ZytESDhsdnJ3?=
 =?utf-8?B?VVRBSmJtbzJwbXppMEg4SFZuN1hBUXZneFJSUHBqZ0dvdXN5T1p5WTAzSm4z?=
 =?utf-8?B?czVTeEdVWENhNGpPR0ZTOGlZMk03SnZiRVpjZVhxOXN5bUlldnFxbFFnS0xo?=
 =?utf-8?B?V1BzNTcyZThBZFFjMzRPanRFSkVZT0daZjRVd05tbDZHRzNzOHFDUU9aa1c3?=
 =?utf-8?B?STJtQ2loTkFlYmoxb0xiVWZUL2xrRVNkS1hFczBoR2RkNldHRmZQYzM3eTQ5?=
 =?utf-8?B?dHVURlVQcGF1eUR3SU9ZdFhpN3lOTXBpMUZiZ3pBVkx3RUwwcnRielZ1WmtC?=
 =?utf-8?B?UURMQzk0SGJZdVN1MGxJdW5tV1JIUDBvQ1pZdXE0eS9zU252ellVUFEzRHRk?=
 =?utf-8?B?WnVieWZsamdreldxdkxucDJWQWczT1pTV3poWEIyaGFDb1JSaHRwUHRwdjFH?=
 =?utf-8?B?TUJJMnpNRjk1VWFBYzk1VFlPTzBDMk9LQmxpVHJyZ1h3YlB4T1Fhd3Y1cXh5?=
 =?utf-8?B?TlFid21KaUNFZWhaai9lQzErN1hCSXZQcEc2V0ZTd2thYmVGdzZUS3RpbGRw?=
 =?utf-8?Q?PguKp7zPSD5aDjFC132d0qr2h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d838dfca-8b17-4657-38a9-08dcc38ffe9b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:24:00.1386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhAlYTNTDfmbikxN+POtOGIY2tWkO59SFhzzESDCS6th/rF58HC0Vm4jlyZjKIuN4p10E9VTJ7vvVrK+VSwW2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
Received-SPF: permerror client-ip=2a01:111:f403:2009::625;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Thu, Aug 22, 2024 at 05:21:25PM +0100, Peter Maydell wrote:
> The TYPE_XLNX_ZYNQMP_EFUSE device creates a register block with
> register_init_block32() in its instance_init method; we must
> therefore destroy it in our instance_finalize method to avoid a leak
> in the QOM introspection "init-inspect-finalize" lifecycle:
> 
> Direct leak of 304 byte(s) in 1 object(s) allocated from:
>     #0 0x55f3ff5839d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294d9d8) (BuildId: 23cf931c66865a71b6cc4da95156d03bc106fa72)
>     #1 0x7f3f31c6bc50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
>     #2 0x55f3ff9b8c5d in register_init_block hw/core/register.c:248:34
>     #3 0x55f3ff9b96be in register_init_block32 hw/core/register.c:299:12
>     #4 0x55f4005e5b25 in efuse_ctrl_init hw/nvram/xlnx-versal-efuse-ctrl.c:718:9
>     #5 0x55f40254afb1 in object_init_with_type qom/object.c:420:9
>     #6 0x55f40253228b in object_initialize_with_type qom/object.c:562:5
>     #7 0x55f402533b2d in object_new_with_type qom/object.c:782:5
>     #8 0x55f402533c01 in object_new qom/object.c:797:12
>     #9 0x55f402d31a2d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  include/hw/nvram/xlnx-zynqmp-efuse.h |  1 +
>  hw/nvram/xlnx-zynqmp-efuse.c         | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/nvram/xlnx-zynqmp-efuse.h b/include/hw/nvram/xlnx-zynqmp-efuse.h
> index f5beacc2e6a..7fb12df3fbb 100644
> --- a/include/hw/nvram/xlnx-zynqmp-efuse.h
> +++ b/include/hw/nvram/xlnx-zynqmp-efuse.h
> @@ -37,6 +37,7 @@ struct XlnxZynqMPEFuse {
>      qemu_irq irq;
>  
>      XlnxEFuse *efuse;
> +    RegisterInfoArray *reg_array;
>      uint32_t regs[XLNX_ZYNQMP_EFUSE_R_MAX];
>      RegisterInfo regs_info[XLNX_ZYNQMP_EFUSE_R_MAX];
>  };
> diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
> index 2d465f0fc6a..4e2d1b9d1e7 100644
> --- a/hw/nvram/xlnx-zynqmp-efuse.c
> +++ b/hw/nvram/xlnx-zynqmp-efuse.c
> @@ -803,9 +803,8 @@ static void zynqmp_efuse_init(Object *obj)
>  {
>      XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> -    RegisterInfoArray *reg_array;
>  
> -    reg_array =
> +    s->reg_array =
>          register_init_block32(DEVICE(obj), zynqmp_efuse_regs_info,
>                                ARRAY_SIZE(zynqmp_efuse_regs_info),
>                                s->regs_info, s->regs,
> @@ -813,10 +812,17 @@ static void zynqmp_efuse_init(Object *obj)
>                                ZYNQMP_EFUSE_ERR_DEBUG,
>                                R_MAX * 4);
>  
> -    sysbus_init_mmio(sbd, &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>  }
>  
> +static void zynqmp_efuse_finalize(Object *obj)
> +{
> +    XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(obj);
> +
> +    register_finalize_block(s->reg_array);
> +}
> +
>  static const VMStateDescription vmstate_efuse = {
>      .name = TYPE_XLNX_ZYNQMP_EFUSE,
>      .version_id = 1,
> @@ -853,6 +859,7 @@ static const TypeInfo efuse_info = {
>      .instance_size = sizeof(XlnxZynqMPEFuse),
>      .class_init    = zynqmp_efuse_class_init,
>      .instance_init = zynqmp_efuse_init,
> +    .instance_finalize = zynqmp_efuse_finalize,
>  };
>  
>  static void efuse_register_types(void)
> -- 
> 2.34.1
> 

