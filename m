Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D2E10F284B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69hM-0007sJ-S3; Fri, 27 Mar 2026 12:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w69hG-0007qc-29
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w69hD-0007S2-Dp
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774627562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d5BlG7VXayB4NIxCld9UAV+2pWD0xsl1hbPrvmQC20c=;
 b=PDXUHhKUC9OnE84Rf8i/a4wxZ0UHvCmLiZIUF8CBJQUN5u5DJHhHTrij6ruObwQunRj1DV
 Z6S9pY1Ndxga+DTj6Ebe7DtmmII7uM+1Ti4sEtjJpsRi3O2XJdwgcinJdOJ8pngj09b3Y+
 kj4114zzbF80KnZr7X/0BQRFY3i6w+M=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-VglncwqrNOGICcLdsVgMZQ-1; Fri, 27 Mar 2026 12:06:00 -0400
X-MC-Unique: VglncwqrNOGICcLdsVgMZQ-1
X-Mimecast-MFC-AGG-ID: VglncwqrNOGICcLdsVgMZQ_1774627560
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d7c848c866so2668161a34.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774627560; cv=none;
 d=google.com; s=arc-20240605;
 b=LV0b18Pc9OAuDbItdaC053eVLjI3ssCSVw/7rQAymrW5zz227jVENe1tJ6njwvKRq0
 1zQFFttY5ttwc4mH2r+RtUuNxKxvC9rEp0spNFS+YfioNQ15l+tEUcAMZ44llzfdh4ue
 uePj5H6vEYte7VAaOrrHVpaeNhzRI0MdgYmdCfYnMHCvtJEMXanJGKOeB0Cac7qG2z7r
 hq1+6Iyryq3jdTw/PS6pVT77TmK0WFTof0KGdzY35IwIuo1jRedIj6HnnNr+jt8U5Bt2
 VJv+zkIw9FuElUthL5AiepKMOYJ+77AZHyaFrTwJZrAQa0K8FNWW2NpBTDth9wYQUygR
 GhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d5BlG7VXayB4NIxCld9UAV+2pWD0xsl1hbPrvmQC20c=;
 fh=KMwhk4AtOdJrZxwM8eEuZN4U7UGeDFiSpz72qlp6giU=;
 b=IFOyMUwHS908zFHRIvwUHt2wmkLkhWI/jZ270b2FTOqjiR27UI7Id3KbUHS4enhRd2
 ijzu66B3vSdEzSV+CNpv6gqU2ab34Mau5gzqfJEw7gSCvbKHRB49xJyj+C3SnmTvwPgQ
 XGS5x4Kgv4fpFl+UCKru4ladXsxk9cA/akbVJTinNcx/h7QCEaSmYbdf0KLULX3uN0bX
 Vfc7PARvDu1MtmYgElSVSb0hkRzKW5VtbPeH/7etBlL5xXbZyc/7gSkzW249BBosfpHx
 6bhrSLnBqFMe7DAlte4zhHtI/N+iHcF5Nm8leGIg8jXpLxq0R89mIAxT5FDiTWXgjGSy
 Q0lA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774627560; x=1775232360; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5BlG7VXayB4NIxCld9UAV+2pWD0xsl1hbPrvmQC20c=;
 b=VlHYrT1OMHP/aTjLMxtNZk9gsfV2YogARXVz7eqtVyQjY8FwED4qaNQhwh7hD6Bu8/
 OyRWlrqDBKcieiIm6MeXgJP/fhQMWahzOGcORAB9qQXj1JDUsubSkJL+lZtafJWrGCVZ
 qBFLWqZMyyfYaLO5GrsnBq7y/V4CWcn+dig7fAgx5d8KtliIDOXXNCi+gjSMJ5m3oFWB
 tT4Ct/ajlzPJ5/WqnVNAD162Cz7haec8sh4heQTOi0F4lvhelakin3v9f8H+YqKes6YB
 /JjsYOtbGe3GsShjtMmoQCStgWSJmr+Jjp8n9aprKzW68sd8fM0b4o33eTz1hzM22ZLQ
 aouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627560; x=1775232360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d5BlG7VXayB4NIxCld9UAV+2pWD0xsl1hbPrvmQC20c=;
 b=srLRkw6nSXsadMXfvtBZm5sCLJZuxI19QuVrcBk+ItDgh6I67uFUJZPv65cAW9+ilu
 54y8Yzqll0sf27fxntK1gonboS+KvZOdcsMcmr3mPShuGwzRGRYrXw/fBS65uuVmoR4R
 NJMEGZ0Zu1xLJKW7Y6qys/0UxrDkYahYOIQsZw6O/rml7bYV7jkdGnP/MLA10+oafXGO
 htyopsPagDPj0QipNgTf47nWBoSHYXp7xJO3zUCn40+oqm0QvQ1hQ2QYe+BZyy5F0aT6
 F+TMaukc0MHjG+f98H7LHyO9GKIr+f18iOe6c3dfrcG6GeRSKN4HPYT4dkW2PFs8ijb4
 MK9Q==
