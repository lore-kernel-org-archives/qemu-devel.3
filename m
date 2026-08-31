Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6DBC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rH5-0000Dx-7W; Sun, 30 Aug 2026 21:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rH3-0000Cz-MQ
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 21:57:25 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rH1-0004vy-2x
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 21:57:25 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66e63c2c9e1so910809d50.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 18:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788141441; cv=none;
 d=google.com; s=arc-20260327;
 b=sR7P+dhhT2CPUbVrqFLKWFH9g9rfwLkeu1sig6nLVlgLw+ayAcfBdcVyVqNyWKT6Tt
 AXiBfj5NOdLiuwbPbXYpv562cptVKjaTp8wvAq+VVdQVXDmCvvhWiWeLeIujpxfM7DKm
 NYrnEddOTg/0/eoLALmba2iFH9Rh2y0BhJKWt13C7IZd6Qdb9cHYPEb7YvHBwKbQQIEJ
 CN2W4gC5hJYHPM5q1dGF82PrtYdChwGwAW2P1XijYEiLsQ3JV148Nz81o7ZgL6qmHEQS
 fZBT3TaRAcBSVgp1rQ+Uqlj5ap92ly5Uosrs+E2CHocPHLcDOtwFP+oaDIJMjz62qhpO
 6Q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EHWkIpJjbvCM8i9EVzGkfSqsE5M0tKBuD6Cyeoh+D9k=;
 fh=kZ4oTAT93UVohyFkSRyiFjTUHt11KIet+HJfYvTK4ek=;
 b=EyIFRhevLsyIIC1s5dcBVenEXA4HC8iKq2ndrbN2COZAS1ENUlrkYcg/BD7rwbxZyS
 cOuJJhZ9zJh1nbeUJ7e2a9tlUHeYcMf2IJmVYBGYZBSoAm+HWttRCuylwXjDy5LYKj6P
 XrqHsiWRVMYNHkJh/ulCA5MZsF5nLJLXGIy5xkOLWRk/rYCgQ4uxJPe9dENQWyEuEs2p
 8VGd9vW5r1berf7u+AWuHSGX4nx/hFMGSAnemuyUPEYOCKjFqbt3pt9DkX1wGuEQC8qS
 5varmcxVIp4PtKi3kTtW4ijHoTxkTsbX1Fx46QFkrnkgJISy0NhKpyKx9GWrNX0V1h3i
 At7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1788141441; x=1788746241; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EHWkIpJjbvCM8i9EVzGkfSqsE5M0tKBuD6Cyeoh+D9k=;
 b=VA6vrHTo0E6Aq2xSYI9ZWN3i6pD0uDiud1GTQB8KTWYa0Ka3YDsFNBLwOo+Dex8MFk
 mMVeNTol3NKG30s/MnE6zwqvmuKaxiWqWdL+eLoQAmQmIPBlQXMkk8/m0OxxxmbeQKLU
 QLNqV/QVg6U79gMFR5yF+HiL4h36SgQNBSxT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788141441; x=1788746241;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EHWkIpJjbvCM8i9EVzGkfSqsE5M0tKBuD6Cyeoh+D9k=;
 b=hs3NhFgdACKAt9wSccc35N2SgQ5OiuyT/5YYSY56Q5BY38+ayVw2dCv2xJaH2m0C7x
 JP84ld8SJ62yiOkKlgD+zLW2kQjitfbu4vhpaqCeInLS3LE5Yaa0bJLvRHyNXfol2t/+
 2FM7qE2UxIvFuUYT8wo83qT2nGsz1mKY2WSP3WXfcJf/jWEhjtIdnSzY+RW8GDc/zRHk
 sRd/C326hwSl9bEApO/uqll08Su/UWZS9cTkeau+50DORQuAweRCiHmW9IU6hd/Huo8O
 NQe1GsGlBIM8fF7SWofwHM9fV1top0x2eHAGYtuXcLifW3FW1Ts0BIt+qHCrkk3bdzGy
 ey6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgn1HIK6SGTLxbjmLtxw3eABL9tiyxLzjFS8tWZkMqP78iLuXa/FobdJ+m/lvvD49l5wMI1a78Q5Yq@nongnu.org
