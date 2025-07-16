Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E3CC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc16r-0002hu-12; Wed, 16 Jul 2025 08:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uc0vr-00053r-Ve
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uc0vo-0002hD-Qk
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752667694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=QVYkEoq3jsjPIHsmpjc5W3zKYgt4DxW3gtiAiotlAGY=;
 b=YmO7079nR6TGK8e+COskZ/T9SDBLYVSWAMEf7iHOJTwFwUlJ4G86MdrsMPfld7WQV5YbfK
 nCg6ENpjdFYu5+MNJbPv8vNntSaKCJ0cspZF+BwZgXg1jX37m3TwL2/ACmlZzIMwrzrVBb
 JFfIL/K537J4q65w5k7TOYHC+fCvTRE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-7qXpDGwuNqOIpXmo83W7-A-1; Wed, 16 Jul 2025 08:08:13 -0400
X-MC-Unique: 7qXpDGwuNqOIpXmo83W7-A-1
X-Mimecast-MFC-AGG-ID: 7qXpDGwuNqOIpXmo83W7-A_1752667692
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a6d90929d6so2943335f8f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 05:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752667691; x=1753272491;
 h=content-transfer-encoding:autocrypt:subject:to:content-language
 :from:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QVYkEoq3jsjPIHsmpjc5W3zKYgt4DxW3gtiAiotlAGY=;
 b=eldKu8fuVh6YNre6iihb+i1z4NoYT3/IOENJ/sgkUSgIR8c1pXdh751UbIpYMwLsuI
 AXcwGcJghnOuNZ5O01+BDCdFI6BxWAsBN6TWXeFs7vcwcIFJ4SkgQBYHY+ST/X8pqR6Z
 m8OnNhIdd5C6jJTfwmoHZTIreeG0lOLhMLV+kJrJSI77LPelBgEb09niyNDJ/ZPE9jXe
 d88PA6aZncdkdvbfgeM83c58rFSpR4eDuNMeZhiSEKvW/KkY3/TM34/5wbYopeQV6mSd
 vT0QBnwtI9VNM4rkk1btKLwf/3EfCg7+wd8sIifK9e+F80iKqKTPDhS/LZqFkkeN4NtH
 aIPA==
X-Gm-Message-State: AOJu0Yw3DPV+nayiB7ngiNsenE/41sI01CTwVttUXYB6TDrvlhRHeBW7
 G/TzaK4lqjLEi5pE/IEHs0ae3Zl1w0TfIC/CqXCqkGJh7A/j0NeJ4VsxPm/fzU/ku7Wap5PjXOZ
 86K5RHi7dwODi7M0JHf9c0iPx/mS6b9wnvmCZ8s/c0dKvJrTjv5FwMBcI8ua3QrqAgRKQ+mhGbj
 evb6RlT2IjxGdWl2TtzjNZqcMGlsTSVDLF/CjWXPj7
X-Gm-Gg: ASbGncudmGXB9OQazksvmyGtx/mDfJwyYMiy7yLLDJSZJxVArNWVa1wr8PEnCis/YkY
 QwK9Tyr5999dBjUNP2mO80dBQA1+zYJi6a33TajeUnOwsXHGeIiQahR7n32pqknZpYdKUXrw7VG
 Z3RlHFkpRuoVUXkMo4VW3Gf9vQHShUX6pbSY2F+Z5PmsZ3jFk4KF1o/uLsCSspArlzYwreNCkoF
 rq2OYXKhcTwP2uebVfeK4uMVYgxHzHKZm2Kebw/rt9IgCrscDFlw7jgKyHhzWN7BeE0kofEmN/v
 9uFGHJb88ZFv+PNZD2RZQT2voJBgC56bF8JEOkN09+A=
X-Received: by 2002:a05:6000:26d3:b0:3a4:febd:39f2 with SMTP id
 ffacd0b85a97d-3b60e523ce1mr1878467f8f.37.1752667691292; 
 Wed, 16 Jul 2025 05:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuYAXreTlfmcE4wrzUoBLGnJ+EuOnJffkdqabBpQbbfzv6fFHRzsFGVO2tYROSDgvCTqROZw==
X-Received: by 2002:a05:6000:26d3:b0:3a4:febd:39f2 with SMTP id
 ffacd0b85a97d-3b60e523ce1mr1878432f8f.37.1752667690636; 
 Wed, 16 Jul 2025 05:08:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45627898725sm33167265e9.1.2025.07.16.05.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 05:08:09 -0700 (PDT)
Message-ID: <c2342e56-b6d8-4115-8318-d8047a46f1ad@redhat.com>
Date: Wed, 16 Jul 2025 14:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Subject: Rust in QEMU update, July 2025
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

While I have generally given a three months cadence to the update,
this one is a bit early---mostly due to the upcoming freeze, and
many subprojects having reached a point where an update is useful.


Summary
'''''''

Achievements
   Almost full safety for device code; logging and initial work on tracing;
   starting to look at interoperability of C<->Rust data structures

