Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE565CA0FE1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 08:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upMj7-0002vH-Ay; Fri, 22 Aug 2025 04:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upMif-0002of-TB
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 04:01:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upMic-0003T2-1v
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 04:01:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45a1b05ac1eso10348585e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 01:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755849707; x=1756454507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R05yerlxpRUddCTUmZ82t6NykLnReLxMV/L9FnHb1C0=;
 b=yHWKbURYXuLqaLNoVg5xADhZ9H1IxVEFE2M98zQpuxqigrdEcgnLAefCB75TQmFYg3
 Dq8/cFjJnc8MfUntKVg9hs+9UeqP4uCDhyQGow3EXGNlUD0xKr32coYg4crhj3ezjsyT
 5gr6KVLygHXFAyyLfzuZ1zFQlEyE7WC4qySDRSxvMu37X1y1uxLa/hdhBA4AuAGu0jNS
 39NLcDvqT6RsRXZLjFFvlLoy8yVAEWYU/jnP/PEejHvey4BtQqMkRcioYf8qQZngVDae
 tAUDVLRyBsZkix4HSAxlunf9BOjLGfz5ktWJBLwGLPUfFjB+4cHWkCesshAl1WJIGDxB
 +tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755849707; x=1756454507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R05yerlxpRUddCTUmZ82t6NykLnReLxMV/L9FnHb1C0=;
 b=Sj+TWrNsvu3mi3QsJCmJtiDPlBtXIOlBNPdtNf6HWHIEmA6pYnseThN7beciAn0P+Q
 EuK3rZ+9UNSEADspAY4sZeLqBlGyJ050WPbTxl62ApXQLuf+g0iYSf3tGVBM3ffg+/TD
 qPoYOsWozUVaC8R1kjGaxh6RfLoXLIpCtCe8ZtZU6yuGFihuGEdKk0tz8AAHjQ2S9xxF
 G1d43CfI2RhZT+DutJ4A3WyFuE2zHrLTEljyUiqWH3QGYQ4tiCPLYBxzdvROjf3Tgy6S
 ZcnMwne3mUVyeBc30NSj0l+pQl772GUg92bj1TxTxI5g6Pg8c/L9tHsDb6DKBo7KwGSS
 vPQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq3BX+8P1YTfGXkbgCFS78O7vkZFDtHTZtC3lY6630eI1EtQFeTS9qwYYdiBH/nrrGtQC+5o/lHgeR@nongnu.org
X-Gm-Message-State: AOJu0Yxr/ZVcvtjv21G+bne3pLQieAv50gfExaPxP4a7fjqc6cMQ7aoG
 SMIJNGK84li36NgJF7wGRj84xNrmiAp+tCnoKoiTR88NgmJIbed6hfIE4O6rHapaFBw=
X-Gm-Gg: ASbGncs2pt6EsYgTF3grcgpQwkE0qUPeRPteyPtLr1tMNV1wyq4J6Wp1Cefj1cCDeAe
 H8QNfLG6J05hJbcxSPYhZB9AZUft7NRUE18ZsFCMV7fnE0Vzt+/UR1PP2xj8eSXaOoNuQip2ZOP
 Rxv/dyCGEpKUIMOm2f38Icxv2bPoc3skBxMpFXFADDIkOKRRBcd+XRStQtVeY0rKqdxSZlv3qGW
 p88nhuuGvHMEuHcg39pUtWPGFmuqUtqhGGHM06YpXe0enC6HRwS4xbatYNkkmUakbYYmW5yv9pF
 EIeh3SkW5UMHT85iaiyHyPW862u31is4ul28Lpb3HpPUrD/ETXnL5fn33eQK17jJbWsDICtlVqv
 K0yXL0swZyWSsMgIzb05ne5Hs7BquM6OwQsdyYPsMsHeZ04Vfx9OW3xDuQqkr6/kjNStetPA=
X-Google-Smtp-Source: AGHT+IEph/mlFxczFLVbGA8bKpxx4SzH+LPmkB1d92UD9PAoz7jMrEL61aCo5QMfu6/qF03cEB+d5Q==
X-Received: by 2002:a05:600c:1d1e:b0:458:ba04:fe6d with SMTP id
 5b1f17b1804b1-45b517a069emr12580185e9.14.1755849706632; 
 Fri, 22 Aug 2025 01:01:46 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c5e024eee4sm1901569f8f.66.2025.08.22.01.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 01:01:45 -0700 (PDT)
Message-ID: <8a3737c5-7e25-4138-8c5a-5f67a6f587e5@linaro.org>
Date: Fri, 22 Aug 2025 10:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/gpio/pca9554: Avoid leak in pca9554_set_pin()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250821154459.2417976-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250821154459.2417976-1-peter.maydell@linaro.org>
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

On 21/8/25 17:44, Peter Maydell wrote:
> In pca9554_set_pin() we have a string property which we parse in
> order to set some non-string fields in the device state.  So we call
> visit_type_str(), passing it the address of the local variable
> state_str.
> 
> visit_type_str() will allocate a new copy of the string; we
> never free this string, so the result is a memory leak, detected
> by ASAN during a "make check" run:
> 
> Direct leak of 5 byte(s) in 1 object(s) allocated from:
>      #0 0x5d605212ede3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (
> BuildId: 3d5373c89317f58bfcd191a33988c7347714be14)
>      #1 0x7f7edea57b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b68282
> 9a6913cf682d75)
>      #2 0x7f7edea6d4d8 in g_strdup (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x784d8) (BuildId: 1eb6131419edb83b2178b68282
> 9a6913cf682d75)
>      #3 0x5d6055289a91 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
>      #4 0x5d6055289a91 in qobject_input_type_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qapi/qo
> bject-input-visitor.c:542:12
>      #5 0x5d605528479c in visit_type_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qapi/qapi-visit
> -core.c:349:10
>      #6 0x5d60528bdd87 in pca9554_set_pin /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/gpio/pca9554.c:179:10
>      #7 0x5d60549bcbbb in object_property_set /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1450:5
>      #8 0x5d60549d2055 in object_property_set_qobject /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/qom-qobject.c:28:10
>      #9 0x5d60549bcdf1 in object_property_set_str /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1458:15
>      #10 0x5d605439d077 in gb200nvl_bmc_i2c_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/aspeed.c:1267:5
>      #11 0x5d60543a3bbc in aspeed_machine_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/aspeed.c:493:9
> 
> 
> Make the state_str g_autofree, so that we will always free
> it, on both error-exit and success codepaths.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/gpio/pca9554.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index de3f883aee9..eac0d23be34 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -174,7 +174,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>       PCA9554State *s = PCA9554(obj);
>       int pin, rc, val;
>       uint8_t state, mask;
> -    char *state_str;
> +    g_autofree char *state_str = NULL;
>   
>       if (!visit_type_str(v, name, &state_str, errp)) {
>           return;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


