Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9E6C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 11:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHigD-0004I4-8J; Thu, 13 Jun 2024 07:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHigB-0004HX-CQ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 07:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHig8-0004fv-Oi
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 07:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718278299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sdXfzU3rp0jR7iL1KjWD04ixkIcrj7f69toywFEbqxI=;
 b=ZaJhresBrWbTdR9MFdnjRFjlC4M6SpjndJMcjRfD12x2Rd5tCDEzBPQFmMjawUa3nDUnm9
 ipu6rDcol1aS8bxoaEll9GBMjvt48OoXkWL1hHUmQOVztl3P9gUSdLAN8NmZHj1t9RqB/S
 88ApVi7tdYlIslrefTfQ7MFxB5wP/rA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-sSYLRhkqOTSzVS5-WJqS2w-1; Thu, 13 Jun 2024 07:31:38 -0400
X-MC-Unique: sSYLRhkqOTSzVS5-WJqS2w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6efbb08949so47030366b.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 04:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718278297; x=1718883097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdXfzU3rp0jR7iL1KjWD04ixkIcrj7f69toywFEbqxI=;
 b=VSLZAKeXix7KvnvpG0RcZFVQDlO+Ndl0taeJTSq9r3yEF7WVlNftwgCUA2Ih+dgOIG
 R5Zh8CRSdZuQjDalKRZHr2FhXW3fW3mOfySR0EwPi09pQVcHQWO7uvZZiB70mY+7w6Rp
 9cc0pj3A8/UXdlLy7W5JM36DxnWh20lavCn4YtfeOP+fwgF0fFgkNabayhX/7snXFIRj
 CHrOEEFgT85WaQuyacwF1HkqFCbsToI+QBbpYvJ0WWl0kgZUKnMJamUzvmkZatCtQF+H
 14nXRII/zpgJ7f7+gi55hQtLseUiltL3yhkBw5Tbu0pJ1o1jy9gH6vs9D16ue3rqWrqg
 iV7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSM51ccVBEYLFQSAWefQhJlZNAjwKN4wJ9IsC0dH3h83v+XLV2ulYxJ9xU/fulk7ucZDFfJBvhKtwtQYb+1GpC0SCdqoI=
X-Gm-Message-State: AOJu0YyY7RnTXWTZ2tcooO3j8G1tGoqGeyZGUGeQ6Mn7sDKlB8Kk3bKO
 EoxlzE/pGOyk0B1/Rj88gKUuzLt5T7i+eVsOsm9bqfIRNTTGrjIgb111hdr/HXkSnR5cgnCXOFl
 WdsfpnXkpjmES7rDfg82zSRh0Uu2D/8AtuAQHpFwtBA0VxxRg8T82
X-Received: by 2002:a17:906:2614:b0:a6f:57f1:cebe with SMTP id
 a640c23a62f3a-a6f57f1d187mr102704066b.5.1718278296973; 
 Thu, 13 Jun 2024 04:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2E12v/bpvrzw9ziq0leFw//QYgvGsB1X1B4vjdlbhQr7eM97g0XN+3s7qkAdX1b1x09f+hQ==
X-Received: by 2002:a17:906:2614:b0:a6f:57f1:cebe with SMTP id
 a640c23a62f3a-a6f57f1d187mr102702766b.5.1718278296552; 
 Thu, 13 Jun 2024 04:31:36 -0700 (PDT)
Received: from sgarzare-redhat ([147.229.117.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db5b98sm62257966b.86.2024.06.13.04.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:31:35 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:31:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Brad Smith <brad@comstyle.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 slp@redhat.com, 
 Igor Mammedov <imammedo@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>, 
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RESEND v7 10/12] hostmem: add a new memory backend based
 on POSIX shm_open()
Message-ID: <5hsea56r4ipq6t4ihktpasfeskv2lpxepp73234wsotn6oba4s@z7oc3unmum3r>
References: <20240612130140.63004-1-sgarzare@redhat.com>
 <20240612130140.63004-11-sgarzare@redhat.com>
 <87frtifgb3.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87frtifgb3.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 12, 2024 at 03:20:48PM GMT, Markus Armbruster wrote:
>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>> shm_open() creates and opens a new POSIX shared memory object.
>> A POSIX shared memory object allows creating memory backend with an
>> associated file descriptor that can be shared with external processes
>> (e.g. vhost-user).
>>
>> The new `memory-backend-shm` can be used as an alternative when
>> `memory-backend-memfd` is not available (Linux only), since shm_open()
>> should be provided by any POSIX-compliant operating system.
>>
>> This backend mimics memfd, allocating memory that is practically
>> anonymous. In theory shm_open() requires a name, but this is allocated
>> for a short time interval and shm_unlink() is called right after
>> shm_open(). After that, only fd is shared with external processes
>> (e.g., vhost-user) as if it were associated with anonymous memory.
>>
>> In the future we may also allow the user to specify the name to be
>> passed to shm_open(), but for now we keep the backend simple, mimicking
>> anonymous memory such as memfd.
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>[...]
>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 9b8f6a7ab5..94e4458288 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -601,8 +601,8 @@
>>  #
>>  # @share: if false, the memory is private to QEMU; if true, it is
>>  #     shared (default false for backends memory-backend-file and
>> -#     memory-backend-ram, true for backends memory-backend-epc and
>> -#     memory-backend-memfd)
>> +#     memory-backend-ram, true for backends memory-backend-epc,
>> +#     memory-backend-memfd, and memory-backend-shm)
>>  #
>>  # @reserve: if true, reserve swap space (or huge pages) if applicable
>>  #     (default: true) (since 6.1)
>> @@ -721,6 +721,22 @@
>>              '*hugetlbsize': 'size',
>>              '*seal': 'bool' } }
>>
>> +##
>> +# @MemoryBackendShmProperties:
>> +#
>> +# Properties for memory-backend-shm objects.
>> +#
>> +# Setting @share boolean option (defined in the base type) to false
>> +# will cause a failure during allocation because it is not
>> +# supported by this backend.
>
>This is QMP reference documentation.  "Failure during allocation" feels
>like unnecessary detail there.  Maybe "This memory backend support only
>shared memory, which is the default."

I'll fix in v8!

>
>> +#
>> +# Since: 9.1
>> +##
>> +{ 'struct': 'MemoryBackendShmProperties',
>> +  'base': 'MemoryBackendProperties',
>> +  'data': { },
>> +  'if': 'CONFIG_POSIX' }
>> +
>>  ##
>>  # @MemoryBackendEpcProperties:
>>  #
>> @@ -1049,6 +1065,8 @@
>>      { 'name': 'memory-backend-memfd',
>>        'if': 'CONFIG_LINUX' },
>>      'memory-backend-ram',
>> +    { 'name': 'memory-backend-shm',
>> +      'if': 'CONFIG_POSIX' },
>>      'pef-guest',
>>      { 'name': 'pr-manager-helper',
>>        'if': 'CONFIG_LINUX' },
>> @@ -1121,6 +1139,8 @@
>>        'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
>>                                        'if': 'CONFIG_LINUX' },
>>        'memory-backend-ram':         'MemoryBackendProperties',
>> +      'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
>> +                                      'if': 'CONFIG_POSIX' },
>>        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
>>                                        'if': 'CONFIG_LINUX' },
>>        'qtest':                      'QtestProperties',
>
>[...]
>
>Other than that, QAPI schema
>Acked-by: Markus Armbruster <armbru@redhat.com>
>

Thanks for the review!
Stefano


