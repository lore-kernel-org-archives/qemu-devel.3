Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDE6E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9Vk-0004m0-UH; Thu, 05 Dec 2024 05:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJ9Vj-0004ld-AG
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:55:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJ9Vh-0001iK-On
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733396104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wMm9ABn/0U3hPqIWqC835qUi1mKNmKdZ5mcT3Xzr/hM=;
 b=cvWz/A8b8CVPxIVWoi8aTKDBYcC5GRIZgD5ZF4CmPVMJ73Dku3f3kkZGjkXsudXA7Ecg27
 VPyedD2kQjHUBYOn2jrOLs/bH7F6DsDqF/UI2RN0t8zqeZRB28dIis/eCHopehVgrRVGZD
 WIgTZBt+HKUdWnhU93DcFhtAD0Y+HFc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-Dk4d4aL9MlibY2hge8no6Q-1; Thu, 05 Dec 2024 05:55:03 -0500
X-MC-Unique: Dk4d4aL9MlibY2hge8no6Q-1
X-Mimecast-MFC-AGG-ID: Dk4d4aL9MlibY2hge8no6Q
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4349cbf726cso4677025e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733396102; x=1734000902;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMm9ABn/0U3hPqIWqC835qUi1mKNmKdZ5mcT3Xzr/hM=;
 b=lmpgn5fUgA/0iCj0FT2bQIV+IeJBpCK8uZDruFeLtH7qk44XSk+6xTDPsTTNm8NThF
 55ct3cgDlMppkWKkpR7XnnClteUsYCtsVtBgMCgJoRjNDMgRx/72enEKRtXAc8/2utXk
 vLxDjSy0ZJaEDUOx1o8DDz21FXZYcd4Rr7a0n6QYpPNlAQEdBykuVXgwBZzsUKf3sF1K
 iLYhKDjdNc5eTlt8aoUE/o7Pl40gDYsGJZ51mHSPzQFSUX6VZYYj5/5z2COfIQ5IPX5h
 UGUmaHgFB+/TfjaS9aMWYmj5EcEVedxEzTscDgIWCojvlEFP4M8RslWTfr326jAsVn8c
 eKlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn5JZ0jfulD0uWoF3lVi5B5XlZAIKktPztXie0BgOkNnsnMlw5Yb5Bh4bKIg1mWaqqA5V9AZ2P1bEU@nongnu.org
X-Gm-Message-State: AOJu0Yyatc5D79h/ChZTt7YbFl1KkK7eQLIAuo6hM+h2GeBHRfmuayOC
 TyeaBryeoJamNnjBTKpSs994F+R/Jcx2ChaututkL1NhgQDW1djAvqc2M4o/rBUHMj3uuExVU26
 sbQq7DOGEPKTkP02VKiB+QR84gtq+BfunvHM99qJmRqs2pEa/QQID
X-Gm-Gg: ASbGncs9Za6Vhcc2FvPnn8a+aSrHoz7IJZx8AvPFxqsMpB5aLbLOIJMQWqTFVPmdpFw
 4irePSL/fosbxbGzikcRtzPVCzpEFQhnZmtwsgGVuWK6VoKNWsZcQMu0Mq2F7+u7pMAUVu/XOvw
 wGv6pDpM0NHLcSSbj2tu46mGCUa0Oli/vGIzK/+F9jXHvH/2mVhuLElnyu7JJ0ISnPqtB/2uA7I
 RfbGR09zXcx4B/KfKdJAFRqm092OOMRQDko3Z8s3aLp4W20vcUzU/CWqwAt4Vnj+2WcAKlPlGsq
 Hiu41Q==
X-Received: by 2002:a05:6000:2806:b0:385:e8aa:2a4e with SMTP id
 ffacd0b85a97d-385fd3f2371mr5667267f8f.31.1733396102500; 
 Thu, 05 Dec 2024 02:55:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7xw//VBukVq+xgSeVcywacz4syrQR6s3bvLUy8pjOhAuwGncWa4g0vnSTxYWLTkKl6WOIzQ==
X-Received: by 2002:a05:6000:2806:b0:385:e8aa:2a4e with SMTP id
 ffacd0b85a97d-385fd3f2371mr5667250f8f.31.1733396102155; 
 Thu, 05 Dec 2024 02:55:02 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-244.web.vodafone.de.
 [109.42.48.244]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386219096b8sm1667638f8f.84.2024.12.05.02.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 02:55:01 -0800 (PST)
Message-ID: <a41bb572-6bf1-4972-8223-22677a21b864@redhat.com>
Date: Thu, 5 Dec 2024 11:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] gitlab: purge build files from cirrus CI jobs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241204194807.1472261-1-berrange@redhat.com>
 <20241204194807.1472261-5-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241204194807.1472261-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 04/12/2024 20.48, Daniel P. Berrangé wrote:
> Uploading artifacts in Cirrus CI requires sufficient disk space to
> create a tarball of the artifact files. IOW, whatever size the
> artifacts are, double that. This results in space pressure on the
> FreeBSD jobs due to limited disk size. Purging the .o files from
> the meson build directory reclaims significant space.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/cirrus/build.yml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
> index 9983ab0690..d26a2a788c 100644
> --- a/.gitlab-ci.d/cirrus/build.yml
> +++ b/.gitlab-ci.d/cirrus/build.yml
> @@ -37,6 +37,7 @@ build_task:
>         do
>           $MAKE -j$(sysctl -n hw.ncpu) $TARGET V=1 ;
>         done
> +    - find . -not -path 'meson-logs/*' -delete

I'm not sure, but this might cause trouble if you run the Cirrus-CI job with 
terminal access for testing the binaries manually after the build succeeded? 
Maybe it would be better to just kill the .o files and leave the rest around?

  Thomas


