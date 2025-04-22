Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A958BC369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FVa-0007ds-8t; Tue, 22 Apr 2025 11:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7FVT-0007cS-Fu; Tue, 22 Apr 2025 11:25:58 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7FVR-0000rj-42; Tue, 22 Apr 2025 11:25:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745335519; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JVWoWIJfxZjZI3v/+vk0fOJ5JBn689G3Z/mFyadR8aQ5Uc7TUan2YPp9kG0q96Tkv0I6zv7TpWTf0ZN2W27jGKLgPpNDfsAsGNOMCRTnyojN5RYZBBfSzFFzzFbBn8RoT7yYgXjBuA4Bjtb9dpYZWzsQaaq9E5Z4tIlUmiwC8Oo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745335519;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8TUOAK4dfw6psyhRy6BzmcaE9jy5HibvFtdX8sbr7os=; 
 b=I5OzcM/Tv3BxrZ5rpTJfKYny6Z+3DKJ0MHSDxsQ/WoNYEJO2sHAe9Dv1viDLQpELLujlXPWkyw3lLYaJUjZvGVKhFW4LTWylsWfD3BFNO+/AgC+FqJYoXDhfzKRevzOc6UUN7HtCJvzjpMkzUmfEN20HPAy5GJW5IwtDD34kk0E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745335519; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=8TUOAK4dfw6psyhRy6BzmcaE9jy5HibvFtdX8sbr7os=;
 b=EcRIdbZf06OSmwXgSDT1vEHTaY5ETM/lz1xw2LaCLIaLIeavhp0j9tHH1/hBvAXG
 ZJOlWOczRwJRVmcCUVpFXF/oMiAlTzGMisy53ZqsqMbIaRqGlagyO12GI9Yrhp7jJ7B
 gRtI74imOtjfdgALrXOZKyy7IHwoaefC0Z4ucAVc=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1745335518281881.1837526050226;
 Tue, 22 Apr 2025 08:25:18 -0700 (PDT)
Date: Tue, 22 Apr 2025 23:25:18 +0800
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
Message-ID: <1965e1a8431.cb206d1e1037721.7771287202770929929@linux.beauty>
In-Reply-To: <c67391b9-297f-478b-aea5-c27b0dba6cfd@linaro.org>
References: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
 <1965d6357a1.dfa9d35b911644.778874035603636753@linux.beauty>
 <c67391b9-297f-478b-aea5-c27b0dba6cfd@linaro.org>
Subject: Re: [PATCH V2 1/3] acpi: Add machine option to disable SPCR table
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Philippe Mathieu-Daud=C3=A9,

Thanks for your review!

 ---- On Tue, 22 Apr 2025 21:18:46 +0800  Philippe Mathieu-Daud=C3=A9 <phil=
md@linaro.org> wrote ---=20
 > Hi,
 >=20
 > On 22/4/25 14:05, Li Chen wrote:
 > > diff --git a/include/hw/boards.h b/include/hw/boards.h
 > > index f22b2e7fc7..cdf2791a50 100644
 > > --- a/include/hw/boards.h
 > > +++ b/include/hw/boards.h
 > > @@ -444,6 +444,7 @@ struct MachineState {
 > >       SmpCache smp_cache;
 > >       struct NVDIMMState *nvdimms_state;
 > >       struct NumaState *numa_state;
 > > +    bool enable_spcr;
 >=20
 > I'm a bit reluctant to add a field used by 3 virt machines as
 > generic in MachineState. Shouldn't it be for each machine state?

I looked for alternative locations for this field before submitting v1 but =
couldn't find any.
I re-evaluated potential locations, like struct AcpiBuildState, but ARM, Lo=
ongArch, and RISC-V=20
just use their own AcpiBuildState.

BTW, ACPI-supporting virtual machines may eventually adopt SPCR. Although c=
urrent there=20
are just three users, future adoption is probable, making it a suitable fie=
ld for each machine state.

Feel free to tell me if you have any other suggestions.

 >=20
 > Also I'm surprised we announce the SPCR table regardless a virt
 > serial exists. Shouldn't we have a disabled default and only
 > enable on virt machines, preferably checking the serial port
 > availability?

So you mean we should avoid building SPCR for cases like "-serial none"? If=
 so, I can add a patch to check serial
device availability before doing spcr_setup in  ARM/RISC-V/LoongArch codes.=
=20
Should this change be the first patch in this series, or just a separate se=
ries?

Regards,
Li

