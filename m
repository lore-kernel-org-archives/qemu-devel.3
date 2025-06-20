Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C76C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 06:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSVV6-00021w-1K; Fri, 20 Jun 2025 02:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uSVV3-000215-Bf
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 02:45:21 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uSVUz-0003R6-Cm
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 02:45:20 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ade58ef47c0so311286866b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 23:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750401906; x=1751006706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5YVPZUKM8fUxJ28CAOlzAgI+3DEJTlLh9JpAcZ9CtzQ=;
 b=mZ4iwZIFbGGaU6MKywx8sV5PnmIExbK5SoJ+A/rZYZ6asHaEi2e5cH+Do2RVQaVQMo
 S7PL48cd2t1OhYphNeJMx30pNUo8rYBgwPzVug1+1yA5RGsvd1kJOJ6Yhs8E7GUhDzgA
 IbStHQee0K3RBSCjkJNoDNDEp1AEXkqPMJAa6m6UuNY1WeXHek74dHOVSir8fVxHm80P
 Ok24CRo6ynuYRWV7mywScQYOPpbF9/S/43AUJWChl49aFWJisXgDalhlUEyOyzBTFXpf
 JcHxFAAA8xwNZnq68NECEiqclQcILYQlPN2CcawTpk/epTPqohn8/FWYIM/PgUrbzVvp
 em9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750401906; x=1751006706;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5YVPZUKM8fUxJ28CAOlzAgI+3DEJTlLh9JpAcZ9CtzQ=;
 b=K8bIuY4RwqzXQE8fodg/fXvmtq+4+MQqiuOhfF+8QD2vcUH/RbwsabG8grCrXfCn1U
 hitt8PBXm86PWj32EMoJNg2FbbvSRZSsUDgfREojAXGPJpRYNbiYs4imZcraWOyblXI4
 Pu1TYEyvgU2YURj/GRwtyoiCYx+IzWdgVt7A+yztj6s+K6peGzN1vSWmcdIkGn5g9/v9
 nS2IZIWtWCHy8+YSx0XGvgCqVfoadagpXdB+kMqhmRzu9W7QfLEN/ULPd5pq9xmr3p4f
 z5qmHO0KB38aZArBaaw+RcIS21HqEjxP1yprs2bzUyrzlOXx08DOYiaDpCYbC+WgUhZT
 e1dw==
X-Gm-Message-State: AOJu0Yz9ZdYFaUc9JvnLqCPNi9GqWZWsYX0IroJKKdR/cYtl+QYPpffC
 Ex4KzkTchFNwFlhRDvURYTwWd1RP3FKX5bp7CoODkQ2i79V7wt0RO73NRAjVzYA0mjQ=
X-Gm-Gg: ASbGncuGgJ0Pzi4vCvIanJSJ7nPXhsl+9zn/JpSFUGYyFDLKT+aK4NleFcPxp2p39GL
 HUIpJhPLGWSk+G/IKkIvSG6m7LDO91VdiBuXT9jbZPXQg7QspNkUweBGpLLo2kMqP5vqqXd5Rkd
 gjJDy8pfDQ9v0vYHJnm5u2pBU426LKLLK45XM7aw1viay7eDsWRedcOO4IDNBFEAaRe3CHqs0VW
 4upgbE7bMrG7bYhhEcTLnn7DPqqFCj8m1mbx7m+yClppfINV4c5trPVLoWZnipULGCIBplGia1A
 bvyl0AcJwCBeqJQImrYupc4bhNCmOCmpBdZs7y2J3Nape73p+2Yr3ckNRHCpmVnjr/BwSINqlQ=
 =
X-Google-Smtp-Source: AGHT+IEUSS5KWCwQdedagab+tQr3NJQGb+nlqoPW21eZa/Bamd73nqX4kTjUNrzREcENU31dMQpzdA==
X-Received: by 2002:a17:906:c14c:b0:ae0:573f:40bd with SMTP id
 a640c23a62f3a-ae05ae4d3bcmr116776866b.11.1750401906088; 
 Thu, 19 Jun 2025 23:45:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae054085405sm112888766b.97.2025.06.19.23.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 23:45:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D19DA5F876;
 Fri, 20 Jun 2025 07:45:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yiwei Zhang <zzyiwei@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PULL 12/17] virtio-gpu: support context init multiple timeline
In-Reply-To: <CAJ+hS_jUtitaeqYYxHN6q9ijqBu=Zyviid+EJc2sJ1yQLRxSDQ@mail.gmail.com>
 (Yiwei Zhang's message of "Thu, 19 Jun 2025 19:07:39 -0700")
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-13-alex.bennee@linaro.org>
 <d504e5de-cb7f-4eda-a046-9edef5d23749@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+hS_jUtitaeqYYxHN6q9ijqBu=Zyviid+EJc2sJ1yQLRxSDQ@mail.gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 20 Jun 2025 07:45:04 +0100
Message-ID: <877c16ud1r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Yiwei Zhang <zzyiwei@gmail.com> writes:

> On Sun, Jun 8, 2025 at 1:24=E2=80=AFAM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2025/06/06 1:26, Alex Benn=C3=A9e wrote:
>> > From: Yiwei Zhang <zzyiwei@gmail.com>
>> >
>> > Venus and later native contexts have their own fence context along with
>> > multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX in
>> > the flags must be dispatched to be created on the target context. Fence
>> > signaling also has to be handled on the specific timeline within that
>> > target context.
>> >
>> > Before this change, venus fencing is completely broken if the host
>> > driver doesn't support implicit fencing with external memory objects.
>> > Frames can go backwards along with random artifacts on screen if the
>> > host driver doesn't attach an implicit fence to the render target. The
>> > symptom could be hidden by certain guest wsi backend that waits on a
>> > venus native VkFence object for the actual payload with limited present
>> > modes or under special configs. e.g. x11 mailbox or xwayland.
>> >
>> > After this change, everything related to venus fencing starts making
>> > sense. Confirmed this via guest and host side perfetto tracing.
>> >
>> > Cc: qemu-stable@nongnu.org
>> > Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
>>
>> I suggest moving this in the front of the patch series to ease backporti=
ng.
>>
>> I also wonder if "[PULL 11/17] ui/gtk-gl-area: Remove extra draw call in
>> refresh" requires Cc: qemu-stable@nongnu.org. Fixing -display gtk,gl=3Don
>> for Wayland sounds as important as this patch.
>>
>> Regards,
>> Akihiko Odaki
>
> Hi Alex,
>
> +1 for Akihiko's point. I'm also curious when will the venus fix land
> in-tree?

We have a problem that there are two contradictory bugs - one that shows
up in the x86/kvm case and one in the aarch64/tcg case. Both are caused
by the weird lifetime semantics of the virgl resource vs QEMU memory
region and we haven't found a solution that solves both yet.

I'm currently busy with other stuff and need to do a sweep of my other
maintainer trees for 10.1. Once I've done that I'll have another go at
coming up with a solution unless someone else beats me to it.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

