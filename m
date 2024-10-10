Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57322CF07B8
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 07:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1synIe-0007MF-MJ; Thu, 10 Oct 2024 03:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1synId-0007M0-4y
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 03:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1synIb-0005qf-8g
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 03:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728544162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TnZev6OjrjeSqh6xeQ/ch4aJ3+3kPhqp+FhJhlZ6R00=;
 b=ZYJS4mrL1y4sKJyCfh0tICVD5mfwm0AM4YOhMC4AtL1Vy4JRH/onXmXoc6dL+tniXhM6Xp
 r+UpK+N8LQKys5dYhvx1XHqxD8/OLJxqHNt4BqLsshfOiy0BnZ/u5g4mjQWkZ3P8TiSyC2
 VNn9f8UEp5E4edA0EaJpLc7A/KB3oMI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-Fc5kKB6GMiK_jkyDCmSaDA-1; Thu, 10 Oct 2024 03:09:20 -0400
X-MC-Unique: Fc5kKB6GMiK_jkyDCmSaDA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d34f5b140so189490f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 00:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728544159; x=1729148959;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TnZev6OjrjeSqh6xeQ/ch4aJ3+3kPhqp+FhJhlZ6R00=;
 b=Ij1qECw8ArYKf1sj4fWFA2gho84SpybOZ6OT2DoblBZStEEFH6khaW70opNL5E64Fs
 xX31zxZgfZvjzeEPRMc+K3Meh2599XwJW516ppA639oH0pipTJUR4LEhXs4HNrQOQtk/
 BmkR0iWoAjHI/7TJaQV56XkuqKVrvLta+YkpOqjakmAGTbbx50UOAHhssY6TNptf2Yn8
 cFVAOhjMFOVy3UnpI8gdv+zQ6GqUd3aWh3wrNT8C0tbNXA2+d3D4I3X5204Hd/NJK9x3
 xeHvT0kP4w5V6sNJwVGCqzlitqT7uFvpaGld2GPLrJUg5nrd0joz191718OGWxBSvoh0
 KA6g==
X-Gm-Message-State: AOJu0Yw9T0oCHSEtDMBcyD7sB/twzRTrygtUhsdCNhWLAr1Mp/vMrVuP
 AsRv/g61HQfk4mpsJ1sWaWfaaHrp6PnQcnBYKh4vVkSoa7Och85sPCAz45hkBmpIec7XIyhHwBJ
 aKAj6GbL43hbC2yxgAY+Lhg/nMGmsmv2xtBDvZyewb/UjHLn9Tc/Y
X-Received: by 2002:a5d:4112:0:b0:371:8ea0:e63b with SMTP id
 ffacd0b85a97d-37d3aab5888mr3712902f8f.52.1728544159613; 
 Thu, 10 Oct 2024 00:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiJ6Um2nZKEoWQdgsGc//xuTFdzyoPRz+8Y8z7MaMmxmBWGsvYoVq7FG4y8o+fKKSUnANzGQ==
X-Received: by 2002:a5d:4112:0:b0:371:8ea0:e63b with SMTP id
 ffacd0b85a97d-37d3aab5888mr3712883f8f.52.1728544159188; 
 Thu, 10 Oct 2024 00:09:19 -0700 (PDT)
Received: from [10.43.3.102] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b79f9b4sm679129f8f.86.2024.10.10.00.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 00:09:18 -0700 (PDT)
Message-ID: <d21e29b1-4f03-4b6c-b7f8-0890f0738b7a@redhat.com>
Date: Thu, 10 Oct 2024 09:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audio/pw: Report more accurate error when connecting
 to PipeWire fails
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
References: <3a78811ad5b0e87816b7616ab21d2eeef00b9c52.1726647033.git.mprivozn@redhat.com>
 <CAMxuvay3s1XS7xEOoAr8HnrO087H_3H+GMWb-cVoC0+Dm0feuQ@mail.gmail.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Content-Language: en-US
In-Reply-To: <CAMxuvay3s1XS7xEOoAr8HnrO087H_3H+GMWb-cVoC0+Dm0feuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/18/24 11:29, Marc-André Lureau wrote:
> On Wed, Sep 18, 2024 at 12:17 PM Michal Privoznik <mprivozn@redhat.com> wrote:
>>
>> According to its man page [1], pw_context_connect() sets errno on
>> failure:
>>
>>   Returns a Core on success or NULL with errno set on error.
>>
>> It may be handy to see errno when figuring out why PipeWire
>> failed to connect. That leaves us with just one possible path to
>> reach 'fail_error' label which is then moved to that path and
>> also its error message is adjusted slightly.
>>
>> 1: https://docs.pipewire.org/group__pw__core.html#ga5994e3a54e4ec718094ca02a1234815b
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Thanks, can you merge it too please? I don't have commit access.

Michal


