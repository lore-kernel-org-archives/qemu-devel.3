Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7836CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 12:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu8ma-0008PS-Kr; Thu, 04 Sep 2025 08:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uu8mG-0008Md-5v
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uu8lz-0003yH-3y
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756987740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGfsbECkN8yDi9zfYlQG8Tqcfjb7p7ijr5WocyCehHg=;
 b=N3OpXnB5C99ONu8j1eaM5TXj0EEeRyBKKjwTbLoThxg1FmFdgaZIvd8ZjD7ynAEoxB4UZ0
 ECBoDhp4RJOIT1sZPjRvYcmoK6p3Zts7iLul8dvyKlzjLTitIQd/1fnaf2zHbAwF13G3VQ
 6iTS8wFEmBn7Mcl0RDA1fGRH+z5kJHQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-1U8ze165OL-Oo4fze-zXMw-1; Thu, 04 Sep 2025 08:08:56 -0400
X-MC-Unique: 1U8ze165OL-Oo4fze-zXMw-1
X-Mimecast-MFC-AGG-ID: 1U8ze165OL-Oo4fze-zXMw_1756987730
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45dcfc6558cso6155435e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 05:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756987729; x=1757592529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGfsbECkN8yDi9zfYlQG8Tqcfjb7p7ijr5WocyCehHg=;
 b=CmSNToprnlc3Z/o5ZNivLRIHehvCOUeoTFLh0E/uEMwlz7tAR10ybhwItEPwO2HmP5
 gnM2SNzJm6thp7LLSiL65Ib/AJQVr2MviNioXexKCaGsPwy/2D/gkVrjh+KxC7di+cds
 WuFZ4DYOupRkYKiagxmrHnNCI0UvpIqPjLbHd43hE/qMAZdUZ82i6VrHvPtEi1yagev1
 z83Qt9SIBNqFaCcqlrZAMvgFR0CzbwR0sZRDOTIcnjtRxhwCvGECOnA1r401tWrLZtJB
 THKZKDYzdF3E6D4vwBsngBWEoZDdmHbcrPBgQyHYAAzn5zPX4bQAsozrX+zVwvnlKzL3
 /Ytg==
X-Gm-Message-State: AOJu0YzdxA2tZ7dBL7m6QD8sA0D+s/80Z0o2FJC6FlcjZ1ZELOlYw87v
 roxQb9vpUDm8BBuquGVZnPFNca8kO6IDafpZsx7xpN/cW/SDea3IVEIzhRSA23wy1ptxjMcxzSV
 tmLDUHYNTNcuuPVLrl6y2HL11nW2H3RrAW+3lF1Hby2xuj6KqseKrraU0j1z0GBKGmcA=
X-Gm-Gg: ASbGncu+b9nGrWGy+aDt13C8qp+1ox4+Jx47XPbntYXRNqUpxNX/O1rgi8KumhuS1OG
 BFzWshkN9wZT4TTnAdfsB20tGPmubAPvXDYy4jBUktwotOsxoPD+VaVt/pi4dUj8IAren1QXHdn
 pvuZmrMo/ByV2B22wyXFYhV2giKW9UDjlWS1u+8IfXRe7dcx8px7CWV+cUCsviCYItAM6SdiiH6
 ByC9d7XO3fDmtPKTfzbsTmDzBaXizFIhUu29ZC00Z76xFKPGWJSs33PdSvHcFvZzZwhwPjREd64
 K/BGHSdli0gVFOjOXuzgNcclf1UxGw==
X-Received: by 2002:a05:6000:2681:b0:3df:1a8b:ff40 with SMTP id
 ffacd0b85a97d-3df1a8c028amr3675212f8f.43.1756987729331; 
 Thu, 04 Sep 2025 05:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX0PPz3yh7ncUtLm/xW0ZxJtT+AldckvinW77LYH+EITFhgO23Jx24JW/wmCpN9gO6bSEhZg==
