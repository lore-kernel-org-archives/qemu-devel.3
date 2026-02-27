Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFF9FD7F94
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 11:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvvZC-0007wY-1c; Fri, 27 Feb 2026 05:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvvZA-0007wD-JY
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:59:28 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvvZ7-0005gX-Kr
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:59:28 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48374014a77so21655935e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 02:59:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772189963; cv=none;
 d=google.com; s=arc-20240605;
 b=haqMAaBZ6r/Ea+xbZaBm0IeHsLjTa8TwqIdS7AZs49x+iES8e8AVXD+iqdhliMODe+
 HXGIXm8QvtJUwTquHdqrknEuyr9sOlKphqgLMjue8o6IloK0P4HJJP+wP4oJWMQ+5HO6
 kGqxfQdhPsRA3zXqhfNbrfVbVPWQrPB9qZat+g5QW+xL2d2vOnXX0AI+u8NW/PJZMF62
 JigCOJ3AjTvVAhFfALuccwQjuYsfanyljkixXjU6N1H85K9vD66PiQwVH2MwHhgAan7M
 k6H3JGV1CMzTZ8AhjFr2HOHrlDY1lzuU+0gDvf/aV/V7AJDKeD8m11kPnG59AIqFegDO
 bWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bgu6RvuqdjWsKnK6qCvJpaT7UtMWlxZRWVbhnX5nzP0=;
 fh=YTxI/2B0tIA4OGE8g1nLoHfXTEPH/KCzPpRqw/hY+Dc=;
 b=IZtct/FqjGc0gzpB9h0SpdU2UhcYHNZBCfj1UAa1IeleaooAJUmTFgTf2FArSrnGtA
 AICBY6a+NTPnmLzd3jS9uPR4dl81z3U5rD8FkTw3lHoDCrR0IylgAqyYjITqmqqzjk33
 kcf9L8Lo+C7rZnYBXxlHgYUzIFqApJVkCot3t8vBLLFCkau5pQ3SyttV8gIlcJWDSb0u
 B+4rsSzPFHUDJtu2vz+yqOxlYz4DZ2J1EhgklRm15NCsUtPUIRPGUGcc65Z27Pgx5sXw
 mjBqE6MZNDUZjajdjO2diZS2uenbdV6V8t7R1iUXmyFFdLmvOjp9crcWrwd3iPaQ3y0q
 9zDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772189963; x=1772794763; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bgu6RvuqdjWsKnK6qCvJpaT7UtMWlxZRWVbhnX5nzP0=;
 b=nNAFHhIEbXV0V9vwLRtos2ii/pc4SWiwTj99+eYhhdQL3V1UcNF2W4u6Adyg+KH5lT
 MQUy9WRd8aO/KCCwQqCo4YI4jLq9cDYmJknDUCJi3R6Dj/gWGhzRyz7jNzI66yuCX0xZ
 /nGfiaEzfJULMreQQ3a/wYmGW4h8sBLkjm/UJebKqVeMREujlWtKeVAh6G8bTxB3U8g1
 hfqmDx8rB4UhLXJn3gX4ja3Ph5/OhYYObsfsPG0y4J+C59idPYF/vz9r35TYH8rZ1tE7
 tC/qOx8gyPrEsEVpLtxrFFhtnEjObbrC5CAKdtqagp/hehzrTJrd9htx6UeZwjd2QL4Q
 bITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772189963; x=1772794763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bgu6RvuqdjWsKnK6qCvJpaT7UtMWlxZRWVbhnX5nzP0=;
 b=Q03yveBbGpBayo1XbmUILa5ktAtCKbSPbZGNDr5tl59CCZGM3pPoJ8kSt3dwu4pXlq
 JmazmViwdgt4d0hdayUjDJRMWkLU6s9ENp/QgM95Ty1veqcp4wGvY61hhZkwuNCWKYCU
 npcVIeXmZdzk7hsGK7zxIgON4m9X23pIV6+VR8S7p6E27Y0SN9QhOrRdOXJCy6DITWbz
 xJx872GH4mhWhhUupv+2CWpHCq7ZxX5Yh86TBrBM0kAlT6APHnxGzm5EbaQW+DjtMggg
 rVb9vbYQnllg411L2+MqE0m37kll96Lmc+anhFtAC2o32iITglaAetHf0F8Z5JTgwqa5
 qFwQ==
