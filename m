Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0454B105A576
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0e5G-0005H4-L1; Thu, 12 Mar 2026 07:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0e51-0005F7-JF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:19:55 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0e4x-0008Gm-OB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:19:49 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ae222d87dso871738d50.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:19:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773314383; cv=none;
 d=google.com; s=arc-20240605;
 b=GGo87wIOxJGFUhMHXqsuQ299vO2SXuqhs3h79Fl4v0/yV59m5ay2ezE7GnkP9LzxLV
 gJlH69e7S+FVNRoQwIs/BuckiaFfTWKIIaYkIEx+aPxosyMm2X8sMtiaO1z4lhGINPzF
 B9Ep90HhfeZC1Qj/TQPvZigSg03Ok+Uc2VCh54A/hqZTV74AIS4ttJLvFtVeK0oVaKNS
 OP3LUBoIokHwvmmeB7v8Lc6sJ1Aut5LJuly6ccyHbq8OJSzOAYpa4L7ygclvbwvFdW8y
 cshKu4C4YMubnnxQjnbbKrXi54CqaaBCS3n2tZWQMo+NpzsfMVf9Od7/RH+5Rv/bRdh7
 BYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y0ndm38Hfc6P244KmaANtEWaewMlw0ZHU6ItMefL2/M=;
 fh=NEkeLBU4xrEYSilSUfi2Eubk7SfF1cYgH0xZKrW3IVE=;
 b=X5+kfuz3bGaLMl2fqAcdMR++AP4a+IILJPq/X/OnDNOUz14mMdCmDAseLwia7Yj6YB
 ezCG4XvP++ZSpJaa04pIMnQ3FiNpk9MQ/+Iv2UePu0S7NOaWE7DR//f/n2RHEuCZ29eH
 9dC7Dtq0Y40UU/h/GnhXNes1RkUkA3zub7oblrWxQ5gsbvaaMXo9qj/Wjts1Y/pL7spG
 gTDGr5ty4QJIyvoapSVUu2FIC6SlZvYvJpieWU48TBU9HyDNu10Bzbex0xpU+U6YZEae
 ls8GxjTjrsvKtLDzuuPYN5JIrgbd61iWsATAmlWd/Rr99F1R0TD6TAB2gWrVh2Xp9LTE
 FdtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773314383; x=1773919183; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y0ndm38Hfc6P244KmaANtEWaewMlw0ZHU6ItMefL2/M=;
 b=PjNdxVz8ncilhd+K9e2/Fk/mtCSgNzlOBYVhPqkx/MrUw0BVeRvGCxkKdG/IqJGmqJ
 nLBpiHTkpALfng7THGd5OkfGw0MwU/7yqtWZn+7QjZqWeWq2pws0dfic72kRpcOyBJEH
 AwUaB7/ei9+e7e7wIfWhGW1nfcFIpSBa+Gy5QJIg1ok9pQ33tXsXUWmWiAVCuFf3hJqN
 ntNDYxilErQ0D3xP7nVBjiSdbZo9uxFFja9h2zzgat2gahUrml3L5drntSxjXyMFUziK
 J9Fs8UFmATQygqjzCgxdwgTKsAkbLjyHKWHunZcDymdDPUpJ3uLGvsGk5+LQaLjQQ5sM
 +j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773314383; x=1773919183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0ndm38Hfc6P244KmaANtEWaewMlw0ZHU6ItMefL2/M=;
 b=BAh68V2Sn1+gKhoNbqBwHMNwBlAemDZhIbwCAi8HTFxTlJqSxTm9zgQOqAUzpXE5Cz
 lVnpc8gcNf2sSC5IZH3uqJQ1PNDX2PyGgMw9eYo6SNE83k/lTdhYuuws30WN16ICbglp
 9yiTEPehKxjV5mWqOsnYwpbg8hZ4PhQj6NdGdQQgbxfp1f+L3cs3T9JIGomQonSMnNv+
 Y/eLU3Cpeo0c+8OhUAcsLjZlI/8xzkdm+k6pX+eihL31TpYHsTBoyxS0m/AIJrbTPtHh
 E2GXiGPCdYIj9ge8AwIBrqQRdkSC3CG6MhjUfGUJ4Z5ljTiYdl5zMjO6IKhGQacMrFC9
 b72w==
