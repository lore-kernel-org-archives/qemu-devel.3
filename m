Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DC6CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 09:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqpZv-00061o-HI; Tue, 26 Aug 2025 05:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uqpZs-0005zi-Sr
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uqpZp-0003gP-5J
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756198966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4Lxk8aHwYpTBo+mDoutrKRjfhyWunw2NpvDy5Qek0s=;
 b=gklppJvpR1HE8kHp+b5wvgH4sS1hut63T70BuQBXmNc20XOjOaVNeGOg94WNu49buYQmcX
 3JCnYUVJOag0/4DFLFF5gySDffYVWn1kIyvOJjrqeSPrYMyGSClvMobsAIlcN/W6ET0JPi
 OlsZ5rD/2waXtkWP80h6O+xNsm8g+KQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-k_j81v3WPqmtSE8NlKIPzQ-1; Tue, 26 Aug 2025 05:02:40 -0400
X-MC-Unique: k_j81v3WPqmtSE8NlKIPzQ-1
X-Mimecast-MFC-AGG-ID: k_j81v3WPqmtSE8NlKIPzQ_1756198960
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-71d603bf1c4so65281267b3.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 02:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756198959; x=1756803759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4Lxk8aHwYpTBo+mDoutrKRjfhyWunw2NpvDy5Qek0s=;
 b=XJSiejBd1hA5hllzbWxTbiFq3EERVnb0PRFR67+cp1pxU1MW2qJZerNrMZREgnJgDs
 64w5U6KLXI/RF3F6sp5s4gr4z5i2mLDhgKmItCNV3DRWnV7URZPZ82VuBAR5Nv6xZpMZ
 xhi42QiYiEpl+I3KD8d6LxjgPb93gXp4HlzuGVlqevgT4FR5mh1xBa3dWZD1i4i3FLKG
 HuBfla7LC7P8BpeFW7X6v+NyhVGxJDvoap4dBbs4ARUFFNeBq5pxUCEyTCJ7zBJAYePF
 DEDZoPf9AfLVNgdPQ5lJXgW1zyRTsUJ9qJ9KwkWx07fMNLhDuy6RA7wi0m1Lt3S+5M3p
 ZUCg==
X-Gm-Message-State: AOJu0Yzvo/gX34Qa7NJnLxDnELUK9Q0Me5pDP0OjTfEMNWla+eBMgSU3
 L8YIBqEQZd9nYi0kZsCtu0E2CBFwgMkepZsO7VF/bLIfc5XZovp6cAve93mi64hyz0CajOV7zlx
 ha+qY9R/5Abab7voWLtxjYfh3dDVCEgHQf0E0/7Xex3t2JSR9Vu1oP/Vr7RyAokDAbEfH8H2vT4
 +HRq+k7ZJj622YVVAjKVKgWdbJJkhYpYJTiJ1kM2Y=
X-Gm-Gg: ASbGnctMGNmq7R29MBrRX+ajP7YBwbUS4ib0dXfJZNLx03bJfqIZMCkOTn46mEyI5uM
 OJhfaOuw/+pmtPfXPnIW2aMhGjBPgN5GGajkdatMRrY5f4gTZVDQUhM/S1mYIhIhJRMvyepH7Vc
 q/03w3uV1TzqYgyF6k38k+ySonKhXnJqzm6KVmTSj3ubDtF3YpTw==
X-Received: by 2002:a05:690c:4d84:b0:71f:b944:101c with SMTP id
 00721157ae682-71fdc57fe50mr147321537b3.46.1756198959346; 
 Tue, 26 Aug 2025 02:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe4Mn45XXIsVG32eIUEaV4ex5XI56pJUDSBv9sdjU4JqiTynZ2wHfAxCoG4HC32OsjwT52rS8zrPmPzbHS9lQ=
X-Received: by 2002:a05:690c:4d84:b0:71f:b944:101c with SMTP id
 00721157ae682-71fdc57fe50mr147321387b3.46.1756198958982; Tue, 26 Aug 2025
 02:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250825135311.138330-1-kkostiuk@redhat.com>
In-Reply-To: <20250825135311.138330-1-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Tue, 26 Aug 2025 12:02:26 +0300
X-Gm-Features: Ac12FXxBqJZ14GgXMCsIBE0LUpy1DZXVC5lOE7Z8RfssRhw1PoeMDzxXun9nQEw
Message-ID: <CAGoVJZy6m3=JdwF502A1Y+q7N8g5nC93qufrwGEo6V36YZD_8w@mail.gmail.com>
Subject: Re: [PATCH] qga-vss: Write hex value of error in log
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 25, 2025 at 4:53=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com> wrote:
>
> QGA-VSS writes error using error_setg_win32_internal,
> which call g_win32_error_message.
>
> g_win32_error_message - translate a Win32 error code
> (as returned by GetLastError()) into the corresponding message.
>
> In the same time, we call error_setg_win32_internal with
> error codes from different Windows componets like VSS or
> Performance monitor that provides different codes and
> can't be converted with g_win32_error_message. In this
> case, the empty suffix will be returned so error will be
> masked.
>
> This commit directly add hex value of error code.
>
> Reproduce:
>  - Run QGA command: {"execute": "guest-fsfreeze-freeze-list", "arguments"=
: {"mountpoints": ["D:"]}}
>
> QGA error example:
>  - before changes:
>   {"error": {"class": "GenericError", "desc": "failed to add D: to snapsh=
ot set: "}}
>  - after changes:
>   {"error": {"class": "GenericError", "desc": "failed to add D: to snapsh=
ot set: Windows error 0x8004230e: "}}
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/vss-win32/requester.cpp | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 4401d55e3a..644514fb95 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -28,8 +28,9 @@
>
>  #define err_set(e, err, fmt, ...) {                                     =
    \
>      (e)->error_setg_win32_wrapper((e)->errp, __FILE__, __LINE__, __func_=
_,  \
> -                                   err, fmt, ## __VA_ARGS__);           =
    \
> -    qga_debug(fmt, ## __VA_ARGS__);                                     =
    \
> +                                   err, fmt ": Windows error 0x%lx",    =
    \
> +                                   ## __VA_ARGS__, err);                =
    \
> +    qga_debug(fmt ": Windows error 0x%lx", ## __VA_ARGS__, err);        =
    \
>  }
>  /* Bad idea, works only when (e)->errp !=3D NULL: */
>  #define err_is_set(e) ((e)->errp && *(e)->errp)
> --
> 2.50.1
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>


