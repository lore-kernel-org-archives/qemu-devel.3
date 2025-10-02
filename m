Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1242DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4F02-00044F-0x; Thu, 02 Oct 2025 04:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4Ezu-0003zR-TG
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4Eza-0002gd-Ik
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759394919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=avQOUTJojsYQuh5+dan0gGJqnMUf2MO+ySd/Z4vZZwk=;
 b=LrGpYkiWiUHV7vzRszp1N5UpRtboZNOBPuWuFsAwNltlj01qAllsiG5RQFa4koTYeuMXIb
 prf/39vFyOIRgghYpAYqfN83wJcxg+ioUOJc2kArhoFJphIoOdLcOMXQKrgn/Z1MNPZGlC
 0Mkl6T1ZnYu1YFyo83L6oq50xTO6RFo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-mZILYNkeOqm2aZmpsm9cJw-1; Thu, 02 Oct 2025 04:48:37 -0400
X-MC-Unique: mZILYNkeOqm2aZmpsm9cJw-1
X-Mimecast-MFC-AGG-ID: mZILYNkeOqm2aZmpsm9cJw_1759394916
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso2544105e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394916; x=1759999716;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avQOUTJojsYQuh5+dan0gGJqnMUf2MO+ySd/Z4vZZwk=;
 b=KTZqEIc/xRUIf8Ul5+BabAKwtFaejVVkzSlV61rAUFNR1aPmQ+OKAAMg2wq+iiezZ/
 RlwCrVFTlcYHRVU5VREkd5GVSEpjarG7YwqO71H9FiImBWJvhaqcZZ1Dthdzx61HY86o
 T57+5fX1CXOzuqZfLaUg/a66DXq8vrZ08oXe/JoTPL7XfhLhBBHxO7eBauk+pPNw7PFg
 RhukrVXhTuzvD9mKOh7eeZDL1hoRSiNv5z00DNLwUJJq+Pgt+YM5bWC/sT7y9l/mFGJH
 O19ct412K+IxwM0/tgAhaObZm2k8O2fPgPHRrBO8yOqYY83LZgv90Qh19YnAKOCcBUU/
 S6dg==
X-Gm-Message-State: AOJu0YxUTtN1RsN2d4y86Ym82p4y7mcu5MtYNst2jnzHsuCXOAB4JoUt
 wVHJyDaz5gqessggwTzSpBPX1FR9rEN5ilyN6cvpxXJ/3lByaqnf/tnBocOnwSnW+97Y7SDe1+i
 6hh4kO9sbE/Y09z+hHUely2WBWNgqhKQGS08s7sHGgnd2mrgkcSWWBo9j
X-Gm-Gg: ASbGncvvRXgf+P2ifdq+jI76LmSUDnEth1Yq5EJtDUobmdxkg+2owVma+0xSbiG5Te9
 XrTAsp/HZrM4giyXAn0NZ0l0vXFciBcmN556wz8iHI4jNNjHDttrQCiKseezDK6rOCHVNpJmIOy
 YYSq2pFaoza+ExQ5bUezTTvMPrx7KWs4gGGqypUTMf+1d4HCLpiDNudWs80e1Z7x6JiwEk2oS2R
 WzhltRI0CiQvdagZlA4icoSyWvDJfFZD2wg4exd9JIbpdpUyL3PyaJvfPhPAgoj3KF0UKJ6r2E5
 xfTmvMR7WokvKLPDPhwHxn75PVJkQdqUvW0a2RIcSiRQ2qkVQu/sPU3ZN2IP2W4BodJLsVotwZj
 k1lIHDwkP
X-Received: by 2002:a05:600c:1395:b0:46e:6d5f:f73 with SMTP id
 5b1f17b1804b1-46e6d5f1276mr7206535e9.3.1759394916417; 
 Thu, 02 Oct 2025 01:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIXRZRWeLhN+7E2NJU2loCIjlYeqZ0udza/+OMUVyjQ28j1TKjXFVwktNsj5v8EhJK0YlNeQ==
X-Received: by 2002:a05:600c:1395:b0:46e:6d5f:f73 with SMTP id
 5b1f17b1804b1-46e6d5f1276mr7206305e9.3.1759394916029; 
 Thu, 02 Oct 2025 01:48:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97f0sm2686271f8f.27.2025.10.02.01.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 01:48:35 -0700 (PDT)
Message-ID: <456eb13d-4d39-4418-a8ea-a54a923d426d@redhat.com>
Date: Thu, 2 Oct 2025 10:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
To: Steven Sistare <steven.sistare@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local> <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
 <d91186b6-24d9-4b3a-a4c5-d68445c267bb@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <d91186b6-24d9-4b3a-a4c5-d68445c267bb@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
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

On 10/1/25 21:24, Steven Sistare wrote:
> On 10/1/2025 3:07 PM, Steven Sistare wrote:
>> On 10/1/2025 2:56 PM, Peter Xu wrote:
>>> On Wed, Oct 01, 2025 at 08:33:52AM -0700, Steve Sistare wrote:
>>>> This patch series adds the live migration cpr-exec mode.
>>>>
>>>> The new user-visible interfaces are:
>>>>    * cpr-exec (MigMode migration parameter)
>>>>    * cpr-exec-command (migration parameter)
>>>>
>>>> cpr-exec mode is similar in most respects to cpr-transfer mode, with the
>>>> primary difference being that old QEMU directly exec's new QEMU.  The user
>>>> specifies the command to exec new QEMU in the migration parameter
>>>> cpr-exec-command.
>>>
>>> It turns out I was right where I replied to patch 5; this fails the Windows
>>> build.
>>>
>>> Smallest fix is to wrap qemu_memfd_create() with a CONFIG_LINUX ifdef,
>>> returning -1 to mfd otherwise.
>>
>> That does not make sense.  It already does that, which is why I used it:
>>
>> util/memfd.c
>>
>> int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>>                        uint64_t hugetlbsize, unsigned int seals, Error **errp)
>> {
>>      ...
>> #ifdef CONFIG_LINUX
>>      ...
>>      return mfd;
>> #else
>>      error_setg_errno(errp, ENOSYS, "failed to create memfd");
>> #endif
>>      return -1;
>> }
>>
>> Did the windows build fail due to a different error?
>>
>>> A better one is we only include cpr*.c in meson.build if it's linux.
>>> Personally I'm OK if we go with the smaller one as of now, however then it
>>> would definitely be nice to have a follow up series to reach the better
>>> solution, if that makes sense.
>>>
>>> Feel free to use "make docker-test-build@fedora-win64-cross" for verifying
>>> the changes.  I hope it'll work for you, even if for me currently it didn't
>>> work due to a gitlab.com dns resolution pulling dtc src, where I didn't dig
>>> deeper yet..
>>>
>>> The other thing is, this series doesn't apply on master branch.  I didn't
>>> feel confident to do it myself on the vfio change, please have a look on
>>> both issues.
>> Ugh, they renamed everything.  I will rebase and send V6.
> 
> Actually that was easy to resolve, not worth a V6?
> 
> In patch "vfio: cpr-exec mode", drop the change in container.c, and instead
> add MIG_MODE_CPR_EXEC to container-legacy.c here:
> 
>          if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
>                                        MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
>                                        -1) < 0) {
yes.

Thanks,

C.


