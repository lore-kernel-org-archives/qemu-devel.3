Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872FAC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 06:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5fc0-0002iO-9r; Fri, 18 Apr 2025 02:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5fby-0002hV-L9; Fri, 18 Apr 2025 02:54:06 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5fbw-0003yG-P4; Fri, 18 Apr 2025 02:54:06 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af19b9f4c8cso998312a12.2; 
 Thu, 17 Apr 2025 23:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744959242; x=1745564042; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YLEkyMApbPIGGQquRcY2VmYQsJL8RB3s9s0I1o7NgYw=;
 b=Vig4OyzyRSk3HsI6g1lvLq9jVCQNO/6YAtRox1EWzRJiMPbozgNWtESH9Ck9Mbyq7Q
 Qx4idLp7k7Z83YfTAxHybYPrm/03US/ZZ7ShgDkTUZMcdCMHG9GYsAKfxG4f5lbe2AFY
 JSPEyqwqG8vleJhk66LD3HPWv3Am4bMBKYQ5Myh543JZDy8FNnkzLSYeRcG83bLLVg0I
 zu+jZuSbjAjoPyfAk7j3Sdbbo1rsN4E04L3uwhPcXtB0RicgyVeVJJD7sBPTSkqCJKtk
 W+J2IO5OllZrMsfS8+4s3h5/6NTuGwN4G5dNcqSbCC5+hcGwvG+IOUEInk5rePkevA9Q
 JtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744959242; x=1745564042;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YLEkyMApbPIGGQquRcY2VmYQsJL8RB3s9s0I1o7NgYw=;
 b=X9NWC3RONFf7LjnqiK1KXcHZEBEQoKsAE/NfcTF3z0QocwiEjA2ORfhM1bG4G1B1nT
 PM+A9m2JAV32BALMfWYyY/e6wRBdn+I1Tkhvh9aeASfRYrsWy6sSO9MNgvcaKNamaQi/
 5BNXsH0+6Ddv0UjKB+AYUA2EQ6dCoxn/M5p8VKqvgG9rrjlxonE4pz/HL1NW/x72J6Fb
 dJ+UVWgSfn9WWe/7QGvw2Lrtkue9AA3OVDUC62YtU1/h2WncqfZH0UdEwyMKGrn5j2LX
 G9YmZReF2zrpAUSdRAwZ0R0cpRYvXi2Q3IAkz+39Kqcg7d7jjk4VK6qcLaDkjxzUh4GH
 iYCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkXX4jNTskreFl5YxEGyPPsxk5Ptsnd0maxHolTsFDY2+u7dFlmYmtkb3t+F3WIT9zTAMLu6tj2NO0Nw==@nongnu.org,
 AJvYcCVwgMMezCQ9Rozfk73pr7iSawu5Wy5i+Hn3L0DAcKS677BEA88UE55qTu04TOJoF+olXP2/+cGZC5E=@nongnu.org,
 AJvYcCWY2E8TnBC4pnEROr+esE+Mh8pY/rGTPjdPtpqHw1c6YFEA78unasoghGQ1WMR5zpeYCBEB+3uDjXXEjQ==@nongnu.org,
 AJvYcCXDx5yp+B0eyXNPWTHyowZp8Xii42jqKtldFrhHkLpsisIyQ9VCi3mOjIeefkZY7JoLnpjLteev0w==@nongnu.org,
 AJvYcCXJb+ca7iQecSEZvGvKdXiMyE3J3B9tmy5zYR+E0/bzHFBB7DsJ/f/5ELoY6d9WVQ37E/M8QNfQzamvTw==@nongnu.org
X-Gm-Message-State: AOJu0YyvwZq5ScAEpEJJWXUuN4Anb+cjrjkhe5p28xhTYq9Bn9T1eVVu
 d9s+T1Lv2Qi6AFmPuvoLOO0JTKVWIWredDuQwyxF4qlBXK2ojjMB+YFDidrZwSMf77M7RLMW1iF
 exIMW9d7oVwbkSV7I1O8nBoG96Rk=
X-Gm-Gg: ASbGncsTsyFzsvvhIOlfLy22T5C5fzCgw2ke1DImBP3yecjiMlLdbVpFYwxsfE8y5aU
 4ZYFdqBjrqG1x/qTlgRFYiWugPsCT9tIioYZXaRxumUf4Z78pSkEHyfZpDCbdmDqbKWotj1gkjH
 fvor2gywDHb57Y4afxXt20uA==
