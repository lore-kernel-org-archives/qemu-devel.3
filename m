Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C517606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=WCMRmA07
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW3AZ-0007aA-E0; Tue, 24 Nov 2026 21:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW3AU-0007Ys-Bs
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:55:35 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xW3AS-0006Nj-H9
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:55:34 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67db8985419so6578919d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:55:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795575331; cv=none;
 d=google.com; s=arc-20260327;
 b=idBNwzVYKLOQagbGbUSbDROkCmzz40TRvEYA88cgVuUaSSqwREzzW4Gf7kFo6PcKe5
 q8MpGXVaDT05ghxpsLiJp3AqimcSucSBAI6Cq0HDBb9DegdXum/Qtnwz6CWODweajikk
 rpVlGLcWGTR9FJAIYop2WnYZ0kTUS/FaQSLEBWXHMDtPHHCqUIn18BhDWD38BfJto4XW
 qdRhefw3up9MdGnPCOB6BsqcnudUtdIDwGXEuWZ+uXetjD7yEkMeEKQLq72DeoVwAv3C
 5A/Rbogq69NUNX9kehbykXHbvvOhK/YfPsuhIFqWinr8QHB5WKmcPwdW+KylxBhUkGtW
 R3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EDkDoLY7enX9HQAphRJxJSyDbogIPhHutrgYfaQZ5PA=;
 fh=lzWCnX+ulv5uC5tJHqVa5ERUyqSTalmwKZTfbCCmcSI=;
 b=jTNQR2VE8cHk9HvumVxIhizL7Cid1mW5lRogRkGu5hwtGFDNCE+9vLtRxnEofuUk0X
 b+OlPKmg6gFCccYupqxsXp4wWzP7R70LxZ0w/GovIUsmBIpFMbdQhs7+VJLIkRovprwj
 kHun/uMOK8MB5QCLBIw6aNxycOaeai370y/f5O2QPCNVAry8WPV0jzRbfbW4EGy8Zeu4
 qfcDYKChIr7KaRF9fZz04d72uogswXZe1WY8Y0KFfPG5+j5r8QsKoE1XFXTxDQ4T1kQs
 uozHZyGxiOxpXGIhuhQCiDy8WKjGmPK45bdkVevQWbtbRbAUJgnSFAhzHgXBchZFnCyN
 BrFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795575331; x=1796180131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EDkDoLY7enX9HQAphRJxJSyDbogIPhHutrgYfaQZ5PA=;
 b=WCMRmA076lKuaWr7htH7ju+YZsv0A5SR/TOt013Hlxb9+yUAZNMPI92cIONEhC0anl
 rtME0ytD3yd+QVkcFmtyy31r8PZZg0ubZFyYDB052+jP/o7/e2DkUhnNJTiFABgCwwgY
 tRIoDG2EleaGMbvlql9kEUVrkSrMxNhbkA9TLtI0VMVzi4C7uFMr0iv9PqgGLheT5ynh
 y1a6XoKNUAHX0wayZdEPIxaWWXR0UUGuvYjfOmJ4U1nnJldoqRoQfouSQPJi08hKKfmU
 iuJ+U36xb9jJG5CG2PYYZHDC+0b0I7R48ylQis1//et9EFBn7yt108BEeJJHwY/pBMgw
 NAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795575331; x=1796180131;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EDkDoLY7enX9HQAphRJxJSyDbogIPhHutrgYfaQZ5PA=;
 b=joRElwgJWFXcng6b3sKP/fjPNyRrUuvdtzQGKauffsmL63U55YYhfT7c4yg2br3zwx
 ZOYoyV31mm84K2kHrqN4olLFSq7w/gsbIbd1/dvdWMp6G+34gKQ0ZRorhDRKvzJLFu5V
 hUvv2+Cjds2ZOeT6mqkOtN3zclheW04J9HswLKZEuZbQNPS4OuYyPfXXeq9ifgpiyNCy
 qAM0zR9fzlrpADzEJIqIwEYM23kY/COQx2xwYIFNNN4rjUho/dBlGrWz18LPRwJH4Y3l
 8JaU95nfGE4nomz7onaRyGD/VRFdEGvL/mfoMt0uTzKb2ELwJEZ6Sn9bTw4+GiTW/SHw
 YpCg==
