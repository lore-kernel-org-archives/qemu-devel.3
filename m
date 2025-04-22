Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A124C369D9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 13:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7DLi-0004Cx-3z; Tue, 22 Apr 2025 09:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u79UQ-0002qX-G8; Tue, 22 Apr 2025 05:00:27 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u79UN-0005dJ-0B; Tue, 22 Apr 2025 05:00:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745312267; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fmB0EH6Ie4DQb7aEGAD2biy7XYeS79oFpoYzAh+5R8lgGgH8M9A8LuIfwpW9kTtnGMxIFYRwJH+UFQuCA+UghtvZBV4aKdE/0fEAk3Byla+ExL45rS0ggEP3CTjmBKdJ7QklnO9OXgNYE9MdFg1MaD3dnsTnqDs0hXULUHrFfwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745312267;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Xp3gpPv0RpjdEgFzNDAYCQ5MuMspPbiN8K/GlNJBqmo=; 
 b=FdmgMr+Cpm6GIK/Eqf50U0gdGu6yKo9UYuDkgfLjGqRx0VaM3Wm59Erxaf375bfwUzMoW87+RAow/uhFePPhF7FEzG7cV2i0uTEc3tKpIca+3e4mjpUqGpxeTbiZ/RoZ/CUP6xEmhmYSMWYilep0C9KBTA3Y3jUHts1lLOLoRRA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745312267; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Xp3gpPv0RpjdEgFzNDAYCQ5MuMspPbiN8K/GlNJBqmo=;
 b=bxcuZl0MK/CZer10quLVjld7+oJQE1FyD/AQR0iohyBJ9cc3fv+HF03IM+chyfKr
 doBLDVg5XQQ1rIIPot3uKVHlaJOthzFyYSBZUkCCfyiur6qQvFM1a1ooD/SZ3J3TIeb
 rDp7g+h5b3FUtI2+06NPT6N4TPRdhnl9BSZ5gTL8=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1745312264824897.1584688943897;
 Tue, 22 Apr 2025 01:57:44 -0700 (PDT)
Date: Tue, 22 Apr 2025 16:57:44 +0800
From: Li Chen <me@linux.beauty>
To: =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>
Cc: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "Yanan Wang" <wangyanan55@huawei.com>,
 "Zhao Liu" <zhao1.liu@intel.com>, "Song Gao" <gaosong@loongson.cn>,
 "Bibo Mao" <maobibo@loongson.cn>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Message-ID: <1965cb7b258.11d7ab5af837942.6319847926409671146@linux.beauty>
In-Reply-To: <2b3ca5a6-a2fb-414b-bbcf-f2ec9ce2df28@linaro.org>
References: <87a588wsc9.wl-me@linux.beauty>
 <2b3ca5a6-a2fb-414b-bbcf-f2ec9ce2df28@linaro.org>
Subject: Re: [PATCH] acpi: Add machine option to disable SPCR table
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 22 Apr 2025 09:07:38 -0400
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

Hi Philippe,

Thanks for your review!

 ---- On Tue, 22 Apr 2025 16:00:19 +0800  Philippe Mathieu-Daud=C3=A9 <phil=
md@linaro.org> wrote ---=20
 > Hi,
 >=20
 > On 22/4/25 09:47, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > The ACPI SPCR (Serial Port Console Redirection) table allows firmware
 > > to specify a preferred serial console device to the operating system.
 > > On ARM64 systems, Linux by default respects this table: even if the
 > > kernel command line does not include a hardware serial console (e.g.,
 > > "console=3DttyAMA0"), the kernel still register the serial device
 > > referenced by SPCR as a printk console.
 > >=20
 > > While this behavior is standard-compliant, it can lead to situations
 > > where guest console behavior is influenced by platform firmware rather
 > > than user-specified configuration. To make guest console behavior more
 > > predictable and under user control, this patch introduces a machine
 > > option to explicitly disable SPCR table exposure:
 > >=20
 > >      -machine spcr=3Doff
 >=20
 > Please add some tests in tests/qtest/bios-tables-test.c.
=20
I'll add test machines for all affected architectures in v2. Thanks again.

Regards,
Li

