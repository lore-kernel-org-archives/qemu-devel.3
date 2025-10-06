Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E07CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 07:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5fsT-0007U7-Pu; Mon, 06 Oct 2025 03:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5fsS-0007Tq-2V
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 03:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5fsP-0004HG-Q3
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 03:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759736600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ASCsVF02JKCVKwVpxwEr7aZJZmBCws5yzgXYsRzxWfM=;
 b=YXArmZr/iRfwfM+kOHnzslv5Lm9FM6QEvNyzkUtlSK3zHix4/R88/HFt+h3UeO2PRznR+q
 CqdsofW8SN+ZBdEQwc0eO2b/i1WrAgAKw78G1FQggxs3xJjZAbgn5b0q8horda3VpUuolK
 Y2Prji6m0kt3VWXjNZIBvdjPjtO5U+w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-xBIrsycMOiK41oWY4dLXbw-1; Mon, 06 Oct 2025 03:43:18 -0400
X-MC-Unique: xBIrsycMOiK41oWY4dLXbw-1
X-Mimecast-MFC-AGG-ID: xBIrsycMOiK41oWY4dLXbw_1759736597
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6394afe514eso3247500a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 00:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759736597; x=1760341397;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ASCsVF02JKCVKwVpxwEr7aZJZmBCws5yzgXYsRzxWfM=;
 b=u6t5g5n+CWf1AMsnmNaRUK9KqoJeEwr4IMOS0aXUEfl7ce/6ZVKD1DzIZe/j+OhqBo
 2lMxNBWL0WHEYB8WO2KgNnahetjM+rYvXFSDO0porD5m36uYikjlT4b7pYkuyRrcQNBf
 VICIqz1mSdV1zjF7Sr/lujE7EOopS46vIBZPwbv+/2MgHxHWeDQSADLn4m2HMi04vPN1
 P4vxMw16UlV4U2t8Ero7LSiO6BgyuG+4GSfmPBLCDqCljPaYBo4xifWNC0eH10WzBNdW
 HKWQq+ryKlv3pv9Y5tc50z8py4Ywh8iSZ8ReAdVsX3kb0DVvGMX+kmHLNh+1sx6tnisp
 p7/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQNeAau55GxWxmPSEXPMteCKjDstvw0zHEkXbCvGfg/9J9b/Qe4rrL2JOaQxs7s0a3olAVeSltDiRT@nongnu.org
X-Gm-Message-State: AOJu0YzNCcy91mCaId9Ipm30Aso36CdtTYqbY4aeuKCP+mDgqKI8fFu2
 LO+jc6X2jXriz1WlWDPJO3lhwRo1PdGuT0fFP5WIbewKXRaZclGG3f0b8OkJJkNiR1NLug+t2Zo
 HtgVKv/lFUFnCK7pBwDyW7su97rkmLWdVFqmKOMRpyXMsi90iYBIKOzWZ
X-Gm-Gg: ASbGncu/pqqAJOVSoS6ol1YeI+m9h89WrTm/GgmsZSQlL556FOIxFu387CZDq+1g73W
 txXchWUPTVSbhDfwFI8amybvMFK5TQu5NFPgY8OdtsgrPavYP3AbHYsTAE6BgoqF6M+UzXFF0zc
 1JV92Mry54oNGeR4N5UMuhiOU4NVLP8D8fgVOlmEHePrskpJA/GuMBun65CeoME8y4qUc/8hT42
 OrQHE2bfy2Z7nMRc6XpD8MCuR2uH0244bI77AQNAbtuN+rB+n3Mlz42OyGItocXkMS8NppuDv4y
 wf9OTdABLB0aQpkug1PjrxhPhfGC0XGpyqjfnv422lnQnMGSOvZA+bRh4fOE0CiSPXBQidSt8/j
 KPj2zgDY8bQ==
X-Received: by 2002:a17:907:86ab:b0:b3f:ccac:af47 with SMTP id
 a640c23a62f3a-b49c3d753e9mr1550019666b.31.1759736597194; 
 Mon, 06 Oct 2025 00:43:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEeIf7UWDqJDVq0eGYf9nFziZP0wq0/22rNmRND4anDeR3lM48XUOFGSoACJTAvG/cTA1Tnw==