Current blockers
   Static linking of Rust stdlib; formalize design for QAPI/QMP integration;
   bump to Rust 1.83 for key safety features

Next steps
   Complete tracing and DMA support; finalize 1.83 update; explore new
   devices written in Rust and report on holes in bindings


Table of contents
'''''''''''''''''

* Status in QEMU 10.1
* Build system
* Improvements to devices
* Cleanups
* Next steps


Status in QEMU 10.1
'''''''''''''''''''

For platform availability, the only change from 10.0 to 10.1 is that the
minimum supported Rust version is now 1.77 rather than 1.63.  This means
there's no support for building QEMU with Rust enabled with Debian bookworm,
*on mips64el* only.  Other architectures remain buildable on bookworm too.

With the update to Meson 1.8, support for clippy and rustdoc moved from
QEMU's meson.build files to Meson itself.  The update also made it
possible to use --enable-modules and --enable-rust together.

There are two new dependencies: anyhow, a commonly used crate providing
a general purpose Error implementation; and foreign, a crate that I wrote
to provide utilities for conversion between C and Rust data types.
Both are used to provide access to ``Error*`` from Rust code.

As soon as the Rust version is bumped again from 1.77 to 1.83, Rust devices
will need basically no unsafe Rust code.  This means that there will be a
practical benefit to writing *new* devices in Rust.  If any devices are
contributed that are written in Rust and do not have a C counterpart, it may
be worth splitting "enable Rust" from "enable all devices written in Rust".
This way, the C versions of the pl011 and HPET devices remain available
on platforms without a new-enough compiler version.


Build system
''''''''''''

Rust is still not enabled by default.  The main reason is that Rust
staticlibs also link statically to the Rust standard library, thus
bloating the resulting executable (and making distros hate us as well).
A pending Meson pull request[1] will fix this, as long as ``system/main.c``
is rewritten or wrapped in Rust.

As mentioned in the earlier updates, in parallel to QEMU work I'm
looking at improvements to Meson's support for Cargo and Rust.  While
there weren't many news over the last few months, the plan is to add
support for cross compilation and the ``[lints]`` section to its Cargo
support.  I have therefore made a proposal for tighter integration
between ``meson.build`` files and Cargo packages[2].

.. [1] https://github.com/mesonbuild/meson/pull/14224
.. [2] https://github.com/mesonbuild/meson/issues/14639


Stefano Garzarella is looking at merging the ``buildigvm`` tool into
QEMU's ``contrib/`` directory.  ``buildigvm`` is written in Rust, but
it has a relatively large set of dependencies that make it impractical
(for now) to drive its build from Meson.  While for now Stefano is going
to call out to Cargo in order to build ``buildigvm``, this is not expected
to last forever; ``buildigvm`` will provide a further testbed for
changes to Meson.


Improvements to devices
'''''''''''''''''''''''

New in 10.1 is logging support, as well as ``Error*`` bindings so that
``realize()`` implementations can fail.

With the recent merge of a procedural macro for property support,
there is basically no remaining unsafe code in devices outside the QOM
``instance_init`` method.  Merging the improvements to qdev and VMState
however will require a bump of the minimum supported Rust version
to 1.83.0.

The remaining missing feature for pl011 and HPET is tracing.  A student
is working on it and he has the simpletrace backend working, with syslog
and log coming next.  The plan for the dtrace backend is to use the
``probe`` crate[1], possibly extending it to support ust as well.

.. [1] https://github.com/cuviper/probe-rs


Zhao is looking into using the ``vm-memory`` crate in QEMU.  This
allows devices to perform DMA, including HPET.


Cleanups
''''''''

With the Rust bindings and the first couple of devices taking shape,
it's time to clean up some of the things that have grown a bit more
haphazardly over the last year.

One important change, which should make it easier for Kevin to continue
his work on block layer bindings, is to split the ``qemu-api`` crate
in multiple parts, roughly matching the ``declare_dependency()``
statements used for the C code.

Also, pl011 and HPET were developed independently and sometimes have
different idioms where we could aim for unification.  The main two are:

* name of files (the PL011 main source file is ``device.rs``, but the
   HPET one is ``hpet``.rs) and split between device code and a
   registers module

* adjusting HPET to use the ``bilge`` crate and/or the ``bits`` macro

These could be good tasks for someone who is learning Rust.


Next steps
''''''''''

The highest-priority missing feature, tracing, is being worked on; as is
DMA.

The next step could be better integration of QAPI/QMP (for which Marc-André
Lureau had a prototype already in 2022) and support for QOM properties.
Last month we had a discussion on whether to continue with Marc-André's
approach of converting between C and Rust representations; implement
QEMU's ``Visitor`` interface for Rust data structures; or focus on
conversion between ``QObject`` and Rust, using ``serde`` for code
generation.  Markus leaned towards the latter (though it must be said that
there's no code for it yet, and there could be unforeseen obstacles).

Finally, I'm going to take a step back from actively writing Rust code
for QEMU for some time, but I'll be available for reviews and will keep
looking at upstream Meson support for the language.

Paolo


