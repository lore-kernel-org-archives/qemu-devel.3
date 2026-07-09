Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E8FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 03:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whfil-0003NM-D2; Wed, 08 Jul 2026 23:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whfid-0003Mq-RB
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:46:37 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whfia-0001sk-VX
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 23:46:34 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so1144787a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 20:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783568791; cv=none;
 d=google.com; s=arc-20260327;
 b=k+yyRpx0v4NLApqfltsmNlcttDMzWEp4wHRpgM74McyI3hpeEodadjXu1MgFaJrMsr
 unIJ/b0U9FIsAAG8t87fcvmM0PE8WRuMmPSvApzTDWjKskG0GaBkY95bg49UYDgfQFgW
 WCK2axvNuJE0OE0aarsrbPUjDWd3nFaRrJGRWHNxPcMH9hXWJY6AbvVMAosY57V3U9pw
 3FT/ATFlCtD55sr9dQ5SJjGPmc36e9JhzNBcvpqbnjLeGoH+ZSPYnkCZd52oS1V+e1Zw
 OWttwselk3jwVAHAiDBDYp2phDBLKOA7jJKGvzSK727lxMwhwTpCYnetWxdIWGm1mgAt
 +Zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ne2/mz2SuacesM7JLhFyoE8tE4KJepIJnu3z4Ej48Ro=;
 fh=PHwXGMW25elVn3xrrIpPy7PDF+PoumjLE0wDAAcFPOg=;
 b=CipEqmYL6w4YxgMzu5VLRBRDn0AQHPkZaGe8hiXWsvHVVPh8OGJ9POggatWEh6NSr9
 eI84y8oScNh186zxEg0FSKDrof0x7ZsPS/e6odph4IFrh9SGAblOeMnwwjm8yW9/krm9
 GtK6BT6EYEU21cK1xipUclqPmoW5yo12YgeI0JlriieMVZBPcviw/V++apOXC7PlkbmM
 JkO5EUbshKhHU0VftGzjx49H/gFXLkVV4IVBQCRLN5pfg06epyAbmMrB0VbYJntd4dgn
 EQ2gUxI2N3k4+PT/KyaB3ilkKMjsvhZnbMBJ5HIYkTV1i5QK17reu1DXEyg+p+ZQLcsC
 E2KQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783568791; x=1784173591; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ne2/mz2SuacesM7JLhFyoE8tE4KJepIJnu3z4Ej48Ro=;
 b=isUtZ+UvhgMgro3beuvx/M9fYAZR3/lZoBATKH2itME4FT5wLz6pkAAWgzzR3ly0jQ
 lacU0wCYOk+yXJa2Ml6z50lTkGTKS2Q7HzAo0xZEAoSNGmvOLv3MCAAotA3etewoPKi4
 snWwghiGHJlX6kxUjnNrWU4NU21m9UdDekGFS3k11CFJW3QyDUNmvS7pHL3KvhA9JnCp
 +g/ch6e+LMtbSuFh3ItSTOHRxusQX0Ardbv5eFC5vC0aCROPy3zNiVWRmFDZol37joYW
 +jQIrvMimRO4alVWkQ23M1GKgXVOnqvgUJqMVRNociITTnAPLlbf5wSMIcr6XAwHU1mm
 +2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783568791; x=1784173591;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ne2/mz2SuacesM7JLhFyoE8tE4KJepIJnu3z4Ej48Ro=;
 b=OBOA7tBqm5O28e4pj8E0TEPHiXL/8a1Wx76mA6VjdcPzmddhDQx4msqPmXXwrRd9lj
 Sy6maE5b3Hc64x5K/dRa5qlL5f6Fsg5IIsTj6AjkrObQ7PeANqg9QUBPJhD81GSMKB9c
 mGyCr0lXJEGI7d8T+5h47li2EZc2Z1MS3HTzlCI2Nsos3VTBeDpSatmmDapGpA3iSZ8S
 BWajOAeSW2U+xeGOpRRQTiGGc2tFRKeyL8s2f/3jBcVnFmIujhBnvNChqe4jI62q6ygm
 /m1khGuML3NiWwliOXxtmbdS67SMMQKIxi9pB6LgsSWELQcesSyJOo8CYOPolXbWxGeu
 KfPg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOh52kAQpu/HO4jdYImXwsKyygBPqSGlMY8ALK0fu87SE6ThbEsm1u5a42hKZqSIw+8gZ7bMguyGIa@nongnu.org
X-Gm-Message-State: AOJu0YxH2tra7f58lVrjKcDtRt5M7kCz1tsKsCIlpY0IEzIYJizPLCtA
 UUfH9qYttKkRqt5r/wI+loyfV0jSGLzCyseUi/ACoJFoXA0JtfzgcHnxu796zjrTolwuhh3Sm5W
 DfZP7bc76RXylVSnkCacLBa3Me031Ooj99Q==
