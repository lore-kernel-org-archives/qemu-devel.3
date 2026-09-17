Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E9FC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 05:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x758k-0007in-HS; Thu, 17 Sep 2026 01:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x758Z-0007iD-1f; Thu, 17 Sep 2026 01:58:24 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1x758W-0007iw-1d; Thu, 17 Sep 2026 01:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNlrIKHT5IkFMlAQzpJdCMEDd8E/LA/UIx2O62D8mMRlkXX40neCnZClkZ0Q7IkoHGqsv9dts/PK8GtOFz3WsygAdgOXNegRxQmjcGQN1mjb65EpHEIW9H0iZUh3thQjogSv1bXdfmEsW9PU+3QsBoaysv+ZOSuetbk4Xty5IG7h45UHmiIZ5VbqwsJcvK+/vmpP/+HJWvjd8YqHD461iWhciE4VwqfUSv58oXpt0Z74vhxRnjZcAyp2hnGV00t2RG50wZWp1ifu5gYgD9d3ESfAgBi+KMCVGU7KTZnYwruN5ygPcxk7CBoYfU3PsIXjanWE7Fnm6tL68XcX0K6QFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxTFhY9fkg87tSBC7HoqXXvWKfuW7fyaEirDFZMSW9o=;
 b=asC6ZDr6zORkXhMzQmVXzKeeAC6vkPDckp0I91Dpb/PU1LWqN4idnzsacNRlrT6p3Tspj+d77zt5q9kH9r54Zjn245m315tLaAPOq2v/+AosaALYCO5bPfy0keEdPOItdiQtrYCdPdIU2BRotd16yIcBCl4mKDoU70ncaAej5nLzvj+UchcGr3yTfcJ8k5yP+VeWVgn2jahpabqBcIlN7rVJnB7yUE22qE1UQh1wPJOqDdJhNGxQbcem92hw2+NXqzpqh9AZT5ZZgb3id1FQNO5GkpOcFpMDGhiKkltRimUdJurxydWru7/Pf8JUIZdAAZeUpTQDJDuSOizzr9DGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxTFhY9fkg87tSBC7HoqXXvWKfuW7fyaEirDFZMSW9o=;
 b=h6Tv4WqQL0r4Lm4QqulN/YVMydXxjOJt8vZuMzjFBCWVRjF2FnY2wGWRCDymEl5um7jPS8Ex5I/Nowbxx6Zkb1Iaj+Xb/NVx/mbGorHfOimdfzQbvhh6Iio2ZI6dRRK0x3RG/cnaue2Ys66CeIx+A3Uklb5ji/rznuoXGwL7vPFedoyyTobDlnhJwJFu85sgDfTcPXFbzURUYNajFBWme5bYcoe8YNEaR2omZl39BvF1U1xKXc9EzKUhMbhvq7v/Np3EhF3vLq7yg5yESWf3KxUOMi7+5fetidvDByB8J9T1h2ZcRMfsfUJ1xrQYx/Tjg9uvSfQEVfw85F7Spf86Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB5596.apcprd02.prod.outlook.com (2603:1096:400:1c4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 05:58:07 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0428.009; Thu, 17 Sep 2026
 05:58:07 +0000
Date: Thu, 17 Sep 2026 13:58:01 +0800
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, qemu-stable@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 08/15] hw/riscv/virt.c: fix aclint soc/mtimer nodename
Message-ID: <aqt_QMsRDWG7ojXk@MacBook-Pro-4.local>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
 <725cf200-8a28-4fc9-8d96-4d705213505d@tls.msk.ru>
 <8594dca6-0af0-41a1-878b-1e7847b5f043@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8594dca6-0af0-41a1-878b-1e7847b5f043@oss.qualcomm.com>
