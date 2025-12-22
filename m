Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE38E69162
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 19:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXlvA-0001DX-Q6; Mon, 22 Dec 2025 14:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXlv2-0000zo-SB
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:50:15 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXlv0-00059X-BH
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:50:12 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso31112215ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 11:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766433009; x=1767037809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lVtj7846LWfHJvjhe/F50ghadIUiDzYIHRzOQgWOr9I=;
 b=LUrimcA7LWCUI3AgGh2hP98cMYfcwSfJ/gC5w24/+BrVlEZyeY/hMb/oNikKruW086
 cVhIroHsCsR2h642+/Oyzzdb3r0PNgA2QU6ajyHbRBTXhLdy06uCTDb8SknxszX1tTZE
 3art3paQfhBCTwEHntsBPqBQn0owXIX36IDZU09r2u3TzPC7i07VN+S0LbL+KveIJG79
 S998xHc5ocozc2bj1G2cehmrXCqN7xv8UP9uFE0qBkXndHYwWM/YZ1tc9Y4QLvjkJ+Qy
 h4O38E2qa5aE9N69XZBggAe290kWEGH5PSqBs5HU0TjUipEKmPh5y9H8+zD9QeufbRHL
 wl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433009; x=1767037809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lVtj7846LWfHJvjhe/F50ghadIUiDzYIHRzOQgWOr9I=;
 b=uJth3W1i/gW2OKbsT33hI/iCeOYJ9DViRKPfRzLcAncpW+joo6adUx14Ceh3vuSjwn
 7PTQnTHPyIL8XLxIgFYB+iz6iOvZHH2LwsWGGp7EkT5pU7By70MjjPh2gpnMzRh65TX+
 Y+aKHPixXd8r5zCzI6ExwaIpyttfUfz+UyGdlr3boz0KXpwJUBKPQDt7FKzb9vGIvsqq
 nwNz+XAWYzhVbWBZOuZ46HtD9Y+hewfKmviYN8yYIRq5Vw+HyiZch4j223hAry2vsMdj
 wRm7K2IZSOe6RbWOT7wj/A1VXRJhLSd4eZz7V8qtaxBoVeVkRNYw7YEbnGgLQHZofm29
 8ZQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK3ZmDwXWLLE6kIpBctOquqcOWf9CzqlNRdOQ88rS6ilCTwDylw58jvqxMpcAyMPP54h5NtsmD927H@nongnu.org
X-Gm-Message-State: AOJu0YxVKNoRYfXthqaaRBOs46VwIo5yE5OsxTf6+sOakeZ6FzDMBvSV
 1ZFAWgpt5y70GWZo+tYV5NhG++M2WtUOTmo7W94f1DGErOSax9VTT2NHPUnEpMgveSI=
X-Gm-Gg: AY/fxX6DFVTVntgSTrT3dbEXBmi4giljmn8KjDrKhBykIGjdrJDrhMxcEP/cPA83eza
 OfbRraol4LTDJ/rbKJuDnjkQG96s9UKsTGoFtFhj4XBWm2XIaHpcoB6pyO1P4GTu4oQ4RITNbU+
 eQNvYHj4/OgSI44gC5HN98aPCyWTAIrsL4kG22PWHBXfdFegf5rkuYmSmWGdRzCpDBu7tR0mD4U
 iU2LYcFk3LPWx57VQavY8E62vqHRcSFCtK/N4/IVSpfmRUhxY7vAAAgLCLN26QBI3DIyMpt9F+h
 7tS+cS1oniuj0RycYdou2QeNw5BU30oCatEfLBA1LIwoj9ZBoJ+FGVXDvr8tdjvsIhTjrFWvk9F
 OXF0QTfL3gi98B/g1WuP80qYGj7LyKc9tDLHtTvvSO88J4wd2z2mjKmjf5LfXl3uKDoEmsQuwyf
 AAQcCQk44pDLZczWrHqavd2y+QWq3KqPZZA5u+qCPOCHTv5/0YKw3k6J0=
X-Google-Smtp-Source: AGHT+IE5/dJ64aTh9IUvA2M1WBf4TiOAuMmo3X0uR4UJAfBwftZw970P9VtqOYq0HE8eWyxVzNCP4g==
X-Received: by 2002:a17:902:f707:b0:2a0:a05d:d4a2 with SMTP id
 d9443c01a7336-2a2cab4fd97mr139238375ad.23.1766433008536; 
 Mon, 22 Dec 2025 11:50:08 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4d36esm106106605ad.63.2025.12.22.11.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 11:50:08 -0800 (PST)
Message-ID: <b38eaff9-98a0-4ff2-8c18-2290a3c917e1@linaro.org>
Date: Mon, 22 Dec 2025 11:50:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/12] target/arm: allow gdb to read ARM_CP_NORAW regs
 (!upstream)
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mark Burton
 <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
 <20251219190849.238323-13-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251219190849.238323-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 12/19/25 11:08 AM, Alex Bennée wrote:
> Before this we suppress all ARM_CP_NORAW registers being listed under
> GDB. This includes useful registers like CurrentEL which gets tagged
> as ARM_CP_NO_RAW because it is one of the ARM_CP_SPECIAL_MASK
> registers. These are registers TCG can directly compute because we
> have the information at compile time but until now with no readfn.
> 
> Add a .readfn to return the CurrentEL and then loosen the restrictions
> in arm_register_sysreg_for_feature to allow ARM_CP_NORAW registers to
> be read if there is a readfn available.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20250507165840.401623-1-alex.bennee@linaro.org>
> 
> ---
> vRFC
>    - this is a useful debugging aid but a bit haphazard for
>      up-streaming. See thread comments for details.
> ---
>   target/arm/gdbstub.c |  6 +++++-
>   target/arm/helper.c  | 15 ++++++++++++++-
>   2 files changed, 19 insertions(+), 2 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


