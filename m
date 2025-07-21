Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F90FC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udod1-0004AO-9w; Mon, 21 Jul 2025 07:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1udocr-0003xT-Fx
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1udoco-0008In-In
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvkTVmkFChgh4Bhw78ggddaNI0LaoG4bVMHNwgm3Tyg=;
 b=I5mrZ1JEG70XjvpMDlZrmYmkJc4IY4okb9XHlfrIf6eY76H4ewoNf+LzWRXxVi0bOpQOJo
 0YSplaOmNdxuofRsbLXuULIGXWgXGXJyUK3gEIJqTYuE5NNXpQBBBlUeDasNXftfY30ud0
 ANIlVKqV65hMGKuNnQ+bdrgAq7LwXCg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-_BPSkXGmPrWH7BIfMElpKw-1; Mon, 21 Jul 2025 07:24:02 -0400
X-MC-Unique: _BPSkXGmPrWH7BIfMElpKw-1
X-Mimecast-MFC-AGG-ID: _BPSkXGmPrWH7BIfMElpKw_1753097042
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7194c6b0892so46257897b3.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097042; x=1753701842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvkTVmkFChgh4Bhw78ggddaNI0LaoG4bVMHNwgm3Tyg=;
 b=q/68+Pz4LfW9CV8kA0cMyzqK+IC9exxXf+kXSmGhuWRs79i1SdqmxX+Asw2OomoLX+
 g9wVCW2BgK/79jZ85saoZs6+pbk3QTTRiWO2Un0nAtVvhtcdzwHwGC1K+3E4ox4SzSKF
 0uLZ0FcUCQmMhYVZYZm8SYsoMxA/ZpAnInrs/j9beMbTiR7KwxP9k0SpNtE+WcACWeM3
 nHjHJt67wpT7Ei7yJVvIWIzYyGumYEjx7v/DayNDjxC2dU5rRiz8J2WoxqND/LDTwrL+
 WMLcZnx5sJgDxHZsJn9oTxTacy0uVB+nWv2RdrnV9P6q/tSlVp6bLWIpPyJdOHWemwyd
 AqYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhbQNlmcGNr1cQe2hh/c+8V9gQlaDjfH3ptETY96jWOL+srPnZ/zrK8jjSim9ZHNJqBLB4w9sVHauv@nongnu.org
X-Gm-Message-State: AOJu0YzTlx2Doq05xiqGlPwJAIBQsqwrR1iqsKnTnDCxpz0MEt5/Y5rz
 n5Ma/GaWIPT9xLcnIfGlDIOW89j3zIvW/aheDPWXEn9m4sgiJJbGd39ynN+5UdEG4d4q0WySbRh
 2AhXdi+Kc3F8FUBuhUqcDgMwewT6sjW6+RqnpCktbzl0doCdboC0bMJTxMqIlTGuGo8vAFN7ALU
 pmvxlB65WWNz4IyNKWdssJGOOLwJqA2po=
X-Gm-Gg: ASbGncvUH06vDWtxqdy12Icv8q1iXxelvHCX3vNX+mK79yyKZ4aiglYJsRq7FeorFGo
 kGCHr2yEdUBnn/LRU2Vbd3fwXhSrB9BEXxEOM5qpG95kIoQykcpfHnjOPN7DCyaxHLtIUMAEUIe
 /0aT/F8rHchZcefTM0GL3BzFo67LyX8aeQm472y3Uv51bkYOstSy3BDPs=
X-Received: by 2002:a05:690c:6c09:b0:717:d7d1:4697 with SMTP id
 00721157ae682-718375174f7mr245794947b3.30.1753097041622; 
 Mon, 21 Jul 2025 04:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrTnY3wwXQ2B4Z4Sei64xK1jU/v0RLq4c60Bk9l5F1I+ysNq3x1m3mfHelifZM30RHkLdGP3PIzfLe+mrr6sA=
X-Received: by 2002:a05:690c:6c09:b0:717:d7d1:4697 with SMTP id
 00721157ae682-718375174f7mr245794757b3.30.1753097041246; Mon, 21 Jul 2025
 04:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250717145948.77870-1-kkostiuk@redhat.com>
 <87pldwbspt.fsf@pond.sub.org>
 <CAPMcbCp=PBMSxtTxCMkxigdovaY=MTNLRo6f3BBXNRT6vu4wmw@mail.gmail.com>
 <87seipkif5.fsf@pond.sub.org>
 <CAPMcbCrTTkr5sX11wn1WaXOLgqQTAD-1oxUuqOc+oEmUxcotkw@mail.gmail.com>
