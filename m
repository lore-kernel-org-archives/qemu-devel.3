Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB89CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FWg-0003bh-I2; Mon, 29 Sep 2025 11:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3FWe-0003al-8g
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3FWT-0005KK-SE
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759158639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=msutrdnUnvna09GSdcyu2GgNNuni5cyjcWUZX1HNdWk=;
 b=TzT8kMoi8s/ohEnlSj2CzgcVOyqFoy8R3wgzJJMBWrLvGlpjnKMet46uEEYPvWUYipkEgD
 9/OmSHrybAGvhkc4c+2vUIAyRGj8b27gYYas7SfKorKCYqwrtF2v12GnTe0+axW9AcRsVq
 5do7CGMZjaFbADSS6H+/M9whTe2DW5o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-pCCX6izNNqmup-pUSEzvKw-1; Mon, 29 Sep 2025 11:10:37 -0400
X-MC-Unique: pCCX6izNNqmup-pUSEzvKw-1
X-Mimecast-MFC-AGG-ID: pCCX6izNNqmup-pUSEzvKw_1759158636
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-632c9a9ceb1so7968543a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759158636; x=1759763436;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=msutrdnUnvna09GSdcyu2GgNNuni5cyjcWUZX1HNdWk=;
 b=VoiAoOF4lDuVdi/aUHruCjvF5ASi1AceteZ2cp1PH4Z7infbGaHlUXoST3eHKXbKhD
 v/6hokmq6Syte7xoFCNdvQRH5Hyc00v25tGguIVdSOozmo/lefZJ4PO5Ts+7igrvdMde
 MexQExhQqGbYtCVHxMnYZkRtv6XyMqZ4Gtxx9vLwaqh8pEClCZ4Jkwinbl1d9VS9z6I+
 0BuixyQzYYqVDtEDtBZYBgyhnyq9k+kNcz3HPrt/X10b3i5ntq377hzUzkHXd8yLwRRE
 iANPTVuBsz1CMBZSpWB4qgUMlh4oaayZRw9Azk9zAMwkYothBiqqEDMwDZgMM9rG4+2n
 onPw==
X-Gm-Message-State: AOJu0Yylpd9JzRmtFTDW7QL1CVaEltcmGP6eshXkjBZVOw/V/VpfIjz5
 gRdLRi/BpY1AHOoh4lEnjdXkKdK+Nc8PeLJGzSiJdNCiUslIJFe6+4oRgWmoGlLl+a60QQ/6OYf
 TQtti/v6fJPClS3pGxvmB1rOPJRuy1lTd0FwFG0tV+RpYZ1lhhuC6txAE
X-Gm-Gg: ASbGncvB8XcO8j02plQevNw1EBOqcdheQROf4nBnxXU4nKWHViTcHTB+CawHaIfmh+C
 Sl0FFtLDMXZSiJvd16LiTjsRgS9OK7rfr2PM2eW7OKSWFmMb0zT70wPh38k3A75syzcIjaaInwS
 BCtOWjVKR5p3udnMpjdW0PztMi6kueGXGwtEUe5Dv+9TXKNDBgo6j+dpiKxiHsaYe/1lg0nwxAZ
 JhOymKWISWA1pch5R+xCbpaxchHx/FqJGLxiy2z+eoBDu3T5XUyEe/CAwqQH+3agO4MeCMny2f8
 qf0dRy1yTuMlwdiwqNbzWtYI7tV5VbZyPodXcwhywP5l34Pn3eeB/T7g4IOOG5jfP1E9F4jD9Wv
 kTGjVw5KEzQi0zvzGOHFlF0UghNp2lAgvSjQRR+4zs1RK1Q==
X-Received: by 2002:a17:907:f815:b0:b31:ec30:c678 with SMTP id
 a640c23a62f3a-b34bbebc92amr2099131266b.57.1759158636243; 
 Mon, 29 Sep 2025 08:10:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSd2VTSseZ5lDjfaXEFqU3KjFGEhJfP/vN+a0GHC+8xLKAowQuI8qpZ6xQw/uzBH6aNSub1A==
X-Received: by 2002:a17:907:f815:b0:b31:ec30:c678 with SMTP id
 a640c23a62f3a-b34bbebc92amr2099127566b.57.1759158635817; 
 Mon, 29 Sep 2025 08:10:35 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b3ecb7492besm218105866b.1.2025.09.29.08.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 08:10:34 -0700 (PDT)
Message-ID: <abe8812c-e46b-4d9c-9bb9-b3530611248a@redhat.com>
Date: Mon, 29 Sep 2025 17:10:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] docs/code-provenance: AI exceptions are in addition
 to DCO
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250922154843.60233-1-pbonzini@redhat.com>
 <20250922154843.60233-4-pbonzini@redhat.com> <aNo7RaEOKJ5GFjNQ@redhat.com>
 <2eec6166-f426-41f8-bb79-18ac7d5497cd@redhat.com>
 <aNpS8C5o44kLjspU@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aNpS8C5o44kLjspU@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/29/25 11:35, Kevin Wolf wrote:
>> It's mentioned earlier, since the responsibility is not limited to
>> exceptions: "To satisfy the DCO, the patch contributor has to fully
>> understand the copyright and license status of content they are contributing
>> to QEMU".  I find this sentence to be already a bit heavy, and would prefer
>> not to make it longer.
> 
> Isn't the whole paragraph meant to say that exceptions don't make any of
> earlier mentioned requirements go away? So I don't think it would be
> redundant in this context, even though of course it would repeat the
> requirement just to tell more specifically what it's referring to.

Even though this section is specifically about generated content
exceptions, requirements are not limited to the DCO.  Of the other
practices in the file, "where an automated manipulation is performed
on code, however, this should be declared in the commit message" is
an important one in this context.  The fourth and more controversial
patch in the RFC included text about providing the prompt and, while
it is premature to have it now, I can imagine this paragraph becoming
a bullet list:

----
Exceptions do not remove the need for authors to comply with all other
requirements for contribution.  In particular:

- the "Signed-off-by" label in a patch submission is a statement
   that the author takes responsibility for the entire contents of
   the patch, including any parts that were generated or assisted by AI
   tools or other tools.

- it is highly encouraged to provide background information such as the
   prompts that were used, and to not mix AI- and human-written code in the
   same commit, as much as possible.
---

Also, for lack of a better place, this sentence about requirements could
even extend to those spelled out by submitting-a-patch.rst.  For example,
"use the QEMU coding style", "split up long patches", "don't include
irrelevant changes", "write a meaningful commit message" all serve as
indicators that contributors have properly reviewed and understood any
generated output.

I like the idea that the concerns are split between the exception process
(assessing risk in general) and regular review (assessing code quality of
specific contributions).

Either way, I agree that there is room for clarifying the policy even further.

Thanks,

Paolo

> If you don't want to say "copyright or license status" here, referring
> to "DCO requirements" would have the same effect (because we do have
> the explanation you quoted).
> 
> Kevin
> 
> 
> 


