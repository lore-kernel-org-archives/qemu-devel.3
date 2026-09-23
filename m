Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD74BC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qms-0005nV-Jo; Wed, 23 Sep 2026 13:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9Qmr-0005nG-G1
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9Qmp-0003Od-Hh
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QyDJ8VVCPCCDUHE+c0FpJpfW60EQLN0F2T2Jte4kmBc=;
 b=SQ29s+VG2940fVwY8bdVf0QaDlvYX+t9ZG2ldNP9ZBDRaSgSJLRIAmUeLrlXsOxNa8HUTM
 ktnyszvczA9Lnet2GJFwoBZQU7nM/hu7O9VBgoGgo9CFiXRk28d2Y8O8bzvDG6r6LGpGZr
 kcABiou5L90WCeq/dM5v7SrTuYuwnJw=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-LlOt2xKyNX2N9wqQDwhPZQ-1; Wed, 23 Sep 2026 13:29:36 -0400
X-MC-Unique: LlOt2xKyNX2N9wqQDwhPZQ-1
X-Mimecast-MFC-AGG-ID: LlOt2xKyNX2N9wqQDwhPZQ_1790184576
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66c70bf18a1so1629678d50.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790184576; cv=none;
 d=google.com; s=arc-20260327;
 b=NufOeZZLSQOIpoRzmGRg+Tc0K8vpeAGEcfzY/nDii7EbPinVrjjOhwW2+Fd+aFBCVE
 Z3M7/eX9bboz42jVPCcQec69JxeomN7IlB2QOtjUd0DOLBGMBxbanbiupEW6aqxe0dwt
 j1e0l/og1W3N1y4YZ3IiJsCiriRcEUSykdpMcTE/W8QsHLPTpB5PIElsB9PZDpbMO4CI
 ItY1NeRAT3qF9pzsDxHO8K19EpCdVeUhqaE6UeQ55lWm+0Cp6KfnYZoLzAIKWl6JwBQI
 rP8lnvmYlbOkjLYLa29Fw0FwCry/5wNl/nx6fR9MDq+1S76GA9HcrYwqXvdWSw0uMov0
 rfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QyDJ8VVCPCCDUHE+c0FpJpfW60EQLN0F2T2Jte4kmBc=;
 fh=efRD72j90xG4W9da5AhqhuaTclpdW0BT0ucrSh4Idro=;
 b=ji/34HUZJE++dpN9o0gEL6NZPzEuk3SDEw2j7zH9X2Ful1ZXhrPvGYfYlDOzIdgqA1
 u44sVfXmJ2/MI0yqWUAFN42i36ceb4FDX8jjuldOYDFXq3ZZ2ELMQv83ZP9BLbRLqcAP
 M5ZEce4hZ8OWNA4xQcIirmFHbNDWDHQ5C562WjcsuMQC3lFCHbXV+bG4s1j7lqdxnD57
 4dSj+sUIj820IohhLkMIuGYxXPTTqgyhJOF5jR9WIpRlaT4aaeoDKon4tJcR5ROF+US6
 705pg8LBB3dXpzkK8jlpEzahL8Chw1Ls167V/ynz5RKLolDOdZTGjcoji7hlqACEiWfd
 ABGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184576; x=1790789376; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QyDJ8VVCPCCDUHE+c0FpJpfW60EQLN0F2T2Jte4kmBc=;
 b=FJ+7Df9Xi1jZgNHx/tvPerpPMe2rH9HXY1B5UA0h5QYv7zln/nBojTUWw3eYmDswi0
 oRc1+pITubBQe3es/SrPVNh0yHW/olm9ZSSJy1qKR24Tg/1oLlFVxiSQssBbRInlnq2t
 rJ37fnR3GUxnBMrIDH53t1f/uLTNGrVS+DUgDUA4PY6tjJWte4EjRCxKAgvUhUzMbyNk
 whdc6jy0EkCil676TbnebW4RDs1nWX34TKypuYpcV8+YsCHomzuiyrGXXpQPcrAeRNFM
 RM/hOc5izOE/lx/TYxC25w8Rcr589GeMcXkbk1qxxTDLO81yRjFA0pTVoPLcdXRZbW/c
 SbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184576; x=1790789376;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QyDJ8VVCPCCDUHE+c0FpJpfW60EQLN0F2T2Jte4kmBc=;
 b=cXchxQgqLSg5QqTLiqHEcQkY+V4pPjc4n5dU9LJgzXrY9N9PLO7Tfp+VoyAn8KUeu+
 mcBWAbw/8CnDXqhcxDiZbPyU3rLoCQbcvYewk3OFHu8pCjS1LTqWku8oSI8jhD7f0kmj
 +4G4BHAHG+Nq1UZax5h7iebYYP8rqPLk6damY2Y1CzKWyKuoZk/LWASjSCz/U3wGOBqD
 be6NMGFG4Z/j7Ww73gmc3OG+VUqkma7kKiHVSM5yYwhKTswLhuG+5ie1DJY2zPTFqbq+
 gYWIO//jyKV6vh1okWtJdCcK9aOtiGBzprT6fqE0S0V6yG9XK6be8lRPjVgNjPadfrPh
 1W6Q==
