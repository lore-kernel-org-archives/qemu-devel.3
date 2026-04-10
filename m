Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE00F459F8
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEvr-00040q-Rb; Fri, 10 Apr 2026 12:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wBEvh-00040I-MK
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:42:06 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wBEvg-00039n-4n
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:42:01 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso468226c88.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 09:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775839318; cv=none;
 d=google.com; s=arc-20240605;
 b=AdaZm1RCn8IdyyCOO3pKYj1DxavX/jBqOmoBwFvb9bs9sp9sdctJCQb+IDnnY++qph
 swYk1CALT2afJS8FfY3qCp0PJiJx+vzAECogJLUUpqkY5DLiniOkhOBhsc5LNYQs9mYj
 JFNiRxZ8lqALxmASMjgYb0mS9sUPT7RZv47RmrJ1c2Aa6gK4rArHXsOP3Z4niG2HQ46C
 YMbsnwOI5lN/OHL+gcAIaXxGvAGSlbXu8ryh/s03VvDU37B8gUghhugF1fJt1lVRA2S4
 q+djgF461s6NbC5Ri3ZtTGoWQb7MZCJubVzJjyuEpBP/g3SU+avCOAzYPGEP3vLpfudQ
 eRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bvesXMpz50kHTUEcp/X0NnnqvOyncblvdLWc0DfGMwU=;
 fh=1U4GF0oLWQ/Y6af78tK/MyKxzL//5ocgILtxHMzYyAA=;
 b=LnTcMYdmTPrnqmheCGJXtD9BmXsx2P96uuWIBCilGcVCwdkspLXWCvTaNubBlapCwe
 KGicipo/prifECJLLWvaMfRRbKgf+pExAQVgYJ/O5wYFe69QhEWMQEWbascDEAFLHd/+
 hNe96BMNb7bJLL/+o8FHr1WG6g2C3xvK0wBMFxvyAbLwDi+h+AgWSf6q/Axcv1ArVFSt
 aZJ9y+GGzCBCW3StkWKRLL+K7yvCsAFHXv9MoAo7ZcdNwRvGdUahpVCXwu92eY5edZ1A
 RU6QzRCOpNxg+LroKh7lSFfeuVuvMQFSrC44jxwGt7kb6J44Y4CoooxQN6l4zuI09RDX
 FeIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775839318; x=1776444118; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvesXMpz50kHTUEcp/X0NnnqvOyncblvdLWc0DfGMwU=;
 b=mDlrLiX8xqNrWSE86+tRXVg1IiZSqTOagg/c9STeM1i8DLWl681Gipwpqz98MNHFw2
 Tv5T05TvTFp8rWu8VS87sZ04UVajThi1hU3M2EBbMtxW80SZxq92yh4H42ZzFUeGgHfK
 YWJwUxgnFbesN75CitNOFzYT7RNk9ep5Ccqv4dF9vUgt2v9tHfM92T0aDLtxVXe7z3EZ
 j90KZ9vA+wZy7eSjaLwYNeIJgh9XeAkxaX1gJiCeUOtKEkhk8yXJRllv7rRgo+eEcyz7
 6qBGBSns/T7vJL+YAyfDX+BY2D1nBc7kfM2kH6A6o9YSDLxxsBSyFTS47EHyCK7E4yiu
 /TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775839318; x=1776444118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bvesXMpz50kHTUEcp/X0NnnqvOyncblvdLWc0DfGMwU=;
 b=Hc42ym23CFMyJyHMQVtz83nQzIHfUQdGDrpDx6l2HDQu5AiXEmg5hStxm9xXmDPeeI
 Ou123f7UJE2MKEKMQKDbNbEyeBl70jB4OCH8KL1DInjw8uIXv4jcYHIF6HEe1Mtl2Rwq
 9NJIU4B+DCHC9EwX9+wZXYLjkKB5X34eIeHR9EH+MIlfBK+Qi4zrnA2U0lLFMhMCTIvw
 kED93U9WteXdtzsDe4EK5sU3DTviz8vVJQdUVzY7USRCFxp44CMga6Vm9N7eEEiMIVG9
 BpvtH2PFDaqL6hdJh5QdETlZZaJ8gbYR3BLP92du2EVK2k3eubyCWS7wkF+1kwxHpwLx
 M0/A==
X-Gm-Message-State: AOJu0YzJ5AfQwKLJHJIcwizjnDtGWdy0m+/djlgFwKafbkJZw7sDEXr3
 C+gntIh584DZs0/WR3MYNEpvC3Uo+UUi+IS/r4FlZYe4VjMSigffjxNnGufeSxZfhPWBTToBElo
 2we3Y7VRKps9h86dW1rJQY8Kjsq7Y8PU=
X-Gm-Gg: AeBDievIRxTqkqF3nCZvSZwLHP1b4uOLQlETVB6Kk+msNTDM7M9dJI8Lrk9PsNm29pO
 jAYcHgqzfUf/SnalSOwtaZAhZX3s5/86cSZb5Ee7rVTKFRygSOSejVlEkdL9okeYPOfOkK26RKY
 TiS/u9zAo0IuzX4A+N9iFHQPk0guIfSCQr/av+9KMNq7lQ6YgKEGSK0mm9UuCb4Quon5Otbd0+D
 9cHq97sDWn6rNy8Ar2r/yR6FZ+JBln5vz46osPb1nXmePYRore9uKZvXZ9jaotLRCJMVTsbT47I
 ruCA8XmvTxH8HZKIfbBCjfy5+Bxoevi6JbGZKrJ3
X-Received: by 2002:a05:7022:670a:b0:128:d714:3ca1 with SMTP id
 a92af1059eb24-12c34e39792mr2512772c88.5.1775839317658; Fri, 10 Apr 2026
 09:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260410151818.817298-1-development@knutsson.it>
In-Reply-To: <20260410151818.817298-1-development@knutsson.it>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 10 Apr 2026 20:41:44 +0400
X-Gm-Features: AQROBzBkj661Jq2vxSVu87bi6ZXY6BIVNSDYmE7csTJhBL2RgVjGr9aBeScvi78
Message-ID: <CAJ+F1CKyO_bLi7R01EE1qYG0fkKPcdT1a9pU329xutBT5bC3Vw@mail.gmail.com>
Subject: Re: [PATCH] monitor: fix missing spaces in screendump help text
To: Brian Knutsson <development@knutsson.it>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x1234.google.com
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

On Fri, Apr 10, 2026 at 8:24=E2=80=AFPM Brian Knutsson <development@knutsso=
n.it> wrote:
>
> From: Knutsson Development <development@knutsson.it>
>
> Signed-off-by: Knutsson Development <development@knutsson.it>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hmp-commands.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 5cc4788f12..b6f3b8a796 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -257,8 +257,8 @@ ERST
>          .name       =3D "screendump",
>          .args_type  =3D "filename:F,format:-fs,device:s?,head:i?",
>          .params     =3D "filename [-f format] [device [head]]",
> -        .help       =3D "save screen from head 'head' of display device =
'device'"
> -                      "in specified format 'format' as image 'filename'.=
"
> +        .help       =3D "save screen from head 'head' of display device =
'device' "
> +                      "in specified format 'format' as image 'filename'.=
 "
>                        "Currently only 'png' and 'ppm' formats are suppor=
ted.",
>           .cmd        =3D hmp_screendump,
>          .coroutine  =3D true,
> --
> 2.48.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

