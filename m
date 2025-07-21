Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFA4C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxii-0000MF-Ia; Mon, 21 Jul 2025 17:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udxd1-0003dP-Ea
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udxcy-0005sU-Dj
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753131651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O5GE9viBfL/P9tCl9w0OIO2ARHkUFKBGQf09tTRv5aA=;
 b=iiHaknW529KwJzAXtAWNA3bmkaTGvCRoNJTAAm2htpUBiYxuab8HqJjqScvpm4mJD8yIkF
 l8rXomYQ3Oys21Ng2Tf40A8ze+PdFdJa4irqEjDpXTr5dB6k2LKG2fb5+vwDHaEx0Afy1I
 dOiLPPj93Yq9x/eB0PJij3lBZmlJ3SI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-0TaHGrPxNn2SPbqUWTaMcQ-1; Mon, 21 Jul 2025 17:00:49 -0400
X-MC-Unique: 0TaHGrPxNn2SPbqUWTaMcQ-1
X-Mimecast-MFC-AGG-ID: 0TaHGrPxNn2SPbqUWTaMcQ_1753131648
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b26e33ae9d5so4929677a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 14:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753131648; x=1753736448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5GE9viBfL/P9tCl9w0OIO2ARHkUFKBGQf09tTRv5aA=;
 b=r02obLG0dmrA7mParQGpEHPADE84ReCgiiwM3kiNAW7l2OeS5ohSbp5aRbSy1Se/rE
 GMee9WLXOTxqVLRAEViv7UufCedx7YUPliegcVPvkBaHAKr1X39f9M4IMhggvOZPfn8S
 HMp+7OqOy/n+dxwyb8Cu2jq5GTkHP0nc9t79AqMk0vkyDwCtdSL3E6MBRGahfY0Wi83+
 bk7/IP8cQoN1EtgSGtAGhCGge7MeM6m2jaR02cGajKNwKkX2WZuiclFWAZoP5H/w5U+g
 Dej+hknYRiquQqX2HKHMQFNY7LnFO14OmvrbLTO/oHNUk1KAf6poOjsCQoNIGzF/IZS6
 1hdg==
X-Gm-Message-State: AOJu0YxuDVywJSD9lZcCWobGHvMrwRxIwj2ffsP0bjmyU3IVB0SJuAIq
 A8ux+7FORlJ8DzRaucu6k0cH6ShDgQtAZdiMvs/ezsFKYwkAFwIuEg7fxIE2ftXVFjRKKsYIGcQ
 bSby7yDfPDlQj/23w+/AlJWYz1E5FIGrN1FeW2YkpSAz0m8xSUrhTn/8k9GJheCtMu2ykYCDY9H
 gXhL5Z8i+G6LcGhX10Tw8C6Dub+/3RxPA=
X-Gm-Gg: ASbGncuRNZTpDn/d5cZCeefsGGnvORenpDWUVWFfFRKoxPaKv42D4KygY5fO8ijaTlf
 nPXmIKlIkukKDEgcFWDxeNCFJRbtzQkCl/1OWvoTS0EiDkvDWVJ0mxhaSW31drFrEU/aEpuGksT
 g3HaRKV1ZP1U2L21/5ORRBsqseSuDhh1/K1tHDc7oc3+JnMm4KaHyh
X-Received: by 2002:a17:90b:2fcc:b0:31e:3bac:96bc with SMTP id
 98e67ed59e1d1-31e3bac9951mr3751581a91.33.1753131648011; 
 Mon, 21 Jul 2025 14:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUnK8QQ7Mg1GzwztHX66pIZxdKNpH0eRwJ5G1nQfsIzMtKfe+JkjSM+y3vrebd7ePiywOUr8g8tqnoAXGW0TY=
X-Received: by 2002:a17:90b:2fcc:b0:31e:3bac:96bc with SMTP id
 98e67ed59e1d1-31e3bac9951mr3751510a91.33.1753131647317; Mon, 21 Jul 2025
 14:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250717115246.3830007-1-armbru@redhat.com>
 <20250717115246.3830007-5-armbru@redhat.com>
In-Reply-To: <20250717115246.3830007-5-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 21 Jul 2025 17:00:34 -0400
X-Gm-Features: Ac12FXxBZqWPk0FzT6FP6KjnWmzkacaylp4BQjpD1gc0aPF6_q45gvJj_YPVPww
Message-ID: <CAFn=p-YPk+9EQozpcRdHEsjN+BgxN9dq_irA0nkU=BDLpUJnjw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] qga: Add cross-references
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, michael.roth@amd.com, 
 kkostiuk@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

