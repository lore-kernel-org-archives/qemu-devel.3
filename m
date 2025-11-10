Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1363ACCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITEp-0002mR-DK; Mon, 10 Nov 2025 09:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITE7-0002Jc-0w
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:50:41 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITE5-0008TF-20
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:50:38 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477632d45c9so20779345e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762786234; x=1763391034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0CAKD0S0/ErduNCNipeGluQm7ocygcVqrsf6j+qqNgA=;
 b=Mv6Fe412cqTb4C4bdMxBElMvemV8/v6247J3VwFRC3ruZGQWGjz0uFNHMBge/al5mx
 Gu4tfpog6HKYPAb/Atp4/CG7F/ySgCrlfsfTkBMmq8ehLTulX+eo7Y5RHrA0XrLS7ZBc
 zYW+o2T5amOL+W9xobProWKkK0340h3jsoYhISBZ6x7No+W88n1IhO+Ta33TGn1NzGWc
 a55yPTWbJaRXEtx+RgVu6pg0ueGZpgpMLTxjecjlYvXE4vCOrsCGpAxw/YNMByBM/0BN
 UGVqAyKAc7kRW8q21VlYbVbzmivQ7tnHhP/o7gxEXI+8OPwihsdlxiMkBk2ju/CeBpW4
 HTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762786234; x=1763391034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0CAKD0S0/ErduNCNipeGluQm7ocygcVqrsf6j+qqNgA=;
 b=Va+TFS4n7Ra+URSpFzPU3hJAP3+syBUa8lN53MEGI2fMsRUWkloNVYC3sNvSvGhhOg
 uHhk5ksySIjr0OWZLd6hrfZRf0knL1fhQnVlA5b8dgG4Ui8LWqmy2xSHCVlFDMKDjC+l
 d6ADEOu2DNRD/sem+/X72J4Uz0Mh6AsbtyYbBTbL7Kf4Q90u+VdvKvxSaHT8gs6xgats
 /8qhFFjVrrC504E9nEka0kDn+Ar9mfClpu45QvWJgIXOoNgA/HS20jINYUriRChWVhpo
 MrtPayiXO6Zg8UHbURdowruJ1hmtlMEV+56lKr4cpOfR2CmqCpB0g1gd43zYfvRJPQCy
 U8ow==
X-Gm-Message-State: AOJu0Yw5zHBnPW67IEI9FGpW7N7d2zVwikaW1W6xYPr2TDUZ/RxDpaEg
 AuEByOVRnrY2K1u75tPELvOXzmhcfkh/Ib8v6Ad3xWD/vvGOVCrQDVDePN9geTMiKQ8=
X-Gm-Gg: ASbGncsbS+hA2tja9UOLxRCg9sXb3C82o7iyruq0XAbTHUFhuOQaCNeVfHb1SjSQa83
 1jMFQvLUYYyX8hyZ/KrjfPuH17RBTwxIwjJw1v/1IrrqmRVimRJth05N8kfk/c3rbdIzOLfavRC
 /A1wOdIygcqhZI0gAAB1fHrJXMJ0Y+Ywe8Topz9j/J8pXp3CdoqW2Q7YTiCpap/LHArFThDQnmR
 Ly3Y8idMBNXTeA+Rg/SP2QuMJ3p+AIfRN76iWwP1xhQ4gNNxbamevrTL9drxfZq3CJRWHIi3ex7
 8zWUUBpQJNQsXk4TWP/EZK/dCgvcWrxpOxURmrAD6+N9ZgoSgRfe/z/Cg2qV3mERspE344RrGRM
 Tv6oOzDn+F/cGltswK2rOTw34+MMaacaJw+wdJoYsFiC/n/beqognso2TOdLF6MDTT5EV9JBFg2
 sl3I52YjpkHN5R7rgEZMd/26FPhQ+eEuqwWEx1j5YvZVnp4FUgtDfRg2p71GttFbwWTw==
X-Google-Smtp-Source: AGHT+IEraepT+YybrtH94tWHAdlPkXYPXHFi3Jiwq6yifKUt8qZkapS1VyyOT5sb1Z5eYrAKiquFXg==
X-Received: by 2002:a05:600c:46ce:b0:477:7b16:5f80 with SMTP id
 5b1f17b1804b1-4777b166260mr38565975e9.10.1762786233862; 
 Mon, 10 Nov 2025 06:50:33 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac677abeasm22944538f8f.33.2025.11.10.06.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 06:50:33 -0800 (PST)
Message-ID: <0398f3bd-f91c-46ff-9162-2d16db434ede@linaro.org>
Date: Mon, 10 Nov 2025 15:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] acpi/ghes: Bail early on error from
 get_ghes_source_offsets()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-6-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251105114453.2164073-6-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 5/11/25 12:44, Gavin Shan wrote:
> For one particular error (Error), we can't call error_setg() for twice.
> Otherwise, the assert(*errp == NULL) will be triggered unexpectedly in
> error_setv(). In ghes_record_cper_errors(), get_ghes_source_offsets()
> can return a error initialized by error_setg(). Without bailing on
> this error, it can call into the second error_setg() due to the
> unexpected value from the read acknowledgement register.
> 
> Bail early in ghes_record_cper_errors() when error is received from
> get_ghes_source_offsets() to avoid the exception.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/acpi/ghes.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 527b85c8d8..055e5d719a 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -513,6 +513,9 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>       } else {
>           get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
>                                   &cper_addr, &read_ack_register_addr, errp);
> +        if (*errp) {
> +            return;
> +        }

If get_ghes_source_offsets() can fail, then lets have it return a
boolean.

   if (!get_ghes_source_offsets(..., errp)) {
       return;
   }

See commit e3fe3988d78 ("error: Document Error API usage rules").

