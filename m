Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6791CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4Rh-000192-3N; Wed, 14 Oct 2026 15:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1xH4Rd-00016o-Kh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:15:21 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1xH4Rb-0006wI-Px
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:15:21 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b21cf1a580so632198a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792005318; cv=none;
 d=google.com; s=arc-20260327;
 b=PW4MrWTFUAXPvw2p4UbR9Y7yuL795JMUyCWRRqN2FX50ro6qYkEnIQYRGX3OK003OR
 26rpSvQShy6KgtTjSw7hqh8PexKqypnqNl3ZL03Qrd1y7ECT8QlaEz1A++cI46XWz2qp
 wGzWzlmaYRO+beY954Q3Jb/JLBv8QJP5bawfmGD0USNPKrGH26roH7EiMZKg6+jXfJuo
 7yKvga9AOP7+aOvsJhA1iLt5PSftiM7qAPpMB94N5E815OLDeOKOZi0XKxuEGsz5fk67
 eotAU8/5boXcvm2h2qzZm5TMEcnpOP5/VxLLlNwj0uRCGLnBwIx+lZ5w+yX0ocupxVUZ
 NDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iJwsU3DSWMSAEUMGoaY5e8Z8852YYBGGFIxBQQdbwsM=;
 fh=k11KUkLgAOGvS4V5HW2l4+9WJIsYPCgOmmamG6KNJDY=;
 b=VxfAWaA5W5Hcb6pza8if4DVndvmzrqtqpQedeoDkcXj1EEAaWrq60VebRPPcy27g7B
 yUKp+/JtSWPoIALlhDEbpbFlO/GwUgWNUmm5NNQKK8AANO1amHry1Fh+57QGkB6JafbJ
 77pXWgVxIVsK7Y7+rNOa+LHK8+tBOeZN8y9DkBPsdEF0L9wio80K0ZMCfq/kx1FFy5x4
 GOXK5wUvX7VRcB4qQhjSd0nwtD9WL04QTrk0Dcgq6NBvvzoNluunO697TL82KL3ZArYz
 LMltwJ476pzgbXfCftTx6kfPvpvjf1ZDpSkyqyePs6Rjj1tVBVO2rizP4FTTxR3aKNMC
 Xi9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792005318; x=1792610118; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iJwsU3DSWMSAEUMGoaY5e8Z8852YYBGGFIxBQQdbwsM=;
 b=KQWUhjg4g/HshGNTctxXiBEyOCz7+AOGkR1LlZQZSFcnZ1wJr3VlmCgPLtZfGgdAbd
 kZaE5l9BaBGvrQo51zrB+DEVhaNiHk7JB+xqwBitpQZfH8P2kpGPYfDAOQjsFO/OHdZE
 q24aa020JBQMtWMjdkXQHgoZeJDOrPHwfNoqTmSexRwdEFaH25z9SaaHll/7znaOwDoZ
 oLtP7uXep3nzuNnj7aqQyylneEM2T8dvx/P0qTkp8te1S0d1U4UpXBiOQFrSmEeSif4N
 8n2KnwGspwW/wDiybiaFqqpj2i3e7H4h1deFkABwE2HpObcITPE3XuH668Y7jefp9C9/
 zTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792005318; x=1792610118;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iJwsU3DSWMSAEUMGoaY5e8Z8852YYBGGFIxBQQdbwsM=;
 b=VTOej/xT1tmdejf+JxcL3JOGUHXtBRoq0uEdLlUW1gpHhUdyX4DAHWErCNm4auCZ75
 71Kd+WU4mkJsogdlVfj4RfsaGqCLaLIXdkokeBXPOOA5vVCwXqXNJDhSwZbPQzfCdf1O
 0vf3lg9HqsoJ+goq8JBzScifInAB7+bbJkO3c0miMy7hLSwpGrgmNgjcEEjIt0kurUkz
 JtmfZERIRGNK7ZUwe5bf4fqT5gWXhnNGhey0aTlkzRRcx3mDyE/3PUwWDG9ZmIVn1DkS
 JjsAa5uvcmCHeRSiq/TF8D5TDVyyw3wQsQrh3v3shxampdCJBQ17hoZ8YvStPs7HqpKx
 Dfag==
