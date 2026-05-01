Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBD2CD13DE
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 04:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIf3Z-0005Ml-Hi; Fri, 01 May 2026 00:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIf1p-00057C-JH
 for qemu-devel@nongnu.org; Fri, 01 May 2026 00:00:39 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIeww-00049V-G0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:54:49 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ba699316b42so227646266b.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777607559; cv=none;
 d=google.com; s=arc-20240605;
 b=U0dYtq1ngoVXIenyASwnsa8Ql6enhz1uOXDkBIxeLoZLzpP9vhJCWbUrdKC1kuIRjH
 f2ZFugAzfLaXGQ0vWah++5bPqVcfBRTn7f5qsv32KELHbDnHwA9+omN0mJAQvSuXy5oG
 Wskc+5Uv+AkDqpJJDnAjPqfasaPToXbz/kbvfTb1IrJ65UsXa1zItjT1SpOapK3/ziGE
 MHAM6sawpQ9BIq7UMwRvhNmgrlCNwMfBt9Fu4MXW2sLXYE08jO10NHDDIzrY/RKjxfLC
 XrmTDTdS7NA12LXrQgoPIq83AxoS5fDtaZAUYFJpOvGfOOv+r4R6GNoDz7cp0tYbb2ri
 g7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Tz8WVKfuiuTslSn45JicJ1NnZQl7ojBmZKYPd8U3gPE=;
 fh=9ZBm7Jeorp9wSVPYF5AiPBCRDB4kcVwmpribd+uGcX8=;
 b=M9d2mkQNBscUWUHqsmFzAOrayM7eDwbJ6vLo68vH8CQbgfAVnIBGpwuj3d0RXbMbBS
 TGPzmsnFewWU6oScP7zTXvZiB7IoGE4GFY6jaNTYpoSYKtesTGzcYLDhWC2Bpqo5iEt7
 fc9cD5R3zqjkT+0JGQ7NCXOJRhphVC7f/D4fhYv+DEO0Zloaw9oGeM8uNm7pUBwj+ZXg
 rzMPluhwotiOeO8tfgNanlYXHyIgLSts69rSMJTE8yLZhc5YjhAIffpWYWVoE6xPbep+
 aIXagTwXI2U+NBUoJdn0yKZHKBxp6qxYI0/neP5M39RveppHGbb2EMIIxi2mzgym/a+6
 s29Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777607559; x=1778212359; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tz8WVKfuiuTslSn45JicJ1NnZQl7ojBmZKYPd8U3gPE=;
 b=qcgVuGJ3oLlOepytFJTx+xq0MBa3AZwEMLuhLjzyO7HDHMrdvn7rY3LYOYZrLRXoS0
 nQgEJ8wVT4JzJkc9U4XEYYW89uEO0wgjqcNd6iBkdpYyQJkRE+FsmWMqh3xm3uDl0VoV
 iQoJyEDXw/sLM/mubC6eODP8O5LY26ncKrCN2xAdgymJYKS6StwNvWESMqA0AJxvWW9l
 9S84w9xdCIpfuGYGwdWldOmiDvTrD1Xyctj/UHxVWAbwoAzZAsdLxKplBZFw73sok0Wl
 OqTigBjUe7ToyUZuaKKsi0p1TFjOogYixzZmjzwru4STzr/Oo9Us1G+icH2S8Um54S3M
 3W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777607559; x=1778212359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tz8WVKfuiuTslSn45JicJ1NnZQl7ojBmZKYPd8U3gPE=;
 b=cYzlFgKVUrqMaciutfKaOpREtUn6b2PWPHWjK7INZmyzXeYYePfTBNU982tPUzcdAG
 G06zTu/mFFFQoZOX+WNMKsvh1MDjKnfGtYcNf4Lv099LtiQzhicsju8AGOfOv6/HSPFi
 HGzQtxchXshYnY5IgLPPMFfJ5ALw5zBrbShiGnkIr2WD/joVOQtysYMTtiO+bJJqjiNf
 XjH+Dyiow17givCHst+BB9r7ZL+q6Hc8YDkfP2ZtbkptxXhNS9KgajAjwvya2D4+57Gz
 rzhhZF5ss0mvJNJ4jFmQpodLIhQ/vu9y91Gou0iupqIBlkpr2p/EoyyeQRNWC2xbUcoB
 iIBQ==
X-Gm-Message-State: AOJu0YyF3chhsnqwf4w0OkpZs8K5o4fLwnFJb0446qhgD/Jga61QxVlr
 Gg/FWP2EdLmnKM8oTGWZo0YxcOgrPpJLzISgdwZMSUGfaNFkOzglS8HbbRoWhHMy5S/n23hT3S0
 lDFVEXV9ixnvmdA1kUcnG2D0Z3E8Chx0=
X-Gm-Gg: AeBDiev8EdXMlSJWaZMYHmgpMbECD4rXY/nK/H4DsQpqPUomWvd30Pf8NO9HnlxngCG
 zloHUxtWFJqfDCkMdPq8Bvdgg0UA5wI1Zh1LfsG8afllthsRbWl1uXbACEh/HeVY32WzN+l4jgH
 hOPoh6KEnaSeMJB5RH2AbhwwHg3t+mt+VrIxieU5c2H2N6RFYwwcrEoqZi3TMar4pVR4wR1Ik7o
 y2m8zVE/cINcWIkyaP9OBD9/Znduti5lmVOLzlF408riV9hUnfwGsnHgJ/Tieuy8+Rc3lDF87kf
 YYlx+V6dMfafdcso0bmB5gnbN6BsdE/d1sJ+hac9JThE4EKL
X-Received: by 2002:a17:907:3e27:b0:bae:70db:91f5 with SMTP id
 a640c23a62f3a-bbad546d837mr367390066b.35.1777607559297; Thu, 30 Apr 2026
 20:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260424102800.24022-1-frank.chang@sifive.com>
 <20260424102800.24022-5-frank.chang@sifive.com>
In-Reply-To: <20260424102800.24022-5-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 13:52:13 +1000
X-Gm-Features: AVHnY4Jz6cGeLNnm0xFEpNvyBNumuWeOtCy0oHC1KYV_g27ECgFC06g9G4Nxe74
Message-ID: <CAKmqyKM-4+9ZWnKbVmuYYPj-juFFHu7NCSU+awFt1U-3Awb6vQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] target/riscv: Expose Zicclsm extension as a CPU
 property
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Apr 24, 2026 at 8:29=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Expose Zicclsm extension as a CPU property to allow user to turn on/off
> Zicclsm extension.
>
> Zicclsm is set to true by default to be backward compatible with the old
> RISC-V QEMU design.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index df56b64a736..7f5e06ef83d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1327,6 +1327,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zicbop", ext_zicbop, true),
>      MULTI_EXT_CFG_BOOL("zicboz", ext_zicboz, true),
>
> +    MULTI_EXT_CFG_BOOL("zicclsm", ext_zicclsm, true),
> +
>      MULTI_EXT_CFG_BOOL("zmmul", ext_zmmul, false),
>
>      MULTI_EXT_CFG_BOOL("zca", ext_zca, false),
> --
> 2.43.0
>
>

