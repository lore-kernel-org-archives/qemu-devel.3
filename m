Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821A4D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 10:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZoQd-0006Cy-KT; Sun, 28 Dec 2025 05:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZoQc-0006CW-Qc
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:55:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZoQa-0003ik-RS
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766919311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mlrgCIkrQA0D6TEmz4isG+Td0QCeHERVu1/EiC/NvGM=;
 b=CkyLjDH7wMlXW18hiNUUQjENqbT2KQ9cXPXH2GZFjFwQUj22MRFAXJVJS6v9x1BPROIFUg
 WwamDIUx1Vm9O9444d/ehtOOtGJ8tZMIE95IOINfbRarhjsqrx5MryRNVvbadtIPFgtmAd
 Mr9NxGfFuc1pACyncC8Lrgq9IZIdTzY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-7LVECr0fPI2fE2IkN9LP_A-1; Sun, 28 Dec 2025 05:55:09 -0500
X-MC-Unique: 7LVECr0fPI2fE2IkN9LP_A-1
X-Mimecast-MFC-AGG-ID: 7LVECr0fPI2fE2IkN9LP_A_1766919308
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47775585257so58127835e9.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 02:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766919308; x=1767524108; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mlrgCIkrQA0D6TEmz4isG+Td0QCeHERVu1/EiC/NvGM=;
 b=GFW8qnUMOI9oSTJqv+5tfetkRPA0HD8tONo6yRBId/QlS6AR/X7m18L8C1ISXhqJNK
 1Zej/kgUR2pU5jVOLQEXkR8KwuBHHsEnFC+H2diaav+NxqTE+ilOfzJrIx6JzsZUniMd
 Dvmlwv8ci7KtMuO5ebeFU5okkESapeRiYGvUg6Eiz15DG8uxS8947tqI5fd97kV9b5IV
 P7JNNIwYalcxyFQscb5UQLVUX2M25wSwDp/r10BTQ0skIorvKZKP0RQEZZOXSytnOVdX
 8XsvUrgehJcigsNnNxlRJwuIr3P8djoc9RQsGD25L1N9Q8PYZCE5YtVFyl60wxSPh7lK
 Iz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766919308; x=1767524108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlrgCIkrQA0D6TEmz4isG+Td0QCeHERVu1/EiC/NvGM=;
 b=b01a0zKPPc8FFPJALAvlqE+8ZhD3H4RaQ0s1qLzVZGDOmUFzXp5+QOMWixKUUG86g4
 sk8KKi31aXBWRNTypnmYKd2VwAQQwNoJ0oAbOL9m+CivH1Gqvh5Z2CXad9Uqd95auE3O
 ufVDFmXESJOqHKIOVOqckoFfi/q9Tpz3hm5uaDD0FSf5+Be9ZQJ4I0eOUfLhxE6n9YpK
 JZ5so5kuLSeUE/cxnOtqJ6OJ4VnB8QPuygCh+yXGTkBX0ke7KZ+BjSYFu9quSLfBpurB
 eUeLD9I8LK0f0dJlWRVag0goS1rBK4kVM7K8NPHC6XcF5UR0TZ4LQBwjMew8y3JObXtL
 UUvw==
X-Gm-Message-State: AOJu0YyLrPya/xc/q9BitsUcPRW40k/3UXT5dYZop//DBgBmw6dHuIcs
 3Ma4Y7fFYFiXKu5gToHyB8azhgG64nwKg4ovbcZmVss+I40kAE5h4OwmJZCwZrqIEY2wWpdbd71
 45R6rBY8pY9aXuspMR19dT5rz9Lybnq1Z+0zr5V2LK/NubfwiGkdLGT7eGBITEIJbALLTcMFdKR
 A5SC1nOSIKU20pEoDfwclS0XNCMUfun5E=
X-Gm-Gg: AY/fxX4/UelMBWzNIDDNFxhmHjOA9lp2HTZuLOr/9+JuvVUdNte1Et7hKwzvgzCFmv0
 eDjWbJVi+ECjwjvTJ3Nj8Otd4sFtpNGPmEA7wkZnkglio4CjGOTPf6hfL3d/orNn/Lty0ISMiOG
 TV6DuY9zjMlDLuy39A+2vrQ3Vul7HykouLGD3vdBdBGKT5WTLHzUD7DczT7s8x4Po0wpO5Ijg+7
 WMKW6rhbR5RUqcNzKFcDts1bPzCGWxTG0uotf5Wtfk6sZEb/+bX71GnO7CpwJdDDo/Or+s=
X-Received: by 2002:a05:600c:1c28:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-47d1954586amr300093065e9.10.1766919308406; 
 Sun, 28 Dec 2025 02:55:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHff1HKTGyviVG0TZ79apBR6C7tTuejO6UX/9BEiLdhCBH8WktL/Kl68ue5qjBglGEmSp/xQVlTQ+JLpPIcNXA=
X-Received: by 2002:a05:600c:1c28:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-47d1954586amr300092955e9.10.1766919308020; Sun, 28 Dec 2025
 02:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-4-philmd@linaro.org>
In-Reply-To: <20251224152210.87880-4-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Dec 2025 11:54:56 +0100
X-Gm-Features: AQt7F2pNSzhKcumXt7Rj9S2EuzGmuFPPAqm4mUhtd3Yj9NqSRVSJ8wsEnlrogpk
Message-ID: <CABgObfYbU70d=02Sw=KCV-9fmZpFKoighKjxKfLW-p5Oi4iwxw@mail.gmail.com>
Subject: Re: [PATCH v3 03/25] system/physmem: Use explicit endianness in
 subpage_ops::read/write()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
Content-Type: multipart/alternative; boundary="000000000000b3a010064700f5d8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000b3a010064700f5d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 24 dic 2025, 16:22 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> Replace the ldn_p/stn_p() calls by their explicit endianness
> variants. Duplicate the MemoryRegionOps, replacing the single
> DEVICE_NATIVE_ENDIAN entry by a pair of LITTLE and BIG ones.
> Select the proper MemoryRegionOps in subpage_init().
>

This would need further adjustment when the target endianness is not fixed,
but luckily the extra complexity you're introducing is not needed. The two
ops add either 0 or 2 swaps to the underlying flatview_read/flatview_write
so you only need one copy. As long as the ldn_*_p is consistent with the
endianness of the MemoryRegionOps the result is the same.

Paolo

--000000000000b3a010064700f5d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 24 dic 2025, 16:22 Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Replace the ldn_p/stn_p() calls by their explicit endianness<br>
variants. Duplicate the MemoryRegionOps, replacing the single<br>
DEVICE_NATIVE_ENDIAN entry by a pair of LITTLE and BIG ones.<br>
Select the proper MemoryRegionOps in subpage_init().<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">This would need further=
 adjustment when the target endianness is not fixed, but luckily the extra =
complexity you&#39;re introducing is not needed. The two ops add either 0 o=
r 2 swaps to the underlying flatview_read/flatview_write so you only need o=
ne copy. As long as the ldn_*_p is consistent with the endianness of the Me=
moryRegionOps the result is the same.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Paolo</div></div>

--000000000000b3a010064700f5d8--


