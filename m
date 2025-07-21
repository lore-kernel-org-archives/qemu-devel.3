Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E210DC87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 09:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udmjc-0006l6-Rc; Mon, 21 Jul 2025 05:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1udmj4-0006Ca-TV
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 05:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1udmj0-0005Va-2E
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 05:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753089732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=varHI3Loz9me+KzS0gHmXoqUjqwM3aYm+L29Kco/5xU=;
 b=VgjPxnWprJ2D7+V3sKeXyCUgphF2L7R/cNKOm+Va++e7PawD0cn+KR2fIXU2tLgfOg6Vd+
 N31mhiscalR616Xy56vYuMXUYfibEGUH6Nw/9R48KW8xchFEZUZL165qXSchFqPFyGWQPe
 Yjs+szEKyfXz7S/u8R+8N5yhwdiw1yg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-fN9r0UtHOmWKod1xIv4GXw-1; Mon,
 21 Jul 2025 05:22:10 -0400
X-MC-Unique: fN9r0UtHOmWKod1xIv4GXw-1
X-Mimecast-MFC-AGG-ID: fN9r0UtHOmWKod1xIv4GXw_1753089729
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74B9119560B4
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 09:22:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CB2218004AD
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 09:22:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 607F321E6A27; Mon, 21 Jul 2025 11:22:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org,  Yan Vugenfirer <yvugenfi@redhat.com>,  Daniel
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] util: win32: Write hex value when can't get error message
In-Reply-To: <CAPMcbCp=PBMSxtTxCMkxigdovaY=MTNLRo6f3BBXNRT6vu4wmw@mail.gmail.com>
 (Kostiantyn Kostiuk's message of "Mon, 21 Jul 2025 10:07:27 +0300")
References: <20250717145948.77870-1-kkostiuk@redhat.com>
 <87pldwbspt.fsf@pond.sub.org>
 <CAPMcbCp=PBMSxtTxCMkxigdovaY=MTNLRo6f3BBXNRT6vu4wmw@mail.gmail.com>
Date: Mon, 21 Jul 2025 11:22:06 +0200
Message-ID: <87seipkif5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Kostiantyn Kostiuk <kkostiuk@redhat.com> writes:

> On Sat, Jul 19, 2025 at 9:27=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> Kostiantyn Kostiuk <kkostiuk@redhat.com> writes:
>>
>> > g_win32_error_message - translate a Win32 error code
>> > (as returned by GetLastError()) into the corresponding message.
>> >
>> > In the same time, we call error_setg_win32_internal with
>> > error codes from different Windows componets like VSS or
>> > Performance monitor that provides different codes and
>> > can't be converted with g_win32_error_message.
>>
>> Are these error codes from GetLastError()?
>>
>
> No.
> VSS functions directly return an error code.
> Section: Return value -
> https://learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-vsbackup-=
ivssbackupcomponents-addtosnapshotset
>
> Performance Counters API can return a system error code or a PDH error co=
de.
> Section: Return value -
> https://learn.microsoft.com/en-us/windows/win32/api/pdh/nf-pdh-pdhopenque=
ryw
> System error code =3D GetLastError, PDH error code, something else.
>
> https://learn.microsoft.com/en-us/windows/win32/perfctrs/pdh-error-codes
> FormatMessage requires LoadLibrary(L"pdh.dll") to work properly.

The error code error_setg_win32() takes is passed to
g_win32_error_message().  Contract:

    g_win32_error_message ()

    gchar *
    g_win32_error_message (gint error);

    Translate a Win32 error code (as returned by GetLastError() or
    WSAGetLastError()) into the corresponding message.  The message is
    either language neutral, or in the thread's language, or the user's
    language, the system's language, or US English (see docs for
    FormatMessage()).  The returned string is in UTF-8.  It should be
    deallocated with g_free().

    Parameters

        error error code.

    Returns

        newly-allocated error message

https://www.manpagez.com/html/glib/glib-2.46.0/glib-Windows-Compatibility-F=
unctions.php#g-win32-error-message

Passing error codes from sources other than GetLastError() or
WSAGetLastError() violates this contract.

Apparently, g_win32_error_message() returns NULL then.  This is not
documented behavior.

Your fix relies on this undocumented behavior.

I believe we should instead fix the misuses of error_setg_win32().

[...]


