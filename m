Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CCBCAC5BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 18:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1qzd-0006a5-Rh; Thu, 25 Sep 2025 14:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1v1qz2-0006Kv-4b; Thu, 25 Sep 2025 14:46:39 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1v1qyl-00013A-R3; Thu, 25 Sep 2025 14:46:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NacvZe3/CbL9vr+9xOgeN8SsB68v9TP0HMoahrbTxkgiDswOGYapQn9StGD5YA4UL/lKWSa9qinwYXfr1sByjSp+QQK5mSjTnJ2m7TZ/ifnTfAVCbburWN2MjvLDi51HrMOX8hpcmygnoHjzOzG90B1hlua1QpwMEPLSXFK1WeKS/USmzoAvwlWpgtOrSegjI3NWX+JjjO4fczb3wzaCk0JEnDn5gHwp9Vme+xI3pY7r2dNIUzQrQOy4B8PYIK0rxoqdruYXlxwFxm/xgH7wLgQrV7TpI8zQxbLejCQb7BPFCzwtLb2/PWsABQxWl/f60gu5UtoU8x7WPRNxCMQZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOShE5Os+iIO4Tk9ZFekyU9iwBXUQ7v7S2bVe4xjDKw=;
 b=rvkjDwm284hic8nRGMrDWjBRbYYIRkfNGWkxwHW2Q+qSW94z/Dr5umKmgyTWHcj//xzZONJ/uTy1GbBXoFkxn5SMk9GBtXL5Hz2fU5ZP9MYXum0oQaTG0GZMI6yntDOhnWCQvkw4PRLZZbohDSeHPZYgutpIeWXhWS0NN98+E7X7PSwF2Ji4IOi8oQCc3Dbuor6eS2sgVSsXCTx258M8WNwp09K/edKPB5VhcUkFWCyhK/AGTow+YNcyd/07UpyxHJwE3W8g9FndHbWcSTiujtVYPF0Wj2Leh31z6iPGMuFG0YtIxq7I95JT4ugcbFEFu+5+nsqL7hsxIc1jDEV1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOShE5Os+iIO4Tk9ZFekyU9iwBXUQ7v7S2bVe4xjDKw=;
 b=DrBPCG5la79tr0IdRALcx86J/2BC0zSxFesMeT2URVAe0vGvVXzG+Ip3cSGryxeV58C3CAeZ0rJzDaWNTeNLDAUVc5SJd51IduXSYhYyjmrj2bwxjG3yG7GrFI9bKyzJwgxrnBX0w298GOdvLqKpI8z3X4rXFlPcFlgY2p75NQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 18:45:51 +0000
