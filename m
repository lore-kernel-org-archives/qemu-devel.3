Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6047EA71B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 03:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEfSk-0004kK-C5; Sun, 19 Apr 2026 23:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wEfSi-0004jz-5O
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 23:38:16 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wEfSg-00011e-2Z
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 23:38:15 -0400
Received: by mail-vk1-xa43.google.com with SMTP id
 71dfb90a1353d-5673804da95so787000e0c.0
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 20:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776656291; x=1777261091; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZfDbgLhksNgC/0I18k8S+mBITVy5KnLmOj5gnzgQ6XE=;
 b=ssOp3rup8OpxwIQ/h6rRiU6ChTKH7WDfzr6KnuC/U/FIVe7g4Rz+TZhuoHDKe3B2G8
 StDmkC8Z83RR6nJiGghP0MqD/bTSS77R5F8YYVzdui0RuTbJje6wX+yBaCf20vAb98xy
 kT36foZZN60UHeycLcPSkVN3Fm15JiO0Dmd+VHP0mMsHaAeHa/A32DNt7/8CEkgAoMIb
 tHuxLSyWBoUVqrY1guImwJ9kARXHiprhbv+VEiiNMliW8XSvWAfEKY7+Kq75ZXnnINKG
 h+4izKQAuWHnqod2ZdhH5v49tQ8NnDQBHMU/mT5lUszyKcetqTGNrZ/Bwn4gSZnKcSxA
 SHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776656291; x=1777261091;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfDbgLhksNgC/0I18k8S+mBITVy5KnLmOj5gnzgQ6XE=;
 b=fOMkWMtmDHg3gT4Ktmlot71E9Hk9RPWr+l7bwb7GjjBMcZ6m38Aw183S6SDxmy44Xx
 Q75snRUQlLxoVYh55MVCBReKfSUU7BhDMSqDGKbUDUIA/j5/gFJh0M1b0eU1poF0hUIO
 PlsILxWyKfw+8Eflee/3H4nZUx+msnY303fYEQq69b4MGvGkz0ogym0dmsTOhoVtocCu
 Z3B/WZB0JpVvCNQlOjCvM3XQ+boNS6ohiUchOxCbPn1uPKgGR/eWPp4OnELESKflR9w0
 4u8YoplMs6VSm01ME6GNZ/d3QO4RPGd6H+26cG1Kc+ckVfJ5tYbae51ieZ7e9A9aly+d
 MTjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RaNxkdUNjZCCKg3STe4Qlzk7Lwn44LIjgtatjTr1lcXBay3MKRAXmvQvHhkVaC8Usj2JLnZ9ukQeg@nongnu.org
X-Gm-Message-State: AOJu0Yw6J3bxg0vcIZ9vZ4im4shLDTghEbYH8u1+WTwDS94iqo8SN03M
 IgogzDmLtd3ACmR2c28yuGR3S539P0d4RLxBbfS/nOYReq77SMyAtZr4
X-Gm-Gg: AeBDieuk0STEoL0gAoRYbx/xj/5uxkfvIPsqybAuDa+YzK+6ZeAE69WBYahAl1rVcY2
 EcNAnGeJtr0ZO4pmtK8jEkxQTYFvGKk8yhmmJSK2wUlJQBexm2Ufhb15wOaDxLe9/EY2B3Rafu5
 y1FK7mF3wtr8SqB1vEQ7oh7yE8L49VD+i2BwNUN5bHdDBarKDks4KMZFm/1ih9wG3xzEspung4p
 Nu/hOQYVfEH24d43+oXfU/6zTh/wi3bMZF2t3wKTkxbejHGMPxsGJoGjHJ04M14/cVg+y/M1qdB
 VSuYu1mQrQu6TSV7tPjQjDYNENlgcPts+ltkhCblnHVywmyN0J+hWZ2++lEnKKzb42vdm9A4dQ/
 wjQbeIfxVuMQ565DAu6HX9vuOTI91UzEn903opFmaHKhSKjH1bGQd9t8taecdKEb0nmtHBNgwHj
 oyj3OOTdkVmqgmi9eUIuIL13cme1R2yPn1zurpaYt6EN3Vsnd1bX5GVBzY7C5uCFwbUqUnqUZF6
 BQqNmwqOXA=
X-Received: by 2002:a05:6122:e191:b0:56d:b639:5c0d with SMTP id
 71dfb90a1353d-56fa5a4666emr4791721e0c.13.1776656291001; 
 Sun, 19 Apr 2026 20:38:11 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56fa92f22a4sm5594584e0c.12.2026.04.19.20.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 20:38:09 -0700 (PDT)
Date: Mon, 20 Apr 2026 11:37:52 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@zevorn.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Conor Dooley <conor@kernel.org>, Peng Jiang <3160104094@zju.edu.cn>
Subject: Re: [PATCH v6 1/5] target/riscv: add thead-c908 cpu support
Message-ID: <aeWJKa4edHt6Djv3@ZEVORN-PC.localdomain>
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
 <CAKmqyKMipoe-YHVo5VGekUGG4uFJ7CEktipsOCSrSx=6b9=REA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMipoe-YHVo5VGekUGG4uFJ7CEktipsOCSrSx=6b9=REA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::a43;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-vk1-xa43.google.com
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