X-Received: by 2002:a05:6000:2681:b0:3df:1a8b:ff40 with SMTP id
 ffacd0b85a97d-3df1a8c028amr3675186f8f.43.1756987728720; 
 Thu, 04 Sep 2025 05:08:48 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d53fda847dsm18324880f8f.0.2025.09.04.05.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 05:08:48 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:08:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Huacai Chen
 <chenhuacai@kernel.org>, Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 qemu-arm@nongnu.org, Fam Zheng <fam@euphon.net>, Helge Deller
 <deller@gmx.de>, Matthew Rosato <mjrosato@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, qemu-rust@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 qemu-riscv@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>, Liu
 Zhiwei <zhiwei_liu@linux.alibaba.com>, Riku Voipio <riku.voipio@iki.fi>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Laurent Vivier <lvivier@redhat.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, qemu-ppc@nongnu.org, Stafford Horne
 <shorne@gmail.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Jagannathan
 Raman <jag.raman@oracle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@lists.libvirt.org, Mads
 Ynddal <mads@ynddal.dk>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jason Herne <jjherne@linux.ibm.com>, Michael Rolnik <mrolnik@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Ilya
 Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, Kostiantyn Kostiuk <kkostiuk@redhat.com>, Kyle
 Evans <kevans@freebsd.org>, David Hildenbrand <david@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Warner Losh <imp@bsdimp.com>, Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>, John Snow <jsnow@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Alistair Francis <alistair@alistair23.me>, Marcelo
 Tosatti <mtosatti@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost
 <eduardo@habkost.net>, Aurelien Jarno <aurelien@aurel32.net>, Richard
 Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, Alex
 Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Roman Bolshakov
 <rbolshakov@ddn.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Cleber
 Rosa <crosa@redhat.com>, kvm@vger.kernel.org, Song Gao
 <gaosong@loongson.cn>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Leif Lindholm
 <leif.lindholm@oss.qualcomm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Michael Roth <michael.roth@amd.com>, Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, John
 Levon <john.levon@nutanix.com>, Xin Wang <wangxinxin.wang@huawei.com>
Subject: Re: [PATCH v2 001/281] target/i386: Add support for save/load of
 exception error code
Message-ID: <20250904140844.5b670290@fedora>
In-Reply-To: <20250904081128.1942269-2-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
 <20250904081128.1942269-2-alex.bennee@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  4 Sep 2025 09:06:35 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> From: Xin Wang <wangxinxin.wang@huawei.com>
>=20
> For now, qemu save/load CPU exception info(such as exception_nr and
> has_error_code), while the exception error_code is ignored. This will
> cause the dest hypervisor reinject a vCPU exception with error_code(0),
> potentially causing a guest kernel panic.
>=20
> For instance, if src VM stopped with an user-mode write #PF (error_code 6=
),
> the dest hypervisor will reinject an #PF with error_code(0) when vCPU res=
ume,
> then guest kernel panic as:
>   BUG: unable to handle page fault for address: 00007f80319cb010
>   #PF: supervisor read access in user mode
>   #PF: error_code(0x0000) - not-present page
>   RIP: 0033:0x40115d
>=20
> To fix it, support save/load exception error_code.

this potentially will break migration between new/old QEMU versions
due to presence new subsection. But then according to commit message
the guest might panic (on dst) when resumed anyways.

So patch changes how guest will fail
(panic: old =3D> old, old =3D> new
 vs migration error: new =3D> old ).

Peter,
do we care and do we need a compat knob to make existing
machine type behave old way?

>=20
> Signed-off-by: Xin Wang <wangxinxin.wang@huawei.com>
> Link: https://lore.kernel.org/r/20250819145834.3998-1-wangxinxin.wang@hua=
wei.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/machine.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index dd2dac1d443..45b7cea80aa 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -462,6 +462,24 @@ static const VMStateDescription vmstate_exception_in=
fo =3D {
>      }
>  };
> =20
> +static bool cpu_errcode_needed(void *opaque)
> +{
> +    X86CPU *cpu =3D opaque;
> +
> +    return cpu->env.has_error_code !=3D 0;
> +}
> +
> +static const VMStateDescription vmstate_error_code =3D {
> +    .name =3D "cpu/error_code",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D cpu_errcode_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_INT32(env.error_code, X86CPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  /* Poll control MSR enabled by default */
>  static bool poll_control_msr_needed(void *opaque)
>  {
> @@ -1746,6 +1764,7 @@ const VMStateDescription vmstate_x86_cpu =3D {
>      },
>      .subsections =3D (const VMStateDescription * const []) {
>          &vmstate_exception_info,
> +        &vmstate_error_code,
>          &vmstate_async_pf_msr,
>          &vmstate_async_pf_int_msr,
>          &vmstate_pv_eoi_msr,


