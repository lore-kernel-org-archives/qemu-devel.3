Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A938C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 06:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7TB9-0008WT-Ip; Wed, 23 Apr 2025 02:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u7TB8-0008W8-Lc; Wed, 23 Apr 2025 02:01:50 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u7TB6-00007q-PW; Wed, 23 Apr 2025 02:01:50 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-af5139ad9a2so3828277a12.1; 
 Tue, 22 Apr 2025 23:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745388103; x=1745992903; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=75V2zUF4G37A+7ojkne1bi0Ew25Suvv6XvzMaaSL0es=;
 b=l9G/iqThpDF+t+cpVh3vCKgTSWM+SOiF84wQRveGGrUgux8Ytpp4Y7R5b/nPYRWPCJ
 N+8OsOv9Ppnp6+x3f7H3nJc+4u63b6Hm+t2vtzx0yQUx1XIYUXruEBNZ/GghdxxMMpBy
 APyQRw6/5KQ4JMi2Nlu+csgU5uhPlqRatnSpzg7/oruRH5EVZJAoU6/kz7qF0M3xymli
 AKzulKv+Ve96EFapRT62TXc13RMID/dzhPiQlR9HAB1nu2VmgjRvu+JivU2uYm6eRyNs
 NWAxC5y2+CdIYHuXSIDxToycpyt1NKpVbWCipXzXWeydCprORAwQsW0BS+CAs2Di/9SO
 PMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745388103; x=1745992903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=75V2zUF4G37A+7ojkne1bi0Ew25Suvv6XvzMaaSL0es=;
 b=No1OhMZNx4rGHGLti9Oknfumnq3GdCqvJF4UsBaE3Pybe6q+UCuh/SYOHb5pjzFyXl
 AMDCFepOw8EAKq+1XP62zotoQI+3QDQ2Gk+ZjJYWzDEIAA2KRwZsXatpXgg7V4cSg5RU
 M7XzH/FsIRa2tNv4yPBhheYR7LgHZUfhjymNF4TDGCkC+utEAqrDlAHGrICfkCNe7hcy
 Q5YNBxAI0KHE3DF7lcKFOa0XqWS990nA/GeglRm26mStfCQ9Sc9DO2aCO1nAY1C+/YfL
 sNYq0vnTL8LiT+F+G5n/yylPCP3F2sbKVjWm58FwKylVqkZ9pobF+lJgLc8evOPqQosN
 0Ebw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZfAQNZQ6uMLweNCnir5uWGs2Fo7whkfJdjoPqpW+hJxk7NPye01bISWoBh/VrOv4O4WLgMKhcASI=@nongnu.org,
 AJvYcCVDxKF91Qc2gSGVtjFcX9JEhu03EgfyXJfa05F8rGImW6fw5CovopmTL6veXqMzI20vaR6KsXArHUHGoQ==@nongnu.org,
 AJvYcCVPoqjwegFEzg3yG1g/bn64Y6i8YVI0KbwlwRPTVIL2rfJGP3cPC0T068TFhvRPOZdB1kqw/F6B0iyyQw==@nongnu.org,
 AJvYcCWU2RzX2BGoo0msrRXHfHwAvKTRbEGWjgwJlXEsXJ8alGAQGVGOQ0wW1ngAaWXYQKcYwsOfPoQq+fY7Aw==@nongnu.org,
 AJvYcCWgtV6iE91xzS1vay673SOza70R/zyrClEbODc6IZc+k+2ElEGgjaAIZ+No0t899AuDsF8pHdEACA==@nongnu.org
X-Gm-Message-State: AOJu0YzXwZu/D8mej2i4xz7OtPXQT24TMzhZUc046OCbeR+x+CjZij5A
 pwyPYiZG5735nMhhLAIcbQ6mim3qLTlPjRnGLutj+vPc6A+O7USb8lzWnI6K7k3i/nS9F6ao+pc
 nmCFllFbCA1iNGEAOGR/58OQSIuQ=
X-Gm-Gg: ASbGncurjJ9cb27SpMpVqZZxGXqU3LQVaO9xOao4//moaMmBw9ZcX3MsrhI2H6VL74E
 ngMvesnZI5PkTN+9sAocaa+4NBaoc0aTHkmrYNSI2fIUhH7WATW9bMsmYRO9s9jlKBwJroBjvhF
 2LTrZCptH40DhCWNoIhZjwel2sYK5eAhqXKK+xeEm10EgiGQ8x3B4XtK1+10cpW/g=