X-Gm-Message-State: AFq9FYJ4SlpsCtE2LfX7xHCDE/xYRjpGyFy8TvDUY75RbIMqigemlXk9
 5vIIchTxz5T6kUN4Y56VAaaXfa1I203qkzxf9c5nDL53ddW6a35Y6HR5w4jCYT13YsmjsLKuuhp
 9fCZmadycAJW0AURIPKaInv96/+I5voc=
X-Gm-Gg: AYBFou0Z8S4yr+NszwZdQtNv88X1Oh/G+fMSqfm5X1arRwidt0NbwR3vqgfhWF4n1Sg
 bhQWpzjpOzqPXVhXvg5gbiGvlYCDAFC+cp4877XsJnEc2VzJYvWs9YiV0qUrcoSRYV16Mo4LCww
 3NSlNS4O4BttHFv1+i2ST+K0OBJNYfY+Ch0Rk8ph7fYhiNTcmVEB+3BC+GInOJzyJRTswe4GHVQ
 K/xSXKw08arprXVsjUjXFw3mN/1wWfCIZBGaPLVvDK99M/oRFjeHGZVFj424wbHPcUxG9gSvP2K
 nQ3CvC5J3BfB3ha7brxsJ+sBGyW5gpiEdEatOLMKlcehlcRx5ENH693+zLt6fMGXYJZv41rtebM
 nN7+svju367Cc
X-Received: by 2002:a05:6402:3244:b0:6b1:c43c:c2f2 with SMTP id
 4fb4d7f45d1cf-6b1c43cca4emr5817874a12.1.1792005317513; Wed, 14 Oct 2026
 12:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261014144227.1357644-1-stefanha@redhat.com>
In-Reply-To: <20261014144227.1357644-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 14 Oct 2026 15:15:05 -0400
X-Gm-Features: AclHuK8hXNC6Nk0exGiZ2tVhmNor6CYSsDuKTTR36Om3BCuSk6kB0X4LHILCEyk
Message-ID: <CAJSP0QXn=vCbq6sG04xhdy8xmzBinSszuGrLsi3e3Cj5w0grhg@mail.gmail.com>
Subject: Re: [PULL] dmg: avoid out-of-bounds memory load in
 dmg_read_mish_block()
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
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

On Wed, Oct 14, 2026 at 10:42=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> dmg_read_mish_block() loads from memory beyond the end of the buffer
> when count is less than 4.
>
> There is no known security impact here because dmg_read_mish_block()
> returns almost immediately without any opportunity to gain control of
> execution or cause other damage. A crash will not happen because it's a
> 32-bit load from a memory address that was just heap allocated. The
> address will be properly aligned and will not span a page of memory.
>
> Reported-by: router0mail <https://gitlab.com/router0mail>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Message-id: 20261013193710.1311621-1-stefanha@redhat.com
> Fixes: 7aee37b93a4f ("block/dmg: process a buffer instead of reading ints=
")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4569
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/dmg.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Please ignore. I will resend this as a proper signed block pull request.

Stefan

>
> diff --git a/block/dmg.c b/block/dmg.c
> index 5d7d3b8901f..412d4bfc354 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -226,9 +226,13 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgH=
eaderState *ds,
>      uint64_t in_offset =3D ds->data_fork_offset;
>      uint64_t out_offset;
>
> +    if (count < 244) {
> +        return 0; /* too small, skip silently */
> +    }
> +
>      type =3D buff_read_uint32(buffer, offset);
> -    /* skip data that is not a valid MISH block (invalid magic or too sm=
all) */
> -    if (type !=3D 0x6d697368 || count < 244) {
> +    /* skip data that is not a valid MISH block (invalid magic) */
> +    if (type !=3D 0x6d697368) {
>          /* assume success for now */
>          return 0;
>      }
> --
> 2.56.0
>
>

