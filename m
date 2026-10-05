Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6028CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDoHG-00052c-N4; Mon, 05 Oct 2026 15:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xDoH8-000523-1m
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:23:03 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xDoH6-0008BO-2K
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:23:01 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33e62211987so2903381eec.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 12:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791228177; cv=none;
 d=google.com; s=arc-20260327;
 b=Cx0neb+qlSdD2xcqbbrBlVMGLRyl9oB+GUmDOt/RZCgM1teOJ0xXkYu9t7sYwR5umU
 jFYvffzRVafxj6EAHuph30Y7mrIRm/EaOlKoPKnB21gmrPRJtuxkXAjg6hXg7f2OpU28
 VPTmbwjdw7ML2v3aGGvx1eEgiqYGSvtS2LV6iVDW3B8BwiVjaV0wVAQG0FlFO65oMz+g
 kw5ghIuokCAgWgk6bx+v6CxUFmPNPo88TrDDQKGJQDFtJCiCrMRaLwBDJCViMKSeyAkc
 4+dEAKlyv9epTNsopujMSpBspcGHjiE5UX86aa1kUt7wWwinKJdoqFn7xbLGXrfUAMlN
 QNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RfZ4fwkBD9UQ8QQfMknF4F3Gom+M5Nyf/AoKeV3gCRE=;
 fh=AOmT87DDS8N0CEkwahT4axSuyRBUxwHNKTrUvzIuHY4=;
 b=rHxg1+w8j/rwjuNF7KatuY3HyVHZTVIxnV83fK1WHngEtS5cLbvOVUjjzNvmx9/y7e
 VpVqCVg1g2IxVNdKqrDlXKpPihDYV7sRiRhSXXolO1SlHw7MSWezYHULRGo4ei7zEBQX
 g4QFVexVjWWAeu5zRZVi0MxFFFnhIYGELcRIJLK6WtmDVj9dIvDK57jAnLI7mc/BsznU
 qIhoVT3OX+Iqy6+zfRe4L0lRzPWmQ3FCvUuxjuYNkzCuPx612su17tkx8MHCdw+6r1dr
 /EhX6nivW7XkEg4KXNMy3mhJ0rmFWvZxr3w92K9oU3/rPQwVbF2GybwF6HT3b8c6/8dA
 DnLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791228177; x=1791832977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RfZ4fwkBD9UQ8QQfMknF4F3Gom+M5Nyf/AoKeV3gCRE=;
 b=XhEfF+sDQrNkm0l00w8FT6D60eEtHNKHfsWof/AFajR9gthXczfHefvB7kFPkTJPhm
 /Pm42yEaUv0B63jI7sGT789P0ZApD23KFN7nV0Rf09DZnbu+dja5YUJyD7COyLcSm5DQ
 XiLz9LwHfmormll8XVIw3nuyoEbmTo4+YcP5p4K6apnVfwvqSduMVKGiiEFb4XF4aMF8
 xexSlHygsBS58sJxrFfzMVhiAbc1mzV/bBGSCDFZUyZ4zELhO4fY+TEN8x64CKntU/58
 NalvKM/oWGG2fDcXeWeTsRduY6D2aYD4cg5/qxI14HKkA9iWor1uyiNG9FXu6cIVYGvW
 WBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791228177; x=1791832977;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RfZ4fwkBD9UQ8QQfMknF4F3Gom+M5Nyf/AoKeV3gCRE=;
 b=QlHNKas5YgaaasWlCGd/YSFTIvOyxjBf3/I1L0hkszv2aPEDBWmZ/9GQCztbDqbW4C
 OQwFuRy9QgsWSIwBHhZDK15EebsRoeflBYsbT2ZaOFqFTVbdbOJxLZzli63i28B1DDrj
 PZwm/I2WKLqz+4ZxWJjEy+u+qKMGF5tQM86CJiem9cgZt5qC4V8HrA3K9WefqOt1lI71
 +f1wAEVbThJcd+p2kkpcaJ/A8Z81v+KSewDwVpZsWN2273SkrK89XHYHUMROEUWkMuAO
 lcmoBYZL9fwcHdjVgDtylOlFveiFMPbTp2HfFi/EK8iAbVO9T8FwGDYdR/7mf9Vo1Bld
 zMFg==
