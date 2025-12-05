Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5ECD2E00B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRPU8-00019u-Uf; Fri, 05 Dec 2025 01:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRPU7-00019k-HL
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:40:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRPU6-0003In-1R
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764916804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G1Eyt+jxeZEB3siSg+zX9M1BypcnaUdA14Q+5ZrJlSE=;
 b=U6D7a2PCnuGqLuxpyYPmrKU788pOmQiYfOxemEWDIMYvnvhDqekfPGLfM9zDovDimYU1b3
 19K0k8p3YzHET2xGEELOgcWgG5Z/x1pcVSiBsOtCqEufcYJEqU23kvrA58uvlRck9zGEXG
 TKJZ/5GO2awCTyTEytkgDv/Q7eVJP24=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-_ubb3HvlOmyJlZkqJjbcaQ-1; Fri, 05 Dec 2025 01:40:03 -0500
X-MC-Unique: _ubb3HvlOmyJlZkqJjbcaQ-1
X-Mimecast-MFC-AGG-ID: _ubb3HvlOmyJlZkqJjbcaQ_1764916802
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b3086a055so1727478f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 22:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764916802; x=1765521602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=G1Eyt+jxeZEB3siSg+zX9M1BypcnaUdA14Q+5ZrJlSE=;
 b=KCyZhBB1AuaxL03KTBwTazCpnqxB93hkz+gz1cKrD4OuHq91n7C1m9WrfDCJZD+c3A
 oget0hdREC3SmoPeNxjx1ODHY61C+SJgCLvLHBHIZfO1N64jdwPmFeCgk9zOgmetJHMN
 Bsxy3Ddu34qENICFlXZGweOYVl8bDT78dkuhE9IavMTGIEkPf/517gkLuDoiW9xRo65l
 euhoU/ZxoP5t65/8Kuwvoy9nGqxRY45TFWGD3Cs3k9pVkRGufHKq/cfar2gZNLN00wrm
 bNTXPa9BFWMikeyc6J3anErAjrEgQai8/wdB3aQzhPZKgGg0VC4WapyOxw3wVLT469AQ
 t3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764916802; x=1765521602;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1Eyt+jxeZEB3siSg+zX9M1BypcnaUdA14Q+5ZrJlSE=;
 b=a85DUzocH7+qeBqEARrLOgE79Lc8nt/IRDosxjCnSDWTCzKZl6Js22RJ7YhIpiqK+l
 Vi6nx0/sClSYfUjn1iYp6yfrbkWg76sNvS7n8z7HSX8p5VC6cp2sDtrcaENM8s4wOJQ8
 Ko/Pr2+wArAottZ6LrAIhwh60VET/XSjRnzWb3rV/4D1+JyrqiZHYD+4fmOeM6lIS6Vg
 45OY1wUafm0iGDRusNhLR2IeiqWJ1mNndiV5Ssij3R/1/EP1cj2cZcJFjCq+Fm/4fueK
 Y8ZqNgwR2iLz6xqiVp56Ko561VTsk/5QP94nxrI3G66vfXfwnjCn2mQWut5khsQ7AOyQ
 lzHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBmIp5XLKYPL6+TSu0J9rftTH8eR6qlIaiv8LIkoqCZULJ+IsV6E6P+S6ORjCq0Zi9KfqgoYUlA2Mx@nongnu.org
X-Gm-Message-State: AOJu0Yx3HhsxdmxuWro6TR1AtK1IuUF6aZvR+xW/SHAYsjOZ8UxAgxrt
 yoMLq1LFhgfcw9uItQv9PDX6EU49JuQ3QuOuIGPauB4xjhCTxgmhowqSFwTLYxyOcsc/KfCEd7E
 fMeRypQ1huNfNWQteq/eYlVsvMSg0qGnmr5jf9NYTaY2A0igwWD7dv8zX
X-Gm-Gg: ASbGncszTgTtLi+DR910Fqd+ajvIouw1/gUgzgUJkV30CjKMu+XCUEmpZqSgeiCFPaT
 Fa5QC/d9S65ZTq7alG3+cZoBDMtOUvMXXkpcbuijoJacXh+q5z+fcbzBEMXbVdh3ycazqUjYULR
 wdheIQkAlkN5Mr0x8w7FnWM5BC2jOWcavIJsyon+7lGvQ33MDAYKwoZkv31GG168VZIM7gYRiYq
 Cw0mQ0XPUoWNcfBQwDQzRfurr5H3VfhtCTE7Ji+hNRN0RjfZ0S3xbxFHUIOX70Me1Nu50xw9blx
 ILhWDzC3N1z9afBrwK+pXVl6GllkiWG8SRcYlpu3JQetQ3IJoTdAFkMtAi4LXsqWa32MyxsjXWP
 UuSPznNk=
X-Received: by 2002:a05:6000:2893:b0:42f:7601:899c with SMTP id
 ffacd0b85a97d-42f7985e948mr5287382f8f.50.1764916802312; 
 Thu, 04 Dec 2025 22:40:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFODdl9aDGwsd4XUVBYHwmMmgXDbEk6P/50pzAiGhEE6u1yBWJVeP/Mbn4p4GLM91UgzQN1Dg==
X-Received: by 2002:a05:6000:2893:b0:42f:7601:899c with SMTP id
 ffacd0b85a97d-42f7985e948mr5287362f8f.50.1764916801880; 
 Thu, 04 Dec 2025 22:40:01 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe9065sm6997007f8f.8.2025.12.04.22.40.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 22:40:01 -0800 (PST)
Message-ID: <030652dc-915e-497b-a346-49ea9a820321@redhat.com>
Date: Fri, 5 Dec 2025 07:40:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] tests/docker: drop --disable-[tools|system] from
 all-test-cross
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
 <20251204194902.1340008-8-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251204194902.1340008-8-alex.bennee@linaro.org>
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

On 04/12/2025 20.48, Alex Bennée wrote:
> We use this container to build system images in CI which do not honour
> QEMU_CONFIGURE_OPTS. Drop the --disables from the container so
> developers don not need to jump through hoops trying to replicate that
> on their workstations.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-all-test-cross.docker | 2 +-
>   tests/lcitool/refresh                                 | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
> index 1b01cfe8504..04d424c1a0d 100644
> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -90,7 +90,7 @@ DEBIAN_FRONTEND=noninteractive eatmydata \
>   apt install -y --no-install-recommends \
>   ${AVAILABLE_COMPILERS} && \
>   dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
> -ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
> +ENV QEMU_CONFIGURE_OPTS --disable-docs
>   ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user
>   # As a final step configure the user (if env is defined)
>   ARG USER
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index c5e936112c6..9df607a55f8 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -197,7 +197,7 @@ debian_all_test_cross_compilers = [
>       "apt install -y --no-install-recommends \\\n",
>       "${AVAILABLE_COMPILERS} && \\\n",
>       "dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt\n",
> -    "ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools\n",
> +    "ENV QEMU_CONFIGURE_OPTS --disable-docs\n",
>       "ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user\n",
>   ]
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


