Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83CBC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 10:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0eUP-0006vR-Gi; Fri, 04 Apr 2025 06:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0eUH-0006ub-Sp
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1u0eUD-0005Pg-Qv
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743763277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YiKiZDA8EWFpdbB+bNybfbo35qu9M0V7x/neLlvqdns=;
 b=UmI/cEhgvRoTXP4UwbSOL5BCtaKrNvJC8GMPmh2WojsoKtglNamVRLYVfkPTy1TNa8EQWW
 jqWneuo35if0k3lUkpAMwPRkE3eO8hVxqA6Z5JQoNvSHOjtZHmegQHJCfL1xVxfL8dW0oC
 s0O4WdRRcWUkBhrDhdQL/UribgrFtM0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-PMkIf3_mNPSgOKnPCzx4cg-1; Fri, 04 Apr 2025 06:41:15 -0400
X-MC-Unique: PMkIf3_mNPSgOKnPCzx4cg-1
X-Mimecast-MFC-AGG-ID: PMkIf3_mNPSgOKnPCzx4cg_1743763275
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso11476515e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 03:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743763274; x=1744368074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YiKiZDA8EWFpdbB+bNybfbo35qu9M0V7x/neLlvqdns=;
 b=uO/8Y0PHMLdCQ2c/t/vocaFMjlHBMgYsPmD3gGA+iqVxGBVemA1B0+F9GR3wJWo1oo
 PWh1QuRe9NPaRWNal9cCMmpHkzTSHGUPJuttsYpNwvu4FrI4icmAojRP5DNOtNGGbyLw
 B62qIgHduXivOdIzS5evLuXDBBqwZO9OAHXbpsRmKR3UG1zyz3U7YXOPhGRJYfjgpD40
 2heRf8mGzwetVB0awQMEgTX+vn2ZVUfF8w3SB/La8zfO8nkOkC5tMkcpkzI6tjigdwvI
 1bjgzmHuD/iKHvDEBCCi43PqwzVveMJZFpzWGi73XrnNlEGmVppUF/cvckiNcEH+dBLv
 HxJQ==
X-Gm-Message-State: AOJu0Yz9hAmzr3Pbx43egkObnjnRLsYj8bsZKqE3XWTFd0w84jV/SCcd
 GmPYPPbmj3yMUZ6KZZNXsYTmoleKVtkgqH+EAJurLC8JGSBtgRKWj+v6ZcnpMNoob68M9Gp38kW
 CoiRT/QIaLACeJxHmePsFdtILGiHs446xqLNhVg0oiJPsh1CZEsjU
X-Gm-Gg: ASbGnctfNSk9p2tFsYso1g5YXM/q4i1/S0WdNaoZVM5upa0ed8fivjAwFXXE3lvPWn8
 pYf5kpkvpPSbNwbwa4yHH8p09JH1R0bOJ5k651tQEgPYUA8n6B9l8/tkuOdVYqQsDzuLAZApXDk
 ytlozQud26rIEhctC/MPXWR8NT/8KrmGqnG03eXibZn1TzV378UT/zA2Qu9CZwvawc7I3Bt3/yw
 NXX/bQk9A6qFl41npvsJ46nkJduDQY9DPi9v4aTeahiRdSXIbIxCL1944lrnO3Wb6wr9RnJeYSx
 hwFCVlr14xwy/sftMSXAwlPkWFoSOsxM53fF
X-Received: by 2002:a05:600c:1384:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-43ecf85f526mr23258985e9.13.1743763274637; 
 Fri, 04 Apr 2025 03:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsMf3dRmTkBQ4hC2tUNLG0Vm6Ba2h4iX6WAp3X/7eAp7kNLooPZzf9X1AaFau/iYEZw9lK4w==
X-Received: by 2002:a05:600c:1384:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-43ecf85f526mr23258635e9.13.1743763274263; 
 Fri, 04 Apr 2025 03:41:14 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096896sm4092874f8f.19.2025.04.04.03.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 03:41:13 -0700 (PDT)
Date: Fri, 4 Apr 2025 12:41:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>, Udo
 Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones
 <ajones@ventanamicro.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>
Subject: Re: [PATCH-for-10.0? v2 13/14] hw/arm/virt-acpi: Do not advertise
 disabled GIC ITS
Message-ID: <20250404124110.59c59dc3@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250403151829.44858-14-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-14-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  3 Apr 2025 17:18:28 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> GIC ITS can be disabled at runtime using '-M its=3Doff',
> which sets VirtMachineState::its =3D false. Check this
> field to avoid advertising the ITS in the MADT table.
>=20
> Reported-by: Udo Steinberg <udo@hypervisor.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2886
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e7e27951cb9..38a9e6fe0c5 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -212,7 +212,7 @@ static bool its_enabled(VirtMachineState *vms)
>  {
>      VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
> =20
> -    return !vmc->no_its;
> +    return !vmc->no_its && vms->its;

It's confusing have both no_its and its,
it would be better to lean this mess up (i.e dedup or rename if something i=
s poorly named)

>  }
> =20
>  /*