In-Reply-To: <CAPMcbCrTTkr5sX11wn1WaXOLgqQTAD-1oxUuqOc+oEmUxcotkw@mail.gmail.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Mon, 21 Jul 2025 14:23:50 +0300
X-Gm-Features: Ac12FXw3io3lolAul1U1wtbGZpAYNfiLLf4v9MbwbocBLgD6uSatlA6xzYyZFQc
Message-ID: <CAGoVJZySZ87UHWJpKTwtNZLvP3ygTxmo6hWEcndhTF5dosBfag@mail.gmail.com>
Subject: Re: [PATCH] util: win32: Write hex value when can't get error message
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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

On Mon, Jul 21, 2025 at 1:12=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com> wrote:
>
>
>
> On Mon, Jul 21, 2025 at 12:22=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
>> Kostiantyn Kostiuk <kkostiuk@redhat.com> writes:
>>
>> > On Sat, Jul 19, 2025 at 9:27=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
>> >
>> >> Kostiantyn Kostiuk <kkostiuk@redhat.com> writes:
>> >>
>> >> > g_win32_error_message - translate a Win32 error code
>> >> > (as returned by GetLastError()) into the corresponding message.
>> >> >
>> >> > In the same time, we call error_setg_win32_internal with
>> >> > error codes from different Windows componets like VSS or
>> >> > Performance monitor that provides different codes and
>> >> > can't be converted with g_win32_error_message.
>> >>
>> >> Are these error codes from GetLastError()?
>> >>
>> >
>> > No.
>> > VSS functions directly return an error code.
>> > Section: Return value -
>> > https://learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-vsback=
up-ivssbackupcomponents-addtosnapshotset
>> >
>> > Performance Counters API can return a system error code or a PDH error=
 code.
>> > Section: Return value -
>> > https://learn.microsoft.com/en-us/windows/win32/api/pdh/nf-pdh-pdhopen=
queryw
>> > System error code =3D GetLastError, PDH error code, something else.
>> >
>> > https://learn.microsoft.com/en-us/windows/win32/perfctrs/pdh-error-cod=
es
>> > FormatMessage requires LoadLibrary(L"pdh.dll") to work properly.
>>
>> The error code error_setg_win32() takes is passed to
>> g_win32_error_message().  Contract:
>>
>>     g_win32_error_message ()
>>
>>     gchar *
>>     g_win32_error_message (gint error);
>>
>>     Translate a Win32 error code (as returned by GetLastError() or
>>     WSAGetLastError()) into the corresponding message.  The message is
>>     either language neutral, or in the thread's language, or the user's
>>     language, the system's language, or US English (see docs for
>>     FormatMessage()).  The returned string is in UTF-8.  It should be
>>     deallocated with g_free().
>>
>>     Parameters
>>
>>         error error code.
>>
>>     Returns
>>
>>         newly-allocated error message
>>
>> https://www.manpagez.com/html/glib/glib-2.46.0/glib-Windows-Compatibilit=
y-Functions.php#g-win32-error-message
>>
>> Passing error codes from sources other than GetLastError() or
>> WSAGetLastError() violates this contract.
>>
>> Apparently, g_win32_error_message() returns NULL then.  This is not
>> documented behavior.

If glib wrapper behaviour is undocumented, let's not use it in Windows
related code and use Win32 API directly.
We can also fix the documentation.

Also, if we take a look at
https://learn.microsoft.com/en-us/windows/win32/api/errhandlingapi/nf-errha=
ndlingapi-getlasterror
then it looks like GetLastError might return error codes that don't
have strings in the system, again this is exactly the case were we
want the numeric value to be propagated and not silently dropped.

Best regards,
Yan.

>
>
> It returns an empty string, not NULL.
> https://gitlab.gnome.org/GNOME/glib/-/blob/a205d01adc3fbc4f243e0b0fb52a3a=
0a8a0d9ae7/glib/gwin32.c#L216
>
>>
>> Your fix relies on this undocumented behavior.
>
>
> As for me, this behaviour is almost expected (I expected NULL instead of =
an empty string) because
> g_win32_error_message uses FormatMessage, and FormatMessage returns NULL =
if an unknown error code
> is provided. And I know this, because FormatMessage is the only way on Wi=
ndows to get a human-readable
> string from the error code.
>
>>
>>
>> I believe we should instead fix the misuses of error_setg_win32().
>
>
> This will be more complicated.
> 1. I don't know what code was returned by the Performance Counters API (s=
ystem or PDH)
> 2. QGA call error_setg_win32_internal as part of error propagation with d=
ifferent error codes,
>  fix the misuses in this case means have a different error propagator for=
 different error codes (back to 1)
> 3. Also, this means that I need to reimplement error_setg_win32_internal =
for non-system errors with only
> one difference: "unknown Windows error 0x%x" instead of g_win32_error_mes=
sage, because anyway
> I need the full error propagation part.
>
>>
>> [...]
>>


