Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B35CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 06:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz7qo-00089Z-2b; Thu, 18 Sep 2025 02:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uz7ql-00088U-B7; Thu, 18 Sep 2025 02:10:35 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uz7qe-000667-Ln; Thu, 18 Sep 2025 02:10:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXDXkmAOqdn3x2WpE7PSrvHrW0DwJK/8lx3GjuNwkXplGYH06qHOoGXFVxaIa79spUm9cIFXSEkC0KX6Cd6M5FV/IaI1uuu2SxALC5qQISBjfgLS65SDBrOynxjfnSja8rLkXjIY+cY9qedAokGTo3RWeMg3nv9M2r93axpg8NuCNDarkwdx8sHyTNh6HJRFBCGX7y9yWY0krGsdBn+WBILL0jWr+8m+ITf81xE8Mn3RkjvIVZ80JfBVEBkwG6ORluZhbqNB8tLtyM17jqrw/rds0QrBHfmNHaxRZMFSFihqprMKa4FeaLcAQRwtA+CmI9omIyypFIx6GJ44MtRj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEdljOFRtFIloiqr5X0r6eKIHdD2F+e8HdzIfMoeKxg=;
 b=SjvbjWJOVdD1eRrPp3q0RiSX+Rt3xiIHGNUT0eG2PBX87CYVyBPpkKwz+5cMG/ATfsD8aa9cHUr4xkPDCjdUpbkH8S17tt8peCIRA095uazQaMGr00K04YmjOlBhQiiM4QCuePDBj//zKlaKfUrvP+E0yNAXhryKWzk1WKytj5orQLVkLYN0iXxZZnbjjvbYM2bVRCqF+wXtNOLMB81r+rSqLjsmEOMKpTRtbP25CnA/VVEI4B9pqM+zZe7h/xYt8CtFsQcNQD4mtfG975Zh/TjRvPLTo95fZ+LGVBwEpQEmg7Cc9abAS0SHoYT4Lo3ejNwQPufVotHFBMQaeDNZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEdljOFRtFIloiqr5X0r6eKIHdD2F+e8HdzIfMoeKxg=;
 b=pm9fbzeU53OLcP3AdtjfiYBbgKVoHqQYjs/OoxPrMcihgwinOAxoQ4XSqyEkXT1Q60TS97rhEx7t9d6kbESTZiKRQcxLABAzHr4ZhPlJLbd3l6kdc7DzVSd0AbM2tFdXwD4bdtLRKOK7LUHAA5kP5YBxx8f9cZd+EvlcwV0Fx1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11)
 by SA5PPFE494AA682.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 06:10:18 +0000
