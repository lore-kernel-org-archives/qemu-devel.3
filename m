Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C74D58E62
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwzH-00054x-6V; Mon, 02 Mar 2026 01:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vwwzD-00054k-JX
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:42:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vwwz9-0000dQ-72
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772433749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94t3d1DnajmwAUjIQOTDQXz9ZrvJN9qYvqN05wRPZb4=;
 b=XeajP3Wc8K8IDOaT06JrxvZM06x9Z1sDe86+xR0g8WJr3FImRlhpM802uwu7eI58KwL7Gr
 9fXwGuIOX815/iBNQfNAJQhUs8dFa8TRM1/rdc8mZT1GIcNYA8meYZ/jYvWwtgBCGYGvvj
 EcwK4wEGAkudmZvJEtvBouXmWprkuDA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-lM2kEPhbMU6KJfpP9sGIlA-1; Mon, 02 Mar 2026 01:42:27 -0500
X-MC-Unique: lM2kEPhbMU6KJfpP9sGIlA-1
X-Mimecast-MFC-AGG-ID: lM2kEPhbMU6KJfpP9sGIlA_1772433747
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439b4e653d2so617145f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 22:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772433746; x=1773038546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94t3d1DnajmwAUjIQOTDQXz9ZrvJN9qYvqN05wRPZb4=;
 b=Y84Y10juWCpxRvlfRaHQMi642T5k8t9NUx/igRJUn6TsLdzhLbbbrH18jfan5hdHeM
 HFwqiCzmvGTl9DG3foyerw+1GwbDAoHgSX/kfpdAvxstVmsZCyz1ok5rIUzP6s0S7hYh
 QQW+Hz9tAuc4EzSGuPpEfrxLFCz5JfcDKSdFuzWi5K8E6TebBJ6wxsPwJk8Pe5hUAB5b
 UHcZ7ETevjCcdg7h8AkIrwxXUcUM7qQcXdYJJMZOvhMEy51mxo+ZWPz0S0hAhXz0y18r
 BDi3CYkRtZ/ix4xTTOascmKfS3xKKZ25sRJ9VmFWXd8g6/kZxugbZ5TmU6TnLdrepO4Y
 4LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772433746; x=1773038546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=94t3d1DnajmwAUjIQOTDQXz9ZrvJN9qYvqN05wRPZb4=;
 b=pr+keCh90ZsLnTeCMMB/jlfWm20yoL+k5HRNHLFyRnrsDmef6z55Mau1HT+niGvXJ4
 nrGLPyt0qYEwMwRZB+BndI5Fzpy7vondcAwW1Wrs1SUm8a/X5hSz0x2EAUbE/bXC84UU
 4Bfn97rgnIgpW46tthjW9zMCDKPonrk7zQbj4O5w94UN42GqRO3Cmxnqlq15sHWXScrh
 50dM0cQfA4w8DHIYjXnxLLoLOOjH3+2nk0L3xMIO+gzEuG9JaRZNggt6Npx9M/g559iX
 mQ0UTfpCYZdXG7y7CES4LxotKaOZ1WcLiE7DbItBBtt5O3s/upsM/OtcgdyUrsDSie1w
 5fdA==
X-Gm-Message-State: AOJu0YwGQEWf1cMf8xmNJZeZWQIEKbUnJNuhc4WY9gUiGzOUjgzM/wc7
 zgjEVXYriUPu5WvRgh+c2tRQGSm99qJpwKsBRmV0ovSYhIoPdWLMS6rvcJ5bfsajv7Q+YItk7J2
 On/ZUGs5WrXo85WkRn8LpuDqiWa4xXb0HDMnJtzeET17SWtA1t+Dk/vUN
X-Gm-Gg: ATEYQzzykqc3REuhvylkGVlJx7ceqOR7klrHAOxkUVJqamhQpp2m+e8huWS2+dDDaK2
 bmA01Ns8l9YpS/joEuKwzv141YZLBDqUchtzTC9JlkihCkXwDzH3eIxBxCuhFvu3G8zTfEQZlqA
 oy9xe7lxFTuidIu3DYg0DA62/+AQP/Tv19Okzmq/DobOUnIUI+0hf4UUTJbSjE5/+FDWOkbL6Wn
 TRnIrVAC9yBYvUsUeOwiJ9Had+I4gKqDufW1FvzxdRSYTN+MaA/iBaEkIXW2lfTXD1Xao/So7ew
 OZLrChiJNfSsiYBy/nWfyKYjXoUVc9GarwOqdexibi8PQ38B4gmlSubJWbltW5QqG9VOtgy5+O0
 m1Cb/8g==
X-Received: by 2002:a05:6000:26c6:b0:439:b7c9:2ef0 with SMTP id
 ffacd0b85a97d-439b7c931f8mr3430291f8f.33.1772433746544; 
 Sun, 01 Mar 2026 22:42:26 -0800 (PST)
X-Received: by 2002:a05:6000:26c6:b0:439:b7c9:2ef0 with SMTP id
 ffacd0b85a97d-439b7c931f8mr3430260f8f.33.1772433746111; 
 Sun, 01 Mar 2026 22:42:26 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b130abfasm9763121f8f.34.2026.03.01.22.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 22:42:25 -0800 (PST)
Date: Mon, 2 Mar 2026 07:42:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 06/11] hw/acpi: Build stubs once
Message-ID: <20260302074224.7e5fcfcb@imammedo>
In-Reply-To: <20260225035739.42848-7-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
 <20260225035739.42848-7-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

On Wed, 25 Feb 2026 04:57:34 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Move stubs to the global stub_ss[] source set. These files
> are now built once for all binaries, instead of one time
> per system binary.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/meson.build | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index e1e848327b9..1c5251909b4 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -6,33 +6,36 @@ acpi_ss.add(files(
>    'utils.c',
>  ))
>  acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c'))
> -acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_false: files('acpi-cpu-h=
otplug-stub.c'))
> +stub_ss.add(files('acpi-cpu-hotplug-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_true: files('memory_h=
otplug.c'))
> -acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_false: files('acpi-me=
m-hotplug-stub.c'))
> +stub_ss.add(files('acpi-mem-hotplug-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_true: files('nvdimm.c'))
> -acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_false: files('acpi-nvdimm-stu=
b.c'))
> +stub_ss.add(files('acpi-nvdimm-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
> -acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: =
files('cxl-stub.c'))
> +acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'))
> +stub_ss.add(files('cxl-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_even=
t_device.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
> -acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false=
: files('ghes-stub.c'))
> +acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'))
> +stub_ss.add(files('ghes-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_true: files('pci-bridge.c=
'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_true: files('pcihp.c'))
> -acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug=
-stub.c'))
> +stub_ss.add(files('acpi-pci-hotplug-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco=
.c', 'ich9_timer.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
> -acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: fil=
es('ipmi-stub.c'))
> -acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
> +acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'))
> +stub_ss.add(files('ipmi-stub.c'))
> +stub_ss.add(files('acpi-x86-stub.c'))
>  if have_tpm
>    acpi_ss.add(files('tpm.c'))
>  endif
> -system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-b=
uild-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
> -system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridg=
e-stub.c'))
> +stub_ss.add(files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c'))
> +stub_ss.add(files('pci-bridge-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
>  system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
> -system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.=
c'))
> +stub_ss.add(files('ghes_cper_stub.c'))
>  system_ss.add(files('acpi-qmp-cmds.c', 'acpi_interface.c'))


