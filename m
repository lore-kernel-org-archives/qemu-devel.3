Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED362C3ABA9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9h9d-0000ee-Sl; Tue, 29 Apr 2025 05:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9h9O-0000Mo-46
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9h9J-0004ov-N7
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745918466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aHfeK0iRENAZvPB0wFI0MJMrmwrjjIvZZ1zbZiZC1lU=;
 b=MJJsi0uAmJo/HWUUFxHymphFOXSORWi3DQndzax+hi3D456ueqMiulGC7w5CrbahdzlsZ3
 c12AFHaQBST1TuiERfdgxquTmzyCuftYYcDXJGs0Y1NBXTAew0IfwiKe92PfWhyb9Y8+Kq
 kGK7nex1nygIFNO7IUH6psup1ZDO9JQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-1BVga2-rOXaPKj-S5-3vMA-1; Tue, 29 Apr 2025 05:21:03 -0400
X-MC-Unique: 1BVga2-rOXaPKj-S5-3vMA-1
X-Mimecast-MFC-AGG-ID: 1BVga2-rOXaPKj-S5-3vMA_1745918462
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39979ad285bso2662896f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 02:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745918462; x=1746523262;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aHfeK0iRENAZvPB0wFI0MJMrmwrjjIvZZ1zbZiZC1lU=;
 b=wRH6FLOpzqArWbQpm0a8XEYUeN21mALYpZkO6kfWf3Nn7rXmG1LBPCsji5IQzCnscw
 kHBUfwD1Z9JU0RCsDN4OOYmFwRFPnnI/mEjhwoSk2jjHBb6GQv7I7bYq+Gx2qcNZYxs0
 UMy6Sqc0OpCOOaTcT2YPljT/HemvPhPzs6lRYtnOCgF/yzpSTNPUSIEDdizzl9fVj42G
 oUXc8Q7DuKs3HfqNxxEtsSy1vB3/4qjLOHLbYRMI8P782OH0RCRINR5CSx+70e0fqnxD
 kHNy1/76zl6crehogYgKRDUPVinLzGTjVP3ZC5C4Vn9SjdR2ipXN2ZZmBfP1t+U8w1p0
 RKnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4hdw+SDCycI9yCSoIa666Lrk2gRSh8tSW/Tf6PDTiUO5K7qGv9s0aR70dPfnTXn+unF5YWGK5oByO@nongnu.org
X-Gm-Message-State: AOJu0YxapgmQ/FlP9DcnonrVjnbIu6mIwlC573cod9N7yQ0Knm7jHbs1
 wmKRYH3fjBB7orEZljsaerCavLQdQbB0hEnBoWyA7H8AASNf0Fpi83AZezMffqOiA+pcIb1CotB
 ub4EEbZKNXfp1Ep5VumCji/G3/Ws+BRMY7T5OiQQxfS/cVhiKapOd
X-Gm-Gg: ASbGncs0f6W8xlLeGx6f2Yh0NmwFlGn4sqp1K+4LzlTpLDAfmv09j24zQ1XycCrrXkl
 KdRGGDxaoihyv7+avyabAu+7HDLEdsC7u102iyaCazLuQ8PA6qyYsyq3z1yzgsnfwCzk9TnRKoR
 AneaChmng5+0D27wZjm1cG0XcGTEGViRjJMySxXG2Ri0Cxq7X5I+3PMqI/jGfSEEqsmA2SQrVfB
 fZZu6j8Ikgns1d8MlW+hVby9hk7kl9oC2VkEkVqljE4svvZbxFCqJQE3Vcv4F5awqfcaZJptS4/
 m1QT9czrBGIeq26yOVmwGRwYGCfuXFhE59FqNy2T
X-Received: by 2002:a5d:6911:0:b0:39c:2688:6edf with SMTP id
 ffacd0b85a97d-3a0891b17d2mr1708567f8f.14.1745918462401; 
 Tue, 29 Apr 2025 02:21:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG1AsZvaaYgFNt/DG1PRCDk1TReF+NZYt1UghF6u6jRbgfjZBtW8DFQo5QC/AlszlsFDLseQ==
