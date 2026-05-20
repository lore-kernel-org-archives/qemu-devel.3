Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ACBCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgdq-0003on-6a; Wed, 20 May 2026 09:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wPgdn-0003oD-Sh
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wPgdm-0000nk-1y
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779282433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6I0pJv37EVNCGjVb72egonkZ3GilOTtNppIucjTN79I=;
 b=K9sk0WHASyJJIoZCpennhfaTQDb4bDhq0D5cdNcmLHHppMnEocr7GQsbbrX86I+vTB6s82
 cdAwPCo5iJIqxQEiJCnpKyuZy2B5GpqvtI8CyjCMjBLKTd2tq1P88XZRaSQePb8xs3gi8E
 NPS6u7bJUlqB0L78RF62f3xl3VbBUWc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-7d1UChgOONWhV7oe6y79sg-1; Wed, 20 May 2026 09:07:07 -0400
X-MC-Unique: 7d1UChgOONWhV7oe6y79sg-1
X-Mimecast-MFC-AGG-ID: 7d1UChgOONWhV7oe6y79sg_1779282427
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fe44ce385so39268635e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 06:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779282426; x=1779887226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6I0pJv37EVNCGjVb72egonkZ3GilOTtNppIucjTN79I=;
 b=RRSQjWvkGmEpAOAy5UPEQSG/HzmmSZEqixrdG40WkHaV6JahZdqtTqR6tLfytUZw+h
 ao9yj0tCPS9kjHPA+E1lQ+B7+kOwFE/kSbDcrrUF1rlNeSlYl59qnssPGGpJ/MKvjGVQ
 l4SiUtdXmIMzOAk4/g0prK1ep4/pr636KZ4SyxTt2zNKxvbHHD+PvqLIkm2fCWYQg8Y+
 abI5MHl9zBhy8LbOmBCaF189vBUk2AXNAKZfr4qFOJaUdURnPKMKYryOMn+3uCHT21ip
 cFd+LgVOCmuNfbQ+hcYFaIOXdpQ02QWNXfsY8p+EWJlXcw1Br2t2Py5IfSENguGIjRBM
 8Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282426; x=1779887226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6I0pJv37EVNCGjVb72egonkZ3GilOTtNppIucjTN79I=;
 b=K6VFLsM/fakQeNwNg3eZMC7iDZc+AQ8XST9wXumKv/3x5nSC8CENkbjZhaIqRNsxo9
 8fjpi09JodR66D5RxBDPO43c8AXiSfL0DG3JdGZO6zbAceZ7jobeMhwiEfPYmr0YIfUW
 whx2OCZ80l+BUnTf3s8pisrgNEb/NuGSIUGTsyIGVoucTBjqYytQBK8nqRs7/EUjzFOk
 okXTQpF8WwK8ntzSkEql1URqaETIer9R7ZKLRTstFDcHosQQRQLQwANkuezt9l7KZttJ
 gj7LvpsJRpbEUn9/acRYojAS18z/2H6TbkDKSBpH2He185fqZp5zr9kvWp+lCZHAuR0p
 UIJQ==
X-Gm-Message-State: AOJu0YyMiMV7xH3ftnmpYNsJTunF8/F/e4LXu+mv8mAUrJwt/F9k3u7K
 kNRk4I9AsUbAJU5SLNaAi+dSihbuj5UGnNjGiBzVxxuGbpv9+ewgvYqGy/4wJyZN7vJb+d+KYLw
 lh5Rhpi3+tdJJ1auhjHGNEK5rZIASOSUfpSaDB3WDCwKQoYJnlzKbkkK+
X-Gm-Gg: Acq92OGjPcmVnAeTk1icikqFJ6HGDkvKgqWgUArz23abJe3t28K45hnG1vlB+q4xVdp
 1rs66IBgG5STyevFjcAMpwDvlvClTOx2VCPLYPJT/L7zk+ZFLV+yUVNlOqaPuM79If+VA19Y5ez
 R9b+vhuhg+XlhUA35VYKHW0zNJxHtvh4QqBP6sJYKi2LI22JfQbFkLOJQJRbWmXeeGZ5Erqfskb
 cSS7MiBwsF7BfjYs10nkS6FxGSCtLSnFI1FRM/hW6u2uJ4B7YbMArUAx7OvDb0zb7vv3IZsiGzL
 eNDXQNNE2XCzpzcIjMP6JXgJGKXDsqGP7ydF6S+Hg6x5PfzBOdbsPRENOn3GxO0MC1SrLTQvocS
 ++uH2qA==
X-Received: by 2002:a05:600c:45c6:b0:490:2248:dc93 with SMTP id
 5b1f17b1804b1-4902248dcd5mr89950695e9.12.1779282426376; 
 Wed, 20 May 2026 06:07:06 -0700 (PDT)
X-Received: by 2002:a05:600c:45c6:b0:490:2248:dc93 with SMTP id
 5b1f17b1804b1-4902248dcd5mr89950195e9.12.1779282425911; 
 Wed, 20 May 2026 06:07:05 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febf8305dsm193067775e9.9.2026.05.20.06.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:07:05 -0700 (PDT)
Date: Wed, 20 May 2026 15:07:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>, Andrew Jones
 <ajones@ventanamicro.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mohamed Mediouni
 <mohamed@unpredictable.fr>
Subject: Re: [PATCH v6 1/4] test/acpi: aarch64/virt: Test version 11.0
Message-ID: <20260520150704.136d08a3@imammedo>
In-Reply-To: <20260520-virt-v6-1-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
References: <20260520-virt-v6-0-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20260520-virt-v6-1-d96180454fdf@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 20 May 2026 18:56:30 +0900
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:

> A future commit changes the memory map for the latest version of the
> machine. Test that the memory map of the previous version is preserved.
> 
> Suggested-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 510751799e48..00e62699197a 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2214,6 +2214,28 @@ static void test_acpi_aarch64_virt_tcg(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_aarch64_virt_tcg_11_0(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .machine_param = "-11.0",
> +        .arch = "aarch64",
> +        .variant = ".11.0",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 128ULL * MiB,
> +    };
> +
> +    data.smbios_cpu_max_speed = 2900;
> +    data.smbios_cpu_curr_speed = 2700;
> +    test_acpi_one("-cpu cortex-a57 -machine ras=on "
> +                  "-smbios type=4,max-speed=2900,current-speed=2700", &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_aarch64_virt_tcg_topology(void)
>  {
>      test_data data = {
> @@ -2851,6 +2873,8 @@ int main(int argc, char *argv[])
>      } else if (strcmp(arch, "aarch64") == 0) {
>          if (has_tcg && qtest_has_device("virtio-blk-pci")) {
>              qtest_add_func("acpi/virt", test_acpi_aarch64_virt_tcg);
> +            qtest_add_func("acpi/virt/11.0",
> +                           test_acpi_aarch64_virt_tcg_11_0);
>              qtest_add_func("acpi/virt/acpihmatvirt",
>                             test_acpi_aarch64_virt_tcg_acpi_hmat);
>              qtest_add_func("acpi/virt/topology",
> 


