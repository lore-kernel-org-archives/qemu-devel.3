Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC2DC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtSO-0006Bp-Ch; Tue, 30 Jan 2024 14:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtSM-00065r-5V
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:07:38 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtSE-0000xv-IH
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:07:37 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40ee9e21f89so38559775e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 11:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706641648; x=1707246448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wRUt/6PYgeqfnNQFVNGZSb/yBMsHyvjdJyc5d+vIz8g=;
 b=e9aaQ8foeK08mds7vHWTthrWJlovuYM5wZJXKGhOyvevjpfWiCL0petdJTN4sZGCjT
 8qzjTheDtw7eqwQD9M9ZESdMrXXWSzTAn0vjc+/rA5ALIMYfLI60B9TAuMW6h6xDg8GS
 MtnhS/k9JA7BboiWqsWw8xzjtLo5L73MBm9Hx0Ogl/7698gF9tR6U5+1Mty9p2UQhTEs
 ZT2RmeICfsxPmR1Tml4DdJzYZ/Pxb4r45CaHpaUIZYPDRUyktiVemdnRSP7kxJh02J/q
 DtbtcE0xJlrlvHFJnLac4vA9z0OltWypvfR9xVD0MW9xsyXD3M586llZaJnEYIOUx9/f
 ddjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706641648; x=1707246448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wRUt/6PYgeqfnNQFVNGZSb/yBMsHyvjdJyc5d+vIz8g=;
 b=qjfZJQ7ucAjcDWmmjXHb2L103mgxcmjon4iJhWniLXQzHg74PLIfTIAU8RqamTPVjl
 cUtNI659oVO9zAQy0iwChSBAL7rZ4nAYtn42Hi7TpebU2M9gyDydsB0/1+q54PUYOACu
 roiVNeBGR3LHRXAi2zWvIVVqkH2+vG2jDUQldJcrQUHC1I7T1Xew66HUtl8BdU3fyEkY
 jsrCP6tUjK7FqGffF9GsAHDosZ1k6XA+yPHcxZLaG4ojMLUS1C9L5xhxRTtTIDTXvuBz
 vpwH5rzUJE9cab+UBXC+g9Tb24td53m68bAkGD6Fi+KQXhR9Mz2X+SGxnuPEUKIApbux
 JxZw==
X-Gm-Message-State: AOJu0YwfkpB7Thzsy4enDnaOV7KSyZ8eFRuC/Ae6LctpkmaemNTgrmu4
 QtVLxMOevhuT/9c4HPFUFsIwnxVl4aS4s+poJWrX5rj2wRKl/q+VgBV3kYGSd60=
X-Google-Smtp-Source: AGHT+IFSca/1SAAEkLDJXeGjY8Wt8U5F7H21J4/A/nygTAuLlhnabrqbil/mNeWj+MnwYR8ctoaZQw==
X-Received: by 2002:a05:600c:4fc9:b0:40f:20e:bf7d with SMTP id
 o9-20020a05600c4fc900b0040f020ebf7dmr1884671wmq.22.1706641648632; 
 Tue, 30 Jan 2024 11:07:28 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 p37-20020a05600c1da500b0040eee4931c9sm10773286wms.48.2024.01.30.11.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 11:07:28 -0800 (PST)
Message-ID: <694417c4-b976-47f7-bc61-a84a48ead117@linaro.org>
Date: Tue, 30 Jan 2024 20:07:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pc: q35: Bump max_cpus to 1728 vcpus
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20240130164428.35955-1-anisinha@redhat.com>
 <ZbkoOAPo7gmFZw4g@redhat.com>
 <4CEF526A-5B22-41EA-8634-D4BB5871B739@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4CEF526A-5B22-41EA-8634-D4BB5871B739@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SCC_BODY_URI_ONLY=2.796, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 30/1/24 18:09, Ani Sinha wrote:
> 
> 
>> On 30-Jan-2024, at 22:17, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Tue, Jan 30, 2024 at 10:14:28PM +0530, Ani Sinha wrote:
>>> Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs")
>>> Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSMP is
>>> enabled in the kernel. QEMU has been tested to correctly boot a linux guest
>>> with 1728 vcpus both with edk2 and seabios firmwares. So bump up the max_cpus
>>> value for q35 machines versions 9 and newer to 1728. Q35 machines versions
>>> 8.2 and older continue to support 1024 maximum vcpus as before for
>>> compatibility.
>>
>> Where does the 1728 number come from ?
>>
>> Did something break at 1729, or did the test machine simply not
>> have sufficient resources to do practical larger tests ?
> 
> Actual limit currently is 1856 for EDK2. The HPE folks tested QEMU with edk2 and QEMU fails to boot beyond that limit.
> There are RH internal bugs tracking this and Gerd is working on it from RH side [1].
> 
> We would ultimately like to go to 8192 vcpus for SAP HANA but 1728 vcpus is our immediate target for now. If you want, I can resend the patch with 1856 since that is currently the tested limit.
> 
> 1. https://issues.redhat.com/browse/RHEL-22202
Out of curiosity has the limit to be multiple of 64?

