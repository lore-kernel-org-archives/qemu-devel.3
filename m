Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A55CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 09:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBrYc-0007kJ-GQ; Thu, 23 Oct 2025 05:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vBrYZ-0007k1-2x
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:24:27 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vBrYV-0006iW-8X
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 05:24:26 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo137544166b.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761211460; x=1761816260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wc/vWIbe7zNmH17tpBpu1vmNiEABiUvd2vn+iEYOxDg=;
 b=XDPIPsydj0vNGjkq3CpeGqe2QULeaVtK5b+KGye/iYxpIpnyXmzLBmkyH4bc7KUN5r
 qVVJWfN49xI9lH4hoR9rJDvjEAIrAPISMX8dzqj+FgBR1e4OSLEw9S1y1mAfmj0DM74S
 lUGpYBIGM9DMYyt8arg2yte5TsbT0wrKKX5DCg3+1dOG929CM1kGJS58rYn6rFydSpkU
 c8eTfshvjXXq+2YXS3WG6CoFb/kHi61dXM8RjvR7WAiQy7vMxXW01eVfBJmNklg9F/52
 PbAsYYiUJATlyTpnG/9aKkg48KfJLqCvww7rv2T5yQWxGh9/meMXtwvYjd0axnajiUvt
 reiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761211460; x=1761816260;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wc/vWIbe7zNmH17tpBpu1vmNiEABiUvd2vn+iEYOxDg=;
 b=nuXpfKEp9t9pAHLxYs3sUskxQklwIUtvYeoPccTrOGR9p4XCORNH8j6ilmEOKxVFDJ
 27L2K/E+mjy4glAd/LuYizhFt0m4mf8SgxNWVJyY20ucOWgpnnj6riyYHbe+JnUw8zIK
 MK4Du91oz5sEWKJ1759shWNj1Rdeho1oOrGoHBLcmU4XAujmUZpQ9rClIh+oqYs7d7cQ
 H7FTnpV3g44uz3Jfz4jFf5+KCmEIWhs4BCVGWQt5gT1/Tm7fMKAtsJl9cBimYRwoCx8c
 k4FaULQXbY4vmYq06y+h4MRV1hOHwYUkpCrjUjFQ5LfWbeM/RWGr8ZcL471i1EjFz7hv
 yUkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFcXJRxQ/gxBUy8Ggq38sqcfoK0vw/+W+rXNhktqD+mxHgXbnqsZ1dXzHJ59cD105/JZZ/cIRbe61t@nongnu.org
X-Gm-Message-State: AOJu0YyFLR6v4rTsjILwSu+UBH3G6auE/CbjwBspNSjyIOssCvpVrorU
 l86MFjSaHxpqEMgXuO1d4xIRL/xUou9+M+uv3Sh+IOHquLEdH4OhMOSw
X-Gm-Gg: ASbGncu6eiwU1ZcdWnW9W3hYfSI2ofgVZz6Z58n+EQN8Kww+e7+IkH6lWi27Du9Ggmo
 uv7AaETFUShbuWDbiG/5FBwKPJHDfFCJvwelDe+VCu8rSM/sNQV/PmoDETTqZpK4GZ+WikXIeaS
 pwW0UXNCRJS8GLhT3Tx07RhiLZrFTHF8l2BvQD1fFQD0D1ydC6dr4ZyIwgp40+U+i5MJfVGX+WA
 yAZ+0eRryU7dzOxO/mk5CQAcpPpo/nRJRd/J2DHsrXg3pIs11G0dSRI3vby9PacUhIWURjjNmhN
 SumLxRW4iUUh12+Q8VHaCmkriop2Fw6MaE5ruASy3paA/8A5QD3F4Nm5MgeQOJ4B5oOh9Y+kqY7
 pVSEj/kNlimb8fdJBo6pkC2Zb0p60qpI3Yy8vaPiyElbpOzudAP/8KjiMAwU0jspNE3go0k4i0m
 75tz6MgPtTiZc2S3veT0DW4mIBjQ3QSrKlwOgu7g6EzIY=
X-Google-Smtp-Source: AGHT+IHU5Gei9CD4nq02yBKhEDZA0JJxDkKkZgFYiynYffZtcnsonISoZsbX4e2VEGaNNDX6TpUBgA==
X-Received: by 2002:a17:907:1b1b:b0:b39:57ab:ec18 with SMTP id
 a640c23a62f3a-b6d51c2f64amr167997066b.45.1761211460182; 
 Thu, 23 Oct 2025 02:24:20 -0700 (PDT)
Received: from ehlo.thunderbird.net (ip-109-41-112-116.web.vodafone.de.
 [109.41.112.116]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d511d012bsm182635966b.7.2025.10.23.02.24.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 02:24:19 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:23:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
CC: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_24/24=5D_whpx=3A_apic=3A_use_non-deprec?=
 =?US-ASCII?Q?ated_APIs_to_control_interrupt_controller_state?=
In-Reply-To: <60cd413d-d901-4da7-acb6-c9d47a198c9c@linaro.org>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-25-mohamed@unpredictable.fr>
 <2cbd9feb-2c20-46e0-af40-0bd64060dfba@linaro.org>
 <6982BC4E-1F59-47AD-B6E6-9FFF4212C627@gmail.com>
 <60cd413d-d901-4da7-acb6-c9d47a198c9c@linaro.org>
Message-ID: <0C41CA0E-C523-4C00-AD07-71F6A7890C0E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 23=2E Oktober 2025 06:33:18 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>On 20/10/25 12:27, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 16=2E Oktober 2025 17:15:42 UTC schrieb Pierrick Bouvier <pierrick=
=2Ebouvier@linaro=2Eorg>:
>>> On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
>>>> WHvGetVirtualProcessorInterruptControllerState2 and
>>>> WHvSetVirtualProcessorInterruptControllerState2 are
>>>> deprecated since Windows 10 version 2004=2E
>>>>=20
>>>> Use the non-deprecated WHvGetVirtualProcessorState and
>>>> WHvSetVirtualProcessorState when available=2E
>>>>=20
>>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable=2Efr>
>>>> ---
>>>>    include/system/whpx-internal=2Eh |  9 +++++++
>>>>    target/i386/whpx/whpx-apic=2Ec   | 46 +++++++++++++++++++++++++---=
------
>>>>    2 files changed, 43 insertions(+), 12 deletions(-)
>>>=20
>>> Reviewed-by: Pierrick Bouvier <pierrick=2Ebouvier@linaro=2Eorg>
>>=20
>> Couldn't we merge this patch already until the rest of the series is fi=
gured out?
>
>OK if you provide your Tested-by tag (:

Oh, I did for an older version of the series w/o this patch: <https://lore=
=2Ekernel=2Eorg/qemu-devel/5758AEBA-9E33-4DCA-9B08-0AF91FD03B0E@gmail=2Ecom=
/>

I'll retest=2E

Best regards,
Bernhard

