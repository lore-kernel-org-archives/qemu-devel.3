Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906D4D66BB3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 06:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW74l-0006oF-6I; Thu, 18 Dec 2025 01:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vW74N-0006fq-82
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:01:05 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1vW748-0001v8-Ih
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:00:48 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so2501685ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 22:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766037633; x=1766642433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BG6FNItSsYW/91FIQPqKXoyNAVnl4GBl0mlw5flh5NU=;
 b=UlRkF3iq8sfLsQ9yUMmO+DBupTR/Zo088Tynktw1qIBuBzWCBs46SiqwG2QuCNgib4
 TEizW2Dn5i/jwXCpuSGRuqt5EOieV0AiyrHG40VnNr3+bM5LX15TpXWcN0nOcFdapzZM
 +Nh6T/b3F6hgj4ovZOmtWicDzId9yWN34lxsMBLem6HxWiACi07U3/SsjYhQcala649J
 XhTqTv9WUsuK6xemk9AHWg6W/Zxxxj33/2m7J+Whk6w4GWVqEdqWu5eFBH1uN10UGlEl
 3JNx+jmoAhBWywr+7ufGKMgYDL/6xZvxPp8qMJ3Ggec9otezq3CoG/vqOxjxSVcK+JO0
 dnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766037633; x=1766642433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BG6FNItSsYW/91FIQPqKXoyNAVnl4GBl0mlw5flh5NU=;
 b=QsGWpPOUK7UxbZQ7C9szqRFPvcDoif7MK/sR1EBr2f/jRqP1K/94yRiu3OQL/mUxdM
 qaG8vAg81KW07Ls9bQ9ORJkXnGVXG+4V48+k5TkZBERFTW0lXI5VDK9RwxRFvpFcG1MK
 uC/qG6BE8UfFmmVFgqBzOvJO1ziSjCHEZatkPlL9o/8bmp1w8l4v32h5OdRB6ENW7OsN
 orhFpTF6DfMJ+wqfwa/GSOsTDfVATRWANecQj4rT9EXm82ZyIqdi+NYJaC7z4Fr4lWcK
 nzja8svWODDy5zJsWPovQErQD3MBZjNTfx19B+/fkw/n4GbErjC615yYBCBx2SSrOFZV
 X3rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf61KTD7tMILBtcCE22e7WKCY+3+4XZSgjau/RzDwVGIYGftaAezwvjfr3MjfYaA2MgJEi4puBaF3h@nongnu.org
X-Gm-Message-State: AOJu0YyOtzqyLxLYHxpmbHl882pxTbYlM4wQtCaY7jyj/ifVpNXJHlMF
 9AEVMK5ZyvmowOOKoXOnVn2myq2ZM4Ph005/k/vbevKbzqtOAEXAKER9
X-Gm-Gg: AY/fxX4YO7dvT+FZM1W+GPoCazkeOWMyw7KYOlCLFtKVTiMiClqz3Mel/2yROhBVFJr
 nlcBJyvFEWW+/2GzZ6/w8jDeBR5m2Rr38ppET2PVdu+OmftiWsyhvSkfJq+8jvxpJUMYhqga2FX
 Qbwc5Qp791fNfAdb4tj6t7ONj+QYBdhylwaYYbd421ItH/nPuTK/O5m0gqe52vi6IEeMpbd+rsH
 VGuxQWFN9hx+aU1jbgR3sQfbFjJlau0UksmW00VNE/aRafxJI3bJmTbWk2GFtJVvwhKCNQpfAco
 F2gxHr6LEqr27cWA9kCdZYmjUxtoAC7Q0ljxCnddrxMZwje2iv+ZLm70vIHs3RqIPWx+XMgdFaQ
 7OU/RPlpEQx6KHjFBDDT+EFl6dDWeql1FGv/FmYFkElNCdaw7uBUhtB9QZE7YjkqML99qn3bKF3
 AhfhYI10uh+5/ZyDekxcuhBcAOXHZDY3MADNXVFMmJenfJZ9eu2Gf7ZTxs/1XbXcz9fQ==
X-Google-Smtp-Source: AGHT+IFiiBajMPDq55gu89Z6Ug23XjSOrdUABWccxPbjouk5ePajT4OKEm5lfenvzlDyJlYmxVXv8A==
X-Received: by 2002:a17:903:41d1:b0:29f:301a:f6d2 with SMTP id
 d9443c01a7336-29f301af82amr193328365ad.19.1766037632633; 
 Wed, 17 Dec 2025 22:00:32 -0800 (PST)
