Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7EED3E783
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 00:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTU9m-0004qL-Mw; Wed, 10 Dec 2025 19:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vTU9k-0004q2-7X; Wed, 10 Dec 2025 19:03:40 -0500
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vTU9i-0006ST-Dc; Wed, 10 Dec 2025 19:03:39 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1765411387; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b3lUoOFNRBzpuI+/qj010GMMaDMQ0oPk4pHNandeWMEO9VxE43aKK9BRuIZM29hQ8riIJjUlXuBRCdSlihhRYACJQJl4jyX7ZDgDdgjZhKvxP4Pen3S2V99cUIlrc8+YNAwCa1l+EG82aKIfusmnLobtB3Qceq3yU6b4ooQiCtc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1765411387;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3zEjGOSn6g0n5qhXLIsKrGwfQAijgDoXpyq/W91ZZ1c=; 
 b=QM5rpHkgw7XrJFsMLIo3yDlb7K3L2UB8NealqNSef4x4Lmbcplc/qqggqFzjuW3kIoRCvLZWwqPZrfrMqGrvy2DZ2hxQgyzQbeT748a2e4AyB6iExCZNmXXbzVPhwHrlSjjdBfNSJ4pZ/KsNOMnj96kqkjoF8lDzEytWnUnLoUA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765411387; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=3zEjGOSn6g0n5qhXLIsKrGwfQAijgDoXpyq/W91ZZ1c=;
 b=arMkrj+aitwMAc4r4aucjQm+TAOt4/e6AhKWkY4qeGjyiQo9Nl3H9iKhv5rDeBZa
 Amlscom2gXVx34dc+rIQ6k3cGaP3TjpM6tif9OxyncnjxHU1ZzvMEw0oApKRAJopCFS
 DkDOc2pqU7/54HYYjSyS1wxYaHtpckCzEXWPGmlE=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1765411385875998.4473620910953;
 Wed, 10 Dec 2025 16:03:05 -0800 (PST)
Date: Thu, 11 Dec 2025 08:03:05 +0800
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
Message-ID: <19b0ab7f203.43fecb3b140213.6490567972995015069@linux.beauty>
In-Reply-To: <20251210075237-mutt-send-email-mst@kernel.org>
References: <20250528105404.457729-1-me@linux.beauty>
 <20250528105404.457729-5-me@linux.beauty>
 <20250714144303-mutt-send-email-mst@kernel.org>
 <1981309e2fa.31709fd32611761.5900055972026140740@linux.beauty>
 <20250716074207-mutt-send-email-mst@kernel.org>
 <198131a686b.18fb34702623779.7633947002456257034@linux.beauty>
 <1995f320053.73c58bde124269.3373604835167896043@linux.beauty>
 <19b0837500d.2713ffb3821327.2786629512090065997@linux.beauty>
 <20251210075237-mutt-send-email-mst@kernel.org>
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

Hi Tsirkin,

 ---- On Wed, 10 Dec 2025 20:53:01 +0800  Michael S. Tsirkin <mst@redhat.co=
m> wrote ---=20
 > On Wed, Dec 10, 2025 at 08:23:21PM +0800, Li Chen wrote:
 > > Hi Michael,
 > >=20
 > >  ---- On Fri, 19 Sep 2025 07:38:56 +0800  Li Chen <me@linux.beauty> wr=
ote ---=20
 > >  > Hi Michael,
 > >  >=20
 > >  >  ---- On Wed, 16 Jul 2025 19:59:14 +0800  Li Chen <me@linux.beauty>=
 wrote ---=20
 > >  >  > Hi Michael,
 > >  >  >=20
 > >  >  >  ---- On Wed, 16 Jul 2025 19:42:42 +0800  Michael S. Tsirkin <ms=
t@redhat.com> wrote ---=20
 > >  >  >  > On Wed, Jul 16, 2025 at 07:41:11PM +0800, Li Chen wrote:
 > >  >  >  > > Hi Michael,
 > >  >  >  > >=20
 > >  >  >  > > Thanks for your kind review! All issues below have been fix=
ed in v5:
 > >  >  >  > > https://lore.kernel.org/qemu-devel/20250716111959.404917-5-=
me@linux.beauty/T/#m696cee9a95646add1b74b866c3d6761aa4c5c762
 > >  >  >  >=20
 > >  >  >  > Past soft freeze now: I tagged this but pls remind me after t=
he release
 > >  >  >  > to help make sure it's not lost.
 > >  > =20
 > >  > Gentle reminder: This patch is still missing from the latest master=
 branch, but can apply without
 > >  > any conflict. Can it be included in 10.2?
 > >  >=20
 > >  > Regards,
 > >  > Li.
 > >  >=20
 > >  >=20
 > >=20
 > > Sorry for bothering again. But I'm still unable to find this patch in =
the latest master branch, though it applies without conflicts now.=20
 > >=20
 > > Could it be merged now?
 > >=20
 > > Regards,
 > > Li=E2=80=8B
 >=20
 > you still need to update loongarch, I think. otherwise these tests will
 > fail.

Yes, it seems that tap stdout is polluted by serial stdio.

I'll address the stdout pollution from -serial stdio by redirecting serial =
output to /dev/null using -serial null in the next version.=20
This will still create the serial device but prevent it from writing to the=
 console.

Regards,

Li=E2=80=8B


