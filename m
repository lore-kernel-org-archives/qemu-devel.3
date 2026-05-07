Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B15CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 11:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKwW7-0005Bm-2P; Thu, 07 May 2026 07:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wKwVn-0005AP-Q8
 for qemu-devel@nongnu.org; Thu, 07 May 2026 07:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wKwVm-0003qu-9R
 for qemu-devel@nongnu.org; Thu, 07 May 2026 07:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778151798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJBcgVPA9/WP7hs51QbhMs6flx0KjCGwmiWfAVLc7cs=;
 b=JqhX/wkXaq33IrT+zWzvIYx7dqEBnozAMkiYeYtp8eThI21SPHpcl+BwnGMqRMVSV96dt8
 x03RJgenDS49DVS7rorYVT/Uk0a3g0jSs5gSCy3y5L4eSeXNt0sW7vEu+fhUuScF3yHMxQ
 VXu5CfAsb7dlSPjAAFtVe/fGDRHeYZ0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-fw6n4L59NdWdaObGOMzKug-1; Thu, 07 May 2026 07:03:16 -0400
X-MC-Unique: fw6n4L59NdWdaObGOMzKug-1
X-Mimecast-MFC-AGG-ID: fw6n4L59NdWdaObGOMzKug_1778151795
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c82346bdb00so803049a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778151795; x=1778756595; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJBcgVPA9/WP7hs51QbhMs6flx0KjCGwmiWfAVLc7cs=;
 b=V37VLwzn+sQI0MwuU7V9h3MhywIrxuCcRX8EU4kkMXRm+moc0qrHln953Q5L416jR4
 Rq6U7dzoQpYY1SbCYyrf5jnnpr8J6gfUybcZXgf5fZb+yi2cASUZTkcSkHimhRmpY11G
 N89uU2b0LCkh09F6DPF4CCsSv1zHgOaUK9QSuiyV3y7szryycwwVSq7qAZd4qfOa7gaI
 NB5Y/q5D6n/TE7AZ2nNZZOt+GeaD29F8hWRAHhrWSZ7BSD9ARm2QwqEWQ8hB4UL2Rhph
 H07x1DlR7mqdsNqUIuGi5JwVlT2VH3KB+xV9uPhBgd49snuPWGmap+svfbjopOn+O82A
 uYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778151795; x=1778756595;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dJBcgVPA9/WP7hs51QbhMs6flx0KjCGwmiWfAVLc7cs=;
 b=b8npeyVH5nHjBLcdkVFTfWGv5ANvfLpQIMMu9HlcRn3JqU7v+3kHvF4WW+6EQXCIEm
 kzqeB/w66Hc0h/dmG+j+E+1T7DW9e8px3yITD0oTQFEQlun+nIKxuC8Jgws9vYE+h3rr
 mKSSmqVQBke5imJ/zl5uKalm5SvEbvtd/8fi5UIu64coIxiF/wLcaOv/EeHEcSxv3fjC
 OxelZ+DrP30gVDulYP6yL2x0osSLBxv7VKlJulN7q0zMXiw8nQwhE8OuZP3uCwhqkKIV
 4Xw3o+z9PU6Lb83AINZvC0vZKFF6FspwQvxeH7FszroVrdC8qGTvQ01tEV8dy4UL64nx
 2BQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cmFELbFKsk3Dn684TyZqeyXW6TaHwJu4n7HSb8Qd3s4Hfg5O4/XdS5rmU2f3CNeknbQNlIVPi7UPn@nongnu.org
X-Gm-Message-State: AOJu0Yyn/lazlxiM1/1JRTsknTr4T2uWkH2TQXe964sQZC3R6FN7HzPe
 YIitSIgTLZrroBgCLQZr2VrLBPkG0fTViFaPhlAWWraRLWxmrOV7hlZ2Z5Ouor9ZYanTaRDx4RS
 hE+h+EisBGxGNfBWnd83bB72FIGgAb+yyTWvRPTLN67Gv5xPFxkUUjHmB
X-Gm-Gg: AeBDiet63QDZ+SOzMLNC1roEYdixLdpXHlyXgWR6sCnP5483LjMT9DS1zltbqPUQACG
 /prQH7nCrzJbYQn1dZAdudrQALWd8rFoz289T6apW5q9o2/oQHkZXI92wEj264rs3Ps54fBAVgD
 0QRP2VX0k72XNugJGZ2i/cuEg8cK3pGpkuviaGHKvw9dEm5EaIKrnGFAqEt/n4JCY1NRSvp2oTN
 8s6AddUmKs7p6I6uoWtXUn90z4p+D2Z87fEB0l16Zscd9XxSXzBWliIJLrU6WjsJAE16ZB08gXP
 SvRIsd3Bg+z+1Cr0CZ4SYODWDO2MwBxEoJ3I+Fel+k8sPrHHUnjaUJZKIdp6T7kEEVBc7oS9XCY
 GZMLOMO/ogiJ05j0jsSKhTkm7Hsr9UTEq/uf11WxAPNk45YJe/ZoRcSZmr+wKGkMvTk8fCZfK2+
 wlQg9w6ZQ8kOqJbQ35BT20
X-Received: by 2002:a05:6a00:cc1:b0:82f:9e98:1356 with SMTP id
 d2e1a72fcca58-83a5c4bdb96mr7650328b3a.20.1778151794802; 
 Thu, 07 May 2026 04:03:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:cc1:b0:82f:9e98:1356 with SMTP id
 d2e1a72fcca58-83a5c4bdb96mr7650306b3a.20.1778151794335; 
 Thu, 07 May 2026 04:03:14 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839679c8634sm10338515b3a.39.2026.05.07.04.03.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 May 2026 04:03:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] whpx: i386, arm: do partition reset on boot CPU reset
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <94C6AAAA-BF20-4202-9965-081192A392A2@unpredictable.fr>
Date: Thu, 7 May 2026 16:32:57 +0530
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F3BC33B-9884-41EC-8E81-9E0C80A396F3@redhat.com>
References: <20260421205749.55060-1-mohamed@unpredictable.fr>
 <a8cb94f0-9970-40b8-912b-3ab81a5907f4@linaro.org>
 <94C6AAAA-BF20-4202-9965-081192A392A2@unpredictable.fr>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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



> On 22 Apr 2026, at 6:38=E2=80=AFPM, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>=20
>=20
>=20
>> On 22. Apr 2026, at 14:46, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>>=20
>> +Ani
>>=20
>> On 21/4/26 22:57, Mohamed Mediouni wrote:
>>> WHvResetPartition resets partition state, and is not supported on =
Windows 10.
>>> On Arm, it's supposed to be used for reboots. The prior location of =
the
>>> WHvResetPartition call wasn't right, as other vCPUs might still have
>>> been running, causing the call to fail.
>>=20
>> Is it very different from the conceptual step introduced in commit
>> 4003e5e65fe ("hw/accel: add a per-accelerator callback to change
>> VM accelerator handle")?
>=20
> Hello,
>=20
> The difference is that we reset the partition state but don=E2=80=99t =
have to=20
> re-do any of the memory mappings in the Hyper-V case (or otherwise =
tear
> down the context).
>=20
> We could fallback outright into the CoCo case which would work too.

The rebuild_vm() callback is used only when the vcpus are not resettable =
(so Coco case). If vcpus are resettable (non-CoCo), then that callback =
won=E2=80=99t be called. Within the callback, you can do whatever you =
need to do.=20



