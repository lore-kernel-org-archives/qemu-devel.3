Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1CDD58067
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFXZ8-0001hh-0N; Mon, 25 Nov 2024 06:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFXZ5-0001gy-MQ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:47:39 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFXZ3-0005vl-Uc
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:47:39 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-382325b0508so2849927f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 03:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732535256; x=1733140056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7oPjrALCciiEBbVZYZZf2FLGtOI7ntyud4cR5EjhppA=;
 b=NJo0v00wYzj1DmU0E853k15EvXItxBBe98QTLNS6Q3217Tgbl2dpmmVcxA+rNHqcoE
 e/M8OBE3WAhohwxivUIWY7rKn5SiDct2DwuYcXeSzut5x3DbKsbLQzRzAdtreakpqG7m
 jCeOG+Z8hQ7lP9fXA5+zsWu3w6QIeggz/EEZ6xXghD+fRd17fn8+LQ/treCWw627Tc/I
 fvY9rsG/vxWKaG5vVxgKlNzsUlgrUNT9pyrFW8sR5WWTb7ni32vsmHwaFk4RZL4UqgwC
 OjzxYEkQVWxgSY69tnJF4/jwyoA2vCrIMHqnN/GavYowIjcO592XqucKzQJaexE1xWru
 0wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732535256; x=1733140056;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7oPjrALCciiEBbVZYZZf2FLGtOI7ntyud4cR5EjhppA=;
 b=ABVKSm1d0ilJuNY89Y4TWeILXU2CtrDmGFujywhqFpvl8cmnwoVld3YkcAsmR/o5sY
 L040auPOjzrTlqa8BeA6I3cWrdkw4U6GqHoPfwLtzp42xzck7DY+13b+IBgKbtZwS/g/
 m6VHtVsE2qu+AEKD6pKpohAJj20J62jh+61B92AR6XEXsU8Kk5Yag7UR5PxeUvnkngk2
 ly4hnHuTvzZjLerIzzOCtiuYbVId94f9mWvN/r+RwZu+8kewRepVsX8IyXwPA2PlpomV
 cqFcZIkew/ucVSjPsaZ3AyfI8cbvTU1o+bZtDJ1hxV4SNrIMTLjTM8W9KWm9RFzO62QJ
 Qt+A==
X-Gm-Message-State: AOJu0Yx1QGsYUHdFQXvi+wl6P4boiMrXUzk35l0tIfy5deEbZ803rgQ7
 lms63nno5Ma8IbnadOhlmtcWSra6A2Ppy8F4sn5SB69ESRqX4Ms+purTITPYdCw=
X-Gm-Gg: ASbGnctcaKhsUxVya8LRbDDUfByK8x5FDo+vprPwrcoZs51gGDGOyI3h7fNxNzibu4w
 BzOlmRzzJETHB4tf/2Ocf3RmwvJ2CrjAs+93FeCNg+kZWlkRrxYoQ+PhL0mUEF+KSfymLq1JtHQ
 77l3xGKYmJChN2OJydFXcQlZOJjrXatfD0tjC5Mna0GGqQ8wL+xP5fhIoj/c4MObdDVVs6o+Mht
 DZ/eSMDk7iaYch8R5hgbxQxl79mtF1cAMVp8HZUiztFTcEZ8qXMoM+T/czQcgSXSQ==
X-Google-Smtp-Source: AGHT+IFIj+GwPm+TJ5HQP3Vnxlg48zwP+tVO1ghYwzfEu2ri7FTbv0jWknKe2N7/4FiZuzUudBj4zw==
X-Received: by 2002:a5d:59c6:0:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-38260b485dfmr11135291f8f.11.1732535256044; 
 Mon, 25 Nov 2024 03:47:36 -0800 (PST)
Received: from [192.168.69.146] ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad6730sm10538708f8f.9.2024.11.25.03.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 03:47:35 -0800 (PST)
Message-ID: <963aad3c-69aa-498b-9fba-2038ab4a3455@linaro.org>
Date: Mon, 25 Nov 2024 12:47:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH for-10.0] include/hw/boards: Optimize the booleans in
 MachineClass
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20241122084923.1542743-1-thuth@redhat.com>
 <Z0RZmfjJmaHsfmWy@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z0RZmfjJmaHsfmWy@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/11/24 12:03, Daniel P. Berrangé wrote:
> On Fri, Nov 22, 2024 at 09:49:23AM +0100, Thomas Huth wrote:
>> While looking at the QEMU binary with "pahole", I noticed that we
>> could optimize the size of MachineClass a little bit: So far we
>> are using a mixture of a bitfield and single "bool" members here
>> for the boolean flags. Declaring all flags as part of the bitfield
>> helps to shrink the size of the struct a little bit.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   It's just a micro-optimization (the size of the struct decreases by
>>   eight bytes), so I'm not sure whether it's worth the effort...?
> 
> Given that this is a QOM class, rather than an instance, we'll
> only ever save memory once. That's an unmeasurably small real
> world improvement. We also have no ABI reasons to use bitfields
> for this.
> 
> So if anything I'd suggest we take the opposite approach, and
> eliminate that bitfields in favour of just using 'bool' for
> everything, on the basis that a bitfield has no reason to
> exist.

While I agree with you on this, and the patch would take less
than 1 minute, all of these fields are legacy options. Maybe
a good opportunity to tackle this technical debt.

I.e. as of 2024 having to set no_parallel/no_floppy/no_cdrom
to true to every new machines seems counter intuitive.

> This could become useful if we aim to institute a general ban
> on the use of bitfields in QEMU, as a way to avoid the struct
> packing differences on Windows.
> 
>>   include/hw/boards.h | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)


