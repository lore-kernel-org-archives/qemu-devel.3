Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3193DC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x25cm-0004dM-BJ; Thu, 03 Sep 2026 07:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x25ck-0004bn-QX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x25cj-0007F5-2r
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 07:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788434931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXh+ceAhKq3oiAHH/tdXYJfGsBFI7m9gSB0h4UC2lxc=;
 b=ackRSm/I5WeM8gwkBcv1XOtQhQiMEivijkE6k1DvEo8SzLnG80qRtbKZ582ekkDKkTVeyy
 5bh9t515x1QsoOo5h93vEhlQcdtG9cLd4L+XOKQjjK/8wLCzJZK24U3Wogonk07lTuYqpy
 MpfNSfLm1ZpAkaCBj23YokjCB55lSAY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-4mScFOSiMMu7LYiBAFC4nw-1; Thu, 03 Sep 2026 07:28:49 -0400
X-MC-Unique: 4mScFOSiMMu7LYiBAFC4nw-1
X-Mimecast-MFC-AGG-ID: 4mScFOSiMMu7LYiBAFC4nw_1788434929
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85798977dcso3318013a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 04:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788434929; cv=none;
 d=google.com; s=arc-20260327;
 b=r1/tg8MIBb0fOcF6dIlymNIEk33vUxJtJU61G5PDcidgAZ6ab0VWACqumS4BdYUXl2
 HpAvUfdAEWIo+U9qWqvhkLM0ep8OUr6ChSDHTsoOeZXoHK7HiRDRSQfvhJNqDOXUm2Hz
 xR9CY/vjA12EPsiyxrwsJTlDf7vP/PscQJagHmLx6joBQmwa/RCg2CM+za9FcF5OwAJf
 Uhz+LknUh++LAlr3gPjCiwlhXNDKSFn3psjzLcfc/JV/mtxw5w/VDL/NyPrJDN5dl7j9
 AbJExtRly+gCVFWCdZpeWuOf3WXPQ9bHOp3F5gZ+hgk+5UkAxFDT666+PQp8IDMSXmHy
 c00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HXh+ceAhKq3oiAHH/tdXYJfGsBFI7m9gSB0h4UC2lxc=;
 fh=cdRJnSWr0hdCEFqMJgY+ok+/4UsQGTzFjKLqSTY9C6M=;
 b=gJfkNwJx+4+bk6UXPcwkKIwa7dOYhfYeqrV1Q05kUNrXOoCNDwDtlmszMUMopLtFvH
 4x2s8Nr/qwfiV1nEBKJ87qFCwgJs1iAEVNGXmlaXfvEB352UpgfK+9fszEgKCA3Q8jNY
 ZNta5i4Xu80MFbmeYkgOuvtQzrgOpQiF5QbwfXZII1pw1wNMA2OH4gsc5yfoN/z8oQUP
 5On7v1bF4J7JOfVO+uik1tHiZ2mpNjbrMfeatD8f595rN1zcXiNy896+0GcOThWzPvHS
 X4UOfkCDpYKE1MoRlOLb7zbzzwsJP89p3cLRzp1NOIb70ACd9hXCtFxkdPxLrjkmEiIo
 0SgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788434929; x=1789039729; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HXh+ceAhKq3oiAHH/tdXYJfGsBFI7m9gSB0h4UC2lxc=;
 b=WnxUY1Wv2upyeWC26I787iI8xAD9yEGZ8Av2VH/UQ0T1H8UcnOY7Nx+os0hgqkoW7K
 +ElrnQTtd93bit8h36x2H3fk7xfl79jEmi6NkBsdQVypxFUYTSn8NDCegAV8p+UKloYp
 MnKKJYwQhYQJmfD4fB3Yqe21bg/oosbt0MdI0LkFfCkTn8L5MxoMst9doO3caTkQzT7X
 bocbvkiW8Nwn09gd4+l+EGgXYd6b9d9Ed/mEqPa2cHlHJtDFjf3iHRMLEJYHUQ6HoL3r
 98MlZkk0oRMAmUgu2w+kMrV7a75WZbNFjhuBKlzp379LT2bjze5zQigRfdeEly1xlg1g
 1s8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788434929; x=1789039729;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HXh+ceAhKq3oiAHH/tdXYJfGsBFI7m9gSB0h4UC2lxc=;
 b=c7pOtCfd7SXELO1e1ZzfYKRfIhGDLEkLBKBdylT6ZNflPs9czvUJraHYOE3sWMFThr
 6jT/O2kbE6r6ICL/ZNBUtyawgO+qlAuhSlUXC13vEl8VZFptyqg4xw1/MES+kSeqhOyN
 eZmELaL4QQvB11D51KeC6lncf7qmZVEVlyufzwIa0NW3RiIim/APFbtTVPL+oxDuiJVV
 GxyBLWdR0zjThCbtB+cf+dfFYNmd+e4Du5BFmyDfW8WaiKr+85YMhUwKCfvbgI8sC3Kz
 GXwB5xhSKD3Lnm252XZz1DwxPcKRpk0qd/UT7sgqAYvYiu3WsE+ycULXpG7BJC5eBK6B
 Jx4A==
