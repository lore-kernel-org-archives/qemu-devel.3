Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D41C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1eK3-0003S7-Cl; Wed, 02 Sep 2026 02:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1eK1-0003Pj-Bf
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1eJy-0003vd-VE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 02:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788329982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6biqEbcDa7X3Z98ML6y5if3i6z9ExPKHu+bQwUjcI9Y=;
 b=iENAoAdrSAwgdMMB3CNbJSImaX9d4GodWJF3Q+f8czxs0WgKDJrM/cq9nfo2urytC9i8t1
 yThvfIHEEB0ac8wrZAgU1nyrdVNc3QotIcvenqgs33j0kp8OVDmIlc3Y1kE44YJBdldOh3
 pUq1bWaEWPOOeNsJUCqGZDEYcpXzJ/o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-wWsc8YnGMvqHwXBixnSImg-1; Wed, 02 Sept 2026 02:19:40 -0400
X-MC-Unique: wWsc8YnGMvqHwXBixnSImg-1
X-Mimecast-MFC-AGG-ID: wWsc8YnGMvqHwXBixnSImg_1788329980
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49b7c1dc61eso5206075e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 23:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788329980; x=1788934780; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6biqEbcDa7X3Z98ML6y5if3i6z9ExPKHu+bQwUjcI9Y=;
 b=Hw11f2JUN2EJFQzSPFBq1BZqEX1AOLaPvBedYhaPx2BxvcgWVrMDkEsuNGrmp/Xm58
 wuB4Edfc9T7lL6sxrnV9uyapLTmueb1IrcBt8Y5x6G6fiv9CqybZ7art4K5Jnu7eSGlV
 3MzyqhLu/nVmS2iTq8YJDgj/DrE7lqCRcUxepBiOkpVg2b+z44NgEObpIKjXIuN6fScY
 ukjwDhR8Z4bo8FtZIDPabrey8c7Hj+9YxuTicjD7aRNCBPH1EcAmW95K0D8/qNSEVFL0
 v3rtpE8aoiW4n8dDgo5KoVGjiNxrp5OOzfhML25WzZFitZhwkBaCA3VuZguLL/0CWhsk
 jLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788329980; x=1788934780;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6biqEbcDa7X3Z98ML6y5if3i6z9ExPKHu+bQwUjcI9Y=;
 b=DZxUMBFBpP11/0qwh4jC2i++I3YXVokmb8duoNDuxHeMM2nbDyGBCMLqAe64Q3zTr4
 dRBdznYxIRt6uMiHypALZ8RBHl7umDcXunxIVHcrl133EzFKopC+OqV55YfIxtrZov+x
 aBqSFiYf3qF64YQzOcampZOyyecog0W4JpzXLHlCy/ox0QkIixbUR1Fm4ADjZVbisOsy
 c9PnHMs9LVaJ+H98b/QUvjqswak0Ldimmjgn40YX8GxC1Fm2CwG9QRnIC3KOVcCcKYFO
 amf8caHUfcPP4OBs+9sAH7MR40T9Nf6aeHvsFxWVJGLcC5PEtBBqewgmh9cVautP2bw0
 4FuA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWC/JjNVyD+tezNJpUjXAhkBVPNeCWuPAYx7c+0COI5WVE6dcrGWog7Q3FFwWymm5y4W1HNu0akcrg@nongnu.org
X-Gm-Message-State: AFuF++nXJ4fdhCVP7bKgRWyRs4uPQcAHl/CAZexbAbufxh1Feu7UIf9B
 wIgI45aQFWORyLE5/vXQdsubiWShVBQrhpwC2hGi1N+1wm7ZR3OkQKhbn0g2Y4t7CUKIMF+P8SL
 o219237fRrHPtlw2r0rl6nFHYByTQe/5L849CAQFGmJKX5t56p9A4zuXC
X-Gm-Gg: AR+sD11p1MnCWVP2o3z8ZpsghiX1dKGpAvgOW1UvcReRTFm7nU4vmN2n2RogoVBIOHL
 6i8rrdKxMwLPqnkV0zbp6/uImeLY3CGMHUW5j2E9Tj3DUG9nQtPBF3f58ObtFkKS19GzqMPqxf6
 KLgKKcfVJb39t0uWaYFgJm2YetddpciM9SxeZNDrvW37G2DA2Mq7wKQ6SgJB74YUuL46FR7eK02
 QyM9OkRkfssJSFgkCBaJ/+nxKaIW13sLRC4ZYaoptgJMVWgJuzdHhvaa499lnTrK8XjlEY2wHdx
 sgjXGKjC+gqyxHEFiZwJQ8g3yoB7wTDCqzOZs6uIKq99rS7UbVxD5EvuwhpsoNq1jUzQ6BIR5MD
 091dMMEAWdHjw5FvUdReER7YIP1FhVDGWg5e7O8E=
