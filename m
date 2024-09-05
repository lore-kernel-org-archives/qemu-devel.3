Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE578CD5BA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 10:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smA6Q-0007gv-Et; Thu, 05 Sep 2024 06:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smA6L-0007TE-F9
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smA6J-0004Tm-RO
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725533550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B0mF0zGVDkmtou1ClNE8WVX2yLIgSaMVCuaiAAkLbOc=;
 b=DPpDg+DSiWVBL4t7wCpaKqOO+VigKtvPzlGkVm5uaGEwya4s+C6oi3nvw1Dy2mwLJRjCaX
 g2rlLTFjGcwA5kPvCFyhjOnDd8ZWcSiSnSIhtozR69+UL6jAYX827HpzZFGQBm/31y4EfK
 PwXIhke0JaoCMYm9OlxLWP/+Ka3Vu4w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-D3Mqkbb4Pf6QKJvg0YlWOg-1; Thu, 05 Sep 2024 06:52:29 -0400
X-MC-Unique: D3Mqkbb4Pf6QKJvg0YlWOg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a1d06f8e78so103722185a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 03:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725533548; x=1726138348;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B0mF0zGVDkmtou1ClNE8WVX2yLIgSaMVCuaiAAkLbOc=;
 b=cafLxstaRgul+FBfELmEt0wYCeXM+Nd2wlP/klzlQsK/EWAwtLee/OeFgtMGvJ5If1
 ix4nbhxERrK5511bYOjFBT5BCwhxqRWMm9OncpBTfOFuQo/SIf1eul6rXHP8t9I/ZI4d
 sZdBdZDv0/7tY/uueGw/vVe7M86jEU3tzyxXzPYmzfF+EbUYgU4a/CqRfLElOBLnaplp
 W0Ych4uU0kHS4gUlmlEpDhuOMzsS+8zpfJx6ettL2AVg5vNNkzc0HwrhUixDLmoEUOSt
 3zItNw8OG/xVH8Wc0mUt/HaQu8j2ISXx35exuYPtwx8BmbhDtnyoVYq+RPmcryVBKdpl
 M44Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6ygBd3uvWdgwmocBJtyYPzeDueW1pUxtgH3gGk9kstTcYLau0cG+2b2pMg9jAs38+K1hqt3BBeGri@nongnu.org
X-Gm-Message-State: AOJu0Ywxk8M2LGsw/loqHaR43MKIksHA73x2K1I3frkGOCtI4t+kVOPv
 krvJ3OPg8ag9SsHbk7W+vdPiJ1Ip/2/Sed/bJGn+8xHAEfTlVQ6+q6yhdsapRO1czfpbik3S9vO
 8Qv+dA1MKusfC0g35t3AoZOZzEHII0s23QWybZi52JefCAOnHN8Q0
X-Received: by 2002:a05:620a:4448:b0:7a7:fef9:f608 with SMTP id
 af79cd13be357-7a80426b4bbmr2552667085a.52.1725533548560; 
 Thu, 05 Sep 2024 03:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHehFEqRCCfH+BRtyuj8KZH6ZM1WIBTJ//JQD7WbutMYx49wVX77gEQxjT/geQsO8O/ZOgekg==
X-Received: by 2002:a05:620a:4448:b0:7a7:fef9:f608 with SMTP id
 af79cd13be357-7a80426b4bbmr2552664885a.52.1725533548164; 
 Thu, 05 Sep 2024 03:52:28 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-243-216.web.vodafone.de.
 [109.42.243.216]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98f00fcb1sm63932885a.120.2024.09.05.03.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 03:52:27 -0700 (PDT)
Message-ID: <881fcbd7-d78f-4b42-b1e7-f4321cc9dc2a@redhat.com>
Date: Thu, 5 Sep 2024 12:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/meson.build: Add more CONFIG switches checks
 for the x86 tests
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>
References: <20240904082116.209260-1-thuth@redhat.com>
 <37254a58-3f76-4c12-a2ae-0f2259e8bf9f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <37254a58-3f76-4c12-a2ae-0f2259e8bf9f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 05/09/2024 10.28, Paolo Bonzini wrote:
> On 9/4/24 10:21, Thomas Huth wrote:
>> When configuring QEMU with "--without-default-devices", currently a lot
>> of the x86 qtests are failing since they silently assume that a certain
>> device or the i440fx pc machine is available. Add more checks for CONFIG
>> switches here to not run those tests in case the corresponding device is
>> not available.
> 
> Is this enough to fix this:
> 
> # Check our reduced build configurations
> # requires libfdt: aarch64, arm, loongarch64, microblaze, microblazeel,
> #   or1k, ppc64, riscv32, riscv64, rx
> # fails qtest without boards: i386, x86_64
> build-without-defaults:
> 
> and add i386-softmmu/x86_64-softmmu to build-without-defaults?

Yes, together with some other patches that I sent to the list in the past 
days, this seems to work now:

  https://gitlab.com/thuth/qemu/-/jobs/7751500808#L5050

I just had to discover that I messed up this patch here (forgot to squash 
some other changes). I'll make a proper series out of the patches and send 
them out together again, including a patch to enable x86 in the 
build-without-defaults job.

  Thomas