X-Google-Smtp-Source: AGHT+IF64z5wKPzTJg/n9OD0eLWYp+yiZBMBwrvB+l+qjOffdfHgzpWEL7Jo3pzSu4UBC4S2i0z4JhIyxFME2Cwj1Qw=
X-Received: by 2002:a17:90b:254d:b0:2ff:62f8:9a12 with SMTP id
 98e67ed59e1d1-3087bbc2a72mr23062304a91.23.1745388103371; Tue, 22 Apr 2025
 23:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <73301cc216217d5c3e0d7acdd32482e36f4f045c.1745295397.git.ktokunaga.mail@gmail.com>
 <e163300b-307f-46d9-9bf3-10f17c998e78@linaro.org>
In-Reply-To: <e163300b-307f-46d9-9bf3-10f17c998e78@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Wed, 23 Apr 2025 15:01:30 +0900
X-Gm-Features: ATxdqUEgMiBMXQqp1DS_p2pUXzotO2Zb8dScDj2LI8F234aM8mnRYFR9cYzrLXk
Message-ID: <CAEDrbUZkh6P8y8gSf9jcJSYwBDGVYY-dd9EYhcFtEHFUVqV0UA@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] util/cacheflush.c: Update cache flushing
 mechanism for Emscripten
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e5a29306336bd5c4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000e5a29306336bd5c4
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

>On 22/4/25 07:27, Kohei Tokunaga wrote:
>> Although __builtin___clear_cache is used to flush the instruction cache
for
>> a specified memory region[1], this operation doesn't apply to wasm, as
its
>> memory isn't executable. Moreover, Emscripten does not support this
builtin
>> and fails to compile it with the following error.
>>
>>> fatal error: error in backend: llvm.clear_cache is not supported on wasm
>
>Note, you mix LLVM error ...
>
>>
>> To resolve this, this commit removes the call to __builtin___clear_cache
for
>> Emscripten build.
>>
>> [1]
https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005f_005f_005fclear_005fcache
>
>... with this GCC documentation:
>
>   If the target does not require instruction cache flushes,
>   __builtin___clear_cache has no effect.
>
>I'd expect __builtin___clear_cache() to be OK, having no effect on a GCC
>WASM implementation.

Thank you for the feedback.
Although Emscripten supports built-in functions using GCC-compatible syntax,
the corner-case behavior looks different from what's described in the GCC
documentation, as shown in this patch. To avoid the confusion, I'll remove
that link in the next version of the patch series.

--000000000000e5a29306336bd5c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,</div><div dir=3D"ltr"><br></=
div><div dir=3D"ltr">&gt;On 22/4/25 07:27, Kohei Tokunaga wrote:<br>&gt;&gt=
; Although __builtin___clear_cache is used to flush the instruction cache f=
or<br>&gt;&gt; a specified memory region[1], this operation doesn&#39;t app=
ly to wasm, as its<br>&gt;&gt; memory isn&#39;t executable. Moreover, Emscr=
ipten does not support this builtin<br>&gt;&gt; and fails to compile it wit=
h the following error.<br>&gt;&gt; <br>&gt;&gt;&gt; fatal error: error in b=
ackend: llvm.clear_cache is not supported on wasm<br>&gt;<br>&gt;Note, you =
mix LLVM error ...<br>&gt;<br>&gt;&gt; <br>&gt;&gt; To resolve this, this c=
ommit removes the call to __builtin___clear_cache for<br>&gt;&gt; Emscripte=
n build.<br>&gt;&gt; <br>&gt;&gt; [1] <a href=3D"https://gcc.gnu.org/online=
docs/gcc-14.2.0/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005f_005f_0=
05fclear_005fcache">https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Other-Bui=
ltins.html#index-_005f_005fbuiltin_005f_005f_005fclear_005fcache</a><br>&gt=
;<br>&gt;... with this GCC documentation:<br>&gt;<br>&gt; =C2=A0 If the tar=
get does not require instruction cache flushes,<br>&gt; =C2=A0 __builtin___=
clear_cache has no effect.<br>&gt;<br>&gt;I&#39;d expect __builtin___clear_=
cache() to be OK, having no effect on a GCC<br>&gt;WASM implementation.<br>=
<br>Thank you for the feedback.<br>Although Emscripten supports built-in fu=
nctions using GCC-compatible syntax,<br>the corner-case behavior looks diff=
erent from what&#39;s described in the GCC<br>documentation, as shown in th=
is patch. To avoid the confusion, I&#39;ll remove<br>that link in the next =
version of the patch series.<br><br></div></div>

--000000000000e5a29306336bd5c4--