X-Gm-Message-State: APuU4Z/rfzwLfwNpt8vBa2+QsmA82DE1FDKLg45ueHUxelOCa+bfokok
 7TSDnwq2VRRAFEU1Np7paqrAwNO+gpxOmDkKhO1vD6XCH5r2iGS9yYaB333QYG5ogxSCEmZsMs+
 D+Pznee+YXHzWSGfLDWiEhlcxNHeyeRzU6+YL2VHpxrjBATaiASznqMA=
X-Gm-Gg: AZFdTZfU464SHuROfrDXZ8efWDShO+cknD8UWf34uA0dV0gGcU22QpxkcMJopG0cyMr
 WfnNjquUEgGVpQx8v/AT/zpgYTTkpdpqe70WrsZjXhzzoMnXomdsHn36r49HobygnYYkn3UCoiA
 hrBEb8/bKP6VOysZUt0TUCcVOFeidUkWoKsKg5dCz0DmsfVk2PAjCZ8JLlfM/94Onz5VS4ZoFmz
 hn2e1GGbwB8sZH+uiO/U1lSfI5BTD2IzvVUaXsthZrrkqGLZXFhMcs++aXwFr9hIn92uZewaKPU
 zmcIe9XsRX+d2AfIicyF0WKa6QtqNBbLacz5qiIJWA2v6b5Jkyce2ES6bqywPrJDM8UthsTsIB2
 4PUxOZvo59kKuh5rizMzuTCcC+RhcDVJenlQyXqCy34CEWcyPfPLoo+8k+B64mzLqoQHYIqAKrf
 yvCBM/UVHjaCYWKHfyFeik3Jrz2A==
X-Received: by 2002:a05:690e:4813:b0:67d:ea5e:e504 with SMTP id
 956f58d0204a3-67df45054ffmr3967328d50.103.1795575331128; Tue, 24 Nov 2026
 18:55:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
In-Reply-To: <20261124-spacemit_k3-v1-0-e911d6e88542@oss.tenstorrent.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 24 Nov 2026 20:55:19 -0600
X-Gm-Features: Aa3M54qvOH8NH_QRD2cbPryqZOmekonp2z1F3IqO4lKN69uJgtkrPOpFKeQ9okk
Message-ID: <CAEev2e_4A9sU_SC5_R6zz6+08TPZJQ1YxH0Npo9D7+NxCxf9zw@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add Spacemit K3 Machine
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Jeuk Kim <jeuk20.kim@samsung.com>, Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 8:37=E2=80=AFPM Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> This series adds a spacemit-k3 machine to QEMU. The main intended usage
> of this machine is for firmware develeopment. This series models 8 X100
> harts, has SMP support, uart output, minimal implementation of syscons/
> clock controllers needed to boot, 4 types of boot media (SPI NOR, SD
> EMMC, UFS) and boot mode selection.
>
> The machine allows the user to boot with the bootrom dumped from real
> spacemit k3 hardware. If the user doesn't supply this, QEMU emulates the
> bootrom and loads the next stage from boot media in the same manner in
> which the bootrom would.
>
> SMP support was somewhat complicated to implement because the K3 doesn't
> have one clear way to do so. A single hart is released at reset, and the
> remaining can be woken up by M-mode IPIs or writes to a wakeup register.
> One of the syscons applies an overlay over the M-IMSIC to intercept IPIs
> while in reset and wake up the non-boot harts.
>
> If there are better ways to implement the bootrom emultion/boot media
> loading and the SMP support patch, please let me know.
>
> The model does not implement the 8 A100 harts, the Realtime CPU,
> I2C, PCIe, networking.
>
> This series[1] is needed for the SPI controller to work in EDK2
> properly.
>
> A sample boot log is here[2].
>
> [1] https://lore.kernel.org/qemu-devel/20261123-m25p80_write_enable_fix-v=
2-0-0ac94f99e91f@oss.tenstorrent.com/
> [2] https://gist.github.com/asrinivasanTT/77e692e00d305051533c828fbb2d1ec=
c
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

I realize that I haven't included any tests to boot this machine.

Since this machine boots from SD/Nor Images and goes through the
entire firmware boot flow, we cannot directly boot linux/opensbi like
the other machines.

Maybe a simple test would be to have a simple M-mode program that
exercises the UART and SMP, host it on my github, and fetch builds
from there for the test?

