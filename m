Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6369CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElyI-0000SD-8m; Fri, 31 Oct 2025 06:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vElxY-00008M-3U
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:02:24 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vElxQ-0001jp-DK
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 06:02:15 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so1242531f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 03:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761904926; x=1762509726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lFXnG+0EOe+4315LYAtHqnIdacQnPT26GCUgFBwsDhk=;
 b=kZnRoeHlyTW7oe3GQCC6MA1zqg08hckTqq3y2muFaU3GpWDmEuL/ZHq43f8hinUbzP
 DbgQRvQJUJO+J71bOb+Gs4E/VgGHTkB9ARhIduzEYA6XxfHV7f1+k+1mtOwNC6pjlUYI
 JZoCGxja67JKa1il/Pv2/AxdxjJlt3y/+lqywpsVgqiUH00wZWmacbXKjrqKA0J3aFeZ
 e/GVLiK/KjuZJZqrFBTapnwoawStuN8n7kJQu9yct0kaSjxzGbBpMdxyRFy9yOhSJjcF
 OeDh227yW+l2VvB7mztQvsVgactNlYFK+LkBohVuYTBjFbRh+iwKqACPpZL0BNuwq3oy
 5ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761904926; x=1762509726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lFXnG+0EOe+4315LYAtHqnIdacQnPT26GCUgFBwsDhk=;
 b=whK6WeoZDTIwKH5wrVv/HIqg+v7o13MfesWS23P4TkIgSjTR37Y5knyU43wdobEd8Q
 ZNLGoSZSVU6+masVjDP6HlRMVno2hgE+Z9i2MCmvk7UYzDpPDGNu0FimKcntD8m605hL
 qqg0g9GdITMnq2anh82yWM8p8Cm/Adia+zvNa5Z8y8pc6nvsPYmKwtvJR99acHqxc81u
 uZPiu4TxlvbBOXFqIfRR+SJUaVSytlNXGpxceXqCIQPdVC7RXRrjWruyHtuQkOaxlNAo
 vaJ55Ro4KMJXlnFfk1Cj548hAfLFXBTN0pTXOvYBVBimGTtlKN5N0HvllvLWuO9wL+3A
 x1og==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1KWcNVuXd9yw4xKjkmBgzRDIHVbmma6XrD/cXVZPCu40w/M3br74wMyl7l2tFQCb1ZUi9cmjZbrIf@nongnu.org
X-Gm-Message-State: AOJu0YybnMJbfpwcQOAlSCVqrO6+O52G03lXptkQVp2wne3tbHzJS03E
 jo7cVshaVNzG0YBipIsWT0y7d2D0sa+rc3oFsGmL/N4Cog6NLbxKLgjQl5qM76QZe4c=
X-Gm-Gg: ASbGncvcD1AFlN106oUd0Yi2A1NH2MEBfSlwCcPP8tsRZvcFKX4QTNsOA+87srNUJ3T
 deJBW/guTm9NV1buP1mEg6V1yo5+B09KhSaWCqBDKT/M2y5UU1WjQJhQYCWHewP2iq94fbAKBih
 t2VhL//M40gJqWYNksNRGVLoM+ih9YfyPgFwmDYRVXeP4iL8UsAvsh1CbMyRw+JiNOe4j3CQn0X
 APAuFBj2KeN4cVyr8cDcyukrlIB0Hzv+Ta9dVtdeYdwoCWtjP2i5ch0b4Tbns2UCC+5z7xQZpPF
 x+RhezsxkmoASouQZ1u8wjOemvR6/xvmiYR+7A8mFoxf/IY/EgPCEf4ZIrQpOxjOef48nac6HqD
 1HPCGTyH4ydiYTpOcL/E2tdU+Hvm2BpPB55KJAqd83+xRZgytz/GOwHTAMTdrq40n+vQ3mwkcXi
 wWRFstey2mIS0SgIOvPMh59D3zUciDlB6y+em33HuWmMLkvnmefMRnUm9SAg3JliIuqA==
X-Google-Smtp-Source: AGHT+IEusH0uKFA2dFxrPNu4WVGpMqpMyiYJw1K/LWbCB31+P04L7s5Nb9HlXW4A1Gbaf5hEqraBmQ==
X-Received: by 2002:a05:6000:186c:b0:3df:c5e3:55fe with SMTP id
 ffacd0b85a97d-429bd69d8fbmr2213843f8f.29.1761904925681; 
 Fri, 31 Oct 2025 03:02:05 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13e0325sm2600047f8f.29.2025.10.31.03.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:02:04 -0700 (PDT)
Message-ID: <185c6a36-a90a-4ca1-9c10-477d819d4028@linaro.org>
Date: Fri, 31 Oct 2025 11:02:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] qapi/audio: Fix description markup of
 AudiodevDBusOptions @nsamples
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, kchamart@redhat.com, mst@redhat.com,
 sgarzare@redhat.com
References: <20251031094751.2817932-1-armbru@redhat.com>
 <20251031094751.2817932-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251031094751.2817932-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 31/10/25 10:47, Markus Armbruster wrote:
> The description of Member @nsamples is indented incorrectly.  Comes
> out like
> 
>      Members:
>              [...]
> 	    nsamples (int, optional) – set the number of samples per read/write calls (default to 480,
> 
>      10ms at 48kHz).
> 
> Fixing the indentation makes it come out like
> 
>      Members:
>              [...]
> 	    nsamples (int, optional) – set the number of samples per read/write calls (default to 480, 10ms at 48kHz).
> 
> Fixes: 19c628f2f579 (dbus: add -audio dbus nsamples option)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/audio.json | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


