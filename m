Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813A5CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSee-00068R-5Q; Tue, 29 Sep 2026 03:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xBSea-00068E-7E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:53:32 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xBSeY-0007h5-Pb
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:53:31 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-144f79153f5so264806c88.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790668407; cv=none;
 d=google.com; s=arc-20260327;
 b=QXrxoOwJcAsHTCNdJhb7q9c8kpmA91E7j2YU4dTytRSn/VGXr1Kus54vMJf1KUL71R
 iOmkgnhGJS/QaLeJxBKX8ZCk80PGSskmwb4koSQG6g37RBuw3MK759A6cnsKkzXJb6la
 K6OVZ9xMyoKj1Tgx1TtlVuHkIlxINZevm/Lw7xHM2VJD8TOLu+AI3VIu2yv/+SonXXal
 UVUkSxPRC/ZwwLIzYfOHQuvp77Uie7vP1jAykUHpXVnWWAMcj6qGs/GyMi/8EqkG6+zU
 lTYI6QeYRdkKvO6RggrEgwBkr7KFKo5DFa7eFB6bHurAMntr5H2/CBRElXf7Usy6d9db
 B4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z1f25xCxHnjZVY8m1tfSdeydZ67Y0UAI3N7miEYwJwM=;
 fh=5HO4nrRWbQikJwJf1gOHQ1283vX6Qqk9pcIv/p0VE7E=;
 b=F4YnnAOHf6z/LhopDv1urHkUkhxX9Tpcvmg0Bc+miPAzsvZ4JwDpsDgGV9cZr8HtKJ
 0YVcv5n+4DaJimndIwgsh6EIa+vCpVwIzGd+SjRNexWS0QBfQlWdPqZVt31elR72lxFP
 SD97e/pc4bcofmkOZlKR2G3IyDfxQuIzTsBpDhycWW+rsQqi/HqFQ585n42XDnuqhsvz
 oezepB+zfHTY5Rn8uhfVvE9peDWGtEhPUJQaIGIiZFtnWx9jarA79EahtQ83YopcARiG
 rCb7fFoxbvvOw1kTZOwni6YDncWMVz6SiliIky7gEcaaczMGuF62o37hIKASYwcWimuS
 yy1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790668407; x=1791273207; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z1f25xCxHnjZVY8m1tfSdeydZ67Y0UAI3N7miEYwJwM=;
 b=oQEnbOlxXjtkLo9pB+vR5VDgRgDj0P24GCdD4OxyPy3HX8BXCkCf5qgkzY4/Hu/4p7
 Vdwu447nl2jZmPvP9BZI/9AEooy0dshsOohuUCEAm3h23nQLvIMHd1hyoI1Lp2dx7+mu
 kZ6m37DCMcUjCnJcyC3QF1Ajbimq/x1L6IzRSsOvMkJDSt13S9dGPF6fSBJBJh/XCbgO
 B4MEgsHhMNN7BLC2vz/DGtzGL+Lflo5wdxLlQB2273mrP/M7PaF5uqqXoEdXWVs4YHHJ
 Jj0xPPyjNBmJ/5vVKBKlWvYLIcb91Q9u2Ja822uNzKxPkJXK7J9bpWNy6KEbyRiYQUvv
 QQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790668407; x=1791273207;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z1f25xCxHnjZVY8m1tfSdeydZ67Y0UAI3N7miEYwJwM=;
 b=t8++WPUZj+1nDJJykrn0o1eZhfukxZLLACUuw8SAa7lzqDS+AQA/GXM2dtKABKP/a0
 AjihtykXcLX17j+t6FdTAe/rWx9hQ8jG4sfFLtylPSQvzV3rcIkzZi0vYrzLasf6Mul5
 Rn+Cd/dzniOkR3llNhjSu4hImW95+9cebcg0rj04HVVodO6i1mCxzDKbycm8zN8+0Ciz
 BS8w49jI6KxcHczBQXovlfXx0joXPTL1jNtR65OukEXwRF3utQptkI88FZhreOS7sbgw
 aRypzFWiFrbg/vP5zchl63uc1n8ll31DoLtEgdkhXRR17MZlxDvXquVsQKo1aZhN/JD+
 3iCw==
