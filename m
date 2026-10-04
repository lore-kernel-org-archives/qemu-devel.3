Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E7ECA5FE4
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 01:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDBEK-0006fN-Rh; Sat, 03 Oct 2026 21:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDBEI-0006eU-Mo
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 21:41:30 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDBEH-0005FP-8U
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 21:41:30 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e50968489so446458d50.0
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 18:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791078088; cv=none;
 d=google.com; s=arc-20260327;
 b=mW5z/tvE9iwQLXyhFi7BHyYfiu8pV5Wl6S7T7jdPFjKEhAcNqoW0fCvsBHtPwLNDk7
 noST2gsG5dxMHupVy8bm1unwRtPpYl8z2xdxlKJ+awv/TtLtRM/3hDDPprrxulMffHZU
 l9zXHks2pS2Xojc7Xo9svLc7x97uCzKpMaLE9oyRIdHZA/ZyUkPByaTnjT+8u/FWiC1r
 H8o2KXjOzg6ZX7YhjosQzIfxiobpEJUeupysJ1qII2n8Rm4cCjlv9VhO7RbOAf0gcYh4
 Zdilh5VjIxeSgFYbA4IpKW9kXa5qGZU3uTt4pvN32EW6huspabzO1A+emg8Lm3n1NH1x
 82ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vMoVDe3OUzRN/OxefeqtSS0DcK7Rdn5mEh9jPcLOup4=;
 fh=2kucRcGcphjY4R0+/yXJAPccNI1QO9YS1TbxFqsM6rs=;
 b=l9XTSI3ERmE4rFq5ox9Pqm+S0yUrdg5cB08sV2D8RKpyh8x2g+U5LfRQzGtzuzMguy
 44+GFpdG92dEg9PzU5Llr5Qbk4RbSGtS4X6y3Z0oIqT1z1+yC0lAykcE/i11XOj6p3EU
 E6e8z7d9lAwmCYsHya0k8FAMkxN7Pk+NA8ZGe7boVUIm4LyRosea5FZfh/eZAt5z1UUx
 Nn5GSn0TJvf5SUzcaNNHBRUK6TP2ywby7Aj4D9FzJQculV9KZ82xC0yzoSgPcatoSgE/
 yiUp+/DX+p+XgavWfUchojFy4FtM/h1SFas5sre/acxPMbkdm1FAJnVgQxea7XeQ+I8c
 6QKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791078088; x=1791682888; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vMoVDe3OUzRN/OxefeqtSS0DcK7Rdn5mEh9jPcLOup4=;
 b=N8bwZ8YQfGTUOg1vzKLd132+B38B8+2hal9NP3tvjxuxkFzxss2Eajd82OQGph8KfK
 9+XDHgGHQk1pq90welJYpenQ3mATSK7BsnN2hJOC8rRBDqqIuQGEjj4MVppYCBszFPJ5
 tgckTC9XvkZSigtb0onZZr/dqaT9J9nD9T04sa9vP8Pm6LrREzKwdDQ5Uj1DVKeIK+YJ
 Mb/f3Ghqz+KnEzGt1Dvu0pGUlHeHv2fJpBEeY2IWl+qXD4Ou9mzyQAVODpboAUhOBmRP
 H7Rt9Ury1VFU0gfDSW6wRmlFgwbNAgHhw3k/OL3Qe7p8frmugAxL5YsU3bcZhZ+/PYb8
 914Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791078088; x=1791682888;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vMoVDe3OUzRN/OxefeqtSS0DcK7Rdn5mEh9jPcLOup4=;
 b=gOBO/o6+2omQfghqc8TK5d0szsZ3hriwAibTF8kINtdOiqOedbyTOq61UcXFqqPccb
 M47sQaF4HpSiBKHXrQeTNEEZPxtCh77+xxLq1i04MUmyC5g+9cCUjRL8hk077GD+9xlb
 6vi1YJ1cXEaGqG8WM6wClyx89hZrEbF1M6QFudzPpB3mpmA7BZ3dwuPwfSKVKMk1mbfi
 SZgscF6P4VDwIZ776gxe32hbhgtOqxjtpShpkTml2+sqiGgQTBEyf2togvejLhOLCZ2k
 /+WWdL6QgsecFMXB+jOtiCvFeFE2DkWUoM84mgNkvnpj8zrXzzFux+oHb4To00Mk7GOs
 Xi2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBygjUf63NJVfbjTn+oULYnr1bF3BdkxXvezQQywiI3RCbzzO/h3+wbjoZSGlM482M+3hZMUr1C7axWe@nongnu.org
