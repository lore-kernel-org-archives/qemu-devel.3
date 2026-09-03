Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED42AC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25jk-0006Pg-2w; Thu, 03 Sep 2026 07:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x25ji-0006PS-Oz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x25jh-0000VU-4z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788435363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTsPRw4Iqe1agzQVC0Wd8o76QA4tzEOn9jUmCbNwLdQ=;
 b=VV1gegVmvsNguVM0YOk30GX2jWROxeeNAmoo5zdFBe0EcxyWWLfeuRBjzGzOVeKE1USVb5
 4KZCGMvnOay6s/3nr1kPDsh07LmzCZ8s1xASLljN3zY6OkAhXvTfp3d5AjEJbC6k7L63+P
 e6ysuu/r52dKh+xW/hfs6LFXZ0yYKrI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-VCXdgS2lPp29SWvnDiNsmg-1; Thu, 03 Sep 2026 07:36:01 -0400
X-MC-Unique: VCXdgS2lPp29SWvnDiNsmg-1
X-Mimecast-MFC-AGG-ID: VCXdgS2lPp29SWvnDiNsmg_1788435361
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso2805480a91.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 04:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788435361; cv=none;
 d=google.com; s=arc-20260327;
 b=MPwS8RG3fD/JlNCtI7A3n1yo+lfTxgBmF3XuIA8ebGYnwhJWhwRNQQlJ/EGaWJKgz9
 ypJyroWgcBTc+1X81U7/JwWcAaz/9lqd/p6tLVMPDqlIjwirWdHDDce50OlDPodA2zO3
 RFIsYijAfjrq+3SuXw4K24EmHuRqxN1NvaMLvLtu9CZcb5vHzcUGjvXIZtL4x6Evk0kk
 ebLFGwxcNXH6saJxD8Z4fUdk4bf9HuX2EAly8oU8h+VdhgG3W051pL9FJkJ7mWHdVjLG
 lYIpLzhc48dsrhzodUfZsTrLkMqQgKqeyAdIdVePWe7VpHt0RJ0rntKIZVY8vziDr99u
 hJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XTsPRw4Iqe1agzQVC0Wd8o76QA4tzEOn9jUmCbNwLdQ=;
 fh=cdRJnSWr0hdCEFqMJgY+ok+/4UsQGTzFjKLqSTY9C6M=;
 b=lKWf4S/FjUwAbiomJP/h02g5vHD8YDZLRD1ENZQWqVANDOYziIF4WhAKyyZ+isr7jL
 yEFmkQZ77+BaRHCm6sV4+X/EjtwLbw59Mc1WYAstRXlXYn1nK+csgnc4BSiL1o8T0JCI
 nqLL6Q0gJfPcqDrxU+DboD8b0YNT/EjL98dw/ygZkMQn7YHjnzIGHM2zYsbQoll5y2J3
 3ss/Oxjn+tizcFUEUd9ChRmQNmvVF+3ShrcXaGyQ7d/AsoLDNbon68dtoBHW41kL6Jve
 MNrzAkf3sAMYtSmSZvVRhxqRrtTyOLGQa5cb+cyxFejj+bmNRxV29IHvqTQEV7hXY3l8
 +bUw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788435361; x=1789040161; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XTsPRw4Iqe1agzQVC0Wd8o76QA4tzEOn9jUmCbNwLdQ=;
 b=p2pYl576fkLRhT8WjYwkVyR3GuFhD/jrptpc6mwN44XkoIQcRSCI0QNtDfCdVioPuJ
 yL03wv66cdGGH7OMkp/F2S5Ie6p2VXqB06hTdlxinlFfkGtos9db1qZ9F6dc1/A8LYIo
 jEJ3gaea4BLTisjcNiO2NhqjRL08WkD9bP34bmd982UzPhQmqCFC+YHk1gR/2STOLfOb
 uOyvuWn64hBNATJKQe/w71Vl4LniMxBRn+3+5eqTwnD9p6iASN7ByrAMgsCvJXSQc+Yo
 WubIJZSfIOvimsnRkanmqeNfBN6dmHjgj5FYEmzzJlEnB68RlFeKI1sqYP2eAtMqHZ63
 AFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788435361; x=1789040161;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XTsPRw4Iqe1agzQVC0Wd8o76QA4tzEOn9jUmCbNwLdQ=;
 b=FA2uo9T7hfZnkDG8LPodZdY/+f8Bg78nwtHI9aA179RxhLy8WV4/njWTQrlDyRt9r4
 0bJRju1Qd66gMf2CDgGsJ8KYn2q3KX0aCHLzjY9uVGHbeyPAbqJJO/Z7J0TylDM1U4xU
 Dm/Y3zzB8TjSPjvxDnxgDTdMMaNnD1dPzpEGIPqhKHBsBY4cCtNYGP6lgrcY1dvDLJqt
 1X8MI4VjCiSuQOCHBoQrFFVOJT6qbCx3H1SpoeZq7o0mO/gnZRB0K7stHmHnigvk5B5R
 y8EXx9yTCTm1V5c2YVzpF/nt5TRyEFLoim8ytPTKMzTdGdy3R5kxQuvBksVO67cNexU2
 AOhQ==
