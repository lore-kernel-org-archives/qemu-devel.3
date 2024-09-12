Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C96EE6454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodso-0004HW-Fg; Thu, 12 Sep 2024 03:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodsl-000492-O3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:04:47 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodsi-0004Ys-59
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:04:46 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5365c060f47so676236e87.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726124681; x=1726729481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R3800ssKlSFEL/DlCAjvOpVLu3RW/04U/A/En3T/kj4=;
 b=b47GkFxdpB4D5SskEBjj7K2VmjegrDFoIwdHtnDbfVbOlKDJSfoLadjVCnbLR6UBf2
 L46WNqH/2+ZeDSMCiotSrpsx2Kb9cILa2E+jWJjC3EQo3IMYs7dBlM1MkAfyNzyLPhc/
 MgiIcHV6Mre46LN+Mj/rpQwib8mhSkiVaAqq8Vzz2yJWVkE+QEtzoDcYb1r23aXuT5Sy
 xn8Rse1Zlv+NUL9HIlfeB1uA1ZK6j8tUIn4rciaFSYKqQ0Id1qZeo4OJaCLu4A/v8KeW
 x2cj8WQVRmUB4690MpDMu/BUDQWveOjPGXaPC6V5nrlZEP/3b67gXwhU42ApJojL8gpD
 chmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726124681; x=1726729481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3800ssKlSFEL/DlCAjvOpVLu3RW/04U/A/En3T/kj4=;
 b=bzIsJsmrhSkodApPwQlgNQcypw0IPVpgbYE9QTEkWCLl0ZH69wO7gYhPUfTvTEVPDF
 ArpGtQ+Uu5e6k23AGuTp6yawBs3I0ymZ2Mr+cqsxgu0FSC7BduEziI4XLeIx+mW4hhWz
 2fmxpcTPCw4aqjtkqlCwGaB1pQTyK1PBOB5ficI3ZMpQyZb5NPQ1/yRaRCps7qEhh3PE
 PydB9F7/MOtMcQjzKX+x4gEdfyDIwIKB/k0ip+TPbW0pSzcFZsrT2o0csqReHN3dJfGK
 IQKmcOsAiuSjpcP4AtkfjBX0Kyb7Zudxo28vBoGpAefcEfSd5+5iq8/OKQ6W7kKh194K
 VJMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvfrC48rKfmuWwd92nIpJleAF8z5uuxLuMYu4QabOzdhT8od73WFLbXUvmvTukdBZZV09f1Rj8zI+Z@nongnu.org
X-Gm-Message-State: AOJu0Ywwe3Yr9j48yBff7jDyQz6Cykjd0bDRRs1xLPTR9yQv+Kasz9FZ
 OqYqEkZlEeVojVGGbxWtJw5tPJDL6CXDBQYcWGbdHiYdLgwfoAQaWwtMTbYwHe04+Hbd3uB0Dfx
 Q
X-Google-Smtp-Source: AGHT+IF/gsrMrLHWxrgMkJVqXxofdhvOmajcHzSiTigEZ+oKZwWdSOXH54RrTY8LUbrHKjU8MfTIjA==
X-Received: by 2002:a05:6512:2384:b0:533:1cb8:ec6e with SMTP id
 2adb3069b0e04-53678fd1244mr932234e87.33.1726124681269; 
 Thu, 12 Sep 2024 00:04:41 -0700 (PDT)
Received: from [192.168.69.100] (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41cedsm6250807a12.5.2024.09.12.00.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 00:04:40 -0700 (PDT)
Message-ID: <c960cbd9-dc19-4f96-b5f4-cbd3c5c9bcf2@linaro.org>
Date: Thu, 12 Sep 2024 09:04:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ppc/spapr: Change printf format to %HWADDR_PRId for
 MIN_RMA_SLOF
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20240912065207.508808-1-adityag@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240912065207.508808-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

Hi Aditya,

On 12/9/24 08:52, Aditya Gupta wrote:
> Currently starting a pSeries machine, with lesser than 128MiB shows
> below error:
> 
>      qemu-system-ppc64: pSeries SLOF firmware requires >= 80ldMiB guest RMA (Real Mode Area memory)
> 
> Above '80ldMib' is in hex, and it means 0x80 MiB = 128 MiB.
> 
> Change format specifier for this value to use 'HWADDR_PRId', instead of
> 'HWADDR_PRIx' thus showing decimal value instead of hex.
> 
> Thus, change the message to below error:
> 
>      qemu-system-ppc64: pSeries SLOF firmware requires >= 128MiB guest RMA (Real Mode Area memory)
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> 
> ---
> This is an RFC, as it confused me why does QEMU print that error even with '-m' >80 MB.
> 
> This patch can also be considered a personal preference to see it as a decimal value instead of hex.
> 
> Or maybe we can have '0x80 MiB' instead ?

Simply use size_to_str(), see hw/ppc/pnv.c:

     /* allocate RAM */
     if (machine->ram_size < mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
         error_report("Invalid RAM size, should be bigger than %s", sz);
         g_free(sz);
         exit(EXIT_FAILURE);
     }

> Does the 'ldMiB' actually mean that the value is in hexadecimal ? I did not find a reason in git history.
> ---
> ---
>   hw/ppc/spapr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8aa3ce7449be..b2ddacc6dd01 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2819,8 +2819,8 @@ static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
>   
>       if (rma_size < MIN_RMA_SLOF) {
>           error_setg(errp,
> -                   "pSeries SLOF firmware requires >= %" HWADDR_PRIx
> -                   "ldMiB guest RMA (Real Mode Area memory)",
> +                   "pSeries SLOF firmware requires >= %" HWADDR_PRId
> +                   "MiB guest RMA (Real Mode Area memory)",
>                      MIN_RMA_SLOF / MiB);
>           return 0;
>       }

Amusingly MIN_RMA_SLOF is a constant:

#define MIN_RMA_SLOF            (128 * MiB)

Anyhow it could be changed, so better not hard-code the value in the
error message. Your patch becomes:

      if (rma_size < MIN_RMA_SLOF) {
-        error_setg(errp,
-                   "pSeries SLOF firmware requires >= %" HWADDR_PRIx
-                   "ldMiB guest RMA (Real Mode Area memory)",
-                   MIN_RMA_SLOF / MiB);
+        g_autofree char *min_rma_size_str = size_to_str(MIN_RMA_SLOF);
+
+        error_setg(errp, "pSeries SLOF firmware requires >= %s guest"
+                         "RMA (Real Mode Area memory)", min_rma_size_str);
          return 0;
      }

Regards,

Phil.

