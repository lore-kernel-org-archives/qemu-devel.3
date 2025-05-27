Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB695C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 16:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxc7-0003Hc-7V; Tue, 27 May 2025 12:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxc4-0003Bb-73
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:57:16 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uJxbz-0005oh-6Z
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:57:15 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-742c5eb7d1cso3904782b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748365029; x=1748969829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ue6675tkoi0eaA26Eb8BjmjP65lTK6w+Xy47F+qWVtU=;
 b=h5aMr8MPJQmHEHCoBMNrERC+K3NwLXiRx9EWlRQsUKrUdyLeo4L0o/w+qdpHltfkCU
 DNlKXXU4Pk2s0cY+7XbrGa+g7ub+n+KqnazbkRa4WS1MKlE4VBQpalFTOnUlNKLCegdO
 VxPmIh9n5SzLZhrghupXa4OMCNn0UsuuS8whx8lovBYAx9O1N3hlgsqvk80CtybZ314x
 bNYZ/Ku562SGvcy2AeCaWuFNUf7lnBW0hIcvUTaMnvFynxyOZ838Qk6HQBsM5L3rsRPP
 QffJeghVYOQastAKusrV00/GuMiY0cuI4s1nhjUtMlF07SVuNFMR7f8GyCYfB2gT1mYF
 8GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365029; x=1748969829;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ue6675tkoi0eaA26Eb8BjmjP65lTK6w+Xy47F+qWVtU=;
 b=ge+7k6TZ77kjNBct+YM1RmM3bITm0OOGmd894SqLruGTSg7djg9IaX6708QVOAu0fP
 Qnq49Hdrzuz2caNmYHw8AbqFEhz4Dnq9GARapmKRDs9tWXXQJj6Mzkv51xmgu38KpcPy
 EDifMZAdO8NSr2tHjlK9RBTqhgmAv1CHf77m/J/CVFSS/lkgFnMryjEMwnHMK3NPrb+G
 U20juUpxcejuIMAJFowIIvaApd9/d6EDp3azYZozAIFuXVTG0YsRWa3q+lqdA/m45aAH
 C6fntjpP5AIF9Z6uSO9GLYdfUvpzfLnXjyo/tRjmeOEdfUjLRMrdoe3EbLb5Z6SVE8XO
 sLgA==
X-Gm-Message-State: AOJu0YzOwRq85xUlTzNxCvfXHxGm9c+5qRmpXifDxNEyU64XVaPG5WpT
 Pw5QkAoKMZHbjciTf9IBtQ2QV5m73EL4AWOkEhlWxdm6B02AUoOaN6tJ+hEmwThIW+A=
X-Gm-Gg: ASbGncs83A4o0H1VLnW92xTPmcDTNog7kvdYp+Tp5BXOKYs9FtVWZJoSrz+Z2nYxTqS
 V3WDE5yKUMZZBqxQ1J0EhrXgsu+Iv4ubVzEYsIxIi8K6yXn+oRXcMIrpcI54RTWwN6VqX+CKmqz
 eL3OLC8LiQ+fB0T8atvppQBb77EdTMThwkniGkDllmInFIIVXMhhzFhdqaCvU39T6S0PlaErhPx
 Y26UuleWb/y4e3ipeE1pDBhmeJzxKZPvbbsWc+vzMN9kOGl+bQxKmku9PSJQITUVYRDtkt65se/
 OghGupTgfUZ22hO9PFSOxze10skaBklmlSd/72BUSKKG5ffWmhcCVuR+KbQsK1T1
X-Google-Smtp-Source: AGHT+IGZysdTE0ly1pgfNvOv2EV/dzPjGMLyDtwVJjbDO52uIOsM9EGIWjX0W0VAmDoEH+xm1kOKNg==
X-Received: by 2002:a05:6a20:3d26:b0:1f5:769a:a4b2 with SMTP id
 adf61e73a8af0-2188c248bd0mr19003297637.17.1748365028983; 
 Tue, 27 May 2025 09:57:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96e2106sm19518379b3a.17.2025.05.27.09.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 09:57:08 -0700 (PDT)
Message-ID: <dc801dc6-0dac-421b-ba26-54fcb99df390@linaro.org>
Date: Tue, 27 May 2025 09:57:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] qapi: use imperative style in documentation
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, thuth@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@linaro.org
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-14-pierrick.bouvier@linaro.org>
 <87v7pmqpcl.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87v7pmqpcl.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 5/27/25 4:12 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> As requested by Markus:
>>> We prefer imperative mood "Return" over "Returns".
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> There are a few more:
> 
> /home/armbru/work/qemu/qapi/block.json:86:# Returns a list of information about each persistent reservation
> /home/armbru/work/qemu/qapi/control.json:94:# Returns the current version of QEMU.
> /home/armbru/work/qemu/qapi/dump.json:198:# Returns the available formats for dump-guest-memory
> /home/armbru/work/qemu/qapi/machine.json:933:# Returns information for all memory backends.
> /home/armbru/work/qemu/qapi/machine.json:1238:# Returns the hv-balloon driver data contained in the last received
> /home/armbru/work/qemu/qapi/migration.json:2330:# Returns information of migration threads
> /home/armbru/work/qemu/qapi/misc.json:104:# Returns a list of information about each iothread.
> /home/armbru/work/qemu/qapi/ui.json:688:# Returns a list of vnc servers.  The list can be empty.
> /home/armbru/work/qemu/qapi/virtio.json:27:# Returns a list of all realized VirtIODevices
> 
> If you need to respin for some other reason, then it would be nice to
> change these, too.
> 

No idea how I could missed them, sorry.

