Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2D1EB28DB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 07:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voGTQ-00069v-HC; Fri, 06 Feb 2026 02:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voGTO-00069L-Mv
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:41:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voGTN-0003WW-2T
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770363708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZUuRaOhuIUJ6CZ9CTFDp9JOpbN5YIIa4N4PQGg39ECs=;
 b=SQtrLBT5CjUcfTrRVRhz2nu9U3e77gEmGE+gQSwey/DAFow5hKS868cdwrMpVJc6gbvnyo
 buQxV4HFVbjCeZOxkKZyAEfcR+6mA16QO0/dKp23Ctz3gqKCmqGUMUpopXGvwotInTI4Cp
 /S0OTjz6dHaMLaNrkqaW9gGZiMC9i/Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-eJaKPVouOoOby0izi-gYAA-1; Fri, 06 Feb 2026 02:41:46 -0500
X-MC-Unique: eJaKPVouOoOby0izi-gYAA-1
X-Mimecast-MFC-AGG-ID: eJaKPVouOoOby0izi-gYAA_1770363705
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4325b182e3cso1629027f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 23:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770363705; x=1770968505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZUuRaOhuIUJ6CZ9CTFDp9JOpbN5YIIa4N4PQGg39ECs=;
 b=N9CttTpw6llcbFGoDqm6N/Fa6X+M2UgcxySNn7ktl4rorVsrY/Clte0e17/es4b3MT
 BwfT+GwVDOb2KPA9t+njPVoXwsDuASyjDHSMkV9kfbj5kiUhirPcw1xK0x92rIDoSWav
 z8FogYl3iRCr7eMWvlcaAgtw4Jr6JuaWnvagAa6WSzAKAXJvpwvtiUw2bcmZUgSwbw0M
 Xvlq+6+BOAsO6DTlyACWzwaA/h682MdD/3DqItJTX85Kia2IDbSQP7ILCGee8vI0J7m8
 AqDPtHMZzmS+aJK1zWW96tRegdrINgRpwbogfS8bQd2SlbzPNxfamrJSXnb07ZgE++jZ
 nUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770363705; x=1770968505;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZUuRaOhuIUJ6CZ9CTFDp9JOpbN5YIIa4N4PQGg39ECs=;
 b=vJWhEkUoVN3QLCSvM13llLDMT2XhoB4WD5Zg8mN7RrIr5J2FgRLPEWVitmZqDWbxlO
 /UKnB+LnE+DORmNXIYw5gFYMFkjim8argYIFT2OjT59Twcmcd1OIbiLbPsdlyt602RJv
 217x/sIaBN3sQOXYV33HLPAU5MfBha3gYMNEfyARjSue94Am1VdydoxJ9fQsZdlmuRZR
 juAVxCZRvVTBec1cGw38O++o/G8RIbMlt4oN1xJHVdQhVs2rgDKMmjy1zTy4RUecvIzq
 2WTSuYL964LW71KemL7J5T4TPqOQMyJ68DASNJBFcwqRHE6YnJnm20AtIidgYiYmNVL1
 +3kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtnCw4H0qeC/wklA9fEO4OtESUrYi26yZ685Y+3BIFw9oqADB295vZVyha38KMorqOmy+F8//7PVhm@nongnu.org
X-Gm-Message-State: AOJu0Yx9vxQsyf1XkkKjxycBRP2Fa7xyAV7pwfs8a8Jb9A27Qhx0NeAJ
 hlYCvWYqziimB3uypqbtUvkkMyCauwCvt+CT6HKJ+X8bj/zKP1AUkX+cp3/4FjupwM4Jwe1Q7q5
 S8yL/veHpQ7aaVRm9jT6zWG6/f/9OZvosR3YZgK8zj7gYlnMjfrLMIEoz
X-Gm-Gg: AZuq6aIzV47ycT2aMjQOXyx0EbHqgEphI+xtOw8D/XsXpffiYnbeg1edYEqxQS5mi0U
 N5WSfZWKu4z7tiQprTBQG5ibHfIo+MlDFjAwjMmiL1mZ3E3co3ayh+X4sQv6++OZ467KtojBRiU
 SMy1SM0BrpKgoddG1eCE0PWdxopva42DXxUmMHO5pporSfORXMkO7Ce0ibNlGDxj91RSeD+qL+Z
 3gC9Bn7D+A3iAz14EltszpFUlG/1w1O4DbuTL8X7TuFcQwrMwcNDrXgbWok1Akygo5pTPzIbjEv
 Mv4uJ7rS/Y8EQIxJDNwZXtk6I38Ywdag9vw8tEifYT/M0RFKQejmzoKfHnwGHawuhxIJUEiAWtT
 3vN4EXTc=
X-Received: by 2002:a05:6000:2881:b0:435:dba0:736c with SMTP id
 ffacd0b85a97d-43629384c6amr2616292f8f.56.1770363705078; 
 Thu, 05 Feb 2026 23:41:45 -0800 (PST)
X-Received: by 2002:a05:6000:2881:b0:435:dba0:736c with SMTP id
 ffacd0b85a97d-43629384c6amr2616262f8f.56.1770363704674; 
 Thu, 05 Feb 2026 23:41:44 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bdc11sm3839864f8f.14.2026.02.05.23.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 23:41:44 -0800 (PST)
Message-ID: <89621195-a2d7-4501-9746-c2ef0e611d2c@redhat.com>
Date: Fri, 6 Feb 2026 08:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bsd-user: Dropping the NetBSD and OpenBSD code
To: Warner Losh <imp@bsdimp.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <CANCZdfq74R8fLc9+NURynkKz+D1FOtxKRGno9EwjN--hPpdf6Q@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Brad Smith <brad@comstyle.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CANCZdfq74R8fLc9+NURynkKz+D1FOtxKRGno9EwjN--hPpdf6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 06/02/2026 02.03, Warner Losh wrote:
> So, it's been years since this code compiled by default, and even more years 
> since they compiled at all.
> 
> Maybe 5 years ago, I contacted the OpenBSD folks, who said it had decayed 
> beyond uselessness. So I plan on just removing the bsd-user/openbsd code 
> shortly.
> 
> Maybe 4 years ago, someone from NetBSD popped up and said they had a fork 
> and they'd share it with me, but they never did, and we never reconnected 
> despite some email attempts since then. So, I'd like to remove the netbsd 
> directory as well.
> 
> Both of these are finally getting enough in the way that they are causing me 
> problems with upstreaming the bsd-user stuff. Now that I have a good head of 
> steam on doing that, I'd like to finish that process. Expect me to flood 
> your email in the coming months with way too many patches now that I've 
> found a way to streamline the process enough for me to sneak it into what 
> would otherwise be lost Friday afternoons...
> 
> Before I send the patch series to do this, I'd like to do a last and final 
> call for collaboration. I kept it around for this long in the hopes someone 
> would show up, but nobody ever did.

Please make sure to CC: at least the related people who are listed in the 
MAINTAINERS file (done now). But if nobody speaks up, yes, I'd say go ahead 
and remove the bitrotten code.

  Thomas