On Mon, Apr 20, 2026 at 09:49:50AM +1000, Alistair Francis wrote:
> On Sat, Apr 18, 2026 at 1:13 AM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
> >
> > From: Chao Liu <chao.liu@zevorn.cn>
> >
> > The C908 processor is based on the RV64GCB[V] instruction
> > set, compatible to RVA22 Profile and implements the XIE
> > (XuanTie Instruction Extension) technology.
> >
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Reviewed-by: Conor Dooley <conor@kernel.org>
> 
> As Connor pointed out, he didn't add his Reviewed-by, instead he
> commented about a missing extension [1]. On top of that I don't see
> any instances of `Reviewed-by: Conor Dooley <conor@kernel.org>` in the
> QEMU tree, so I assume there are none on the mailing list as well.
> Which makes a copy and paste error seem less likely.
> 
> I do see that Connor's reply was sent from his conor@kernel.org address,
> but manually stitching together a `Reviewed-by` and address seems
> unlikely to happen by accident. Although it does seem like the type of
> thing an LLM would do (see below).
> 
Sorry, when I first started contributing to QEMU, I wasn't familiar with
mailing list conventions. I had been under the impression that whenever a
reviewer left comments, it was appropriate to carry a Reviewed-by tag into
the next revision. No one pointed this out at the time, but that was
clearly my oversight. My apologies to Alistair and Conor for the trouble
caused.

I made the same mistake on earlier patches as well:

https://lore.kernel.org/qemu-devel/8b29b86a9af84edba54cc53aec017224478312bf.1745894489.git.lc00631@tecorigin.com/
https://lore.kernel.org/qemu-devel/501e578a4ef28515ccdefcbc82defc04363855ca.1746001489.git.lc00631@tecorigin.com/

There is also a slightly different case where I added a Reviewed-by tag:

https://lore.kernel.org/qemu-devel/07a97219e3f7e342c668d6772acc4c0a8eb4d4f3.1744709888.git.lc00631@tecorigin.com/

There the R-b came from an internal colleague who reviewed the patch on
our side before it was sent upstream.

Is that also against community convention?

> > Reported-by: Peng Jiang <3160104094@zju.edu.cn>
> 
> I'm not sure how this can be Reported-by, it's not a bug fix. What was
> reported? It seems like the Reported-by appeared in v3 [2] and wasn't
> in v2 [3], yet I don't see anything reported.
> 
This patchset is the project-phase output of a non-profit QEMU open-source
training camp we run in China; so far the camp has trained about 2000
participants. Peng Jiang is one of the members, and his task was bringing
up OpenSBI/RustSBI + Linux on the QEMU k230 board. For the specific
details, see:

https://github.com/rustsbi/rustsbi/issues/160

The Reported-by in v3 was added as a form of encouragement, since he
found several bugs during that bring-up work.

Given this situation, should I also drop Peng Jiang's Reported-by tag?

After the camp concluded, I asked him to report any further issues to the
upstream list directly himself — for example in v4:

https://lore.kernel.org/qemu-devel/651b1d38.63ab7.19be50b4721.Coremail.3160104094@zju.edu.cn/

> The extra and unexplained `Reviewed-by` (especially using an odd
> address as mentioned above) really points to this being LLM generated.
> Especially considering that your reviews are LLM generated (those are
> fine). Unfortunately that means I will need to decline the commits
> according to the QEMU Code Provenance rules [4]. Note that it isn't
> just the Code Provenance policy, it is also now really difficult to
> trust these patches knowing that stray `Reviewed-by` tags could be
> hallucinated and not caught before being submitted.
> 
That said, I should clarify that no LLM assistance was used in developing
this patchset.

Finally, thanks to Alistair for the patient review. I'll be more careful
about these details in future contributions to avoid adding review burden
on maintainers/reviewers.

Reference:
1. learning-QEMU-Camp-2025: https://opencamp.cn/gevico/camp/2025/stage/5
2. QEMU K230 modeling task assignments: https://github.com/gevico/qemu/issues/7

Thanks,
Chao

> 1: https://patchew.org/QEMU/cover.1764493931.git.chao.liu@zevorn.cn/c27edc69ea6642f645d5e194bd5d4cd71e812841.1764493931.git.chao.liu@zevorn.cn/#20251203-squiggle-gentile-f27af704359e@spud
> 2: https://patchew.org/QEMU/cover.1765811173.git.chao.liu@zevorn.cn/ac82fb9f22366614c2be80d9fe200f1b5ce161ef.1765811173.git.chao.liu@zevorn.cn/
> 3: https://patchew.org/QEMU/cover.1764830405.git.chao.liu@zevorn.cn/fdd2cb519a91a16c5b6e8931dda8301bf1c23c85.1764830405.git.chao.liu@zevorn.cn/
> 4: https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-generated-content
> 
> Alistair

