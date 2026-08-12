Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F54C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBcS-0005HF-LC; Wed, 12 Aug 2026 12:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuBcR-0005GU-NX
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:15:55 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuBcP-0005fV-RD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:15:55 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so14974385ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786551352; x=1787156152; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sDnI/GYPbfThk6f+WbomkHUrj+g1FexXQDZHrMz9Gds=;
 b=gmPwhuu5DlQe6UTTUbGdsCtjTF+uCTRiS/pIuGgedTmsODdQuW4JddKr3fOdvEZWTw
 jJ0iuzuSKxsJpSdCSwdGd8+TIyaH4pRHhNZYkn+cBA9H5RJlEr/yNhsIdaVHQfW9KtUg
 SmbOqm5sQCKUU0l4xcDkFGO/8khw92WXxuGKduAdcgLxxWpT2qNioH5JbIwleIPBUSls
 uJbVP1yb9M/tX2XADIW8kMWccO/pWLu87CRZUm3pIT6BA5bJLiCTJM+KPuLNzgW9HI6g
 DmGUtWMofA5LXGSiNyYwkGLx6OmAac3vcDCGaf9LsF0aoLb+hj4+eErc6REIMUlMabIq
 X0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786551352; x=1787156152;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sDnI/GYPbfThk6f+WbomkHUrj+g1FexXQDZHrMz9Gds=;
 b=tBfUa+mCJjiNVqhcJr78CB9qquLlpXCRY8L6Q06ULequ/38EHLhLgPO8HFkaBcIBBa
 qFo74NFnd1t1NAtFt7LbOmI2bD52Bt8Hky7D8J2NM4AXv6qD8jkzwOp0CLJwcwJmklIa
 zpcpvW58hjFefKV0K0EhQDg8Ik+ZaCcg7j1zeLkdkrJ6Ap+MGxboKDytLcakknN3Tm2x
 fkTH+LpqkEs3gJw2RB3j5EYY61IL3+Ge78HHCmacNJUvCCB39RmyxMTRPlzEfOdFeq5K
 Up1ofkRyQo3AXSHulhZfV8EqAuOcG4m5UZx9K9jDQhxnroBK47K9gJ2/lGfvw77pi5Oe
 nJmQ==
X-Gm-Message-State: AOJu0YyVcCulq41EChcO9jv59rE8QTeOST/HO+tO45Bxgp5of0UhZ+La
 n3EoCVBx75k5tXqrU6bPp9jLTVKe7B8z1vcR1YfNrp7xmb8gXzF7VZ7MgJMFmSuzrdkp8ho3Mhl
 FF4MF
X-Gm-Gg: AR+sD134DB8ffV+kpYo9fsixM5MyITKpua0KAyl0SCbJPyVNfAkob7Qxre3d7U5/IsC
 rEeDPBDqOaRlNPVWmIZxDnndiBh+4+Ilkv47ThyomA64A7nUf9PLDbehTBC6snKzIedhv1KssHL
 hXjE33usrBA9NxvJpkij7jOJCN6AIQyTQdSX0xqUAHHeCnDWebZVMXcLj5k2whvF7ddIn5IqJ25
 WnxLsMG2ySoOtsYumpKWJMyigGfCcLRAQylzgEHnHm1IHjx1LOiYPkan3Rs4YPgs1NKMckcSDxt
 2Eb1wl2CqIEjEFeQH7hW7r8WGQ8psc0+4WSAy4NdsmzxtcFcu/0nRGrgiFNqKxIltyU7jBcxm3T
 E+D0GPntCQPVAsYSP7GUCZ19kQNmYr4N4sSC0ztXPug97RWrjboP9xCudeAu2XKQ9X0TDVIBMJ1
 ljFDB93LE4qFF02FUDJcEyBhpgzg9Cs2Trwp9qY30WHcmeHBVKYYw58EFnjq9U95h3gkRYRch+S
 duDenckOn9kLmilKNwNlTw1fwAnDA==
X-Received: by 2002:a17:90b:4c84:b0:38e:2e16:859b with SMTP id
 98e67ed59e1d1-393017e569dmr6859193a91.20.1786551351735; 
 Wed, 12 Aug 2026 09:15:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392fe464e68sm1629080a91.4.2026.08.12.09.15.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 09:15:50 -0700 (PDT)
Message-ID: <1adc0202-0881-45d2-ba0b-464b53989369@linaro.org>
Date: Wed, 12 Aug 2026 09:15:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/83] aspeed queue
To: qemu-devel@nongnu.org
References: <20260811162938.1403216-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/11/26 09:28, Cédric Le Goater wrote:
> The following changes since commit 84f07211cc5b4fc6a371559bf8a5de4fb068e648:
> 
>    Update version for v11.1.0 release (2026-08-11 10:04:46 -0400)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20260811
> 
> for you to fetch changes up to 0375f6498eee6188089924bb766c653492ff8857:
> 
>    tests/qtest/aspeed-hace: Test the crypto command on the AST2700 (2026-08-11 18:25:58 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Fixes missing Kconfig dependencies for Aspeed boards
> * Adds 64-bit addressing support to the EHCI USB controller model.
>    Enable it on the AST2700
> * Extends Aspeed SMC qtest coverage with fast-read, DOR and QOR
>    read modes
> * Introduces a separate Aspeed2700SCUState type and shares the SCUIO,
>    FMC and SCU instances across the AST2700 PSP, SSP and TSP
>    coprocessors
> * Adds Data FIFO-based flash access for the AST2700 FMC controller
> * Adds the ADC128D818 12-bit 8-channel ADC sensor device with tests,
>    wired up on the Anacapa board
> * Reworks the PCA9552/PCA9555 GPIO/LED driver: polarity inversion,
>    datasheet-conformant command handling, GPIO QOM properties, reset
>    via the Resettable interface, and extensive qtest coverage
> * Reworks the PCA9554 GPIO driver: output-to-input reflection,
>    PCA9536 support, pin direction property, and qtest coverage
> * Adds PCA9555 IO expanders and temperature sensors to the Catalina
>    board
> * Adds AST2700 I2C master buffer mode support
> * Updates ASPEED functional tests to SDK v11.03 and Zephyr SDK v03.08
> * Adds AES-GCM support to the QEMU crypto cipher layer (gcrypt,
>    nettle, gnutls backends) with unit tests
> * Adds crypto (AES) command emulation to the Aspeed HACE model:
>    direct access, scatter-gather, CTR, GCM modes, 64-bit DMA, with
>    qtest coverage on AST2500, AST2600, AST1030 and AST2700

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

