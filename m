Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F58CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 12:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSDqi-0004FT-Es; Wed, 27 May 2026 08:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wSDqe-0004F0-EI
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wSDqb-00082q-Lt
 for qemu-devel@nongnu.org; Wed, 27 May 2026 08:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779886736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iEQAfLvOet6qO6R1zNac4aqvvCu/csDx1DZhIdUpyCE=;
 b=QIuiGOL6e2WHjWHGIkGd/ZSyzo1nWO7hEFjxBPR5wAnqhWOBS5ZqVUHWjF3O4omyIaP/A8
 X5fT1kb8UemY26eG3duOZ6QCe3GljCsRY60dmORY15ryh15LNW/tuuUfLa6yRT+/gMEdtg
 0KcBFidNCB/W79AEayKaIYi1yo9wQ/s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-R3JzypXDP7qyTP1xLGfdZQ-1; Wed, 27 May 2026 08:58:54 -0400
X-MC-Unique: R3JzypXDP7qyTP1xLGfdZQ-1
X-Mimecast-MFC-AGG-ID: R3JzypXDP7qyTP1xLGfdZQ_1779886734
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ed830a0eeso1279581f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779886733; x=1780491533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEQAfLvOet6qO6R1zNac4aqvvCu/csDx1DZhIdUpyCE=;
 b=bPqOa1RRduvqexf/k+h5pcpifDLU2jE2rQyUBT5LDNqCn15oCRN40Jw6Iy3eaGUV8k
 4LsupOuLbHIjrNTPYy67EaK8gBg1Xjg+nWZmFfd8H5nGhFy+INUvAua49msUfKru2V00
 eFm4QC3ozZvtmbKBT/u0HS7FJpZCq72prgPA08Du9E6Qu56JpdmJwxxqCwa+BkaYNb8d
 BYEbZITtn77KN+vVkIGGR7TqOja2KI2FWvl106VIh3+KVTNPTupJuDlWUer6Q/wX2Tx6
 GhzWGnbP98alXScg9F+Dgh29IIK0U3SLhFZJnpow7e9c7SJY5AI0dzKGsxSDUxZBXuD9
 oy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779886733; x=1780491533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iEQAfLvOet6qO6R1zNac4aqvvCu/csDx1DZhIdUpyCE=;
 b=VaHccp5bq+xDy/hD+82DfwL9T7FtTzFW7p2t/vjz4CuhxMF1h4fiP2GXWM0YA4cNyh
 gRfqI/5YLijZ7mF05xFY09tzxt3fggS8HsvG9tgBoK0nJmFmnh67t6b/hgyc+duDDH98
 M4VP/VelZtb6RYNinKoHDpXl0om6pPNVB4d+RT3D5XWY97qM1LNoFWGrkODJ1fey1wEP
 ZQ6Tvk1Qbg9Xb98R3xPpVnaSMByNEMSGnolfPs4foYqBirZ+7eUTJgscQLVS2XO9lH9/
 ViaJok/GDl4nJjHuM2RZlr4N6nxufai5O1O0s2EnuNWO0xnYlSTmK3v0PpOAkQ4Sl4r3
 a0Qg==
X-Gm-Message-State: AOJu0YxzpKl0lxpi7cGdlEu6Ts9lm8yjrJ8Kf0SUZuGcOZ1u3jbv8idM
 +5b3hMI7M0RVYd2r8RMR1BNUZPYWoMyxg/fS9Yk1eC0XD+yNIJjsLYN9n9Xg+3hdlHy3sE2htlG
 To1SRgFiGGczLzNE6CyBEiDPYtF4OksKwFCtXWFqGsP70ukgOO7BzvdvW
X-Gm-Gg: Acq92OE3+oJJYdi+4O4Yrw0R+tvCKti2pyvFfzG6pdH6Mkj5ZHwitcYtltemPgcHJo+
 PL3aNV2Y2XWevdgkVbfIdkP1TFreWHuFOBOamr2CjiTByQBWWy0CJ5nLkC15Zmn0uigODmJmtt/
 UVoBWwBb2moOMg8pDIDL8dbPTsq9xVHEodIcpktS37D+CarhVUY6OLsV+FSnaVKeJYZCcLLphjH
 eydCrRRKYIpiOomR95GdT3IcWJ53po7W2tpUPHF+zLl6wjsJHXH5ZFxZEeK7aAiscVuuY27W4Ac
 7zWxOV3sihZvVSBbZr7bNYHABL7Ix3zqSRRbjwKGeHBi9MNZYR3Z3L0AAaic3NpxtT9sMACvGOF
 NT0bkrg==
X-Received: by 2002:a05:600c:a402:b0:48f:d1c0:721e with SMTP id
 5b1f17b1804b1-490426b294amr265356135e9.12.1779886733602; 
 Wed, 27 May 2026 05:58:53 -0700 (PDT)
X-Received: by 2002:a05:600c:a402:b0:48f:d1c0:721e with SMTP id
 5b1f17b1804b1-490426b294amr265355855e9.12.1779886733205; 
 Wed, 27 May 2026 05:58:53 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490809c2dc2sm16208485e9.28.2026.05.27.05.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 05:58:52 -0700 (PDT)
Date: Wed, 27 May 2026 14:58:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 16/21] tests: acpi: arm/virt: add GTDT watchdog table
 test case
Message-ID: <20260527145851.2b0abebd@imammedo>
In-Reply-To: <cba87a73-0458-445e-8c12-683ca639f2de@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-17-imammedo@redhat.com>
 <cba87a73-0458-445e-8c12-683ca639f2de@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 26 May 2026 16:44:08 +0200
Eric Auger <eauger@redhat.com> wrote:

> On 3/3/26 10:25 AM, Igor Mammedov wrote:
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  tests/qtest/bios-tables-test.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index 5082866184..11c6854af8 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -2290,6 +2290,24 @@ static void test_acpi_aarch64_virt_tcg_wdat(void)
> >      free_test_data(&data);
> >  }
> >  
> > +static void test_acpi_aarch64_virt_tcg_gtdt_wd(void)
> > +{
> > +    test_data data = {
> > +        .machine = "virt",
> > +        .arch = "aarch64",
> > +        .variant = ".gwdt",
> > +        .tcg_only = true,
> > +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> > +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> > +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> > +        .ram_start = 0x40000000ULL,
> > +        .scan_len = 128ULL * MiB,
> > +    };
> > +
> > +    test_acpi_one("-cpu cortex-a57 " "-device sbsa_gwdt", &data);  
> depends on the instantiation strategy, ie. whether Peter is OK with
> dynamic sysbus instantiation

machine option in v1 to do the same opened another can of worms
that I think consensus was it would be better go with -device. 

> 
> Thanks
> 
> Eric
> > +    free_test_data(&data);
> > +}
> > +
> >  static void test_acpi_q35_viot(void)
> >  {
> >      test_data data = {
> > @@ -2910,6 +2928,8 @@ int main(int argc, char *argv[])
> >              }
> >              qtest_add_func("acpi/virt/acpi-watchdog",
> >                             test_acpi_aarch64_virt_tcg_wdat);
> > +            qtest_add_func("acpi/virt/gwdt-watchdog",
> > +                           test_acpi_aarch64_virt_tcg_gtdt_wd);
> >          }
> >      } else if (strcmp(arch, "riscv64") == 0) {
> >          if (has_tcg && qtest_has_device("virtio-blk-pci")) {  
> 


