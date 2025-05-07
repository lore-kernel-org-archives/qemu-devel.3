Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB56C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 11:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCdQ6-0003TX-CE; Wed, 07 May 2025 07:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCdQ3-0003RN-3Z
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:58:35 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCdPz-0000DK-UQ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 07:58:33 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac25520a289so1152192166b.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746619108; x=1747223908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AS+S5V85fn4XkQGv3yyoyHMQqf4NztisZINh+hUAsrQ=;
 b=Ol4jZ2dOWnZ7lJgPhN0m4owy7edCm/b9nlB3GGz+jQSpdyqgS2IVvaLR1L8AFVmg+k
 JFB3PN6kSQOgWu/8ktWuOGnJIZGc2jh+/jH6OheS4Ufxik0gK9OmqNK9rFh/z+o9SPqE
 GJZvhSilGK7ab2r+qG/IcRaVtXk3ddNPJmLbEsYPB4FU9WkRHf74Jda27pf0ksbwBKoB
 qlxLDHCITQeBO0AHY2qrlH9hwQ0DxiLcId/sJnCMSWlu7Mf7Gs1mi5K7e/+zSZ3V3Jye
 tFaue+dYcy6TGlskcvLpo0PuabJNveKy1TnqX6PU93t3gjg6qZaz7A93B8V1mPaXcGiy
 aebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746619108; x=1747223908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AS+S5V85fn4XkQGv3yyoyHMQqf4NztisZINh+hUAsrQ=;
 b=qOVEYTSTeybebPbWSYi/9RyP1rgGHtgxljqrV/QoCgbtGXFefP8UhOL2dr8zBiJcgK
 bELkEhSIHgK7ZGrY1bKlMy36UTtViJgJeSdHFkpRW/5GJ+Po9wGJ1nuqGU5yMEqFv4QW
 CqiyoY8gU/8k2tAlzqLavvrsJ3gxCXoDc3/N/wyYkjp2fq6PwuTFnP+N9g8WtyvByW3s
 1XRLrXrrZeBR6y2R8IoHYim7UVxXi3bWUKzIyATZgRwcCes6eBR4+F17oP4U+R0y6UQK
 bbUz+rjE8AkoVPMZltl6lz/EnJfze+BM5fzeD/O7NNOAESkUSOqBLTQvWneZuNg4GjHV
 djPA==
X-Gm-Message-State: AOJu0YyXkZjb9bTsBATbC6pDNs7fV+iMxmbzY44h2Oe9YWZKdRdQ79hA
 ejlvxLoxtZpjpiOb2Sn9F2wfgkNDVwauit0ampWecqQBGEWL0H+9Pp8Cjg/PQug=
X-Gm-Gg: ASbGncuFxpOJIta6kujzyzj3luNCS8urwd9MI9HkawBLvBEKJ4wUfkBVR64UnRStSGs
 /MGCvNW8aqWZeg/z3ITKCphYiN28mvWSc4+g3iwmlAIswU8lRWYz+An5agos8XjMw6Eo/bVnFzW
 ADuZ7vya5s2k8ZJkpU1CUp2ItPsf5VGkkfoazLNQIENCgFVGzdu1fGtpPlkjOEqLO7s5pXUCUte
 lQjdd9Y2M2Tki81ZPUG+a9dQu6Bj6VQYGXdRR3dptv2xVP/O/khaaV1TwUEE2crYeJLvHJ/uLCY
 INjIZtC/edmv/BXRvObU4IMCcBAzQ0UwZK9b96ipAivhyDNaXYI6nHUvyByF
X-Google-Smtp-Source: AGHT+IGd35PMq0BF6K5haauV0wYnBQtbS0lkrmfqF7h7Gdzt2MJMZPIaefpsHo1esKFZm+bZeiK34A==
X-Received: by 2002:a17:907:8b85:b0:acb:5adb:bd4a with SMTP id
 a640c23a62f3a-ad1e8cacfdbmr289153566b.12.1746619107690; 
 Wed, 07 May 2025 04:58:27 -0700 (PDT)
