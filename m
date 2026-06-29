Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5786CC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we1ED-000587-Bj; Sun, 28 Jun 2026 21:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we1EB-00057c-IF
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:56:03 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we1EA-00078h-3K
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:56:03 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6974a6e54dbso5190780a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 18:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782698160; cv=none;
 d=google.com; s=arc-20260327;
 b=XEW0xm5UIUpUp1ciuNKSzKq/r6x2yO4C6IMEvJIjzWO9L3zz0u7Jflbok/GkNnh2zm
 FGkrQuITW6NBoOc/YLbK0FGt3GCL66GjjS4XftVxkYOBNyrL0/4kayDQKWxKzgH0oSQq
 L4WZTL+w47jqrel9A4QnL2xr1UfXxBcVhEV+uScn9TOIVIKCw1b4d50qLVW/TNIEzRWC
 tgpiSufDa9U5KMEKN2xCPFIYPPros+wj5qZYa4txyH1nuRQZ7Mk2x6ybjtVrN4sLgwsN
 N1FzRUyU6/PfFalQ4U+PphG5F46dew+XShK237TqoAkXmMlwrkV5u0LnMWUWNyywJM2c
 0Ljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=67SGkREIpxmBr1FvlfzHlYWlqTReQj5J+e4yvFMe5PQ=;
 fh=rWmma6703t4R+1iH2sHosg8cZrsXDBK9GDA/nQp6UYg=;
 b=JNk6ONTWYuwCYhbQkXKRftU4gvqLVuS5swYpRgkywWqMGVRtgPDQGycBZtVv7WfRzL
 IdkCAYva1DulHjrNunHq+7E326lp3BDdOBXumRgcs1hHXgR8IIkk5/oUhT9i+m/O5NVp
 M5NjxDBOO2DecZTb3DBOIGQMguvqLM97QOEr57phdN4UDjt0+f4En6kPIcPcmBGEYhrZ
 kI0ECep/e+7Ox2MRFPBi5wdSRWZBVYPgWiSYDRXDpoRGvk4MxTGeYLD2RxK1kkpd3X1t
 VhiiuvLa8VlmSADtN+CuQDZRRNYtGWF2E0oFzSqOuB2TGMKMDFw4ZBiCRMOCt0Syzs9C
 pgXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782698160; x=1783302960; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67SGkREIpxmBr1FvlfzHlYWlqTReQj5J+e4yvFMe5PQ=;
 b=nqEXRMuDoLlntxk13RmC62HComN/H1+Vb3UoxX9mkMmp+WGnD3fKOz+4vnUoW1gXtY
 ja22BQnFCHa+yXAxhn0gITX/lbL8zFheuzw3hJ9J297fo47BToZ3MA3PBkBtMm3DYoIv
 gZnHT5YBthas86GGSLn1AsEzbxOnrvzH/Bsff/I4io5b1AcDVFzEX82kE1XZAJxO4NLT
 zuhxy7KNl9FacHqzUGHOnMSlbwW1DgvxmYRyqoynr/h+aiwGaYsdXHdFmQtk33ZZZqJz
 +WH2MHp8McMVXLvJrff45uJjrH3KORZe6C/RbxCUxURSjaC3es/wZjMsMJ8OrWCbadnA
 QjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782698160; x=1783302960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=67SGkREIpxmBr1FvlfzHlYWlqTReQj5J+e4yvFMe5PQ=;
 b=oPplAS0RQ3S+ImN1Ujj+zkcXX21DLmVFEO1KI2zfBVd59RqlmnqxJsGn9Uncw/hVGN
 EeHA/jQ82d613ky9cP5ghBEEN/KcrunNjLOr+OfNXW4LI9hWXpkB2mjHqehnKKMrTcMo
 cWj6Btr9N9Zwvv2Ilwgyuvi3+7NS7k9iHMA97P7SXFy8NVBWx8bdYIo0mj7cQOOW3JXe
 wv72b5YMiByhSUallz8AwpbJTi02/1YqJ8+k1zBsnPRTnopPOEFheY8t4+4OVY81caP2
 +S2E0XLcFWarYM9zx1maHTrslSL8vE6WV1rrbnEvohzZPsMeE9SaY5Rf0DjnbTJw9Yhc
 yF/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHF23+C3dRHLohAuEL39K4JbEG7Nov3yvC+Ca4B64uu7iq5HhNrhMVBqxuI+AVQNYa6zYzezIjp5Af@nongnu.org
