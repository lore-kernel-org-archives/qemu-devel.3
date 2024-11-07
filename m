Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273C1D5D689
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 20:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t99QJ-0006zn-1x; Thu, 07 Nov 2024 15:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t99QH-0006zP-DX
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 15:48:09 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t99QF-0001Zo-L5
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 15:48:09 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb3debdc09so12194301fa.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 12:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731012484; x=1731617284; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+tfd37kIrjmQ3TrvX3Z6juOv88Erq1VFjITX8+GNTdw=;
 b=uzaVSQUOSJfKWetHlKvi1wbRak0CmppaDsciNdf7yq34iWfbuVGxCAK7tu0w/MGUSM
 PxDDP2VAWPeeg/R3Cm9X9IcA6SfPuPPpHMFmwfk6Tcn4Nx9x3caKmDjJojfkstIn/t4l
 Ej4/2VkaRTICLSyk4i1fA2Nwhq35WhCnGuXMahHNwbl3avqGT/97JUsB2mobpxLJ6Rki
 NFgXLlR+fhvkdd+15fcVSNmHAtnjP8OQPC1IGc90vt6VWFEAtez2iu5nrhwecqgeDM5B
 JKhFsEFYaZHnpp7RtYGXF64xrNDIVkE8l9DSFrNRsM+KomYpBG/EYHLmmabDwyK8zuzY
 Ucuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731012484; x=1731617284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+tfd37kIrjmQ3TrvX3Z6juOv88Erq1VFjITX8+GNTdw=;
 b=xGFmCcu2/ccn2qmBRBRJzCsZtxhVcEPWHhrtwOdfx7m1H8L1N8f+VMbCOKp46Ox8PK
 Inopdyr4iB8kyPCS7pSUzR/04ufSfaZhe2JN5+Kg0ty5dLvRwlxd2VkKKiJqdg58K4d+
 Aj2+JhA3o1AU0RCyoASIEM9j/xM8ARu49Qn2eZKI6Lxq/iCOnu4xf8Ji1EaPX4vQYZ2T
 kmzUq40uaM5tvfAjY4EMO4oP4tZ8Y+gQYxDQkDWBfjtYv+enRXauWTRLIHfEQLt5JpRy
 flJYUs1E/AGXewtt8vXbx0wSmHlwac9ZdA+RSLkiE12hC3wnvgvi23e3WXV1aoC6O+ZA
 I0cg==
X-Gm-Message-State: AOJu0YwVmdsTsfqJG7HLsw2Bz9DMbBn3i2m1vKjtFLutLk4aiCoQIQW5
 lPPFpHRWu3J5vfoacDMF2tsOuNCTAyRl8GF5IW/XN5g5OxB3Jgv1105Vx8CXtJX250n9kjTbeMa
 a71Pp1IOUd4Sr6nb7JV4aSBBnP/yuaCMH/4JDgqTGQ7qJ9asT
X-Google-Smtp-Source: AGHT+IGSgeV9sWI4Wh7+Jk9epYf7AKgk8mvtCIeR4Vk3NaShNAKVHX5kLiA2vVofIZM6NomGuEmQw0w1CyZS4cWRQHc=
X-Received: by 2002:a2e:ab05:0:b0:2fb:5b23:edba with SMTP id
 38308e7fff4ca-2ff201b271bmr2000921fa.23.1731012483797; Thu, 07 Nov 2024
 12:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20241107163210.3620697-1-peter.maydell@linaro.org>
 <20241107163210.3620697-2-peter.maydell@linaro.org>
In-Reply-To: <20241107163210.3620697-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 20:47:53 +0000
Message-ID: <CAFEAcA8mu0fbOtmqCm6pV_pBvAzW4UCe_1xg7P7RpL3NQY4ohw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/net/virtio-net.c: Don't assume IP length field is
 aligned
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 7 Nov 2024 at 16:32, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In virtio-net.c we assume that the IP length field in the packet is
> aligned, and we copy its address into a uint16_t* in the
> VirtioNetRscUnit struct which we then dereference later.  This isn't
> a safe assumption; it will also result in compilation failures if we
> mark the ip_header struct as QEMU_PACKED because the compiler will
> not let you take the address of an unaligned struct field.
>
> Make the ip_plen field in VirtioNetRscUnit a void*, and make all the
> places where we read or write through that pointer instead use some
> new accessor functions read_unit_ip_len() and write_unit_ip_len()
> which account for the pointer being potentially unaligned and also do
> the network-byte-order conversion we were previously using htons() to
> perform.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/virtio/virtio-net.h |  2 +-
>  hw/net/virtio-net.c            | 23 +++++++++++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index 060c23c04d2..b9ea9e824e3 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -102,7 +102,7 @@ typedef struct VirtioNetRscStat {
>  /* Rsc unit general info used to checking if can coalescing */
>  typedef struct VirtioNetRscUnit {
>      void *ip;   /* ip header */
> -    uint16_t *ip_plen;      /* data len pointer in ip header field */
> +    void *ip_plen; /* pointer to unaligned uint16_t data len in ip header */
>      struct tcp_header *tcp; /* tcp header */
>      uint16_t tcp_hdrlen;    /* tcp header len */
>      uint16_t payload;       /* pure payload without virtio/eth/ip/tcp */
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index f2104ed364a..11cf462180d 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2049,6 +2049,21 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
>      return virtio_net_receive_rcu(nc, buf, size, false);
>  }
>
> +/*
> + * Accessors to read and write the IP packet data length field. This
> + * is a potentially unaligned network-byte-order 16 bit unsigned integer
> + * pointed to by unit->ip_len.
> + */
> +static uint16_t read_unit_ip_len(VirtioNetRscUnit *unit)
> +{
> +    return ldl_be_p(unit->ip_plen);
> +}
> +
> +static void write_unit_ip_len(VirtioNetRscUnit *unit, uint16_t l)
> +{
> +    stl_be_p(unit->ip_plen, l);
> +}

These should of course be lduw_be_p() and stw_be_p(), since
it's a 16 bit field.

Interestingly nothing fails in "make check" or "make check-functional"
if this breaks, suggesting we aren't exercising virtio-net very hard.

-- PMM