X-Received: by 2002:a17:907:86ab:b0:b3f:ccac:af47 with SMTP id
 a640c23a62f3a-b49c3d753e9mr1550017566b.31.1759736596778; 
 Mon, 06 Oct 2025 00:43:16 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486970b23csm1080914866b.61.2025.10.06.00.43.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 00:43:16 -0700 (PDT)
Message-ID: <8cdf9d77-8801-4c25-93a2-06c81b9d1f3d@redhat.com>
Date: Mon, 6 Oct 2025 09:43:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251003141820.85278-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/10/2025 16.18, Gustavo Romero wrote:
> The goal of this series is to remove Avocado as a dependency for running
> the reverse_debugging functional test.
> 
> After several rounds of discussions about v1 and v2, and experiments
> done by Daniel and Thomas (thanks for all the experiments and comments
> so far), I've taken a new approach and moved away from using a runner
> for GDB. The changes, I believe, are much simpler now.
> 
> This new series uses GDB's machine interface (MI) via the pygdbmi module
> (thanks Manos and Peter for the inputs). pygdbmi provides a controller
> to start GDB and communicate with it through MI, so there is no longer a
> risk of version clashes between libpython in GDB and Python modules in
> the pyvenv, as it could, in theory, happen when GDB executes the test
> script via -x option.
> 
> Also, as Daniel pointed out, the overall test output is pretty bad and
> currently does not allow one to easily follow the sequence of GDB
> commands used in the test. I took this opportunity to improve the output
> and it now prints the sequence in a format that can be copied and pasted
> directly into GDB.
> 
> The TAP protocol is respected, and Meson correctly displays GDB's test
> output in testlog-thorough.txt.
> 
> Because the pygdbmi "shim" is so thin, I had to write a trivial GDB
> class around it to easily capture and print the payloads returned by its
> write() method. The GDB class allows clean, single-line commands to be
> used in the tests through method chaining, making them easier to follow,
> for example:
> 
> pc = gdb.cli("print $pc").get_add()
> 
> The test is kept “skipped” for aarch64, ppc64, and x86_64, so it is
> necessary to set QEMU_TEST_FLAKY_TESTS=1 in the test environment to
> effectively run the test on these archs.
> 
> On aarch64, the test is flaky, but there is a fix that I’ve tested while
> writing this series [0] that resolves it. On ppc64 and x86_64, the test
> always fails: on ppc64, GDB gets a bogus PC, and on x86_64, the last
> part of the test (reverse-continue) does not hit the last executed PC
> (as it should happen) but instead jumps to the beginning of the code
> (first PC in forward order).
> 
> Thus, to effectively run the reverse_debugging test on aarch64:
> 
> $ export QEMU_TEST_FLAKY_TESTS=1
> $ make check-functional
> 
> or:
> $ make check-functional-aarch64
> 
> or even, to run only the reverse_debug test after 'make check-functional':
> $ ./pyvenv/bin/meson test --verbose --no-rebuild -t 1 --setup thorough --suite func-thorough func-aarch64-reverse_debug
> 
> 
> Cheers,
> Gustavo
> 
> v1:
> https://patchew.org/QEMU/20250819143916.4138035-1-gustavo.romero@linaro.org/
> 
> v2:
> https://patchew.org/QEMU/20250904154640.52687-1-gustavo.romero@linaro.org/
> 
> v3:
> https://patchew.org/QEMU/20250922054351.14289-1-gustavo.romero@linaro.org/
> 
> v4:
> https://patchew.org/QEMU/20250926051542.104432-1-gustavo.romero@linaro.org/
> 
> v5:
> https://patchew.org/QEMU/20251002020432.54443-1-gustavo.romero@linaro.org/
> 
> v6:
> - Fixed skipping test when no GDB is installed in the test environment

With this v6, the test now gets skipped in my incremental build directory, 
and it works when I compile QEMU in a new folder. I guess that's good 
enough, so from my side, it's fine to include this now:

Tested-by: Thomas Huth <thuth@redhat.com>

Alex, will you queue the patches?

  Thomas


