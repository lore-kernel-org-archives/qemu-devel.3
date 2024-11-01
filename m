Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFC3E6F06F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 17:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6vGO-0004Lw-L6; Fri, 01 Nov 2024 13:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t6vGK-0004Lc-RL
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:16:40 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t6vGJ-00076v-5O
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:16:40 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a0f198d38so329111866b.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730481397; x=1731086197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkhnW+18j4lMHBdZnU4Y6mGEduZ3VjhpJV5HUL26r7Y=;
 b=o+XLEklu79SIeBIAFstQ1xfJs5lmrDbJRNUzPVyV6qmfYS5cqws81TOcoLMtRxVq3C
 dV2sbLhmN6w5aoy/fZPEZE2RdlrP8QijBsjPOfPdHia8vAdou+1ZA1jyZdWfTKz0NUV8
 LS5tY3o0pQXokIKnXy/pxXOsU8+3aky4ADxG0ygWjnscTdCiOijvi4LwLtSALXpX20oR
 q9Tsy0cM2UJsF5iQbXtJqnDBoLuZbUFK83NHBB1T2KSfnh5+EVPP9n4MPypTga1Kj2W4
 l06rdCGcaWK7bM7vhrpXftgX22NJPj5jY6kP2pkD8io6cPrSXHd4XdVST379Qe10/M19
 18tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730481397; x=1731086197;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mkhnW+18j4lMHBdZnU4Y6mGEduZ3VjhpJV5HUL26r7Y=;
 b=Ug40Ktcs+KMeW4q0cx7CnU2suZv9aR/Tjopj/C9ZVeWdaxFXLVhalDFnWVkvd0xusI
 hmzo1Bu+X2fHTJtisG042BggjVk0gIQnh/BKHyabirhjo9GD8fPsZJX3cfN2FV6kh3sN
 C7hGx1Lw9/RUrAxI71c1gsA2l+lK8pvWOAxr1DID36HHpdqBHiVAntPJu/uK8TGi4W9H
 OJFU0nnHMilIYwnNej8BKy27rmXEKZbLad8mVwlz+At6g1kZcSrQroZBTTa1WMDcR5wo
 NeRsmOUm4A6saX5nfea1czBYJ0ytNgHhTKKh7zO21BYP1JMkWntkg9195PpD3EzZyHnA
 /c+g==
X-Gm-Message-State: AOJu0Yy1BL+MztPnez3KYoEaMMp+oI2a0hBA5XJpa9qjIyWzAt1g3e7l
 csRH9Hlqu62z171YXsEPWuL1G0qzdMDrPMjfGkQzNu6B5tM9tyFAm7vOxpbAyQM=
X-Google-Smtp-Source: AGHT+IHpQYtWfQxUSX9qBntwLc7NcRI0plUYt5Zcs/ASssCNlMqF6ERrvtKps02RSZFKI52xFQGyzQ==
X-Received: by 2002:a17:906:c108:b0:a9a:a32:bbe4 with SMTP id
 a640c23a62f3a-a9e654910a8mr365165066b.12.1730481396687; 
 Fri, 01 Nov 2024 10:16:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e564c531csm208602266b.51.2024.11.01.10.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 10:16:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2CCA75F8D3;
 Fri,  1 Nov 2024 17:16:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Robert Beckett <bob.beckett@collabora.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,  Xenia Ragiadakou
 <xenia.ragiadakou@amd.com>,  Huang Rui <ray.huang@amd.com>,  Dmitry
 Osipenko <dmitry.osipenko@collabora.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: Re: [PULL 11/13] virtio-gpu: Handle resource blob commands
In-Reply-To: <CAFEAcA8M1gu9Ow8n42i-ie9t-k=yoe0R+D0CUZodwoU_Kezfhw@mail.gmail.com>
 (Peter Maydell's message of "Fri, 1 Nov 2024 15:35:41 +0000")
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
 <20241029121030.4007014-12-alex.bennee@linaro.org>
 <CAFEAcA8M1gu9Ow8n42i-ie9t-k=yoe0R+D0CUZodwoU_Kezfhw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 01 Nov 2024 17:16:35 +0000
Message-ID: <87ldy2ho24.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 29 Oct 2024 at 12:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> From: Robert Beckett <bob.beckett@collabora.com>
>>
>> Support BLOB resources creation, mapping, unmapping and set-scanout by
>> calling the new stable virglrenderer 0.10 interface. Only enabled when
>> available and via the blob config. E.g. -device virtio-vga-gl,blob=3Dtrue
>>
>> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>> Signed-off-by: Robert Beckett <bob.beckett@collabora.com> # added set_sc=
anout_blob
>> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Message-Id: <20241024210311.118220-12-dmitry.osipenko@collabora.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Hi; Coverity points out some possible issues with this commit:
>
>
>> +    fb.bytes_pp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
>> +    fb.width =3D ss.width;
>> +    fb.height =3D ss.height;
>> +    fb.stride =3D ss.strides[0];
>> +    fb.offset =3D ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y * fb.st=
ride;
>> +
>> +    fbend =3D fb.offset;
>> +    fbend +=3D fb.stride * (ss.r.height - 1);
>> +    fbend +=3D fb.bytes_pp * ss.r.width;
>
> Here 'fbend' is a uint64_t, but fb.stride, fb.bytes_pp,
> ss.r.height and ss.r.width are all uint32_t. So these
> multiplications will be done as 32x32->32 before being
> added to fbend, potentially overflowing. This probably
> isn't what was intended.

Also what is the subtlety behind using both stride and bytes_pp in the
calculation. My naive thought would be:

  fb.bytes_pp * ss.r.width =3D=3D fb.stride

Can anyone enlighten me?

> (This is Coverity CID 1564769, 1564770.)
>
> The calculation of fb.offset also might overflow, but
> Coverity doesn't spot that because fb.offset is uint32_t
> and so the whole calculation is 32-bit all the way through
> without a late-32-to-64 extension.

I'll roll a patch once I understand this (and fixup the other case as
well).

>
>> +    if (fbend > res->base.blob_size) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: fb end out of range\n",
>> +                      __func__);
>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>> +        return;
>> +    }
>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

