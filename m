Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CF2C83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 06:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW7kW-0007Xe-2i; Mon, 30 Jun 2025 02:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uW7kU-0007WO-Ca
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 02:12:14 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uW7kR-0002v5-KW
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 02:12:14 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so1427977f8f.2
 for <qemu-devel@nongnu.org>; Sun, 29 Jun 2025 23:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751263929; x=1751868729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WunxR0k+nmp3qdd6gRV7DzcKlEagnW+dxdSX1BM/0gU=;
 b=GMUL9DRaIzlzVNDelGGFK1LiBOuH9Rm/8W0b89sq5WROBRSOklowIj75SCEcooaJB3
 5xqbMO6v3sS9uT6ySp0DGtSRfRpfNp4Jh9U7w9O7mk2NsqXmxBWos+sUMAqnKuRcSKVA
 TQJmVvSChDMf5EseKzxnOVeEVb2NS0tHNHtfkcbPOyfPtAKQCaicJykgMRxZC6adh6Tz
 oxh9Wclo0Di6XMqK14y7ce8jydVtaokkIl+wbCVTZzqztbNrRMi6QV0ZWQJp+QxraEoB
 PwM8/VJnmvF7wBVxoLT/LbwC1VitrvhD97Bb8zvGd190qY5FM63JTFzOyMxI3WWEwDzc
 IBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751263929; x=1751868729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WunxR0k+nmp3qdd6gRV7DzcKlEagnW+dxdSX1BM/0gU=;
 b=cIer+3YAWXyy4lTYm4+9gUn2QrRf8I1fd8YWh2CUUaIRhPDnJCBxZ8BZ2n/Ip8k63C
 HRnKE5UCdsp8XSOhHQwRMYHnwxEgdbBPnmOrTmd4yWdCPFqcpy0bd+EKx+CHJtALwY8O
 z3h6zQs2+YuGVVYYqD6/KjjPCqE3B5GnRwBFApsua1lZN/G1ZT1Qug22wPg94o+Mw52s
 AWQ79OofhVvY0+Grl8Io1rH1gXLCQ40giOMIZZ6dGo/8YnWvkj69C+chegGd7K2j7Dkq
 l4PqjriX1i7BVyzi79LeywqbkvNNKrj45PxkewtM5UWkZkWM5VgEIIqGV8JO5EjGcgwd
 YwOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVln+KQSnEWdo7hjFuOuwBS3EEnBOC/Fvf+YuPkvdsQQz6Wc6mvMnHOhULCdCecqWICp3HZzKLvKnxO@nongnu.org
X-Gm-Message-State: AOJu0YyaMLkmWBsCurd//d/qM/UkxYVHJ5ClwBf8K7+xeXPY4VTqFEoP
 CaCh2e5Py7QPJoPfR7z2OoiLFuCEOavcrnZM0zbSepzDo/D3rc21Ab0zSb2PyY1ryvU=
X-Gm-Gg: ASbGnctK2DwQlCQH2/hJwR1kC66bIXwtA+x68pCSx4omGX6CSoRxebqfitmOjP9Z+hu
 gl8QtvNoeM6zO+lVjARn9xtrOCvvVDoNWgnrfnfypL/KMZWpbDLZf48TJK7ueqnOl1MazSieAxH
 9sgFYZ8HVRbEJW6Z6sF+mrwhdfSEGr2e4GXcPI3peq6QiQuencoFfZ3TO70hc/mU5OBs4uaWl3V
 6T15839g9TMlXgFIdSO9x9XAniSQiVk+mnj2YJDP7gtz+DcWIh9EeqK6Y/Iyi1waS1W9zTDX63/
 9a9zOGq3K6vCFjoDMj6u/Hp1h/OPTamXlHIzoo8rO04wE7e2gKQxDRdRA8LRHKPS4YJ26MjzEx4
 bFbL7hvRP4cOe1CA8HTUD2IkTwYQaeQ==
X-Google-Smtp-Source: AGHT+IHdwlVYc3MN1G9DYUrSMe7EHVx6HFhKzlk0nOPKRkraWic6oCUm2fbM3LvnrEgW+8hrfUragA==
X-Received: by 2002:adf:e181:0:b0:3a4:f038:af76 with SMTP id
 ffacd0b85a97d-3a8feb844cemr9309903f8f.53.1751263929308; 
 Sun, 29 Jun 2025 23:12:09 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e59736sm9399485f8f.74.2025.06.29.23.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Jun 2025 23:12:08 -0700 (PDT)
Message-ID: <d02f590f-5085-453e-91cc-beccf936d0b7@linaro.org>
Date: Mon, 30 Jun 2025 08:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
 <20250627112512.1880708-14-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250627112512.1880708-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 27/6/25 13:25, Alex Bennée wrote:
> Seeing as I've taken a few patches to here now I might as well put
> myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
> it is not my core focus. If someone with more GPU experience comes
> forward we can always update again.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20250603110204.838117-8-alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


