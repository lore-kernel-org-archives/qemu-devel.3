Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C95C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77Pl-00016o-LU; Thu, 17 Sep 2026 04:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x77Pj-00014L-BY
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x77Pf-0002Wt-Kr
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789633448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mjRxrr8bXpQ+C+RspEvvJUmTW6jnsH/Jva0+1T6sCL8=;
 b=OqK4McxQVWhQCSDKNe3J9g/GuXlyINRYfaAQo57iG5Ys5ngziH1uF+uqZOm4eOHbPKTWLv
 jVWqMfx4sNJcVyF1FPv3eEoewHpoi69kzUM8gv7TLbZ21GWmyWlrXMX3k7eqxI91JFJGCl
 pL0lN8cf4rc4xSz7eqlcku2TYOeZeSc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-VIPy0ZjFPzCPBw7MF-QXFQ-1; Thu, 17 Sep 2026 04:24:06 -0400
X-MC-Unique: VIPy0ZjFPzCPBw7MF-QXFQ-1
X-Mimecast-MFC-AGG-ID: VIPy0ZjFPzCPBw7MF-QXFQ_1789633445
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4870af30a85so289894f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789633445; x=1790238245; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mjRxrr8bXpQ+C+RspEvvJUmTW6jnsH/Jva0+1T6sCL8=;
 b=mdC4ZC4D6aBWIAm4CHu+EWT0T4EuAmu/JM1pDWQFg3bV/YaDenxhYAnlXRjI/65LJ0
 BSeds9TzqibnKMBJeYuQg2NYaQiuDDP7rOzph8r4bA4wswf6eJG43MAp53mg2ZqFb/lv
 xt5ThDMhxX1QJA77reX4TJkZ46l44hrPUZi2R2oYEdOwvypawipYflNXw1nWawuTkLMn
 41101EZwOtP+t2uNqEz+PAOjWvJc9WA1RBOmedbxEvQ/UKocrmwAjOkbTLyDFbyTYDIa
 qR2n/i3T8y9R0RuVkCtkP0y6CC8j/H4DuVdC3JxCiSXsjtTcida360jfU06IC3zRyiR+
 Ta8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633445; x=1790238245;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mjRxrr8bXpQ+C+RspEvvJUmTW6jnsH/Jva0+1T6sCL8=;
 b=sPV9qjiQIFff8uusj/1Bd3wofQ/v1n0wKgbnpYHNiLsmNsUkbJXs7k6Etd96hRe9Io
 rfIYpwhuTGe8O3FSb0jNo3aeT3HwKhHOjGlJw2E3d5YMzKpPG6XFzs0F6anIQKsCf/j2
 MMaqG8aLFpXWuiUwoazCseVnBOsmRZx6tkV9oFxfvs3GZNZOvxu69QWf5AO990oiYUlB
 x5CXTjHKfpFd4ZlzwXeqibDysIujxFn2d42SX6lcZE7WqJ5+1gLT+kg5mLZ+QzJOVgfY
 IjdDwxmHOmurkJcAeXSUBPY5EZW+eT8Yuwn6tHhTHTShs6yTsrs7P/+MMnchgFwGOLlO
 jG8Q==
X-Gm-Message-State: AFuF++nA4ylB3xMujxsCh7GiclDyxHvbOZa9vZ3IUMO0Z+pFtYU8/MEj
 c3uKZubpiC553qa6ZlEtWapsR/GXXItqO1yEksZ40SnuEUZdaZDyW4jeYfyIU9zsDTqvJa/PfD0
 wd6yoDIqWyWqLibzPFOl2lQ/lZrDkep4s2KZktooNruwm211jzSlCLwyt
X-Gm-Gg: AYBFou22Ad5tDz9LANVnSDCasBSPIYE34mjlUJjtIBY6bX3XPvrjFbpY6sHStHYIWDS
 cluKlry4Hi6y+GrF6mPYrilHiNsy6cxkvNWsPAFKh20Fa+wjxHe4P6mDDz6qpH0ll9bT3eJNNZi
 z9KdqXH/Evu+ZSa2ud3Gqtjwzpc+qWUUy78Z2gT0GCKl10ZKWtkGrgGY4EyUSH00rzfqwfWri1N
 eooo9TFyO5G9uWSD2gKWAEDTnn/Ii6V7vXpwfGgz1kwN9dhasNHvgz0E4OJpFx8uvKdAw7xo+WC
 GCe1uoroQxHhe2RDQsUURis2BKD0trsYBTf1Lwp6tc/Tc3z9sWWQKQZ4F+7m1yPewT+gAjorww=
 =
X-Received: by 2002:a05:6000:1ac8:b0:487:fb2:1a0f with SMTP id
 ffacd0b85a97d-48713aff89bmr3728840f8f.6.1789633445151; 
 Thu, 17 Sep 2026 01:24:05 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac8:b0:487:fb2:1a0f with SMTP id
 ffacd0b85a97d-48713aff89bmr3728809f8f.6.1789633444687; 
 Thu, 17 Sep 2026 01:24:04 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fa70sm13366378f8f.9.2026.09.17.01.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 01:24:04 -0700 (PDT)
Message-ID: <b6f9631d-a086-435a-be47-3092bfc426ce@redhat.com>
Date: Thu, 17 Sep 2026 10:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] Add GSoC 2026 wrap-up post
To: Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>,
 Aadeshveer Singh <aadeshveer07@gmail.com>, i@uchout.moe, niko.ramak@gmail.com