X-Gm-Message-State: AFuF++lMOHjhk2qDsNZ3/IvSjZBkLeVN+QkoUhbUWGPxCuA8Mj2SSmtX
 F1B7/SJc/wo2Zb/4yvrPq8oZi/Qsf7w46iGf5zZMst2UWt75aaPGKr+QhJ10yINvLun5G+FqSw9
 uipbGhwN5SNDBXMNM4+eBtg3gKe9xwVGIH9e67eGzbxsyIwufSpJ+IXhSczcAkkb4buzEZ9HsJp
 c9igub7dSMsf9B2xeJh+2GH+uYwm6PcHM=
X-Gm-Gg: AYBFou2XOZpbknQ2P8QSUKR0a//JME0VmkBm7G+IWhhFxaskQpVsveKZTDLpf3E+Y3E
 Hel866BDfd/vuX2ksy2zJHM65buQmuwYKWFMjQsDpdDP7NlLy/QfS1VnK7mv6X5uDOj/SvmkCVE
 X6GFn53GktxobmrB4oZ5LnR6OIi4OzkHJGJkkhtfWfBKW1hm5SdqXRrHGHwgX6iNcQByBtqlxV1
 vCW30eHZSS5kdaZ
X-Received: by 2002:a05:690e:b4a:b0:672:a52c:daf4 with SMTP id
 956f58d0204a3-672d5976331mr1958704d50.103.1790184575982; 
 Wed, 23 Sep 2026 10:29:35 -0700 (PDT)
X-Received: by 2002:a05:690e:b4a:b0:672:a52c:daf4 with SMTP id
 956f58d0204a3-672d5976331mr1958689d50.103.1790184575546; Wed, 23 Sep 2026
 10:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260923070351.855246-1-armbru@redhat.com>
In-Reply-To: <20260923070351.855246-1-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 23 Sep 2026 13:29:24 -0400
X-Gm-Features: AcwNN1VK-h2Fsk_3mUKrKR-uj9SS9Fg-mKEijB02qWAAGSxY36vOgEy53ITdtNo
Message-ID: <CAFn=p-aKeFKh9tmKmzXaFW_0_FppH0z-z8wrNMuTd8J1m0yywg@mail.gmail.com>
Subject: Re: [PATCH] qga/qapi-schema: Deemphasize numeric @whence in
 guest-file-seek
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, michael.roth@amd.com, 
 kkostiuk@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 23, 2026 at 3:03=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> guest-file-seek accepts both symbolic and numeric @whence values, but
> the former is documented as "preferred interface".  Remove or replace
> mentions of numeric values by symbolic ones.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Sure. The equivalences are still documented in `GuestFileWhence`, so
this seems fine. If the symbolic names are preferred, it seems fine
that looking up the symbol doesn't give you a crappier, non-preferred
way to specify it. By contrast, if you look up the numbers, it should
tell you what the equivalent preferred enum is.

(make "upgrading" easy, make "downgrading" hard.)

yadda yadda

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  qga/qapi-schema.json | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 040c932310..576ce7fea8 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -342,11 +342,11 @@
>  #
>  # Symbolic names for use in `guest-file-seek`
>  #
> -# @set: Set to the specified offset (same effect as 'whence':0)
> +# @set: Set to the specified offset
>  #
> -# @cur: Add offset to the current location (same effect as 'whence':1)
> +# @cur: Add offset to the current location
>  #
> -# @end: Add offset to the end of the file (same effect as 'whence':2)
> +# @end: Add offset to the end of the file
>  #
>  # Since: 2.6
>  ##
> @@ -373,7 +373,7 @@
>  #
>  # Seek to a position in the file, as with fseek(), and return the
>  # current file position afterward.  Also encapsulates ftell()'s
> -# functionality, with offset=3D0 and whence=3D1.
> +# functionality, with offset=3D0 and whence=3D"cur".
>  #
>  # @handle: filehandle returned by `guest-file-open`
>  #
> --
> 2.55.0
>


