Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1B3C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QfA-0001r1-Gb; Wed, 23 Sep 2026 13:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9Qee-0001WH-Er
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9Qed-0002jS-0R
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUqqg0um0tkss2P3GYV2rM610LleloCvyAyUQ+ZeFIs=;
 b=WXS72JW4Y1VXK5KdGgq9etV7WbuCPsqFIbXm7DcTNXY+7MAjKKsu9YSVTNBwi13CIVQ2Ti
 Ruc+5ASDaKm93+4jlvn0MarAGRIOjcuVB7TbiDSmYuR7hUhSPhWphAdhXUMtJOJLgXywN6
 LnYx9uvmXAcK7ZXIi7TycBWhyeh0GgU=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-OFTnAmWhNx-8xFcnNhaoGQ-1; Wed, 23 Sep 2026 13:21:07 -0400
X-MC-Unique: OFTnAmWhNx-8xFcnNhaoGQ-1
X-Mimecast-MFC-AGG-ID: OFTnAmWhNx-8xFcnNhaoGQ_1790184067
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-671203c3d56so41954d50.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790184067; cv=none;
 d=google.com; s=arc-20260327;
 b=Q/qRwqf42lSgZKh/aU1OBWvHbHseBtBgHNnbiLzCDcOflsrX6PorRdkQy+s8Dygatf
 BdmMb0y8LLXjsyB5a99Rs7rUH/6HcWkkMkiIeu20psL6lF0fjcAevoOg25oi8Hdx3GQt
 fc3X+Q6pVdmhRR7A5UrpkY4OSZGXt3giZKP3+6+yJu8GZDEDFvCPSPKJP1OOBO/2wFNO
 MIQDCfGlv22O0iZmdMPvt8A/tMsG2y4qG4ePDY3Xg+3XFsPsl7+MfqptGtbtgu0ChFiU
 cqNs+9dsI66gJKmHcM21KRyLb6f5vGoK5rLq+QrkPxKFU0JIVC8HMMwMZnJq8WXUZTQ+
 Hf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QUqqg0um0tkss2P3GYV2rM610LleloCvyAyUQ+ZeFIs=;
 fh=efRD72j90xG4W9da5AhqhuaTclpdW0BT0ucrSh4Idro=;
 b=Os8Eeg+a4lgJnfdCx1KCwdC7MpaF2P+lL2Tv1YVu275pYZSwr1zNb0d1PZji+oXNOc
 TRR62f0ThzwuLf/+zO5oFd/2vwZVlxK9vHNmw7KEUqK1S1xIY462vFWVSkcURlvT/CAv
 KMI44cGX1ciI5v3EkcP0zQWjkPp3Poxy8diJ+kZphik9G76GjBPHn6JtXSF+ltAUSu3I
 XmyQb/H4m7etujp/4i60vL6/036woW6ZcLzObqqRJ588tdVjAtew3oGXYj3kT7iq/RnU
 Yf5XAlCHiLqvrClEeKnTfY5j5zI9nT9lHDrFV9VCj3FtRNim1ceJZMZL3MPWvY0YGKzq
 PBZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184067; x=1790788867; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QUqqg0um0tkss2P3GYV2rM610LleloCvyAyUQ+ZeFIs=;
 b=JH3WJ9DYjkPK4qOsQMcwh+W/g3+w9T5PfECN5D2GZyuzWEWnPsLH6VtlMLjLoZNCPP
 mJx0NFaLSNSZkmZ1w3F5BDebf/CRQ+FTCNJvWdBHCzG38sDwtX5RbWKJpjx8W8y82pNm
 Ib80hwRt2Veof59lYwfI7JxC57k354QDex1loDPsgtoL+cMkxePUj3+SlpOxJyFBnV+5
 SOsVEotChBXr4bUxtpeTNaIpzLPyzXiteenLCGTqCdhZ39QUNE9Mpwc/WiUtbV7lBct4
 4QZxCeU6GZRPNx+hMw0yZRiYNkhg//fl8AFDJN8qrhkDxYJOKx2x4O0RCIvN1NxF2x2N
 ovHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184067; x=1790788867;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QUqqg0um0tkss2P3GYV2rM610LleloCvyAyUQ+ZeFIs=;
 b=Y8IB3auE6Md5ZcYmKip98Ix5YW164Id6QNTVHNERVBFtCG2OIIsYbi0/ufnqzPQKC/
 q//xeUWWUNIglj2e/AlVKqZQ2t5mpFQCw6hI/uKVIgAELULcYf/0n0QJ4bsuK0JvoHcF
 w0Veh7gaDebq0LkrVWS5cMkFlcsksv4VIZJo7AT5cuseb8/SZdkoR1LOMZ8Vp1xY4NxJ
 4759O1Xqo2i62vEYlzbt4DPHZ3wSUh9QwsPx4ajvuj5N4JE5bs/xCEhQ9N5/ix8obub4
 LZNEUPyCkOuowv0KSVk80wdlb+JIA8GkX6HyK8bD3CA3ZYbl7T6WkNTzl9xCutcWBeHb
 1POw==