On Thu, Jul 17, 2025 at 7:52=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Enclose command and type names in `backquotes`, so they become links
> in generated HTML.
>
> We did this for qapi/ in merge commit 504632dcc631.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  qga/qapi-schema.json | 80 ++++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 6c26ace3c9..8162d888bb 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -96,11 +96,11 @@
>  # In cases where a partial stale response was previously received by
>  # the client, this cannot always be done reliably.  One particular
>  # scenario being if qemu-ga responses are fed character-by-character
> -# into a JSON parser.  In these situations, using guest-sync-delimited
> +# into a JSON parser.  In these situations, using `guest-sync-delimited`
>  # may be optimal.
>  #
>  # For clients that fetch responses line by line and convert them to
> -# JSON objects, guest-sync should be sufficient, but note that in
> +# JSON objects, `guest-sync` should be sufficient, but note that in
>  # cases where the channel is dirty some attempts at parsing the
>  # response may result in a parser error.
>  #
> @@ -217,7 +217,7 @@
>  #
>  # This command does NOT return a response on success.  Success
>  # condition is indicated by the VM exiting with a zero exit status or,
> -# when running with --no-shutdown, by issuing the query-status QMP
> +# when running with --no-shutdown, by issuing the `query-status` QMP
>  # command to confirm the VM status is "shutdown".
>  #
>  # Since: 0.15.0
> @@ -247,7 +247,7 @@
>  #
>  # Close an open file in the guest
>  #
> -# @handle: filehandle returned by guest-file-open
> +# @handle: filehandle returned by `guest-file-open`
>  #
>  # Since: 0.15.0
>  ##
> @@ -278,7 +278,7 @@
>  # As this command is just for limited, ad-hoc debugging, such as log
>  # file access, the number of bytes to read is limited to 48 MB.
>  #
> -# @handle: filehandle returned by guest-file-open
> +# @handle: filehandle returned by `guest-file-open`
>  #
>  # @count: maximum number of bytes to read (default is 4KB, maximum is
>  #     48MB)
> @@ -309,7 +309,7 @@
>  #
>  # Write to an open file in the guest.
>  #
> -# @handle: filehandle returned by guest-file-open
> +# @handle: filehandle returned by `guest-file-open`
>  #
>  # @buf-b64: base64-encoded string representing data to be written
>  #
> @@ -340,7 +340,7 @@
>  ##
>  # @QGASeek:
>  #
> -# Symbolic names for use in @guest-file-seek
> +# Symbolic names for use in `guest-file-seek`
>  #
>  # @set: Set to the specified offset (same effect as 'whence':0)
>  #
> @@ -355,7 +355,7 @@
>  ##
>  # @GuestFileWhence:
>  #
> -# Controls the meaning of offset to @guest-file-seek.
> +# Controls the meaning of offset to `guest-file-seek`.
>  #
>  # @value: Integral value (0 for set, 1 for cur, 2 for end), available
>  #     for historical reasons, and might differ from the host's or
> @@ -375,7 +375,7 @@
>  # current file position afterward.  Also encapsulates ftell()'s
>  # functionality, with offset=3D0 and whence=3D1.
>  #
> -# @handle: filehandle returned by guest-file-open
> +# @handle: filehandle returned by `guest-file-open`
>  #
>  # @offset: bytes to skip over in the file stream
>  #
> @@ -393,7 +393,7 @@
>  #
>  # Write file changes buffered in userspace to disk/kernel buffers
>  #
> -# @handle: filehandle returned by guest-file-open
> +# @handle: filehandle returned by `guest-file-open`
>  #
>  # Since: 0.15.0
>  ##
> @@ -434,12 +434,12 @@
>  # @guest-fsfreeze-freeze:
>  #
>  # Sync and freeze all freezable, local guest filesystems.  If this
> -# command succeeded, you may call @guest-fsfreeze-thaw later to
> +# command succeeded, you may call `guest-fsfreeze-thaw` later to
>  # unfreeze.
>  #
>  # On error, all filesystems will be thawed.  If no filesystems are
> -# frozen as a result of this call, then @guest-fsfreeze-status will
> -# remain "thawed" and calling @guest-fsfreeze-thaw is not necessary.
> +# frozen as a result of this call, then `guest-fsfreeze-status` will
> +# remain "thawed" and calling `guest-fsfreeze-thaw` is not necessary.
>  #
>  # Returns: Number of file systems currently frozen.
>  #
> @@ -457,7 +457,7 @@
>  # @guest-fsfreeze-freeze-list:
>  #
>  # Sync and freeze specified guest filesystems.  See also
> -# @guest-fsfreeze-freeze.
> +# `guest-fsfreeze-freeze`.
>  #
>  # On error, all filesystems will be thawed.
>  #
> @@ -482,7 +482,7 @@
>  # Returns: Number of file systems thawed by this call
>  #
>  # .. note:: If the return value does not match the previous call to
> -#    guest-fsfreeze-freeze, this likely means some freezable filesystems
> +#    `guest-fsfreeze-freeze`, this likely means some freezable filesyste=
ms
>  #    were unfrozen before this call, and that the filesystem state may
>  #    have changed before issuing this command.
>  #
> @@ -513,7 +513,7 @@
>  ##
>  # @GuestFilesystemTrimResponse:
>  #
> -# @paths: list of @GuestFilesystemTrimResult per path that was trimmed
> +# @paths: list of `GuestFilesystemTrimResult` per path that was trimmed
>  #
>  # Since: 2.4
>  ##
> @@ -557,7 +557,7 @@
>  #
>  # This command does NOT return a response on success.  There is a high
>  # chance the command succeeded if the VM exits with a zero exit status
> -# or, when running with --no-shutdown, by issuing the query-status QMP
> +# or, when running with --no-shutdown, by issuing the `query-status` QMP
>  # command to to confirm the VM status is "shutdown". However, the VM
>  # could also exit (or set its status to "shutdown") due to other
>  # reasons.
> @@ -565,7 +565,7 @@
>  # Errors:
>  #     - If suspend to disk is not supported, Unsupported
>  #
> -# .. note:: It's strongly recommended to issue the guest-sync command
> +# .. note:: It's strongly recommended to issue the `guest-sync` command
>  #    before sending commands when the guest resumes.
>  #
>  # Since: 1.1
> @@ -585,8 +585,8 @@
>  # - pm-utils (via pm-hibernate)
>  # - manual write into sysfs
>  #
> -# IMPORTANT: guest-suspend-ram requires working wakeup support in
> -# QEMU. You should check QMP command query-current-machine returns
> +# IMPORTANT: `guest-suspend-ram` requires working wakeup support in
> +# QEMU. You should check QMP command `query-current-machine` returns
>  # wakeup-suspend-support: true before issuing this command.  Failure
>  # in doing so can result in a suspended guest that QEMU will not be
>  # able to awaken, forcing the user to power cycle the guest to bring
> @@ -595,14 +595,14 @@
>  # This command does NOT return a response on success.  There are two
>  # options to check for success:
>  #
> -# 1. Wait for the SUSPEND QMP event from QEMU
> -# 2. Issue the query-status QMP command to confirm the VM status is
> +# 1. Wait for the `SUSPEND` QMP event from QEMU
> +# 2. Issue the `query-status` QMP command to confirm the VM status is
>  #    "suspended"
>  #
>  # Errors:
>  #     - If suspend to ram is not supported, Unsupported
>  #
> -# .. note:: It's strongly recommended to issue the guest-sync command
> +# .. note:: It's strongly recommended to issue the `guest-sync` command
>  #    before sending commands when the guest resumes.
>  #
>  # Since: 1.1
> @@ -621,8 +621,8 @@
>  # - systemd hybrid-sleep
>  # - pm-utils (via pm-suspend-hybrid)
>  #
> -# IMPORTANT: guest-suspend-hybrid requires working wakeup support in
> -# QEMU. You should check QMP command query-current-machine returns
> +# IMPORTANT: `guest-suspend-hybrid` requires working wakeup support in
> +# QEMU. You should check QMP command `query-current-machine` returns
>  # wakeup-suspend-support: true before issuing this command.  Failure
>  # in doing so can result in a suspended guest that QEMU will not be
>  # able to awaken, forcing the user to power cycle the guest to bring
> @@ -631,14 +631,14 @@
>  # This command does NOT return a response on success.  There are two
>  # options to check for success:
>  #
> -# 1. Wait for the SUSPEND QMP event from QEMU
> -# 2. Issue the query-status QMP command to confirm the VM status is
> +# 1. Wait for the `SUSPEND` QMP event from QEMU
> +# 2. Issue the `query-status` QMP command to confirm the VM status is
>  #    "suspended"
>  #
>  # Errors:
>  #     - If hybrid suspend is not supported, Unsupported
>  #
> -# .. note:: It's strongly recommended to issue the guest-sync command
> +# .. note:: It's strongly recommended to issue the `guest-sync` command
>  #    before sending commands when the guest resumes.
>  #
>  # Since: 1.1
> @@ -793,7 +793,7 @@
>  #     There's no restriction on list length or on repeating the same
>  #     @logical-id (with possibly different @online field).  Preferably
>  #     the input list should describe a modified subset of
> -#     @guest-get-vcpus' return value.
> +#     `guest-get-vcpus`' return value.
>  #
>  # Returns: The length of the initial sublist that has been
>  #     successfully processed.  The guest agent maximizes this value.
> @@ -1069,7 +1069,7 @@
>  #
>  # Returns: The list of filesystems information mounted in the guest.
>  #     The returned mountpoints may be specified to
> -#     @guest-fsfreeze-freeze-list.  Network filesystems (such as CIFS
> +#     `guest-fsfreeze-freeze-list`.  Network filesystems (such as CIFS
>  #     and NFS) are not listed.
>  #
>  # Since: 2.2
> @@ -1171,7 +1171,7 @@
>  ##
>  # @GuestMemoryBlockResponse:
>  #
> -# @phys-index: same with the 'phys-index' member of @GuestMemoryBlock.
> +# @phys-index: same with the 'phys-index' member of `GuestMemoryBlock`.
>  #
>  # @response: the result of memory block operation.
>  #
> @@ -1201,11 +1201,11 @@
>  #     guest-supported identifiers.  There's no restriction on list
>  #     length or on repeating the same @phys-index (with possibly
>  #     different @online field).  Preferably the input list should
> -#     describe a modified subset of @guest-get-memory-blocks' return
> +#     describe a modified subset of `guest-get-memory-blocks`' return
>  #     value.
>  #
>  # Returns: The operation results, it is a list of
> -#     @GuestMemoryBlockResponse, which is corresponding to the input
> +#     `GuestMemoryBlockResponse`, which is corresponding to the input
>  #     list.
>  #
>  #     Note: it will return an empty list if the @mem-blks list was
> @@ -1258,7 +1258,7 @@
>  #
>  # @err-data: base64-encoded stderr of the process.  Note: @out-data
>  #     and @err-data are present only if 'capture-output' was specified
> -#     for 'guest-exec'.  This field will only be populated after the
> +#     for `guest-exec`.  This field will only be populated after the
>  #     process exits.
>  #
>  # @out-truncated: true if stdout was not fully captured due to size
> @@ -1277,10 +1277,10 @@
>  # @guest-exec-status:
>  #
>  # Check status of process associated with PID retrieved via
> -# guest-exec.  Reap the process and associated metadata if it has
> +# `guest-exec`.  Reap the process and associated metadata if it has
>  # exited.
>  #
> -# @pid: pid returned from guest-exec
> +# @pid: pid returned from `guest-exec`
>  #
>  # Since: 2.5
>  ##
> @@ -1301,7 +1301,7 @@
>  ##
>  # @GuestExecCaptureOutputMode:
>  #
> -# An enumeration of guest-exec capture modes.
> +# An enumeration of `guest-exec` capture modes.
>  #
>  # @none: do not capture any output
>  #
> @@ -1310,7 +1310,7 @@
>  # @stderr: only capture stderr
>  #
>  # @separated: capture both stdout and stderr, but separated into
> -#     GuestExecStatus out-data and err-data, respectively
> +#     `GuestExecStatus` out-data and err-data, respectively
>  #
>  # @merged: capture both stdout and stderr, but merge together into
>  #     out-data.  Not effective on windows guests.
> @@ -1324,10 +1324,10 @@
>  ##
>  # @GuestExecCaptureOutput:
>  #
> -# Controls what guest-exec output gets captures.
> +# Controls what `guest-exec` output gets captures.
>  #
>  # @flag: captures both stdout and stderr if true.  Equivalent to
> -#     GuestExecCaptureOutputMode::all.  (since 2.5)
> +#     `GuestExecCaptureOutputMode`::all.  (since 2.5)
>  #
>  # @mode: capture mode; preferred interface
>  #
> --
> 2.49.0
>


