Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6170FC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udp5J-0003aE-3h; Mon, 21 Jul 2025 07:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1udp51-0003L7-I0
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:53:17 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1udp4w-00044T-Ku
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:53:15 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so3224816f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753098785; x=1753703585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6GZvdZ+c6BoehRY1iO/ZqSA/2A8sT0Zux402y54ziwE=;
 b=m5qhIyM9sU/FBuLalP6xGGbmm4ykJRxPIg2EZoXqlAWZVRlRT9bpW8IpXNhmC9ej1D
 Yg+FMQcYHMD07mqWXjCM6XbekE+3I9Gkc377fp0lmSRPJ4aP4slIs0U1Lz/ARBqgmsi/
 Nuyc9IYabnqIhwSIVDweyUsnA4cPCX8MafhscI4NTc0gIrorKZfzgBbYU7D+kg5adkCb
 if3k76mTyQhoU0hBI7r0XjlN4COu9VjvKukS2lYGI0dHXMUthCgxwpNtSHGvuktBJCOI
 bGwtL9m5RYVF7h+WxselASfZBHoOPSulZkUhVhg4TEX8DSzQGk17KbYvZt9zDNgEXuqr
 FJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753098785; x=1753703585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6GZvdZ+c6BoehRY1iO/ZqSA/2A8sT0Zux402y54ziwE=;
 b=xM+5LVQgCh02uurMQOxunfMQAO3Xim3jFyCE2pNLvzFO78NofIZKiK85t79uFFtPy6
 /Paiy27bzsNB80p0J88/iNP+EXyucbJu0Ka2fklOzz8dl5c43VCtefYbq8ulqzjHpVl8
 IPvZoA/WebMTltZXMy+pjKX9gM3SCVJn7uAb5miQnC6TMDYRxBaIhLzDmjJjKUxay7qi
 +PfnOuRS49M9VIZVbHaBZudIM18Gh+Ln2gePq7C+yy9j/E0K4kk4KRZemgMzMcSvD+Me
 2Jj//KRl1z3YXZIuk3JsGLEvEf/ZjhXlpcjtu3iE2og1YxaJVjBSxuQ+mfwf5iwsiHaL
 0+GQ==
X-Gm-Message-State: AOJu0YwFSLJdQPMOhkxWtcNUW4lmMzs24WKksTbMWwwyxQvFbouQ1xG+
 5qS+dwRYvxM77f1SHhY1jdH9gVALL9zkjjXfV0koER6D2+bF0qqH3wGfUq+mxI77wxI=
X-Gm-Gg: ASbGnctwc1Xbrkr6TSt1cWrcJxGz+E77vTgrCXfpVmTs/jjCXNb8GZ5xP/OtLCWXVLa
 duYsa+ba72hXhOSRfw1w/lUhidRgS2DG45Oqe2h9I3kcFYrbz9EWGVqnDTHO2rFSL/O0/98WRzU
 ln2lG4zpvVZ9ZWABJfW9jF/iNW0pgU1Wuqx/52xBKmYJYHT0o2EIXLfz0UfMgaDfPPvAIOdIT91
 PTuL9ahwH4j/sIk4GAfg28BN8hYQocYDB7LWwF92GPHXW2MN0qJ5bK7b5TApbxVrEwuZc4xsuC0
 v46iWHQRS+ZT2UFPIzUMyq2xSZOXiz7nL4iQKBY4H2gkgfQlYg/3hSRc/es2diZiJaRF+2xpLkU
 b93mFjkT0+A/MzMG2i/uh+39m9H4GAjgGWKEVcExr+8Nvr4nnUrg5PlnJtRNyCjH/fQ==
X-Google-Smtp-Source: AGHT+IESvYS6Q7Ja2SdrbxNTgBFUS95MjwXuUzLAVJHHFV90h8iNUoO1eJDL16iTYsphMfg6eQ6IVw==
X-Received: by 2002:a05:6000:4b17:b0:3a4:e1e1:7779 with SMTP id
 ffacd0b85a97d-3b60e50ff22mr15005623f8f.32.1753098784856; 
 Mon, 21 Jul 2025 04:53:04 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4d7fasm10221424f8f.69.2025.07.21.04.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 04:53:04 -0700 (PDT)
