Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A42CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAh8-0007DG-5z; Wed, 13 May 2026 10:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNAgh-0007Ay-KH
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:35:55 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNAgf-00070q-To
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:35:51 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so5084226f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778682947; x=1779287747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GOMN0FkiVj1ZQGTvrgvMIzQ6h95Ilg9hvrAfog3kSRs=;
 b=FQPfhIXlvl+2y8qzSoSEidFq9mAnHQOAm+pachhRm2IVmb0zlNNOq4kezNB5LXURRT
 h8WJ/r/OyA07LPrYLYmgA5O0ih7xFrufpab7km4SnhW0PGXrfv0TCeikbHzMVCgtDkmn
 WNlxlTLmZlitJq+HfFt567h3lVFAFUeXMG6LIleQnP4/AYdwmK2H0GaaYWCg8Pdx2/wq
 0ZvNZ9UWo5lN+yDhEfjqll65tWNu0GjZzLg+dYDmp8nejCCUtZo8LyR2O8aQI+gB4oEY
 wc9iy2IGpc0k0iGn99fnvLErSGyHk6xfp0FKW92tF6TMPQ8VsGwASlp1i/9Ac2qnt0mI
 t2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778682947; x=1779287747;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GOMN0FkiVj1ZQGTvrgvMIzQ6h95Ilg9hvrAfog3kSRs=;
 b=C6lOTW+xcK8oOlrPU5grFn8q67un+f8U+nAXfQgKUhApEHBCrwFjCLrUM446L5GcJo
 4rws4N1/FxqoQiRNrJX0dChzkDiqoA4DYB+hyBIlUkoYeyUOihQHsdReRVTgSKJPU9tU
 z8PVQZMo0qpjQAgs0G3zbb1X6SL3BCWuajf8UIaK6FUJSso8hzD8pAK61x3vme2BaCXy
 77B5KJR4fGlz6qQ3jxGbL+D6Hp3U/qdyxPC8WCUjbqa0gk4JQ+dM5OM2SzapJChoguhG
 P2oWO5dF5y+PVxTsRpWdmyMV1IzyolYcw0oAJCEeqBRZRszhlP1mY3Sipc3SLYq9CzCB
 1/9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+z7jO7H3iHxybxB7g7fn3B5x7yRUmm3lbVY5UduZKmZmyTXJUFnymbmLlKYs2WQD5T8g7Nad6jJg0Z@nongnu.org
X-Gm-Message-State: AOJu0YzWt3Dsv/rDevcvbFWBeBzK6laveg7RVoI5zGCvuqfV4WHhD2vq
 ytjHFuBIknNjmPi0PyPSdiht73DDVS+sYuA5KRocin3SpWG38vZD0AVsZh7V0Sb3SP8=
X-Gm-Gg: Acq92OH8w99v8QZlWe6jjcTcV6DFvLWDRCYId2jzU7rmPIACFqFs/6UzD2A1ogL7e4w
 wDFU88JQgy3Tybv9ANsy55GJ3zlJaAI+D0uw4rijB+HKBXT0ah2KHzWZLSVp0tlgG8yKVLU2zuU
 e97MyfeRBCsOmHmqDStKVaOJJ2OV2oyr21SLT+d09YAhDHPEGsqx7ukUazL124S2mWDkgQeCyA7
 mk1IBNN6cM2PADA+6H9tV9QAeCx2BQcGcSLRxwOohOEvov7A+MSgdVCug53fwmnQrdm0zL8tgrd
 DYPZcTijCXWhKwNtR4jXT6vAE3TSHAUQXRTWpDkmKGQz7WNNVXzHorE26DjkTMqs9mrPXb+BjaZ
 6xvPffdVyroaKe7Snw27v9dtgWxCyM4EdaUeUd969BBHpnNpjlTKjvlZDYVvQtQjrVu7wQAYwEM
 UYONvSHWBBICRDFnNKfaehA+MYvX8pZ1OMFTurcD5EBcmzPjOCFN3MaBp/hWJgkBFJjg==
X-Received: by 2002:adf:f68a:0:b0:45d:2b7e:a20 with SMTP id
 ffacd0b85a97d-45d2b7e15a6mr1707763f8f.14.1778682947458; 
 Wed, 13 May 2026 07:35:47 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548eb75c29sm39818517f8f.9.2026.05.13.07.35.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 07:35:46 -0700 (PDT)
Message-ID: <603ab306-72c9-447c-ad04-4741b94158a8@linaro.org>
Date: Wed, 13 May 2026 16:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] qom: validate ID format when creating objects
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260512122958.788097-1-berrange@redhat.com>
 <20260512122958.788097-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512122958.788097-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 12/5/26 14:29, Daniel P. Berrangé wrote:
> The object_new_with_props/propv methods failed to validate the ID string
> format, thus diverging from user_creatable_add_type.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qom/object.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

