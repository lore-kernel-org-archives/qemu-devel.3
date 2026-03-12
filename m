Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4498105A589
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0eQv-0001Zb-Na; Thu, 12 Mar 2026 07:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w0eQt-0001ZH-Gm
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:42:27 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w0eQq-00075A-KQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:42:26 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ae5423b02aso6699115ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773315742; x=1773920542; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NdPAw2eThtDWmGAFkrq0ybO5YP06ET3AZWSjt6khejs=;
 b=ANrVQqbdGLg8YzOTo8z552w1uZy+VRqn0yjjpjiMcLBrD2yNbRasTbTlq9kxToiHfA
 yUSiaUacB5pC3TDeuxVLJj0RpUCUOPfVupHl/Pz7VabfScjJzc5G1MDBZtxgOIRzFdKT
 ZqwBXomP99aaevr/wb/9hhjP2wlYwdXcRDxo6Jw7/v5Rwkt2esTty2KXPQ1IVhN8Jgkm
 ZcQ03SLacPWOtq67GbnsPAyRcDKzGO+1GbuPx7OT44lObW0JT2GK+fOPavPdxEvgorEk
 xrBQ95/LNCfE7Tp/ZzsRelUqVvDp22UCFZSmdsF/KtkZ8tChZqtvzdUHbPV5SiAUNFa3
 KCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773315742; x=1773920542;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NdPAw2eThtDWmGAFkrq0ybO5YP06ET3AZWSjt6khejs=;
 b=Xlm/OUFr1/dExnUkjrDA9S8dU8V4COmovH9hoKXYxcOF8X5r6u7c1Cw6EZBR8V1HB1
 oj6s2Pg15obpMlloWeOIIr3NQCR0qrTUpO9Max7+YKyfJP4G0jIhs4ZBYJ4ulnoxj/Si
 y53CuMVTQgnthy90dapbu04JwHBTspjp7LH2HJPmua/L1yQegseudEz1vM09WPTZDG7Q
 wEOKnVYPUeO/L4t5HdJvHIIMuTnoKTr0d00QuLxzH3llmT/ifMkQ5gScFrKQ6H6MxhXG
 jnlPC+4X1uf93mlYgvqieMIaKN7wqKN7h1rKZ3CiIhlg+mDJlgP5HBo6He8fVQybWp+5
 l6Ow==
X-Gm-Message-State: AOJu0YwT3O14xDY/9Ce2tho87lREUUtDO4z+a9teBHXWHI4pCZabtAdR
 96yuVjPDatSihaScKVcMSqRLD2ycPE+7Nb0CiJd1hnysYOqFOTpscmTyK4C/r23K5OA=
X-Gm-Gg: ATEYQzxTUS5Y6GLZYkf5abwfl59XuoOo5HxQSf4+yNlGu2b9q1cRQWg8axARzjzaAhx
 PQeUqGeGG3Vt7Rrd3A05XxVY1Y5ESwkqRO0i6EvAF66/qsHglkLeJUH+32pDPqelMCe/Tb6mi21
 0dLFvhR9XXlhSjy6CvxeSMmU0O50eRTLE3OcjDR8dTK1u5M2zj/+wk6/+5IWzHnnSaw06W3vBgJ
 5qx4C5ZpaMuKCR0n4kZRh8/rkJjxSd+jIu3m+xBpkvq7dU2PlkT1tHxtduyUGI2fydhdDN8LOJV
 28anYVE3FCdKpTk3BgKuWhIR8p80pJHXehLxs0hkgZFsTMseYIAbj64fO0DdWg34BOfPMZUL3tR
 XX/EACKE8BLd4NBqb71FPU3cItSEkGbbXb2f2yYo30rF0715EOLjqUoh+CDp+K3qhUxUWrTmpYH
 mvlirFo+EUPc+9EhqVTMEnNA8iWVmMM8XatksZBiFwogkY66TBXw962vUCFGsDOdIYlpBa12P6L
 yw=
X-Received: by 2002:a17:902:e888:b0:2ae:467f:11d8 with SMTP id
 d9443c01a7336-2aeae891e96mr56225525ad.30.1773315742011; 
 Thu, 12 Mar 2026 04:42:22 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae246ff0sm80015205ad.27.2026.03.12.04.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:42:21 -0700 (PDT)
Date: Thu, 12 Mar 2026 19:42:18 +0800
From: Max Chou <max.chou@sifive.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v5 5/9] target/riscv: Use the tb->cs_base as the extend
 tb flags
Message-ID: <abKlW3gA3qXR6bub@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <20260306071105.3328365-6-max.chou@sifive.com>
 <CAKmqyKM-mu7+gtFRK+G94szLFUDdxGaz4zxW7-bW2L5y0Kn2hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKM-mu7+gtFRK+G94szLFUDdxGaz4zxW7-bW2L5y0Kn2hw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2026-03-09 15:01, Alistair Francis wrote:
> On Fri, Mar 6, 2026 at 5:13 PM Max Chou <max.chou@sifive.com> wrote:
> >
> > We have more than 32-bits worth of state per TB, so use the
> > tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.
> >
> > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > ---
> >  include/exec/translation-block.h | 1 +
> >  target/riscv/cpu.h               | 3 +++
> >  target/riscv/tcg/tcg-cpu.c       | 7 ++++++-
> >  3 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
> > index 4f83d5bec9..40cc699031 100644
> > --- a/include/exec/translation-block.h
> > +++ b/include/exec/translation-block.h
> > @@ -65,6 +65,7 @@ struct TranslationBlock {
> >       * arm: an extension of tb->flags,
> >       * s390x: instruction data for EXECUTE,
> >       * sparc: the next pc of the instruction queue (for delay slots).
> > +     * riscv: an extension of tb->flags,
> >       */
> >      uint64_t cs_base;
> >
>

Hi Alistair,

I’m curious to know if you mean adding more details here, such as
specifying the bit width for misa (e.g., 32 bits) or the bit width for
ALTFMT (e.g., 1 bit).
If so, I’ll include these details in the v6 version.

Thanks,
rnax

> We need to update the comment in `struct TranslationBlock` for
> `target_ulong cs_base`
> 
> Alistair
> 

