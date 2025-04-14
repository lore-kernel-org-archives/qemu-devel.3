Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7C9C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 05:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4C2H-0006qv-TH; Mon, 14 Apr 2025 01:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u4C2F-0006qT-SR
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 01:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u4C2D-0004HG-H4
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 01:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744607221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ll6IniNpU4hfdSdOBDEEkawbwEous11xak5FPHlaBaQ=;
 b=PWyjzSMpwYJfr9qztnCJjyXZK2mR1opS31RSI5SvjAqCseHBUljc+5dS5aDRcHC0ril93b
 HX2K7K8LLrUFG3cyS0t3SdYh/RtMTRU8xJoSgXcjd0whpahJtYb6npd/MBqgtt6ZUtmylN
 kd35GZ0MKeXbbQ/oqLQ/NPH+oYWAFNA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-yF8-s-smOwGRMPXKFxj3Hw-1; Mon,
 14 Apr 2025 01:06:59 -0400
X-MC-Unique: yF8-s-smOwGRMPXKFxj3Hw-1
X-Mimecast-MFC-AGG-ID: yF8-s-smOwGRMPXKFxj3Hw_1744607218
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA37A1956089; Mon, 14 Apr 2025 05:06:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8692619560AD; Mon, 14 Apr 2025 05:06:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D8EEA21E66C2; Mon, 14 Apr 2025 07:06:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>
Cc: qemu-devel@nongnu.org,  Wen Congyang <wencongyang2@huawei.com>,  Hanna
 Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  John Snow
 <jsnow@redhat.com>,  Xie Changlong <xiechanglong.d@gmail.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-block@nongnu.org
Subject: Re: [PATCH v3] blockdev-backup: Add error handling option for
 copy-before-write jobs
In-Reply-To: <20250414011817.671328-1-Raman.Dzehtsiar@gmail.com> (Raman
 Dzehtsiar's message of "Mon, 14 Apr 2025 03:18:17 +0200")
References: <20250414011817.671328-1-Raman.Dzehtsiar@gmail.com>
Date: Mon, 14 Apr 2025 07:06:52 +0200
Message-ID: <87r01v1gcz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Raman Dzehtsiar <raman.dzehtsiar@gmail.com> writes:

> This patch extends the blockdev-backup QMP command to allow users to spec=
ify
> how to behave when IO errors occur during copy-before-write operations.
> Previously, the behavior was fixed and could not be controlled by the use=
r.
>
> The new 'on-cbw-error' option can be set to one of two values:
> - 'break-guest-write': Forwards the IO error to the guest and triggers
>   the on-source-error policy. This preserves snapshot integrity at the
>   expense of guest IO operations.
> - 'break-snapshot': Allows the guest OS to continue running normally,
>   but invalidates the snapshot and aborts related jobs. This prioritizes
>   guest operation over backup consistency.
>
> This enhancement provides more flexibility for backup operations in diffe=
rent
> environments where requirements for guest availability versus backup
> consistency may vary.
>
> The default behavior remains unchanged to maintain backward compatibility.
>
> Signed-off-by: Raman Dzehtsiar <Raman.Dzehtsiar@gmail.com>

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b1937780e1..d35326167d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1622,6 +1622,9 @@
>  # @discard-source: Discard blocks on source which have already been
>  #     copied to the target.  (Since 9.1)
>  #
> +# @on-cbw-error: optional policy defining behavior on I/O errors in
> +#     copy-before-write jobs; defaults to break-guest-write.  (Since 10.=
0)
> +#

This will come out like

    =E2=80=A2 on-cbw-error (OnCbwError, optional) =E2=80=93 optional policy=
 defining
      behavior on I/O errors in copy-before-write jobs; defaults to
      break-guest-write.  (Since 10.0)

Scratch "optional", please.

Also, make it 10.1, and keep the member documentation ordered like ...

>  # @x-perf: Performance options.  (Since 6.0)
>  #
>  # Features:
> @@ -1641,6 +1644,7 @@
>              '*compress': 'bool',
>              '*on-source-error': 'BlockdevOnError',
>              '*on-target-error': 'BlockdevOnError',
> +            '*on-cbw-error': 'OnCbwError',
>              '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
>              '*filter-node-name': 'str',
>              '*discard-source': 'bool',

... the actual members.

[...]


