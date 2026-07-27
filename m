Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C38C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 04:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woDDW-00067S-ND; Mon, 27 Jul 2026 00:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1woDDV-000657-OT
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 00:45:29 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1woDDU-0006Jo-Al
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 00:45:29 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-81ed2a00f12so26373407b3.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 21:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785127527; cv=none;
 d=google.com; s=arc-20260327;
 b=agIoEDIiCg2IWPEDX5edVXx2UMSVjOU1SBGU701dtToP/fKnBBetI1FBuiIJ7xnCm0
 zzIPyNCA4hBmge/tqU9GV5zP23ksiOq/OaTbd/zRIImh6m8Wd+xeraD4samv6RAdKRdi
 ZA2JVpQ+A7gE6MkEYY0un8/m7RSZNn+t/C6+7dNK6XPTkcn3fz/TtHgehi6w2Pe3OfY5
 rIn/dD2TJwusj44ymcy4pkJoBCpETDwhmDIa9deUr8oiwDMOrKbl8Bc3577IqSx1YquD
 U0gzEocKC4UGztxbj7Qv1ZDA2IdzSi5AOmTCh/62SNVKtwUBbBP78a83FGHLS8zGD6N6
 Ixxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0OUhsbKQ0/u8SCUlAqfilJ4I7sL1QRkwHHunxt6ShDM=;
 fh=c1T1+m8G2EyFNqUHo256tHQQkB3bftmoJ0qWpaHaX+4=;
 b=pHdJXGl9noVeAiTEDw2nTJCQSKu34XafQSiNSdIHBgPsjreJv9fiRzosS+Jr591DVQ
 mgWc2HXjl9BfVW+y2CmMJGeWwkiMG2i5Z449XLIfIjpF3mha15jUo2ioUZ7h3zmbmQun
 mX3fhCmH4cwNmWmOZF4G/5ZBg+Ea8pU1StaTQov6coNW3zOUFura5HK84cMmJjJc8SCB
 9MUD61QCVqH+Kz6kUKFHpW55dFwx95gIf5NxEHRPTLppfArN1wnZHFPvq6oQ40p/j1+8
 oEKR+q5p6M6IF+dzwT7TDEnc2jwob4SUBlWcGL0pPHJVF4f6bSY16hoYLPYUWBTKhfpf
 5BPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785127527; x=1785732327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0OUhsbKQ0/u8SCUlAqfilJ4I7sL1QRkwHHunxt6ShDM=;
 b=R+Slgg3cA4pALMIf+z7gHzI0baGe9W7pqRAFeyQp3GAUtfzMKmDug3b8vlkFShrhwo
 Zh52F+lTEI4PRyggXcg2TK85k2/q2qXmWcejxN4B0Wop6332NYJwuntZaZkM6ryooCfd
 I3BkNu1ZMC1sH0qjgYFUI9MU7fGB2idaI8wXDoYaMbZJ4JTZDCbvIhKzWN4yEzNtfk+r
 ZJvz3uqfrKevlBuT5VtIjozbP5tN1pVsiniJtMaIVuBmP/ja3bq4MPxb5ZQV8HGIMGuK
 jP4V+2g+eEaVhNlLYiVW+ikQesP2M73BPfFVR1fjH2342pVnvJcx9nsitCj09DbS2Vh8
 PaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785127527; x=1785732327;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0OUhsbKQ0/u8SCUlAqfilJ4I7sL1QRkwHHunxt6ShDM=;
 b=s6mGe2zLgJLvFEOj5LGIxbf6uIAc6Ugb+1gENsjReFH3mBhb9eEezjrYI5DR8CAHF6
 kR3+TwXSocSxvWBPiXezwIgNvxwist+4QGaQFH+TToTNLFYlxNMxFj8Tji5wQZQQm4BT
 9XDRJxomXRnVVfw5OZJxgu59TX39XmWYhPN2eaXlyvdH8ZqYmtR/6skyFGY/2bzQ/iNW
 R35rG1l+g06Z7nq/xWMRzsPLj6VFo9t+1LaZECVx6rL/VQRk5sRLLAI3CWH5n9F4FKUN
 zs/qMWsacwT6pF6PZ717e6g+AAGA97UpBLIVDLGWZ12T+0816aLTSm9GdECj9fYF5e9s
 INcA==