X-Gm-Message-State: AFuF++l1mh9PjsGnbC0JZkDy5p4/VruszY1EdQASx0UXbynVMVnl10Lf
 SjqeHD1tjosWCarsHk2qgKlSTOQkSNkT+dGN68pLnsvgsYWtnB5JX2YtojtoD50Idv+6NcUwhzW
 y0BEiRjVHm2ryvBgiFIG74LHg1sT/TCA=
X-Gm-Gg: AYBFou1hM0pJbg3PUeltBOzZKhehEOkh2VhbXA6Se5Tk8c+72oNe01sd+X6Jgyn6Ao1
 bytcVOi/gBZD3/xDeuZZ3i5kaA4iZFmpl1mb+FdENTaEFp9nnebK2cRWynY30hzBZk6EY+yzCY8
 sdpwK2SbOSBpom0xYWk1KghRGRRYltrgYN0iNU9lIYB31UqOuly+luJcfB0x0nZjioWbDKl/cJ0
 jB5/AqVfLDfyyeSf7Ss+fGe18yRPaHLLutpS+dt/cAAJsknmjzK+okajQYkvNUnyuuqiv377AS8
 kpifmKTqCH1vvgeRW7XWfXPHVX/iMi/+xoMGwm+pPkV9+5iiL9qNxaCdtlzqIDolQN/17CHYr0V
 3JtCjdoUXBWZUzbJvi0LOWgJPXTCxlwTKaMg1VWKlhxd3wKAHSrvTnJvYnyubDPwnO9XgAlNgA1
 8pg2zdzHOfg397WQWi
X-Received: by 2002:a05:690e:dcc:b0:66f:7717:a6f0 with SMTP id
 956f58d0204a3-66f7717ad33mr1396300d50.9.1788141441358; Sun, 30 Aug 2026
 18:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826221154.54577-1-joel@jms.id.au>
 <20260826221154.54577-6-joel@jms.id.au>
 <be675569-27ef-46cf-82bf-563852bbe66e@oss.qualcomm.com>
In-Reply-To: <be675569-27ef-46cf-82bf-563852bbe66e@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 31 Aug 2026 11:27:10 +0930
X-Gm-Features: AcwNN1X53eB0-VFKX1pK9bXW42LA3jchxcdYCgFmZq25_dYfGj50ql1BNvrUmys
Message-ID: <CACPK8XczvftDPUVb=2pX9ofRNA31jhLopeFPse-o6s7h27BVuQ@mail.gmail.com>
Subject: Re: [PATCH 14/16] hw/riscv: Add property to hart to allow private
 memory
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb12b.google.com
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

On Thu, 27 Aug 2026 at 21:48, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> On 8/26/2026 7:11 PM, Joel Stanley wrote:
> > From: Portia Stephens <portias@oss.tenstorrent.com>
> >
> > There are platforms where CPUs have different mapping of system memory.
> > The global system memory does not allow for this. This adds an optional
> > property to assign a specific memory region to a hart. This allows for a
> > machine to alias the hart's memory to system memory while the hart only
> > views memory from its own memory region.
>
> LGTM but please clarify in the commit msg that the memory region is being
> assigned to the hart array, not "to a hart".

From the machine side you're right, but I agree with the commit
message that the memory region assigned to the hart. The property is
being set on the individual hart, not on the array:

    /* Use private memory instead of system_memory if provided */
    if (s->memory) {
        object_property_set_link(OBJECT(&s->harts[idx]), "memory",
                                 OBJECT(s->memory), &error_abort);
    }

How about:

"This adds an optional property on the hart array to assign a specific
memory region. The array passes the region to each hart it creates,
so a machine can alias the harts' memory to system memory, while
the harts view memory from their own memory region."


>
> E.g.:
>
> "(...) This adds an optional property to assign a specific memory region to the
>   hart array. This allows for a machine to alias the array's memory to
>   system memory while the array only views memory from its own memory region."
>
>
> With the commit msg change:
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

