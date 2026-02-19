Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FACCE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1MG-00072K-Oz; Thu, 19 Feb 2026 05:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vt1Ln-0006zu-SR
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:33:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vt1Lj-0005zC-7g
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771497213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GRCVPpgeeHHMPPQFmT5zXeVEj5NtVQ0fYgZWek8b+0Q=;
 b=AWleGMUNBQQhQjeCe6nNJIIlsnaxn1ljGz8yc8I6wOgacM3gKnLKiOg37ts51p1PXgQkbM
 KbYxXDQ/PMQjShxkSRO4mXRtlHirTcP2h9KO8hBaIaGZD6DfFi4X8lDdjXTCvtK+QxAxwr
 aQ5ZAvpC8uRtIyTvG2PJ4g1V2L4QyPc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-WCchmrshOI2VOZyOPvMVmg-1; Thu, 19 Feb 2026 05:33:32 -0500
X-MC-Unique: WCchmrshOI2VOZyOPvMVmg-1
X-Mimecast-MFC-AGG-ID: WCchmrshOI2VOZyOPvMVmg_1771497211
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d1902109a9so7797986a34.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:33:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771497211; cv=none;
 d=google.com; s=arc-20240605;
 b=EyNJZcsUMaIpLl6mBKW0A8SJjhPBqKm2Fqm928YZz2I8oR3FDPz/s0yR59FiqoR0EM
 eGOFeEnDANWfiAr3Us5gqM9uu6HzHhm8528scgUBJbWeGbyrf6ATpqxJor02sbYAY7aL
 2j9UJ6Z3HbnnHH3Bj9vpAYvW/wD8gK7msdpXUZmc34jubpfLQL23xljNpMbpekZkMiwJ
 jJfTTSMscN9Wr9EttSq1WeCjTVUw37pCAOR6EzB/qhAmSRf+/sL40ZQNBoRBGCugNviV
 ONFaAIfjlI2sGLody/UPTpbT/YVhczdqxYiV0yDB2I6NZvjiNBWf+LNQJvrDNBd2I4Qn
 zSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GRCVPpgeeHHMPPQFmT5zXeVEj5NtVQ0fYgZWek8b+0Q=;
 fh=Y0ZyvydcxOPbaC4pimDZtDanVoBureR4Mclz7RjfapA=;
 b=giuOFeqcdynv02Ny3RbC1QiAQ5fAp5fmfKI7KlXBSaEVPJEi/lhVrerQ4AFhUi7e8p
 ysxSMDjjTTr+FucL3r6IK2MmawtAvZFypXqZI6JkngnPH5tGKvi9J0SRi+IXQr52iyMV
 +4bXhTQ788tIlNYmSyV5uH5Wwnh5KxB3MDTs7xP2MY5MNTB+l8Apn0N/1JkVwWc4bvXf
 svv34g7HfG2OMKXAqMiKv/IUCww9s787sR4kAiy3zrv94kuTU3LbiUU1DqiMlQ2LIeHb
 EEFtckcbPrHjuBRgkCWpa3M79O2bJyjgQOgo5n3tKfESjr2MruHCHTdJR+5TB69G3NX9
 ID8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771497211; x=1772102011; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRCVPpgeeHHMPPQFmT5zXeVEj5NtVQ0fYgZWek8b+0Q=;
 b=LbJtbKBoZljesSpipAGzZD7TWNERs5UEvOD8QkDUtcGFjzIIEB5iKT9nqEW5pX9pCJ
 V8Ja+9FQPAeQt7NRYExbh5uFgMq84Xa3Bcp7sPUSHKXWFKjDnBJYNF0n1TN0+rr/rmhS
 eeY1V2eKSgcEAYtT1iEQybKRQR5azZcThKxbQE3+Sb+qNOfZczaPR1W83vejekDp6c5H
 zP4xhiTHENNEba/bpjSKcuOGiu/Fi0AXeH8b0z7LVwn4yM7wOvcGABBzXpMQV4Pv558Z
 jlQZH9vn3XY7K8P4stJSuBCR4LuZGCx2NChop7HaMu+SIv3qaug3+WFj/h4earE6nvmL
 BRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497211; x=1772102011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GRCVPpgeeHHMPPQFmT5zXeVEj5NtVQ0fYgZWek8b+0Q=;
 b=hHzG0zhvtbuO7rsLB0jZL/ylkARrGV7/spJY3YlOInJcqHb7A0JpBdLWKnyOFTtL0V
 pP6zTeytKZXMNaZ9rGKfe9HaJopfIuCDqoYQbgjkVo9pUfU9WAxT9CutRSBvf2XfH3gq
 +Jiip8M+V20Kz6LH7S8S0uyU16qC+IMlPdtFhd7CGuCR22gKd4nUZzori/nVRJT3MD5A
 j8pOtMDy2KYd9HXXbp1KEr5UiThv7n3JiUk6i36XN4r+UoIEIp3zDbeMeyvaYyW/vrQi
 1WasbR05abir7jct+CRvKZRWVkk6mthwhvFcJRSKqgWI2ql7P3bKo5xlpgY4iCe2JYRY
 b2vg==
