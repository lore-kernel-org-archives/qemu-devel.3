Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FEBC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOK8I-000818-Hz; Mon, 01 Jul 2024 12:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOK8H-00080d-GL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOK8E-00054E-Nj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719852237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jSOc6PQBpFbAYlwylphH9Vs1PNer/u93oLMOfaIelU=;
 b=Cfqk6cX6UIH6iIOPdYTtBevAppFx3zd6HRrGhL5GzzrE9XZ07dh1I4F9GygjhiCEGBoaEO
 QZ9pAKbnu7YDSV/NT/ErBxd8FPrRwIMiowOTckg7T+9M/U4e0BqQD9+nUFKs/YabkH2WT4
 /rRUcym+d3e+vqNSnbmnhI/f/k0YtVI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364--EvAQW13PhqF8tbJ20RcKQ-1; Mon, 01 Jul 2024 12:43:55 -0400
X-MC-Unique: -EvAQW13PhqF8tbJ20RcKQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36743ab5fb3so2136655f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719852233; x=1720457033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3jSOc6PQBpFbAYlwylphH9Vs1PNer/u93oLMOfaIelU=;
 b=ixPRTbOD69GHxOAgbNdp44+NXluZLIQXBOHZzS2rwLY/gveLH2hLv3LNyfTlydp+dQ
 zwLONm8tZpHBMdo8FrXZZBivh1cX7TJ2bWdtfzhYhxYWcx0yaTnMdpJygQA7799RdJi0
 TE7ODBSaWXYDg3FCyPQm9nzsco0VE2+Jl1DWCwnZnw4k7uoQrTb5VD4gNKHsx4qJaiTc
 LopjgrfboxUpliI7tGtiwTGjxggI6qneSOtrW5LUFxDLu5DPc4j46oHaI9mCWrYr+NWT
 /DwyR/DZ6/Jo3/PhUTx4s9aYbDuspwbMJuA6Db8B03Tn+lWoFH3fjiiMw+I+L41EPnHX
 P2MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf/YaNc1PDwrR1qz/Zx8bL5My+jlMo9XUIDQNaWwzl3Q8HHoV4Q8pJlPyMLVwkRR5Uszmm5f9lf1VcXDoQ5Uos7VLONAk=
X-Gm-Message-State: AOJu0YwJBahOe3y5+2IRY5WoAc4Z2LZD0+XRGBd8JhbNRhMiD2uiXfOY
 BCqqfGSqbyratv/AfW3xy1mmGDWXktDQtLB+vGie7JqkDs9Dy0Tv6MBT5nJrkb8aHJFjp1fHCy1
 9BoeIlnx/AncQ0gSYe4S1r1yx4J+acYeige3FNO6uOYJMEXkaB0nLk+97x+Jn0Gcz65mdXKvo0V
 P8ka2KGCzV9+iw/UQFnASpm2QjbQE=
X-Received: by 2002:a05:6000:18a1:b0:366:e9f5:781b with SMTP id
 ffacd0b85a97d-36774f6cf3fmr5737508f8f.21.1719852232999; 
 Mon, 01 Jul 2024 09:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc9OKrBHzF23y4yRH9eLsv+7iyjJw4J8O7AevKgtEznZuoqZV8QBm99/hXhDkszWu5vw61H3qDUErAXv+lk54=
X-Received: by 2002:a05:6000:18a1:b0:366:e9f5:781b with SMTP id
 ffacd0b85a97d-36774f6cf3fmr5737493f8f.21.1719852232674; Mon, 01 Jul 2024
 09:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
 <20240701133038.1489043-3-dbarboza@ventanamicro.com>
 <5e0c57ef-d06d-4cdc-8d5b-3adec8263c5f@linaro.org>
In-Reply-To: <5e0c57ef-d06d-4cdc-8d5b-3adec8263c5f@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2024 18:43:40 +0200
Message-ID: <CABgObfZzVN+CuCpYOpLqYERht_ipk4Xv_oydWi59WytyQtddsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] system/vl.c: parse all -accel options
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 ajones@ventanamicro.com, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 1, 2024 at 4:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

In principle, a Reviewed-by tag is just stating that you don't know of
any issues that would prevent the patch being included. However, as a
frequent participant to the project, your Reviewed-by tag carries some
weight and, to some extent, it is also a statement that you understand
the area being modified.  A Reviewed-by from an experienced
contributor may even imply that you could take the patch in one of
your pull requests. (*) That makes it even more important to
understand the area.

I would expect that anyone with an understanding of command line
parsing would know 1) what -accel kvm -accel tcg does, and 2) what
.merge_lists does; and this would be enough to flag an issue
preventing the patch from being included.

To be clear, I don't expect reviews to be perfect. But in this case
I'm speaking up because the patch is literally a one line declarative
change, and the only way to say "I've reviewed it" is by understanding
the deeper effects of that line.

Also, I think it's fair that the submitter didn't spot the problem;
it's okay to send out broken patches, that's part of the learning
experience. :)

Paolo

(*) as opposed to Acked-by, where your review probably has been more
conceptual than technical, and that you don't really want to take the
patch in a pull request.


Paolo


