Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB08C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuuBx-0003ZK-6s; Fri, 14 Aug 2026 11:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuuBv-0003Yd-UE
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:51:31 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuuBu-0004zJ-IT
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:51:31 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66c82b32121so824269d50.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 08:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786722689; cv=none;
 d=google.com; s=arc-20260327;
 b=iaD4qUj6V09sIouVTTo0s0U+k3xr4v5Xix+usVzGU5xNWo0KATN1UMUNIQIlzxi/NX
 0p2bo3cnS71gGQS+qxZS9O5DnigRSmOTWAhEpmIl0DyeaCjmsPmSCUds0y6ZVBXbpEZJ
 Fw6UyfMoxdqjQSyD+/WRmgvtqiiFuaO+vftNv0wGzfOF9HfdNp0UTsXH7sYA5Uw25sfz
 JEuClejvewnCXcy9UNAYQfS0vy9O6Q+lWUCOgKFDq2bd9TiI605kc2d1dsbLx/YNiA6G
 SrUIWJ9wZrbIX6CQlF0ye5whUdPYklb/SITrQl/GoYxIGVNEMhl1FZ/54JQaSDjpwl1J
 tNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dUhBMO8NC+eAqyDxPKMtSw8zgeFz//KtjkJmG3llBVA=;
 fh=EBO+ewaBzcwICwNeTItCWUiUAR27teQwQEsktwcbdbI=;
 b=ooD5miLenWGCNMirb3vBjQD/DxEfpnHhFI0a9ZmJwShuMvJAML9RY9yceoTRvHgnLF
 CnMKQrfl6RUDONuwxdv3ewezWKTtK0BIfay4rhq8h5Nr8S8mTniIIpnV9XuQT5Y97Crz
 pK20vcEGd3FT5y8SbltGmzIH6bBl3iLLa/Ni9E/tk9adgKeFh0Lar285SZegfvJ/UJQv
 AC+3hyf4C9IyAxpWZueKpzbZIHobpw7J71VG8/BfIOYBCDN7DBO8W3qAQgJESKhCAMPy
 NcsyotGOVZDvQk7/9ODz6aVfCQIlqTa8m9B/1lEpH01pGUqobck2iDO3HAzKhrhupNYa
 WiJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786722689; x=1787327489; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dUhBMO8NC+eAqyDxPKMtSw8zgeFz//KtjkJmG3llBVA=;
 b=CZ+qUZk3dlOIO8BFng8NWnmQcKYoau+iIlv52EN48Zbuex0uHVd4BPmIjUoivt1aZt
 o5CDajcYOlxzr5ncUE/O/EsyQrII9OR3ImAh+RBex4cPc0yTvkzkXhAKTioRGLkjzXHS
 zIz1Q8NpUIiI0o0A6jzWqymUcRUffx4FErodpzbx7G7phEnZIRGV9yLe4mz72f2HdpIO
 FEO6Jj79ga43TWMZzxX6Xbs6Rw0j7CbBFhvlt14rVcWMQm/s+EdkEL/adYR8a0cijPz8
 RsJhj3xo8GdJZ4FnVbDPUmjuOBp4TF301dQk4sPucaqiJFitkxk13m8sshncaOzaj+GN
 P+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786722689; x=1787327489;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dUhBMO8NC+eAqyDxPKMtSw8zgeFz//KtjkJmG3llBVA=;
 b=fvCuHuy9MNpw47jcJf0pHyrOFRn80TrdcBZWGva/ams2/qJCUpc5QImNak2H4voP/P
 x0fiuBEf/j7K56YiH93KvHVtV421yjYjpEqh45hzrN+tuRNKZfld1FwqvXZNbYduk950
 ujjCJZijqlTmnZRFh6uoKmHPMv3okyS9N2+v/MPr76gOlDPv1EBZFz9cRv1nNvKj2qOe
 V2SAdncWgGvDuhZ456u6HlIhl4Kj8J4Etpcf6ltovol3B7yZf7VuZVF/TCx3L/GrDb+P
 A2YLYZZ/9nKpjyF48jcaEmld0wa+sINxpx60UafY2lVN7v+PUM50dmI/bnIymCPphuGM
 XYIw==
X-Gm-Message-State: AOJu0YwcU3ewT+BWNT6KEMmXnedymGgNI8BSPZrMfQXnhmU6Tk1sXPFE
 FskRVfT6CdKhMmLWebaMyxW4zfyK1lGF4Q+Oz6ZdaG4LTLUlXSm1ExAF2ifg7cDSPkTkm+zCFbV
 Ois519I7t8pRh2vRXTb2tDYm7otL5+1o=
X-Gm-Gg: AR+sD11/qYmJ3wo5U4NCzfXCHPdxSOp/DBEz5172OMHoRSlgP1ptgasQWF2JPleqvUx
 CGFGO32LX9CiH6cPq0pqL4EwAokl8TR25SO6M+s/9w0GiMZgrsXbyBndCY6zffl5RzQdnhTCluO
 j7KcLhu4YANuTbHCbuFfcpVMIEvlxbv7k/atziBS6tTMnmN90WcGLtFNLkAyDrXAG7nOYWrP4Qc
 bbvsWIoHYuypMZa+yOJnkY02ADcbn+DgdQRse0vRjqcgcvYK1vP1t3kRU9iCxowcetOOh8j9fWJ
 j2denYAshvIOoNY6FtmRWHiINjTEsQjoggWL3StZChzgjFH5
X-Received: by 2002:a05:690e:418e:b0:66c:4937:d319 with SMTP id
 956f58d0204a3-66c72d2ec6bmr3064484d50.46.1786722689144; Fri, 14 Aug 2026
 08:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
 <CAAW0U4azckLqyWEy=bGRH3Js8AOeW=rpN2+rgkhVStzC0Jv5mA@mail.gmail.com>
 <CAEUhbmU1LYzeQU39eOhd-S+WY6w7A--MOtmcG+cbTgeyCEMr9A@mail.gmail.com>
In-Reply-To: <CAEUhbmU1LYzeQU39eOhd-S+WY6w7A--MOtmcG+cbTgeyCEMr9A@mail.gmail.com>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Fri, 14 Aug 2026 23:51:18 +0800
X-Gm-Features: AUfX_mx0PcnB9LQoUpT8QcXJ2mmymJCV2pvlJWfkLMmnQeWuTIfb3_ZGFGNKHOc
Message-ID: <CAAW0U4bS=usrkxTruUS=-YEYJ=er2o3tKF4ridZ8ZFX-Qmyo4w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] hw/riscv: Add K230 DWC SSI Standard PIO support
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yx1-xb12a.google.com
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

Bin Meng <bmeng.cn@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=94 17:25=E5=86=99=E9=81=93=EF=BC=9A

>
> For review comments raised during a normal process to the *existing*
> patches, the Suggested-by is usually not needed.
>
> This tag is mainly used for *new* patches inspired from the review
> process / discussion thread.
>
Hi Bin,
I understand. Thank you very much for the explanation. I'll drop the
wrong Suggested-by
tags in the next revision and make sure not to add them again.

If you have time, could you take a look at the implementation? I'd
appreciate any review comments.

Regards,
Kangjie