X-Gm-Message-State: AOJu0YzEyUN1mTCcMs5ufYVopwEQ66AKK7eDj0ptIBBN/7PC0+UzGVgr
 LnutZYqvPsfldZEpdEgqsTu2X8iL2uSZOtAysNU1A0dN5S4VK34MAyzYGR1Aw6ZDxmqUxN0z1cI
 r4ObcGXSsqRPNgqRhocEDk+i8J4Yb8hZPwoFT+aoRZg==
X-Gm-Gg: ATEYQzyQD6Io6m85YkQAaTNzj509ZVJx5iZ7Gx4+Lx6c4qsA2Alpa6DppxhNdO0yraD
 oUH/atC11qVDySJcsrfDHEtGRRS7gPWDOBRQAeM7yXt3d1yusftZ+80tKdXNirBTpDftgR6XkxD
 WgWDTOCw66Fti8mZ24GB6OcPCl0o6bgh4XF454zPDdEJQL5buqJUU8z5z0cPO5TmZ5bF/oQK6+f
 KBhS3GKgDhcnkOcuCASSH0J8+Vc6HsGhKYft4vPFlNmrTo/HEC3cAliFZoKHeJfqULpSs1IwNHg
 bu3XRFTDlntye2WQQmvXQwYokFkfplehXu2Oc263b087Xlk2qQ==
X-Received: by 2002:a05:600c:a086:b0:483:b3d7:2e80 with SMTP id
 5b1f17b1804b1-483c9c1fc82mr32673475e9.33.1772189962904; Fri, 27 Feb 2026
 02:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20260227104314.81038-1-philmd@linaro.org>
 <20260227104314.81038-4-philmd@linaro.org>
