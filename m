Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFA8C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyTsp-0004nV-RS; Mon, 24 Aug 2026 08:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyTso-0004nC-Cn
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:34:34 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyTsm-0000bm-K7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:34:34 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so3760264a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787574871; cv=none;
 d=google.com; s=arc-20260327;
 b=ezGCmOgKMHyJrXXN4Cu0+ZMdtdqViRD8TDHE8ETemaIMMCnL6iuzzAetvSI0Ehl0na
 Jf2sNDclnV/asVHhy0kvhxT9o1xjGSN+chGAN9nvkwQmJsobZEFuVum06DOTvEDL5Fqf
 cSiBWa+3Dizn9fGx2zpq51NNoPyIp+qXaYJZQHG/qxakJ6vxrMCTnxcikTfDM6fku6Pi
 SsXRYHjGGt+sWygo6O2eaV8Zsx6Bqb4vKEsUMwFhHRhPkoJTYcJ2oR5DaHPZNZ3gOlnq
 H1I9xGtVSEp/Q/Sqvh1CNM5ILy2BPAIOhR8ZgJiGx5sCI5UgT596XXdNCiArONhZ0kLv
 LZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SB7s5elB9fI60jrTHrTu6XgC8ZhigLv3DovDMAnWATA=;
 fh=uZtXeOWea64wQW1rEejrNm3IvfSqIbbCqylHEt/o6Lk=;
 b=fg9XB6J6hMuTWwfOsilDyT3kACbNXwhbLKAwl2KSu4GzE11wUZQS/oid6+6JmSNdcB
 5f3hwABS1DidXihu44SvZdZ2scqtq/sLXUaLylN0vJ0f3g3eLBkz2/y7mwoaTPkV0Vak
 w9mjpXFB09kof48jOPMkl6Klwmt1cajp1iJBwGBsgC/iCH/W7jqDW97dLcmY7hFlMeHk
 nPpu2uStVMmd8MNJiecR6VkidFOj8GIuTT8jiN5/EpSV8XsBq/b+ioCAZV1YzoAJXXXD
 rclXCjM09eay86n4BdqPbLQgqWw9+fOtvnbIlJleGXpitkpTFLE3viVspuKynoEcX5HC
 JqBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787574871; x=1788179671; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SB7s5elB9fI60jrTHrTu6XgC8ZhigLv3DovDMAnWATA=;
 b=jdlJj3JuAKp7D0LjJJ4rhv1PvdaoFxt6G5KkLxCTgClG5UBNAyKYgfCCOW1qf8/WWw
 zuAGqd2OLozdm5DWfZk/xdiKSkwhbwQUwYyEd8nh8R+48hH0DmqMsernbkMSdAWxyc8W
 IQj4aRKKBlzvDoRYIlouaj4wSUNRv9vhsOBzYKxzI24tFb9id+LX8W453ohkgtt9bOBJ
 l7DeMQwsDlfgiwygBmsmXDhtk12aSkALeKb6wvdQDtSz0UgRv/ScNHHNA4WksSGBHK14
 sEKwzjPB9i7n+JAdNiD95C7tVM2c/g+Rd7YKQB77iO1e5rDtjEcaZWkTlUcnY4W/WSY9
 xAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787574871; x=1788179671;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SB7s5elB9fI60jrTHrTu6XgC8ZhigLv3DovDMAnWATA=;
 b=pAQd7xkrcQJzoUxL/KhvJsFeXdL6of355mBhZuCARI8sl5YkbPVKLl/WV7EDEYL1fE
 0PJT34Y//4PiCSbd58ERWcXuapKPL3+k4woQc0r+3CGmGf0gAfKX1/DK695959uafX8q
 zLtZqoAsv5UgaJ8rM8ghmYZuYutSDl34v1IJduI4CzUZ8kIK+o5yknpXsfkBYaVTfexM
 YsEfAzWcii6aPkLPG5OK6RKB5GBLzMHpCZQwt6t48o3T3wqDB65QcFekj41CzhZElg+I
 ktBkCGQ0JAcUKU8hX32OYZgMDrBUIQII4yV/F8bqoPFrZPwniFoP87DNcxM9WBNZxUBz
 JbOg==