X-Gm-Message-State: AOJu0YxHLG59eJquSmsgashrxlx0hsac1orLg3pT2In8GURy8WwTfIYi
 Gp0wh8c2aiKN4fuPAzq5tiHdTKHTXhNlgdkrtf2/h//dtCzIR/HRlHqBni6KJN8N+HzDwhszWYc
 uU2kIbFyZKBc4F4sft2barQp6eZI2C98iTkev3RAHsuZX3AkFEm0OcN8RCZpirfIDUPSdP7oTlY
 SJhg0vCEwpW2JFe1NkSJLe+dd1oKkweJk=
X-Gm-Gg: AZuq6aLvuYXVqh6X7CLrRBVPEFsWhcsIVV5rBrt4WNXJ3rXFpajGLL8l9W7GP74FcoB
 UfZBJibuztgMP6V+7SLn09yioN2Po/0eoUeoRVe9nDpxUVwWLYYmcMuUvZa0AdhKFkQWViwancQ
 hthihrMdA0K/grpxTVXsxUzmKLbSv4COsK5hy+NLHFPsvsBgxRvEMtNBBxfahY28rwjkYqTkgEB
 ixNlaRl
X-Received: by 2002:a05:6820:1795:b0:659:9a49:904d with SMTP id
 006d021491bc7-679a71e01f9mr2829522eaf.24.1771497211409; 
 Thu, 19 Feb 2026 02:33:31 -0800 (PST)
X-Received: by 2002:a05:6820:1795:b0:659:9a49:904d with SMTP id
 006d021491bc7-679a71e01f9mr2829510eaf.24.1771497210947; Thu, 19 Feb 2026
 02:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20260211122759.125094-1-mbawa@redhat.com>
 <CAFEAcA_+eqfTy+7U9igTscue5SMURm3C9yUXvdFTon+ZgSJfAA@mail.gmail.com>
 <CAFEAcA_fR8gQc-f1qhcNb7tD0_EfqfNJEhS_tSg354Rhpb=fQw@mail.gmail.com>
In-Reply-To: <CAFEAcA_fR8gQc-f1qhcNb7tD0_EfqfNJEhS_tSg354Rhpb=fQw@mail.gmail.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Thu, 19 Feb 2026 16:03:15 +0530
X-Gm-Features: AaiRm51d3jCQRdJLBGchRk917SaOMN8Wes2GY1GN2FwGaEDp0LP5cI4DXPxS3f0
Message-ID: <CAJg9KkzORMAeQUiEm6ue9k5yfhw3KTtJkS_Bk=U1roTMsk_CZg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Add virtio-transports property
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org, 
 philmd@linaro.org, cohuck@redhat.com, eric.auger@redhat.com, 
 sebott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 19, 2026 at 3:43=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 18 Feb 2026 at 19:01, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Wed, 11 Feb 2026 at 12:28, Mohammadfaiz Bawa <mbawa@redhat.com> wrot=
e:
> > >
> > > Windows ARM64 guests detect virtio-mmio devices declared in ACPI
> > > tables even when no backend is attached. This causes "Unknown
> > > devices" (ACPI\LNRO0005) to appear in Device Manager.
> > >
> > > Until Windows fixes that by supporting, adding a new machine
> > > property 'virtio-transports' to control the number of
> > > virtio-mmio transports instantiated. The default remains
> > > NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
> > > Setting it to 0 allows users to disable virtio-mmio entirely.
> > >
> > > Usage: -machine virt,virtio-transports=3D0
> > >
> > > Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> >
> > Applied to target-arm.next, thanks -- but please could you check
> > up with the ACPI spec about whether it says anything about what
> > to report for empty transports? If it says we should or if it's
> > just vague we should probably match the x86 microvm behaviour
> > of not showing empty transports, since they can never be
> > hotplugged after startup. (This might need to be tied to
> > a machine-version, not sure.) Maybe we should also not report
> > them in the dtb?
>
> Looking again at this patch, I had a couple of niggles, so
> I've dropped this patch from target-arm.next for the moment.
>
> (1) we need to document the new property in
>     docs/system/arm/virt.rst. Something like

Right, sorry about missing that , I'll add the suggested documentation.

>
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -226,6 +226,11 @@ dtb-randomness
>  dtb-kaslr-seed
>    A deprecated synonym for dtb-randomness.
>
> +virtio-transports
> +  Set the number of virtio-mmio transports to create (between 0 and 32;
> +  the default is 32).  Unused transports are harmless, but you can
> +  use this property to avoid exposing them to the guest if you wish.
> +
>  x-oem-id
>    Set string (up to 6 bytes) to override the default value of field
> OEMID in ACPI
>    table header.
>
> would do.
>
> (2) I think we should call the property virtio-mmio-transports,
> to make it clearer to the user that this is MMIO-specific and
> nothing to do with the much more commonly used PCI virtio.
> What do you think?

Yes, virtio-mmio-transports was my initial pick for the property, but I dro=
pped
it thinking it was too long.But, I think the clarity here is needed.
I'll rename it.

Will send v2 with both changes shortly.

Thanks,
Faiz

>
> thanks
> -- PMM
>


