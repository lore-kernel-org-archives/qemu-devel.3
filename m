Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AAACFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 09:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxjlb-0007r9-9R; Mon, 07 Oct 2024 05:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxjlQ-0007ql-CW
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxjlC-000214-K8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 05:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728292229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rLUyzqGqvRyzBZFL6MGHa7KKyIvyu/b03D9B/AJJqy8=;
 b=GG4II1vdu1M/CpxNJVdi1JmDHAC6TcMWEeHU5o0XuIjomsx9ff6Og3Yuw2HkA9gU+PmC+i
 fuiFIkZA3SzV5O5wCtAZr1pI45kgke2qkfgq2UHFu/3C/RJtDGmAaAFIqcD3OQTB4cqxOR
 Rrx4s5L7InUMJ50RHV4joscSMGFeGVY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-dG3P3GTMPaOMshS-XhcCKg-1; Mon, 07 Oct 2024 05:10:27 -0400
X-MC-Unique: dG3P3GTMPaOMshS-XhcCKg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7ae5c5ba98bso706573885a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 02:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728292226; x=1728897026;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLUyzqGqvRyzBZFL6MGHa7KKyIvyu/b03D9B/AJJqy8=;
 b=h/MirWvX3cS3KuVy1UAB2GIqzZgu44YwGTT0qml5irovhY3J8Veyg3FK42xQf8tKIM
 sFbvXF0e1QoYDjaNJrDkAB++PprWPQqO4AArmJ05PtU+GDFeLd5yS5/5PTE2Y+dwDemz
 xiq/+B2w+BazXkI2kqb+GDqdiEG5Wjp7aujwtUUcQMXkj5koD2L0V3Wr2kHiJwLKdN5p
 parm6dWFJ1+dn9ojjvI1JUJP27GZ+jPRrOBWSrbJH18ia3PRNIe7RJ9U+w+mrD7YRpdN
 yVnwzgsdu23NhqyvHdfTv3Ig47Icc4r/3b6HpaxdKpTE4Hb41UYQiWuKuoG4spnGeewg
 5xYg==
X-Gm-Message-State: AOJu0YxNY6wH5ZktNHFlzE3Fe+8vRv78mHWxGCr3MJ5AiAUP4CZ9MLka
 /Wjg1a07MVNR40szvPdfo7xhDpB8uRLWbNokGUTZCS3x850vrbpyW3YzDM6X9J3DmT4WVRVbGbb
 zWkyCvVL/1OEkcAZag9IeNbaE1to+4CTj6GFSF2wAChgezPYm5jDV
X-Received: by 2002:a05:620a:4002:b0:7a6:6447:19ab with SMTP id
 af79cd13be357-7ae6f48813dmr1937258285a.46.1728292226547; 
 Mon, 07 Oct 2024 02:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHBFUBvVDAdGlgwu7I512Tf3Tb1sngymlKyHIzyFp58y1n+61dOW3t8Avfj67qZVq5kPn4kA==
X-Received: by 2002:a05:620a:4002:b0:7a6:6447:19ab with SMTP id
 af79cd13be357-7ae6f48813dmr1937255985a.46.1728292226128; 
 Mon, 07 Oct 2024 02:10:26 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7563736esm236180985a.67.2024.10.07.02.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 02:10:25 -0700 (PDT)
Message-ID: <d2d5706c-882c-4643-bda7-c820fb2a42d5@redhat.com>
Date: Mon, 7 Oct 2024 11:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] .gitlab-ci.d/cirrus: Add manual testing of macOS 15
 (Sequoia)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240917085058.1740-1-philmd@linaro.org>
 <20240917085058.1740-4-philmd@linaro.org> <Zul7dIheGE03MtgQ@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Zul7dIheGE03MtgQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 17/09/2024 14.52, Daniel P. Berrangé wrote:
> On Tue, Sep 17, 2024 at 10:50:58AM +0200, Philippe Mathieu-Daudé wrote:
>> Upgrade libvirt-ci so it covers macOS 15. Add a manual entry
>> (QEMU_JOB_OPTIONAL: 1) to test on Sequoia release. Refresh the
>> lci-tool generated files.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Pending libvirt-ci MR 501: https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/501
>>
>> CI job: https://gitlab.com/philmd/qemu/-/jobs/7841560032
>> ---
>>   .gitlab-ci.d/cirrus.yml           | 17 +++++++++++++++++
>>   .gitlab-ci.d/cirrus/macos-15.vars | 16 ++++++++++++++++
>>   tests/lcitool/libvirt-ci          |  2 +-
>>   tests/lcitool/refresh             |  1 +
>>   4 files changed, 35 insertions(+), 1 deletion(-)
>>   create mode 100644 .gitlab-ci.d/cirrus/macos-15.vars
>>
>> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
>> index f061687f1b..b84b42cce5 100644
>> --- a/.gitlab-ci.d/cirrus.yml
>> +++ b/.gitlab-ci.d/cirrus.yml
>> @@ -66,6 +66,22 @@ aarch64-macos-14-base-build:
>>       NAME: macos-14
>>       CIRRUS_VM_INSTANCE_TYPE: macos_instance
>>       CIRRUS_VM_IMAGE_SELECTOR: image
>> +    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest
> 
> Something isn't right here - the existing 14 release is "sonoma", "ventura"
> was 13 IIUC which you just removed
> 
>> +    CIRRUS_VM_CPUS: 12
>> +    CIRRUS_VM_RAM: 24G
>> +    UPDATE_COMMAND: brew update
>> +    INSTALL_COMMAND: brew install
>> +    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
>> +    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
>> +    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu
>> +    TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
>> +
>> +aarch64-macos-15-base-build:
>> +  extends: .cirrus_build_job
>> +  variables:
>> +    NAME: macos-15
>> +    CIRRUS_VM_INSTANCE_TYPE: macos_instance
>> +    CIRRUS_VM_IMAGE_SELECTOR: image
>>       CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
> 
> And this should be sequoia
> 
> I think the info we've committed to libvirt-ci is probably wrong.

FYI, I'm going to queue this patch with the update to the fixed libvirt-ci 
commit and this patch on top:

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -66,7 +66,7 @@ aarch64-macos-14-base-build:
      NAME: macos-14
      CIRRUS_VM_INSTANCE_TYPE: macos_instance
      CIRRUS_VM_IMAGE_SELECTOR: image
-    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest
+    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
      CIRRUS_VM_CPUS: 12
      CIRRUS_VM_RAM: 24G
      UPDATE_COMMAND: brew update
@@ -82,7 +82,7 @@ aarch64-macos-15-base-build:
      NAME: macos-15
      CIRRUS_VM_INSTANCE_TYPE: macos_instance
      CIRRUS_VM_IMAGE_SELECTOR: image
-    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
+    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sequoia-base:latest
      CIRRUS_VM_CPUS: 12
      CIRRUS_VM_RAM: 24G
      UPDATE_COMMAND: brew update

  Thomas


