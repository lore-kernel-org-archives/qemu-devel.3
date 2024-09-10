Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC54FECE57A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzkO-0005Ab-5W; Tue, 10 Sep 2024 08:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1snzkI-000592-Ur
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1snzkA-0001Cn-AT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725970393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zMCLFNxyejVSEI0C0ONg2nRCjcJL3nR79nFtGUR0tjU=;
 b=XG8YGENlOUQ0zxKf5nBBMLkQ8B1ha4Gc6AKORjMWbgLolFvoV89rTIfigRCXdK2mr+ykVN
 umCcN4xf3oYarnVK4Ivfhnuv3exxej5y8ZMayoKcwpz3bfLy/09Cq2ZQ09Cs8yT6ERKFQ3
 gE//bxvHvQmWq3l++UOg8YgMlbWKqVo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-oGlndHUoNjKbDLrfnXX7xw-1; Tue, 10 Sep 2024 08:13:11 -0400
X-MC-Unique: oGlndHUoNjKbDLrfnXX7xw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c5135456cbso83951856d6.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725970390; x=1726575190;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zMCLFNxyejVSEI0C0ONg2nRCjcJL3nR79nFtGUR0tjU=;
 b=O4O8bwvsLnY63D+OmSz3Nrl6bHKVQHdc06v/Eyj3YDYnvPI0bdqx7IN6E6wDP8fWpj
 yy1VIezt/YjOI9RiZNlM+hhbuTeuKCrL1m5q4RULwrEmK+vUgKvDXwTLOxfGt13i9+Vf
 P+Ukzpw8Q685TPi792L2vh49p36ymFf0d2jr4Mud6l8R6yGdOijTTWHCMV0Oxw91mIpO
 GYznIHU+ymsjUjfOtYKG76CJDUGHY7krCVOu/koyYkRhd2QHVEo/71Ekxis4lLdDWt2a
 HfH246ez29z5QN5VTdaSCFqVxnRf0ps+Pqva6T/Mp61HhJf73qTaM6GLi/KcIkSJZj7t
 MfQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsWv4MayKbYxJ3OjMTBx2elUSyeHq76SthAuhRgGRj4a+Xla7plWNgCs9GE5FgjJP7ShTJ34rwnoOQ@nongnu.org
X-Gm-Message-State: AOJu0Yz9Hp8rfcf6kyum1819LSdT3pWXFWNmuhb5wTBSTJI5v5VNvoAw
 7cIuJNRFR5z4SMYEr7xK3LzNoEk3uxtXYaqd68qRqAAeG10TwuaJMWE6vFGDBWb3kT28hNRVbm0
 uR8oskO/ULak+VXNIbVxUNaAw3wsFVVWMwFuKvV3T8N8b/5se+xuO
X-Received: by 2002:a05:6214:4302:b0:6c3:643d:3b with SMTP id
 6a1803df08f44-6c528509e5fmr150722326d6.42.1725970390582; 
 Tue, 10 Sep 2024 05:13:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuYPTEuoTwU0B3cQTKkjFSq1PKrF9H9b4cIxCDILwbNmPE4bV1HTutaH0cmT5mOqb16po7fQ==
X-Received: by 2002:a05:6214:4302:b0:6c3:643d:3b with SMTP id
 6a1803df08f44-6c528509e5fmr150722096d6.42.1725970390210; 
 Tue, 10 Sep 2024 05:13:10 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-178-122.web.vodafone.de.
 [109.43.178.122]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5343293d3sm29533986d6.17.2024.09.10.05.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 05:13:09 -0700 (PDT)
Message-ID: <3d74779c-7048-4de8-ba6d-e65062b541c5@redhat.com>
Date: Tue, 10 Sep 2024 14:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] .gitlab-ci.d/crossbuilds.yml: Force 'make check'
 single threaded for cross-i686-tci
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240906180723.503855-1-peter.maydell@linaro.org>
 <20240906180723.503855-3-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240906180723.503855-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/09/2024 20.07, Peter Maydell wrote:
> The cross-i686-tci CI job is persistently flaky with various tests
> hitting timeouts.  One theory for why this is happening is that we're
> running too many tests in parallel and so sometimes a test gets
> starved of CPU and isn't able to complete within the timeout.
> 
> Set the MESON_TESTTHREADS environment variable to 1 for this job;
> this will cause 'meson test' to run only one test at a time.
> 
> (Note that this relies on the change to meson2make that makes it
> honour MESON_TESTTHREADS; otherwise it will have no effect.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Seems worth a try -- if this doesn't have an effect then
> we can revert it, but we'll at least have determined what
> the problem isn't...
> ---
>   .gitlab-ci.d/crossbuilds.yml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index cb499e4ee0d..ca1db011b11 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -70,6 +70,9 @@ cross-i686-tci:
>       ACCEL: tcg-interpreter
>       EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
>       MAKE_CHECK_ARGS: check check-tcg
> +    # Force 'meson test' to run only one test at once, to
> +    # see whether this reduces the flakiness of this CI job.
> +    MESON_TESTTHREADS: 1

Can't we simply add "-j1" to the MAKE_CHECK_ARGS line?

According to the man-page of "make":

  "If there is more than one -j option, the last one is effective."

So adding a -j1 should override the previous setting, I think.

  Thomas