In-Reply-To: <20260227104314.81038-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 27 Feb 2026 12:58:56 +0200
X-Gm-Features: AaiRm52kHyqQjjyTwJK8lkXrKSkpgxEw-VXxCsLlrm5rYQpJIopH60fi4kfwKI4
Message-ID: <CAAjaMXb8aZhGh1VRmLdorzFOuAqSOTQKzWuqo_HZBQFEBTcRkw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] gdbstub: Move gdb-xml/ within gdbstub/
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 27, 2026 at 12:44=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> gdb-xml/ files are only consumed by gdbstub API.
> No need for a top-level entry, move them to gdbstub/.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  MAINTAINERS                                   | 19 +++++++++----------
>  docs/devel/codebase.rst                       |  2 --
>  meson.build                                   |  2 +-
>  {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-core.xml |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-fpu.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-mte.xml  |  0
>  .../gdb-xml}/aarch64-pauth.xml                |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-sme2.xml |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/alpha-core.xml   |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/arm-core.xml     |  0
>  .../gdb-xml}/arm-m-profile-mve.xml            |  0
>  .../gdb-xml}/arm-m-profile.xml                |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/arm-neon.xml     |  0
>  .../gdb-xml}/arm-vfp-sysregs.xml              |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/arm-vfp.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/arm-vfp3.xml     |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/avr-cpu.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/cf-core.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/cf-fp.xml        |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/hexagon-core.xml |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/hexagon-hvx.xml  |  0
>  .../gdb-xml}/i386-32bit-linux.xml             |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/i386-32bit.xml   |  0
>  .../gdb-xml}/i386-64bit-apx.xml               |  0
>  .../gdb-xml}/i386-64bit-linux.xml             |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/i386-64bit.xml   |  0
>  .../gdb-xml}/loongarch-base32.xml             |  0
>  .../gdb-xml}/loongarch-base64.xml             |  0
>  .../gdb-xml}/loongarch-fpu.xml                |  0
>  .../gdb-xml}/loongarch-lasx.xml               |  0
>  .../gdb-xml}/loongarch-lsx.xml                |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/m68k-core.xml    |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/m68k-fp.xml      |  0
>  .../gdb-xml}/microblaze-core.xml              |  0
>  .../gdb-xml}/microblaze-stack-protect.xml     |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/or1k-core.xml    |  0
>  .../gdb-xml}/power-altivec.xml                |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/power-core.xml   |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/power-fpu.xml    |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/power-spe.xml    |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/power-vsx.xml    |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/power64-core.xml |  0
>  .../gdb-xml}/riscv-32bit-cpu.xml              |  0
>  .../gdb-xml}/riscv-32bit-fpu.xml              |  0
>  .../gdb-xml}/riscv-32bit-virtual.xml          |  0
>  .../gdb-xml}/riscv-64bit-cpu.xml              |  0
>  .../gdb-xml}/riscv-64bit-fpu.xml              |  0
>  .../gdb-xml}/riscv-64bit-virtual.xml          |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/rx-core.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-acr.xml     |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-cr.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-fpr.xml     |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-gs.xml      |  0
>  .../gdb-xml}/s390-virt-kvm.xml                |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-virt.xml    |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390-vx.xml      |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/s390x-core64.xml |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-cp0.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-cpu.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-fpu.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-cp0.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-cpu.xml  |  0
>  {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-fpu.xml  |  0
>  63 files changed, 10 insertions(+), 13 deletions(-)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-mte.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-pauth.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/aarch64-sme2.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/alpha-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-m-profile-mve.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-m-profile.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-neon.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-vfp-sysregs.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-vfp.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/arm-vfp3.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/avr-cpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/cf-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/cf-fp.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/hexagon-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/hexagon-hvx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/i386-32bit-linux.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/i386-32bit.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/i386-64bit-apx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/i386-64bit-linux.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/i386-64bit.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/loongarch-base32.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/loongarch-base64.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/loongarch-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/loongarch-lasx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/loongarch-lsx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/m68k-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/m68k-fp.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/microblaze-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/microblaze-stack-protect.xml (100%=
)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/or1k-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power-altivec.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power-spe.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power-vsx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/power64-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-32bit-cpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-32bit-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-32bit-virtual.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-64bit-cpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-64bit-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/riscv-64bit-virtual.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/rx-core.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-acr.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-cr.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-fpr.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-gs.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-virt-kvm.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-virt.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390-vx.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/s390x-core64.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-cp0.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-cpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc32-fpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-cp0.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-cpu.xml (100%)
>  rename {gdb-xml =3D> gdbstub/gdb-xml}/sparc64-fpu.xml (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 606b16762cf..fd316018b68 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -106,7 +106,7 @@ M: Thomas Huth <thuth@redhat.com>
>  S: Supported
>  F: configs/devices/s390x-softmmu/default.mak
>  F: configs/targets/s390x-softmmu.mak
> -F: gdb-xml/s390*.xml
> +F: gdbstub/gdb-xml/s390*.xml
>  F: hw/char/sclp*.[hc]
>  F: hw/char/terminal3270.c
>  F: hw/intc/s390_flic.c
> @@ -214,8 +214,8 @@ F: include/hw/cpu/a*mpcore.h
>  F: docs/system/target-arm.rst
>  F: docs/system/arm/cpu-features.rst
>  F: docs/system/arm/emulation.rst
> -F: gdb-xml/arm*.xml
> -F: gdb-xml/aarch64*.xml
> +F: gdbstub/gdb-xml/arm*.xml
> +F: gdbstub/gdb-xml/aarch64*.xml
>
>  ARM SMMU
>  M: Eric Auger <eric.auger@redhat.com>
> @@ -230,7 +230,7 @@ AVR TCG CPUs
>  M: Michael Rolnik <mrolnik@gmail.com>
>  S: Maintained
>  F: docs/system/target-avr.rst
> -F: gdb-xml/avr-cpu.xml
> +F: gdbstub/gdb-xml/avr-cpu.xml
>  F: target/avr/
>  F: tests/functional/avr/
>
> @@ -245,7 +245,7 @@ F: tests/tcg/hexagon/
>  F: disas/hexagon.c
>  F: configs/targets/hexagon-linux-user/default.mak
>  F: docker/dockerfiles/debian-hexagon-cross.docker
> -F: gdb-xml/hexagon*.xml
> +F: gdbstub/gdb-xml/hexagon*.xml
>  T: git https://github.com/quic/qemu.git hex-next
>
>  Hexagon idef-parser
> @@ -304,7 +304,7 @@ M: Stafford Horne <shorne@gmail.com>
>  S: Odd Fixes
>  F: docs/system/or1k/cpu-features.rst
>  F: target/or1k/
> -F: gdb-xml/or1k-core.xml
> +F: gdbstub/gdb-xml/or1k-core.xml
>  F: hw/or1k/
>  F: include/hw/or1k/
>  F: tests/functional/or1k/meson.build
> @@ -403,7 +403,7 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>  M: Artyom Tarasenko <atar4qemu@gmail.com>
>  S: Maintained
>  F: target/sparc/
> -F: gdb-xml/sparc*.xml
> +F: gdbstub/gdb-xml/sparc*.xml
>  F: hw/sparc/
>  F: hw/sparc64/
>  F: include/hw/sparc/sparc64.h
> @@ -491,7 +491,7 @@ S: Supported
>  F: target/s390x/kvm/
>  F: target/s390x/machine.c
>  F: target/s390x/sigp.c
> -F: gdb-xml/s390*.xml
> +F: gdbstub/gdb-xml/s390*.xml
>  T: git https://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>
> @@ -1348,7 +1348,7 @@ F: include/hw/intc/loongson_ipi_common.h
>  F: hw/intc/loongarch_*.c
>  F: hw/intc/loongson_ipi_common.c
>  F: hw/rtc/ls7a_rtc.c
> -F: gdb-xml/loongarch*.xml
> +F: gdbstub/gdb-xml/loongarch*.xml
>
>  M68K Machines
>  -------------
> @@ -3299,7 +3299,6 @@ F: docs/system/gdb.rst
>  F: gdbstub/*
>  F: include/exec/gdbstub.h
>  F: include/gdbstub/*
> -F: gdb-xml/
>  F: tests/tcg/multiarch/gdbstub/*
>  F: scripts/feature_to_c.py
>  F: scripts/probe-gdb-support.py
> diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
> index 69d88271178..f09307b8971 100644
> --- a/docs/devel/codebase.rst
> +++ b/docs/devel/codebase.rst
> @@ -88,8 +88,6 @@ yet, so sometimes the source code is all you have.
>    `VirtFS <https://www.linux-kvm.org/page/VirtFS>`_ support.
>  * `gdbstub <https://gitlab.com/qemu-project/qemu/-/tree/master/gdbstub>`=
_:
>    `GDB <GDB usage>` support.
> -* `gdb-xml <https://gitlab.com/qemu-project/qemu/-/tree/master/gdb-xml>`=
_:
> -  Set of XML files describing architectures and used by `gdbstub <GDB us=
age>`.
>  * `host <https://gitlab.com/qemu-project/qemu/-/tree/master/host>`_:
>    Various architecture specific header files (crypto, atomic, memory
>    operations).
> diff --git a/meson.build b/meson.build
> index 42f9cfb5512..56a746fed00 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4304,7 +4304,7 @@ foreach target : target_dirs
>    if 'TARGET_XML_FILES' in config_target
>      gdbstub_xml_files =3D []
>      foreach gdbstub_xml : config_target['TARGET_XML_FILES'].split()
> -      gdbstub_xml_files +=3D 'gdb-xml/' + gdbstub_xml
> +      gdbstub_xml_files +=3D 'gdbstub/gdb-xml/' + gdbstub_xml
>      endforeach
>      gdbstub_xml =3D custom_target(target + '-gdbstub-xml.c',
>                                  output: target + '-gdbstub-xml.c',
> diff --git a/gdb-xml/aarch64-core.xml b/gdbstub/gdb-xml/aarch64-core.xml
> similarity index 100%
> rename from gdb-xml/aarch64-core.xml
> rename to gdbstub/gdb-xml/aarch64-core.xml
> diff --git a/gdb-xml/aarch64-fpu.xml b/gdbstub/gdb-xml/aarch64-fpu.xml
> similarity index 100%
> rename from gdb-xml/aarch64-fpu.xml
> rename to gdbstub/gdb-xml/aarch64-fpu.xml
> diff --git a/gdb-xml/aarch64-mte.xml b/gdbstub/gdb-xml/aarch64-mte.xml
> similarity index 100%
> rename from gdb-xml/aarch64-mte.xml
> rename to gdbstub/gdb-xml/aarch64-mte.xml
> diff --git a/gdb-xml/aarch64-pauth.xml b/gdbstub/gdb-xml/aarch64-pauth.xm=
l
> similarity index 100%
> rename from gdb-xml/aarch64-pauth.xml
> rename to gdbstub/gdb-xml/aarch64-pauth.xml
> diff --git a/gdb-xml/aarch64-sme2.xml b/gdbstub/gdb-xml/aarch64-sme2.xml
> similarity index 100%
> rename from gdb-xml/aarch64-sme2.xml
> rename to gdbstub/gdb-xml/aarch64-sme2.xml
> diff --git a/gdb-xml/alpha-core.xml b/gdbstub/gdb-xml/alpha-core.xml
> similarity index 100%
> rename from gdb-xml/alpha-core.xml
> rename to gdbstub/gdb-xml/alpha-core.xml
> diff --git a/gdb-xml/arm-core.xml b/gdbstub/gdb-xml/arm-core.xml
> similarity index 100%
> rename from gdb-xml/arm-core.xml
> rename to gdbstub/gdb-xml/arm-core.xml
> diff --git a/gdb-xml/arm-m-profile-mve.xml b/gdbstub/gdb-xml/arm-m-profil=
e-mve.xml
> similarity index 100%
> rename from gdb-xml/arm-m-profile-mve.xml
> rename to gdbstub/gdb-xml/arm-m-profile-mve.xml
> diff --git a/gdb-xml/arm-m-profile.xml b/gdbstub/gdb-xml/arm-m-profile.xm=
l
> similarity index 100%
> rename from gdb-xml/arm-m-profile.xml
> rename to gdbstub/gdb-xml/arm-m-profile.xml
> diff --git a/gdb-xml/arm-neon.xml b/gdbstub/gdb-xml/arm-neon.xml
> similarity index 100%
> rename from gdb-xml/arm-neon.xml
> rename to gdbstub/gdb-xml/arm-neon.xml
> diff --git a/gdb-xml/arm-vfp-sysregs.xml b/gdbstub/gdb-xml/arm-vfp-sysreg=
s.xml
> similarity index 100%
> rename from gdb-xml/arm-vfp-sysregs.xml
> rename to gdbstub/gdb-xml/arm-vfp-sysregs.xml
> diff --git a/gdb-xml/arm-vfp.xml b/gdbstub/gdb-xml/arm-vfp.xml
> similarity index 100%
> rename from gdb-xml/arm-vfp.xml
> rename to gdbstub/gdb-xml/arm-vfp.xml
> diff --git a/gdb-xml/arm-vfp3.xml b/gdbstub/gdb-xml/arm-vfp3.xml
> similarity index 100%
> rename from gdb-xml/arm-vfp3.xml
> rename to gdbstub/gdb-xml/arm-vfp3.xml
> diff --git a/gdb-xml/avr-cpu.xml b/gdbstub/gdb-xml/avr-cpu.xml
> similarity index 100%
> rename from gdb-xml/avr-cpu.xml
> rename to gdbstub/gdb-xml/avr-cpu.xml
> diff --git a/gdb-xml/cf-core.xml b/gdbstub/gdb-xml/cf-core.xml
> similarity index 100%
> rename from gdb-xml/cf-core.xml
> rename to gdbstub/gdb-xml/cf-core.xml
> diff --git a/gdb-xml/cf-fp.xml b/gdbstub/gdb-xml/cf-fp.xml
> similarity index 100%
> rename from gdb-xml/cf-fp.xml
> rename to gdbstub/gdb-xml/cf-fp.xml
> diff --git a/gdb-xml/hexagon-core.xml b/gdbstub/gdb-xml/hexagon-core.xml
> similarity index 100%
> rename from gdb-xml/hexagon-core.xml
> rename to gdbstub/gdb-xml/hexagon-core.xml
> diff --git a/gdb-xml/hexagon-hvx.xml b/gdbstub/gdb-xml/hexagon-hvx.xml
> similarity index 100%
> rename from gdb-xml/hexagon-hvx.xml
> rename to gdbstub/gdb-xml/hexagon-hvx.xml
> diff --git a/gdb-xml/i386-32bit-linux.xml b/gdbstub/gdb-xml/i386-32bit-li=
nux.xml
> similarity index 100%
> rename from gdb-xml/i386-32bit-linux.xml
> rename to gdbstub/gdb-xml/i386-32bit-linux.xml
> diff --git a/gdb-xml/i386-32bit.xml b/gdbstub/gdb-xml/i386-32bit.xml
> similarity index 100%
> rename from gdb-xml/i386-32bit.xml
> rename to gdbstub/gdb-xml/i386-32bit.xml
> diff --git a/gdb-xml/i386-64bit-apx.xml b/gdbstub/gdb-xml/i386-64bit-apx.=
xml
> similarity index 100%
> rename from gdb-xml/i386-64bit-apx.xml
> rename to gdbstub/gdb-xml/i386-64bit-apx.xml
> diff --git a/gdb-xml/i386-64bit-linux.xml b/gdbstub/gdb-xml/i386-64bit-li=
nux.xml
> similarity index 100%
> rename from gdb-xml/i386-64bit-linux.xml
> rename to gdbstub/gdb-xml/i386-64bit-linux.xml
> diff --git a/gdb-xml/i386-64bit.xml b/gdbstub/gdb-xml/i386-64bit.xml
> similarity index 100%
> rename from gdb-xml/i386-64bit.xml
> rename to gdbstub/gdb-xml/i386-64bit.xml
> diff --git a/gdb-xml/loongarch-base32.xml b/gdbstub/gdb-xml/loongarch-bas=
e32.xml
> similarity index 100%
> rename from gdb-xml/loongarch-base32.xml
> rename to gdbstub/gdb-xml/loongarch-base32.xml
> diff --git a/gdb-xml/loongarch-base64.xml b/gdbstub/gdb-xml/loongarch-bas=
e64.xml
> similarity index 100%
> rename from gdb-xml/loongarch-base64.xml
> rename to gdbstub/gdb-xml/loongarch-base64.xml
> diff --git a/gdb-xml/loongarch-fpu.xml b/gdbstub/gdb-xml/loongarch-fpu.xm=
l
> similarity index 100%
> rename from gdb-xml/loongarch-fpu.xml
> rename to gdbstub/gdb-xml/loongarch-fpu.xml
> diff --git a/gdb-xml/loongarch-lasx.xml b/gdbstub/gdb-xml/loongarch-lasx.=
xml
> similarity index 100%
> rename from gdb-xml/loongarch-lasx.xml
> rename to gdbstub/gdb-xml/loongarch-lasx.xml
> diff --git a/gdb-xml/loongarch-lsx.xml b/gdbstub/gdb-xml/loongarch-lsx.xm=
l
> similarity index 100%
> rename from gdb-xml/loongarch-lsx.xml
> rename to gdbstub/gdb-xml/loongarch-lsx.xml
> diff --git a/gdb-xml/m68k-core.xml b/gdbstub/gdb-xml/m68k-core.xml
> similarity index 100%
> rename from gdb-xml/m68k-core.xml
> rename to gdbstub/gdb-xml/m68k-core.xml
> diff --git a/gdb-xml/m68k-fp.xml b/gdbstub/gdb-xml/m68k-fp.xml
> similarity index 100%
> rename from gdb-xml/m68k-fp.xml
> rename to gdbstub/gdb-xml/m68k-fp.xml
> diff --git a/gdb-xml/microblaze-core.xml b/gdbstub/gdb-xml/microblaze-cor=
e.xml
> similarity index 100%
> rename from gdb-xml/microblaze-core.xml
> rename to gdbstub/gdb-xml/microblaze-core.xml
> diff --git a/gdb-xml/microblaze-stack-protect.xml b/gdbstub/gdb-xml/micro=
blaze-stack-protect.xml
> similarity index 100%
> rename from gdb-xml/microblaze-stack-protect.xml
> rename to gdbstub/gdb-xml/microblaze-stack-protect.xml
> diff --git a/gdb-xml/or1k-core.xml b/gdbstub/gdb-xml/or1k-core.xml
> similarity index 100%
> rename from gdb-xml/or1k-core.xml
> rename to gdbstub/gdb-xml/or1k-core.xml
> diff --git a/gdb-xml/power-altivec.xml b/gdbstub/gdb-xml/power-altivec.xm=
l
> similarity index 100%
> rename from gdb-xml/power-altivec.xml
> rename to gdbstub/gdb-xml/power-altivec.xml
> diff --git a/gdb-xml/power-core.xml b/gdbstub/gdb-xml/power-core.xml
> similarity index 100%
> rename from gdb-xml/power-core.xml
> rename to gdbstub/gdb-xml/power-core.xml
> diff --git a/gdb-xml/power-fpu.xml b/gdbstub/gdb-xml/power-fpu.xml
> similarity index 100%
> rename from gdb-xml/power-fpu.xml
> rename to gdbstub/gdb-xml/power-fpu.xml
> diff --git a/gdb-xml/power-spe.xml b/gdbstub/gdb-xml/power-spe.xml
> similarity index 100%
> rename from gdb-xml/power-spe.xml
> rename to gdbstub/gdb-xml/power-spe.xml
> diff --git a/gdb-xml/power-vsx.xml b/gdbstub/gdb-xml/power-vsx.xml
> similarity index 100%
> rename from gdb-xml/power-vsx.xml
> rename to gdbstub/gdb-xml/power-vsx.xml
> diff --git a/gdb-xml/power64-core.xml b/gdbstub/gdb-xml/power64-core.xml
> similarity index 100%
> rename from gdb-xml/power64-core.xml
> rename to gdbstub/gdb-xml/power64-core.xml
> diff --git a/gdb-xml/riscv-32bit-cpu.xml b/gdbstub/gdb-xml/riscv-32bit-cp=
u.xml
> similarity index 100%
> rename from gdb-xml/riscv-32bit-cpu.xml
> rename to gdbstub/gdb-xml/riscv-32bit-cpu.xml
> diff --git a/gdb-xml/riscv-32bit-fpu.xml b/gdbstub/gdb-xml/riscv-32bit-fp=
u.xml
> similarity index 100%
> rename from gdb-xml/riscv-32bit-fpu.xml
> rename to gdbstub/gdb-xml/riscv-32bit-fpu.xml
> diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdbstub/gdb-xml/riscv-32bi=
t-virtual.xml
> similarity index 100%
> rename from gdb-xml/riscv-32bit-virtual.xml
> rename to gdbstub/gdb-xml/riscv-32bit-virtual.xml
> diff --git a/gdb-xml/riscv-64bit-cpu.xml b/gdbstub/gdb-xml/riscv-64bit-cp=
u.xml
> similarity index 100%
> rename from gdb-xml/riscv-64bit-cpu.xml
> rename to gdbstub/gdb-xml/riscv-64bit-cpu.xml
> diff --git a/gdb-xml/riscv-64bit-fpu.xml b/gdbstub/gdb-xml/riscv-64bit-fp=
u.xml
> similarity index 100%
> rename from gdb-xml/riscv-64bit-fpu.xml
> rename to gdbstub/gdb-xml/riscv-64bit-fpu.xml
> diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdbstub/gdb-xml/riscv-64bi=
t-virtual.xml
> similarity index 100%
> rename from gdb-xml/riscv-64bit-virtual.xml
> rename to gdbstub/gdb-xml/riscv-64bit-virtual.xml
> diff --git a/gdb-xml/rx-core.xml b/gdbstub/gdb-xml/rx-core.xml
> similarity index 100%
> rename from gdb-xml/rx-core.xml
> rename to gdbstub/gdb-xml/rx-core.xml
> diff --git a/gdb-xml/s390-acr.xml b/gdbstub/gdb-xml/s390-acr.xml
> similarity index 100%
> rename from gdb-xml/s390-acr.xml
> rename to gdbstub/gdb-xml/s390-acr.xml
> diff --git a/gdb-xml/s390-cr.xml b/gdbstub/gdb-xml/s390-cr.xml
> similarity index 100%
> rename from gdb-xml/s390-cr.xml
> rename to gdbstub/gdb-xml/s390-cr.xml
> diff --git a/gdb-xml/s390-fpr.xml b/gdbstub/gdb-xml/s390-fpr.xml
> similarity index 100%
> rename from gdb-xml/s390-fpr.xml
> rename to gdbstub/gdb-xml/s390-fpr.xml
> diff --git a/gdb-xml/s390-gs.xml b/gdbstub/gdb-xml/s390-gs.xml
> similarity index 100%
> rename from gdb-xml/s390-gs.xml
> rename to gdbstub/gdb-xml/s390-gs.xml
> diff --git a/gdb-xml/s390-virt-kvm.xml b/gdbstub/gdb-xml/s390-virt-kvm.xm=
l
> similarity index 100%
> rename from gdb-xml/s390-virt-kvm.xml
> rename to gdbstub/gdb-xml/s390-virt-kvm.xml
> diff --git a/gdb-xml/s390-virt.xml b/gdbstub/gdb-xml/s390-virt.xml
> similarity index 100%
> rename from gdb-xml/s390-virt.xml
> rename to gdbstub/gdb-xml/s390-virt.xml
> diff --git a/gdb-xml/s390-vx.xml b/gdbstub/gdb-xml/s390-vx.xml
> similarity index 100%
> rename from gdb-xml/s390-vx.xml
> rename to gdbstub/gdb-xml/s390-vx.xml
> diff --git a/gdb-xml/s390x-core64.xml b/gdbstub/gdb-xml/s390x-core64.xml
> similarity index 100%
> rename from gdb-xml/s390x-core64.xml
> rename to gdbstub/gdb-xml/s390x-core64.xml
> diff --git a/gdb-xml/sparc32-cp0.xml b/gdbstub/gdb-xml/sparc32-cp0.xml
> similarity index 100%
> rename from gdb-xml/sparc32-cp0.xml
> rename to gdbstub/gdb-xml/sparc32-cp0.xml
> diff --git a/gdb-xml/sparc32-cpu.xml b/gdbstub/gdb-xml/sparc32-cpu.xml
> similarity index 100%
> rename from gdb-xml/sparc32-cpu.xml
> rename to gdbstub/gdb-xml/sparc32-cpu.xml
> diff --git a/gdb-xml/sparc32-fpu.xml b/gdbstub/gdb-xml/sparc32-fpu.xml
> similarity index 100%
> rename from gdb-xml/sparc32-fpu.xml
> rename to gdbstub/gdb-xml/sparc32-fpu.xml
> diff --git a/gdb-xml/sparc64-cp0.xml b/gdbstub/gdb-xml/sparc64-cp0.xml
> similarity index 100%
> rename from gdb-xml/sparc64-cp0.xml
> rename to gdbstub/gdb-xml/sparc64-cp0.xml
> diff --git a/gdb-xml/sparc64-cpu.xml b/gdbstub/gdb-xml/sparc64-cpu.xml
> similarity index 100%
> rename from gdb-xml/sparc64-cpu.xml
> rename to gdbstub/gdb-xml/sparc64-cpu.xml
> diff --git a/gdb-xml/sparc64-fpu.xml b/gdbstub/gdb-xml/sparc64-fpu.xml
> similarity index 100%
> rename from gdb-xml/sparc64-fpu.xml
> rename to gdbstub/gdb-xml/sparc64-fpu.xml
> --
> 2.52.0
>
>

