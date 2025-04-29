Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E441C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 19:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9qxB-00068u-8m; Tue, 29 Apr 2025 15:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9qwr-00062n-M7
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:48:58 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9qwp-00045d-I4
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 15:48:57 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so5937154b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745956123; x=1746560923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CMRzedeakuNMxl6wu6ncrTAMeptIWNSN9/I21AMDMVI=;
 b=V3G6k+ZWA5fQR3Z8w+WAzqAa2WKutLVO9TnK67xkJpDzMj0KzA4tXWs1pDodSo+zUI
 YwZK4mS4HP4ZKeTGzA3Xr9jOJuV/iXcTKuEHJhtLJ+ia72pyBI+YPWCr3majU/XLgw4B
 2e4h26P7ziWcbsjtPgY/vGrq+p2k4VYFeHzlB7nv+HgGvKM0oRZc28lgJTJGDBNxPIxx
 R51PSBQ85tZ7TL2/TpokNnxgRbGO+ZZzIXedAOmkRYQDB+8CWbW6rP5/C91/D4gzDJMR
 eL215QHWB+S4MEbzVM+IZS0iHrhuQ0JY7OKrQgVpto49zFNjR2cOVsiluNCN8nmyInd9
 3Gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745956123; x=1746560923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CMRzedeakuNMxl6wu6ncrTAMeptIWNSN9/I21AMDMVI=;
 b=iskd1e/PefFRz4VBgQ8Qx8rJ/aAXB/KGOyFFNKP9SaxZRr6pVJp1wCKAfh8VXGdoju
 O5fDf9fcd4qNDpEJdF2+QjtFAhnne4lIv32ancExRpF46U8SaeZF+YcEheyA6dbVpir+
 jnUCTmSfudwsdoMAkvrzuYqNyZMPBLJWgucqYa+fCvrWJmP2UizObEG0TBceOwhLaIUz
 5hAKDOTisiGY74/ZynoJS/jAkPggRUW29z5ZCkbVhZb3nUe1StgRQMH5fQ1Q48EJVgE9
 ceCs0HFXz21Ao2jH75y9TAADPlcEI5yJsXelkprw6aV6r2oFAcwq/HgYdMp3Ea4E1cYU
 NRHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzyf1fVqGNgV6uJB0No6qoZvRg7pU80aVdaHAHLeoSNyarDyd/d30qqYBCEB1n1drG3zfrkYnPujml@nongnu.org
X-Gm-Message-State: AOJu0YyD/mOHZX4rul3/DjbhE1pUsxZGo1/IIkvQVXwegI7mpK7YoQgf
 nAzz1BQUeK6+4BSrf3Z2iHsdkMSePr8sRf8thUnUsVD/ctKGLW5vcaB1f/rRX1A=
X-Gm-Gg: ASbGncunGbVizTEMFPO597VMswZQItevGY4A+PD7OhAbZ2uw16oWcHGtnvxbvOwHbsX
 KEHI8ZNxLbxzk1j8FBmcKO0HTqFMgOOmpt46Qu5hSPMMODHT/hyQYeCPm5kCb9MdXGK22W1RSBV
 UhxM75PTQGaKrhYP3p4udkP8qNETy0a3ClA3HQ2nZlwbv15UEx94Cu0rIwQ4rzCJP7CYn4oBYYf
 +AR7yX8OViFlaLoWFwbL2vLfetqpulqf0/7Ibx4qtQJBEfSTjjxp+6o/YXndy+jiKSlYB5uJDLY
 kvQ8Nr2ocjS/sZsLJf4eF8RwPvc0BvYcv30r/ZU6SFD6HyHKTVZOJSD2RUQ3RJTS
X-Google-Smtp-Source: AGHT+IHeqZ9LHWUswqPgnndQQDC9RpY9WhX6v0bDVbYnMhglw33ul5fNQwJ/i8n77HijsOQAtPFWEw==
X-Received: by 2002:a05:6a00:22c9:b0:736:2d84:74da with SMTP id
 d2e1a72fcca58-740389a295bmr740576b3a.10.1745956122699; 
 Tue, 29 Apr 2025 12:48:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740399415bcsm69021b3a.73.2025.04.29.12.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 12:48:42 -0700 (PDT)
Message-ID: <407aa670-1f96-4284-80cb-6f2b37d65c93@linaro.org>
Date: Tue, 29 Apr 2025 12:48:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
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
 <3024f643-f4df-4342-8d9f-d5929e3ec2e5@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <3024f643-f4df-4342-8d9f-d5929e3ec2e5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/29/25 2:20 AM, Thomas Huth wrote:
> On 29/04/2025 10.23, Markus Armbruster wrote:
> ...
>> I don't wish to derail this thread, but we've been dancing around the
>> question of how to best fix the target for some time.  I think we should
>> talk about it for real.
>>

Sure, and no problem about that, that's welcome!
I'm not eluding the conversation, but I just feel that as long as we 
can't really build this single-binary and share this, it's impossible 
for people to try it and make a judgment based on rationale facts about it.

