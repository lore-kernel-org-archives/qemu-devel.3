Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFC3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we40L-00017O-Fh; Mon, 29 Jun 2026 00:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1we40F-00016q-Tv
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1we3zq-0003Sw-O6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782708804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpcP+sGwKYaBepDBJKxraeicU3ElQpCiKSq3wJfZFpM=;
 b=PET7CxUFFyVeoUH0lTk7yKA5fMZPmyCGeCC5hjiz9FNxIJltrQjv13q6rfzvl25M3+9X0+
 OApz7FTpTeJbfNu9TC2aWSD7DMaVrzNn9kRS8Qq1xSHBasLAuOq7Ph4CstjXECUUKTx3/f
 avGpkZCYwvB79btM5PUlqiWu7efaLfQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-G-B7BHDsMiyhazTZ50NIGQ-1; Mon, 29 Jun 2026 00:53:17 -0400
X-MC-Unique: G-B7BHDsMiyhazTZ50NIGQ-1
X-Mimecast-MFC-AGG-ID: G-B7BHDsMiyhazTZ50NIGQ_1782708797
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-48f680bda84so4774257b6e.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782708797; cv=none;
 d=google.com; s=arc-20260327;
 b=DEp9Odk1+V4aI+mzt1QDxKFvUuAhoijK5w9kJxwrkhI2Elh+ICKuDdQtADfmmVjnkR
 CvolWXPHMDfRk65L/2JuqmSYL4CLfminUkiHPhJhDKFa6PUXaVUk0HTRLaICC5uaeG3U
 qxL+HlYTdcxjfwKEEXZ+oH5MLNWBqWU2E3rCqLafz1dLgyKu2MfNaTlnJUKM5anrtwGb
 76SPdQ4fgj8hWIGob7DUpNOsIXNl9AYwg73jInRCziq2pIQl2bNkzjV+/AhmH8nXGGID
 SWhsX15bQEYlaS9sHVdaMw220EDfAkwDE198vD2QjzT3lLyExB11zsYskEvLiE7Vl19m
 VlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tpcP+sGwKYaBepDBJKxraeicU3ElQpCiKSq3wJfZFpM=;
 fh=rvP0WXKqeFGsCcy61Ow0iQ5z6XYIhmi8GIpCeOLZ84c=;
 b=BhWXBfygXoBfllMo5ak7raqy7ACp9ZZASAG6fhCuK+V7BKVpd0/iOql0VBVxFViDK1
 GzKwY+Otwrfp4ZFZL7575mxXZHSHX3+1l6xOdq5ONP6zamzSmnRamPjaayU9KLpH5ZOT
 KWrg9l6CzSiMlUyTLdALdG+JKbqqv8zkap5K808iVxejvPup6sKrF0frmj2PiQBv2dKG
 Bc0SEOiqCtMyT/WDcrC/nUK83TMuR+HWT8D8gYni2OOJ33L224qqbQe5DOaH9t8m1ePR
 qOAhw3IneYIDjPfJahH4mDxHHiV93nZ15FDOu8KlIeIJ/cMncm8T+1DOCfcnLh6+Fng/
 bSvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782708797; x=1783313597; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpcP+sGwKYaBepDBJKxraeicU3ElQpCiKSq3wJfZFpM=;
 b=MprmGk9XkfSXJNHgHYwWSWrqfGSv0L/TrpQaeBOsE/SmrwcIB4utjaLkIRWtym0lS3
 YVegLrcpX2W8udSimoUECNo9TLWgKt3oA3ddfkCXzFf/XqbfPS/bnaWFBTGN8mqkPr8o
 WvgS0o76N3S55UjQNRkxeI4T7B2AvuxxPiVAoKh8VuR8UBl6hZ6W9YvodJpOklY9Oto8
 FPLY50ctsdaIBZmqo8c4XHwttlImbQsddNPIlB5ZsRBxWvhY88NnUJ9RA95X4MDfxg2s
 iHoDJLUe9K0DL2qg+74180VW8IP5V17d056N19MdhJ7bKAUwK1QKi54REfCvD0BZVA58
 M5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782708797; x=1783313597;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tpcP+sGwKYaBepDBJKxraeicU3ElQpCiKSq3wJfZFpM=;
 b=DbX0je5gHAyu5giAUnDbvgkj0SHpU3dP8qJGJLVlZKmMIjIX+q0lhqPnK2HX1FZeJe
 wxLnY/oZ/qgpHWssCSiq2lo6kKb6SvGBpNA1Mg0pFMNjvdYofzYZM9pNDpO6OBFIElxt
 AH1FW2BMO7SLwe/ISUZd7q0xBytFLDaw07tXGbQdjeqIjX8sePs43e0gl9kjXlyOvvQD
 rO0er2vZD7/DJh0OS7atuksC9CjW6faQfjHe120p+9J6uI8Pvt0CSM/m1G/wlkFpFY6h
 Fg1jxasrfj3EcdpNKZp5drOSh2sE5d5ihqdZfZqMeeHMw6DETfIbIGk4pWsPnn1WSCb/
 GrgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9j65wxjqh4CP1nrETU5adJXkvQq8O8dRiHqggTmxA7VPg4cKIkAZQ5TY4GZqcRyo2CI9AP8jA0u1HA@nongnu.org