X-Gm-Message-State: AOJu0YyDiUBjlWWY0VhsdnK7u1dA5ixkiwJj45QFmXtamepOAKUticme
 FEsgduR3AC+BCYLQXlso/SG//8scHe9TOKgoia3dc+zEF5wL6oB23MKwrpZ4htMKHa0ZSvxgHZI
 LjHJ9P1RZvfe0zBz6uSq3bEbQpEqZbWv04oWfOp6E3A==
X-Gm-Gg: ATEYQzxHZqbFC73O3QO28+/yzfDIEja84IFjkC+r+8IHBZW71oErAKanz6O68Eokr9j
 tW/KCdArxL/hqZ/etGdgt0rlq1ayUdCvI/jTbA5fQC6mY+l7mcSdL7f8o7kE9zfaZss0dPiJdGh
 2bcmawabAE9JYIYVsSiJAog9d5xE7vpGVxYVny/EoJJKq8pbzXvgnnbCtfqBO97OH8mfG7e6x7M
 PidCw1JqwZRK+lyBPCuTfcwgAdhhopI4aQA40B1aH+vHNMoUdfKPFOqPAFwy4R8BGVRdj6AGSGO
 /X4v1+JCdiXigu2C1mGGmkEEstzakHBTQtdRrxDbRcnOSW9r9shSQrRUUDg6HUIegng=
X-Received: by 2002:a05:690e:1768:b0:649:b535:46ab with SMTP id
 956f58d0204a3-64d657ab568mr3790633d50.49.1773314382948; Thu, 12 Mar 2026
 04:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260312102626.891359-1-dtalexundeer@yandex-team.ru>
In-Reply-To: <20260312102626.891359-1-dtalexundeer@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 11:19:30 +0000
X-Gm-Features: AaiRm51Ud4VUVLi1mQx7Cc-pZqIZvIp7JVNFbh37q8y_uKCxwEn3LzpO97lrA3w
Message-ID: <CAFEAcA_mzXDdz_xjPnZ9Kc4K01Aoss_OH_qEoL3G33KdsnHrLw@mail.gmail.com>
Subject: Re: [PATCH v3] vmstate: fix subsection load name check
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 12 Mar 2026 at 10:26, Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
>
> When loading a subset, its name is checked for the parent prefix. The
> following bug may occur here:
>
> Let's say there is a vmstate named "virtio-blk", it has a subsection
> named "virtio-blk/subsection", and it also has another vmstate named
> "virtio" in the fields.
> Then, during the migration, when trying to load this subsection for
> "virtio", the prefix condition will pass for "virtio-blk/subsection" and
> then the migration will break, because this vmstate does not have such a
> subsection.
>
> In other words, if a field inside vmstate1 is set via vmstate2 with a
> name that is a prefix of the parent vmstate, then the field can "steal"
> a subsection belonging to the parent state.
>
> Looks like it happens because migration stream for "virtio-blk" looks
> like this:
>
>  [virtio-blk header] [virtio-blk fields] [virtio-blk subsections]
>
> "virtio-blk" contains "virtio" field, so migration stream is:
>
>  [virtio-blk header] [virtio header] [virtio fields] [virtio
> subsections] [virtio-blk subsections]
>
> And when we load the subsections of the "virtio" device,
> vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if
> this is his subsection. This is where we encounter an error.
>
> Thus, the error occurs due to the fact that vmsd does not know how many
> subsections it has when loading (this does not appear anywhere in the
> migration stream), so it tries to load all the appropriate ones by
> names.
>
> To fix this issue, we call vmstate_get_subsection() and, in case of
> fail, ignore it, pop the VMSD stack and will try to define this
> subsection for outer VMSD
>
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  migration/vmstate.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 4d28364f7b..8f3a69c26e 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -639,9 +639,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>          sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
>          if (sub_vmsd == NULL) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
> -            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
> -                       idstr, vmsd->name);
> -            return -ENOENT;
> +            return 0;
>          }

Does this result in a less useful error message for the case
where the source sent us a non-existent subsection ? What do
we report once this patch is applied ?

-- PMM

