Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5815C982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 04:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9ERh-0004dr-VY; Wed, 23 Sep 2026 00:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1x9ERd-0004dY-Bd
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 00:18:58 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1x9ERb-0007Ni-H3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 00:18:56 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-3a5a0703ae7so3842291fa.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 21:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790137133; cv=none;
 d=google.com; s=arc-20260327;
 b=Nrhm2C4cKJUInUXFxCdYLfNakiWRS1k0cLC4AxP1Q88MOoozc3RAquINBJd8s+UxIL
 BNEGDxn38NEKdJBriDI9AamQaH6ppCFJVlIzaZ/1iX+sMmm4FNulQen8jIVKvP9LJfPR
 toK13giPc7duwM61xngryP5L/0xTA50V+NpD53tWhip1oyYOSNYzdULiU703RqKHeGdg
 J+rtABP/K3wom0liiDAgF35nPfvlIMjOgYJZpRwp5vpFXjvOgfLshu5cafVNeB2j7zV+
 aDs4sNbtAAAZYPPBLt+eUaSdemsXjzNfANdjsesqM6IxEkNT89ZmJ3WcM+JQo9/zgKC3
 yizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oclJs3W8rXiFLgP6PshyFulcT5y7FHYYlWCFb0HDR1s=;
 fh=I5OGIxuujXbGDWDCpMfHmQygTfOOweHUagcotUWbg5o=;
 b=kYz5r/GM9GHxNjw1Syj/IXHNEi5BjFareXnFOUoBL479mJH2dy2ki6OYfOcWrOjAXS
 Asta3voDlumwuqVkataHedFxT2oP2tiyqIFOVsAMUPUCJ8QUzTHkRC/dYamH9iEahVFh
 pv49VM00Jz4MKn2puycb+++pooPOtIw8HfqKNXjxgrDbEHyoHjvcoaQpqqq+NWM7iztQ
 U+o6O3EfzaNiWy7x82tjqQpRdiNKiWROZjucSEBzB0vYiebP/gCTCUWJCUzSsTqrS/8o
 sVWJqiTyGS5dq7aJoYvYvtafLLEdGpDzCBQkHHh9SieiRJQVHkorCdYlqDfn16dPRsUF
 tC5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1790137133; x=1790741933; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oclJs3W8rXiFLgP6PshyFulcT5y7FHYYlWCFb0HDR1s=;
 b=DSWS4Phvx+BoZXPtFqTISAwcb4qTOOm6lOHioolbbbfhc71deVhuzS0oL1y9ehucWe
 f2XfgCF1lwdzDHTVZ1loIOpDZwaSXLW1u14oSLYC2mQkNfeiC0yVTUgjTVag6goVQKkT
 ZeSLbVQ0V+M0zcJTwh+nLeu9HxxqXQmzT2XypZNjPVSuIXQXbiihJW4VH7mZfS/qu/IH
 uK0XMy1s2SouqELD5y94Ogapkk3oXrzkM7gqpvEUMGEEcbIJCI+5j5Q2TD36w7jWQSD+
 CtE3ojbipv06opgk3vUaISsHcEN8o0msP2jXZVpGMIj/OA30kU8KRIWohGy7IjawgXx/
 zufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790137133; x=1790741933;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oclJs3W8rXiFLgP6PshyFulcT5y7FHYYlWCFb0HDR1s=;
 b=UVZg2FEiNOCNxYezi82oi23KW3vh1S3CxaiaqZawPOmbdZE+4JERVejWGcXrtQCYAw
 KJK8zhvQaB7ir642uixb5K1OXheM4rTd2dJF7HKb1t0jRSuR4ZoXmpajtlRbS/xXBd3Q
 wQkhDJD2L62bnjOYHUQhVG8JpNzdJFiTriG6QeZg5Gcq+K1J/+tCtbz8a/Wcb0G33UNv
 317P/+Rgy28ybZw1QwG/gm2yE5RxocLQwiAcd1OoCb64mpTYwCn78TVS08b65BinkjwA
 2vwrykG3M27K+Z9WATHo71kYaO8O5OMdfYu+KmoUummxjPm1gOg4VbfAwJ5NUlVPZup1
 aDDw==
X-Gm-Message-State: AFuF++kJl20YPk5Ljaec/dnjG2AhbssWOCpHjAZUy4RiwqXXPg9tI9ZB
 JwUvA90y+3VNGNKyhFaSCMKFEV39dvQjkgy8SL7DmVdyxWNwzENKM+LMOQ9++IfK6bMClg0TNIB
 Vt4LMPBKjUNUO5nJL5pFpgZmaAFCXIlfnluu8VaT54by7jV1yfR2n7g8=
