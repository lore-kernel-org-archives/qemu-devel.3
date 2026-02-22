Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6E7C61DFF
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 03:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vu06u-0001u5-MF; Sat, 21 Feb 2026 22:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vu06u-0001sa-1y; Sat, 21 Feb 2026 22:26:20 -0500
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vu06s-0000lK-0p; Sat, 21 Feb 2026 22:26:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771730740; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cNbjaSH3ubSd076aKrNpCJxGltl+lAxhtMQGIp3QFETJd8OtuIGl/aZnKDOeuiPgSBa/u1YpOa529lLAQHeVN/sy4JYOTOv3/dKbbidhB9uXVZcO7AZSIAgzr2R6+jMg6mi00o9Ma8fLj31E0TGuhEMfnxywizTMpB+Qwt1qIZ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771730740;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tb6DnQ0GHeM9DHHwy+Tnu6i89ALnWqG24LeU9cSPQlg=; 
 b=WHQPkiEmjhIOEGcvOkRtKNcWpAVFHjK+HDgrt+G2t4V6k0eFqPYSGTxzr1qrOcl6gJvBiVMV2AM4gk0IILnCcn0IlIDVzcBAyM3BnuXhLoAovruD2a/Ippt68CwhJ2TUXC6j/WCnV/ZVrViZ09MV3tDblCqTqQ8l8yC7OgEn8Mo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771730740; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=tb6DnQ0GHeM9DHHwy+Tnu6i89ALnWqG24LeU9cSPQlg=;
 b=oO24DEHr78Wr7KQcq0Q6aq/DjbgqaSYr3y5BP98crH74gJ0zRnFbQXxWasXjQ7yI
 CyKcNxEbHOUJmDoF1DyGJuvT5N5ebN40Oef27WB8LB/ZHSMOdCvW4ZgS+W14FJDWU1P
 jBw0Hvz51mtItJH210fDQP7iJDYq18ChFcC82EPU=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1771730737548421.65379763987494;
 Sat, 21 Feb 2026 19:25:37 -0800 (PST)
Date: Sun, 22 Feb 2026 11:25:37 +0800
From: Li Chen <me@linux.beauty>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel" <qemu-devel@nongnu.org>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-riscv" <qemu-riscv@nongnu.org>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Song Gao" <gaosong@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>,
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>
Message-ID: <19c8361997b.82077cee2137730.7750036902825910397@linux.beauty>
In-Reply-To: <20260220094834-mutt-send-email-mst@kernel.org>
References: <20260219130403.810220-1-me@linux.beauty>
 <20260220094834-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH v7 1/1] acpi/virt: suppress SPCR when UART0 has no
 serial backend
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

 ---- On Fri, 20 Feb 2026 22:50:57 +0800  Michael S. Tsirkin <mst@redhat.co=
m> wrote ---=20
 > On Thu, Feb 19, 2026 at 09:04:02PM +0800, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > virt machines always instantiate a PL011/16550 UART at slot 0 and desc=
ribe
 > > it in ACPI (DSDT and optional SPCR table). When the command line disab=
les
 > > the serial backend (e.g. "-serial none"), SPCR still points at UART0 a=
nd
 > > the guest may pick it as the preferred console even though it is not
 > > usable.
 > >=20
 > > Only generate SPCR when UART0 has a chardev backend attached. Keep the
 > > UART device description in DSDT unchanged so the guest-visible UART
 > > topology does not change.
 > >=20
 > > The bios-tables-test qtests use "-serial null" to keep SPCR enabled wh=
ile
 > > discarding firmware serial output, avoiding TAP stdout corruption.
 > >=20
 > > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
 > > ---
 >=20
 > So -serial null gives a device -serial none hides it from guest.
 > Sensible. And yet, out of abundance of caution, maybe keep
 > the legacy behaviour for existing machine types. No?

Thanks. I see your point about being cautious with legacy behaviour.
Given you and Igor's feedback, gating SPCR on chardev backend state is not =
the
right approach, so I'll drop this patch.

Regards,
Li=E2=80=8B


