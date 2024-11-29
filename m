Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248A4D6EBE2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfU-0007y5-5l; Fri, 29 Nov 2024 02:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfT-0007xw-9G
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:43:59 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfR-0002iu-Cy
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866237; x=1764402237;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=aM8mqPyN5ZNPJ+XgspxAHIbZoobBBfEugTRjl/ShzBE=;
 b=xZ4eha9qgMrlwmEQaoHV7vuHtNBfN8zvAS1CA0NOfSRcG3yhJZRePU0d
 7yGtOYIdGAAqpYwb8OcYMw/6/Q8ihHL1Wv9QojH6/LDbQmVWfZe4FuU5X
 HJMTLgjSDUImNAht6FMemABnQqKO0IWhnzrDAmYfsL/hwQUTCNSmeir6A
 uRvRQz7AAcGZMcRdVJ+1n+eo9+aTpEWJuWdF6KutPqJLL5WI14D5A9QlQ
 FMACAZAv+d3pRKb2wx9sXt6xoHj3kvca+3VzFQ8sFXEI5EG5vC1gkpRcT
 gnSJ/0+Ez2wuEC70Spb2sGop3yQU7z878XoRbPAwFeeK956J3MYG0ZLxX Q==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25663421"
X-MGA-submission: =?us-ascii?q?MDGWdL3aigG+Z8ODGlCVozlFb9cZvifuLNw9if?=
 =?us-ascii?q?vzDvsDkaNXRt1qyHvJWr9CXsp+tlZoy7aJmSIFd4UiTveWA3drBxgZ3+?=
 =?us-ascii?q?XbsgEg60O9SL5CJUXYv7DpRx9EVZ+ujK3g43HOH6aVtNTU4AhcZrqgiq?=
 =?us-ascii?q?UXsIlfbjPz2DWC+IsCeReIJA=3D=3D?=
Received: from mail-am6eur05lp2107.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.107])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:43:54 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxPxFmquwuGE1ExCGKJphSK0zu0oNz9MMeUKvch2psv6kYAzQQMsA3AUjnXiUnYCCvYTL0yI8I9wLzob0tGiZ6llFthr8dnMeumxm+fQUc1pWmP1MFoR6sonPrju4UbabRjALLl9PVqHyuWXsenDJ0EuulhNaclWpl38tP0PQCMH9z6NbLCrwkpAR2y0HupH44SzkawyzgKrdXELSjmy3/cNqdXTpGGTNV1oERq6u7vmGRmW3tWs0lhXXGtyxv//qXtTlpjn65tbxnbLjZEIzINhyo4sYzedkwbAbns2cmA9N6sJ1ffaVuCF7TzZzpKxUl7TYJ+9ih8tGQdSjm9enQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM8mqPyN5ZNPJ+XgspxAHIbZoobBBfEugTRjl/ShzBE=;
 b=fJ/vqOkCS9Uz2AOMGgl8dURzBEdIN95Hjjxuu9gNHdnXQZAsPDdrlUtsRQLe8D+Jo+hfiECZQfbURc1GqqTUkcL9O7s4e/cJ+ZOofjFh7CQDj+IljqsppsIcGrmaToQeKYTqFLJGdtdcfIo74diqDvXagzVBYDCccqNuP2b1hXEseBYsfgzapwRHRQCF5ywJEHRJs9PLQeue+3tSfBr0Gjd7za8W8n8vNItOSFwH+XSPbRLYocOwCp1vUc8jXQJ6nOhm0Zblw1Dc5hl7McYOpuMW/aX+xJPg81QCQ3BXtX0BkJR86BFVswwJeB5285RmTxR6Mg+HTuYuoqNmTfsYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM8mqPyN5ZNPJ+XgspxAHIbZoobBBfEugTRjl/ShzBE=;
 b=MEMqfMEfqyLnfqg5Xasa4wTS/ssgcI3m/QZqX/pVoykM9DOj2mpp2hyQ7Jz0yLneJVY0pJscA6b7d6kfix0Dbr9uV9hqBl6qmWKxe5zp+sZggDSyPARrm2x6knuvXBEl+JWpFDo8Tj8pJ9tolFRHQymqxOLWp69kGqzaTUFXCaWe+R3H7/Mezt2Ftl5iH+rTgO/Fhhn5Najgv3Je2/rhIueT7hYYtCFttrOGqclcYS2y+h3wS0hLlL+4Zeknokmz3xOKZzI7PhgqMoNZ6FBTZUKew6yaWzqEdacQjOrXiUTG/Qt5pXTPSrE2nut7w/u2pdwkCVzJn0Cs/GolLvxDcQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7847.eurprd07.prod.outlook.com (2603:10a6:20b:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 05/19] pcie: Add helper to declare PASID capability for a
 pcie device
