Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A132CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAorV-0001s9-7m; Mon, 20 Oct 2025 08:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAorH-0001l9-OL
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:19:30 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAorD-0006p8-TR
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:19:27 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b3d50882cc2so818049766b.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760962760; x=1761567560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kT0j/s0XBuP0ITAjNCV5ZQF3F9LmCWWFhKV3gfp9k/0=;
 b=hztNPnoxOrpfLoXPP8uR93C59lHP7cHo9os0kAIisNPXj6KsbXhnc/xLsSCJskApKg
 WH28jd8p1eneYq8d105eM5O25hr1mb0BgwrdxRyRyp9ieLpRJB3WAKVYGLCE6nctBKM3
 wA+WGMkkg05ZaOzrnxUMuhV2q0fDQQ93K8eL0kN+Xsfm5xpudhjnuj5KbKHv76yH7TKc
 L/pHS0hy3kiUKZUVDypWe85DQBms9jxYt9deJHBG6YBvoC6NspEF9S9TF/qp9xs077cE
 JBXYrQK1SG1dvHaZuEnnEwzVwf2hdRtkfTHBOwPBhnM6AJJhjLGqYwp10IgxgLZp8utd
 UOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760962760; x=1761567560;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kT0j/s0XBuP0ITAjNCV5ZQF3F9LmCWWFhKV3gfp9k/0=;
 b=Q8juSpweCtPOTknN4w9m6TAYNmdmLnwIVxsuuXLfY2nnM4bNV5JvWTfN7l3wnXA6m4
 8h+Z3dxLb1sl9NgZv3xeKGaiJQX9GgIi5Jdx8iJhBHnkGG6W8jK+26B8QkmiSV3/frx4
 fPjv4zPNs7H7QydfRWlyfyKoz2QDJPAPgo9ecS1FTZsodG4adbd+FZdhGD2oJIsDMTdX
 7zBYi3frDReRppjLeOJRn1V44HuujIqAad13LkPbRoBMtZIN+u/VqWPs+KZZ/HzVgJA9
 8PnRbAOytRRfeayvOT94nVgl8UdjOZI3deKEKQ1nZAkq7bEHSXOXyRn24topishLE1aW
 yHcQ==
X-Gm-Message-State: AOJu0YwNI1DSj2XLFQl0J33YPQolvNRXFuH8RQ4MovCd6MOPQXwi3NSl
 hzOP5dAAOrH+AWBdQuHqwN979/lPafM56y7+0K94erwe7IkQi+jAsLmLrAsMCw==
X-Gm-Gg: ASbGnctYpho1IfF/Dago+85/Z8MkFEf9lhxL3KIkmY5JsSwZYvH506s27Zb/XcK6zHt
 R2lAUdmeRfnUClyn/kXe/DedZ7iRdHXX0v9MSf0dGCSmVxnRrPefYS/AmrHbqC3MnE/5JR6NavM
 bUFB6SsK+70NsrqFT4g6D42P/fU9pISd1Qt4ChcZC4mOldA5oTA50UlB7Dp1PlAECSZNAhscWr4
 lSJKUxNkniMpryrj3B0i/f51nXr/qk/kwn77xi2aYh0O7aIQLI4/nD2QRQg5iDRf99D3PPbxJi9
 qaAdn+tQmWWGlXips2QhWnuNIHsFVwZ2zXsLiwhvYDL80ZyzDASthebN3jeoIHe3LVdd3AEBXHA
 iTIT4Sw91y42BhhGKyZgQDQZ5qA05YLq5I8WHqySFMhlBTLoe0Z4TngLkizj4p6uSGsypb/jryH
 Jks0at4iIpakO43jkTlQ==
X-Google-Smtp-Source: AGHT+IHxPPhHxkb1OPMx+8tRbXsfi7bsKNPwr2ehmzVPkmhExYX3HfawB7KM5n+STVBA8HM1UbVekw==
X-Received: by 2002:a17:907:3dac:b0:b45:8370:ef10 with SMTP id
 a640c23a62f3a-b647245845bmr1536621066b.22.1760962759904; 
 Mon, 20 Oct 2025 05:19:19 -0700 (PDT)
Received: from ehlo.thunderbird.net ([90.187.110.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65eb0362fbsm784362466b.39.2025.10.20.05.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 05:19:19 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:27:14 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
CC: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
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
In-Reply-To: <2cbd9feb-2c20-46e0-af40-0bd64060dfba@linaro.org>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-25-mohamed@unpredictable.fr>
 <2cbd9feb-2c20-46e0-af40-0bd64060dfba@linaro.org>
Message-ID: <6982BC4E-1F59-47AD-B6E6-9FFF4212C627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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



Am 16=2E Oktober 2025 17:15:42 UTC schrieb Pierrick Bouvier <pierrick=2Ebo=
uvier@linaro=2Eorg>:
>On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
>> WHvGetVirtualProcessorInterruptControllerState2 and
>> WHvSetVirtualProcessorInterruptControllerState2 are
>> deprecated since Windows 10 version 2004=2E
>>=20
>> Use the non-deprecated WHvGetVirtualProcessorState and
>> WHvSetVirtualProcessorState when available=2E
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable=2Efr>
>> ---
>>   include/system/whpx-internal=2Eh |  9 +++++++
>>   target/i386/whpx/whpx-apic=2Ec   | 46 +++++++++++++++++++++++++------=
---
>>   2 files changed, 43 insertions(+), 12 deletions(-)
>
>Reviewed-by: Pierrick Bouvier <pierrick=2Ebouvier@linaro=2Eorg>

Couldn't we merge this patch already until the rest of the series is figur=
ed out?

Best regards,
Bernhard

