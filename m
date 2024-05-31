Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1584C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0QO-0004zi-MY; Fri, 31 May 2024 07:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0QM-0004zQ-Uf
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0QL-0004fz-7M
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717154872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQXLkmaihewQQ+Q3DK3T/I1QdWmZfEA3y+2sPA08/tU=;
 b=XDiK3siC4+WHNeu/eyppdmiG5fCLhC/pbhtNvXu1dAnSgk+V1HZc4SX9mjOkBLQr5+MziU
 wQpnRtD4U3MQV+/Etuf7bQECACEJEvj46Gdp6RbeRzIAjnI+FC3sowd5m0/ecO9h+9gske
 j3PWfvdP/5Loibc64/T8RpAYlkFodww=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-OJ8UFm0aMuCQbFfm5Lw8Jg-1; Fri, 31 May 2024 07:27:51 -0400
X-MC-Unique: OJ8UFm0aMuCQbFfm5Lw8Jg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35e0e59dcf7so375279f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717154870; x=1717759670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQXLkmaihewQQ+Q3DK3T/I1QdWmZfEA3y+2sPA08/tU=;
 b=B1wYIvLCDHny2utbXyOEQoWFMouRgLrFjMSqwH42iMD062J2Al7Q+31eEBjC+G/2DD
 LURWs9N6362hrIFOjsUBijALt9eil70dQLvjFP1UjctemllU5T4EHPo33o0jW3xsC5F4
 Xxi1ygqvyHhNWFUh6fAgvH4TRDF4VCG8tRlidZ+R8OIzUfxNkU2VSCEaK07jodcq+Yj1
 vluM22hAyeiOW4FUvmNWcsivAXV0FKKmQefeTqCVpQtEo3JTKxmVr/YZvZatjt/U3+p8
 BlQ4XcXfX0S4LopqFTk9uBtDBujYq3ZqSvnZoirbqWiU6/vKiP8t9N9+RqP9jlnU/G71
 2qOg==
X-Gm-Message-State: AOJu0YzM0w72ZQzBc+YO2lN6MZyGgdKTKKMkSJVuVc0MQZIMiJHeTwJS
 niLjx3SszpVlFiSmD9MaoGjd/ZlOozqHnAV6AZhOznyPcp2a3Oh+4P23fKYlscPRbXfAjEWrueU
 qmLFICMQSChn7se7abOvUrt0HnWDZykIJgp9EltoB5Lwpp3LQxcN4T3eDDOBDYpP8VK8EupUrBq
 kuQus3ieMBAE6VDxiJbh7/Ipa672g=
X-Received: by 2002:a5d:5388:0:b0:355:3cc:485f with SMTP id
 ffacd0b85a97d-35e0f26e9bfmr1067082f8f.21.1717154869825; 
 Fri, 31 May 2024 04:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh2AwYrrRRWkZx282BhkBX/chfbWOE/90tS5yY6z39+zH4RCTmIFYdxi76wrQjyOesvxCcffaKzl7ahUeX8LE=
X-Received: by 2002:a5d:5388:0:b0:355:3cc:485f with SMTP id
 ffacd0b85a97d-35e0f26e9bfmr1067061f8f.21.1717154869422; Fri, 31 May 2024
 04:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-28-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-28-pankaj.gupta@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 13:27:36 +0200
Message-ID: <CABgObfZ48ukQ5UaLqi01Xc7Rs+Lo+iiKkFcSMd4qq_RFz1+-TA@mail.gmail.com>
Subject: Re: [PATCH v4 27/31] hw/i386/sev: Use guest_memfd for legacy ROMs
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com, 
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 30, 2024 at 1:17=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
>
> From: Michael Roth <michael.roth@amd.com>
>
> Current SNP guest kernels will attempt to access these regions with
> with C-bit set, so guest_memfd is needed to handle that. Otherwise,
> kvm_convert_memory() will fail when the guest kernel tries to access it
> and QEMU attempts to call KVM_SET_MEMORY_ATTRIBUTES to set these ranges
> to private.
>
> Whether guests should actually try to access ROM regions in this way (or
> need to deal with legacy ROM regions at all), is a separate issue to be
> addressed on kernel side, but current SNP guest kernels will exhibit
> this behavior and so this handling is needed to allow QEMU to continue
> running existing SNP guest kernels.

[...]

>  #ifdef CONFIG_XEN_EMU
> @@ -1022,10 +1023,15 @@ void pc_memory_init(PCMachineState *pcms,
>      pc_system_firmware_init(pcms, rom_memory);
>
>      option_rom_mr =3D g_malloc(sizeof(*option_rom_mr));
> -    memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
> -                           &error_fatal);
> -    if (pcmc->pci_enabled) {
> -        memory_region_set_readonly(option_rom_mr, true);
> +    if (sev_snp_enabled()) {

Using sev_snp_enabled() here however is pretty ugly...

Fortunately we can fix machine_require_guest_memfd(), which I think is
initialized later (?), so that it is usable here too (and the code is
cleaner). To do so, just delegate machine_require_guest_memfd() to the
ConfidentialGuestSupport object (see patch at
https://patchew.org/QEMU/20240531112636.80097-1-pbonzini@redhat.com/)
and then initialize the new field in SevSnpGuest's instance_init
function:

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1c5e2e7a1f9..a7574d1c707 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2328,8 +2328,11 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data=
)
 static void
 sev_snp_guest_instance_init(Object *obj)
 {
+    ConfidentialGuestSupport *cgs =3D CONFIDENTIAL_GUEST_SUPPORT(obj);
     SevSnpGuestState *sev_snp_guest =3D SEV_SNP_GUEST(obj);

+    cgs->require_guest_memfd =3D true;
+
     /* default init/start/finish params for kvm */
     sev_snp_guest->kvm_start_conf.policy =3D DEFAULT_SEV_SNP_POLICY;
 }


Paolo


