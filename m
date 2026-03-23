Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0C8EC01BC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cG3-0005oG-VG; Mon, 23 Mar 2026 06:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4cG2-0005o3-VG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w4cG0-00054I-O1
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774260695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LUWppxkTHznJFkC0P3GY7PBG8qC8+2QSYa1J10e74NU=;
 b=LRjY8YKln+qsEUu43rMXwhrG+vqNNuNFKRbr22h3WzQIPYunr86yZaUfDu8QAW2G0qn0br
 F+Q+eiPUg20569seq5XIvsaj96Vi8Xq7GR3D8NKLVbkgrNiRLw0KtkYM2PR1b4Lf1RJ86a
 /YorD95KWQTJuWWkpkJG9i0YRgFw3ds=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-wJyBLZtzPTqLC_2d1UqzLQ-1; Mon, 23 Mar 2026 06:11:32 -0400
X-MC-Unique: wJyBLZtzPTqLC_2d1UqzLQ-1
X-Mimecast-MFC-AGG-ID: wJyBLZtzPTqLC_2d1UqzLQ_1774260692
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd7de0e161so428070585a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774260692; x=1774865492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LUWppxkTHznJFkC0P3GY7PBG8qC8+2QSYa1J10e74NU=;
 b=a3WRnQi0CM5uzZ0HaIu9vCni5QHY+aGgd7TgAon3GMunOMIsgnqUZZDF4/LZln0ugJ
 LDoHXJb/5t+sij+IE3qVWusQA/tKvXA20Gw2BFs4Lo9RgxUl+AHfRHbFTz/mGG21UsGL
 jUX31IVqKkW6hmXg6QPJK9yVfJ8dpeSgeSyCjPoh2kdpsVZ+tOjWI2Zto8+AcGgbCnBQ
 afy4HfMMLJAtZtDrJ7lDNPWWxJ9zUWtL3r2jdDU9orkqxIaiOMw5cVLiuyUM+7/P99Eu
 8m3irYenepg/wfnxMRzeXScsTyS4dxQCZVwos7VFPTX7w2M4lr7ys9gcY24JcGXHFc+g
 ETQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774260692; x=1774865492;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUWppxkTHznJFkC0P3GY7PBG8qC8+2QSYa1J10e74NU=;
 b=Zka2Q1+CD8z1dl/1t/d6eShLsRMWyRplM2XrOtcIgz/a74qHEnys/tkf5LG7xA+sif
 2s8Hdf80RobhSCFpiLmyIULr+n7rPgUctlBgsMuzku/iIAsuQIqt7ENar6jTpHqglswB
 FhgwkEruEs/0/dJ7Nee1Eq8ZKs1Dcd/VSTVSpYoqWoVEKjjKNNQkivlcpS32M8dtzQk5
 CnvQg7ts/F7T2Mz1HkQ3/bAWAoD4h0VC9ODf95lx9G+toMI76lMothyTJplU0XXaAn0c
 DCfRQm2Sd5J1Y/b2leOS6Sd6GgIbhBAo0BJ9OvITYR5fNdzXRkwcNPrIqo3oJ27NSvJX
 Pfig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGErqgTpBns0unHe0DRYOn8SdVbp9iWaycZxoIsATs0uzmJ6fIMpqNrFIZ1uoXfXRbYdYDyCEAbFwm@nongnu.org
X-Gm-Message-State: AOJu0Yxd78DQu1ah9V6eXlbWdZxv0hlrzZnMWFSSbsObUNBkJQRvelCJ
 r8UoVRYWaM4rexAR+QPkih/GkSFvzYlK/e9psgKDk3MQ+WuWbFuIp79s5SDsqL+UgcStcQ1XoNe
 DAKfrqsb0JYUlNrpfW3NEaVgp1/wX7ORIwjoqCSjwUjJy6TjolRzjnYCU
X-Gm-Gg: ATEYQzwNEvBNATj5kLf0a6ifMqCh2soNhBRD995UN1q6KDORAlqJz/SXH9B05JY1PBk
 wY8DOYTmOZ8Uy4ARIl96MNkHaKBdTm16E2u0VJb6Si/BnNYed+zp4OS2ArY03q0OhTxVcT8FY2K
 2l/qZ1dQ3SV8JXFgHexcAUAN5sUKdhppNfFpqeW95upZz40mBnGMcP8cfxrmoLzYkbKmlefnPfc
 QFKyfMKjMQwXkPWdIuOLwOk31Lc9gWgZ4hLEyx1dEcv7jnn/knOPBi5PZLBWpy1XFFDk73Y4TWx
 UrOFW+15qSEgKa5HeSrMMBJwlFWR9GxrDVunQtey0l7SNkUomzOIScsuuUPx6Hwd9hqknNxTSek
 vfIV86gA93SjeOX+8VA==
X-Received: by 2002:a05:620a:410a:b0:8cf:e1c9:b29a with SMTP id
 af79cd13be357-8cfe1c9b343mr626463685a.20.1774260690817; 
 Mon, 23 Mar 2026 03:11:30 -0700 (PDT)
X-Received: by 2002:a05:620a:410a:b0:8cf:e1c9:b29a with SMTP id
 af79cd13be357-8cfe1c9b343mr626460085a.20.1774260690274; 
 Mon, 23 Mar 2026 03:11:30 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.47]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc9089ca9sm773967885a.24.2026.03.23.03.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 03:11:29 -0700 (PDT)
Message-ID: <81078de3-e6ac-4a11-b087-4f90f9e7a326@redhat.com>
Date: Mon, 23 Mar 2026 11:11:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0] monitor: Correctly display virtual addresses
 while dumping memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20260323095020.66658-1-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260323095020.66658-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/03/2026 10.50, Philippe Mathieu-Daudé wrote:
> While reworking the address format width in commit 6ad593a75a8 we
> introduce a bug, leading to addresses being displayed with too many
> zeroes:
> 
>    $ qemu-system-ppc -monitor stdio -S
>    QEMU 10.2.90 monitor - type 'help' for more information
>    (qemu) x/x 0
>    0000000000000000000000000000000000000000000000000000000000000000: 0x00000000
>    (qemu) x/x 0xfff00000
>    00000000000000000000000000000000000000000000000000000000fff00000: 0x60000000
> 
>    $ qemu-system-ppc64 -monitor stdio -S
>    QEMU 10.2.90 monitor - type 'help' for more information
>    (qemu) x/x 0
>    00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000: 0x00000000
> 
> Correct the format width to restore the previous behavior:
> 
>    $ qemu-system-ppc -monitor stdio -S
>    QEMU 10.2.90 monitor - type 'help' for more information
>    (qemu) x/x 0
>    00000000: 0x00000000
> 
>    $ qemu-system-ppc64 -monitor stdio -S
>    QEMU 10.2.90 monitor - type 'help' for more information
>    (qemu) x/x 0
>    0000000000000000: 0x00000000
> 
> Fixes: 6ad593a75a8 ("monitor/hmp: Use plain uint64_t @addr argument in memory_dump()")
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   monitor/hmp-cmds.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