X-Received: by 2002:a05:600c:3b07:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-49ce5823706mr35591985e9.10.1788329979398; 
 Tue, 01 Sep 2026 23:19:39 -0700 (PDT)
X-Received: by 2002:a05:600c:3b07:b0:496:bffb:fb7b with SMTP id
 5b1f17b1804b1-49ce5823706mr35591165e9.10.1788329978878; 
 Tue, 01 Sep 2026 23:19:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4?
 ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm30928415e9.1.2026.09.01.23.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 23:19:38 -0700 (PDT)
Message-ID: <a3b97fdb-562c-4db1-b754-0dacfea253b8@redhat.com>
Date: Wed, 2 Sep 2026 08:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/25] hw/arm: Facebook SanMiguel BMC and TMP75-family
 sensors
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Emmanuel Blot <eblot@meta.com>, Markus Armbruster <armbru@redhat.com>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/31/26 12:44, Emmanuel Blot wrote:
> This series adds the Facebook SanMiguel BMC, promotes the
> TMP75/TMP175/LM75B sensors from generic TMP105 stand-ins to improved,
> dedicated models, and introduces the test-side plumbing needed to
> exercise real I2C devices from functional tests without hardcoding QOM
> paths.
> 
> The work falls into four parts.
> 
> 1. TMP* sensor models
> 
> The TMP105 model was the only stand-in for a whole family of pin- and
> register-compatible parts, and several boards worked around the gap with
> private TYPE_TMP75 / TYPE_LM75 aliases that resolved back to a plain
> TMP105.
> 
> The model is first cleaned up for correctness and QEMU convention. One
> of those changes touches migrated state, which gains an optional
> subsection so existing streams stay compatible.
> 
> On that base, TMP75/TMP175/LM75B become variants selected by a small
> per-type class descriptor. The variant is class data, so the wire format
> is unchanged and all variants share the existing vmstate. qtest coverage
> is added for the per-variant behaviour. The existing BMC boards then
> drop their local aliases and instantiate the real models.
> 
> 2. SanMiguel BMC
> 
> A new AST2600-based machine for the Facebook SanMiguel BMC, derived from
> its device tree. It wires up three TMP75 sensors, IO expanders, FRU
> EEPROMs, an I2C mux and an RTC across its I2C buses, and provides its
> RAM, flash and networking; the FRU EEPROMs are populated with data read
> from physical hardware. A functional test boots the OpenBMC image and
> drives each sensor over QOM, checking the guest hwmon interface reports
> the injected value back.
> 
> 3. Python device locator
> 
> A QOM path names a device by its position under the object that owns it,
> in enumeration order — it says nothing about where the device sits in
> the bus topology. From a QOM path alone it is impossible to tell where a
> device is actually connected or what purpose it serves.
> 
> DeviceLocator is a pure-Python helper that resolves a device from a
> string descriptor of its position — bus, address, type, on-bus index —
> by walking the bus/device hierarchy. It uses only standard QOM queries
> over QMP: no new QEMU commands, no model changes. A self-check exercises
> the grammar and its error paths against a paused SanMiguel BMC; it needs
> no disk image and runs in about a second.
> 
> Note: the helper adopts the 3.10 type-hint syntax rather than the 3.9
> equivalents; 3.9 reached end of life on 2025-10-31. The import is
> guarded so the module still loads on 3.9 and dependent tests skip there.
> 
> Two small test-framework fixes ride along: the set_machine probe VM now
> gets the per-test workdir instead of the hardcoded /var/tmp default, and
> the Aspeed OpenBMC helper can optionally assert the booted device-tree
> model.
> 
> 4. Catalina follow-ups
> 
> The final three commits are the tail of the earlier "hw/arm: improve
> Aspeed Catalina BMC emulation" series: functional tests for the PCA9555
> and PCA9554 IO expanders, plus the PCA9554 change that drives its input
> pins externally. They were held back because reaching such devices from
> a test needs a stable way to reference them by bus position — the QOM
> re-parenting patch tried then was rejected, and the device locator now
> unblocks them.
> 
> Based on:
> 
>    repo:   https://github.com/legoater/qemu.git
>    branch: aspeed-11.1
>    commit: 04d27371e3 ("hw/arm: catalina: add NIC and FIO temperature sensors")
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
> Changes in v2:
> - Simplify TMP105 multiple variant initialization
> - Improve reliability against malformed device locator strings
> - Remove an obsolete reference to INA23x devices from a commit log message
> - Rebase patch series on aspeed-next branch
> - Fix invalid JSON syntax in SanMiguel FRU descriptions
> - Link to v1: https://lore.kernel.org/qemu-devel/20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr
> 
> To: qemu-devel@nongnu.org
> Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Steven Lee <steven_lee@aspeedtech.com>
> Cc: Jamin Lin <jamin_lin@aspeedtech.com>
> Cc: Kane Chen <kane_chen@aspeedtech.com>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: qemu-arm@nongnu.org
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <th.huth+qemu@posteo.eu>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> 
> ---
> Emmanuel Blot (25):
>        hw/sensor: tmp105: make device state private to the implementation
>        hw/sensor: tmp105: name the parent object field parent_obj
>        hw/sensor: tmp105: implement Resettable reset
>        hw/sensor: tmp105: enforce the configurable fault queue
>        hw/sensor: tmp105: describe the temperature property
>        hw/arm: aspeed: guard board-local temperature-sensor aliases
>        hw/sensor: tmp105: add TMP75, TMP175 and LM75B variants
>        tests/qtest: tmp105: cover the ALERT fault queue
>        tests/qtest: tmp105: cover the TMP75, TMP175 and LM75B variants
>        tests/qtest: tmp105: cover one-shot and fault-queue write immunity
>        tests/qtest: tmp105: cover shutdown clearing the ALERT across variants
>        hw/arm: sanmiguel: add Facebook SanMiguel BMC machine
>        hw/arm: sanmiguel: populate EEPROM data
>        hw/arm: catalina: use the real TMP75 model
>        hw/arm: fuji: use the real TMP75 and LM75B temperature sensors
>        tests/functional: aspeed: optionally check the device tree model on boot
>        tests/functional: give the set_machine probe VM the test workdir
>        tests/functional: add a pure-Python device-locator resolver
>        tests/functional: add a device-locator self-check
>        tests/functional: aspeed: add hwmon sensor read helpers
>        tests/functional/arm: sanmiguel: add BMC boot test
>        tests/functional/arm: catalina: test TMP75
>        tests/functional/arm: catalina: test PCA9555 IO expander via QOM
>        hw/arm: catalina: drive pca9554 io expander input pins externally
>        tests/functional/arm: catalina: test PCA9554 IO expander via QOM
> 
>   hw/arm/aspeed_ast2600_catalina.c              |  14 +-
>   hw/arm/aspeed_ast2600_fuji.c                  |  16 +-
>   hw/arm/aspeed_ast2600_sanmiguel.c             | 405 ++++++++++++++++++
>   hw/arm/meson.build                            |   1 +
>   hw/sensor/tmp105.c                            | 304 ++++++++++---
>   include/hw/sensor/tmp105.h                    |  46 +-
>   tests/functional/arm/meson.build              |   3 +
>   tests/functional/arm/test_aspeed_catalina.py  | 107 ++++-
>   tests/functional/arm/test_aspeed_sanmiguel.py |  72 ++++
>   tests/functional/arm/test_device_locator.py   | 120 ++++++
>   tests/functional/aspeed.py                    |  21 +-
>   tests/functional/qemu_test/locator.py         | 586 ++++++++++++++++++++++++++
>   tests/functional/qemu_test/testcase.py        |   2 +-
>   tests/qtest/tmp105-test.c                     | 359 ++++++++++++++++
>   14 files changed, 1934 insertions(+), 122 deletions(-)
> ---
> base-commit: e5d3f5ac8633de310066f14862b17e4cac8ef8a5
> change-id: 20260729-sanmiguel-bmc-locator-db13cceae66c
> 
> Best regards,
> --
> Emmanuel Blot <emmanuel.blot@free.fr>
> 

Applied 1-16 to

     https://github.com/legoater/qemu aspeed-next


Functional tests need to identify devices in the bus topology and
we lack support for that. Several recent threads have touched this
topic:

   - "[PATCH v5 0/8] hw/sensor: Add new device emulation for TI ADC128D818" [1]
   - "Call to clean up QOM onboard devices lacking a parent" [2]
   - "[PATCH RFC 001/134] qom: Introduce object_new_child()" [3]
   - "[PATCH RFC v2 0/137] qom: Make composition-tree parenting mandatory" [4]
   - "[PATCH v2 0/25] hw/arm: Facebook SanMiguel BMC and TMP75-family sensors" [5]

Not addressed yet. It's still maturing, like all the good stuff.

Thanks,

C.

[1] https://lore.kernel.org/qemu-devel/20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr
[2] https://lore.kernel.org/qemu-devel/87se5scipx.fsf@pond.sub.org
[3] https://lore.kernel.org/qemu-devel/20260711223707.42139-1-graf@amazon.com
[4] https://lore.kernel.org/qemu-devel/20260718213652.37673-1-graf@amazon.com
[5] https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr


