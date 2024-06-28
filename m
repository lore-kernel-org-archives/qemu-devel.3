Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2E1C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 19:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNH1g-0006G8-P9; Fri, 28 Jun 2024 15:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sNH16-00061K-6w
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 15:12:16 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sNH14-0001YM-84
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 15:12:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fa07e4f44eso6120615ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719601931; x=1720206731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zwkeKqITQlPK4Z07x0ExxUgmqkivBNdrlbmO5s7uY5w=;
 b=KhPoEJcUh1wvpVYrlBjVWIqT5kWLHLGR1PIokfCSY0eHkkHAExDksKx4Rsn1EhZduu
 Li1ml7suCqjAkV4HLuWszSYzZCgsOSSRbxfdE6oCgqBUXIDl9wSxkLliToqE5/GLnyX4
 3HMAObdXkeqBZmP2Xnx8Hgntqp+l5qPHOPn5JCDNifZGsvij1ClOA4CyshUyAa8lYmKf
 EcOXGxmn+8OHFRj/1S66iRMk139Ko2EnHa2KfQHgQomKJPwHSGZX4fv2OZJiUVUkSL+d
 6Jat1bJYZToymbfpcHKEfDo8ZwDmAYiUB6PZBUGuMKkKOvZQVYxMtBowFOxDiwCk+Iql
 zvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719601931; x=1720206731;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zwkeKqITQlPK4Z07x0ExxUgmqkivBNdrlbmO5s7uY5w=;
 b=Z88IjjvReGou6cZVV3gOHkdAiTQulWL9TO0hRADrOG6WCNGazkUo+4Rbg5PV5QMjnc
 dbJhAisonIhTWcnmF+eFtg7J7XX3M9843XpMLSPIsfhk4uAY+oTsV2V7PGI7n+24M8Mh
 VZAZ+lli2op0La78r0m3vpZJ1Hou1urWpTBIFVABYUbe/GvnZsRxIzhys90QL6Ou/wMM
 hr0+wNKmo1aqw3U+oAFQLROCOh4z1Ssj+q0B90BbT94lyYy4jqVk1/krZdov6X1Qxnd8
 dBrZgjp/RgwtUUaNZ/AS1WVVX0mIHNvlSDFeaiXgM4QLUBd+bFcT6RBkBPVY2EZDcP5/
 2oPw==
X-Gm-Message-State: AOJu0YxHX+NQ5eozVt7wziqBJUtZtsBzPgJn+bFiId8TVOPZdBg4GRnO
 uqBmwwA1djw+axJiHbZUZaIewlG3x8NVjIDzCcZ+4ekHoXkR9XP/ptdIYbhrlz0=
X-Google-Smtp-Source: AGHT+IGQ8evbNZRLDsj1F55IshoLaFEExxqGnDL89hlykaEU2fqYnUvtYjlfKCVWwxik/uy2QqX3Lg==
X-Received: by 2002:a17:903:32ce:b0:1fa:643:f424 with SMTP id
 d9443c01a7336-1fa238e46ddmr196335005ad.14.1719601931498; 
 Fri, 28 Jun 2024 12:12:11 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10e2725sm19332795ad.70.2024.06.28.12.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 12:12:10 -0700 (PDT)
Message-ID: <dfa7bc8f-378f-4876-b630-fe1182dca937@linaro.org>
Date: Fri, 28 Jun 2024 12:12:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnlGlOGORQkOsoO5@intel.com> <fl60u.ry7sk6d8fv39@linaro.org>
 <ZnrpgW+CopiJAGZF@intel.com> <fnew7.3urdmuxnhe3l@linaro.org>
 <27f52dce-b659-446d-8358-50b6001f7307@linaro.org>
