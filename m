Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63288CA0EED
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 10:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoJgT-0004BX-VH; Tue, 19 Aug 2025 06:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uoJgQ-00048H-4I
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uoJgM-0008SO-4Z
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755599704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o7Yogf9aCnDnZnLg6Olxn2sdTpvS/Bo9ndTLcS0obzU=;
 b=ENdwgO19xG0GsavySvOZNgHPpDCj+XSpBFYHv6uHH7ti8RZHc8xeBpdiCNYSA25UEDhGvg
 YAnsfn6a27JckSxK+fXmjDShiSmLn8aT8xABIpmBEoum+PFMeYsO0rKRwNPdiSw0BN9pVb
 aXwSx4pdR//sWx0ktqE8AQHN8IJ7mpg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-knMZ2uw9MP-40kJ91Q-Kxg-1; Tue, 19 Aug 2025 06:35:03 -0400
X-MC-Unique: knMZ2uw9MP-40kJ91Q-Kxg-1
X-Mimecast-MFC-AGG-ID: knMZ2uw9MP-40kJ91Q-Kxg_1755599702
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a28ff4793so11803155e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 03:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755599701; x=1756204501;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o7Yogf9aCnDnZnLg6Olxn2sdTpvS/Bo9ndTLcS0obzU=;
 b=T/OdnVheLNoQoBFKehAZqvr3T9+z4xX9XPKndEW/4vXizii40oBZMTB6J2/kotUbl/
 441hmEaupGL+j9CDUGQ5SO9t4Gyb8aJdJVPXDWQYpyu+G9r7Y0Ge/sEMjd6qFL/ZWg7A
 bqu8YIPuwcqT7ooN98v9IbO3ubJ3Jh4xvQpxVANB1UDHiQy6XZgNVE039MibG0CffBEA
 VTXAIRp9hnEpMCh0YjB2QruEG9/Gosqr0mH/OTJtMdAzEcv7mFfn6xqRbBZ+HvV0imYP
 rQfRDDSTbYxTzzIB2zPp++j+CyJFO4Bl6UGen9Vz1PnWK7sfz2rMlcN8+wQ8kjVWXxd0
 5m4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE5bBOzf+ihqYDXPQWIRpyVpfafSO32x7vym9JOwUw55DiSiWnH+UVKiLl+I0UzzE0OaE/LsWrH9et@nongnu.org
X-Gm-Message-State: AOJu0YxtWRvLBqgOdvAPBAorjaPB/uPWAm+uKWoYPmO41oZmLJydGR1M
 APPIx1pYcdswPfWrXyzTWFKxDnlylTCkoqTcoFdlEBNDtWEQ0tePZ/KlMkZkx+TGEoA2D/Z7996
 xyKU57fHZjC8qacP/ktSV+PHHlZZr3gMDE24GV6orYnAf6wZGliVAR3rHPOtKpE6w
X-Gm-Gg: ASbGncu2M//096i/ep+f0hA4icS1E/oDupF65DSo7MEZ7a1stm5lSgKkttwmRg2sF+a
 jniWY6B7eyXE5JtbSTjbbJ2gLrCFp5sRD7rA/bOJWm3gp3hKRKmTnxTqSYf2WON1xXLgVTa+z0p
 1BJtcKXlrsufLxn1OvosrZeHPbNt3yE5DCxjzZ9KdY3b5E0y+YnpJuWM27Z1+RR9BvFwbDSPPgO
 tpWp/O/hIImZ5GfPmT+dNDWnNvQSjn2HNkzWb9r/IAVhiK9/Ci2rMtDPvkb71SgLAd4nQBkWLZw
 0PMZmCg+FF9m/m518deCcwdHLAVp6eAW09q3q7oI2Dg=
X-Received: by 2002:a05:600c:1e8a:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-45b43e0012cmr19336465e9.17.1755599701417; 
 Tue, 19 Aug 2025 03:35:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1PMcVuohxjtdRr4NWMUfNpILSZyCqmnrkKft+bQwCAT+unX+lLfzc9ZEdqphsYy3aOlXszA==
X-Received: by 2002:a05:600c:1e8a:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-45b43e0012cmr19336315e9.17.1755599700886; 
 Tue, 19 Aug 2025 03:35:00 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45b42a8f972sm38089545e9.20.2025.08.19.03.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 03:35:00 -0700 (PDT)
Message-ID: <8a0b42b1-e2ef-4746-a443-0ed0840dcdbe@redhat.com>
Date: Tue, 19 Aug 2025 12:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2 0/8] docs: Update our kernel-doc script to the
 kernel's new Python one
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
References: <20250814171324.1614516-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250814171324.1614516-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/14/25 19:13, Peter Maydell wrote:
> Earlier this year, the Linux kernel's kernel-doc script was rewritten
> from the old Perl version into a shiny and hopefully more maintainable
> Python version. This commit series updates our copy of this script
> to the latest kernel version. I have tested it by comparing the
> generated HTML documentation and checking that there are no
> unexpected changes.
> 
> Luckily we are carrying very few local modifications to the Perl
> script, so this is fairly straightforward. The structure of the
> patchset is:
>   * a minor update to the kerneldoc.py Sphinx extension so it
>     will work with both old and new kernel-doc script output
>   * a fix to a doc comment markup error that I noticed while comparing
>     the HTML output from the two versions of the script
>   * import the new Python script, unmodified from the kernel's version
>     (conveniently the kernel calls it kernel-doc.py, so it doesn't
>     clash with the existing script)
>   * make the changes to that library code that correspond to the
>     two local QEMU-specific changes we carry
>   * tell sphinx to use the Python version
>   * delete the Perl script (I have put a diff of our local mods
>     to the Perl script in the commit message of this commit, for
>     posterity)
> 
> The diffstat looks big, but almost all of it is "import the
> kernel's new script that we trust and don't need to review in
> detail" and "delete the old script".
> 
> My immediate motivation for doing this update is that I noticed
> that the submitter of https://gitlab.com/qemu-project/qemu/-/issues/3077
> is using a Perl that complains about a construct in the perl script,
> which prompted me to check if the kernel folks had already fixed
> it, which it turned out that they had, by rewriting the whole thing :-)
> More generally, if we don't do this update, then we're effectively
> going to drift down the same path we did with checkpatch.pl, where
> we have our own version that diverges from the kernel's version
> and we have to maintain it ourselves.