References: <20260915153326.90014-1-stefanha@redhat.com>
 <CAGxU2F6MSE3sskAhXOjFUu7QQwSBYWr-Qv5VCsYBpjYLQu8drA@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAGxU2F6MSE3sskAhXOjFUu7QQwSBYWr-Qv5VCsYBpjYLQu8drA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17/09/2026 09.42, Stefano Garzarella wrote:
> On Tue, 15 Sept 2026 at 17:34, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> Google Summer of Code 2026 has completed and it's time to showcase the
>> projects that QEMU's 4 contributors worked on this summer.
>>
>> Cc: Tanish Desai <tanishdesai37@gmail.com>
>> Cc: Aadeshveer Singh <aadeshveer07@gmail.com>
>> Cc: i@uchout.moe
>> Cc: niko.ramak@gmail.com
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>> Aadeshveer, Nicola, Tanish, and uchouT: Feel free to suggest edits!
>>
>>   _posts/2026-09-15-gsoc-2026-wrap-up.md | 96 ++++++++++++++++++++++++++
>>   1 file changed, 96 insertions(+)
>>   create mode 100644 _posts/2026-09-15-gsoc-2026-wrap-up.md
>>
>> diff --git a/_posts/2026-09-15-gsoc-2026-wrap-up.md b/_posts/2026-09-15-gsoc-2026-wrap-up.md
>> new file mode 100644
>> index 0000000..c652251
>> --- /dev/null
>> +++ b/_posts/2026-09-15-gsoc-2026-wrap-up.md
>> @@ -0,0 +1,96 @@
>> +---
>> +layout: post
>> +title:  "QEMU Google Summer of Code 2026 project report"
>> +date:   2026-09-15 07:00:00 +0000
>> +categories: [internships, gsoc]
>> +---
>> +QEMU participated in [Google Summer of
>> +Code](https://summerofcode.withgoogle.com/) 2026 with 4 contributors working on
>> +open source internships from May through August. The contributors gained
>> +experience in open source software development working on 12-week projects.
>> +
>> +This post covers the GSoC projects that QEMU had this summer.
>> +
>> +## Fast Snapshot Load in QEMU (Aadeshveer Singh)
>> +When virtual machine snapshots are loaded by QEMU, the entire contents of RAM
>> +and all device state is loaded before the virtual machine can start executing.
>> +A lazy approach is actually possible where the contents of RAM are loaded
>> +on-demand when accessed by the virtual machine. This can significantly speed up
>> +snapshot load times since virtual machines may have a large amount of RAM and
>> +loading it upfront takes time.
>> +
>> +Aadeshveer implemented fast snapshot load by taking advantage of QEMU's
>> +postcopy migration infrastructure, which monitors RAM accesses using Linux
>> +userfaultfd(2) so that memory pages can be populated on-demand. A thread is
>> +introduced to load RAM in the background while the virtual machine is already
>> +running so that on-demand loading is minimized (it affects virtual machine
>> +performance). Testing showed that fast snapshot load indeed provides a major
>> +speed up.
>> +
>> +Aadeshveer has written up a [project
>> +report](https://gist.github.com/Aadeshveer/6a16579aed93f5d483bbb9419ecd2211) as
>> +well as a [detailed
>> +journal](https://aadeshveer.bearblog.dev/a-summer-with-qemu/) if you would like
>> +to learn more. This project was mentored by Peter Xu.
>> +
>> +## Support x86 Process Context Identifiers (PCID) in COCONUT-SVSM (Tanish Desai)
>> +Process Context Identifiers are an x86 CPU feature that improves context
>> +switching performance. Without PCID, software has to flush the Translation
>> +Lookaside Buffer (TLB) when context switching so that memory translations that
>> +are no longer relevant in the new context are no longer used. PCID allows
>> +translations from multiple address spaces (contexts) to exist in the TLB and
>> +this can help if they are needed again in the near future.
>> +
>> +Tanish implemented PCID support in COCONUT-SVSM, software used by confidential
>> +virtual machines. This involved:
>> +1. Creating a [Rust crate for x86 CPUID feature descriptors](https://github.com/coconut-svsm/cpufeature) so that PCID functionality can be detected.
>> +1. Adding a PCID to each address space, including writing a bitmap allocator for the available 4,096 PCIDs.
>> +
>> +Tanish described this in more detail
>> +[here](https://tanish111.github.io/tanishd/blog.html). This project was
>> +mentored by Luigi Leonardi and Jörg Rödel.
>> +
>> +## Observability Support for COCONUT-SVSM (Nicola Ramacciotti)
>> +Troubleshooting confidential virtual machines can be challenging because the
>> +host is untrusted and does not have visibility into logs, traces, etc from
>> +inside the virtual machine. Instead, an operating system running inside the
>> +confidential virtual machine could extract logs and the new Observability and
>> +Configuration Protocol (OCP) has been defined for this purpose.
>> +
>> +Nicola implemented OCP in COCONUT-SVSM, creating the interface that software
>> +inside the guest can use to read logs. A Linux device driver was also
>> +implemented together with a userspace utility called svsm-tools that exposes
>> +OCP functionality to list, read, and write data.
>> +
>> +Nicola published a project report that goes into detail
>> +[here](https://github.com/n-ramacciotti/GSoC-2026-ocp-svsm). This project was
>> +mentored by Stefano Garzarella, Gerd Hoffmann, and Joerg Roedel.
> 
> nit: since we had "Jörg Rödel" in the previous section, I'd use the
> same in both sections.
> 
> Anyway, it's really a minor, LGTM:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Thanks everybody, I've pushed the article now to the repo with the fixed name:

  https://www.qemu.org/2026/09/15/gsoc-2026-wrap-up/

  Thomas


