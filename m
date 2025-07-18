Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95B7C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 08:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucgAx-0005Y3-AB; Fri, 18 Jul 2025 04:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucgA5-0004fF-5M
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucgA2-0003Rq-TD
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 04:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752826177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DuTqUrOS2+eTUqjD1xeTjU//byX65LF2BvnlqEJg94o=;
 b=EAD24X2blYJGh5Elhu1+8T9vVxs3BSQ0U+EyBQaQZTRad6hDA5fALikHEga4WIEmxDHaO2
 qosMPy0GnP1qeaPkzPh4fx8ob5bDvG/t4LZOvKZoELtc+UovAKnWZFBcggn8scxsTx4IS+
 cZe9vs3yySDMT3fd7qF7wzOZuX/x0fA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-wGgzGRy7PWWMXkbf7qOCqQ-1; Fri, 18 Jul 2025 04:09:36 -0400
X-MC-Unique: wGgzGRy7PWWMXkbf7qOCqQ-1
X-Mimecast-MFC-AGG-ID: wGgzGRy7PWWMXkbf7qOCqQ_1752826173
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6069f1c97b3so1506501a12.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 01:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752826173; x=1753430973;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DuTqUrOS2+eTUqjD1xeTjU//byX65LF2BvnlqEJg94o=;
 b=Q5csNYruQOQvyIY/b491zyeNgEUdhzFOsJdP5QIIGuVb5Z4TfciiT4w7t5Dp+PcU8e
 yuAdWok4gDuhEOIZ2GFhGeCGAWL1cDzx7o8Rp3fKqbH8z4ndQLoA/IiFWXVPf+3CqDD9
 ATBDHyFSvT21+o8nvyLdDAJYQRgDD0Hp/dU55iniYysShDzHxtaOZZWMLpFD3nhSLee+
 Sk+hna/4n1Z69TZ9Syzoznkht0jyQRDwbCKIM4nyIO2ngcW5dOBHKdE6pkAL8CTSD+hp
 PC86I6Nz4twZE9dKC/29I0ly/LT+fY0Iv6bVF7q2c6Gd2yL7SUZR+3yzd1MzsLUnuXz8
 CiWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeunee/5agrOC4/mSnkULeF6I6/O/QzCzbyxZ+ejpNpBp9CnyUnpVTm7xZ1kapbEP/yt/my7MEL2Y1@nongnu.org
X-Gm-Message-State: AOJu0YxmSRQj6QcV+pHFofifEMmeJoBztae5rUEEVRbGkW9hEVOasltu
 Hw0PQXBcefMag5DM3VJWjvmUk35jFKnDlkvWhZoaPiMgurSy6mudInzWiChImIovUs3kkT3aV8o
 QqeBm/YgjG/BJkb4tr8IGtnpVSy7xNOJV6UN+m+K2rT4aXgHjNWUM6wQr
X-Gm-Gg: ASbGnctYFA4vB9f+VG4eQ9ZNyBFb3F0AWn9Zc+kO1rMitgMGXaM8v6Ys4jTwTkqJ5Dj
 BYf+XICYIABjDcvqaUNJ86CgnP+OKkZTxEga/OP2wWui8IC1oPXfX6/X59CWV7cFcswGG3rWVoV
 iEXDhLreo1nCMF5sMQmZ0rjf25hGDqiaUz+/JKh5dBngO2FF1BOryY5oxqqcFP4250B+qYMXzYT
 H9+1Xgp0fHhYPfehIbQ8BIDL85Fl1dg7aR+dAhzhMJPL9QteYLn5JkLB7asUsHR5xuZ02Y3uCyC
 tiglVUOrpTmHucQHCb8vT7ZD7vMZ6JdxUwN9rteplaU=
X-Received: by 2002:a17:907:e2d3:b0:ae0:1883:78ce with SMTP id
 a640c23a62f3a-ae9ce15657amr925201066b.47.1752826172873; 
 Fri, 18 Jul 2025 01:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaIU/XIr1gWEg05SCBQTK9iPlO05+q2JQOtJ8S7Rs2/Y0Y2zvP4fgJMjlpiAygeQyAsvHLZA==
X-Received: by 2002:a17:907:e2d3:b0:ae0:1883:78ce with SMTP id
 a640c23a62f3a-ae9ce15657amr925198566b.47.1752826172296; 
 Fri, 18 Jul 2025 01:09:32 -0700 (PDT)
Received: from [10.131.45.123] ([151.49.73.155])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-aec6c79a089sm76393466b.20.2025.07.18.01.09.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 01:09:31 -0700 (PDT)
Message-ID: <993ed8bd-a953-48db-b37e-42178cd0c4b1@redhat.com>
Date: Fri, 18 Jul 2025 10:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/6] target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20250717152316.353049-1-pbonzini@redhat.com>
 <20250717152316.353049-2-pbonzini@redhat.com>
 <df3745a5-28ab-482c-9fa1-434d2c0327de@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <df3745a5-28ab-482c-9fa1-434d2c0327de@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/18/25 09:21, Michael Tokarev wrote:
> On 17.07.2025 18:23, Paolo Bonzini wrote:
>> KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
>> cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
>> MSR and it makes no sense to emulate it on AMD.
>>
>> As a consequence, VMs created on AMD with qemu -cpu host and using
>> KVM will advertise the ARCH_CAPABILITIES feature and provide the
>> IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
>> as the guest OS might not expect this MSR to exist on such cpus (the
>> AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
>> are not defined on the AMD architecture).
>>
>> A fix was proposed in KVM code, however KVM maintainers don't want to
>> change this behavior that exists for 6+ years and suggest changes to be
>> done in QEMU instead.  Therefore, hide the bit from "-cpu host":
>> migration of -cpu host guests is only possible between identical host
>> kernel and QEMU versions, therefore this is not a problematic breakage.
>>
>> If a future AMD machine does include the MSR, that would re-expose the
>> Windows guest bug; but it would not be KVM/QEMU's problem at that
>> point, as we'd be following a genuine physical CPU impl.
>>
>> Reported-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> This feels like a qemu-stable material, is it not?
Yes, good idea.

Paolo