X-Gm-Message-State: AFuF++mzRcBjDdSaUSFvODY9Slxf7zpjW6ssKFEWMpo72QHQPB9wN6kB
 O3y32BJMPDs4tfxu/spuN8uUm56tZWBrRk+8ikhE2DGl3Sl5bqBDBG5VStswS5uJueXhX1ZjjVe
 6xEII2WWA+qjDgJwqPjhPSLeYURJxgSPsLNyJadNi1gKjm5Rkv71iH1YlwbfMDoQHVrm+//+NYd
 uoQnSTDbTSGalPh12+Vs30GFEz/RRbhOrdIY8RN80=
X-Gm-Gg: AYBFou31nsw++GbKVtCha9whjJDFe4GjBfBMca8XUTfUL6n7wa5kyrxWw+/EamP/5HQ
 K4SXXIdUbOxU0dchqn3tLV2Y+QWKY7OwOKNLKTMBk4N4tokgQjts44w+BB03XtQzL603kcLebTD
 XHbyK1gNLqOKa+lTWDYXxmrryTWUQIQlfz/kvCnJsJ4D+OKMyWCW4Y6fjh4fkeuJDBHzctbMOFP
 RUlhuJUeXn14EJM
X-Received: by 2002:a05:690e:43ce:b0:672:b59a:3784 with SMTP id
 956f58d0204a3-672d599005fmr894623d50.28.1790184067235; 
 Wed, 23 Sep 2026 10:21:07 -0700 (PDT)
X-Received: by 2002:a05:690e:43ce:b0:672:b59a:3784 with SMTP id
 956f58d0204a3-672d599005fmr894614d50.28.1790184066846; Wed, 23 Sep 2026
 10:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260923064212.839691-1-armbru@redhat.com>
In-Reply-To: <20260923064212.839691-1-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 23 Sep 2026 13:20:55 -0400
X-Gm-Features: AcwNN1VhZRjB0Gt1FfvcfAaQylS59eR27Sy6zCUqZs8LfQFMjK6ewyjLFLlaLmw
Message-ID: <CAFn=p-ZU7ZE9KR6WL27MPG1D8TGFCOxsgZmaFy5qJqJLZy_dJQ@mail.gmail.com>
Subject: Re: [PATCH] qga/qapi-schema: Drop "This is a read-only operation"
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

On Wed, Sep 23, 2026 at 2:42=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Documentation of guest-get-vcpus and guest-get-memory-blocks has "This
> is a read-only operation".  Similar commands don't.  A "get" command
> that actually writes would be in surprisingly bad taste.  Delete both
> instances of the sentence.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/qapi-schema.json | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 8cd0ba048b..040c932310 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -769,8 +769,6 @@
>  #
>  # Retrieve the list of the guest's logical processors.
>  #
> -# This is a read-only operation.
> -#
>  # Returns: The list of all VCPUs the guest knows about.  Each VCPU is
>  #     put on the list exactly once, but their order is unspecified.
>  #
> @@ -1133,8 +1131,6 @@
>  #
>  # Retrieve the list of the guest's memory blocks.
>  #
> -# This is a read-only operation.
> -#
>  # Returns: The list of all memory blocks the guest knows about.  Each
>  #     memory block is put on the list exactly once, but their order is
>  #     unspecified.
> --
> 2.55.0
>

Sure, why not?

Reviewed-by: John Snow <jsnow@redhat.com>


