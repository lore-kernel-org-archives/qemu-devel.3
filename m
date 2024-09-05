Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39219CD5BCB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 15:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smEIz-0006fH-I7; Thu, 05 Sep 2024 11:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smEIl-0006da-1w
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:21:39 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smEIf-00042i-Tb
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:21:38 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a86e5e9ff05so118040066b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725549690; x=1726154490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ruk8uDCg94aLcQDEDJB4tG2U7xiG8gbzV1EDfl1dHU=;
 b=AnqrqWpc2zDgsD2AA7gCtw7kyxBQa4quotqsjPq04cW4+Hs2gz9kxodYJffS2jJ7H2
 zlFVtrNB/V34joOEFjmHc4kT4wC+lPHd8ZW9VNrqzeb2VO8bZqowTYe/ODu4fjquGKpc
 wAwRu+9lQpvlfUsDw52ofI2D+Xu+IcoYNTKAjhpOE1+gnaNyJeaf61w7l8TLkeI5DfLX
 4+BeFiNxoXxU8sgiE5CqDaCLuuhd7k7R/IKqp12vIaT4MT3JZtStOB9FcK7wz5ouf2iv
 Jy1TEgePHTm2JhVfVBimuMjeyUXEFVOPz3pe2eqZCe8U2Y7A1k7D5m3LMwfKMDedrEWX
 IKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725549690; x=1726154490;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Ruk8uDCg94aLcQDEDJB4tG2U7xiG8gbzV1EDfl1dHU=;
 b=n/rLS1EO6e3O5bYn2oeOJnX5QqI8TTFEGljzkK/S2kB82iKZGomBGS6DZD5j6czTdX
 aeNXli58v0LnTM0g6SRUclEBtBQAcUUvON/166ZU4QxxwPGqQos2HayAkQy6jhzqheJ1
 oFi4ouS0ojNucV3VbPsq/1YD7TAe2MoObwEnDA7qsQFesCeKfGncd7w4qVRDLuj8G0vr
 Rx1VkafPrBKvKPdnrlhTRqqoJmC887lDDpCkYg8iXYjHBLedcjZii68j2VQkHZ2PZ+37
 wJEzR7mnKCS2mJRd5AmlUdViknGV6kJ0VAyRM1DDKbNLS9siUL+HvbZoYwoK7KCHKHoG
 o7zw==
X-Gm-Message-State: AOJu0YxrQGR+j2MxbPOD5EE9uecpPPg5qetCzHB4OgRqwhbacKudIOhh
 3FL+jGETIGe5ha6ZfM6gxV/sfTY0x92m5njEntUx9tDO2tnS5+8y+/6tr5V/Dzc=
X-Google-Smtp-Source: AGHT+IHEbHMK1hamNaMsrnUBE9h4fgOlCYwXce6/PUql3sNFiAaWtAXADMpCgcJgFTLHHeOOzfIXBw==
X-Received: by 2002:a17:907:97d4:b0:a86:aded:b09c with SMTP id
 a640c23a62f3a-a8a32fe141cmr707373166b.60.1725549689703; 
 Thu, 05 Sep 2024 08:21:29 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a80f6d29fsm14482566b.95.2024.09.05.08.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 08:21:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C35E85F8BA;
 Thu,  5 Sep 2024 16:21:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Yanan
 Wang <wangyanan55@huawei.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v7 0/6] plugins: access values during a memory read/write
In-Reply-To: <20240724194708.1843704-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 24 Jul 2024 12:47:02 -0700")
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 05 Sep 2024 16:21:27 +0100
Message-ID: <8734met9c8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This series allows plugins to know which value is read/written during a m=
emory
> access.
>
> For every memory access, we know copy this value before calling mem callb=
acks,
> and those can query it using new API function:
> - qemu_plugin_mem_get_value

Queued to patches 1-5 to plugins/next, thanks.

You can send the re-spun version of 6 once the review comments have been
done.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