X-Gm-Message-State: AFuF++k1tyJ1jvJky1z+RyVFqUrQYS0OlO2bBhlCJ5Joyf8SFgY1zCzu
 g+pzemcsX4hLEUtCnfXPi3B/2Af+7/9nR6UHXZEOQQtgewMh/z+Mu8SAZ6q1tWZTW1Gzl2OkSix
 gqzcIVIh0SDpJWRtZ2DpjN1AefTu1Qp4=
X-Gm-Gg: AYBFou1GZVaEYxGtO8z+Ab4q2ktmwBVd3lr5DlD6C75hqria8QH89YWN+6KmnrRWE2G
 xqu2ZL7K5AYDPq6BXYPAIZ6fDZ7AAX5Vt2UsKPr2byatUmgHM7qoPwx+1GL5BFrM6iLHoc6PyDW
 5tCLy/wRlvvbvPUieG1uAXQ9DENkD6jj3temiHtR86rHTOd1XUlTto309ULmkmXyaMZfN+x5sQC
 bKx6nPwjTk+PWAbrP3YkacmqMiaKBNVJXmrv2+TdTQl8cgt/xAXRVQoCXth061z7zDhTAGkmT3S
 TeGToZS42+WLB75UMO99XYLI/eT2WWK9WoLobCnsZ12ZUUeEbXLMNnXSLuTtHEsEj2yRQpo/JEc
 VKJyq2Le6ILo=
X-Received: by 2002:a05:701b:42c5:20b0:148:bce6:429b with SMTP id
 a92af1059eb24-14b2d993e52mr2268880c88.8.1790668407418; Tue, 29 Sep 2026
 00:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260929060653.445985-1-malike@kylinos.cn>
In-Reply-To: <20260929060653.445985-1-malike@kylinos.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Sep 2026 11:53:14 +0400
X-Gm-Features: AclHuK_veZ5J6HpMP1_oPnbbAJgThIFBvdvL-q9s1CaugW_HqAKFD16lO980ij0
Message-ID: <CAJ+F1CJ80FWS6qOXe+kNek6fPkJvuyrNtUKjQc-iup_2sgOuJw@mail.gmail.com>
Subject: Re: [PATCH] contrib/systemd: use BindsTo in qemu-guest-agent.service
To: malike <malike@kylinos.cn>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x1231.google.com
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

On Tue, Sep 29, 2026 at 10:08=E2=80=AFAM malike <malike@kylinos.cn> wrote:
>
> The qemu-guest-agent systemd unit uses the old BindTo=3D directive
> name. systemd renamed BindTo=3D to BindsTo=3D, so use the current
> directive name here.
>
> systemd commit 7f2cdda committed on Jul 14, 2012:
> unit: rename BindTo=3D to BindsTo=3D
>
> Fixes: 2ba60ec17518 ("contrib: add systemd unit files")
> Signed-off-by: malike <malike@kylinos.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/systemd/qemu-guest-agent.service | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/systemd/qemu-guest-agent.service b/contrib/systemd/q=
emu-guest-agent.service
> index 51cd7b37ff..59f7ecb1b8 100644
> --- a/contrib/systemd/qemu-guest-agent.service
> +++ b/contrib/systemd/qemu-guest-agent.service
> @@ -1,6 +1,6 @@
>  [Unit]
>  Description=3DQEMU Guest Agent
> -BindTo=3Ddev-virtio\x2dports-org.qemu.guest_agent.0.device
> +BindsTo=3Ddev-virtio\x2dports-org.qemu.guest_agent.0.device
>  After=3Ddev-virtio\x2dports-org.qemu.guest_agent.0.device
>
>  [Service]
> --
> 2.25.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

