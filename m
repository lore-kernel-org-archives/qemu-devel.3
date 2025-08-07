Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8BBC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 21:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk8Ag-0005i6-Al; Thu, 07 Aug 2025 17:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uk8Ae-0005gm-T0
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 17:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uk8Ad-0004mm-4S
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 17:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754602146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/ZT2RJBUospmARJZdTAsWNFtfyPV0n1/WfdjOu7uzo=;
 b=gvrHIlb/TVsXNcgBXxmp2F7td3Xs1Nl5DX673Tshel872x20LhzTuqmfYh/oKAq4R9o04+
 4tlebIjW3Xt36ZnaTC2hk4uIrnhKbKWzpMCpNzBbBpy+KS/DDVw8+igF4wIGZ9r2NXZTQN
 uC0H6d7dnMSSKUOpoDBuqbdhxWNaMPQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-1zM0huBXPg-9jBdz0Rfc7A-1; Thu, 07 Aug 2025 17:29:05 -0400
X-MC-Unique: 1zM0huBXPg-9jBdz0Rfc7A-1
X-Mimecast-MFC-AGG-ID: 1zM0huBXPg-9jBdz0Rfc7A_1754602144
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3132c1942a1so2940376a91.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 14:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754602144; x=1755206944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/ZT2RJBUospmARJZdTAsWNFtfyPV0n1/WfdjOu7uzo=;
 b=Gp0HaLyZdPQSNC5YtZPyBnLvFr9+osakfahjtyb5bDQJ4Xhb2LF+hW8335dxv2/uKt
 kDaEd91/RAIZoQnaVC2aJU6kZcIZjms3GKC4zAmsGnNpEXZy5MS/AU4te4JkALohnxIE
 aOE9D2p/5JaRHnDRHjIipLUszf/mCfajHFQj/2qc2kW+U8Mcr0qQAhf7nwu3rLBGzzmQ
 xKgL3wl6rHTwuC2dd0bubxlQoxPL4KRtk0USaypomqo3sU2MbboFFIchsmOJjx3evieO
 Hl2eS8E7MgoGwTSIGGgPTWydJwunkKxtSbN4j6r8DkbP07iuXQL9d4ZD20ls/MT5tCmZ
 PslA==
X-Gm-Message-State: AOJu0YzlHHUe2S134cQcOkElC+bXk4YPQOPAQnzYxDZCNTeZ+vYcbJWx
 2fT43x2Ar/lF3ZOSfeKXw5oMaXavq5q3kqTLWrH32nBYJBhF4jLG8ENZnnCextvTco7f0uFi0b3
 LD+PHtreEzRR3tuCQKkHtZJrOawwXGzrhBpldEyQSQt/T5GIWoZ8S6KjIQ/EKUoFJEItpsmXqOk
 IOFhKv37S1y4mBmv2lk8tCg97ov4ETN1w=
X-Gm-Gg: ASbGncv67PEkELbu+XxWUDXHWPG94iUbqG3Bt+EEHCpiDcdtascvloJcKBMSwvEJMqU
 GJk7vmE03m/f+cjV1elduP7LN4STXMm/ySCUv1pPhnOPRwNJ/xh7IhDN1mQ7bmUlQiD7NzmftQI
 iqhDM2rCr/3fiertEOEPUhJnjc7yWTglzXHmUcRAua/5HlKAboYAy+
X-Received: by 2002:a17:90b:224e:b0:321:2b8a:4304 with SMTP id
 98e67ed59e1d1-321839ec183mr776386a91.10.1754602144052; 
 Thu, 07 Aug 2025 14:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm7uRpd86SCpPWJvs9KmprPpcRgyBefgvgZez4zplo8IyMITfL+eoMhzPJ/u+AhUsyq2l1ERfrzZYizMUE3lc=
X-Received: by 2002:a17:90b:224e:b0:321:2b8a:4304 with SMTP id
 98e67ed59e1d1-321839ec183mr776358a91.10.1754602143700; Thu, 07 Aug 2025
 14:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250731054044.4011789-1-armbru@redhat.com>
 <20250731054044.4011789-3-armbru@redhat.com>
In-Reply-To: <20250731054044.4011789-3-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 7 Aug 2025 17:28:50 -0400
X-Gm-Features: Ac12FXwM-lb18sZTeA4-_Ny2eA24ZnX_3r5QTeFZUCna3QdQS-zReIV_WAYRlS4
Message-ID: <CAFn=p-azn=JTDZGiyjMTxHSDB5KpmnHfAoWokACKBgcvy2JAFA@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs/devel/qapi-code-gen: Fix typos in QAPI schema
 language grammar
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, peter.maydell@linaro.org, 
 eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

On Thu, Jul 31, 2025 at 1:40=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Fixes: 3248c1aaf2db (docs: update the documentation upfront about schema =
configuration)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  docs/devel/qapi-code-gen.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
> index 138921b386..2cd51729c3 100644
> --- a/docs/devel/qapi-code-gen.rst
> +++ b/docs/devel/qapi-code-gen.rst
> @@ -786,8 +786,8 @@ Configuring the schema
>  Syntax::
>
>      COND =3D STRING
> -         | { 'all: [ COND, ... ] }
> -         | { 'any: [ COND, ... ] }
> +         | { 'all': [ COND, ... ] }
> +         | { 'any': [ COND, ... ] }

Oopsie.

>           | { 'not': COND }
>
>  All definitions take an optional 'if' member.  Its value must be a
> --
> 2.49.0
>


