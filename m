Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF16C27C55
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:29:26 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFgNW-0008PP-7z; Fri, 07 Jun 2024 16:40:02 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jfehlig@suse.com>) id 1sFgNU-0008On-Fd
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 16:40:00 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jfehlig@suse.com>) id 1sFgNQ-0007oS-Go
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 16:39:58 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2eab0bc74cdso26423301fa.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717792794; x=1718397594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l52WnzWelLPTDbeOiU1TA3yfGz1uBJsv1xjkrNEb44E=;
 b=ULrrJWuFn1EzJjeuFStZ9l9wd/6KuKTUyb1F5oL5AVyEk0R2DVIsJH8EFaL/+otaMD
 BsrYp0zIOx0u4qOXRxtBXgrTBUgQ9ArrbyNlAIgnk2hasD6yhINBIYiromf12v20Lrti
 yAWSCWMeBS7kp/05bg7sVzLDkE+ao/mC3nT2vhXEgNoKZHSRw9+XrGZvHp+DgzM5IfWt
 V9Ml4ztT2Ta9uN9ajjhTN0m0OIfuBG1CsxD2MjkBiGHTuymzQ6x2FeEnqZ0lSjmvq+qd
 V3MbcJJfpmCpPCDGsVQbWPyCmwxhCfogTB2WaVurUmA2d/CAqdXyPoJnJUuKDxYdPfeD
 QmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717792794; x=1718397594;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l52WnzWelLPTDbeOiU1TA3yfGz1uBJsv1xjkrNEb44E=;
 b=iUdgTfJ4f8jh3S7efT7b4MmABBsHL533LgMrryX0NtBjctsOJNqJh46XK/W/J+KEFF
 m4BQi7TpgADdma7pO8oD6RIlWTSa+0GVmL9zDlp7L4SGwWUuBj7LB58PYLzzz7zMpO5s
 d3LOa97Hdhx1ZgI0b2uhQHIHtDIAAtLtfbw0nKdF0HuIO5Ho1BuNyj9m2NpOjVKueVBc
 zvKZ5s1pprADLk/H4D1jZEm8Bvc6wpALXOhjQRnmHXtpVn1hBuxuySUxP+ZT6peSgt/K
 YcFDFVJUQin7OUKK7yv3pcKC6wNHngenwFfLDbfY2QFJkdakM/2O1qQ8CUj7mVWh57Bz
 2UZQ==
X-Gm-Message-State: AOJu0YwfSMDROUzVt9M4VD+ZuNE8CSMFhwWXj4RPJpq3Gnat2uHV80ln
 HgYP/4p7gsr1ZNpYGnN9/TFOvjCVYxOwBWwFZDlnGGMke8TVO5h5j8uCIVJ0UqE=
X-Google-Smtp-Source: AGHT+IHn0OmKfhHnUepisC7P9SesLiCap7PZ3LMpY+DMmZum3vVU0YvZO9BbDbEHq4+1bo/chHL4mA==
X-Received: by 2002:a2e:860b:0:b0:2ea:7ccd:10a7 with SMTP id
 38308e7fff4ca-2eadce7f92dmr20949581fa.45.1717792793656; 
 Fri, 07 Jun 2024 13:39:53 -0700 (PDT)
Received: from [192.168.1.246] ([192.150.157.228])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b7a225b969sm997253173.59.2024.06.07.13.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 13:39:53 -0700 (PDT)
Message-ID: <1d2bc62f-421f-416d-9ef2-0536e2fe54bc@suse.com>
Date: Fri, 7 Jun 2024 14:39:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to precopy
 file migration
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de> <Zl9_ZiC6-743ZosG@x1n>
 <87y17gwq5g.fsf@suse.de>
Content-Language: en-US
From: Jim Fehlig <jfehlig@suse.com>
In-Reply-To: <87y17gwq5g.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::22c;
 envelope-from=jfehlig@suse.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/7/24 12:42 PM, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Thu, May 23, 2024 at 04:05:48PM -0300, Fabiano Rosas wrote:
>>> We've recently added support for direct-io with multifd, which brings
>>> performance benefits, but creates a non-uniform user interface by
>>> coupling direct-io with the multifd capability. This means that users
>>> cannot keep the direct-io flag enabled while disabling multifd.
>>>
>>> Libvirt in particular already has support for direct-io and parallel
>>> migration separately from each other, so it would be a regression to
>>> now require both options together. It's relatively simple for QEMU to
>>> add support for direct-io migration without multifd, so let's do this
>>> in order to keep both options decoupled.
>>>
>>> We cannot simply enable the O_DIRECT flag, however, because not all IO
>>> performed by the migration thread satisfies the alignment requirements
>>> of O_DIRECT. There are many small read & writes that add headers and
>>> synchronization flags to the stream, which at the moment are required
>>> to always be present.
>>>
>>> Fortunately, due to fixed-ram migration there is a discernible moment
>>> where only RAM pages are written to the migration file. Enable
>>> direct-io during that moment.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>
>> Is anyone going to consume this?  How's the performance?
> 
> I don't think we have a pre-determined consumer for this. This came up
> in an internal discussion about making the interface simpler for libvirt
> and in a thread on the libvirt mailing list[1] about using O_DIRECT to
> keep the snapshot data out of the caches to avoid impacting the rest of
> the system. (I could have described this better in the commit message,
> sorry).
> 
> Quoting Daniel:
> 
>    "Note the reason for using O_DIRECT is *not* to make saving / restoring
>     the guest VM faster. Rather it is to ensure that saving/restoring a VM
>     does not trash the host I/O / buffer cache, which will negatively impact
>     performance of all the *other* concurrently running VMs."
> 
> 1- https://lore.kernel.org/r/87sez86ztq.fsf@suse.de
> 
> About performance, a quick test on a stopped 30G guest, shows
> mapped-ram=on direct-io=on it's 12% slower than mapped-ram=on
> direct-io=off.
> 
>>
>> It doesn't look super fast to me if we need to enable/disable dio in each
>> loop.. then it's a matter of whether we should bother, or would it be
>> easier that we simply require multifd when direct-io=on.
> 
> AIUI, the issue here that users are already allowed to specify in
> libvirt the equivalent to direct-io and multifd independent of each
> other (bypass-cache, parallel). To start requiring both together now in
> some situations would be a regression. I confess I don't know libvirt
> code to know whether this can be worked around somehow, but as I said,
> it's a relatively simple change from the QEMU side.

Currently, libvirt does not support --parallel with virDomainSave* and 
virDomainRestore* APIs. I'll work on that after getting support for mapped-ram 
merged. --parallel is supported in virDomainMigrate* APIs, but obviously those 
APIs don't accept --bypass-cache.

Regards,
Jim

> 
> Another option which would be for libvirt to keep using multifd, but
> make it 1 channel only if --parallel is not specified. That might be
> enough to solve the interface issues. Of course, it's a different code
> altogether than the usual precopy code that gets executed when
> multifd=off, I don't know whether that could be an issue somehow.


