Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A848610F2861
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6BK4-0004UD-CP; Fri, 27 Mar 2026 13:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6BJx-0004Td-Ph
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:50:10 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6BJw-0006SS-4a
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:50:09 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ea73e7b60so2569156d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 10:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774633807; cv=none;
 d=google.com; s=arc-20240605;
 b=Dy/mhbqOCXWPVFs1veEjU9EuCVm0DBwT7FQX5LH1cI8lfoZAApBNCB7jxnLibgzsNT
 7na6obUm+jzKhYH2HjuTWzGeBM2vzkWfl2bbJK/pLz8VX3cRCmVWGs9z9KEkraVHD6XH
 wXWxQHQ8gsiBD3D3MgpaV9Uq3JHBYN206UrshdIMw1HyfxMqn62o2b5B4fbckCeUlppl
 nC1Ub+9b/IgfC6RUZesTn0PGCjb9aPlc4VFnhGFqCAnCR+WwEXYK6SgQ3tyEhtEGGNB7
 UPQnuhfqLD3d1jLzMYjEDj6MY/3UtbOXbTT2L6paZ/J7gfp9/bXOdhX9mpM6NCf2PRsi
 YEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o7NfbAaQ6PnBVQMzsMvByNm8WJHV/YlMxjQhD5kWImQ=;
 fh=s7VG75S3gruSNn7BODeRWfKJC95HAzYSe3gW+38i0ek=;
 b=e1ql+LYe5BwBj7XcHji6454upEgcyv7wacW3EODhIriF48M6DLaYYRBHi/RkQgbhU/
 TDh5N6MWjq7httx/QzVBdoEcnDYASPQDO65GIgrraJSKhnVcGopvV356XuEuLeAMmcWR
 s4tJy5cP3foDgFKR+kYyC4+jrCG92d0af95M2ozhlFyoFQ9Nxym0jwZ5zhvupHeweiMn
 21KTzqk04eesh+ygDiQS/AN3160g1niJz35OoWeyWeQX4ywK6MirQHcvlqDROccYA8vz
 F6IvT1eufMOC2Na+oYpABwvqFyUJ6yQtONKRZDkmRy6tkBlWXB18vASWTqKt6SCjToZk
 Pv7Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774633807; x=1775238607; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7NfbAaQ6PnBVQMzsMvByNm8WJHV/YlMxjQhD5kWImQ=;
 b=QwhMGMaxIhRfuz7/Amr36ct77udcMek6qFFm9jABjoOC4cE/ojHmT9L8cYQs4aWV/k
 dOSg+qtizfwxfIYY/ugi2bxXLrQk2vKqRJi/PDC97GiaqUW5Zabe/lsBQ+YML4YKUukR
 c7aGViaac2TtqwgfjT+XkmUtuUdEj06KsBslean020ucbIqzbdb3TfxleB6WXdWenl0K
 wI+to1VlGYyZmXAZsz0UNrClHOOCNMJrro8IbSa7ikwsS07J9bAk5/KpvFM8NBoNk7/Y
 zq4gGSoqPHBxx7h/PsFhqV1U52DE4Q7QlO+xPKU0AoyHwL/4b2zEaCuS6oTQ660o3m8W
 Zjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774633807; x=1775238607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o7NfbAaQ6PnBVQMzsMvByNm8WJHV/YlMxjQhD5kWImQ=;
 b=XTpsRUwOPxjyUWL76F+oGLJZ6KiigjpqJPCma9t+jp2hXx3svCcA1h1YKFodXwrKPk
 O3+sZFB0IfUb4r5GB8RzHnSINZUaVScqZvqt9RU5uDaEnqKTHwxtDtm5fxZZvjm7h8PL
 oP2V9uyhw1I/juqw7/XCpASR3F7/YI0Wx7haNCfwkMGwFXtkBZDX3KF8q6h/SlCQlnhe
 flJt5caVZbVzimUYrQOlrT9gjIrvnnDURrEl+XE2VGzGUQ8jT2x2mqiaEVGOlA1ZnOPG
 XHKNMtvz058inh9g90fcPds5+Ru2l+N3A1hVxWke0mp/rgqA/RdbESwz1TNJBsrx5P+B
 P/rQ==