Received: from DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d]) by DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 06:10:18 +0000
Date: Thu, 18 Sep 2025 08:10:16 +0200
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
Message-ID: <aMugpMt4qU4XSnay@zapote>
References: <20250912100059.103997-1-luc.michel@amd.com>
 <20250912100059.103997-3-luc.michel@amd.com>
 <aMRVsn6cbN7fjPuq@zapote>
 <aMkR9fr7ITfggWV7@XFR-LUMICHEL-L2.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMkR9fr7ITfggWV7@XFR-LUMICHEL-L2.amd.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: BY3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:254::14) To DM6PR12MB4090.namprd12.prod.outlook.com
 (2603:10b6:5:217::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_|SA5PPFE494AA682:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5f2c21-ce2d-4d23-cf82-08ddf67a0a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0UBjF5ku2DWEi9gSltV842r1sHjx5xqvnrG6pPiqKyUL5lT4HyN32wJc5Lk9?=
 =?us-ascii?Q?E6YmMwTwEPYSXG2dBZd7guiOmXAu8AklzyED4E0SrEA+khxyxgBMvDwf/1Bo?=
 =?us-ascii?Q?I0QiUGf7KIP02BGZ7IkaD4IXVMtlGW7jDjDKulVu1ycoEN0plyOk4xkAfSTz?=
 =?us-ascii?Q?qKLfNjmiYWQSk6fKyoRdtrZbHKzl7z7cdu+4zNT9cwuBpk0euyY4fKfWVJa4?=
 =?us-ascii?Q?IUWKYWYcVqsUxazJu1I9x7+rH3cnqt0eZbaeb8wUFzb65GLjeJU9+DMQaG4L?=
 =?us-ascii?Q?VftFb+O4sZem9y65LURCguFX+Lhm95BnpV+wN9uAXnGehX817LFSyEMLM40b?=
 =?us-ascii?Q?PNrbKgPi+zx4HvL9QqNDlTov6CzbZ+89hcQqwtEkiJIMwzOlt2+0vr905gCA?=
 =?us-ascii?Q?B/2ze/r+PdEXZS3vMpMK3gEYPyQiic+XjIVujOTzsl94sgVr11dM5CYDSS4g?=
 =?us-ascii?Q?jpEWIz+8r8EXYytI1yZdR1EMcyslsoAi0yavjMdEw22yf1qt7Bygm8xwuk77?=
 =?us-ascii?Q?8EuK5RQEkvZSabhxtF1o4yB3IpD8esLyfv/KNQoddN7B3T7XHDAhvOGBzV3K?=
 =?us-ascii?Q?/FZ9A4s257dVs4Q10XsmPp+GKNcagFsB5Hse0y6fTIgBrZ3bE+qz7gTuokEk?=
 =?us-ascii?Q?MIvJDtVjy+3Z4s2UO8C7LH4Qa9lf4wqJoEm8XoU0LfQzU/348FVBRA8OKYkI?=
 =?us-ascii?Q?CZFZKYyR1Mg9KAPTutf2/+QXBe32dox65r4tiJJ53EfNXLfsQH39CPOF8+5Q?=
 =?us-ascii?Q?hwP1m7U6XZbIXeKiTpaACgONsNssoD62oqIQSfoRBghiJt7hXBTGzp6IbqV/?=
 =?us-ascii?Q?TbSxnWMF3JAPo8AD8DoChVhQyY9Z5YK7zD9swYDcPQ54mkN4zF7EhGB+Kf6G?=
 =?us-ascii?Q?Iihe1NQaZ4oyg2i0y+eYTu09gRss2CjXSwdGZGLP5abnqPrSSNfrev6qcu3I?=
 =?us-ascii?Q?8cem/05KNdN2C3+hjekahw3xCaI0qsDVYCBy/j70qZhtYeWZC2R2U5aN5+m/?=
 =?us-ascii?Q?/GPzspi+T6YK/yXvSRXkkYJ1ntaOfV360rdBjZiEeKEXrd79ueLMW5RLdG7k?=
 =?us-ascii?Q?+AQRemZhh7TyMBJHgiB4lhDzPGq5jFQL4A2adMCfE+bueOag4OYl5wMMhVa1?=
 =?us-ascii?Q?g7eX53mXsFZ8DGrHc6dnF6HUReEhB6QpOfL2M2n9GWZhMiqnuWWI7faEsuhf?=
 =?us-ascii?Q?vxT7COUyoq0R4CzY+irkwZ07ARgeWmWavdzYeh9XKG1txibza/15qNy+DY6K?=
 =?us-ascii?Q?fRPFk5TURtBFlsRQIR2MgY8J9R8gvPscb6WyJn9hJdrbUTMfiei0YQi4lGpD?=
 =?us-ascii?Q?b/Bt2rs32Cj15Iu1hnmv6lbbUOGIdcQ9JKhI3otbQAgtM0EeWgT1I0xiyQjd?=
 =?us-ascii?Q?6kPkcXqla+OU9tLkodEnDVE34RnsQtYdcHTHYi1FMuRoDD/QnppPpMycQ0il?=
 =?us-ascii?Q?BLBpyzAVC8g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4090.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4cQtDgzLGdqJhp7W+hO58j3kNHSW7qUZDTR8ocV0jGqpPOr9Sr5AoRnTgKtP?=
 =?us-ascii?Q?gZhiGpVsRJYVJSG2+UAtFCrrwIX6SeLToEqMtGG4QamnQGeSv2EalHgp4Rxl?=
 =?us-ascii?Q?rHr55YbvrgJKb3tLhe4vdzIbSLrZpiGL3upGhtDzYe1Zq+TrpzL+uOF/Sisp?=
 =?us-ascii?Q?WLeQJB6Y7TOKadWvS9K7cBi5EY6k+FtC277xBbAaUu5Cqh4Oh730gUa8shDR?=
 =?us-ascii?Q?9RivPasiqjlkcaMqd0tnG6tC/gLfZ/vJ5l5nfEEYQaqAPVfV+VdYySAn0ItW?=
 =?us-ascii?Q?5mHB7hCIXJmGCu4nJvYj+By2CEmOBdhDscNVrNghkivJuqpqTpGV9cpgFC70?=
 =?us-ascii?Q?E9LrOFSdtraSjS+3V0TjLC5OHXT5zb8IO/zEg13mnZmw2e8AgW0u2q7M28h3?=
 =?us-ascii?Q?IQ1K7zKJWM9ysfP75KHwiu7eu0S2OKaCP9FccooEgCdxUncO5piAFZGdram8?=
 =?us-ascii?Q?YYN345nNG72CzHlAAYB1gDaR8lpyWnnGSugaw8rUAeFtx4IrN+FzXKYQQXQW?=
 =?us-ascii?Q?Z+UnBXJvPGiyvJYoCNgCAp3yYJB0xRBchqXGSlX6doZD7vW8qiGxcHI8Ykij?=
 =?us-ascii?Q?toRBeAxmO6MR5P8HHFKkhsX1o5p/5axX7Ie8KxqQ4yTl1NyUgEQxkYIcxRoD?=
 =?us-ascii?Q?Yfpomh4eXxa8DQWHysNqqRXMs13Ua++s0hT+NzCP9mqHh7ggmdEoJ/BBzYG1?=
 =?us-ascii?Q?OtUJOvROxb2+BvUdxOQiff/41Uwcl6h6bgLlNhY5qBJDBYs6B/zC/p1q4Mtk?=
 =?us-ascii?Q?4ijkg6kFXM/io+UwO9U1U9fEjWM09mtKLRotnmwnr2x5TzyiQ/MMunmLO15x?=
 =?us-ascii?Q?yXpkmRH4qHX/MbRdROKagFtG6rwYHphp185RuzXYaITEq/kPuroEst+gyq1Z?=
 =?us-ascii?Q?Pgjidb8YI/Plc+FWlRDEnL2tIaBMB6pRy8xGOwwAx6A/wsPWmPWsse2QDQ18?=
 =?us-ascii?Q?rmRDf+lggfaRuQBZX0HeiLICnnuK6vxDxeSUUhRqwzten5D+FVQWBqgyGCqI?=
 =?us-ascii?Q?uNHBuhVd/7aUSTZvEOcua02t2tSpc092AN0d2wpnrKC7bDocjS3/3pnHV3xJ?=
 =?us-ascii?Q?zR5ACvUs0Kp+aMHmXadaADYLXMt2P2f26B0KityFnEZ7E4Nlu8gCWENxtQh0?=
 =?us-ascii?Q?fzXLH1IUth1lD4W0w2BIAqxa81ShjokYmbi9xa398wt76synD+8WRjjus9bg?=
 =?us-ascii?Q?dHK6uWrj0k5P5rqT4ro3C3tUxhZUUb25Z6tWS3N4WLyWFgakd93QWSIXtxaj?=
 =?us-ascii?Q?PkpynsiJvQc90Ed5IV+fDdI8lHdxBGagYtymMUe4CGH8eaCYvshfeIiVZvp1?=
 =?us-ascii?Q?prE7muNvaQUlATpNcY954yEbZmB6Ghfh+Jztrh/YVdJmUQnxIOwgFJ098vPH?=
 =?us-ascii?Q?M9DZpgoMkmBkplsY508CDdlGgwvbrUSI3+6cVQs8Ts8nNGRPHnmJtLk/wGaS?=
 =?us-ascii?Q?Neb0ynMjsjkz1lXomN7bTxwtctw8ifxClPAM+ub28P6j2lz2JZoMebwXKcK5?=
 =?us-ascii?Q?ohW6XATsxTlsz7V1CCbXW3OEVbtUnxkH2lvsoSiMyzqOsY1ouG31dNzbcDVM?=
 =?us-ascii?Q?UqHHYycAWMBPSRs+4D0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5f2c21-ce2d-4d23-cf82-08ddf67a0a57
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 06:10:18.0721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4hPZ7UDDXsh93v1SQl1nWmwWWf8zrkVolX67LPOMtj61B16oE+8mUzlSkoFyAnz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE494AA682
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 16, 2025 at 09:30:46AM +0200, Luc Michel wrote:
> Hi Edgar,
> 
> On 19:17 Fri 12 Sep     , Edgar E. Iglesias wrote:
> > On Fri, Sep 12, 2025 at 12:00:11PM +0200, Luc Michel wrote:
> > > The following commits will move FDT creation logic from the
> > > xlnx-versal-virt machine to the xlnx-versal SoC itself. Prepare this by
> > > passing the FDT handle to the SoC before it is realized. If no FDT is
> > > passed, a dummy one is created internally as a stub to the fdt function
> > > calls.
> > > 
> > > For now the SoC only creates the two clock nodes. The ones from the
> > > xlnx-versal virt machine are renamed with a `old-' prefix and will be
> > > removed once they are not referenced anymore.
> > 
> > 
> > Hi Luc,
> > 
> > 
> > 
> > > 
> > > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > > Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> > > ---
> > >  include/hw/arm/xlnx-versal.h | 12 ++++++++++++
> > >  hw/arm/xlnx-versal-virt.c    |  9 ++++++---
> > >  hw/arm/xlnx-versal.c         | 28 ++++++++++++++++++++++++++++
> > >  3 files changed, 46 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> > > index 1f92e314d6c..f2a62b43552 100644
> > > --- a/include/hw/arm/xlnx-versal.h
> > > +++ b/include/hw/arm/xlnx-versal.h
> > > @@ -134,21 +134,33 @@ struct Versal {
> > >          XlnxVersalCFrameBcastReg cframe_bcast;
> > >  
> > >          OrIRQState apb_irq_orgate;
> > >      } pmc;
> > >  
> > > +    struct {
> > > +        uint32_t clk_25mhz;
> > > +        uint32_t clk_125mhz;
> > > +    } phandle;
> > > +
> > >      struct {
> > >          MemoryRegion *mr_ddr;
> > > +        void *fdt;
> > >      } cfg;
> > >  };
> > >  
> > >  struct VersalClass {
> > >      SysBusDeviceClass parent;
> > >  
> > >      VersalVersion version;
> > >  };
> > >  
> > > +static inline void versal_set_fdt(Versal *s, void *fdt)
> > > +{
> > > +    g_assert(!qdev_is_realized(DEVICE(s)));
> > > +    s->cfg.fdt = fdt;
> > > +}
> > > +
> > 
> > Should this be a property of some sort? it looks a little odd to bypass QOM..
> 
> fdt being a void* and not an Object*, it's not directly possible AFAIK.
> I don't see it being an issue here because the Versal SoC code is
> tightly coupled to the versal-virt machine code (the machine is
> basically the sole user of the SoC). Even if it was not the case, the
> SoC interface is fully specified in xlnx-versal.h and any user can
> leverage it just fine. I guess QOM/qdev abstractions are necessary when
> we don't include the .h and only rely on the type name (QMP, HPM
> use-cases, ...).

Yes, and for example the dynamic machine creation that Mirela
prototyped. I don't feel very strongly about this and I'm fine either
way. We can change things if a dynamic machine implementation comes
along.


> 
> [snip]
> 
> > > +
> > >  static void versal_realize(DeviceState *dev, Error **errp)
> > >  {
> > >      Versal *s = XLNX_VERSAL_BASE(dev);
> > >      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
> > >  
> > > +    if (s->cfg.fdt == NULL) {
> > > +        int fdt_size;
> > > +
> > > +        s->cfg.fdt = create_device_tree(&fdt_size);
> > > +    }
> > > +
> > > +    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
> > > +    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
> > > +
> > 
> > Should we be adding nodes if s->cfg.fdt wasn't created by us?
> > If the user passes a dtb, I wonder if we should just assume the user
> > knows what they are doing and use it as is...
> > 
> > Or do you have use-cases where it makes sense?
> 
> Note that the device tree created in the SoC code is just a dummy one to
> avoid crashing when the SoC user does not provide one, as stated in the
> commit message:
> 
> "If no FDT is passed, a dummy one is created internally as a stub to the
> fdt function calls."

Aha, thanks!

But then is there really a case when the dummy one is needed? won't
versal-virt always pass an fdt?

If that is the case then maybe we could just assert(s->cfg.fdt);

> 
> This code path should not be reached in normal versal-virt machine
> use-case. We rely on the one given by the machine code through the
> versal_set_fdt function.
> 
> Then to answer the question about the user providing a DTB, I stick to
> the existing behaviour before the refactoring. s->binfo.get_dtb is still
> set in the machine code and provided to the ARM virtual bootloader. The
> bootloader uses it only if no DTB is provided by the user.

Got it, thanks!




> 
> Thanks
> 
> -- 
> Luc