Received: from [192.168.55.72] ([176.171.151.116])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1eb6cdc95sm150546866b.71.2025.05.07.04.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 04:58:27 -0700 (PDT)
Message-ID: <0dc12168-6742-4c39-ae5c-4a703cd83dde@linaro.org>
Date: Wed, 7 May 2025 13:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] util/memfd: allow allocating 0 bytes
To: Elisha Hollander <just4now666666@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
References: <CACkyd_aL_KAgG1FzoC+H+TpNm2KCvWq+35HMUsVaBKWThNSBNQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CACkyd_aL_KAgG1FzoC+H+TpNm2KCvWq+35HMUsVaBKWThNSBNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Hi Elisha,

On 6/5/25 18:44, Elisha Hollander wrote:
>  > As I mentioned earlier, let's say you don't initialize the vertical 

"As I mentioned earlier": where? Otherwise this description will be of
little relevance in 5 years from now in our history.

> display end registers, and set the minimum scanline register, the 
> emulation will then have to allocate some display buffer, but because 
> the vertical display end is initilized as 0 the buffer will be empty and 

Typo "initialized".

> the program break.
> 
> Signed-off-by: donno2048 <just4now666666@gmail.com 
> <mailto:just4now666666@gmail.com>>
> 
> ---
>   util/memfd.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/util/memfd.c b/util/memfd.c
> index 8a2e906..e96e5af 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -108,7 +108,7 @@ err:
>   void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
>                          int *fd, Error **errp)
>   {
> -    void *ptr;
> +    void *ptr = NULL;
>       int mfd = qemu_memfd_create(name, size, false, 0, seals, NULL);
> 
>       /* some systems have memfd without sealing */
> @@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t 
> size, unsigned int seals,
>           }
>       }
> 
> -    ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> -    if (ptr == MAP_FAILED) {
> -        goto err;
> +    if (size != 0) {
> +        ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
> +        if (ptr == MAP_FAILED) {
> +            goto err;
> +        }
>       }
> 
>       *fd = mfd;
> --
> 2.30.2

Alternatively always set *fd, removing the @err label:

-- >8 --
@@ -132,0 +133 @@ void *qemu_memfd_alloc(const char *name, size_t size, 
unsigned int seals,
+    *fd = mfd;
@@ -134,3 +135,2 @@ void *qemu_memfd_alloc(const char *name, size_t 
size, unsigned int seals,
-    ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
-    if (ptr == MAP_FAILED) {
-        goto err;
+    if (!size) {
+        return NULL;
@@ -139,2 +139,4 @@ void *qemu_memfd_alloc(const char *name, size_t 
size, unsigned int seals,
-    *fd = mfd;
-    return ptr;
+    ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
+    if (ptr != MAP_FAILED) {
+        return ptr;
+    }
@@ -142 +143,0 @@ void *qemu_memfd_alloc(const char *name, size_t size, 
unsigned int seals,
-err:
---

Or more similar to your approach:

-- >8 --
@@ -111 +111 @@ void *qemu_memfd_alloc(const char *name, size_t size, 
unsigned int seals,
-    void *ptr;
+    void *ptr = NULL;
@@ -134,5 +133,0 @@ void *qemu_memfd_alloc(const char *name, size_t 
size, unsigned int seals,
-    ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
-    if (ptr == MAP_FAILED) {
-        goto err;
-    }
-
@@ -140 +134,0 @@ void *qemu_memfd_alloc(const char *name, size_t size, 
unsigned int seals,
-    return ptr;
@@ -142,4 +136,2 @@ void *qemu_memfd_alloc(const char *name, size_t 
size, unsigned int seals,
-err:
-    error_setg_errno(errp, errno, "failed to allocate shared memory");
-    if (mfd >= 0) {
-        close(mfd);
+    if (!size) {
+        return NULL;
@@ -147 +139,11 @@ err:
-    return NULL;
+
+    if (size) {
+        ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
+        if (ptr == MAP_FAILED) {
+            error_setg_errno(errp, errno, "failed to allocate shared 
memory");
+            if (mfd >= 0) {
+                close(mfd);
+            }
+        }
+    }
+    return ptr;
---