X-Gm-Message-State: AFuF++kNvjio8KJ24mYBHX3iwGeGgflqjr7J/y3Wd9sLQbkwFchE5Kb3
 oiVb3n9wEmbJG6RH0zV4CpLzSFkqSEN5lHiVQqgPfinlWkotbiyFxSKvbiuafclVTGsr1KcLbgf
 kqus/cp8TVUfyH+T8mAPShhzFrIREBos2ZGpaQj7So21qQ4c1PVVzRJZJYIpCD84BgwDmueIfbK
 rSUNpLziqI7IofyNt8wPAplHPB6fiLmv4=
X-Gm-Gg: AYBFou1/EYMah2kzL4cldiGAZNymrR5a1+fBDJbO/6emRVphnfGmVfL4DfNgxl5sJ2f
 tTbIDKxrbSae+PzA/zCsPNothfGmJFwBvP2spCgw9ocggtVjXtk0R1dFm+EUk89XcSlc4mmzZmI
 nDLtSywKjBxtA2QLFmzVtUFE25Gp80TZ2Zcp1NIS3HaD4HLixvgqggffRhaTy6FJrYh+/oJNHw+
 s6FRYWPze2Rfpu8VaZalgnhpmIKvOCCTOIM7M7OLEKi9OyueIuKeR9PWQJnp2oxOwsVJCfxaAFp
 GA==
X-Received: by 2002:a17:90b:46:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-39aedbfe60amr18976579a91.0.1788434928590; 
 Thu, 03 Sep 2026 04:28:48 -0700 (PDT)
X-Received: by 2002:a17:90b:46:b0:38e:ad9d:1161 with SMTP id
 98e67ed59e1d1-39aedbfe60amr18976519a91.0.1788434928104; Thu, 03 Sep 2026
 04:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260903103548.2142568-1-berrange@redhat.com>
 <20260903103548.2142568-5-berrange@redhat.com>
In-Reply-To: <20260903103548.2142568-5-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 3 Sep 2026 15:28:36 +0400
X-Gm-Features: AcwNN1X3eoLKDFlsBU9_27p7JhpSaujGCzU-cAAN1s5cNddczehgwgIiqM4rZTw
Message-ID: <CAMxuvaxdk5ETRJs0rB=s-Uftvz65xxBzRs_3oi1ROahUQ+EXTA@mail.gmail.com>
Subject: Re: [PATCH 4/4] meson: warn on GCC < 12.0 due to lack of
 -ftrivial-auto-var-init=zero
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

On Thu, Sep 3, 2026 at 2:36=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> The security policy for assigning CVEs has an assumption that all
> stack variables are zero initialized. Our CLang min version gives
> us -ftrivial-auto-var-init=3Dzero, but that is only available in GCC
> 12 onwards.
>
> Our min GCC is 10.4 but only NetBSD has such an old version.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 5315420a41..eeca8d074a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -327,6 +327,12 @@ endif
>  foreach lang : all_languages
>    compiler =3D meson.get_compiler(lang)
>    if compiler.get_id() =3D=3D 'gcc' and compiler.version().version_compa=
re('>=3D10.4')
> +      if not compiler.version().version_compare('>=3D12.0')
> +          warning('GCC < 12.0 does not support -ftrivial-auto-var-init=
=3Dzero.')
> +          warning('This compiler will not satisfy the QEMU security poli=
cy ')
> +          warning('for assigning CVE which is predicated on zero-initial=
ization ')
> +          warning('of  stack variables. Update to GCC 12.0 or use CLang =
>=3D 17.0 ')
> +      endif
>      # ok
>    elif compiler.get_id() =3D=3D 'clang' and compiler.compiles('''
>        #ifdef __apple_build_version__
> --
> 2.55.0
>