X-Received: by 2002:a5d:6911:0:b0:39c:2688:6edf with SMTP id
 ffacd0b85a97d-3a0891b17d2mr1708544f8f.14.1745918462005; 
 Tue, 29 Apr 2025 02:21:02 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbefc0sm13754065f8f.51.2025.04.29.02.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 02:21:01 -0700 (PDT)
Message-ID: <3024f643-f4df-4342-8d9f-d5929e3ec2e5@redhat.com>
Date: Tue, 29 Apr 2025 11:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, jsnow@redhat.com, philmd@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org> <aA9ChuXrkmx1Igy5@angien.pipo.sk>
 <8734dswnm3.fsf@pond.sub.org>
 <2cc27344-8cfd-4435-9d41-79b86f61d537@linaro.org>
 <875xinnzok.fsf@pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <875xinnzok.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29/04/2025 10.23, Markus Armbruster wrote:
...
> I don't wish to derail this thread, but we've been dancing around the
> question of how to best fix the target for some time.  I think we should
> talk about it for real.
> 
> Mind, this is not an objection to your larger "single binary" idea.  It
> could be only if it was an intractable problem, but I don't think it is.
> 
> You want the single binary you're trying to create to be a drop-in
> replacement for per-target binaries.
> 
> "Drop-in replacement" means existing usage continues to work.
> Additional interfaces are not a problem.
> 
> To achieve "drop-in replacement", the target needs to be fixed
> automatically, and before the management application can further
> interact with it.
> 
> If I understand you correctly, you're proposing to use argv[0] for that,
> roughly like this: assume it's qemu-system-<target>, extract <target>
> first thing in main(), done.
> 
> What if it's not named that way?  If I understand you correctly, you're
> proposing to fall back to a compiled-in default target.
> 
> I don't think this is going to fly.

I tend to disagree. For normal users that consume QEMU via the distros, the 
check via argv[0] should be good enough. For developers, I think we can 
assume that they are adaptive enough to use an additional "-target" option 
in case they mis-named their binary in a bad way.

> Developers rename the binary all the time, and expect this not to change
> behavior.  For instance, I routinely rename qemu-FOO to qemu-FOO.old or
> qemu-FOO.COMMIT-HASH to let me compare behavior easily.

Developers should already be aware that this can cause trouble, since e.g. 
the qtests are deriving the target architecture from the binary name 
already. See the qtest_get_arch() function.

> We could relax the assumption to support such renames.  Developers then
> need to be aware of what renames are supported.  Meh.
> 
> The more we relax the pattern, the likelier surprising behavior becomes.
> 
> We could mitigate surprises by eliminating the built-in default target.

Just print out a proper error message if the target cannot be derived from 
argv[0], pointing the users to use "-target", and we should be fine.

And if someone renames their "qemu-sytem-aarch64" symlink to 
"qemu-system-x86_64" and still expect to run aarch64 images that way, that's 
just plain stupidity.

> Users invoke their binaries with their own names, too.  If Joe R. User
> finds qemu-system-<joe's-fav-target> too much to type, and creates a
> symlink named q to it, more power to him!

They can also either use shell aliases or short shell scripts to achieve 
that goal, so that's not really a show stopper.

> Distributions have packaged renamed binaries.  qemu-kvm has been used
> quite widely.

Yes, and QEMU already checks for that naming in configure_accelerators() ... 
so that's rather another indicator that we can go with configuration via 
argv[0] :-)

> In neither of these cases, relaxing the pattern helps.
> 
> The least bad solution I can see so far is a new option -target.
> 
> Instead of turning the target-specific binaries into links to / copies
> of the single binary, they become wrappers that pass -target as the
> first option.  We need to make sure this option is honored in time then,
> which should be easy enough.
> 
> If you invoke the single binary directly, you need to pass -target
> yourself.  If you don't to pass it, or pass it late in the command line,
> you open up a window for interaction with indeterminate target.
> Target-specific interfaces could exhibit different behavior then, even
> fail.  That's fine under "additional interfaces are not a problem".
> 
> Thoughts?

Shell script wrappers always have the problem that they break the direct 
usage of debuggers like "valgrind" or "gdb" with the target binary, so 
that's also not the best solution.

I'd go with Pierrick's idea to try to determine the target via argv[0]. And 
for people who really want to rename their binary in a way that makes it 
impossible to determine the target automatically, just provide the "-target" 
option as fallback solution, too.

  Thomas


