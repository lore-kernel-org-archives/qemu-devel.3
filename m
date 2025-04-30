Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4095C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 08:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA2zl-000184-GZ; Wed, 30 Apr 2025 04:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA2zi-00017a-TO
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:40:43 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA2zh-0005P1-0H
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:40:42 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c546334bdeso599804285a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746002438; x=1746607238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/SRF6WHGAoCHNFDcr9vTE2KjI6+UXLVub7lgAtm4jUg=;
 b=tJ7TLoYG4MSRoJsb0VNMjvbQO8byX8E5ksTwXdCV+vL+Kv7Mln4SsSjF1IsayvI4VQ
 me3OvWMnGl/Ox1DcS1cBv9LP09XcQSrSYJ+xwADLmQsk/ASTI60vseesjkLtXmclXfN0
 B+FiVqFXLZMrCNB1HwvNxIuE+S/B9x4AZkpWOJ1YHygev/2cTDvdcOZFAOrRVvJYg//7
 GsWvgz8cNJBf4IFb6fEychgyuls25c3WzsX7hGiwJ1dl9HGvnIZnVNA0svrB/W26F4wu
 gh3/EfbgHGKuK4qUC1lRVjflySzrWxpPADP0arFXzxBpb4wlr3+E7AV7SWjl+AQUM7q7
 8UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746002438; x=1746607238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/SRF6WHGAoCHNFDcr9vTE2KjI6+UXLVub7lgAtm4jUg=;
 b=YOmud/kA7rgBmRfU/cen5/Obq0TkdfPtqHgDtYGqqlz/icit9sOtrXiKm2Yvf+hIVX
 quoStU5kvKugo+4VkcqZ1YroyigAK4na80iw5kJhfwdumu4sohhy0GhWB2n1SEVf22P2
 FZV1w8tErwikMvP4ALlFRP/DNiWqlunL3h6sFGjy05TE6jD+GGlekVXaKTZee8awjdxY
 f7n0/IJXO0hWUDqbanTQS/snI6N3yr+CExUb6T7vMtA5+H6uwhThTzQNhY3s48ojHBHv
 KhL8lV20wQq54uvDoDrGKrAHyjOI00DPAHUJB4Q4gW8h19tUEjkYKS30QG3i7+aOzqyS
 6z/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpLFK2JOOxGKKMYvNcOj8ymGICRFS9kBNEIynJZvvUjTTHLBtsefCOXiJWcShNybzgXBLwptuBoICj@nongnu.org
X-Gm-Message-State: AOJu0YwEuZNF/KqsgOxuICFpoFN593gh5zbu0xChKCF0xjnvbWGUwGfV
 ftFOy0kEWMGBv989vqqtNbHlJrZlDZ/C67xMDQZootNkCjZ68qwoYVXqu97oMYw=
X-Gm-Gg: ASbGnct56b7MXb7KtUKCFpXVBBRYbbw96N5aj4/o6ltoMumNrJR+QXkkdvCWyhdYtMN
 fXGMVq0v9Qy5tnboIA8fYQ/69fiBMJd3/0fzYd+XhLfcSG0zcNxH7TvSb+/dfxgXiaNTq1ycUPm
 TPsgMS1xItCZatxSF/oW8eoQpIhKyuMFfdW3ghNzmUdHtnuaUV2Ku//VbKFcEQOx1+Ao5WcIpGe
 +0Zcv9K4I2lD8N001YN2O9KSMGDEHCsXeTlkzKinaEv1EoNt331GKQFhtlTgG0rywF/sYQzhrR1
 zYHEeFAa/umicKpDFxwDblhlnAsM0l5hl2d8shL2Seif4oTuY/gODgbXzPMbU7hkb77tegnbE/b
 NrxwoIUtolW7+Ng==
X-Google-Smtp-Source: AGHT+IE9K6X07+ubKSgZCk0tTInrpwKMX5vstIFrBlOhcL180iDSpo5fP7yKzkU87cr6SBcFK4YNKw==
X-Received: by 2002:a05:620a:4483:b0:7c5:6396:f161 with SMTP id
 af79cd13be357-7cac7eb8e57mr228014485a.49.1746002438536; 
 Wed, 30 Apr 2025 01:40:38 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958ea0b9bsm829861985a.91.2025.04.30.01.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 01:40:38 -0700 (PDT)
Message-ID: <c3efa112-5c79-4ead-9a0c-3e27f328cce2@linaro.org>
Date: Wed, 30 Apr 2025 10:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/libqos: Avoid double swapping when using
 modern virtio
To: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250430073343.526867-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250430073343.526867-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x732.google.com
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

On 30/4/25 09:33, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The logic in the qvirtio_read/write function is rather a headache,
> involving byte-swapping when the target is big endian, just to
> maybe involve another byte-swapping  in the qtest_read/write
> function immediately afterwards (on the QEMU side). Let's do it in
> a more obvious way here: For virtio 1.0, we know that the values have
> to be little endian, so let's read/write the bytes in that well known
> order here.

Thanks for looking at this!

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   This also decreases our usage of qtest_big_endian() which might (or
>   might not) get helpful for the universal binary one day...
> 
>   tests/qtest/libqos/virtio.c | 61 ++++++++++++++++++++++++++-----------
>   1 file changed, 44 insertions(+), 17 deletions(-)
> 
> diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
> index 2e7979652fd..078adf3c8dc 100644
> --- a/tests/qtest/libqos/virtio.c
> +++ b/tests/qtest/libqos/virtio.c
> @@ -25,49 +25,76 @@
>    */
>   static uint16_t qvirtio_readw(QVirtioDevice *d, QTestState *qts, uint64_t addr)
>   {
> -    uint16_t val = qtest_readw(qts, addr);
> +    uint8_t buf[2];
>   
> -    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
> -        val = bswap16(val);
> +    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
> +        qtest_memread(qts, addr, buf, sizeof(buf));
> +        return (buf[1] << 8) | buf[0];
> +    } else {
> +        return qtest_readw(qts, addr);
>       }
> -    return val;
>   }

What about using cpu_to_le() API?

-- >8 --
  static uint16_t qvirtio_readw(QVirtioDevice *d, QTestState *qts, 
uint64_t addr)
  {
-    uint16_t val = qtest_readw(qts, addr);
+    uint16_t val;

-    if (d->features & (1ull << VIRTIO_F_VERSION_1) && 
qtest_big_endian(qts)) {
-        val = bswap16(val);
+    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
+        qtest_memread(qts, addr, &val, sizeof(val));
+        cpu_to_le16s(&val);
+    } else {
+        val = qtest_readw(qts, addr);
      }
+
      return val;
  }
---