X-Gm-Gg: AfdE7cm118pA8GfGggUZ4HZ1na8KfA1QWe5ClaStz3Q2Rs/dlxSYKT4TAoOSssfPKpR
 kyCPrLpb+Y7Kn0LYnhIsj7JdiUvxk0njJ9DMDh6d8ITk3UP9MCUtcif8Uli0MAelCN+6639HvPQ
 +I/2jmQvR4A/ZxcrktjHik7FCI9x+Jy/p7zxoJB6VPTVAeBTPUcqNJ9XBuxhej1gU8RLznYW8xE
 55FO+GJjR+N7O3w3HaBZz8qgCGtly/1N39ZuB1gnmtVymq/LCtH4gsgTMFEvK9syI7doxfJh6y8
 OjPeGfyxZMDmtjfj4u7U/nyB3cM=
X-Received: by 2002:a05:6402:4306:b0:697:eb97:a4ed with SMTP id
 4fb4d7f45d1cf-69c01b81c71mr397306a12.7.1783568790959; Wed, 08 Jul 2026
 20:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260707020750.788960-1-alistair.francis@wdc.com>
In-Reply-To: <20260707020750.788960-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2026 13:46:04 +1000
X-Gm-Features: AUfX_my6TJN4Cy3FvrNQero6iaIDYDocUOfQwKFeoHrH1Xw44qmEGRn4uWgInvY
Message-ID: <CAKmqyKOcW+0OJoTdROUjjnw43yrXUP3YPzuZUU9snjy_SDyZXg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/pci/pcie_doe: Check mailbox length for overflows
To: alistair.francis@wdc.com, tangtao1634@phytium.com.cn, mst@redhat.com, 
 qemu-devel@nongnu.org, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Tue, Jul 7, 2026 at 12:08=E2=80=AFPM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> It was possible that a guest could overflow the `doe_cap->write_mbox`
> buffer by writing more then PCI_DOE_DW_SIZE_MAX dwords.
> `doe_cap->write_mbox_len` would continue to increment and there were no
> bounds checks on the length when offsetting into doe_cap->write_mbox.
>
> This patch adds a check and reports a guest error if we would overflow.
>
> On an overflow we also silenty discard the entire object as instructed
> to do in the PCIe spec when the length specified in the header
> (up to PCI_DOE_DW_SIZE_MAX dwords) doesn't match the length of the
> object.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3679
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/pci/pcie_doe.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
> index 2210f86968..1bc2b45781 100644
> --- a/hw/pci/pcie_doe.c
> +++ b/hw/pci/pcie_doe.c
> @@ -78,14 +78,21 @@ static bool pcie_doe_discovery(DOECap *doe_cap)
>      return true;
>  }
>
> +static void pcie_doe_reset_write_mbox(DOECap *st)
> +{
> +    st->write_mbox_len =3D 0;
> +
> +    memset(st->write_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
> +}
> +
>  static void pcie_doe_reset_mbox(DOECap *st)
>  {
>      st->read_mbox_idx =3D 0;
>      st->read_mbox_len =3D 0;
> -    st->write_mbox_len =3D 0;
>
>      memset(st->read_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
> -    memset(st->write_mbox, 0, PCI_DOE_DW_SIZE_MAX * DWORD_BYTE);
> +
> +    pcie_doe_reset_write_mbox(st);
>  }
>
>  void pcie_doe_init(PCIDevice *dev, DOECap *doe_cap, uint16_t offset,
> @@ -356,8 +363,20 @@ void pcie_doe_write_config(DOECap *doe_cap,
>          if (size !=3D DWORD_BYTE) {
>              return;
>          }
> -        doe_cap->write_mbox[doe_cap->write_mbox_len] =3D val;
> -        doe_cap->write_mbox_len++;
> +        if (doe_cap->write_mbox_len < PCI_DOE_DW_SIZE_MAX) {
> +            doe_cap->write_mbox[doe_cap->write_mbox_len] =3D val;
> +            doe_cap->write_mbox_len++;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Mailbox write length (%d) overflow\n",
> +                          doe_cap->write_mbox_len);
> +            /*
> +             * Too much data has been written, it can't
> +             * "match the Length indicated in DOE Data Object Header 2"
> +             * so we drop the entire object.
> +             */
> +            pcie_doe_reset_write_mbox(doe_cap);
> +        }
>          break;
>      case PCI_EXP_DOE_CAP:
>          /* fallthrough */
> --
> 2.54.0
>

