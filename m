Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325D606A896
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AkM4uYMV;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bqFh/4NQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT06W-0006U1-7e; Mon, 16 Nov 2026 12:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xT05m-0006ND-Dy
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:02:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xT05i-0006VD-Vx
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794848521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uq4bt5UrjbA0HqIgp3vitj1azyu0T2kn3YEMyvMvgX4=;
 b=AkM4uYMVzZ+Lk9dAqnlNwtap4y3JHX+1F6naW6Ek1J/s7eJAzTaEg9r4TGvPsYv6h5K2d5
 w+xKGdN/2Db1lFwU9wdYY682Np333FaDKrfHdbIDJtmcMv8sGOwBX/Lc7gbF5/y/M3ZFPF
 ssJFR9ZzAeyB2PCi2jKis2vhv0wyoo8=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-S2qI6ujaMuqkI6HXt5Ynzg-1; Mon, 16 Nov 2026 12:01:59 -0500
X-MC-Unique: S2qI6ujaMuqkI6HXt5Ynzg-1
X-Mimecast-MFC-AGG-ID: S2qI6ujaMuqkI6HXt5Ynzg_1794848519
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67994567a44so5199984d50.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 09:01:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794848519; cv=none;
 d=google.com; s=arc-20260327;
 b=VcivuO81DOnJ2udx4w4BfRfH7wN4UDzV6V6i3f+2DSxCKhJRy0O0N4ULgIdcOx3sIx
 xvu5DuatIbi7kYsii6VxlhdH/tfLNFCZ5KWRXR6SYzKnVDTgd/uhMYoxldl3yGlclwZu
 5CVNhLlWOEsYAovdvSjvk2I+VB6xw064lqOsALoTNkCVuaVP8E5NF53X1JuIaCuaeGKT
 yINmkj7tAxxsodsjHWGkH6Z4dhxrW24rteEU+S+U9PI6nia6piJpf8ifmlxUPDgYoStO
 Ski/rKX9gqbW+ub0w4x1AqrzrJV/WCN2AmnWwtCc9PePv1x8V4Lk4Xx5+dIOGm09quuy
 GjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Uq4bt5UrjbA0HqIgp3vitj1azyu0T2kn3YEMyvMvgX4=;
 fh=590vJ5tVHg5cMspmNPv9rR9I4bZI5zsyrUJvfaBGb+4=;
 b=qSkSVNXPuAObFN1m1C7Egl/r05xPKDPBofKQJPczBskx5HgEyFU7ioaX4WQf7UwyPU
 UAK239YKsV0xmundlh6oMN1HuKpJDum7XLBd+7RrSV8eGA8AJLhtxefRLlAuUz+ny2VF
 v/aZkGz4ndGZ/J0t24q3+Dh/fSPq3K1hi/NUFoGIIZYa2/ZXOv8LTJtvnWH6q2hTIgi0
 xLWXDRBHLFx0iXliaK7gcxUG3wKP+R+XPCm1QQKbm76Ju1t+7gb4nsZJ1JUDbAt0lS3s
 XsuCKOiqFpLNoYD81UsCL0mz9ycJ7NS1Jkbjreald4l4CCzeocfF2FLxp+wOS6oFSLks
 4ApQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794848519; x=1795453319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uq4bt5UrjbA0HqIgp3vitj1azyu0T2kn3YEMyvMvgX4=;
 b=bqFh/4NQcoABadaGSGLuYAdmtHCTFc/ycwNiJKwJ1ylOyy2EX7DbiTykMFWNcIpP1Z
 5k1+kztWnkdPs47A0N+zmOyVwHSMNFjHad5BHJcjAILdaZq+RjiQdNEqDDNjgDyboLaP
 ZM7oamBwrufDW/owi8OUnr5V5Xxw8KkgadPAYr0iFVR2llRHZ/Dca6I2UdLD+yXCft/D
 HQk8/k1J9t25RhrQi+X4U/V2cJdN/SSZ3l09I6/wNz5wudQHaAzgFu6p69TI38zi6BLc
 CQxnpx/ghOvGAX83xoNkxQtFxuqnh5qEzo/W6FTtS/3pG08wiNB4ZJM2aS7vvYbo3gNS
 Ukeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794848519; x=1795453319;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uq4bt5UrjbA0HqIgp3vitj1azyu0T2kn3YEMyvMvgX4=;
 b=KwOx+tll8+2Nm9kAUQOaQ+/cTlodz+yU6ouWrS8KhdXJKfGsQnm+mymrbQDX/djy68
 XykwXnRxp8VGSl8kSExSXmToV4VJumy1o4brS5LEGWU/RYMB8qIPc1W3IxvsnZhveEQ7
 9LH3qlvqHUMgL+arEKTvqjMlrRiA5H4xY7GfccVHErPVV2ta4O795z9rb9gjZxh9syJa
 fBc0yOmAbFp6mP8jgoE6gdWd0fikNhsnkUIXhi0HAAqE1jf4HgNy5zOFE1T3kWr4NZHN
 aTcEgq0wKrNM0AMTgikscb0j9YzOO6raY7r3KNdtN1JO4umyVj7Zi7phVABtQHvBsVy7
 T91g==
