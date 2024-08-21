Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3306C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 07:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgfi8-0001dl-Q6; Wed, 21 Aug 2024 03:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sgfi7-0001cm-Da
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 03:24:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sgfhs-0003Jm-GB
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 03:24:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-429e29933aaso49133465e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724225075; x=1724829875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jGjcH8Pmwuc7DxR1Lmg/Gb1PDCFtSLxYhj1L8wOnRoY=;
 b=Nr40OPNECGZyIjouREzS5lxhlSlIoV8lh9MGg3kbjfQaG7roW/9F/xshF5lYW6pDPI
 NP8FoRrhed98fxSEyEGtfr9kyBf7D306Vm6fAPXRBw5jMii9PX7wd8icT69GLyfSaCGF
 6IiErmYaC8T/Pmyt5ppE6Zz894n+SliXQ6E9Mil64x0/WCbDKE7+9+TbhmBEwHAi9N2a
 j3BGb8U/N0m2Mhtm4Qx8KwVN0+lxhknp1NG9ICoQTuic1tehbA+E+6QeRApWnUTsy4us
 cnTlc9fF2COJMp9bSizlmhM6/gVRm+kQ58ni1VBGCiFfZzfILd1H+1pdSsnMBDHtVyE5
 hXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724225075; x=1724829875;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jGjcH8Pmwuc7DxR1Lmg/Gb1PDCFtSLxYhj1L8wOnRoY=;
 b=CTb3bHSdgu2+9i4nHgEDfCtesdHLbgSXEsJGY62YnFrha8lPM/0QYEL/qVZuPYC7HP
 zRGuqB3RT1diE/q1sKMMGaBZ42dzmfYicvhIaWWb7KVPTx9W0sgHeMi+PIxFEz+3UTNK
 wEkZEjnT5u2ZiqZNeunCUD7t8I3vDyctrCLEmK29fDJymqlQvnAn0+HpqShBMvSHu3/a
 sPfK8/bBbaff4Ns4rkd6M0RUBIkCuXT7EVI4tKFCNt81KIIZ8y0b8fW8ilr+azG9LckT
 5rofNsypydZIvE85LF9hRuWt+Wj7K4vy+LXAAy4Za1wcgxC9yfA2lMr90Gi96MUmpbC7
 gg6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpf1oS0VPMPF7PEAI5lSitixnqeaalNKiC2Q/+3gNjxv76h5QplK1+/G5vmGDPuy8bDsLmwz7EGVFx@nongnu.org
X-Gm-Message-State: AOJu0YyIZ0waxSN5GSKEdtpdcnAb4Fz+6KM/cGnRMkRo44xtTN6Otl63
 8UuSkz3NCsnS84BvghZAYiVPpNtsKJaqi6S89I0p+XqFosgJueveeWtmBhNDkac=
X-Google-Smtp-Source: AGHT+IEApsZUZvXZmgHBhgCvsPSCVM+K9OZrjqwnH7zX5X1lNf6RAatwQBOuZk44gIYfgz1bRz5oaA==
X-Received: by 2002:a05:6000:2c2:b0:371:9360:c4a8 with SMTP id
 ffacd0b85a97d-372fd57e737mr1019209f8f.6.1724225074517; 
 Wed, 21 Aug 2024 00:24:34 -0700 (PDT)
Received: from meli-email.org (adsl-122.37.6.3.tellas.gr. [37.6.3.122])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898b89bdsm14861983f8f.112.2024.08.21.00.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 00:24:34 -0700 (PDT)
Date: Wed, 21 Aug 2024 10:24:05 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Junjie Mao <junjie.mao@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com,
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 6/7] rust: add crate to expose bindings and interfaces
User-Agent: meli 0.8.7
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
 <20240815-rust-pl011-v7-6-975135e98831@linaro.org>
 <9f6c96fd-bb0c-4014-bba1-70986f4bb384@linaro.org>
 <Zr4ZbOHR9Sc10YSX@redhat.com>
 <6f009629-fbad-4868-bc12-21a18de379b5@linaro.org>
In-Reply-To: <6f009629-fbad-4868-bc12-21a18de379b5@linaro.org>
Message-ID: <ik4kw.0ewrm1y9xy4w@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

On Fri, 16 Aug 2024 11:34, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>On 15/8/24 17:06, Daniel P. Berrangé wrote:
>> On Thu, Aug 15, 2024 at 04:01:17PM +0200, Philippe Mathieu-Daudé wrote:
>>> Hi Manos,
>>>
>>> On 15/8/24 13:42, Manos Pitsidianakis wrote:
>>>> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
>>>> provides some declaration macros for symbols visible to the rest of
>>>> QEMU.
>>>>
>>>> Co-authored-by: Junjie Mao <junjie.mao@intel.com>
>>>> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> Signed-off-by: Junjie Mao <junjie.mao@intel.com>
>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>> ---
>>>>    MAINTAINERS                       |   6 ++
>>>>    rust/meson.build                  |   9 +++
>>>>    rust/qemu-api/.gitignore          |   2 +
>>>>    rust/qemu-api/Cargo.lock          |   7 +++
>>>>    rust/qemu-api/Cargo.toml          |  23 +++++++
>>>>    rust/qemu-api/README.md           |  17 +++++
>>>>    rust/qemu-api/build.rs            |  13 ++++
>>>>    rust/qemu-api/meson.build         |  17 +++++
>>>>    rust/qemu-api/rustfmt.toml        |   1 +
>>>>    rust/qemu-api/src/bindings.rs     |   7 +++
>>>>    rust/qemu-api/src/definitions.rs  | 108 ++++++++++++++++++++++++++++++++
>>>>    rust/qemu-api/src/device_class.rs | 128 ++++++++++++++++++++++++++++++++++++++
>>>>    rust/qemu-api/src/lib.rs          | 100 +++++++++++++++++++++++++++++
>>>>    rust/qemu-api/src/tests.rs        |  48 ++++++++++++++
>>>>    rust/rustfmt.toml                 |   7 +++
>>>>    15 files changed, 493 insertions(+)
>> 
>>>> diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
>>>> new file mode 100644
>>>> index 0000000000..51260cbe42
>>>> --- /dev/null
>>>> +++ b/rust/qemu-api/Cargo.toml
>>>> @@ -0,0 +1,23 @@
>>>> +[package]
>>>> +name = "qemu_api"
>>>> +version = "0.1.0"
>>>> +edition = "2021"
>>>
>>>> +license = "GPL-2.0 OR GPL-3.0-or-later"
>>>
>>> in particular explaining the license choice.
>> 
>> Semantically this is an overly verbose way of saying
>> "GPL-2.0-or-later", so just simplify this.
>
>Indeed. Manos, please use GPL-2.0-or-later to keep it simple.
>
>> 
>>> Should all rust code use it?
>> 
>> GPL-2.0-or-later is what we expect all new QEMU contributions to be
>> licensed as, regardless of language[1], so this looks desirable.
>
>Agreed.

Thanks, will replace it.

Manos