X-Gm-Message-State: AFq9FYJSt9VbmoBi/Z3/LvsxaQxBzr3jLH93iAwv0GpNg9zP7zUbWQz4
 xSZS9X/j44Ke9nikemWQTzDd4IHTIFJbBbBhYPPzJpNPZUuW67cmtz0YlpAKZBVdgDdUT9hH7ga
 DsXXqJlLaaTX3eltx0/DyTpa+Uvqx47A=
X-Gm-Gg: AYBFou2pFPLIpBMi4s/oDW4qw2mEf+hsYB6iiToeTKVqGugGBLxP090eVRRiJsn/iJe
 Vd0PbTPZ5yIgfDP7NzhxxCIV4l3fK4kij1q1m4BA3yZ87qBiG5J4IRGpwpu+jhanfdS8V4jOymU
 jzyKDPAqU3KTWM3DPFYgpcdi5IOv/RGb/w5w3nCTh3ypAw8wTzk9lIQuTK2EaJQ44Lj6ip0dp/r
 9e1B/X0g0M+dadjhXVwZvKg2a6WYxEdOsLJwi5rE39g7t8EQfOmtbqBPNLPJZb9yV5ezT5CLHlq
 qo6jx4TED5DjKVI2vXhMBb+SycgUD0JXNJeyLcuJ+dGmx3HamrQR6Oxv7Jkd1r00kJlgYAS2fDb
 sR210/hXl/QAjpSov
X-Received: by 2002:a05:690e:4089:b0:677:d3d8:990 with SMTP id
 956f58d0204a3-677d3d80bc5mr32942d50.6.1791078087838; Sat, 03 Oct 2026
 18:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260812013619.2134092-1-bin.meng@processmission.com>
 <20260812013619.2134092-4-bin.meng@processmission.com>
 <768450BF-240E-4E73-99FF-E234915C066A@gmail.com>
In-Reply-To: <768450BF-240E-4E73-99FF-E234915C066A@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 09:41:15 +0800
X-Gm-Features: AclHuK-V73b0EH9hNCLlUQnpHETqtuHYj9VD6MAz-2xa5c3e3ZY1rn-p3iwVa8E
Message-ID: <CAEUhbmVFR1OR6Zmt5YQ9T5GBTvdBszNxP0=w+M7aehWkUUuFEg@mail.gmail.com>
Subject: Re: [PATCH 03/10] hw/arm: fsl-imx6ul: Map early firmware register
 placeholders
To: Bernhard Beschow <shentey@gmail.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x11.google.com
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

Hi Bernhard,

On Wed, Sep 9, 2026 at 6:28=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
>
>
> Am 12. August 2026 01:36:06 UTC schrieb Bin Meng <bin.meng@processmission=
.com>:
> >U-Boot configures the AIPS bus access controls and the i.MX6UL SNVS
> >low-power registers before its console is available. Its timer setup
> >also enables the system counter through the control window on AIPS2.
> >
> >These blocks are not modeled yet. Map unimplemented regions at their
> >documented addresses so early firmware accesses complete without
> >falling through to unmapped memory.
>
> Hi Bin,
>
> You could try setting
>
>    mc->ignore_memory_transaction_failures =3D true;
>
> in mcimx6ul_evk_machine_init() instead and check if that prevents these (=
and any future such) failures.

I think that flag is way too wide to ignore lots of failures, not only
unmapped areas.

From include/hw/core/board.h comments, it says new board models should
not use this flag to enable access to unimplemented devices.

 * @ignore_memory_transaction_failures:
 *    If this is flag is true then the CPU will ignore memory transaction
 *    failures which should cause the CPU to take an exception due to an
 *    access to an unassigned physical address; the transaction will instea=
d
 *    return zero (for a read) or be ignored (for a write). This should be
 *    set only by legacy board models which rely on the old RAZ/WI behaviou=
r
 *    for handling devices that QEMU does not yet model. New board models
 *    should instead use "unimplemented-device" for all memory ranges where
 *    the guest will attempt to probe for a device that QEMU doesn't
 *    implement and a stub device is required.

Regards,
Bin

