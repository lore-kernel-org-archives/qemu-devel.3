Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E925BCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 18:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIshM-0003Rx-Ct; Tue, 11 Nov 2025 13:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIsgd-00036t-EO
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:01:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIsgc-0003Gy-Bn
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762884105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pglcBOI65Cy8PggXp2vfN1Rqo3l/dKZZbS2poH6t+Ao=;
 b=ijrp1UHPu3+voN79lwvIfo6nNfhc3vbPJLd2J0DAFxJ3rXRKEDkOoKJXa/Xd+XufGTdXto
 mQ0mlYAVQxM829B4bvRcQZbt5GhPN3ya6dfV74OWLU4cNoUcPjg0O1WtZeNooMC3IPjb/U
 WO7nC5+0fWNVKEU/8/9bZZFhYxO9/lM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-HPF43N4YOoirAt03RxoEyg-1; Tue, 11 Nov 2025 13:01:40 -0500
X-MC-Unique: HPF43N4YOoirAt03RxoEyg-1
X-Mimecast-MFC-AGG-ID: HPF43N4YOoirAt03RxoEyg_1762884097
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b2ffe9335so2167761f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762884097; x=1763488897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pglcBOI65Cy8PggXp2vfN1Rqo3l/dKZZbS2poH6t+Ao=;
 b=LGCykBJ4ShD8B8viZ3sfhj59FJ+T7jLWfEyRTkWUpfG5RZAEOznL+cXAQCVnG+iCtI
 u0O93RDLGuCJk+gNWNwpqpqsS/AIjyvRe6dYEnHw79kcRLMkdlJ9UGgp56JM5hs2rZ9A
 yxO7kGoX9f/u1YywAh+9BQM46EayhghcIrHb8mUHlzLILSf1bzSuFbz7+zICU3hbcWNm
 EwdzaK+TgWHnOvXvDPaG70syzTM5ebbTemDyNFTc9P2zCh1afDWK1CaO6/F92P9sz/F+
 WetRdWjpagAuiELyvrZ5+Vx8wP6iThOQNe1T7ng0J9Vv8fkUVG3Yh0Mw6Ebw8e30oXzT
 ImpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762884097; x=1763488897;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pglcBOI65Cy8PggXp2vfN1Rqo3l/dKZZbS2poH6t+Ao=;
 b=mfuGAfBHYdvbCXcY1MmAfKu4SaczcvpWOVpE+1THI8EHFpUcPit/N5hwKsuDva8+en
 uyDI3ijqUeMVQwUnRqNwZ9Rv57coBX4thbgo6DKvuZ3rE7bNuF+iDxS7/9mQJktTPsj6
 iVjmW73Rck+gvrP7ZzPz3Az001IxyfTvIirMl2W9Fsvq3yrO1PpifmBQtXVbbi2hz7aq
 ac1foi85Gjc4TnYE5mtlLRiR6AZ0sOxHy+4nOEwSqM+wHX1F9Y+ttLRLoRK4A3vfFAwY
 Yh5cMqpJtag2BqrR7YoNBSBAClIwZpwg2RzGI6jCXdg3m/qS2rzgeJmyA5RrTv/D6ODT
 0pRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhhjiDoOlcVL8Q3xQRKBHodkWUHh+QEmaA5CcmgiYQVjS+ICIHSmSYV9gQINMs5T+ywBtF9+IeNKCf@nongnu.org
X-Gm-Message-State: AOJu0YxlTW6IFgCUZpKmYb8+gHxymDBH2j14FI6Qf77oHCZOQi0xtEsy
 8+6OVRq798xOgHkB0GEy/7q7b7jajdu8HeUeUWKPiD46OOztwlO56HcNnZooWKwLuQQsPzPUOne
 x4UxE3qmbYB0kNiwh3nTjl43sfEz7PlGNOC180n+PkVvJkcpYsOjoY5AB
X-Gm-Gg: ASbGncsCcqVCQm6JMRhPa+5DATxHmqSqietDmDLcR7N3js7JRqf4BoW/NQ/tsVlU3O3
 zYz1SkHQ9SmtwBZiz5P6Ua2B+ydOtZ4APvZyxk+zjgNCzXuYRql5vuhG+0W757Oj05lLn+dKoMS
 rjC1lhsw45x+j4NKilLEBJ/LqRHYX3h+YeRwXY2nZ8xmAlRw2fIXHPmFU1sHz3rFOvZzZQlnFv5
 1HxAliWj0RVZjYmDKgpmdJv5aZMX2Rrvo/OCShwHW/rC42j/1n7Fy8hftEsJs5Bd/mv961/0fcf
 e+ZNJWxNhZBcVN5c9qS7RAfmGuN7LSeGqr5vAT+xwZOrNBDgAqQy6pkja0F14liQYCIn+bk=