X-Gm-Message-State: AFuF++k6Aqqg/ls5IIvOnoA8nIMEFfQ6AiQGsbWTrQn6r7BmvdX6mvJh
 pygWn0DIIDunP5kMOte84iZcy5Wz+s8SXKmKcz9awr916hxcJkZV8lY8E2ZHaV4z9fIz/m3lU7Z
 Wsx1KFYNHR3YJtIm742Z3J6YP/fc7EZuIw5YF+wsEKfKrbKjxpyrtdyPgwb1Sy6fYVBMih8+V0Y
 S11VXh2l0uaOzgOoRD546o1k2I5IShtJM=
X-Gm-Gg: AYBFou2zquLhsgfMZZv74FhD1UrsCDC6egDKrbQJxnPZ1h2qfw1mA1x2SSY+QSROdSB
 EXpVAT5Lj8mKzmDwkcjf+dVTFYgLAV59gphcmaoD3ogaKSw5C9qTi/pan+NUbZ44rcC4khIaPng
 JDuLsHFFdRUemM5O1PQejleJNjOhdqn1gKseJDOzzqRGs0bZB9sETB1xvhbodxAX+hm8kgAnByj
 055CPU/Qpn7epWF6HsbnnxNAQI/PdoRURp34Gozj+XroJ1n0Fvy8IpUSQ9QiaPcxVOKT32W8mKD
 QQ==
X-Received: by 2002:a17:90b:5208:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-39aedf0d47amr19916668a91.7.1788435360565; 
 Thu, 03 Sep 2026 04:36:00 -0700 (PDT)
X-Received: by 2002:a17:90b:5208:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-39aedf0d47amr19916574a91.7.1788435360072; Thu, 03 Sep 2026
 04:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260903103548.2142568-1-berrange@redhat.com>
 <20260903103548.2142568-2-berrange@redhat.com>
In-Reply-To: <20260903103548.2142568-2-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 3 Sep 2026 15:35:48 +0400
X-Gm-Features: AcwNN1V51sWSQQ__m83LtwbQfd9ctNXBuSbdBJR257myFvQsPeDOBH2WQY4mB0o
Message-ID: <CAMxuvazkHrYr6z_MgRNhGXptZHdxS=oufBbrEnc6MuF+2q6-SA@mail.gmail.com>
Subject: Re: [PATCH 1/4] meson: simplify clang version checks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 3, 2026 at 2:35=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> The checks for the clang minor versions are currently redundant since
> there can never be a minor version less than zero. Going forward it
> is likely sufficient to always pick a NN.0.0 release as the min CLang
> version, so drop the minor version checks.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

This is basically since your commit 2a85a08c998. I'm happy if that is
enough on macos:
Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 5c9de307b0..70e2755149 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -330,11 +330,11 @@ foreach lang : all_languages
>      # ok
>    elif compiler.get_id() =3D=3D 'clang' and compiler.compiles('''
>        #ifdef __apple_build_version__
> -      # if __clang_major__ < 15 || (__clang_major__ =3D=3D 15 && __clang=
_minor__ < 0)
> +      # if __clang_major__ < 15
>        #  error You need at least XCode Clang v15.0 to compile QEMU
>        # endif
>        #else
> -      # if __clang_major__ < 10 || (__clang_major__ =3D=3D 10 && __clang=
_minor__ < 0)
> +      # if __clang_major__ < 10
>        #  error You need at least Clang v10.0 to compile QEMU
>        # endif
>        #endif''')
> --
> 2.55.0
>