X-Gm-Message-State: AOJu0Yx1RecA0Alh9d/+bXCZXVVRP1+s1mk15JRWpaZG4GVI+F63qJrS
 umDTsjr8rMVFtMQb302eYDhIb9Lwy2Y0xopmnWu63hAqsZxmEnsbjydwM+gxuDFdNp+SiZn2Wc4
 xdJzKeAW39OSTkbUdFW+AvrMmdCJBnVGd9gFICY6IIqLzOR56i/0FoCFhjP5ueegKdU2rgRKu0a
 mJRzi1DmVg3YNJyDCOLzDB5KhGPc1Pv2k=
X-Gm-Gg: AfdE7cntXxzGdOYFt02mXQxzp/+UnxrnByyGsxYltSJOxcsz4WpzSXQjelopzORoMmV
 8QgAhc65JMnIM7gXdhRXsDunFOOTwGbqW8VkBxljLQy2kUT8rN/5R1WQCJl5O0PmCMQaY5Nmtjj
 zc1JMhfNVDmwBfCKICBH7HvUTsTHSPeRsuuGeKqAg7mBtd2Nf9KbTFdkZaK6pDHC+sfq61ugsGX
 eCJAuXbIQB8USfcnB9aW0G41Q==
X-Received: by 2002:a05:6808:f8b:b0:48a:3f80:ee5c with SMTP id
 5614622812f47-4921772124fmr11444567b6e.23.1782708796984; 
 Sun, 28 Jun 2026 21:53:16 -0700 (PDT)
X-Received: by 2002:a05:6808:f8b:b0:48a:3f80:ee5c with SMTP id
 5614622812f47-4921772124fmr11444553b6e.23.1782708796500; Sun, 28 Jun 2026
 21:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260619093140.832136-1-mbawa@redhat.com>
In-Reply-To: <20260619093140.832136-1-mbawa@redhat.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Mon, 29 Jun 2026 10:23:00 +0530
X-Gm-Features: AVVi8Cfwes4OvpC3edtf2KIDZcN-dMCMEGKPl5SIFDFG5edS8qCeoHw5IR2_G5I
Message-ID: <CAJg9KkxHPZnGjFg9CcpB1RGv321OZU3guBGWHZiUqYQhaVG0Lw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] hw/tpm: fix tpm-tis-device backward migration on
 aarch64
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Fri, Jun 19, 2026 at 3:01=E2=80=AFPM Mohammadfaiz Bawa <mbawa@redhat.com=
> wrote:
>
> 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM64
> virt") unconditionally registers a "tpm-ppi" RAMBlock when the TPM
> TIS sysbus device is realized.  This breaks backward migration: a
> QEMU with PPI support cannot migrate to an older QEMU without it:
>
>   Unknown ramblock "tpm-ppi", cannot accept migration
>
> The failure is 100% reproducible on any aarch64 guest that uses
> tpm-tis-device when migrating to a host whose QEMU predates the PPI
> commit.
>
> Fix by gating the PPI memory region behind a new "ppi" device
> property, and disabling it via hw_compat_11_0[] for machine types
> <=3D virt-11.0.  Also move the sysbus_init_mmio() calls from
> instance_init to realizefn so the memory regions are properly
> initialized before being registered (Peter).
>
> Not exposing the 2nd MMIO slot when ppi=3Doff triggers a NULL
> dereference in platform_bus_get_mmio_addr(), so patch 1 adds a
> guard first.
>
> Changes in v3:
> - Reordered: platform-bus NULL guard is now patch 1 (Peter)
>
> Changes in v2:
> - Dropped zero-size memory region hack (Peter)
> - Moved sysbus_init_mmio() from initfn to realizefn (Peter)
> - Only expose PPI MMIO region when ppi=3Don (Peter)
> - Added NULL guard in platform_bus_get_mmio_addr() (found via testing)
> - v1: https://lore.kernel.org/qemu-devel/20260618123317.633869-1-mbawa@re=
dhat.com
> - v2: https://lore.kernel.org/qemu-devel/20260619053623.756021-1-mbawa@re=
dhat.com
>
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
>
> Mohammadfaiz Bawa (3):
>   hw/core/platform-bus: guard platform_bus_get_mmio_addr() against NULL
>   hw/tpm: gate PPI support on tpm-tis-device behind a device property
>   hw/core/machine: disable tpm-tis-device PPI for machine type <=3D 11.0
>
>  hw/core/machine.c       |  1 +
>  hw/core/platform-bus.c  |  3 +--
>  hw/tpm/tpm_tis.h        |  1 +
>  hw/tpm/tpm_tis_sysbus.c | 18 +++++++++++-------
>  4 files changed, 14 insertions(+), 9 deletions(-)
>
> --
> 2.54.0
>
Gentle ping.
Patch 1/3 has Peter's Reviewed-by. Looking for review on the other two.

Thanks,
Faiz


