Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23C5C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxbM-0002HM-EZ; Mon, 21 Jul 2025 16:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udxZr-0001At-AY
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udxZo-0004sf-3y
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753131454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4358BB0ZdYlZXmC0GvHVwWPKLk2/oxzKTQz2hNa+rQ=;
 b=RgF+mzTnS8tsubw9obLEudz4QFmY0LXxRuNAyiwa446DmPNqSh4AiAXHDpel/h2Fxb4n/G
 tM+jzxLl8SRomuTlsvtTIsJTJfWFSpGd7LQYyyW09o1CzOECUI4MSSkLbSMUm/11VtCFiK
 ixwjEbyyBCAXf/zHCUN6qbjcaHOVRUA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-c5fzqLGvOO6VI99WKnYZ3A-1; Mon, 21 Jul 2025 16:57:32 -0400
X-MC-Unique: c5fzqLGvOO6VI99WKnYZ3A-1
X-Mimecast-MFC-AGG-ID: c5fzqLGvOO6VI99WKnYZ3A_1753131452
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-311e98ee3fcso6106627a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 13:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753131451; x=1753736251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4358BB0ZdYlZXmC0GvHVwWPKLk2/oxzKTQz2hNa+rQ=;
 b=aqCEXLFbKCuBAif3IKsKovB8oilh2L0ncZVCRf2s98ldZOS+Cdm572QumRkEOPxeEp
 XvBd8eEW7kOEiOsmhsvVKjFGzusfO7Fvb2PeRykHaOuj/ggjcNMBe7icIv3MpPo+KNZ2
 0WSLEYMAXqo6FOpvTdW6T1V+ub6iSucRqGmBXyKTSqXOd3Hh+y7XNstnE/3iMFNoHMVS
 V2sYk1WkeW29rze+zAKoKfyMqjSogPP4SEPc+3/oLiiYPYdLSTu5v1dziYl3lDjj7Z66
 mPaVwo7+CDuYbgbQiUfmkiapVYSsHe8GpsdQAnzkiZxwKvmaq9O6RV0+D7rk7VZ5P84u
 eLeQ==
X-Gm-Message-State: AOJu0YxNFBQ3NLQJJmpyoe/b4CI/2gOhHWgSp+bQrU8ic49L+R2aL4E3
 yoO58FYt1mPrBpfcPDPsb26z66oxwsjm1lPEgYdKDAyWkXsZg1+liQXP5fa/SxrAAKoeipZnsam
 E3HeMFT2khcWBv0Fgn2XoZnTzUBhVZqdgwvK+frXLDmzO0d3dhgXZHATFcryOU0ycAeLD6xEGMK
 P39kADzbodf9JaX0sscM0uUz/NnqLa5B0=
X-Gm-Gg: ASbGncsbPepBXHHyKnsg1hg2eiZWinc6QCkERwyzKVunV8CsDR4+RfvKYuwN5AXMLjc
 acc5xn9Jkcdesxc4jwVonFGyfpo0VGYRdGbGamL46tLm8PtRAE56iMgam6CUarpfcIEzjSxviWc
 mh8rmkkQPlcaT7ruBuLygtfWU4LQQnc+gfRXr/94yckhVPiYorbb5f
X-Received: by 2002:a17:90b:1b50:b0:313:d361:73d7 with SMTP id
 98e67ed59e1d1-31e3e17b307mr1244727a91.13.1753131451451; 
 Mon, 21 Jul 2025 13:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAGFUuhsvDiXCLekARfhpn9zuh9g/enIxSuk2H77NsZQRGStkritcqYnKJ4hhYeQ0aNjh6x+D7rLo/RdCjWrE=
X-Received: by 2002:a17:90b:1b50:b0:313:d361:73d7 with SMTP id
 98e67ed59e1d1-31e3e17b307mr1244712a91.13.1753131450993; Mon, 21 Jul 2025
 13:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250717115246.3830007-1-armbru@redhat.com>
 <20250717115246.3830007-3-armbru@redhat.com>
