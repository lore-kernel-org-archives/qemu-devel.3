Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4764C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCyk5-0005a4-PP; Thu, 08 May 2025 06:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCyk4-0005Zd-94
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:44:40 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCyk2-0007NR-Hi
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:44:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73972a54919so830416b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746701076; x=1747305876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nr0dZBTNg1HHRf8UF/Ze0682FGxfLX/EeV66P0o4n6k=;
 b=Fvy/JmUxs0itVisrrXwskRxl9gjFtsa2mP6QvvAtzS0/uHZ+F7ZrDH+Na3/FqPy90F
 zV04tf2grsGHZB/+DzXOSUhpIm5HGGAF0OCzhB+uxnl2a3jqKOcRGTBRqboThVgSYoiX
 RytsqjYS8VJvuiQ49zoYANwxRuUSQwBISOcFTieeDLxNKgeWQW7KqGefKAYDBc3kyn6L
 5uOWLDTm4dnlbNzIjfURwxyKtcRGz90n53ez1OLZZ+//XZse2438wjQZIu/RI4lYfjI4
 3ELnN/caBIw6UyYoz94LK4feoDWcHOAPfWzqSlcucmyjnpaa4FYUBXe+8n/cGou47fgJ
 i86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746701076; x=1747305876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nr0dZBTNg1HHRf8UF/Ze0682FGxfLX/EeV66P0o4n6k=;
 b=AYvje7CCU1DTEhhM9BeB9JleiA4+FCMwGR5IVIfxyiqAzaSA7U/kSnPuY83I0Fv70X
 artiFbBgef5JqfMOwScVlJWv8J2yepiGueUOIABsgoy1mvF5O4GkATem2ZRRJuvrEGFm
 jSKu0I7MAogajT4Kuh2abbmsInWy+9R/dlQA/2uhv+6J0g+FI+vAMF9wQX1XSOs4JdmS
 +6mm35yRS4U5/tjMyY0H57BHvOBnor+uRQNN/PQPOyZeIDP8c1z9VSsXuVkVpS8z+Djw
 1VnihBuX4OmmseRWk0LyBtDZJYpSrCy9akjnHLdg30x20W1ekADUer2o7NQxTVj0I84m
 kWZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWgLsskY0iMW15WWfxr+2YAo698KKehqGeC/whU+OOArVbKVyjk6DfDak0OPzOskC6uFtdCZK03G1Z@nongnu.org
X-Gm-Message-State: AOJu0YyyFKU53zPXvi9xIVgzkyh/HQ2Ig4WQJQw5Zv1zFjXWDz8+uWmt
 HifVtAbP/+gPefqBmVVsH39/+Edde0HkYhcZ/v49UdiuAmUxywVMiq6lehpzJZ0=
X-Gm-Gg: ASbGncsHJgsWeuBcFn/FbfjOc1NbF1+gg9mKmgZatQuJrkmbqglp/8ti6IvJJ1X8CWG
 +zZ9DwlyFg6ydNpDg8VLageSes0UxN0GlFPlZiKbKTkVnRyaOTPpAnWaYEpkUSBKp+i/TpfzfJz
 SdI3XhG2909XU6PTKls92MpFK9HEqFKYUu27O5qnnFuJNMi8Pbur2VZEp/buj/S8iTEIoJh3m9+
 HJ1EFkiY0txCDBHoDxmKN3PsblahRMMZkbqAr5CSipI6yQwi+aWdBayk4GcjC5w7r9gpYeZjJN2
 UIqM1HZT6dBgnTVdeVTgzLDfPJubT+eEggOJEw1bM0zkE65hHXJDU0vqV88ha8joGybutCsA/PY
 I88KA1Mjb
X-Google-Smtp-Source: AGHT+IHwT2bEvRbwl4ZiLyjx6MyTXyGekS352uetBFoygnI/2JYhoSa/dwa8bTSxRLZtKg1yzWCyqw==
X-Received: by 2002:a05:6a00:a90f:b0:730:95a6:375f with SMTP id
 d2e1a72fcca58-740a9979bf9mr4853343b3a.3.1746701076579; 
 Thu, 08 May 2025 03:44:36 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7adc9sm12971867b3a.30.2025.05.08.03.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 03:44:36 -0700 (PDT)
Message-ID: <8b414a4f-cc17-4387-b692-ab717e0bbdec@linaro.org>
Date: Thu, 8 May 2025 12:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/6] qmp: add QMP command x-query-virtio-status
To: Markus Armbruster <armbru@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 mst@redhat.com, qemu_oss@crudebyte.com, kraxel@redhat.com,
 si-wei.liu@oracle.com, joao.m.martins@oracle.com, eblake@redhat.com,
 qemu-block@nongnu.org, david@redhat.com, arei.gonglei@huawei.com,
 marcandre.lureau@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 michael.roth@amd.com, groug@kaod.org, dgilbert@redhat.com,
 eric.auger@redhat.com, stefanha@redhat.com, boris.ostrovsky@oracle.com,
 kwolf@redhat.com, mathieu.poirier@linaro.org, raphael.norwitz@nutanix.com,
 pbonzini@redhat.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <1660220684-24909-1-git-send-email-jonah.palmer@oracle.com>
 <1660220684-24909-3-git-send-email-jonah.palmer@oracle.com>
 <7de79c4d-57f2-4103-a22e-748cfbe08974@linaro.org>
 <87tt5vh75c.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87tt5vh75c.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/25 09:51, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> [...]
> 
>> When a structure is only used by an unstable command, is it considered
>> unstable too? IOW is it OK to modify it?
> 
> Yes.
> 
> docs/devel/qapi-code-gen.rst:
> 
>      Special features
>      ~~~~~~~~~~~~~~~~
> 
>      [...]
> 
>      Feature "unstable" marks a command, event, enum value, or struct
>      member as unstable.  It is not supported elsewhere so far.  Interfaces
>      so marked may be withdrawn or changed incompatibly in future releases.
> 
> We support "unstable" exactly where we need it to mark parts of the
> external interface unstable:
> 
> * Commands and events, because these *are* the external interface.
> 
> * Struct members, because they can be arguments / results of commands /
>    events.
> 
> * Enum values, because these can be values of arguments / results.
> 
> * Not types.  Not needed, and would enable inconsistencies, like stable
>    member with an unstable type.
> 
> Questions?

None, thank you!

