Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF85C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7TIS-0001ME-PL; Fri, 18 Sep 2026 03:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrezanin@redhat.com>)
 id 1x7TIN-0001LO-2X
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrezanin@redhat.com>)
 id 1x7TIK-0007yq-Tm
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789717562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qZv+exKqyNjMxq3hyq93Xj2Gw1BgKFVEeuRR/mK2ME=;
 b=Oevo6UjvkE4+HMslPsRznighFZloVxlym+BqkR4y+CaiwDJDoAlNLfpMGktNGgVfZYtQwo
 NWPh+4vyvpPqQINQTeUX2szx1Z9E1xuuSHjGsg/Qj1pouO5qttISb8tQdeL5zRyGv3ZOZh
 bwxXoL6Hu0I5vj4OzH7fJUqeQhERLFE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-Y2XFJVVYNsi1ae62ajyS4Q-1; Fri, 18 Sep 2026 03:44:24 -0400
X-MC-Unique: Y2XFJVVYNsi1ae62ajyS4Q-1
X-Mimecast-MFC-AGG-ID: Y2XFJVVYNsi1ae62ajyS4Q_1789717463
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-8052a85c504so404878a34.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 00:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789717463; cv=none;
 d=google.com; s=arc-20260327;
 b=mWYogZ804IT0FSclHWiwFFmlk2RCrGVdDHY8iV/5rYoD7ih1ugUXKFn0/deoU0hF5O
 UBAXRb8N/agHkU/+wkaWzOHNheugzVwyvKGBGE6WZcPJNYY14Byan7UUUn/Rie0ZrpfO
 EYcd4jtdRe1tP5EgAuWc08cX3q6wC7xLWj7BUoQxuIVaFNLpRQwM5sB0wBEmDVm+Hmr9
 5ms8+/AYqj6oljjFzlXwIiw0Yf04dK8NAAbDa7WQnwyM+Tpg1siaw6en7XddI/F9ZCYO
 fUa0wWHvvQDUCb/2AJhLf0jPNSJKw/WwlPFjIHdY1gg2oflRf9Vu3md52vjRc3F6qU3E
 n/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+qZv+exKqyNjMxq3hyq93Xj2Gw1BgKFVEeuRR/mK2ME=;
 fh=D6xsa7zXv2DKqI1Kpa+lo7IXCppmZskPVMhFzOD9HMA=;
 b=qKO0avisw0IpopZ85uSzV5z6yKdR3+CTBo3wWJyJUqHALpPI1kCdfQzhhE5Jqqb0a4
 DtdCKkSc0ZkOwhdZhrFVChiXHXQfPXw6VLpgh4rtnrhaeYwp+TNwk0P1x09sqPo6/cvJ
 6Y1bTnxyY1n7Wn0NUHAHuffjOp9awTlEBEwhGcq9iqFE1eO6B53z/pwWmgCXF/aOACrc
 fWbkKaxKJzBAjJ0x43zH281gw3RbJt6C1Cgqs+ix/AUJJ6GYiHdW3OpnmSgNRUCOlQEL
 armpJLqgnKfqitvl4Q/wnO7J/qtNOFXM/RQLpHZOtRai6AXg9KpauZo4SSimcHULcV3r
 A/2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789717463; x=1790322263; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+qZv+exKqyNjMxq3hyq93Xj2Gw1BgKFVEeuRR/mK2ME=;
 b=NiF8bM/BVFc+y0jhedWdC7urQSVBj7PY2PwekVGpSO2xfG8KObxkaRaPYCi+f2dlk4
 dtOJRA1z7z2mVhRFXBdveosNMfJQRmzyNA0ADLB0ghFHb3tPNol4CrGV1NFUN7LgJN1m
 hzqzBZKV8T6DfAFu+4Awnmqb+M2g8uNGRkUtTTR2x40a70I3ZOof88G6Z1F2FduU/uyp
 qr8RqDBpHe2XcswLTVDXJi+RDlbeXUDHkMduNH1yX6DixYhg7kQnpBHJbCg68ax0bALa
 n9S2/hkRqduRyb73lQU+JwcGc5gSOaqBJTUZd90SVYG0mS0Ou4edkabSueAEKk8uF9hm
 l3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789717463; x=1790322263;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+qZv+exKqyNjMxq3hyq93Xj2Gw1BgKFVEeuRR/mK2ME=;
 b=pWHzkF6675k3vf5rstYw20Fo2B1aPK1jnHwgix7Sjzxf8WgYv94Sc+XVW6lIxdvMB9
 ay+5okypy6b4jbVK6EOhqKCLTUgL+DmAPUDo1zxcz4E9w4bdcaMN+me9T8mLQtHhrxgv
 uYdSbwlb87XZuSq2BjhKI7/guNLmCuvm4V+SGRIf/eFZjfyTIJDcK82IieleGnn3RuH6
 TUdsJFw0ow9/chVvOK7SN/dZMdCJivCnnIFLWP+Z06HJ1OOMM3AOf6PLUds4nWXojOeS
 X0vEK7eF0RWvX9fUPw9p/K/oI8WHvrTPPGyuegu50b/p4FCvau0UtT4gp9GlaQG1Ip5U
 5Q+w==