Thread-Topic: [PATCH v1 05/19] pcie: Add helper to declare PASID capability
 for a pcie device
Thread-Index: AQHbQjJv/djmAPSDTkCKwQvJ1qVl7w==
Date: Fri, 29 Nov 2024 07:43:52 +0000
Message-ID: <20241129074332.87535-6-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7847:EE_
x-ms-office365-filtering-correlation-id: afc98462-0cce-497a-d08a-08dd10499225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aENGclBkWUU2TUlyVUQ0T3FhQlpDUmxUaVVIYUVlbDZVYUtuWmNETmVxQ2hq?=
 =?utf-8?B?cDN6cks3M2M3OER0bS9XRU1sMXBSWFZpeWQxMnpwaGx6SCtmSlorcndpL2RP?=
 =?utf-8?B?clJtemlnQUdTdlZiOHFxeUxxTUN1eERhKzhBUGVGMGlXVndlMmlPMlVESVlK?=
 =?utf-8?B?MFJOVjkzeW9jRW9vdjJXZTdkZ1plK2o1alJhMzRyWW02aHJ1ZkVndzg4SS82?=
 =?utf-8?B?cDdEUUNWVEw1QnZkWGxncXVnN2d0MXNweHlMcTZ6SnRXOWNvRGpjWW5zTFo4?=
 =?utf-8?B?Zy9sNkFUUU03UVZ4ZzRXNDhXSVVvVnBqQTdJZzY2K202b0VPcTA0MnlraGF6?=
 =?utf-8?B?VVVpY1dqZUF3Q3NwVzBteDlBQUVmYk5QR3poWEEvcHVIOVRBRzR2SUJlOCsz?=
 =?utf-8?B?WkduNitoNUI2NWg0RnpTWXVSKytSYXRMbkhVYktTVTlEZWhoVlc0K3J1Vkli?=
 =?utf-8?B?Mk1QMHlJbXVadWNKMjB0WERGelVTaHNuZEVhSmQvM2JmYUF6MUd1THhtT1BD?=
 =?utf-8?B?WUEzeWYxVWpQNEpDOUFyR281ckRzc3lpTEEva01HUUVsVUwzOFhjNFBnRlRm?=
 =?utf-8?B?cDdwQVZ4enRXNmNzZS9XV01lOVdnREpTTUQ5cVd2SHVpVmtNQXpENU95YjJS?=
 =?utf-8?B?N1h0UExEYnBjVm1IODU2WEJBRWRZY1V5ZmhTMjJDektCdS8yMWQzZHBMZzdM?=
 =?utf-8?B?ZGpmWmlWc2lYdTFDVGRMdEM0YWszOXY4N0lXY2llZGlTM0xIaVVPTE9lYzNa?=
 =?utf-8?B?Yzg4Szd0TTBDOGx6UU51d3lzTmt2eHVsbGljbUZGWVRSb1RtUDB0TkRHb3g5?=
 =?utf-8?B?V3Y0WU1oam1ocFlBYVBJNDgrOXpHUERoZndIVlBsL2JTSVJkWXN6a05YTFlS?=
 =?utf-8?B?NXhrdjc2UTdLdWc0bVBUckJycFVSVFlYZUVtKzB2MFp0a0tMVEhBNzZFYi9L?=
 =?utf-8?B?RnNOMHVrMXZVR1NWVTNBZVB4bWlrYmNqMXJUVG14Z3hPMkM5ellvMS9lQ3Bl?=
 =?utf-8?B?Sy8zNUVCamsydG1iM29KOUJQZzNmc3l5UU5ReUVGKytNbG9pM2JhMTZBMytw?=
 =?utf-8?B?NEZ3MWVhb2g2TjRNdmxnVmJUbjRZaEd1cWZKWW1XQ21ablVDck9JTDBvZWR4?=
 =?utf-8?B?cGN1bmdjaERkYXRZc0lkNnlNT2JST25zdy9LdEJ3eVh0OCs4SlJ5U3pLZlJB?=
 =?utf-8?B?V1dCQWtQbmE5UGY2Q1JvRjUrQmloOEo0TXF2ejBEd3dXY0JsaDAycWhnNWg5?=
 =?utf-8?B?eUd2NmNBYkUrUUEzWFdacXowbHA4alIyNVpIZTdXRVpHNXFXUkpxbEU5OE9j?=
 =?utf-8?B?SmhZejlYSS94SU9CcW53WVhiV21mWlR0Y3Z3eE9FeDYzZHI1UHRKRElSMWdr?=
 =?utf-8?B?MXE4SjEyRlAvOExjbjlZY25QaTR5Znh1bnFWeDB1N3NXZ2RkTUZFbGhkQTBi?=
 =?utf-8?B?MFhoMVhVRVZLQnZ6TjVreEFsQVBncHp5Q3F6cEthL2Y2VHBzeFJWMUpOUXZ0?=
 =?utf-8?B?QWdCZDdPUVdlakFESkpGTEZnQlZBRkN0Y1dBandyLzV1Mk5qVjBlbHpHd3F2?=
 =?utf-8?B?b0hXckNBWEkvdnMxY1F1TUdaZ3dIdTVkd0lXd0xYVXVMQktkZzM1bFdYVC9F?=
 =?utf-8?B?clRPSWJFOWZYd3FMZUptajhHOTN2UHhoS3ZUenJhYjMrMVE1bnd5eWlRWjBR?=
 =?utf-8?B?em1wUXNaTFBZQWR3dTNVSlFTVXlkSmJFREJHU0lsVG0zOW1WME1PUTVZdFha?=
 =?utf-8?B?M0FyYlJ4SDUrUjUrUlI2ZXdGRVVZaUszcThoa0V3dHl2L0RUYVR1TjZBdXU0?=
 =?utf-8?B?YWhjbnB0RnBybW4yZ0JjcjRrZzM0TnFBc3A5TDIxR05vekF3YjdGRlo0TG9z?=
 =?utf-8?B?cDNtdFV1MjA4SVR3NGRKSzJMbjIrNU9lR2poNWYxMGV1VXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDVVL2s5TUZ1SVRsOWhjVkF6Y01mUlAvRlhCclg1V0NPd29sdnhSZDZoWEpW?=
 =?utf-8?B?OCtVRDB4RmhiRUVQRjBZa3JiYjQrNGpEbGEzUG5ETHA2TVBiL0dHZzlOS3lP?=
 =?utf-8?B?dTdTQk01Q3drc29UcFZKcDkyUDlGaUNTRG1ocHY1RGhHMHBUaXoyaVhISW13?=
 =?utf-8?B?dlh4WVcvd2FBdnpwZ0xONEp0SzF0aG9RQmpmbVhrbVgrTGJoQmowVjNLVlVn?=
 =?utf-8?B?cmhuZlljUi9NTk9BWVRUQzJ0K3lSb2Q3c2VhTHRESXdyenlMOEgweEZuYnV3?=
 =?utf-8?B?d0hVUlNsdnMybktwK0tCMWVKcy9KS01TTFdWS0NOa1ZjQXlqc1h6Y2hiRWxK?=
 =?utf-8?B?SWtzWG90bkpURi9RYXN5NDVRUFNkVThQdnY0YzM4K1pzUjZvK2MweDlTQ1Bu?=
 =?utf-8?B?VkJoZVhGN05kZ0VDRGRsQmJubEk1U044UXFkWXFKSEszM24vRzh3VFQyQXVW?=
 =?utf-8?B?cW54WU5EcVUwKy9nTTQrdWpGSks0WlNwY2FXblhQb2VpMVNNRytRNEM1aXNK?=
 =?utf-8?B?SHNrcHJ0RzZELzlXU1dONXloeFV5Vko1aXA1Z2dXNFJ4RHdiTHFOclRKUTJm?=
 =?utf-8?B?RG9wbEdySXY2aUxUMWdWR3JSVWdKSVNYRzY3NGR4NVUrdlhkNllpbTNYRDYy?=
 =?utf-8?B?MVArNGlkVjNSTkFtUXJGZEx3UmZpbmFkNkhxZHQ1Y25mMC9qd2M1NmoxSFd4?=
 =?utf-8?B?NDN0RG5qeGJWUUxWd04zamJicnZ0b2Y1bnRJVGJablp5QnZnQkpnNUsxWUpy?=
 =?utf-8?B?R2duS0FzM0RHQzIrVVZzcWhEZUlPN2dMRjRuMFdGS0oyV2w2czUxN3lEUy9w?=
 =?utf-8?B?cUdJZmlISGpsMlBSbm1pR2NubnBrd2lra2doMmVHNjBpN3JjTFhpcXFDcjgw?=
 =?utf-8?B?NC9FNlpuSlR1Vy9EcWc4Vmh4b0taTVNiZ21GcE9Cek5yU1IrN3QzYUV5azg2?=
 =?utf-8?B?eHdIL1JxZ0Zmam5iTE5OWU9iMVppWnozSWZlM2ZWQXpHMk90SERXRzAvQXhF?=
 =?utf-8?B?WElRaXlOVWNneHFvLzJQUHdEQ0lSa0hySVpVVC81WG53QW1uOTBVbmd0UGIz?=
 =?utf-8?B?YmlWdEluWTNRVFZweVBlZUQrbWJrWmh5U2ZDSitBN1dxQ01LT1RCOGJzUWxM?=
 =?utf-8?B?NFlLMkN6VldPQ0g2K1NwYVZOUGpiSFNyQittVEYzMnRuTGdFUDhBdXdYVFFV?=
 =?utf-8?B?UjhTUEc0YzJZNWpTMFcvRHNCZHF1ejZIbW1pbnNMdnZxamwzNjJTQytLTWJh?=
 =?utf-8?B?Z2tKTXMyeDA2RGxhaDN0SnFGV3R4UGJ1a1FOUXNHOGV1akVlZFkrNnl2MVRz?=
 =?utf-8?B?Y1VJTHBsS2YzU0FYeUc1NWJUTU5tNXlCZC9FMHUyWUJXZjlnVVZjQ0xyTDhV?=
 =?utf-8?B?a1J4NU4wNWxtUVAyR0V3ZUtXdnBpN1g3U0hmWlJibnlwbjk5SjJRTXlpanVF?=
 =?utf-8?B?S1RvR3BXVnBHVkNhOGQyU2QzQTNnZFUzNTMzR3hERm9KdnFDSTNGZTN5QTJM?=
 =?utf-8?B?VjZHMlFwVkZiaFFzSmovNndiR1BLNThqMm5QUTlndWt2ZjcwR0xVUkFmQlZj?=
 =?utf-8?B?Y0JOMEN2ZThxZ1ZweGtLdnNmeEFnN0ZhcE0zbFZ3ZmNESWpWQ0FGTmVsSHVr?=
 =?utf-8?B?MEY3S2gyUVhNTFdaTCtMYXhDMW44Y3VmTkRpVHFBdk5LYndUcU5hK01Fb3NN?=
 =?utf-8?B?QmV3NjUxbG4xblFFOEhqVWI1cjlza3lrbW5mN1hPaFkvY1h4cGg0dG02Mldl?=
 =?utf-8?B?TXlMcnVIaWhNSmVUTnJIam0vcG5zMk1nNjlnR3FxMTJ0dUdqbmc5UVd6WHo1?=
 =?utf-8?B?V0F2bXdNZnFicHphekFrcmR2aXJ3dWdYaXRrWlNPb1hjaGJzRjBCSURYSTBw?=
 =?utf-8?B?SmxEVHY1U1BDbmc1dSs2WkF1U3BLb2ZsYnhQQzFyZmd3WllpU090OXZkbndS?=
 =?utf-8?B?SFRLTG5HOVlyUVI5eGRnRFVsY0srcThEeWloVUo3eUdLZnBRM2FMNGpmTEFs?=
 =?utf-8?B?bjBmN290U2txUmFMa2w0Ui9EVWVKanE2TGZ2SytjcjhCUGpOQmVXdm0rSkdP?=
 =?utf-8?B?RFI1WmpQOEo2cEwwaXB1NVRTZmhjWW5udzNybTRIbXpNRS9uaUhsMUtVd01J?=
 =?utf-8?B?Ni9nbFVTVHJ6ZG9HbUtjUGxvMFA0U2hWQlFIL1c1Wk9zRkZmek9RVEtWZEtH?=
 =?utf-8?Q?7NsKOMbSoxVGnOJOKajpy5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF7F2CDDB3A2AF4FA017CEB4674CFA81@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc98462-0cce-497a-d08a-08dd10499225
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:52.6593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBWRT4Mwp6AXIYvOPrOoXoNYtvpVGyFFjNmM2kVK/urec8gQKwOEhnrK/urW2Xq3n+N7tzgDL+daHzThhSlTHAT7NSdw0rCMe4UeDX1GnsZ8MDKqSreH9n511g5HKCIL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7847
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvcGNpL3BjaWUuYyAgICAgICAgICAg
ICAgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2h3L3BjaS9wY2llLmgg
ICAgICB8ICA2ICsrKysrLQ0KIGluY2x1ZGUvaHcvcGNpL3BjaWVfcmVncy5oIHwgIDUgKysrKysN
CiAzIGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlm
ZiAtLWdpdCBhL2h3L3BjaS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQppbmRleCAwYjQ1NWM4NjU0
Li41Yjg5NjQ5NmFlIDEwMDY0NA0KLS0tIGEvaHcvcGNpL3BjaWUuYw0KKysrIGIvaHcvcGNpL3Bj
aWUuYw0KQEAgLTEyMTAsMyArMTIxMCwyNyBAQCB2b2lkIHBjaWVfYWNzX3Jlc2V0KFBDSURldmlj
ZSAqZGV2KQ0KICAgICAgICAgcGNpX3NldF93b3JkKGRldi0+Y29uZmlnICsgZGV2LT5leHAuYWNz
X2NhcCArIFBDSV9BQ1NfQ1RSTCwgMCk7DQogICAgIH0NCiB9DQorDQorLyogUEFTSUQgKi8NCit2
b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lEZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50
OF90IHBhc2lkX3dpZHRoLA0KKyAgICAgICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBi
b29sIHByaXZfbW9kKQ0KK3sNCisgICAgYXNzZXJ0KHBhc2lkX3dpZHRoIDw9IFBDSV9FWFRfQ0FQ
X1BBU0lEX01BWF9XSURUSCk7DQorICAgIHN0YXRpYyBjb25zdCB1aW50MTZfdCBjb250cm9sX3Jl
Z19yd19tYXNrID0gMHgwNzsNCisgICAgdWludDE2X3QgY2FwYWJpbGl0eV9yZWcgPSBwYXNpZF93
aWR0aDsNCisNCisgICAgcGNpZV9hZGRfY2FwYWJpbGl0eShkZXYsIFBDSV9FWFRfQ0FQX0lEX1BB
U0lELCBQQ0lfUEFTSURfVkVSLCBvZmZzZXQsDQorICAgICAgICAgICAgICAgICAgICAgICAgUENJ
X0VYVF9DQVBfUEFTSURfU0laRU9GKTsNCisNCisgICAgY2FwYWJpbGl0eV9yZWcgPDw9IFBDSV9Q
QVNJRF9DQVBfV0lEVEhfU0hJRlQ7DQorICAgIGNhcGFiaWxpdHlfcmVnIHw9IGV4ZWNfcGVybSA/
IFBDSV9QQVNJRF9DQVBfRVhFQyA6IDA7DQorICAgIGNhcGFiaWxpdHlfcmVnIHw9IHByaXZfbW9k
ICA/IFBDSV9QQVNJRF9DQVBfUFJJViA6IDA7DQorICAgIHBjaV9zZXRfd29yZChkZXYtPmNvbmZp
ZyArIG9mZnNldCArIFBDSV9QQVNJRF9DQVAsIGNhcGFiaWxpdHlfcmVnKTsNCisNCisgICAgLyog
RXZlcnl0aGluZyBpcyBkaXNhYmxlZCBieSBkZWZhdWx0ICovDQorICAgIHBjaV9zZXRfd29yZChk
ZXYtPmNvbmZpZyArIG9mZnNldCArIFBDSV9QQVNJRF9DVFJMLCAwKTsNCisNCisgICAgcGNpX3Nl
dF93b3JkKGRldi0+d21hc2sgKyBvZmZzZXQgKyBQQ0lfUEFTSURfQ1RSTCwgY29udHJvbF9yZWdf
cndfbWFzayk7DQorDQorICAgIGRldi0+ZXhwLnBhc2lkX2NhcCA9IG9mZnNldDsNCit9DQpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kvcGNpZS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQpp
bmRleCBiOGQ1OTczMmJjLi5hYTA0MGMzZTk3IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kv
cGNpZS5oDQorKysgYi9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCkBAIC03Miw4ICs3Miw5IEBAIHN0
cnVjdCBQQ0lFeHByZXNzRGV2aWNlIHsNCiAgICAgdWludDE2X3QgYWVyX2NhcDsNCiAgICAgUENJ
RUFFUkxvZyBhZXJfbG9nOw0KIA0KLSAgICAvKiBPZmZzZXQgb2YgQVRTIGNhcGFiaWxpdHkgaW4g
Y29uZmlnIHNwYWNlICovDQorICAgIC8qIE9mZnNldCBvZiBBVFMgYW5kIFBBU0lEIGNhcGFiaWxp
dGllcyBpbiBjb25maWcgc3BhY2UgKi8NCiAgICAgdWludDE2X3QgYXRzX2NhcDsNCisgICAgdWlu
dDE2X3QgcGFzaWRfY2FwOw0KIA0KICAgICAvKiBBQ1MgKi8NCiAgICAgdWludDE2X3QgYWNzX2Nh
cDsNCkBAIC0xNTIsNCArMTUzLDcgQEAgdm9pZCBwY2llX2NhcF9zbG90X3VucGx1Z19jYihIb3Rw
bHVnSGFuZGxlciAqaG90cGx1Z19kZXYsIERldmljZVN0YXRlICpkZXYsDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KIHZvaWQgcGNpZV9jYXBfc2xvdF91bnBs
dWdfcmVxdWVzdF9jYihIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19kZXYsDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCk7
DQorDQordm9pZCBwY2llX3Bhc2lkX2luaXQoUENJRGV2aWNlICpkZXYsIHVpbnQxNl90IG9mZnNl
dCwgdWludDhfdCBwYXNpZF93aWR0aCwNCisgICAgICAgICAgICAgICAgICAgICBib29sIGV4ZWNf
cGVybSwgYm9vbCBwcml2X21vZCk7DQogI2VuZGlmIC8qIFFFTVVfUENJRV9IICovDQpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmggYi9pbmNsdWRlL2h3L3BjaS9wY2llX3Jl
Z3MuaA0KaW5kZXggOWQzYjY4NjhkYy4uNGQ5Y2Y0YTI5YyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUv
aHcvcGNpL3BjaWVfcmVncy5oDQorKysgYi9pbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3MuaA0KQEAg
LTg2LDYgKzg2LDExIEBAIHR5cGVkZWYgZW51bSBQQ0lFeHBMaW5rV2lkdGggew0KICNkZWZpbmUg
UENJX0FSSV9WRVIgICAgICAgICAgICAgICAgICAgICAxDQogI2RlZmluZSBQQ0lfQVJJX1NJWkVP
RiAgICAgICAgICAgICAgICAgIDgNCiANCisvKiBQQVNJRCAqLw0KKyNkZWZpbmUgUENJX1BBU0lE
X1ZFUiAgICAgICAgICAgICAgICAgICAxDQorI2RlZmluZSBQQ0lfRVhUX0NBUF9QQVNJRF9NQVhf
V0lEVEggICAgIDIwDQorI2RlZmluZSBQQ0lfUEFTSURfQ0FQX1dJRFRIX1NISUZUICAgICAgIDgN
CisNCiAvKiBBRVIgKi8NCiAjZGVmaW5lIFBDSV9FUlJfVkVSICAgICAgICAgICAgICAgICAgICAg
Mg0KICNkZWZpbmUgUENJX0VSUl9TSVpFT0YgICAgICAgICAgICAgICAgICAweDQ4DQotLSANCjIu
NDcuMA0K

