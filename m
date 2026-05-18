Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A18FCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOlrn-0002X7-Af; Sun, 17 May 2026 20:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlrl-0002Ui-LX
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:29:53 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlrk-0002c9-77
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:29:53 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-678adefbd26so3374137a12.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779064191; cv=none;
 d=google.com; s=arc-20240605;
 b=N10n21XsaiWx0EqL6PT9i8ceXycngf2cOwY5FI9oHs34+aIYYjQDuDgej4WjIprHWa
 Sv+qYzxmChoT77/qHqXrfxUoRqC2ZWGX1kGqD4zWQ6mas1z67Kyf1Pg0ATFKHa9P9cou
 oc+w+5rTcZo4oV5QQCNjCamkCwn8JKNTIcER8uqAK4ZdTI6iaO8zu8R3Eejra/uGo3ri
 q60R+gmqm2UkSdGpITfh2q7qb0LKfzQ09KWggkdR56A87ihKNeULBz6HDO2sdOPDuWEy
 KzQxH04/huixPXyTQ1qTL5T6MrN6/jWTfr6RdykvnIwWhGLGw11Qxw//qbD8oOeaWHMy
 3Kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3NFvGlc9JL1cvXdqUUF1+rJo6bAzt4s/QCYZ5ZTD5pg=;
 fh=A83smZfl0aCJbt0aSN8uyH4Eb0MKJr+HQbscuSe7+j8=;
 b=T8bm03H6Y2AzH1buC0Sm67zyW6cQrwIonzvno/3hDfO//OvcysSH3jnQWpVQ5IdJuj
 EpX55ZPD7czJWkhW5lPC4dbVoH2OYy8TQgTPiSlOtxs5n/Jtc+BzDmB0J5qABDFPnCGf
 aCxzzcdFspaxDab5dDvx24JPCX7hbHnURHtlu7jrqxAGuqbJlKo1HB6Mk8hdlkSqf4/c
 TWbKAKGl85WfY4bGcmk02SDW0zDagnx9LDXAeIWFhtq9DVZ8APCzwicPX5towkckh3eS
 8rvTgCS6zPPAk+BSo0HZBnlSDhZnbz7K6lLH9KVA2SrInK+t33EoN0ASSiGGZ87eRJru
 Jeew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779064191; x=1779668991; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NFvGlc9JL1cvXdqUUF1+rJo6bAzt4s/QCYZ5ZTD5pg=;
 b=DoQ2kTYT5+iiNHxCpnr80dbLsju5ZbObwFhV3RtHTuBvqXG42XxXY8w2UbU+1psc6t
 hmxgRqVnPcHilpVi2t8uFIJceHbzi7V8iivGM2ixe2b25qZDFjsXVaukLlh5gN9AOIR0
 963DsNGBrzVWNzl/a8hcxnvEykJXu5rBGzUwudTZcjUITGz91XBEbP1UOMAZiNMdTGTr
 nuaAmlZIE5UNXofKwf5wejLFX0FfPhpeQjj4KPUttS3D+Lv6sJZL9QKbPAcLQiHyLy+q
 DSdzX9cj/ufyt9m9y9zvjIULRnrWMTWsQ1PitGPjbM654eHGWIQVoTaZI6nQWC4EF0kn
 q9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779064191; x=1779668991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3NFvGlc9JL1cvXdqUUF1+rJo6bAzt4s/QCYZ5ZTD5pg=;
 b=MEH1wb0Ag0A42KnK9qqWJes0+jDHUoPKdGICB+24GuPNOlO2IXH3AxeWANGuUA3zEb
 P9GRxgRQTKgm15DBIKnDSvyvH//fsFYWjnEqdK88VafqVrGa79oeTPSSKktwHlPKbiuF
 zvfPRnvp89PiQkPQIB36J+aGc7bgKu7utTIFuFPKbHWc6+hj12u7Lv2tPsghqTV2sBbW
 zo0DhBLBcp5IqS2KKTp8PdM8zHE5nw6EF3URew2XJ92Gdi8l2xWgkJeqVBeLF8z87wLo
 /8Jeg8BAfq4MZg2bqSpmEYP5jp+YCc0tFSX1ER95fQn/vo3eRemqrMg+rQ5uX6GFuYP4
 A6ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HvpaQTzHvV+L/cWS6pjLv6rD84DWlf7HgG1zw37lbpemHvpSHbe7JIstmtLPIM9jire7X7OCnvCNp@nongnu.org
X-Gm-Message-State: AOJu0Yxx7vZaPtGWs2v3LI44Ymc7aVEpPn3JifmojaXQsO/rrim9bqjr
 WGS7RVClbqnhGWCLVEDaSHOh21JUhdm6PzcH2mBLctUmMngsl7pA1UDP0t+iA1+Mq8TidSY/xfp
 xr3E0mNiDyWGEL8PXxvkunZcWdioP3Fic7eoy
X-Gm-Gg: Acq92OH0UR72dd9hp0LKNCE9EXH9Ia/C3hyn1rUBD6epOnEhqBBTpe1m1Hi+IbsDylr
 SwB5jzttaYUIiBV+dPKO/qTEV+RL6rQJz1kxaTRvK9Dmg7PkDck2K7b7+IAdNuisGzZ/pOq2FZo
 bi502LKYTrZ9N/PQc2aH5kYhve00qrHQZfSJNU5xwDh/xykRFvwBXD/uGLII1BnhnZXSOTVkkUP
 cUod6dT5dp3pcIh9N/+jkGZfY37+fBVxX9jPGDl8An3Rh7AAlj5YJnzuZLuP+7zStaunikEIm6O
 xhNAr/9EWqdR/vYqdhH3ySIrJz189HNwDrHnYDLUYdPb/h67
X-Received: by 2002:a17:907:a09:b0:bd7:bbae:1ff2 with SMTP id
 a640c23a62f3a-bd7bbae4519mr93282666b.21.1779064190670; Sun, 17 May 2026
 17:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260511072126.3009004-1-vulab@iscas.ac.cn>
In-Reply-To: <20260511072126.3009004-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:29:23 +1000
X-Gm-Features: AVHnY4LimANkw7C8vOGUCAUq6soWOrX2WkVs5HdeT_onKFuTitH3xIAH9dggLAs
Message-ID: <CAKmqyKN-5Hwj0AcutXB6P7P5eBukt6j7x5kFV=1k1rCM1uqq2Q@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/pmp: Fix integer overflow in TOR and NA4
 address computation
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Mon, May 11, 2026 at 7:53=E2=80=AFPM Zishun Yi <vulab@iscas.ac.cn> wrote=
:
>
> According to the RISC-V Privileged Manual: "The Sv32 page-based
> virtual-memory scheme described in sv32 supports 34-bit physical
> addresses for RV32, so the PMP scheme must support addresses wider than
> XLEN for RV32."
>
> However, the current QEMU implementation uses `target_ulong` (which
> resolves to `uint32_t` on RV32) for PMP address variables.  When
> shifting these addresses left (e.g., `this_addr << 2`), an integer
> overflow occurs, truncating the high bits of the 34-bit physical
> address.
>
> Fix this issue by casting the `target_ulong` variables to `hwaddr`
> before performing the left shift operation.

It's probably a better idea to just use `hwaddr` for `this_addr` and
`prev_addr` instead

Alistair

