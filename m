Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748C1C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 12:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td7To-0001SI-Lw; Wed, 29 Jan 2025 07:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td7Tn-0001S5-Dw
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 07:47:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td7Tl-0007YW-Dz
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 07:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738154856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FQ1xxi88uUhUHryNzyR0nAsLxvNBLjIJPPpKvYRDcZc=;
 b=XSjeaOcx0ls1CxNEDtEmR06xfgPS5IqSD1CfptTGeY3tKMEi09aepBHABTmJwVF8cjWITs
 iIHT7/f/r4Na0iENPlz+xacWRWXllQqslwfSUiySxoM5eHJoFw5kDcY9wgs9Jf4OCyyBrp
 pfc6+yL18KZ/vpiztMLpZP38V8xK/no=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-dC6o6IjmM_2SwgUJp-SXGA-1; Wed, 29 Jan 2025 07:47:34 -0500
X-MC-Unique: dC6o6IjmM_2SwgUJp-SXGA-1
X-Mimecast-MFC-AGG-ID: dC6o6IjmM_2SwgUJp-SXGA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38bee9ae3b7so4454742f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 04:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738154854; x=1738759654;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQ1xxi88uUhUHryNzyR0nAsLxvNBLjIJPPpKvYRDcZc=;
 b=iuwsCnuZys4SBAnLK8O8Iq5jRNLwG2nBYMZ02h4v7wjDiKj4QY0T+q6T6xxyytEv/d
 obN6BholCNjmsAwx4Wt07kG9FnHC/DgzW8GVwaKi2SjfJVJAOE9ZCdoFO69BpOJaAh49
 jV43vO4tnxr371jkkj8tklArhIJmN1xcpyUFTeXnD78MX9nnqtwyTwdZI1fs1Mb7ia4b
 mhOTlgxzQbW3KI1FL/9fA6tWJEFLqYOjpsY1V2SDbJsqq36R711Y42EhLVEZ8PymJCII
 3E1s19RtamV8LkZb0tVGbrNtjdPzYeTnKMHyCpRR6ZO4YxdRjL0L7jNixz/tgeHk51bF
 vsOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQGtqwXpmp86wByvoupRpeZAaRkqYu+JazrSs/ZOlTtfJTLCcNVgDJf3FaydLcefFGcH5lNNX0J2aZ@nongnu.org
X-Gm-Message-State: AOJu0YyyNdqtISsApXlzU/ue63igwkoGlwf+k6hhSHqzy8rIGYrRKT0t
 lsyO2+Q1uVPHKc1G2SVzMPEinkt4vm+2Hw60aJGDyhLeopTk7L3Q09E2g9HKpNti7JKEr0L5wki
 VE3de0VWGFEJU27Yfp9vS6kfjJMez6qhMx1gDSj5f5A+/jL6bPfVv
X-Gm-Gg: ASbGnctmbwgZ2I/AjPobEaBsbrDffcmVCT8Y0hMbUeifwMHWTvR4hiOaLJz5YQfM4kc
 snNaiEmEnL0s+U3kU+ALTnR4ScNdgmz66j3/tWG+AfvZuz8rrCEvBBYEK+dSGLCl+IyS1V8y+WM
 F4bFp5BYtlgH+Z2avCxi8zVAfpwbn86B+z7OAz3R7rdD+MVqu50SWnha5uDyTi33hDbw7z2/BPs
 n315rZ8Xnc7e0XMCIW/0q+CTJRupGLwfOvfADz6kMVW1e1nJPeGCEGmVB1qSJmFMykzgpqIxSDv
 HCLuAQ==
X-Received: by 2002:a5d:584e:0:b0:38a:8b00:6908 with SMTP id
 ffacd0b85a97d-38c520b0b23mr2878157f8f.54.1738154853715; 
 Wed, 29 Jan 2025 04:47:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp5b+BLCJjHjmqADg5/Ea8KEgaErytnUi109qNHUS2qL53o/ntwe49UF/OMykm1C0wlXV0bg==
X-Received: by 2002:a5d:584e:0:b0:38a:8b00:6908 with SMTP id
 ffacd0b85a97d-38c520b0b23mr2878128f8f.54.1738154853316; 
 Wed, 29 Jan 2025 04:47:33 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6b2sm17394260f8f.34.2025.01.29.04.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 04:47:32 -0800 (PST)
Message-ID: <8a54600c-ff3f-42dd-b164-62a57de867df@redhat.com>
Date: Wed, 29 Jan 2025 13:47:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 stefanha@redhat.com, mark.cave-ayland@ilande.co.uk,
 Liviu Ionescu <ilg@livius.net>
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
 <Z5ii-ueFt5-5Brxz@redhat.com>
 <8c0eea44-d0bf-4b86-9b1b-1c2082ab2df9@linaro.org>
 <9bf6d4b0-7a89-4110-a1e1-46bbdb2fc793@linaro.org>
 <c13e207e-06a5-4f40-b319-f4f2e59d919a@redhat.com>
 <CAFEAcA_CfVfypS5yUtT3V34CDxmAqx7wYnDoKPfHq-o=54GgAg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_CfVfypS5yUtT3V34CDxmAqx7wYnDoKPfHq-o=54GgAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/29/25 13:23, Peter Maydell wrote:
> I'm not really strongly opposed to dropping 32-bit host support,
> but I don't think a thread on qemu-devel is exactly likely to
> get the attention of the people who might be using this
> functionality. (You could argue that functionality without
> representation among the developer community is fair game
> for being dumped even if it has users, of course.)
On the other hand, broken tests that no one even runs among the 
developers are not particularly significant.  It's not surprising that 
tests do not pass the first time and need a little tweaking when trying 
them on a new platform.

There are many examples of parts of QEMU that stayed unmaintained for 
years, working relatively well for limited use cases, and were only 
later revamped.  Most of those that I can remember are guest side: the 
TCG frontend for x86, ESP emulation in hw/scsi, VGA.  In fact VGA still 
has a good number of emulation deficiencies and it's deprecated for 
virtualization use, but no one in their right mind would suggest slating 
it for removal.

The difference with TCG of course is that TCG is in active development, 
and therefore its 32-bit host support is not surviving passively in the 
same way that a random device is.  Still, I think we can identify at 
least three different parts that should be treated differently: 
64-on-32, 32-on-32 system-mode emulation and 32-on-32 user-mode emulation.

We could and should remove 64-on-32, maybe even without a deprecation 
period, but the rest I'm not so sure.  I don't know enough to understand 
their maintenance cost (other than the mere existence of the 32-bit TCG 
backends), but it's certainly not comparable to 64-on-32.

Paolo


