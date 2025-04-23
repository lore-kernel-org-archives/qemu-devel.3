Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5CBC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 08:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Vbq-0004Mj-NB; Wed, 23 Apr 2025 04:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7Vbm-0004Lz-OP; Wed, 23 Apr 2025 04:37:30 -0400
Received: from sender3-op-o12.zoho.com ([136.143.184.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7Vbk-0001UK-ET; Wed, 23 Apr 2025 04:37:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745397416; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YtF4t0iDxtwaNOQIXHKE7ymALitrDIsAjyAZQSGge9wSAuckqFrZys1R0GY5dt9a1i/iYYT3+OlNK6pCxEe1sYO3DBlr9O7EVHDwJmMr3tBC/oVrc8/UVsgEv0ip1nrBg9uyQ+7SJKi6nlqcKYNSsPRcc2eP5ih3apSSU5K4CKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745397416;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DLiG68aWG2qKmHUEF0B4qSFIJB1PTuOxaDN+OdB1NFc=; 
 b=kJIhQaXyIW1TOpoHHE7/Pil4IIyTVHVy7/vu0/wxAFbJdwOoYPGKjv3300WSeHmZIfH6Rl0UcJbd7xs5CSErRw6luKPMqusi8O/TKV2zDDi9ToYb5XXPaKD3xwtdWFNQMjOV7M+1rVEbYEvn/xONG0ilBkvNImrOKy7SeNOT9a4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745397416; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=DLiG68aWG2qKmHUEF0B4qSFIJB1PTuOxaDN+OdB1NFc=;
 b=oyPjF0UR4TCVL8GBfQ3v3tLbsLTb6SA8/G8L88fwDZpSEsY+rLH0g0L46A1XJgzB
 KZxV4YiYykTSLo9er0U+anUjF2BC3Sjo63H8h/5AM/NK5lHL5pAOXElPpG1qarwYCGx
 5MOaHNIpYLB99PnCrFHxcqUlmsdjZ6fwighvQLDw=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1745397413734890.1693772533544;
 Wed, 23 Apr 2025 01:36:53 -0700 (PDT)
Date: Wed, 23 Apr 2025 16:36:53 +0800
From: Li Chen <me@linux.beauty>
To: "bibo mao" <maobibo@loongson.cn>
Cc: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
Message-ID: <19661caf736.1119e56341303707.7495372918825001957@linux.beauty>
In-Reply-To: <dea44766-af4a-98ad-54fb-bee8fe647d3f@loongson.cn>
References: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
 <dea44766-af4a-98ad-54fb-bee8fe647d3f@loongson.cn>
Subject: Re: [PATCH V2 0/3] acpi: Add machine option to disable SPCR table
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.184.12; envelope-from=me@linux.beauty;
 helo=sender3-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Bibo,

 ---- On Wed, 23 Apr 2025 14:27:36 +0800  bibo mao <maobibo@loongson.cn> wr=
ote ---=20
 >=20
 >=20
 > On 2025/4/22 =E4=B8=8B=E5=8D=888:03, Li Chen wrote:
 > > This series introduces a new machine option, spcr=3Don|off, allowing u=
sers
 > > to disable the ACPI SPCR (Serial Port Console Redirection) table.
 > > By default, SPCR is enabled. Disabling it can help ensure that the gue=
st > console behavior is determined solely by kernel command-line parameter=
s
 > Hi Li,
 >=20
 > SPCR only provides serial port HW description information.
 >=20
 > However how to use is determined by Linux kernel, Can you describe the=
=20
 > detailed scenario which is unintended serial console configurations=20
 > imposed by firmware?

Yes, it is decided by the kernel, more specifically, by how architecture-sp=
ecific code utilizes acpi_parse_spcr. For example, in the 5.10 arm64 kernel=
=20
https://elixir.bootlin.com/linux/v5.10.236/source/arch/arm64/kernel/acpi.c#=
L236,  it passes true to acpi_parse_spcr's param enable_console.

So, SPCR consoles are respected by Arm64 Linux by default. Therefore, even =
without a console=3DttyAMA0 configuration, ttyAMA0 is still added as a pref=
erred console
and used by printk.

Regards,
Li

