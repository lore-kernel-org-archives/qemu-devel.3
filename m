Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EE1CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7HPW-00078v-6h; Fri, 10 Oct 2025 14:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v7HPU-00078V-7a
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v7HPL-0004kC-8K
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760119192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AFLiW8+AtDhWgZAInnlhE6wds3dYjwfN3fiTKs8tXaM=;
 b=YN67HUhJN5f1NH2UjUKnp4O39mhpDmpDaUQKLm+Q02jiQGm5Uu78Gt0ZUhe3oUK/ZbnkGa
 OCbXeOjVlKZUyGXwtDnC+QA1q0ZFOAF8APihkDPNGT3iyRyzg8XRuuIqg5cXYvj6nKz92h
 LhGr7geERAjXXD95Mrbp+KYlhNzNVc8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-DdPGQ2ipMVKI3kBLr_9n9g-1; Fri, 10 Oct 2025 13:59:50 -0400
X-MC-Unique: DdPGQ2ipMVKI3kBLr_9n9g-1
X-Mimecast-MFC-AGG-ID: DdPGQ2ipMVKI3kBLr_9n9g_1760119189
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-41066f050a4so1302126f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760119189; x=1760723989;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AFLiW8+AtDhWgZAInnlhE6wds3dYjwfN3fiTKs8tXaM=;
 b=o2vioxbdHfwWwsHo1ETmnoc3ZtWAMhwm8dKxXnCDnOGW/iUrnCAoCcHcplcc6Ya1tz
 1N02CYsviemNMRDwLUvAO3rrXt5qjoMILrrIJbJ2f7i0Km8O/3Vy3Ez3ys4bDf70DtZa
 WntvqpiLJ/bpLw2ItytYy65nnDGjdQ7TSKMt/v9oc9FHmqURpUfRpA4tc6SYwQBl+9wf
 TM0Wu2VW/M4/EOrYqJlx6ukK2MwkD8lE39VD+n8gefq7EaiLhQby6aaWhXQXF9LI9Pq6
 +0L3PA8PwKWbNnzlR2Eb+5EUWDLz5L8oeqIeowudaBPUhcou8EjWeVYLTEu5wtSbEBUp
 AmaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhSt2a2fHNtUhGcJKPwp1au5T4g6RltXKSHfkcN63xO1sYQZqSRxweXfZHncPe4eoQgik4r8GheaYD@nongnu.org
X-Gm-Message-State: AOJu0Yw6wz7JuLvDBku0FA6Zl6PB9kT4cpZhNWfEcpJYl26h88Kz+ac8
 g8K2XUsrojZqjHLSoAnF89RrrwKQsE+z0o9jUWRDGB+HE4w3DsopJuN77R6v60cROk5oRea2gt1
 HUVuyn9HgY2BKL95XdbGNM8UUatDOg1e8w4k9RyFtwY+vTLmaBy5TCpd+
X-Gm-Gg: ASbGncviCrbsnD8DTOPGcc3/znYHW6dntC4g0KngTz16e128w0QZBhv1f9uilRhIj5i
 coObAWB1S7743yvyH/ZBsRSVmSpNuXbVACENWbrqfgWGby83XvU+LZiVzuZ+c/2tpDaL19WNY5G
 ROHaQNhslEjJKdKeaBY/zyAuWtRgjNuGe5IhfjzEwr8T1INsWsk/rBoXlv1XuOVHrIquTNwJHC8
 Y6YLQMe/oEGFdRYUJdET4PUIkRNEpzHajAMdiqJTZrufc93IYAmNv6/B0GHfZtsxRbgIOlNKlNW
 I25WRCxIkohYm17CtehjAMN4xXQxDp/3c88ErYA6LyimAeeyhRRhSZLirDHJvd9zElqn9PMK1or
 UDXcX
X-Received: by 2002:a05:6000:2601:b0:3ec:b899:bc39 with SMTP id
 ffacd0b85a97d-4266e8e9004mr8601539f8f.58.1760119189151; 
 Fri, 10 Oct 2025 10:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7krgCZddFLPDBGMIG9zz7LcSrI620U361CyyHg9QSBkbgROWWAqurkJX2wBOJOrmabq/3HQ==
X-Received: by 2002:a05:6000:2601:b0:3ec:b899:bc39 with SMTP id
 ffacd0b85a97d-4266e8e9004mr8601526f8f.58.1760119188781; 
 Fri, 10 Oct 2025 10:59:48 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49d03e2sm56298255e9.19.2025.10.10.10.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:59:48 -0700 (PDT)
Message-ID: <9a3e44d1-71c3-4725-965f-a8a3d2eb6736@redhat.com>
Date: Fri, 10 Oct 2025 19:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: purge msys pacman cache
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yonggang Luo <luoyonggang@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251010160545.144760-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251010160545.144760-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/10/2025 18.05, Daniel P. Berrangé wrote:
> For the Windows msys2 CI job we install many packages using pacman
> and use the GitLab cache to preserve the pacman cache across CI
> runs. While metadata still needs downloading, this avoids pacman
> re-downloading packages from msys2 if they have not changed.
> 
> The problem is that pacman never automatically purges anything
> from its package cache. Thus the GitLab cache is growing without
> bound and packing/unpacking the cache is consuming an increasing
> amount of time in the CI job.
> 
> If we run 'pacman -Sc' /after/ installing our desired package set,
> it will purge any cached downloaded packages that are not matching
> any installed package.
> 
> This will (currently) cap the pacman download cache at approx
> 256 MB.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 1 +
>   1 file changed, 1 insertion(+)
> 
> See a test job with this change, plus a find across the msys
> pacman cache, showing the cleanup effects....
> 
> Before cleanup:
> 
>    https://gitlab.com/berrange/qemu/-/jobs/11679136531#L34
> 
> After cleanup:
> 
>    https://gitlab.com/berrange/qemu/-/jobs/11679136531#L1126
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 1e6a01bd9a..6e1135d8b8 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -87,6 +87,7 @@ msys2-64bit:
>         mingw-w64-x86_64-pkgconf
>         mingw-w64-x86_64-python
>         mingw-w64-x86_64-zstd"
> +  - .\msys64\usr\bin\bash -lc "pacman -Sc --noconfirm"
>     - Write-Output "Running build at $(Get-Date -Format u)"
>     - $env:JOBS = $(.\msys64\usr\bin\bash -lc nproc)
>     - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory

Reviewed-by: Thomas Huth <thuth@redhat.com>

I just tested this with some additional "ls -lR /var/cache/pacman" added, 
and it seems to work as expected:

  https://gitlab.com/thuth/qemu/-/jobs/11680562487#L293

This just removed an old "mingw-w64-x86_64-python-3.12.11-4-any.pkg.tar.zst" 
package, but kept the newer 3.12.12 package (and all other currently 
installed packages) around. Thus also:

Tested-by: Thomas Huth <thuth@redhat.com>


