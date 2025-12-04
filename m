Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B5ED1D899
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4q8-0005cu-6V; Thu, 04 Dec 2025 03:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4q2-0005bV-GK
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:37:22 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4q0-0005wL-AQ
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:37:21 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4779a637712so4344125e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 00:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764837438; x=1765442238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s5lNgTvSaX55b4fwG0OR9WPFzHK7w7xAKUX+HuoFvzg=;
 b=T9u7WT+KPJpaUiL0X6sY9FUnsEX+phQnMPXNNi23mCf2KdLjgkYJ0axuFkm/siiMPe
 yhpeTe/cUWGkAMEbRMMarrPOw+mkIkOj93j+8C11lLeNpA9C9gcJRSIrFmoM1JBO56wU
 Iy2bEc/j+duX+WP7Vvl+JfkFYXy+N/7UHAPdnnDJjiza3/3VIKXFJ/Ao5qK3dp9Xi/Zc
 GqXtKRDv7dmq/7rExFo206bq5GiczKhZsN0HnHYWBYCfrz3McCOhDjIFBKMNmHhAWYAo
 xq/Be2q+RT7yeAZb8+YCE8cYCkSlSbSRPMNxSrYpjGN/EVkg8aoilD0tHbUZLpoevqfd
 dzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837438; x=1765442238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s5lNgTvSaX55b4fwG0OR9WPFzHK7w7xAKUX+HuoFvzg=;
 b=MTavnDqANQoAJmS29BFvVGAJinG8+8yoy7ezMB7mPZuJqbzzdvXOOJKeGJp5ZVkLFc
 UfxLnyFLJYbyfWbfkY+fFcplqfM0knWq5k1L/LiT8ww8BNmySohBvMiPKvv0rEinm99p
 adOqOnARgwN1bhpHNxNeJ4BKMdnEW52AaCzLIomz4MQj2UcWiyRr0+Vqvuivb5K+WDte
 v4yh9C19pqJeX+2hYo989sN9PKTknLpV6G2WRQh67W94Tc+FB+5VXp07EAGEI1M9OFYc
 vsfpxrDNUqsuss4jP/Cw923762K2lf/IznU/oDjGV6CBvuyVTvIIrcroDh8Vc+47aFiw
 qFKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVphToFiFcSzFL6p4MGSlDJqJ4pmOocqhSFC4YHWTFH7AJ1mC/vW5imDsfkrS1pHT7KowpvS+IGWaBi@nongnu.org
X-Gm-Message-State: AOJu0YzekaPyBuVVRfAIP84GjsEe8/lGa8sjYmkAVPPN6gUZC0zdKpVm
 EWVojhFSM340JVien8bq+M4l3+nV1I6T1IuMgxUuN4ghMXE/Xgp7bm4MeW+trpSZUF4=
X-Gm-Gg: ASbGnctpWqPI2v3J2/i+JlnjspOEJlUmqph1JCZMydRXar//ffbeZzHkW3aKpiMS7kQ
 PKXQUBwox4jyJY7FOCHgqVoR9CSSviAlwB6wrVhgh8hYGOAy5XAzMZaRy1Sur0zJqilmwDEeQ/3
 qOncwDugse0hHh3JnmlXNM1o8g6nrROJ98eVvQMnlAC6BJ/q639BR2kEV+Q3nqUutp0TnzHQY6Y
 31WK9LUpl02mO9vMqGpUI3X6OsN2S5MmWtbr73HxL49O6x3OziQps9enG3V4LgrD7UVodT55BJN
 W3iz+xsC+EC30nhKP6U047rjy1stLLgFV2BzbyHxRJjAqLtp1APFmi7yVZrRNg1hPtwtycjv4Kc
 XQlZbGK5wWpS0/l1kMI9MIV84WjYYMjWa5HLxcjVLwY2OJ2WVz0GsotztU3mlH7UoxEWitfwKZt
 gPG18bFTxoIsBZ4KZsyIESEpOpV7emArCT7vD83lEbqUPSO1eWlKm2hQ==
X-Google-Smtp-Source: AGHT+IGbsyJHqOIb6+thOIV+nV3ULRFxpugZ+WugehYp3Il5dKUtnwLirgj8aO1XKniPQ8EzbL0kQA==
X-Received: by 2002:a05:6000:1889:b0:42b:40df:2337 with SMTP id
 ffacd0b85a97d-42f731f6f63mr4880645f8f.50.1764837438038; 
 Thu, 04 Dec 2025 00:37:18 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331af5sm1824833f8f.31.2025.12.04.00.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 00:37:17 -0800 (PST)
Message-ID: <e0b91a24-70e7-4cf4-b2bb-30b9b3401714@linaro.org>
Date: Thu, 4 Dec 2025 09:37:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scripts: fix broken error path in modinfo-collect.py
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20251203220138.159656-1-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203220138.159656-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 3/12/25 23:01, Denis V. Lunev via wrote:
> sys.stderr.print is dropped long ago and should not be used. Official
> replacement is sys.stderr.write
> 
> The problem has been found debugging building on some fancy platform
> derived from Debian.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: John Snow <jsnow@redhat.com>
> CC: Cleber Rosa <crosa@redhat.com>
> ---
>   scripts/modinfo-collect.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/modinfo-collect.py b/scripts/modinfo-collect.py
> index 6ebaea989d..db78b16c1f 100644
> --- a/scripts/modinfo-collect.py
> +++ b/scripts/modinfo-collect.py
> @@ -41,7 +41,7 @@ def main(args):
>       for obj in args:
>           entry = compile_commands.get(obj, None)
>           if not entry:
> -            sys.stderr.print('modinfo: Could not find object file', obj)
> +            sys.stderr.write(f'modinfo: Could not find object file {obj}')

Missing trailing '\n'? Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>               sys.exit(1)
>           src = entry['file']
>           if not src.endswith('.c'):