In-Reply-To: <20250717115246.3830007-3-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 21 Jul 2025 16:57:17 -0400
X-Gm-Features: Ac12FXwHItPvNzMVxjYm_0IA7rAPME4OdqmeCXwju8P7R3iqxO0AtHZxdYmqW-w
Message-ID: <CAFn=p-a5VYx7jsyp1c=uVuWsttv6OWmZ-_PLKzLH5-d69OvWkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] qga: Remove trivial "Returns:" sections
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
> The QAPI doc generator recently started to auto-generate return
> documentation when there is no "Returns:" section (commit 636c96cd77d
> "qapi: Fix undocumented return values by generating something").
> Remove "Returns:" sections where the auto-generated text is obviously
> no worse.  For instance, guest-info's documentation changes from
>
>     Return:
>        GuestAgentInfo -- GuestAgentInfo
>
> to
>
>     Return:
>        GuestAgentInfo
>
> The auto-generated returns all are in the exact same spot.
>
> We did this for qapi/ in commit 0462da9d6b1 (qapi: remove trivial
> "Returns:" sections).
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  qga/qapi-schema.json | 25 -------------------------
>  1 file changed, 25 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a569a14b55..a9cc9150dc 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -202,8 +202,6 @@
>  #
>  # Get some information about the guest agent.
>  #
> -# Returns: @GuestAgentInfo
> -#
>  # Since: 0.15.0
>  ##
>  { 'command': 'guest-info',
> @@ -285,8 +283,6 @@
>  # @count: maximum number of bytes to read (default is 4KB, maximum is
>  #     48MB)
>  #
> -# Returns: @GuestFileRead
> -#
>  # Since: 0.15.0
>  ##
>  { 'command': 'guest-file-read',
> @@ -320,8 +316,6 @@
>  # @count: bytes to write (actual bytes, after base64-decode), default
>  #     is all content in buf-b64 buffer after base64 decoding
>  #
> -# Returns: @GuestFileWrite
> -#
>  # Since: 0.15.0
>  ##
>  { 'command': 'guest-file-write',
> @@ -387,8 +381,6 @@
>  #
>  # @whence: Symbolic or numeric code for interpreting offset
>  #
> -# Returns: @GuestFileSeek
> -#
>  # Since: 0.15.0
>  ##
>  { 'command': 'guest-file-seek',
> @@ -428,9 +420,6 @@
>  #
>  # Get guest fsfreeze state.
>  #
> -# Returns: GuestFsfreezeStatus ("thawed", "frozen", etc., as defined
> -#     below)
> -#
>  # .. note:: This may fail to properly report the current state as a
>  #    result of some other guest processes having issued an fs
>  #    freeze/thaw.
> @@ -749,8 +738,6 @@
>  #
>  # Get list of guest IP addresses, MAC addresses and netmasks.
>  #
> -# Returns: List of GuestNetworkInterface
> -#
>  # Since: 1.1
>  ##
>  { 'command': 'guest-network-get-interfaces',
> @@ -1251,8 +1238,6 @@
>  #
>  # Get information relating to guest memory blocks.
>  #
> -# Returns: @GuestMemoryBlockInfo
> -#
>  # Since: 2.3
>  ##
>  { 'command': 'guest-get-memory-block-info',
> @@ -1298,8 +1283,6 @@
>  #
>  # @pid: pid returned from guest-exec
>  #
> -# Returns: GuestExecStatus
> -#
>  # Since: 2.5
>  ##
>  { 'command': 'guest-exec-status',
> @@ -1458,8 +1441,6 @@
>  #
>  # Retrieves the timezone information from the guest.
>  #
> -# Returns: A GuestTimezone dictionary.
> -#
>  # Since: 2.10
>  ##
>  { 'command': 'guest-get-timezone',
> @@ -1533,8 +1514,6 @@
>  #
>  # Retrieve guest operating system information
>  #
> -# Returns: @GuestOSInfo
> -#
>  # Since: 2.10
>  ##
>  { 'command': 'guest-get-osinfo',
> @@ -1604,8 +1583,6 @@
>  #
>  # Retrieve information about device drivers in Windows guest
>  #
> -# Returns: @GuestDeviceInfo
> -#
>  # Since: 5.2
>  ##
>  { 'command': 'guest-get-devices',
> @@ -1633,8 +1610,6 @@
>  #
>  # @username: the user account to add the authorized keys
>  #
> -# Returns: @GuestAuthorizedKeys
> -#
>  # Since: 5.2
>  ##
>  { 'command': 'guest-ssh-get-authorized-keys',
> --
> 2.49.0
>


