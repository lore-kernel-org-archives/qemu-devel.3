Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32D0EF48F3
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 08:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqoyJ-00021X-JV; Fri, 13 Feb 2026 03:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqoyH-00021N-OY
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 03:56:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqoyG-00042b-7u
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 03:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770972975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiANOVSbt8s2JSf6gaHdz1L+8o/uK5+HG1uEe0aPNLU=;
 b=I/IINvpeYYdEmpGvAJmgk2pv7WxZslzGfw4M//QhlM/QPM2DYjKifE07EN2B/trkoxvFfm
 oQuCFBhoFJNgXH4j27GfMnGcZ5npmyEFGthOkx9dsEOrvIfbLuslMl4vOrx6ZIh9Eh2drL
 yEyxJNdRM/qKM2iGG/V+K3tN47uTg7U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-yWxqeS81M-6Aov1QtuIp1A-1; Fri, 13 Feb 2026 03:56:11 -0500
X-MC-Unique: yWxqeS81M-6Aov1QtuIp1A-1
X-Mimecast-MFC-AGG-ID: yWxqeS81M-6Aov1QtuIp1A_1770972971
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836bf1a920so10609175e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 00:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770972971; x=1771577771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KiANOVSbt8s2JSf6gaHdz1L+8o/uK5+HG1uEe0aPNLU=;
 b=RlDO0nqOBGFQj6EmW9jYqaIdwH4H9j9VBW5q0nwOXhTz42EOmNqZUJt89hsU9tFbFk
 ODvhgRwt2vybFEw0sQZOjhQ4lBYuOvq7QwDcQuQZuhVE9zgf8uNTOUmuXYVp9WAZ4P7l
 Rst1qL3e2NgX2uBxuVmT3AP+1ud6vP0qeOljOsRVCNYqByelGQVzMSTJxzSvJXkdndu8
 82RkOe2/fcUBS9bt1d3wfRXdKRWJjT3Lims5PPtudFKYRXQjOX1suumfgutIc06pjVb3
 FLgq0A9WHRWr6/tgxR2dqsjnNc2dJNKDrThUmE9g5EHSC/aqpqB6YHHigyw+VyU30Vmc
 uv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770972971; x=1771577771;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KiANOVSbt8s2JSf6gaHdz1L+8o/uK5+HG1uEe0aPNLU=;
 b=pQIfIMmeOIlrjMo9nzggtEHChihKGdZ+4uEU/rbtoChABTWMFFcirZ2vzTN7ui5yKl
 5XHoJvq2dIeMkXnTlIeNSjMUpOw4PNi7klWnmOY8UFep67awgYMocv42qMkd00AFwPbM
 hvmykW0aom6p3DbMBdJMeCGSIBdHNnwtIccUPnCVYRSDxkL+r2zcWhWAadIdztqB1tLm
 IWsLVZ4QX5js8QE/Kj8nknwy4R94JWgEuVfcuB3fGIIMMdGEB4JpbyUA2TFRZvKxa9GW
 AtKvOO3em41f92HqsLiO8ZCzYLYN3rO3jN6Jp2yXmdkp7lpjn5AycYwadgmdGJMo0LRx
 N5xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Sx+NFa97Fxt8q997mGc9M1dJE+/lB9VudlIlkGa/MtSdKc0ARCvH6ebYuoR/ZwTWrRQ6VZoUISUb@nongnu.org
X-Gm-Message-State: AOJu0YxSBcus3JENQ2cgGaxhcZRZspYpRjcq5mYhqx6yVef2mOnn/+gu
 56SMOkklvN2gI8jqx3TpvxtntZ8S+1aGSqcvBuDGKE0WOwhr+DNemSHn9luvbekXGXiCQClLhOa
 gn6HDg16cJTjOEJqiQkHLa50Da1s/x7lHqw5BjV4qCjo4AT2hLOo2UEho