X-Gm-Gg: AYBFou1Co1sd6CoVXLa2cSvj7ix1eTlcTUjaJj+aKEOvv5S4JNpS0ZjV2QAyY/K+fbH
 +mS8qGdRmogEucaTPUgWtvKpJhgVtrsESJ7QysaXZixX82Xb7yVemwDX45rYe1ByEiHJbFDzns+
 HC9vREvQoVbagkG2a/0a/7L3y8azKN59+uXqlE9TaZOyP9a0WUeOHx6znQ648jjdxCsKX3gPJTt
 NmgqU9AgMa9Xo9iMIRizEZ/Fbi99y9Rf+zl375mkqBQ6TlBpw1ZZLWt4ZdHCSF/nGd1diPSJ/0P
 v9AmFeYxAdR7JbKWN3YtZ4eVTB0hMEQPucOxy0ZohS+n22rZuTBBlXqbgvRghzaZIw==
X-Received: by 2002:a05:651c:a152:b0:3a6:32a5:efa5 with SMTP id
 38308e7fff4ca-3a632a6001amr888671fa.23.1790137132687; Tue, 22 Sep 2026
 21:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
 <20260923-nohmp-v1-67-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-67-ebc029d4bd80@redhat.com>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Wed, 23 Sep 2026 12:18:39 +0800
X-Gm-Features: AclHuK-5HGA04sA-gew7qzIkAmtwjTmDv-hFJWsHfD_fASeIM2AHGxp3YcbFSgo
Message-ID: <CAFWXh4ywKBZXgh71S73X2DqH5T4Gt6vwbkHYeZkQ0-KP_5JdnA@mail.gmail.com>
Subject: Re: [PATCH 67/88] qemu-iotests/luks-detached-header: migrate away
 from HMP
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-lj1-x231.google.com
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

Reviewed-by: Hyman Huang <yong.huang@bitdeer.com>

Thks, Yong

On Wed, Sep 23, 2026 at 4:23=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qemu-iotests/tests/luks-detached-header | 49 +++++++--------------=
------
>  1 file changed, 13 insertions(+), 36 deletions(-)
>
> diff --git a/tests/qemu-iotests/tests/luks-detached-header b/tests/qemu-i=
otests/tests/luks-detached-header
> index 58eb3c2cc484..fbf812902832 100755
> --- a/tests/qemu-iotests/tests/luks-detached-header
> +++ b/tests/qemu-iotests/tests/luks-detached-header
> @@ -266,52 +266,29 @@ class TestDetachedLUKSHeader(QMPTestCase):
>          # (Pattern verification will be checked by tearDown())
>
>          # Normal LUKS disk
> -        result =3D self.vm.qmp_log(
> -            "human-monitor-command",
> -            command_line=3D'qemu-io luks-1-format "write -P 40 0 64k"',
> -        )
> -        self.assert_qmp(result, "return", "")
> +        self.vm.qmp_qemu_io("luks-1-format", "write -P 40 0 64k",
> +                            use_log=3DTrue)
>
> -        result =3D self.vm.qmp_log(
> -            "human-monitor-command",
> -            command_line=3D'qemu-io luks-1-format "read -P 40 0 64k"',
> -        )
> -        self.assert_qmp(result, "return", "")
> +        self.vm.qmp_qemu_io("luks-1-format", "read -P 40 0 64k",
> +                            use_log=3DTrue)
>
>          # Detached LUKS header with raw payload
> -        cmd =3D 'qemu-io luks-2-payload-raw-format "write -P 41 0 64k"'
> -        result =3D self.vm.qmp(
> -            "human-monitor-command",
> -            command_line=3Dcmd
> -        )
> -        self.assert_qmp(result, "return", "")
> +        self.vm.qmp_qemu_io("luks-2-payload-raw-format",
> +                            "write -P 41 0 64k")
>
> -        cmd =3D 'qemu-io luks-2-payload-raw-format "read -P 41 0 64k"'
> -        result =3D self.vm.qmp(
> -            "human-monitor-command",
> -            command_line=3Dcmd
> -        )
> -        self.assert_qmp(result, "return", "")
> +        self.vm.qmp_qemu_io("luks-2-payload-raw-format",
> +                            "read -P 41 0 64k")
>
>          # Detached LUKS header with qcow2 payload
> -        cmd =3D 'qemu-io luks-3-payload-qcow2-format "write -P 42 0 64k"=
'
> -        result =3D self.vm.qmp(
> -            "human-monitor-command",
> -            command_line=3Dcmd
> -        )
> -        self.assert_qmp(result, "return", "")
> +        self.vm.qmp_qemu_io("luks-3-payload-qcow2-format",
> +                            "write -P 42 0 64k")
>
> -        cmd =3D 'qemu-io luks-3-payload-qcow2-format "read -P 42 0 64k"'
> -        result =3D self.vm.qmp(
> -            "human-monitor-command",
> -            command_line=3Dcmd
> -        )
> -        self.assert_qmp(result, "return", "")
> +        self.vm.qmp_qemu_io("luks-3-payload-qcow2-format",
> +                            "read -P 42 0 64k")
>
>          self.vm.shutdown()
>
>
>  if __name__ =3D=3D "__main__":
>      # Test image creation and I/O
> -    iotests.main(supported_fmts=3D["luks"], supported_protocols=3D["file=
"],
> -                 require_hmp=3DTrue)
> +    iotests.main(supported_fmts=3D["luks"], supported_protocols=3D["file=
"])
>
> --
> 2.56.0.rc0.29.g47ce80527c56
>

