Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348CDC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4vjM-0003sC-8v; Fri, 11 Sep 2026 03:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x4vjI-0003rg-D7
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x4vjF-0000TG-7B
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789111879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qQWGRNBjVayQdHo3mPFwaoqXM0HnNYiz7akZkWtDIhI=;
 b=IcxKzU6uU2sgcp96NGtAVOjVPvx1A3HTegGOkjxkJkwePqvVO2gjK3Bgk6vtKr389a+M0a
 JLhpT47ZEtWdfvq5nWZCg3DhNtn4gkLeYk+3vgFQi69uK1mESWlf6FSkPitetCTEA4XEh8
 Mk3vKKNV4X7Di3I4P4AU201l8KGnT0c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-wIThocrQP_ulmYG2gFokxg-1; Fri, 11 Sep 2026 03:31:17 -0400
X-MC-Unique: wIThocrQP_ulmYG2gFokxg-1
X-Mimecast-MFC-AGG-ID: wIThocrQP_ulmYG2gFokxg_1789111877
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cc954a3edso4048735e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789111876; x=1789716676; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qQWGRNBjVayQdHo3mPFwaoqXM0HnNYiz7akZkWtDIhI=;
 b=Wi6f+Zghsn1bLQOjoxZBrsSJcmIv3kfD4Qc7H8vCr3p6jtQduuoQfOyO1OwmctymUo
 vg9e64sZTSo2P9ydNKK13AFn/in767zs74zKyl7balfCbcsU4+FbDs0Q55NTKPPCozlJ
 wSdv4rFZ22TF52MS5YFl+3rvtUdWEWb49UcfC4oQ4A8IcMfdQ7qUVnXD360dWDf79rJg
 W2n0nkpicGj4Oo9bi6jqvKEAeYDAQuWzF/0ZOdBjd16vl1dUYJU+ClueEnzXVI++jnqB
 W3Ia176zB9eS0iQmlxsQBafziPu/z6XAFNHfNDjxXjOXnWid/bZwhBPboCiEoqmw+LMg
 LCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789111876; x=1789716676;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qQWGRNBjVayQdHo3mPFwaoqXM0HnNYiz7akZkWtDIhI=;
 b=Dr9lpkh4Cu0NcL6/B70ezmq92bv9xxGjigFV3s57DMT5pj+5RyP7rubVDJ8tqOkYCx
 t/RnXFEZO+siMdOWv6xT/7JW8DRTqvMp9VOVXwd2ENDLTd6Y0oEzR/4CmfqWrg5yEt4r
 m0Il+b08hRWEH63SVf8TNRh2+t7rVd+/qnGgFL5AIrUfm8l9td0uWf5c/YIVzOJ0k0sC
 CK+F8Pd29Omsek5P8NFmDb4L7UqE5F/EgSWdJP5GTvajgOPQlcsvS1xQW4vZtpB8ZnJ7
 PtNVuAYS3efo/8qfrBng/oaVc1j0UI3XGXAgFnbOPzs3lgAV6l4owtdU2XdmT9Imt2Nq
 sNjQ==
X-Gm-Message-State: AFuF++ksrxQv9yvgfa5kjRhkWPl5o52LE3nCQbxwakOPvqryiaJw6/kb
 GX47HRP0xC6lIHFBZx5wlI37XePP9necaRbB6t128BNcm6xYgWsom/nsLZOeWHlSTLKcm0wsnDf
 kR2hdMQD6pkllOhK5fg9PLM5+Zs5iQC9hWvzLS+509PlqG5eXeVO161T5
X-Gm-Gg: AYBFou0OxdgLs+FRnp5ND/mqKv7HXGs80Hs4ikmwiFuDJZWivoIwnVvB4OYa+eVY44U
 /X+2vTUaywCp3677fhKKq9gSy9WH4E+efX7JH2eAuij9pSrzjDH64Q3HclEac2bTkkON9F0F5pm
 03v52NMb4od1GZ4a4VyULpYmCa6ZRE5UOKhbVDamqTl2fROytCfWerX5GtVvnTqpT9cFvmt7Pml
 74bwtj69nXIE0cHjkoUahdsQs6o0fvdunlhK1momZlrqbB2YKDgF7kz5CWu5hlWhN6qYUu3L/+S
 fXAji3vG6ch9EHgk94yJNJ2HiMK6aYMQmHrISLnDWOVrFJd5KtonvcNujbVs4YvhSofoJKpzDO/
 ft6Rs5UG+eTZCk3yxFRDp4+3eY1TQaDsRNraYaWm2rCeGOw==
X-Received: by 2002:a05:600c:8b23:b0:49c:fa20:cc0a with SMTP id
 5b1f17b1804b1-49e619e6849mr28255675e9.33.1789111869765; 
 Fri, 11 Sep 2026 00:31:09 -0700 (PDT)
X-Received: by 2002:a05:600c:8b23:b0:49c:fa20:cc0a with SMTP id
 5b1f17b1804b1-49e619e6849mr28249825e9.33.1789111862694; 
 Fri, 11 Sep 2026 00:31:02 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm25498895e9.4.2026.09.11.00.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 00:31:00 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:30:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PULL 00/90] pci, vhost, virtio, iommu, apci: features, fixes
Message-ID: <CAGxU2F72403d-Dt2+_MuDhcdHrdbNNjkYK+KMJ3R1PUbY7xQEQ@mail.gmail.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Michael,

CCing Andrey

On Thu, 10 Sept 2026 at 22:44, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d6:
>
>   Merge tag 'qom-qapi-pr-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 18:35:31 +0100)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 99c75c61d61251d98e0b93dd199edbb10a990205:
>
>   MAINTAINERS: add Junjie Cao as CXL reviewer (2026-09-10 10:55:03 -0400)
>
> ----------------------------------------------------------------
> pci, vhost, virtio, iommu, apci: features, fixes
>
> migration/cpr now supports vhost-vsock devices

In the last review we found several issues and Andrey is going to fix 
them in v5, so IMO is better to remove that series from the pull 
request.

See 
https://lore.kernel.org/qemu-devel/20260820113955.509478-1-andrey.drobyshev@virtuozzo.com/ 
mainly in patch 5 and 10 IIRC.

Thanks,
Stefano