X-Google-Smtp-Source: AGHT+IHkpfY5hHAFvYvTGFKYPidYXM/IL+jZhfak47UIbJcmuSAYn2S1dkxNea3orbH0GfDyxASc5nkUisjZICCumP4=
X-Received: by 2002:a17:90b:3b50:b0:305:5f28:2d5c with SMTP id
 98e67ed59e1d1-3087bb679c2mr2267154a91.15.1744959241732; Thu, 17 Apr 2025
 23:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <9da41d784991f77e2c1f38d0781cd047b593e053.1744787186.git.ktokunaga.mail@gmail.com>
 <afe0abf1-2c33-47d8-bde6-8abc722eb212@linaro.org>
 <2d232dbc-4613-4352-8ede-3fd5dcefc32c@linaro.org>
 <CAEDrbUbQ2h1wj-KJqjYjcGPb4Pyp0te8ycy2DoJGENvT2+Mxcg@mail.gmail.com>
 <e7f66ec8-ee38-453d-a6de-4ed8d5a54268@linaro.org>
In-Reply-To: <e7f66ec8-ee38-453d-a6de-4ed8d5a54268@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 18 Apr 2025 15:53:49 +0900
X-Gm-Features: ATxdqUELYxpc16CMfbZ7wEabwr_03yB3vJtXle1t0CMdpVlr73kuh4qY3JKExuU
Message-ID: <CAEDrbUYw2mp-UrYGXtEDSuwRP+8oC3nHq5s9VppGj=7f7_Gq_w@mail.gmail.com>
Subject: Re: [PATCH 12/19] block: Update block to compile with Emscripten
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
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
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c04c5b063307fb33"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52b.google.com
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

--000000000000c04c5b063307fb33
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

> If meson fails to link, it won't define HAVE_COPY_FILE_RANGE,

Yes, meson correctly detects the link failure when checking for
copy_file_range, as shown in meson-log.txt:

> wasm-ld: error: /tmp/emscripten_temp_oqvz296m/testfile_0.o: undefined
symbol: copy_file_range

and reflects this in the configure output:

> Checking for function "copy_file_range" : NO

> so you
> shouldn't get "static declaration of 'copy_file_range' follows
> non-static declaration" right?

To fix this error, I needed to update the stub implementation in
file-posix.c to exactly match the declaration in Emscripten's
headers. Specifically, I changed the return type from off_t to ssize_t and
removed the "static" qualifier. With this change, file-posix.c builds
correctly under Emscripten, and there is no need to add a new stub in
stubs/emscripten.c

The following is the patch updates file-posix.c to solve this error:

 #ifndef HAVE_COPY_FILE_RANGE
-static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
-                             off_t *out_off, size_t len, unsigned int
flags)
+ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
+                               off_t *out_off, size_t len, unsigned int
flags)
 {
 #ifdef __NR_copy_file_range
     return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,

--000000000000c04c5b063307fb33
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,</div><br>&gt; If meson fails=
 to link, it won&#39;t define HAVE_COPY_FILE_RANGE,<br><br>Yes, meson corre=
ctly detects the link failure when checking for<br>copy_file_range, as show=
n in meson-log.txt:<br><br>&gt; wasm-ld: error: /tmp/emscripten_temp_oqvz29=
6m/testfile_0.o: undefined symbol: copy_file_range<br><br>and reflects this=
 in the configure output:<br><br>&gt; Checking for function &quot;copy_file=
_range&quot; : NO<br><br>&gt; so you<br>&gt; shouldn&#39;t get &quot;static=
 declaration of &#39;copy_file_range&#39; follows<br>&gt; non-static declar=
ation&quot; right?<br><br>To fix this error, I needed to update the stub im=
plementation in<br>file-posix.c to exactly match the declaration in Emscrip=
ten&#39;s<br>headers. Specifically, I changed the return type from off_t to=
 ssize_t and<br>removed the &quot;static&quot; qualifier. With this change,=
 file-posix.c builds<br>correctly under Emscripten, and there is no need to=
 add a new stub in<br><div>stubs/emscripten.c</div><br>The following is the=
 patch updates file-posix.c to solve this error:<br><br>=C2=A0#ifndef HAVE_=
COPY_FILE_RANGE<br>-static off_t copy_file_range(int in_fd, off_t *in_off, =
int out_fd,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 off_t *out_off, size_t len, unsig=
ned int flags)<br>+ssize_t copy_file_range(int in_fd, off_t *in_off, int ou=
t_fd,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 off_t *out_off, size_t len, unsig=
ned int flags)<br>=C2=A0{<br>=C2=A0#ifdef __NR_copy_file_range<br>=C2=A0 =
=C2=A0 =C2=A0return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,<br=
><br></div>

--000000000000c04c5b063307fb33--