X-Gm-Message-State: AFuF++kIy6B3AEje3SyNZlEbYwGiy4FAJ6JNm9TrreQhqgFpAmtxQ9DX
 5PsYN/ciQucsL550qQbIg0WbDreSxqRvnLcAv2j4Q9O7SO0aucEfEfW+0nKSCmGhRlYF3bKQliL
 ut9dvH9GAEeAf/Yf0pEHUOaEahXIPGRo=
X-Gm-Gg: AYBFou1x06mJ7L6RmLX3LYc2wuljmst2H3AXMrGlm3zmOtTQs5rEpOaZ4B/ujcB4r1S
 7tgBxo+n5US6VtRmMifh3mVE3WOlIvRqsBnVnII5k6PIB2WGRdoRyi8ce+XP6/YJWpwTn2czubr
 wMNvBVXRfbptPm8uwISa28gtjyH6W81BQDR5Tkpjqa7szRfsPregGnj8/19jLFFvERO5+G1yKLf
 iPwgKSRk/Tsraorf4NWHwzxBsQx5FbgqxVFGHYIaxSdHkSnzIBgeum6XRm+uES7zq+4DGks7Lev
 +5aJvO+Byc4aCxgqlvVn7lDQyCqEjN5eeGpwYdz2RWbVcAaT9P9mLTNgN+Xa3pMH54WQuy5Cho8
 2Qs59h0Irtb8=
X-Received: by 2002:a05:7301:9a90:b0:34b:d400:e999 with SMTP id
 5a478bee46e88-34f14f0b486mr14440204eec.5.1791228177200; Mon, 05 Oct 2026
 12:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20261005174522.8663-1-gurchetan.singh.foss@gmail.com>
In-Reply-To: <20261005174522.8663-1-gurchetan.singh.foss@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 5 Oct 2026 23:22:43 +0400
X-Gm-Features: AclHuK-IrKZR9vxJaZxlV7QI_ALT4bdF0sLIi4Fj_Kh1QNP20ZZLmd3P6K4Gl2c
Message-ID: <CAJ+F1C+zTWt878LjRHn7wXQWn3aW8UvWD=E15yBwc1DiGWSmUg@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu-rutabaga: make sure ctx_ids match
To: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Mon, Oct 5, 2026 at 11:00=E2=80=AFPM Gurchetan Singh
<gurchetan.singh.foss@gmail.com> wrote:
>
> The ctx_ids need to match as well as the ring ids for
> proper signaling.
>
> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxst=
ream")
> Signed-off-by: Gurchetan Singh <gurchetan.singh.foss@gmail.com>
> ---
>  hw/display/virtio-gpu-rutabaga.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rut=
abaga.c
> index 3aafa4dc66..edf7b62703 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -902,7 +902,8 @@ virtio_gpu_rutabaga_aio_cb(void *opaque)
>          }
>
>          if (signaled_ctx_specific &&
> -           (cmd->cmd_hdr.ring_idx !=3D fence_data.ring_idx)) {
> +           ((cmd->cmd_hdr.ctx_id !=3D fence_data.ctx_id) ||
> +           (cmd->cmd_hdr.ring_idx !=3D fence_data.ring_idx))) {
>              continue;
>          }

lgtm

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


btw Gurchetan, do you remember why virtio-gpu-pci-rutabaga.c is using
raw TypeInfo, and not VirtioPCIDeviceTypeInfo? Is it just an
oversight? I can send a patch if it's the case


thanks
>
> --
> 2.55.0
>
>