X-Gm-Message-State: AOJu0Yy9Nu1WyTjflAwul3KNE+oNAX4JXa00mB/8A4HjnPtbvoRbTcqG
 Dn8ZFf56YXNdv/fCYyeXomH7LwsL9edV925+wA0d0DsuKeMS8BDdFAG5NQ90Yeikut5fzArTtJU
 Kv1r53AMqqxJz+sgHzoLdNAqeJvjEGFU=
X-Gm-Gg: AfdE7cn5kh18dvdqHjdkCZsTNZFowWwVYYsg6RQrZmapvHmcTkUV0dt4e7J2XkATLs1
 ldM+oJnuqMAOagfq4fn4IX4unFWG3rJSV64dFmGOZd2YIVG/7toskbBDYHCk9ABXqgdNL118FHg
 jd5aC741siTnjQ3findNMij4nr7URCOaZhwVeZAZI8Q7dKaVUTQel+scLlgCnuFhrgJbeMIR22c
 iuhfbNLiHCWJLb/61rk1xExa9J+meWxgBErqAgqy5C79MlYx3nekuayHvrd7UGq6xBfqllshPve
 TU/iYpwWw0O2fDsyF0cUVwo8dRUm75VXGVxmBw==
X-Received: by 2002:a05:6402:26c4:b0:698:642f:b871 with SMTP id
 4fb4d7f45d1cf-698642fba7amr1092276a12.9.1782698160402; Sun, 28 Jun 2026
 18:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_CA380CBF4A98C990C07BC04A9E748C438309@qq.com>
 <CAKmqyKN09Ut3BAnUpF4Fen=DzMcT=sNpGjTHa8yPeu58H5EpDg@mail.gmail.com>
 <03156de5-9081-4b32-93ea-eaf363acf8ab@oss.qualcomm.com>
In-Reply-To: <03156de5-9081-4b32-93ea-eaf363acf8ab@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 11:55:34 +1000
X-Gm-Features: AVVi8CctY97hL8OePVBkfzMZ9qQha1Sk-UyKxvoNHJivoN7gySykYjAFBmA6fH0
Message-ID: <CAKmqyKOtPw1ca_QsaxYMiWGETTT0mVyA-ENb12b7aKO7F=uACQ@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: ZhengXiang Qin <qinzhengxiang@foxmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Jun 22, 2026 at 11:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Alistair,
>
> On 22/6/26 05:03, Alistair Francis wrote:
> > On Sun, Jun 21, 2026 at 10:48=E2=80=AFPM ZhengXiang Qin
> > <qinzhengxiang@foxmail.com> wrote:
> >>
> >> check_zicbom_access() currently treats any probe_access_flags() result
> >> other than TLB_INVALID_MASK as a successful access. However, a result
> >> with TLB_MMIO means that the target is MMIO-like and should not be
> >> treated as a normal cache block management target.
> >>
> >> Raise a store/AMO access fault for Zicbom accesses to MMIO-like region=
s
> >> so that cbo.clean, cbo.flush and cbo.inval do not silently succeed on
> >> non-cacheable/MMIO-like memory.
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
> >> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> >> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >> Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
> >
> > Thanks!
> >
> > Applied to riscv-to-apply.next
> >
> > Alistair
> >
> >> ---
> >> Changes since v2:
> >> - Add else before the success path for readability.
> >> - Keep fault_addr as target_ulong since CPURISCVState::badaddr is targ=
et_ulong.
>
> This is not true, the fields is uint64_t since this commit:
>
>   commit f2287c7020f36e2f13622d9635a968d6f6fb507d
>   Author: Anton Johansson <anjo@rev.ng>
>   Date:   Wed May 20 14:53:43 2026 +0200
>
>       target/riscv: Fix size of badaddr and bins
>
> Could you update the commit, or ask the contributor to repost,
> or clean on top, please?

Thanks for catching this. I have dropped the patch, please rebase on
master and send a new version

Alistair

