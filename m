Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF7EC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0rE-00018K-9R; Wed, 16 Jul 2025 08:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uc0nl-0007eV-94; Wed, 16 Jul 2025 07:59:57 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uc0nf-0000Y3-B7; Wed, 16 Jul 2025 07:59:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1752667156; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XiL8XQN4ym855SneN6kEO4G9cHxPApiD87ii8xoa/TgiqS+pajzhTTGqq1ZlQTmRnpkjVvFJKbAWpg3O83X8z1Kq8WKTThByNVKSSicqUhWaBRG0WomySd0vENmLy555JXd2fJIitcx1fXsxv43M8JqiaklYEDpfn+n3qWuHlSY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752667156;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RAfeCURvXMiMScDTykZANyqL5e/VhXBrjVcH1Ir72Tw=; 
 b=JP+H/VzhVmRBGi6qn64gH6ABOo6OnBkjsS6V+4Bfufr6PpESRRiYQk5p6J7EK7BeFfNEtF3/psvoAaFlLs+D1dWfk+bHWHROxxidn8wgQixUcphn9IoHEaA5aXO4RdCL3Kb5CqD8oJn2X+24wSS5VHa5wEWo58eGRPAZnIYZzFI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752667156; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=RAfeCURvXMiMScDTykZANyqL5e/VhXBrjVcH1Ir72Tw=;
 b=f4Lm2QSrwfApJRjPXSnYh46XrQNT3Q2OxpmoD4vDd0vLkpaCO04EPuc4uYbR6PxL
 grbq1C/9gZGPpBAH5gw4lSC33uzc3SJAUwqr2ccl+XVidwm3CWMPnhe3UVNyHa3YNo3
 o/D+FK3+w9gc952VvC0DnJNevPWyqW2F4EcPIX8U=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1752667154652735.6352112545944;
 Wed, 16 Jul 2025 04:59:14 -0700 (PDT)
Date: Wed, 16 Jul 2025 19:59:14 +0800
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
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>,
 "Li Chen" <chenl311@chinatelecom.cn>
Message-ID: <198131a686b.18fb34702623779.7633947002456257034@linux.beauty>
In-Reply-To: <20250716074207-mutt-send-email-mst@kernel.org>
References: <20250528105404.457729-1-me@linux.beauty>
 <20250528105404.457729-5-me@linux.beauty>
 <20250714144303-mutt-send-email-mst@kernel.org>
 <1981309e2fa.31709fd32611761.5900055972026140740@linux.beauty>
 <20250716074207-mutt-send-email-mst@kernel.org>
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
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

 ---- On Wed, 16 Jul 2025 19:42:42 +0800  Michael S. Tsirkin <mst@redhat.co=
m> wrote ---=20
 > On Wed, Jul 16, 2025 at 07:41:11PM +0800, Li Chen wrote:
 > > Hi Michael,
 > >=20
 > > Thanks for your kind review! All issues below have been fixed in v5:
 > > https://lore.kernel.org/qemu-devel/20250716111959.404917-5-me@linux.be=
auty/T/#m696cee9a95646add1b74b866c3d6761aa4c5c762
 >=20
 > Past soft freeze now: I tagged this but pls remind me after the release
 > to help make sure it's not lost.
 >=20

Ok.

Regards,
Li=E2=80=8B


