Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA022CA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 16:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuZGl-0000yQ-OQ; Fri, 05 Sep 2025 12:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuZGa-0000ve-Bi
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 12:26:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuZGV-0004F5-Da
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 12:26:23 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3d44d734cabso1634301f8f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757089570; x=1757694370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/aJT5kj/X0VjoycfEh/4yw8Kx/fcFYJpYop+XmItbMQ=;
 b=KPyPyRGol51tC3lGsiJ8kUg7jxHtVcwXv+3wmUbHN2F+rk9n7QAdCE6cdQ+2h5HY6j
 e4rQ14FIYlLcb7/2Qx/8R8LizFJP/lsjQIfXvCreQZhQblsoZqc25PUy2JO2v3mtzn1P
 9gzIT29WJY5423907Gmk38vmqE7ayWbE74Mkso74w5pO5ZUwTPw5HQUji26pnsPxA/uf
 MQn2XL9A6dnt7OXSFSpwnC2mZZ4HR57M0LEHLp3OeipWu7QHMosXAoXGqddGH0xX+e6K
 3aLlJa9QE29mq7LHRseSamQWtj65UduGuiasVshq5vnRTfUUso7kXGZJNEaUWSBOMIM8
 0qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757089570; x=1757694370;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/aJT5kj/X0VjoycfEh/4yw8Kx/fcFYJpYop+XmItbMQ=;
 b=H2rB2xOcbT6Bc84TerNvrlyenwHAYkaA4vYopyxBPPII1FvUNDtVCWD/4FCgi2liyC
 aXrIJawXqtqQVX7JOSniWF/5fj/8XvJVjYTyD1NJU+iZqP8G6msIwWHuY5ur+5HkyJYt
 yha+UlZmKL7rSWpqjitAAsK9P0WkXAkk2NSnVCb1tNTr8NwN6owP1rGHfBMAJ6aBBqwl
 gG0jepUg0dVTBaPBTFPvssTVrpENlRXwufK0geWOUmFWeEZWFxRoF5gsA6JiJD3tYcMA
 Z5mq+arMgALelZqr4G26aRXPAcTsQeyu1AyEMN9vFAJMy69pyOfilsleI3JckD4m/KQu
 JDdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlLWvhxHgJnxifLR218jjdVyS6gcVae6V/5g3O/+2c8OeH5A6H+ixzKTpOcZCmNV62ACso3sYbadtU@nongnu.org
X-Gm-Message-State: AOJu0YyGdiS5Qr5BrgIECn1M8xlU/ONIJcMUwXx/8TxHdOEF6EkBcnMF
 /LzB7e3jHvUdSMpPph6klvxAqWPW0/6R0F0mYhWUiM4pcg2O+DNDeyu10gURv167V/s=
X-Gm-Gg: ASbGncsV6rbUgFTT6uJaUxXoTgPcxubktFHFExNM9lkyaplNaLmESax9GuIvBs6DNsU
 GSkgNxCAUF2sa4EV22IN7DVLHORFrhuf2CwTUE3s0WvKahS2q6uI67uPnN5X217+QeVzF8wBlPB
 kw50L0vhpygqMKdiSZHQaLL/uUMuaCbIlGu8o36I8u+eb9eO7p/kTahl9ZOdoNn0dgNHIxbcoMm
 J0e8kG2w141HKO35PD0gzpRc5yqsvLzsMYfzjXjA7CjtM8AZX07FOIfKd5QK7+6z9/WO2oGtGNc
 0MavPTywSe7wQoQyoUr9/SqNO/7TGqFDBzGFE8eUdc2b8aeg6ucY/FRwNSliruzFyVImgsvZAg2
 iQMolbZ3rx2956tGfmMPm9Wcbchrvwa1ZpPVWMuCndEmOopkLyxg+Aew7JYfD5yoWRrn+8Xo=
X-Google-Smtp-Source: AGHT+IEaDWT8LFy1uZ6AfEJ9cUV8EgDcQuPC2laByBaei24aAc6READpWPi5hMo0ELTxzQOvfAjagw==
X-Received: by 2002:a05:6000:26c4:b0:3d0:e908:a10b with SMTP id
 ffacd0b85a97d-3d1e0a98afdmr19162969f8f.56.1757089570536; 
 Fri, 05 Sep 2025 09:26:10 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d690f2ebb9sm22264342f8f.20.2025.09.05.09.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 09:26:09 -0700 (PDT)
Message-ID: <6be94329-73c5-425a-a890-1199ddcfe1f4@linaro.org>
Date: Fri, 5 Sep 2025 18:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add missing includes
To: Peter Foley <pefoley@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, nabihestefan@google.com
References: <20250904-includes-v1-1-a04a0ea14fd1@google.com>
 <687f76dc-769d-4e8d-9281-5e5f10361bfe@redhat.com>
 <80ba3dae-0bb9-4a45-b1f9-5b80f4fdc47b@linaro.org>
 <CAAAKUPPbiQnCzkmnL0Luww1qeFQxVojzfkgJPrGgphXpkrXMGQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAAAKUPPbiQnCzkmnL0Luww1qeFQxVojzfkgJPrGgphXpkrXMGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

On 9/5/25 18:00, Peter Foley wrote:
> We're using glibc 2.27.

That's just too old.

commit c42e77a90d9244c8caf76fe0e54f84200430a4e1
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Tue Aug 8 09:44:18 2023 -0700

     qemu/osdep: Remove fallback for MAP_FIXED_NOREPLACE

     In order for our emulation of MAP_FIXED_NOREPLACE to succeed within
     linux-user target_mmap, we require a non-zero value.  This does not
     require host kernel support, merely the bit being defined.

     MAP_FIXED_NOREPLACE was added with glibc 2.28.  From repology.org:

                       Fedora 36: 2.35
               CentOS 8 (RHEL-8): 2.28
                       Debian 11: 2.31
              OpenSUSE Leap 15.4: 2.31
                Ubuntu LTS 20.04: 2.31

     Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
     Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
     Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
     Message-Id: <20230808164418.69989-1-richard.henderson@linaro.org>


r~


