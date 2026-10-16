Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D75DCCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiZg-0006zt-Rj; Fri, 16 Oct 2026 10:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHiZU-0006yn-5x
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:06:12 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHiZS-0004ji-Cs
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:06:07 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6af9a9451daso2530505a12.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 07:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792159565; cv=none;
 d=google.com; s=arc-20260327;
 b=oj6/O1SimApxGd6jXmKVRct39yQgdrilAonRt2DZEkohNKiRanZm2u17xL6Rvg+RwL
 6O8lcEV2miJmQR0y3iY6lJYTWKaTrwF2S7KObHPYdoq3DAUI1jTRgh1zq1D7WfSNedOK
 fuT+8oXIELNoldAtWn9flQmGugnqEJNALkE2kBVD7owoDaqmaqYWTCvISUj6C7TT1IQF
 XlCm0Hf5HY03iAW6OfW+51GlcW16oIHY8PVXSVRcST2+iqs9VNplz5tojM9IdHcdWM2i
 smHE4cqEbzh63BSE//q+6qAxGAhBh4PyQH/p2ishHMgPC2eqvO3oC35wKOhjIXUZeQNd
 ruJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=J9IImW9GgYpIi/RCk8fzQ0zy4Zwv383B/5op/lAYV24=;
 fh=63CrkvNni3mSJ2GwEPafmfW7IgrzmJMRQEJ9UzvvWq0=;
 b=TWhnXShItUmpo53SDPewKwtECo84VeuRCk+J9Bn+3+FLBr7XLtZdBBrpESqRjSi2HE
 PqCG92YmC/vyOr92pmXPJldD3Oht2uAvufwMp61ZswQe1KcO8RakZkGlkcqVIgj9lHLP
 CWS8aRlwSUB00+1hAq2MCeEgQcGtE2r8+iAwMioOtAp6J6pAGrzUlonl12QY0vy1QhvF
 ILG8kZKQc5jzNSQ4rMgAt/J3qYIqLu0ofGiQmgsW3BliqWpGlTf+0wHscuGFpIBDX2Wa
 A0T4fBRmuwGNs6H8UurODeBBdG+ZFWyjVdL0VAmC6nhL60BtkRSSxbKQqEM2h9x1ppF2
 eK7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792159565; x=1792764365; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J9IImW9GgYpIi/RCk8fzQ0zy4Zwv383B/5op/lAYV24=;
 b=OIMtTIZwfQ4ORk6ygTzGEIE7Lv64oLpfsBmb0TUzXL0Mk4Z/4xe8oOusxdqwn+WaXw
 UhQkVmP1lTCRrtVtZhITTu2zQ73ShlD5HjgD8QFqjYegS1fCUPG+BU8TQt6aC0T/o+0g
 efSiOswEzolnz9tFp9rh3r+ito3t6917GU/H4NjYvvij/X8GRU+pAJzq2BAcpkdE8HmI
 en7UowcDJSVfwm4Lrs/mxRBg/XNehu0lzovPDIXBm6ZNxWuJuMkxj17vfdWekeiQ1R9z
 uVUWcmjKrSiGsnzoAt6p8zRbw8LsGeBusuqOPJz1/Mmqcx6VKKYzwDzzWe6nrBI/ZTuH
 qokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792159565; x=1792764365;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J9IImW9GgYpIi/RCk8fzQ0zy4Zwv383B/5op/lAYV24=;
 b=CsEcVCtutMv3B7MFSB2Bvn68kyXBi/2PJb4IwrWp3cSBS50QZbHzy/JC4HkBggce6W
 XHUBuScJ75TOBIDwbHtifLPGD6n8pxXdsFgM63sAv6ZMcYGtca9Rt/c3FvH0RbdXmCe9
 A0eFu9upfQYkRfJWT9bDIA3IoypaaopzeVMhjta7+95PyjtGeRy1QSXOAX4aYzR5issF
 VwDvWriFrHMA3l8rs6OLDLQAjO3ZBw+K9Nu8IoCsepwrUbUOvv0jFfYhCp2wJGMV0IoU
 5cKz/70VgS3yU+rAkk/OmM46vGMVwu4OrxwUYiceYxi1jpbldVCNiBH7fxzRyQfo2bpr
 XG8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzidgnCvTtFWuLIKmjWo/ucgHuhiZTklPCACpyOi7OpXs2JcesijHsv/JLxXVhgX3SHjxraLaaCDF91@nongnu.org
X-Gm-Message-State: AFq9FYI4bE1oXjbaajFVbAFUcTyLWMjqOO23RRsUGiGuTm47pkvAN/R6
 JLCbhtjBsgL85Ab7jmT1W6mGNlAByWGaJ18LwRJbqduFFGoYFuItOMXfAtq31gu0kXNM4yh2pz3
 mHXGthTXCca8jnfVzpMG13yzImtrLZGI=