Yep - for checkpatch.pl that makes sense, since we have more differences 
in what we test and we have backported the most pressing parser fixes, 
but kerneldoc has no reason to diverge.

Thanks for doing this!  For the whole series...

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> We should also update the Sphinx plugin itself (i.e.
> docs/sphinx/kerneldoc.py), but because I did not need to do
> that to update the main kernel-doc script, I have left that as
> a separate todo item.
> 
> Testing
> -------
> 
> I looked at the HTML output of the old kernel-doc script versus the
> new one, using the following diff command which mechanically excludes
> a couple of "same minor change" everywhere diffs, and eyeballing the
> resulting ~150 lines of diff.
> 
> diff -w  -I '^<div class="kernelindent docutils container">$' -I '^</div>$' -I '^<p><strong>Definition</strong>' -r -u -x searchindex.js build/x86/docs-old-kerneldoc/manual build/x86/docs/manual
> 
> The HTML changes are:
> 
> (1) some paras now have ID tags, eg:
> -<p><strong>Functions operating on arrays of bits</strong></p>
> +<p id="functions-operating-on-arrays-of-bits"><strong>Functions operating on arrays of bits</strong></p>
> 
> (2) Some extra named <div>s, eg:
> +<div class="kernelindent docutils container">
>   <p><strong>Parameters</strong></p>
>   <dl class="simple">
>   <dt><code class="docutils literal notranslate"><span class="pre">long</span> <span class="pre">nr</span></code></dt><dd><p>the bit to set</p>
> @@ -144,12 +145,14 @@
>   <dt><code class="docutils literal notranslate"><span class="pre">unsigned</span> <span class="pre">long</span> <span class="pre">*addr</span></code></dt><dd><p>the address to start counting from</p>
>   </dd>
>   </dl>
> +</div>
> 
> (3) The new version correctly parses the multi-line Return: block for
> the memory_translate_iotlb() doc comment. You can see that the
> old HTML here had dt/dd markup, and it mis-renders in the HTML at
> https://www.qemu.org/docs/master/devel/memory.html#c.memory_translate_iotlb
> 
>   <p><strong>Return</strong></p>
> -<dl class="simple">
> -<dt>On success, return the MemoryRegion containing the <strong>iotlb</strong> translated</dt><dd><p>addr.  The MemoryRegion must not be
>   accessed after rcu_read_unlock.
> +<p>On success, return the MemoryRegion containing the <strong>iotlb</strong> translated
> +addr.  The MemoryRegion must not be accessed after rcu_read_unlock.
>   On failure, return NULL, setting <strong>errp</strong> with error.</p>
> -</dd>
> -</dl>
> +</div>
> 
> "Definition" sections now get output with a trailing colon:
> 
> -<p><strong>Definition</strong></p>
> +<div class="kernelindent docutils container">
> +<p><strong>Definition</strong>:</p>
> 
> This seems like it might be a bug in kernel-doc since the Parameters,
> Return, etc sections don't get the trailing colon. I don't think it's
> important enough to worry about.
> 
> thanks
> -- PMM
> 
> Peter Maydell (8):
>    docs/sphinx/kerneldoc.py: Handle new LINENO syntax
>    tests/qtest/libqtest.h: Remove stray space from doc comment
>    scripts: Import Python kerneldoc from Linux kernel
>    scripts/kernel-doc: strip QEMU_ from function definitions
>    scripts/kernel-doc: tweak for QEMU coding standards
>    scripts/kerneldoc: Switch to the Python kernel-doc script
>    scripts/kernel-doc: Delete the old Perl kernel-doc script
>    MAINTAINERS: Put kernel-doc under the "docs build machinery" section
> 
>   MAINTAINERS                     |    2 +
>   docs/conf.py                    |    4 +-
>   docs/sphinx/kerneldoc.py        |    7 +-
>   tests/qtest/libqtest.h          |    2 +-
>   .editorconfig                   |    2 +-
>   scripts/kernel-doc              | 2442 -------------------------------
>   scripts/kernel-doc.py           |  325 ++++
>   scripts/lib/kdoc/kdoc_files.py  |  291 ++++
>   scripts/lib/kdoc/kdoc_item.py   |   42 +
>   scripts/lib/kdoc/kdoc_output.py |  749 ++++++++++
>   scripts/lib/kdoc/kdoc_parser.py | 1670 +++++++++++++++++++++
>   scripts/lib/kdoc/kdoc_re.py     |  270 ++++
>   12 files changed, 3355 insertions(+), 2451 deletions(-)
>   delete mode 100755 scripts/kernel-doc
>   create mode 100755 scripts/kernel-doc.py
>   create mode 100644 scripts/lib/kdoc/kdoc_files.py
>   create mode 100644 scripts/lib/kdoc/kdoc_item.py
>   create mode 100644 scripts/lib/kdoc/kdoc_output.py
>   create mode 100644 scripts/lib/kdoc/kdoc_parser.py
>   create mode 100644 scripts/lib/kdoc/kdoc_re.py
> 


