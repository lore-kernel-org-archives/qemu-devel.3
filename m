Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B59DC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 07:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA2K2-0007ja-IB; Wed, 30 Apr 2025 03:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA2Jz-0007ic-Nx
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA2Jx-0007z7-4g
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745999850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/TMMUGkNpp1D87llHefk/3l0BdaUkqmQQfCOp1G9twc=;
 b=gLRiTC0gnAuOhg1PUoiRE72DABSMg9ZiAJlc3ppEsKZUBheZm6WWNOJ047ZctNJDImnUFH
 O09CWSZU/ymNJ7vPB67DLdCs2qjpYrs0h3QxSHSpJD+NR7gPhmwg/4JndoEXpEY+TLWEvI
 0+Rln/quf4YSu8Msx3i3OW6GTkyNrmk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-mut7q62NO2G7ch5D08R6mA-1; Wed, 30 Apr 2025 03:57:28 -0400
X-MC-Unique: mut7q62NO2G7ch5D08R6mA-1
X-Mimecast-MFC-AGG-ID: mut7q62NO2G7ch5D08R6mA_1745999847
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a064c45f03so303195f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 00:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745999847; x=1746604647;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/TMMUGkNpp1D87llHefk/3l0BdaUkqmQQfCOp1G9twc=;
 b=wRWYlWRdCX5zAIQUVqhmjzUvDCjJ8TmKBON92xI4RcWe2vRHdJ8EBsEVuDLutzBQ+i
 hl4PQZhOst6Y7CFAIwEocwyQqbhEW1sppqJRaZIA7GvESQYmMy4xot7ta39+IVSJWLZk
 oOnV71uB+itjGQzkkDYQSX0ZB9J9cg4PAIDsTK3DM3T6xw1yUvW5l14FLWzfq++u57Kp
 tRbIJiiRsjvtAQq/rOvLNnfYkqwEaUR756yNLCxnZn5RblsluzOHaOARxvGJDAKsxlHg
 GQmZFo/uD0BKRoUAorgx4SEMt4IfqDKGe2RbDKNhkDlSKzaIr9ODrPcYEEOms/g4aD7U
 dwfg==
X-Gm-Message-State: AOJu0Yx+aGNqQD6opiafJnMcltseDDWNxIM0Tu9c8XbvpEsaf/FLOUph
 O3bHN518fayH2kPn2J6NmDw6YWsWpWR+R316rvqMl+ZGinkY0GyolECN3sAJzqRj3Jiho1W+Ojj
 3k4Hu0sr3wZVUUFkM98wpdC2C6RoApCORbgiPyOc6x1VZVHf04Xkf
X-Gm-Gg: ASbGncstCDpIVS56HzW1J7uJAkBpx9OPDWXVMLZgl2siKWe2naPF9m71c1d/ejNldQm
 o11vIy2NhNJbkdH5NWDNlN0HIfTDTMGy7IbmnHJS4G0uytuq/UMiOAC3Kyjjc2gnBE50iXNRJia
 LIG5oOjXD/PjIqoM2cSibDDb/odNBNfukFGvHeJBMMs3+v4k6SppXsmHCN2O7SZ3eluuraAmhcR
 75MVF/eXECQ3lHp6BZhmIwxtFj8sZUSlNKREkrlqhEui36nL20DjXdvLMCMcVRGPguqHl4krFzV
 bhLcqkZ7kE/W9AJ5uT10xW19rG25vjvhxGfCUpWi
X-Received: by 2002:a5d:64c8:0:b0:3a0:7c91:4aaf with SMTP id
 ffacd0b85a97d-3a08fb6929cmr1432139f8f.19.1745999846936; 
 Wed, 30 Apr 2025 00:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGycdqlDNX4tDu27jpUpX5XOPxPA/nfkHGczAK2D/jRbjNIi4SaHzdDkHqaaPNr3vlSWQgZyA==
X-Received: by 2002:a5d:64c8:0:b0:3a0:7c91:4aaf with SMTP id
 ffacd0b85a97d-3a08fb6929cmr1432107f8f.19.1745999846532; 
 Wed, 30 Apr 2025 00:57:26 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5e1c6sm16619596f8f.98.2025.04.30.00.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 00:57:25 -0700 (PDT)
Message-ID: <5d0e0b69-cbbc-4fa4-a847-fdc8603a8122@redhat.com>
Date: Wed, 30 Apr 2025 09:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drop support for Python 3.8
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
References: <20250425120710.879518-1-thuth@redhat.com>
 <57f21448-79c1-4d46-9a8e-f9109eb67dcd@linaro.org>
 <87jz78b7fh.fsf@pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87jz78b7fh.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  Hi!

On 25/04/2025 17.13, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>> On 25/4/25 14:07, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>> Python 3.8 went "end of life" in October 2024 and Fedora 42 dropped
>>> this version already, so the "python" CI job is currently failing.
>>> Thus it's time to drop support for this Python version in QEMU, too.
...
>>>    if test -z "${PYTHON}"; then
>>>        # A bare 'python' is traditionally python 2.x, but some distros
>>>        # have it as python 3.x, so check in both places.
>>> -    for binary in python3 python python3.12 python3.11 \
>>> -                          python3.10 python3.9 python3.8; do
>>> +    for binary in python3 python python3.13 python3.12 python3.11 \
>>
>> The 3.13 test was missing in commit 45b14be9b63 ("python: enable testing
>> for 3.13"). Preferably adding in a preliminary commit, otherwise mention
>> in this patch description

Yes, I'll add a sentence to the patch description!

>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

> Yes.  The patch looks good to me otherwise.  But John knows a lot more
> about this stuff than I do; would be good to get his blessing.

Seems like John is currently away from keyboard / busy with other stuff? I 
think we should go ahead and include this patch to get the CI green again, 
so I'll add it to my next pull request. If there is still anything that 
needs to be done on top, it can be done in another patch later.

  Thomas