X-Gm-Message-State: AOJu0YxYIiOwafkgVXJmJfgAPa11PI4rT3Z/OUvkrro36Rc+3lxG8wV/
 TlhfwrcAnf6/S+bqbCaJ8c95rIKus1Gs7n++qJ9xsECGmkUK4WwraUevSdPNQjhlRsympuoXE/t
 SLyuB0o+kXEVXDS2aSwpPStzEpcM9D3k=
X-Gm-Gg: AR+sD10MLXU4SJYf9qtvboXAtJEmt1Ycr9dUPomZyAtBJi1cRI0kh1eh6q65RoeSUPR
 lx8ou++8XaikJrmJ4RKUnvm50pCU+wm8+VvVpu5qBVYOiuWKYfWnAVVLyL2vPtm+uaSeCEDRsrd
 SCQE30JepUNGIq7bH9HZ/TX8P5A9kuRg/La1+MqwOb8QXFTlRlL1/PMOquLz25YV1AYS+U7w5Zh
 fsnUmOQrMNrNskjauux/0+3D0HOesLDVnJugYjs75vpTZCpmJoKCYxj5ybAKA==
X-Received: by 2002:a05:690c:64c2:b0:81e:9ba9:d36b with SMTP id
 00721157ae682-81f69e9bd7amr23128037b3.63.1785127526839; Sun, 26 Jul 2026
 21:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785064312.git.flamboyant.h.01@gmail.com>
 <12e325190a15045cff5c429b154217814cd9e618.1785064313.git.flamboyant.h.01@gmail.com>
In-Reply-To: <12e325190a15045cff5c429b154217814cd9e618.1785064313.git.flamboyant.h.01@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 27 Jul 2026 12:45:12 +0800
X-Gm-Features: AUfX_mwYfOo15Iqvx9k9PAcrHvDVRAGZQUpU5j2HVZnvG7olLePuuxVNmCIwcPo
Message-ID: <CAEUhbmUEF7fLEP9+HbE6mKE5OKsVm0rds+1S==BtRLArLZMbxA@mail.gmail.com>
Subject: Re: [PATCH 01/11] hw/ssi: Add K230 DesignWare SSI register model
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Kangjie,

On Sun, Jul 26, 2026 at 8:30=E2=80=AFPM Kangjie Huang <flamboyant.h.01@gmai=
l.com> wrote:
>
> Add a SysBus model for the K230 DesignWare SSI controllers.
>
> Implement the register layout, reset values, writable masks, FIFO state,
> chip-select GPIOs, and the MMIO regions needed by the K230 machine,
> based on the K230 Technical Reference Manual. The controller is not
> instantiated by this patch.

Please split the model into 2 models:

- One generic model for Synopsys DesignWare SSI controller
- One K230 specific wrapper model on top of the Synopsys DesignWare
SSI controller [optional, if the generic model is enough to make the
k230 software happy]

This way we can reuse the Synopsys DesignWare SSI controller model by
other machines in the future.

>
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
> ---
>  hw/ssi/Kconfig               |   4 +
>  hw/ssi/k230_dw_ssi.c         | 795 +++++++++++++++++++++++++++++++++++
>  hw/ssi/meson.build           |   1 +
>  include/hw/ssi/k230_dw_ssi.h |  50 +++
>  4 files changed, 850 insertions(+)
>  create mode 100644 hw/ssi/k230_dw_ssi.c
>  create mode 100644 include/hw/ssi/k230_dw_ssi.h
>

Regards,
Bin