X-Received: by 2002:a5d:5c84:0:b0:42b:4279:eddd with SMTP id
 ffacd0b85a97d-42b4bb7d2f0mr90474f8f.24.1762884096720; 
 Tue, 11 Nov 2025 10:01:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZO7dWUazsEo1FXX4wCWBB8J8Qn7Bv1CYf1jO0OUi/DbAay5UVfKOZiBUA7uG7I0QaGR0xrg==
X-Received: by 2002:a5d:5c84:0:b0:42b:4279:eddd with SMTP id
 ffacd0b85a97d-42b4bb7d2f0mr90430f8f.24.1762884096263; 
 Tue, 11 Nov 2025 10:01:36 -0800 (PST)
Received: from [192.168.0.7] ([47.64.113.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac679c5dcsm33138957f8f.44.2025.11.11.10.01.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 10:01:35 -0800 (PST)
Message-ID: <b540d3eb-b132-4fb8-acd7-8b5ec5878652@redhat.com>
Date: Tue, 11 Nov 2025 19:01:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] tests: move test_xen assets to share.linaro.org
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-stable@nongnu.org
References: <20251111171724.78201-1-alex.bennee@linaro.org>
 <20251111171724.78201-8-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251111171724.78201-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 11/11/2025 18.17, Alex Bennée wrote:
> Linaro are migrating file-hosting from the old NextCloud instance to
> another sharing site.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>   tests/functional/aarch64/test_xen.py | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_xen.py b/tests/functional/aarch64/test_xen.py
> index 261d796540d..f7bde5859ec 100755
> --- a/tests/functional/aarch64/test_xen.py
> +++ b/tests/functional/aarch64/test_xen.py
> @@ -25,8 +25,7 @@ class BootXen(LinuxKernelTest):
>       XEN_COMMON_COMMAND_LINE = 'dom0_mem=128M loglvl=all guest_loglvl=all'
>   
>       ASSET_KERNEL = Asset(
> -        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
> -         'download?path=%2F&files=linux-5.9.9-arm64-ajb'),
> +        ('https://share.linaro.org/downloadFile?id=RRahAWwAwYKTZQd'),

If the URL fits into one line, you could drop the parentheses here now (and 
also in the other spots in this patch).

With that nit fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


>           '00366fa51ea957c19462d2e2aefd480bef80ce727120e714ae48e0c88f261edb')
>   
>       def launch_xen(self, xen_path):
> @@ -55,8 +54,7 @@ def launch_xen(self, xen_path):
>           wait_for_console_pattern(self, console_pattern, "Panic on CPU 0:")
>   
>       ASSET_XEN_4_11 = Asset(
> -        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
> -         'files=xen-hypervisor-4.11-arm64_4.11.4%2B37-g3263f257ca-1_arm64.deb'),
> +        ('https://share.linaro.org/downloadFile?id=ALU4n2NGGYbE4fO'),
>           'b745c2631342f9fcc0147ddc364edb62c20ecfebd430e5a3546e7d7c6891c0bc')
>   
>       def test_arm64_xen_411_and_dom0(self):
> @@ -66,8 +64,7 @@ def test_arm64_xen_411_and_dom0(self):
>           self.launch_xen(xen_path)
>   
>       ASSET_XEN_4_14 = Asset(
> -        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
> -         'files=xen-hypervisor-4.14-arm64_4.14.0%2B80-gd101b417b7-1_arm64.deb'),
> +        ('https://share.linaro.org/downloadFile?id=os4zSXPl7WW4lqX'),
>           'e930a3293248edabd367d5b4b3b6448b9c99c057096ea8b47228a7870661d5cb')
>   
>       def test_arm64_xen_414_and_dom0(self):
> @@ -77,8 +74,7 @@ def test_arm64_xen_414_and_dom0(self):
>           self.launch_xen(xen_path)
>   
>       ASSET_XEN_4_15 = Asset(
> -        ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/download?path=%2F&'
> -         'files=xen-upstream-4.15-unstable.deb'),
> +        ('https://share.linaro.org/downloadFile?id=jjjG4uTp2wuO4Ks'),
>           '2a9a8af8acf0231844657cc28baab95bd918b0ee2d493ee4ee6f8846e1358bc9')
>   
>       def test_arm64_xen_415_and_dom0(self):