X-Gm-Message-State: AOJu0Yw4LQgDSWXvJ85OzxfwaMax1tlQL4PRwWnEo88EWRS4zH6ui3j0
 CUmabuILNrZ64BBUwLmjHpwl5wQ9Hl9OppKqcQ61OQL8cXTBe14SVC7K/chT0SGp99VyLnyYKUt
 LKNEAW/O9M+mGP2vygIhv3xoTj2uQxAmVXRGjuRGUAg==
X-Gm-Gg: ATEYQzyToyRjan4zwlV9/VvZjT4CNhemVJodhB5j8OjZOGbWM5GHpZcj9PLesnSxLv9
 yo0kG2d2gaAf8i5J8aq2850W62MuWkU0QPVY75fEdYeJhaSKhTCppX23LsUDOsdYzvyXuqxdbEM
 hqtxIMNvCQHNCDEx+XKlMgO8eGTt9bZYvg8ztPdYSd83cvlqMBvLYmDMNPPO1BIkoNZcWT7xmL0
 Smz5/BMK4NGy0gAqCxiRcMFG9XV3qDl+hzW9gdtTmvYWDxdLHrKjDG6s43H5f8fM0Z7wQI7vRNV
 fMRC6l/WyrTVzVHka4xoeE14xrT/Wg4+fTgNGufdqJxQOSetZGAk6taWo7ObOj00ujs=
X-Received: by 2002:a05:690e:440e:b0:64c:af3f:e2a3 with SMTP id
 956f58d0204a3-64ff74158efmr2989569d50.55.1774633806716; Fri, 27 Mar 2026
 10:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260317094806.1944053-1-peter.maydell@linaro.org>
 <CAFEAcA_VF9iztXv9hEp1BvVoqphFM8qnmh1nJC3VUKRbVMeB2g@mail.gmail.com>
 <CAPMcbCp_TZOXOAgnnMWWUY_8U903NVRZVYLzXxHHDG2h6-yZMg@mail.gmail.com>
In-Reply-To: <CAPMcbCp_TZOXOAgnnMWWUY_8U903NVRZVYLzXxHHDG2h6-yZMg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 17:49:54 +0000
X-Gm-Features: AQROBzAJzkxDuWsedUgkauMTVium3lj1YiiTDvDR0Zk_ZsSPoPO_uv_zUHIB4Vo
Message-ID: <CAFEAcA8ExdecnLtWAPCf2yCAVkNNAVoTOMeYXhu40Q71fz-9ZQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] fsfreeze-hook: fix bashisms, syslog fallback logic
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Fri, 27 Mar 2026 at 17:40, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrot=
e:
>
>
>
> On Fri, Mar 27, 2026 at 7:03=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>>
>> On Tue, 17 Mar 2026 at 09:48, Peter Maydell <peter.maydell@linaro.org> w=
rote:
>> >
>> > This patchset fixes some issues with the fsfreeze-hook guest-agent
>> > script reported in https://gitlab.com/qemu-project/qemu/-/work_items/3=
339
>> >
>> >  * the script is a #!/bin/sh one, but it uses various bash-isms.
>> >    Most are easy fixes, but getting rid of the PIPESTATUS usage
>> >    is a little less obvious, so that gets its own patch
>> >  * a bug in the logic determining whether to log to file or syslog
>> >    means that if the logfile doesn't exist on first run, the script
>> >    will create the logfile but log to syslog (and then log to file
>> >    on second and subsequent runs)
>> >
>> > NB: I have tested this by setting up the script and running it
>> > manually in a temp directory, but not as a "real world" fsfreeze.
>>
>> These have been reviewed, do you plan to take them into a pullreq ?
>
>
> Yes. I keep it for comments from other people.
>
> Do you prefer to merge it into v11.0 or v11.1?

It's a user-reported bug, so I think 11.0 would be nice unless
you think it's too risky or needs more testing.

-- PMM