Received: from ?IPV6:2406:3003:2007:2131:9948:323f:feb9:6c3d?
 ([2406:3003:2007:2131:9948:323f:feb9:6c3d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d087c606sm11976735ad.3.2025.12.17.22.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 22:00:32 -0800 (PST)
Message-ID: <6ac29c96-3be1-4387-8b1a-2f122a1bb90e@gmail.com>
Date: Thu, 18 Dec 2025 14:00:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qga/vss-win32: Fix ConvertStringToBSTR redefinition
 with newer MinGW
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
References: <20251215164512.322786-1-phind.uet@gmail.com>
 <20251215164512.322786-2-phind.uet@gmail.com>
 <CAMxuvaw=ZigHsgHf5matsmLrH57y-HE4gwgQy4Oyht4+u58N+g@mail.gmail.com>
 <CAPMcbCqSGCk0kmHF+uJjOjES+sKHQHQ-v59iU_q4QqY3TOTGVg@mail.gmail.com>
 <09738981-6ee4-47f9-b868-37f3259c06ed@linaro.org>
Content-Language: en-US
From: NGUYEN DINH PHI <phind.uet@gmail.com>
In-Reply-To: <09738981-6ee4-47f9-b868-37f3259c06ed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=phind.uet@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 12/18/2025 2:13 AM, Pierrick Bouvier wrote:
> On 12/16/25 1:53 AM, Kostiantyn Kostiuk wrote:
>> Hi
>>
>> On Tue, Dec 16, 2025 at 8:26 AM Marc-André Lureau 
>> <marcandre.lureau@redhat.com <mailto:marcandre.lureau@redhat.com>> wrote:
>>
>>     Hi
>>
>>     On Mon, Dec 15, 2025 at 8:57 PM <phind.uet@gmail.com
>>     <mailto:phind.uet@gmail.com>> wrote:
>>
>>         From: Nguyen Dinh Phi <phind.uet@gmail.com
>>         <mailto:phind.uet@gmail.com>>
>>
>>         Newer versions of MinGW-w64 provide ConvertStringToBSTR() in the
>>         _com_util namespace via <comutil.h>. This causes a redefinition
>>         error when building qemu-ga on Windows with these toolchains.
>>
>>         Add a meson check to detect whether ConvertStringToBSTR is 
>> already
>>         available, and conditionally compile our fallback implementation
>>         only when the system does not provide one.
>>
>>         Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com
>>         <mailto:phind.uet@gmail.com>>
>>         ---
>>           meson.build               | 12 ++++++++++++
>>           qga/vss-win32/install.cpp |  2 ++
>>           2 files changed, 14 insertions(+)
>>
>>         diff --git a/meson.build b/meson.build
>>         index c5710a6a47..60a980e610 100644
>>         --- a/meson.build
>>         +++ b/meson.build
>>         @@ -3299,6 +3299,18 @@ endif
>>           # Detect host pointer size for the target configuration loop.
>>           host_long_bits = cc.sizeof('void *') * 8
>>
>>         +# Detect if ConvertStringToBSTR has been defined in _com_util
>>         namespace
>>         +if host_os == 'windows'
>>         +  has_convert_string_to_bstr = cxx.compiles('''
>>         +    #include <comutil.h>
>>         +    int main() {
>>         +        BSTR b = _com_util::ConvertStringToBSTR("test");
>>         +        return b ? 0 : 1;
>>         +    }
>>         +  ''')
>>         +  config_host_data.set('CONFIG_CONVERT_STRING_TO_BSTR',
>>         has_convert_string_to_bstr)
>>         +endif
>>         +
>>           ########################
>>           # Target configuration #
>>           ########################
>>         diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/ 
>> install.cpp
>>         index 7b25d9098b..5b7a8e9bc5 100644
>>         --- a/qga/vss-win32/install.cpp
>>         +++ b/qga/vss-win32/install.cpp
>>         @@ -549,6 +549,7 @@ STDAPI DllUnregisterServer(void)
>>
>>
>>           /* Support function to convert ASCII string into BSTR (used in
>>         _bstr_t) */
>>         +#ifndef CONFIG_CONVERT_STRING_TO_BSTR
>>
>>
>>     I wonder if it could check __MINGW64_VERSION_MAJOR >= 14 instead of
>>     adding a configure-time check.
>>
>>
>> @Peter Maydell <mailto:peter.maydell@linaro.org> preferred to avoid 
>> specific version-number checks.
>> See: https://gitlab.com/qemu-project/qemu/-/ 
>> issues/3217#note_2935451782 <https://gitlab.com/qemu-project/qemu/-/ 
>> issues/3217#note_2935451782>
>>
>> I also preferred the idea of checking the real function present 
>> instead of the version of the component.
>>
>> Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com 
>> <mailto:kkostiuk@redhat.com>>
>>
>>
>>     lgtm anyway
>>     Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com
>>     <mailto:marcandre.lureau@redhat.com>>
>>
>>           namespace _com_util
>>           {
>>               BSTR WINAPI ConvertStringToBSTR(const char *ascii) {
>>         @@ -566,6 +567,7 @@ namespace _com_util
>>                   return bstr;
>>               }
>>           }
>>         +#endif
>>
>>           /* Stop QGA VSS provider service using Winsvc API  */
>>           STDAPI StopService(void)
>>         --         2.43.0
>>
> 
> When cross-compiling using fedora-win64-cross, it can find the function 
> in header but does not link it.
> 
> $ podman run --pull newer --init --rm -it -v $(pwd):$(pwd) -w $(pwd) \
> docker.io/pbolinaro/qemu-ci:fedora-win64-cross \
> bash -cx './configure $QEMU_CONFIGURE_OPTS && ninja -C build install'
> ...
> [4434/4696] Linking target qga/vss-win32/qga-vss.dll
> FAILED: qga/vss-win32/qga-vss.dll
> x86_64-w64-mingw32-g++ -m64  -o qga/vss-win32/qga-vss.dll qga/vss-win32/ 
> qga-vss.dll.p/requester.cpp.obj qga/vss-win32/qga-vss.dll.p/ 
> provider.cpp.obj qga/vss-win32/qga-vss.dll.p/install.cpp.obj qga/vss- 
> win32/qga-vss.dll.p/vss-debug.cpp.obj -Wl,--allow-shlib-undefined - 
> shared ../qga/vss-win32/qga-vss.def -Wl,--start-group -Wl,--out- 
> implib=qga/vss-win32/qga-vss.dll.a -fstack-protector-strong -Wl,--no-seh 
> -Wl,--nxcompat -Wl,--dynamicbase -Wl,--high-entropy-va -fstack- 
> protector-all -fstack-protector-strong -Wl,--add-stdcall-alias -Wl,-- 
> enable-stdcall-fixup -lws2_32 -lole32 -loleaut32 -lshlwapi -luuid - 
> lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lcomdlg32 -ladvapi32 - 
> Wl,--end-group
> /usr/lib/gcc/x86_64-w64-mingw32/14.2.1/../../../../x86_64-w64-mingw32/ 
> bin/ld: qga/vss-win32/qga-vss.dll.p/install.cpp.obj: in function 
> `_bstr_t::Data_t::Data_t(char const*)':
> /usr/x86_64-w64-mingw32/sys-root/mingw/include/comutil.h:279: 
> (.text+0x1dc8): undefined reference to 
> `_com_util::ConvertStringToBSTR(char const*)'
> ...
> 
> Looking into mingw files, the symbol is not there.
> $ nm /usr/x86_64-w64-mingw32/sys-root/mingw/lib/lib*.a |
> grep -i ConvertStringToBSTR
> 
> It's present in header file though:
> /usr/x86_64-w64-mingw32/sys-root/mingw/include/comutil.h
> 
> Not sure if something is missing in mingw, or if it's missing an 
> attribute to say it should be available at runtime only, but in all 
> cases, a simple fix to the patch is:
> 
> diff --git a/meson.build b/meson.build
> index ab19317f5af..113296544c4 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3261,7 +3261,7 @@ host_long_bits = cc.sizeof('void *') * 8
> 
>   # Detect if ConvertStringToBSTR has been defined in _com_util namespace
>   if host_os == 'windows'
> -  has_convert_string_to_bstr = cxx.compiles('''
> +  has_convert_string_to_bstr = cxx.links('''
>       #include <comutil.h>
>       int main() {
>           BSTR b = _com_util::ConvertStringToBSTR("test");
> 
> I would recommend to use cxx.links instead of cxx.compiles for now.
> 
> Regards,
> Pierrick

Hi,
Upon checking, I found that ConvertStringToBSTR has been declared in 
this header file for quite some time; however, the actual definition was 
introduced only in MinGW releases. I will provide an updated version 
that uses linking instead.

Thanks and best regards,
Phi

