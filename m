Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AA6C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 09:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKCpN-0002pP-RT; Wed, 28 May 2025 05:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1uKCpM-0002lc-BG
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:12:00 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>) id 1uKCpK-0006f5-Df
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:12:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748423472; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lHL1m++Pka3pTtvLLt1O0cs/SnCxOPwx0a07sQl3L82Khsk6CoAIu9kkEUiy4IABjT5onX9vJJc+q4tQzT1MKlI5iFGsDoPVz6SZxnmvDgQb0lAJ9woQVVsOoqwhPaf6JO/gCdQecdpecsqB/JDlA+5lrYG0Z/z0Jq1BumZ24Gg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748423472;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=REdgpME5NVjjTg0yulNaYNQiNqkO0DVBlnGxD93ndHE=; 
 b=ije4vvNWIRg+0M6sNqJxOV1I+MmIEBGxfToTLWPAOci8YTU2g/PqevLF1m1eVPFzJGtqfTmFj6+/bMyQSG6vtT2ghHNJ/aHFDTsYfrF9iOgHXvBC0yrXD2fkOH1EYBSv1+EFpwrlKWx5tMuB3Yd1IQPhK1R+WA5M1qprI/Rd9M0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748423472; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=REdgpME5NVjjTg0yulNaYNQiNqkO0DVBlnGxD93ndHE=;
 b=GpEFs1Xa0VndtcziYI3lB89G/vMxgKdXbH0fUxJoCx6rB0VAMbL2ZrN3ZwDNsDRp
 iI7g1tVqqzFRrT8qSiN7Yscz/ZAyDpzsYf24vnkvIVSstrByETq4BjnaEACf4xOgHNd
 1oDko0GuCL19sm9k3uwPc+d+zd+4oVoe2vYw9hbk=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 174842344914184.75137743719858;
 Wed, 28 May 2025 02:10:49 -0700 (PDT)
Date: Wed, 28 May 2025 17:10:49 +0800
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
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Message-ID: <19716289a19.118e5995d2887663.8392966219912427610@linux.beauty>
In-Reply-To: <be8c1d4d-b68e-42b1-9466-3698ded1be10@linaro.org>
References: <87msberqzi.wl-me@linux.beauty> <87ldqyrqqo.wl-me@linux.beauty>
 <be8c1d4d-b68e-42b1-9466-3698ded1be10@linaro.org>
Subject: Re: [PATCH V3 1/4] acpi: Add machine option to disable SPCR table
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.12; envelope-from=me@linux.beauty;
 helo=sender4-op-o12.zoho.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Philippe,

 ---- On Mon, 26 May 2025 18:07:16 +0800  Philippe Mathieu-Daud=C3=A9 <phil=
md@linaro.org> wrote ---=20
 > Hi Li,
 >=20
 > On 15/5/25 14:41, Li Chen wrote:
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
 > >=20
 > > By default, the option is enabled (spcr=3Don), preserving existing
 > > behavior. When disabled, QEMU will omit the SPCR table from the guest'=
s
 > > ACPI namespace, ensuring that only consoles explicitly declared in the
 > > kernel command line are registered.
 > >=20
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > Reviewed-by: Bibo Mao <maobibo@loongson.cn>
 > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
 > > Reviewed-by: Gavin Shan <gshan@redhat.com>
 > > ---
 >=20
 >=20
 > > diff --git a/include/hw/boards.h b/include/hw/boards.h
 > > index 765dc8dd35..089104d54b 100644
 > > --- a/include/hw/boards.h
 > > +++ b/include/hw/boards.h
 > > @@ -444,6 +444,7 @@ struct MachineState {
 > >       SmpCache smp_cache;
 > >       struct NVDIMMState *nvdimms_state;
 > >       struct NumaState *numa_state;
 > > +    bool enable_spcr;
 >=20
 > This structure is used by all machines. Can we be more
 > descriptive, maybe naming as "acpi_spcr_enabled"?

Make sense to me, updated in v4, thanks!
(But I'm not sure why v4 failed to send to qemu-devel/qemu-arm/qemu-riscv a=
nd report
 "Message headers fail syntax check" error).

Regards,
Li