Opinions and taste matter, but it's even better when we all have the 
same thing and can try solutions and post facts instead.

>> Mind, this is not an objection to your larger "single binary" idea.  It
>> could be only if it was an intractable problem, but I don't think it is.
>>
>> You want the single binary you're trying to create to be a drop-in
>> replacement for per-target binaries.
>>
>> "Drop-in replacement" means existing usage continues to work.
>> Additional interfaces are not a problem.
>>
>> To achieve "drop-in replacement", the target needs to be fixed
>> automatically, and before the management application can further
>> interact with it.
>>
>> If I understand you correctly, you're proposing to use argv[0] for that,
>> roughly like this: assume it's qemu-system-<target>, extract <target>
>> first thing in main(), done.
>>
>> What if it's not named that way?  If I understand you correctly, you're
>> proposing to fall back to a compiled-in default target.
>>
>> I don't think this is going to fly.
> 
> I tend to disagree. For normal users that consume QEMU via the distros, the
> check via argv[0] should be good enough. For developers, I think we can
> assume that they are adaptive enough to use an additional "-target" option
> in case they mis-named their binary in a bad way.
> 
>> Developers rename the binary all the time, and expect this not to change
>> behavior.  For instance, I routinely rename qemu-FOO to qemu-FOO.old or
>> qemu-FOO.COMMIT-HASH to let me compare behavior easily.
> 
> Developers should already be aware that this can cause trouble, since e.g.
> the qtests are deriving the target architecture from the binary name
> already. See the qtest_get_arch() function.
> 
>> We could relax the assumption to support such renames.  Developers then
>> need to be aware of what renames are supported.  Meh.
>>
>> The more we relax the pattern, the likelier surprising behavior becomes.
>>
>> We could mitigate surprises by eliminating the built-in default target.
> 
> Just print out a proper error message if the target cannot be derived from
> argv[0], pointing the users to use "-target", and we should be fine.
> 
> And if someone renames their "qemu-sytem-aarch64" symlink to
> "qemu-system-x86_64" and still expect to run aarch64 images that way, that's
> just plain stupidity.
> 
>> Users invoke their binaries with their own names, too.  If Joe R. User
>> finds qemu-system-<joe's-fav-target> too much to type, and creates a
>> symlink named q to it, more power to him!
> 
> They can also either use shell aliases or short shell scripts to achieve
> that goal, so that's not really a show stopper.
> 
>> Distributions have packaged renamed binaries.  qemu-kvm has been used
>> quite widely.
> 
> Yes, and QEMU already checks for that naming in configure_accelerators() ...
> so that's rather another indicator that we can go with configuration via
> argv[0] :-)
> 
>> In neither of these cases, relaxing the pattern helps.
>>
>> The least bad solution I can see so far is a new option -target.
>>
>> Instead of turning the target-specific binaries into links to / copies
>> of the single binary, they become wrappers that pass -target as the
>> first option.  We need to make sure this option is honored in time then,
>> which should be easy enough.
>>
>> If you invoke the single binary directly, you need to pass -target
>> yourself.  If you don't to pass it, or pass it late in the command line,
>> you open up a window for interaction with indeterminate target.
>> Target-specific interfaces could exhibit different behavior then, even
>> fail.  That's fine under "additional interfaces are not a problem".
>>
>> Thoughts?
> 
> Shell script wrappers always have the problem that they break the direct
> usage of debuggers like "valgrind" or "gdb" with the target binary, so
> that's also not the best solution.
> 
> I'd go with Pierrick's idea to try to determine the target via argv[0]. And
> for people who really want to rename their binary in a way that makes it
> impossible to determine the target automatically, just provide the "-target"
> option as fallback solution, too.
> 
>    Thomas
> 

I agree 100% with what Thomas said.

Regarding the "Rename the binary and things should work", I was thinking 
of something like:
guess_target(argv) {
   binary=argv[0];
   if (binary.contains("qemu-system-arm")) {
     set_target(&target_info_system_arm);
   } else if (binary.contains("qemu-system-aarch64") {
     set_target(&target_info_system_aarch64);
   }
   unreachable("can't guess target from " + binary);
}

In short, detect "*qemu-system-{arch}*", with arch being one of the 
available architecture we added to the single binary.

In case someone wants to stress this piece of code by doing:
$ mv qemu-system qemu-system-arm-or-qemu-system-aarch64
Well, we can take the first occurence and call it a day.

To disambiguate a target, we can provide the -target command line 
option, and provide a QEMU_TARGET env var.

With those three ways, I hope we can cover 99.999999% of the use cases.

Anyway, we'll need to have a way to identify the target, and all the 
possible solutions will have shortcomings.
The right question is "Which solution covers the widest percentage of 
use cases ?", and my opinion is that argv[0] + -target + QEMU_TARGET env 
is the best compromise for me at this point.
I'm not keen to have a default target set, but it's a personal opinion 
based on fear of "implicit smart choice hurts", so I'll be happy to 
change my mind with a good argument for it.

Regards,
Pierrick

