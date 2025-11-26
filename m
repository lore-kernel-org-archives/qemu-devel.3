Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF0AD10390
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 08:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOB88-0003Y5-SO; Wed, 26 Nov 2025 03:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOB7x-0003W5-Go
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:43:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOB7t-0003J6-1q
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764146627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SWt3xA+ZgJHYVMq9IIXvFZMzqF/epU10bHZNQXzeuf8=;
 b=CN9OTGx3FWbNf8wqwQKgNPqwc7eR6ZuVTwWBVxx/uvrFW9NtapaoiLZyxJf5kiqR5K+oCg
 dQGkbEn89qcJgp6zH0sMYCMHDkyAuNsPJn7OBcvtVARXw+v8hOMxtrtjJe9Do4tJKoLT22
 4NqrSeSuKCG3YeWkyQnocyE1oOzylWs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Nel9k5fCPhqsqf1uE9COfA-1; Wed, 26 Nov 2025 03:43:45 -0500
X-MC-Unique: Nel9k5fCPhqsqf1uE9COfA-1
X-Mimecast-MFC-AGG-ID: Nel9k5fCPhqsqf1uE9COfA_1764146624
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b70b2a89c22so69264966b.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 00:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764146624; x=1764751424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SWt3xA+ZgJHYVMq9IIXvFZMzqF/epU10bHZNQXzeuf8=;
 b=ABvOUxsedEP4jV6oK6KNZ/zEx8cx53z/gtHBgyH8b1a48bMCH7wZwW04NlQDh15aQf
 ABulZPCbx7mSNZ8jTfz0poDrYKlFbhyUtLhBWHs7fVjOwTQznleuRz7dF+tMfwO3e1jW
 HUkkez6p0fcv9BAVwpSKelIYQ14VPME+fmk/EinpWxfQZA+EHgXpLwo+AmqJYkcAw0j8
 M5IJccHbxgEgVwPLQb9v8MUk5bmOXOE0Z/eqPJzo3srKD8Ox6qc1YT0LJQAUc4cn3qww
 14qx7+eSFT0zA5VvDDkMKQAMucNA8YEv3LM47gD4VCk1+d4bFq0vT+kIXReaW38VLZzZ
 TNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764146624; x=1764751424;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SWt3xA+ZgJHYVMq9IIXvFZMzqF/epU10bHZNQXzeuf8=;
 b=WZmChDKEU1vj0P9uBhqDADEEq9wxeO0Cj9PLHKUcaLjHUEzvmnbyndke+rj2tYnhXj
 +HNkI6cg+Hfd29npYtnaXMkJXyf7pFxo81rWqvJZJ7TSZP7L9YA2mFqt9aCIGeKs5Dgl
 b/i1c+4wFnR0QrmtDf2va9QgQdpK6mIOExlR/YxtM1WHfKs87gXtqGYkCFbEFmlpesQy
 85b/vlpSlxi7CQSfjEdSH04wJozzW0ZUv/Jp6jLoAID2QJOaTT2+eguLJM7/t/3O9tOb
 2pGf9ppbzy7Zahacl5vncs+EUmMi8TMgQ/SOM28Jqd0sHJI1dt3U4nqZQk1bCdyQ5vBs
 G//g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiqcTjjO6P5Y0HaVhYRm8HflYrjIjFZaCU3QsDy11VoSgLATXDwqS+YlR4s15truPCEzNTiVZYx00d@nongnu.org
X-Gm-Message-State: AOJu0YyJtTLExjLrZPTgAtve9QKoxYJXjn3yqgsqNO7tt/EXH1CwpNVC
 n7cA6kMkU6kj7bYrb+uDJMfYLSjrlwk5QIHVIhGlbMVFZogkl8h8WHAIYxK2loNMWDT6w68QfxN
 bLsNG3suUneR833yHN/hZ2sEyGLeAoaVp8eta69D9TtHcQ71Sa194oCBh
X-Gm-Gg: ASbGnctorBAiNCgD1lmcwXqCNKo6PLgc9DF+JL0Ee8ohBNr8MdkuDL/3zyPKoZEE4/K
 IePlDVfofwevsxCeUbYi+AMu8Fmn/xv+lAqWguG1kfSWr4Kq7M2MHzj0dQvup7SzWT3mRWhUqZ1
 s2oF5TwV6J/6SLjgcTIlU9m96E13B2JbTuCCO+NGl8VTGtf4JPliYFf8Q3SmCbGG5VO357ZfAWB
 2SPBjSAO9guI558+601CHVd3IbzkYLvUgQp4PLR2V8maD5CC35WZMoRBtYJcmOLtNpu96xdt20R
 zF0xbhkFHVdU3XvhAfnc6T+bLRBvk4GY8lwVkrMyljCcaX+nN4BTdBkbeBuCvLDiLkD43bDg1Gi
 zelvHDJA=
X-Received: by 2002:a17:907:d19:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b766ef1d094mr2507087466b.16.1764146624428; 
 Wed, 26 Nov 2025 00:43:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLIo6tMhoCSckM4F84CZHZiX3Qz9iqdj4BVmilhErNA8cEDOCS51zaiBSDZQfzlgSekdKMkw==
X-Received: by 2002:a17:907:d19:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b766ef1d094mr2507084666b.16.1764146623748; 
 Wed, 26 Nov 2025 00:43:43 -0800 (PST)
Received: from [192.168.0.5] ([47.64.115.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7654ff4096sm1848582966b.49.2025.11.26.00.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 00:43:43 -0800 (PST)
Message-ID: <e9dbf6bb-d5b8-407c-86e5-93f056b287c3@redhat.com>
Date: Wed, 26 Nov 2025 09:43:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Update URL for make-pullreq script
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20251125164511.255550-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251125164511.255550-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 25/11/2025 17.45, Peter Maydell wrote:
> In the submitting-a-pull-request docs, we have a link to the
> make-pullreq script which might be useful for maintainers.  The
> canonical git repo for this script has moved; update the link.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Cc'd stable because the old URL is likely to stop working soon
> ---
>   docs/devel/submitting-a-pull-request.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/submitting-a-pull-request.rst b/docs/devel/submitting-a-pull-request.rst
> index a4cd7ebbb6a..e7d00808782 100644
> --- a/docs/devel/submitting-a-pull-request.rst
> +++ b/docs/devel/submitting-a-pull-request.rst
> @@ -67,7 +67,7 @@ subject tag is "PULL SUBSYSTEM s390/block/whatever" rather than just
>   pull requests that should be applied to master.
>   
>   You might be interested in the `make-pullreq
> -<https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/make-pullreq>`__
> +<https://gitlab.com/pm215/misc-scripts/-/blob/master/make-pullreq>`__
>   script which automates some of this process for you and includes a few
>   sanity checks. Note that you must edit it to configure it suitably for
>   your local situation!

Reviewed-by: Thomas Huth <thuth@redhat.com>