Content-Language: en-US
In-Reply-To: <27f52dce-b659-446d-8358-50b6001f7307@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 6/27/24 16:47, Pierrick Bouvier wrote:
> On 6/25/24 11:08, Manos Pitsidianakis wrote:
>> On Tue, 25 Jun 2024 19:00, Zhao Liu <zhao1.liu@intel.com> wrote:
>>> [snip]
>>>> This is for future-proofing the Rust integration in general. I
>>>> haven't been
>>>> able to compile under macos yet because bindgen cannot find the system clang
>>>> header. I also don't have a windows pc to test it on. But it should work
>>>> theoretically under all three.
>>>
>>> Yes, they should work. EMM, but there is no particular need for them at
>>> the moment, so just to be safe, we can put these two platforms on hold
>>> for now, and they can be easily added when the tests are covered.
>>>
>>> A TODO can remind support for them.
>>
>> I'm still trying to figure out why bindgen doesn't find the /Library/***
>> include paths.. it's frustrating! I will remove them if I don't succeed
>> and also no one volunteers to attempt a windows build. :)
>>
> 
> I'm currently doing it, and managed to run until bindgen step. Same
> problem that you found on MacOS, it can't locate some headers
> (strings.h, included from osdep.h). I'll try to dig into this, but if
> you found a solution already, you're welcome to share it.
> 
> 'gcc | grep' command you used should work, but should be adapted because
> windows paths start with C:/ instead of /.
> 

I've been able to build rust device on windows, with a few tweaks needed.

- specificy the target for libclang (used by bindgen), which targets 
MSVC by default (so different set of headers)
- additional headers (libclang searches its own header with a relative 
path instead of absolute)
- additional windows libs that must be linked in final executable

However, even tough I can build the executable, I get this error:
$ ./build/qemu-system-aarch64 -M virt
C:\w\qemu\build\qemu-system-aarch64.exe: unknown type 'x-pl011-rust'

Any idea of what could be missing here?

By the way, I noticed configure --enable-with-rust does not trigger 
error when not finding cargo, it just deactivates rust support, which is 
probably not what is expected.

---

QEMU Build instructions for windows are here:
https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2

Additional steps needed:
$ cargo install bindgen-cli
$ export PATH=/c/Users/user/.cargo/bin/:$PATH
$ wget 
https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.6/LLVM-18.1.6-win64.exe 
# for libclang.dll
$ pacman -S p7zip
$ mkdir llvm && cd llvm && 7z x ../LLVM-18.1.6-win64.exe && cd ..
$ export LIBCLANG_PATH=$(cygpath -m $(pwd)/llvm/bin/libclang.dll)

Additional libs to link can be found with:
$ touch empty.rs
$ rustc empty.rs --print=native-static-libs --crate-type=staticlib
note: Link against the following native artifacts when linking against 
this static library. The order and any duplication can be significant on so
me platforms.
note: native-static-libs: -lkernel32 -ladvapi32 -lkernel32 -lntdll 
-luserenv -lws2_32 -lkernel32 -lws2_32 -lkernel32

---

diff --git a/meson.build b/meson.build
index ca40a39ad7e..98faa4777b7 100644
--- a/meson.build
+++ b/meson.build
@@ -3896,7 +3896,8 @@ foreach target : target_dirs
          input: copy,
          dependencies: arch_deps + lib_deps,
          output: target + '-generated.rs',
-        include_directories: include_directories('.', 'include'),
+        include_directories: include_directories('.', 'include',
+        'llvm/lib/clang/18/include/'),
          args: [
            '--ctypes-prefix', 'core::ffi',
            '--formatter', 'rustfmt',
@@ -3910,7 +3911,10 @@ foreach target : target_dirs
            '--with-derive-default',
            '--allowlist-file', meson.project_source_root() + '/include/.*',
            '--allowlist-file', meson.project_source_root() + '/.*',
-          '--allowlist-file', meson.project_build_root() + '/.*'
+          '--allowlist-file', meson.project_build_root() + '/.*',
+        ],
+        c_args: [
+          '--target=x86_64-pc-windows-gnu'
          ],
        )

@@ -3925,7 +3929,12 @@ foreach target : target_dirs
            rust_dep = declare_dependency(link_args: [
                                            '-Wl,--whole-archive',
                                            t['output-path'],
-                                          '-Wl,--no-whole-archive'
+                                          '-Wl,--no-whole-archive',
+                                          '-lkernel32',
+                                          '-ladvapi32',
+                                          '-lntdll',
+                                          '-luserenv',
+                                          '-lws2_32',
                                            ],
                                            sources: [rust_device_cargo])
            rust_hw.add(rust_dep)

