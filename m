Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB93EC5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUK4a-0001bB-FG; Tue, 02 Jun 2026 04:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1wUK4Y-0001ay-7L
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1wUK4W-0000Z4-EJ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780387318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BTQmql4dYaF13HR3yHbuEoH6fqmU3ka7i/eGczfwCCE=;
 b=Dqv90erAy+IuINyJpC5WR4QLMfgeMIjUAXFTP1STLgBFjSC5/c0Uou4cgqnClbHhq9fhFh
 /6whi3vVvY+8BI7ZTIl1A8SZZVJN/erdEKGlSMEPqzCvKyuXPbWLK6QUksXRLOIXalIpAG
 54DIn5sgnJVSmHnbOPZW1CI0SyPMEvQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-DqDoNYq9OL2BuoEKFhgNqw-1; Tue, 02 Jun 2026 04:01:57 -0400
X-MC-Unique: DqDoNYq9OL2BuoEKFhgNqw-1
X-Mimecast-MFC-AGG-ID: DqDoNYq9OL2BuoEKFhgNqw_1780387316
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36bba9b849dso4020418a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 01:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780387316; cv=none;
 d=google.com; s=arc-20240605;
 b=aYNNgGS6RoI5zzcL53CwTsp1j14Q7G1X6FpknMfiLaSRYAtSI54egy6nar0Q+1tvPP
 Z6OxU7dh7BoE1/oGSxumd67RfVX/FyddFCHkE5dhQX2wz0YySjQRZ+i4ZwE5tBPzQRMQ
 iHeBxRxQz0c+XFsF/J+FE6ykqa70Kp86lQwOsa6yey/1CfqsbKzCIuSN+jIkAtAxcpyi
 AyjKBjmjvnN5PeCN7MIWomnz9xv7Fsp60E6TiWyWePrD1FeY7vjSwmsppwIO3uW0tXtD
 YL8xIbhmJhVofD55FuzDzlpRxjhd2cStIcnFhVHWnEDVzmT3koKpuOm80YfjGqa8LYb7
 8QtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BTQmql4dYaF13HR3yHbuEoH6fqmU3ka7i/eGczfwCCE=;
 fh=e2eC8NuQ4/dcP/8/zm8PE7I9Ag9c/nkRlugmCPGBcpk=;
 b=TkF0qM/5yKJfvvqb+zVVs8pNp39cfGPDJUvaeq40KKdLLQWLoqvOWIj1lzdxt5sK/V
 Z0dFaw6sDB+WKScRv/n95lqv/FRcQV/jKyitYaX4ZurmC8/QSjC0BViFYcQqYA56VkL+
 opcqZAU8u6Fb9DxDG45qP/rWCoooaYbehJCni9ym1GmK9jnUjv6b7QWjA7tUkaoWrKO8
 dq96xolT2vJS+Tany6vL0OBjeiFBD1pW9gbIKl9I4jX+AoVL3tSywUT3t+uuhI1k159L
 HBxg2eEvxNLeGxLMCJjjy8XKES6Lh4roWlTrn5CTIY/HBzJ8KQrZ/PJm+yMIHoN1peQR
 3/ag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780387316; x=1780992116; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTQmql4dYaF13HR3yHbuEoH6fqmU3ka7i/eGczfwCCE=;
 b=J4orDSbB1qHKgf1xBzFSIFgo5FWfYRVoWyYSvUvKiyg00eWziJJPCfkRlDj9dWHHW9
 vr8bGptdTWweHlBIkXyLVj1li6H2MggVZLrB22aWHpvUqhfTuuN6LiHQuTRfX/V2UDNu
 maLZQO/HDqzLJ64MexXEWJ9LNzkgyrPOQc38E4+GUb6zJEZ0DDRu7tMyTcrPYddSmgiD
 4pKzQSr/HDbmsjWK38Z9Xd1bgI/vdIIuoFjgo4QgwyLvz0FbX8TSIibdq/k1op81cCqY
 UDz/XQYOW/lN+//WcUPaTRVmEpTVzQlVD8x8tOY2duVZYOZfB2K7+YFBgdF44Xv2n8vc
 4G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780387316; x=1780992116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BTQmql4dYaF13HR3yHbuEoH6fqmU3ka7i/eGczfwCCE=;
 b=F+N9BNWvDO3Qo6ehlvH6+G5/VzthN0WFgzFs16LIC0LJDOcdg3fpY2ft/KQb737KXS
 7HIKQFiwta6BncFFwYsy9/bu0nP2pR7kHZIEsjsJdjZJ788hSTPym4G9+XdQqmIrjvCs
 fNXD7BCPc5OMeh33NAyvGTKFQ8o7ixpk0+75Kd6fbglpOsJGMOk8jXxgrVXpQgnE6GfQ
 L2ynpt1HRulXP8Eza5ezsaJydk8kTTcGGx0Ck6Tq2JhDs9aByRLA2IwXBpsL9ym+7r7L
 IpNFrXX8XboSIQ358DHcr+Zgei8HVkVdn3/cymnINnISkcV6wLAobgEdfU2e7GEQF9wU
 r6qw==
