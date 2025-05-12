Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36913C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOpF-0002bJ-KB; Mon, 12 May 2025 04:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEOo8-0002BD-ED
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:46:45 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEOo6-0002Go-NM
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:46:44 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70a2b85aeb7so33189887b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039601; x=1747644401; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N2NVw1vctpw4VdxjsSRvIp8qR1FQioY2MoaReGDEb+E=;
 b=SlILcrJlpky4Fd3J++a0HKZU6Pt+UlMS7x3gqtaJqgwRaoE6pdXB1WRGx6vFp0HfAr
 uBLCAP6TYTQynXGWILA+OATv4KqFCmlFnMcWDXrXpe2hjo7cj0S3W0TnSg/O+pQ7Dj4n
 zelPWu7wkoBwRxVWFGEx1ztlG5ytH/DO2ZXBA2sv1vhe+8jePIRuTPFwhozLThkZi4Q1
 fpi3Jjkcpvm+QUYKlqJuCgUbySmTzsZ9YVE41clhhZFkBln+KUcAMezswvmCOgp0UUd7
 nCFkjtfUPN2iyVxGg0JPrui+2vq5L3G9ZDWPVSmD43hidT65Ov7V9wPWAMVkyYY+gHee
 N2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039601; x=1747644401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2NVw1vctpw4VdxjsSRvIp8qR1FQioY2MoaReGDEb+E=;
 b=J/g+ukY5p4plrVRBVMvIy0nfJMAW2roeIpLZIMmg9yYqWiDgT2yArh5QzlquMLIU5T
 pxVo3gGQhQYhgtg4jBt8FNHzhaEld5SlFPdxQItlK8gfAhprLQz8AyNHWlAK8E7kteYF
 vw+cJE5fr4I+PyH/ukNzPSey6Cc2wmsHigm/Aff0jQeSbAgDKgT6ZscXY8GjrYb0hw6n
 nWKOx41/MLQ6Pci4rL07Wu7em6fm/oEpU2bz4++9n4yO/JYcesMUBll9bYh1hrFXjhM0
 QF2xxdmn6fCgwQvxKORbU4sUpjtKvmym3Q4RYyOw6GW1VQp3ikeqkF2JQGMCE6amMp8D
 1F+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc5UOPzyAsF59u8uJRz27AggWtkPyxUp31DXIJR2qOENi79SRNkf8qwXG7CULF2/WlFvvWBEbDNf0d@nongnu.org
X-Gm-Message-State: AOJu0Yy7OwnyuGUt+fC5i9QU7fzKpAeyRU8/VomCVoxBdWyBok1Rtf+Q
 AjJYbJoOZnJDVU2fObP9vm4X8wXB7epHn9pShJ7pwDxoREL2FooA5x/stAX82ZgIn+iwK5yTZic
 yPa80w5p6ZG0bGeLUf3bcS5CYy3kaCSNrr4ke0Q==
X-Gm-Gg: ASbGncvhbORyaDvGpLQFzlxDoNGMo2S+FMZtK1jBaz6JYoWva6uZj+IaT+rdMdeAZ3r
 6ItbhqphNyglb/SlTBFdU/sfVP13Rg4IikFIDy1uJbn9DWq7r8IIc9sUSWex8GvrnysuUKxXYe+
 d3o1j3TmW4EsFu0SFtjBR8Bl6Ux68aGFVTDg==
X-Google-Smtp-Source: AGHT+IFm02z/RgZm6/IfSP9b2A9XxMjlo0wxyKw7bnZQK6m8s/qL+dHccy2NAQdA8QpgNSb5VC5Y3JZobjE8cEMedto=
X-Received: by 2002:a05:690c:610a:b0:702:5689:356e with SMTP id
 00721157ae682-70a3fa255f7mr147088147b3.12.1747039601406; Mon, 12 May 2025
 01:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com> <aB2vjuT07EuO6JSQ@intel.com>
 <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
In-Reply-To: <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 09:46:30 +0100
X-Gm-Features: AX0GCFubIQGwUvsBeO1JqHfag2JXE624Dj7DHFCn6wFHtrkPbrfp4Ge8KnLAUwc
Message-ID: <CAFEAcA-kuHvxjuV_cMh-Px3C-k2Gd51jFqhwndO52vm++M_jAA@mail.gmail.com>
Subject: Re: How to mark internal properties (was: Re: [PATCH v4 12/27]
 target/i386/cpu: Remove CPUX86State::enable_cpuid_0xb field)
To: Thomas Huth <thuth@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 9 May 2025 at 11:04, Thomas Huth <thuth@redhat.com> wrote:
> Thanks for your clarifications, Zhao! But I think this shows again the
> problem that we have hit a couple of times in the past already: Properties
> are currently used for both, config knobs for the users and internal
> switches for configuration of the machine. We lack a proper way to say "this
> property is usable for the user" and "this property is meant for internal
> configuration only".
>
> I wonder whether we could maybe come up with a naming scheme to better
> distinguish the two sets, e.g. by using a prefix similar to the "x-" prefix
> for experimental properties? We could e.g. say that all properties starting
> with a "q-" are meant for QEMU-internal configuration only or something
> similar (and maybe even hide those from the default help output when running
> "-device xyz,help" ?)? Anybody any opinions or better ideas on this?

I think a q-prefix is potentially a bit clunky unless we also have
infrastructure to say eg DEFINE_INTERNAL_PROP_BOOL("foo", ...)
and have it auto-add the prefix, and to have the C APIs for
setting properties search for both "foo" and "q-foo" so you
don't have to write qdev_prop_set_bit(dev, "q-foo", ...).

thanks
-- PMM

