Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5254CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvyxG-0006xJ-FE; Tue, 09 Sep 2025 10:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvyxC-0006wV-JV
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvyx6-0006TN-QC
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757426643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R9ngnzdsjun91a4UfHkP4l3LzYvtabB+kxVXDrYmjTM=;
 b=Cg6GUBI91qTE0fFD/NmQUdQsVNszsX01FBz/CY2URaD8YiUKeC6+ZXnsUiBK4/m3/2LGyL
 hEX+65ek8YUIxH08TyLQQlHLxLPr5CgsoDvvR2KXbNZPRO+s9jyTnyG62BUX4yQNCMm/c5
 S9dPc+zDX981bJ+yYRyLwnmN5iH6bT8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-bAvZ7eyHPROWI8cUrxLbtA-1; Tue, 09 Sep 2025 10:04:01 -0400
X-MC-Unique: bAvZ7eyHPROWI8cUrxLbtA-1
X-Mimecast-MFC-AGG-ID: bAvZ7eyHPROWI8cUrxLbtA_1757426640
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e753e78902so322249f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 07:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757426640; x=1758031440;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9ngnzdsjun91a4UfHkP4l3LzYvtabB+kxVXDrYmjTM=;
 b=ke7l58Jv0ikCFr93rsCtos8q5QuHkrER5xBYMMNNuP57I7uL2Wlw2ptSPzBxsKQcdH
 LDgoZKiCiVk79CeiQ9QdgouYbYi9E/1TAbGsjD/oVxsL5c5pFRCzv6GbSJY5sCZb53so
 VRD67HxIsDdXWVbaK04X60lZzaKmqgK5AWl9UBcFAd3+RmYoovjjpAxDUIySXTJzOzj7
 V/D5PMxkF0bgvQNUaA9QmcP6HiWdZ0i1ywdbHW8Qdq8weD/3IAifcVcVt5JgbItK1FMS
 eCOTLkxE3KffHAbGJ2g8wHK7YEykUp4W8jEBM+ArjfZRXrexk2kFGS6z9+2+IxfNd8dQ
 JJ2Q==
X-Gm-Message-State: AOJu0Yz02tAexoUu/LTMIdnostZEhyGEyCqfSXAaPwAyeEW1j270Ez41
 ga2k9UqpcamrB6pphpOEP5M6+yozF4Vt/36GLkAETECIgqjf0bibvYGVdwwq+A4cSx+b0SAFAop
 6L56jfnpDZ1MdUM8Gj2AJLXvRQUSPmSJ7Tviml0QKGuPGd/4wbRuRhotV
X-Gm-Gg: ASbGnctxdeaO/8xGCOtfNcUqAv1fan8cDM7xA66VfKt0VUB78D3kCvUVWgaIB+XM0UR
 6rW4OwdifzZ/Y+XOzUqoQWX6b7r+4gZCwNhEjwUMOgbfm2y5wEi2RR6uVkDvPgXZM1cUWhEISor
 NAETv0Ld5PsHikY+5q0v77DuQ/gQOlFloJrXyLDjbAWI7dbHNe3s9r3NXd1POjTuEY72OfK1vs3
 MfmBpUEhF1Jjxg/6CsLD4qPdsw6pr5U0bonKic+DTuqk9geA7vOm8hhLN0q3a2ypl+mZCgZTu7q
 KCspu9gAgG0pbCv7MTh8nzbPuH1x+M/77ZcYqHBPqbXiO+F1xIRhQZaexqO7HjVGF4MFchOTrWW
 qnQPj9w==
X-Received: by 2002:a05:6000:22c3:b0:3de:78c8:11fc with SMTP id
 ffacd0b85a97d-3e6497c0668mr10308352f8f.63.1757426639617; 
 Tue, 09 Sep 2025 07:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0valpWlqaryySuF6aVEZlmHGbbGXHNvaXyVAEqLQD43zFQwW6vAeQ0TTuIyxZ7sR37rdy7g==
X-Received: by 2002:a05:6000:22c3:b0:3de:78c8:11fc with SMTP id
 ffacd0b85a97d-3e6497c0668mr10308316f8f.63.1757426639112; 
 Tue, 09 Sep 2025 07:03:59 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e752238851sm2717310f8f.29.2025.09.09.07.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 07:03:58 -0700 (PDT)
Message-ID: <91a01e52-4ede-4317-b7ef-fc555d3e6825@redhat.com>
Date: Tue, 9 Sep 2025 16:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] tests/functional:
 exec_command_and_wait_for_pattern: add vm arg
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com,
 yc-core@yandex-team.ru, peterx@redhat.com, mst@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, philmd@linaro.org, berrange@redhat.com
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-8-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250905135039.2202924-8-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 05/09/2025 15.50, Vladimir Sementsov-Ogievskiy wrote:
> Allow to specify non default vm for the command.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/cmd.py | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index dc5f422b77..28b36a3a54 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -172,7 +172,8 @@ def exec_command(test, command):
>       _console_interaction(test, None, None, command + '\r')
>   
>   def exec_command_and_wait_for_pattern(test, command,
> -                                      success_message, failure_message=None):
> +                                      success_message, failure_message=None,
> +                                      vm=None):
>       """
>       Send a command to a console (appending CRLF characters), then wait
>       for success_message to appear on the console, while logging the.
> @@ -184,9 +185,11 @@ def exec_command_and_wait_for_pattern(test, command,
>       :param command: the command to send
>       :param success_message: if this message appears, test succeeds
>       :param failure_message: if this message appears, test fails
> +    :param vm: the VM to use (defaults to test.vm if None)
>       """
>       assert success_message
> -    _console_interaction(test, success_message, failure_message, command + '\r')
> +    _console_interaction(test, success_message, failure_message, command + '\r',
> +                         vm=vm)

  Hi,

FYI, there was another patch on the list that does something very similar, 
and I picked it for my pull request today (since it fixed some more spots):

  https://lore.kernel.org/qemu-devel/20250909135147.612345-20-thuth@redhat.com/

... so once that got merged, you can likely drop this patch from your series.

  Regards,
   Thomas


