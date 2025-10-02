Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A191CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4F1I-0005x2-Rz; Thu, 02 Oct 2025 04:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4F1G-0005w3-Fj
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4F0v-0003Qr-1V
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759395006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BplH6H79asj3QgDZ6GHl1Wm2Xso7blJtDG4uvh6hEYc=;
 b=aK5kM7ius/qvUpjXLevkjI7dt46ByL5ja5fgVMAeNrMUEoz/g72Oa2imFYGaXrtVkCrm0e
 8IxpchFkaQLd5fJWTYbMFy58dSWoPWhil6m5TQ+uIlDFKRwAw28jtBWrgUqUeXk6iQdmd8
 GimOU9wn4vUVMgIEbGdwDK/ZZntaaX4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-R-hx4tovN_ifOWC4iv8GDA-1; Thu, 02 Oct 2025 04:50:04 -0400
X-MC-Unique: R-hx4tovN_ifOWC4iv8GDA-1
X-Mimecast-MFC-AGG-ID: R-hx4tovN_ifOWC4iv8GDA_1759395003
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ecdd80ea44so797980f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759395003; x=1759999803;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BplH6H79asj3QgDZ6GHl1Wm2Xso7blJtDG4uvh6hEYc=;
 b=nK66yIHKKsykTWIZ+d9zWJXNmpnyjF9NwIjMJVB2HKYpW05WyacNOVcr5+XNFHa4+G
 CMWXuL8wCi5p5m/ek8cqsM0DsZf9MN/uCtYfwO4+zoIb57kdqHCT3Gmh6UR2PIBLGDZ9
 mK79f8rCxL54C1XntIQBY57t/ExwzDkKKgLAexaTKEY64NxgXdLCfojyS0B7e87tSnH3
 mE2wQLsjwp8yFGulZJJyVIn9qaOOInLVvlYEyNwJhAgzGF2ui8t2mkYAAvnWebOi6zms
 LtF8jLWS3RbdM1CJABfLuAFPNielRzCx+leR4j8LxZIs+GlFGexKi9r2ahxxOsaCfr3x
 07kA==
X-Gm-Message-State: AOJu0YxVYtfXhP1tyDFzZeDIpuDYoTKCm3SL3EA8r+vCyFzIeJdPwRZk
 og2IZqJb7qHGuF2O2V95nH3A6l+4G1qVyWJCZViwoAu8WYM6QrZto7B2H9HhZlwtPpXD2+UAIOr
 LPNTWG+ePwSJDsrj8amZGyYCNfoRIUrIOIwGPF73FjS9WUea2Bv6LbI1I
X-Gm-Gg: ASbGncttZ1P6FkbJItygSplfHGFwS05XExM8CSg2m1tBQtpyRqKstzJThMsskg97DY9
 fIUqFt0RE1eMC45wHcIbr5nQTMAJuQVkNKRVOAf3lxklKNd1nvNAubKaMxf23FPu/SVtZNXhcLe
 5ePrOElx0CUBo3SN1ZLDXCFvf6Y0JzM87Gy2y7sJOtzFeiFH1DbaiBGxTHZqXwMB12a9ouqqlNh
 LsPSEYae/v/ovGUOFjb2igaJMB0Uo5PrpSoElxXT8XUP+h9u30Vi9BTSdIH8WFKG6lm/YyauY63
 SiuJF52UZJVx2fQb59CPlZCu4nRelg0zb2V/6dBDDJej70OC5mPCo4Bmra2LJbXHay+5Kifr+Ll
 iXCT4EmJa
X-Received: by 2002:a05:6000:4202:b0:3eb:ad27:9802 with SMTP id
 ffacd0b85a97d-4255d294cc2mr1756111f8f.2.1759395003311; 
 Thu, 02 Oct 2025 01:50:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCT18Cjx3n2nQSj5nN6qamP1R9IodHaaCNTCWWuzL/Ss5jbhhiwNGJ/7U498e8tldh1333Ww==
X-Received: by 2002:a05:6000:4202:b0:3eb:ad27:9802 with SMTP id
 ffacd0b85a97d-4255d294cc2mr1756091f8f.2.1759395002948; 
 Thu, 02 Oct 2025 01:50:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c3eca22sm54674635e9.4.2025.10.02.01.50.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 01:50:02 -0700 (PDT)
Message-ID: <b40b6df8-9f7b-4ec0-ae59-0ff15b913a02@redhat.com>
Date: Thu, 2 Oct 2025 10:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>, Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local> <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
 <aN2JE0D44AdV-qK5@x1.local>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aN2JE0D44AdV-qK5@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 10/1/25 22:03, Peter Xu wrote:
> On Wed, Oct 01, 2025 at 03:07:23PM -0400, Steven Sistare wrote:
>> That does not make sense.  It already does that, which is why I used it:
>>
>> util/memfd.c
>>
>> int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>>                        uint64_t hugetlbsize, unsigned int seals, Error **errp)
>> {
>>      ...
>> #ifdef CONFIG_LINUX
>>      ...
>>      return mfd;
>> #else
>>      error_setg_errno(errp, ENOSYS, "failed to create memfd");
>> #endif
>>      return -1;
>> }
>>
>> Did the windows build fail due to a different error?
> 
> https://gitlab.com/peterx/qemu/-/jobs/11566477462
> 
> See util/meson.build:
> 
> if host_os != 'windows'
>    ...
>    util_ss.add(files('memfd.c'))
>    ...
> 

Steve, you can test the windows build with :

--cross-prefix=x86_64-w64-mingw32- --disable-sdl --disable-docs

C.


