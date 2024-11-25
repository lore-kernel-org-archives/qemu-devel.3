Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448FED58090
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 12:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFY0x-00050I-58; Mon, 25 Nov 2024 07:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tFY0t-0004z4-T1
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:16:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tFY0s-0002Am-2T
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 07:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732536981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+5u+4xWnd7W5L7ip6Lp6CyQgPLhFutn+d3ksGLbdODI=;
 b=DesuicHCnUjznzxdoHUmXqAUNVxEAlG2ru0phuM5RzublOTrGqr7+3lII6Z9Gjh6ieF6Oo
 UwSyjDKZuyoHN62d0+Xcev92DDN6B31t32fM5xXaCjfZ+OxWEBiMwYdpMr+vXNscve0j83
 y9v6H7DTLODQjEC2PXzsMGOnPKohuyk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-A1vDuHwuNL2zwwQDcqawUw-1; Mon, 25 Nov 2024 07:16:20 -0500
X-MC-Unique: A1vDuHwuNL2zwwQDcqawUw-1
X-Mimecast-MFC-AGG-ID: A1vDuHwuNL2zwwQDcqawUw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315d98a75fso37064805e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 04:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732536979; x=1733141779;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+5u+4xWnd7W5L7ip6Lp6CyQgPLhFutn+d3ksGLbdODI=;
 b=eGXBIlBAcgJ092wsN/JhHD0oca/m84d0EF6pnabMKSHW69hDiM56miMCC5t8fjvT/5
 ZqkpCDSXGEv6vqQuhiLaZKOCvOuRc5zmloWJklqO6V8wBNdWF0LOG+GmmR3yTrYuslAr
 5MekMWo+PdAaN8BLHZ+dwP7sq9kte1PWGD0a9v1duKWubGUbbXhb/JyqxlLl8B2Q7p0g
 L87e98yjUPINC4r+VT5CGlJtE374BRki7KP82DcFgk2Q0eNh3bff7vq3ejb87IWn3ZhK
 5prMh2uT1mSiAKScGlo8Kzr+GlP6NjizqHd0pw8qbsj8hRUXHADp5AmlNK9OIdDC+qs6
 BYfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTzp14bntQoFc/MWHKNXcu123/yc06hdo/S055+RwchKHwKuVSAGDgF5GEQ1OV0nZnoz2gYoEHDFX4@nongnu.org
X-Gm-Message-State: AOJu0YyG8zoPmhwigebcFpAgmSk/gQVOQ/rYRT8Ksmc/iE6azrnsZbZ8
 MV2BA/l2vk1NFL1y2wZzTvybbPaTpuQhd/FwOoSe9MusB1wo6q+PbxWCiJ8dvxiqhKtB53l+VOe
 o+agrWiziAZyjWyJpB3rP06aRpTRnfueNfkkpWUmso6BhSYgrK/Zi
X-Gm-Gg: ASbGncvizNzIMv2eoXQjYefxB/FrowY9S2kKNveKw3zip4b08N3W7/slNhPHC5ant5t
 JV+k9DueiIJ6QfOASqkTzu3insVA95XtXB6l3x7JRA/l1vkxiNPIUQlPYbmUqR9LQExoWBUB+bW
 NzNCB/ahljeM9cx82CLDCyEuqHgmNC2GFOAOM8JQdvatxiUAqnUCA2RINOZrj9ZHfbLcClGlLwt
 5w6Bxvg00YTpdkHyiu9S+05pNdL0onRR5JCZCvkMVDJ4JtpnJZ1mUw7sP19MYoTohDDxbc0b6a+
 rCk=
X-Received: by 2002:a05:600c:3b25:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-433ce4c20bemr97506545e9.32.1732536978670; 
 Mon, 25 Nov 2024 04:16:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg7P0TG+c9vqLh0H5TdNSpCNE/CFShou/L9+JHZHdnUIq8hoql6TwiO04nU/nZN0udx6MZ8Q==
X-Received: by 2002:a05:600c:3b25:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-433ce4c20bemr97506295e9.32.1732536978286; 
 Mon, 25 Nov 2024 04:16:18 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349e47f3d1sm46508905e9.17.2024.11.25.04.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 04:16:17 -0800 (PST)