X-Gm-Message-State: AOJu0Yz5s6US4hM5rTCk2TlaR1DoPR3U8gAT/v+1xqyCrbU7tmJdDcpC
 0qX/xeNKoLLCY2nwyWmFDg43slmgegk7kT5GXoLj57fDh/hur/pyLe8zkVxOza77c/iKWvR2tEy
 lNf+KGWmfgACshbUJcTlvVQ6d3cPWk9GQLifIHl78YyMPy+Krxw5WHN/E1NV/TiDWwbkEfSN/qh
 nkkVK06aB2nazeR3FjdWk1nMmvbTvCGdE=
X-Gm-Gg: Acq92OGIJQ3n+RDRsYWWbhpkM/bzQuB3dQkwUZw4y4n+pbZVEf+n6SQmqK+GIWGMBk8
 SEt6UIEBtcj4tSISFOiCdFyVbLCklmN/g5oqnc7H6CMuhdn8nYqex+4wGaiTl5qTRugAcaX13zY
 zLWl8+ZVEDaSg/5j2ezx5qOIRHiUtA6oDc+XUd5viG83+LkATsib0vjW5PMKWxnfWNm3ecGCjOt
 gdh6fJzqOnIztKqpcyMWKDknRtANTeV5wt7JOpkSYeMxvme
X-Received: by 2002:a05:6a20:e20f:b0:39f:2dd0:65d5 with SMTP id
 adf61e73a8af0-3b427fb8a39mr16193943637.39.1780387315994; 
 Tue, 02 Jun 2026 01:01:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:e20f:b0:39f:2dd0:65d5 with SMTP id
 adf61e73a8af0-3b427fb8a39mr16193898637.39.1780387315409; Tue, 02 Jun 2026
 01:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260602074446.1206892-1-clg@redhat.com>
In-Reply-To: <20260602074446.1206892-1-clg@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Tue, 2 Jun 2026 10:01:43 +0200
X-Gm-Features: AVHnY4IHuvblfFZ-cSOF4uMmLBLniz8ipZQDWnIUMVQgNiJJN4y0kccNJ1bsWTc
Message-ID: <CAMXpfWsXEqvH0Uo4OV929n=g5qN7G0wsjsTn5Q4z-ZLbv+Oijw@mail.gmail.com>
Subject: Re: [PATCH] vfio/pci: Fix information leak in vfio_rom_read()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Looks good to me!

Reviewed-by: Mario Casquero <mcasquer@redhat.com>

BR,
Mario





On Tue, Jun 2, 2026 at 9:44=E2=80=AFAM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:
>
> vfio_rom_read() can leak uninitialized stack data to the guest when a
> read occurs at the end boundary of the ROM BAR.
>
> Fix this by initializing the val union to 0xff, matching the ROM
> initialization pattern used in vfio_pci_load_rom().
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9df04fa2d76b1a78ee884d915f5a0c3c5fdb6115..de28e72519326741295c19f4a=
07208b95861f2ce 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1142,7 +1142,7 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr =
addr, unsigned size)
>          uint16_t word;
>          uint32_t dword;
>          uint64_t qword;
> -    } val;
> +    } val =3D { .qword =3D ~0ULL };
>      uint64_t data =3D 0;
>
>      /* Load the ROM lazily when the guest tries to read it */
> --
> 2.54.0
>


