Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED29FC27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwbS-0000Ky-J1; Tue, 11 Jun 2024 04:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGwbQ-0000Jc-UZ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:11:36 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGwbO-0000jk-Ju
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:11:36 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6f3efa1cc7so9039166b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718093492; x=1718698292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y/yoAPhRFn5Q4H5cB6u2ksY/tjHnfadLZGlFsNwg3g0=;
 b=uoq9Wx/Jd+macSgx5/CKWjSP38SySGf/7b8SvEwVz2wTHdhMMSVbwhGaz9U3qbIPmR
 vWnskw8JIAK9VAlcHArp8+gYc29gRooO7E6CDaQQrvKZIwkNNqWTOusbcP4szmdve/N/
 IU24AfYS+DFU956QiDTRO6a/Sdq5SPxrRj7yPvykuTR2DTddEasbjZy7h/89QfiygjJ3
 3A4h1j0X5UDR1OLr0HBW7zKlLgsw1myMVtyNQrevv8BAwPewwlvwJVBPpe1iZttrn4S+
 58yAt4hrq4PU5Xo2CtAQLmgmDJ272inKtnBMNVBrDIDctcU+zXzl2Jd1FZ7yPhzZL1Bn
 egyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718093492; x=1718698292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y/yoAPhRFn5Q4H5cB6u2ksY/tjHnfadLZGlFsNwg3g0=;
 b=IVbROkOIKsPV76UXcMfJT4ff1Fy56t+4nK1pjdmpnqSx36+vrDBKEnmHWQjPG+n2Na
 XuajmF5hl7ErSlLEOR4/MRps1K4A+xqyMBaqr8s3zcPRJq8fF37j0+4TZzHOjWUeOSrE
 tWp33JbYXSd75PcRXg4jnGPpPibeMjVJvU4uXd8qK3wikFu508yP7mmwd/G9CljoOhXr
 ITe73LOwxGplqLTfEWbPqWApqPaylnEj1ykhI6CtjnFnGeDzk8dsGwDHD/G11IBu3V3g
 LMbJWdz98RNy/G4v3PVKyTuKxXfVy5+bEJ2az6Stbms91UtpTsiLk0XxtbF/m40F2DRF
 6A0g==
X-Gm-Message-State: AOJu0YxzCbrvZ+JfPIlHITVd8xBQkDhOE5T1o9rSKiFBLrwmmh3NeJh7
 m9SQXF9eaq2IfvsacA3UkYSxFOoC7s5KTRuhlj+yPzeiRbz2qYWz/WZaWmQkPpY=
X-Google-Smtp-Source: AGHT+IEhvm6xffFVNXZ72dAsLCQh3yYMhvC57xKpwInRUMWut8t131SOZAKEGE4SCUx4bPhf6mTliA==
X-Received: by 2002:a17:906:d8a7:b0:a6e:c5b0:b648 with SMTP id
 a640c23a62f3a-a6f34d2782amr146579166b.25.1718093492597; 
 Tue, 11 Jun 2024 01:11:32 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6efcf350e0sm456677466b.156.2024.06.11.01.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 01:11:32 -0700 (PDT)
Message-ID: <171e17ad-3bb0-4c1d-ab06-9c30fa7c245b@linaro.org>
Date: Tue, 11 Jun 2024 10:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <CAJSP0QU2Y_mNtYQtPbahnvj1eLLTu2Z-f4z-6VZgSSxqgVnPbQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QU2Y_mNtYQtPbahnvj1eLLTu2Z-f4z-6VZgSSxqgVnPbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 10/6/24 21:59, Stefan Hajnoczi wrote:
> On Mon, 10 Jun 2024 at 14:23, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:


>> Should QEMU provide wrapping Rust APIs over QEMU internals?
>> -----------------------------------------------------------
>> [qemuprovidewrappingrustapis] Back to [TOC]
>>
>> My personal opinion is no, with the reasoning being that QEMU internals
>> are not documented or stable. However I do not see why creating stable
>> opt-in interfaces is bad. It just needs someone to volunteer to maintain
>> it and ensure there are no breakages through versions.
> 
> Rust code will need to interface with QEMU's C APIs, so Rust wrappers
> seem unavoidable. Using a protocol like vhost-user might be possible
> in some cases. It separates the two codebases so they can both be
> native and without bindings, but that won't work for all parts of the
> QEMU source tree.
> 
> Stable APIs aren't necessary if most developers in the QEMU community
> are willing to work in both languages. They can adjust both C and Rust
> code when making changes to APIs. I find this preferable to having
> Rust maintainers whose job is to keep wrappers up-to-date. Those Rust
> maintainers would probably burn out. This seems like a question of
> which approach the developer community is comfortable with.

Both APIs must be updated in sync in order to pass CI, so having
the same developer updating both languages seems a requisite.

