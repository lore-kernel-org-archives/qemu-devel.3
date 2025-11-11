Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F55BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 08:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIkDQ-00061G-CP; Tue, 11 Nov 2025 03:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vIkDO-0005yY-AB
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:59:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vIkDM-0002rh-Qf
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762851539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/sQXm1v8T8mIyTbIOXXpkBO2kBe0zzWQeJIYZCSzwgI=;
 b=VYalaJ4TcxklEIvV9NbO97w5iMnBL7+1jFYVxEjBOXlYKE23k65s5pKdVFjI+gbz2PPr33
 EKXSNUZbOwjqgPyI/xWyiyeUmve/+jHCAsS41iTLco51Tht5JUlSOvCoPQtSjGGbRzMzwp
 BEUuB+hKXR0hWlz/wG8RcQQKb29wAvA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-HONgWv7UN3Oy4FmrbG4xeQ-1; Tue, 11 Nov 2025 03:58:58 -0500
X-MC-Unique: HONgWv7UN3Oy4FmrbG4xeQ-1
X-Mimecast-MFC-AGG-ID: HONgWv7UN3Oy4FmrbG4xeQ_1762851537
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1377so1039617f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 00:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762851537; x=1763456337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/sQXm1v8T8mIyTbIOXXpkBO2kBe0zzWQeJIYZCSzwgI=;
 b=KOg66BywtFxCI+i0yuQPrArzkdVNbr+hlw2F/WFFQQhdSNEtq2UvJkWSkFYcuXx4vc
 HdcpG6EiS4++HZsiQVT3QK/gWGZZ2BuFNUCDDclAN3vKaowPfMc2Aq6IL0Mon6aJhvDl
 7ZKPBVjMZJylU5+b1x6fAy0owuscA7nc7zKGlgnXDMBPhAN8PPafiNjoe3c3ckc8fvN6
 CgSAfeZ8K8qterD5oKafLPBMMXJDqE2GBbKkakvf2AnXNMXp+mqKNtwoFtbrXh/8aZ+T
 C4zh9jfNbIpRToQzlp2NmtCG2Bqiz1s27yAr5drmzNQesgAyY2Z8FCJWvS4hErKiK02r
 Npmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762851537; x=1763456337;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sQXm1v8T8mIyTbIOXXpkBO2kBe0zzWQeJIYZCSzwgI=;
 b=nzSWt6Vn+BX1+zgl5lw6nj4yg44/GdEIrgR5Ob6sYAiWgi35kIfMhKpx+thhki8Arz
 4tIgWN+vbda9MqvaOZkHIMd1/WwWsQN2JRsHQ2p71gC68e3siVJGY0mm1YEIDGfSe7Kh
 a6zuo/aRJDyvBa255DfOEErtthh9cWq3xQdQJgXIeOp4Pr1Zv/hS2sJLcfgaq0tpxliY
 IT53JLO+icdl1P6w339eeSV448PlKMsT2VBDTMlrpRb0u58GmbIiVsDTb8q3x52w6d57
 P394gLBHKagEOq68xYRmvUmaAyDykNNe6w/DLLEavTge3sNVRtX8btfMP6O/DVwF0LO3
 LIYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFtesA8bbViytPZij9M19bUKYxpAx4d2eEDFwLD+0nJ6EgUpTnCcB08/5q+jR5kHvqPSRinXX0AjMJ@nongnu.org
X-Gm-Message-State: AOJu0YzUeXQJ6LaCCUe9mnM5MEd6sDi1pcaOpvZ6NWco/qH1LMBxHv8J
 dFfWJacyHxpTfBMlt/CsgtBEDyiMQmEoMmo6zCidLLSCyXb7vfyal9FqG5X0gwAF+MfiZZ4dtlQ
 V+yaDOhTv9+cOcjkIYKP/fQHxnAHILtj50D7WnfL/yAbk9McqgPnQ0g4V
X-Gm-Gg: ASbGncsu5Ks6rqyIVDVBdynolLq4fSuURac7dwSHSY2XbUSyl1XR/nWfXRPHCkunzqx
 IFbwAjWsKKyDNBLxDusvjSsOPo0wnOveEfIJAd3NBUGKsKk876nKFW0mS/iSmnAoEDbYjcJK11f
 0iSldDcPvMxlgeUDNj5SRAOkyic3kzPr20ekNzzOmNXRb4/HECUMlmqSRuctcM94zYVvKMJZxNK
 3KKItqtJraY/w6M6dTLdH9D/FqGZ4z844fTRZ4masf+LD46MWs3EtstyttWlMoLBZtmMvnSveQm
 mdU2tZJyvkfaqJMbRZKcRHtuyC5zF4xr23/imo1bJcTq+Dm4TZdlghas0w1lHFYp8AwrbFPk3ob
 eD6L9PmW03LbYl6wUcuQY/nGY6zSWcee/CP1Cr3k4NOaj8gmTIYvz4+81uGprI9rgirwE30M+Zo
 6fb+mgWg==
X-Received: by 2002:a05:6000:2a07:b0:42b:2fc8:177 with SMTP id
 ffacd0b85a97d-42b2fc80241mr8898742f8f.49.1762851536804; 
 Tue, 11 Nov 2025 00:58:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7D7wIjmj7vZiCjUqpV9X0+9jg5+dXdzajtTfU/3zdUEkWND2FZ5ZI6SX2O5w6dFuFKbwllQ==
X-Received: by 2002:a05:6000:2a07:b0:42b:2fc8:177 with SMTP id
 ffacd0b85a97d-42b2fc80241mr8898721f8f.49.1762851536414; 
 Tue, 11 Nov 2025 00:58:56 -0800 (PST)
Received: from [192.168.10.48] ([176.206.111.214])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42ac677abeasm27424497f8f.33.2025.11.11.00.58.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 00:58:55 -0800 (PST)
Message-ID: <c3868653-4909-46bd-be59-426e4e4b0b62@redhat.com>
Date: Tue, 11 Nov 2025 09:58:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Does our interface compatibility promise cover defaults?
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <875xbhdl59.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <875xbhdl59.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On 11/11/25 09:32, Markus Armbruster wrote:
>>From about/deprecated.rst:
> 
>      In general features are intended to be supported indefinitely once
>      introduced into QEMU. In the event that a feature needs to be removed,
>      it will be listed in this section. The feature will remain functional for the
>      release in which it was deprecated and one further release. After these two
>      releases, the feature is liable to be removed. Deprecated features may also
>      generate warnings on the console when QEMU starts up, or if activated via a
>      monitor command, however, this is not a mandatory requirement.
> 
> This obviously applies to syntax and semantics of our external
> interface.
> 
> Does it apply to default values there?
> 
> If no: does this mean we can change defaults without notice?

In some sense, versioned machine types are an example "changing the 
defaults without notice": almost every release of QEMU changes the 
default values for -M pc and -M virt.

But then, while we change the defaults, we provide a way to access the 
old defaults and only remove the old machine types with advance 
notification.

> If yes: does this mean any change of defaults needs notice in
> about/deprecated.rst and the grace period?

Generally speaking I'd say so.  I don't speak much crypto, but the 
latest commit to deprecated.rst (commit d58f9b20c71, "crypto: deprecate 
use of external dh-params.pem file", 2025-11-03) looks like a change of 
defaults.

Paolo

> Note that changing a default is a silent change, like changing semantics
> / behavior, unlike changing syntax.
> 
> 
> 