X-Gm-Message-State: AOJu0YxQShTSVGoLVHK22xV+D3oXgb6bMCMBEXQSZN88nH4/Ns+xRrCW
 zLVfwIpv9w6Q7bJUMNgGU+3A5ons6m/quuBVQzKtnMzaamhYj+eKmQdUM9dNimSAA3x4nWuQKlw
 c2QlHFnwggMgiI9pFvcQ87+xPaB4uhkoMElxQYy4iqXFcUtGJrPx/OsrgspBiWyrfxKNUmA5KNg
 TPpcYQ2f5Impct8ArI548mLLhW02AWhVI=
X-Gm-Gg: ATEYQzxaOtxyxjFBtVy1qBPhyRUGFLoX8nhAhDaHt//OPmEz9mV5rDmfNpyk7DiWJ+S
 OAROiMRmAgDi37j+pT8aoHJhvidt9PrtpIHqbOZpPbzrsDbp3YJZtphQGOKZeD8aRtlORYhBtoU
 uBoREv4rcaIsOLXmhTWP3s64vTY121a0XPHPh6pzUcxvrg0NVdwn2hJOhAvU2CK7IBJZz+l27gB
 zcLMnBGoLltam+RalEhS70fBaYT93BBjCMumrk=
X-Received: by 2002:a05:6820:2290:b0:67e:212:8254 with SMTP id
 006d021491bc7-67e1870131amr1465140eaf.46.1774627559851; 
 Fri, 27 Mar 2026 09:05:59 -0700 (PDT)
X-Received: by 2002:a05:6820:2290:b0:67e:212:8254 with SMTP id
 006d021491bc7-67e1870131amr1465110eaf.46.1774627559427; Fri, 27 Mar 2026
 09:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260327-tpm-tis-sysbus-ppi-v2-0-d8ec84d25dbc@redhat.com>
 <d7f6f5e3-678a-4a63-8031-1af2cfd2c7a2@linux.ibm.com>
In-Reply-To: <d7f6f5e3-678a-4a63-8031-1af2cfd2c7a2@linux.ibm.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Fri, 27 Mar 2026 21:35:42 +0530
X-Gm-Features: AQROBzCJ7aPI5R8wBaxsA1oD7h8LWSIvKZ5ln1LCWmDPfCVVjP5Gux2sgypXn7k
Message-ID: <CAJg9Kky+TJO_gDoYs_+sOGqQ0j7Gw4tWrboAooby3F_sWPYOKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw/tpm: add PPI support to tpm-tis-device on ARM64
 virt
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com, 
 pierrick.bouvier@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>,
 imammedo@redhat.com, 
 anisinha@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, 
 qemu-arm@nongnu.org, mohamed@unpredictable.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Mar 27, 2026 at 9:15=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 3/27/26 7:48 AM, Mohammadfaiz Bawa wrote:
> > The ARM virt machine's tpm-tis-device lacks Physical Presence Interface
> > (PPI) support - no _DSM, _STA, or PPI operation regions in the ACPI
> > namespace. This causes Windows 11 ARM64 guests to log Event ID 15
> > (tpm.sys) errors per boot.
> >
> > This series documents the change, refactors tpm_build_ppi_acpi() to
> > accept a dynamic PPI base address, then wires up PPI MMIO and ACPI
> > on tpm-tis-sysbus via the platform bus.
> >
> > Tested: aarch64 KVM, upstream QEMU, Win11 ARM64 25H2, swtpm.
> > Event ID 15 eliminated.
> >
> > Changes in v2:
> > - Moved tpm.rst documentation hunk from patch 3 into patch 1 (Stefan)
> > - Added Reviewed-by tags
> >
> > Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> > ---
> > Mohammadfaiz Bawa (3):
> >        docs/specs/tpm: document PPI support on ARM64 virt
> >        hw/acpi/tpm: parameterize PPI base address in tpm_build_ppi_acpi
> >        hw/tpm: add PPI support to tpm-tis-device for ARM64 virt
> >
> >   docs/specs/tpm.rst       | 24 ++++++++++++++++++++++++
> >   hw/acpi/tpm.c            |  8 ++++----
> >   hw/arm/virt-acpi-build.c |  9 ++++++++-
> >   hw/tpm/tpm_tis_isa.c     |  2 +-
> >   hw/tpm/tpm_tis_sysbus.c  | 11 +++++++++++
> >   include/hw/acpi/tpm.h    |  3 ++-
> >   6 files changed, 50 insertions(+), 7 deletions(-)
> > ---
> > base-commit: 8e711856d7639cbffa51405f2cc2366e3d9e3a23
> > change-id: 20260324-tpm-tis-sysbus-ppi-ef31a7d71753
>
> Does this branch contain this series here:
>
> https://lore.kernel.org/qemu-devel/20260317120241.16320-1-philmd@linaro.o=
rg/
>
> A patch in this series changed TPMState to not have ppi_enabled anymore:
>
> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> index 184632ff66..1531620bf9 100644
> --- a/hw/tpm/tpm_tis.h
> +++ b/hw/tpm/tpm_tis.h
> @@ -75,7 +75,6 @@ typedef struct TPMState {
>
>       size_t be_buffer_size;
>
> -    bool ppi_enabled;
>       TPMPPI ppi;
>   } TPMState;
>

No, my branch doesn't include this series. Looking at it, the only thing
I'd need to adjust is a small change in patch 3, the ppi_enabled
property wiring in
tpm_tis_sysbus.c. The rest should apply cleanly on top.

Happy to rebase and send v3 on top once it's ready, or however
you'd like to handle it.


>
> >
> > Best regards,
>


