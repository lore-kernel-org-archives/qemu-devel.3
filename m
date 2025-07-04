Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34A9C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXegg-0007O4-AY; Fri, 04 Jul 2025 07:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXegc-0007NM-9V
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:34:35 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uXega-0005L5-GI
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:34:34 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60789b450ceso1601971a12.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751628870; x=1752233670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0hJSZ3XLkgk7D6/XNauE9Wc2wgZX68HhPzxUxGOc3M=;
 b=Cm9FFSg+eeC/0VUQPWQEB4mOM39V5i3IAzfvlR6VaL5UW3+gv+9u/Zi1SBeRUtZFwD
 Ql1vtfvJ42is+GpA9kAsbkyd5V3iyE8Jzu9LmjKY9nyQLjXMaD8FvuxisDwEwxHJl9E7
 Yexzp+y+FXqSdb8a+/xZ286If9kMtLu6fCuzibh5fgDAG8G6nxru+wn3ZKGcQ50pEvJ3
 s+veuywLKGGVDpYTf6K2MvxDEZHHGEXsUC8yy11zHsbfxyDlFx1NMR+X8ALrLvH5587d
 pvmBmBa9pcxYEjpRlUrGXfby4YclRVkJsssNxSWUN75/FFNJLyzjfUX25q+Qq7rhhWuH
 egoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751628870; x=1752233670;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u0hJSZ3XLkgk7D6/XNauE9Wc2wgZX68HhPzxUxGOc3M=;
 b=t3cT8fDz0NZdMo5+fRshcyVSCw1i4GdKLO695FWewJLnXGJUbTTj71/FYfPDTBW1bz
 bs/jzPcvvzyqtoJnnfiJzRv5NooQALQH5FlgH5Rh1H2ymLJRKbN3s94BIPt5HlKmiJM+
 OCCFc79W7s2HMZbifhKAJAW0J66j+ZjnMpIMkB1DssfoPugv/0HLYjJooq6fFmjPXcnH
 I4eNxq0yYoaGp46X/1TzVjJf8KFAKVrQ5tzSphlO0aJDE5E0Acc6hD15ZSLMyei+SSO4
 oXbfJTv8qI1rcRNtaYj9IymRt0rJ9Umw6xwNDfMR92mj+Mh0yxkwldKdtY52BJNDQSFl
 FBJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv4zYkpI5EENq8IpfvgnVjLXVTopX5Aslnb/mP+d+g+X/E7T7RrGHii7ObDDdt3J04GFH7iKmejkPv@nongnu.org
X-Gm-Message-State: AOJu0Yxk19b7AGsM4nUlH4yKSJrhsxyn8LLzYWxbCQRc0b9RpwsUleqj
 OWnKkjkQ20HZTQVltJBQlzL3dNRqUUPaJgEyfl+OSL+RM+YHmlwDs0KlwM/dsN1Lt84=
X-Gm-Gg: ASbGnctzZildq+3UGQTsaiTaYryey7Rqo0XV2z/rseX3haPd05t+HVgCFlx7nogoROl
 YC8+ZUfJWMwYR7Km9+SOi3M/cIC9+NiFTGwq9VqxiTWmjjaSUJjIDWeiy/OL4XY1N6sQmWOkZpC
 0F6pDHWnhVgQjP5OiKWiBaYj8cJ7+dXcymi13aGJLvvuDb0bnWrtyFTSC6nIKkhASe1f29RnL7F
 Qfth+DMhWpjqR8Avd7VNOGvwcqJ3yI3eytqzs/6REcG7vmJUIpbXHDZ7K27lkdpi1UCI3ScBt1K
 ZI44dd+FnHvDk5Rtul7L9ZXS06OPAKQ1y3cjzANSvVAc+3zD89VVaoeTLvE7fDk=
X-Google-Smtp-Source: AGHT+IHYxEqW5R5HgqWUKoHZSuc0LMoUef4pAHeOo3QSZwYt0I3lBlWt0GESoeuwSSDKxbMpqY3byg==
X-Received: by 2002:a05:6402:358c:b0:608:f54b:5c81 with SMTP id
 4fb4d7f45d1cf-60fd2fae9cbmr1588223a12.1.1751628870477; 
 Fri, 04 Jul 2025 04:34:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fcb2f890esm1205681a12.61.2025.07.04.04.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:34:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C8BC25F8AE;
 Fri, 04 Jul 2025 12:34:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Peter Xu <peterx@redhat.com>,  David
 Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 02/39] system/memory: Restrict eventfd
 dispatch_write() to emulators
In-Reply-To: <4d57f96b-ee72-484f-a1f5-dadbf773ef64@intel.com> (Xiaoyao Li's
 message of "Fri, 4 Jul 2025 11:32:18 +0800")
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-3-philmd@linaro.org>
 <4d57f96b-ee72-484f-a1f5-dadbf773ef64@intel.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 04 Jul 2025 12:34:28 +0100
Message-ID: <871pqwb35n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/4/2025 1:32 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Commit 8c56c1a592b ("memory: emulate ioeventfd") added a !KVM
>> check because the only accelerator available back then were TCG,
>> QTest and KVM. Then commit 126e7f78036 ("kvm: require
>> KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH") suggested
>> '!KVM' check should be '(TCG || QTest)'. Later more accelerator
>> were added. Implement the suggestion as a safety measure, not
>> dispatching to eventfd when hardware accelerator is used.
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   system/memory.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>> diff --git a/system/memory.c b/system/memory.c
>> index 76b44b8220f..4f713889a8e 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -25,7 +25,7 @@
>>   #include "qom/object.h"
>>   #include "trace.h"
>>   #include "system/ram_addr.h"
>> -#include "system/kvm.h"
>> +#include "system/qtest.h"
>>   #include "system/runstate.h"
>>   #include "system/tcg.h"
>>   #include "qemu/accel.h"
>> @@ -1530,12 +1530,7 @@ MemTxResult memory_region_dispatch_write(MemoryRe=
gion *mr,
>>         adjust_endianness(mr, &data, op);
>>   -    /*
>> -     * FIXME: it's not clear why under KVM the write would be processed
>> -     * directly, instead of going through eventfd.  This probably should
>> -     * test "tcg_enabled() || qtest_enabled()", or should just go away.
>> -     */
>> -    if (!kvm_enabled() &&
>> +    if ((tcg_enabled() || qtest_enabled()) &&
>
> The FIXME provides two options:
> 1. change to "tcg_enabled() || qtest_enabled()"
> 2. remove !kvm_enabled()
>
> And as the FIXME said, it's not clear why under KVM the write would be
> processed directly. Now, the question becomes why under hardware
> accelerator is used the write would be processed directly instead of
> going through eventfd. I think it needs to answer this question when
> we do such change, and it's better to put the answer as the comment in
> the code.

Under KVM the eventfd notifications are sent directly from the kernel to
the relevant fd. There is no reason why under KVM you couldn't inject
the eventfds from QEMU but it would be a weird and sub-optimal setup.
KVM is perfectly capable of trapping the MMIO accesses in kernel.

I don't think eventfd's can be supported for HVF because I don't think
it has such a concept. For vhost-user devices they would then rely on
VHOST_USER_VRING_KICK over the socket instead.

>
>>           memory_region_dispatch_write_eventfds(mr, addr, data, size, at=
trs)) {
>>           return MEMTX_OK;
>>       }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