X-Gm-Gg: AYBFou0LUFnc4NyanZiPbDyXUGqOuBox6wd37QGVkp6jitKjowZ4tXyo6mQWJu46eQW
 GQKjMh0ehqrsYKS+r7gATZ02wbnHmlXhBHJrAr+z/GqL3dmE7DwFnHKQ0cUZBVETAwhnpILF+qz
 4mo/Ap7MPb9MqWtlBJLOhDxPHuP8+lsRyOt3QX8GBgd+SCqd99WB2nhwtsOITIkHvNJ56xMfIfO
 x8dLIGAD9RBaQNv33jLxvlKDA0VRauU8+3Ng7YOXfrpyYpNzW27zMUxKUj+EYlZUlPz560+1xJd
 0HLxh9D/p4TFdhbWGAlS1BGBe0/7x+UvKrDWn3iwiOFJ9SSHPiVQveM=
X-Received: by 2002:a05:6402:400f:b0:6b1:c526:afa8 with SMTP id
 4fb4d7f45d1cf-6b1c526b70fmr10556282a12.9.1792159564415; Fri, 16 Oct 2026
 07:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20261015044104.879-1-luoyonggang@gmail.com>
 <CAFEAcA8n9E1jpcOCat0kzv0Q++x7YwK_MNJBJ0qGdtX1-As4zg@mail.gmail.com>
 <CAE2XoE-fgq_c9qONyvfbNi3Ys_hv7yKvGCkk+Wz+rHPW0p65Eg@mail.gmail.com>
 <077274ba-002e-4241-9158-13a3270bddaa@oss.qualcomm.com>
 <CAFEAcA-mii9S1NvhKOt=pMha6-OQKheYj7FuMaDVbV2Eoi-3bQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-mii9S1NvhKOt=pMha6-OQKheYj7FuMaDVbV2Eoi-3bQ@mail.gmail.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 16 Oct 2026 22:05:51 +0800
X-Gm-Features: AclHuK-LdFdTnzXiy5jqe912RkVRxxCOyAwgNKxP22ZmT1O2AJBfnTBnW-lNw90
Message-ID: <CAE2XoE9W+vohRokJ=ePFesJpiTg7hfjSH3c4ptAibFPxAtv8oQ@mail.gmail.com>
Subject: Re: [PATCH] target-info: dispatch CPU QMP, dump, monitor,
 and Angel semihosting
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 David Hildenbrand <david@kernel.org>, Glenn Miles <milesg@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Cornelia Huck <cohuck@redhat.com>, Weiwei Li <liwei1518@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Bibo Mao <maobibo@loongson.cn>, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Song Gao <17746591750@163.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Eric Farman <farman@linux.ibm.com>, Philippe Mathieu-Daude <philmd@mailo.com>, 
 Xianglai Li <lixianglai@loongson.cn>, Chao Liu <chao.liu@processmission.com>, 
 qemu-s390x@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 16, 2026 at 9:56=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 16 Oct 2026 at 14:51, Brian Cain <brian.cain@oss.qualcomm.com> wr=
ote:
> >
> >
> > On 10/15/2026 4:38 AM, Yonggang Luo wrote:
> > > On Thu, Oct 15, 2026 at 5:20=E2=80=AFPM Peter Maydell <peter.maydell@=
linaro.org> wrote:
> > >> On Thu, 15 Oct 2026 at 05:41, Yonggang Luo <luoyonggang@gmail.com> w=
rote:
> > >>> Put query-cpu-definitions, dump notes, monitor, and Angel semihosti=
ng on
> > >>> TargetOps[SYS_EMU_TARGET__MAX] and look up by target_arch().
> > >>> Keep the table in target-ops.c and with a stub
> > >>>
> > >>> - Register with a QEMU_ARCH_* bitmask so shared base-arch objects
> > >>>    can fill both slots (e.g. QEMU_ARCH_ARM is ARM|AARCH64).
> > >>> - TARGET_INFO_CPU_OP is type_init. A NULL member means no handler.
> > >>> - Drop stubs/qmp-cpu.c
> > >>>         stubs/hmp-cmd-info_tlb.c
> > >>>         stubs/hmp-cmd-info_mem.c
> > >>>         stubs/dump.c
> > >>>
> > >>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>
> > >> Too big a patch touching stuff all over the place with
> > >> insufficient explanation of what it's doing or why.
> > > Oh, sorry, I post is just for demo(DRAFT) for other place to
> > > reference, but git-publish have no way
> > > to title it(maybe because I use it wrongly).
> >
> > git publish has `--subject-prefix=3DPREFIX` - that will let you qualify
> > this as DRAFT/RFC.
>
> It's also helpful to edit the commit message for a single-patch
> RFC so it's clear about the purpose of posting it (or to provide
> a suitable cover letter on a multi-patch RFC). "Just a draft
> to go with this other discussion" is totally fine, as long as
> the commit message says so. (More generally, an RFC should say
> what you are asking for comments about :-))

Thanks, I'll take care of it next time.

>
> thanks
> -- PMM



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

