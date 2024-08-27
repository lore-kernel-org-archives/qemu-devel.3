Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4D4C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siyFq-0005b6-Qj; Tue, 27 Aug 2024 11:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siyFp-0005Uq-7w
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:37:09 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siyFn-0003Zy-H0
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:37:08 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a86e5e9ff05so125846966b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724773025; x=1725377825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1vLiCNkcYxf10pE4q0NfWDH5BRMCn9pXqogkpfPhenQ=;
 b=TNicsdBFMBfcJjGd3QCzVIuobbfUT3wpUUr9gboS5/H1VqLq25sK37dJ9Lz5roOvH3
 hT6ocipnwpGAj1rCT/cNIagqjSJ137WD2nq+E2udz85zh5Q2cnJX568sZh1zDq/hibpb
 b2nhf1siabV76IheWHjksmiJGRgfwKfcT+C5exrtlKNswLJNzGzs/xF5fJCtouFkVaOl
 QPBY8OMEyOxjbNtVlSWPHJgrlljNUm9jmYs/vma4TB9uCGMHGleiw+eJPTXdZa+o2cSB
 9/6Bkl029fRkTDz0JDtZIsyQlGPQXO1/04DB+9VTcq0gi0Aq6MBJFXYdFnb/ZPU5jWwF
 SXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724773025; x=1725377825;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1vLiCNkcYxf10pE4q0NfWDH5BRMCn9pXqogkpfPhenQ=;
 b=DeU09GY4dwhmuvIPCLQQW0RcAAbud0lD6luxCF2YaQ+i2vsVM2QjwT3gjaJePnkqKK
 jgXqsbNB+R3hBQ/8N2W60iAAMsMMdNn54xEACOxVLm66zUzCbUK4VreOHM+tGbncEz/L
 6MAnS7lDwrlBnHRLPQM0J3SNAv8IadbvnxAHK6aSyXwGoHU7Kx3X1bP6/QksIf7WxjXE
 vgtU+KX8q2VPB/CNMf9RbwH0OutAwaHaHOvrXt09R2XVi8JV0gXKlYtApx4O+Yuy/U+5
 bm0LnrKo0l02AXLK0/mM11QtDHsm2xWyVvlKV2WLA2YRaEU/g1g1pD5sKD/Oerx3uuAq
 wDGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRazM9cHNgYjiaMaIfK1gy4vDFihqJw7peK70cO9JCVq3eegRvVIEKCxFJoHa8ddGC7tO9Sv1LO051@nongnu.org
X-Gm-Message-State: AOJu0YzOvoURnkg/2DQvKAshoQ/mYVWxVQqIIMW4JRMDKGshPZ2OBS6C
 vMotF299TzA7JjuRnj6BCuGLssqHbbjZYXsIGQRD3xOhTDPXeyY5Da51OJYzxGfiBMjeCww4PG7
 F
X-Google-Smtp-Source: AGHT+IHIpbTQU1BG/fp8QrawR8H2lbIYTNyDC+ybFLPFTuF2y5y5cmCrQKhRD1VM93kwFiftA9pj3A==
X-Received: by 2002:a17:907:7255:b0:a7a:a5ed:43d0 with SMTP id
 a640c23a62f3a-a86e3bdbadfmr262134766b.47.1724773025289; 
 Tue, 27 Aug 2024 08:37:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e582de1asm122614866b.118.2024.08.27.08.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 08:37:04 -0700 (PDT)
Message-ID: <a1e21e7c-a2a7-4eac-8a5d-e3cd57dc6894@linaro.org>
Date: Tue, 27 Aug 2024 17:37:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/34] modules: check arch on qom lookup
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Peter Lieven <pl@kamp.de>,
 Greg Kurz <groug@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-s390x@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>
References: <20210624103836.2382472-1-kraxel@redhat.com>
 <20210624103836.2382472-20-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20210624103836.2382472-20-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

(old patch)

On 24/6/21 12:38, Gerd Hoffmann wrote:
> With target-specific modules we can have multiple modules implementing
> the same object.  Therefore we have to check the target arch on lookup
> to find the correct module.

"multiple modules implementing the same object." seems a design
mistake to me.

Assuming we clean the tree of target-specific modules "implementing
the same object" -- due to heterogeneous emulation --, is there
another use case for this check?

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   util/module.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/util/module.c b/util/module.c
> index 065aed09ffef..6bb4ad915a1c 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -329,6 +329,9 @@ void module_load_qom_one(const char *type)
>           if (!modinfo->objs) {
>               continue;
>           }
> +        if (!module_check_arch(modinfo)) {
> +            continue;
> +        }
>           for (sl = modinfo->objs; *sl != NULL; sl++) {
>               if (strcmp(type, *sl) == 0) {
>                   module_load_one("", modinfo->name, false);
> @@ -349,6 +352,9 @@ void module_load_qom_all(void)
>           if (!modinfo->objs) {
>               continue;
>           }
> +        if (!module_check_arch(modinfo)) {
> +            continue;
> +        }
>           module_load_one("", modinfo->name, false);
>       }
>       module_loaded_qom_all = true;


