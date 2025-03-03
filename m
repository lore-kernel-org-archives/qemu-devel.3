Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42162C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp4GE-00043p-PE; Mon, 03 Mar 2025 06:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp4G3-00041s-FR
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:46:51 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tp4G1-0001XL-KN
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 06:46:51 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e60b04fc3edso2914564276.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 03:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741002408; x=1741607208; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdlPbpIFj0/t7ED+bsr0Srbzkrk3Qt3hyYAAzB4XwNA=;
 b=XDsfCyFbUxG6K0qiD+8q8dCzKIXUCIIQF0V7rKePsNDQ50wc+lYiQNuIztzBuVDRfo
 W6dpuFnwWa+aoh349SdyENfl76km20uadT++9FoLpvR+7EMEn1XVUm/jJupbavS/FTZO
 0XqmYh9RjInXELW8apV+TMNMJBd+toG25b4dxiHqrq11rDnVv/dMn87owqUrpvrJ07eV
 ehoqdUqON7gNnu0vptiOMal1MErbF9mQnNDHtP8FOJyuhpTycsZ7aOMV8vIk2Q+OkFWv
 YG9cOIjTeEumvYdYus1nW9iNynXFEY55bcu4rbQDEttC3ENxPQZ33G8OQTb9HF/PJWP0
 8ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741002408; x=1741607208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdlPbpIFj0/t7ED+bsr0Srbzkrk3Qt3hyYAAzB4XwNA=;
 b=oH3Nh+O2dzlx9EvQDCMXJDkOiB1XuCrW0ksNyYEOAyBiYXErGBMKgQlerJ9Q/WbSEd
 D9PwBDkzGHM9PkRjUs684lX8uZoUyxQdiqTWKeCNn1I6BDtV3P1KS/aD2HgUK3sNC0yA
 GNbZlqOeVTWd17dT11PFlx971OTeNx97gUEC7QlriuwlUEQOthPxmjFA2fAfiO5yyJJp
 U6PNlfjdJBc9/G7Rc07jYVfsAd6IHL7tgmXW8114oPKTLlbiSgza2i0bYHXD9yjbarDm
 o7xaoFn+o9Dx6Ot02lCq6HvHkAJG19kzQfZaCmgeVRwLlKkzeWl9KVTCBSsnupLzS6mi
 bBOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYuNOuiTqzDs5bENLVQH2TjVQ99uRA7Jceoz09E/lA/ZpzIRrhUoz+GYOqmP8RFTQq9SzUrbfCGItk@nongnu.org
X-Gm-Message-State: AOJu0YwdJ18b2EfrMDa+HWEpDZGATxkJ9jIRxE9guG7qK7ihUDsw/TX1
 KShowREwbO3TC3MWjwviPJXiAt5X17D8GzVmgqwSm1I5mhnG0fYIp/+/1ONQNIbkdo3a/RABy9i
 QlLY2Zx+4sXq2hGqeZqPTDVTwrgU0mbNGZTOCHg==
X-Gm-Gg: ASbGncvqAGzikdzMLo1WI1ZsvXgBQ+7EJb7THmdyY7vqcuxQ/Zv0fML6nMTId8Kgagi
 O5JKRcd9++yWXBTArieHDZs06794uT1ou+E+q3eiactNRDY2ltMwmICyRNv0RFayi9RXA0/1qeh
 dtiLv69C3LfXwxEMDCeQa8uLktF3Y=
X-Google-Smtp-Source: AGHT+IHu+bj0nrS6azr13qW+2Vi7wZInGeALPkilHwi9iVlZzI2T7/1qzweqUgShzXIMdnkXzbVDN3/WoNvr1HW+az4=
X-Received: by 2002:a05:6902:320c:b0:e4d:25c6:c3b2 with SMTP id
 3f1490d57ef6-e60b2e8eebamr14126733276.7.1741002406456; Mon, 03 Mar 2025
 03:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20250227154253.1653236-1-venture@google.com>
 <0256b5de-12f9-4c13-bbff-e7fcf593f542@linaro.org>
In-Reply-To: <0256b5de-12f9-4c13-bbff-e7fcf593f542@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Mar 2025 11:46:34 +0000
X-Gm-Features: AQ5f1JoT1W_H4e6n5y4BHc9aO1_Ev2Ffmy_o_HzhF6r-k0kvQCgRzT3ZgQSivCw
Message-ID: <CAFEAcA89sSmXEBTUbt2x7sPmqQZsqPkMedLbsn0dqhx+b=advg@mail.gmail.com>
Subject: Re: [PATCH] hw/net: ftgmac100: copy eth_hdr for alignment
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Patrick Venture <venture@google.com>, clg@kaod.org,
 steven_lee@aspeedtech.com, 
 leetroy@gmail.com, jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, 
 joel@jms.id.au, jasowang@redhat.com, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 3 Mar 2025 at 11:17, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi Patrick,
>
> On 27/2/25 16:42, Patrick Venture wrote:
> > eth_hdr requires 2 byte alignment
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> >   hw/net/ftgmac100.c | 15 ++++++++++++---
> >   1 file changed, 12 insertions(+), 3 deletions(-)
>
>
> > @@ -1028,6 +1032,7 @@ static ssize_t ftgmac100_receive(NetClientState *=
nc, const uint8_t *buf,
> >   {
> >       FTGMAC100State *s =3D FTGMAC100(qemu_get_nic_opaque(nc));
> >       FTGMAC100Desc bd;
> > +    struct eth_header eth_hdr =3D {};
> >       uint32_t flags =3D 0;
> >       uint64_t addr;
> >       uint32_t crc;
> > @@ -1036,7 +1041,11 @@ static ssize_t ftgmac100_receive(NetClientState =
*nc, const uint8_t *buf,
> >       uint32_t buf_len;
> >       size_t size =3D len;
> >       uint32_t first =3D FTGMAC100_RXDES0_FRS;
> > -    uint16_t proto =3D be16_to_cpu(PKT_GET_ETH_HDR(buf)->h_proto);
>
> The LD/ST API deals with unaligned fields, would that help?
>
>      uint16_t proto =3D lduw_be_p(&PKT_GET_ETH_HDR(buf)->h_proto);

No, it doesn't, unfortunately -- I forget the details, but
if the struct is unaligned but its definition says it is
aligned then you get UB even with our accessor functions.
This is why in commit f8b94b4c520126 I had to fix this for
struct ip_header by marking it as QEMU_PACKED, even though
the actual access there was a uint8_t*.

(See also the other thread where I suggested to Patrick that
the best approach here is to mark eth_hdr as QEMU_PACKED,
and fix up anything we need to do to make that change.)

thanks
-- PMM

