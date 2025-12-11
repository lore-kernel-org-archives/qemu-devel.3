Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4347D41C14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTds7-0007RX-91; Thu, 11 Dec 2025 05:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vTds3-0007QG-PP; Thu, 11 Dec 2025 05:26:03 -0500
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vTds1-00062t-Mg; Thu, 11 Dec 2025 05:26:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1765448732; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fbXrSZtTlEAH3PzgYgJ36PbqjkoAwcgQzJ82p6TvEYmO8ikA634IAi0o99J57Og0ZPjF85sXliw9QddZgTm+Pes0lmDhQeNsutgXV5mIZ23wwgPr8lq4q69SIKmGsFaTlECwep+NnyNiuFnzcf4zM5y8i8sVwb7OfmAUatbGfVE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1765448732;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DZJZJZqJpKYSoeB/fSJExhf/+xXPr96sKY8ZeXG1xgI=; 
 b=C7hk7O/4LyGGD91gnvAF3AoDQoojIxKxGaHIy8toWITIVneJR7k88063hELMoUH4lHJmykMJffmZhJQJVDuiax/PoFurG10sAKeiI5KzNkTZbjDx7w8k5KHkoajFMhrivB/rkbSL5lpzeOCEAnmHTG8fROuqxHO1gg7y+TU/bhE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765448732; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=DZJZJZqJpKYSoeB/fSJExhf/+xXPr96sKY8ZeXG1xgI=;
 b=GfALw4LQ9dFD1lotx+DrQcuhnhHOoGkemI+0nDEhS/G8uOcNl/lfDHBQzoEdjvft
 Aq2NXMBc60+W6ESB5fEFBHr++TTD/DyhjalMSzD8uNIZC2CMHYQ4orLFY8x65piubcD
 CAqw6YLu6pKaSe5TMDG0rd65krkKwdyC5rhBF6xw=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1765448729097945.3561874895004;
 Thu, 11 Dec 2025 02:25:29 -0800 (PST)
Date: Thu, 11 Dec 2025 18:25:29 +0800
From: Li Chen <me@linux.beauty>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>,
 "Zhao Liu" <zhao1.liu@intel.com>, "Song Gao" <gaosong@loongson.cn>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Message-ID: <19b0cf1c1dd.3e0ec837386469.8764466025780095235@linux.beauty>
In-Reply-To: <20251211024304-mutt-send-email-mst@kernel.org>
References: <20250528105404.457729-1-me@linux.beauty>
 <20250528105404.457729-5-me@linux.beauty>
 <20250714144303-mutt-send-email-mst@kernel.org>
 <1981309e2fa.31709fd32611761.5900055972026140740@linux.beauty>
 <20250716074207-mutt-send-email-mst@kernel.org>
 <198131a686b.18fb34702623779.7633947002456257034@linux.beauty>
 <1995f320053.73c58bde124269.3373604835167896043@linux.beauty>
 <19b0837500d.2713ffb3821327.2786629512090065997@linux.beauty>
 <20251210075237-mutt-send-email-mst@kernel.org>
 <19b0ab7f203.43fecb3b140213.6490567972995015069@linux.beauty>
 <20251211024304-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH REPOST v4 4/4] acpi/virt: suppress UART device & SPCR
 when guest has no serial hardware
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.12; envelope-from=me@linux.beauty;
 helo=sender4-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Michael,

 ---- On Thu, 11 Dec 2025 15:43:45 +0800  Michael S. Tsirkin <mst@redhat.co=
m> wrote ---=20
 > On Thu, Dec 11, 2025 at 08:03:05AM +0800, Li Chen wrote:
 > > Hi Tsirkin,
 > >=20
 > >  ---- On Wed, 10 Dec 2025 20:53:01 +0800  Michael S. Tsirkin <mst@redh=
at.com> wrote ---=20
 > >  > On Wed, Dec 10, 2025 at 08:23:21PM +0800, Li Chen wrote:
 > >  > > Hi Michael,
 > >  > >=20
 > >  > >  ---- On Fri, 19 Sep 2025 07:38:56 +0800  Li Chen <me@linux.beaut=
y> wrote ---=20
 > >  > >  > Hi Michael,
 > >  > >  >=20
 > >  > >  >  ---- On Wed, 16 Jul 2025 19:59:14 +0800  Li Chen <me@linux.be=
auty> wrote ---=20
 > >  > >  >  > Hi Michael,
 > >  > >  >  >=20
 > >  > >  >  >  ---- On Wed, 16 Jul 2025 19:42:42 +0800  Michael S. Tsirki=
n <mst@redhat.com> wrote ---=20
 > >  > >  >  >  > On Wed, Jul 16, 2025 at 07:41:11PM +0800, Li Chen wrote:
 > >  > >  >  >  > > Hi Michael,
 > >  > >  >  >  > >=20
 > >  > >  >  >  > > Thanks for your kind review! All issues below have bee=
n fixed in v5:
 > >  > >  >  >  > > https://lore.kernel.org/qemu-devel/20250716111959.4049=
17-5-me@linux.beauty/T/#m696cee9a95646add1b74b866c3d6761aa4c5c762
 > >  > >  >  >  >=20
 > >  > >  >  >  > Past soft freeze now: I tagged this but pls remind me af=
ter the release
 > >  > >  >  >  > to help make sure it's not lost.
 > >  > >  > =20
 > >  > >  > Gentle reminder: This patch is still missing from the latest m=
aster branch, but can apply without
 > >  > >  > any conflict. Can it be included in 10.2?
 > >  > >  >=20
 > >  > >  > Regards,
 > >  > >  > Li.
 > >  > >  >=20
 > >  > >  >=20
 > >  > >=20
 > >  > > Sorry for bothering again. But I'm still unable to find this patc=
h in the latest master branch, though it applies without conflicts now.=20
 > >  > >=20
 > >  > > Could it be merged now?
 > >  > >=20
 > >  > > Regards,
 > >  > > Li=E2=80=8B
 > >  >=20
 > >  > you still need to update loongarch, I think. otherwise these tests =
will
 > >  > fail.
 > >=20
 > > Yes, it seems that tap stdout is polluted by serial stdio.
 > >=20
 > > I'll address the stdout pollution from -serial stdio by redirecting se=
rial output to /dev/null using -serial null in the next version.=20
 > > This will still create the serial device but prevent it from writing t=
o the console.
 > >=20
 > > Regards,
 > >=20
 > > Li=E2=80=8B
 >=20
 > I don't know about that, what I meant is that loongaarch also has SPCR
 > so it's expected tables have to be updated.

My apologies, I misunderstood your previous comment. I just found I already=
 added LoongArch support in v5 [1] months ago. I've now fixed the tap=20
parsing error and submitted v6 of the patch [2]. And now all tests can pass=
.

[1]: https://patchew.org/QEMU/20250716111959.404917-1-me@linux.beauty/20250=
716111959.404917-5-me@linux.beauty/
[2]: https://lore.kernel.org/qemu-devel/20251211102025.873506-1-me@linux.be=
auty/T/#u

Regards,

Li=E2=80=8B