X-Gm-Message-State: AFuF++kIewPeBass487ui+lG6g8BupSRbqgH6awjdQGly3MqtWwow83R
 P/LhizNYMwUtF58N5AGqqC29r1/Qc+3EyKrLk1H8G+1EZkWwnutESRHNJdP9IMyPXsyb+VsnO16
 DDRa1UGneYhFRn6OA8txw1uCaIMcP4RLZR1tTYZyVBK/qS1wQAxpDQtInJPFK+4Y0hD0WAccXv7
 fdPZO1V/3b0qtgqjUFfCVnnxpxieLxdPE=
X-Gm-Gg: AYBFou11I60n3VzWitBRQ7pDwiHErwV4q3KCp2E1CnQslw0iOsYYxn3i5XMo80qsjdk
 VbyXmpXk0l8DHAVVFj96e3qIfMlIe3vx2cUtdHErjCI+YzxaWFnEcrzneZpL6d9RqXrxQpNWZlr
 NcSIN/flQA9UjAO9R9zdRPX+d1V202aw4gmLYLKvKlrT/uliq8gH5K5Nqn2Q==
X-Received: by 2002:a05:6820:4d06:b0:6b7:46e9:9703 with SMTP id
 006d021491bc7-6ca9c84e82amr1604085eaf.51.1789717463549; 
 Fri, 18 Sep 2026 00:44:23 -0700 (PDT)
X-Received: by 2002:a05:6820:4d06:b0:6b7:46e9:9703 with SMTP id
 006d021491bc7-6ca9c84e82amr1604072eaf.51.1789717463140; Fri, 18 Sep 2026
 00:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260721122135.6288-1-philmd@oss.qualcomm.com>
 <20260721122135.6288-4-philmd@oss.qualcomm.com>
In-Reply-To: <20260721122135.6288-4-philmd@oss.qualcomm.com>
From: Miroslav Rezanina <mrezanin@redhat.com>
Date: Fri, 18 Sep 2026 09:44:12 +0200
X-Gm-Features: AcwNN1V1QzfHhOgeL-HCPscnU3IMGupzuwJKmfRaIQ1HW7parCukC29xzHF9Ids
Message-ID: <CAKRGJ0CnGvU3Je5B3duHF-vUOZGXeMk5f0YFQbC+=vbGp++j0g@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/arm: Only compile gicv5-cpuif.c when GICv5 is
 selected
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mrezanin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

looks like this patch was applied incorrectly. I do not see removal of
gicv5-cpuif.c from unconditional adding. Is this being fixed?

Mirek

On Tue, Jul 21, 2026 at 2:24=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Only compile gicv5-cpuif.c when ARM_GICV5 is Kconfig-selected,
> otherwise we get when building with --without-default-devices:
>
>   Undefined symbols for architecture arm64:
>     "_gicv5_activate", referenced from:
>         _gicr_cdia_read in target_arm_tcg_gicv5-cpuif.c.o
>     "_gicv5_deactivate", referenced from:
>         _gic_cddi_write in target_arm_tcg_gicv5-cpuif.c.o
>     "_gicv5_get_hppi", referenced from:
>         _gic_hppi in target_arm_tcg_gicv5-cpuif.c.o
>     "_gicv5_request_config", referenced from:
>         _gic_cdrcfg_write in target_arm_tcg_gicv5-cpuif.c.o
>     "_gicv5_set_enabled", referenced from:
>         _gic_cddis_write in target_arm_tcg_gicv5-cpuif.c.o
>         _gic_cden_write in target_arm_tcg_gicv5-cpuif.c.o
>     "_gicv5_set_handling", referenced from:
>         _gic_cdhm_write in target_arm_tcg_gicv5-cpuif.c.o
>     "_gicv5_set_pending", referenced from:
>         _gic_cdpend_write in target_arm_tcg_gicv5-cpuif.c.o
>     "_gicv5_set_priority", referenced from:
>         _gic_cdpri_write in target_arm_tcg_gicv5-cpuif.c.o
>     "_gicv5_set_target", referenced from:
>         _gic_cdaff_write in target_arm_tcg_gicv5-cpuif.c.o
>
> Fixes: ee0f1ce00db ("target/arm: GICv5 cpuif: Initial skeleton and GSB ba=
rrier insns")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  target/arm/tcg/meson.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 573e8b5af48..1cd98c1b857 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -83,11 +83,13 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64',=
 if_true: files(
>  arm_common_system_ss.add(files(
>    'cpregs-at.c',
>    'cpu32-system.c',
> -  'gicv5-cpuif.c',
>    'psci.c',
>    'tlb_helper.c',
>    'tlb-insns.c',
>  ))
> +arm_common_system_ss.add(when: 'CONFIG_ARM_GICV5', if_true: files(
> +  'gicv5-cpuif.c',
> +))
>  arm_user_ss.add(files(
>    'tlb_helper.c',
>  ))
> --
> 2.53.0
>
>


--=20
Miroslav =C5=98ezanina
Virtualization Team - Maintainer