Received: from MW4PR12MB6777.namprd12.prod.outlook.com
 ([fe80::2113:34e8:8f3b:1a49]) by MW4PR12MB6777.namprd12.prod.outlook.com
 ([fe80::2113:34e8:8f3b:1a49%5]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 18:45:51 +0000
Date: Thu, 25 Sep 2025 20:45:48 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v5 02/47] hw/arm/xlnx-versal: prepare for FDT creation
Message-ID: <aNWN3KxHvMlszraG@zapote>
References: <20250912100059.103997-1-luc.michel@amd.com>
 <20250912100059.103997-3-luc.michel@amd.com>
 <aMRVsn6cbN7fjPuq@zapote>
 <aMkR9fr7ITfggWV7@XFR-LUMICHEL-L2.amd.com>
 <aMugpMt4qU4XSnay@zapote>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMugpMt4qU4XSnay@zapote>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::32) To MW4PR12MB6777.namprd12.prod.outlook.com
 (2603:10b6:303:1e9::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6777:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c2b0c0-d427-46ea-f437-08ddfc63c02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZIOk+Kptf1bAjFZbmckWkpLX4Z0WT+g20fVwytdmtrb+9hjtVsecWERg21Zr?=
 =?us-ascii?Q?xWxNJ4uzsmZ/Edn2oMWJwDtEuMWVHBdI6wb/qgFDRkcTfHGY6eiQiKTWhyDd?=
 =?us-ascii?Q?0EZQqGg7GJCxcUIKssVqnE1VjaToUicZB7wMwqWi/fiRJznwg+gAcgid+X+A?=
 =?us-ascii?Q?XnNG6ztFq68bvWn9Hd3SIYS+jr29w3Nl5dcctvKoV2KytWGtLBmYBtuvw7GG?=
 =?us-ascii?Q?AnSv87GxvQVonqNe5itTPYT35FthZ+V7C8FG2dh42R2NUWl6ZUAwrhM73wLo?=
 =?us-ascii?Q?KxhJHqS1nTLg+Xh6g8dGkiequTU/vb5pJeo92MVPMg+zP/i0LxFkRWdvkse2?=
 =?us-ascii?Q?NPuP7SGmj0gH9Mc9Wtd6LWkYkDaAuN++KhALAzvvcCGPM+xotV0hqxWtJUi6?=
 =?us-ascii?Q?11RfM8EsoDCgWBfzafImy3pRQ/VA/gc02GQwONFxnRWnxny3QqtIo6OSz1PS?=
 =?us-ascii?Q?dW8nmDGVv65g1p4Y0JE9CnGsmpb9aavrXHT+344lystWuaE8AUA2xSvlAuxz?=
 =?us-ascii?Q?g75eTX5IkGa9nge+KjMQ36QMO7Kwv548dYFTCslZrRop3lFA41XjIme6GXF0?=
 =?us-ascii?Q?gGPOUfMinqkHO8+ONUqdctSlGybY9kYOKPcAKcoLk6XfS00g+DYnmVldl3GO?=
 =?us-ascii?Q?cWOk3QxZh7qPmLe0wnsNClMCNb+Q1kXHcoa4LpdlrbpfSRYXfT1qO/f7Mb84?=
 =?us-ascii?Q?oLZTv+swuy0gDayZGlzkdgKxbEaOR+NT3Jw3Cuw6P54wXmrMHBGEo9+5/mws?=
 =?us-ascii?Q?wmnQkl7QIhtMsmtH8UnwqC5yor4LdwV2+GKM+Ksf1D61p1QEOcbNJvyh5SME?=
 =?us-ascii?Q?uqIokZjeZSgG8WFPiDxN7UAM0x9pBs9u02P9jDiGUggtViZS0BSj4LMRPiiW?=
 =?us-ascii?Q?dN2vu7/vr5LzzDULnNCsLLcouhuDmTuMd8AjP4o4W5Wslg0xPC2o/8VUgua8?=
 =?us-ascii?Q?JhPNmvbiWVjrrTIQjFFaxQBaUPpKcpRfuEiHlBlSeyeVVy2H7QOUWqMSo4WO?=
 =?us-ascii?Q?7p83bIg/8qYS1FuenqKH4pF6wdW89ovIPvb9rG25ZHYREV4jHcEqcHP0sdLW?=
 =?us-ascii?Q?KGktysT0lY1/qEA6qQjhMdxgBrJbqtvRM+dg+My8io10Pg8DKMKMOhTqr/mK?=
 =?us-ascii?Q?3xB7nDmf7j9VQFvzK0QG0SmOBTq14mL7ONBK7jqCl4kMHVsF8CYNj06qKqAt?=
 =?us-ascii?Q?WGNue0D03pbZN4MCQB5RlBJpHiMXorpe7s7KUjgDJPfJE+nugACACy9jROwB?=
 =?us-ascii?Q?P5M27RWrzWnK+v69mDufVg2x/gAeZx4qGmv3OWr8WiNEYozC5iNkHIWfeU0t?=
 =?us-ascii?Q?DWPBNtVSgs7hgYqcWNtL1M24OgjENOpFcg4ZoI0eevOdBobBv8v/xfknVBTJ?=
 =?us-ascii?Q?UovX/692hMrhqGDGWUjwpi+HzCIuglShtS6TFmW9p2FjUWVULS1mV6aiF3xe?=
 =?us-ascii?Q?TBl9WoJnXhEkYNK3XC5T/isqix7ZTb1t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6777.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QZcSZKxUqBvNY9FZMTRhyzcI9sOsuZLGPtRHU4989skfO271ddPgc/9d4kdP?=
 =?us-ascii?Q?BAur2p45VKidQsUUjflyOS0GEnHnDCNbDXqyCGlXx8HAGVy2YbwistReWzg6?=
 =?us-ascii?Q?3MIptT3v2qAPXON0LnHCiyqJlEwqy0WpFunIGPHn1WjhkUWvesGqymodLU1g?=
 =?us-ascii?Q?QMJM04XY/lT88kzyBeXeZ66bmYwgoyck7tdurhpgDwQ6yWvvNHb7KpkPychH?=
 =?us-ascii?Q?7RFhR9VNHw9wZwGa4w6gECsOnTOeQsYhG4DxlHZ3WRbk0MwBOkB4G0VwmlL5?=
 =?us-ascii?Q?B0O5PEV/wKNK9mZdnHNvMX2F/O5AQWbOpW4vZ06/6rT2sprGtnwu8X+JIgod?=
 =?us-ascii?Q?T0tSgzRKgXUw5Dwl0vtkvfuxEkzGD69CMgNxn1ptiV7qQeI3A0/ThpC1U/7L?=
 =?us-ascii?Q?vJeRuVdKwpqKuT+1X2QqI5mKZgRxdk2kXNaCo0EJnTG7cNBr8Zvmzh3BKql3?=
 =?us-ascii?Q?5nfcpBJrQHItFVkaFT7yDuVFZkH1o61dck1YGwj/e7Z/iAQDgPSKIWxMkMx2?=
 =?us-ascii?Q?zp4qTWZ1pl0gHkSW+Vxjg56wm3DgdsXP1ckUB37M13+zspaSc03nebaJIiyw?=
 =?us-ascii?Q?6t6fBYXKohZ/1zqBsZhRLOmGX81LPzNoZGFz9ZusQHveO+4hc1lEZOEYW2h8?=
 =?us-ascii?Q?Nak7f1qkpw9pr/UXE0TpyEbdZ5Xx5HXGHFq8oCZkK0XLZTUQZ8+mqNxmnCmc?=
 =?us-ascii?Q?johhCsetBsETQtrg+Y7/jRV4lsLTeFdFR1bu4i5ybT/95xhfkNDFiP1rhshq?=
 =?us-ascii?Q?tRbHRFz52ktNSTH1OZZtF+Ox65cMBiKY/UEbaEy1QSWEnlCesG7FxHkEYRCA?=
 =?us-ascii?Q?frwaHtOxkV3y+xk1glAQV5tJQdMlCVr2O2zXw2BmUwihJ2e2fkiKDX8nKfx6?=
 =?us-ascii?Q?l43rCPdoYaHg35ZW25SWXw1B9ff7dMixuAYeCAaXjj4Na3N9KcGjtQ97YiBB?=
 =?us-ascii?Q?oucfLOXqZjsjdq+4ZJ3j+GDGAA1MxPIVd/9vWwiajBR0CCrTDJzITslthCXO?=
 =?us-ascii?Q?H2TpvVNUUad18Vy63YSYM0g8t+LSlbPKA+sRruQhEg7cfUJX6wz+jriuwbXr?=
 =?us-ascii?Q?0GDHdzPbKVDBQ8JU2xxnzThrgvRcAcu9ejISvlhEuL1vignjeh6RQDbY2sjn?=
 =?us-ascii?Q?J8G92FmbxQ8JafcNqU4N63t4xMpZBwcIKKLM+l+Vo8On7iZfBdL4UOGCZMyA?=
 =?us-ascii?Q?EllmO0yGo4sCXll08Orub9f2ZM8QCFaXTIb+pHYgPVbSSvQOSdOSRoCOxY08?=
 =?us-ascii?Q?iV6lwMIyhLwjiyFnXwGhD3mjE3UYWPf5g+dvPyIUUkhkxqO4G5TlihGwSdHR?=
 =?us-ascii?Q?+wYBjyH25KtDqtSverj9pKWORINi6NzHSdvPRVM2lkAd90qf0Yo3igERkebH?=
 =?us-ascii?Q?qtA/TVcoy3qL0qfcL6XnCR2FyQ6tIQHi9z9Vqqof4AyUqhhKWxVoBuEZrgg1?=
 =?us-ascii?Q?qnMHe0XQ9b/UTpzBhVby21hi7hiCHnmob5QA6gKcoUvBANEsUJ4DBAR298av?=
 =?us-ascii?Q?M8/Y/bnh1mod357Yifw73IY5PhBoHHo0BwJ3fVffBTpPEXGDuEOSFDOFAlcB?=
 =?us-ascii?Q?o3jsEY8EOI70aYeprbYu5FTdodLTPw8IQKB1ucPS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c2b0c0-d427-46ea-f437-08ddfc63c02c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 18:45:51.3933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5mth64Fl0QNALzk28+pfUQ7IswkW1QbJopk8M0z2LI/zqje0n6f9165JsIKxTYa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Sep 18, 2025 at 08:10:18AM +0200, Edgar E. Iglesias wrote:
> On Tue, Sep 16, 2025 at 09:30:46AM +0200, Luc Michel wrote:
> > Hi Edgar,
> >

[snip]

> > [snip]
> > 
> > > > +
> > > >  static void versal_realize(DeviceState *dev, Error **errp)
> > > >  {
> > > >      Versal *s = XLNX_VERSAL_BASE(dev);
> > > >      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
> > > >  
> > > > +    if (s->cfg.fdt == NULL) {
> > > > +        int fdt_size;
> > > > +
> > > > +        s->cfg.fdt = create_device_tree(&fdt_size);
> > > > +    }
> > > > +
> > > > +    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
> > > > +    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
> > > > +
> > > 
> > > Should we be adding nodes if s->cfg.fdt wasn't created by us?
> > > If the user passes a dtb, I wonder if we should just assume the user
> > > knows what they are doing and use it as is...
> > > 
> > > Or do you have use-cases where it makes sense?
> > 
> > Note that the device tree created in the SoC code is just a dummy one to
> > avoid crashing when the SoC user does not provide one, as stated in the
> > commit message:
> > 
> > "If no FDT is passed, a dummy one is created internally as a stub to the
> > fdt function calls."
> 
> Aha, thanks!
> 
> But then is there really a case when the dummy one is needed? won't
> versal-virt always pass an fdt?
> 
> If that is the case then maybe we could just assert(s->cfg.fdt);


Luc, up to you if you want to add an assert rather than creating the
dummy stub. My preference would be to assert.

In any case, feel free to add my RB tag on the whole series:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

