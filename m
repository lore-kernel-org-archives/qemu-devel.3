Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA5FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH27D-00036K-Ac; Mon, 19 May 2025 11:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uH27A-00030H-PB
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:09:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uH277-00036c-O4
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:09:16 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so3637297b3a.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747667352; x=1748272152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BuDJ1B7F+vOPtHbiq4VidDY0vfvEheIBG0gEkqf4zHo=;
 b=ELbv4XMnHGwsoUxH0Cp4r14vX51OW+8chwfH9U4fFjhWB12uerguGDsTxXqIaVaqN9
 tvV9Z63k0N+WdEqVs6JzFEG4O3w0QwJPZEF9GDSd0Gb/0ngHkBSH6VdzQBnzKbsO3I0C
 eTrQUWKQShGLbk4++mYXbB/V17C+FG+pt+h1HjZ8AR+/3EMmFV7w815PZNhdWOOGqXPn
 YI83AdCIetB1xPG/ljeK+bYABYgA/8LXTLzqPcdifHWbzbrus4vWsja5FEKfulbO/kDr
 cVk8NvR4xig4RpLrO1BAv5hnb9Lm4JmANDu4OEfcpDUKBJfiHr5ffIEvTc/M80Q0K+//
 7OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747667352; x=1748272152;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuDJ1B7F+vOPtHbiq4VidDY0vfvEheIBG0gEkqf4zHo=;
 b=Epue4bqNEIE06DmYUqAEEyy4tg2fHIYYATOBXkERYnnQshm9F5fgeVbxo0JnKEJCtN
 3PeN4OsYfSSs6HYYG7+FV70BfmPSlKqYuNUuelgSU9vVHIebZlPMPwcB4QsFVbQCB2bn
 Q84CVO9gGMeSgvFXTi7KkF0JqWPKLegG+sd6xM7gQ/q8oaIGfCvP+sPmbCP+ZjWBsDap
 ojTqc/d0ZIGHhom6lTQ+zfAd+0xoU9B39w+173yeJLYgfJNSY4HiajkGgQKnxM2Q8zdk
 8/wMA2EMjhvjGpg+1nyw9mMqVyM298SXAPPzaV7AaYVFCSak4YXQ2C7WxGoz5OM+HLei
 tuMw==
X-Gm-Message-State: AOJu0YwdVQcWXVisrkHRKpMGzCAXPGZRS6V8hWI8ki0v14yNJbkwrHfB
 edZXPIaFb88AZ4Ft1jQ7vWEi1imwRiqPKh9gnZNz/leRkajmSsu0hGc=
X-Gm-Gg: ASbGncuRrpbz2stAz1vbSMiStG5zz3CVT5/sdlBzylbjBDITLBBYbWNOA+vw6VXEoOy
 EcdkiAl0gVXreGNvkQXVBDLYLaVKR3DfJ8y/+FJgFy4zhT3U+l7CBgH2o+7YelJEV3PEzzZwPfV
 zxjnOJBFsqYOFescvXtPm0rKWcIriw5iA0KhvDkrL4i0MzyCFxTH3fKS65IOZY2UcWwAg8K67xQ
 8ilR+FnUxLvwa04spwtxhWLLgqYmDmF1rhGVKrKSsDUohYjIOXLsBBcTZ+BXJUiq4xJD5TW/x4x
 LvBK5x3OsNuo9ZtzFj58j02q39ZC9GcOJIV/OuVIQukBUZ84TuX/WzpOx5Q=
X-Google-Smtp-Source: AGHT+IGkZS25xp7eb6d4TlOjxxVHpT60eB7oYjCXjMXsEwLRZQXidhaoIUF8rzzN1dwoEoeF2aYEHQ==
X-Received: by 2002:a05:6a20:438c:b0:216:3365:d575 with SMTP id
 adf61e73a8af0-2170cc4f88fmr18100270637.16.1747667351872; 
 Mon, 19 May 2025 08:09:11 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a982b862sm6547467b3a.105.2025.05.19.08.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 08:09:11 -0700 (PDT)
Message-ID: <3513c279-33e5-480f-b50a-3abd384f4419@gmail.com>
Date: Mon, 19 May 2025 23:09:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: OpRegion not found fix error typo
To: "edmund.raile" <edmund.raile@protonmail.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "edmund.raile@proton.me" <edmund.raile@proton.me>
References: <MFFbQoTpea_CK5ELq8oJ-a3Q57wo7ywQlrIqDvdIDKhUuCm59VUz2QzvdojO5r_wb_7SHifU0Kym3loj4eASPhdzYpjtiMCTePzyg1zrroo=@protonmail.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
Autocrypt: addr=tomitamoeko@gmail.com; keydata=
 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
In-Reply-To: <MFFbQoTpea_CK5ELq8oJ-a3Q57wo7ywQlrIqDvdIDKhUuCm59VUz2QzvdojO5r_wb_7SHifU0Kym3loj4eASPhdzYpjtiMCTePzyg1zrroo=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x444.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 5/19/25 19:24, edmund.raile wrote:
> Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
> ---
>  hw/vfio/igd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e54a2a2f00..36ceb85212 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -203,7 +203,7 @@ static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
>                      VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
>      if (ret) {
>          error_setg_errno(errp, -ret,
> -                         "Device does not supports IGD OpRegion feature");
> +                         "Device does not support IGD OpRegion feature");
>          return false;
>      }
>  

Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>

Thank you for your contribution!

