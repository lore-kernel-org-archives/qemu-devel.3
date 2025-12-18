Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2876D6ACE2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 10:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWBTe-0001B0-0D; Thu, 18 Dec 2025 05:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1vWBTb-0001AS-L6
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 05:43:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1vWBTZ-0005wS-Un
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 05:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766054597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qN8oMOQ/z2gmbjInO5tYtIItoXYlaJagVDX5jAk/VZc=;
 b=cH1Gm7k1KX5BMxKJhOiFyFklEDwXTdPrwHK4fJCshyoSPwdjM517t1oKmE8KGj1bPISsEA
 Ka5uKfWCYYQIRe1jcQP3XEPA3bmLVRxAP9wkgvldy9TsE+FC9BnEar/06kUmIqWpqzWfa7
 gldjOo5u7MJg2XnseD3bEWRXfDRV+Dg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-3VLQgXyHN8qb26TxLHADNw-1; Thu, 18 Dec 2025 05:43:15 -0500
X-MC-Unique: 3VLQgXyHN8qb26TxLHADNw-1
X-Mimecast-MFC-AGG-ID: 3VLQgXyHN8qb26TxLHADNw_1766054595
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c66cb671fso860530a91.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 02:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766054595; x=1766659395; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qN8oMOQ/z2gmbjInO5tYtIItoXYlaJagVDX5jAk/VZc=;
 b=Pfdu3iLygWoscCln85QztBHqQESq77bpOC0LnmVev4sBitv+Z30Gbp1nOdASJzsK/c
 h+TsHgdK8swDt+ZQlt5gS9kbha75XqmoYH5eqyeF5zbrEPloDkYkLM6X3bQKWDkymWIC
 hE3EQiMMAcVPx981a315y7gWLo4E4jk1LAp6S+Rxfv8KArttmt/CEmso3IthwbIKE5Wj
 4n4gJRKymS09o0UIHIrasEQDPjv6aCjuw3vYYoMtSVveiauyBpDbbaJCKfX1g5VEp0B9
 aHQJd2ahRLbet6FPlGI2JvFbjwxAsp0x1WnTCAkTl8BObA7FO6M+IIZVGWJVKiXhq07z
 n4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766054595; x=1766659395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qN8oMOQ/z2gmbjInO5tYtIItoXYlaJagVDX5jAk/VZc=;
 b=gFfL1Rbvl+eudi1EW6NYnWW/Z568QClmM6a30g23kmQq4oEfGGbE+TcsIO0nGm92Ti
 tH6+wHnxMKG6pZ2+osfBwu4sbm/0Ickbhn7riiWTv8ICmXSk2iAoe4bJyRiVUZF+ExV0
 LHh1bWSfeQ+tov7vKMPpFlo/3xwJoY3bprPnbNY2KhAyBmvnrXOvF4Q4lu1xabt9aIlL
 +wCV+NFfn2mvQFXOIvQz+VpEN01pUFMIGtqeV7p6CaVMmZ998bdakhs2EZ60dLv+kQmc
 WhkO60t5oJW4ZlTgcXIRSFjBMiH4v924ii/fgBth9Fgwl86mMab6pqpwV9JUu09ygucy
 g72w==
X-Gm-Message-State: AOJu0YyrmqHBWkEYtw/aLKfgTVaPoHpF2FOorKOr8sr121Ec8RHGj+r+
 eAk5h3eyR2B0WsTwSzEmEf977RQDNNHHRczRn1O7053pcuPTTRZiKGNd+thya62QcoNh2VnLDq5
 JA/Xb8ulU85P8wB1y2/6OpiRRb7SPj+vp4bfsOzqWMfQk/G7wgnaMPMSLd3cQnSh49Jl9MsrAIC
 WQD6S73sqsQuHwdXSM/pUBK+MPtTwD/uQ=
X-Gm-Gg: AY/fxX47zvltP0GIWLAlTIDO34hO5YZQFp6p3FdOPfl8XcrLMnvcSOFesoPXlosLnFO
 1nM1ta053yufvH3aGDXJ1uKDQXK64OxYaR+SPgqfO/iyA4sBeVGPOT1c4CSZT9H1vWGLZfQ+Da8
 LWiE4iwcugsxT4gfdc8r7SFJS8QASv3/wG7S6vIz7jQbSGYcDkzkPrd0PVQCAYGtLE
X-Received: by 2002:a17:90b:2e0c:b0:32e:6fae:ba52 with SMTP id
 98e67ed59e1d1-34abd6c684fmr19695162a91.6.1766054594886; 
 Thu, 18 Dec 2025 02:43:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHRCpzKidHZJMJtY2JisVLnrdcKcwSsVNJjeNECk27D3DWL/uGwSVKkJPGAJpVQPgcOjln/cDospH9sRrfw9Y=
X-Received: by 2002:a17:90b:2e0c:b0:32e:6fae:ba52 with SMTP id
 98e67ed59e1d1-34abd6c684fmr19695151a91.6.1766054594505; Thu, 18 Dec 2025
 02:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20251214090939.408436-1-zhenwei.pi@linux.dev>
 <20251214090939.408436-2-zhenwei.pi@linux.dev>
In-Reply-To: <20251214090939.408436-2-zhenwei.pi@linux.dev>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Thu, 18 Dec 2025 11:43:03 +0100
X-Gm-Features: AQt7F2peDhDze1IILb-P-sMqY-uB_Jidr7qG899FZbp_xC6A62MTRR0QIRkAYpA
Message-ID: <CAA8xKjUd3kW6gAsoUTEjdK-A1=4Y+dR0ywB=iFMf_hYZGEAQhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/virtio/virtio-crypto: verify asym request size
To: zhenwei pi <zhenwei.pi@linux.dev>
Cc: qemu-devel@nongnu.org, mst@redhat.com, arei.gonglei@huawei.com, 
 nakamurajames123@gmail.com, qemu-security@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Dec 14, 2025 at 10:19=E2=80=AFAM zhenwei pi <zhenwei.pi@linux.dev> =
wrote:
>
> The total lenght of request is limited by cryptodev config, verify it
> to avoid unexpected request from guest.

CVE-2025-14876 has been assigned to this bug.

Thanks,

> Fixes: 0e660a6f90a ("crypto: Introduce RSA algorithm")
> Reported-by: AM =EC=9D=B4=EC=9E=AC=EC=98=81 <nakamurajames123@gmail.com>
> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
> ---
>  hw/virtio/virtio-crypto.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 517f2089c5..94dbf9d92d 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -767,11 +767,18 @@ virtio_crypto_handle_asym_req(VirtIOCrypto *vcrypto=
,
>      uint32_t len;
>      uint8_t *src =3D NULL;
>      uint8_t *dst =3D NULL;
> +    uint64_t max_len;
>
>      asym_op_info =3D g_new0(CryptoDevBackendAsymOpInfo, 1);
>      src_len =3D ldl_le_p(&req->para.src_data_len);
>      dst_len =3D ldl_le_p(&req->para.dst_data_len);
>
> +    max_len =3D src_len + dst_len;
> +    if (unlikely(max_len > vcrypto->conf.max_size)) {
> +        virtio_error(vdev, "virtio-crypto asym too big length");
> +        goto err;
> +    }
> +
>      if (src_len > 0) {
>          src =3D g_malloc0(src_len);
>          len =3D iov_to_buf(iov, out_num, 0, src, src_len);
> --
> 2.43.0
>


--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


