Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3AFC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x64q7-0006E6-VX; Mon, 14 Sep 2026 07:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x64q6-0006DQ-T3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:27:10 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x64q4-0007vE-AE
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:27:10 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4aa8d882so1430762d50.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 04:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789385227; cv=none;
 d=google.com; s=arc-20260327;
 b=UjZilCFEXtgjArlFvH2Gj0ZUmc+b+mSb7Ma9m4aY7Jx+Zaqr1Uzv6re1UPbL5mndBD
 3QmubbDtV33kzPGUXX0GNfzwmLQtOiILmyXjndELS7rlJvzeeIfQmjHTiNI78Vv2Kc55
 BxdUK6lmyfgNh15X1kvBTSMAe2RrSFL0Yy5ipeD/rBJOXIjRRwrKuS7RslxDZrP85B3C
 TVZ1vomCT+mgmVtVwjSYJXOfdPrgZq8uB+7DgDhLjBksUt1VaJnDYgBQ+n9wOuh0NUjw
 21LdGQn4SNG/76BzUD2624Kx53+nOHUd9Wot6BlGcEzUI68fmm7w5KaA0dC2w61pOdRw
 f/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QQNw9jEF4RWvV57juX1m3+edMRoIpw5ThRRrmoNT37k=;
 fh=I4+9jBsawlEC6VYtYQWWbwhwDHCjIcQfIwimnV5OqlQ=;
 b=l5UfbVda/Ep7LQbJsp6UWYbzgKxX5HPe2cNavA+O9bqek0csZDlDyknqiolZzk9qC9
 tP3LAc3oOD5sZPpju4c+YzYhmu3u68KKYa7qFnceiD4ADYQ8xNS//BCL09kFPfCkVaQf
 +zokCB70eizWelmwky++wsGlNI0PXbwubnlBEiDCDRW2Mge8vS+U9El15p/RO8Sh39f1
 LJ8s08ekO65C6yR8pCBefs2WdPAuvWFq1WxK+0rtT4b5X0Wjm+YxvhrtOtIyyC2bUF6D
 bfisrudiegT8J1od6cVgRmi026IoJSWzWeh69yRKyUcepY1AXGHIIcTBww8pEBypGYij
 So/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789385227; x=1789990027; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QQNw9jEF4RWvV57juX1m3+edMRoIpw5ThRRrmoNT37k=;
 b=wBMcH21luBJj+7BARpU9LGjGLiUDqgAbAFKpTy5zHtwhpqdGTbk5OL6ZwFlukhvtGx
 4yRnqdITrRjdX7M+mgSQdtJ92K3F8pEz94H5Ov6tkkxouq4OE0JDPQVg7kl5E/W0VR+b
 2xwLpdTpWlezBuioRrqL1Vt+I+0HSs/ebepfEAmi/54xot9ZwZBqSqWjC8h6M6veNCqO
 HIgfTckMJcY1BJdbmSvDmBcTicfaVAOwwCo1B7/5IYCsxaKEXQXj+SsPtis4yEjpXaKv
 ZyILdKKxM9kvgRJ2mOC8DM9nzMMZbOswvhiAJp5Oa+MjtTAxFlvFzbB3X4kenlyLD7o/
 fqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789385227; x=1789990027;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QQNw9jEF4RWvV57juX1m3+edMRoIpw5ThRRrmoNT37k=;
 b=J9GF1U8mKnfuSAxijCM740ZphCIV4pH7tOhyrjGLyHCbTDoiUWum21g7Yn6why0lNU
 OWmLOmqCw8zL8SqMJtdhqnBfSNzNUK1dZWYPPLHRAaaJDNYkVyCIFhzD5ifGVgPtQUIY
 90c7af5G+BGdF46VBOfTGii7f12Hv9riUJviATOnbPjC9/0Ze/wcI5UKVpJcj5J4ADdH
 rCUgQFo5YiSeuezuqEaGgjpL6WzqilbLxdPpTUkhJTDEHAZkUX/PANkhZO8KV3h7I4jQ
 o7j5taSjij4f+3RAReKLbM+gf3w/2enoI5gUnAAeb868nYwcf3gTavU0QcQP0uc//nUn
 pw2A==
X-Gm-Message-State: AFuF++l6VaRxjGyre4Hi59BJqK+tVTptQTkz8ByTzdnmzd+sfJIaPKIZ
 xyeaFmi37pnQqKaIcb52vrSf4TTZV1Q2QlA5QDW1ws+rJHjqTvcZ5aBZSg8CiYrlTchFU5LG2eb
 wFSv0VDAHvEnw0cPnwtP1xT+ZX9g6Da7QkjEgcW+Rjg==
X-Gm-Gg: AYBFou1xe5pRCZ5QxCmSRVrQ85b+akhBQ7mMEqn2Ic/aYgfJCIW6Ykkvh7kU7r2SPOv
 FLiDVv+I8kTENoG78Ml0sTHrxtBpmmPeABDrc+QS+KcnuMFX9aF3S53W3qvoOIK4+AoHMUTMdpF
 43/spTe/4atvrcItzBJQp6ZAB9hX8ozaDAaZLK8Nw4+5ue0ZU92xh2sJB1S9M45cW05RBv4TMMb
 lHxekAIQdJbbvf7bcjnTYbyNeNatQspGqHHS1lxlnh/H1DYJCmzVh5rlfqo9eo3OltPV3TOe4En
 fvriMO4yGKxAnOf/iRmjC1Gsxsyl2xUZw0lbrxHf9gX0fZDVGc6pma/srNSmHcSPeCpPrdh2A20
 eQyV21fQ8yUplNIgeYp1orbKqMNnZ5sYroNN1o9o=
X-Received: by 2002:a05:690e:4419:b0:671:4b8f:e8f5 with SMTP id
 956f58d0204a3-6714dff9729mr275501d50.35.1789385227080; Mon, 14 Sep 2026
 04:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-4-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-4-2b21e63974f3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 12:26:55 +0100
X-Gm-Features: AcwNN1XW3MUngEO8Shspfe-7Zi7uvOVyTbxK8AJYJzUa824KrIy1alSeaQHFkxE
Message-ID: <CAFEAcA9ZHGY2Wj_8z9Vq01Oz+Dx8xtfh6H28FsYepAM4szogYA@mail.gmail.com>
Subject: Re: [PATCH 4/9] tests/launchupdate-test: correct g_auto usage
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Sun, 6 Sept 2026 at 09:54, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> g_free() isn't the appropriate way to release those types.
>
> Fixes: 0b70c6ce7b31 ("Add functional and unit tests for the vm-launch-upd=
ate device")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/launchupdate-test.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-t=
est.c
> index 225c843df5b9..ed007cdce29f 100644
> --- a/tests/qtest/launchupdate-test.c
> +++ b/tests/qtest/launchupdate-test.c
> @@ -192,8 +192,8 @@ static guint32 match_string(char *serial_f, const cha=
r *exp_out)
>  {
>      GError *error =3D NULL;
>      g_autofree gchar *f_contents =3D NULL;
> -    g_autofree GRegex *regex =3D NULL;
> -    g_autofree GMatchInfo *match_info =3D NULL;
> +    g_autoptr(GRegex) regex =3D NULL;
> +    g_autoptr(GMatchInfo) match_info =3D NULL;
>      gsize len;
>      guint32 count =3D 0;
>      gboolean ret;
> @@ -214,7 +214,6 @@ static guint32 match_string(char *serial_f, const cha=
r *exp_out)
>          g_match_info_next(match_info, &error);
>          count++;
>      }
> -    g_regex_unref(regex);
>      return count;
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

