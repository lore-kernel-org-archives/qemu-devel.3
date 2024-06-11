Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1905EC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2AZ-0008NX-SR; Tue, 11 Jun 2024 10:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sH2AX-0008Mo-Uo
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:08:14 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sH2AW-0002LI-0B
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:08:13 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-354b722fe81so4925706f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718114890; x=1718719690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xa41lpxo6b+pt6sjExRmhHRcck8PBqAPB8RIER/pVAc=;
 b=t5VZzpvTJIXt7SkI6jEOjvTf8qWBAuySiawo5Yfx+oJGv+mSKKoGM2vATBFXvJO2ci
 a+0HdYReqwSIJ0mTUsPhOesq0Ioz0lP5wzBP4/tv2TK/22G8Rd7wzdx0+gNtfSxiJwuQ
 6Tiss6/sRNEa6yrrvcFgK1uwNi5zkviZv8ex1clFAJbSxVr2/D8EL1vpdP8OR9Ycg48p
 AedcspOaTCkffNTnvZqB5HcFvp8BrILy71MsZ5iYMgnFLI4qM2PduIB+ESCrdlFSbLQo
 dgyIuz4oC9I+GGWXppfUl8/l2AtU3UTwxMdwQiEbnalZU9oTjSV9qiXF6ceQwinVWzRE
 FTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718114890; x=1718719690;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xa41lpxo6b+pt6sjExRmhHRcck8PBqAPB8RIER/pVAc=;
 b=WupdOdrxmsBiledDb36jBaEW/lTh5w2YGcBFkigUY1BEJkVTouCUFSBJVYDolHfwb1
 479TOt8G7MeoeIpbFDGeRYunIpkHG2I6Prxme+oHH/E0/qNo5+2KeBT2qO30XvX1ywJp
 SOC/XFlZBsYRvJ/k1V4kGSKDeSo7CjmOarmLoaMs3jQAAsg0WdzkxW2TwoILoVi3lFc1
 GKS6mV+BQO30Fqecurg96ZcLdFCt4Cm1iUqvKdxKzNHDv0zpux9Qn1cgzo7iV90aJ/tk
 n0S6FhyluorYSiCCIZxqgKg1x0rJcr1RbjQ6s01yl19nsXrHGKB4kC2dqCpzkeQxPSzS
 +4iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFK8A8mKncMkNeGG39ZaUy/+uI/qYGYbLyutU+KzDTO4GdUJ0rOQq/WqikjRqafepYrvrQBCf8i3bCHGRzIHHeZKBsUsA=
X-Gm-Message-State: AOJu0YylWbccvOsYjCvo5PYsdddm1cAJFoQ8PyxERjukIA/yFBK71GCO
 WOQeF7PjfcgqWdjYQi996uho6dbQ+x25qPVQo2IiEdSjLFsRTyFoVDDwtxkyQ/Y=
X-Google-Smtp-Source: AGHT+IGeeJfsQXuipgVvy2R05QEs3sgsB6lvEA0cRC5a/iNYDlZrmx4GOgD7ZaFib3cj4383aOFzqg==
X-Received: by 2002:a5d:50ce:0:b0:35f:f24:c276 with SMTP id
 ffacd0b85a97d-35f0f24c302mr6181718f8f.55.1718114889999; 
 Tue, 11 Jun 2024 07:08:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f24fb3fa4sm5380462f8f.102.2024.06.11.07.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:08:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AE06A5F898;
 Tue, 11 Jun 2024 15:08:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
Cc: mst@redhat.com,  sdl.qemu@linuxtesting.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/net/virtio-net.c: fix crash in iov_copy()
In-Reply-To: <a2a6e83e-fb47-4de1-a807-81843092c3fa@swemel.ru>
 (=?utf-8?B?ItCU0LzQuNGC0YDQuNC5CdCk0YDQvtC70L7QsiIncw==?= message of "Tue,
 11 Jun 2024 15:33:12 +0300")
References: <20240527133140.218300-2-frolov@swemel.ru>
 <a2a6e83e-fb47-4de1-a807-81843092c3fa@swemel.ru>
Date: Tue, 11 Jun 2024 15:08:08 +0100
Message-ID: <871q53zi5z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

=D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =D0=A4=D1=80=D0=BE=D0=BB=D0=BE=
=D0=B2 <frolov@swemel.ru> writes:

> ping
>
> https://patchew.org/QEMU/20240527133140.218300-2-frolov@swemel.ru/
>
> On 27.05.2024 16:31, Dmitry Frolov wrote:
>> A crash found while fuzzing device virtio-net-socket-check-used.
>> Assertion "offset =3D=3D 0" in iov_copy() fails if less than guest_hdr_l=
en bytes
>> were transmited.
>>
>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>> ---
>>   hw/net/virtio-net.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 24e5e7d347..603b80a50a 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -2783,6 +2783,12 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue=
 *q)
>>            */
>>           assert(n->host_hdr_len <=3D n->guest_hdr_len);
>>           if (n->host_hdr_len !=3D n->guest_hdr_len) {
>> +            if (iov_size(out_sg, out_num) < n->guest_hdr_len) {
>> +                virtio_error(vdev, "virtio-net header is invalid");
>> +                virtqueue_detach_element(q->tx_vq, elem, 0);
>> +                g_free(elem);
>> +                return -EINVAL;
>> +            }

Isn't this basically another case for goto detach?

Although the use of goto's here is a bit of a code smell. I wonder if
there is any way to better structure this function and take care of the
auto-freeing of elements?

>>               unsigned sg_num =3D iov_copy(sg, ARRAY_SIZE(sg),
>>                                          out_sg, out_num,
>>                                          0, n->host_hdr_len);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