X-Gm-Gg: AZuq6aKr2CuGi94yJAqdd//7YCPhocrUTinjb1ByQZQLck8XJUUgn8ENYu5MztYimKZ
 ywiZ0UjWfASoHf+I2GqzJnAjfbqLgpojDRlCMFWpKF9fzHS2iMJPEDmXg6/3ECnHl59NCj5hG2g
 uRcXYSVlEOjC72HtpQfriJWzeWYFnRnjXKKa96DVPJJReuec1VYpdq4+rq9SoLXpGkvqIKohZJv
 V9aM3XeQ0tUgFwWchOrAH7DSun3GRgsAwspaIEG6wdKs1nLhYShKsilZNjNwsdsGQVF9jigaVaO
 J+/ISyBUa7WSLWtuR5UH53nzsdWtjOMnOcSorkC/njf8v6WCaMeBlfsd/x6GclDeb93AF1N1Je2
 gUneZ+3wckh+sg2VLvMg+fz/YqOqJrEkRKA3zBjeI/mEDjwGBIkS96xNQ7Z719i1NbbKPSub2XW
 fjOf6xOW6kDbBIH7PZZIto/OeENg==
X-Received: by 2002:a05:600c:8b28:b0:483:6d42:25c6 with SMTP id
 5b1f17b1804b1-48373a63174mr16409655e9.23.1770972970607; 
 Fri, 13 Feb 2026 00:56:10 -0800 (PST)
X-Received: by 2002:a05:600c:8b28:b0:483:6d42:25c6 with SMTP id
 5b1f17b1804b1-48373a63174mr16409255e9.23.1770972970193; 
 Fri, 13 Feb 2026 00:56:10 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48371a2d55esm16845185e9.8.2026.02.13.00.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 00:56:07 -0800 (PST)
Message-ID: <a35ed04e-1fcb-45cd-b235-3994beddff15@redhat.com>
Date: Fri, 13 Feb 2026 09:56:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/31] hw/accel: add a per-accelerator callback to
 change VM accelerator handle
To: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
 <20260212062522.99565-4-anisinha@redhat.com>
 <0d4b92f6-1220-4301-bf38-6b15e910aa47@linaro.org>
 <EAFC646D-DA07-4C09-BA33-2153799F882B@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <EAFC646D-DA07-4C09-BA33-2153799F882B@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/13/26 06:24, Ani Sinha wrote:
> 
> 
>> On 12 Feb 2026, at 10:23 PM, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Ani,
>>
>> On 12/2/26 07:24, Ani Sinha wrote:
>>> When a confidential virtual machine is reset, a new guest context in the
>>> accelerator must be generated post reset. Therefore, the old accelerator guest
>>> file handle must be closed and a new one created. To this end, a per-accelerator
>>> callback, "reset_vmfd" is introduced that would get called when a confidential
>>> guest is reset. Subsequent patches will introduce specific implementation of
>>> this callback for KVM accelerator.
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>>   include/accel/accel-ops.h |  1 +
>>>   system/runstate.c         | 37 ++++++++++++++++++++++++++++++++++++-
>>>   2 files changed, 37 insertions(+), 1 deletion(-)
>>> diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
>>> index 23a8c246e1..998a95ca69 100644
>>> --- a/include/accel/accel-ops.h
>>> +++ b/include/accel/accel-ops.h
>>> @@ -23,6 +23,7 @@ struct AccelClass {
>>>       AccelOpsClass *ops;
>>>         int (*init_machine)(AccelState *as, MachineState *ms);
>>> +    int (*reset_vmfd)(MachineState *ms);
>>
>> So far 'vmfd' is a KVM concept. Can we use a more generic name?

For what it's worth, mshv and nvmm also have it (whpx has a handle 
because it's Windows, hvf probably has a file descriptor internally but 
only exposes a single VM per process).

> This is more like a hypervisor interface to manage the VM. For example, for Xen it would be what xc_interface_open() would return.
> So I can rename it to something like “reset_hypervisor_interface”.
Or rebuild_vm perhaps?  It can also be done on applying, since it's an 
easy mass change on the .patch files themselves.

Paolo


