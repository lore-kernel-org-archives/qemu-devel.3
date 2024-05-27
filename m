Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8107AC25B7E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcNq-000263-Uo; Mon, 27 May 2024 11:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBcNo-00025I-RU
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBcNf-0003GA-8M
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716824121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6H5AjAejZLjqK038mZtyyNtif1gRxmmZdXt0xXnlTbs=;
 b=XBdfP00VJO6ryCJGUgl0ZgXf0Hb84JvsOeGDNQW2VJ2aArAiJayT0reTArUasIm59eQ7WI
 Vm51NrNy/Lz84ZdXhu81is2wgkk5sqY5gBX6WSDDCHQXDSVA9uPveJ6Maoe2s7H7C9Itwo
 zHUDBripvq7JBY3CwDUOpHw/XJUX37k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-mB59xxWaOtyn9vNmhXnGGQ-1; Mon, 27 May 2024 11:35:20 -0400
X-MC-Unique: mB59xxWaOtyn9vNmhXnGGQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a62e7631309so100689166b.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 08:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716824119; x=1717428919;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6H5AjAejZLjqK038mZtyyNtif1gRxmmZdXt0xXnlTbs=;
 b=VZiUX1QbgkJtmaKRMU585F5kBNRrNcqbppCA1892Xy/P0gHGrLdU59ZZYfOj7NnOKM
 pVNtcQOQzEyJTP8w2arFCZgZjCtmkQA0eU1FePhrOdjLr+gap8FgC7G61KAzajuC+A+H
 jSppMrvGCqOvPRl2z7lF9pWSjevV4y7ko3M+tu80PHMadkG8XcWlRQpG6KI9xe6C4i2K
 QANdwaxk2n5N18cF5Y//1NpdHtH+KqN+i4xsRJnVEmy1JaWkFVKn0fd05oBEDOpcTgjR
 TeVsVIj6C0mEO7zoW4ixpduffekyOjBxshgNv5cm9dFLZeUbIL/kiDkoQJWP5cXqPsxO
 +Qzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCDMboFnJk8oShRRAtcm4b/sibxHPvVROZiG0LnJ1cDfql+MbaUp9+VWENZCzswOSL9PKLcATTmWjvIL7p6fYXDpNNPuM=
X-Gm-Message-State: AOJu0YyP6/Bj77CE4PLu+90621VGEDknSnBSj2SCAHwDEdjA3m1Y6xIy
 sChEAegOSDmGBK9FaajYGBnvMOBaratAYmk4a5B6/IfA+FBHyibfm9QdLRw+J0mAB0zIonoA5Ql
 QvXQJ6PedoHKol5+Akw0f6SYURsm4sKcfm9I0c/NO1Hoftb/vTnHX
X-Received: by 2002:a17:906:b56:b0:a55:5520:f43f with SMTP id
 a640c23a62f3a-a623e8d98cbmr1061451066b.10.1716824118966; 
 Mon, 27 May 2024 08:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVPCD/aU7F4z6gDG876JYakhRiGwr0ULv2+yEsDUinJqt6OKC4SC7HeT4fY0xfuZbYpGyanQ==
X-Received: by 2002:a17:906:b56:b0:a55:5520:f43f with SMTP id
 a640c23a62f3a-a623e8d98cbmr1061448866b.10.1716824118529; 
 Mon, 27 May 2024 08:35:18 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-179-90.web.vodafone.de.
 [109.43.179.90]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a629b6ae617sm350784366b.204.2024.05.27.08.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 08:35:18 -0700 (PDT)
Message-ID: <e46b4172-a647-44cb-9ce5-52723875c9a2@redhat.com>
Date: Mon, 27 May 2024 17:35:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/update-linux-headers.sh: Remove temporary
 directory inbetween
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240527060243.12647-1-thuth@redhat.com>
 <871q5npa89.fsf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <871q5npa89.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 27/05/2024 17.04, Cornelia Huck wrote:
> On Mon, May 27 2024, Thomas Huth <thuth@redhat.com> wrote:
> 
>> We are reusing the same temporary directory for installing the headers
>> of all targets, so there could be stale files here when switching from
>> one target to another. Make sure to delete the folder before installing
>> a new set of target headers into it.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   scripts/update-linux-headers.sh | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
>> index 8963c39189..fbf7e119bc 100755
>> --- a/scripts/update-linux-headers.sh
>> +++ b/scripts/update-linux-headers.sh
>> @@ -112,6 +112,7 @@ for arch in $ARCHLIST; do
>>           arch_var=ARCH
>>       fi
>>   
>> +    rm -rf "$hdrdir"
>>       make -C "$linux" O="$blddir" INSTALL_HDR_PATH="$hdrdir" $arch_var=$arch headers_install
>>   
>>       rm -rf "$output/linux-headers/asm-$arch"
> 
> Hm. I presume that headers-install gives us the same set of headers
> outside include/asm for every arch?

I just double-checked and yes, apart from a file called "a.out.h", the other 
headers outside of the asm subfolder are the same. So AFAICS there is still 
a slight chance that we might pick up a wrong file from the asm folder... 
shall I change the patch to only delete that subfolder? Or is that chance 
just too small that we can ignore it?

  Thomas