X-ClientProxiedBy: PH7PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:510:23d::24) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 6828b7bf-5453-4d7c-a60f-08df1480a531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: xaWuxtKght5yhQBCp7UU/dCgMTlO9sM8UwX+2nvV3V+qjGmT15ID1mmaVTjVWeAsXciLUpmlyl8V5aQlyKh74J/YzEjJTNJ+vFqM14EZ3ATpFfb/KLObHyGsXRtLmoXMoZYRyLHKwabMOrNQSZm0Q1MytSwTeSSwllqX8T3VxEwL74Dh4A5cO6LiS7/paoj1zg49p5yBbYhEVyhYh4NjYgoRRd1LY6SB2ZJghtSYUd9rMBCGRCvqmzI6aQnhaSTwjQ3Uzd2rjIs5N2T+eV+Mj2lJDUrA8/0DvUKWCLMiJFsTaCKXz5QKhXHJdyAScBXSewfQOhsH3fEOULU5LQ85VAaxPlQy2bIMI5yQ2659XRB/fuJyqQbW+BlueU0TNwC7lloDDwMVuoKpMSnSmVv1oItXq4VMJ5yYM5SA3ts+0jeu+96w/HIudv85q4u5UetyB6KeU/kHc5a0EXJlND65Pzo21OJzleYX0SJXJVys3rKPdkcO1G3hkGuJwWbUDJv8TmlDyGVVTH0dAcsh4xlQkWJWeMRLRZE6Y/2wQsPUXlRhWFbX0icxIW1OBr1+5gjm3PGg7MSDdO4mNhfu0JD2uEZr6HJwPs5KentCCXtOsn8B4dQXOG48YOT5Ml9OUGC1SQsBFCaE0Kt2tMTxIQPHMMJ74shgrEB3jpl2S6jKZSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rbwp71xL0Kw+3ipefY5X3QieVwnuD7CSI5GFRdDgeRAAv0Czx5ypQalO7y?=
 =?iso-8859-1?Q?GYT8ELdsdRqGkdN0QNcSB4fPzgRTjGoRSyK7XxqEiTVF8K/OekJQr7NHcj?=
 =?iso-8859-1?Q?ILbFnapRfjSS149zDEzisM3dsLerUl/WJJZrJzGZWyg8EzKd1FLnFIrp4L?=
 =?iso-8859-1?Q?e/YJA8vZpp8CV5XRmXSMbVkpSoSKkKkxUY1Uk7fqthMb02CP0qJQcsOetF?=
 =?iso-8859-1?Q?3aBN9H9Wkqvnszn/Uyq1xVPK3yUwM7FN9NJUs8EFKx6IJ5vyuWGFjF/M1H?=
 =?iso-8859-1?Q?5IJJXG1DPYEcai7fi8CW5YVdSSB0Vfj9IaAAjjUsjWHgByerrvcxMzPeOz?=
 =?iso-8859-1?Q?ahFFBgdwOxLSSNb/vqjNqvKwjGI26tI0NWMqpBBTJYS3ghJswS27gQnbCl?=
 =?iso-8859-1?Q?65aeDxKZvJFiYL+YHndBzaw49ZRst79hIqVKJgtGvpDBEctvTbgjNkN8Ke?=
 =?iso-8859-1?Q?+QTDcn6B0B51dEzWneD2B7AXxJ2SgPTRqbl7CW7Uu2vvAB52KzppY4351v?=
 =?iso-8859-1?Q?Wb/R1D3RuNdi1IHXM/ye+zGc6cWHOXxNxSOs7zY40fkpVTGFMO2OYprYrc?=
 =?iso-8859-1?Q?G51c/KsUY8rV12cqjjJ+WHP8hcwAcbyNMII7Cm6QpkT2jN65i4HOiQkHZd?=
 =?iso-8859-1?Q?zTi5xS0cTu3ewM35CP2JdH8RWqQuPSQVxD78CYcBncmLXZg38/jpQ+3yjW?=
 =?iso-8859-1?Q?HTZyK5Qin6hSENqiI61N6m5hnv782hjtkoxPFnCZXUkWmXaNocbu/hsNdW?=
 =?iso-8859-1?Q?z3BvqSUis2jS6EnawLnfIKbZ8lT4ZOGRisZlmQ/Sqpyt/6TjviSI1S1qG5?=
 =?iso-8859-1?Q?+iq5G9bPPdTDnjz4diWtwetTtc8WO/v8nJfw7rWvRbf1jBUw9TH94TN40r?=
 =?iso-8859-1?Q?D9lOLpF4GbK711gm/xYsd4/vemXTbDAg87j4EOR+viH00CUscM6bpPWI1a?=
 =?iso-8859-1?Q?Yh0Etym6mrqLMlNEnELclQXbqryW1X6CboQv/acBxu2sij5lx1/oENbToi?=
 =?iso-8859-1?Q?Ze9QV3ihYYFr+ZCgQx7TMODbjvB34GUD61/PBq8piA5UcaIriqkqtEeAyh?=
 =?iso-8859-1?Q?Kvf/fAM9157x/eBjQr2X5dps1ie96YfCI8plj1bCZ1He0stpBg3PLE8A7B?=
 =?iso-8859-1?Q?+0B5J4KQNpjfYfKSI2Lns2W4MFd1gUFO3lKaHQEvRqzTYF714II7qcvpHB?=
 =?iso-8859-1?Q?RazB3sEc4Cu50JDLM7/jmC94RJApoiFvWtiBZ5lctnsvzAA5k6q0+lXWGM?=
 =?iso-8859-1?Q?EsXo3Z34JGvZlamw6p7rdsMSeX7txfaBkVgIGIfiLiznSCeA3fOcgJA4SG?=
 =?iso-8859-1?Q?wwPYUxFIQbvrrR3bIIkrmbu/mhoI0UG3f5TQE4Rgs4OYjgW8yp6Y4BlprS?=
 =?iso-8859-1?Q?Kl33Wy5559+68dko0C1fRbmTQCoBADoDTbKkvHI3fheEEht+BbQ16LQoBH?=
 =?iso-8859-1?Q?S1JL6I8pTLsNMZXkLSHb5Zrwg7J+IAJ0eBj0cLu1YLKBU5GW4OVHyn3Ftj?=
 =?iso-8859-1?Q?oICidqIPGijBZ2+p+AW6CQLMvVBOWg9RyGk8AMtwlrOMteI0AqTQV92anv?=
 =?iso-8859-1?Q?OfhJS8AtYPyW5bM5nJOVpHjPCjgKzKcvRYoeecIQpcE61ZZtFTc5YtfAEU?=
 =?iso-8859-1?Q?lFeLsf98nlKQAjWC5bvgTN9XgE5Jwa7cvVOxogOKWNglBn40Ea7UIK4rnb?=
 =?iso-8859-1?Q?8tQDdXM+b0RNlyf+iu4aM2r2fH8jGy79UVblZ4QgOOJbx4bYCVxffwP/fZ?=
 =?iso-8859-1?Q?03h+dEXUnU8bsqpBGBA/0lpe4Aqk6DgSwlI7sgpfIjAyb9TyQqlPyLrmsW?=
 =?iso-8859-1?Q?G0vZPpHiprqLA2NMjzkDn3IDRq2wEqo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6828b7bf-5453-4d7c-a60f-08df1480a531
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 05:58:07.1522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tg5bCsMTLaK5Im62rBlFrvGYTZH1RYEzYyUcLn1u23X74PyIvXjUAE9ed9fiyNHGM1j5TAmum1h/fq6d1CoKwmdoXJT2ta6YKeGO4koIjqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5596
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Chao Liu <chao.liu@processmission.com>
From:  Chao Liu via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 16, 2026 at 02:10:38PM +0800, Daniel Henrique Barboza wrote:
> Hi Michael!
> 
> On 9/16/2026 3:35 AM, Michael Tokarev wrote:
> > On 8/28/26 23:39, Daniel Henrique Barboza wrote:
> > > Running 'dtc' to generate a readable fdt for the virt machine produce
> > > warnings:
> > > 
> > >   $ dtc -I dtb -O dts virt.dtb > virt.dts
> > > <stdout>: Warning (simple_bus_reg): /soc/mtimer@2000000: simple-bus unit address format error, expected "2007ff8"
> > > <stdout>: Warning (simple_bus_reg): /soc/mtimer@2008000: simple-bus unit address format error, expected "200fff8"
> > > 
> > > This happens because the 'reg' field does not match the address in the
> > > nodename.  The right fix, pointed out by Chao in [1], is to make the
> > > nodename match the reg value:
> > > 
> > > "In the current QEMU implement, `addr` is the MTIMECMP base address,
> > > while the MTIME register is located at addr + RISCV_ACLINT_DEFAULT_MTIME."
> > > 
> > > In other words, the 'reg' value is correct but the nodename isn't.
> > > 
> > > We'll make the fix now, allowing the next patch to move the fixed version
> > > of aclint FDT to fdt-common.
> > > 
> > > [1] https://lore.kernel.org/qemu-devel/apHH1upnh8udUUT-@ChaodeMacBook-Pro.local/
> > > 
> > > Cc: qemu-stable@nongnu.org
> > > Suggested-by: Chao Liu <chao.liu@processmission.com>
> > > Fixes: 954886ea6d ("hw/riscv: virt: Add optional ACLINT support to virt machine")
> > > Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > > ---
> > >   hw/riscv/virt.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > This patch is Cc'd to qemu-stable, but there's an interesting rebase twist here,
> > it looks like.  This is commit v11.1.0-1035-g9d6ac47d318 in the master branch.
> > 
> > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > > index a6ec9def16..83a4b7710d 100644
> > > --- a/hw/riscv/virt.c
> > > +++ b/hw/riscv/virt.c
> > > @@ -234,7 +234,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
> > >                  (s->memmap[VIRT_CLINT].size * socket);
> > >           size = s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
> > >       }
> > > -    name = g_strdup_printf("/soc/mtimer@%lx", addr);
> > > +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
> > > +                           addr + RISCV_ACLINT_DEFAULT_MTIME);
> > 
> > Before this commit, `add` variable is declared in this function as
> > unsigned long.  So this particular change is wrong, because now the
> > format string does not match its argument:
> > 
> > ../hw/riscv/virt.c: In function 'create_fdt_socket_aclint':
> > ../hw/riscv/virt.c:408:28: error: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'long unsigned int' [-Werror=format=]
> >    408 |     name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
> >        |                            ^~~~~~~~~~~~~~~
> >    409 |                            addr + RISCV_ACLINT_DEFAULT_MTIME);
> >        |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >        |                                 |
> >        |                                 long unsigned int
> > In file included from ../include/qemu/osdep.h:118,
> >                   from ../hw/riscv/virt.c:21:
> > /usr/x86_64-w64-mingw32/sys-root/mingw/include/inttypes.h:38:19: note: format string is defined here
> >     38 | #define PRIx64 "llx"
> > 
> > However, the very next commit, v11.1.0-1036-ge6ea6bec5a3
> > "hw/riscv/fdt-common, virt.c: add riscv_create_fdt_socket_aclint()",
> > moves this whole function to another file, *and* changes the type of
> > `addr` variable to hwaddr.  So now, everything fits.
> > 
> > But this single patch alone does not work.
> > 
> > Note also there's no mentions of this type change anywhere.
> > 
> > So, what was the actual issue ere?
> > 
> > I'm dropping this patch from the stable series for now, it is definitely
> > wrong.
> 
> It is ok to drop this.  This is a FDT issue that has been around for several
> years at this point and no one noticed.
> 
> In case you want to port it anyway the right fix would be this:
> 
> 
> name = g_strdup_printf("/soc/mtimer@%lx", addr + RISCV_ACLINT_DEFAULT_MTIME);
> 
> 
> This would fix the FDT nodename without messing with the format string.
> 
> 
> > 
> > It is also interesting that only win64 build of qemu detected this, all
> > other went just fine.
> 
> Yep, this went unnoticed on my end since it didn't break on Linux during my
> testing ...
> 
I also run into build failures somtimes. Just share my idea, QEMU's gitlab CI
is very useful! But be careful when choosing the base commit or branch.

If you just use the latest master branch, CI may fail..

Thanks,
Chao
> 
> Cheers,
> Daniel
> 
> > 
> > Thanks,
> > 
> > /mjt
> 