X-Gm-Message-State: AFuF++nEA2Vo7p6dO71nCzWCP9kh9gQUB+zmTtwtO6ZfJZGcIrMNLLoL
 o2JD52YnXE4fFfYp950ZJ7YKgsQA+JusTfW0/UgWgQM+Op0lZ3RV1ZC7iTB7tX5DR9WIPfxLWcU
 vjZMXUszYrSVZAGF8W/+uKExYuRUGSZzc9qSv
X-Gm-Gg: AR+sD11MzBO5RLo+DHbt3BB9usrh/yB25OOPOT+4z3952MpVDG9kZkr7VYDTRe55NJH
 73H0Y0238lzJP+NaXh4MPMShUVdBYLZqlYJO/AMBM/wwEWfZL0h8+R7o9iLW/bgvhU0TSnVUT6f
 D5ovcARp62fiyv815+fL3GQQ7hOpORRzOpEJPLLrl9V4kJ0kRsvluGiKyb8dR3odeBSgl6cz2t+
 RgSDbVYzZUPzozT2MQMAq94Ko98rz9UDbRTozZtvYQh9DYf/YYsFELZ6ATqRUIRR1RykOsTTsoz
 AioPHWXSaYUjRJMbbhqgC2CCyRi68DK+V0vw5TtPIe7+tg==
X-Received: by 2002:a17:90b:3911:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-395df2926d9mr31164908a91.12.1787574870706; Mon, 24 Aug 2026
 05:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260707202640.2099841-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260707202640.2099841-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 24 Aug 2026 16:34:18 +0400
X-Gm-Features: AcwNN1W14xOx13oPg--xEopRtnum1dxVp1K4XW2dm8IFUSSNYIrP7_xNGZCZJas
Message-ID: <CAJ+F1CKkLdzMbutap633LkU=hKWPah-zrJD3WTohZZvBUK-19Q@mail.gmail.com>
Subject: Re: [PATCH] meson: detect bindgen and LLVM 22 incompatibility
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1036.google.com
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

Hi Paolo

On Wed, Jul 8, 2026 at 12:27=E2=80=AFAM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> bindgen < 0.72.1 linked against libclang >=3D 22 generates opaque structs
> for C types declared with "typedef struct X X;" forward declarations,
> common in QEMU. The struct fields are missing from the generated Rust
> bindings. For example, with bindgen 0.71.x and LLVM 22, a struct like:
>
>   typedef struct VMStateField VMStateField;
>   struct VMStateField {
>       const char *name;
>       int version_id;
>   };
>
> produces:
>
>   pub struct VMStateField {
>       pub _address: u8,
>   }
>
> instead of:
>
>   pub struct VMStateField {
>       pub name: *const c_char,
>       pub version_id: c_int,
>   }
>
> The build then fails with:
>   error[E0609]: no field `version_id` on type `VMStateField`
>   error[E0609]: no field `flags` on type `VMStateField`
>   error[E0560]: struct `util_sys::Error` has no field named `msg`
>
> Check the bindgen version against llvm-config at configure time. With
> -Drust=3Denabled, error out; with -Drust=3Dauto, disable Rust and suggest
> the upgrade.
>
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>

iirc, you told me that the patch was good. Can you add a-b/r-b, should
I take it through my tree?

> ---
>  meson.build | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 164328ded83..c965cef352e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -125,6 +125,25 @@ if have_rust
>        have_rust =3D false
>      endif
>    endif
> +
> +  # bindgen < 0.72.1 generates opaque structs for "typedef struct X X;"
> +  # patterns when linked against libclang >=3D 22.
> +  if have_rust and bindgen.version().version_compare('<0.72.1')
> +    llvm_config =3D find_program('llvm-config', required: false)
> +    if llvm_config.found()
> +      llvm_version =3D run_command(llvm_config, '--version',
> +                                 check: true).stdout().strip()
> +      if llvm_version.version_compare('>=3D22.0.0')
> +        if get_option('rust').enabled()
> +          error('bindgen ' + bindgen.version() + ' is incompatible with =
LLVM ' + llvm_version + '. ' +
> +                'Please upgrade with "cargo install --locked bindgen-cli=
@0.72.1"')
> +        else
> +          warning('bindgen ' + bindgen.version() + ' is incompatible wit=
h LLVM ' + llvm_version + ', disabling Rust.')
> +          have_rust =3D false
> +        endif
> +      endif
> +    endif
> +  endif
>  endif
>
>  if have_rust
> --
> 2.55.0
>
>

