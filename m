Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33869D49C65
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 07:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vliv1-0001IK-Ej; Fri, 30 Jan 2026 02:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vliuz-0001Gp-6Z
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:27:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vliuw-0008Ui-Ug
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769758065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CIEnhJ4elPsh6TVbrczi0RhKjJP1KalCLjATSeONf8c=;
 b=CPR0a0dIyI53zOyFAu+eIHQrJww83ppqcUcqqjTGvuZTgAgiO0QqGnyDQjdBCZ/XiZcVsE
 WagljglRAn0y5Clq0pe2T2hGI2h0D/jPEqYoPzU1w+j3qYyDLjVTHAOTCgL0/6dM4E/NFc
 DcRo+wHT/p/qWao8Q68iTMKnOCRz37Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-ZutHmj-GOz2e5QVqJg2Nlw-1; Fri, 30 Jan 2026 02:27:43 -0500
X-MC-Unique: ZutHmj-GOz2e5QVqJg2Nlw-1
X-Mimecast-MFC-AGG-ID: ZutHmj-GOz2e5QVqJg2Nlw_1769758062
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so17877675e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 23:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769758062; x=1770362862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CIEnhJ4elPsh6TVbrczi0RhKjJP1KalCLjATSeONf8c=;
 b=pfHRFv8FTUxr3hKOAi52R1GeVx8ANatxgN5Zs6fv2YarzxrFIBpSz3E9XQDAnuvR6S
 8NRR6rqxvINVbZyR36GSYrm52cSfeoNZicsDO+RUiZbs5Mg5sAvfhaWsI9GKfhP/Migc
 QQO0ykUPno7ah4Ca28fTIUc23SNsk/WZLo3d00agSbIlMAyONespZexaoFcS4pFQwugi
 +pY3FTFUNr1xl/jnnvyI/TVde9l8WMc817ETGsOi3exyKvQiBCWJPSsOmoOtaso3yJWO
 Fn5xipv+89tntJmMfjbZ4XUFktXpSgOALxhijAQg4KdvEQblUoPIJEMY/AwOFNdCF3Ck
 GOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769758062; x=1770362862;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIEnhJ4elPsh6TVbrczi0RhKjJP1KalCLjATSeONf8c=;
 b=mQqSYve/AwXxl38gwKF5YCVeJO+uCtHGARST6zESv0fVJ83umiDsd9F2at2e+Kg9EP
 qX9tPXOqF0ZHjDzpHHJisP74LITUVeZpvoUEQyxFoOfaEOydbwqr7eY0dL2IsRXAXsE7
 0/O+cSERWkwTC7P78BusUco2XB81Ng7W1CIXZSpPYBFm8/9cfk6GCqM+tty3LAitGaD3
 1trL0SuefJNvgbS4FXTA9/BzcpEkRrRlWu4urA22HZ9SUXL32CZ2BgMHog5B16pukMD4
 zBmXNbG1to2LantIl/4w9o3G0eGKMzJjrd2jdyRcBANOsv1STcrxsyX7TIaKqA4OKog3
 Evzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVna+0tp16NSP1wequ5CeBoq5FVnAwNybCYtsLOFzBQYD7FPmCDLbiacrnf8CP504by1kggRx35BWgc@nongnu.org
X-Gm-Message-State: AOJu0YwkKc8Fv/LxAYJgKMp6IxoD28svaY9ZihwHVdw+i9T/KKzUGD1q
 9Knmq/DpJK5JC+oVS7VE2+sfsO5/lvEMBSoX8c/bLfUER2fAJWXzYKqq5VBT4yx58+JLlWRiiDf
 /5hoJ6k/f88vkTjdK9PyIKWgt69oD9NxcnK2U2HpAIuvO0pwktF7Bcjot
X-Gm-Gg: AZuq6aISJ7Je7NTShe6rzWIIIlNCN6TzvR8Kf6M40wywiQ2nEZavTmu5J7ey9gX4wp2
 P2iyaO3XvnDW9H3A6xG8z39Rz/VPogTTTTpz2Koi24zNijlybrGi+4dFMY0l8dT/BrkCoBr8xrs
 fa9XnwezPJUuF4pR9fwQp4cxnO5yuMT39vRTdEFmIAnP7PcnaZK7aTU2UR5+4KuGiU0v3IGCxJf
 CM36W4XGg3DarCh2R89NxMpkWrmNIQ3WvCGtUyCuqyRVRogfRyMJpZ2ULbrf/TwklgAGAvn97lg
 O1NyZzYYeUqO4CjuFbxyDFpR/1+CLI7oDXf6SpDUO1Jb3kaEApwMHz0XSsndBLrBlvVLDTLuXef
 ig610PYI=
X-Received: by 2002:a05:600c:4ec7:b0:47b:da85:b9ef with SMTP id
 5b1f17b1804b1-482db463c13mr20769795e9.16.1769758062129; 
 Thu, 29 Jan 2026 23:27:42 -0800 (PST)
X-Received: by 2002:a05:600c:4ec7:b0:47b:da85:b9ef with SMTP id
 5b1f17b1804b1-482db463c13mr20769565e9.16.1769758061774; 
 Thu, 29 Jan 2026 23:27:41 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e047e644sm8261545e9.2.2026.01.29.23.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 23:27:41 -0800 (PST)
Message-ID: <3701a9f4-dc26-4f00-9aa7-7c5f6dc73f57@redhat.com>
Date: Fri, 30 Jan 2026 08:27:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] target/s390x: Dump Floating-Point-Control Register
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260129190902.196262-1-iii@linux.ibm.com>
 <20260129190902.196262-2-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260129190902.196262-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/01/2026 19.57, Ilya Leoshkevich wrote:
> Knowing the value of this register is very useful for debugging
> floating-point code.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/cpu-dump.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/s390x/cpu-dump.c b/target/s390x/cpu-dump.c
> index 869d3a4ad54..5b852928031 100644
> --- a/target/s390x/cpu-dump.c
> +++ b/target/s390x/cpu-dump.c
> @@ -63,6 +63,7 @@ void s390_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>                                (i % 4) == 3 ? '\n' : ' ');
>               }
>           }
> +        qemu_fprintf(f, "FPC=%08" PRIx32 "\n", env->fpc);
>       }

Reviewed-by: Thomas Huth <thuth@redhat.com>