X-Gm-Message-State: APuU4Z9xAi4sm/Fktc2Vt3BtSzC4K4yraIHAgKEQIqb4qy+1sdqCmdTQ
 hacMoCj1lLGD4ur2vwOi/R89oH014nFhLOYfZxh8mgFHQI3hD9j2OJTNvxiOQ212/ACEnxu3SV2
 RHGsmGRMs/dgYESudMjBXRTwA2AJCbj1lxBog5vtdVOPcJbBodHTj93AvzKA98fZPFsEDFLj3Ff
 blpckLAbvxJOSEvD/qb/ngsWbUPLq2N6o=
X-Gm-Gg: AZFdTZfqReO6oWshi0NrlIbM8GnSYMxtM8PVeQO/AhfxWcdi/WVNe5obiBvaQS+G581
 E6O2uwn8ZyI9qoLqpfMx/x8StAHLVXmIKtNdWVudfgRCx/+6XS7xb2vprFQxjH1uoubi5xfiC1J
 mdFF8pwJc8N9eEOcQQvOgABESmLPNHP1ntGd/fxrkYuzxWu2iLr7SQHq7m/fNQoK3f0IZq2oYFv
 HRqKoUfRLkrpGfv
X-Received: by 2002:a53:a802:0:b0:67b:e31d:6ee5 with SMTP id
 956f58d0204a3-67d8976853amr5020374d50.90.1794848518789; 
 Mon, 16 Nov 2026 09:01:58 -0800 (PST)
X-Received: by 2002:a53:a802:0:b0:67b:e31d:6ee5 with SMTP id
 956f58d0204a3-67d8976853amr5020338d50.90.1794848518198; Mon, 16 Nov 2026
 09:01:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112112956.361209-2-marcandre.lureau@redhat.com>
In-Reply-To: <20261112112956.361209-2-marcandre.lureau@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 16 Nov 2026 12:01:47 -0500
X-Gm-Features: AclHuK-t0awv9XPG26domtpLdCbLt0dxGDMpAUglFNAn0A8ZzpFYfO202NgJu6g
Message-ID: <CAFn=p-ZZ3o022sYXbq2ZsPd5AkzqGuc4Vu=kBwNKAAocZ+j38Q@mail.gmail.com>
Subject: Re: [PATCH] python/qemu: fix accelerator detection with annotated
 -accel help
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, berrange@redhat.com, richard.henderson@linaro.org, 
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 6:30=E2=80=AFAM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> QEMU annotates the accelerator names in "-accel help" with their
> security status, eg "kvm (secure)". kvm_available() compares the
> entries with the plain accelerator name, so the check fails and
> functional tests using require_accelerator('kvm') are silently
> skipped.
>
> Keep only the accelerator name of each line.
>
> fwiw, I am surprised we don't seem to have a CI that exercice functional
> kvm tests, or compare against a baseline to avoid this kind of
> regression.
>
> Fixes: d3b770fc6342 ("system: report acclerator security status in help o=
utput")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  python/qemu/utils/accel.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/python/qemu/utils/accel.py b/python/qemu/utils/accel.py
> index f915b646692e..7e3f43d6b489 100644
> --- a/python/qemu/utils/accel.py
> +++ b/python/qemu/utils/accel.py
> @@ -47,8 +47,9 @@ def list_accel(qemu_bin: str) -> List[str]:
>      except:
>          LOG.debug("Failed to get the list of accelerators in %s", qemu_b=
in)
>          raise
> -    # Skip the first line which is the header.
> -    return [acc.strip() for acc in out.splitlines()[1:]]
> +    # Skip the first line which is the header, and drop annotations
> +    # such as " (secure)" from the accelerator names.
> +    return [acc.split(' ')[0] for acc in out.splitlines()[1:]]
>
>
>  def kvm_available(target_arch: Optional[str] =3D None,
> --
> 2.56.0.116.g6de20f6092dc
>

adding to python staging and will send a pull alongside 3.15 support
(pending tests)

--js


