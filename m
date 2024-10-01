Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDD0CEACDB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveEv-0007TN-5A; Tue, 01 Oct 2024 10:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sveEr-0007Bq-QK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sveEp-0005qb-VW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727794350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ahsPVwE3aZVS2Nh93bi8X9KNy+tszfszHqp/Re/xH34=;
 b=genEOOL1F/iO80MXYGOY9DS/rpOXSYnXHot81Q3pyxbwHtYCUuBfVLudntYNQMV7gxNsbv
 mvnZDHsneje3jDzeVfNgzxbS1Cpz+V+S6dDVJbA46mFx5F1ByvZgp2vXSFF8FYZC9zWCg9
 nGjnkaCbSEMkdfEYSHRetP3Dlz/+cvo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-YAeVAHoeNgKWihifoihPmQ-1; Tue, 01 Oct 2024 04:28:54 -0400
X-MC-Unique: YAeVAHoeNgKWihifoihPmQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37cc63b1ec3so2838493f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 01:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727771333; x=1728376133;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ahsPVwE3aZVS2Nh93bi8X9KNy+tszfszHqp/Re/xH34=;
 b=uZSULhZYU9uzEW3Zcwr4JYd6YbDLoWH0ZNQDIfcf1Gjc96pcliUutiPw7RKKFsjclG
 TIIYM0bTC1tTTxL4h4jH4V3y1e/4uIv+bR7xa9I+NWol6JMUvOFgPwe9flsa+PS1CBnR
 fCpVFXKehTnMbidDTudxVLyOVqW9wGETEvGD0o6AFweA9Znxo20pocVxtD3CeLMpuKgj
 Sm6iNdRuL8uEMksFhOBKnthJG+wPHGV5pl32Ao8kbpoEUaj3mXAMncXSwafYCvsCGEHV
 t0lex9uD0LQdzSvr9e4wsUqoTzDSPUOidHdNaUp21t7p46F9gNxO6k50Mf2BCIQEvwnl
 BvKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGZMoghuhs15cyVIC/XgM4z8dIbTy+lEF/iB52dEAw4sDRgL8Nkl0LGHCyMp+JermyD//blNBfgj7p@nongnu.org
X-Gm-Message-State: AOJu0YwRcl+dhueBVtzRJmOKvQQjZWFi3PGkVwU+/SRoEZ8OMHMkgpZ4
 uwCDoQIPbkKG15MYjEFNJZb4t4cT0UplmzobhyTZlaOFKttjVP86lFY7Rh+M1ZxYwehFqDmR7HS
 SV3rA9+6HzwKQjuW5SaUZp0c1uT8pFHXt/M5peOEH94ooYUomiVTN
X-Received: by 2002:adf:f78c:0:b0:371:844f:e0c with SMTP id
 ffacd0b85a97d-37cd5a83207mr7915259f8f.10.1727771332929; 
 Tue, 01 Oct 2024 01:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOJOck8e6eAo54lmyt4BwiMF8ohVhoZ8cevj620MMtG0S/Zvcqhl32Arf5BRN1mpRWTBKjJw==
X-Received: by 2002:adf:f78c:0:b0:371:844f:e0c with SMTP id
 ffacd0b85a97d-37cd5a83207mr7915245f8f.10.1727771332481; 
 Tue, 01 Oct 2024 01:28:52 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.43.71])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cdddd86c7sm8680182f8f.26.2024.10.01.01.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 01:28:52 -0700 (PDT)
Message-ID: <959ad3a2-505b-4d43-878f-027e359e8d54@redhat.com>
Date: Tue, 1 Oct 2024 10:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Minimum sphinx version?
To: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>
References: <CAFn=p-bfv=uRCGzODQDyK4mO1ct-7tG3REfN9pm0o=n2GBGKug@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFn=p-bfv=uRCGzODQDyK4mO1ct-7tG3REfN9pm0o=n2GBGKug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/30/24 19:16, John Snow wrote:
> The current reality is that Sphinx 3.4.3 is our minimum because RHEL 9 
> offers that as the distro package and I have not dared bump our version 
> beyond that for fear of disrupting our ability to build docs on RHEL 9 
> without internet.
> 
> What I'd like to ask is: How adamant are we that we can build docs on 
> older platforms? Do we consider it part of our platform promise? Can we 
> bump Sphinx to a slightly newer version at the expense of offline doc 
> builds for RHEL 9?

Could we stop building QMP docs, if Sphinx is too old?  While at the 
same time keeping the same 3.x version and the ability to build man 
pages, which is the really important part.

It should be as easy as adding a -D option to SPHINX_ARGS based on 
sphinx_version in docs/meson.build; bonus points for adding a docs-qmp 
feature option, like

enable_docs_qmp = get_option('docs-qmp') \
   .disable_auto_if(sphinx_version.version_compare('<4')) \
   .allowed()
if enable_docs_qmp
   SPHINX_ARGS += ['-Ddocs_qmp=1']
endif

and for adding enable_docs_qmp to the summary.  Unfortunately I don't 
think -D is accessible from rST, so you'd have to check it from the 
extension and put a "QMP documentation not included in this manual" 
placeholder.  Not great, I admit.

The current check on sphinx being 1.7 or newer is obsolute, but I won't 
remove it for now so that you already have the code to compute 
sphinx_version.

Paolo

> To reiterate: interactive developer builds from git or source tarballs 
> would continue to work (and be able to build docs just fine) so long as 
> --enable-docs is passed, but will require an internet connection to set 
> up the python environment with a new-enough sphinx. RHEL 9 rpm builds of 
> bleeding edge QEMU may be cut off from building docs in isolated 
> RPMBUILD environments unless that repository backports a newer sphinx 
> that can be identified as a dependency in the specfile.
> 
> How much of a problem do we consider that to be?
> 
> CCing the usual suspects.
> 
> --js
> 


