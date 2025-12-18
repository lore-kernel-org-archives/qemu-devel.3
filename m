Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3947D6E2CC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIMk-0002vE-Sz; Thu, 18 Dec 2025 13:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vWIMj-0002v5-8g
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:04:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vWIMh-0006fT-Sj
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766081078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HMm5PPGmJbbaFEUe0uI/zJ77u3Ca5KRWh3EGewiRCN4=;
 b=RP1EJiObc29bjluIbOWi3tKB0INJtX+F2+wiDwPa0IuAfyjXP1xFN88d0GC+mX45kdXLxm
 ucW9NilTugE/8HkAIwtDScxDssXInxmxURb+yX8ajbbL/1YnCrNgYwOoV+vo6ThAu9aSXY
 sOnOIHCbISeY2Pm9LXz47sfDfyUVoX8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-NB_KD_2bOSK31Xnq8Q6qAA-1; Thu, 18 Dec 2025 13:04:35 -0500
X-MC-Unique: NB_KD_2bOSK31Xnq8Q6qAA-1
X-Mimecast-MFC-AGG-ID: NB_KD_2bOSK31Xnq8Q6qAA_1766081074
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fc153d50so615515f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766081074; x=1766685874; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMm5PPGmJbbaFEUe0uI/zJ77u3Ca5KRWh3EGewiRCN4=;
 b=Vx8yE3+sddgOaMMdtSU8n/K48bTJ4xl2QMEX6W8hNOAeNuML70rYFaT/Fc1Z2/o3b8
 5EznpEMbLS/1FFDvAVKl9Q9uaSBPQu5riAmBhk2WlPsPTn3aQO8qe+ZxnixOVWpGq6+P
 n/cu2oA1DUC3bbFIKWmuVbi7MJOlWgocPuSfKUW+bm2qeP8Z3W5oeJCi5ZSU+W6JmEyv
 tIN7kfv0hwsotP7mRnfKOK+jjP4z/q5nw2te+FYuxnIstEaqLY+Zr1Ze/Dy3Xq8rFh3c
 kJUODlrw/UlGNE+Vzg1ha3xzvzNR8YAJIdZ8OI8TnpI0q/ydRgf7vM9jMWs1hOOzqxP2
 YX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766081074; x=1766685874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HMm5PPGmJbbaFEUe0uI/zJ77u3Ca5KRWh3EGewiRCN4=;
 b=P+VY6DY+h++AmBvdAjMhP9YVhB8wDMQYUeTediCNhhlH3bDQssC+1WTpGsZ0v76mY7
 QkggSfdRgt8GR5msniY7XPeGpi/E6oaXvj/U8Qa+5rvzGYjAEQhTmixAbIsl0xpep7+c
 fLjnpL55SWs4YDkAMfjuv/qinq7Fjbu95tjsF04z3ImAoRw4691136yt9ZV/MdZH5Bns
 GEbSrNewW//zVrTcAAlKMb/sk8i7Hwa0wdWOvnANtwzkRnDPQ5141GhCd8cR6KPn6aON
 37KLY1Q1p+EE2gzJdsAN95H/VpkXlaXFnQFiSSFne15RBmIvsyYU3d/xsFB7xpQMMJ8N
 nREQ==
X-Gm-Message-State: AOJu0YxP4fX4m9Ycss0obQ6xlKDAodN+2u3ljOhNmbp4cpn2JpYl5bIR
 bAfH4H/N2/8wPxLgL4dOIuxuY7zyN/8yMMX2/PZXBbuME4GTTF8Vf5o+RzBQIdOtP3tcU1TrLxS
 saqmVdpCfMxXIOV3ZtsSLQHAsDv4P9uiBqRqOLggWROrBi0On8Jx2kQRV9k2VuwLJo5XX4JZpf8
 WmCa5lZbmPN5KKOaKE1DieYz2x5ezN4CSLVr6FBZ52CQ==
X-Gm-Gg: AY/fxX7fmEBJBBgNLDTcZSbRCVi6u31BaQT9CHAuqY4DX17vWSyz2MOl/5lrlkd4REK
 18lXj4n3wIcvmcJ5yzlTtrkOd/g2xV0bOpl2SJ1SLU06n1TfiKAd70vfoRd0o6p5mpZi5gUmz/w
 QhDkk4GKUnL9jSFMX7kb7xHt3S3nMal+I6iogSAoFo64l8KZTXrr0NWm32nxjkwCHezyvuP47l1
 fZ6FSB+Iqttd9QgDdmRkIi//hoz3Q3uB16+QW1sclFaXYC/Ci5o9rBIqM2+ugwVsMoO
X-Received: by 2002:a05:6000:610:b0:430:f68f:ee96 with SMTP id
 ffacd0b85a97d-4324e4fd793mr412119f8f.36.1766081073799; 
 Thu, 18 Dec 2025 10:04:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGi8GHbl1YyaqRg777H/lPlJqIeY349J5VWsFjFxLdhVKg7szJncPjBFq6YLyBqsBQ7McYLpbzjHH5gJ0nFr9Q=
X-Received: by 2002:a05:6000:610:b0:430:f68f:ee96 with SMTP id
 ffacd0b85a97d-4324e4fd793mr412088f8f.36.1766081073378; Thu, 18 Dec 2025
 10:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
 <20251205164125.2122504-5-alex.bennee@linaro.org>
In-Reply-To: <20251205164125.2122504-5-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Dec 2025 19:04:21 +0100
X-Gm-Features: AQt7F2oc1YM8rUGVllhHbp1g1Znhs4_WjciF4X55mrimAcqZxXqA0vrvdDWGR6k
Message-ID: <CABgObfa=pNuy7WeEM0ziavDH6r8XhjakJYr3fzJtqSJpiK3CGw@mail.gmail.com>
Subject: Re: [PULL 04/14] tests/tcg: honour the available QEMU binaries when
 running check-tcg
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Dec 5, 2025 at 5:41=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>  if test "$tcg" =3D "enabled"; then
> -    echo "TCG_TESTS_TARGETS=3D$tcg_tests_targets" >> $config_host_mak
> +    echo "TCG_TESTS_WITH_COMPILERS=3D$tcg_tests_with_compilers" >> $conf=
ig_host_mak
>  fi
>
>  if test "$skip_meson" =3D no; then
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d4dfbf3716d..7728098981d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -37,6 +37,15 @@ export SRC_PATH
>
>  SPEED =3D quick
>
> +
> +# TCG_TESTS_WITH_COMPILERS represents the test targets we have cross com=
piler
> +# support for, CONFIGURED_TEST_TARGETS it what meson has finally
> +# configured having rejected stuff we can't build.
> +CONFIGURED_TCG_TARGETS=3D$(patsubst %-config-target.h, %, $(wildcard *-c=
onfig-target.h))

Please use something like

   echo "TARGET_DIRS=3D$target_list" >> $config_host_mak

instead.  Using $(wildcard) risks picking stale files.

Paolo