Message-ID: <918536da-bba3-4a0f-96e0-0acf5287e59e@redhat.com>
Date: Mon, 25 Nov 2024 13:16:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cirrus-ci: Remove MSYS2 jobs duplicated with
 gitlab-ci
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-stable <qemu-stable@nongnu.org>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jintao Yin <nicememory@gmail.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230322135721.61138-1-philmd@linaro.org>
 <20230322135721.61138-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20230322135721.61138-3-philmd@linaro.org>
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


  Hi Michael,

could you please cherry-pick this patch to the QEMU 7.2 stable branch?

On IRC, we just noticed that this job is still running for the staging-7.2 
branch. Since nobody really looks for the output on cirrus-ci by default 
(this is the part that is not mirrored to our gitlab CI board), this is just 
wasting our precious CI minutes from the Cirrus-CI nowadays. Since we just 
ran out of Cirrus-CI credits for this month, removing the job from the 7.2 
branch could help to survive longer the next month, I think.

  Thanks,
   Thomas


On 22/03/2023 14.57, Philippe Mathieu-Daudé wrote:
> - Various developers are reluctant to git Cirrus-CI the permissions
>    requested to access their GitHub account.
> 
> - When we use the cirrus-run script to trigger Cirrus-CI job from
>    GitLab-CI, the GitLab-CI job is restricted to a 1h timeout
>    (often not enough).
> 
> - Although Cirrus-CI VMs are more powerful than GitLab-CI ones,
>    its free plan is limited in 2 concurrent jobs.
> 
> - The GitLab-CI MSYS2 jobs are a 1:1 mapping with the Cirrus-CI ones
>    (modulo the environment caching).
> 
> Reduce the maintenance burden by removing the Cirrus-CI config file,
> keeping the GitLab-CI jobs.
> 
> Update Yonggang Luo's maintenance file list to the new file, which
> use the same environment shell.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS |   3 +-
>   .cirrus.yml | 111 ----------------------------------------------------
>   2 files changed, 1 insertion(+), 113 deletions(-)
>   delete mode 100644 .cirrus.yml
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9b56ccdd92..34b50b267c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3818,8 +3818,7 @@ W: https://cirrus-ci.com/github/qemu/qemu
>   Windows Hosted Continuous Integration
>   M: Yonggang Luo <luoyonggang@gmail.com>
>   S: Maintained
> -F: .cirrus.yml
> -W: https://cirrus-ci.com/github/qemu/qemu
> +F: .gitlab-ci.d/windows.yml
>   
>   Guest Test Compilation Support
>   M: Alex Bennée <alex.bennee@linaro.org>
> diff --git a/.cirrus.yml b/.cirrus.yml
> deleted file mode 100644
> index 5fb00da73d..0000000000
> --- a/.cirrus.yml
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -env:
> -  CIRRUS_CLONE_DEPTH: 1
> -
> -windows_msys2_task:
> -  timeout_in: 90m
> -  windows_container:
> -    image: cirrusci/windowsservercore:2019
> -    os_version: 2019
> -    cpu: 8
> -    memory: 8G
> -  env:
> -    CIRRUS_SHELL: powershell
> -    MSYS: winsymlinks:native
> -    MSYSTEM: MINGW64
> -    MSYS2_URL: https://github.com/msys2/msys2-installer/releases/download/2022-06-03/msys2-base-x86_64-20220603.sfx.exe
> -    MSYS2_FINGERPRINT: 0
> -    MSYS2_PACKAGES: "
> -      diffutils git grep make pkg-config sed
> -      mingw-w64-x86_64-python
> -      mingw-w64-x86_64-python-sphinx
> -      mingw-w64-x86_64-toolchain
> -      mingw-w64-x86_64-SDL2
> -      mingw-w64-x86_64-SDL2_image
> -      mingw-w64-x86_64-gtk3
> -      mingw-w64-x86_64-glib2
> -      mingw-w64-x86_64-ninja
> -      mingw-w64-x86_64-jemalloc
> -      mingw-w64-x86_64-lzo2
> -      mingw-w64-x86_64-zstd
> -      mingw-w64-x86_64-libjpeg-turbo
> -      mingw-w64-x86_64-pixman
> -      mingw-w64-x86_64-libgcrypt
> -      mingw-w64-x86_64-libpng
> -      mingw-w64-x86_64-libssh
> -      mingw-w64-x86_64-snappy
> -      mingw-w64-x86_64-libusb
> -      mingw-w64-x86_64-usbredir
> -      mingw-w64-x86_64-libtasn1
> -      mingw-w64-x86_64-nettle
> -      mingw-w64-x86_64-cyrus-sasl
> -      mingw-w64-x86_64-curl
> -      mingw-w64-x86_64-gnutls
> -      mingw-w64-x86_64-libnfs
> -    "
> -    CHERE_INVOKING: 1
> -  msys2_cache:
> -    folder: C:\tools\archive
> -    reupload_on_changes: false
> -    # These env variables are used to generate fingerprint to trigger the cache procedure
> -    # If wanna to force re-populate msys2, increase MSYS2_FINGERPRINT
> -    fingerprint_script:
> -      - |
> -        echo $env:CIRRUS_TASK_NAME
> -        echo $env:MSYS2_URL
> -        echo $env:MSYS2_FINGERPRINT
> -        echo $env:MSYS2_PACKAGES
> -    populate_script:
> -      - |
> -        md -Force C:\tools\archive\pkg
> -        $start_time = Get-Date
> -        bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND $env:MSYS2_URL C:\tools\archive\base.exe
> -        Write-Output "Download time taken: $((Get-Date).Subtract($start_time))"
> -        cd C:\tools
> -        C:\tools\archive\base.exe -y
> -        del -Force C:\tools\archive\base.exe
> -        Write-Output "Base install time taken: $((Get-Date).Subtract($start_time))"
> -        $start_time = Get-Date
> -
> -        ((Get-Content -path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post
> -        C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
> -        C:\tools\msys64\usr\bin\bash.exe -lc "export"
> -        C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy
> -        echo Y | C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Suu --overwrite=*
> -        taskkill /F /FI "MODULES eq msys-2.0.dll"
> -        tasklist
> -        C:\tools\msys64\usr\bin\bash.exe -lc "mv -f /etc/pacman.conf.pacnew /etc/pacman.conf || true"
> -        C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Syuu --overwrite=*"
> -        Write-Output "Core install time taken: $((Get-Date).Subtract($start_time))"
> -        $start_time = Get-Date
> -
> -        C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed $env:MSYS2_PACKAGES"
> -        Write-Output "Package install time taken: $((Get-Date).Subtract($start_time))"
> -        $start_time = Get-Date
> -
> -        del -Force -ErrorAction SilentlyContinue C:\tools\msys64\etc\mtab
> -        del -Force -ErrorAction SilentlyContinue C:\tools\msys64\dev\fd
> -        del -Force -ErrorAction SilentlyContinue C:\tools\msys64\dev\stderr
> -        del -Force -ErrorAction SilentlyContinue C:\tools\msys64\dev\stdin
> -        del -Force -ErrorAction SilentlyContinue C:\tools\msys64\dev\stdout
> -        del -Force -Recurse -ErrorAction SilentlyContinue C:\tools\msys64\var\cache\pacman\pkg
> -        tar cf C:\tools\archive\msys64.tar -C C:\tools\ msys64
> -
> -        Write-Output "Package archive time taken: $((Get-Date).Subtract($start_time))"
> -        del -Force -Recurse -ErrorAction SilentlyContinue c:\tools\msys64
> -  install_script:
> -    - |
> -      $start_time = Get-Date
> -      cd C:\tools
> -      ls C:\tools\archive\msys64.tar
> -      tar xf C:\tools\archive\msys64.tar
> -      Write-Output "Extract msys2 time taken: $((Get-Date).Subtract($start_time))"
> -  script:
> -    - mkdir build
> -    - cd build
> -    - C:\tools\msys64\usr\bin\bash.exe -lc "../configure --python=python3
> -        --target-list-exclude=i386-softmmu,ppc64-softmmu,aarch64-softmmu,mips64-softmmu,mipsel-softmmu,sh4-softmmu"
> -    - C:\tools\msys64\usr\bin\bash.exe -lc "make -j8"
> -    - exit $LastExitCode
> -  test_script:
> -    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
> -    - exit $LastExitCode


