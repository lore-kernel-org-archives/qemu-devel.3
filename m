Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA98CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 11:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRTlS-0001VD-Bp; Mon, 25 May 2026 07:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wRTl5-0001UK-5O
 for qemu-devel@nongnu.org; Mon, 25 May 2026 07:46:11 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wRTl3-0001Cn-KO
 for qemu-devel@nongnu.org; Mon, 25 May 2026 07:46:10 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bd6460b0d11so1671607666b.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 04:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779709567; cv=none;
 d=google.com; s=arc-20240605;
 b=TQ8a6nSlN+ydm2iD5l1k5BwhNdR6TlqzIqFOmdWCVvtjJRh7QGJdZw8ynW/u/pJN88
 cBOZcgVpuGN92olg7Qu63hpeQl89rmIf5ZybWA07s6wA9Zvv9tLB1SO5vpR5Zoy16iUc
 D3im3guRa5jOeBOcZzx34eV9oI9Cz+ZLWHUfEyPkHol0hKAqeAbemMxaAJ3CZo+Qx5Jx
 AwsygrEU/iu6fUX5bHLWhTmTKrc+45rLgEbmBkhr86Kmpyk42Kh2Yg3PDEjEKYc7rE7p
 Yg380G24GnHRJNJGGFW2Mm7pB1Lg2P7h/k6uy1CKvHR52Adv5wJMdIyf8DfzVOfTmQS2
 i+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UfG4bsPoO0gVIYDhkQpli7FG8eRfL6sVO6+/+eOZMKw=;
 fh=Kh7guUmA4KG1z1gdEndCtQd6ySyUyQE1cJ/ICDW5GS4=;
 b=ZnFkPMBrLnjzwPEkgAvZOFUrBul1ZNcyJ58NfRxihU/3rwxBFNh5slkQrtnMo2De4r
 NpFRIDJrPysK8/IPWEVkmuDkwCHSDjHhj5pq2Q5jWvzrsR1x2/Wr0cfX1gzlS4mFjNam
 e6tADABcI/QhBPOtkU3bnQK8gBxFrPYDc1pFWVPo4p1sjYK6PytfG+eiQ8sku/xYb6O1
 zeysVYdIgRVu5/IwS74KqBjrajVZAbxcbtg7J64l7OSEZweYWffOdTViMyCII2m02iB9
 uh/YyseX7RHZFVt+c6EJTgSSYmgnY05xRno1hvUe+THNiGFf+xPMKhf+1GSuWg99ka3j
 StOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779709567; x=1780314367; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfG4bsPoO0gVIYDhkQpli7FG8eRfL6sVO6+/+eOZMKw=;
 b=T14b6wKJyy0wxdC5g6JcOZhH0gCKcnoxSfoS2ZANdh0qbNECHVcvjjRPGNThg6MU6m
 v0d8p44Ta/K2DX7RqioGs2Z59HsN5fZheBXqZ57qjACyv4pMlgnUTjolQxzwqYsVVUnb
 2f7ec1QlXCAo++eX3nXwrw1n8Xb0OQvA6LCTiKHplxPmLUuGONoEPzJtf/HNqQYKS1lm
 gEYQqIu8E0OtOSLddY505Uof9Z+IQslJQSP2+Uiz90CUoFMKwUkeP0ckEWJqzSjfIKab
 6iihRyK5QSQMBQnZKX9R+4VbZJfYxu4db/sacQtYvMpkCcmw30QZwyodGlNIpKygjsZX
 MtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779709567; x=1780314367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UfG4bsPoO0gVIYDhkQpli7FG8eRfL6sVO6+/+eOZMKw=;
 b=AJYM9pgZRJWswucTMMTnHs/pJpAv2xcuZIAz4fj8Nnv1HFbKkOeU0PdF42Q3Nj2CYs
 phSDHno3k9ldJgH0kOB+NxMim7U6QcBdxDJLLK0yjZIaeLJmc/6dvI5U85m9RVvRmio7
 OSaCaruhrN8SMB3GVJbQkA+aDtl9ybVt83UFGRaL5cZO8sPhI4iwpabcSNed2iSLKey/
 FpKUhCTp/YManDLbqSkYEsmF6CwLqmkq3LN/BGKh5GkCmg4wUb/T9gNnOwtpqD+6Lna8
 /ZjfN21wuPmKgefZLPV+yJOWAMpeHp5AZDoCJfNGlkO0WcguUvrQV+XuCJ/059B2noSA
 vXbQ==
X-Gm-Message-State: AOJu0YyHUt+cmvF6Am0Lkx0oJoDSZ/PYNAtj0mxMGxB76nxrWLpQAsvJ
 oVwyEadRM6ASmAocKgHNjeLg6oyXJUdm1kGNmlmLBXEPGbf0JsLrrkQ+pd0r7QyHgikqqL+TsXO
 ImEwk5CW8OVGbOxu5Woewa4V+vUuaTY8=
X-Gm-Gg: Acq92OERtlyp4lPSdOKyN4pQWri5QXl180pDzlddfbl+Ak6vwagMvpeLoHb0Zv2REi8
 oD6dByOXcW2Cf5NMtcIi7Y+FhlbAY1c58S+i1qWFbRei93Qt4P5q2TvRtooEq6rfkc16myPnFbF
 hgCprgbrCUulyV5XSOU9rIzbt+xEe3oBhnLHTZ+kJcw6ZOT28+blUO68QRo/0S11Xich6JkW79l
 4+sysVye+VugtTNLD82lc1GGh3ZXst7mW4nf2yOin4V2eOjNcPGxKFW8cszMpcH0nj72JpPTlEw
 kDvQpyA4Uyn0lv/b3fo=
X-Received: by 2002:a17:907:c003:b0:bd4:7bed:512a with SMTP id
 a640c23a62f3a-bdd2580bc63mr850076866b.30.1779709566601; Mon, 25 May 2026
 04:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260522080644.9531-1-randomjack94dev@gmail.com>
In-Reply-To: <20260522080644.9531-1-randomjack94dev@gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 25 May 2026 19:45:29 +0800
X-Gm-Features: AVHnY4IXZtKOtDPQlXMfCoeG1JnNW4iwix8PkW155LMu8FPmCmagapidGMhGAqc
Message-ID: <CAK3tnvJ8acuHzp4WoQ87SqYJ36+Oc30ESYT+yrgNZgU+fCfv3w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Mechanical conversion to QEMU_LOCK_GUARD
To: Evgeny Kolmakov <randomjack94dev@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, stefanha@redhat.com, 
 fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com, lizhijian@fujitsu.com, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x636.google.com
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

On Fri, May 22, 2026 at 4:07=E2=80=AFPM Evgeny Kolmakov
<randomjack94dev@gmail.com> wrote:
>
> This trivial series replaces manual qemu_mutex_(un)lock() calls
> with the safer QEMU_LOCK_GUARD() macro in
>   net/colo-compare.c: colo_notify_compares_event(),
>   block/io.c: bdrv_co_get_self_request().
>
> Evgeny Kolmakov (2):
>   net/colo-compare: Use QEMU_LOCK_GUARD to simplify mutex handling
>   block/io: Use QEMU_LOCK_GUARD to simplify mutex handling
>
>  block/io.c         | 4 +---
>  net/colo-compare.c | 8 ++------
>  2 files changed, 3 insertions(+), 9 deletions(-)
>

LGTM.
For this series:
Reviewed-by: Zhang Chen <zhangckid@gmail.com>

> --
> 2.43.0
>