Message-ID: <c3afe3f5-962d-40ba-a778-716ef9929053@linaro.org>
Date: Mon, 21 Jul 2025 13:53:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: win32: Write hex value when can't get error message
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yvugenfi@redhat.com>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250717145948.77870-1-kkostiuk@redhat.com>
 <87pldwbspt.fsf@pond.sub.org>
 <CAPMcbCp=PBMSxtTxCMkxigdovaY=MTNLRo6f3BBXNRT6vu4wmw@mail.gmail.com>
 <87seipkif5.fsf@pond.sub.org>
 <CAPMcbCrTTkr5sX11wn1WaXOLgqQTAD-1oxUuqOc+oEmUxcotkw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAPMcbCrTTkr5sX11wn1WaXOLgqQTAD-1oxUuqOc+oEmUxcotkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 21/7/25 12:12, Kostiantyn Kostiuk wrote:
> 
> 
> On Mon, Jul 21, 2025 at 12:22 PM Markus Armbruster <armbru@redhat.com 
> <mailto:armbru@redhat.com>> wrote:
> 
>     Kostiantyn Kostiuk <kkostiuk@redhat.com
>     <mailto:kkostiuk@redhat.com>> writes:
> 
>      > On Sat, Jul 19, 2025 at 9:27 AM Markus Armbruster
>     <armbru@redhat.com <mailto:armbru@redhat.com>> wrote:
>      >
>      >> Kostiantyn Kostiuk <kkostiuk@redhat.com
>     <mailto:kkostiuk@redhat.com>> writes:
>      >>
>      >> > g_win32_error_message - translate a Win32 error code
>      >> > (as returned by GetLastError()) into the corresponding message.
>      >> >
>      >> > In the same time, we call error_setg_win32_internal with
>      >> > error codes from different Windows componets like VSS or
>      >> > Performance monitor that provides different codes and
>      >> > can't be converted with g_win32_error_message.
>      >>
>      >> Are these error codes from GetLastError()?
>      >>
>      >
>      > No.
>      > VSS functions directly return an error code.
>      > Section: Return value -
>      > https://learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-
>     vsbackup-ivssbackupcomponents-addtosnapshotset <https://
>     learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-vsbackup-
>     ivssbackupcomponents-addtosnapshotset>
>      >
>      > Performance Counters API can return a system error code or a PDH
>     error code.
>      > Section: Return value -
>      > https://learn.microsoft.com/en-us/windows/win32/api/pdh/nf-pdh-
>     pdhopenqueryw <https://learn.microsoft.com/en-us/windows/win32/api/
>     pdh/nf-pdh-pdhopenqueryw>
>      > System error code = GetLastError, PDH error code, something else.
>      >
>      > https://learn.microsoft.com/en-us/windows/win32/perfctrs/pdh-
>     error-codes <https://learn.microsoft.com/en-us/windows/win32/
>     perfctrs/pdh-error-codes>
>      > FormatMessage requires LoadLibrary(L"pdh.dll") to work properly.
> 
>     The error code error_setg_win32() takes is passed to
>     g_win32_error_message().  Contract:
> 
>          g_win32_error_message ()
> 
>          gchar *
>          g_win32_error_message (gint error);
> 
>          Translate a Win32 error code (as returned by GetLastError() or
>          WSAGetLastError()) into the corresponding message.  The message is
>          either language neutral, or in the thread's language, or the user's
>          language, the system's language, or US English (see docs for
>          FormatMessage()).  The returned string is in UTF-8.  It should be
>          deallocated with g_free().
> 
>          Parameters
> 
>              error error code.
> 
>          Returns
> 
>              newly-allocated error message
> 
>     https://www.manpagez.com/html/glib/glib-2.46.0/glib-Windows-
>     Compatibility-Functions.php#g-win32-error-message <https://
>     www.manpagez.com/html/glib/glib-2.46.0/glib-Windows-Compatibility-
>     Functions.php#g-win32-error-message>
> 
>     Passing error codes from sources other than GetLastError() or
>     WSAGetLastError() violates this contract.
> 
>     Apparently, g_win32_error_message() returns NULL then.  This is not
>     documented behavior.
> 
> 
> It returns an empty string, not NULL.
> https://gitlab.gnome.org/GNOME/glib/-/blob/ 
> a205d01adc3fbc4f243e0b0fb52a3a0a8a0d9ae7/glib/gwin32.c#L216 <https:// 
> gitlab.gnome.org/GNOME/glib/-/blob/ 
> a205d01adc3fbc4f243e0b0fb52a3a0a8a0d9ae7/glib/gwin32.c#L216>

Worth reporting to GLib IMHO.

